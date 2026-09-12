using System;
using UnityEngine;
using UnityEngine.Rendering;

/// <summary>
/// Supplies the captured EID4922 resources to a native URP Environment Skybox
/// material. It does not draw anything; URP's DrawSkyboxPass performs the draw.
/// </summary>
[ExecuteAlways]
public sealed class EID4922EnvironmentSkyBinder : MonoBehaviour
{
    public EID4922SkyProfile profile;
    public Material environmentMaterial;
    [Min(1f)] public float geometryRadius = 7198f;
    public bool assignRenderSettingsSkybox = true;

    GraphicsBuffer frameBuffer;
    GraphicsBuffer viewBuffer;
    GraphicsBuffer objectBuffer;
    GraphicsBuffer skyBuffer;
    bool subscribed;

    static readonly int Res19 = Shader.PropertyToID("_EID4922Res19");
    static readonly int Res29 = Shader.PropertyToID("_EID4922Res29");
    static readonly int Res27 = Shader.PropertyToID("_EID4922Res27");
    static readonly int Res25 = Shader.PropertyToID("_EID4922Res25");
    static readonly int Res23 = Shader.PropertyToID("_EID4922Res23");
    static readonly int Res21 = Shader.PropertyToID("_EID4922Res21");
    static readonly int Res20 = Shader.PropertyToID("_EID4922Res20");
    static readonly int Res18 = Shader.PropertyToID("_EID4922Res18");
    static readonly int FrameCB = Shader.PropertyToID("EID4922FrameCB");
    static readonly int ViewCB = Shader.PropertyToID("EID4922ViewCB");
    static readonly int ObjectCB = Shader.PropertyToID("EID4922ObjectCB");
    static readonly int SkyCB = Shader.PropertyToID("EID4922SkyCB");
    static readonly int EnvironmentMVP = Shader.PropertyToID("_EID4922EnvironmentMVP");
    static readonly int EnvironmentCameraToWorld = Shader.PropertyToID("_EID4922EnvironmentCameraToWorld");
    static readonly int CameraPositionWS = Shader.PropertyToID("_EID4922RealtimeCameraPositionWS");
    static readonly int SkyRadius = Shader.PropertyToID("_EID4922SkyRadius");
    static readonly int UseRealtime = Shader.PropertyToID("_EID4922UseRealtimeMVP");
    static readonly int ReversedZ = Shader.PropertyToID("_EID4922SceneDepthReversedZ");
    static readonly int MeshRadius = Shader.PropertyToID("_EID4922EnvironmentMeshRadius");

    void OnEnable()
    {
        Subscribe();
        if (assignRenderSettingsSkybox && environmentMaterial != null)
            RenderSettings.skybox = environmentMaterial;
    }

    void OnDisable()
    {
        Unsubscribe();
        DisposeBuffers();
    }

    void OnDestroy() => DisposeBuffers();

    void Subscribe()
    {
        if (subscribed) return;
        RenderPipelineManager.beginCameraRendering += OnBeginCameraRendering;
        subscribed = true;
    }

    void Unsubscribe()
    {
        if (!subscribed) return;
        RenderPipelineManager.beginCameraRendering -= OnBeginCameraRendering;
        subscribed = false;
    }

    static Vector4[] BytesToVectors(byte[] bytes)
    {
        if (bytes == null || bytes.Length == 0 || (bytes.Length & 15) != 0) return null;
        float[] values = new float[bytes.Length / 4];
        Buffer.BlockCopy(bytes, 0, values, 0, bytes.Length);
        Vector4[] vectors = new Vector4[bytes.Length / 16];
        for (int i = 0; i < vectors.Length; ++i)
            vectors[i] = new Vector4(values[i * 4], values[i * 4 + 1], values[i * 4 + 2], values[i * 4 + 3]);
        return vectors;
    }

    static GraphicsBuffer CreateConstant(TextAsset asset, GraphicsBuffer old)
    {
        if (asset == null || asset.bytes == null || asset.bytes.Length == 0) return old;
        if ((asset.bytes.Length & 15) != 0) return old;
        int count = asset.bytes.Length / 16;
        if (count <= 0) return old;
        if (old == null || old.count != count)
        {
            old?.Dispose();
            old = new GraphicsBuffer(GraphicsBuffer.Target.Constant, count, 16);
        }
        old.SetData(BytesToVectors(asset.bytes));
        return old;
    }

    void EnsureBuffers()
    {
        if (profile == null || !profile.useCapturedBuffers) return;
        frameBuffer = CreateConstant(profile.frameUniforms11, frameBuffer);
        viewBuffer = CreateConstant(profile.viewUniforms13, viewBuffer);
        objectBuffer = CreateConstant(profile.objectUniforms15, objectBuffer);
        skyBuffer = CreateConstant(profile.skyUniforms32, skyBuffer);
    }

