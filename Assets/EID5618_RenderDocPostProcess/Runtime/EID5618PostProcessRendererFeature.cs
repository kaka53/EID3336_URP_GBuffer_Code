using System;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
#if UNITY_EDITOR
using UnityEditor;
#endif

/// <summary>
/// EID5618 RenderDoc colour pass. Res9 is explicitly selectable: captured
/// EID5537 output for deterministic validation, migrated EID5537 generation,
/// or the live camera colour diagnostic fallback. res10/res11 and b5/b6 remain
/// independently bound captured resources.
/// </summary>
public sealed class EID5618PostProcessRendererFeature : ScriptableRendererFeature
{
    [Serializable]
    public sealed class Settings
    {
        [Tooltip("EID5618 exact shader material. If an old LivePostProcess material is assigned, a runtime exact material is created instead.")]
        public Material material;
        [Tooltip("EID5618 RenderDoc texture and constant-buffer inputs.")]
        public EID5618InputProfile inputProfile;
        [Tooltip("EID5618 fullscreen colour pass injection point.")]
        public RenderPassEvent injectionPoint = RenderPassEvent.AfterRenderingPostProcessing;
        public bool renderInGameView = true;
        public bool renderInSceneView = true;
        public bool enabledForCamera = true;

        public enum DebugOutputMode
        {
            Final = 0,
            RawRes9Mapped = 1,
            RawRes10Mapped = 2,
            RawRes11 = 3,
            FinalBeforeOutputDecode = 4,
        }

        [Tooltip("调试输出：Final 为完整 EID5618 FS；RawRes9/10/11 用于确认输入绑定；FinalBeforeOutputDecode 用于隔离颜色空间问题。")]
        public DebugOutputMode debugOutput = DebugOutputMode.Final;
        [Tooltip("HDR 调试输入映射的尺度。RawRes9/RawRes10 下使用，建议 1。")]
        [Min(0.0001f)]
        public float debugScale = 1f;

        public enum BinaryValueChoice { Zero = 0, One = 1 }
        [Header("res10 / _eid5617Res10 bloom")]
        [Tooltip("res10 插值目标，只能选择 0 或 1；0=关闭 bloom，1=强制 1。")]
        public BinaryValueChoice res10LerpValue = BinaryValueChoice.One;
        [Tooltip("res10 采样值到 0/1 目标值的插值权重。0=原始纹理，1=完全使用选择值。")]
        [Range(0f, 1f)] public float res10LerpWeight = 0f;
        [Tooltip("res10 bloom 阈值；max(rgb) 低于此值时按 0 处理。默认 0 保持原始算法。")]
        [Range(0f, 1f)] public float res10Threshold = 0f;
    }

    public Settings settings = new Settings();
    EID5618PostProcessPass pass;
    Material runtimeMaterial;
    Material copyMaterial;
    Material generatedRes9Material;

    public override void Create()
    {
        EnsureMaterial();
        EnsureCopyMaterial();
        EnsureGeneratedRes9Material();
        pass = new EID5618PostProcessPass(settings, runtimeMaterial, copyMaterial, generatedRes9Material);
        pass.renderPassEvent = settings.injectionPoint;
    }

    void EnsureCopyMaterial()
    {
        Shader shader = Shader.Find("Hidden/EID5618/Copy");
        if (shader == null)
        {
            Debug.LogError("[EID5618] Copy shader was not found.");
            return;
        }
        copyMaterial = CoreUtils.CreateEngineMaterial(shader);
        copyMaterial.name = "EID5618_InputCopy_Runtime";
    }

    void EnsureGeneratedRes9Material()
    {
        Shader shader = Shader.Find("Hidden/EID5618/EID5537Res9");
        if (shader == null)
        {
            Debug.LogWarning("[EID5618] Generated EID5537 shader was not found; GeneratedEID5537 mode will fall back to captured res9.");
            return;
        }
        generatedRes9Material = CoreUtils.CreateEngineMaterial(shader);
        generatedRes9Material.name = "EID5537_Res9_Runtime";
    }

