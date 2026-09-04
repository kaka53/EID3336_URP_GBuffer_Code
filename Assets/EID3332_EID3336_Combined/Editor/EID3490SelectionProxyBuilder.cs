#if UNITY_EDITOR
using System;
using System.IO;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

/// <summary>
/// Builds the editor picking mesh from the same EID3490 raw vertex/index
/// streams used by the procedural reconstructed draw.  The ordinary Map01
/// mesh is not the draw mesh (it has a different vertex count), so it cannot
/// be used as a reliable SceneView selection proxy.
/// </summary>
public static class EID3490SelectionProxyBuilder
{
    const string Root = "Assets/EID3332_EID3336_Combined";
    const string RawRoot = Root + "/Resources/EID3490Raw";
    const string ProxyFolder = Root + "/Models/ProxyMeshes";
    const string RawSourcePath = ProxyFolder + "/EID3490_RawSelectionSource.asset";

    public static Renderer RebuildRenderer(GameObject go, int instanceIndex, Matrix4x4 captured, Transform parent, Material selectionMaterial)
    {
        if (go == null) throw new ArgumentNullException(nameof(go));
        if (parent == null) throw new ArgumentNullException(nameof(parent));
        EnsureProxyFolder();

        go.transform.SetParent(parent, false);
        SetWorldMatrix(go.transform, captured);

        MeshFilter filter = go.GetComponent<MeshFilter>();
        if (filter == null) filter = go.AddComponent<MeshFilter>();
        MeshRenderer renderer = go.GetComponent<MeshRenderer>();
        if (renderer == null) renderer = go.AddComponent<MeshRenderer>();
        Mesh rawSource = GetOrBuildRawSourceMesh();
        Mesh proxy = BuildInstanceProxy(rawSource, instanceIndex, go.transform, captured);

        if (filter == null)
            throw new InvalidOperationException("Unable to create MeshFilter for " + go.name + ".");
        filter.sharedMesh = proxy;
        renderer.sharedMaterial = selectionMaterial;
        renderer.enabled = true;
        renderer.shadowCastingMode = ShadowCastingMode.Off;
        renderer.receiveShadows = false;
        renderer.allowOcclusionWhenDynamic = false;
        go.hideFlags = HideFlags.None;
        renderer.hideFlags = HideFlags.None;
        return renderer;
    }

    static Mesh GetOrBuildRawSourceMesh()
    {
        Mesh existing = AssetDatabase.LoadAssetAtPath<Mesh>(RawSourcePath);
        byte[] vertexBytes = ReadBytes(RawRoot + "/vertex_stream0.bytes");
        byte[] indexBytes = ReadBytes(RawRoot + "/indices_u16.bytes");
        if (vertexBytes == null || indexBytes == null || vertexBytes.Length % 16 != 0 || indexBytes.Length % 2 != 0)
            throw new InvalidOperationException("EID3490 raw selection streams are missing or have invalid stride/size.");

        int vertexCount = vertexBytes.Length / 16;
        int indexCount = indexBytes.Length / 2;
        var vertices = new Vector3[vertexCount];
        for (int i = 0; i < vertexCount; ++i)
        {
            int offset = i * 16;
            vertices[i] = new Vector3(
                BitConverter.ToSingle(vertexBytes, offset + 0),
                BitConverter.ToSingle(vertexBytes, offset + 4),
                BitConverter.ToSingle(vertexBytes, offset + 8));
        }

        var indices = new int[indexCount];
        for (int i = 0; i < indexCount; ++i)
        {
            int value = indexBytes[i * 2] | (indexBytes[i * 2 + 1] << 8);
            if (value < 0 || value >= vertexCount)
                throw new InvalidOperationException("EID3490 raw selection index " + value + " exceeds vertex count " + vertexCount + ".");
            indices[i] = value;
        }

        Mesh mesh = existing != null ? UnityEngine.Object.Instantiate(existing) : new Mesh();
        mesh.name = "EID3490 Raw Selection Source (324v 474t)";
        mesh.Clear();
        mesh.indexFormat = IndexFormat.UInt16;
        mesh.vertices = vertices;
        mesh.SetIndices(indices, MeshTopology.Triangles, 0, true);
        mesh.RecalculateBounds();

        if (existing == null)
        {
            AssetDatabase.CreateAsset(mesh, RawSourcePath);
            EditorUtility.SetDirty(mesh);
            return mesh;
        }

        EditorUtility.CopySerialized(mesh, existing);
        existing.name = mesh.name;
        UnityEngine.Object.DestroyImmediate(mesh);
        EditorUtility.SetDirty(existing);
        return existing;
    }

