using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

/// <summary>
/// Independent RenderFeature for the EID4662 Compute Pass #2 chain.
/// Required inputs are explicit RenderDoc exports. The feature never substitutes
/// camera color, global textures, or neutral black/white textures.
/// </summary>
public sealed class EID4662ComputePass2RenderFeature : ScriptableRendererFeature
{
    [Serializable]
    public sealed class Settings
    {
        [Tooltip("Disable the feature without removing it from Renderer Data.")]
        public bool enabled = true;
        [Tooltip("All required texture/buffer fields must be exported from F:/endfield06.rdc and the same frame.")]
        public EID4662ComputePass2CapturedResources capturedResources;
        [Tooltip("Compute assets for EID4542,4546,4550,4554,4558,4562,4586,4590,4594. The six 4562..4582 dispatches share the iterate shader.")]
        public ComputeShader prepare4542;
        public ComputeShader prepare4546;
        public ComputeShader prepare4550;
        public ComputeShader seed4554;
        public ComputeShader seed4558;
        public ComputeShader iterate4562;
        public ComputeShader build4586;
        public ComputeShader build4590;
        public ComputeShader build4594;
        [Tooltip("Do not write the replay output into camera color. Outputs are published as globals and into the independent debug RT.")]
        public bool publishGlobalOutputs = true;
        [Tooltip("0=none, 1=Res18, 2=Res19, 3=Res33. The selected output is copied/upscaled into the independent debug RT.")]
        [Range(0, 3)] public int debugOutput;
        public bool runInSceneView = true;
        public bool runInGameView = true;
    }

    public Settings settings = new Settings();
    EID4662ComputePass2RenderPass pass;

    public override void Create()
    {
        pass = new EID4662ComputePass2RenderPass(settings)
        {
            renderPassEvent = RenderPassEvent.AfterRenderingGbuffer
        };
    }

    protected override void Dispose(bool disposing)
    {
        pass?.Dispose();
        pass = null;
    }

    public override void SetupRenderPasses(ScriptableRenderer renderer, in RenderingData renderingData)
    {
        if (pass != null) pass.SetTargets(renderer.cameraDepthTargetHandle);
    }

    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        if (pass == null || settings == null || !settings.enabled) return;
        Camera camera = renderingData.cameraData.camera;
        if (camera == null || camera.cameraType == CameraType.Preview || camera.cameraType == CameraType.Reflection) return;
        if (renderingData.cameraData.isSceneViewCamera ? !settings.runInSceneView : !settings.runInGameView) return;
        if (!pass.IsConfigured())
        {
            pass.LogConfigurationErrorOnce();
            return;
        }
        renderer.EnqueuePass(pass);
    }
}

internal sealed class EID4662ComputePass2RenderPass : ScriptableRenderPass
{
    readonly EID4662ComputePass2RenderFeature.Settings settings;
    readonly EID4662ComputePass2Resources resources = new EID4662ComputePass2Resources();
    RTHandle depthTarget;
    bool logged;
    bool loggedMissing;

