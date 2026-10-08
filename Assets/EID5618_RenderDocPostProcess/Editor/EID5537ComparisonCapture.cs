#if UNITY_EDITOR
using System;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

[InitializeOnLoad]
public static class EID5537ComparisonCapture
{
    const string Folder = ".rdctools/taa_comparison_1007";
    const string RendererPath = "Assets/EID3332_EID3336_Combined/Settings/EID3332Combined-Renderer.asset";
    const string ScenePath = "Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
    static readonly BindingFlags Fields = BindingFlags.Instance | BindingFlags.NonPublic;
    static readonly StringBuilder report = new StringBuilder();
    static EID5537FixedFrameRendererFeature taa;
    static EID5618PostProcessRendererFeature post;
    static Camera camera;
    static RTHandle finalColor;
    static Matrix4x4 view, projection;
    static bool running, originalEnabled, originalActive;
    static int stage, frames, resolves;
    static double deadline, nextRepaint;

    static EID5537ComparisonCapture() { EditorApplication.update += Tick; }

    [MenuItem("EID5537/Capture TAA on and off")]
    public static void Run()
    {
        if (running) return;
        Directory.CreateDirectory(Folder);
        if (UnityEngine.SceneManagement.SceneManager.GetActiveScene().path != ScenePath)
            throw new InvalidOperationException("Open the RenderDoc camera scene first. Capture never switches scenes.");
        var renderer = AssetDatabase.LoadAssetAtPath<UniversalRendererData>(RendererPath);
        taa = renderer.rendererFeatures.OfType<EID5537FixedFrameRendererFeature>().Single();
        post = renderer.rendererFeatures.OfType<EID5618PostProcessRendererFeature>().Single();
        camera = Resources.FindObjectsOfTypeAll<Camera>().Single(c => c.gameObject.scene.IsValid() &&
            c.cameraType == CameraType.Game && c.name == taa.settings.cameraNameContains);
        if (!post.isActive || !post.settings.enabledForCamera ||
            post.settings.debugOutput != EID5618PostProcessRendererFeature.Settings.DebugOutputMode.Final ||
            post.settings.inputProfile.res9Source != EID5618InputProfile.Res9SourceMode.EID5537RenderFeature)
            throw new InvalidOperationException("Expected the active EID5618 final pass with live TAA/fallback inputs.");
        originalEnabled = taa.settings.enabledForCamera;
        originalActive = taa.isActive;
        view = camera.worldToCameraMatrix;
        projection = camera.projectionMatrix;
        report.Clear();
        report.AppendLine("Time=" + DateTime.Now.ToString("O"));
        report.AppendLine("API=" + SystemInfo.graphicsDeviceType);
        report.AppendLine("Camera=" + camera.name);
        report.AppendLine("Scene=" + ScenePath);
        report.AppendLine("Position=" + camera.transform.position + " rotation=" + camera.transform.rotation);
        report.AppendLine("Capture=EID5618 final camera color; linear RGB converted to display sRGB; opaque PNG");
        report.AppendLine("Original TAA active=" + originalActive + " enabled=" + originalEnabled);
        stage = frames = resolves = 0;
        finalColor = null;
        running = true;
        deadline = EditorApplication.timeSinceStartup + 120;
        nextRepaint = 0;
        taa.SetActive(true);
        taa.settings.enabledForCamera = true;
        taa.ResetColorHistory();
        EID5618PostProcessRendererFeature.CaptureOutputForDiagnostics += ObserveFinal;
        RenderPipelineManager.endCameraRendering += Sample;
        AssemblyReloadEvents.beforeAssemblyReload += Cancel;
        EditorApplication.quitting += Cancel;
    }

