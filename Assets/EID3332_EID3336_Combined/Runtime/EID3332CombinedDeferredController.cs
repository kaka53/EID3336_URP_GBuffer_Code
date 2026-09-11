using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
#if UNITY_EDITOR
using UnityEditor;
#endif

[ExecuteAlways]
public sealed class EID3332CombinedDeferredController : MonoBehaviour, IEID3336URPGBufferProvider, IEID3336URPDeferredLightingProvider
{
    public enum ProjectionSource { RenderDocCaptured = 0, CurrentUnityCamera = 1 }
    public enum B6ViewMode { FinalLighting = 0, DirectLighting = 1, IndirectDiffuse = 2, IndirectSpecular = 3, CapturedLighting = 4, BRDF = 5, BaseColor = 6, NormalWS = 7, WorldPosition = 8, Material = 9, LinearDepth = 10, ProbeReflection = 11, ScreenSpecular = 12, CombinedIndirect = 13, ProbeWeight = 14, ReflectionValidity = 15, GBuffer0 = 16, GBuffer1 = 17, GBuffer2 = 18, GBuffer3 = 19 }

    [Header("Combined scene")]
    public Camera targetCamera;
    public Transform eid3315Root;
    public Transform eid3332Root;
    public Transform eid3336Root;
    public Material gbufferMaterial;
    [Tooltip("Authoritative shared VS/PS MRT writer. Used for MRT0-MRT4 pass only.")]
    public EID3332CombinedSceneMRTController sharedMrtController;
    public EID3332CombinedDeferredTargets targets;
    public Material cameraCompositeMaterial;
    public bool normalDeferredDisplay = true;
    public bool renderInSceneView = true;
    public bool autoSizeTargetsToCamera = true;
    [Range(.25f, 2f)] public float renderScale = 1f;

    [Header("URP GBuffer integration (isolated workspace)")]
    [Tooltip("RenderDoc EID3336 adapter material used by the embedded URP GBufferPass. It is separate from the legacy five-MRT material.")]
    public Material urpGBufferMaterial;
    [Tooltip("Stage-1 keeps URP GBuffer3 empty; captured lighting is not adapted until the lighting stage.")]
    public bool urpGBufferWriteCapturedLighting;
    [Tooltip("Capture the live URP GBuffer attachments after the provider draw for validation only.")]
    public bool captureURPGBufferForValidation;
    [Tooltip("Route B uses the standard MeshRenderer/UniversalGBuffer path for the current Unity camera when the source five-MRT path is disabled.")]
    public bool useRouteBMeshRendererForCurrentCamera;
    [Tooltip("Use the modified URP GBufferPass to emit RenderDoc RT0-RT4 and reserve attachment 5 for lighting.")]
    public bool useURPFiveMRT = true;
    [NonSerialized] public RenderTexture[] lastURPGBufferCapture;

    [Header("Shared B6 deferred lighting")]
    public bool enableB6Lighting = true;
    public Material b6LightingMaterial;
    [Tooltip("When enabled, adjustable lighting/profile values come from the B6 material inspector. The pipeline only supplies live GBuffer, depth, camera, screen and ComputeBuffer data.")]
    public bool b6MaterialOwnsTuningParameters = true;

    [Header("Legacy controller overrides (used only when material ownership is disabled)")]
    public B6ViewMode b6ViewMode = B6ViewMode.FinalLighting;
    [Range(0f, 4f)] public float b6IndirectDiffuseStrength = 1f;
    [Range(0f, 4f)] public float b6IndirectSpecularStrength = 1f;
    public bool b6UseCapturedIndirectOptions = true;
    public bool b6UseCapturedProbeData = true;
    public Texture2D b6ScreenSH;
    public Texture2D b6ScreenSpecularColor;
    public Texture2D b6ScreenSpecularWeight;
    public Texture2D b6ReflectionValidity;
    public Texture2D b6ReflectionVisibility;
    public Texture2D b6SSAO;
    public Texture2DArray b6ReflectionAtlas;
    [Range(0f, 1f)] public float b6ScreenSHWeight = 0f; // 0=保留screen_sh_b5，1=移除screen_sh_b5
    [Range(0f, 1f)] public float b6ScreenSpecularContributionWeight = 1f;
    [Range(0f, 1f)] public float b6ProbeReflectionWeight = 1f;
    [Range(0f, 1f)] public float b6CapturedVisibilityWeight = 1f;

    [Header("Camera/coordinates")]
    public ProjectionSource projectionSource = ProjectionSource.CurrentUnityCamera;
    [Tooltip("Use the exact per-event raw vertex/index streams for CurrentUnityCamera. The imported FBX is used only as a transform/visibility source. This keeps UV, packed normal/tangent/color and triangle order identical to RenderDoc.")]
    public bool useRawStreamsForCurrentCamera = true;
    [Tooltip("For raw CurrentUnityCamera geometry, start from the captured per-draw instance matrices and apply each Unity model node Transform as a live delta. This preserves initial parity while allowing real-time movement, rotation and scale.")]
    public bool useCapturedInstanceTransformsForRawCurrent = true;
    public bool reconstructionFlipY = true;
    public bool b6FlipY = true;
    public float worldPositionRange = 1024f;
    public float depthDisplayFar = 1000f;
    public Vector3 lightDirectionWS = new Vector3(.35f, .8f, .25f);
    public Color lightColor = Color.white;
    public float lightIntensity = 2.5f;
    public float ambientStrength = .12f;
    public float specularStrength = .7f;

