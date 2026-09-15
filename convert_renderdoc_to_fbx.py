"""
Convert RenderDoc exported vertex data (CSV format) to FBX for Unity import
Preserves all vertex attributes including POSITION, NORMAL, TEXCOORD, TANGENT, COLOR, etc.

Usage:
1. In RenderDoc, right-click on EID3320 draw call
2. Export to CSV: "Export Mesh Data" -> Save as CSV
3. Run this script to convert to FBX
"""

import csv
import struct
import numpy as np
from pathlib import Path

def parse_renderdoc_csv(csv_path):
    """
    Parse RenderDoc CSV export containing vertex data
    Expected format: VTX, IDX, POSITION.x, POSITION.y, POSITION.z, NORMAL.x, NORMAL.y, NORMAL.z, TEXCOORD.x, TEXCOORD.y, etc.
    """
    print(f"Reading RenderDoc CSV: {csv_path}")

    vertices = []
    indices = []
    attributes = {}

    with open(csv_path, 'r') as f:
        reader = csv.DictReader(f)
        headers = reader.fieldnames

        print(f"Found columns: {headers}")

        # Determine attribute structure from headers
        attr_names = set()
        for header in headers:
            if '.' in header:
                attr_name = header.split('.')[0]
                attr_names.add(attr_name)

        print(f"Detected attributes: {attr_names}")

        # Initialize attribute storage
        for attr in attr_names:
            attributes[attr] = []

        # Parse vertex data
        for row in reader:
            # Get vertex index
            vtx_idx = int(row.get('VTX', 0))
            idx = row.get('IDX', '')
            if idx:
                indices.append(int(idx))

            # Parse each attribute
            for attr in attr_names:
                components = []
                i = 0
                while True:
                    col_name = f"{attr}.{chr(ord('x') + i)}"
                    if col_name in row:
                        components.append(float(row[col_name]))
                        i += 1
                    else:
                        break

                if components:
                    attributes[attr].append(components)

    print(f"Parsed {len(attributes.get('POSITION', []))} vertices")
    print(f"Parsed {len(indices)} indices")

    return attributes, indices

def create_fbx_with_bpy(attributes, indices, output_path):
    """
    Create FBX using Blender's bpy module
    This is the most reliable way to create FBX files
    """
    try:
        import bpy
    except ImportError:
        print("✗ Blender Python API not available")
        print("Please install Blender or use the standalone script")
        return False

    # Clear existing mesh
    bpy.ops.wm.read_factory_settings(use_empty=True)

    # Create mesh
    mesh = bpy.data.meshes.new("EID3320_Mesh")
    obj = bpy.data.objects.new("EID3320", mesh)
    bpy.context.collection.objects.link(obj)

    # Get positions
    positions = attributes.get('POSITION', [])
    num_verts = len(positions)

    # Create vertices
    mesh.vertices.add(num_verts)
    for i, pos in enumerate(positions):
        mesh.vertices[i].co = pos[:3]

    # Create faces from indices
    if indices:
        num_faces = len(indices) // 3
        mesh.loops.add(len(indices))
        mesh.polygons.add(num_faces)

        for i in range(num_faces):
            loop_start = i * 3
            mesh.polygons[i].loop_start = loop_start
            mesh.polygons[i].loop_total = 3
            mesh.polygons[i].vertices = [indices[loop_start], indices[loop_start + 1], indices[loop_start + 2]]

            for j in range(3):
                mesh.loops[loop_start + j].vertex_index = indices[loop_start + j]

    mesh.update()

    # Add normals
    if 'NORMAL' in attributes:
        normals = attributes['NORMAL']
        mesh.normals_split_custom_set_from_vertices([n[:3] for n in normals])
        mesh.use_auto_smooth = True

    # Add UVs
    for uv_idx in range(8):
        uv_name = f"TEXCOORD{uv_idx}" if uv_idx > 0 else "TEXCOORD"
        if uv_name in attributes or f"TEXCOORD{uv_idx}" in attributes:
            uv_data = attributes.get(uv_name, attributes.get(f"TEXCOORD{uv_idx}", []))

            uv_layer = mesh.uv_layers.new(name=f"UVMap{uv_idx}")
            for i, loop in enumerate(mesh.loops):
                if i < len(uv_data):
                    uv_layer.data[i].uv = uv_data[loop.vertex_index][:2]

    # Add vertex colors
    if 'COLOR' in attributes or 'COLOR0' in attributes:
        color_data = attributes.get('COLOR', attributes.get('COLOR0', []))
        color_layer = mesh.vertex_colors.new(name="Color")

        for i, loop in enumerate(mesh.loops):
            if loop.vertex_index < len(color_data):
                color = color_data[loop.vertex_index]
                color_layer.data[i].color = color[:4] if len(color) >= 4 else color[:3] + [1.0]

    # Export to FBX
    bpy.ops.export_scene.fbx(
        filepath=str(output_path),
        use_selection=False,
        apply_scale_options='FBX_SCALE_ALL',
        axis_forward='-Z',
        axis_up='Y'
    )

    print(f"✓ Exported FBX using Blender: {output_path}")
    return True

