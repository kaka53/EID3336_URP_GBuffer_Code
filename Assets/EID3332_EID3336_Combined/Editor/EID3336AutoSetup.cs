#if UNITY_EDITOR
using UnityEngine;
using UnityEditor;
using System.IO;

/// <summary>
/// EID3336 自动场景设置工具
/// 读取 CSV 配置文件，自动放置模型实例到场景中
/// </summary>
public static class EID3336AutoSetup
{
    private const string FBX_PATH = "Assets/EID3332_EID3336_Combined/Models/EID3336_VSInput.fbx";
    private const string CSV_PATH = "Assets/EID3332_EID3336_Combined/Models/EID3336_Instances.csv";

    [MenuItem("Tools/EID3336/Auto Setup Scene from CSV")]
    public static void AutoSetupScene()
    {
        // 1. 加载 FBX 模型
        GameObject fbxPrefab = AssetDatabase.LoadAssetAtPath<GameObject>(FBX_PATH);
        if (fbxPrefab == null)
        {
            Debug.LogError($"[EID3336] 找不到 FBX 模型: {FBX_PATH}");
            return;
        }

        // 2. 读取 CSV 配置
        string csvFullPath = Path.Combine(Application.dataPath.Replace("Assets", ""), CSV_PATH);
        if (!File.Exists(csvFullPath))
        {
            Debug.LogError($"[EID3336] 找不到 CSV 配置: {csvFullPath}");
            return;
        }

        string[] lines = File.ReadAllLines(csvFullPath);
        if (lines.Length < 2)
        {
            Debug.LogError("[EID3336] CSV 文件为空或格式错误");
            return;
        }

        // 3. 创建场景根节点
        GameObject root = new GameObject("EID3336_World");
        root.transform.position = Vector3.zero;
        root.transform.rotation = Quaternion.identity;
        root.transform.localScale = Vector3.one;

        // 4. 解析 CSV 并创建实例
        int instanceCount = 0;
        for (int i = 1; i < lines.Length; i++)  // 跳过标题行
        {
            string line = lines[i].Trim();
            if (string.IsNullOrEmpty(line)) continue;

            string[] parts = line.Split(',');
            if (parts.Length < 11)
            {
                Debug.LogWarning($"[EID3336] CSV 第 {i + 1} 行格式错误，跳过");
                continue;
            }

            try
            {
                // 解析数据: Index,Name,PosX,PosY,PosZ,RotX,RotY,RotZ,ScaleX,ScaleY,ScaleZ
                int index = int.Parse(parts[0]);
                string name = parts[1];
                Vector3 position = new Vector3(
                    float.Parse(parts[2]),
                    float.Parse(parts[3]),
                    float.Parse(parts[4])
                );
                Vector3 rotation = new Vector3(
                    float.Parse(parts[5]),
                    float.Parse(parts[6]),
                    float.Parse(parts[7])
                );
                Vector3 scale = new Vector3(
                    float.Parse(parts[8]),
                    float.Parse(parts[9]),
                    float.Parse(parts[10])
                );

                // 创建实例
                GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(fbxPrefab, root.transform);
                instance.name = name;
                instance.transform.position = position;
                instance.transform.eulerAngles = rotation;
                instance.transform.localScale = scale;

                Debug.Log($"[EID3336] 创建实例 {index}: {name} at {position}");
                instanceCount++;
            }
            catch (System.Exception ex)
            {
                Debug.LogError($"[EID3336] 解析 CSV 第 {i + 1} 行失败: {ex.Message}");
            }
        }

        // 5. 选中根节点
        Selection.activeGameObject = root;
        EditorGUIUtility.PingObject(root);

        Debug.Log($"[EID3336 Auto Setup] 完成！创建了 {instanceCount} 个实例");
        Debug.Log($"  根节点: {root.name}");
        Debug.Log($"  模型: {FBX_PATH}");
    }

    [MenuItem("Tools/EID3336/Auto Setup Complete Scene (With Camera)")]
    public static void AutoSetupCompleteScene()
    {
        // 1. 创建模型实例
        AutoSetupScene();

        // 2. 创建相机
        GameObject cameraObj = new GameObject("EID3336_RenderDoc_Camera");
        Camera camera = cameraObj.AddComponent<Camera>();

        // 设置 Transform
        cameraObj.transform.position = new Vector3(-560.816f, 108.866f, 410.792f);
        cameraObj.transform.eulerAngles = new Vector3(10.713f, 70.633f, 0.0f);

        // 设置相机参数
        camera.fieldOfView = 58.86f;
        camera.nearClipPlane = 0.3f;
        camera.farClipPlane = 1000f;
        camera.clearFlags = CameraClearFlags.Skybox;
        camera.allowHDR = true;
        camera.allowMSAA = false;

        Debug.Log("[EID3336] 相机已创建");
        Debug.Log($"  Position: {cameraObj.transform.position}");
        Debug.Log($"  Rotation: {cameraObj.transform.eulerAngles}");
        Debug.Log($"  FOV: {camera.fieldOfView}");
    }

    [MenuItem("Tools/EID3336/Clear EID3336 Scene")]
    public static void ClearScene()
    {
        GameObject root = GameObject.Find("EID3336_World");
        if (root != null)
        {
            Object.DestroyImmediate(root);
            Debug.Log("[EID3336] 已删除 EID3336_World");
        }

        GameObject camera = GameObject.Find("EID3336_RenderDoc_Camera");
        if (camera != null)
        {
            Object.DestroyImmediate(camera);
            Debug.Log("[EID3336] 已删除相机");
        }
    }

    [MenuItem("Tools/EID3336/Validate Scene Setup")]
    public static void ValidateScene()
    {
        GameObject root = GameObject.Find("EID3336_World");
        if (root == null)
        {
            Debug.LogWarning("[EID3336] 场景中没有找到 EID3336_World");
            return;
        }

        int instanceCount = 0;
        System.Text.StringBuilder report = new System.Text.StringBuilder();
        report.AppendLine("=== EID3336 场景验证报告 ===\n");

        foreach (Transform child in root.transform)
        {
            report.AppendLine($"实例 {instanceCount}: {child.name}");
            report.AppendLine($"  Position: {child.position}");
            report.AppendLine($"  Rotation: {child.eulerAngles}");
            report.AppendLine($"  Scale: {child.localScale}");
            
            MeshFilter mf = child.GetComponent<MeshFilter>();
            if (mf != null && mf.sharedMesh != null)
            {
                report.AppendLine($"  Mesh: {mf.sharedMesh.name} ({mf.sharedMesh.vertexCount} vertices)");
            }
            else
            {
                report.AppendLine("  ⚠️ 缺少 Mesh");
            }
            report.AppendLine();
            instanceCount++;
        }

        report.AppendLine($"总实例数: {instanceCount}");
        
        GameObject camera = GameObject.Find("EID3336_RenderDoc_Camera");
        if (camera != null)
        {
            report.AppendLine($"\n相机: {camera.name}");
            report.AppendLine($"  Position: {camera.transform.position}");
            report.AppendLine($"  Rotation: {camera.transform.eulerAngles}");
            
            Camera cam = camera.GetComponent<Camera>();
            if (cam != null)
            {
                report.AppendLine($"  FOV: {cam.fieldOfView}");
                report.AppendLine($"  Near/Far: {cam.nearClipPlane}/{cam.farClipPlane}");
            }
        }
        else
        {
            report.AppendLine("\n⚠️ 未找到相机");
        }

        Debug.Log(report.ToString());
        EditorGUIUtility.systemCopyBuffer = report.ToString();
        Debug.Log("[已复制到剪贴板]");
    }
}
#endif