    [NonSerialized] public Matrix4x4 capturedView = Matrix4x4.identity;
    [NonSerialized] public Matrix4x4 capturedProjection = Matrix4x4.identity;
    [NonSerialized] public Matrix4x4 capturedViewProjection = Matrix4x4.identity;
    [NonSerialized] public bool capturedMatricesLoaded;

    [NonSerialized] public RenderTexture liveSceneViewFinalTexture;
    [NonSerialized] public RenderTexture liveGameFinalTexture;
    [NonSerialized] public Renderer[] renderers = Array.Empty<Renderer>();
    readonly Dictionary<Renderer, int> profileByRenderer = new Dictionary<Renderer, int>();
    readonly Dictionary<Renderer, int> rendererIndex = new Dictionary<Renderer, int>();
    readonly Dictionary<int, Material> runtimeB6Materials = new Dictionary<int, Material>();
    ComputeBuffer reflectionProbeBuffer;
    ComputeBuffer clusterMaskBuffer;
    Material runtimeB6Material;

    const string CapturedRoot = "Assets/EID3336_URP_Reconstruction/DeferredLightingReadable/CapturedResources";
    string ProjectFile(string assetPath) => Path.Combine(Directory.GetParent(Application.dataPath).FullName, assetPath.Replace('/', Path.DirectorySeparatorChar));

    void OnEnable() { RefreshRenderers(); LoadB6Assets(); LoadCapturedMatrices(); EID3336LightingParameters.Register(this); EID3336URPGBufferProviderRegistry.Register(this); }
    void OnDisable() { EID3336URPGBufferProviderRegistry.Unregister(this); EID3336LightingParameters.Unregister(this); ReleaseB6Buffers(); }
    void OnDestroy() { EID3336URPGBufferProviderRegistry.Unregister(this); EID3336LightingParameters.Unregister(this); ReleaseB6Buffers(); }
    void OnValidate() { if (isActiveAndEnabled) RefreshRenderers(); }

    public bool UsesRouteBMeshForCamera(Camera camera)
    {
        return useRouteBMeshRendererForCurrentCamera && camera != null && !UseCapturedProjection(camera);
    }

    public bool UseEID3336FiveMRT(Camera camera)
    {
        // This is intentionally independent of RendererFeature execution.
        // UniversalRenderer queries it before allocating GBuffer resources.
        return useURPFiveMRT && IsForCamera(camera) && sharedMrtController != null;
    }

    public bool IsForCamera(Camera camera)
    {
        if (!isActiveAndEnabled || camera == null) return false;
        return camera == targetCamera || (renderInSceneView && camera.cameraType == CameraType.SceneView);
    }

    public bool UseCapturedProjection(Camera camera)
    {
        // Capture mode is deliberately bound to the game/reconstruction camera only.
        // SceneView always uses its current matrix for interactive inspection.
        return camera == targetCamera && projectionSource == ProjectionSource.RenderDocCaptured && capturedMatricesLoaded;
    }

    public Matrix4x4 GetViewProjection(Camera camera)
    {
        if (!capturedMatricesLoaded) LoadCapturedMatrices();
        if (UseCapturedProjection(camera)) return capturedViewProjection;
        return camera == null ? Matrix4x4.identity : GL.GetGPUProjectionMatrix(camera.projectionMatrix, true) * camera.worldToCameraMatrix;
    }

    public Matrix4x4 GetWorldToView(Camera camera)
    {
        if (UseCapturedProjection(camera)) return capturedView.transpose;
        return camera == null ? Matrix4x4.identity : camera.worldToCameraMatrix;
    }

    public Vector3 GetCameraPosition(Camera camera)
    {
        return GetWorldToView(camera).inverse.GetColumn(3);
    }
    public Material GetActiveDeferredLightingMaterial()
    {
        return GetActiveDeferredLightingMaterial(targetCamera);
    }

    public Material GetActiveDeferredLightingMaterial(Camera camera)
    {
        if (!enableB6Lighting) return null;
        EnsureB6Material();
        if (b6LightingMaterial == null || b6LightingMaterial.shader == null) return null;

        // The serialized material is the tuning source only. RTs, depth, matrices
        // and camera-dependent buffers belong to a per-camera runtime instance.
        int key = camera != null ? camera.GetInstanceID() : 0;
        if (!runtimeB6Materials.TryGetValue(key, out Material material) || material == null ||
            material.shader != b6LightingMaterial.shader)
        {
            DestroyRuntimeB6Material(material);
            material = new Material(b6LightingMaterial)
            {
                name = "EID3332Combined B6 Runtime [" + (camera != null ? camera.name : "default") + "]",
                hideFlags = HideFlags.HideAndDontSave
            };
            runtimeB6Materials[key] = material;
        }
        else
        {
            // Pick up only inspector tuning changes. CopyPropertiesFromMaterial
            // is intentionally avoided here because it also copies the previous
            // camera's live RTs, depth, matrices and structured buffers.
            SyncB6TuningProperties(b6LightingMaterial, material);
        }
        return material;
    }

