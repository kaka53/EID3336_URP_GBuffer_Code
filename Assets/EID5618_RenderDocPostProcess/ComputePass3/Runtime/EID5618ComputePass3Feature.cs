using System;
using System.IO;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
#if UNITY_EDITOR
using UnityEditor;
#endif

public sealed class EID5618ComputePass3Feature : ScriptableRendererFeature
{
    static readonly int[] DownWidth = { 342, 171, 85, 43, 21, 11, 5 };
    static readonly int[] DownHeight = { 192, 96, 48, 24, 12, 6, 3 };
    static readonly int[] DownGroupsX = { 43, 22, 11, 6, 3, 2, 1 };
    static readonly int[] DownGroupsY = { 25, 13, 7, 4, 2, 1, 1 };
    static readonly int[] UpWidth = { 11, 21, 43, 85, 171, 342, 683 };
    static readonly int[] UpHeight = { 6, 12, 24, 48, 96, 192, 384 };
    static readonly int[] UpGroupsX = { 2, 3, 6, 11, 22, 43, 86 };
    static readonly int[] UpGroupsY = { 1, 2, 4, 7, 13, 25, 49 };

    [Serializable]
    public sealed class Settings
    {
        public ComputeShader threshold5542;
        public ComputeShader downsample5546;
        public ComputeShader upsample5574;
        public EID5618ComputePass3Inputs inputs;
        public RenderPassEvent injectionPoint = (RenderPassEvent)550;
        public bool renderInGameView = true;
        public bool renderInSceneView = true;
        public bool enabledForCamera = true;
        public bool publishGlobalRes10 = true;
    }

    public Settings settings = new Settings();
    Pass pass;
    Settings passSettings;

    public override void Create()
    {
        if (pass == null || !ReferenceEquals(passSettings, settings))
        {
            pass?.Dispose();
            pass = new Pass(settings);
            passSettings = settings;
        }
        pass.renderPassEvent = settings.injectionPoint;
    }

