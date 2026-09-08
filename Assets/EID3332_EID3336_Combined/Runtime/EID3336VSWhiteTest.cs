using UnityEngine;
using UnityEngine.Rendering;

/// <summary>
/// Dedicated EID3336 RenderDoc VS209986 test driver.
/// The vertex path is the recovered VS only; the fragment shader returns pure white.
/// Captured buffers are loaded from the serialized EID3336_VSBufferParameters asset
/// through EID3332CombinedSceneMaterialResources.
/// </summary>
[ExecuteAlways]
[DisallowMultipleComponent]
public sealed class EID3336VSWhiteTest : MonoBehaviour
{
    public Camera targetCamera;
    public bool renderInSceneView;
    public bool enabledForCamera = true;
    public Material material;
    public EID3332CombinedSceneMaterialResources resources;
    public EID3332CombinedDrawProfile profile;
    public EID3336VSBufferParameters serializedParameters;
    public int instanceCount = 3;
    public int indexCount = 7980;
    public int shaderInstanceOffset;
    public float rawStream1StrideBytes = 16f;

    [Header("Material-local parameters")]
    public Vector4 localParameter0;
    public Vector4 localParameter1;
    public Vector4 localParameter2;
    public Vector4 localScale = Vector4.one;
    public Vector4 localOffset;
    public Vector4 localFlags;

    static readonly int Local0Id = Shader.PropertyToID("_EID3336VSLocalParameter0");
    static readonly int Local1Id = Shader.PropertyToID("_EID3336VSLocalParameter1");
    static readonly int Local2Id = Shader.PropertyToID("_EID3336VSLocalParameter2");
    static readonly int LocalScaleId = Shader.PropertyToID("_EID3336VSLocalScale");
    static readonly int LocalOffsetId = Shader.PropertyToID("_EID3336VSLocalOffset");
    static readonly int LocalFlagsId = Shader.PropertyToID("_EID3336VSLocalFlags");
    static readonly int RawStrideId = Shader.PropertyToID("_EID3336RawStream1StrideBytes");
    static readonly int InstanceIndexId = Shader.PropertyToID("_EID3336InstanceIndex");
    static readonly int RouteObjectTransformId = Shader.PropertyToID("_EID3336RouteBUseObjectTransform");
    static readonly int ObjectToWorldId = Shader.PropertyToID("_EID3336RouteBObjectToWorld");

    void OnEnable() { ApplyAllParameters(); }
    void OnValidate() { ApplyAllParameters(); }
    void Update() { ApplyAllParameters(); }

    public bool IsForCamera(Camera camera)
    {
        if (!enabled || !enabledForCamera || camera == null) return false;
        if (targetCamera != null && camera == targetCamera) return true;
        return renderInSceneView && camera.cameraType == CameraType.SceneView;
    }

    public void ApplyAllParameters()
    {
        if (resources != null && serializedParameters != null && resources.serializedVSBufferParameters == null)
            resources.serializedVSBufferParameters = serializedParameters;
        if (resources != null && profile != null)
        {
            resources.material = material;
            resources.ApplyProfileStreamLayout(profile);
        }
        if (material == null) return;
        material.SetVector(Local0Id, localParameter0);
        material.SetVector(Local1Id, localParameter1);
        material.SetVector(Local2Id, localParameter2);
        material.SetVector(LocalScaleId, localScale);
        material.SetVector(LocalOffsetId, localOffset);
        material.SetVector(LocalFlagsId, localFlags);
        material.SetFloat(RawStrideId, rawStream1StrideBytes);
    }

    public bool PrepareForDraw(CommandBuffer cmd)
    {
        if (cmd == null || material == null || resources == null || profile == null) return false;
        ApplyAllParameters();
        resources.material = material;
        resources.BindProfileTextures(profile);
        resources.ApplyProfileStreamLayout(profile);
        if (!resources.BindCapturedProfile(profile)) return false;
        resources.BindObjectForCommandBuffer(cmd, profile, false);
        material.SetFloat(RawStrideId, rawStream1StrideBytes);
        material.SetFloat(RouteObjectTransformId, 0f);
        material.SetMatrix(ObjectToWorldId, Matrix4x4.identity);
        return true;
    }

    public void Record(CommandBuffer cmd)
    {
        if (!PrepareForDraw(cmd)) return;
        int pass = material.FindPass("EID3336_RenderDocVS_White");
        if (pass < 0) return;
        int drawIndices = profile != null && profile.indexCount > 0 ? profile.indexCount : indexCount;
        int drawInstances = profile != null && profile.instanceCount > 0 ? profile.instanceCount : instanceCount;
        for (int instance = 0; instance < drawInstances; ++instance)
        {
            cmd.SetGlobalInt(InstanceIndexId, shaderInstanceOffset + instance);
            material.SetFloat(InstanceIndexId, shaderInstanceOffset + instance);
            cmd.DrawProcedural(Matrix4x4.identity, material, pass, MeshTopology.Triangles, drawIndices, 1);
        }
    }
}