    static readonly int InputColor = Shader.PropertyToID("_EID4662_InputColor");
    static readonly int InputHalfA = Shader.PropertyToID("_EID4662_InputHalfA");
    static readonly int InputHalfB = Shader.PropertyToID("_EID4662_InputHalfB");
    static readonly int InputPackedFull = Shader.PropertyToID("_EID4662_InputPackedFull");
    static readonly int InputPackedHalf = Shader.PropertyToID("_EID4662_InputPackedHalf");
    static readonly int InputDepth = Shader.PropertyToID("_EID4662_InputDepth");
    static readonly int InputStencil = Shader.PropertyToID("_EID4662_InputStencil");
    static readonly int Ssbo21 = Shader.PropertyToID("_EID4662_SSBO21");
    static readonly int Output = Shader.PropertyToID("_EID4662_Output");
    static readonly int OutputA = Shader.PropertyToID("_EID4662_OutputA");
    static readonly int OutputB = Shader.PropertyToID("_EID4662_OutputB");
    static readonly int OutputC = Shader.PropertyToID("_EID4662_OutputC");
    static readonly int SeedMask = Shader.PropertyToID("_EID4662_InputMask");
    static readonly int SeedInputA = Shader.PropertyToID("_EID4662_InputA");
    static readonly int SeedPacked = Shader.PropertyToID("_EID4662_InputPacked");
    static readonly int SeedRG = Shader.PropertyToID("_EID4662_InputRG");
    static readonly int SeedMip = Shader.PropertyToID("_EID4662_InputMip");
    static readonly int IterateA0 = Shader.PropertyToID("_EID4662_OutputA0");
    static readonly int IterateA1 = Shader.PropertyToID("_EID4662_OutputA1");
    static readonly int IterateB0 = Shader.PropertyToID("_EID4662_OutputB0");
    static readonly int IterateB1 = Shader.PropertyToID("_EID4662_OutputB1");
    static readonly int Field = Shader.PropertyToID("_EID4662_Field");
    static readonly int Iteration = Shader.PropertyToID("_EID4662_Iteration");
    static readonly int SourceSize = Shader.PropertyToID("_EID4662_SourceSize");
    static readonly int TargetSize = Shader.PropertyToID("_EID4662_TargetSize");
    static readonly int InvSourceSize = Shader.PropertyToID("_EID4662_InvSourceSize");
    static readonly int InvTargetSize = Shader.PropertyToID("_EID4662_InvTargetSize");
    static readonly int GlobalRes18 = Shader.PropertyToID("_EID4662_Res18");
    static readonly int GlobalRes19 = Shader.PropertyToID("_EID4662_Res19");
    static readonly int GlobalRes33 = Shader.PropertyToID("_EID4662_Res33");
    static readonly int GlobalDebugRT = Shader.PropertyToID("_EID4662_ComputePass2_DebugRT");
    static readonly int GlobalDebugOutput = Shader.PropertyToID("_EID4662_ComputePass2DebugOutput");

    public EID4662ComputePass2RenderPass(EID4662ComputePass2RenderFeature.Settings settings)
    {
        this.settings = settings;
        ConfigureInput(ScriptableRenderPassInput.None);
    }

    public void SetTargets(RTHandle depth)
    {
        depthTarget = depth;
    }

    public bool IsConfigured()
    {
        return settings != null && settings.capturedResources != null &&
               settings.capturedResources.IsCompleteForDispatchChain(out _) &&
               settings.prepare4542 != null && settings.prepare4546 != null && settings.prepare4550 != null &&
               settings.seed4554 != null && settings.seed4558 != null && settings.iterate4562 != null &&
               settings.build4586 != null && settings.build4590 != null && settings.build4594 != null;
    }

    public void LogConfigurationErrorOnce()
    {
        if (loggedMissing || settings == null) return;
        loggedMissing = true;
        if (settings.capturedResources == null)
        {
            Debug.LogError("[EID4662 ComputePass2] 未配置 RenderDoc 资源清单；不会使用 Camera Color 或黑色占位资源。");
            return;
        }
        if (!settings.capturedResources.IsCompleteForDispatchChain(out string missing))
            Debug.LogError("[EID4662 ComputePass2] RenderDoc 资源不完整，Feature 已停止：" + missing);
    }

    public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
    {
        if (settings?.capturedResources?.resource209495 == null) return;
        Texture source = settings.capturedResources.resource209495;
        resources.Ensure(source.width, source.height);
        resources.EnsureCapturedBuffers(settings.capturedResources);
    }

