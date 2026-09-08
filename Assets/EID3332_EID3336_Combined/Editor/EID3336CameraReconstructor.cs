#if UNITY_EDITOR
using UnityEngine;
using UnityEditor;

/// <summary>
/// EID3336 相机还原工具
/// 从 RenderDoc 捕获的相机数据在 Unity 中重建相机
/// 数据来源: endfield Vulkan 主相机，EID 3336
/// </summary>
public static class EID3336CameraReconstructor
{
    [MenuItem("Tools/EID3336/Create Camera from RenderDoc Data")]
    public static void CreateCameraFromRenderDocData()
    {
        // === 从 RenderDoc EID3336 捕获的数据 ===
        // 坐标系转换: Vulkan (Y-up, -Z front) → Unity (Y-up, +Z front)
        
        // 1. 相机位置（Vulkan → Unity: Z 取反）
        Vector3 vulkanPosition = new Vector3(-560.816f, 108.866f, -410.792f);
        Vector3 unityPosition = new Vector3(
            vulkanPosition.x,
            vulkanPosition.y,
            -vulkanPosition.z  // Z 取反
        );
        
        // 2. 相机旋转（从旋转矩阵计算的欧拉角）
        Vector3 unityRotation = new Vector3(10.713f, 70.633f, 0.0f);
        
        // 3. 投影参数（从 Projection 矩阵推导）
        float fieldOfView = 58.86f;  // Vertical FOV
        float nearClipPlane = 0.3f;  // Vulkan reversed-Z 推导值
        float farClipPlane = 1000f;
        
        // 创建相机 GameObject
        GameObject cameraObj = new GameObject("EID3336_RenderDoc_Camera");
        Camera camera = cameraObj.AddComponent<Camera>();
        
        // 设置 Transform
        cameraObj.transform.position = unityPosition;
        cameraObj.transform.eulerAngles = unityRotation;
        
        // 设置相机参数
        camera.fieldOfView = fieldOfView;
        camera.nearClipPlane = nearClipPlane;
        camera.farClipPlane = farClipPlane;
        camera.clearFlags = CameraClearFlags.Skybox;
        camera.backgroundColor = new Color(0.1f, 0.1f, 0.1f, 1f);
        camera.cullingMask = -1; // 渲染所有层
        camera.allowHDR = true;
        camera.allowMSAA = false;
        
        // 添加相机标记组件
        var marker = cameraObj.AddComponent<EID3336CameraMarker>();
        marker.sourceEID = 3336;
        marker.captureFile = "endfield06.rdc";
        marker.coordinateSystem = "Vulkan Y-up -Z front → Unity Y-up +Z front";
        marker.vulkanPosition = vulkanPosition;
        marker.distanceToSceneCenter = 62.06f;
        
        // 选中新创建的相机
        Selection.activeGameObject = cameraObj;
        
        Debug.Log($"[EID3336 Camera] 相机已创建\n" +
                  $"  Position (Unity): {unityPosition}\n" +
                  $"  Rotation: {unityRotation}\n" +
                  $"  FOV: {fieldOfView}°\n" +
                  $"  Near/Far: {nearClipPlane}/{farClipPlane}\n" +
                  $"  场景中心距离: 62.06 units");
    }
    
