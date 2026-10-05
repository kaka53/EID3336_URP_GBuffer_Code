#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public static class EID5537FixedFrameValidation
{
    const string Analysis = ".rdctools/eid5537_analysis/";

    [MenuItem("EID5537/Validate fixed frame against RID210447")]
    public static void Run()
    {
        try
        {
            EID5537FixedFrameSetup.Install();
            string deviceAndFormat;
            byte[] actual = RenderIsolated(0, out deviceAndFormat);
            byte[] reference = File.ReadAllBytes(Analysis + "eid5537_rid210447_rgba16f.raw");
            if (actual.Length != reference.Length) throw new InvalidOperationException(
                $"RGBAHalf byte count mismatch: Unity={actual.Length}, RenderDoc={reference.Length}");
            Directory.CreateDirectory(Analysis);
            File.WriteAllBytes(Analysis + "unity_eid5537_rgba16f.raw", actual);
            bool matches;
            string direct = Evaluate(actual, reference, false, out matches);
            bool flippedMatches;
            string flipped = Evaluate(actual, reference, true, out flippedMatches);
            string report = "EID5537 fixed-frame RenderFeature vs RID210447\n" +
                $"Unity: {Application.unityVersion}, {deviceAndFormat}\n" +
                $"Reference and readback: {reference.Length} bytes, 1366x768 RGBAHalf\n" +
                $"Result: {(matches ? "PASS within tolerance (not bit-exact)" : "FAIL")}\n" +
                direct + flipped;
            File.WriteAllText(Analysis + "fixed_frame_validation.txt", report);
            if (matches) Debug.Log(report);
            else Debug.LogError(report);
            if (Application.isBatchMode) EditorApplication.Exit(matches ? 0 : 2);
        }
        catch (Exception e)
        {
            Directory.CreateDirectory(Analysis);
            File.WriteAllText(Analysis + "fixed_frame_validation.txt", "VALIDATION FAILED\n" + e);
            Debug.LogException(e);
            if (Application.isBatchMode) EditorApplication.Exit(1);
        }
    }

    [MenuItem("EID5537/Probe fixed-frame shader inputs")]
    public static void ProbeInputs()
    {
        try
        {
            EID5537FixedFrameSetup.Install();
            Directory.CreateDirectory(Analysis);
            for (int probe = 1; probe <= 5; probe++)
            {
                string format;
                File.WriteAllBytes(Analysis + "probe_" + probe + ".raw", RenderIsolated(probe, out format));
            }
            Debug.Log("[EID5537] Five shader input probes saved in " + Analysis);
            if (Application.isBatchMode) EditorApplication.Exit(0);
        }
        catch (Exception e)
        {
            Debug.LogException(e);
            if (Application.isBatchMode) EditorApplication.Exit(1);
        }
    }

    static byte[] RenderIsolated(int probe, out string deviceAndFormat)
    {
        var rendererAsset = AssetDatabase.LoadAssetAtPath<UniversalRendererData>(
            "Assets/EID3332_EID3336_Combined/Settings/EID3332Combined-Renderer.asset");
        EID5537FixedFrameRendererFeature feature = null;
        foreach (var entry in rendererAsset.rendererFeatures)
            if (entry is EID5537FixedFrameRendererFeature found) { feature = found; break; }
        if (feature == null) throw new InvalidOperationException("EID5537 feature not installed.");
        int previousProbe = feature.settings.probeInput;
        feature.settings.probeInput = probe;
        var pipelineAsset = AssetDatabase.LoadAssetAtPath<UniversalRenderPipelineAsset>(
            "Assets/EID3332_EID3336_Combined/Settings/EID3332Combined-URP.asset");
        if (pipelineAsset == null) throw new InvalidOperationException("Combined URP pipeline not found.");

        var previousGraphics = GraphicsSettings.defaultRenderPipeline;
        var previousQuality = QualitySettings.renderPipeline;
        GameObject cameraObject = null;
        RenderTexture cameraTarget = null;
        try
        {
            EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Single);
            GraphicsSettings.defaultRenderPipeline = pipelineAsset;
            QualitySettings.renderPipeline = pipelineAsset;
            cameraObject = new GameObject("EID5537 Fixed Frame Validation Camera");
            var camera = cameraObject.AddComponent<Camera>();
            camera.clearFlags = CameraClearFlags.SolidColor;
            cameraTarget = new RenderTexture(EID5537FixedFrameRendererFeature.Width,
                EID5537FixedFrameRendererFeature.Height, 0, RenderTextureFormat.ARGBHalf);
            camera.targetTexture = cameraTarget;
            camera.Render();
            var target = EID5537FixedFrameRendererFeature.CurrentOutput;
            if (target == null || target.width != EID5537FixedFrameRendererFeature.Width ||
                target.height != EID5537FixedFrameRendererFeature.Height)
                throw new InvalidOperationException("EID5537 RenderFeature did not produce the 1366x768 RT.");
            deviceAndFormat = $"API: {SystemInfo.graphicsDeviceType}, RT: {target.graphicsFormat}";
            var request = AsyncGPUReadback.Request(target, 0, TextureFormat.RGBAHalf);
            request.WaitForCompletion();
            if (request.hasError) throw new InvalidOperationException("RGBAHalf GPU readback failed.");
            return request.GetData<byte>().ToArray();
        }
        finally
        {
            feature.settings.probeInput = previousProbe;
            GraphicsSettings.defaultRenderPipeline = previousGraphics;
            QualitySettings.renderPipeline = previousQuality;
            if (cameraObject != null) UnityEngine.Object.DestroyImmediate(cameraObject);
            if (cameraTarget != null) UnityEngine.Object.DestroyImmediate(cameraTarget);
        }
    }

    static string Evaluate(byte[] actual, byte[] reference, bool flipY, out bool matches)
    {
        const int width = EID5537FixedFrameRendererFeature.Width;
        const int height = EID5537FixedFrameRendererFeature.Height;
        long exact = 0, over1e3 = 0, finite = 0, nonFinite = 0;
        double absolute = 0, squared = 0, max = 0;
        for (int y = 0; y < height; y++)
        for (int x = 0; x < width * 4; x++)
        {
            int a = (y * width * 4 + x) * 2;
            int r = ((flipY ? height - 1 - y : y) * width * 4 + x) * 2;
            ushort av = BitConverter.ToUInt16(actual, a), rv = BitConverter.ToUInt16(reference, r);
            if (av == rv) exact++;
            float af = HalfToFloat(av), rf = HalfToFloat(rv);
            if (float.IsNaN(af) || float.IsInfinity(af) || float.IsNaN(rf) || float.IsInfinity(rf))
            {
                nonFinite++;
                continue;
            }
            double delta = Math.Abs(af - rf);
            absolute += delta;
            squared += delta * delta;
            max = Math.Max(max, delta);
            if (delta > 1e-3) over1e3++;
            finite++;
        }
        long total = (long)width * height * 4;
        matches = exact >= total * 0.995 && over1e3 <= total * 0.001 &&
            absolute / Math.Max(1, finite) < 1e-4;
        var sb = new StringBuilder();
        sb.AppendLine(flipY ? "Y-flipped comparison:" : "Direct comparison:");
        sb.AppendLine($"  exact half components: {exact}/{total}; nonfinite pairs: {nonFinite}");
        sb.AppendLine($"  MAE: {absolute / Math.Max(1, finite):G9}; RMSE: {Math.Sqrt(squared / Math.Max(1, finite)):G9}; max: {max:G9}");
        sb.AppendLine($"  components > 0.001: {over1e3}/{total} ({100.0 * over1e3 / total:F4}%)");
        return sb.ToString();
    }

    static float HalfToFloat(ushort half)
    {
        uint sign = (uint)(half & 0x8000) << 16;
        uint exponent = (uint)(half >> 10) & 31;
        uint mantissa = (uint)half & 1023;
        uint bits;
        if (exponent == 0)
        {
            if (mantissa == 0) bits = sign;
            else
            {
                int e = -14;
                while ((mantissa & 1024) == 0) { mantissa <<= 1; e--; }
                bits = sign | (uint)(e + 127) << 23 | (mantissa & 1023) << 13;
            }
        }
        else bits = sign | (exponent == 31 ? 255u : exponent + 112) << 23 | mantissa << 13;
        return BitConverter.ToSingle(BitConverter.GetBytes(bits), 0);
    }
}
#endif