    public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
    {
        if (!IsConfigured()) return;
        var captured = settings.capturedResources;
        Texture inputColor = captured.resource209495;
        Texture inputHalfA = captured.resource210490;
        Texture inputHalfB = captured.resource209118;
        Texture inputPackedFull = captured.resource210525;
        Texture inputPackedHalf = captured.resource210516;
        if (inputColor == null || inputHalfA == null || inputHalfB == null || inputPackedFull == null || inputPackedHalf == null)
            return;

        resources.Ensure(inputColor.width, inputColor.height);
        if (!resources.EnsureCapturedBuffers(captured))
        {
            Debug.LogError("[EID4662 ComputePass2] indirect args/ssbo21 GPU buffer 创建失败；本帧不执行。");
            return;
        }

        CommandBuffer cmd = CommandBufferPool.Get("EID4662 Compute Pass #2 (RenderDoc resources)");
        try
        {
            int fw = resources.FullWidth, fh = resources.FullHeight;
            int hw = resources.HalfWidth, hh = resources.HalfHeight;

            Clear(cmd, resources.halfA); Clear(cmd, resources.halfB); Clear(cmd, resources.halfC);
            Clear(cmd, resources.pingA); Clear(cmd, resources.pingB);
            Clear(cmd, resources.res18); Clear(cmd, resources.res19); Clear(cmd, resources.res33);
            Clear(cmd, resources.debugPreview);

            DispatchPrepareIndirect(cmd, settings.prepare4542, resources.dispatchArgs4542, inputColor, inputHalfA, inputHalfB, inputPackedFull, inputPackedHalf, resources.halfA, resources.halfB, resources.halfC, fw, fh, hw, hh);
            DispatchPrepareIndirect(cmd, settings.prepare4546, resources.dispatchArgs4546, inputColor, inputHalfA, inputHalfB, inputPackedFull, inputPackedHalf, resources.halfA, resources.halfB, resources.halfC, hw, hh, hw, hh);
            DispatchPrepareIndirect(cmd, settings.prepare4550, resources.dispatchArgs4550, inputColor, inputHalfA, inputHalfB, inputPackedFull, inputPackedHalf, resources.halfA, resources.halfB, resources.halfC, hw, hh, hw, hh);

            DispatchSeedA(cmd, settings.seed4554, resources.halfC, inputPackedFull, resources.halfB, captured.resource210942, resources.pingB, hw, hh, 86, 48);
            DispatchSeedB(cmd, settings.seed4558, inputPackedFull, resources.halfA, resources.halfB, captured.resource210925, resources.pingA, hw, hh, 86, 48);

            int[] groupX = { 43, 22, 11, 6, 3, 2 };
            int[] groupY = { 24, 12, 6, 3, 2, 1 };
            for (int i = 0; i < groupX.Length; ++i)
            {
                DispatchIterate(cmd, settings.iterate4562, captured.resource209118, i, hw, hh, groupX[i], groupY[i], i);
            }

            DispatchBuild18(cmd, settings.build4586, captured.resource209118, resources.halfB, resources.pingA, resources.res18, fw, fh, hw, hh);
            DispatchBuild19(cmd, settings.build4590, resources.pingB, resources.halfB, resources.res19, hw, hh);
            DispatchBuild33(cmd, settings.build4594, resources.res18, resources.res19, captured.resource209543Depth, captured.resource209547Stencil, resources.res33, fw, fh, hw, hh);

            if (settings.publishGlobalOutputs)
            {
                cmd.SetGlobalTexture(GlobalRes18, resources.res18);
                cmd.SetGlobalTexture(GlobalRes19, resources.res19);
                cmd.SetGlobalTexture(GlobalRes33, resources.res33);
            }

            if (settings.debugOutput == 1) cmd.Blit(resources.res18, resources.debugPreview);
            else if (settings.debugOutput == 2) cmd.Blit(resources.res19, resources.debugPreview);
            else if (settings.debugOutput == 3) cmd.Blit(resources.res33, resources.debugPreview);
            cmd.SetGlobalTexture(GlobalDebugRT, resources.debugPreview);
            cmd.SetGlobalInt(GlobalDebugOutput, settings.debugOutput);
            context.ExecuteCommandBuffer(cmd);

            if (!logged)
            {
                logged = true;
                Debug.Log($"[EID4662 ComputePass2] RenderDoc resources active; camera={renderingData.cameraData.camera.name} events=4542,4546,4550,4554,4558,4562,4566,4570,4574,4578,4582,4586,4590,4594 capture={captured.sourceCapture} size={fw}x{fh}");
            }
        }
        finally
        {
            CommandBufferPool.Release(cmd);
        }
    }

