using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public sealed class EID4922SkyRendererFeature : ScriptableRendererFeature
{
    // EID4922 is a separate sky/model pass, not deferred-lighting input.
    // Match URP native DrawSkyboxPass timing: render after opaque/deferred scene passes
    // and immediately before the skybox stage, using the camera depth attachment.
    public const int StableSkyPassEventValue = (int)RenderPassEvent.BeforeRenderingSkybox;
    public static RenderPassEvent StableSkyPassEvent => (RenderPassEvent)StableSkyPassEventValue;
    [Serializable]
    public sealed class Settings
    {
        public EID4922SkyProfile profile;
        [Tooltip("Runtime固定在延迟光照之后、Forward/Transparent之前；天空只测试场景深度，不参与延迟光照。")]
        public RenderPassEvent injectionPoint = (RenderPassEvent)StableSkyPassEventValue;
        public bool onlyCameraWithMarker = true;
        public bool renderInSceneView = true;
        public bool renderInGameView = true;
    }

    public Settings settings = new Settings();
    EID4922SkyRenderPass pass;

    public override void Create()
    {
        pass = new EID4922SkyRenderPass(settings);
        settings.injectionPoint = StableSkyPassEvent;
        pass.renderPassEvent = StableSkyPassEvent;
    }

    protected override void Dispose(bool disposing)
    {
        pass?.Dispose();
        pass = null;
    }

    public override void SetupRenderPasses(ScriptableRenderer renderer, in RenderingData renderingData)
    {
        if (pass == null || settings.profile == null) return;
        pass.SetTargets(renderer.cameraColorTargetHandle, renderer.cameraDepthTargetHandle);
    }

    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        if (pass == null || settings.profile == null || settings.profile.skyMaterial == null || settings.profile.skyMesh == null) return;
        // Re-assert every frame because RendererData can contain an old serialized enum value.
        // EID4922 follows the native URP skybox stage, after opaque/deferred depth is complete.
        pass.renderPassEvent = StableSkyPassEvent;
        Camera camera = renderingData.cameraData.camera;
        bool isSceneView = renderingData.cameraData.isSceneViewCamera;
        if (camera.cameraType == CameraType.Preview || camera.cameraType == CameraType.Reflection) return;
        if (isSceneView)
        {
            if (!settings.renderInSceneView) return;
        }
        else
        {
            if (!settings.renderInGameView) return;
            EID4922SkyCamera marker = camera.GetComponent<EID4922SkyCamera>();
            if (settings.onlyCameraWithMarker && (marker == null || !marker.enabledForSky)) return;
        }
        renderer.EnqueuePass(pass);
    }
}

public sealed class EID4922SkyRenderPass : ScriptableRenderPass
{
    readonly EID4922SkyRendererFeature.Settings settings;
    RTHandle colorTarget;
    RTHandle depthTarget;
    GraphicsBuffer frameBuffer, viewBuffer, objectBuffer, skyBuffer;
    Material runtimeMaterial;
    Material sourceMaterial;
    MaterialPropertyBlock skyProperties;
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
    static readonly int RealtimeMVP = Shader.PropertyToID("_EID4922RealtimeMVP");
    static readonly int RealtimeCameraPositionWS = Shader.PropertyToID("_EID4922RealtimeCameraPositionWS");
    static readonly int SkyRadius = Shader.PropertyToID("_EID4922SkyRadius");
    static readonly int UseRealtimeMVP = Shader.PropertyToID("_EID4922UseRealtimeMVP");
    static bool loggedDepthConvention;
    static readonly HashSet<int> loggedCoverageCameras = new HashSet<int>();
    static readonly int DepthMode = Shader.PropertyToID("_EID4922DepthMode");
    static readonly int ZTestMode = Shader.PropertyToID("_EID4922ZTest");
    static readonly int SceneDepthAvailable = Shader.PropertyToID("_EID4922SceneDepthAvailable");

    public EID4922SkyRenderPass(EID4922SkyRendererFeature.Settings settings)
    {
        this.settings = settings;
        // Request URP's canonical CameraDepthTexture for both GameView and SceneView.
        // Without this input declaration, SceneView may not allocate/copy a sampleable
        // depth texture; the pass would then sample a stale/empty global published only
        // opportunistically by the custom deferred-light pass.
        ConfigureInput(ScriptableRenderPassInput.Depth);
    }
    public void SetTargets(RTHandle color, RTHandle depth) { colorTarget = color; depthTarget = depth; }

