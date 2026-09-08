#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEngine;
using UnityEngine.SceneManagement;

// Readback of the CURRENT scene only. Never opens/saves scenes or edits model materials.
[InitializeOnLoad]
public static class EID3336DeferredInputValidation
{
    static readonly string Root = Path.GetDirectoryName(Application.dataPath);
    static readonly string Trigger = Path.Combine(Root, "Validation/trigger_rt34_contract.txt");
    static EID3336DeferredInputValidation() { EditorApplication.update += Poll; }
    static void Poll()
    {
        if (EditorApplication.isCompiling || EditorApplication.isUpdating) return;
        string liveTrigger = Path.Combine(Root, "Validation/trigger_live_output.txt");
        if (File.Exists(liveTrigger))
        {
            File.Delete(liveTrigger);
            EditorApplication.delayCall += DumpLiveState;
        }
        if (!File.Exists(Trigger)) return;
        File.Delete(Trigger);
        EditorApplication.delayCall += Capture;
    }
    [MenuItem("Tools/EID3332+3336/Validate Current Camera RT3 RT4 Lighting")]
    public static void Capture()
    {
        EID3332CombinedDeferredController controller = null;
        foreach (var c in UnityEngine.Object.FindObjectsOfType<EID3332CombinedDeferredController>())
            if (c.isActiveAndEnabled && c.targetCamera != null && c.targetCamera.gameObject.scene == SceneManager.GetActiveScene())
            { controller = c; break; }
        if (controller == null || controller.b6LightingMaterial == null || !controller.enableB6Lighting)
        { Debug.LogError("[RT34 Validation] Active scene has no enabled B6 camera/material."); return; }
        Camera camera = controller.targetCamera;
        Material original = controller.b6LightingMaterial;
        bool owns = controller.b6MaterialOwnsTuningParameters;
        RenderTexture previousTarget = camera.targetTexture;
        RenderTexture previousActive = RenderTexture.active;
        Material temporary = new Material(original) { hideFlags = HideFlags.HideAndDontSave };
        int width = Mathf.Max(1, camera.pixelWidth), height = Mathf.Max(1, camera.pixelHeight);
        RenderTexture output = new RenderTexture(width, height, 24, RenderTextureFormat.ARGB32) { hideFlags = HideFlags.HideAndDontSave };
        string folder = Path.Combine(Root, "Validation", "RT34_Contract_" + DateTime.Now.ToString("yyyyMMdd_HHmmss"));
        Directory.CreateDirectory(folder);
        var report = new StringBuilder();
        try
        {
            output.Create();
            controller.b6LightingMaterial = temporary;
            controller.b6MaterialOwnsTuningParameters = true;
            camera.targetTexture = output;
            report.AppendLine("Scene=" + SceneManager.GetActiveScene().path);
            report.AppendLine("Camera=" + camera.name + " size=" + width + "x" + height);
            report.AppendLine("Original view mode=" + original.GetFloat("_EID3336B6ViewMode"));
            int[] modes = { 0, 6, 7, 1 };
            string[] names = { "FinalLighting", "BaseColor_RT4", "NormalWS_RT3", "DirectLighting" };
            for (int i = 0; i < modes.Length; ++i)
            {
                temporary.SetFloat("_EID3336B6ViewMode", modes[i]);
                camera.Render();
                Save(output, Path.Combine(folder, names[i] + ".png"), report);
            }
            foreach (string prop in new[] { "_EID3336B6UseURPGBuffer", "_EID3336B6MaterialTarget", "_EID3336B6NormalTarget", "_EID3336B6BaseColorTarget" })
                report.AppendLine(prop + "=" + temporary.GetFloat(prop));
            for (int i = 0; i < 5; ++i)
            {
                Texture tex = temporary.GetTexture("_EID3336B6RT" + i);
                report.AppendLine("RT" + i + "=" + (tex != null ? tex.name : "NULL"));
                if (tex is RenderTexture rt && rt.IsCreated()) Save(rt, Path.Combine(folder, "BoundRT" + i + ".png"), report);
            }
            var messages = ShaderUtil.GetShaderMessages(temporary.shader);
            foreach (var message in messages) report.AppendLine("Shader: " + message.severity + " " + message.message);
            File.WriteAllText(Path.Combine(folder, "report.txt"), report.ToString());
            Debug.Log("[RT34 Validation] Capture completed: " + folder);
        }
        catch (Exception e) { Debug.LogException(e); File.WriteAllText(Path.Combine(folder, "error.txt"), e.ToString()); }
        finally
        {
            camera.targetTexture = previousTarget;
            controller.b6LightingMaterial = original;
            controller.b6MaterialOwnsTuningParameters = owns;
            RenderTexture.active = previousActive;
            output.Release();
            UnityEngine.Object.DestroyImmediate(output);
            UnityEngine.Object.DestroyImmediate(temporary);
            SceneView.RepaintAll();
        }
    }
    static string liveFolder;
    static readonly System.Collections.Generic.HashSet<int> liveCameras = new System.Collections.Generic.HashSet<int>();
    static double liveDeadline;
    [MenuItem("Tools/EID3332+3336/Inspect Real Game and Scene Output")]
    public static void DumpLiveState()
    {
        liveFolder = Path.Combine(Root, "Validation", "LiveOutput_" + DateTime.Now.ToString("yyyyMMdd_HHmmss"));
        Directory.CreateDirectory(liveFolder);
        var text = new StringBuilder();
        text.AppendLine("ActiveScene=" + SceneManager.GetActiveScene().path);
        text.AppendLine("Playing=" + EditorApplication.isPlaying + " Paused=" + EditorApplication.isPaused);
        text.AppendLine("Pipeline=" + UnityEngine.Rendering.GraphicsSettings.currentRenderPipeline);
        foreach (var c in UnityEngine.Object.FindObjectsOfType<EID3332CombinedDeferredController>(true))
        {
            text.AppendLine("Controller=" + c.name + " active=" + c.isActiveAndEnabled + " camera=" + c.targetCamera + " B6=" + c.enableB6Lighting + " sceneView=" + c.renderInSceneView);
            if (c.b6LightingMaterial != null)
            {
                foreach (string k in new[] { "_EID3336B6ViewMode", "_EID3336B6UseURPGBuffer", "_EID3336B6BaseColorTarget", "_EID3336B6NormalTarget", "_EID3336B6LightIntensity" })
                    text.AppendLine(k + "=" + c.b6LightingMaterial.GetFloat(k));
            }
        }
        foreach (Camera c in Resources.FindObjectsOfTypeAll<Camera>())
            text.AppendLine("Camera=" + c.name + " type=" + c.cameraType + " enabled=" + c.enabled + " active=" + c.gameObject.activeInHierarchy + " target=" + c.targetTexture + " display=" + c.targetDisplay + " mask=" + c.cullingMask + " rect=" + c.pixelRect + " position=" + c.transform.position);
        foreach (SceneView v in SceneView.sceneViews)
            text.AppendLine("SceneView=" + v.titleContent.text + " mode=" + v.cameraMode.name + "/" + v.cameraMode.drawMode + " lighting=" + v.sceneLighting + " camera=" + v.camera);
        foreach (EditorWindow w in Resources.FindObjectsOfTypeAll<EditorWindow>())
        {
            text.AppendLine("Window=" + w.GetType().FullName + " title=" + w.titleContent.text + " focused=" + (EditorWindow.focusedWindow == w));
            if (!w.GetType().Name.Contains("GameView")) continue;
            for (Type t = w.GetType(); t != null; t = t.BaseType)
            {
                var flags = System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.DeclaredOnly;
                foreach (var prop in t.GetProperties(flags))
                    if (prop.GetIndexParameters().Length == 0 && (typeof(Texture).IsAssignableFrom(prop.PropertyType) || prop.Name.ToLowerInvariant().Contains("display")))
                    {
                        try { text.AppendLine("  " + t.Name + "." + prop.Name + "=" + prop.GetValue(w)); } catch { }
                    }
            }
            w.Repaint();
        }
        var fd = typeof(Editor).Assembly.GetType("UnityEditorInternal.FrameDebuggerUtility");
        if (fd != null)
            foreach (var method in fd.GetMethods(System.Reflection.BindingFlags.Static | System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.NonPublic))
                if ((method.Name == "IsLocalEnabled" || method.Name == "IsEnabled") && method.GetParameters().Length == 0)
                    try { text.AppendLine("FrameDebugger." + method.Name + "=" + method.Invoke(null, null)); } catch { }
        File.WriteAllText(Path.Combine(liveFolder, "state.txt"), text.ToString());
        liveCameras.Clear();
        liveDeadline = EditorApplication.timeSinceStartup + 20;
        UnityEngine.Rendering.RenderPipelineManager.endCameraRendering -= CaptureLiveCamera;
        UnityEngine.Rendering.RenderPipelineManager.endCameraRendering += CaptureLiveCamera;
        EditorApplication.update -= FinishLiveCapture;
        EditorApplication.update += FinishLiveCapture;
        SceneView.RepaintAll();
        EditorApplication.QueuePlayerLoopUpdate();
        Debug.Log("[Live Output Diagnostic] " + liveFolder);
    }
    static void CaptureLiveCamera(UnityEngine.Rendering.ScriptableRenderContext context, Camera camera)
    {
        if (camera == null || (camera.cameraType != CameraType.Game && camera.cameraType != CameraType.SceneView) || !liveCameras.Add(camera.GetInstanceID())) return;
        var report = new StringBuilder();
        report.AppendLine("REAL camera render (not Camera.Render): " + camera.name + " type=" + camera.cameraType + " target=" + camera.targetTexture);
        try
        {
            if (camera.targetTexture != null && camera.targetTexture.IsCreated())
                Save(camera.targetTexture, Path.Combine(liveFolder, "Live_" + camera.cameraType + "_" + camera.GetInstanceID() + ".png"), report);
            var c = UnityEngine.Object.FindObjectOfType<EID3332CombinedDeferredController>();
            if (c != null && c.b6LightingMaterial != null)
            {
                report.AppendLine("viewMode=" + c.b6LightingMaterial.GetFloat("_EID3336B6ViewMode") + " normal=" + c.b6LightingMaterial.GetFloat("_EID3336B6NormalTarget") + " base=" + c.b6LightingMaterial.GetFloat("_EID3336B6BaseColorTarget"));
                for (int i = 3; i <= 4; ++i) report.AppendLine("BoundRT" + i + "=" + c.b6LightingMaterial.GetTexture("_EID3336B6RT" + i));
            }
        }
        catch (Exception e) { report.AppendLine(e.ToString()); }
        File.AppendAllText(Path.Combine(liveFolder, "live_frames.txt"), report.ToString());
    }
    static void FinishLiveCapture()
    {
        if (EditorApplication.timeSinceStartup < liveDeadline) return;
        UnityEngine.Rendering.RenderPipelineManager.endCameraRendering -= CaptureLiveCamera;
        EditorApplication.update -= FinishLiveCapture;
    }
    static void Save(RenderTexture source, string path, StringBuilder report)
    {
        var prior = RenderTexture.active;
        var copy = RenderTexture.GetTemporary(source.width, source.height, 0, RenderTextureFormat.ARGB32, RenderTextureReadWrite.Linear);
        var cpu = new Texture2D(source.width, source.height, TextureFormat.RGBA32, false, true);
        try
        {
            Graphics.Blit(source, copy);
            RenderTexture.active = copy;
            cpu.ReadPixels(new Rect(0, 0, source.width, source.height), 0, 0);
            cpu.Apply();
            File.WriteAllBytes(path, cpu.EncodeToPNG());
            int nonzero = 0;
            foreach (Color32 c in cpu.GetPixels32()) if (c.r != 0 || c.g != 0 || c.b != 0) ++nonzero;
            report.AppendLine(Path.GetFileName(path) + " nonzeroRGB=" + nonzero + "/" + (source.width * source.height));
        }
        finally { RenderTexture.active = prior; RenderTexture.ReleaseTemporary(copy); UnityEngine.Object.DestroyImmediate(cpu); }
    }
}
#endif
