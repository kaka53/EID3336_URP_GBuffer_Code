#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEngine;

/// <summary>
/// EID3320 场景实例搭建工具。
/// 从 Resources/EID3320VS/_28_30.bytes 读取 4 个实例矩阵，直接在场景中实例化
/// 模型（场景整体为 Vulkan capture 空间，相机负责 -Z/+Z），与 EID3336 一致。
/// </summary>
public static class EID3320SceneSetup
{
    const string Root = "Assets/EID3332_EID3336_Combined";
    const string MeshPath = Root + "/Models/VSInputExport/EID3320_VSInput_Exact.asset";
    const string MaterialPath = Root + "/Geometry/EID3332CombinedSharedMRT_EID3320.mat";
    const string MatrixBytesPath = Root + "/Resources/EID3320VS/_28_30.bytes";
    const int InstanceCount = 4;

    [MenuItem("Tools/EID3332+3336/EID3320 Setup Instances in Scene")]
    public static void SetupInstances()
    {
        Mesh mesh = AssetDatabase.LoadAssetAtPath<Mesh>(MeshPath);
        if (mesh == null)
        {
            Debug.LogError("[EID3320] Mesh not found: " + MeshPath + " — run 'Export EID3320 Exact VSInput Model' first.");
            return;
        }
        Material material = AssetDatabase.LoadAssetAtPath<Material>(MaterialPath);

        GameObject root = GameObject.Find("EID3320_World");
        if (root == null)
        {
            root = new GameObject("EID3320_World");
            Undo.RegisterCreatedObjectUndo(root, "Create EID3320 World");
        }

        for (int i = 0; i < InstanceCount; i++)
        {
            string name = "EID3320_Instance_" + i.ToString("D3");
            Transform existing = root.transform.Find(name);
            GameObject go = existing != null ? existing.gameObject : new GameObject(name);
            if (existing == null)
            {
                go.transform.SetParent(root.transform, false);
                Undo.RegisterCreatedObjectUndo(go, "Create " + name);
            }
            var mf = go.GetComponent<MeshFilter>();
            if (mf == null) mf = go.AddComponent<MeshFilter>();
            mf.sharedMesh = mesh;
            var mr = go.GetComponent<MeshRenderer>();
            if (mr == null) mr = go.AddComponent<MeshRenderer>();
            mr.sharedMaterial = material;

            Matrix4x4 capture = ReadInstanceMatrix(i);
            ApplyWorldMatrix(go.transform, capture);
        }

        Selection.activeGameObject = root;
        EditorGUIUtility.PingObject(root);
        Debug.Log("[EID3320] Created " + InstanceCount + " instances under 'EID3320_World' (capture world matrix applied directly).");
    }

    [MenuItem("Tools/EID3332+3336/EID3320 Validate Scene Instances")]
    public static void ValidateInstances()
    {
        GameObject root = GameObject.Find("EID3320_World");
        StringBuilder sb = new StringBuilder();
        sb.AppendLine("=== EID3320 场景实例验证 ===\n");

        if (root == null)
        {
            sb.AppendLine("未找到 EID3320_World 根节点");
            Debug.Log(sb.ToString());
            EditorGUIUtility.systemCopyBuffer = sb.ToString();
            return;
        }

        int count = 0;
        foreach (Transform child in root.transform)
        {
            sb.AppendLine($"实例 {count}: {child.name}");
            sb.AppendLine($"  Position: {child.position}");
            sb.AppendLine($"  Rotation: {child.rotation.eulerAngles}");
            sb.AppendLine($"  Scale: {child.localScale}");
            MeshFilter mf = child.GetComponent<MeshFilter>();
            if (mf != null && mf.sharedMesh != null)
                sb.AppendLine($"  Mesh: {mf.sharedMesh.name} ({mf.sharedMesh.vertexCount} verts, {mf.sharedMesh.triangles.Length / 3} tris)");
            else
                sb.AppendLine("  ⚠️ 缺少 Mesh");
            sb.AppendLine();
            count++;
        }
        sb.AppendLine($"总实例数: {count}");

        Debug.Log(sb.ToString());
        EditorGUIUtility.systemCopyBuffer = sb.ToString();
    }

    static Matrix4x4 ReadInstanceMatrix(int index)
    {
        string path = Path.Combine(Application.dataPath, MatrixBytesPath.Substring("Assets/".Length).Replace('/', Path.DirectorySeparatorChar));
        if (!File.Exists(path)) { Debug.LogError("[EID3320] matrix bytes not found: " + path); return Matrix4x4.identity; }
        byte[] bytes = File.ReadAllBytes(path);
        int offset = index * 256;
        if (offset + 64 > bytes.Length) return Matrix4x4.identity;
        Matrix4x4 m = Matrix4x4.identity;
        for (int c = 0; c < 4; ++c)
        {
            Vector4 col = new Vector4(
                BitConverter.ToSingle(bytes, offset + c * 16 + 0),
                BitConverter.ToSingle(bytes, offset + c * 16 + 4),
                BitConverter.ToSingle(bytes, offset + c * 16 + 8),
                BitConverter.ToSingle(bytes, offset + c * 16 + 12));
            m.SetColumn(c, col);
        }
        return m;
    }

    static void ApplyWorldMatrix(Transform target, Matrix4x4 matrix)
    {
        Vector3 x = matrix.GetColumn(0), y = matrix.GetColumn(1), z = matrix.GetColumn(2);
        Vector3 p = matrix.GetColumn(3);
        float sx = x.magnitude, sy = y.magnitude, sz = z.magnitude;
        if (sx < 1e-6f || sy < 1e-6f || sz < 1e-6f) { target.position = p; return; }
        Vector3 scale = new Vector3(sx, sy, sz);
        if (Vector3.Dot(Vector3.Cross(x / sx, y / sy), z / sz) < 0f) scale.z = -scale.z;
        target.SetPositionAndRotation(p, Quaternion.LookRotation(z / sz, y / sy));
        target.localScale = scale;
    }
}
#endif