    static void SyncB6TuningProperties(Material source, Material target)
    {
        if (source == null || target == null) return;

        string[] floatProperties =
        {
            "_EID3336B6ViewMode",
            "_EID3336B6ScreenSHWeight",
            "_EID3336B6ScreenSpecularContributionWeight",
            "_EID3336B6ProbeReflectionWeight",
            "_EID3336B6CapturedVisibilityWeight",
            "_EID3336B6WorldDisplayRange",
            "_EID3336B6DepthDisplayFar",
            "_EID3336B6ReconstructionFlipY",
            "_EID3336B6FlipY",
            "_EID3336B6LightIntensity",
            "_EID3336B6AmbientStrength",
            "_EID3336B6DiffuseStrength",
            "_EID3336B6SpecularStrength",
            "_EID3336B6IndirectDiffuseStrength",
            "_EID3336B6IndirectSpecularStrength"
        };
        foreach (string property in floatProperties)
            if (source.HasProperty(property) && target.HasProperty(property))
                target.SetFloat(property, source.GetFloat(property));

        if (source.HasProperty("_EID3336B6LightDirectionWS") && target.HasProperty("_EID3336B6LightDirectionWS"))
            target.SetVector("_EID3336B6LightDirectionWS", source.GetVector("_EID3336B6LightDirectionWS"));
        if (source.HasProperty("_EID3336B6LightColor") && target.HasProperty("_EID3336B6LightColor"))
            target.SetColor("_EID3336B6LightColor", source.GetColor("_EID3336B6LightColor"));
    }

    void DestroyRuntimeB6Material(Material material)
    {
        if (material == null) return;
        if (Application.isPlaying) Destroy(material); else DestroyImmediate(material);
    }
    void EnsureB6Material()
    {
        if (b6LightingMaterial != null) return;
        Shader s = Shader.Find("Hidden/EID3332Combined/Deferred/B6CapturedIndirect");
        if (s != null) b6LightingMaterial = runtimeB6Material = new Material(s) { name = "EID3332Combined B6 Runtime", hideFlags = HideFlags.HideAndDontSave };
    }

    public void RefreshRenderers()
    {
        var list = new List<Renderer>();
        profileByRenderer.Clear(); rendererIndex.Clear();
        if (eid3315Root != null) foreach (var r in eid3315Root.GetComponentsInChildren<Renderer>(true)) { if (r != null && !list.Contains(r)) { rendererIndex[r] = list.Count; profileByRenderer[r] = 3315; list.Add(r); } }
        if (eid3332Root != null) foreach (var r in eid3332Root.GetComponentsInChildren<Renderer>(true)) { if (r != null && !list.Contains(r)) { rendererIndex[r] = list.Count; profileByRenderer[r] = 3332; list.Add(r); } }
        if (eid3336Root != null) foreach (var r in eid3336Root.GetComponentsInChildren<Renderer>(true)) { if (r != null && !list.Contains(r)) { rendererIndex[r] = list.Count; profileByRenderer[r] = 3336; list.Add(r); } }
        renderers = list.ToArray();
    }

    public Bounds GetModelBounds()
    {
        Bounds b = new Bounds(targetCamera != null ? targetCamera.transform.position : Vector3.zero, Vector3.one);
        bool has = false;
        foreach (var r in renderers) if (r != null) { if (!has) { b = r.bounds; has = true; } else b.Encapsulate(r.bounds); }
        return b;
    }

    /// <summary>
    /// Called by the embedded URP 14.0.12 GBufferPass after stock
    /// UniversalGBuffer draws and before CopyDepth/DeferredPass.
    /// </summary>
    public bool RecordEID3336GBuffer(
        ScriptableRenderContext context,
        ref RenderingData renderingData,
        RTHandle[] gbufferAttachments,
        RTHandle depthAttachment)
    {
        Camera camera = renderingData.cameraData.camera;
        bool fiveMrt = UseEID3336FiveMRT(camera);
        if (!isActiveAndEnabled || !fiveMrt || !captureURPGBufferForValidation ||
            gbufferAttachments == null || gbufferAttachments.Length < 6 ||
            depthAttachment == null)
            return false;

        // The current URP GBufferPass has already rendered the ordinary
        // UniversalGBuffer materials. This callback is deliberately a
        // validation-only readback bridge; it must not redraw the old custom
        // five-MRT path on top of the current URP attachments.
        CommandBuffer cmd = CommandBufferPool.Get("EID3336 URP GBuffer validation readback");
        try
        {
            CaptureURPGBufferAttachments(cmd, gbufferAttachments, 5);

            context.ExecuteCommandBuffer(cmd);
            Debug.Log("[EID3336 URP GBuffer] validation readback copied RT0-RT4 after UniversalGBuffer DrawRenderers.");
            return true;
        }
        finally
        {
            CommandBufferPool.Release(cmd);
        }
    }

