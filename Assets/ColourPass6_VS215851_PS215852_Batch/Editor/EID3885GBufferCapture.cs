#if UNITY_EDITOR
using System;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.SceneManagement;

public static class EID3885GBufferCapture
{
    const string Root = "Assets/ColourPass6_VS215851_PS215852_Batch";
    const string ScenePath = "Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
    const string OutRel = ".rdctools/eid3885_verified/preview";
    const int Width = 1280;
    const int Height = 720;
    static readonly StringBuilder report = new StringBuilder();

    static void Require(bool condition, string message)
    {
        if (!condition) throw new InvalidDataException(message);
        report.AppendLine("PASS " + message);
    }

    [MenuItem("Tools/Colour Pass 6/Capture EID3885 GBuffer Preview")]
    public static void Build()
    {
        report.Clear();
        string projectRoot = Directory.GetParent(Application.dataPath).FullName;
        string outDir = Path.Combine(projectRoot, OutRel.Replace('/', Path.DirectorySeparatorChar));
        Directory.CreateDirectory(outDir);
        RenderTexture[] mrt = null;
        RenderTexture depth = null;
        try
        {
            Require(SystemInfo.graphicsDeviceType != GraphicsDeviceType.Null, "device " + SystemInfo.graphicsDeviceType);
            var scene = EditorSceneManager.OpenScene(ScenePath, OpenSceneMode.Single);
            Require(scene.IsValid(), "opened Combined scene");

            var go = scene.GetRootGameObjects()
                .SelectMany(r => r.GetComponentsInChildren<Transform>(true))
                .FirstOrDefault(t => t.name == "EID3885");
            Require(go != null && go.gameObject.activeInHierarchy, "GO EID3885 active");
            var binder = go.GetComponent<EID215851InstanceBinder>();
            var mr = go.GetComponent<MeshRenderer>();
            var mf = go.GetComponent<MeshFilter>();
            Require(binder != null && mr != null && mf != null, "binder + MeshRenderer");
            binder.Bind();
            Require(mr.sharedMaterial != null && mr.sharedMaterial.shader != null, "material " + (mr.sharedMaterial != null ? mr.sharedMaterial.shader.name : "null"));

            Bounds world = InstanceWorldBounds(binder);
            Require(world.size.sqrMagnitude > 1e-4f, "instance world bounds " + world);
            mr.localBounds = new Bounds(world.center, world.size + Vector3.one * 4f);

            Camera cam = FindCaptureCamera();
            Require(cam != null, "camera " + (cam != null ? cam.name : "null"));

            mrt = AllocMrt(Width, Height);
            depth = AllocDepth(Width, Height);

            int combinedRt4 = DrawIsolated(mr, cam.worldToCameraMatrix, GL.GetGPUProjectionMatrix(cam.projectionMatrix, true), mrt, depth);
            SaveMrt(mrt, outDir, "combined");
            Require(combinedRt4 > 0, "combined-camera RT4 nonBlack=" + combinedRt4);

            Matrix4x4 lookView, lookProj;
            LookAtMatrices(world, Width, Height, out lookView, out lookProj);
            int lookRt4 = DrawIsolated(mr, lookView, lookProj, mrt, depth);
            SaveMrt(mrt, outDir, "lookat");
            Require(lookRt4 > 0, "look-at RT4 nonBlack=" + lookRt4);

            File.Copy(Path.Combine(outDir, "combined_RT4.png"), Path.Combine(outDir, "EID3885_GBuffer_RT4.png"), true);
            File.Copy(Path.Combine(outDir, "combined_RT0.png"), Path.Combine(outDir, "EID3885_GBuffer_RT0.png"), true);
            File.Copy(Path.Combine(outDir, "combined_RT2.png"), Path.Combine(outDir, "EID3885_GBuffer_RT2.png"), true);

            report.AppendLine("worldCenter=" + world.center.ToString("R", CultureInfo.InvariantCulture));
            report.AppendLine("worldSize=" + world.size.ToString("R", CultureInfo.InvariantCulture));
            report.AppendLine("camera=" + cam.name + " pos=" + cam.transform.position.ToString("R", CultureInfo.InvariantCulture));
            report.AppendLine("RESULT=PASS");
            File.WriteAllText(Path.Combine(outDir, "capture_info.txt"), report.ToString(), Encoding.UTF8);
            Debug.Log("[EID3885] GBuffer preview PASS\n" + report);
        }
        catch (Exception e)
        {
            report.AppendLine("RESULT=FAIL");
            report.AppendLine(e.ToString());
            File.WriteAllText(Path.Combine(outDir, "capture_info.txt"), report.ToString(), Encoding.UTF8);
            throw;
        }
        finally
        {
            if (mrt != null)
                foreach (var rt in mrt)
                    if (rt != null) { rt.Release(); UnityEngine.Object.DestroyImmediate(rt); }
            if (depth != null) { depth.Release(); UnityEngine.Object.DestroyImmediate(depth); }
        }
    }