    static void Tick()
    {
        if (EditorApplication.isCompiling || EditorApplication.isUpdating) return;
        if (!running && File.Exists(Folder + "/run.request"))
        {
            // During editor startup the saved scene may not have loaded yet.
            if (UnityEngine.SceneManagement.SceneManager.GetActiveScene().path != ScenePath) return;
            File.Move(Folder + "/run.request", Folder + "/run_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".done");
            try { Run(); }
            catch (Exception e)
            {
                if (running) Finish(false, e.ToString());
                else File.WriteAllText(Folder + "/capture_report.txt", "FAIL\n" + e);
            }
        }
        if (!running) return;
        if (EditorApplication.timeSinceStartup > deadline) { Finish(false, "Timed out"); return; }
        if (EditorApplication.timeSinceStartup < nextRepaint) return;
        nextRepaint = EditorApplication.timeSinceStartup + 0.12;
        foreach (var window in Resources.FindObjectsOfTypeAll<EditorWindow>())
            if (window.GetType().Name == "GameView") window.Repaint();
        EditorApplication.QueuePlayerLoopUpdate();
    }

    static void ObserveFinal(CommandBuffer cmd, RTHandle target)
    {
        if (running && ReferenceEquals(Read(post, "pass", "cameraColor"), target)) finalColor = target;
    }

    static object Read(object owner, params string[] names)
    {
        foreach (string name in names) owner = owner?.GetType().GetField(name, Fields)?.GetValue(owner);
        return owner;
    }

    static void Sample(ScriptableRenderContext context, Camera renderedCamera)
    {
        if (!running || renderedCamera != camera) return;
        try
        {
            if (camera.worldToCameraMatrix != view || camera.projectionMatrix != projection)
                throw new InvalidOperationException("Camera changed during comparison; capture aborted.");
            if (finalColor?.rt == null) throw new InvalidOperationException("No final camera color captured.");
            frames++;
            if (stage == 0)
            {
                var material = Read(taa, "material") as Material;
                if (EID5537FixedFrameRendererFeature.GetCurrentOutput(camera) == null || material == null)
                    throw new InvalidOperationException("TAA did not produce an output for this camera.");
                bool bootstrap = material.GetFloat("_EID5537BootstrapHistory") > 0.5f;
                resolves = bootstrap ? 0 : resolves + 1;
                report.AppendLine("TAA frame=" + frames + " bootstrap=" + bootstrap + " consecutiveResolves=" + resolves);
                if (resolves < 12) return;
                Save(finalColor.rt, "taa_on.png");
                // Leave the feature active so AddRenderPasses clears stale per-camera
                // output; downstream passes then use their normal live-color fallback.
                taa.settings.enabledForCamera = false;
                stage = 1;
                frames = 0;
                finalColor = null;
            }
            else
            {
                if (EID5537FixedFrameRendererFeature.GetCurrentOutput(camera) != null)
                    throw new InvalidOperationException("Stale TAA output in the disabled comparison.");
                if (frames < 2) return;
                Save(finalColor.rt, "taa_off.png");
                Finish(true, "Same camera matrices, scene and downstream final color settings; no scene or asset save.");
            }
        }
        catch (Exception e) { Finish(false, e.ToString()); }
    }

    static void Save(RenderTexture source, string name)
    {
        var old = RenderTexture.active;
        var linear = new Texture2D(source.width, source.height, TextureFormat.RGBAFloat, false, true);
        var display = new Texture2D(source.width, source.height, TextureFormat.RGBA32, false, true);
        try
        {
            RenderTexture.active = source;
            linear.ReadPixels(new Rect(0, 0, source.width, source.height), 0, 0, false);
            linear.Apply(false, false);
            var pixels = linear.GetPixels();
            long nonzero = 0;
            for (int i = 0; i < pixels.Length; i++)
            {
                Color p = pixels[i];
                if (float.IsNaN(p.r) || float.IsNaN(p.g) || float.IsNaN(p.b) ||
                    float.IsInfinity(p.r) || float.IsInfinity(p.g) || float.IsInfinity(p.b))
                    throw new InvalidOperationException("Nonfinite final image pixels");
                if (p.r != 0 || p.g != 0 || p.b != 0) nonzero++;
                pixels[i] = new Color(Mathf.LinearToGammaSpace(Mathf.Clamp01(p.r)),
                    Mathf.LinearToGammaSpace(Mathf.Clamp01(p.g)), Mathf.LinearToGammaSpace(Mathf.Clamp01(p.b)), 1);
            }
            if (nonzero == 0) throw new InvalidOperationException("Blank final image");
            display.SetPixels(pixels);
            display.Apply(false, false);
            File.WriteAllBytes(Folder + "/" + name, display.EncodeToPNG());
            report.AppendLine(name + "=" + source.width + "x" + source.height + " source=" + source.graphicsFormat +
                " nonzero=" + nonzero + " time=" + Time.realtimeSinceStartupAsDouble.ToString("F3"));
        }
        finally
        {
            RenderTexture.active = old;
            UnityEngine.Object.DestroyImmediate(linear);
            UnityEngine.Object.DestroyImmediate(display);
        }
    }

    static void Cancel() { if (running) Finish(false, "Editor reload or shutdown interrupted capture"); }

    static void Finish(bool success, string message)
    {
        running = false;
        EID5618PostProcessRendererFeature.CaptureOutputForDiagnostics -= ObserveFinal;
        RenderPipelineManager.endCameraRendering -= Sample;
        AssemblyReloadEvents.beforeAssemblyReload -= Cancel;
        EditorApplication.quitting -= Cancel;
        if (taa != null)
        {
            taa.settings.enabledForCamera = originalEnabled;
            taa.SetActive(originalActive);
            taa.ResetColorHistory();
        }
        report.AppendLine("Restored TAA active=" + (taa != null && taa.isActive) + " enabled=" + (taa != null && taa.settings.enabledForCamera));
        report.AppendLine("RESULT=" + (success ? "PASS" : "FAIL") + " " + message);
        File.WriteAllText(Folder + "/capture_report.txt", report.ToString());
        EditorApplication.QueuePlayerLoopUpdate();
        Debug.Log("[EID5537 comparison] " + (success ? "PASS" : "FAIL") + " " + Folder);
    }
}
#endif