    void EnsureMaterial()
    {
        Shader exact = Shader.Find("Hidden/EID5618/ExactRenderDoc");
        if (exact == null)
        {
            Debug.LogError("[EID5618] Hidden/EID5618/ExactRenderDoc shader was not found.");
            return;
        }

        // Do not silently run the historical additive diagnostic shader. It is
        // intentionally kept in the project for comparison only.
        if (settings.material != null && settings.material.shader == exact)
        {
            runtimeMaterial = settings.material;
            return;
        }

        runtimeMaterial = CoreUtils.CreateEngineMaterial(exact);
        runtimeMaterial.name = "EID5618_ExactRenderDoc_Runtime";
    }

    protected override void Dispose(bool disposing)
    {
        pass?.Dispose();
        pass = null;
        if (runtimeMaterial != null && runtimeMaterial != settings.material)
            CoreUtils.Destroy(runtimeMaterial);
        if (copyMaterial != null)
            CoreUtils.Destroy(copyMaterial);
        if (generatedRes9Material != null)
            CoreUtils.Destroy(generatedRes9Material);
        runtimeMaterial = null;
        copyMaterial = null;
        generatedRes9Material = null;
    }

    public override void SetupRenderPasses(ScriptableRenderer renderer, in RenderingData renderingData)
    {
        if (pass != null && runtimeMaterial != null)
            pass.SetTarget(renderer.cameraColorTargetHandle);
    }

    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        if (pass == null || runtimeMaterial == null || !settings.enabledForCamera)
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
}

sealed class EID5618PostProcessPass : ScriptableRenderPass
{
    static readonly int Res9 = Shader.PropertyToID("_EID5618Res9");
    static readonly int CopySource = Shader.PropertyToID("_EID5618Source");
    static readonly int LiveCameraFlipY = Shader.PropertyToID("_EID5618LiveCameraFlipY");
    static readonly int Res10 = Shader.PropertyToID("_EID5618Res10");
    static readonly int Res11 = Shader.PropertyToID("_EID5618Res11");
    static readonly int ExactRT = Shader.PropertyToID("_EID5618ExactRT");
    static readonly int LinearDisplay = Shader.PropertyToID("_EID5618LinearDisplay");
    static readonly int Uniforms7 = Shader.PropertyToID("_7_uniforms7");
    static readonly int OutputDecodeSrgb = Shader.PropertyToID("_EID5618OutputDecodeSrgb");
    static readonly int DebugMode = Shader.PropertyToID("_EID5618DebugMode");
    static readonly int DebugScale = Shader.PropertyToID("_EID5618DebugScale");
    static readonly int Res10LerpValue = Shader.PropertyToID("_EID5618Res10LerpValue");
    static readonly int Res10LerpWeight = Shader.PropertyToID("_EID5618Res10LerpWeight");
    static readonly int Res10Threshold = Shader.PropertyToID("_EID5618Res10Threshold");
    static readonly int B5 = Shader.PropertyToID("_13_14");
    static readonly int B6 = Shader.PropertyToID("_5_6");
    static readonly int GeneratedRes14 = Shader.PropertyToID("_13");
    static readonly int GeneratedRes13 = Shader.PropertyToID("_790");
    static readonly int GeneratedRes17 = Shader.PropertyToID("_15");
    static readonly int GeneratedRes16 = Shader.PropertyToID("_795");
    static readonly int GeneratedRes15 = Shader.PropertyToID("_800");
    static readonly int GeneratedB5 = Shader.PropertyToID("_11_12");
    static readonly int GeneratedB6 = Shader.PropertyToID("_5_6");

    const int B7Bytes = 32;
    const int B5Bytes = 416;
    const int B6Bytes = 3200;
    const int CapturedWidth = 1366;
    const int CapturedHeight = 768;

    readonly Material material;
    readonly Material copyMaterial;
    readonly Material generatedRes9Material;
    readonly EID5618PostProcessRendererFeature.Settings settings;
    RTHandle cameraColor;
    RTHandle liveFullColor;
    RTHandle exactTarget;
    ComputeBuffer uniforms7VS;
    ComputeBuffer uniforms14B5;
    ComputeBuffer uniforms6B6;
    byte[] b7Bytes;
    byte[] b5Bytes;
    byte[] b6Bytes;
    int targetWidth;
    int targetHeight;
    bool warnedMissing;
    bool loggedBindings;

