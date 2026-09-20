using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public sealed class EID4666VegetationLightPassFeature : ScriptableRendererFeature
{
    public const string ShaderName = "Hidden/EID4666/VegetationLightPass";

    [Serializable]
    public sealed class Settings
    {
        [Tooltip("独立 Feature。AfterRenderingDeferredLights=240，排在场景 LightPass 230 之后。写 Camera Color，不清屏。")]
        public RenderPassEvent injectionPoint = RenderPassEvent.AfterRenderingDeferredLights;
        public bool renderInGameView = true;
        public bool renderInSceneView = true;
        public bool enabledForCamera = true;
    }

    public Settings settings = new Settings();
    Pass pass;
    Material materialGame;
    Material materialScene;
    EID4662FullLightPassBinding binding;

    public override void Create()
    {
        pass?.Dispose();
        binding ??= new EID4662FullLightPassBinding();
        EnsureMaterials();
        if (materialGame != null && materialScene != null)
            pass = new Pass(materialGame, materialScene, binding);
        if (pass != null)
            pass.renderPassEvent = settings.injectionPoint;
    }

    static Material CreatePassMaterial(Shader shader, string name)
    {
        Material material = CoreUtils.CreateEngineMaterial(shader);
        material.name = name;
        return material;
    }

    static bool MaterialNeedsRebuild(Material material, Shader shader)
    {
        return material == null || material.shader != shader || material.passCount == 0;
    }

    bool EnsureMaterials()
    {
        Shader shader = Shader.Find(ShaderName);
        if (shader == null || !shader.isSupported)
            return false;
        if (MaterialNeedsRebuild(materialGame, shader))
        {
            if (materialGame != null)
                CoreUtils.Destroy(materialGame);
            materialGame = CreatePassMaterial(shader, "EID4666_VegetationLightPass_Game");
        }
        if (MaterialNeedsRebuild(materialScene, shader))
        {
            if (materialScene != null)
                CoreUtils.Destroy(materialScene);
            materialScene = CreatePassMaterial(shader, "EID4666_VegetationLightPass_Scene");
        }
        return materialGame != null && materialScene != null && materialGame.passCount > 0 && materialScene.passCount > 0;
    }

    protected override void Dispose(bool disposing)
    {
        pass?.Dispose();
        pass = null;
        binding?.Release();
        binding = null;
        if (materialGame != null)
            CoreUtils.Destroy(materialGame);
        if (materialScene != null)
            CoreUtils.Destroy(materialScene);
        materialGame = null;
        materialScene = null;
    }

    public override void SetupRenderPasses(ScriptableRenderer renderer, in RenderingData renderingData)
    {
        if (pass == null)
            return;
        pass.SetTargets(renderer.cameraColorTargetHandle, renderer.cameraDepthTargetHandle);
    }

    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        if (!EnsureMaterials())
            return;
        if (pass == null || pass.UsesMaterials(materialGame, materialScene) == false)
        {
            pass?.Dispose();
            binding ??= new EID4662FullLightPassBinding();
            pass = new Pass(materialGame, materialScene, binding);
        }
        if (pass == null || !settings.enabledForCamera)
            return;

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

        var controller = UnityEngine.Object.FindObjectOfType<EID3332CombinedDeferredController>();
        if (controller == null || !controller.IsForCamera(camera) || !controller.UseEID3336FiveMRT(camera))
            return;

        pass.renderPassEvent = settings.injectionPoint;
        pass.ConfigureInput(ScriptableRenderPassInput.None);
        renderer.EnqueuePass(pass);
    }

    sealed class Pass : ScriptableRenderPass
    {
        static readonly int Id17 = Shader.PropertyToID("_17");
        static readonly int Id18 = Shader.PropertyToID("_18");
        static readonly int Id19 = Shader.PropertyToID("_19");
        static readonly int Id20 = Shader.PropertyToID("_20");
        static readonly int Id21 = Shader.PropertyToID("_21");
        static readonly int Id29 = Shader.PropertyToID("_29");
        static readonly int Id30 = Shader.PropertyToID("_30");
        static readonly int Id32 = Shader.PropertyToID("_32");
        static readonly int Id33 = Shader.PropertyToID("_33");
        static readonly int Id34 = Shader.PropertyToID("_34");
        static readonly int Id37 = Shader.PropertyToID("_37");
        static readonly int Id38 = Shader.PropertyToID("_38");
        static readonly int Id39 = Shader.PropertyToID("_39");
        static readonly int Id40 = Shader.PropertyToID("_40");
        static readonly int Id41 = Shader.PropertyToID("_41");
        static readonly int Id42 = Shader.PropertyToID("_42");
        static readonly int Id43 = Shader.PropertyToID("_43");
        static readonly int Id44 = Shader.PropertyToID("_44");
        static readonly int Id46 = Shader.PropertyToID("_46");
        static readonly int Id47 = Shader.PropertyToID("_47");
        static readonly int Id48 = Shader.PropertyToID("_48");
        static readonly int IdUseLiveCamera = Shader.PropertyToID("_EID4666UseLiveCamera");
        static readonly int IdWorldToView = Shader.PropertyToID("_EID4666WorldToView");
        static readonly int IdClipToWorld = Shader.PropertyToID("_EID4666ClipToWorld");
        static readonly int IdCameraPositionWS = Shader.PropertyToID("_EID4666CameraPositionWS");
        static readonly int IdScreenSize = Shader.PropertyToID("_EID4666ScreenSize");
        static readonly int IdReversedZ = Shader.PropertyToID("_EID4666ReversedZ");
        static readonly int IdDepthEpsilon = Shader.PropertyToID("_EID4666DepthEpsilon");

        static readonly int[] TextureIds =
        {
            Id17, Id18, Id19, Id20, Id21, Id29, Id30, Id32, Id33, Id34,
            Id37, Id38, Id39, Id40, Id41, Id42, Id43, Id44, Id46, Id47, Id48
        };

        readonly Material materialGame;
        readonly Material materialScene;
        readonly EID4662FullLightPassBinding binding;
        readonly MaterialPropertyBlock propertyBlock = new MaterialPropertyBlock();
        RTHandle colorTarget;
        RTHandle depthTarget;
        int warnedMissingCameraId;

        public Pass(Material materialGame, Material materialScene, EID4662FullLightPassBinding binding)
        {
            this.materialGame = materialGame;
            this.materialScene = materialScene;
            this.binding = binding;
            profilingSampler = new ProfilingSampler("EID4666 Vegetation LightPass");
        }

        public bool UsesMaterials(Material game, Material scene)
        {
            return materialGame == game && materialScene == scene;
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
            Camera camera = renderingData.cameraData.camera;
            bool gameCam = IsGameCamera(ref renderingData);
            Material material = gameCam ? materialGame : materialScene;
            if (material == null || camera == null || material.passCount == 0)
                return;

            var controller = UnityEngine.Object.FindObjectOfType<EID3332CombinedDeferredController>();
            if (controller == null || !controller.IsForCamera(camera) || !controller.UseEID3336FiveMRT(camera))
                return;

            CommandBuffer cmd = CommandBufferPool.Get("EID4666 Vegetation LightPass");
            try
            {
                bool useCapturedProjection = controller.UseCapturedProjection(camera);
                binding.Bind(material, useCapturedProjection);

                RTHandle color = colorTarget != null ? colorTarget : renderingData.cameraData.renderer.cameraColorTargetHandle;
                RTHandle depth = depthTarget != null ? depthTarget : renderingData.cameraData.renderer.cameraDepthTargetHandle;
                if (color != null)
                {
                    if (depth != null)
                        cmd.SetRenderTarget(color, depth);
                    else
                        cmd.SetRenderTarget(color);
                }

                bool bound = BindLiveGBuffer(material, camera, controller, depth);
                BindLiveCamera(material, controller, camera, ref renderingData, useCapturedProjection);
                EndfieldCP2ExactReplayFeature.ApplyDeferredLightPassOverride(material, camera);
                EID4649ColourPass20Feature.ApplyDeferredLightPass29Override(material, camera);
                FillPropertyBlock(material);
                if (bound)
                    cmd.DrawProcedural(Matrix4x4.identity, material, 0, MeshTopology.Triangles, 3, 1, propertyBlock);

                context.ExecuteCommandBuffer(cmd);
            }
            finally
            {
                CommandBufferPool.Release(cmd);
            }
        }

        bool BindLiveGBuffer(Material material, Camera camera, EID3332CombinedDeferredController controller, RTHandle cameraDepth)
        {
            Texture depth = null;
            Texture materialPacked = null;
            Texture normal = null;
            Texture baseColor = null;
            EID3336FiveMRTLightingInputs.TryGetVegetationLightPassInputs(
                camera, out depth, out materialPacked, out normal, out baseColor);
            Material lightPass = controller != null ? controller.GetActiveDeferredLightingMaterial(camera) : null;
            MergeFromMaterial(lightPass, "_17", "_46", "_47", "_48",
                ref depth, ref materialPacked, ref normal, ref baseColor);
            MergeFromMaterial(lightPass, "_EID3336B6Depth", "_EID3336B6RT2", "_EID3336B6RT3", "_EID3336B6RT4",
                ref depth, ref materialPacked, ref normal, ref baseColor);
            if (!IsUsable(depth))
                depth = SlotTex(cameraDepth);
            if (!IsUsable(depth))
            {
                Texture cameraDepthTexture = Shader.GetGlobalTexture("_CameraDepthTexture");
                if (IsUsable(cameraDepthTexture))
                    depth = cameraDepthTexture;
            }
            if (!AllUsable(depth, materialPacked, normal, baseColor))
            {
                int cameraId = camera != null ? camera.GetInstanceID() : 0;
                if (warnedMissingCameraId != cameraId)
                {
                    Debug.LogError("[EID4666] Missing live GBuffer for "
                        + (camera != null ? camera.name : "null")
                        + " mode=" + (controller != null ? controller.lightPassMode.ToString() : "null")
                        + " lightPass=" + (lightPass != null ? lightPass.name : "null")
                        + " _17=" + TexLabel(depth)
                        + " _46=" + TexLabel(materialPacked)
                        + " _47=" + TexLabel(normal)
                        + " _48=" + TexLabel(baseColor));
                    warnedMissingCameraId = cameraId;
                }
                return false;
            }
            warnedMissingCameraId = 0;

            material.SetTexture(Id17, depth);
            material.SetTexture(Id46, materialPacked);
            material.SetTexture(Id47, normal);
            material.SetTexture(Id48, baseColor);
            return true;
        }

        static void MergeFromMaterial(Material src, string depthName, string materialName, string normalName, string baseColorName,
            ref Texture depth, ref Texture materialPacked, ref Texture normal, ref Texture baseColor)
        {
            if (src == null)
                return;
            if (!IsUsable(depth))
                depth = NamedTex(src, depthName);
            if (!IsUsable(materialPacked))
                materialPacked = NamedTex(src, materialName);
            if (!IsUsable(normal))
                normal = NamedTex(src, normalName);
            if (!IsUsable(baseColor))
                baseColor = NamedTex(src, baseColorName);
        }

        static Texture NamedTex(Material src, string name)
        {
            if (src == null || !src.HasProperty(name))
                return null;
            Texture texture = src.GetTexture(name);
            return IsUsable(texture) ? texture : null;
        }

        static Texture SlotTex(RTHandle handle)
        {
            if (handle == null)
                return null;
            if (handle.rt != null && IsUsable(handle.rt))
                return handle.rt;
            Texture texture = handle;
            return IsUsable(texture) ? texture : null;
        }

        void BindLiveCamera(Material material, EID3332CombinedDeferredController controller, Camera camera,
            ref RenderingData renderingData, bool useCapturedProjection)
        {
            int width = Mathf.Max(1, renderingData.cameraData.cameraTargetDescriptor.width);
            int height = Mathf.Max(1, renderingData.cameraData.cameraTargetDescriptor.height);
            Vector4 screenSize = new Vector4(width, height, 1f / width, 1f / height);
            material.SetFloat(IdUseLiveCamera, useCapturedProjection ? 0f : 1f);
            material.SetFloat(IdReversedZ, SystemInfo.usesReversedZBuffer ? 1f : 0f);
            material.SetFloat(IdDepthEpsilon, 1e-5f);
            material.SetVector(IdScreenSize, screenSize);

            Matrix4x4 view = controller.GetWorldToView(camera);
            Matrix4x4 worldToClip = controller.GetViewProjection(camera);
            Vector3 cameraPosition = controller.GetCameraPosition(camera);
            material.SetMatrix(IdWorldToView, view);
            material.SetMatrix(IdClipToWorld, worldToClip.inverse);
            material.SetVector(IdCameraPositionWS, new Vector4(cameraPosition.x, cameraPosition.y, cameraPosition.z, 1f));
        }

        void FillPropertyBlock(Material material)
        {
            propertyBlock.Clear();
            for (int i = 0; i < TextureIds.Length; ++i)
            {
                Texture texture = material.GetTexture(TextureIds[i]);
                if (texture != null)
                    propertyBlock.SetTexture(TextureIds[i], texture);
            }
            propertyBlock.SetFloat(IdUseLiveCamera, material.GetFloat(IdUseLiveCamera));
            propertyBlock.SetFloat(IdReversedZ, material.GetFloat(IdReversedZ));
            propertyBlock.SetFloat(IdDepthEpsilon, material.GetFloat(IdDepthEpsilon));
            propertyBlock.SetVector(IdScreenSize, material.GetVector(IdScreenSize));
            propertyBlock.SetVector(IdCameraPositionWS, material.GetVector(IdCameraPositionWS));
            propertyBlock.SetMatrix(IdWorldToView, material.GetMatrix(IdWorldToView));
            propertyBlock.SetMatrix(IdClipToWorld, material.GetMatrix(IdClipToWorld));
        }

        static bool IsGameCamera(ref RenderingData renderingData)
        {
            Camera camera = renderingData.cameraData.camera;
            return camera != null
                && camera.cameraType == CameraType.Game
                && !renderingData.cameraData.isSceneViewCamera;
        }

        static bool IsUsable(Texture texture)
        {
            // Shader property defaults are 1x1 black; live FiveMRT GBuffer is camera-sized.
            return texture != null && texture.width >= 8 && texture.height >= 8;
        }

        static bool AllUsable(Texture depth, Texture materialPacked, Texture normal, Texture baseColor)
        {
            return IsUsable(depth) && IsUsable(materialPacked) && IsUsable(normal) && IsUsable(baseColor);
        }

        static string TexLabel(Texture texture)
        {
            if (texture == null)
                return "null";
            return texture.name + " " + texture.width + "x" + texture.height;
        }
    }
}
