using UnityEngine;
using UnityEditor;
using System.Text;

/// <summary>
/// EID3320 模型导入后处理器和验证工具
/// 确保所有顶点属性正确导入
/// </summary>
public class EID3320ImportValidator : AssetPostprocessor
{
    // 在导入 EID3320 模型时自动配置
    void OnPreprocessModel()
    {
        if (!assetPath.Contains("EID3320") && !assetPath.Contains("eid3320"))
            return;

        ModelImporter importer = (ModelImporter)assetImporter;

        Debug.Log($"[EID3320] Preprocessing model: {assetPath}");

        // 模型设置
        importer.globalScale = 1.0f;
        importer.useFileScale = false;
        importer.bakeAxisConversion = true;
        importer.importBlendShapes = true;
        importer.importVisibility = true;
        importer.importCameras = false;
        importer.importLights = false;
        importer.preserveHierarchy = true;

        // 网格设置 - 保留所有顶点属性
        importer.isReadable = true;  // 重要！允许读取顶点数据
        importer.optimizeMeshVertices = false;  // 不优化顶点
        importer.optimizeMeshPolygons = false;  // 不优化多边形
        importer.weldVertices = false;  // 不合并顶点
        importer.keepQuads = true;
        importer.indexFormat = ModelImporterIndexFormat.Auto;

        // 法线和切线
        importer.importNormals = ModelImporterNormals.Import;
        importer.importBlendShapeNormals = ModelImporterNormals.Import;
        importer.normalCalculationMode = ModelImporterNormalCalculationMode.Unweighted;
        importer.importTangents = ModelImporterTangents.Import;

        // UV 设置
        importer.swapUVChannels = false;
        importer.generateSecondaryUV = false;

        // 材质设置
        importer.materialImportMode = ModelImporterMaterialImportMode.None;

        // 动画设置
        importer.importAnimation = false;

        Debug.Log($"[EID3320] Import settings configured for: {assetPath}");
    }

    void OnPostprocessModel(GameObject go)
    {
        if (!assetPath.Contains("EID3320") && !assetPath.Contains("eid3320"))
            return;

        Debug.Log($"[EID3320] Postprocessing model: {assetPath}");

        // 验证所有网格
        MeshFilter[] meshFilters = go.GetComponentsInChildren<MeshFilter>();
        foreach (var mf in meshFilters)
        {
            if (mf.sharedMesh != null)
            {
                ValidateMesh(mf.sharedMesh, assetPath);
            }
        }
    }

    private void ValidateMesh(Mesh mesh, string path)
    {
        StringBuilder report = new StringBuilder();
        report.AppendLine($"[EID3320] Mesh Validation Report: {mesh.name}");
        report.AppendLine($"Asset Path: {path}");
        report.AppendLine("─────────────────────────────────────────");

        // 基本信息
        report.AppendLine($"Vertices: {mesh.vertexCount}");
        report.AppendLine($"Triangles: {mesh.triangles.Length / 3}");
        report.AppendLine($"SubMeshes: {mesh.subMeshCount}");

        // 顶点属性检查
        report.AppendLine("\nVertex Attributes:");
        report.AppendLine($"  ✓ Positions: {mesh.vertices.Length}");

        if (mesh.normals.Length > 0)
            report.AppendLine($"  ✓ Normals: {mesh.normals.Length}");
        else
            report.AppendLine($"  ✗ Normals: MISSING");

        if (mesh.tangents.Length > 0)
            report.AppendLine($"  ✓ Tangents: {mesh.tangents.Length}");
        else
            report.AppendLine($"  ✗ Tangents: MISSING");

        if (mesh.colors.Length > 0)
            report.AppendLine($"  ✓ Colors: {mesh.colors.Length}");
        else
            report.AppendLine($"  ⚠ Colors: Not present (may be optional)");

        // UV 通道
        report.AppendLine("\nUV Channels:");
        report.AppendLine($"  UV0 (uv): {(mesh.uv.Length > 0 ? $"✓ {mesh.uv.Length}" : "✗ MISSING")}");
        report.AppendLine($"  UV1 (uv2): {(mesh.uv2.Length > 0 ? $"✓ {mesh.uv2.Length}" : "⚠ Not present")}");
        report.AppendLine($"  UV2 (uv3): {(mesh.uv3.Length > 0 ? $"✓ {mesh.uv3.Length}" : "⚠ Not present")}");
        report.AppendLine($"  UV3 (uv4): {(mesh.uv4.Length > 0 ? $"✓ {mesh.uv4.Length}" : "⚠ Not present")}");

        // 骨骼数据（如有）
        if (mesh.boneWeights.Length > 0)
        {
            report.AppendLine("\nSkinning Data:");
            report.AppendLine($"  ✓ Bone Weights: {mesh.boneWeights.Length}");
            report.AppendLine($"  ✓ Bind Poses: {mesh.bindposes.Length}");
        }

        // 边界
        report.AppendLine("\nBounds:");
        report.AppendLine($"  Center: {mesh.bounds.center}");
        report.AppendLine($"  Size: {mesh.bounds.size}");

        report.AppendLine("─────────────────────────────────────────");

        Debug.Log(report.ToString());
    }
}