    [MenuItem("Tools/EID3336/Print Camera Matrix Details")]
    public static void PrintCameraMatrixDetails()
    {
        string details = @"
=== EID3336 RenderDoc 相机完整数据 ===

原始 Vulkan 数据:
  坐标系: Y-up, -Z front, X right
  Position: (-560.816, 108.866, -410.792)
  
Camera World Matrix (VS_25_m1):
  [-0.331612,  0.175364, -0.926974, -560.816]
  [ 0.000000,  0.982572,  0.185882,  108.866]
  [-0.943416, -0.061641,  0.325833, -410.792]
  [ 0.000000,  0.000000,  0.000000,    1.000]
  
  Right:   (-0.331612,  0.000000, -0.943416)
  Up:      ( 0.175364,  0.982572, -0.061641)
  Forward: (-0.926974,  0.185882,  0.325833)
  
转换到 Unity:
  坐标系: Y-up, +Z front, X right
  Position: (-560.816, 108.866, 410.792)  [Z 取反]
  Rotation: (10.713°, 70.633°, 0.0°)
  FOV Y: 58.86°
  Aspect: 5.27 (ViewProjection 推导)
  Near/Far: 0.3 / 1000.0
  
  Right:   (-0.331612,  0.000000,  0.943416)
  Up:      ( 0.175364,  0.982572,  0.061641)
  Forward: ( 0.926974, -0.185882,  0.325833)

场景数据 (EID3336 绘制的对象):
  BBox Min: (-550.690, 82.115, -480.828)
  BBox Max: (-494.729, 104.000, -433.490)
  BBox Center (Vulkan): (-522.709, 93.057, -457.159)
  BBox Center (Unity):  (-522.709, 93.057,  457.159)
  相机到场景中心: 62.06 units
  
  绘制: vkCmdDrawIndexed(7980 indices, 3 instances)
  顶点: 5139, 三角形: 7980

投影细节:
  TAA Jitter: (-0.125, -0.278, -0.00009, -0.00036)
  ViewProjection[1][1]: -1.772607 → FOV
  
坐标系转换规则:
  Vulkan → Unity
  - Position.z 取反
  - Forward 向量取反
  - Rotation 从旋转矩阵重新计算
";
        Debug.Log(details);
        EditorGUIUtility.systemCopyBuffer = details;
        Debug.Log("[已复制到剪贴板]");
    }
}

/// <summary>
/// 标记组件，存储 RenderDoc 捕获的原始数据
/// </summary>
public class EID3336CameraMarker : MonoBehaviour
{
    [Header("RenderDoc Capture Info")]
    public int sourceEID = 3336;
    public string captureFile = "endfield06.rdc";
    public string coordinateSystem = "Vulkan Y-up -Z front";
    
    [Header("Original Data")]
    public Vector3 vulkanPosition;
    public float distanceToSceneCenter;
    
    [Header("Scene BBox (Vulkan Coordinates)")]
    public Vector3 bboxMin = new Vector3(-550.69f, 82.11f, -480.83f);
    public Vector3 bboxMax = new Vector3(-494.73f, 104.00f, -433.49f);
    
    private void OnDrawGizmos()
    {
        // 绘制相机方向
        Gizmos.color = Color.yellow;
        Gizmos.DrawLine(transform.position, transform.position + transform.forward * 10f);
        
        // 绘制到场景中心的线
        Vector3 sceneCenter = new Vector3(-522.71f, 93.06f, 457.16f);
        Gizmos.color = Color.cyan;
        Gizmos.DrawLine(transform.position, sceneCenter);
        Gizmos.DrawWireSphere(sceneCenter, 2f);
    }
    
    private void OnDrawGizmosSelected()
    {
        // 绘制 BBox (转换到 Unity 坐标)
        Vector3 unityMin = new Vector3(bboxMin.x, bboxMin.y, -bboxMin.z);
        Vector3 unityMax = new Vector3(bboxMax.x, bboxMax.y, -bboxMax.z);
        
        Gizmos.color = Color.green;
        DrawWireBBox(unityMin, unityMax);
    }
    
    private void DrawWireBBox(Vector3 min, Vector3 max)
    {
        Vector3[] corners = new Vector3[8];
        corners[0] = new Vector3(min.x, min.y, min.z);
        corners[1] = new Vector3(max.x, min.y, min.z);
        corners[2] = new Vector3(max.x, max.y, min.z);
        corners[3] = new Vector3(min.x, max.y, min.z);
        corners[4] = new Vector3(min.x, min.y, max.z);
        corners[5] = new Vector3(max.x, min.y, max.z);
        corners[6] = new Vector3(max.x, max.y, max.z);
        corners[7] = new Vector3(min.x, max.y, max.z);
        
        // Bottom face
        Gizmos.DrawLine(corners[0], corners[1]);
        Gizmos.DrawLine(corners[1], corners[2]);
        Gizmos.DrawLine(corners[2], corners[3]);
        Gizmos.DrawLine(corners[3], corners[0]);
        
        // Top face
        Gizmos.DrawLine(corners[4], corners[5]);
        Gizmos.DrawLine(corners[5], corners[6]);
        Gizmos.DrawLine(corners[6], corners[7]);
        Gizmos.DrawLine(corners[7], corners[4]);
        
        // Vertical edges
        Gizmos.DrawLine(corners[0], corners[4]);
        Gizmos.DrawLine(corners[1], corners[5]);
        Gizmos.DrawLine(corners[2], corners[6]);
        Gizmos.DrawLine(corners[3], corners[7]);
    }
}
#endif
