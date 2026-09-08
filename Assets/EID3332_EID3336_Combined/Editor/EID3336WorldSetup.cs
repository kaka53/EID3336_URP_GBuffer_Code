#if UNITY_EDITOR
using UnityEngine;
using UnityEditor;
using System.Collections.Generic;

/// <summary>
/// EID3336 世界坐标还原工具
/// 从 RenderDoc 捕获的实例矩阵数据在 Unity 场景中还原对象
/// </summary>
public static class EID3336WorldSetup
{
    // 从 RenderDoc VS_28_30.bytes 提取的实例矩阵（Vulkan 坐标系）
    private static readonly Matrix4x4[] VulkanInstanceMatrices = new Matrix4x4[]
    {
        // Instance 0
        new Matrix4x4(
            new Vector4(0.769687f, -0.082409f, 0.355874f, 0f),
            new Vector4(0.021846f, 0.838907f, 0.147014f, 0f),
            new Vector4(-0.364637f, -0.123690f, 0.759997f, 0f),
            new Vector4(-533.900024f, 86.239998f, -445.910004f, 1f)
        ),
        // Instance 1
        new Matrix4x4(
            new Vector4(-0.353712f, -0.169084f, -0.977298f, 0f),
            new Vector4(-0.137014f, 1.035967f, -0.129645f, 0f),
            new Vector4(0.982307f, 0.083615f, -0.369991f, 0f),
            new Vector4(-515.034912f, 87.686157f, -454.817383f, 1f)
        ),
        // Instance 2
        new Matrix4x4(
            new Vector4(0.618099f, -0.134524f, 0.841822f, 0f),
            new Vector4(0.142687f, 1.041463f, 0.061660f, 0f),
            new Vector4(-0.840477f, 0.077878f, 0.629557f, 0f),
            new Vector4(-522.400024f, 83.269997f, -458.899994f, 1f)
        )
    };

    [MenuItem("Tools/EID3336/Setup World from RenderDoc Data")]
    public static void SetupWorldFromRenderDocData()
    {
        // 查找或加载 FBX 模型
        string fbxPath = "Assets/EID3332_EID3336_Combined/Models/eid_3336_world.fbx";
        GameObject modelPrefab = AssetDatabase.LoadAssetAtPath<GameObject>(fbxPath);
        
        if (modelPrefab == null)
        {
            Debug.LogError($"[EID3336 Setup] FBX 模型未找到: {fbxPath}");
            return;
        }

        // 创建场景根节点
        GameObject root = new GameObject("EID3336_World");
        
        // 为每个实例创建对象
        for (int i = 0; i < VulkanInstanceMatrices.Length; i++)
        {
            CreateInstance(root.transform, modelPrefab, i, VulkanInstanceMatrices[i]);
        }
        
        Selection.activeGameObject = root;
        
        Debug.Log($"[EID3336 Setup] 已创建 {VulkanInstanceMatrices.Length} 个实例\n" +
                  $"  根节点: EID3336_World\n" +
                  $"  FBX: {fbxPath}");
    }

    private static void CreateInstance(Transform parent, GameObject modelPrefab, int index, Matrix4x4 vulkanMatrix)
    {
        // 转换到 Unity 坐标系
        Matrix4x4 unityMatrix = VulkanToUnityMatrix(vulkanMatrix);
        
        // 创建实例
        GameObject instance = Object.Instantiate(modelPrefab, parent);
        instance.name = $"EID3336_Instance_{index:D3}";
        
        // 从矩阵提取 TRS
        Vector3 position = unityMatrix.GetColumn(3);
        Quaternion rotation = unityMatrix.rotation;
        Vector3 scale = new Vector3(
            unityMatrix.GetColumn(0).magnitude,
            unityMatrix.GetColumn(1).magnitude,
            unityMatrix.GetColumn(2).magnitude
        );
        
        // 应用 Transform
        instance.transform.position = position;
        instance.transform.rotation = rotation;
        instance.transform.localScale = scale;
        
        // 添加标记组件
        var marker = instance.AddComponent<EID3336InstanceMarker>();
        marker.instanceIndex = index;
        marker.vulkanPosition = vulkanMatrix.GetColumn(3);
        marker.vulkanMatrix = vulkanMatrix;
        marker.unityMatrix = unityMatrix;
        
        Debug.Log($"[Instance {index}] Position: {position}, Rotation: {rotation.eulerAngles}, Scale: {scale}");
    }

