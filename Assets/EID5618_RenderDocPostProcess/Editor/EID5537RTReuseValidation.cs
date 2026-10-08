#if UNITY_EDITOR
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

[InitializeOnLoad]
public static class EID5537RTReuseValidation
{
    const string Folder = ".rdctools/taa_rt_1007";
    const string RendererPath = "Assets/EID3332_EID3336_Combined/Settings/EID3332Combined-Renderer.asset";
    const string ProfilePath = "Assets/EID5618_RenderDocPostProcess/Materials/EID5618_InputProfile.asset";
    static readonly BindingFlags Fields = BindingFlags.Instance | BindingFlags.NonPublic | BindingFlags.Public;
    static readonly StringBuilder report = new StringBuilder();
    static ScriptableRendererFeature[] features;
    static EID5537FixedFrameRendererFeature taa;
    static int samples, baselineAllocations, resolves;
    static string baselineTextures;
    static bool running, passed;
    static bool orientationQueued;
    static double deadline, nextRepaint;

    static EID5537RTReuseValidation() { EditorApplication.update += Tick; }

    [MenuItem("EID5537/Validate live RT reuse")]
    public static void Run()
    {
        if (running) return;
        Directory.CreateDirectory(Folder);
        AssetDatabase.ImportAsset(ProfilePath, ImportAssetOptions.ForceUpdate);
        AssetDatabase.ImportAsset(RendererPath, ImportAssetOptions.ForceUpdate);
        var renderer = AssetDatabase.LoadAssetAtPath<UniversalRendererData>(RendererPath);
        features = renderer.rendererFeatures.Where(f => f is EID5537FixedFrameRendererFeature ||
            f is EID5618ComputePass3Feature || f is EID5618PostProcessRendererFeature).ToArray();
        taa = features.OfType<EID5537FixedFrameRendererFeature>().Single();
        report.Clear();
        report.AppendLine("Time=" + DateTime.Now.ToString("O"));
        report.AppendLine("API=" + SystemInfo.graphicsDeviceType);
        report.AppendLine("Scene=" + UnityEngine.SceneManagement.SceneManager.GetActiveScene().path);
        report.AppendLine("TAA active=" + taa.isActive + " cameraEnabled=" + taa.settings.enabledForCamera +
            " event=" + (int)taa.settings.injectionPoint + " flipY=" + taa.settings.flipLiveColorY);
        passed = taa.isActive && taa.settings.enabledForCamera;
        samples = 0;
        resolves = 0;
        baselineTextures = null;
        orientationQueued = false;
        taa.ResetColorHistory();
        running = true;
        deadline = EditorApplication.timeSinceStartup + 120;
        nextRepaint = 0;
        RenderPipelineManager.endCameraRendering += Sample;
        Application.logMessageReceived += OnLog;
        EID5618PostProcessRendererFeature.CaptureInputsForDiagnostics += CaptureOrientation;
    }