/// <summary>
/// 编辑器窗口：手动验证和检查 EID3320 模型
/// </summary>
public class EID3320MeshInspector : EditorWindow
{
    private GameObject selectedObject;
    private Vector2 scrollPosition;
    private string reportText = "";

    [MenuItem("Tools/EID3320/Mesh Inspector")]
    public static void ShowWindow()
    {
        var window = GetWindow<EID3320MeshInspector>("EID3320 Inspector");
        window.minSize = new Vector2(400, 600);
    }

    void OnGUI()
    {
        GUILayout.Label("EID3320 Mesh Inspector", EditorStyles.boldLabel);
        GUILayout.Space(10);

        EditorGUILayout.HelpBox(
            "选择包含 EID3320 网格的 GameObject 或直接选择 FBX 资产进行详细检查。",
            MessageType.Info
        );

        GUILayout.Space(10);

        // 对象选择
        GameObject newSelection = (GameObject)EditorGUILayout.ObjectField(
            "Target Object",
            selectedObject,
            typeof(GameObject),
            true
        );

        if (newSelection != selectedObject)
        {
            selectedObject = newSelection;
            if (selectedObject != null)
            {
                InspectObject();
            }
        }

        GUILayout.Space(10);

        if (GUILayout.Button("Inspect Selected", GUILayout.Height(30)))
        {
            if (Selection.activeGameObject != null)
            {
                selectedObject = Selection.activeGameObject;
                InspectObject();
            }
            else
            {
                reportText = "请先在 Hierarchy 或 Project 中选择一个对象。";
            }
        }

        GUILayout.Space(10);

        // 显示报告
        if (!string.IsNullOrEmpty(reportText))
        {
            scrollPosition = EditorGUILayout.BeginScrollView(scrollPosition);
            EditorGUILayout.TextArea(reportText, GUILayout.ExpandHeight(true));
            EditorGUILayout.EndScrollView();
        }
    }