def create_fbx_manual(attributes, indices, output_path):
    """
    Create FBX manually using FBX SDK Python bindings
    """
    try:
        from fbx import *
    except ImportError:
        print("✗ FBX SDK not available, falling back to OBJ export")
        obj_path = output_path.with_suffix('.obj')
        create_obj_with_attributes(attributes, indices, obj_path)
        return False

    # Create FBX manager and scene
    manager = FbxManager.Create()
    scene = FbxScene.Create(manager, "EID3320_Scene")

    # Create mesh
    mesh = FbxMesh.Create(scene, "EID3320")

    # Set positions
    positions = attributes.get('POSITION', [])
    num_verts = len(positions)

    mesh.InitControlPoints(num_verts)
    for i, pos in enumerate(positions):
        mesh.SetControlPointAt(FbxVector4(pos[0], pos[1], pos[2], 1.0), i)

    # Add normals
    if 'NORMAL' in attributes:
        normal_element = mesh.CreateElementNormal()
        normal_element.SetMappingMode(FbxLayerElement.eByControlPoint)
        normal_element.SetReferenceMode(FbxLayerElement.eDirect)

        normals = attributes['NORMAL']
        for normal in normals:
            normal_element.GetDirectArray().Add(FbxVector4(normal[0], normal[1], normal[2], 0.0))

    # Add UVs
    for uv_idx in range(8):
        uv_name = f"TEXCOORD{uv_idx}" if uv_idx > 0 else "TEXCOORD"
        if uv_name in attributes or f"TEXCOORD{uv_idx}" in attributes:
            uv_data = attributes.get(uv_name, attributes.get(f"TEXCOORD{uv_idx}", []))

            uv_element = mesh.CreateElementUV(f"UV{uv_idx}")
            uv_element.SetMappingMode(FbxLayerElement.eByControlPoint)
            uv_element.SetReferenceMode(FbxLayerElement.eDirect)

            for uv in uv_data:
                uv_element.GetDirectArray().Add(FbxVector2(uv[0], uv[1]))

    # Add tangents
    if 'TANGENT' in attributes:
        tangent_element = mesh.CreateElementTangent()
        tangent_element.SetMappingMode(FbxLayerElement.eByControlPoint)
        tangent_element.SetReferenceMode(FbxLayerElement.eDirect)

        tangents = attributes['TANGENT']
        for tangent in tangents:
            tangent_element.GetDirectArray().Add(FbxVector4(tangent[0], tangent[1], tangent[2], tangent[3] if len(tangent) > 3 else 1.0))

    # Add vertex colors
    if 'COLOR' in attributes or 'COLOR0' in attributes:
        color_data = attributes.get('COLOR', attributes.get('COLOR0', []))
        color_element = mesh.CreateElementVertexColor()
        color_element.SetMappingMode(FbxLayerElement.eByControlPoint)
        color_element.SetReferenceMode(FbxLayerElement.eDirect)

        for color in color_data:
            color_element.GetDirectArray().Add(FbxColor(color[0], color[1], color[2], color[3] if len(color) > 3 else 1.0))

    # Add polygons
    if indices:
        for i in range(0, len(indices), 3):
            mesh.BeginPolygon()
            mesh.AddPolygon(indices[i])
            mesh.AddPolygon(indices[i+1])
            mesh.AddPolygon(indices[i+2])
            mesh.EndPolygon()

    # Create node and attach mesh
    node = FbxNode.Create(scene, "EID3320")
    node.SetNodeAttribute(mesh)
    scene.GetRootNode().AddChild(node)

    # Export
    ios = FbxIOSettings.Create(manager, "IOSRoot")
    manager.SetIOSettings(ios)

    exporter = FbxExporter.Create(scene, "")
    exporter.Initialize(str(output_path), -1, ios)
    exporter.Export(scene)
    exporter.Destroy()

    manager.Destroy()

    print(f"✓ Exported FBX: {output_path}")
    return True