    protected override void Dispose(bool disposing)
    {
        pass?.Dispose();
        pass = null;
        passSettings = null;
    }

    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        if (pass == null || !settings.enabledForCamera)
            return;
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
        renderer.EnqueuePass(pass);
    }

    sealed class Pass : ScriptableRenderPass
    {
        static readonly int Src = Shader.PropertyToID("_Src");
        static readonly int SrcLo = Shader.PropertyToID("_SrcLo");
        static readonly int SrcHi = Shader.PropertyToID("_SrcHi");
        static readonly int Dst = Shader.PropertyToID("_Dst");
        static readonly int Uniforms5 = Shader.PropertyToID("CP3Uniforms5");
        static readonly int Threshold13 = Shader.PropertyToID("CP3Threshold13");
        static readonly int Down13 = Shader.PropertyToID("CP3Downsample13");
        static readonly int Up12 = Shader.PropertyToID("CP3Upsample12");
        static readonly int GlobalRes10 = Shader.PropertyToID("_EID5618Res10");

        const string CapturedRoot = "Assets/EID5618_RenderDocPostProcess/CapturedInputs/ComputePass3";
        const int Uniforms5Bytes = 3200;
        const int Threshold13Bytes = 64;

        readonly Settings settings;
        readonly ProfilingSampler sampler = new ProfilingSampler("EID5618 ComputePass3");
        RTHandle cameraColor;
        RTHandle skySrc;
        RTHandle half659;
        readonly RTHandle[] down = new RTHandle[7];
        readonly RTHandle[] up = new RTHandle[7];
        ComputeBuffer cb5;
        ComputeBuffer cbThreshold13;
        readonly ComputeBuffer[] cbDown = new ComputeBuffer[7];
        readonly ComputeBuffer[] cbUp = new ComputeBuffer[7];
        bool buffersReady;
        bool logged;
        bool warned;

        public Pass(Settings settings)
        {
            this.settings = settings;
            ConfigureInput(ScriptableRenderPassInput.None);
        }

        public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
        {
            cameraColor = renderingData.cameraData.renderer.cameraColorTargetHandle;
            Allocate(ref half659, 683, 384, "EID5542_209659");
            for (int i0 = 0; i0 < 7; i0++)
                Allocate(ref down[i0], DownWidth[i0], DownHeight[i0], "EID" + (5546 + i0 * 4) + "_down");
            for (int i1 = 0; i1 < 7; i1++)
                Allocate(ref up[i1], UpWidth[i1], UpHeight[i1], "EID" + (5574 + i1 * 4) + "_up");
            ConfigureTarget(cameraColor);
            ConfigureClear(ClearFlag.None, Color.clear);
        }

        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            if (settings.threshold5542 == null || settings.downsample5546 == null || settings.upsample5574 == null)
            {
                WarnOnce("[EID5618 CP3] Missing compute shaders.");
                return;
            }

            if (!EnsureConstantBuffers())
            {
                WarnOnce("[EID5618 CP3] Missing rid526 slices.");
                return;
            }

            CommandBuffer cmd = CommandBufferPool.Get("EID5618 ComputePass3");
            try
            {
                using (new ProfilingScope(cmd, sampler))
                {
                    Texture hdr = ResolveSkySrc(cmd, renderingData.cameraData.camera);
                    if (hdr == null)
                    {
                        WarnOnce("[EID5618 CP3] Missing EID4922 camera color for EID5542 _Src.");
                    }
                    else
                    {
                    int kThresh = settings.threshold5542.FindKernel("CSMain");
                    int kDown = settings.downsample5546.FindKernel("CSMain");
                    int kUp = settings.upsample5574.FindKernel("CSMain");
                    if (kThresh < 0 || kDown < 0 || kUp < 0)
                    {
                        WarnOnce("[EID5618 CP3] CSMain kernel not found.");
                    }
                    else
                    {
                        cmd.SetComputeConstantBufferParam(settings.threshold5542, Uniforms5, cb5, 0, Uniforms5Bytes);
                        cmd.SetComputeConstantBufferParam(settings.threshold5542, Threshold13, cbThreshold13, 0, Threshold13Bytes);
                        cmd.SetComputeTextureParam(settings.threshold5542, kThresh, Src, hdr);
                        cmd.SetComputeTextureParam(settings.threshold5542, kThresh, Dst, half659);
                        DispatchNamed(cmd, "EID5542", settings.threshold5542, kThresh, 86, 49);

                        Texture src = half659;
                        for (int i0 = 0; i0 < 7; i0++)
                        {
                            cmd.SetComputeConstantBufferParam(settings.downsample5546, Down13, cbDown[i0], 0, 16);
                            cmd.SetComputeTextureParam(settings.downsample5546, kDown, Src, src);
                            cmd.SetComputeTextureParam(settings.downsample5546, kDown, Dst, down[i0]);
                            DispatchNamed(cmd, "EID" + (5546 + i0 * 4), settings.downsample5546, kDown, DownGroupsX[i0], DownGroupsY[i0]);
                            src = down[i0];
                        }

                        Texture lo = down[6];
                        Texture hi = down[5];
                        for (int i1 = 0; i1 < 7; i1++)
                        {
                            cmd.SetComputeConstantBufferParam(settings.upsample5574, Up12, cbUp[i1], 0, 48);
                            cmd.SetComputeTextureParam(settings.upsample5574, kUp, SrcLo, lo);
                            cmd.SetComputeTextureParam(settings.upsample5574, kUp, SrcHi, hi);
                            cmd.SetComputeTextureParam(settings.upsample5574, kUp, Dst, up[i1]);
                            DispatchNamed(cmd, "EID" + (5574 + i1 * 4), settings.upsample5574, kUp, UpGroupsX[i1], UpGroupsY[i1]);
                            lo = up[i1];
                            hi = i1 < 5 ? down[4 - i1] : half659;
                        }

                        if (settings.publishGlobalRes10 && up[6] != null)
                            cmd.SetGlobalTexture(GlobalRes10, up[6]);

                        if (!logged)
                        {
                            logged = true;
                            Debug.Log("[EID5618 CP3] hdr=" + Describe(hdr) + " out=" + Describe(up[6] != null ? up[6].rt : null));
                        }
                    }
                    }
                }

                context.ExecuteCommandBuffer(cmd);
            }
            finally
            {
                CommandBufferPool.Release(cmd);
            }
        }

        Texture ResolveSkySrc(CommandBuffer cmd, Camera camera)
        {
            RenderTexture taa = EID5537FixedFrameRendererFeature.GetCurrentOutput(camera);
            if (taa != null) return taa;
            Allocate(ref skySrc, 1366, 768, "EID5542_Src");
            if (skySrc == null || skySrc.rt == null)
                return null;
            if (cameraColor != null && cameraColor.rt != null)
                Blit(cmd, cameraColor, skySrc);
            else
                Blit(cmd, BuiltinRenderTextureType.CameraTarget, skySrc);
            return skySrc;
        }

        static void DispatchNamed(CommandBuffer cmd, string name, ComputeShader shader, int kernel, int groupsX, int groupsY)
        {
            cmd.BeginSample(name);
            cmd.DispatchCompute(shader, kernel, groupsX, groupsY, 1);
            cmd.EndSample(name);
        }

        static void Allocate(ref RTHandle handle, int width, int height, string name)
        {
            var existing = handle?.rt;
            if (existing != null && existing.IsCreated() && existing.width == width && existing.height == height &&
                existing.graphicsFormat == GraphicsFormat.R16G16B16A16_SFloat && existing.enableRandomWrite &&
                existing.antiAliasing == 1) return;
            RenderTextureDescriptor desc = new RenderTextureDescriptor(width, height)
            {
                depthBufferBits = 0,
                msaaSamples = 1,
                mipCount = 1,
                useMipMap = false,
                autoGenerateMips = false,
                sRGB = false,
                enableRandomWrite = true,
                graphicsFormat = GraphicsFormat.R16G16B16A16_SFloat
            };
            RenderingUtils.ReAllocateIfNeeded(ref handle, desc, FilterMode.Bilinear, TextureWrapMode.Clamp, name: name);
        }

        bool EnsureConstantBuffers()
        {
            if (buffersReady)
                return true;

            byte[] u5 = LoadSlice(settings.inputs != null ? settings.inputs.uniforms5_3200 : null, "eid5542_uniforms5_3200.bytes", Uniforms5Bytes);
            byte[] u13 = LoadSlice(settings.inputs != null ? settings.inputs.uniforms13_64 : null, "eid5542_uniforms13_64.bytes", Threshold13Bytes);
            if (u5 == null || u13 == null)
                return false;

            byte[][] downBytes = new byte[7][];
            byte[][] upBytes = new byte[7][];
            for (int i0 = 0; i0 < 7; i0++)
            {
                downBytes[i0] = LoadSlice(DownAsset(i0), DownName(i0), 16);
                if (downBytes[i0] == null)
                    return false;
            }
            for (int i1 = 0; i1 < 7; i1++)
            {
                upBytes[i1] = LoadSlice(UpAsset(i1), UpName(i1), 48);
                if (upBytes[i1] == null)
                    return false;
            }

            if (cb5 == null) cb5 = new ComputeBuffer(Uniforms5Bytes / 16, 16, ComputeBufferType.Constant);
            if (cbThreshold13 == null) cbThreshold13 = new ComputeBuffer(Threshold13Bytes / 16, 16, ComputeBufferType.Constant);
            cb5.SetData(ToUInt4(u5));
            cbThreshold13.SetData(ToUInt4(u13));
            for (int i0 = 0; i0 < 7; i0++)
            {
                if (cbDown[i0] == null) cbDown[i0] = new ComputeBuffer(1, 16, ComputeBufferType.Constant);
                cbDown[i0].SetData(ToUInt4(downBytes[i0]));
            }
            for (int i1 = 0; i1 < 7; i1++)
            {
                if (cbUp[i1] == null) cbUp[i1] = new ComputeBuffer(3, 16, ComputeBufferType.Constant);
                cbUp[i1].SetData(ToUInt4(upBytes[i1]));
            }
            buffersReady = true;
            return true;
        }

        TextAsset DownAsset(int i)
        {
            if (settings.inputs == null) return null;
            switch (i)
            {
                case 0: return settings.inputs.down5546;
                case 1: return settings.inputs.down5550;
                case 2: return settings.inputs.down5554;
                case 3: return settings.inputs.down5558;
                case 4: return settings.inputs.down5562;
                case 5: return settings.inputs.down5566;
                default: return settings.inputs.down5570;
            }
        }

        TextAsset UpAsset(int i)
        {
            if (settings.inputs == null) return null;
            switch (i)
            {
                case 0: return settings.inputs.up5574;
                case 1: return settings.inputs.up5578;
                case 2: return settings.inputs.up5582;
                case 3: return settings.inputs.up5586;
                case 4: return settings.inputs.up5590;
                case 5: return settings.inputs.up5594;
                default: return settings.inputs.up5598;
            }
        }

        static string DownName(int i)
        {
            return "eid" + (5546 + i * 4) + "_uniforms13_16.bytes";
        }

        static string UpName(int i)
        {
            return "eid" + (5574 + i * 4) + "_uniforms12_48.bytes";
        }

        static byte[] LoadSlice(TextAsset assigned, string fileName, int expected)
        {
            if (assigned != null && assigned.bytes != null && assigned.bytes.Length == expected)
                return assigned.bytes;
#if UNITY_EDITOR
            TextAsset asset = AssetDatabase.LoadAssetAtPath<TextAsset>(CapturedRoot + "/" + fileName);
            if (asset != null && asset.bytes != null && asset.bytes.Length == expected)
                return asset.bytes;
#endif
            string path = Path.Combine(Application.dataPath, "EID5618_RenderDocPostProcess/CapturedInputs/ComputePass3", fileName);
            if (File.Exists(path))
            {
                byte[] bytes = File.ReadAllBytes(path);
                if (bytes.Length == expected)
                    return bytes;
            }
            return null;
        }

        static bool IsUsable(Texture texture)
        {
            if (texture == null) return false;
            try { return texture.GetInstanceID() != 0 && texture.width > 0 && texture.height > 0; }
            catch (MissingReferenceException) { return false; }
        }

        struct UInt4 { public uint x, y, z, w; }

        static UInt4[] ToUInt4(byte[] bytes)
        {
            UInt4[] result = new UInt4[bytes.Length / 16];
            for (int i0 = 0; i0 < result.Length; ++i0)
            {
                result[i0].x = BitConverter.ToUInt32(bytes, i0 * 16 + 0);
                result[i0].y = BitConverter.ToUInt32(bytes, i0 * 16 + 4);
                result[i0].z = BitConverter.ToUInt32(bytes, i0 * 16 + 8);
                result[i0].w = BitConverter.ToUInt32(bytes, i0 * 16 + 12);
            }
            return result;
        }

        static string Describe(Texture texture)
        {
            if (texture == null) return "<null>";
            return texture.name + "(" + texture.width + "x" + texture.height + ", " + texture.graphicsFormat + ")";
        }

        void WarnOnce(string message)
        {
            if (warned) return;
            warned = true;
            Debug.LogError(message);
        }

        public void Dispose()
        {
            skySrc?.Release();
            skySrc = null;
            half659?.Release();
            half659 = null;
            for (int i0 = 0; i0 < down.Length; i0++)
            {
                down[i0]?.Release();
                down[i0] = null;
            }
            for (int i1 = 0; i1 < up.Length; i1++)
            {
                up[i1]?.Release();
                up[i1] = null;
            }
            cb5?.Release();
            cbThreshold13?.Release();
            cb5 = null;
            cbThreshold13 = null;
            for (int i0 = 0; i0 < cbDown.Length; i0++)
            {
                cbDown[i0]?.Release();
                cbDown[i0] = null;
            }
            for (int i1 = 0; i1 < cbUp.Length; i1++)
            {
                cbUp[i1]?.Release();
                cbUp[i1] = null;
            }
            buffersReady = false;
            Shader.SetGlobalTexture(GlobalRes10, null);
        }
    }
}
