using System;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public sealed class EID5537FixedFrameRendererFeature : ScriptableRendererFeature
{
    public const int Width = 1366;
    public const int Height = 768;
    public static readonly int OutputId = Shader.PropertyToID("_EID5537Res9");
    public static RenderTexture CurrentOutput { get; private set; }
    public static Camera CurrentOutputCamera { get; private set; }

    public static RenderTexture GetCurrentOutput(Camera camera)
    {
        if (camera == null || camera != CurrentOutputCamera || CurrentOutput == null)
            return null;
        return CurrentOutput.IsCreated() ? CurrentOutput : null;
    }

    [Serializable]
    public sealed class Settings
    {
        [Tooltip("Use camera color/depth plus explicit live EID5519/EID5528/history dependencies. Missing inputs skip AA; never mix captured history with live color.")]
        public bool useLiveInputs;
        [Tooltip("Transitional mode: live camera color (_13) + previous EID5537 result (_800). Motion/mask/constants remain captured; depth can use the shared GBuffer attachment. Ignored when Use Live Inputs is enabled.")]
        public bool useLiveColorHistory;
        [Tooltip("In color-history mode, use this camera's shared GBuffer depth at resolve time. Copies raw device depth, not Linear01Depth. Invalid live depth skips AA instead of using captured depth.")]
        public bool useLiveGBufferDepth;
        [Tooltip("Flip normalized live color AND live depth together if an orientation probe proves it necessary. Changing it resets history.")]
        public bool flipLiveColorY;
        [Tooltip("Reconstruct EID5519 from original captured inputs. Cached after first draw. This is not live motion; moving cameras still reset history.")]
        public bool restoreEID5519;
        [Tooltip("Use this Game camera's current depth/motion and per-camera ping-pong history for all four EID5519 inputs. Never falls back to captured textures.")]
        public bool liveEID5519;
        public Shader eid5519LiveShader;
        [Tooltip("Generate EID5537 _795 from current EID5519 motion using the original EID5528 five-tap mask. Requires live EID5519; missing inputs skip TAA, never use a captured mask.")]
        public bool liveEID5528;
        public Shader eid5528Shader;
        public EID5519Profile eid5519Profile;
        public EID5537FixedFrameProfile profile;
        public Shader shader;
        // EID5618 consumes this result at AfterRenderingPostProcessing. Keep
        // the producer earlier in the frame so the dependency is explicit and
        // does not rely on renderer-feature list ordering.
        public RenderPassEvent injectionPoint = (RenderPassEvent)((int)RenderPassEvent.BeforeRenderingPostProcessing - 1);
        public bool renderInGameView = true;
        public bool renderInSceneView = false;
        public bool enabledForCamera = true;
        public bool allowEditMode = false;
        public bool requireGameCamera = true;
        public string cameraNameContains = "EID3336 RenderDoc Camera";
        public bool skipOverlayCameras = true;
        public bool skipStereoCameras = true;
        [HideInInspector] public int probeInput;
    }

    public Settings settings = new Settings();
    FixedFramePass pass;
    Material material;
    Settings passSettings;
    bool warnedShader;
    public int RenderTextureAllocationCount => pass != null ? pass.AllocationCount : 0;

    bool CanReusePass => pass != null && material != null && ReferenceEquals(passSettings, settings) &&
        (settings.shader == null || material.shader == settings.shader);

    public override void Create()
    {
        if (settings == null) settings = new Settings();
        if (CanReusePass)
        {
            pass.renderPassEvent = settings.injectionPoint;
            return;
        }
        pass?.Dispose();
        pass = null;
        passSettings = null;
        if (material != null) CoreUtils.Destroy(material);
        material = null;
        warnedShader = false;
        // Do not instantiate the large exact shader when Unity opens the
        // project: SceneView/Preview cameras are filtered below. Compile and
        // allocate resources only for an eligible game-camera render.
    }

    // Unified toggle: no stale output/history may survive disabling the feature.
    public void SetTAAEnabled(bool enabled)
    {
        if (settings == null) settings = new Settings();
        settings.enabledForCamera = enabled;
        settings.renderInGameView = true;
        settings.renderInSceneView = false;
        settings.requireGameCamera = true;
        CurrentOutput = null;
        CurrentOutputCamera = null;
        if (!enabled) Dispose(false); // Release 5519/5528, color history and constant buffers.
        else ResetColorHistory();
        SetActive(enabled); // Resources are created lazily for the next eligible Game render.
    }

    [ContextMenu("Reset EID5537 Color History")]
    public void ResetColorHistory() { pass?.InvalidateColorHistory(); }

    bool EnsurePass()
    {
        if (CanReusePass) return true;
        if (pass != null || material != null) Create();
        Shader shader = settings.shader != null ? settings.shader : Shader.Find("Hidden/EID5618/EID5537Res9");
        if (shader == null || !shader.isSupported)
        {
            if (!warnedShader)
            {
                Debug.LogError("[EID5537] Fixed-frame shader is missing or unsupported.");
                warnedShader = true;
            }
            return false;
        }
        try
        {
            material = CoreUtils.CreateEngineMaterial(shader);
            if (material == null) return false;
            pass = new FixedFramePass(settings, material);
            passSettings = settings;
            return true;
        }
        catch (Exception e)
        {
            if (material != null) CoreUtils.Destroy(material);
            material = null;
            if (!warnedShader)
            {
                Debug.LogError("[EID5537] Fixed-frame pass could not be initialized: " + e.Message);
                warnedShader = true;
            }
            return false;
        }
    }

    public override void SetupRenderPasses(ScriptableRenderer renderer, in RenderingData renderingData)
    {
        if (pass != null) pass.SetCameraTargets(renderer.cameraColorTargetHandle, renderer.cameraDepthTargetHandle);
    }

    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        Camera camera = renderingData.cameraData.camera;
        if (camera == null) return;

        // Clear stale state even when this camera is filtered out or the profile
        // is temporarily invalid during an asset/domain reload.
        CurrentOutput = null;
        CurrentOutputCamera = null;
        EID5537LiveInputs.BeginCamera(camera);
        EID3336FiveMRTLightingInputs.BeginMotionCamera(camera);

        if (settings == null || !settings.enabledForCamera || (!settings.useLiveInputs && settings.profile == null)) return;
        if (camera.cameraType == CameraType.Preview || camera.cameraType == CameraType.Reflection) return;
        if (!Application.isPlaying && !settings.allowEditMode) return;
        if (settings.requireGameCamera && camera.cameraType != CameraType.Game) return;
        if (settings.skipOverlayCameras && renderingData.cameraData.renderType == CameraRenderType.Overlay) return;
        if (settings.skipStereoCameras && camera.stereoEnabled) return;
        if (!string.IsNullOrEmpty(settings.cameraNameContains) &&
            camera.name.IndexOf(settings.cameraNameContains, StringComparison.OrdinalIgnoreCase) < 0) return;
        if (renderingData.cameraData.isSceneViewCamera ? !settings.renderInSceneView : !settings.renderInGameView) return;
        if (!EnsurePass()) return;

        pass.renderPassEvent = settings.injectionPoint;
        renderer.EnqueuePass(pass);
    }

    protected override void Dispose(bool disposing)
    {
        pass?.Dispose();
        pass = null;
        passSettings = null;
        if (material != null) CoreUtils.Destroy(material);
        material = null;
        CurrentOutput = null;
        CurrentOutputCamera = null;
    }

    sealed class FixedFramePass : ScriptableRenderPass
    {
        static readonly int Res14 = Shader.PropertyToID("_790");
        static readonly int Res13 = Shader.PropertyToID("_13");
        static readonly int Res17 = Shader.PropertyToID("_800");
        static readonly int Res16 = Shader.PropertyToID("_795");
        static readonly int Res15 = Shader.PropertyToID("_15");
        static readonly int BootstrapHistory = Shader.PropertyToID("_EID5537BootstrapHistory");
        static readonly int CameraDepthSource = Shader.PropertyToID("_EID5537CameraDepthSource");
        static readonly int CameraSource = Shader.PropertyToID("_EID5537CameraSource");
        static readonly int SourceSize = Shader.PropertyToID("_EID5537SourceSize");
        static readonly int CopyFlipY = Shader.PropertyToID("_EID5537CopyFlipY");
        static readonly int B7 = Shader.PropertyToID("_11_12");
        static readonly int B8 = Shader.PropertyToID("_5_6");
        readonly Settings settings;
        readonly Material material;
        RTHandle target;
        RTHandle cameraColor;
        RTHandle cameraDepth;
        string lastLiveWarning;
        readonly EID5519Pass eid5519 = new EID5519Pass();
        readonly EID5519LivePass live5519 = new EID5519LivePass();
        readonly EID5528Pass live5528 = new EID5528Pass();
        bool previousLiveMask;
        readonly EID5537ColorHistory colorHistory = new EID5537ColorHistory();
        bool warnedPartialHistory;
        RenderTexture previousDepthSource;
        GraphicsFormat previousDepthFormat;
        int outputAllocations;
        public int AllocationCount => outputAllocations + colorHistory.AllocationCount + eid5519.AllocationCount + live5519.AllocationCount + live5528.AllocationCount;

        Vector2Int SourceViewport(in RenderingData data)
        {
            return cameraColor != null && cameraColor.useScaling
                ? cameraColor.GetScaledSize(cameraColor.rtHandleProperties.currentViewportSize)
                : new Vector2Int(data.cameraData.cameraTargetDescriptor.width, data.cameraData.cameraTargetDescriptor.height);
        }

        bool NeedsColorCopy(Vector2Int viewport)
        {
            var source = cameraColor?.rt;
            return settings.flipLiveColorY || source == null || source.width != Width || source.height != Height ||
                viewport.x != Width || viewport.y != Height;
        }

        public void InvalidateColorHistory() { colorHistory.Invalidate(); eid5519.Invalidate(); live5519.Invalidate(); live5528.Invalidate(); }

        public void SetCameraTargets(RTHandle color, RTHandle depth)
        {
            cameraColor = color;
            cameraDepth = depth;
        }
        ComputeBuffer cb7;
        ComputeBuffer cb8;
        TextAsset previousB7;
        TextAsset previousB8;
        bool warned;
        bool warnedBufferFailure;

        public FixedFramePass(Settings settings, Material material)
        {
            this.settings = settings;
            this.material = material;
            profilingSampler = new ProfilingSampler("EID5537 TAA Resolve");
        }

        public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
        {
            var desc = new RenderTextureDescriptor(Width, Height)
            {
                depthBufferBits = 0, msaaSamples = 1, mipCount = 1,
                useMipMap = false, autoGenerateMips = false, sRGB = false,
                graphicsFormat = GraphicsFormat.R16G16B16A16_SFloat
            };
            if (target == null || target.rt == null || !target.rt.IsCreated() ||
                target.rt.width != Width || target.rt.height != Height ||
                target.rt.graphicsFormat != desc.graphicsFormat)
            {
                colorHistory.Invalidate();
                target?.Release();
                target = null;
                target = RTHandles.Alloc(desc, FilterMode.Point, TextureWrapMode.Clamp,
                    name: "EID5537_RID210447_RGBA16F");
                outputAllocations++;
            }
            if (settings.useLiveColorHistory && !settings.useLiveInputs)
                colorHistory.Ensure(desc, settings.useLiveGBufferDepth && !(settings.restoreEID5519 && settings.liveEID5519), NeedsColorCopy(SourceViewport(in renderingData)));
            if (target != null)
            {
                ConfigureTarget(target);
                ConfigureClear(ClearFlag.Color, Color.clear);
            }
        }

        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            if (target == null || target.rt == null || !target.rt.IsCreated() || material == null) return;
            bool partialHistory = settings.useLiveColorHistory && !settings.useLiveInputs;
            bool liveDepth = partialHistory && settings.useLiveGBufferDepth;
            bool useLive5519 = settings.restoreEID5519 && settings.liveEID5519 && partialHistory && liveDepth;
            bool useLive5528 = settings.liveEID5528 && !settings.useLiveInputs;
            if(previousLiveMask!=useLive5528) {colorHistory.Invalidate();previousLiveMask=useLive5528;}
            if(useLive5528 && !useLive5519) {
                colorHistory.Invalidate();
                if(lastLiveWarning!="mask-prerequisites")Debug.LogWarning("[EID5528] Live mask requires live EID5519/color/depth. TAA skipped; captured mask fallback disabled.");
                lastLiveWarning="mask-prerequisites";return;
            }
            bool resetHistory = false;
            bool copyColor = false;
            Vector2Int liveSourceSize = default;
            ComputeBuffer activeB7;
            ComputeBuffer activeB8;
            material.SetFloat(BootstrapHistory, 0f);
            if (settings.useLiveInputs)
            {
                EID5537LiveInputs.Dependencies live;
                string reason;
                if (!EID5537LiveInputs.TryConsume(renderingData.cameraData.camera,
                    cameraColor?.rt, cameraDepth?.rt, out live, out reason))
                {
                    if (lastLiveWarning != reason)
                    {
                        Debug.LogWarning("[EID5537 Live] AA skipped: " + reason + ". Captured fallback is disabled.");
                        lastLiveWarning = reason;
                    }
                    return;
                }
                if (live.historyColor == target.rt || cameraColor.rt == target.rt ||
                    live.packedMotion == target.rt || live.rejectionMask == target.rt)
                {
                    if (lastLiveWarning != "feedback")
                        Debug.LogWarning("[EID5537 Live] AA skipped: input/output feedback alias.");
                    lastLiveWarning = "feedback";
                    return;
                }
                lastLiveWarning = null;
                material.SetTexture(Res13, cameraColor.rt);
                material.SetTexture(Res14, cameraDepth.rt);
                material.SetTexture(Res15, live.packedMotion);
                material.SetTexture(Res16, live.rejectionMask);
                material.SetTexture(Res17, live.historyColor);
                activeB7 = live.uniforms12B7;
                activeB8 = live.uniforms6B8;
            }
            else
            {
                var p = settings.profile;
                if (p == null || (!liveDepth && p.res14Depth == null) ||
                    (!partialHistory && (p.res17Color == null || p.res13Color == null)) ||
                    (!useLive5528 && p.res16Mask == null) || (!useLive5519 && p.res15Color == null) || !EnsureBuffers(p))
                {
                    if (!warned)
                    {
                        Debug.LogError("[EID5537] Missing captured inputs or invalid b7/b8 (192/3200 bytes).");
                        warned = true;
                    }
                    return;
                }
                material.SetTexture(Res14, p.res14Depth);
                material.SetTexture(Res13, p.res13Color);
                material.SetTexture(Res17, p.res17Color);
                if(!useLive5528) material.SetTexture(Res16, p.res16Mask);
                if(!useLive5519) material.SetTexture(Res15, p.res15Color);
                activeB7 = cb7;
                activeB8 = cb8;
                if (partialHistory)
                {
                    if (colorHistory.Read?.rt == null || !colorHistory.Read.rt.IsCreated())
                    {
                        colorHistory.Invalidate();
                        if (lastLiveWarning != "history-allocation")
                            Debug.LogWarning("[EID5537 ColorHistory] AA skipped: live color/history RT allocation is unavailable.");
                        lastLiveWarning = "history-allocation";
                        return;
                    }
                    RenderTexture source = cameraColor?.rt;
                    if (source == null || !source.IsCreated() || source.antiAliasing != 1 || source.sRGB ||
                        source.dimension != TextureDimension.Tex2D || source.memorylessMode != RenderTextureMemoryless.None ||
                        (source.graphicsFormat != GraphicsFormat.B10G11R11_UFloatPack32 &&
                         source.graphicsFormat != GraphicsFormat.R16G16B16A16_SFloat &&
                         source.graphicsFormat != GraphicsFormat.R32G32B32A32_SFloat) || material.passCount < 2)
                    {
                        colorHistory.Invalidate();
                        if (lastLiveWarning != "live-color")
                            Debug.LogWarning("[EID5537 ColorHistory] Requires an allocated single-sample linear HDR camera RT and the copy shader pass.");
                        lastLiveWarning = "live-color";
                        return;
                    }
                    liveSourceSize = SourceViewport(in renderingData);
                    copyColor = NeedsColorCopy(liveSourceSize);
                    if (copyColor && (colorHistory.CurrentColor?.rt == null || !colorHistory.CurrentColor.rt.IsCreated()))
                    {
                        colorHistory.Invalidate();
                        return;
                    }
                    if (liveSourceSize.x <= 0 || liveSourceSize.y <= 0 ||
                        liveSourceSize.x > source.width || liveSourceSize.y > source.height ||
                        source == target.rt || source == colorHistory.Read?.rt || source == colorHistory.CurrentColor?.rt)
                    {
                        colorHistory.Invalidate();
                        if (lastLiveWarning != "viewport")
                            Debug.LogWarning("[EID5537 ColorHistory] Invalid camera viewport or input/output feedback alias.");
                        lastLiveWarning = "viewport";
                        return;
                    }
                    if (liveDepth)
                    {
                        RenderTexture depth = cameraDepth?.rt;
                        Vector2Int depthSize = cameraDepth != null && cameraDepth.useScaling
                            ? cameraDepth.GetScaledSize(cameraDepth.rtHandleProperties.currentViewportSize)
                            : new Vector2Int(renderingData.cameraData.cameraTargetDescriptor.width,
                                renderingData.cameraData.cameraTargetDescriptor.height);
                        // The capture's geometry uses GreaterEqual (reversed device Z).
                        // Do not silently linearize/invert or use a stale global depth copy.
                        if (depth == null || !depth.IsCreated() || depth.antiAliasing != 1 ||
                            depth.dimension != TextureDimension.Tex2D || depth.memorylessMode != RenderTextureMemoryless.None ||
                            depth.depthStencilFormat == GraphicsFormat.None || !SystemInfo.usesReversedZBuffer ||
                            depthSize != liveSourceSize || depthSize.x > depth.width || depthSize.y > depth.height ||
                            material.passCount < 3 || (!useLive5519 && (colorHistory.CurrentDepth?.rt == null ||
                            !colorHistory.CurrentDepth.rt.IsCreated())))
                        {
                            colorHistory.Invalidate();
                            if (lastLiveWarning != "live-depth")
                                Debug.LogWarning("[EID5537 ColorHistory] AA skipped: shared GBuffer depth must be sampleable single-sample reversed device-Z with matching color viewport; R32 depth copy/pass must be available.");
                            lastLiveWarning = "live-depth";
                            return;
                        }
                        if (previousDepthSource != depth || previousDepthFormat != depth.depthStencilFormat)
                            colorHistory.Invalidate();
                        previousDepthSource = depth;
                        previousDepthFormat = depth.depthStencilFormat;
                        if(!useLive5519) material.SetTexture(Res14, colorHistory.CurrentDepth.rt);
                    }
                    else previousDepthSource = null;
                    lastLiveWarning = null;
                    resetHistory = colorHistory.NeedsReset(renderingData.cameraData.camera,
                        liveSourceSize, source.graphicsFormat, settings.flipLiveColorY);
                    material.SetTexture(CameraSource, source);
                    material.SetVector(SourceSize, new Vector4(liveSourceSize.x, liveSourceSize.y, Width, Height));
                    material.SetFloat(CopyFlipY, settings.flipLiveColorY ? 1f : 0f);
                    RenderTexture currentColor = copyColor ? colorHistory.CurrentColor.rt : source;
                    material.SetTexture(Res13, currentColor);
                    material.SetTexture(Res17, resetHistory ? currentColor : colorHistory.Read.rt);
                    material.SetFloat(BootstrapHistory, resetHistory ? 1f : 0f);
                    if (!warnedPartialHistory)
                    {
                        Debug.LogWarning("[EID5537 ColorHistory] _13 is live camera HDR and _800 is previous resolve. _790 is " +
                            (liveDepth ? "live shared GBuffer device depth" : "captured depth") +
                            (useLive5519 ? (useLive5528 ? ". EID5519 inputs and EID5528 mask are live; b7/b8 remain captured." : ". EID5519 inputs/motion are live; mask/b7/b8 remain captured.") : ". Motion/mask/b7/b8 remain captured;") + " This is NOT fully live TAA. Camera movement resets color history.");
                        warnedPartialHistory = true;
                    }
                }
            }
            material.SetFloat("_EID5537Probe", settings.probeInput);
            var cmd = CommandBufferPool.Get(settings.useLiveInputs
                ? "EID5537 Live FS -> RID210447" : partialHistory
                    ? "EID5537 Live13 + History800" : "EID5537 Fixed Frame FS -> RID210447");
            try
            {
                if (activeB7 == null || activeB8 == null || !activeB7.IsValid() || !activeB8.IsValid()) return;
                if (settings.restoreEID5519 && !settings.useLiveInputs)
                {
                    if (settings.liveEID5519)
                    {
                        RTHandle liveMotion;
                        if (!useLive5519 || !EID3336FiveMRTLightingInputs.TryGetMotion(renderingData.cameraData.camera, out liveMotion))
                        { colorHistory.Invalidate(); live5519.Invalidate(); return; }
                        Matrix4x4 vp=renderingData.cameraData.GetGPUProjectionMatrix()*renderingData.cameraData.GetViewMatrix();
                        if(settings.flipLiveColorY) { var flip=Matrix4x4.identity;flip.m11=-1;vp=flip*vp; }
                        // Keep conservative movement reset until every upstream motion writer is temporal.
                        if(!live5519.Record(cmd, settings.eid5519LiveShader, renderingData.cameraData.camera,
                            cameraDepth,liveMotion,liveSourceSize,vp,settings.flipLiveColorY,settings.probeInput != 0))
                        {
                            colorHistory.Invalidate();
                            if(lastLiveWarning!=live5519.Failure) Debug.LogWarning("[EID5519 Live] Skipped: "+live5519.Failure);
                            lastLiveWarning=live5519.Failure;return;
                        }
                        if(useLive5528) {
                            if(!live5528.Record(cmd,settings.eid5528Shader,live5519.Motion)) {
                                colorHistory.Invalidate();
                                if(lastLiveWarning!=live5528.Failure)Debug.LogWarning("[EID5528] TAA skipped: "+live5528.Failure);
                                lastLiveWarning=live5528.Failure;return;
                            }
                            material.SetTexture(Res16,live5528.Output);
                        }
                        material.SetTexture(Res15,live5519.Motion);
                        material.SetTexture(Res14,live5519.CurrentDepth);
                        if(live5519.ResetThisRender) { resetHistory=true; material.SetFloat(BootstrapHistory,1); }
                    }
                    else if (!eid5519.Record(cmd, settings.eid5519Profile))
                    {
                        colorHistory.Invalidate();
                        return; // Never silently fall back to an unrelated captured motion RT.
                    }
                    if(!settings.liveEID5519) material.SetTexture(Res15, eid5519.Motion);
                    // EID5537 res14 is the original D32S8, NOT EID5519's R16
                    // dilated depth (the latter is a temporal dependency for other passes).
                    // Keep res14 unchanged in both captured and live-depth modes.
                    CoreUtils.SetRenderTarget(cmd, target, ClearFlag.None);
                }
                if (partialHistory)
                {
                    if (copyColor)
                    {
                        cmd.BeginSample("EID5537 Copy Camera HDR -> _13");
                        CoreUtils.SetRenderTarget(cmd, colorHistory.CurrentColor, ClearFlag.None);
                        cmd.SetViewport(new Rect(0, 0, Width, Height));
                        cmd.DrawProcedural(Matrix4x4.identity, material, 1, MeshTopology.Triangles, 3, 1);
                        cmd.EndSample("EID5537 Copy Camera HDR -> _13");
                    }
                    if (liveDepth && !useLive5519)
                    {
                        cmd.BeginSample("EID5537 Copy GBuffer Depth -> _790");
                        // Select the depth aspect explicitly; never stencil or a GBuffer color channel.
                        cmd.SetGlobalTexture(CameraDepthSource, cameraDepth.nameID, RenderTextureSubElement.Depth);
                        CoreUtils.SetRenderTarget(cmd, colorHistory.CurrentDepth, ClearFlag.None);
                        cmd.SetViewport(new Rect(0, 0, Width, Height));
                        cmd.DrawProcedural(Matrix4x4.identity, material, 2, MeshTopology.Triangles, 3, 1);
                        cmd.EndSample("EID5537 Copy GBuffer Depth -> _790");
                    }
                    // Restore the attachment declared in OnCameraSetup so URP's
                    // target tracking matches the actual target on leaving Execute.
                    CoreUtils.SetRenderTarget(cmd, target, ClearFlag.None);
                }
                cmd.SetGlobalConstantBuffer(activeB7, B7, 0, 192);
                cmd.SetGlobalConstantBuffer(activeB8, B8, 0, 3200);
                cmd.SetViewport(new Rect(0, 0, Width, Height));
                string resolveLabel = partialHistory && resetHistory ? "EID5537 Bootstrap History" : "EID5537 Resolve";
                cmd.BeginSample(resolveLabel);
                cmd.DrawProcedural(Matrix4x4.identity, material, 0, MeshTopology.Triangles, 3, 1);
                cmd.EndSample(resolveLabel);
                cmd.SetGlobalTexture(OutputId, target.nameID);
                context.ExecuteCommandBuffer(cmd);
                if(useLive5519) live5519.Commit();
                if (target.rt != null && target.rt.IsCreated())
                {
                    CurrentOutput = target.rt;
                    CurrentOutputCamera = renderingData.cameraData.camera;
                    if (partialHistory)
                    {
                        if (settings.probeInput == 0)
                            colorHistory.Commit(ref target, renderingData.cameraData.camera, liveSourceSize,
                                cameraColor.rt.graphicsFormat, settings.flipLiveColorY);
                        else colorHistory.Invalidate(); // Never feed a diagnostic probe into normal history.
                    }
                }
            }
            finally { CommandBufferPool.Release(cmd); }
        }

        bool EnsureBuffers(EID5537FixedFrameProfile p)
        {
            if (p.uniforms12B7 == null || p.uniforms6B8 == null) return false;
            // TextAsset.bytes allocates; only read it when the assets or GPU
            // buffers actually change, not on every rendered frame.
            if (cb7 != null && cb8 != null && cb7.IsValid() && cb8.IsValid() &&
                previousB7 == p.uniforms12B7 && previousB8 == p.uniforms6B8) return true;

            byte[] b7Bytes = p.uniforms12B7.bytes;
            byte[] b8Bytes = p.uniforms6B8.bytes;
            if (b7Bytes.Length != 192 || b8Bytes.Length != 3200) return false;

            ComputeBuffer newB7 = null;
            ComputeBuffer newB8 = null;
            try
            {
                newB7 = new ComputeBuffer(192 / 16, 16, ComputeBufferType.Constant);
                newB8 = new ComputeBuffer(3200 / 16, 16, ComputeBufferType.Constant);
                newB7.SetData(AsUInt4(b7Bytes));
                newB8.SetData(AsUInt4(b8Bytes));
                cb7?.Release();
                cb8?.Release();
                cb7 = newB7;
                cb8 = newB8;
                previousB7 = p.uniforms12B7;
                previousB8 = p.uniforms6B8;
                warnedBufferFailure = false;
                return true;
            }
            catch (Exception e)
            {
                newB7?.Release();
                newB8?.Release();
                if (!warnedBufferFailure)
                {
                    Debug.LogError("[EID5537] Fixed-frame constant buffers could not be created: " + e.Message);
                    warnedBufferFailure = true;
                }
                return false;
            }
        }

        struct UInt4 { public uint x, y, z, w; }

        static UInt4[] AsUInt4(byte[] bytes)
        {
            var values = new UInt4[bytes.Length / 16];
            for (int i = 0; i < values.Length; i++)
            {
                int offset = i * 16;
                values[i] = new UInt4
                {
                    x = BitConverter.ToUInt32(bytes, offset), y = BitConverter.ToUInt32(bytes, offset + 4),
                    z = BitConverter.ToUInt32(bytes, offset + 8), w = BitConverter.ToUInt32(bytes, offset + 12)
                };
            }
            return values;
        }

        public void Dispose()
        {
            if (CurrentOutput == target?.rt || CurrentOutput == colorHistory.Read?.rt) CurrentOutput = null;
            if (CurrentOutputCamera != null) CurrentOutputCamera = null;
            target?.Release();
            target = null;
            colorHistory.Dispose();
            eid5519.Dispose();
            live5519.Dispose();
            live5528.Dispose();
            cameraColor = null;
            cameraDepth = null;
            previousDepthSource = null;
            EID5537LiveInputs.Reset();
            cb7?.Release();
            cb8?.Release();
            cb7 = null;
            cb8 = null;
        }
    }
}