    static Mesh BuildInstanceProxy(Mesh rawSource, int instanceIndex, Transform node, Matrix4x4 captured)
    {
        if (rawSource == null) throw new InvalidOperationException("EID3490 raw selection source mesh is unavailable.");
        string path = ProxyFolder + "/EID3490_instance_" + instanceIndex.ToString("000") + "_SelectionProxy.asset";
        Mesh existing = AssetDatabase.LoadAssetAtPath<Mesh>(path);
        Mesh proxy = new Mesh { name = "EID3490 Instance " + instanceIndex + " Selection Proxy" };
        proxy.indexFormat = rawSource.indexFormat;

        // The node carries the decomposed captured Transform so it remains
        // editable/selectable.  Rebase the raw vertices by the exact residual
        // matrix so SceneView picking stays on the procedural draw even when
        // the captured affine matrix contains a small shear/non-TRS component.
        Matrix4x4 localFromCaptured = node.worldToLocalMatrix * captured;
        Vector3[] sourceVertices = rawSource.vertices;
        var vertices = new Vector3[sourceVertices.Length];
        for (int i = 0; i < sourceVertices.Length; ++i)
            vertices[i] = localFromCaptured.MultiplyPoint3x4(sourceVertices[i]);
        proxy.vertices = vertices;
        proxy.SetIndices(rawSource.GetIndices(0), MeshTopology.Triangles, 0, true);
        proxy.RecalculateBounds();

        if (existing == null)
        {
            AssetDatabase.CreateAsset(proxy, path);
            EditorUtility.SetDirty(proxy);
            return proxy;
        }

        EditorUtility.CopySerialized(proxy, existing);
        existing.name = proxy.name;
        UnityEngine.Object.DestroyImmediate(proxy);
        EditorUtility.SetDirty(existing);
        return existing;
    }

    static byte[] ReadBytes(string assetPath)
    {
        string projectRoot = Directory.GetParent(Application.dataPath).FullName;
        string fullPath = Path.Combine(projectRoot, assetPath.Replace('/', Path.DirectorySeparatorChar));
        return File.Exists(fullPath) ? File.ReadAllBytes(fullPath) : null;
    }

    static void EnsureProxyFolder()
    {
        if (!AssetDatabase.IsValidFolder(Root + "/Models"))
            AssetDatabase.CreateFolder(Root, "Models");
        if (!AssetDatabase.IsValidFolder(ProxyFolder))
            AssetDatabase.CreateFolder(Root + "/Models", "ProxyMeshes");
    }

    static void SetWorldMatrix(Transform target, Matrix4x4 world)
    {
        Matrix4x4 local = target.parent != null ? target.parent.worldToLocalMatrix * world : world;
        Vector3 x = local.GetColumn(0);
        Vector3 y = local.GetColumn(1);
        Vector3 z = local.GetColumn(2);
        Vector3 scale = new Vector3(x.magnitude, y.magnitude, z.magnitude);
        float determinant = Vector3.Dot(x, Vector3.Cross(y, z));
        if (determinant < 0f) scale.z = -scale.z;

        Vector3 up = scale.y > 1e-7f ? y / scale.y : Vector3.up;
        Vector3 forward = Mathf.Abs(scale.z) > 1e-7f ? z / scale.z : Vector3.forward;
        target.localRotation = forward.sqrMagnitude < 1e-8f || up.sqrMagnitude < 1e-8f || Vector3.Cross(forward, up).sqrMagnitude < 1e-8f
            ? Quaternion.identity
            : Quaternion.LookRotation(forward, up);
        target.localPosition = local.GetColumn(3);
        target.localScale = scale;
    }
}
#endif