def create_obj_with_attributes(attributes, indices, output_path):
    """
    Fallback: Export to OBJ with companion CSV for additional attributes
    """
    print(f"Exporting to OBJ format: {output_path}")

    positions = attributes.get('POSITION', [])
    normals = attributes.get('NORMAL', [])
    uvs = attributes.get('TEXCOORD', attributes.get('TEXCOORD0', []))

    # Write OBJ
    with open(output_path, 'w') as f:
        f.write("# EID3320 exported from RenderDoc\n")
        f.write(f"# Vertices: {len(positions)}\n\n")

        # Positions
        for pos in positions:
            f.write(f"v {pos[0]} {pos[1]} {pos[2]}\n")

        # Texture coordinates
        if uvs:
            f.write("\n")
            for uv in uvs:
                f.write(f"vt {uv[0]} {1.0 - uv[1]}\n")  # Flip V for Unity

        # Normals
        if normals:
            f.write("\n")
            for normal in normals:
                f.write(f"vn {normal[0]} {normal[1]} {normal[2]}\n")

        # Faces
        if indices:
            f.write("\n# Faces\n")
            for i in range(0, len(indices), 3):
                idx0, idx1, idx2 = indices[i] + 1, indices[i+1] + 1, indices[i+2] + 1

                if uvs and normals:
                    f.write(f"f {idx0}/{idx0}/{idx0} {idx1}/{idx1}/{idx1} {idx2}/{idx2}/{idx2}\n")
                elif normals:
                    f.write(f"f {idx0}//{idx0} {idx1}//{idx1} {idx2}//{idx2}\n")
                else:
                    f.write(f"f {idx0} {idx1} {idx2}\n")

    # Write additional attributes to CSV
    csv_path = output_path.with_suffix('.csv')
    with open(csv_path, 'w', newline='') as f:
        writer = csv.writer(f)

        # Header
        header = ['VertexIndex']
        extra_attrs = [k for k in attributes.keys() if k not in ['POSITION', 'NORMAL', 'TEXCOORD', 'TEXCOORD0']]
        for attr in extra_attrs:
            sample = attributes[attr][0] if attributes[attr] else []
            for i in range(len(sample)):
                header.append(f"{attr}.{chr(ord('x') + i)}")

        writer.writerow(header)

        # Data
        for i in range(len(positions)):
            row = [i]
            for attr in extra_attrs:
                if i < len(attributes[attr]):
                    row.extend(attributes[attr][i])
            writer.writerow(row)

    print(f"✓ Exported OBJ: {output_path}")
    print(f"✓ Additional attributes: {csv_path}")

    return True

def main():
    """Main execution"""
    print("=" * 70)
    print("RenderDoc to FBX Converter - EID3320 Export")
    print("=" * 70)
    print()

    # Get input CSV path
    csv_path = input("Enter RenderDoc CSV export path (or drag file here): ").strip().strip('"')

    if not csv_path or not Path(csv_path).exists():
        print(f"✗ File not found: {csv_path}")
        print("\nInstructions:")
        print("1. Open endfield06 capture in RenderDoc")
        print("2. Find EID3320 draw call")
        print("3. Right-click -> Export")
        print("4. Choose 'Mesh Output' and save as CSV")
        return

    # Parse CSV
    try:
        attributes, indices = parse_renderdoc_csv(csv_path)
    except Exception as e:
        print(f"✗ Failed to parse CSV: {e}")
        return

    # Output path
    output_dir = Path("D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/EID3336_URP_Reconstruction/Models")
    output_dir.mkdir(parents=True, exist_ok=True)
    output_path = output_dir / "EID3320_VSInput.fbx"

    print(f"\nOutput: {output_path}")
    print()

    # Try different export methods
    print("Attempting FBX export...")

    # Try Blender first (most reliable)
    if not create_fbx_with_bpy(attributes, indices, output_path):
        # Try FBX SDK
        if not create_fbx_manual(attributes, indices, output_path):
            # Fall back to OBJ
            obj_path = output_path.with_suffix('.obj')
            create_obj_with_attributes(attributes, indices, obj_path)

    print()
    print("=" * 70)
    print("✓ Export complete!")
    print("=" * 70)
    print(f"\nNext steps:")
    print(f"1. Open Unity project at: D:/endcopy/EID3336_URP_GBuffer_Workspace")
    print(f"2. The model is at: Assets/EID3336_URP_Reconstruction/Models/")
    print(f"3. Configure import settings to preserve all vertex attributes")

if __name__ == "__main__":
    main()