    void CaptureURPGBufferAttachments(CommandBuffer cmd, RTHandle[] attachments, int count)
    {
        if (cmd == null || attachments == null || count <= 0 || attachments.Length < count)
            return;

        if (lastURPGBufferCapture == null || lastURPGBufferCapture.Length != count)
        {
            if (lastURPGBufferCapture != null)
                for (int i = 0; i < lastURPGBufferCapture.Length; ++i)
                    if (lastURPGBufferCapture[i] != null) DestroyImmediate(lastURPGBufferCapture[i]);
            lastURPGBufferCapture = new RenderTexture[count];
        }

        for (int i = 0; i < count; ++i)
        {
            RenderTexture source = attachments[i] != null ? attachments[i].rt : null;
            Debug.Log($"[RouteB GBuffer Capture] slot={i} handle={(attachments[i] != null ? attachments[i].name : "null")} source={(source != null ? source.name : "null")} format={(source != null ? source.graphicsFormat.ToString() : "none")} size={(source != null ? source.width + "x" + source.height : "0x0")}");
            if (source == null)
                continue;

            RenderTexture destination = lastURPGBufferCapture[i];
            if (destination == null || destination.width != source.width || destination.height != source.height || destination.graphicsFormat != source.graphicsFormat)
            {
                if (destination != null) DestroyImmediate(destination);
                RenderTextureDescriptor descriptor = source.descriptor;
                descriptor.depthBufferBits = 0;
                descriptor.msaaSamples = 1;
                descriptor.useMipMap = false;
                descriptor.autoGenerateMips = false;
                descriptor.bindMS = false;
                destination = new RenderTexture(descriptor)
                {
                    name = "EID3336_URP_GBuffer_Validation_" + i,
                    hideFlags = HideFlags.DontSave
                };
                destination.Create();
                lastURPGBufferCapture[i] = destination;
            }

            cmd.CopyTexture(attachments[i].nameID, destination);
        }
    }

    public void ReleaseURPGBufferValidationCapture()
    {
        if (lastURPGBufferCapture == null)
            return;
        for (int i = 0; i < lastURPGBufferCapture.Length; ++i)
        {
            if (lastURPGBufferCapture[i] != null)
                DestroyImmediate(lastURPGBufferCapture[i]);
            lastURPGBufferCapture[i] = null;
        }
        lastURPGBufferCapture = null;
    }

    public bool RecordGeometry(CommandBuffer cmd, Camera camera, int cameraWidth, int cameraHeight)
    {
        if (cmd == null || camera == null || targets == null) return false;
        bool captured = UseCapturedProjection(camera);
        int width = captured ? 1366 : cameraWidth;
        int height = captured ? 768 : cameraHeight;
        if (autoSizeTargetsToCamera && !captured)
        {
            width = Mathf.Max(1, Mathf.RoundToInt(cameraWidth * renderScale));
            height = Mathf.Max(1, Mathf.RoundToInt(cameraHeight * renderScale));
        }
        targets.Ensure(width, height);
        RefreshRenderers();
        var colors = new RenderTargetIdentifier[5];
        for (int i = 0; i < 5; ++i) colors[i] = new RenderTargetIdentifier(targets.GetColor(i));
        cmd.SetRenderTarget(colors, new RenderTargetIdentifier(targets.Depth));
        cmd.ClearRenderTarget(true, true, Color.clear, 1f);

        // Authoritative pass: both Draw Profiles write the SAME MRT/depth set in
        // RenderDoc order (3332 then 3336), through the shared recovered VS/PS.
        if (sharedMrtController != null && sharedMrtController.sharedMrtMaterial != null)
        {
            if (captured) sharedMrtController.DrawCapturedRawMRT(cmd);
            else sharedMrtController.DrawCurrentCameraMRT(cmd, GetViewProjection(camera), useRawStreamsForCurrentCamera, useCapturedInstanceTransformsForRawCurrent);
        }
        else
            DrawFallback(cmd, 0, camera);
        cmd.SetRenderTarget(new RenderTargetIdentifier(targets.Coverage), new RenderTargetIdentifier(targets.Depth));
        cmd.ClearRenderTarget(false, false, Color.clear, 1f);
        DrawFallback(cmd, 1, camera);
        cmd.SetRenderTarget(new RenderTargetIdentifier(targets.DepthDebug), new RenderTargetIdentifier(targets.Depth));
        cmd.ClearRenderTarget(false, true, Color.clear, 1f);
        DrawFallback(cmd, 2, camera);
        var refs = new[] { new RenderTargetIdentifier(targets.ActualWorldPosition), new RenderTargetIdentifier(targets.ActualNormal) };
        cmd.SetRenderTarget(refs, new RenderTargetIdentifier(targets.Depth));
        cmd.ClearRenderTarget(false, true, Color.clear, 1f);
        DrawFallback(cmd, 3, camera);
        return true;
    }