    static void Clear(CommandBuffer cmd, RenderTexture target)
    {
        cmd.SetRenderTarget(target);
        cmd.ClearRenderTarget(false, true, Color.clear);
    }

    void SetSizes(CommandBuffer cmd, ComputeShader cs, int sw, int sh, int tw, int th, int iteration = 0)
    {
        cmd.SetComputeVectorParam(cs, SourceSize, new Vector4(sw, sh, 0, 0));
        cmd.SetComputeVectorParam(cs, TargetSize, new Vector4(tw, th, 0, 0));
        cmd.SetComputeVectorParam(cs, InvSourceSize, new Vector4(1f / Mathf.Max(1, sw), 1f / Mathf.Max(1, sh), 0, 0));
        cmd.SetComputeVectorParam(cs, InvTargetSize, new Vector4(1f / Mathf.Max(1, tw), 1f / Mathf.Max(1, th), 0, 0));
        cmd.SetComputeIntParam(cs, Iteration, iteration);
    }

    static int Kernel(ComputeShader cs) => cs.FindKernel("CSMain");

    void BindCommon(CommandBuffer cmd, ComputeShader cs, int kernel, Texture inputColor, Texture halfA, Texture halfB, Texture packedFull, Texture packedHalf, RenderTexture outputA, RenderTexture outputB, RenderTexture outputC, int sw, int sh, int tw, int th, int iteration = 0)
    {
        SetSizes(cmd, cs, sw, sh, tw, th, iteration);
        cmd.SetComputeTextureParam(cs, kernel, InputColor, inputColor);
        cmd.SetComputeTextureParam(cs, kernel, InputHalfA, halfA);
        cmd.SetComputeTextureParam(cs, kernel, InputHalfB, halfB);
        cmd.SetComputeTextureParam(cs, kernel, InputPackedFull, packedFull);
        cmd.SetComputeTextureParam(cs, kernel, InputPackedHalf, packedHalf);
        if (resources.ssbo21 != null) cmd.SetComputeBufferParam(cs, kernel, Ssbo21, resources.ssbo21);
        cmd.SetComputeTextureParam(cs, kernel, OutputA, outputA);
        cmd.SetComputeTextureParam(cs, kernel, OutputB, outputB);
        cmd.SetComputeTextureParam(cs, kernel, OutputC, outputC);
    }

    void DispatchPrepareIndirect(CommandBuffer cmd, ComputeShader cs, ComputeBuffer args, Texture inputColor, Texture halfA, Texture halfB, Texture packedFull, Texture packedHalf, RenderTexture outputA, RenderTexture outputB, RenderTexture outputC, int sw, int sh, int tw, int th)
    {
        int k = Kernel(cs);
        BindCommon(cmd, cs, k, inputColor, halfA, halfB, packedFull, packedHalf, outputA, outputB, outputC, sw, sh, tw, th);
        cmd.DispatchCompute(cs, k, args, 0);
    }

    void DispatchSeedA(CommandBuffer cmd, ComputeShader cs, Texture mask, Texture packed, Texture rg, Texture mip, RenderTexture output, int sw, int sh, int groupsX, int groupsY)
    {
        int k = Kernel(cs);
        cmd.SetComputeTextureParam(cs, k, SeedMask, mask);
        cmd.SetComputeTextureParam(cs, k, SeedPacked, packed);
        cmd.SetComputeTextureParam(cs, k, SeedRG, rg);
        cmd.SetComputeTextureParam(cs, k, SeedMip, mip);
        cmd.SetComputeTextureParam(cs, k, Output, output, 0);
        if (resources.ssbo21 != null) cmd.SetComputeBufferParam(cs, k, Ssbo21, resources.ssbo21);
        cmd.DispatchCompute(cs, k, groupsX, groupsY, 1);
    }

