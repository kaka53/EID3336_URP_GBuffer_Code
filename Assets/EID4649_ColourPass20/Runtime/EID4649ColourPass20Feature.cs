using System;
using System.IO;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
#if UNITY_EDITOR
using UnityEditor;
#endif

public sealed class EID4649ColourPass20Feature : ScriptableRendererFeature
{
    public const string ShaderName = "Hidden/EID4649/ExactRenderDoc";
    public const string GlobalTextureName = "_EID4649ColourPass20RT";
    public const int CapturedWidth = 1366;
    public const int CapturedHeight = 768;
    public const int Uniforms6Bytes = 1312;
    public const int Uniforms17Bytes = 32864;
    public const int Uniforms21Bytes = 11440;
    public const int Uniforms8Bytes = 3200;

    const string NativeRoot = "Assets/EID4649_ColourPass20/Captured/UnityNative/";
    const string BufferRoot = "Assets/EID4649_ColourPass20/Captured/Buffers/";
    const string Contact209587 = "Assets/EID4662_ComputePass2/CapturedResources/Native/rid209587.asset";

    public enum InputSource
    {
        Captured = 0,
        Live = 1
    }

    [Serializable]
    public sealed class Settings
    {
        [Tooltip("独立 Feature。AfterRenderingGbuffer=220，排在 ExactReplay CS 之后、延迟光 230 之前。")]
        public RenderPassEvent injectionPoint = RenderPassEvent.AfterRenderingGbuffer;
        public bool renderInGameView = true;
        public bool renderInSceneView = true;
        public bool enabledForCamera = true;
        [Tooltip("总开关。Captured=_15 rid209560 / _24 rid209590 / _27 rid209587。Live=_15 GBuffer depth / _24 EID4530 _EndfieldGTAOBlur / _27 EID4594 _EndfieldContact。")]
        public InputSource inputSource = InputSource.Live;
        [Header("Captured / override textures")]
        [Tooltip("覆盖捕获 _15 rid209560。inputSource=Captured 时生效。")]
        public Texture tex15_209560;
        public Texture tex22_209068;
        public Texture tex23_198185;
        [Tooltip("覆盖捕获 _24 rid209590。inputSource=Captured 时生效。")]
        public Texture tex24_209590;
        public Texture tex25_209071;
        [Tooltip("覆盖捕获 _27 rid209587。inputSource=Captured 时生效。")]
        public Texture tex27_209587;
        [Header("LightPass _29")]
        [Tooltip("live=_EID4649ColourPass20RT；capture=4662 reflection_validity_b6。不改 FS 算术。")]
        public InputSource liveCapture = InputSource.Live;
    }

    public Settings settings = new Settings();
    Pass pass;
    Material materialGame;
    Material materialScene;
    static Texture lightPass29Game;
    static Texture lightPass29Scene;
    static bool lightPass29Override;

    public override void Create()
    {
        pass?.Dispose();
        EnsureMaterials();
        pass = new Pass(settings, materialGame, materialScene);
        pass.renderPassEvent = settings.injectionPoint;
    }

    void EnsureMaterials()
    {
        Shader shader = Shader.Find(ShaderName);
        if (shader == null)
            return;
        if (materialGame == null)
        {
            materialGame = CoreUtils.CreateEngineMaterial(shader);
            materialGame.name = "EID4649_ExactRenderDoc_Runtime_Game";
        }
        if (materialScene == null)
        {
            materialScene = CoreUtils.CreateEngineMaterial(shader);
            materialScene.name = "EID4649_ExactRenderDoc_Runtime_Scene";
        }
    }

    protected override void Dispose(bool disposing)
    {
        pass?.Dispose();
        pass = null;
        if (materialGame != null)
            CoreUtils.Destroy(materialGame);
        if (materialScene != null)
            CoreUtils.Destroy(materialScene);
        materialGame = null;
        materialScene = null;
        ClearDeferredLightPass29Override();
    }

    public static void ApplyDeferredLightPass29Override(Material material, Camera camera)
    {
        if (material == null || !lightPass29Override)
            return;
        bool gameCam = camera != null && camera.cameraType == CameraType.Game;
        Texture tex = gameCam ? lightPass29Game : lightPass29Scene;
        if (tex != null)
            material.SetTexture("_29", tex);
    }