    void DrawFallback(CommandBuffer cmd, int pass, Camera camera)
    {
        if (gbufferMaterial == null || gbufferMaterial.shader == null || !gbufferMaterial.shader.isSupported || pass < 0 || pass >= gbufferMaterial.passCount) return;
        gbufferMaterial.SetMatrix("_EID3336BViewProjection", GetViewProjection(camera));
        gbufferMaterial.SetMatrix("_EID3336BCorrection", Matrix4x4.identity);
        int width = targets != null ? targets.width : 1;
        int height = targets != null ? targets.height : 1;
        gbufferMaterial.SetVector("_EID3336BScreenSize", new Vector4(width, height, 1f / width, 1f / height));
        for (int i = 0; i < renderers.Length; ++i)
        {
            var r = renderers[i];
            if (r == null || !r.enabled || !r.gameObject.activeInHierarchy) continue;
            int profile = profileByRenderer.TryGetValue(r, out int p) ? p : 3336;
            Color color = profile == 3315 ? new Color(.40f, .78f, .32f, 1f) : (profile == 3332 ? new Color(.18f, .55f, .95f, 1f) : new Color(.72f, .78f, .84f, 1f));
            gbufferMaterial.SetColor("_EID3336BRendererColor", color);
            gbufferMaterial.SetColor("_EID3336BBaseColor", color);
            gbufferMaterial.SetColor("_EID3336BEmission", Color.black);
            gbufferMaterial.SetFloat("_EID3336BRendererIndex", i);
            gbufferMaterial.SetFloat("_EID3336BMetallic", 0f);
            gbufferMaterial.SetFloat("_EID3336BRoughness", .65f);
            gbufferMaterial.SetFloat("_EID3336BAO", 1f);
            gbufferMaterial.SetFloat("_EID3336BMaterialId", profile);
            gbufferMaterial.SetFloat("_EID3336BUseVisibilityMask", 0f);
            int submeshes = r is SkinnedMeshRenderer sk && sk.sharedMesh != null ? sk.sharedMesh.subMeshCount : (r.GetComponent<MeshFilter>()?.sharedMesh?.subMeshCount ?? 1);
            for (int sm = 0; sm < Mathf.Max(1, submeshes); ++sm) cmd.DrawRenderer(r, gbufferMaterial, sm, pass);
        }
    }

    public void BindDeferredLighting(Camera camera)
    {
        int outputWidth = camera != null && camera.targetTexture != null ? camera.targetTexture.width : (camera != null ? Mathf.Max(1, camera.pixelWidth) : (targets != null ? targets.width : 1));
        int outputHeight = camera != null && camera.targetTexture != null ? camera.targetTexture.height : (camera != null ? Mathf.Max(1, camera.pixelHeight) : (targets != null ? targets.height : 1));
        BindDeferredLighting(camera, outputWidth, outputHeight);
    }

    public bool TryPrepareEID3336Lighting(Camera camera, out Material material)
    {
        material = null;
        if (!IsForCamera(camera) || !enableB6Lighting) return false;
        material = GetActiveDeferredLightingMaterial(camera);
        if (material == null) return false;
        BindCapturedLightingInputsToMaterial(material);
        if (!b6MaterialOwnsTuningParameters) ApplyControllerB6TuningToMaterial(material);
        return true;
    }

    // Log once per camera/layout, not every repaint (SceneView renders continuously).
    readonly System.Collections.Generic.Dictionary<int, string> deferredInputContracts =
        new System.Collections.Generic.Dictionary<int, string>();

    void LogDeferredInputContract(Camera camera, bool sourceFiveMrt, Material material)
    {
        if (camera == null || material == null) return;
        string contract = "fiveMrt=" + sourceFiveMrt +
            " Material=" + material.GetFloat("_EID3336B6MaterialTarget") +
            " Normal=" + material.GetFloat("_EID3336B6NormalTarget") +
            " BaseColor=" + material.GetFloat("_EID3336B6BaseColorTarget") +
            " RT3=" + material.GetTexture("_EID3336B6RT3")?.name +
            " RT4=" + material.GetTexture("_EID3336B6RT4")?.name;
        int id = camera.GetInstanceID();
        if (deferredInputContracts.TryGetValue(id, out string previous) && previous == contract)
            return;
        deferredInputContracts[id] = contract;
        Debug.Log("[EID3336 B6 Input Contract] camera=" + camera.name + " " + contract, this);
    }