    void DisposeBuffers()
    {
        frameBuffer?.Dispose();
        viewBuffer?.Dispose();
        objectBuffer?.Dispose();
        skyBuffer?.Dispose();
        frameBuffer = viewBuffer = objectBuffer = skyBuffer = null;
    }

    void OnBeginCameraRendering(ScriptableRenderContext context, Camera camera)
    {
        if (!isActiveAndEnabled || profile == null || environmentMaterial == null || camera == null) return;
        if (camera.cameraType == CameraType.Preview || camera.cameraType == CameraType.Reflection) return;

        EnsureBuffers();
        if (assignRenderSettingsSkybox && RenderSettings.skybox != environmentMaterial)
            RenderSettings.skybox = environmentMaterial;

        bool reversedZ = SystemInfo.usesReversedZBuffer;
        float capturedRadius = Mathf.Max(1f, profile.skyRadius);
        float meshRadius = Mathf.Max(1f, geometryRadius > 0f ? geometryRadius : capturedRadius);
        if (camera.cameraType == CameraType.SceneView && camera.farClipPlane > camera.nearClipPlane)
        {
            float minRadius = Mathf.Max(2f, camera.nearClipPlane * 4f);
            meshRadius = Mathf.Min(meshRadius, Mathf.Max(minRadius, camera.farClipPlane * 0.5f));
        }

        // Build the same camera-relative skybox transform used by URP DrawSkyboxPass.
        // The sky has no translation: only the camera rotation is retained, so the
        // environment stays infinitely far away while remaining live in SceneView/GameView.
        Matrix4x4 rotationOnlyView = camera.worldToCameraMatrix;
        rotationOnlyView.m03 = 0f;
        rotationOnlyView.m13 = 0f;
        rotationOnlyView.m23 = 0f;

        // Match the projection convention used by the modified URP GBuffer and
        // DeferredLights code. This workspace always renders the camera target as
        // a texture, including GameView and SceneView, so the same GPU Y/depth
        // conversion must be used for every camera.
        Matrix4x4 gpuProjection =
            GL.GetGPUProjectionMatrix(camera.projectionMatrix, true);

        Matrix4x4 environmentMVP =
            gpuProjection *
            rotationOnlyView *
            Matrix4x4.Scale(Vector3.one * meshRadius);

        Matrix4x4 cameraToWorldRotation = camera.cameraToWorldMatrix;
        cameraToWorldRotation.m03 = 0f;
        cameraToWorldRotation.m13 = 0f;
        cameraToWorldRotation.m23 = 0f;

        CommandBuffer cmd = CommandBufferPool.Get("EID4922 Environment Skybox Bind");
        try
        {
            if (profile.res19 != null) cmd.SetGlobalTexture(Res19, profile.res19);
            if (profile.res29 != null) cmd.SetGlobalTexture(Res29, profile.res29);
            if (profile.res27 != null) cmd.SetGlobalTexture(Res27, profile.res27);
            if (profile.res25 != null) cmd.SetGlobalTexture(Res25, profile.res25);
            if (profile.res23 != null) cmd.SetGlobalTexture(Res23, profile.res23);
            if (profile.res21 != null) cmd.SetGlobalTexture(Res21, profile.res21);
            if (profile.res20 != null) cmd.SetGlobalTexture(Res20, profile.res20);
            if (profile.res18 != null) cmd.SetGlobalTexture(Res18, profile.res18);

            if (profile.useCapturedBuffers)
            {
                if (frameBuffer != null) cmd.SetGlobalConstantBuffer(frameBuffer, FrameCB, 0, frameBuffer.count * 16);
                if (viewBuffer != null) cmd.SetGlobalConstantBuffer(viewBuffer, ViewCB, 0, viewBuffer.count * 16);
                if (objectBuffer != null) cmd.SetGlobalConstantBuffer(objectBuffer, ObjectCB, 0, objectBuffer.count * 16);
                if (skyBuffer != null) cmd.SetGlobalConstantBuffer(skyBuffer, SkyCB, 0, skyBuffer.count * 16);
            }

            cmd.SetGlobalMatrix(EnvironmentMVP, environmentMVP);
            cmd.SetGlobalMatrix(EnvironmentCameraToWorld, cameraToWorldRotation);
            cmd.SetGlobalVector(CameraPositionWS, camera.transform.position);
            cmd.SetGlobalFloat(SkyRadius, capturedRadius);
            cmd.SetGlobalFloat(MeshRadius, meshRadius);
            cmd.SetGlobalFloat(UseRealtime, 1f);
            cmd.SetGlobalFloat(ReversedZ, reversedZ ? 1f : 0f);

            context.ExecuteCommandBuffer(cmd);
            cmd.Clear();
        }
        finally
        {
            CommandBufferPool.Release(cmd);
        }
    }
}