    static void ClearDeferredLightPass29Override()
    {
        lightPass29Override = false;
        lightPass29Game = null;
        lightPass29Scene = null;
    }

    static void PublishDeferredLightPass29Override(bool enabled, bool gameCam, Texture tex)
    {
        lightPass29Override = enabled;
        if (!enabled)
        {
            if (gameCam)
                lightPass29Game = null;
            else
                lightPass29Scene = null;
            return;
        }
        if (gameCam)
            lightPass29Game = tex;
        else
            lightPass29Scene = tex;
    }

    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        if (materialGame == null || materialScene == null)
        {
            EnsureMaterials();
            if (materialGame != null && materialScene != null)
            {
                pass?.Dispose();
                pass = new Pass(settings, materialGame, materialScene);
            }
        }
        if (pass == null || materialGame == null || materialScene == null || !settings.enabledForCamera)
        {
            ClearDeferredLightPass29Override();
            return;
        }

        Camera camera = renderingData.cameraData.camera;
        if (camera == null || camera.cameraType == CameraType.Preview || camera.cameraType == CameraType.Reflection)
            return;

        if (renderingData.cameraData.isSceneViewCamera)
        {
            if (!settings.renderInSceneView) return;
        }
        else if (!settings.renderInGameView)
        {
            return;
        }