    public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
    {
        // Use the same path for GameView and SceneView. ConfigureInput(Depth) above
        // makes URP build/bind its canonical _CameraDepthTexture for the active camera.
        // The sampled copy and the hardware depth attachment are separate URP resources;
        // keep the latter bound as a second guard, exactly like
        // DrawSkyboxPass. The fragment shader also compares the canonical depth copy;
        // both views therefore use the same color/depth ordering instead of a SceneView
        // only hardware path or a GameView only texture path.
        if (colorTarget != null)
        {
            if (depthTarget != null) ConfigureTarget(colorTarget, depthTarget);
            else ConfigureTarget(colorTarget);
        }
        ConfigureClear(ClearFlag.None, Color.clear);
        EnsureBuffers(settings.profile);
    }

    static Vector4[] BytesToVectors(byte[] bytes)
    {
        if (bytes == null || bytes.Length == 0 || (bytes.Length & 15) != 0) return null;
        float[] values = new float[bytes.Length / 4];
        Buffer.BlockCopy(bytes, 0, values, 0, bytes.Length);
        Vector4[] result = new Vector4[bytes.Length / 16];
        for (int i = 0; i < result.Length; i++) result[i] = new Vector4(values[i * 4], values[i * 4 + 1], values[i * 4 + 2], values[i * 4 + 3]);
        return result;
    }

    static GraphicsBuffer CreateConstant(TextAsset asset, GraphicsBuffer old)
    {
        if (asset == null || asset.bytes == null || asset.bytes.Length == 0) return old;
        int count = asset.bytes.Length / 16;
        if (count <= 0 || asset.bytes.Length % 16 != 0) return old;
        if (old == null || old.count != count)
        {
            old?.Dispose();
            old = new GraphicsBuffer(GraphicsBuffer.Target.Constant, count, 16);
        }
        old.SetData(BytesToVectors(asset.bytes));
        return old;
    }

    void EnsureBuffers(EID4922SkyProfile p)
    {
        if (!p.useCapturedBuffers) return;
        frameBuffer = CreateConstant(p.frameUniforms11, frameBuffer);
        viewBuffer = CreateConstant(p.viewUniforms13, viewBuffer);
        objectBuffer = CreateConstant(p.objectUniforms15, objectBuffer);
        skyBuffer = CreateConstant(p.skyUniforms32, skyBuffer);
    }

    void EnsureRuntimeMaterial(EID4922SkyProfile p)
    {
        if (p == null || p.skyMaterial == null) return;
        if (runtimeMaterial != null && sourceMaterial == p.skyMaterial) return;
        if (runtimeMaterial != null)
        {
            if (Application.isPlaying) UnityEngine.Object.Destroy(runtimeMaterial);
            else UnityEngine.Object.DestroyImmediate(runtimeMaterial);
        }
        sourceMaterial = p.skyMaterial;
        runtimeMaterial = new Material(sourceMaterial)
        {
            name = "EID4922SkyRuntimeMaterial",
            hideFlags = HideFlags.HideAndDontSave
        };
    }

