#if UNITY_EDITOR
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;

[InitializeOnLoad]
public static class ColourPass3PerEIDCapture
{
    const string ScenePath = "Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
    const string RootName = "ColourPass3_VS209978_PS209979";
    const string TriggerPath = "Validation/ColourPass3Batch/CapturePerEID.request";
    const string OutputPath = "Validation/ColourPass3Batch/Captures/PerEID";
    static bool running;
    static ColourPass3PerEIDCapture() { EditorApplication.update += Poll; }
    static void Poll()
    {
        if (running || EditorApplication.isCompiling || EditorApplication.isUpdating) return;
        string t = Absolute(TriggerPath); if (!File.Exists(t)) return;
        try { File.Delete(t); } catch (IOException) { return; }
        CaptureAll();
    }

    [MenuItem("Tools/Colour Pass 3/Capture Each EID RT4")]
    public static void CaptureAll()
    {
        running = true;
        RenderTexture[] mrt = null; RenderTexture depth = null;
        try
        {
            var scene = EditorSceneManager.OpenScene(ScenePath, OpenSceneMode.Single);
            GameObject root = Array.Find(scene.GetRootGameObjects(), x => x.name == RootName);
            if (root == null) throw new InvalidOperationException("Missing " + RootName);
            Transform[] groups = root.transform.Cast<Transform>().OrderBy(x => x.name).ToArray();
            if (groups.Length != 33) throw new InvalidOperationException("Expected 33 EID groups, got " + groups.Length);
            const int size = 384;
            mrt = new RenderTexture[5];
            for (int i = 0; i < 5; ++i) { mrt[i] = new RenderTexture(size, size, 0, RenderTextureFormat.ARGBHalf, RenderTextureReadWrite.Linear) { name = "ColourPass3_PerEID_RT" + i, hideFlags = HideFlags.HideAndDontSave }; mrt[i].Create(); }
            depth = new RenderTexture(size, size, 24, RenderTextureFormat.Depth, RenderTextureReadWrite.Linear) { name = "ColourPass3_PerEID_Depth", hideFlags = HideFlags.HideAndDontSave }; depth.Create();
            RenderTargetIdentifier[] colors = mrt.Select(x => new RenderTargetIdentifier(x)).ToArray();
            string output = Absolute(OutputPath); Directory.CreateDirectory(output);
            var report = new StringBuilder(); report.AppendLine("date=2026-09-10"); report.AppendLine("shader=VS209978_PS209979"); report.AppendLine("resolution=" + size + "x" + size);
            foreach (Transform group in groups)
            {
                Renderer[] renderers = group.GetComponentsInChildren<Renderer>(true);
                if (renderers.Length == 0) throw new InvalidOperationException(group.name + " has no renderers.");
                Bounds b = renderers[0].bounds; for (int i = 1; i < renderers.Length; ++i) b.Encapsulate(renderers[i].bounds);
                Vector3 direction = new Vector3(0.55f, -0.3f, 1f).normalized;
                float radius = Mathf.Max(b.extents.magnitude, 0.02f);
                float fov = 35f; float distance = radius / Mathf.Tan(fov * Mathf.Deg2Rad * 0.5f) * 1.35f;
                Vector3 cameraPosition = b.center - direction * distance;
                Matrix4x4 cameraLocalToWorld = Matrix4x4.TRS(cameraPosition, Quaternion.LookRotation(b.center - cameraPosition, Vector3.up), Vector3.one);
                Matrix4x4 view = Matrix4x4.Scale(new Vector3(1f, 1f, -1f)) * cameraLocalToWorld.inverse;
                float near = Mathf.Max(0.001f, distance - radius * 1.8f); float far = distance + radius * 2.5f;
                Matrix4x4 projection = GL.GetGPUProjectionMatrix(Matrix4x4.Perspective(fov, 1f, near, far), true);
                CommandBuffer cmd = new CommandBuffer { name = "ColourPass3 " + group.name + " RT4 validation" };
                cmd.SetRenderTarget(colors, new RenderTargetIdentifier(depth)); cmd.ClearRenderTarget(true, true, Color.clear); cmd.SetViewProjectionMatrices(view, projection);
                foreach (Renderer r in renderers) cmd.DrawRenderer(r, r.sharedMaterial, 0, 0);
                Graphics.ExecuteCommandBuffer(cmd); cmd.Release();
                int pixels = Save(mrt[4], Path.Combine(output, group.name + "_RT4.png"));
                report.AppendLine(group.name + " renderers=" + renderers.Length + " nonBlack=" + pixels + " bounds=" + b);
                if (pixels == 0) throw new InvalidOperationException(group.name + " RT4 is empty.");
            }
            report.AppendLine("validation=PASS"); File.WriteAllText(Path.Combine(output, "PerEIDCaptureReport.txt"), report.ToString(), Encoding.UTF8);
            AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
            Debug.Log("[ColourPass3 PerEID] PASS: 33 EIDs -> " + output);
        }
        catch (Exception e) { Debug.LogException(e); string o = Absolute(OutputPath); Directory.CreateDirectory(o); File.WriteAllText(Path.Combine(o, "FAIL.txt"), e.ToString()); }
        finally { if (mrt != null) foreach (RenderTexture x in mrt) if (x != null) { x.Release(); UnityEngine.Object.DestroyImmediate(x); } if (depth != null) { depth.Release(); UnityEngine.Object.DestroyImmediate(depth); } running = false; }
    }

    static int Save(RenderTexture source, string path)
    {
        RenderTexture old = RenderTexture.active; RenderTexture.active = source; Texture2D t = new Texture2D(source.width, source.height, TextureFormat.RGBA32, false, true); t.ReadPixels(new Rect(0, 0, source.width, source.height), 0, 0); t.Apply(); Color32[] ps = t.GetPixels32(); int count = ps.Count(x => x.r > 2 || x.g > 2 || x.b > 2); File.WriteAllBytes(path, t.EncodeToPNG()); UnityEngine.Object.DestroyImmediate(t); RenderTexture.active = old; return count;
    }
    static string Absolute(string relative) => Path.Combine(Directory.GetParent(Application.dataPath).FullName, relative.Replace('/', Path.DirectorySeparatorChar));
}
#endif