        pass.renderPassEvent = settings.injectionPoint;
        pass.ConfigureInput(settings.inputSource == InputSource.Live
            ? ScriptableRenderPassInput.Depth
            : ScriptableRenderPassInput.None);
        renderer.EnqueuePass(pass);
    }

    sealed class Pass : ScriptableRenderPass
    {
        static readonly int GlobalTextureId = Shader.PropertyToID(GlobalTextureName);
        static readonly int Id15 = Shader.PropertyToID("_15");
        static readonly int Id22 = Shader.PropertyToID("_22");
        static readonly int Id23 = Shader.PropertyToID("_23");
        static readonly int Id24 = Shader.PropertyToID("_24");
        static readonly int Id25 = Shader.PropertyToID("_25");
        static readonly int Id27 = Shader.PropertyToID("_27");
        static readonly int Id56 = Shader.PropertyToID("_5_6");
        static readonly int Id78 = Shader.PropertyToID("_7_8");
        static readonly int Id1617 = Shader.PropertyToID("_16_17");
        static readonly int Id2021 = Shader.PropertyToID("_20_21");
        static readonly int LiveBlurId = Shader.PropertyToID("_EndfieldGTAOBlur");
        static readonly int LiveContactId = Shader.PropertyToID("_EndfieldContact");
        static readonly int CameraDepthTextureId = Shader.PropertyToID("_CameraDepthTexture");
        static readonly int IdUseLiveCamera = Shader.PropertyToID("_EID4649UseLiveCamera");
        static readonly int IdClipToWorld = Shader.PropertyToID("_EID4649ClipToWorld");
        static readonly int IdCameraPositionWS = Shader.PropertyToID("_EID4649CameraPositionWS");
        static readonly int IdScreenSize = Shader.PropertyToID("_EID4649ScreenSize");

        readonly Settings settings;
        readonly Material materialGame;
        readonly Material materialScene;
        RTHandle colorTargetGame;
        RTHandle colorTargetScene;
        RTHandle depthCopyGame;
        RTHandle depthCopyScene;
        RTHandle liveBlurGame;
        RTHandle liveBlurScene;
        RTHandle liveContactGame;
        RTHandle liveContactScene;
        readonly MaterialPropertyBlock propertyBlock = new MaterialPropertyBlock();
        ComputeBuffer uniforms6;
        ComputeBuffer uniforms8;
        ComputeBuffer uniforms17;
        ComputeBuffer uniforms21;
        Texture cached22;
        Texture cached23;
        Texture cached25;
        Texture cached15Fallback;
        Texture cached24Fallback;
        Texture cached27Fallback;
        RenderTexture lightPass29Game;
        RenderTexture lightPass29Scene;
        bool buffersReady;
        bool capturedReady;
        bool warnedMissing;
        bool loggedBind;

        public Pass(Settings settings, Material materialGame, Material materialScene)
        {
            this.settings = settings;
            this.materialGame = materialGame;
            this.materialScene = materialScene;
            profilingSampler = new ProfilingSampler("EID4649 Colour Pass #20");
        }

        public void Dispose()
        {
            colorTargetGame?.Release();
            colorTargetScene?.Release();
            colorTargetGame = null;
            colorTargetScene = null;
            depthCopyGame?.Release();
            depthCopyScene?.Release();
            depthCopyGame = null;
            depthCopyScene = null;
            liveBlurGame?.Release();
            liveBlurScene?.Release();
            liveContactGame?.Release();
            liveContactScene?.Release();
            liveBlurGame = null;
            liveBlurScene = null;
            liveContactGame = null;
            liveContactScene = null;
            uniforms6?.Release();
            uniforms8?.Release();
            uniforms17?.Release();
            uniforms21?.Release();
            uniforms6 = null;
            uniforms8 = null;
            uniforms17 = null;
            uniforms21 = null;
            buffersReady = false;
            capturedReady = false;
            cached22 = cached23 = cached25 = null;
            cached15Fallback = cached24Fallback = cached27Fallback = null;
            ReleaseSnap(ref lightPass29Game);
            ReleaseSnap(ref lightPass29Scene);
            ClearDeferredLightPass29Override();
        }

        public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
        {
            bool gameCam = IsGameCamera(ref renderingData);
            GetOutputSize(ref renderingData, out int width, out int height);
            RTHandle colorTarget = EnsureColorTarget(gameCam, width, height);
            if (colorTarget != null)
                ConfigureTarget(colorTarget);
            ConfigureClear(ClearFlag.None, Color.clear);
        }

        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            bool gameCam = IsGameCamera(ref renderingData);
            GetOutputSize(ref renderingData, out int width, out int height);
            RTHandle colorTarget = EnsureColorTarget(gameCam, width, height);
            Material material = gameCam ? materialGame : materialScene;
            if (colorTarget == null || material == null)
                return;
            if (!EnsureConstantBuffers())
                return;

            CommandBuffer cmd = CommandBufferPool.Get("EID4649 Colour Pass #20");
            try
            {
                if (!BindTextures(cmd, ref renderingData, material, gameCam, width, height, out Texture tex15, out Texture tex24, out Texture tex27))
                {
                    if (!gameCam)
                    {
                        RestoreGameGlobals(cmd);
                        context.ExecuteCommandBuffer(cmd);
                    }
                    return;
                }

                BindLiveCamera(material, renderingData.cameraData.camera, width, height);

                material.SetConstantBuffer(Id56, uniforms6, 0, Uniforms6Bytes);
                material.SetConstantBuffer(Id78, uniforms8, 0, Uniforms8Bytes);
                material.SetConstantBuffer(Id1617, uniforms17, 0, Uniforms17Bytes);
                material.SetConstantBuffer(Id2021, uniforms21, 0, Uniforms21Bytes);

                FillPropertyBlock(material, tex15, tex24, tex27);
                cmd.SetRenderTarget(colorTarget);
                cmd.SetViewport(new Rect(0f, 0f, width, height));
                cmd.DrawProcedural(Matrix4x4.identity, material, 0, MeshTopology.Triangles, 3, 1, propertyBlock);
                if (gameCam)
                    cmd.SetGlobalTexture(GlobalTextureId, colorTarget);

                if (settings.liveCapture == InputSource.Live && colorTarget.rt != null)
                {
                    RenderTexture snap = gameCam ? lightPass29Game : lightPass29Scene;
                    EnsureSnap(ref snap, gameCam ? "_EID4649_LightPass29_Game" : "_EID4649_LightPass29_Scene", width, height);
                    if (gameCam)
                        lightPass29Game = snap;
                    else
                        lightPass29Scene = snap;
                    if (snap != null && snap.IsCreated())
                    {
                        cmd.Blit(colorTarget, snap);
                        PublishDeferredLightPass29Override(true, gameCam, snap);
                    }
                }
                else
                {
                    PublishDeferredLightPass29Override(false, gameCam, null);
                }

                if (!gameCam)
                    RestoreGameGlobals(cmd);

                context.ExecuteCommandBuffer(cmd);
            }
            finally
            {
                CommandBufferPool.Release(cmd);
            }
        }

        bool BindTextures(CommandBuffer cmd, ref RenderingData renderingData, Material material, bool gameCam, int width, int height, out Texture tex15, out Texture tex24, out Texture tex27)
        {
            tex15 = null;
            tex24 = null;
            tex27 = null;
            if (!capturedReady)
            {
                cached22 = Resolve(settings.tex22_209068, NativeRoot + "rid209068.asset");
                cached23 = Resolve(settings.tex23_198185, NativeRoot + "rid198185.asset");
                cached25 = Resolve(settings.tex25_209071, NativeRoot + "rid209071.asset");
                cached15Fallback = Resolve(settings.tex15_209560, NativeRoot + "rid209560.asset");
                cached24Fallback = Resolve(settings.tex24_209590, NativeRoot + "rid209590.asset");
                cached27Fallback = Resolve(settings.tex27_209587, Contact209587);
                capturedReady = true;
            }

            tex15 = ResolveTex15(cmd, ref renderingData, gameCam, width, height);
            tex24 = ResolveTex24(cmd, gameCam);
            tex27 = ResolveTex27(cmd, gameCam);

            if (tex15 == null || cached22 == null || cached23 == null || tex24 == null || cached25 == null || tex27 == null)
            {
                if (!warnedMissing)
                {
                    Debug.LogError("[EID4649] Missing inputs. "
                        + "15(GBufferDepth)=" + (tex15 != null)
                        + " 22=" + (cached22 != null)
                        + " 23=" + (cached23 != null)
                        + " 24(_EndfieldGTAOBlur)=" + (tex24 != null)
                        + " 25=" + (cached25 != null)
                        + " 27(_EndfieldContact)=" + (tex27 != null));
                    warnedMissing = true;
                }
                return false;
            }

            material.SetTexture(Id15, tex15);
            material.SetTexture(Id22, cached22);
            material.SetTexture(Id23, cached23);
            material.SetTexture(Id24, tex24);
            material.SetTexture(Id25, cached25);
            material.SetTexture(Id27, tex27);

            if (!loggedBind)
            {
                loggedBind = true;
                Debug.Log("[EID4649] bind source=" + settings.inputSource
                    + " _15=" + Describe(tex15)
                    + " _24=" + Describe(tex24)
                    + " _27=" + Describe(tex27));
            }
            return true;
        }

        void FillPropertyBlock(Material material, Texture tex15, Texture tex24, Texture tex27)
        {
            propertyBlock.Clear();
            propertyBlock.SetTexture(Id15, tex15);
            propertyBlock.SetTexture(Id22, cached22);
            propertyBlock.SetTexture(Id23, cached23);
            propertyBlock.SetTexture(Id24, tex24);
            propertyBlock.SetTexture(Id25, cached25);
            propertyBlock.SetTexture(Id27, tex27);
            propertyBlock.SetFloat(IdUseLiveCamera, material.GetFloat(IdUseLiveCamera));
            propertyBlock.SetMatrix(IdClipToWorld, material.GetMatrix(IdClipToWorld));
            propertyBlock.SetVector(IdCameraPositionWS, material.GetVector(IdCameraPositionWS));
            propertyBlock.SetVector(IdScreenSize, material.GetVector(IdScreenSize));
        }

        void BindLiveCamera(Material material, Camera camera, int width, int height)
        {
            bool useLive = settings.inputSource == InputSource.Live && camera != null;
            material.SetFloat(IdUseLiveCamera, useLive ? 1f : 0f);
            if (!useLive)
                return;

            Matrix4x4 worldToClip;
            Vector3 cameraPosition;
            var controller = UnityEngine.Object.FindObjectOfType<EID3332CombinedDeferredController>();
            if (controller != null && controller.IsForCamera(camera))
            {
                worldToClip = controller.GetViewProjection(camera);
                cameraPosition = controller.GetCameraPosition(camera);
            }
            else
            {
                worldToClip = GL.GetGPUProjectionMatrix(camera.projectionMatrix, true) * camera.worldToCameraMatrix;
                cameraPosition = camera.worldToCameraMatrix.inverse.GetColumn(3);
            }

            material.SetMatrix(IdClipToWorld, worldToClip.inverse);
            material.SetVector(IdCameraPositionWS, new Vector4(cameraPosition.x, cameraPosition.y, cameraPosition.z, 1f));
            material.SetVector(IdScreenSize, new Vector4(width, height, 1f / width, 1f / height));
        }

        Texture ResolveTex15(CommandBuffer cmd, ref RenderingData renderingData, bool gameCam, int width, int height)
        {
            if (settings.inputSource == InputSource.Captured)
                return cached15Fallback;
            Texture live = ResolveLiveGBufferDepth(cmd, ref renderingData, gameCam, width, height);
            if (live != null)
                return live;
            if (!warnedMissing)
                Debug.LogWarning("[EID4649] Live GBuffer depth missing; falling back to captured 209560.");
            return cached15Fallback;
        }

        Texture ResolveTex24(CommandBuffer cmd, bool gameCam)
        {
            if (settings.inputSource == InputSource.Captured)
                return cached24Fallback;
            Texture live = Shader.GetGlobalTexture(LiveBlurId);
            if (!IsUsable(live))
            {
                if (!warnedMissing)
                    Debug.LogWarning("[EID4649] Live _EndfieldGTAOBlur missing; falling back to captured 209590.");
                return cached24Fallback;
            }
            return CopyColorToCameraRT(cmd, live, gameCam, ref liveBlurGame, ref liveBlurScene,
                gameCam ? "_EID4649GTAOBlur_Game" : "_EID4649GTAOBlur_Scene", GraphicsFormat.R8_UNorm);
        }

        Texture ResolveTex27(CommandBuffer cmd, bool gameCam)
        {
            if (settings.inputSource == InputSource.Captured)
                return cached27Fallback;
            Texture live = Shader.GetGlobalTexture(LiveContactId);
            if (!IsUsable(live))
            {
                if (!warnedMissing)
                    Debug.LogWarning("[EID4649] Live _EndfieldContact missing; falling back to captured 209587.");
                return cached27Fallback;
            }
            return CopyColorToCameraRT(cmd, live, gameCam, ref liveContactGame, ref liveContactScene,
                gameCam ? "_EID4649Contact_Game" : "_EID4649Contact_Scene", GraphicsFormat.R8G8_UNorm);
        }

        Texture ResolveLiveGBufferDepth(CommandBuffer cmd, ref RenderingData renderingData, bool gameCam, int width, int height)
        {
            Camera camera = renderingData.cameraData.camera;
            var controller = UnityEngine.Object.FindObjectOfType<EID3332CombinedDeferredController>();
            bool fiveMrt = controller != null && controller.UseEID3336FiveMRT(camera);
            if (controller != null && controller.IsForCamera(camera) && controller.targets != null && !fiveMrt)
            {
                RenderTexture depthDebug = controller.targets.DepthDebug;
                if (IsSampleableColor(depthDebug))
                    return depthDebug;
                RenderTexture sceneDepth = controller.targets.Depth;
                if (IsUsable(sceneDepth))
                    return CopyDepthToR32F(cmd, sceneDepth, gameCam, width, height);
            }

            RTHandle cameraDepth = renderingData.cameraData.renderer != null
                ? renderingData.cameraData.renderer.cameraDepthTargetHandle
                : null;
            if (cameraDepth != null && cameraDepth.rt != null && IsUsable(cameraDepth.rt))
                return CopyDepthToR32F(cmd, cameraDepth.rt, gameCam, width, height);

            Texture cameraDepthTex = Shader.GetGlobalTexture(CameraDepthTextureId);
            if (IsUsable(cameraDepthTex))
                return CopyDepthToR32F(cmd, cameraDepthTex, gameCam, width, height);

            return null;
        }

        Texture CopyDepthToR32F(CommandBuffer cmd, Texture source, bool gameCam, int width, int height)
        {
            if (cmd == null || !IsUsable(source))
                return null;
            var desc = new RenderTextureDescriptor(width, height)
            {
                msaaSamples = 1,
                graphicsFormat = GraphicsFormat.R32_SFloat,
                depthBufferBits = 0,
                depthStencilFormat = GraphicsFormat.None,
                sRGB = false,
                mipCount = 1,
                useMipMap = false,
                autoGenerateMips = false,
                enableRandomWrite = false
            };
            RTHandle depthCopy = gameCam ? depthCopyGame : depthCopyScene;
            RenderingUtils.ReAllocateIfNeeded(ref depthCopy, desc, FilterMode.Point, TextureWrapMode.Clamp,
                name: gameCam ? "_EID4649GBufferDepth_Game" : "_EID4649GBufferDepth_Scene");
            if (gameCam)
                depthCopyGame = depthCopy;
            else
                depthCopyScene = depthCopy;
            if (depthCopy == null)
                return null;
            cmd.Blit(source, depthCopy);
            return depthCopy;
        }

        Texture CopyColorToCameraRT(CommandBuffer cmd, Texture source, bool gameCam, ref RTHandle gameRT, ref RTHandle sceneRT, string name, GraphicsFormat format)
        {
            if (cmd == null || !IsUsable(source))
                return null;
            int width = Mathf.Max(1, source.width);
            int height = Mathf.Max(1, source.height);
            var desc = new RenderTextureDescriptor(width, height)
            {
                msaaSamples = 1,
                graphicsFormat = format,
                depthBufferBits = 0,
                depthStencilFormat = GraphicsFormat.None,
                sRGB = false,
                mipCount = 1,
                useMipMap = false,
                autoGenerateMips = false,
                enableRandomWrite = false
            };
            RTHandle dest = gameCam ? gameRT : sceneRT;
            RenderingUtils.ReAllocateIfNeeded(ref dest, desc, FilterMode.Point, TextureWrapMode.Clamp, name: name);
            if (gameCam)
                gameRT = dest;
            else
                sceneRT = dest;
            if (dest == null)
                return null;
            cmd.Blit(source, dest);
            return dest;
        }

        void RestoreGameGlobals(CommandBuffer cmd)
        {
            if (cmd == null)
                return;
            if (colorTargetGame != null)
                cmd.SetGlobalTexture(GlobalTextureId, colorTargetGame);
            if (liveBlurGame != null)
                cmd.SetGlobalTexture(LiveBlurId, liveBlurGame);
            if (liveContactGame != null)
                cmd.SetGlobalTexture(LiveContactId, liveContactGame);
        }

        RTHandle EnsureColorTarget(bool gameCam, int width, int height)
        {
            var desc = new RenderTextureDescriptor(width, height)
            {
                msaaSamples = 1,
                graphicsFormat = GraphicsFormat.R8G8_UNorm,
                depthBufferBits = 0,
                depthStencilFormat = GraphicsFormat.None,
                sRGB = false,
                mipCount = 1,
                useMipMap = false,
                autoGenerateMips = false,
                enableRandomWrite = false
            };
            RTHandle colorTarget = gameCam ? colorTargetGame : colorTargetScene;
            RenderingUtils.ReAllocateIfNeeded(ref colorTarget, desc, FilterMode.Point, TextureWrapMode.Clamp,
                name: gameCam ? GlobalTextureName + "_Game" : GlobalTextureName + "_Scene");
            if (gameCam)
                colorTargetGame = colorTarget;
            else
                colorTargetScene = colorTarget;
            return colorTarget;
        }

        void GetOutputSize(ref RenderingData renderingData, out int width, out int height)
        {
            if (settings.inputSource == InputSource.Captured)
            {
                width = CapturedWidth;
                height = CapturedHeight;
                return;
            }
            width = Mathf.Max(1, renderingData.cameraData.cameraTargetDescriptor.width);
            height = Mathf.Max(1, renderingData.cameraData.cameraTargetDescriptor.height);
        }

        static bool IsGameCamera(ref RenderingData renderingData)
        {
            Camera camera = renderingData.cameraData.camera;
            return camera != null
                && camera.cameraType == CameraType.Game
                && !renderingData.cameraData.isSceneViewCamera;
        }

        static void EnsureSnap(ref RenderTexture rt, string name, int width, int height)
        {
            if (rt != null && rt.IsCreated() && rt.width == width && rt.height == height &&
                rt.graphicsFormat == GraphicsFormat.R8G8_UNorm)
                return;
            ReleaseSnap(ref rt);
            var desc = new RenderTextureDescriptor(width, height)
            {
                msaaSamples = 1,
                graphicsFormat = GraphicsFormat.R8G8_UNorm,
                depthBufferBits = 0,
                depthStencilFormat = GraphicsFormat.None,
                sRGB = false,
                mipCount = 1,
                useMipMap = false,
                autoGenerateMips = false,
                enableRandomWrite = false
            };
            rt = new RenderTexture(desc)
            {
                name = name,
                filterMode = FilterMode.Point,
                wrapMode = TextureWrapMode.Clamp,
                hideFlags = HideFlags.HideAndDontSave
            };
            rt.Create();
        }

        static void ReleaseSnap(ref RenderTexture rt)
        {
            if (rt == null)
                return;
            rt.Release();
            CoreUtils.Destroy(rt);
            rt = null;
        }

        static bool IsUsable(Texture texture)
        {
            return texture != null && texture.width > 0 && texture.height > 0;
        }

        static bool IsSampleableColor(RenderTexture rt)
        {
            return rt != null && rt.IsCreated() && rt.width > 0 && rt.height > 0 && rt.graphicsFormat != GraphicsFormat.None;
        }

        static string Describe(Texture texture)
        {
            if (texture == null) return "null";
            return texture.name + " " + texture.width + "x" + texture.height;
        }

        static Texture Resolve(Texture assigned, string assetPath)
        {
            if (assigned != null) return assigned;
#if UNITY_EDITOR
            return AssetDatabase.LoadAssetAtPath<Texture>(assetPath);
#else
            return null;
#endif
        }

        bool EnsureConstantBuffers()
        {
            if (buffersReady)
                return uniforms6 != null && uniforms8 != null && uniforms17 != null && uniforms21 != null;

            uniforms6 = CreateConstantBuffer(BufferRoot + "cb_526_369408.bytes", Uniforms6Bytes);
            uniforms17 = CreateConstantBuffer(BufferRoot + "cb_526_321280.bytes", Uniforms17Bytes);
            uniforms21 = CreateConstantBuffer(BufferRoot + "cb_526_431104.bytes", Uniforms21Bytes);
            uniforms8 = CreateConstantBuffer(BufferRoot + "cb_526_370944.bytes", Uniforms8Bytes);
            buffersReady = true;
            if (uniforms6 == null || uniforms8 == null || uniforms17 == null || uniforms21 == null)
            {
                Debug.LogError("[EID4649] Captured constant buffers are missing or the wrong size.");
                return false;
            }
            return true;
        }

        static ComputeBuffer CreateConstantBuffer(string assetPath, int expectedSize)
        {
            string path = Path.Combine(Directory.GetParent(Application.dataPath).FullName,
                assetPath.Replace('/', Path.DirectorySeparatorChar));
            if (!File.Exists(path))
                return null;
            byte[] bytes = File.ReadAllBytes(path);
            if (bytes.Length != expectedSize || (bytes.Length & 15) != 0)
                return null;
            int count = bytes.Length / 16;
            var words = new UInt4[count];
            for (int i = 0; i < count; ++i)
            {
                words[i].x = BitConverter.ToUInt32(bytes, i * 16 + 0);
                words[i].y = BitConverter.ToUInt32(bytes, i * 16 + 4);
                words[i].z = BitConverter.ToUInt32(bytes, i * 16 + 8);
                words[i].w = BitConverter.ToUInt32(bytes, i * 16 + 12);
            }
            var buffer = new ComputeBuffer(count, 16, ComputeBufferType.Constant);
            buffer.SetData(words);
            return buffer;
        }

        struct UInt4
        {
            public uint x, y, z, w;
        }
    }
}
