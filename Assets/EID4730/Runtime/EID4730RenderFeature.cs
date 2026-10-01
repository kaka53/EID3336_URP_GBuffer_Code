using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace EID4730
{
    public sealed class EID4730RenderFeature : ScriptableRendererFeature
    {
        public const string ShaderPassName = "EID4730CharacterForward";
        public bool enableEID4812CharacterForward = true;
        public LayerMask eid4812LayerMask = ~0;
        public bool renderEID4812InSceneView = true;
        public bool enableEID4780CharacterForward = true;
        public LayerMask eid4780LayerMask = ~0;
        public bool renderEID4780InSceneView = true;
        public bool enableEID4785CharacterForward = true;
        public LayerMask eid4785LayerMask = ~0;
        public bool renderEID4785InSceneView = true;
        public bool enableEID4725CharacterForward = true;
        public LayerMask eid4725LayerMask = ~0;
        public bool renderEID4725InSceneView = true;
        public bool enableEID4705CharacterForward = true;
        public LayerMask eid4705LayerMask = ~0;
        public bool renderEID4705InSceneView = true;
        public bool enableEID4817CharacterForward = true;
        public LayerMask eid4817LayerMask = ~0;
        public bool renderEID4817InSceneView = true;

        public bool enableEID4740CharacterForward = true;
        public LayerMask eid4740LayerMask = ~0;
        public bool renderEID4740InSceneView = true;

        public bool enableEID4789CharacterForward = true;
        public LayerMask eid4789LayerMask = ~0;
        public bool renderEID4789InSceneView = true;

        public bool enableEID4794CharacterForward = true;
        public LayerMask eid4794LayerMask = ~0;
        public bool renderEID4794InSceneView = true;

        public bool enableEID4883CharacterForward = true;
        public LayerMask eid4883LayerMask = ~0;
        public bool renderEID4883InSceneView = true;

        public Shader replayShader, restoreShader, previewShader;
        [Tooltip("0 = HDR color, 1 = second MRT attachment")] [Range(0, 1)] public int previewAttachment;
        public bool showInSceneView = true;
        public bool verifyCaptureHashes = true;
        [Tooltip("Unused. Kept so the Combined Renderer asset stays valid.")]
        public bool strictDepthEquality = false;
        [Range(0, 64)] public int depthToleranceUlps = 16;
        [Tooltip("After 4666 (240), before Combined opaques (250) and URP final blit.")]
        public RenderPassEvent injectionPoint = (RenderPassEvent)((int)RenderPassEvent.AfterRenderingDeferredLights + 5);
        [Tooltip("EID4780 uses the same render-pass queue as EID4730; retained for serialized renderer compatibility.")]
        public RenderPassEvent eid4780InjectionPoint = (RenderPassEvent)245;
        [Tooltip("Unused serialized capture slots. Frame textures come from StreamingAssets/EID4730.")]
        public Texture lut48;
        public Texture shadow38;
        public Texture fog56;
        public Texture irrFineData;
        public Texture irrFineWeight;
        public Texture irrMedData;
        public Texture irrMedWeight;
        public Texture irrCoarseData;
        public Texture irrCoarseWeight;


#if UNITY_EDITOR
        // Optional end-of-pass readback hook. Null during all normal rendering.
        public static Action<CommandBuffer, RTHandle> CaptureCharacterColorForDiagnostics;
        public static Action<CommandBuffer, RTHandle, int> CaptureHairForDiagnostics;
        public static bool HairLegacyAOForDiagnostics;
        public static bool HairAOAuditForDiagnostics;
        public static Action<CommandBuffer, RTHandle> CaptureEID4789ColorForDiagnostics;
        public static Action<CommandBuffer, RTHandle> CaptureEID4785ColorForDiagnostics;
        public static Action<CommandBuffer, RTHandle> CaptureEID4725ColorForDiagnostics;
        public static Action<CommandBuffer, RTHandle> CaptureEID4720ColorForDiagnostics;
        public static Action<CommandBuffer, RTHandle> CaptureBeforeEID4720ColorForDiagnostics;
        public static Action<CommandBuffer, RTHandle> CaptureEID4725DepthForDiagnostics;
        public static Action<CommandBuffer, RTHandle> CaptureEID4780ColorForDiagnostics;
        public static Action<CommandBuffer, RTHandle> CaptureEID4765ColorForDiagnostics;
        public static Action<CommandBuffer, RTHandle, bool> CaptureEID4817ColorForDiagnostics;
        static int isolatedAttachmentDiagnosticScopes;
        public static bool IsolatedAttachmentDiagnostics => isolatedAttachmentDiagnosticScopes > 0;
        public static int LastCameraId { get; private set; }
        public static int LastAuxiliaryClearCount { get; private set; }
        public static int LastTargetBindingCount { get; private set; }
        public static int LastDrawGroupCount { get; private set; }
        public static IDisposable BeginIsolatedAttachmentDiagnostics() => new IsolatedAttachmentScope();
        sealed class IsolatedAttachmentScope : IDisposable
        {
            bool disposed;
            public IsolatedAttachmentScope() { isolatedAttachmentDiagnosticScopes++; }
            public void Dispose() { if (!disposed) { disposed = true; isolatedAttachmentDiagnosticScopes--; } }
        }
#else
        static bool IsolatedAttachmentDiagnostics => false;
#endif

        [Tooltip("Replay ColourPass26 hair alpha and back-face draws using captured resources and scene-consistent depth.")]
        public bool enableColourPass26Hair = false;
        public Shader colourPass26FrontShader;
        public Shader colourPass26BackShader;
        ColourPass26HairPass hairPass;
        ReplayPass pass;

        public override void Create()
        {
            pass?.Dispose();
            pass = new ReplayPass(this) { renderPassEvent = injectionPoint };
            hairPass?.Dispose();
            hairPass = new ColourPass26HairPass(() => pass?.SharedAuxiliary,colourPass26FrontShader,colourPass26BackShader);
        }

        public override void SetupRenderPasses(ScriptableRenderer renderer, in RenderingData renderingData)
        {
            if (pass == null)
                return;
            pass.SetTargets(renderer.cameraColorTargetHandle, renderer.cameraDepthTargetHandle);
            hairPass?.SetTargets(renderer.cameraColorTargetHandle, renderer.cameraDepthTargetHandle);
        }

        public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
        {
            Camera c = renderingData.cameraData.camera;
            if (c.cameraType == CameraType.Preview || c.cameraType == CameraType.Reflection || (c.cameraType == CameraType.SceneView && !showInSceneView)) return;
            if (renderingData.cameraData.renderType != CameraRenderType.Base) return;
            if (pass == null) Create();
            // EID4780 is drawn by the same EID4730 queue from ReplayPass.Execute().
            pass.renderPassEvent = injectionPoint;
            renderer.EnqueuePass(pass);
            if (enableColourPass26Hair) renderer.EnqueuePass(hairPass);
        }

        protected override void Dispose(bool disposing)
        {
            pass?.Dispose();
            pass = null;
            hairPass?.Dispose();
            hairPass = null;
        }

        sealed class ReplayPass : ScriptableRenderPass, IDisposable
        {
            static readonly ShaderTagId CharacterTag = new ShaderTagId(ShaderPassName);
            static readonly ShaderTagId EID4812Tag = new ShaderTagId("CharacterForward");
            static readonly ShaderTagId EID4780Tag = new ShaderTagId("EID4780CharacterForward");
            static readonly ShaderTagId EID4785Tag = new ShaderTagId("EID4785CharacterForward");
            static readonly ShaderTagId EID4725Tag = new ShaderTagId("EID4725CharacterForward");
            static readonly ShaderTagId EID4705Tag = new ShaderTagId("EID4705CharacterForward");
            static readonly ShaderTagId EID4740Tag = new ShaderTagId("EID4740CharacterForward");
            static readonly ShaderTagId EID4817Tag = new ShaderTagId("EID4817CharacterForward");

            static readonly ShaderTagId EID4789Tag = new ShaderTagId("EID4789CharacterForward");
            static readonly ShaderTagId EID4794Tag = new ShaderTagId("EID4794CharacterForward");

            static readonly ShaderTagId EID4883Tag = new ShaderTagId("EID4883CharacterForward");

            readonly EID4730RenderFeature owner;
            RTHandle colorTarget;
            RTHandle depthTarget;
            RTHandle sharedCharacterAuxiliary;
            public RTHandle SharedAuxiliary => sharedCharacterAuxiliary;
            // Allocated only by explicit editor diagnostics; never used by normal rendering.
            RTHandle eid4725Auxiliary;
            RTHandle eid4705Auxiliary;
            RTHandle eid4785Auxiliary;
            RTHandle eid4817Auxiliary;
            RTHandle eid4740Auxiliary;
            RTHandle eid4812Auxiliary;
            RTHandle eid4789Auxiliary;
            bool loggedEID4789;
            RTHandle eid4794Auxiliary;
            bool loggedEID4794;
            RTHandle eid4883Auxiliary;
            bool loggedEID4883;
            ReplaySession session;
            EID4812ReplaySession eid4812Session;
            EID4780ReplaySession eid4780Session;
            bool sessionFailed;
            bool loggedBind;
            bool loggedEID4812;
            bool loggedEID4780;
            bool loggedEID4785;
            bool loggedEID4725;
            bool loggedEID4705;
            bool loggedEID4817;
            bool loggedEID4740;

            public ReplayPass(EID4730RenderFeature owner)
            {
                this.owner = owner;
                profilingSampler = new ProfilingSampler("Character Forward / Shared MRT");
            }

            public void SetTargets(RTHandle color, RTHandle depth)
            {
                colorTarget = color;
                depthTarget = depth;
            }

            void EnsureSession()
            {
                if (session != null || sessionFailed)
                    return;
                if (owner.replayShader == null)
                {
                    sessionFailed = true;
                    Debug.LogError("[EID4730] replayShader is missing; cannot bind OriginalVSFS frame resources.");
                    return;
                }
                try
                {
                    session = new ReplaySession(owner.replayShader, owner.verifyCaptureHashes);
                }
                catch (Exception ex)
                {
                    sessionFailed = true;
                    Debug.LogException(ex);
                }
            }

            public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
            {
                if (colorTarget == null)
                    colorTarget = renderingData.cameraData.renderer.cameraColorTargetHandle;
                if (depthTarget == null)
                    depthTarget = renderingData.cameraData.renderer.cameraDepthTargetHandle;
                if (colorTarget != null)
                {
                    if (depthTarget != null)
                        ConfigureTarget(colorTarget, depthTarget);
                    else
                        ConfigureTarget(colorTarget);
                }
                var sharedDesc = renderingData.cameraData.cameraTargetDescriptor;
                sharedDesc.depthBufferBits = 0;
                sharedDesc.graphicsFormat = UnityEngine.Experimental.Rendering.GraphicsFormat.A2B10G10R10_UNormPack32;
                RenderingUtils.ReAllocateIfNeeded(ref sharedCharacterAuxiliary, sharedDesc,
                    FilterMode.Point, TextureWrapMode.Clamp, name: "_CharacterForward_AuxiliaryMRT");
                if (IsolatedAttachmentDiagnostics)
                {
                    if (owner.enableEID4812CharacterForward)
                    {
                        var desc = renderingData.cameraData.cameraTargetDescriptor;
                        desc.depthBufferBits = 0;
                        desc.graphicsFormat = UnityEngine.Experimental.Rendering.GraphicsFormat.A2B10G10R10_UNormPack32;
                        RenderingUtils.ReAllocateIfNeeded(ref eid4812Auxiliary, desc, FilterMode.Point, TextureWrapMode.Clamp, name: "_EID4812_AuxiliaryMRT");
                    }
                    if (owner.enableEID4725CharacterForward)
                    {
                        var desc = renderingData.cameraData.cameraTargetDescriptor;
                        desc.depthBufferBits = 0;
                        desc.graphicsFormat = UnityEngine.Experimental.Rendering.GraphicsFormat.A2B10G10R10_UNormPack32;
                        RenderingUtils.ReAllocateIfNeeded(ref eid4725Auxiliary, desc, FilterMode.Point, TextureWrapMode.Clamp, name: "_EID4725_AuxiliaryMRT");
                    }
                    if (owner.enableEID4705CharacterForward)
                    {
                        var desc = renderingData.cameraData.cameraTargetDescriptor;
                        desc.depthBufferBits = 0;
                        desc.graphicsFormat = UnityEngine.Experimental.Rendering.GraphicsFormat.A2B10G10R10_UNormPack32;
                        RenderingUtils.ReAllocateIfNeeded(ref eid4705Auxiliary, desc, FilterMode.Point, TextureWrapMode.Clamp, name: "_EID4705_AuxiliaryMRT");
                    }
                    if (owner.enableEID4785CharacterForward)
                    {
                        var desc = renderingData.cameraData.cameraTargetDescriptor;
                        desc.depthBufferBits = 0;
                        desc.graphicsFormat = UnityEngine.Experimental.Rendering.GraphicsFormat.A2B10G10R10_UNormPack32;
                        RenderingUtils.ReAllocateIfNeeded(ref eid4785Auxiliary, desc, FilterMode.Point, TextureWrapMode.Clamp, name: "_EID4785_AuxiliaryMRT");
                    }
                    if (owner.enableEID4817CharacterForward)
                    {
                        var desc = renderingData.cameraData.cameraTargetDescriptor;
                        desc.depthBufferBits = 0;
                        desc.graphicsFormat = UnityEngine.Experimental.Rendering.GraphicsFormat.A2B10G10R10_UNormPack32;
                        RenderingUtils.ReAllocateIfNeeded(ref eid4817Auxiliary, desc, FilterMode.Point, TextureWrapMode.Clamp, name: "_EID4817_AuxiliaryMRT");
                    }
                    if (owner.enableEID4740CharacterForward)
                    {
                        var desc = renderingData.cameraData.cameraTargetDescriptor;
                        desc.depthBufferBits = 0;
                        desc.graphicsFormat = UnityEngine.Experimental.Rendering.GraphicsFormat.A2B10G10R10_UNormPack32;
                        RenderingUtils.ReAllocateIfNeeded(ref eid4740Auxiliary, desc, FilterMode.Point, TextureWrapMode.Clamp, name: "_EID4740_AuxiliaryMRT");
                    }
                    if (owner.enableEID4789CharacterForward)
                    {
                        var desc = renderingData.cameraData.cameraTargetDescriptor;
                        desc.depthBufferBits = 0;
                        desc.graphicsFormat = UnityEngine.Experimental.Rendering.GraphicsFormat.A2B10G10R10_UNormPack32;
                        RenderingUtils.ReAllocateIfNeeded(ref eid4789Auxiliary, desc, FilterMode.Point, TextureWrapMode.Clamp, name: "_EID4789_AuxiliaryMRT");
                    }
                    if (owner.enableEID4794CharacterForward)
                    {
                        var desc = renderingData.cameraData.cameraTargetDescriptor;
                        desc.depthBufferBits = 0;
                        desc.graphicsFormat = UnityEngine.Experimental.Rendering.GraphicsFormat.A2B10G10R10_UNormPack32;
                        RenderingUtils.ReAllocateIfNeeded(ref eid4794Auxiliary, desc, FilterMode.Point, TextureWrapMode.Clamp, name: "_EID4794_AuxiliaryMRT");
                    }
                    if (owner.enableEID4883CharacterForward)
                    {
                        var desc = renderingData.cameraData.cameraTargetDescriptor;
                        desc.depthBufferBits = 0;
                        desc.graphicsFormat = UnityEngine.Experimental.Rendering.GraphicsFormat.A2B10G10R10_UNormPack32;
                        RenderingUtils.ReAllocateIfNeeded(ref eid4883Auxiliary, desc, FilterMode.Point, TextureWrapMode.Clamp, name: "_EID4883_AuxiliaryMRT");
                    }
                }
                if (!IsolatedAttachmentDiagnostics)
                {
                    eid4725Auxiliary?.Release(); eid4725Auxiliary = null;
                    eid4705Auxiliary?.Release(); eid4705Auxiliary = null;
                    eid4740Auxiliary?.Release(); eid4740Auxiliary = null;
                    eid4785Auxiliary?.Release(); eid4785Auxiliary = null;
                    eid4789Auxiliary?.Release(); eid4789Auxiliary = null;
                    eid4794Auxiliary?.Release(); eid4794Auxiliary = null;
                    eid4812Auxiliary?.Release(); eid4812Auxiliary = null;
                    eid4817Auxiliary?.Release(); eid4817Auxiliary = null;
                    eid4883Auxiliary?.Release(); eid4883Auxiliary = null;
                }
                ConfigureClear(ClearFlag.None, Color.clear);
            }

            public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
            {
                CommandBuffer cmd = CommandBufferPool.Get();
                RTHandle color = null, depth = null;
                bool restoreTargets = false;
                try
                {
#if UNITY_EDITOR
                    LastCameraId = renderingData.cameraData.camera.GetInstanceID();
                    LastAuxiliaryClearCount = LastTargetBindingCount = LastDrawGroupCount = 0;
#endif
                    EnsureSession();
                    EnsureEID4812Session();
                    EnsureEID4780Session();

                    if (session != null)
                        session.BindFrame(cmd);
                    EID4649ColourPass20Feature.ApplyCharacterForward40Override(cmd, renderingData.cameraData.camera);
                    // EID4812/EID4780 share legacy shader aliases (VS_34_35, VS_29_31, _21_23).
                    // Bind each capture immediately before its draw, never both here.
                    CameraData cameraData = renderingData.cameraData;
                    Matrix4x4 view = cameraData.GetViewMatrix();
                    Matrix4x4 gpuProjection = cameraData.GetGPUProjectionMatrix();
                    cmd.SetViewProjectionMatrices(view, cameraData.GetProjectionMatrix());
                    cmd.SetGlobalMatrix("unity_MatrixVP", gpuProjection * view);
                    cmd.SetGlobalVector("_WorldSpaceCameraPos", cameraData.worldSpaceCameraPos);
                    color = colorTarget != null ? colorTarget : cameraData.renderer.cameraColorTargetHandle;
                    depth = depthTarget != null ? depthTarget : cameraData.renderer.cameraDepthTargetHandle;
                    if (color == null || depth == null || sharedCharacterAuxiliary == null) return;
                    restoreTargets = true;
                    if (IsolatedAttachmentDiagnostics)
                        cmd.SetRenderTarget(color, depth);
                    else
                    {
                        // Capture 4725..4883 share 209599/210525/209543 in pass 4673..4923.
                        // No per-draw clears. The earlier producer of 210525 is not yet wired
                        // to this feature: initialize our owned auxiliary ONCE per camera.
                        // Never clear camera color, depth or stencil.
                        cmd.BeginSample("Character MRT / Initialize auxiliary once");
                        cmd.SetRenderTarget(sharedCharacterAuxiliary);
                        cmd.ClearRenderTarget(false, true, Color.clear);
                        cmd.SetRenderTarget(new RenderTargetIdentifier[] { color.nameID, sharedCharacterAuxiliary.nameID }, depth.nameID);
                        cmd.SetGlobalTexture("_CharacterForward_AuxiliaryMRT", sharedCharacterAuxiliary.nameID);
                        // Old names mean isolated masks, NOT aliases of the accumulated MRT.
                        cmd.SetGlobalTexture("_EID4725_AuxiliaryMRT", Texture2D.blackTexture);
                        cmd.SetGlobalTexture("_EID4705_AuxiliaryMRT", Texture2D.blackTexture);
                        cmd.SetGlobalTexture("_EID4740_AuxiliaryMRT", Texture2D.blackTexture);
                        cmd.SetGlobalTexture("_EID4785_AuxiliaryMRT", Texture2D.blackTexture);
                        cmd.SetGlobalTexture("_EID4789_AuxiliaryMRT", Texture2D.blackTexture);
                        cmd.SetGlobalTexture("_EID4794_AuxiliaryMRT", Texture2D.blackTexture);
                        cmd.SetGlobalTexture("_EID4812_AuxiliaryMRT", Texture2D.blackTexture);
                        cmd.SetGlobalTexture("_EID4817_AuxiliaryMRT", Texture2D.blackTexture);
                        cmd.SetGlobalTexture("_EID4883_AuxiliaryMRT", Texture2D.blackTexture);
                        cmd.EndSample("Character MRT / Initialize auxiliary once");
#if UNITY_EDITOR
                        LastAuxiliaryClearCount++;
                        LastTargetBindingCount += 2;
#endif
                    }
                    context.ExecuteCommandBuffer(cmd);
                    cmd.Clear();

                    if (!loggedBind)
                    {
                        loggedBind = true;
                        Debug.Log("[EID4730] DrawRenderers LightMode=" + ShaderPassName
                            + " override=0 algorithm=OriginalVSFS bindFrame=" + (session != null ? "1" : "0")
                            + " skip=FS_56,FS_58,FS_48_49,VS_32_33");
                    }

                    bool drawEID4705 = owner.enableEID4705CharacterForward
                        && (cameraData.camera.cameraType != CameraType.SceneView || owner.renderEID4705InSceneView);
                    if (drawEID4705 && color != null && depth != null && (IsolatedAttachmentDiagnostics ? eid4705Auxiliary != null : sharedCharacterAuxiliary != null))
                    {
                        EID4705ReplayBinder.PrepareActiveForDraw();
                        BindHairDrawAO(cmd, cameraData.camera, 4705);
                        BeginGroup(context, cmd, cameraData.camera, "EID4705 CharacterForward", eid4705Auxiliary, "_EID4705_AuxiliaryMRT", color, depth);
                        var eid4705Settings = CreateDrawingSettings(EID4705Tag, ref renderingData, cameraData.defaultOpaqueSortFlags);
                        eid4705Settings.perObjectData = PerObjectData.None;
                        eid4705Settings.enableInstancing = false;
                        var eid4705Filter = new FilteringSettings(RenderQueueRange.all, owner.eid4705LayerMask);
                        context.DrawRenderers(renderingData.cullResults, ref eid4705Settings, ref eid4705Filter);
                        EndGroup(context, cmd, "EID4705 CharacterForward", color, depth);
#if UNITY_EDITOR
                        if(CaptureHairForDiagnostics!=null){CaptureHairForDiagnostics(cmd,color,4705);context.ExecuteCommandBuffer(cmd);cmd.Clear();}
#endif
                        if (!loggedEID4705)
                        {
                            loggedEID4705 = true;
                            Debug.Log("[EID4705] DrawRenderers in EID4730 queue LightMode=EID4705CharacterForward liveVP=1 depthTarget="
                                + (depth != null ? "1" : "0") + " injection=" + (int)renderPassEvent);
                        }
                    }

#if UNITY_EDITOR
                    if(CaptureBeforeEID4720ColorForDiagnostics!=null){CaptureBeforeEID4720ColorForDiagnostics(cmd,color);context.ExecuteCommandBuffer(cmd);cmd.Clear();}
#endif
                    if (EID4720ReplayBinder.PrepareActiveForDraw(cmd) > 0) {
                        BeginGroup(context,cmd,cameraData.camera,"EID4720 CharacterForward",null,null,color,depth);
                        var settings4720=CreateDrawingSettings(new ShaderTagId("EID4720CharacterForward"),ref renderingData,cameraData.defaultOpaqueSortFlags);
                        settings4720.perObjectData=PerObjectData.None;settings4720.enableInstancing=false;
                        var filter4720=new FilteringSettings(RenderQueueRange.all,-1);
                        context.DrawRenderers(renderingData.cullResults,ref settings4720,ref filter4720);
                        EndGroup(context,cmd,"EID4720 CharacterForward",color,depth);
                    }
#if UNITY_EDITOR
                    if(CaptureEID4720ColorForDiagnostics!=null){CaptureEID4720ColorForDiagnostics(cmd,color);context.ExecuteCommandBuffer(cmd);cmd.Clear();}
#endif
                    bool drawEID4725 = owner.enableEID4725CharacterForward
                        && (cameraData.camera.cameraType != CameraType.SceneView || owner.renderEID4725InSceneView);
                    if (drawEID4725 && color != null && depth != null && (IsolatedAttachmentDiagnostics ? eid4725Auxiliary != null : sharedCharacterAuxiliary != null))
                    {
                        // Material textures survive shader import; its CB/SSBO bindings do not.
                        // Reassert the independent face resources for Game and SceneView cameras.
                        EID4725ReplayBinder.PrepareActiveForDraw();
                        // Capture EID4725 writes R11G11B10 + R10G10B10A2 with shared depth.
                        // All production draws retain the same shared attachments.
                        BindHairDrawAO(cmd, cameraData.camera, 4725);
                        BeginGroup(context, cmd, cameraData.camera, "EID4725 CharacterForward", eid4725Auxiliary, "_EID4725_AuxiliaryMRT", color, depth);
                        var eid4725Settings = CreateDrawingSettings(EID4725Tag, ref renderingData, cameraData.defaultOpaqueSortFlags);
                        eid4725Settings.perObjectData = PerObjectData.None;
                        eid4725Settings.enableInstancing = false;
                        var eid4725Filter = new FilteringSettings(RenderQueueRange.all, owner.eid4725LayerMask);
                        context.DrawRenderers(renderingData.cullResults, ref eid4725Settings, ref eid4725Filter);
                        EndGroup(context, cmd, "EID4725 CharacterForward", color, depth);
#if UNITY_EDITOR
                        if (CaptureEID4725ColorForDiagnostics != null)
                        {
                            CaptureEID4725ColorForDiagnostics(cmd, color);
                            CaptureEID4725DepthForDiagnostics?.Invoke(cmd, depth);
                            context.ExecuteCommandBuffer(cmd);
                            cmd.Clear();
                        }
#endif

                        if (!loggedEID4725)
                        {
                            loggedEID4725 = true;
                            Debug.Log("[EID4725] DrawRenderers in EID4730 queue LightMode=EID4725CharacterForward liveVP=1 depthTarget="
                                + (depth != null ? "1" : "0") + " injection=" + (int)renderPassEvent);
                        }
                    }

                    BeginGroup(context, cmd, cameraData.camera, "EID4730 CharacterForward group", null, null, color, depth);
                    DrawingSettings drawingSettings = CreateDrawingSettings(CharacterTag, ref renderingData, cameraData.defaultOpaqueSortFlags);
                    drawingSettings.perObjectData = PerObjectData.None;
                    drawingSettings.enableInstancing = false;
                    FilteringSettings filteringSettings = new FilteringSettings(RenderQueueRange.all, -1);
                    context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref filteringSettings);
                    EndGroup(context, cmd, "EID4730 CharacterForward group", color, depth);
#if UNITY_EDITOR
                    if (CaptureEID4765ColorForDiagnostics != null)
                    {
                        CaptureEID4765ColorForDiagnostics(cmd, color);
                        context.ExecuteCommandBuffer(cmd);
                        cmd.Clear();
                    }
#endif

                    bool drawEID4740 = owner.enableEID4740CharacterForward
                        && (cameraData.camera.cameraType != CameraType.SceneView || owner.renderEID4740InSceneView);
                    if (drawEID4740 && color != null && depth != null && (IsolatedAttachmentDiagnostics ? eid4740Auxiliary != null : sharedCharacterAuxiliary != null))
                    {
                        // The capture CB/SSBO bindings are not serialized in .mat and shader
                        // reimport can invalidate them while the binder remains enabled.
                        EID4740ReplayBinder.PrepareActiveForDraw();
                        BeginGroup(context, cmd, cameraData.camera, "EID4740 CharacterForward", eid4740Auxiliary, "_EID4740_AuxiliaryMRT", color, depth);
                        var eid4740Settings = CreateDrawingSettings(EID4740Tag, ref renderingData, cameraData.defaultOpaqueSortFlags);
                        eid4740Settings.perObjectData = PerObjectData.None;
                        eid4740Settings.enableInstancing = false;
                        var eid4740Filter = new FilteringSettings(RenderQueueRange.all, owner.eid4740LayerMask);
                        context.DrawRenderers(renderingData.cullResults, ref eid4740Settings, ref eid4740Filter);
                        EndGroup(context, cmd, "EID4740 CharacterForward", color, depth);
                        if (!loggedEID4740)
                        {
                            loggedEID4740 = true;
                            Debug.Log("[EID4740] DrawRenderers in EID4730 queue LightMode=EID4740CharacterForward liveVP=1 depthTarget="
                                + (depth != null ? "1" : "0") + " injection=" + (int)renderPassEvent);
                        }
                    }

                    bool drawEID4780 = owner.enableEID4780CharacterForward
                        && (cameraData.camera.cameraType != CameraType.SceneView || owner.renderEID4780InSceneView);
                    if (drawEID4780)
                    {
                        if (eid4780Session != null) eid4780Session.Bind(cmd);
                        EID4649ColourPass20Feature.ApplyCharacterForward40Override(cmd, cameraData.camera);
                        BeginGroup(context, cmd, cameraData.camera, "EID4780 CharacterForward", null, null, color, depth);
                        var eid4780Settings = CreateDrawingSettings(EID4780Tag, ref renderingData, cameraData.defaultOpaqueSortFlags);
                        eid4780Settings.perObjectData = PerObjectData.None;
                        eid4780Settings.enableInstancing = false;
                        var eid4780Filter = new FilteringSettings(RenderQueueRange.all, owner.eid4780LayerMask);
                        context.DrawRenderers(renderingData.cullResults, ref eid4780Settings, ref eid4780Filter);
                        EndGroup(context, cmd, "EID4780 CharacterForward", color, depth);
#if UNITY_EDITOR
                        if (CaptureEID4780ColorForDiagnostics != null)
                        {
                            CaptureEID4780ColorForDiagnostics(cmd, color);
                            context.ExecuteCommandBuffer(cmd);
                            cmd.Clear();
                        }
#endif

                        if (!loggedEID4780)
                        {
                            loggedEID4780 = true;
                            Debug.Log("[EID4780] DrawRenderers in EID4730 queue LightMode=EID4780CharacterForward session="
                                + (eid4780Session != null ? "1" : "0")
                                + " textures=" + (eid4780Session != null ? eid4780Session.TextureBindingCount : 0)
                                + " buffers=" + (eid4780Session != null ? eid4780Session.BufferBindingCount : 0)
                                + " liveVP=1 depthTarget=" + (depth != null ? "1" : "0")
                                + " injection=" + (int)renderPassEvent);
                        }
                    }

                    bool drawEID4785 = owner.enableEID4785CharacterForward
                        && (cameraData.camera.cameraType != CameraType.SceneView || owner.renderEID4785InSceneView);
                    if (drawEID4785 && color != null && depth != null && (IsolatedAttachmentDiagnostics ? eid4785Auxiliary != null : sharedCharacterAuxiliary != null))
                    {
                        // Recover non-serialized bindings after shader/material import without activation toggles.
                        EID4785ReplayBinder.PrepareActiveForDraw(cmd);
                        // Capture EID4785 writes R11G11B10 + R10G10B10A2 with shared depth.
                        // All production draws retain the same shared attachments.
                        BeginGroup(context, cmd, cameraData.camera, "EID4785 CharacterForward", eid4785Auxiliary, "_EID4785_AuxiliaryMRT", color, depth);
                        var eid4785Settings = CreateDrawingSettings(EID4785Tag, ref renderingData, cameraData.defaultOpaqueSortFlags);
                        eid4785Settings.perObjectData = PerObjectData.None;
                        eid4785Settings.enableInstancing = false;
                        var eid4785Filter = new FilteringSettings(RenderQueueRange.all, owner.eid4785LayerMask);
                        context.DrawRenderers(renderingData.cullResults, ref eid4785Settings, ref eid4785Filter);
                        EndGroup(context, cmd, "EID4785 CharacterForward", color, depth);
#if UNITY_EDITOR
                        if (CaptureEID4785ColorForDiagnostics != null)
                        {
                            CaptureEID4785ColorForDiagnostics(cmd, color);
                            context.ExecuteCommandBuffer(cmd);
                            cmd.Clear();
                        }
#endif
                        if (!loggedEID4785)
                        {
                            loggedEID4785 = true;
                            Debug.Log("[EID4785] DrawRenderers in EID4730 queue LightMode=EID4785CharacterForward liveVP=1 depthTarget="
                                + (depth != null ? "1" : "0") + " injection=" + (int)renderPassEvent);
                        }
                    }

                    bool drawEID4789 = owner.enableEID4789CharacterForward
                        && (cameraData.camera.cameraType != CameraType.SceneView || owner.renderEID4789InSceneView);
                    if (drawEID4789 && color != null && depth != null && (IsolatedAttachmentDiagnostics ? eid4789Auxiliary != null : sharedCharacterAuxiliary != null))
                    {
                        // Capture CB/SSBO bindings are restored immediately before the draw.
                        EID4789ReplayBinder.PrepareActiveForDraw(cmd);
                        BeginGroup(context, cmd, cameraData.camera, "EID4789 CharacterForward", eid4789Auxiliary, "_EID4789_AuxiliaryMRT", color, depth);
                        var eid4789Settings = CreateDrawingSettings(EID4789Tag, ref renderingData, cameraData.defaultOpaqueSortFlags);
                        eid4789Settings.perObjectData = PerObjectData.None;
                        eid4789Settings.enableInstancing = false;
                        var eid4789Filter = new FilteringSettings(RenderQueueRange.all, owner.eid4789LayerMask);
                        context.DrawRenderers(renderingData.cullResults, ref eid4789Settings, ref eid4789Filter);
                        EndGroup(context, cmd, "EID4789 CharacterForward", color, depth);
#if UNITY_EDITOR
                        if (CaptureEID4789ColorForDiagnostics != null)
                        {
                            CaptureEID4789ColorForDiagnostics(cmd, color);
                            context.ExecuteCommandBuffer(cmd);
                            cmd.Clear();
                        }
#endif
                        if (!loggedEID4789)
                        {
                            loggedEID4789 = true;
                            Debug.Log("[EID4789] DrawRenderers in EID4730 queue LightMode=EID4789CharacterForward liveVP=1 depthTarget="
                                + (depth != null ? "1" : "0") + " injection=" + (int)renderPassEvent);
                        }
                    }

                    bool drawEID4794 = owner.enableEID4794CharacterForward
                        && (cameraData.camera.cameraType != CameraType.SceneView || owner.renderEID4794InSceneView);
                    if (drawEID4794 && color != null && depth != null && (IsolatedAttachmentDiagnostics ? eid4794Auxiliary != null : sharedCharacterAuxiliary != null))
                    {
                        // The capture CB/SSBO bindings are not serialized in .mat and shader
                        // reimport can invalidate them while the binder remains enabled.
                        EID4794ReplayBinder.PrepareActiveForDraw();
                        BindHairDrawAO(cmd, cameraData.camera, 4794);
                        BeginGroup(context, cmd, cameraData.camera, "EID4794 CharacterForward", eid4794Auxiliary, "_EID4794_AuxiliaryMRT", color, depth);
                        var eid4794Settings = CreateDrawingSettings(EID4794Tag, ref renderingData, cameraData.defaultOpaqueSortFlags);
                        eid4794Settings.perObjectData = PerObjectData.None;
                        eid4794Settings.enableInstancing = false;
                        var eid4794Filter = new FilteringSettings(RenderQueueRange.all, owner.eid4794LayerMask);
                        context.DrawRenderers(renderingData.cullResults, ref eid4794Settings, ref eid4794Filter);
                        EndGroup(context, cmd, "EID4794 CharacterForward", color, depth);
#if UNITY_EDITOR
                        if(CaptureHairForDiagnostics!=null){CaptureHairForDiagnostics(cmd,color,4794);context.ExecuteCommandBuffer(cmd);cmd.Clear();}
#endif
                        if (!loggedEID4794)
                        {
                            loggedEID4794 = true;
                            Debug.Log("[EID4794] DrawRenderers in EID4730 queue LightMode=EID4794CharacterForward liveVP=1 depthTarget="
                                + (depth != null ? "1" : "0") + " injection=" + (int)renderPassEvent);
                        }
                    }

                    // Preserve capture action order in the same EID4730 replay pass.
                    // EID1721 uses captured PS216008, not the generic character shader.
                    if (color != null && depth != null && sharedCharacterAuxiliary != null)
                    {
                        EID4798ReplayBinder.PrepareActiveForDraw();
                        BindHairDrawAO(cmd, cameraData.camera, 4798);
                        BeginGroup(context, cmd, cameraData.camera, "EID4798 CharacterForward", null, null, color, depth);
                        var ds4798 = CreateDrawingSettings(new ShaderTagId("EID4798CharacterForward"), ref renderingData, cameraData.defaultOpaqueSortFlags);
                        ds4798.perObjectData = PerObjectData.None; ds4798.enableInstancing = false;
                        var filter4798 = new FilteringSettings(RenderQueueRange.all, -1);
                        context.DrawRenderers(renderingData.cullResults, ref ds4798, ref filter4798);
                        EndGroup(context, cmd, "EID4798 CharacterForward", color, depth);
#if UNITY_EDITOR
                        if (CaptureHairForDiagnostics != null) { CaptureHairForDiagnostics(cmd, color, 4798); context.ExecuteCommandBuffer(cmd); cmd.Clear(); }
#endif
                    }

                    bool drawEID4812 = owner.enableEID4812CharacterForward
                        && (cameraData.camera.cameraType != CameraType.SceneView || owner.renderEID4812InSceneView);
                    if (drawEID4812 && eid4812Session != null && color != null && depth != null && (IsolatedAttachmentDiagnostics ? eid4812Auxiliary != null : sharedCharacterAuxiliary != null))
                    {
                        eid4812Session.Bind(cmd);
                        EID4649ColourPass20Feature.ApplyCharacterForward40Override(cmd, cameraData.camera);
                        BindHairDrawAO(cmd, cameraData.camera, 4812);
                        BeginGroup(context, cmd, cameraData.camera, "EID4812 CharacterForward", eid4812Auxiliary, "_EID4812_AuxiliaryMRT", color, depth);
                        var eidSettings = CreateDrawingSettings(EID4812Tag, ref renderingData, cameraData.defaultOpaqueSortFlags);
                        eidSettings.perObjectData = PerObjectData.None;
                        eidSettings.enableInstancing = false;
                        var eidFilter = new FilteringSettings(RenderQueueRange.all, owner.eid4812LayerMask);
                        context.DrawRenderers(renderingData.cullResults, ref eidSettings, ref eidFilter);
                        EndGroup(context, cmd, "EID4812 CharacterForward", color, depth);
#if UNITY_EDITOR
                        if(CaptureHairForDiagnostics!=null){CaptureHairForDiagnostics(cmd,color,4812);context.ExecuteCommandBuffer(cmd);cmd.Clear();}
#endif
                        if (!loggedEID4812)
                        {
                            loggedEID4812 = true;
                            Debug.Log("[EID4812] DrawRenderers LightMode=CharacterForward session=" + (eid4812Session != null ? "1" : "0")
                                + " textures=" + (eid4812Session != null ? eid4812Session.TextureBindingCount : 0)
                                + " buffers=" + (eid4812Session != null ? eid4812Session.BufferBindingCount : 0)
                                + " liveVP=1 depth=Equal sharedDepth=1 MRT=2 justInTimeBindings=1");
                        }
                    }

                    bool drawEID4817 = owner.enableEID4817CharacterForward
                        && (cameraData.camera.cameraType != CameraType.SceneView || owner.renderEID4817InSceneView);
                    if (drawEID4817 && color != null && depth != null && (IsolatedAttachmentDiagnostics ? eid4817Auxiliary != null : sharedCharacterAuxiliary != null))
                    {
                        // The capture CB/SSBO bindings are not serialized in .mat and shader
                        // reimport can invalidate them while the binder remains enabled.
#if UNITY_EDITOR
                        if(CaptureEID4817ColorForDiagnostics!=null){CaptureEID4817ColorForDiagnostics(cmd,color,false);context.ExecuteCommandBuffer(cmd);cmd.Clear();}
#endif
                        EID4817ReplayBinder.PrepareActiveForDraw();
                        BeginGroup(context, cmd, cameraData.camera, "EID4817 CharacterForward", eid4817Auxiliary, "_EID4817_AuxiliaryMRT", color, depth);
                        var eid4817Settings = CreateDrawingSettings(EID4817Tag, ref renderingData, cameraData.defaultOpaqueSortFlags);
                        eid4817Settings.perObjectData = PerObjectData.None;
                        eid4817Settings.enableInstancing = false;
                        var eid4817Filter = new FilteringSettings(RenderQueueRange.all, owner.eid4817LayerMask);
                        context.DrawRenderers(renderingData.cullResults, ref eid4817Settings, ref eid4817Filter);
                        EndGroup(context, cmd, "EID4817 CharacterForward", color, depth);
#if UNITY_EDITOR
                        if(CaptureEID4817ColorForDiagnostics!=null){CaptureEID4817ColorForDiagnostics(cmd,color,true);context.ExecuteCommandBuffer(cmd);cmd.Clear();}
#endif
                        if (!loggedEID4817)
                        {
                            loggedEID4817 = true;
                            Debug.Log("[EID4817] DrawRenderers in EID4730 queue LightMode=EID4817CharacterForward liveVP=1 depthTarget="
                                + (depth != null ? "1" : "0") + " injection=" + (int)renderPassEvent);
                        }
                    }

                    bool drawEID4883 = owner.enableEID4883CharacterForward
                        && (cameraData.camera.cameraType != CameraType.SceneView || owner.renderEID4883InSceneView);
                    if (drawEID4883 && color != null && depth != null && (IsolatedAttachmentDiagnostics ? eid4883Auxiliary != null : sharedCharacterAuxiliary != null))
                    {
                        // The capture CB/SSBO bindings are not serialized in .mat and shader
                        // reimport can invalidate them while the binder remains enabled.
                        EID4883ReplayBinder.PrepareActiveForDraw();
                        BeginGroup(context, cmd, cameraData.camera, "EID4883 CharacterForward", eid4883Auxiliary, "_EID4883_AuxiliaryMRT", color, depth);
                        var eid4883Settings = CreateDrawingSettings(EID4883Tag, ref renderingData, cameraData.defaultOpaqueSortFlags);
                        eid4883Settings.perObjectData = PerObjectData.None;
                        eid4883Settings.enableInstancing = false;
                        var eid4883Filter = new FilteringSettings(RenderQueueRange.all, owner.eid4883LayerMask);
                        context.DrawRenderers(renderingData.cullResults, ref eid4883Settings, ref eid4883Filter);
                        EndGroup(context, cmd, "EID4883 CharacterForward", color, depth);
                        if (!loggedEID4883)
                        {
                            loggedEID4883 = true;
                            Debug.Log("[EID4883] DrawRenderers in EID4730 queue LightMode=EID4883CharacterForward liveVP=1 depthTarget="
                                + (depth != null ? "1" : "0") + " injection=" + (int)renderPassEvent);
                        }
                    }





#if UNITY_EDITOR
                    if (CaptureCharacterColorForDiagnostics != null)
                    {
                        CaptureCharacterColorForDiagnostics(cmd, color);
                        context.ExecuteCommandBuffer(cmd);
                        cmd.Clear();
                    }
#endif
                }
                catch (Exception ex)
                {
                    Debug.LogException(ex);
                }
                finally
                {
                    try
                    {
                        if (restoreTargets)
                        {
                            cmd.Clear();
                            cmd.SetRenderTarget(color, depth);
                            context.ExecuteCommandBuffer(cmd);
#if UNITY_EDITOR
                            LastTargetBindingCount++;
#endif
                        }
                    }
                    finally { CommandBufferPool.Release(cmd); }
                }
            }

            static void BindHairDrawAO(CommandBuffer cmd, Camera camera, int eid)
            {
                EID4649ColourPass20Feature.BindDrawScopedCharacterAO(cmd, camera, Shader.PropertyToID("_EID" + eid + "DrawAO"));
                cmd.SetGlobalFloat("_EID" + eid + "UseDrawAO", 1f);
                cmd.SetGlobalFloat("_EID" + eid + "AOAudit", 0f);
#if UNITY_EDITOR
                cmd.SetGlobalFloat("_EID" + eid + "UseDrawAO", HairLegacyAOForDiagnostics ? 0f : 1f);
                cmd.SetGlobalFloat("_EID" + eid + "AOAudit", HairAOAuditForDiagnostics ? 1f : 0f);
#endif
            }

            void BeginGroup(ScriptableRenderContext context, CommandBuffer cmd, Camera camera, string label,
                RTHandle diagnosticAuxiliary, string diagnosticName, RTHandle color, RTHandle depth)
            {
                EID4649ColourPass20Feature.ApplyCharacterForward40Override(cmd, camera);
                cmd.BeginSample(label);
                if (IsolatedAttachmentDiagnostics && diagnosticAuxiliary != null)
                {
                    cmd.SetRenderTarget(diagnosticAuxiliary);
                    cmd.ClearRenderTarget(false, true, Color.clear);
                    cmd.SetRenderTarget(new RenderTargetIdentifier[] { color.nameID, diagnosticAuxiliary.nameID }, depth.nameID);
                    cmd.SetGlobalTexture(diagnosticName, diagnosticAuxiliary.nameID);
#if UNITY_EDITOR
                    LastAuxiliaryClearCount++;
                    LastTargetBindingCount += 2;
#endif
                }
                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();
#if UNITY_EDITOR
                LastDrawGroupCount++;
#endif
            }

            void EndGroup(ScriptableRenderContext context, CommandBuffer cmd, string label, RTHandle color, RTHandle depth)
            {
                cmd.EndSample(label);
                if (IsolatedAttachmentDiagnostics)
                {
                    cmd.SetRenderTarget(color, depth);
#if UNITY_EDITOR
                    LastTargetBindingCount++;
#endif
                }
                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();
            }

            void EnsureEID4812Session()
            {
                if (eid4812Session != null || !owner.enableEID4812CharacterForward) return;
                try
                {
                    string path = System.IO.Path.Combine(UnityEngine.Application.dataPath, "EID4812_RenderDocRestore/StreamingAssets/replay.json");
                    eid4812Session = new EID4812ReplaySession(path);
                }
                catch (Exception ex)
                {
                    Debug.LogException(ex);
                    owner.enableEID4812CharacterForward = false;
                }
            }

            void EnsureEID4780Session()
            {
                if (eid4780Session != null || !owner.enableEID4780CharacterForward) return;
                try
                {
                    string path = System.IO.Path.Combine(UnityEngine.Application.dataPath, "EID4780_RenderDocRestore/StreamingAssets/replay.json");
                    eid4780Session = new EID4780ReplaySession(path);
                }
                catch (Exception ex)
                {
                    Debug.LogException(ex);
                    owner.enableEID4780CharacterForward = false;
                }
            }

            public void Dispose()
            {
                colorTarget = null;
                depthTarget = null;
                sharedCharacterAuxiliary?.Release();
                sharedCharacterAuxiliary = null;
                eid4725Auxiliary?.Release();
                eid4725Auxiliary = null;
                eid4705Auxiliary?.Release();
                eid4705Auxiliary = null;
                eid4785Auxiliary?.Release();
                eid4785Auxiliary = null;
                eid4812Auxiliary?.Release();
                eid4812Auxiliary = null;
                eid4817Auxiliary?.Release();
                eid4817Auxiliary = null;
                eid4740Auxiliary?.Release();
                eid4740Auxiliary = null;
                eid4789Auxiliary?.Release();
                eid4789Auxiliary = null;
                loggedEID4789 = false;
                eid4794Auxiliary?.Release();
                eid4794Auxiliary = null;
                loggedEID4794 = false;
                eid4883Auxiliary?.Release();
                eid4883Auxiliary = null;
                loggedEID4883 = false;
                session?.Dispose();
                eid4812Session?.Dispose();
                eid4780Session?.Dispose();
                eid4812Session = null;
                eid4780Session = null;
                session = null;
                sessionFailed = false;
                loggedBind = false;
                loggedEID4812 = false;
                loggedEID4780 = false;
                loggedEID4785 = false;
                loggedEID4725 = false;
                loggedEID4705 = false;
                loggedEID4817 = false;
                loggedEID4740 = false;
            }
        }
    }
}