    void DispatchSeedB(CommandBuffer cmd, ComputeShader cs, Texture packed, Texture inputA, Texture rg, Texture mip, RenderTexture output, int sw, int sh, int groupsX, int groupsY)
    {
        int k = Kernel(cs);
        cmd.SetComputeTextureParam(cs, k, SeedPacked, packed);
        cmd.SetComputeTextureParam(cs, k, SeedInputA, inputA);
        cmd.SetComputeTextureParam(cs, k, SeedRG, rg);
        cmd.SetComputeTextureParam(cs, k, SeedMip, mip);
        cmd.SetComputeTextureParam(cs, k, Output, output, 0);
        if (resources.ssbo21 != null) cmd.SetComputeBufferParam(cs, k, Ssbo21, resources.ssbo21);
        cmd.DispatchCompute(cs, k, groupsX, groupsY, 1);
    }

    void DispatchIterate(CommandBuffer cmd, ComputeShader cs, Texture source, int mip, int sw, int sh, int groupsX, int groupsY, int iteration)
    {
        int k = Kernel(cs);
        SetSizes(cmd, cs, sw, sh, sw, sh, iteration);
        cmd.SetComputeTextureParam(cs, k, InputHalfB, source);
        cmd.SetComputeTextureParam(cs, k, IterateA0, resources.pingA, mip);
        cmd.SetComputeTextureParam(cs, k, IterateA1, resources.pingA, mip + 1);
        cmd.SetComputeTextureParam(cs, k, IterateB0, resources.pingB, mip);
        cmd.SetComputeTextureParam(cs, k, IterateB1, resources.pingB, mip + 1);
        if (resources.ssbo21 != null) cmd.SetComputeBufferParam(cs, k, Ssbo21, resources.ssbo21);
        cmd.DispatchCompute(cs, k, groupsX, groupsY, 1);
    }

    void DispatchBuild18(CommandBuffer cmd, ComputeShader cs, Texture halfDepth, Texture rg, Texture field, RenderTexture output, int fw, int fh, int hw, int hh)
    {
        int k = Kernel(cs);
        cmd.SetComputeTextureParam(cs, k, InputHalfB, halfDepth);
        cmd.SetComputeTextureParam(cs, k, SeedRG, rg);
        cmd.SetComputeTextureParam(cs, k, Field, field);
        if (resources.ssbo21 != null) cmd.SetComputeBufferParam(cs, k, Ssbo21, resources.ssbo21);
        cmd.SetComputeTextureParam(cs, k, Output, output);
        cmd.DispatchCompute(cs, k, (fw + 7) / 8, (fh + 7) / 8, 1);
    }

    void DispatchBuild19(CommandBuffer cmd, ComputeShader cs, Texture field, Texture rg, RenderTexture output, int w, int h)
    {
        int k = Kernel(cs);
        cmd.SetComputeTextureParam(cs, k, Field, field);
        cmd.SetComputeTextureParam(cs, k, SeedRG, rg);
        if (resources.ssbo21 != null) cmd.SetComputeBufferParam(cs, k, Ssbo21, resources.ssbo21);
        cmd.SetComputeTextureParam(cs, k, Output, output);
        cmd.DispatchCompute(cs, k, (w + 7) / 8, (h + 7) / 8, 1);
    }

    void DispatchBuild33(CommandBuffer cmd, ComputeShader cs, Texture res18, Texture res19, Texture depth, Texture stencil, RenderTexture output, int fw, int fh, int hw, int hh)
    {
        int k = Kernel(cs);
        SetSizes(cmd, cs, fw, fh, fw, fh);
        cmd.SetComputeTextureParam(cs, k, Field, res18);
        cmd.SetComputeTextureParam(cs, k, InputHalfA, res19);
        cmd.SetComputeTextureParam(cs, k, InputDepth, depth);
        cmd.SetComputeTextureParam(cs, k, InputStencil, stencil);
        if (resources.ssbo21 != null) cmd.SetComputeBufferParam(cs, k, Ssbo21, resources.ssbo21);
        cmd.SetComputeTextureParam(cs, k, Output, output);
        cmd.DispatchCompute(cs, k, 64, 23, 14);
    }

    public void Dispose() => resources.Dispose();
}



