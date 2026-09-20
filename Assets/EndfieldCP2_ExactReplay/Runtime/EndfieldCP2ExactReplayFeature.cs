using System;
using System.IO;
using System.Reflection;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
#if UNITY_EDITOR
using UnityEditor;
#endif

public sealed class EndfieldCP2ExactReplayFeature : ScriptableRendererFeature
{
    public const int FullWidth = 1366;
    public const int FullHeight = 768;
    public const int HalfWidth = 683;
    public const int HalfHeight = 384;
    public const int HiZMipCount = 7;
    public const int Uniforms14Bytes = 48;
    public const int Uniforms14Slot = 256;
    public const int Uniforms14DownBytes = 6 * Uniforms14Slot;
    public const int HiZGroupsX = 86;
    public const int HiZGroupsY = 48;

    public static readonly int[] HiZMipWidth = { 683, 342, 171, 86, 43, 22, 11 };
    public static readonly int[] HiZMipHeight = { 384, 192, 96, 48, 24, 12, 6 };
    public static readonly int[] HiZDownGroupsX = { 43, 22, 11, 6, 3, 2 };
    public static readonly int[] HiZDownGroupsY = { 24, 12, 6, 3, 2, 1 };

    public const int LinDepthMipCount = 5;
    public const int Uniforms6Bytes = 3200;
    public const int Uniforms11Bytes = 80;
    public const int LinDepthGroupsX = 43;
    public const int LinDepthGroupsY = 24;
    public static readonly int[] LinDepthMipWidth = { 683, 342, 171, 86, 43 };
    public static readonly int[] LinDepthMipHeight = { 384, 192, 96, 48, 24 };

    public const int Uniforms5Bytes = 1312;
    public const int Uniforms10Bytes = 80;
    public const int Uniforms8Bytes = 80;
    public const int GtaoGroupsX = 86;
    public const int GtaoGroupsY = 48;
    public const int BlurGroupsX = 43;
    public const int BlurGroupsY = 48;
    public const int Uniforms6ContactBytes = 1312;
    public const int Uniforms11ContactBytes = 80;
    public const int ContactGroupsX = 64;
    public const int ContactGroupsY = 23;
    public const int ContactGroupsZ = 14;

    public enum DebugPreview
    {
        AO = 0,
        SSR = 1,
        SSRMask = 2,
        Contact = 3,
        HiZ = 4,
        LinDepth = 5,
        GTAO = 6,
        Temporal = 7,
        Blur = 8,
        Blur2 = 9
    }

    public enum HiZDepthSource
    {
        Captured209535 = 0,
        LiveGBuffer = 1
    }

    [Serializable]
    public sealed class Settings
    {
        public EndfieldCP2ExactReplayInputs inputs;
        public ComputeShader hizBuild;
        public ComputeShader hizDown;
        public ComputeShader linDepth;
        public ComputeShader gtao;
        public ComputeShader aoTemporal;
        public ComputeShader aoBlur;
        public ComputeShader aoBlur2;
        public ComputeShader contactShadow;
        public RenderPassEvent injectionPoint = RenderPassEvent.AfterRenderingGbuffer;
        public bool renderInGameView = true;
        public bool renderInSceneView = true;
        public bool enabledForCamera = true;
        [Tooltip("Frame Debugger 里本 Pass 显示哪张 RT。默认 AO。不写 Camera Color。")]
        public DebugPreview debugPreview = DebugPreview.AO;
        [Tooltip("非空时只跑名字包含这段的相机。留空 = 当前 Renderer 上的 Game/Scene 相机都跑。物体名是 EID3336 RenderDoc Camera。")]
        public string cameraNameContains = "";
        [Tooltip("EID4486 HiZ / EID4514 LinDepth 的 _Depth，以及 EID4518 GTAO 的 _OctNormal。Captured209535 = 4486 用 rid209535、4514 用 rid209543、4518 用 rid209566。LiveGBuffer = Combined/FiveMRT 深度 + RT3 octa normal。不要绑 GBuffer2 / _CameraNormalsTexture。CB 仍冻结。")]
        public HiZDepthSource hizDepthSource = HiZDepthSource.Captured209535;
        [Tooltip("总开关。开：延迟光 _20=ExactReplay GTAO（半分辨率，尚未 EID4534 upsample）、_33=EID4594 Contact UAV。关：仍用捕获 ssao_b18 / reflection_visibility_b22。不改 FS 算术，不绑 _18/_19。")]
        public bool bindDeferredLightPass;
    }

    public Settings settings = new Settings();
    Pass pass;
    static Texture lightPassAOGame;
    static Texture lightPassContactGame;
    static Texture lightPassAOScene;
    static Texture lightPassContactScene;
    static bool lightPassOverride;

    public override void Create()
    {
        pass = new Pass(settings);
        pass.renderPassEvent = settings.injectionPoint;
    }

    protected override void Dispose(bool disposing)
    {
        pass?.Dispose();
        pass = null;
        ClearDeferredLightPassOverride();
    }

    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        if (pass == null || !settings.enabledForCamera)
        {
            ClearDeferredLightPassOverride();
            return;
        }

        Camera camera = renderingData.cameraData.camera;
        if (camera == null || camera.cameraType == CameraType.Preview || camera.cameraType == CameraType.Reflection)
            return;
        if (renderingData.cameraData.isSceneViewCamera)
        {
            if (!settings.renderInSceneView)
                return;
        }
        else if (!settings.renderInGameView)
        {
            return;
        }

        if (!string.IsNullOrEmpty(settings.cameraNameContains) &&
            camera.name.IndexOf(settings.cameraNameContains, StringComparison.Ordinal) < 0)
            return;