    static Bounds InstanceWorldBounds(EID215851InstanceBinder binder)
    {
        var bytes = binder.profile != null && binder.profile.instanceBytes != null ? binder.profile.instanceBytes.bytes : null;
        int count = binder.profile != null ? binder.profile.instanceCount : 0;
        int stride = binder.profile != null && binder.profile.instanceStride > 0 ? binder.profile.instanceStride : 96;
        if (bytes == null || count <= 0 || bytes.Length < count * stride) return new Bounds(Vector3.zero, Vector3.one);
        Vector3 min = new Vector3(float.PositiveInfinity, float.PositiveInfinity, float.PositiveInfinity);
        Vector3 max = new Vector3(float.NegativeInfinity, float.NegativeInfinity, float.NegativeInfinity);
        for (int i = 0; i < count; i++)
        {
            int o = i * stride + 48;
            var p = new Vector3(BitConverter.ToSingle(bytes, o), BitConverter.ToSingle(bytes, o + 4), BitConverter.ToSingle(bytes, o + 8));
            min = Vector3.Min(min, p);
            max = Vector3.Max(max, p);
        }
        var b = new Bounds();
        b.SetMinMax(min, max);
        b.Expand(3f);
        return b;
    }

    static int DrawIsolated(MeshRenderer mr, Matrix4x4 view, Matrix4x4 proj, RenderTexture[] mrt, RenderTexture depth)
    {
        foreach (var rt in mrt) { var old = RenderTexture.active; RenderTexture.active = rt; GL.Clear(true, true, Color.clear); RenderTexture.active = old; }
        var colors = mrt.Select(x => new RenderTargetIdentifier(x)).ToArray();
        var cmd = new CommandBuffer { name = "EID3885 GBuffer preview" };
        cmd.SetRenderTarget(colors, new RenderTargetIdentifier(depth));
        cmd.ClearRenderTarget(true, true, Color.clear);
        cmd.SetViewProjectionMatrices(view, proj);
        cmd.DrawRenderer(mr, mr.sharedMaterial, 0, 0);
        Graphics.ExecuteCommandBuffer(cmd);
        cmd.Release();
        return CountNonBlack(mrt[4]);
    }

    static void SaveMrt(RenderTexture[] mrt, string outDir, string prefix)
    {
        for (int i = 0; i < mrt.Length; i++)
            Save(mrt[i], Path.Combine(outDir, prefix + "_RT" + i + ".png"));
    }

    static int Save(RenderTexture source, string path)
    {
        RenderTexture old = RenderTexture.active;
        RenderTexture converted = RenderTexture.GetTemporary(source.width, source.height, 0, RenderTextureFormat.ARGB32, RenderTextureReadWrite.Linear);
        try
        {
            Graphics.Blit(source, converted);
            RenderTexture.active = converted;
            var tex = new Texture2D(source.width, source.height, TextureFormat.RGBA32, false, true);
            tex.ReadPixels(new Rect(0, 0, source.width, source.height), 0, 0, false);
            tex.Apply(false, false);
            FlipVertical(tex);
            Color32[] ps = tex.GetPixels32();
            int count = 0;
            for (int i = 0; i < ps.Length; i++)
                if (ps[i].r > 2 || ps[i].g > 2 || ps[i].b > 2) count++;
            File.WriteAllBytes(path, tex.EncodeToPNG());
            UnityEngine.Object.DestroyImmediate(tex);
            return count;
        }
        finally
        {
            RenderTexture.ReleaseTemporary(converted);
            RenderTexture.active = old;
        }
    }

