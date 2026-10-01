using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public sealed class EID4673CharacterForwardFeature : ScriptableRendererFeature
{
    public const string ShaderPassName = "EID4673CharacterForward";

    [Serializable]
    public sealed class Settings
    {
        [Tooltip("独立 Feature。AfterRenderingDeferredLights+5=245，排在植被 LightPass 240 之后、Combined 250 之前。写 Camera Color，Load depth，不清屏。")]
        public RenderPassEvent injectionPoint = (RenderPassEvent)((int)RenderPassEvent.AfterRenderingDeferredLights + 5);
        public bool renderInGameView = true;
        public bool renderInSceneView = true;
        public bool enabledForCamera = true;
        public LayerMask layerMask = -1;
        [Tooltip("捕获 EID4730 set1 t1 rid195422 256x256 LUT。空则 Editor 从 UnityNative 加载。不要绑 rid195216。")]
        public Texture lut48;
        [Tooltip("捕获 EID4730 t22 rid209554 1366x768 屏幕阴影。空则 Editor 从 UnityNative 加载。")]
        public Texture shadow38;
        [Tooltip("捕获 EID4730 t36 rid209575 86x48x128 体积雾。空则 Editor 从 UnityNative 加载。")]
        public Texture fog56;
        [Tooltip("捕获 EID4730 t35 _40 rid198552 fine data。空则 Editor 从 UnityNative 加载。")]
        public Texture irrFineData;
        [Tooltip("捕获 EID4730 t32 _41 rid198555 fine weight。")]
        public Texture irrFineWeight;
        [Tooltip("捕获 EID4730 t34 _42 rid198558 med data。")]
        public Texture irrMedData;
        [Tooltip("捕获 EID4730 t31 _43 rid198561 med weight。")]
        public Texture irrMedWeight;
        [Tooltip("捕获 EID4730 t33 _44 rid198564 coarse data。")]
        public Texture irrCoarseData;
        [Tooltip("捕获 EID4730 t30 _45 rid198567 coarse weight。")]
        public Texture irrCoarseWeight;
    }

    public Settings settings = new Settings();
    Pass pass;
    static readonly HashSet<int> LoggedCameras = new HashSet<int>();
    static readonly HashSet<int> LoggedSkips = new HashSet<int>();

    public override void Create()
    {
        pass = new Pass(settings);
        pass.renderPassEvent = settings.injectionPoint;
    }

    protected override void Dispose(bool disposing)
    {
        pass?.Dispose();
        pass = null;
    }

    public override void SetupRenderPasses(ScriptableRenderer renderer, in RenderingData renderingData)
    {
        if (pass == null)
            return;
        pass.SetTargets(renderer.cameraColorTargetHandle, renderer.cameraDepthTargetHandle);
    }

    void LogSkip(Camera camera, string reason)
    {
        if (camera == null)
            return;
        int id = camera.GetInstanceID();
        if (!LoggedSkips.Add(id))
            return;
        Debug.LogWarning("[EID4673] skip enqueue camera=" + camera.name + " type=" + camera.cameraType + " reason=" + reason);
    }

    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        if (pass == null)
        {
            Create();
            if (pass == null)
                return;
        }
        if (!settings.enabledForCamera)
        {
            LogSkip(renderingData.cameraData.camera, "enabledForCamera=0");
            return;
        }

        Camera camera = renderingData.cameraData.camera;
        if (camera == null || camera.cameraType == CameraType.Preview || camera.cameraType == CameraType.Reflection)
            return;

        if (renderingData.cameraData.isSceneViewCamera)
        {
            if (!settings.renderInSceneView)
            {
                LogSkip(camera, "renderInSceneView=0");
                return;
            }
        }
        else if (!settings.renderInGameView)
        {
            LogSkip(camera, "renderInGameView=0");
            return;
        }

        var controller = UnityEngine.Object.FindObjectOfType<EID3332CombinedDeferredController>();
        if (controller == null)
        {
            LogSkip(camera, "no EID3332CombinedDeferredController");
            return;
        }
        if (!controller.IsForCamera(camera))
        {
            LogSkip(camera, "IsForCamera=0 target=" + (controller.targetCamera != null ? controller.targetCamera.name : "null"));
            return;
        }
        if (!controller.UseEID3336FiveMRT(camera))
        {
            LogSkip(camera, "UseEID3336FiveMRT=0 useURPFiveMRT=" + controller.useURPFiveMRT);
            return;
        }

        pass.renderPassEvent = settings.injectionPoint;
        pass.ConfigureInput(ScriptableRenderPassInput.None);
        if (LoggedCameras.Add(camera.GetInstanceID()))
            Debug.Log("[EID4673] Enqueue Character Forward camera=" + camera.name + " type=" + camera.cameraType + " injection=" + (int)settings.injectionPoint);
        renderer.EnqueuePass(pass);
    }

    sealed class Pass : ScriptableRenderPass
    {
        static readonly ShaderTagId PassTag = new ShaderTagId(ShaderPassName);

        readonly Settings settings;
        RTHandle colorTarget;
        RTHandle depthTarget;
        Texture cachedLut;
        Texture cachedShadow;
        Texture cachedFog;
        Texture cachedFineData;
        Texture cachedFineWeight;
        Texture cachedMedData;
        Texture cachedMedWeight;
        Texture cachedCoarseData;
        Texture cachedCoarseWeight;
        Texture3D dummyVolume;
        bool buffersLoaded;
        bool loggedBind;
        bool loggedIrrOn;

        public Pass(Settings settings)
        {
            this.settings = settings;
            profilingSampler = new ProfilingSampler("EID4673 Character Forward");
        }

        public void SetTargets(RTHandle color, RTHandle depth)
        {
            colorTarget = color;
            depthTarget = depth;
        }

        public void Dispose()
        {
            colorTarget = null;
            depthTarget = null;
            if (dummyVolume != null)
            {
                if (Application.isPlaying) UnityEngine.Object.Destroy(dummyVolume);
                else UnityEngine.Object.DestroyImmediate(dummyVolume);
                dummyVolume = null;
            }
            buffersLoaded = false;
            loggedBind = false;
            loggedIrrOn = false;
        }

        const string NativeLut = "Assets/EID4673_CharacterForward/Captured/UnityNative/rid195422.asset";
        const string NativeShadow = "Assets/EID4673_CharacterForward/Captured/UnityNative/rid209554.asset";
        const string NativeFog = "Assets/EID4673_CharacterForward/Captured/UnityNative/rid209575.asset";
        const string NativeFineData = "Assets/EID4673_CharacterForward/Captured/UnityNative/rid198552.asset";
        const string NativeFineWeight = "Assets/EID4673_CharacterForward/Captured/UnityNative/rid198555.asset";
        const string NativeMedData = "Assets/EID4673_CharacterForward/Captured/UnityNative/rid198558.asset";
        const string NativeMedWeight = "Assets/EID4673_CharacterForward/Captured/UnityNative/rid198561.asset";
        const string NativeCoarseData = "Assets/EID4673_CharacterForward/Captured/UnityNative/rid198564.asset";
        const string NativeCoarseWeight = "Assets/EID4673_CharacterForward/Captured/UnityNative/rid198567.asset";

        Texture Pick(Texture setting, ref Texture cache, string path)
        {
            if (setting != null)
                return setting;
            if (cache != null)
                return cache;
#if UNITY_EDITOR
            cache = UnityEditor.AssetDatabase.LoadAssetAtPath<Texture>(path);
#endif
            return cache;
        }

        void EnsureBuffers()
        {
            if (buffersLoaded)
                return;
            buffersLoaded = true;
            if (dummyVolume == null)
            {
                dummyVolume = new Texture3D(1, 1, 1, TextureFormat.RGBA32, false)
                {
                    name = "EID4673_DummyVolume",
                    hideFlags = HideFlags.HideAndDontSave,
                    wrapMode = TextureWrapMode.Clamp,
                    filterMode = FilterMode.Point
                };
                dummyVolume.SetPixel(0, 0, 0, Color.clear);
                dummyVolume.Apply(false, true);
            }
        }

        void BindCapturedLighting(CommandBuffer cmd)
        {
            EnsureBuffers();
            Texture lut = Pick(settings.lut48, ref cachedLut, NativeLut);
            Texture shadow = Pick(settings.shadow38, ref cachedShadow, NativeShadow);
            Texture fog = Pick(settings.fog56, ref cachedFog, NativeFog);
            Texture fineData = Pick(settings.irrFineData, ref cachedFineData, NativeFineData);
            Texture fineWeight = Pick(settings.irrFineWeight, ref cachedFineWeight, NativeFineWeight);
            Texture medData = Pick(settings.irrMedData, ref cachedMedData, NativeMedData);
            Texture medWeight = Pick(settings.irrMedWeight, ref cachedMedWeight, NativeMedWeight);
            Texture coarseData = Pick(settings.irrCoarseData, ref cachedCoarseData, NativeCoarseData);
            Texture coarseWeight = Pick(settings.irrCoarseWeight, ref cachedCoarseWeight, NativeCoarseWeight);

            if (lut != null)
                cmd.SetGlobalTexture("_EID215980Lut", lut);
            if (shadow != null)
                cmd.SetGlobalTexture("_EID215980Shadow", shadow);
            if (fog != null)
                cmd.SetGlobalTexture("_EID215980Fog", fog);

            bool irrOn = fineData != null && fineWeight != null && medData != null && medWeight != null
                && coarseData != null && coarseWeight != null;
            if (irrOn)
            {
                cmd.SetGlobalTexture("_EID215980IrrFineData", fineData);
                cmd.SetGlobalTexture("_EID215980IrrFineWeight", fineWeight);
                cmd.SetGlobalTexture("_EID215980IrrMedData", medData);
                cmd.SetGlobalTexture("_EID215980IrrMedWeight", medWeight);
                cmd.SetGlobalTexture("_EID215980IrrCoarseData", coarseData);
                cmd.SetGlobalTexture("_EID215980IrrCoarseWeight", coarseWeight);
                cmd.SetGlobalFloat("_EID215980IrrOn", 1f);
            }
            else
            {
                Texture dummy = dummyVolume;
                cmd.SetGlobalTexture("_EID215980IrrFineData", dummy);
                cmd.SetGlobalTexture("_EID215980IrrFineWeight", dummy);
                cmd.SetGlobalTexture("_EID215980IrrMedData", dummy);
                cmd.SetGlobalTexture("_EID215980IrrMedWeight", dummy);
                cmd.SetGlobalTexture("_EID215980IrrCoarseData", dummy);
                cmd.SetGlobalTexture("_EID215980IrrCoarseWeight", dummy);
                cmd.SetGlobalFloat("_EID215980IrrOn", 0f);
            }

            if (!loggedBind || (irrOn != loggedIrrOn))
            {
                loggedBind = true;
                loggedIrrOn = irrOn;
                Debug.Log("[EID4673] EID4730 bind lut=" + (lut != null ? lut.name : "null")
                    + " shadow=" + (shadow != null ? shadow.name : "null")
                    + " fog=" + (fog != null ? fog.name : "null")
                    + " irrOn=" + (irrOn ? "1" : "0"));
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
            ConfigureClear(ClearFlag.None, Color.clear);
        }

        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            CommandBuffer cmd = CommandBufferPool.Get("EID4673 Character Forward");
            try
            {
                BindCapturedLighting(cmd);
                RTHandle color = colorTarget != null ? colorTarget : renderingData.cameraData.renderer.cameraColorTargetHandle;
                RTHandle depth = depthTarget != null ? depthTarget : renderingData.cameraData.renderer.cameraDepthTargetHandle;
                if (color != null)
                {
                    if (depth != null)
                        cmd.SetRenderTarget(color, depth);
                    else
                        cmd.SetRenderTarget(color);
                }
                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();

                DrawingSettings drawingSettings = CreateDrawingSettings(PassTag, ref renderingData, renderingData.cameraData.defaultOpaqueSortFlags);
                drawingSettings.perObjectData = PerObjectData.None;
                FilteringSettings filteringSettings = new FilteringSettings(RenderQueueRange.all, settings.layerMask);
                context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref filteringSettings);
            }
            finally
            {
                CommandBufferPool.Release(cmd);
            }
        }
    }
}