        pass.renderPassEvent = settings.injectionPoint;
        pass.ConfigureInput(settings.hizDepthSource == HiZDepthSource.LiveGBuffer
            ? ScriptableRenderPassInput.Depth
            : ScriptableRenderPassInput.None);
        renderer.EnqueuePass(pass);
    }

    public static void ApplyDeferredLightPassOverride(Material material, Camera camera)
    {
        if (material == null || !lightPassOverride)
            return;
        bool gameCam = camera != null && camera.cameraType == CameraType.Game;
        Texture ao = gameCam ? lightPassAOGame : lightPassAOScene;
        Texture contact = gameCam ? lightPassContactGame : lightPassContactScene;
        if (ao != null)
            material.SetTexture("_20", ao);
        if (contact != null)
            material.SetTexture("_33", contact);
    }

    static void ClearDeferredLightPassOverride()
    {
        lightPassOverride = false;
        lightPassAOGame = null;
        lightPassContactGame = null;
        lightPassAOScene = null;
        lightPassContactScene = null;
    }

    static void PublishDeferredLightPassOverride(bool enabled, bool gameCam, Texture ao, Texture contact)
    {
        lightPassOverride = enabled;
        if (!enabled)
        {
            if (gameCam)
            {
                lightPassAOGame = null;
                lightPassContactGame = null;
            }
            else
            {
                lightPassAOScene = null;
                lightPassContactScene = null;
            }
            return;
        }

        if (gameCam)
        {
            lightPassAOGame = ao;
            lightPassContactGame = contact;
        }
        else
        {
            lightPassAOScene = ao;
            lightPassContactScene = contact;
        }
    }

    sealed class Pass : ScriptableRenderPass
    {
        static readonly int GlobalAO = Shader.PropertyToID("_EndfieldAO");
        static readonly int GlobalSSR = Shader.PropertyToID("_EndfieldSSR");
        static readonly int GlobalSSRMask = Shader.PropertyToID("_EndfieldSSRMask");
        static readonly int GlobalContact = Shader.PropertyToID("_EndfieldContact");
        static readonly int GlobalHiZ = Shader.PropertyToID("_EndfieldHiZ");
        static readonly int GlobalLinDepth = Shader.PropertyToID("_EndfieldLinDepth");
        static readonly int GlobalGTAO = Shader.PropertyToID("_EndfieldGTAO");
        static readonly int GlobalGTAOEdge = Shader.PropertyToID("_EndfieldGTAOEdge");
        static readonly int GlobalOctNormal = Shader.PropertyToID("_EndfieldOctNormal");
        static readonly int GlobalTemporal = Shader.PropertyToID("_EndfieldGTAOTemporal");
        static readonly int GlobalBlur = Shader.PropertyToID("_EndfieldGTAOBlur");
        static readonly int DepthId = Shader.PropertyToID("_Depth");
        static readonly int HiZId = Shader.PropertyToID("_HiZ");
        static readonly int HiZSrcId = Shader.PropertyToID("_HiZSrc");
        static readonly int HiZDstId = Shader.PropertyToID("_HiZDst");
        static readonly int[] LinDepthIds =
        {
            Shader.PropertyToID("_LinDepth0"),
            Shader.PropertyToID("_LinDepth1"),
            Shader.PropertyToID("_LinDepth2"),
            Shader.PropertyToID("_LinDepth3"),
            Shader.PropertyToID("_LinDepth4")
        };
        static readonly int Uniforms14Id = Shader.PropertyToID("uniforms14");
        static readonly int Uniforms6Id = Shader.PropertyToID("uniforms6");
        static readonly int Uniforms11Id = Shader.PropertyToID("uniforms11");
        static readonly int Uniforms5Id = Shader.PropertyToID("uniforms5");
        static readonly int Uniforms10Id = Shader.PropertyToID("uniforms10");
        static readonly int Uniforms8Id = Shader.PropertyToID("uniforms8");
        static readonly int OctNormalId = Shader.PropertyToID("_OctNormal");
        static readonly int GtaoId = Shader.PropertyToID("_GTAO");
        static readonly int GtaoEdgeId = Shader.PropertyToID("_GTAOEdge");
        static readonly int MotionId = Shader.PropertyToID("_Motion");
        static readonly int HistoryId = Shader.PropertyToID("_History");
        static readonly int TemporalId = Shader.PropertyToID("_Temporal");
        static readonly int BlurId = Shader.PropertyToID("_Blur");
        static readonly int ContactId = Shader.PropertyToID("_Contact");
        static readonly int Child0Id = Shader.PropertyToID("_child0");
        static readonly int Child1Id = Shader.PropertyToID("_child1");
        static readonly int Child2Id = Shader.PropertyToID("_child2");
        static readonly int Child3Id = Shader.PropertyToID("_child3");
        static readonly int GBuffer3Id = Shader.PropertyToID("_GBuffer3");

        const string ImportedRoot =
            "Assets/EID3332_EID3336_Combined/DeferredLighting/EID4662Full/Resources/Imported/";
        const string CapturedRoot = "Assets/EndfieldCP2_ExactReplay/Captured";
        const string HiZShaderPath = "Assets/EndfieldCP2_ExactReplay/Shaders/EID4486_HiZBuild.compute";
        const string HiZDownShaderPath = "Assets/EndfieldCP2_ExactReplay/Shaders/EID4490_HiZDown.compute";
        const string LinDepthShaderPath = "Assets/EndfieldCP2_ExactReplay/Shaders/EID4514_LinDepth.compute";
        const string GtaoShaderPath = "Assets/EndfieldCP2_ExactReplay/Shaders/EID4518_GTAO.compute";
        const string AoTemporalShaderPath = "Assets/EndfieldCP2_ExactReplay/Shaders/EID4522_AOTemporal.compute";
        const string AoBlurShaderPath = "Assets/EndfieldCP2_ExactReplay/Shaders/EID4526_AOBlur.compute";
        const string AoBlur2ShaderPath = "Assets/EndfieldCP2_ExactReplay/Shaders/EID4530_AOBlur2.compute";
        const string ContactShadowShaderPath = "Assets/EndfieldCP2_ExactReplay/Shaders/EID4594_ContactShadow.compute";
        const string Depth543Path =
            "Assets/EID4662_ComputePass2/CapturedResources/Native/rid209543_depth_r32f.asset";
        const string OctNormalPath =
            "Assets/EndfieldCP2_ExactReplay/Captured/UnityNative/rid209566_oct_normal.asset";
        const string Motion210525Path =
            "Assets/EID4662_ComputePass2/CapturedResources/Native/rid210525.asset";
        const string History209486Path =
            "Assets/EndfieldCP2_ExactReplay/Captured/UnityNative/rid209486_history.asset";

        readonly Settings settings;
        readonly ProfilingSampler baselineSampler = new ProfilingSampler("Endfield CP2 Baseline");
        readonly ProfilingSampler hizSampler = new ProfilingSampler("Endfield CP2 EID4486 HiZ mip0");
        readonly ProfilingSampler hizDownSampler = new ProfilingSampler("Endfield CP2 EID4490 HiZ mip1-6");
        readonly ProfilingSampler linDepthSampler = new ProfilingSampler("Endfield CP2 EID4514 LinDepth");
        readonly ProfilingSampler gtaoSampler = new ProfilingSampler("Endfield CP2 EID4518 GTAO");
        readonly ProfilingSampler temporalSampler = new ProfilingSampler("Endfield CP2 EID4522 Temporal");
        readonly ProfilingSampler blurSampler = new ProfilingSampler("Endfield CP2 EID4526 Blur");
        readonly ProfilingSampler blur2Sampler = new ProfilingSampler("Endfield CP2 EID4530 Blur2");
        readonly ProfilingSampler contactSampler = new ProfilingSampler("Endfield CP2 EID4594 Contact");
        RTHandle aoRT;
        RTHandle ssrRT;
        RTHandle maskRT;
        RTHandle contactRT;
        readonly RenderTexture[] hizMips = new RenderTexture[HiZMipCount];
        RenderTexture hizSrcRT;
        RenderTexture octNormalSrcRT;
        readonly RenderTexture[] linDepthMips = new RenderTexture[LinDepthMipCount];
        RenderTexture gtaoRT;
        RenderTexture gtaoEdgeRT;
        readonly RenderTexture[] temporalPing = new RenderTexture[2];
        RenderTexture temporalCurrent;
        Texture temporalHistBound;
        int temporalWriteIndex;
        bool temporalHistoryValid;
        RenderTexture blurRT;
        RenderTexture contactShadowRTGame;
        RenderTexture contactShadowRTScene;
        RenderTexture lightPassAoGame;
        RenderTexture lightPassAoScene;
        ComputeBuffer uniforms14;
        readonly ComputeBuffer[] uniforms14DownSlots = new ComputeBuffer[6];
        ComputeBuffer uniforms6;
        ComputeBuffer uniforms11;
        ComputeBuffer uniforms5;
        ComputeBuffer uniforms10;
        ComputeBuffer uniforms8;
        ComputeBuffer uniforms6Contact;
        ComputeBuffer uniforms11Contact;
        int hizKernel = -1;
        int hizDownKernel = -1;
        int linDepthKernel = -1;
        int gtaoKernel = -1;
        int temporalKernel = -1;
        int blurKernel = -1;
        int blur2Kernel = -1;
        int contactKernel = -1;
        bool logged;
        bool warned;
        bool warnedHiZ;
        bool warnedLiveDepth;
        bool warnedLiveOctNormal;
        Texture lastOctNormal;
        static FieldInfo deferredLightsField;
        static PropertyInfo useFiveMrtProperty;
        static PropertyInfo gbufferAttachmentsProperty;
        bool warnedHiZDown;
        bool warnedLinDepth;
        bool warnedGtao;
        bool warnedTemporal;
        bool warnedBlur;
        bool warnedBlur2;
        bool warnedContact;

        public Pass(Settings settings)
        {
            this.settings = settings;
        }

        public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
        {
            Allocate(ref aoRT, FullWidth, FullHeight, GraphicsFormat.R8_UNorm, "_EndfieldAO");
            Allocate(ref ssrRT, HalfWidth, HalfHeight, GraphicsFormat.R32G32B32A32_SFloat, "_EndfieldSSR");
            Allocate(ref maskRT, HalfWidth, HalfHeight, GraphicsFormat.R8_UNorm, "_EndfieldSSRMask");
            Allocate(ref contactRT, FullWidth, FullHeight, GraphicsFormat.R8G8B8A8_UNorm, "_EndfieldContact");
            EnsureHiZ();
            EnsureLinDepth();
            EnsureGtao();
            EnsureTemporal();
            EnsureBlur();
            EnsureContactShadow();

            ConfigureTarget(renderingData.cameraData.renderer.cameraColorTargetHandle);
            ConfigureClear(ClearFlag.None, Color.clear);
        }

        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            Texture ao = Resolve(settings.inputs != null ? settings.inputs.aoFull : null, "ssao_b18");
            Texture ssr = Resolve(settings.inputs != null ? settings.inputs.ssrColor : null, "screen_specular_color_b7");
            Texture mask = Resolve(settings.inputs != null ? settings.inputs.ssrMask : null, "screen_specular_weight_b8");
            Texture contact = Resolve(settings.inputs != null ? settings.inputs.contact : null, "reflection_visibility_b22");
            if (ao == null && ssr == null && mask == null && contact == null)
            {
                ClearDeferredLightPassOverride();
                if (!warned)
                {
                    Debug.LogError("[Endfield CP2] Baseline captured textures missing (ssao_b18 / b7 / b8 / b22).");
                    warned = true;
                }
                return;
            }

            CommandBuffer cmd = CommandBufferPool.Get("Endfield CP2");
            using (new ProfilingScope(cmd, baselineSampler))
            {
                CopyOrBlit(cmd, ao, aoRT);
                CopyOrBlit(cmd, ssr, ssrRT);
                CopyOrBlit(cmd, mask, maskRT);
                CopyOrBlit(cmd, contact, contactRT);

                if (aoRT != null && aoRT.rt != null)
                    cmd.SetGlobalTexture(GlobalAO, aoRT);
                if (ssrRT != null && ssrRT.rt != null)
                    cmd.SetGlobalTexture(GlobalSSR, ssrRT);
                if (maskRT != null && maskRT.rt != null)
                    cmd.SetGlobalTexture(GlobalSSRMask, maskRT);
                if (contactRT != null && contactRT.rt != null)
                    cmd.SetGlobalTexture(GlobalContact, contactRT);
            }

            DispatchHiZ(cmd, ref renderingData);
            DispatchHiZDown(cmd);
            DispatchLinDepth(cmd, ref renderingData);
            DispatchGTAO(cmd, ref renderingData);
            DispatchAOTemporal(cmd, ref renderingData);
            DispatchAOBlur(cmd);
            DispatchAOBlur2(cmd);
            bool gameCam = IsGameCamera(ref renderingData);
            RenderTexture contactDst = gameCam ? contactShadowRTGame : contactShadowRTScene;
            RenderTexture aoSnap = gameCam ? lightPassAoGame : lightPassAoScene;
            DispatchContactShadow(cmd, ref renderingData, contactDst);
            CopyRT(cmd, gtaoRT, aoSnap);
            PublishDeferredLightPassOverride(
                settings.bindDeferredLightPass,
                gameCam,
                aoSnap != null && aoSnap.IsCreated() ? aoSnap : null,
                contactDst != null && contactDst.IsCreated() ? contactDst : null);

            if (!logged)
            {
                logged = true;
                Debug.Log("[Endfield CP2] Baseline + EID4486 mip0 + EID4490-4510 mip1-6 + EID4514 LinDepth + EID4518 GTAO + EID4522 Temporal + EID4526 Blur + EID4530 Blur2 + EID4594 Contact (no Camera Color write) AO=" + Describe(ao)
                          + " SSR=" + Describe(ssr)
                          + " Mask=" + Describe(mask)
                          + " Contact=" + Describe(contact)
                          + " HiZDepth=" + settings.hizDepthSource + " " + Describe(ResolveCapturedDepth535())
                          + " LinDepthSrc=" + settings.hizDepthSource + " " + Describe(ResolveCapturedDepth543())
                          + " OctN=" + settings.hizDepthSource + " " + Describe(lastOctNormal)
                          + " Mot=" + Describe(ResolveMotion())
                          + " Hist=" + Describe(temporalHistBound)
                          + " Temporal=" + Describe(temporalCurrent)
                          + " ContactUAV=" + Describe(gameCam ? contactShadowRTGame : contactShadowRTScene)
                          + " preview=" + settings.debugPreview);
            }

            context.ExecuteCommandBuffer(cmd);
            CommandBufferPool.Release(cmd);
        }

        void DispatchHiZ(CommandBuffer cmd, ref RenderingData renderingData)
        {
            ComputeShader cs = ResolveHiZShader();
            Texture depth = ResolveHiZDepth(cmd, ref renderingData);
            RenderTexture mip0 = hizMips[0];
            if (cs == null || depth == null || mip0 == null || !mip0.IsCreated())
            {
                if (!warnedHiZ)
                {
                    Debug.LogError("[Endfield CP2] EID4486 missing HiZ shader or depth (" + settings.hizDepthSource + ").");
                    warnedHiZ = true;
                }
                return;
            }

            if (!EnsureUniforms14())
            {
                if (!warnedHiZ)
                {
                    Debug.LogError("[Endfield CP2] EID4486 missing uniforms14 48 bytes.");
                    warnedHiZ = true;
                }
                return;
            }

            if (hizKernel < 0)
            {
                if (!cs.HasKernel("HiZBuild"))
                {
                    if (!warnedHiZ)
                    {
                        Debug.LogError("[Endfield CP2] EID4486 kernel HiZBuild not found.");
                        warnedHiZ = true;
                    }
                    return;
                }
                hizKernel = cs.FindKernel("HiZBuild");
            }

            using (new ProfilingScope(cmd, hizSampler))
            {
                cmd.SetComputeConstantBufferParam(cs, Uniforms14Id, uniforms14, 0, Uniforms14Bytes);
                Vector4 child0 = LoadFloat4(cachedUniforms, 0);
                Vector4 child1 = LoadFloat4(cachedUniforms, 16);
                Vector4 child2 = LoadFloat4(cachedUniforms, 32);
                cmd.SetComputeVectorParam(cs, Child0Id, child0);
                cmd.SetComputeVectorParam(cs, Child1Id, child1);
                cmd.SetComputeVectorParam(cs, Child2Id, child2);
                cmd.SetComputeTextureParam(cs, hizKernel, DepthId, depth);
                cmd.SetComputeTextureParam(cs, hizKernel, HiZId, mip0);
                cmd.DispatchCompute(cs, hizKernel, HiZGroupsX, HiZGroupsY, 1);
                cmd.SetGlobalTexture(GlobalHiZ, mip0);
            }
        }

        void DispatchHiZDown(CommandBuffer cmd)
        {
            ComputeShader cs = ResolveHiZDownShader();
            if (cs == null || hizMips[0] == null || !hizMips[0].IsCreated())
            {
                if (!warnedHiZDown)
                {
                    Debug.LogError("[Endfield CP2] EID4490 missing HiZDown shader or mip0.");
                    warnedHiZDown = true;
                }
                return;
            }

            if (!EnsureUniforms14Down())
            {
                if (!warnedHiZDown)
                {
                    Debug.LogError("[Endfield CP2] EID4490 missing uniforms14Down 1536 bytes.");
                    warnedHiZDown = true;
                }
                return;
            }

            if (hizDownKernel < 0)
            {
                if (!cs.HasKernel("HiZDown"))
                {
                    if (!warnedHiZDown)
                    {
                        Debug.LogError("[Endfield CP2] EID4490 kernel HiZDown not found.");
                        warnedHiZDown = true;
                    }
                    return;
                }
                hizDownKernel = cs.FindKernel("HiZDown");
            }

            using (new ProfilingScope(cmd, hizDownSampler))
            {
                for (int i = 0; i < 6; ++i)
                {
                    RenderTexture src = hizMips[i];
                    RenderTexture dst = hizMips[i + 1];
                    if (src == null || dst == null || !src.IsCreated() || !dst.IsCreated())
                        continue;

                    int slot = i * Uniforms14Slot;
                    cmd.SetComputeConstantBufferParam(cs, Uniforms14Id, uniforms14DownSlots[i], 0, Uniforms14Bytes);
                    cmd.SetComputeVectorParam(cs, Child0Id, LoadFloat4(cachedUniformsDown, slot));
                    cmd.SetComputeVectorParam(cs, Child1Id, LoadFloat4(cachedUniformsDown, slot + 16));
                    cmd.SetComputeVectorParam(cs, Child2Id, LoadFloat4(cachedUniformsDown, slot + 32));
                    cmd.SetComputeTextureParam(cs, hizDownKernel, HiZSrcId, src);
                    cmd.SetComputeTextureParam(cs, hizDownKernel, HiZDstId, dst);
                    cmd.DispatchCompute(cs, hizDownKernel, HiZDownGroupsX[i], HiZDownGroupsY[i], 1);
                }
            }
        }

        void DispatchLinDepth(CommandBuffer cmd, ref RenderingData renderingData)
        {
            ComputeShader cs = ResolveLinDepthShader();
            Texture depth = ResolveLinDepth(cmd, ref renderingData);
            RenderTexture mip0 = linDepthMips[0];
            if (cs == null || depth == null || mip0 == null || !mip0.IsCreated())
            {
                if (!warnedLinDepth)
                {
                    Debug.LogError("[Endfield CP2] EID4514 missing LinDepth shader or depth (" + settings.hizDepthSource + ").");
                    warnedLinDepth = true;
                }
                return;
            }

            if (!EnsureUniforms6() || !EnsureUniforms11())
            {
                if (!warnedLinDepth)
                {
                    Debug.LogError("[Endfield CP2] EID4514 missing uniforms6 3200B or uniforms11 80B.");
                    warnedLinDepth = true;
                }
                return;
            }

            if (linDepthKernel < 0)
            {
                if (!cs.HasKernel("LinDepth"))
                {
                    if (!warnedLinDepth)
                    {
                        Debug.LogError("[Endfield CP2] EID4514 kernel LinDepth not found.");
                        warnedLinDepth = true;
                    }
                    return;
                }
                linDepthKernel = cs.FindKernel("LinDepth");
            }

            using (new ProfilingScope(cmd, linDepthSampler))
            {
                cmd.SetComputeConstantBufferParam(cs, Uniforms6Id, uniforms6, 0, Uniforms6Bytes);
                cmd.SetComputeConstantBufferParam(cs, Uniforms11Id, uniforms11, 0, Uniforms11Bytes);
                cmd.SetComputeVectorParam(cs, Child0Id, LoadFloat4(cachedUniforms6, 0));
                cmd.SetComputeVectorParam(cs, Child1Id, LoadFloat4(cachedUniforms6, 16));
                cmd.SetComputeVectorParam(cs, Child2Id, LoadFloat4(cachedUniforms6, 32));
                cmd.SetComputeVectorParam(cs, Child3Id, LoadFloat4(cachedUniforms6, 48));
                cmd.SetComputeTextureParam(cs, linDepthKernel, DepthId, depth);
                for (int i = 0; i < LinDepthMipCount; ++i)
                {
                    RenderTexture rt = linDepthMips[i];
                    if (rt == null || !rt.IsCreated())
                        return;
                    cmd.SetComputeTextureParam(cs, linDepthKernel, LinDepthIds[i], rt);
                }
                cmd.DispatchCompute(cs, linDepthKernel, LinDepthGroupsX, LinDepthGroupsY, 1);
                cmd.SetGlobalTexture(GlobalLinDepth, mip0);
            }
        }

        void DispatchGTAO(CommandBuffer cmd, ref RenderingData renderingData)
        {
            ComputeShader cs = ResolveGtaoShader();
            Texture oct = ResolveGtaoOctNormal(cmd, ref renderingData);
            RenderTexture aoOut = gtaoRT;
            RenderTexture edgeOut = gtaoEdgeRT;
            if (cs == null || oct == null || aoOut == null || !aoOut.IsCreated() ||
                edgeOut == null || !edgeOut.IsCreated() ||
                linDepthMips[0] == null || !linDepthMips[0].IsCreated())
            {
                if (!warnedGtao)
                {
                    Debug.LogError("[Endfield CP2] EID4518 missing GTAO shader, oct-normal, or LinDepth (" + settings.hizDepthSource + ").");
                    warnedGtao = true;
                }
                return;
            }

            if (!EnsureUniforms5() || !EnsureUniforms10())
            {
                if (!warnedGtao)
                {
                    Debug.LogError("[Endfield CP2] EID4518 missing uniforms5 1312B or uniforms10 80B.");
                    warnedGtao = true;
                }
                return;
            }

            if (gtaoKernel < 0)
            {
                if (!cs.HasKernel("GTAO"))
                {
                    if (!warnedGtao)
                    {
                        Debug.LogError("[Endfield CP2] EID4518 kernel GTAO not found.");
                        warnedGtao = true;
                    }
                    return;
                }
                gtaoKernel = cs.FindKernel("GTAO");
            }

            using (new ProfilingScope(cmd, gtaoSampler))
            {
                cmd.SetComputeConstantBufferParam(cs, Uniforms5Id, uniforms5, 0, Uniforms5Bytes);
                cmd.SetComputeConstantBufferParam(cs, Uniforms10Id, uniforms10, 0, Uniforms10Bytes);
                cmd.SetComputeTextureParam(cs, gtaoKernel, OctNormalId, oct);
                for (int i = 0; i < LinDepthMipCount; ++i)
                {
                    RenderTexture rt = linDepthMips[i];
                    if (rt == null || !rt.IsCreated())
                        return;
                    cmd.SetComputeTextureParam(cs, gtaoKernel, LinDepthIds[i], rt);
                }
                cmd.SetComputeTextureParam(cs, gtaoKernel, GtaoId, aoOut);
                cmd.SetComputeTextureParam(cs, gtaoKernel, GtaoEdgeId, edgeOut);
                cmd.DispatchCompute(cs, gtaoKernel, GtaoGroupsX, GtaoGroupsY, 1);
                cmd.SetGlobalTexture(GlobalGTAO, aoOut);
                cmd.SetGlobalTexture(GlobalGTAOEdge, edgeOut);
                cmd.SetGlobalTexture(GlobalOctNormal, oct);
            }
        }

        void DispatchAOTemporal(CommandBuffer cmd, ref RenderingData renderingData)
        {
            ComputeShader cs = ResolveAoTemporalShader();
            Texture motion = ResolveMotion();
            Texture seed = ResolveHistory();
            RenderTexture srcAo = gtaoRT;
            bool gameCam = IsGameCamera(ref renderingData);
            Texture hist = gameCam && temporalHistoryValid
                ? temporalPing[1 - temporalWriteIndex]
                : seed;
            RenderTexture dst = temporalPing[temporalWriteIndex];
            temporalHistBound = hist;
            temporalCurrent = null;
            if (cs == null || motion == null || hist == null || srcAo == null || !srcAo.IsCreated() ||
                dst == null || !dst.IsCreated() ||
                linDepthMips[0] == null || !linDepthMips[0].IsCreated())
            {
                if (!warnedTemporal)
                {
                    Debug.LogError("[Endfield CP2] EID4522 missing AOTemporal shader, 210525, 209486 seed, GTAO, LinDepth, or ping-pong RT.");
                    warnedTemporal = true;
                }
                return;
            }

            if (!EnsureUniforms8())
            {
                if (!warnedTemporal)
                {
                    Debug.LogError("[Endfield CP2] EID4522 missing uniforms8 80B.");
                    warnedTemporal = true;
                }
                return;
            }

            if (temporalKernel < 0)
            {
                if (!cs.HasKernel("AOTemporal"))
                {
                    if (!warnedTemporal)
                    {
                        Debug.LogError("[Endfield CP2] EID4522 kernel AOTemporal not found.");
                        warnedTemporal = true;
                    }
                    return;
                }
                temporalKernel = cs.FindKernel("AOTemporal");
            }

            using (new ProfilingScope(cmd, temporalSampler))
            {
                cmd.SetComputeConstantBufferParam(cs, Uniforms8Id, uniforms8, 0, Uniforms8Bytes);
                cmd.SetComputeTextureParam(cs, temporalKernel, LinDepthIds[0], linDepthMips[0]);
                cmd.SetComputeTextureParam(cs, temporalKernel, GtaoId, srcAo);
                cmd.SetComputeTextureParam(cs, temporalKernel, MotionId, motion);
                cmd.SetComputeTextureParam(cs, temporalKernel, HistoryId, hist);
                cmd.SetComputeTextureParam(cs, temporalKernel, TemporalId, dst);
                cmd.DispatchCompute(cs, temporalKernel, GtaoGroupsX, GtaoGroupsY, 1);
                cmd.SetGlobalTexture(GlobalTemporal, dst);
                temporalCurrent = dst;
                if (gameCam)
                {
                    temporalHistoryValid = true;
                    temporalWriteIndex = 1 - temporalWriteIndex;
                }
            }
        }

        static bool IsGameCamera(ref RenderingData renderingData)
        {
            Camera camera = renderingData.cameraData.camera;
            return camera != null
                && camera.cameraType == CameraType.Game
                && !renderingData.cameraData.isSceneViewCamera;
        }

        void DispatchAOBlur(CommandBuffer cmd)
        {
            ComputeShader cs = ResolveAoBlurShader();
            RenderTexture src = temporalCurrent;
            RenderTexture edge = gtaoEdgeRT;
            RenderTexture dst = blurRT;
            if (cs == null || src == null || !src.IsCreated() ||
                edge == null || !edge.IsCreated() ||
                dst == null || !dst.IsCreated())
            {
                if (!warnedBlur)
                {
                    Debug.LogError("[Endfield CP2] EID4526 missing AOBlur shader, temporal, or GTAO edge.");
                    warnedBlur = true;
                }
                return;
            }

            if (!EnsureUniforms8())
            {
                if (!warnedBlur)
                {
                    Debug.LogError("[Endfield CP2] EID4526 missing uniforms8 80B.");
                    warnedBlur = true;
                }
                return;
            }

            if (blurKernel < 0)
            {
                if (!cs.HasKernel("AOBlur"))
                {
                    if (!warnedBlur)
                    {
                        Debug.LogError("[Endfield CP2] EID4526 kernel AOBlur not found.");
                        warnedBlur = true;
                    }
                    return;
                }
                blurKernel = cs.FindKernel("AOBlur");
            }

            using (new ProfilingScope(cmd, blurSampler))
            {
                cmd.SetComputeConstantBufferParam(cs, Uniforms8Id, uniforms8, 0, Uniforms8Bytes);
                cmd.SetComputeTextureParam(cs, blurKernel, TemporalId, src);
                cmd.SetComputeTextureParam(cs, blurKernel, GtaoEdgeId, edge);
                cmd.SetComputeTextureParam(cs, blurKernel, BlurId, dst);
                cmd.DispatchCompute(cs, blurKernel, BlurGroupsX, BlurGroupsY, 1);
                cmd.SetGlobalTexture(GlobalBlur, dst);
            }
        }

        void DispatchAOBlur2(CommandBuffer cmd)
        {
            ComputeShader cs = ResolveAoBlur2Shader();
            RenderTexture src = blurRT;
            RenderTexture edge = gtaoEdgeRT;
            RenderTexture dst = gtaoRT;
            if (cs == null || src == null || !src.IsCreated() ||
                edge == null || !edge.IsCreated() ||
                dst == null || !dst.IsCreated())
            {
                if (!warnedBlur2)
                {
                    Debug.LogError("[Endfield CP2] EID4530 missing AOBlur2 shader, 209581 blur, or GTAO edge.");
                    warnedBlur2 = true;
                }
                return;
            }

            if (!EnsureUniforms8())
            {
                if (!warnedBlur2)
                {
                    Debug.LogError("[Endfield CP2] EID4530 missing uniforms8 80B.");
                    warnedBlur2 = true;
                }
                return;
            }

            if (blur2Kernel < 0)
            {
                if (!cs.HasKernel("AOBlur2"))
                {
                    if (!warnedBlur2)
                    {
                        Debug.LogError("[Endfield CP2] EID4530 kernel AOBlur2 not found.");
                        warnedBlur2 = true;
                    }
                    return;
                }
                blur2Kernel = cs.FindKernel("AOBlur2");
            }

            using (new ProfilingScope(cmd, blur2Sampler))
            {
                cmd.SetComputeConstantBufferParam(cs, Uniforms8Id, uniforms8, 0, Uniforms8Bytes);
                cmd.SetComputeTextureParam(cs, blur2Kernel, BlurId, src);
                cmd.SetComputeTextureParam(cs, blur2Kernel, GtaoEdgeId, edge);
                cmd.SetComputeTextureParam(cs, blur2Kernel, GtaoId, dst);
                cmd.DispatchCompute(cs, blur2Kernel, BlurGroupsX, BlurGroupsY, 1);
                cmd.SetGlobalTexture(GlobalGTAO, dst);
            }
        }

        void DispatchContactShadow(CommandBuffer cmd, ref RenderingData renderingData, RenderTexture dst)
        {
            ComputeShader cs = ResolveContactShadowShader();
            Texture depth = ResolveLinDepth(cmd, ref renderingData);
            if (cs == null || depth == null || dst == null || !dst.IsCreated())
            {
                if (!warnedContact)
                {
                    Debug.LogError("[Endfield CP2] EID4594 missing ContactShadow shader, depth (" + settings.hizDepthSource + "), or UAV.");
                    warnedContact = true;
                }
                return;
            }

            if (!EnsureUniforms6Contact() || !EnsureUniforms11Contact())
            {
                if (!warnedContact)
                {
                    Debug.LogError("[Endfield CP2] EID4594 missing uniforms6Contact 1312B or uniforms11Contact 80B.");
                    warnedContact = true;
                }
                return;
            }

            if (contactKernel < 0)
            {
                if (!cs.HasKernel("ContactShadow"))
                {
                    if (!warnedContact)
                    {
                        Debug.LogError("[Endfield CP2] EID4594 kernel ContactShadow not found.");
                        warnedContact = true;
                    }
                    return;
                }
                contactKernel = cs.FindKernel("ContactShadow");
            }

            using (new ProfilingScope(cmd, contactSampler))
            {
                cmd.SetComputeConstantBufferParam(cs, Uniforms6Id, uniforms6Contact, 0, Uniforms6ContactBytes);
                cmd.SetComputeConstantBufferParam(cs, Uniforms11Id, uniforms11Contact, 0, Uniforms11ContactBytes);
                cmd.SetComputeTextureParam(cs, contactKernel, DepthId, depth);
                cmd.SetComputeTextureParam(cs, contactKernel, ContactId, dst);
                cmd.DispatchCompute(cs, contactKernel, ContactGroupsX, ContactGroupsY, ContactGroupsZ);
                cmd.SetGlobalTexture(GlobalContact, dst);
            }
        }

        bool EnsureUniforms14()
        {
            byte[] bytes = LoadBytes(settings.inputs != null ? settings.inputs.uniforms14 : null,
                "eid4486_uniforms14.bytes", Uniforms14Bytes);
            if (bytes == null)
                return false;
            if (uniforms14 == null)
                uniforms14 = new ComputeBuffer(Uniforms14Bytes / 16, 16, ComputeBufferType.Constant);
            uniforms14.SetData(ToUInt4(bytes));
            cachedUniforms = bytes;
            return true;
        }

        bool EnsureUniforms14Down()
        {
            byte[] bytes = LoadBytes(settings.inputs != null ? settings.inputs.uniforms14Down : null,
                "eid4490_4510_uniforms14.bytes", Uniforms14DownBytes);
            if (bytes == null)
                return false;
            cachedUniformsDown = bytes;
            byte[] slice = new byte[Uniforms14Bytes];
            for (int i = 0; i < 6; ++i)
            {
                Buffer.BlockCopy(bytes, i * Uniforms14Slot, slice, 0, Uniforms14Bytes);
                if (uniforms14DownSlots[i] == null)
                    uniforms14DownSlots[i] = new ComputeBuffer(Uniforms14Bytes / 16, 16, ComputeBufferType.Constant);
                uniforms14DownSlots[i].SetData(ToUInt4(slice));
            }
            return true;
        }

        bool EnsureUniforms6()
        {
            byte[] bytes = LoadBytes(settings.inputs != null ? settings.inputs.uniforms6 : null,
                "eid4514_uniforms6.bytes", Uniforms6Bytes);
            if (bytes == null)
                return false;
            if (uniforms6 == null)
                uniforms6 = new ComputeBuffer(Uniforms6Bytes / 16, 16, ComputeBufferType.Constant);
            uniforms6.SetData(ToUInt4(bytes));
            cachedUniforms6 = bytes;
            return true;
        }

        bool EnsureUniforms11()
        {
            byte[] bytes = LoadBytes(settings.inputs != null ? settings.inputs.uniforms11 : null,
                "eid4514_uniforms11.bytes", Uniforms11Bytes);
            if (bytes == null)
                return false;
            if (uniforms11 == null)
                uniforms11 = new ComputeBuffer(Uniforms11Bytes / 16, 16, ComputeBufferType.Constant);
            uniforms11.SetData(ToUInt4(bytes));
            cachedUniforms11 = bytes;
            return true;
        }

        bool EnsureUniforms5()
        {
            byte[] bytes = LoadBytes(settings.inputs != null ? settings.inputs.uniforms5 : null,
                "eid4518_uniforms5.bytes", Uniforms5Bytes);
            if (bytes == null)
                return false;
            if (uniforms5 == null)
                uniforms5 = new ComputeBuffer(Uniforms5Bytes / 16, 16, ComputeBufferType.Constant);
            uniforms5.SetData(ToUInt4(bytes));
            cachedUniforms5 = bytes;
            return true;
        }

        bool EnsureUniforms10()
        {
            byte[] bytes = LoadBytes(settings.inputs != null ? settings.inputs.uniforms10 : null,
                "eid4518_uniforms10.bytes", Uniforms10Bytes);
            if (bytes == null)
                return false;
            if (uniforms10 == null)
                uniforms10 = new ComputeBuffer(Uniforms10Bytes / 16, 16, ComputeBufferType.Constant);
            uniforms10.SetData(ToUInt4(bytes));
            cachedUniforms10 = bytes;
            return true;
        }

        bool EnsureUniforms8()
        {
            byte[] bytes = LoadBytes(settings.inputs != null ? settings.inputs.uniforms8 : null,
                "eid4522_uniforms8.bytes", Uniforms8Bytes);
            if (bytes == null)
                return false;
            if (uniforms8 == null)
                uniforms8 = new ComputeBuffer(Uniforms8Bytes / 16, 16, ComputeBufferType.Constant);
            uniforms8.SetData(ToUInt4(bytes));
            cachedUniforms8 = bytes;
            return true;
        }

        bool EnsureUniforms6Contact()
        {
            byte[] bytes = LoadBytes(settings.inputs != null ? settings.inputs.uniforms6Contact : null,
                "eid4594_uniforms6.bytes", Uniforms6ContactBytes);
            if (bytes == null)
                return false;
            if (uniforms6Contact == null)
                uniforms6Contact = new ComputeBuffer(Uniforms6ContactBytes / 16, 16, ComputeBufferType.Constant);
            uniforms6Contact.SetData(ToUInt4(bytes));
            return true;
        }

        bool EnsureUniforms11Contact()
        {
            byte[] bytes = LoadBytes(settings.inputs != null ? settings.inputs.uniforms11Contact : null,
                "eid4594_uniforms11.bytes", Uniforms11ContactBytes);
            if (bytes == null)
                return false;
            if (uniforms11Contact == null)
                uniforms11Contact = new ComputeBuffer(Uniforms11ContactBytes / 16, 16, ComputeBufferType.Constant);
            uniforms11Contact.SetData(ToUInt4(bytes));
            return true;
        }

        byte[] cachedUniforms;
        byte[] cachedUniformsDown;
        byte[] cachedUniforms6;
        byte[] cachedUniforms11;
        byte[] cachedUniforms5;
        byte[] cachedUniforms10;
        byte[] cachedUniforms8;

        static Vector4 LoadFloat4(byte[] bytes, int offset)
        {
            if (bytes == null || bytes.Length < offset + 16)
                return Vector4.zero;
            return new Vector4(
                BitConverter.ToSingle(bytes, offset),
                BitConverter.ToSingle(bytes, offset + 4),
                BitConverter.ToSingle(bytes, offset + 8),
                BitConverter.ToSingle(bytes, offset + 12));
        }

        ComputeShader ResolveHiZShader()
        {
            if (settings.hizBuild != null)
                return settings.hizBuild;
#if UNITY_EDITOR
            return AssetDatabase.LoadAssetAtPath<ComputeShader>(HiZShaderPath);
#else
            return null;
#endif
        }

        ComputeShader ResolveHiZDownShader()
        {
            if (settings.hizDown != null)
                return settings.hizDown;
#if UNITY_EDITOR
            return AssetDatabase.LoadAssetAtPath<ComputeShader>(HiZDownShaderPath);
#else
            return null;
#endif
        }

        ComputeShader ResolveLinDepthShader()
        {
            if (settings.linDepth != null)
                return settings.linDepth;
#if UNITY_EDITOR
            return AssetDatabase.LoadAssetAtPath<ComputeShader>(LinDepthShaderPath);
#else
            return null;
#endif
        }

        ComputeShader ResolveGtaoShader()
        {
            if (settings.gtao != null)
                return settings.gtao;
#if UNITY_EDITOR
            return AssetDatabase.LoadAssetAtPath<ComputeShader>(GtaoShaderPath);
#else
            return null;
#endif
        }

        ComputeShader ResolveAoTemporalShader()
        {
            if (settings.aoTemporal != null)
                return settings.aoTemporal;
#if UNITY_EDITOR
            return AssetDatabase.LoadAssetAtPath<ComputeShader>(AoTemporalShaderPath);
#else
            return null;
#endif
        }

        ComputeShader ResolveAoBlurShader()
        {
            if (settings.aoBlur != null)
                return settings.aoBlur;
#if UNITY_EDITOR
            return AssetDatabase.LoadAssetAtPath<ComputeShader>(AoBlurShaderPath);
#else
            return null;
#endif
        }

        ComputeShader ResolveAoBlur2Shader()
        {
            if (settings.aoBlur2 != null)
                return settings.aoBlur2;
#if UNITY_EDITOR
            return AssetDatabase.LoadAssetAtPath<ComputeShader>(AoBlur2ShaderPath);
#else
            return null;
#endif
        }

        ComputeShader ResolveContactShadowShader()
        {
            if (settings.contactShadow != null)
                return settings.contactShadow;
#if UNITY_EDITOR
            return AssetDatabase.LoadAssetAtPath<ComputeShader>(ContactShadowShaderPath);
#else
            return null;
#endif
        }

        Texture ResolveCapturedDepth535()
        {
            Texture assigned = settings.inputs != null ? settings.inputs.depthFull209535 : null;
            if (IsUsable(assigned))
                return assigned;
#if UNITY_EDITOR
            Texture loaded = AssetDatabase.LoadAssetAtPath<Texture>(
                CapturedRoot + "/UnityNative/rid209535_depth_r32f.asset");
            if (IsUsable(loaded))
                return loaded;
#endif
            return null;
        }

        Texture ResolveHiZDepth(CommandBuffer cmd, ref RenderingData renderingData)
        {
            if (settings.hizDepthSource != HiZDepthSource.LiveGBuffer)
                return ResolveCapturedDepth535();

            Texture live = ResolveLiveGBufferDepth(cmd, ref renderingData);
            if (live != null)
                return live;

            if (!warnedLiveDepth)
            {
                Debug.LogWarning("[Endfield CP2] EID4486 LiveGBuffer depth missing; falling back to captured 209535.");
                warnedLiveDepth = true;
            }
            return ResolveCapturedDepth535();
        }

        Texture ResolveLiveGBufferDepth(CommandBuffer cmd, ref RenderingData renderingData)
        {
            if (TryGetCombinedGeometryController(renderingData.cameraData.camera,
                    out EID3332CombinedDeferredController controller))
            {
                RenderTexture depthDebug = controller.targets.DepthDebug;
                if (IsSampleableColor(depthDebug))
                    return BindOrCopyHiZSrc(cmd, depthDebug);

                RenderTexture sceneDepth = controller.targets.Depth;
                if (IsUsable(sceneDepth))
                    return CopyDepthToR32F(cmd, sceneDepth);
            }

            RTHandle cameraDepth = renderingData.cameraData.renderer != null
                ? renderingData.cameraData.renderer.cameraDepthTargetHandle
                : null;
            if (cameraDepth != null && cameraDepth.rt != null && IsUsable(cameraDepth.rt))
                return CopyDepthToR32F(cmd, cameraDepth.rt);

            return null;
        }

        static bool IsSampleableColor(RenderTexture rt)
        {
            return IsUsable(rt) && rt.IsCreated() && rt.graphicsFormat != GraphicsFormat.None;
        }

        static bool IsPlausibleOctNormal(Texture texture)
        {
            return IsUsable(texture) && texture.width >= 32 && texture.height >= 32;
        }

        Texture BindOrCopyHiZSrc(CommandBuffer cmd, RenderTexture source)
        {
            if (IsSampleableColor(source) && source.width == FullWidth && source.height == FullHeight)
                return source;
            return CopyDepthToR32F(cmd, source);
        }

        Texture CopyDepthToR32F(CommandBuffer cmd, Texture source)
        {
            if (cmd == null || !IsUsable(source))
                return null;
            EnsureHiZSrc();
            if (hizSrcRT == null || !hizSrcRT.IsCreated())
                return null;
            cmd.Blit(source, hizSrcRT);
            return hizSrcRT;
        }

        Texture ResolveCapturedDepth543()
        {
            Texture assigned = settings.inputs != null ? settings.inputs.depthFull209543 : null;
            if (IsUsable(assigned))
                return assigned;
#if UNITY_EDITOR
            Texture loaded = AssetDatabase.LoadAssetAtPath<Texture>(Depth543Path);
            if (IsUsable(loaded))
                return loaded;
#endif
            return null;
        }

        Texture ResolveLinDepth(CommandBuffer cmd, ref RenderingData renderingData)
        {
            if (settings.hizDepthSource != HiZDepthSource.LiveGBuffer)
                return ResolveCapturedDepth543();

            Texture live = ResolveLiveGBufferDepth(cmd, ref renderingData);
            if (live != null)
                return live;

            if (!warnedLiveDepth)
            {
                Debug.LogWarning("[Endfield CP2] EID4514 LiveGBuffer depth missing; falling back to captured 209543.");
                warnedLiveDepth = true;
            }
            return ResolveCapturedDepth543();
        }

        Texture ResolveCapturedOctNormal()
        {
            Texture assigned = settings.inputs != null ? settings.inputs.octNormal209566 : null;
            if (IsUsable(assigned))
                return assigned;
#if UNITY_EDITOR
            Texture loaded = AssetDatabase.LoadAssetAtPath<Texture>(OctNormalPath);
            if (IsUsable(loaded))
                return loaded;
#endif
            return null;
        }

        Texture ResolveGtaoOctNormal(CommandBuffer cmd, ref RenderingData renderingData)
        {
            Texture oct;
            if (settings.hizDepthSource != HiZDepthSource.LiveGBuffer)
            {
                oct = ResolveCapturedOctNormal();
            }
            else
            {
                oct = ResolveLiveGBufferOctNormal(cmd, ref renderingData);
                if (oct == null)
                {
                    if (!warnedLiveOctNormal)
                    {
                        Debug.LogWarning("[Endfield CP2] EID4518 LiveGBuffer RT3 oct-normal missing; falling back to captured 209566. _GBuffer3="
                                         + Describe(Shader.GetGlobalTexture(GBuffer3Id)));
                        warnedLiveOctNormal = true;
                    }
                    oct = ResolveCapturedOctNormal();
                }
            }
            lastOctNormal = oct;
            return oct;
        }

        Texture ResolveLiveGBufferOctNormal(CommandBuffer cmd, ref RenderingData renderingData)
        {
            Camera camera = renderingData.cameraData.camera;
            EID3332CombinedDeferredController controller =
                UnityEngine.Object.FindObjectOfType<EID3332CombinedDeferredController>();

            if (IsCombinedGeometryController(camera, controller))
            {
                RenderTexture rt3 = controller.targets.GetColor(3);
                if (IsSampleableColor(rt3) && IsPlausibleOctNormal(rt3))
                    return CopyOctNormalToFull(cmd, rt3);
            }

            // FiveMRT index 3 = RenderDoc RT3 octa.xy。Shader.GetGlobalTexture("_GBuffer3")
            // 常拿到 RTHandle 1x1 占位，不能当 Texture2D 绑给 GTAO。
            Texture attachment;
            TryGetDeferredFiveMrtRt3(renderingData.cameraData.renderer, out attachment, out bool _);
            if (IsUsable(attachment) && IsPlausibleOctNormal(attachment))
                return CopyOctNormalToFull(cmd, attachment);

            Texture global = Shader.GetGlobalTexture(GBuffer3Id);
            if (IsUsable(global) && IsPlausibleOctNormal(global))
                return CopyOctNormalToFull(cmd, global);

            return null;
        }

        static bool TryGetDeferredFiveMrtRt3(ScriptableRenderer renderer, out Texture rt3, out bool fiveMrt)
        {
            rt3 = null;
            fiveMrt = false;
            if (renderer == null)
                return false;
            try
            {
                if (deferredLightsField == null)
                    deferredLightsField = renderer.GetType().GetField("m_DeferredLights",
                        BindingFlags.Instance | BindingFlags.NonPublic);
                object lights = deferredLightsField != null ? deferredLightsField.GetValue(renderer) : null;
                if (lights == null)
                    return false;

                if (useFiveMrtProperty == null)
                    useFiveMrtProperty = lights.GetType().GetProperty("UseEID3336FiveMRT",
                        BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
                object flag = useFiveMrtProperty != null ? useFiveMrtProperty.GetValue(lights) : null;
                fiveMrt = flag is bool enabled && enabled;
                if (!fiveMrt)
                    return false;

                if (gbufferAttachmentsProperty == null)
                    gbufferAttachmentsProperty = lights.GetType().GetProperty("GbufferAttachments",
                        BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
                RTHandle[] attachments = gbufferAttachmentsProperty != null
                    ? gbufferAttachmentsProperty.GetValue(lights) as RTHandle[]
                    : null;
                if (attachments == null || attachments.Length <= 3 || attachments[3] == null)
                    return false;
                rt3 = attachments[3].rt;
                return IsUsable(rt3);
            }
            catch (Exception)
            {
                return false;
            }
        }

        static bool TryGetCombinedGeometryController(Camera camera, out EID3332CombinedDeferredController controller)
        {
            controller = UnityEngine.Object.FindObjectOfType<EID3332CombinedDeferredController>();
            return IsCombinedGeometryController(camera, controller);
        }

        static bool IsCombinedGeometryController(Camera camera, EID3332CombinedDeferredController controller)
        {
            return controller != null && controller.IsForCamera(camera) &&
                   controller.targets != null &&
                   !controller.UseEID3336FiveMRT(camera) &&
                   !controller.UsesRouteBMeshForCamera(camera);
        }

        Texture CopyOctNormalToFull(CommandBuffer cmd, Texture source)
        {
            if (cmd == null || !IsUsable(source))
                return null;
            EnsureOctNormalSrc();
            if (octNormalSrcRT == null || !octNormalSrcRT.IsCreated())
                return null;
            cmd.Blit(source, octNormalSrcRT);
            return octNormalSrcRT;
        }

        Texture ResolveMotion()
        {
            Texture assigned = settings.inputs != null ? settings.inputs.motion210525 : null;
            if (IsUsable(assigned))
                return assigned;
#if UNITY_EDITOR
            Texture loaded = AssetDatabase.LoadAssetAtPath<Texture>(Motion210525Path);
            if (IsUsable(loaded))
                return loaded;
#endif
            return null;
        }

        Texture ResolveHistory()
        {
            Texture assigned = settings.inputs != null ? settings.inputs.history209486 : null;
            if (IsUsable(assigned))
                return assigned;
#if UNITY_EDITOR
            Texture loaded = AssetDatabase.LoadAssetAtPath<Texture>(History209486Path);
            if (IsUsable(loaded))
                return loaded;
#endif
            return null;
        }

        static void Allocate(ref RTHandle handle, int width, int height, GraphicsFormat format, string name)
        {
            RenderTextureDescriptor desc = new RenderTextureDescriptor(width, height)
            {
                depthBufferBits = 0,
                msaaSamples = 1,
                mipCount = 1,
                useMipMap = false,
                autoGenerateMips = false,
                sRGB = false,
                graphicsFormat = format
            };
            RenderingUtils.ReAllocateIfNeeded(ref handle, desc, FilterMode.Point,
                TextureWrapMode.Clamp, name: name);
        }

        void EnsureHiZ()
        {
            for (int i = 0; i < HiZMipCount; ++i)
            {
                int w = HiZMipWidth[i];
                int h = HiZMipHeight[i];
                RenderTexture rt = hizMips[i];
                if (rt != null && rt.IsCreated() && rt.width == w && rt.height == h && rt.enableRandomWrite)
                    continue;
                ReleaseHiZAt(i);
                RenderTextureDescriptor desc = new RenderTextureDescriptor(w, h)
                {
                    graphicsFormat = GraphicsFormat.R32_SFloat,
                    depthBufferBits = 0,
                    msaaSamples = 1,
                    volumeDepth = 1,
                    dimension = TextureDimension.Tex2D,
                    enableRandomWrite = true,
                    useMipMap = false,
                    autoGenerateMips = false,
                    mipCount = 1,
                    sRGB = false
                };
                rt = new RenderTexture(desc)
                {
                    name = i == 0 ? "_EndfieldHiZ" : "_EndfieldHiZ_mip" + i,
                    filterMode = FilterMode.Point,
                    wrapMode = TextureWrapMode.Clamp,
                    hideFlags = HideFlags.HideAndDontSave
                };
                rt.Create();
                hizMips[i] = rt;
            }
        }

        void ReleaseHiZAt(int i)
        {
            RenderTexture rt = hizMips[i];
            if (rt == null)
                return;
            if (rt.IsCreated())
                rt.Release();
            if (Application.isPlaying)
                UnityEngine.Object.Destroy(rt);
            else
                UnityEngine.Object.DestroyImmediate(rt);
            hizMips[i] = null;
        }

        void ReleaseHiZ()
        {
            for (int i = 0; i < HiZMipCount; ++i)
                ReleaseHiZAt(i);
            ReleaseHiZSrc();
            ReleaseOctNormalSrc();
        }

        void EnsureHiZSrc()
        {
            int width = FullWidth;
            int height = FullHeight;
            RenderTexture rt = hizSrcRT;
            if (rt != null && rt.IsCreated() && rt.width == width && rt.height == height &&
                rt.graphicsFormat == GraphicsFormat.R32_SFloat)
                return;
            ReleaseHiZSrc();
            RenderTextureDescriptor desc = new RenderTextureDescriptor(width, height)
            {
                graphicsFormat = GraphicsFormat.R32_SFloat,
                depthBufferBits = 0,
                msaaSamples = 1,
                volumeDepth = 1,
                dimension = TextureDimension.Tex2D,
                enableRandomWrite = false,
                useMipMap = false,
                autoGenerateMips = false,
                mipCount = 1,
                sRGB = false
            };
            rt = new RenderTexture(desc)
            {
                name = "_EndfieldHiZSrc",
                filterMode = FilterMode.Point,
                wrapMode = TextureWrapMode.Clamp,
                hideFlags = HideFlags.HideAndDontSave
            };
            rt.Create();
            hizSrcRT = rt;
        }

        void ReleaseHiZSrc()
        {
            RenderTexture rt = hizSrcRT;
            if (rt == null)
                return;
            if (rt.IsCreated())
                rt.Release();
            if (Application.isPlaying)
                UnityEngine.Object.Destroy(rt);
            else
                UnityEngine.Object.DestroyImmediate(rt);
            hizSrcRT = null;
        }

        void EnsureOctNormalSrc()
        {
            int width = FullWidth;
            int height = FullHeight;
            RenderTexture rt = octNormalSrcRT;
            if (rt != null && rt.IsCreated() && rt.width == width && rt.height == height &&
                rt.graphicsFormat == GraphicsFormat.R16G16B16A16_SFloat)
                return;
            ReleaseOctNormalSrc();
            RenderTextureDescriptor desc = new RenderTextureDescriptor(width, height)
            {
                graphicsFormat = GraphicsFormat.R16G16B16A16_SFloat,
                depthBufferBits = 0,
                msaaSamples = 1,
                volumeDepth = 1,
                dimension = TextureDimension.Tex2D,
                enableRandomWrite = false,
                useMipMap = false,
                autoGenerateMips = false,
                mipCount = 1,
                sRGB = false
            };
            rt = new RenderTexture(desc)
            {
                name = "_EndfieldOctNormalSrc",
                filterMode = FilterMode.Point,
                wrapMode = TextureWrapMode.Clamp,
                hideFlags = HideFlags.HideAndDontSave
            };
            rt.Create();
            octNormalSrcRT = rt;
        }

        void ReleaseOctNormalSrc()
        {
            RenderTexture rt = octNormalSrcRT;
            if (rt == null)
                return;
            if (rt.IsCreated())
                rt.Release();
            if (Application.isPlaying)
                UnityEngine.Object.Destroy(rt);
            else
                UnityEngine.Object.DestroyImmediate(rt);
            octNormalSrcRT = null;
        }

        void EnsureLinDepth()
        {
            for (int i = 0; i < LinDepthMipCount; ++i)
            {
                int w = LinDepthMipWidth[i];
                int h = LinDepthMipHeight[i];
                RenderTexture rt = linDepthMips[i];
                if (rt != null && rt.IsCreated() && rt.width == w && rt.height == h && rt.enableRandomWrite)
                    continue;
                ReleaseLinDepthAt(i);
                RenderTextureDescriptor desc = new RenderTextureDescriptor(w, h)
                {
                    graphicsFormat = GraphicsFormat.R32_SFloat,
                    depthBufferBits = 0,
                    msaaSamples = 1,
                    volumeDepth = 1,
                    dimension = TextureDimension.Tex2D,
                    enableRandomWrite = true,
                    useMipMap = false,
                    autoGenerateMips = false,
                    mipCount = 1,
                    sRGB = false
                };
                rt = new RenderTexture(desc)
                {
                    name = i == 0 ? "_EndfieldLinDepth" : "_EndfieldLinDepth_mip" + i,
                    filterMode = FilterMode.Point,
                    wrapMode = TextureWrapMode.Clamp,
                    hideFlags = HideFlags.HideAndDontSave
                };
                rt.Create();
                linDepthMips[i] = rt;
            }
        }

        void ReleaseLinDepthAt(int i)
        {
            RenderTexture rt = linDepthMips[i];
            if (rt == null)
                return;
            if (rt.IsCreated())
                rt.Release();
            if (Application.isPlaying)
                UnityEngine.Object.Destroy(rt);
            else
                UnityEngine.Object.DestroyImmediate(rt);
            linDepthMips[i] = null;
        }

        void ReleaseLinDepth()
        {
            for (int i = 0; i < LinDepthMipCount; ++i)
                ReleaseLinDepthAt(i);
        }

        void EnsureGtao()
        {
            EnsureGtaoRT(ref gtaoRT, "_EndfieldGTAO");
            EnsureGtaoRT(ref gtaoEdgeRT, "_EndfieldGTAOEdge");
        }

        static void EnsureGtaoRT(ref RenderTexture rt, string name)
        {
            if (rt != null && rt.IsCreated() && rt.width == HalfWidth && rt.height == HalfHeight &&
                rt.enableRandomWrite)
                return;
            ReleaseGtaoRT(ref rt);
            RenderTextureDescriptor desc = new RenderTextureDescriptor(HalfWidth, HalfHeight)
            {
                graphicsFormat = GraphicsFormat.R8_UNorm,
                depthBufferBits = 0,
                msaaSamples = 1,
                volumeDepth = 1,
                dimension = TextureDimension.Tex2D,
                enableRandomWrite = true,
                useMipMap = false,
                autoGenerateMips = false,
                mipCount = 1,
                sRGB = false
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

        static void ReleaseGtaoRT(ref RenderTexture rt)
        {
            if (rt == null)
                return;
            if (rt.IsCreated())
                rt.Release();
            if (Application.isPlaying)
                UnityEngine.Object.Destroy(rt);
            else
                UnityEngine.Object.DestroyImmediate(rt);
            rt = null;
        }

        void ReleaseGtao()
        {
            ReleaseGtaoRT(ref gtaoRT);
            ReleaseGtaoRT(ref gtaoEdgeRT);
        }

        void EnsureTemporal()
        {
            if (IsTemporalRT(temporalPing[0]) && IsTemporalRT(temporalPing[1]))
                return;
            ReleaseTemporal();
            EnsureTemporalRT(ref temporalPing[0], "_EndfieldGTAOTemporal0");
            EnsureTemporalRT(ref temporalPing[1], "_EndfieldGTAOTemporal1");
            temporalWriteIndex = 0;
            temporalHistoryValid = false;
            temporalCurrent = null;
            temporalHistBound = null;
        }

        static bool IsTemporalRT(RenderTexture rt)
        {
            return rt != null && rt.IsCreated() && rt.width == HalfWidth && rt.height == HalfHeight &&
                   rt.enableRandomWrite;
        }

        static void EnsureTemporalRT(ref RenderTexture rt, string name)
        {
            if (rt != null && rt.IsCreated() && rt.width == HalfWidth && rt.height == HalfHeight &&
                rt.enableRandomWrite)
                return;
            ReleaseGtaoRT(ref rt);
            RenderTextureDescriptor desc = new RenderTextureDescriptor(HalfWidth, HalfHeight)
            {
                graphicsFormat = GraphicsFormat.R16G16B16A16_SFloat,
                depthBufferBits = 0,
                msaaSamples = 1,
                volumeDepth = 1,
                dimension = TextureDimension.Tex2D,
                enableRandomWrite = true,
                useMipMap = false,
                autoGenerateMips = false,
                mipCount = 1,
                sRGB = false
            };
            rt = new RenderTexture(desc)
            {
                name = name,
                filterMode = FilterMode.Bilinear,
                wrapMode = TextureWrapMode.Clamp,
                hideFlags = HideFlags.HideAndDontSave
            };
            rt.Create();
        }

        void ReleaseTemporal()
        {
            ReleaseGtaoRT(ref temporalPing[0]);
            ReleaseGtaoRT(ref temporalPing[1]);
            temporalWriteIndex = 0;
            temporalHistoryValid = false;
            temporalCurrent = null;
            temporalHistBound = null;
        }

        void EnsureBlur()
        {
            EnsureGtaoRT(ref blurRT, "_EndfieldGTAOBlur");
        }

        void ReleaseBlur()
        {
            ReleaseGtaoRT(ref blurRT);
        }

        void EnsureContactShadow()
        {
            EnsureContactShadowRT(ref contactShadowRTGame, "_EndfieldContact_Game");
            EnsureContactShadowRT(ref contactShadowRTScene, "_EndfieldContact_Scene");
            EnsureGtaoRT(ref lightPassAoGame, "_EndfieldGTAO_LightPass_Game");
            EnsureGtaoRT(ref lightPassAoScene, "_EndfieldGTAO_LightPass_Scene");
        }

        static void EnsureContactShadowRT(ref RenderTexture rt, string name)
        {
            if (rt != null && rt.IsCreated() && rt.width == FullWidth && rt.height == FullHeight &&
                rt.enableRandomWrite && rt.graphicsFormat == GraphicsFormat.R8G8_UNorm)
                return;
            ReleaseGtaoRT(ref rt);
            RenderTextureDescriptor desc = new RenderTextureDescriptor(FullWidth, FullHeight)
            {
                graphicsFormat = GraphicsFormat.R8G8_UNorm,
                depthBufferBits = 0,
                msaaSamples = 1,
                volumeDepth = 1,
                dimension = TextureDimension.Tex2D,
                enableRandomWrite = true,
                useMipMap = false,
                autoGenerateMips = false,
                mipCount = 1,
                sRGB = false
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

        void ReleaseContactShadow()
        {
            ReleaseGtaoRT(ref contactShadowRTGame);
            ReleaseGtaoRT(ref contactShadowRTScene);
            ReleaseGtaoRT(ref lightPassAoGame);
            ReleaseGtaoRT(ref lightPassAoScene);
        }

        static void CopyRT(CommandBuffer cmd, RenderTexture source, RenderTexture dest)
        {
            if (cmd == null || source == null || !source.IsCreated() || dest == null || !dest.IsCreated())
                return;
            cmd.Blit(source, dest);
        }

        static void CopyOrBlit(CommandBuffer cmd, Texture source, RTHandle dest)
        {
            if (source == null || dest == null || dest.rt == null)
                return;
            cmd.Blit(source, dest);
        }

        static Texture Resolve(Texture assigned, string stem)
        {
            if (IsUsable(assigned))
                return assigned;
#if UNITY_EDITOR
            Texture loaded = AssetDatabase.LoadAssetAtPath<Texture>(ImportedRoot + stem + ".asset");
            if (IsUsable(loaded))
                return loaded;
#endif
            return null;
        }

        static bool IsUsable(Texture texture)
        {
            if (texture == null)
                return false;
            try
            {
                return texture.GetInstanceID() != 0 && texture.width > 0 && texture.height > 0;
            }
            catch (MissingReferenceException)
            {
                return false;
            }
        }

        static byte[] LoadBytes(TextAsset assigned, string fileName, int expected)
        {
            if (assigned != null && assigned.bytes != null && assigned.bytes.Length == expected)
                return assigned.bytes;
#if UNITY_EDITOR
            TextAsset asset = AssetDatabase.LoadAssetAtPath<TextAsset>(CapturedRoot + "/" + fileName);
            if (asset != null && asset.bytes != null && asset.bytes.Length == expected)
                return asset.bytes;
#endif
            string path = Path.Combine(Application.dataPath, "EndfieldCP2_ExactReplay/Captured", fileName);
            if (File.Exists(path))
            {
                byte[] bytes = File.ReadAllBytes(path);
                if (bytes.Length == expected) return bytes;
            }
            return null;
        }

        struct UInt4
        {
            public uint x, y, z, w;
        }

        static UInt4[] ToUInt4(byte[] bytes)
        {
            UInt4[] result = new UInt4[bytes.Length / 16];
            for (int i = 0; i < result.Length; ++i)
            {
                result[i].x = BitConverter.ToUInt32(bytes, i * 16 + 0);
                result[i].y = BitConverter.ToUInt32(bytes, i * 16 + 4);
                result[i].z = BitConverter.ToUInt32(bytes, i * 16 + 8);
                result[i].w = BitConverter.ToUInt32(bytes, i * 16 + 12);
            }
            return result;
        }

        static string Describe(Texture texture)
        {
            if (texture == null)
                return "<null>";
            return texture.name + "(" + texture.width + "x" + texture.height + ")";
        }

        public void Dispose()
        {
            aoRT?.Release();
            ssrRT?.Release();
            maskRT?.Release();
            contactRT?.Release();
            ReleaseHiZ();
            ReleaseLinDepth();
            ReleaseGtao();
            ReleaseTemporal();
            ReleaseBlur();
            ReleaseContactShadow();
            aoRT = null;
            ssrRT = null;
            maskRT = null;
            contactRT = null;
            if (uniforms14 != null)
            {
                uniforms14.Release();
                uniforms14 = null;
            }
            for (int i = 0; i < uniforms14DownSlots.Length; ++i)
            {
                if (uniforms14DownSlots[i] == null)
                    continue;
                uniforms14DownSlots[i].Release();
                uniforms14DownSlots[i] = null;
            }
            if (uniforms6 != null)
            {
                uniforms6.Release();
                uniforms6 = null;
            }
            if (uniforms11 != null)
            {
                uniforms11.Release();
                uniforms11 = null;
            }
            if (uniforms5 != null)
            {
                uniforms5.Release();
                uniforms5 = null;
            }
            if (uniforms10 != null)
            {
                uniforms10.Release();
                uniforms10 = null;
            }
            if (uniforms8 != null)
            {
                uniforms8.Release();
                uniforms8 = null;
            }
            if (uniforms6Contact != null)
            {
                uniforms6Contact.Release();
                uniforms6Contact = null;
            }
            if (uniforms11Contact != null)
            {
                uniforms11Contact.Release();
                uniforms11Contact = null;
            }
        }
    }
}