    static int CountNonBlack(RenderTexture source)
    {
        RenderTexture old = RenderTexture.active;
        RenderTexture converted = RenderTexture.GetTemporary(source.width, source.height, 0, RenderTextureFormat.ARGB32, RenderTextureReadWrite.Linear);
        try
        {
            Graphics.Blit(source, converted);
            RenderTexture.active = converted;
            var tex = new Texture2D(source.width, source.height, TextureFormat.RGBA32, false, true);
            tex.ReadPixels(new Rect(0, 0, source.width, source.height), 0, 0, false);
            tex.Apply(false, false);
            Color32[] ps = tex.GetPixels32();
            int count = 0;
            for (int i = 0; i < ps.Length; i++)
                if (ps[i].r > 2 || ps[i].g > 2 || ps[i].b > 2) count++;
            UnityEngine.Object.DestroyImmediate(tex);
            return count;
        }
        finally
        {
            RenderTexture.ReleaseTemporary(converted);
            RenderTexture.active = old;
        }
    }

    static RenderTexture[] AllocMrt(int w, int h)
    {
        var mrt = new RenderTexture[5];
        for (int i = 0; i < 5; i++)
        {
            mrt[i] = new RenderTexture(w, h, 0, RenderTextureFormat.ARGBHalf, RenderTextureReadWrite.Linear)
            {
                name = "EID3885_preview_RT" + i,
                hideFlags = HideFlags.HideAndDontSave
            };
            mrt[i].Create();
        }
        return mrt;
    }

    static RenderTexture AllocDepth(int w, int h)
    {
        var depth = new RenderTexture(w, h, 24, RenderTextureFormat.Depth, RenderTextureReadWrite.Linear)
        {
            name = "EID3885_preview_Depth",
            hideFlags = HideFlags.HideAndDontSave
        };
        depth.Create();
        return depth;
    }

    static void LookAtMatrices(Bounds world, int w, int h, out Matrix4x4 view, out Matrix4x4 proj)
    {
        float fov = 35f;
        float radius = Mathf.Max(world.extents.x, world.extents.z, 4f);
        float distance = radius / Mathf.Tan(fov * Mathf.Deg2Rad * 0.5f) * 0.95f;
        Vector3 dir = new Vector3(0.55f, 0.22f, 0.80f).normalized;
        Vector3 pos = world.center - dir * distance;
        Matrix4x4 l2w = Matrix4x4.TRS(pos, Quaternion.LookRotation(world.center - pos, Vector3.up), Vector3.one);
        view = Matrix4x4.Scale(new Vector3(1f, 1f, -1f)) * l2w.inverse;
        float near = Mathf.Max(0.05f, distance - radius * 2f);
        float far = distance + radius * 3f;
        proj = GL.GetGPUProjectionMatrix(Matrix4x4.Perspective(fov, (float)w / h, near, far), true);
    }

    static void FlipVertical(Texture2D tex)
    {
        Color[] pixels = tex.GetPixels();
        int w = tex.width;
        int h = tex.height;
        var flipped = new Color[pixels.Length];
        for (int y = 0; y < h; y++)
            Array.Copy(pixels, y * w, flipped, (h - 1 - y) * w, w);
        tex.SetPixels(flipped);
        tex.Apply(false, false);
    }

    static Camera FindCaptureCamera()
    {
        var cameras = UnityEngine.Object.FindObjectsOfType<Camera>(true);
        for (int i = 0; i < cameras.Length; i++)
            if (cameras[i] != null && cameras[i].name == "EID3336 RenderDoc Camera") return cameras[i];
        return cameras.Length > 0 ? cameras[0] : null;
    }
}
#endif