    public EID5618PostProcessPass(EID5618PostProcessRendererFeature.Settings settings, Material material, Material copyMaterial, Material generatedRes9Material)
    {
        this.settings = settings;
        this.material = material;
        this.copyMaterial = copyMaterial;
        this.generatedRes9Material = generatedRes9Material;
        // The pass reads the already allocated cameraColor target directly in
        // LiveCameraColor mode. Requesting ScriptableRenderPassInput.Color here
        // makes URP schedule its automatic CopyColor pass, which can allocate
        // a scaled intermediate (683x384 in this project). That copy is not
        // needed and would add an unintended resolution conversion.
    }

    public void SetTarget(RTHandle target) => cameraColor = target;

    public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
    {
        if (cameraColor == null) return;

        EID5618InputProfile profile = settings.inputProfile;
        bool live = profile != null && profile.res9Source == EID5618InputProfile.Res9SourceMode.LiveCameraColor;
        RenderTextureDescriptor cameraDesc = renderingData.cameraData.cameraTargetDescriptor;
        // Keep LiveCameraColor at the camera descriptor resolution. Do not use
        // cameraColor.rt.width/height here: an RTHandle can expose its scaled
        // physical allocation (for example 683x384) even when the camera
        // target descriptor is 1366x768. The intermediate must not become a
        // half-resolution CopyColor target.
        targetWidth = live ? Mathf.Max(1, cameraDesc.width) : CapturedWidth;
        targetHeight = live ? Mathf.Max(1, cameraDesc.height) : CapturedHeight;

        RenderTextureDescriptor exact = new RenderTextureDescriptor(targetWidth, targetHeight)
        {
            depthBufferBits = 0,
            msaaSamples = 1,
            mipCount = 1,
            useMipMap = false,
            autoGenerateMips = false,
            sRGB = false,
            graphicsFormat = GraphicsFormat.R8G8B8A8_UNorm
        };
        RenderingUtils.ReAllocateIfNeeded(ref exactTarget, exact, FilterMode.Point,
            TextureWrapMode.Clamp, name: "EID5618_Exact_R8G8B8A8_UNORM");

        RenderTextureDescriptor liveDesc = cameraDesc;
        liveDesc.width = targetWidth;
        liveDesc.height = targetHeight;
        liveDesc.depthBufferBits = 0;
        liveDesc.msaaSamples = 1;
        liveDesc.mipCount = 1;
        liveDesc.useMipMap = false;
        liveDesc.autoGenerateMips = false;
        liveDesc.sRGB = false;
        liveDesc.useDynamicScale = false;
        liveDesc.graphicsFormat = GraphicsFormat.R16G16B16A16_SFloat;
        RenderingUtils.ReAllocateIfNeeded(ref liveFullColor, liveDesc, FilterMode.Point,
            TextureWrapMode.Clamp, name: "EID5618_LiveOrGenerated_Res9");

        ConfigureTarget(cameraColor);
        ConfigureClear(ClearFlag.None, Color.clear);
    }