    void BindDeferredLightingFromURPGBuffer(
        Camera camera,
        RTHandle[] gbufferAttachments,
        RTHandle depthAttachment,
        RTHandle depthCopyTexture,
        int outputWidth,
        int outputHeight,
        bool sourceFiveMrt,
        Material material)
    {
        if (material == null || camera == null || gbufferAttachments == null ||
            gbufferAttachments.Length < 3 || depthAttachment == null)
            return;

        // Live pipeline-owned resources. These must be refreshed for every camera.
        // In source five-MRT mode these are exactly RenderDoc RT0..RT4;
        // in compatibility mode they are the standard URP four-target inputs.
        // Captured indirect-light textures and immutable RenderDoc constants are
        // also rebound here every frame. Scalar tuning values (weights, view mode,
        // direct-light controls) remain material-owned when b6MaterialOwnsTuningParameters
        // is enabled.
        BindCapturedLightingInputsToMaterial(material);
        material.SetTexture("_EID3336B6RT0", gbufferAttachments[0].rt);
        material.SetTexture("_EID3336B6RT1", gbufferAttachments[1].rt);
        material.SetTexture("_EID3336B6RT2", gbufferAttachments[2].rt);
        if (sourceFiveMrt)
        {
            material.SetTexture("_EID3336B6RT3", gbufferAttachments[3].rt);
            material.SetTexture("_EID3336B6RT4", gbufferAttachments[4].rt);
        }
        else
        {
            material.SetTexture("_EID3336B6RT3", Texture2D.blackTexture);
            material.SetTexture("_EID3336B6RT4", Texture2D.blackTexture);
        }
        // The source-level B6 shader expects the same sampled depth image as the
        // copy-depth stage. The native depth-stencil attachment is not a
        // shader-readable SRV on D3D11 and can silently return zero/stale data.
        RenderTexture depthSource = depthCopyTexture != null ? depthCopyTexture.rt : null;
        if (depthSource == null && depthAttachment != null)
            depthSource = depthAttachment.rt;
        material.SetTexture("_EID3336B6Depth", depthSource);

        Matrix4x4 vp = GetViewProjection(camera);
        material.SetMatrix("_EID3336B6ClipToWorld", vp.inverse);
        material.SetMatrix("_EID3336B6WorldToView", GetWorldToView(camera));
        material.SetVector("_EID3336B6CameraPositionWS", GetCameraPosition(camera));
        outputWidth = Mathf.Max(1, outputWidth);
        outputHeight = Mathf.Max(1, outputHeight);
        material.SetVector("_EID3336B6ScreenSize", new Vector4(outputWidth, outputHeight, 1f / outputWidth, 1f / outputHeight));
        material.SetVector("_EID3336B6OutputSize", new Vector4(outputWidth, outputHeight, 1f / outputWidth, 1f / outputHeight));

        // The source five-MRT contract is a runtime routing decision, not a
        // material default. Always set the decoder targets here so a material
        // serialized for the legacy URP contract cannot silently remap RTs.
        if (!b6MaterialOwnsTuningParameters)
            ApplyControllerB6TuningToMaterial(material);
        material.SetFloat("_EID3336B6UseURPGBuffer", sourceFiveMrt ? 0f : 1f);
        material.SetFloat("_EID3336B6MaterialTarget", sourceFiveMrt ? 2f : 1f);
        material.SetFloat("_EID3336B6NormalTarget", sourceFiveMrt ? 3f : 2f);
        material.SetFloat("_EID3336B6BaseColorTarget", sourceFiveMrt ? 4f : 0f);
        EnsureProbeBuffers(material);
    }

    public void BindDeferredLighting(Camera camera, int outputWidth, int outputHeight)
    {
        Material material = GetActiveDeferredLightingMaterial(camera);
        if (material == null || targets == null || camera == null) return;

        // Legacy five-MRT resources are also pipeline-owned/live.
        BindCapturedLightingInputsToMaterial(material);
        for (int i = 0; i < 5; ++i)
            material.SetTexture("_EID3336B6RT" + i, targets.GetColor(i));
        material.SetTexture("_EID3336B6Depth", targets.Depth);

        Matrix4x4 vp = GetViewProjection(camera);
        material.SetMatrix("_EID3336B6ClipToWorld", vp.inverse);
        material.SetMatrix("_EID3336B6WorldToView", GetWorldToView(camera));
        material.SetVector("_EID3336B6CameraPositionWS", GetCameraPosition(camera));
        outputWidth = Mathf.Max(1, outputWidth);
        outputHeight = Mathf.Max(1, outputHeight);
        int gbufferWidth = Mathf.Max(1, targets.width);
        int gbufferHeight = Mathf.Max(1, targets.height);
        material.SetVector("_EID3336B6ScreenSize", new Vector4(gbufferWidth, gbufferHeight, 1f / gbufferWidth, 1f / gbufferHeight));
        material.SetVector("_EID3336B6OutputSize", new Vector4(outputWidth, outputHeight, 1f / outputWidth, 1f / outputHeight));

        if (!b6MaterialOwnsTuningParameters)
        {
            ApplyControllerB6TuningToMaterial(material);
            material.SetFloat("_EID3336B6UseURPGBuffer", 0f);
            material.SetFloat("_EID3336B6MaterialTarget", 2f);
            material.SetFloat("_EID3336B6NormalTarget", 3f);
            material.SetFloat("_EID3336B6BaseColorTarget", 4f);
        }
        EnsureProbeBuffers(material);
    }

    // Captured textures and the RenderDoc constant/structured-buffer inputs are
    // pipeline data, not per-object material tuning. Keep them synchronized with
    // the active B6 material on every camera render so the full indirect-lighting
    // path cannot silently fall back to black/default resources.
    void BindCapturedLightingInputsToMaterial(Material material)
    {
        if (material == null) return;
        LoadB6Assets();
        if (b6ScreenSH != null) material.SetTexture("_EID3336B6ScreenSH", b6ScreenSH);
        if (b6ScreenSpecularColor != null) material.SetTexture("_EID3336B6ScreenSpecularColor", b6ScreenSpecularColor);
        if (b6ScreenSpecularWeight != null) material.SetTexture("_EID3336B6ScreenSpecularWeight", b6ScreenSpecularWeight);
        if (b6ReflectionValidity != null) material.SetTexture("_EID3336B6ReflectionValidity", b6ReflectionValidity);
        if (b6ReflectionVisibility != null) material.SetTexture("_EID3336B6ReflectionVisibility", b6ReflectionVisibility);
        if (b6SSAO != null) material.SetTexture("_EID3336B6SSAO", b6SSAO);
        if (b6ReflectionAtlas != null) material.SetTexture("_EID3336B6ReflectionAtlas", b6ReflectionAtlas);

        // These values come from the captured deferred-lighting constant buffers.
        // They are not replaced by Unity's standard URP lighting constants.
        SetB6Constants(material);
        ApplyProbeConstantsToMaterial(material);
        EnsureProbeBuffers(material);
    }