    public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
    {
        EID4922SkyProfile p = settings.profile;
        if (p == null || p.skyMesh == null || p.skyMaterial == null || colorTarget == null) return;
        EnsureRuntimeMaterial(p);
        if (runtimeMaterial == null) return;
        // The depth convention must match the active graphics API. The shader reads the
        // current camera's canonical _CameraDepthTexture and the pass uses the matching
        // hardware compare used by a native URP skybox: GreaterEqual for reversed-Z,
        // LessEqual otherwise. GameView and SceneView therefore use the same two guards.
        runtimeMaterial.SetFloat("_EID4922Cull", 0f);
        if (!loggedDepthConvention)
        {
            loggedDepthConvention = true;
            Debug.Log("[EID4922] depth-safe sky dual-pass mode; usesReversedZBuffer=" + SystemInfo.usesReversedZBuffer);
        }
        CommandBuffer cmd = CommandBufferPool.Get("EID4922 RenderDoc Sky");
        try
        {
            if (p.res19 != null) cmd.SetGlobalTexture(Res19, p.res19);
            if (p.res29 != null) cmd.SetGlobalTexture(Res29, p.res29);
            if (p.res27 != null) cmd.SetGlobalTexture(Res27, p.res27);
            if (p.res25 != null) cmd.SetGlobalTexture(Res25, p.res25);
            if (p.res23 != null) cmd.SetGlobalTexture(Res23, p.res23);
            if (p.res21 != null) cmd.SetGlobalTexture(Res21, p.res21);
            if (p.res20 != null) cmd.SetGlobalTexture(Res20, p.res20);
            if (p.res18 != null) cmd.SetGlobalTexture(Res18, p.res18);
            if (p.useCapturedBuffers)
            {
                if (frameBuffer != null) cmd.SetGlobalConstantBuffer(frameBuffer, FrameCB, 0, frameBuffer.count * 16);
                if (viewBuffer != null) cmd.SetGlobalConstantBuffer(viewBuffer, ViewCB, 0, viewBuffer.count * 16);
                if (objectBuffer != null) cmd.SetGlobalConstantBuffer(objectBuffer, ObjectCB, 0, objectBuffer.count * 16);
                if (skyBuffer != null) cmd.SetGlobalConstantBuffer(skyBuffer, SkyCB, 0, skyBuffer.count * 16);
            }

            Camera camera = renderingData.cameraData.camera;
            float radius = Mathf.Max(1f, p.skyRadius);
            // Keep the RenderDoc atmospheric sampling radius unchanged, but use a
            // smaller enclosing geometry radius for SceneView when its editor camera
            // has a short far clip. This prevents the unit sphere from being clipped
            // while preserving the captured world-space direction/ray calculations.
            float meshRadius = radius;
            if (renderingData.cameraData.isSceneViewCamera && camera != null && camera.farClipPlane > camera.nearClipPlane)
            {
                float minMeshRadius = Mathf.Max(2f, camera.nearClipPlane * 4f);
                float maxMeshRadius = Mathf.Max(minMeshRadius, camera.farClipPlane * 0.5f);
                meshRadius = Mathf.Min(radius, maxMeshRadius);
            }
            if (camera != null && loggedCoverageCameras.Add(camera.GetInstanceID()))
            {
                Debug.Log($"[EID4922] coverage camera={camera.name}, sceneView={renderingData.cameraData.isSceneViewCamera}, skyRadius={radius}, meshRadius={meshRadius}, near={camera.nearClipPlane}, far={camera.farClipPlane}, target={renderingData.cameraData.cameraTargetDescriptor.width}x{renderingData.cameraData.cameraTargetDescriptor.height}");
            }
            if (p.useRealtimeCameraMatrices && camera != null)
            {
                // A sky sphere follows camera translation but keeps world-space orientation.
                // Removing view translation prevents parallax while preserving live SceneView/GameView rotation.
                Matrix4x4 rotationOnlyView = camera.worldToCameraMatrix;
                rotationOnlyView.m03 = 0f;
                rotationOnlyView.m13 = 0f;
                rotationOnlyView.m23 = 0f;
                Matrix4x4 gpuProjection = renderingData.cameraData.GetGPUProjectionMatrix();
                Matrix4x4 realtimeMVP = gpuProjection * rotationOnlyView * Matrix4x4.Scale(Vector3.one * meshRadius);
                cmd.SetGlobalMatrix(RealtimeMVP, realtimeMVP);
                cmd.SetGlobalVector(RealtimeCameraPositionWS, camera.transform.position);
                cmd.SetGlobalFloat(SkyRadius, radius);
                cmd.SetGlobalFloat(UseRealtimeMVP, 1f);
            }
            else
            {
                cmd.SetGlobalFloat(UseRealtimeMVP, 0f);
                cmd.SetGlobalFloat(SkyRadius, radius);
            }

            // The native URP pass does not clear the color target in Execute().
            // This pass follows the same load-preserving behavior. The hardware depth
            // test and the sampled-depth mask are both identical between the two views.

            // Use one standalone sky draw.
            bool reversedZ = SystemInfo.usesReversedZBuffer;
            // Match the deferred light pass through URP's canonical depth texture;
            // the hardware depth test above is the native URP ordering guard and this
            // explicit compare protects the same pixels when the copy is sampled.
            cmd.SetGlobalFloat(SceneDepthAvailable, 1f);
            runtimeMaterial.SetFloat(ZTestMode, (float)(reversedZ ? CompareFunction.GreaterEqual : CompareFunction.LessEqual));
            if (skyProperties == null) skyProperties = new MaterialPropertyBlock();
            skyProperties.Clear();
            skyProperties.SetFloat(DepthMode, reversedZ ? 0f : 1f);
            cmd.DrawMesh(p.skyMesh, Matrix4x4.identity, runtimeMaterial, 0, 0, skyProperties);
            context.ExecuteCommandBuffer(cmd);
        }
        finally { CommandBufferPool.Release(cmd); }
    }

    public void Dispose()
    {
        frameBuffer?.Dispose(); viewBuffer?.Dispose(); objectBuffer?.Dispose(); skyBuffer?.Dispose();
        frameBuffer = viewBuffer = objectBuffer = skyBuffer = null;
        if (runtimeMaterial != null)
        {
            if (Application.isPlaying) UnityEngine.Object.Destroy(runtimeMaterial);
            else UnityEngine.Object.DestroyImmediate(runtimeMaterial);
            runtimeMaterial = null;
            sourceMaterial = null;
        }
    }
}