    static void CaptureOrientation(CommandBuffer cmd, Texture res9, Texture res10)
    {
        if (!running || orientationQueued || res9 != EID5537FixedFrameRendererFeature.CurrentOutput) return;
        var material = Read(taa, "material") as Material;
        if (material == null || material.GetFloat("_EID5537BootstrapHistory") < 0.5f) return;
        var sourceHandle = Read(Read(taa, "pass"), "cameraColor") as RTHandle;
        var source = sourceHandle?.rt;
        if (source == null) return;
        orientationQueued = true;
        int sourceWidth = source.width, width = res9.width, height = res9.height;
        Vector2Int viewport = sourceHandle.useScaling
            ? sourceHandle.GetScaledSize(sourceHandle.rtHandleProperties.currentViewportSize)
            : new Vector2Int(source.width, source.height);
        Color[] before = null, after = null;
        bool readbackFailed = false;
        Action compare = () =>
        {
            if (before == null || after == null) return;
            double direct = 0, flipped = 0;
            for (int y = 0; y < height; y++)
            for (int x = 0; x < width; x++)
            {
                int sx = Mathf.Min((int)((x + 0.5f) * viewport.x / width), viewport.x - 1);
                int sy = Mathf.Min((int)((y + 0.5f) * viewport.y / height), viewport.y - 1);
                Color a = after[y * width + x];
                direct += RgbDifference(a, before[sy * sourceWidth + sx]);
                flipped += RgbDifference(a, before[(viewport.y - 1 - sy) * sourceWidth + sx]);
            }
            direct /= width * height * 3.0;
            flipped /= width * height * 3.0;
            bool sameRows = !double.IsNaN(direct) && !double.IsInfinity(direct) &&
                flipped > 1e-5 && direct <= Math.Max(1e-6, flipped * 0.05);
            File.WriteAllText(Folder + "/orientation_validation.txt",
                "Bootstrap current HDR vs TAA before EID5618 overwrites camera color\n" +
                "Source=" + sourceWidth + "x" + source.height + " viewport=" + viewport +
                " output=" + width + "x" + height + "\nDirectRGB_MAE=" + direct.ToString("G9") +
                "\nFlippedRGB_MAE=" + flipped.ToString("G9") + "\nRESULT=" + (sameRows ? "PASS" : "FAIL"));
        };
        // Record both reads before the final color pass overwrites cameraColor.
        // This adds CPU staging reads only, not persistent full-size GPU RTs.
        cmd.RequestAsyncReadback(source, 0, TextureFormat.RGBAFloat, request =>
        {
            if (request.hasError)
            {
                readbackFailed = true;
                File.WriteAllText(Folder + "/orientation_validation.txt", "FAIL source readback");
                return;
            }
            before = request.GetData<Color>().ToArray();
            if (!readbackFailed) compare();
        });
        cmd.RequestAsyncReadback(res9, 0, TextureFormat.RGBAFloat, request =>
        {
            if (request.hasError)
            {
                readbackFailed = true;
                File.WriteAllText(Folder + "/orientation_validation.txt", "FAIL TAA readback");
                return;
            }
            after = request.GetData<Color>().ToArray();
            if (!readbackFailed) compare();
        });
    }

    static double RgbDifference(Color a, Color b) =>
        Math.Abs((double)a.r - b.r) + Math.Abs((double)a.g - b.g) + Math.Abs((double)a.b - b.b);