    private static Matrix4x4 VulkanToUnityMatrix(Matrix4x4 vulkanMatrix)
    {
        // Vulkan: Y-up, -Z front, X right
        // Unity:  Y-up, +Z front, X right
        // 转换: Z 轴取反
        
        Matrix4x4 unityMatrix = vulkanMatrix;
        
        // 翻转 Z 列（第 3 列）
        unityMatrix.m02 = -vulkanMatrix.m02;
        unityMatrix.m12 = -vulkanMatrix.m12;
        unityMatrix.m22 = -vulkanMatrix.m22;
        unityMatrix.m32 = -vulkanMatrix.m32;
        
        // 翻转 Z 行（第 3 行）
        unityMatrix.m20 = -vulkanMatrix.m20;
        unityMatrix.m21 = -vulkanMatrix.m21;
        
        // Position Z 取反
        unityMatrix.m23 = -vulkanMatrix.m23;
        
        return unityMatrix;
    }

    [MenuItem("Tools/EID3336/Print Instance Matrices")]
    public static void PrintInstanceMatrices()
    {
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.AppendLine("=== EID3336 实例矩阵数据 ===\n");
        
        for (int i = 0; i < VulkanInstanceMatrices.Length; i++)
        {
            Matrix4x4 vulkan = VulkanInstanceMatrices[i];
            Matrix4x4 unity = VulkanToUnityMatrix(vulkan);
            
            sb.AppendLine($"Instance {i}:");
            sb.AppendLine($"  Vulkan Position: {vulkan.GetColumn(3)}");
            sb.AppendLine($"  Unity Position:  {unity.GetColumn(3)}");
            
            Vector3 scale = new Vector3(
                vulkan.GetColumn(0).magnitude,
                vulkan.GetColumn(1).magnitude,
                vulkan.GetColumn(2).magnitude
            );
            sb.AppendLine($"  Scale: {scale}");
            sb.AppendLine($"  Rotation (Unity Euler): {unity.rotation.eulerAngles}\n");
        }
        
        sb.AppendLine("坐标系转换:");
        sb.AppendLine("  Vulkan: Y-up, -Z front, X right");
        sb.AppendLine("  Unity:  Y-up, +Z front, X right");
        sb.AppendLine("  转换: Position.z 取反, Z 轴列和行取反");
        
        Debug.Log(sb.ToString());
        EditorGUIUtility.systemCopyBuffer = sb.ToString();
        Debug.Log("[已复制到剪贴板]");
    }

    [MenuItem("Tools/EID3336/Setup Complete Scene (Camera + World)")]
    public static void SetupCompleteScene()
    {
        // 1. 创建世界对象
        SetupWorldFromRenderDocData();
        
        // 2. 创建相机
        EID3336CameraReconstructor.CreateCameraFromRenderDocData();
        
        Debug.Log("[EID3336] 完整场景已创建：3 个模型实例 + 相机");
    }
}

/// <summary>
/// 实例标记组件，存储原始 RenderDoc 数据
/// </summary>
public class EID3336InstanceMarker : MonoBehaviour
{
    [Header("Instance Info")]
    public int instanceIndex;
    
    [Header("Original Vulkan Data")]
    public Vector3 vulkanPosition;
    public Matrix4x4 vulkanMatrix;
    public Matrix4x4 unityMatrix;
    
    [Header("CSV Data")]
    public Vector3 bboxMin;
    public Vector3 bboxMax;
    
    private void OnDrawGizmos()
    {
        // 绘制局部坐标轴
        Gizmos.color = Color.red;
        Gizmos.DrawLine(transform.position, transform.position + transform.right * 5f);
        Gizmos.color = Color.green;
        Gizmos.DrawLine(transform.position, transform.position + transform.up * 5f);
        Gizmos.color = Color.blue;
        Gizmos.DrawLine(transform.position, transform.position + transform.forward * 5f);
        
        // 绘制实例编号
        UnityEditor.Handles.Label(transform.position + Vector3.up * 2f, $"Instance {instanceIndex}");
    }
    
    private void OnDrawGizmosSelected()
    {
        // 高亮显示
        Gizmos.color = Color.yellow;
        Gizmos.DrawWireSphere(transform.position, 1f);
    }
}
#endif