    [ContextMenu("Copy Controller B6 Values To Material")]
    public void ApplyControllerB6TuningToMaterial()
    {
        EnsureB6Material();
        if (b6LightingMaterial == null) return;
        ApplyControllerB6TuningToMaterial(b6LightingMaterial);
#if UNITY_EDITOR
        if (!Application.isPlaying)
            EditorUtility.SetDirty(b6LightingMaterial);
#endif
    }

    // The serialized material is the Inspector-facing tuning source. Runtime
    // cameras receive the same scalar/vector inputs on their own material.
    void ApplyControllerB6TuningToMaterial(Material material)
    {
        if (material == null) return;
        LoadB6Assets();

        material.SetTexture("_EID3336B6ScreenSH", b6ScreenSH);
        material.SetTexture("_EID3336B6ScreenSpecularColor", b6ScreenSpecularColor);
        material.SetTexture("_EID3336B6ScreenSpecularWeight", b6ScreenSpecularWeight);
        material.SetTexture("_EID3336B6ReflectionValidity", b6ReflectionValidity);
        material.SetTexture("_EID3336B6ReflectionVisibility", b6ReflectionVisibility);
        material.SetTexture("_EID3336B6SSAO", b6SSAO);
        material.SetTexture("_EID3336B6ReflectionAtlas", b6ReflectionAtlas);
        material.SetFloat("_EID3336B6ViewMode", (float)b6ViewMode);
        material.SetFloat("_EID3336B6ScreenSHWeight", b6ScreenSHWeight);
        material.SetFloat("_EID3336B6ScreenSpecularContributionWeight", b6ScreenSpecularContributionWeight);
        material.SetFloat("_EID3336B6ProbeReflectionWeight", b6ProbeReflectionWeight);
        material.SetFloat("_EID3336B6CapturedVisibilityWeight", b6CapturedVisibilityWeight);
        material.SetFloat("_EID3336B6WorldDisplayRange", worldPositionRange);
        material.SetFloat("_EID3336B6DepthDisplayFar", depthDisplayFar);
        material.SetFloat("_EID3336B6ReconstructionFlipY", reconstructionFlipY ? 1f : 0f);
        material.SetFloat("_EID3336B6FlipY", b6FlipY ? 1f : 0f);
        Vector3 d = lightDirectionWS.sqrMagnitude > 1e-6f ? lightDirectionWS.normalized : Vector3.up;
        material.SetVector("_EID3336B6LightDirectionWS", new Vector4(d.x, d.y, d.z, 0f));
        material.SetColor("_EID3336B6LightColor", lightColor);
        material.SetFloat("_EID3336B6LightIntensity", lightIntensity);
        material.SetFloat("_EID3336B6AmbientStrength", ambientStrength);
        material.SetFloat("_EID3336B6DiffuseStrength", 1f);
        material.SetFloat("_EID3336B6SpecularStrength", specularStrength);
        material.SetFloat("_EID3336B6IndirectDiffuseStrength", b6IndirectDiffuseStrength);
        material.SetFloat("_EID3336B6IndirectSpecularStrength", b6IndirectSpecularStrength);
        SetB6Constants(material);
        ApplyProbeConstantsToMaterial(material);
    }

    void LoadB6Assets()
    {
#if UNITY_EDITOR
        if (b6ScreenSH == null) b6ScreenSH = AssetDatabase.LoadAssetAtPath<Texture2D>(CapturedRoot + "/Imported/screen_sh_b5.asset");
        if (b6ScreenSpecularColor == null) b6ScreenSpecularColor = AssetDatabase.LoadAssetAtPath<Texture2D>(CapturedRoot + "/Imported/screen_specular_color_b7.asset");
        if (b6ScreenSpecularWeight == null) b6ScreenSpecularWeight = AssetDatabase.LoadAssetAtPath<Texture2D>(CapturedRoot + "/Imported/screen_specular_weight_b8.asset");
        if (b6ReflectionValidity == null) b6ReflectionValidity = AssetDatabase.LoadAssetAtPath<Texture2D>(CapturedRoot + "/Imported/reflection_validity_b6.asset");
        if (b6ReflectionVisibility == null) b6ReflectionVisibility = AssetDatabase.LoadAssetAtPath<Texture2D>(CapturedRoot + "/Imported/reflection_visibility_b22.asset");
        if (b6SSAO == null) b6SSAO = AssetDatabase.LoadAssetAtPath<Texture2D>(CapturedRoot + "/Imported/ssao_b18.asset");
        if (b6ReflectionAtlas == null) b6ReflectionAtlas = AssetDatabase.LoadAssetAtPath<Texture2DArray>(CapturedRoot + "/Imported/reflection_atlas_mip3.asset");
#endif
    }
    [ContextMenu("Load RenderDoc Captured Matrices")]
    public void LoadCapturedMatrices()
    {
        string path = ProjectFile(CapturedRoot + "/raw/cb_uniforms7_b26.bin");
        if (!File.Exists(path)) { capturedMatricesLoaded = false; return; }
        byte[] data = File.ReadAllBytes(path);
        if (data.Length < 192) { capturedMatricesLoaded = false; return; }
        capturedView = ReadMatrix(data, 0);
        capturedProjection = ReadMatrix(data, 128);
        capturedViewProjection = capturedProjection.transpose * capturedView.transpose;
        capturedMatricesLoaded = true;
    }