    static void Tick()
    {
        if (EditorApplication.isCompiling || EditorApplication.isUpdating) return;
        if (!running && File.Exists(Folder + "/run.request"))
        {
            File.Move(Folder + "/run.request", Folder + "/run_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".request.done");
            try { Run(); }
            catch (Exception e) { File.WriteAllText(Folder + "/live_validation.txt", "FAIL\n" + e); }
        }
        if (!running) return;
        if (samples >= 12 || EditorApplication.timeSinceStartup > deadline)
        {
            Finish();
            return;
        }
        if (EditorApplication.timeSinceStartup < nextRepaint) return;
        nextRepaint = EditorApplication.timeSinceStartup + 0.15;
        foreach (var window in Resources.FindObjectsOfTypeAll<EditorWindow>())
            if (window.GetType().Name == "GameView") window.Repaint();
        EditorApplication.QueuePlayerLoopUpdate();
    }

    static void OnLog(string message, string stack, LogType type)
    {
        if (type != LogType.Error && type != LogType.Exception && type != LogType.Assert) return;
        report.AppendLine(type + ": " + message);
        passed = false;
    }

    static void Sample(ScriptableRenderContext context, Camera camera)
    {
        if (!running || camera.cameraType != CameraType.Game || camera.name != taa.settings.cameraNameContains) return;
        samples++;
        var output = EID5537FixedFrameRendererFeature.GetCurrentOutput(camera);
        var material = Read(taa, "material") as Material;
        bool bootstrap = material == null || material.GetFloat("_EID5537BootstrapHistory") > 0.5f;
        if (!bootstrap && output != null) resolves++;
        report.AppendLine("Sample=" + samples + " allocations=" + taa.RenderTextureAllocationCount +
            " bootstrap=" + bootstrap + " time=" + Time.realtimeSinceStartupAsDouble.ToString("F3") +
            " output=" + (output == null ? "null" : output.GetInstanceID() + " " + output.width + "x" + output.height));
        if (output == null) passed = false;
        if (samples == 2)
        {
            baselineAllocations = taa.RenderTextureAllocationCount;
            baselineTextures = TextureIds();
            report.AppendLine("Baseline RT ids=" + baselineTextures);
            foreach (var feature in features)
            {
                object before = Read(feature, "pass");
                for (int i = 0; i < 5; i++) feature.Create();
                bool same = ReferenceEquals(before, Read(feature, "pass"));
                report.AppendLine(feature.GetType().Name + " Create x5 retained pass=" + same);
                passed &= same;
            }
            passed &= baselineTextures == TextureIds();
        }
        if (samples > 2)
        {
            bool stable = baselineAllocations == taa.RenderTextureAllocationCount && baselineTextures == TextureIds();
            report.AppendLine("RT set stable=" + stable);
            passed &= stable;
        }
        if (samples == 12 && output != null)
            AsyncGPUReadback.Request(output, 0, TextureFormat.RGBAFloat, SaveReadback);
    }

    static object Read(object owner, string field) => owner?.GetType().GetField(field, Fields)?.GetValue(owner);

    static string TextureIds()
    {
        var ids = new SortedSet<int>();
        foreach (var feature in features)
        {
            object pass = Read(feature, "pass");
            if (pass == null) continue;
            foreach (var field in pass.GetType().GetFields(Fields))
            {
                object value = field.GetValue(pass);
                if (value is RTHandle handle && field.Name != "cameraColor" && field.Name != "cameraDepth") Add(handle, ids);
                if (value is RTHandle[] handles) foreach (var item in handles) Add(item, ids);
                if (field.Name == "colorHistory" && value != null)
                    foreach (string property in new[] { "CurrentColor", "Read", "CurrentDepth" })
                        Add(value.GetType().GetProperty(property).GetValue(value) as RTHandle, ids);
            }
        }
        return string.Join(",", ids);
    }

    static void Add(RTHandle handle, SortedSet<int> ids)
    {
        if (handle?.rt != null && handle.rt.IsCreated()) ids.Add(handle.rt.GetInstanceID());
    }

    static void SaveReadback(AsyncGPUReadbackRequest request)
    {
        if (request.hasError) { File.WriteAllText(Folder + "/pixel_validation.txt", "FAIL GPU readback"); return; }
        var colors = request.GetData<Color>();
        long nonfinite = 0, nonzero = 0;
        foreach (Color c in colors)
        {
            if (float.IsNaN(c.r) || float.IsNaN(c.g) || float.IsNaN(c.b) || float.IsNaN(c.a) ||
                float.IsInfinity(c.r) || float.IsInfinity(c.g) || float.IsInfinity(c.b) || float.IsInfinity(c.a)) nonfinite++;
            if (c.r != 0 || c.g != 0 || c.b != 0) nonzero++;
        }
        File.WriteAllText(Folder + "/pixel_validation.txt", "Pixels=" + colors.Length + " nonfinite=" + nonfinite +
            " nonzeroRGB=" + nonzero + " result=" + (nonfinite == 0 && nonzero > 0 ? "PASS" : "FAIL"));
        var cpu = new Texture2D(EID5537FixedFrameRendererFeature.Width, EID5537FixedFrameRendererFeature.Height,
            TextureFormat.RGBAFloat, false, true);
        try { cpu.LoadRawTextureData(request.GetData<byte>()); cpu.Apply(); File.WriteAllBytes(Folder + "/taa_output.png", cpu.EncodeToPNG()); }
        finally { UnityEngine.Object.DestroyImmediate(cpu); }
    }

    static void Finish()
    {
        RenderPipelineManager.endCameraRendering -= Sample;
        Application.logMessageReceived -= OnLog;
        EID5618PostProcessRendererFeature.CaptureInputsForDiagnostics -= CaptureOrientation;
        running = false;
        passed &= samples >= 12 && resolves > 0;
        report.AppendLine("History resolves=" + resolves);
        report.AppendLine("Orientation readback queued=" + orientationQueued + "; see orientation_validation.txt");
        report.AppendLine("RESULT=" + (passed ? "PASS" : "FAIL") + " samples=" + samples);
        File.WriteAllText(Folder + "/live_validation.txt", report.ToString());
        Debug.Log("[EID5537 RT reuse] " + (passed ? "PASS" : "FAIL") + " " + Folder + "/live_validation.txt");
    }
}
#endif