    void InspectObject()
    {
        if (selectedObject == null)
        {
            reportText = "没有选择对象。";
            return;
        }

        StringBuilder report = new StringBuilder();
        report.AppendLine($"═══════════════════════════════════════════════");
        report.AppendLine($"EID3320 详细检查报告");
        report.AppendLine($"对象: {selectedObject.name}");
        report.AppendLine($"═══════════════════════════════════════════════\n");

        // 查找所有 MeshFilter
        MeshFilter[] meshFilters = selectedObject.GetComponentsInChildren<MeshFilter>();

        if (meshFilters.Length == 0)
        {
            report.AppendLine("⚠ 未找到 MeshFilter 组件。");

            // 检查是否是资产
            string assetPath = AssetDatabase.GetAssetPath(selectedObject);
            if (!string.IsNullOrEmpty(assetPath))
            {
                report.AppendLine($"\n这是一个资产文件: {assetPath}");
                report.AppendLine("请将其拖入场景后再检查，或直接检查其子对象。");
            }

            reportText = report.ToString();
            return;
        }

        report.AppendLine($"找到 {meshFilters.Length} 个网格\n");

        for (int i = 0; i < meshFilters.Length; i++)
        {
            MeshFilter mf = meshFilters[i];
            if (mf.sharedMesh == null)
            {
                report.AppendLine($"[{i}] {mf.gameObject.name}: 无网格数据\n");
                continue;
            }

            Mesh mesh = mf.sharedMesh;

            report.AppendLine($"───────────────────────────────────────────────");
            report.AppendLine($"[{i}] Mesh: {mesh.name}");
            report.AppendLine($"GameObject: {mf.gameObject.name}");
            report.AppendLine($"───────────────────────────────────────────────");

            // 基本统计
            report.AppendLine($"\n【基本信息】");
            report.AppendLine($"  顶点数: {mesh.vertexCount:N0}");
            report.AppendLine($"  三角形数: {mesh.triangles.Length / 3:N0}");
            report.AppendLine($"  子网格数: {mesh.subMeshCount}");
            report.AppendLine($"  可读: {mesh.isReadable}");

            // 顶点属性
            report.AppendLine($"\n【顶点属性】");
            AppendAttributeStatus(report, "位置 (Position)", mesh.vertices.Length, mesh.vertexCount);
            AppendAttributeStatus(report, "法线 (Normal)", mesh.normals.Length, mesh.vertexCount);
            AppendAttributeStatus(report, "切线 (Tangent)", mesh.tangents.Length, mesh.vertexCount);
            AppendAttributeStatus(report, "顶点色 (Color)", mesh.colors.Length, mesh.vertexCount);

            // UV 通道
            report.AppendLine($"\n【UV 通道】");
            AppendAttributeStatus(report, "UV0", mesh.uv.Length, mesh.vertexCount);
            AppendAttributeStatus(report, "UV1", mesh.uv2.Length, mesh.vertexCount);
            AppendAttributeStatus(report, "UV2", mesh.uv3.Length, mesh.vertexCount);
            AppendAttributeStatus(report, "UV3", mesh.uv4.Length, mesh.vertexCount);
            AppendAttributeStatus(report, "UV4", mesh.uv5.Length, mesh.vertexCount);
            AppendAttributeStatus(report, "UV5", mesh.uv6.Length, mesh.vertexCount);
            AppendAttributeStatus(report, "UV6", mesh.uv7.Length, mesh.vertexCount);
            AppendAttributeStatus(report, "UV7", mesh.uv8.Length, mesh.vertexCount);

            // 蒙皮数据
            if (mesh.boneWeights.Length > 0)
            {
                report.AppendLine($"\n【蒙皮数据】");
                report.AppendLine($"  骨骼权重: {mesh.boneWeights.Length}");
                report.AppendLine($"  绑定姿态: {mesh.bindposes.Length}");
            }

            // 边界信息
            report.AppendLine($"\n【包围盒】");
            report.AppendLine($"  中心: {mesh.bounds.center}");
            report.AppendLine($"  尺寸: {mesh.bounds.size}");
            report.AppendLine($"  范围: X[{mesh.bounds.min.x:F2}, {mesh.bounds.max.x:F2}] " +
                            $"Y[{mesh.bounds.min.y:F2}, {mesh.bounds.max.y:F2}] " +
                            $"Z[{mesh.bounds.min.z:F2}, {mesh.bounds.max.z:F2}]");

            // 示例顶点数据
            if (mesh.vertexCount > 0 && mesh.isReadable)
            {
                report.AppendLine($"\n【示例顶点 (索引 0)】");
                report.AppendLine($"  位置: {mesh.vertices[0]}");
                if (mesh.normals.Length > 0)
                    report.AppendLine($"  法线: {mesh.normals[0]}");
                if (mesh.tangents.Length > 0)
                    report.AppendLine($"  切线: {mesh.tangents[0]}");
                if (mesh.uv.Length > 0)
                    report.AppendLine($"  UV0: {mesh.uv[0]}");
                if (mesh.colors.Length > 0)
                    report.AppendLine($"  颜色: {mesh.colors[0]}");
            }

            report.AppendLine();
        }

        report.AppendLine($"═══════════════════════════════════════════════");
        report.AppendLine($"检查完成 - {System.DateTime.Now:yyyy-MM-dd HH:mm:ss}");
        report.AppendLine($"═══════════════════════════════════════════════");

        reportText = report.ToString();
    }

    void AppendAttributeStatus(StringBuilder sb, string name, int count, int expected)
    {
        string status;
        if (count == expected && count > 0)
            status = "✓";
        else if (count == 0)
            status = "✗";
        else
            status = "⚠";

        sb.AppendLine($"  {status} {name}: {count} / {expected}");
    }
}

/// <summary>
/// 快速访问菜单
/// </summary>
public class EID3320QuickMenu
{
    [MenuItem("Tools/EID3320/Open Models Folder")]
    public static void OpenModelsFolder()
    {
        string path = "Assets/EID3336_URP_Reconstruction/Models";
        Object obj = AssetDatabase.LoadAssetAtPath<Object>(path);
        if (obj != null)
        {
            EditorGUIUtility.PingObject(obj);
            Selection.activeObject = obj;
        }
        else
        {
            Debug.LogWarning($"文件夹不存在: {path}");
        }
    }

    [MenuItem("Tools/EID3320/Documentation")]
    public static void OpenDocumentation()
    {
        string path = "Assets/../EID3320_Export_Guide.md";
        if (System.IO.File.Exists(path))
        {
            System.Diagnostics.Process.Start(path);
        }
        else
        {
            Debug.LogWarning("未找到文档文件");
        }
    }
}
