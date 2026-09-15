"""
Export EID3320 VS Input data from RenderDoc capture (endfield06) to FBX format
Preserves all vertex attributes for Unity import
"""

import renderdoc as rd
import struct
import numpy as np
from pathlib import Path

def connect_to_renderdoc():
    """Connect to RenderDoc API"""
    cap = rd.OpenCaptureFile()
    return cap

def find_eid3320_drawcall(controller):
    """
    Find the draw call for EID3320 in the endfield06 capture
    """
    # Get the root actions
    actions = controller.GetRootActions()

    target_drawcalls = []

    def search_actions(action_list):
        for action in action_list:
            # Look for EID3320 marker or specific draw call
            if action.customName and 'eid3320' in action.customName.lower():
                target_drawcalls.append(action)
            elif action.customName and 'EID3320' in action.customName:
                target_drawcalls.append(action)

            # Recursively search children
            if action.children:
                search_actions(action.children)

    search_actions(actions)
    return target_drawcalls

def extract_vertex_data(controller, action):
    """
    Extract all vertex attributes from VS Input
    """
    # Set current event to the target draw call
    controller.SetFrameEvent(action.eventId, False)

    # Get the current state
    state = controller.GetPipelineState()

    # Get vertex input attributes
    vertex_inputs = state.GetVertexInputs()

    vertex_data = {}

    for attr in vertex_inputs:
        # Get mesh data for this draw call
        mesh_data = controller.GetMeshData(action.eventId, 0, rd.MeshDataStage.VSIn)

        # Extract vertex buffer data
        indices = mesh_data.indexResourceId
        num_vertices = mesh_data.numIndices if mesh_data.indexResourceId != rd.ResourceId.Null() else mesh_data.numVertices

        # Read vertex buffer
        vb_data = []
        for i in range(num_vertices):
            vertex = mesh_data.GetVertex(i)
            vb_data.append(vertex)

        vertex_data[attr.name] = {
            'data': vb_data,
            'format': attr.format,
            'semantic': attr.name,
            'offset': attr.byteOffset
        }

    return vertex_data, mesh_data