    static Matrix4x4 ReadMatrix(byte[] data, int offset)
    {
        Matrix4x4 matrix = Matrix4x4.zero;
        for (int r = 0; r < 4; ++r)
            for (int c = 0; c < 4; ++c)
                matrix[r, c] = BitConverter.ToSingle(data, offset + (r * 4 + c) * 4);
        return matrix;
    }

    static float F(byte[] d, int o) => BitConverter.ToSingle(d, o);
    static Vector4 V(byte[] d, int o) => new Vector4(F(d,o),F(d,o+4),F(d,o+8),F(d,o+12));
    void SetB6Constants(Material material)
    {
        if (material == null) return;
        string root = ProjectFile(CapturedRoot + "/raw"); string p9 = Path.Combine(root, "cb_uniforms9_b29.bin");
        if (File.Exists(p9)) { var d=File.ReadAllBytes(p9); if(d.Length>=512){material.SetVector("_EID3336B6IndirectScale",V(d,464));material.SetVector("_EID3336B6IndirectOptions",b6UseCapturedIndirectOptions?V(d,480):new Vector4(1,1,1,1));material.SetVector("_EID3336B6ReflectionMipParameters",V(d,496));material.SetVector("_EID3336B6ClusterOffsets",V(d,448));material.SetFloat("_EID3336B6TextureMipBias",F(d,416));if(d.Length>=2240){material.SetVector("_EID3336B6FallbackSHRed",V(d,2160));material.SetVector("_EID3336B6FallbackSHGreen",V(d,2176));material.SetVector("_EID3336B6FallbackSHBlue",V(d,2192));}}}
    }
    void ApplyProbeConstantsToMaterial(Material material)
    {
        if (material == null) return;
        if (material == null || !b6UseCapturedProbeData) return;
        string cp = Path.Combine(ProjectFile(CapturedRoot + "/raw"), "cb_uniforms26_b30.bin");
        if (!File.Exists(cp)) return;
        byte[] cb = File.ReadAllBytes(cp);
        if (cb.Length < 4160) return;
        material.SetVector("_EID3336B6ProbeClusterGrid", V(cb, 0));
        material.SetVector("_EID3336B6ProbeAtlasLayout", V(cb, 16));
        material.SetVector("_EID3336B6ProbeDepthAndAtlasOffset", V(cb, 32));
        material.SetVector("_EID3336B6FallbackProbeNormalPlane", V(cb, 48));
    }

    void EnsureProbeBuffers(Material material)
    {
        if (material == null || !b6UseCapturedProbeData) return;
        if (reflectionProbeBuffer == null || clusterMaskBuffer == null)
        {
            string root = ProjectFile(CapturedRoot + "/raw");
            string cp = Path.Combine(root, "cb_uniforms26_b30.bin");
            string mp = Path.Combine(root, "ssbo_cluster_b31.bin");
            if (!File.Exists(cp) || !File.Exists(mp)) return;
            byte[] cb = File.ReadAllBytes(cp);
            byte[] raw = File.ReadAllBytes(mp);
            if (cb.Length < 4160 || raw.Length == 0 || raw.Length % 4 != 0) return;
            reflectionProbeBuffer?.Release();
            clusterMaskBuffer?.Release();
            Vector4[] probes = new Vector4[32 * 8];
            for (int i = 0; i < probes.Length; i++) probes[i] = V(cb, 64 + i * 16);
            reflectionProbeBuffer = new ComputeBuffer(probes.Length, 16, ComputeBufferType.Structured);
            reflectionProbeBuffer.SetData(probes);
            uint[] masks = new uint[raw.Length / 4];
            Buffer.BlockCopy(raw, 0, masks, 0, raw.Length);
            clusterMaskBuffer = new ComputeBuffer(masks.Length, 4, ComputeBufferType.Raw);
            clusterMaskBuffer.SetData(masks);
        }
        // Allocation is shared, binding is per-camera material and must never be skipped.
        material.SetBuffer("_EID3336B6ReflectionProbes", reflectionProbeBuffer);
        material.SetBuffer("_EID3336B6ClusterProbeMasks", clusterMaskBuffer);
    }
    void ReleaseB6Buffers(){reflectionProbeBuffer?.Release();clusterMaskBuffer?.Release();reflectionProbeBuffer=null;clusterMaskBuffer=null;if(runtimeB6Material!=null){if(Application.isPlaying)Destroy(runtimeB6Material);else DestroyImmediate(runtimeB6Material);runtimeB6Material=null;}}
    public void SetLiveFinalTexture(Camera camera, RenderTexture texture){if(camera!=null){if(camera.cameraType==CameraType.SceneView)liveSceneViewFinalTexture=texture;else if(camera==targetCamera)liveGameFinalTexture=texture;}}
}










// Native URP five-GBuffer lightpass integration marker.


