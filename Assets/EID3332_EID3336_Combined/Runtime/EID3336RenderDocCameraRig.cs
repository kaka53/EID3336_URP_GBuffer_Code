using UnityEngine;

/// <summary>
/// Camera reconstructed from EID3336 / VS209986 captured camera buffers.
/// The serialized matrices are the exact values used by the RenderDoc replay path.
/// </summary>
[ExecuteAlways]
[DisallowMultipleComponent]
public sealed class EID3336RenderDocCameraRig : MonoBehaviour
{
    [Header("RenderDoc capture")]
    public Camera targetCamera;
    public int captureWidth = 1366;
    public int captureHeight = 768;
    public float captureVerticalFov = 58.00002f;
    public float captureNearClip = 0.1f;
    public float captureFarClip = 10106.856f;
    public Vector3 captureCameraPosition = new Vector3(-560.815674f, 108.866417f, -410.792053f);
    // Right-handed Unity transform obtained from the captured camera basis with Vulkan Z converted to Unity +Z.
    public Quaternion captureCameraRotation = new Quaternion(0.05396448f, 0.8124064f, -0.07616986f, 0.57557084f);

    [Header("Exact captured matrices")]
    [Tooltip("RenderDoc VS_25_m0 converted to the matrix convention used by the replay controller.")]
    public Matrix4x4 renderDocWorldToCamera = new Matrix4x4(
        new Vector4(-0.33161211f, 0.17536440f, -0.92697406f, 0f),
        new Vector4(0.00000002235174f, 0.98257202f, 0.18588239f, 0f),
        new Vector4(-0.94341588f, -0.06164081f, 0.32583272f, 0f),
        new Vector4(-573.520996f, -33.943565f, -406.248383f, 1f));

    [Tooltip("RenderDoc VS_25_m2 converted to the matrix convention used by the replay controller.")]
    public Matrix4x4 renderDocProjection = new Matrix4x4(
        new Vector4(1.01428139f, 0f, 0f, 0f),
        new Vector4(0f, -1.80404747f, 0f, 0f),
        new Vector4(-0.00018303019f, 0.00072340545f, 0.000009894371f, 0.100000985f),
        new Vector4(0f, 0f, -1f, 0f));

    public bool applyExactMatrices = true;
    public bool applyTransform = true;
    public bool forceCaptureAspect = true;

    void OnEnable() { Apply(); }
    void OnValidate() { Apply(); }
    void LateUpdate() { Apply(); }
    void OnPreCull() { Apply(); }

    [ContextMenu("Apply EID3336 RenderDoc Camera")]
    public void Apply()
    {
        if (targetCamera == null) targetCamera = GetComponent<Camera>();
        if (targetCamera == null) return;

        if (applyTransform)
            targetCamera.transform.SetPositionAndRotation(captureCameraPosition, captureCameraRotation);

        targetCamera.nearClipPlane = captureNearClip;
        targetCamera.farClipPlane = captureFarClip;
        targetCamera.fieldOfView = captureVerticalFov;
        if (forceCaptureAspect && captureHeight > 0)
            targetCamera.aspect = (float)captureWidth / captureHeight;

        if (applyExactMatrices)
        {
            targetCamera.worldToCameraMatrix = renderDocWorldToCamera;
            targetCamera.projectionMatrix = renderDocProjection;
        }
        else
        {
            targetCamera.ResetWorldToCameraMatrix();
            targetCamera.ResetProjectionMatrix();
        }
    }

    [ContextMenu("Reset To Unity Camera Matrices")]
    public void ResetUnityMatrices()
    {
        applyExactMatrices = false;
        Apply();
    }
}