def export_to_fbx(vertex_data, mesh_data, output_path):
    """
    Export vertex data to FBX format with all attributes preserved
    Uses FBX SDK to create proper FBX file
    """
    try:
        import fbx
        import FbxCommon
    except ImportError:
        print("FBX SDK not available, falling back to OBJ with custom attributes")
        export_to_obj_with_attributes(vertex_data, mesh_data, output_path)
        return

    # Create FBX Manager
    manager = fbx.FbxManager.Create()
    scene = fbx.FbxScene.Create(manager, "EID3320_Scene")

    # Create mesh node
    mesh_node = fbx.FbxNode.Create(scene, "EID3320_Mesh")
    mesh = fbx.FbxMesh.Create(scene, "EID3320")

    # Extract positions
    positions = vertex_data.get('POSITION', {}).get('data', [])
    num_vertices = len(positions)

    # Initialize control points (positions)
    mesh.InitControlPoints(num_vertices)
    control_points = mesh.GetControlPoints()

    for i, pos in enumerate(positions):
        control_points[i] = fbx.FbxVector4(pos[0], pos[1], pos[2])

    # Add normals
    if 'NORMAL' in vertex_data:
        normals_layer = mesh.CreateElementNormal()
        normals_layer.SetMappingMode(fbx.FbxLayerElement.eByControlPoint)
        normals_layer.SetReferenceMode(fbx.FbxLayerElement.eDirect)

        normals = vertex_data['NORMAL']['data']
        for normal in normals:
            normals_layer.GetDirectArray().Add(fbx.FbxVector4(normal[0], normal[1], normal[2]))

    # Add UVs
    uv_channels = ['TEXCOORD0', 'TEXCOORD1', 'TEXCOORD2', 'TEXCOORD3']
    for uv_channel in uv_channels:
        if uv_channel in vertex_data:
            uv_layer = mesh.CreateElementUV(uv_channel)
            uv_layer.SetMappingMode(fbx.FbxLayerElement.eByControlPoint)
            uv_layer.SetReferenceMode(fbx.FbxLayerElement.eDirect)

            uvs = vertex_data[uv_channel]['data']
            for uv in uvs:
                uv_layer.GetDirectArray().Add(fbx.FbxVector2(uv[0], uv[1]))

    # Add tangents
    if 'TANGENT' in vertex_data:
        tangent_layer = mesh.CreateElementTangent()
        tangent_layer.SetMappingMode(fbx.FbxLayerElement.eByControlPoint)
        tangent_layer.SetReferenceMode(fbx.FbxLayerElement.eDirect)

        tangents = vertex_data['TANGENT']['data']
        for tangent in tangents:
            tangent_layer.GetDirectArray().Add(fbx.FbxVector4(tangent[0], tangent[1], tangent[2], tangent[3] if len(tangent) > 3 else 1.0))

    # Add vertex colors
    if 'COLOR' in vertex_data or 'COLOR0' in vertex_data:
        color_key = 'COLOR' if 'COLOR' in vertex_data else 'COLOR0'
        color_layer = mesh.CreateElementVertexColor()
        color_layer.SetMappingMode(fbx.FbxLayerElement.eByControlPoint)
        color_layer.SetReferenceMode(fbx.FbxLayerElement.eDirect)

        colors = vertex_data[color_key]['data']
        for color in colors:
            color_layer.GetDirectArray().Add(fbx.FbxColor(color[0], color[1], color[2], color[3] if len(color) > 3 else 1.0))

    # Set indices
    if mesh_data.indexResourceId != rd.ResourceId.Null():
        indices = []
        for i in range(mesh_data.numIndices):
            indices.append(mesh_data.GetIndex(i))

        # Create polygons
        for i in range(0, len(indices), 3):
            mesh.BeginPolygon()
            mesh.AddPolygon(indices[i])
            mesh.AddPolygon(indices[i+1])
            mesh.AddPolygon(indices[i+2])
            mesh.EndPolygon()

    # Attach mesh to node
    mesh_node.SetNodeAttribute(mesh)
    scene.GetRootNode().AddChild(mesh_node)

    # Export FBX
    exporter = fbx.FbxExporter.Create(scene, "")
    exporter.Initialize(str(output_path), -1, manager.GetIOSettings())
    exporter.Export(scene)
    exporter.Destroy()

    manager.Destroy()
    print(f"✓ Exported FBX to: {output_path}")

def export_to_obj_with_attributes(vertex_data, mesh_data, base_path):
    """
    Fallback: Export to OBJ with additional attribute files
    """
    base_path = Path(base_path).with_suffix('')
    obj_path = base_path.with_suffix('.obj')

    # Extract vertex attributes
    positions = vertex_data.get('POSITION', {}).get('data', [])
    normals = vertex_data.get('NORMAL', {}).get('data', [])
    uvs = vertex_data.get('TEXCOORD0', {}).get('data', [])

    # Write OBJ file
    with open(obj_path, 'w') as f:
        f.write(f"# EID3320 Model exported from RenderDoc\n")
        f.write(f"# Vertices: {len(positions)}\n\n")

        # Write positions
        for pos in positions:
            f.write(f"v {pos[0]} {pos[1]} {pos[2]}\n")

        # Write UVs
        if uvs:
            for uv in uvs:
                f.write(f"vt {uv[0]} {uv[1]}\n")

        # Write normals
        if normals:
            for normal in normals:
                f.write(f"vn {normal[0]} {normal[1]} {normal[2]}\n")

        # Write faces
        if mesh_data.indexResourceId != rd.ResourceId.Null():
            f.write("\n# Faces\n")
            for i in range(0, mesh_data.numIndices, 3):
                idx0 = mesh_data.GetIndex(i) + 1
                idx1 = mesh_data.GetIndex(i+1) + 1
                idx2 = mesh_data.GetIndex(i+2) + 1

                if uvs and normals:
                    f.write(f"f {idx0}/{idx0}/{idx0} {idx1}/{idx1}/{idx1} {idx2}/{idx2}/{idx2}\n")
                elif normals:
                    f.write(f"f {idx0}//{idx0} {idx1}//{idx1} {idx2}//{idx2}\n")
                else:
                    f.write(f"f {idx0} {idx1} {idx2}\n")

    # Export additional attributes to CSV
    csv_path = base_path.with_suffix('.csv')
    with open(csv_path, 'w') as f:
        # Header
        headers = ['VertexIndex']
        for attr_name in vertex_data.keys():
            if attr_name not in ['POSITION', 'NORMAL', 'TEXCOORD0']:
                headers.append(attr_name)
        f.write(','.join(headers) + '\n')

        # Data
        num_verts = len(positions)
        for i in range(num_verts):
            row = [str(i)]
            for attr_name in vertex_data.keys():
                if attr_name not in ['POSITION', 'NORMAL', 'TEXCOORD0']:
                    data = vertex_data[attr_name]['data'][i]
                    if isinstance(data, (list, tuple)):
                        row.append('|'.join(map(str, data)))
                    else:
                        row.append(str(data))
            f.write(','.join(row) + '\n')

    print(f"✓ Exported OBJ to: {obj_path}")
    print(f"✓ Exported additional attributes to: {csv_path}")