    public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
    {
        if (cameraColor == null || exactTarget == null || liveFullColor == null || material == null)
            return;

        EID5618InputProfile profile = settings.inputProfile;
        if (!EnsureConstantBuffers(profile, renderingData.cameraData.cameraTargetDescriptor.width,
            renderingData.cameraData.cameraTargetDescriptor.height))
            return;

        CommandBuffer cmd = CommandBufferPool.Get("EID5618 Exact RenderDoc Colour Pass");
        try
        {
            EID5618InputProfile.Res9SourceMode sourceMode = profile != null
                ? profile.res9Source
                : EID5618InputProfile.Res9SourceMode.CapturedEID5537;
            Texture res9Texture = null;

            if (sourceMode == EID5618InputProfile.Res9SourceMode.CapturedEID5537)
            {
                // Deterministic path: this is the captured output of EID5537,
                // not the already composited Unity camera colour.
                res9Texture = ResolveCapturedTexture(profile != null ? profile.res9Captured : null,
                    "Assets/EID5618_RenderDocPostProcess/CapturedInputs/UnityNative/res9.asset",
                    "Assets/EID5618_RenderDocPostProcess/CapturedInputs/res9.png");
            }
            else if (sourceMode == EID5618InputProfile.Res9SourceMode.GeneratedEID5537 && generatedRes9Material != null)
            {
                if (profile.eid5537Res14 == null) profile.eid5537Res14 = ResolveCapturedTexture(null,
                    "Assets/EID5618_RenderDocPostProcess/CapturedInputs/EID5537/res14.dds", null);
                if (profile.eid5537Res13 == null) profile.eid5537Res13 = ResolveCapturedTexture(null,
                    "Assets/EID5618_RenderDocPostProcess/CapturedInputs/EID5537/res13.dds", null);
                if (profile.eid5537Res17 == null) profile.eid5537Res17 = ResolveCapturedTexture(null,
                    "Assets/EID5618_RenderDocPostProcess/CapturedInputs/EID5537/res17.dds", null);
                if (profile.eid5537Res16 == null) profile.eid5537Res16 = ResolveCapturedTexture(null,
                    "Assets/EID5618_RenderDocPostProcess/CapturedInputs/EID5537/res16.dds", null);
                if (profile.eid5537Res15 == null) profile.eid5537Res15 = ResolveCapturedTexture(null,
                    "Assets/EID5618_RenderDocPostProcess/CapturedInputs/EID5537/res15.dds", null);
                if (profile.eid5537Res14 == null || profile.eid5537Res13 == null || profile.eid5537Res17 == null ||
                    profile.eid5537Res16 == null || profile.eid5537Res15 == null)
                {
                    Debug.LogError("[EID5618] GeneratedEID5537 requires res13/res14/res15/res16/res17.");
                    return;
                }

                generatedRes9Material.SetTexture(GeneratedRes14, profile.eid5537Res14);
                generatedRes9Material.SetTexture(GeneratedRes13, profile.eid5537Res13);
                generatedRes9Material.SetTexture(GeneratedRes17, profile.eid5537Res17);
                generatedRes9Material.SetTexture(GeneratedRes16, profile.eid5537Res16);
                generatedRes9Material.SetTexture(GeneratedRes15, profile.eid5537Res15);
                cmd.SetGlobalConstantBuffer(uniforms14B5, GeneratedB5, 0, B5Bytes);
                cmd.SetGlobalConstantBuffer(uniforms6B6, GeneratedB6, 0, B6Bytes);
                CoreUtils.SetRenderTarget(cmd, liveFullColor, ClearFlag.None, Color.clear);
                cmd.DrawProcedural(Matrix4x4.identity, generatedRes9Material, 0, MeshTopology.Triangles, 3, 1);
                res9Texture = liveFullColor.rt;
            }
            else if (sourceMode == EID5618InputProfile.Res9SourceMode.GeneratedEID5537)
            {
                // If the generated shader is unavailable, remain deterministic
                // instead of silently switching to the already composited camera.
                res9Texture = ResolveCapturedTexture(profile != null ? profile.res9Captured : null,
                    "Assets/EID5618_RenderDocPostProcess/CapturedInputs/UnityNative/res9.asset",
                    "Assets/EID5618_RenderDocPostProcess/CapturedInputs/res9.png");
            }
            else if (copyMaterial != null)
            {
                // Explicit live diagnostic fallback only.

                if (cameraColor.rt == null || liveFullColor.rt == null)
                    return;
                copyMaterial.SetTexture(CopySource, cameraColor.rt);
                copyMaterial.SetFloat(LiveCameraFlipY, profile != null && profile.flipLiveCameraY ? 1.0f : 0.0f);
                CoreUtils.SetRenderTarget(cmd, liveFullColor, ClearFlag.None, Color.clear);
                // Do not inherit a viewport left by an earlier URP pass.
                // CopyColor is a 1:1 full-resolution input copy.
                cmd.SetViewport(new Rect(0f, 0f, targetWidth, targetHeight));
                cmd.DrawProcedural(Matrix4x4.identity, copyMaterial, 0, MeshTopology.Triangles, 3, 1);
                res9Texture = liveFullColor.rt;
            }

            if (res9Texture == null)
            {
                Debug.LogError("[EID5618] No res9 source is available.");
                return;
            }

            Texture lut = ResolveCapturedTexture(profile != null ? profile.res11Captured : null,
                "Assets/EID5618_RenderDocPostProcess/CapturedInputs/UnityNative/res11.asset",
                "Assets/EID5618_RenderDocPostProcess/CapturedInputs/res11.png");
            if (lut == null)
            {
                if (!warnedMissing)
                {
                    Debug.LogError("[EID5618] RenderDoc res11 LUT is not imported/bound. Check res11.dds in EID5618_InputProfile.");
                    warnedMissing = true;
                }
                return;
            }
            // Bind exactly the three RenderDoc PS image roles. Only res9 is live.
            Texture res10 = ResolveCapturedTexture(profile != null ? profile.res10 : null,
                "Assets/EID5618_RenderDocPostProcess/CapturedInputs/UnityNative/res10.asset",
                "Assets/EID5618_RenderDocPostProcess/CapturedInputs/res10.png");
            if (res10 == null && !warnedMissing)
            {
                Debug.LogError("[EID5618] RenderDoc res10 is not imported/bound. Check res10_rgba16f.dds in EID5618_InputProfile.");
                warnedMissing = true;
            }
            if (res10 == null) return;

            material.SetTexture(Res9, res9Texture);
            material.SetTexture(Res10, res10);
            material.SetTexture(Res11, lut);
            material.SetFloat(DebugMode, (float)settings.debugOutput);
            material.SetFloat(DebugScale, Mathf.Max(0.0001f, settings.debugScale));
            material.SetFloat(Res10LerpValue, (float)settings.res10LerpValue);
            material.SetFloat(Res10LerpWeight, Mathf.Clamp01(settings.res10LerpWeight));
            material.SetFloat(Res10Threshold, Mathf.Clamp01(settings.res10Threshold));

            if (!loggedBindings)
            {
                loggedBindings = true;
                Debug.Log($"[EID5618] Exact pass bindings: source={sourceMode}, res9={DescribeTexture(res9Texture)} materialRes9={DescribeTexture(material.GetTexture(Res9))}, res10={DescribeTexture(res10)} materialRes10={DescribeTexture(material.GetTexture(Res10))}, res11={DescribeTexture(lut)} materialRes11={DescribeTexture(material.GetTexture(Res11))}, debug={settings.debugOutput}, cameraTarget={DescribeTarget(cameraColor)}");
            }

            material.SetFloat(LinearDisplay, 1.0f);

            // Reference-compatible two-pass output: the migrated RenderDoc FS
            // writes its encoded result into a point-sampled UNORM intermediate;
            // a separate display pass performs the single sRGB EOTF into the
            // Unity camera target.
            cmd.SetGlobalConstantBuffer(uniforms7VS, Uniforms7, 0, B7Bytes);
            cmd.SetGlobalConstantBuffer(uniforms14B5, B5, 0, B5Bytes);
            cmd.SetGlobalConstantBuffer(uniforms6B6, B6, 0, B6Bytes);

            CoreUtils.SetRenderTarget(cmd, exactTarget, ClearFlag.Color, Color.clear);
            cmd.SetViewport(new Rect(0f, 0f, targetWidth, targetHeight));
            cmd.BeginSample("EID5618 Exact RenderDoc FS");
            cmd.DrawProcedural(Matrix4x4.identity, material, 0, MeshTopology.Triangles, 3, 1);
            cmd.EndSample("EID5618 Exact RenderDoc FS");

            material.SetTexture(ExactRT, exactTarget.rt);
            CoreUtils.SetRenderTarget(cmd, cameraColor, ClearFlag.Color, Color.clear);
            int cameraWidth = cameraColor.rt != null ? cameraColor.rt.width : renderingData.cameraData.cameraTargetDescriptor.width;
            int cameraHeight = cameraColor.rt != null ? cameraColor.rt.height : renderingData.cameraData.cameraTargetDescriptor.height;
            cmd.SetViewport(new Rect(0f, 0f, Mathf.Max(1, cameraWidth), Mathf.Max(1, cameraHeight)));
            cmd.BeginSample("EID5618 Display Decode");
            cmd.DrawProcedural(Matrix4x4.identity, material, 1, MeshTopology.Triangles, 3, 1);
            cmd.EndSample("EID5618 Display Decode");
            context.ExecuteCommandBuffer(cmd);
        }
        finally
        {
            CommandBufferPool.Release(cmd);
        }
    }

