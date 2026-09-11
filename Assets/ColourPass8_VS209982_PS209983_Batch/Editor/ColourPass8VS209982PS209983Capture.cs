#if UNITY_EDITOR
using System;
using System.IO;
using System.Linq;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;

[InitializeOnLoad]
public static class ColourPass8VS209982PS209983Capture
{
    const string ScenePath = "Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
    const string RootName = "ColourPass8_VS209982_PS209983";
    const string TriggerPath = "Validation/ColourPass8Batch/Capture.request";
    const string OutputPath = "Validation/ColourPass8Batch/Captures";
    static bool running;

    static ColourPass8VS209982PS209983Capture() { EditorApplication.update += Poll; }
    static void Poll()
    {
        if (running || EditorApplication.isCompiling || EditorApplication.isUpdating) return;
        string trigger = Absolute(TriggerPath);
        if (!File.Exists(trigger)) return;
        try { File.Delete(trigger); }
        catch (IOException) { return; }
        Capture();
    }

    [MenuItem("Tools/Colour Pass 8/Capture VS209982 PS209983 Batch")]
    public static void Capture()
    {
        running = true;
        RenderTexture[] mrt = null;
        RenderTexture depth = null;
        try
        {
            var scene = EditorSceneManager.OpenScene(ScenePath, OpenSceneMode.Single);
            GameObject root = Array.Find(scene.GetRootGameObjects(), x => x.name == RootName);
            if (root == null) throw new InvalidOperationException("Batch root is missing: " + RootName);
            EID3332CombinedDeferredController controller = UnityEngine.Object.FindObjectOfType<EID3332CombinedDeferredController>(true);
            if (controller == null || controller.targetCamera == null) throw new InvalidOperationException("Deferred controller or target camera is missing.");
            Renderer[] renderers = root.GetComponentsInChildren<Renderer>(true).Where(x => x != null && x.sharedMaterial != null).ToArray();
            if (renderers.Length != 52) throw new InvalidOperationException("Expected 52 batch renderers, got " + renderers.Length);

            Bounds bounds = BoundsOf(renderers);
            Camera camera = controller.targetCamera;
            Vector3 view = new Vector3(0.45f, -0.25f, 1f).normalized;
            float radius = Mathf.Max(bounds.extents.magnitude, 0.1f);
            float distance = radius / Mathf.Tan(camera.fieldOfView * Mathf.Deg2Rad * 0.5f) * 1.15f;
            Vector3 cameraPosition = bounds.center - view * distance;
            Matrix4x4 cameraLocalToWorld = Matrix4x4.TRS(cameraPosition, Quaternion.LookRotation(bounds.center - cameraPosition, Vector3.up), Vector3.one);
            Matrix4x4 viewMatrix = Matrix4x4.Scale(new Vector3(1f, 1f, -1f)) * cameraLocalToWorld.inverse;
            float near = Mathf.Max(0.01f, distance - radius * 1.6f);
            float far = distance + radius * 2.5f;
            Matrix4x4 projection = GL.GetGPUProjectionMatrix(Matrix4x4.Perspective(camera.fieldOfView, 1280f / 720f, near, far), true);

            mrt = new RenderTexture[5];
            RenderTextureFormat[] formats = { RenderTextureFormat.ARGBHalf, RenderTextureFormat.ARGBHalf, RenderTextureFormat.ARGBHalf, RenderTextureFormat.ARGBHalf, RenderTextureFormat.ARGBHalf };
            for (int i = 0; i < 5; ++i)
            {
                mrt[i] = new RenderTexture(1280, 720, 0, formats[i], RenderTextureReadWrite.Linear)
                {
                    name = "ColourPass8_RT" + i,
                    filterMode = FilterMode.Point,
                    wrapMode = TextureWrapMode.Clamp,
                    hideFlags = HideFlags.HideAndDontSave
                };
                mrt[i].Create();
            }
            depth = new RenderTexture(1280, 720, 24, RenderTextureFormat.Depth, RenderTextureReadWrite.Linear)
            {
                name = "ColourPass8_Depth",
                hideFlags = HideFlags.HideAndDontSave
            };
            depth.Create();

            var colors = mrt.Select(x => new RenderTargetIdentifier(x)).ToArray();
            CommandBuffer cmd = new CommandBuffer { name = "ColourPass8 VS209982 PS209983 Direct Five MRT Validation" };
            cmd.SetRenderTarget(colors, new RenderTargetIdentifier(depth));
            cmd.ClearRenderTarget(true, true, Color.clear);
            cmd.SetViewProjectionMatrices(viewMatrix, projection);
            foreach (Renderer r in renderers)
            {
                Material material = r.sharedMaterial;
                if (material.shader == null || material.shader.name != "EID/URP/VS209982_PS209983_GBuffer")
                    throw new InvalidOperationException(r.name + " has unexpected shader " + (material.shader != null ? material.shader.name : "null"));
                cmd.DrawRenderer(r, material, 0, 0);
            }
            Graphics.ExecuteCommandBuffer(cmd);
            cmd.Release();

            string output = Absolute(OutputPath);
            Directory.CreateDirectory(output);
            int[] nonBlack = new int[5];
            for (int i = 0; i < 5; ++i) nonBlack[i] = Save(mrt[i], Path.Combine(output, "RT" + i + ".png"));
            File.Copy(Path.Combine(output, "RT4.png"), Path.Combine(output, "Final_RT4.png"), true);
            File.WriteAllText(Path.Combine(output, "capture_info.txt"),
                "date=2026-09-11\n" +
                "capture=direct_five_mrt\n" +
                "root=" + RootName + "\n" +
                "renderers=" + renderers.Length + "\n" +
                "bounds=" + bounds + "\n" +
                "camera_position=" + cameraPosition + "\n" +
                "near=" + near + "\nfar=" + far + "\n" +
                "shader=VS209982_PS209983\n" +
                "nonBlack=" + string.Join(",", nonBlack) + "\n");
            if (nonBlack[2] == 0 || nonBlack[3] == 0 || nonBlack[4] == 0)
                throw new InvalidOperationException("GBuffer validation failed: RT2/RT3/RT4 must contain geometry. Values=" + string.Join(",", nonBlack));
            AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
            Debug.Log("[ColourPass8 Capture] PASS: " + output + " nonBlack=" + string.Join(",", nonBlack));
        }
        catch (Exception e)
        {
            Debug.LogException(e);
            string output = Absolute(OutputPath); Directory.CreateDirectory(output); File.WriteAllText(Path.Combine(output, "FAIL.txt"), e.ToString());
        }
        finally
        {
            if (mrt != null) foreach (RenderTexture rt in mrt) if (rt != null) { rt.Release(); UnityEngine.Object.DestroyImmediate(rt); }
            if (depth != null) { depth.Release(); UnityEngine.Object.DestroyImmediate(depth); }
            running = false;
        }
    }

    static Bounds BoundsOf(Renderer[] renderers)
    {
        Bounds b = renderers[0].bounds;
        for (int i = 1; i < renderers.Length; ++i) b.Encapsulate(renderers[i].bounds);
        return b;
    }

    static int Save(RenderTexture source, string path)
    {
        RenderTexture old = RenderTexture.active;
        RenderTexture.active = source;
        Texture2D t = new Texture2D(source.width, source.height, TextureFormat.RGBA32, false, true);
        t.ReadPixels(new Rect(0, 0, source.width, source.height), 0, 0, false);
        t.Apply(false, false);
        Color32[] pixels = t.GetPixels32();
        int nonBlack = 0;
        for (int i = 0; i < pixels.Length; ++i) if (pixels[i].r > 2 || pixels[i].g > 2 || pixels[i].b > 2 || pixels[i].a > 2) ++nonBlack;
        File.WriteAllBytes(path, t.EncodeToPNG());
        UnityEngine.Object.DestroyImmediate(t);
        RenderTexture.active = old;
        return nonBlack;
    }

    static string Absolute(string relative) => Path.Combine(Directory.GetParent(Application.dataPath).FullName, relative.Replace('/', Path.DirectorySeparatorChar));
}
#endif