def main():
    """
    Main execution: Export EID3320 from RenderDoc endfield06 capture
    """
    # RenderDoc capture file path
    capture_path = input("Enter RenderDoc capture path (endfield06.rdc): ").strip()
    if not capture_path:
        capture_path = "endfield06.rdc"

    if not Path(capture_path).exists():
        print(f"✗ Capture file not found: {capture_path}")
        print("\nPlease ensure:")
        print("1. RenderDoc capture file exists")
        print("2. The capture contains EID3320 draw calls")
        return

    # Output path
    output_dir = Path("D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/EID3336_URP_Reconstruction/Models")
    output_dir.mkdir(parents=True, exist_ok=True)
    output_path = output_dir / "EID3320_VSInput.fbx"

    print(f"Loading RenderDoc capture: {capture_path}")

    # Open capture
    cap = rd.OpenCaptureFile()
    status = cap.OpenFile(capture_path, '', None)

    if status != rd.ReplayStatus.Succeeded:
        print(f"✗ Failed to open capture: {status}")
        return

    # Create replay controller
    status, controller = cap.OpenCapture(None)
    if status != rd.ReplayStatus.Succeeded:
        print(f"✗ Failed to create controller: {status}")
        return

    print("✓ Capture opened successfully")

    # Find EID3320 draw calls
    print("Searching for EID3320 draw calls...")
    drawcalls = find_eid3320_drawcall(controller)

    if not drawcalls:
        print("✗ No EID3320 draw calls found")
        print("Available actions will be listed...")
        actions = controller.GetRootActions()
        for action in actions[:20]:
            print(f"  - {action.customName or 'Unnamed'} (Event ID: {action.eventId})")
        return

    print(f"✓ Found {len(drawcalls)} EID3320 draw call(s)")

    # Export first matching draw call
    target_action = drawcalls[0]
    print(f"Extracting vertex data from: {target_action.customName} (Event ID: {target_action.eventId})")

    vertex_data, mesh_data = extract_vertex_data(controller, target_action)

    print(f"\nVertex attributes found:")
    for attr_name, attr_info in vertex_data.items():
        print(f"  - {attr_name}: {len(attr_info['data'])} vertices, format: {attr_info['format']}")

    print(f"\nExporting to FBX: {output_path}")
    export_to_fbx(vertex_data, mesh_data, output_path)

    # Cleanup
    controller.Shutdown()
    cap.Shutdown()

    print(f"\n✓ Export complete!")
    print(f"Import the FBX into Unity at: Assets/EID3336_URP_Reconstruction/Models/EID3320_VSInput.fbx")

if __name__ == "__main__":
    main()