    static string DescribeTexture(Texture texture)
    {
        if (texture == null) return "<null>";
        return $"{texture.name}({texture.width}x{texture.height}, {texture.graphicsFormat})";
    }

    static string DescribeTarget(RTHandle target)
    {
        if (target == null || target.rt == null) return "<null>";
        return $"{target.rt.name}({target.rt.width}x{target.rt.height}, {target.rt.graphicsFormat}, sRGB={GraphicsFormatUtility.IsSRGBFormat(target.rt.graphicsFormat)})";
    }

    static Texture ResolveCapturedTexture(Texture assigned, string exactPath, string fallbackPath)
    {
        if (assigned != null) return assigned;
#if UNITY_EDITOR
        Texture exact = AssetDatabase.LoadAssetAtPath<Texture>(exactPath);
        if (exact != null) return exact;
        return AssetDatabase.LoadAssetAtPath<Texture>(fallbackPath);
#else
        return null;
#endif
    }

    bool EnsureConstantBuffers(EID5618InputProfile profile, int width, int height)
    {
        if (profile == null || profile.uniforms14B5 == null || profile.uniforms6B6 == null)
        {
            if (!warnedMissing)
            {
                Debug.LogError("[EID5618] Assign uniforms14B5 and uniforms6B6 in EID5618_InputProfile.");
                warnedMissing = true;
            }
            return false;
        }

        if (b7Bytes == null || b5Bytes == null || b6Bytes == null)
        {
            b7Bytes = new byte[B7Bytes];
            b5Bytes = (byte[])profile.uniforms14B5.bytes.Clone();
            b6Bytes = (byte[])profile.uniforms6B6.bytes.Clone();
            if (b5Bytes.Length != B5Bytes || b6Bytes.Length != B6Bytes)
            {
                Debug.LogError($"[EID5618] Constant-buffer sizes are wrong: b5={b5Bytes.Length}, b6={b6Bytes.Length}; expected {B5Bytes}/{B6Bytes}.");
                return false;
            }
            uniforms7VS = new ComputeBuffer(B7Bytes / 16, 16, ComputeBufferType.Constant);
            uniforms14B5 = new ComputeBuffer(B5Bytes / 16, 16, ComputeBufferType.Constant);
            uniforms6B6 = new ComputeBuffer(B6Bytes / 16, 16, ComputeBufferType.Constant);
        }

        if (profile.updateCapturedScreenSize)
        {
            WriteFloat(b6Bytes, 0, width);
            WriteFloat(b6Bytes, 4, height);
            WriteFloat(b6Bytes, 8, width > 0 ? 1f / width : 0f);
            WriteFloat(b6Bytes, 12, height > 0 ? 1f / height : 0f);
            Buffer.BlockCopy(b6Bytes, 0, b6Bytes, 16, 16);
            WriteFloat(b6Bytes, 80, 1f + (width > 0 ? 1f / width : 0f));
            WriteFloat(b6Bytes, 84, 1f + (height > 0 ? 1f / height : 0f));
        }

        uniforms7VS.SetData(ToUInt4Array(b7Bytes));
        uniforms14B5.SetData(ToUInt4Array(b5Bytes));
        uniforms6B6.SetData(ToUInt4Array(b6Bytes));
        return true;
    }

    static void WriteFloat(byte[] bytes, int offset, float value)
    {
        byte[] valueBytes = BitConverter.GetBytes(value);
        Buffer.BlockCopy(valueBytes, 0, bytes, offset, 4);
    }

    struct UInt4
    {
        public uint x, y, z, w;
    }

    static UInt4[] ToUInt4Array(byte[] bytes)
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

    public void Dispose()
    {
        liveFullColor?.Release();
        exactTarget?.Release();
        liveFullColor = null;
        exactTarget = null;
        uniforms7VS?.Release();
        uniforms14B5?.Release();
        uniforms6B6?.Release();
        uniforms7VS = null;
        uniforms14B5 = null;
        uniforms6B6 = null;
    }
}












