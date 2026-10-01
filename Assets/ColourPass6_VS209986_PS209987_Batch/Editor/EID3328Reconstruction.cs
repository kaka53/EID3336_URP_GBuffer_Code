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

[InitializeOnLoad]
public static class EID3328Reconstruction
{
    const string Root = "Assets/ColourPass6_VS209986_PS209987_Batch";
    const string MatPath = Root + "/Materials/EID3328_VS209986_PS209987.mat";
    const string ProfilePath = Root + "/Profiles/EID3328_DrawProfile.asset";
    const string ShaderPath = "Assets/EID3332_EID3336_Combined/URPGBuffer/IndependentVS/EID3336RenderDocGBufferIndependent.shader";
    const string ScenePath = "Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
    const string Ps44Path = Root + "/Captured/EID3328/PS_uniforms44.bytes";
    const string OutRel = ".rdctools/eid3328_verified/preview";
    const string TriggerFile = "Validation/EID3328Fix.request";
    const int Width = 1280;
    const int Height = 720;
    static readonly StringBuilder report = new StringBuilder();
    static bool busy;

    static EID3328Reconstruction()
    {
        EditorApplication.update += Poll;
    }

    static void Poll()
    {
        if (busy || EditorApplication.isCompiling || EditorApplication.isUpdating) return;
        string request = Path.Combine(Directory.GetParent(Application.dataPath).FullName, TriggerFile.Replace('/', Path.DirectorySeparatorChar));
        if (!File.Exists(request)) return;
        File.Delete(request);
        try { Build(); }
        catch (Exception e)
        {
            string projectRoot = Directory.GetParent(Application.dataPath).FullName;
            string outDir = Path.Combine(projectRoot, OutRel.Replace('/', Path.DirectorySeparatorChar));
            Directory.CreateDirectory(outDir);
            File.WriteAllText(Path.Combine(outDir, "capture_info.txt"), "RESULT=FAIL\n" + e, Encoding.UTF8);
            Debug.LogException(e);
        }
    }

    static readonly (int prop, int rid)[] Textures =
    {
        (33, 271247), (35, 222331), (37, 224843), (38, 197602), (39, 246832),
        (40, 204), (41, 197598), (42, 198094),
        (53, 198259), (54, 198278), (55, 198267), (56, 198263), (57, 198284),
        (58, 198300), (59, 198309), (60, 209602), (61, 209085),
        (62, 209106), (63, 209109), (64, 209112), (65, 209115)
    };

    static void Require(bool condition, string message)
    {
        if (!condition) throw new InvalidDataException(message);
        report.AppendLine("PASS " + message);
    }

    [MenuItem("Tools/Colour Pass 6/Fix EID3328 Black Output")]
    public static void Build()
    {
        if (busy) return;
        busy = true;
        report.Clear();
        string projectRoot = Directory.GetParent(Application.dataPath).FullName;
        string outDir = Path.Combine(projectRoot, OutRel.Replace('/', Path.DirectorySeparatorChar));
        Directory.CreateDirectory(outDir);
        RenderTexture[] mrt = null;
        RenderTexture depth = null;
        try
        {
            Require(SystemInfo.graphicsDeviceType != GraphicsDeviceType.Null, "device " + SystemInfo.graphicsDeviceType);
            AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);

            Shader shader = AssetDatabase.LoadAssetAtPath<Shader>(ShaderPath);
            Require(shader != null && !ShaderUtil.ShaderHasError(shader), "independent shader");
            Material mat = AssetDatabase.LoadAssetAtPath<Material>(MatPath);
            Require(mat != null, "material " + MatPath);
            mat.shader = shader;

            string psAbs = Path.Combine(projectRoot, Ps44Path.Replace('/', Path.DirectorySeparatorChar));
            byte[] ps = File.ReadAllBytes(psAbs);
            Require(ps.Length == 720, "PS_uniforms44 bytes=" + ps.Length);
            for (int i = 0; i < 45; ++i)
                mat.SetVector("_EID3336PSLocalParam" + i.ToString("00", CultureInfo.InvariantCulture), ReadVector4(ps, i * 16));
            mat.SetFloat("_EID3336PSUseLocalParams", 1f);
            mat.SetFloat("_EID3336UseLocalVSOverrides", 0f);
            mat.SetFloat("_EID3336PSLocalUseUVTransform", 0f);
            mat.SetFloat("_EID3336PSLocalFlipUVY", 0f);

            int bound = 0;
            foreach (var slot in Textures)
            {
                string property = "_" + slot.prop;
                if (!mat.HasProperty(property)) continue;
                Texture texture = LoadTextureAny(slot.rid);
                Require(texture != null, "texture _" + slot.prop + " rid" + slot.rid);
                mat.SetTexture(property, texture);
                bound++;
            }
            Require(bound >= 8, "bound textures=" + bound);
            Vector4 c08 = mat.GetVector("_EID3336PSLocalParam08");
            Require(c08.x > 0.5f && c08.y > 0.5f && c08.z > 0.5f, "c08 multiply " + c08);
            Require(mat.GetTexture("_33") != null, "albedo _33 bound");
            EditorUtility.SetDirty(mat);

            var profile = AssetDatabase.LoadAssetAtPath<EID3332CombinedDrawProfile>(ProfilePath);
            Require(profile != null, "draw profile");
            profile.textureSourceMaterial = mat;
            EditorUtility.SetDirty(profile);
            AssetDatabase.SaveAssets();

            var scene = EditorSceneManager.OpenScene(ScenePath, OpenSceneMode.Single);
            Require(scene.IsValid(), "opened Combined scene");
            MeshRenderer[] instances = scene.GetRootGameObjects()
                .SelectMany(r => r.GetComponentsInChildren<MeshRenderer>(true))
                .Where(r => r != null && r.gameObject.name == "EID3328_instance_000")
                .ToArray();
            Require(instances.Length > 0, "GO EID3328_instance_000 count=" + instances.Length);
            MeshRenderer mr = instances[0];
            Require(mr.enabled && mr.gameObject.activeInHierarchy, "instance_000 active");
            Require(mr.sharedMaterial == mat, "instance_000 uses rebound material");
            Require(mr.GetComponent<MeshFilter>() != null && mr.GetComponent<MeshFilter>().sharedMesh != null, "mesh assigned");

            Camera cam = FindCaptureCamera();
            Require(cam != null, "camera " + (cam != null ? cam.name : "null"));

            mrt = AllocMrt(Width, Height);
            depth = AllocDepth(Width, Height);
            Bounds world = RendererWorldBounds(mr);
            Require(world.size.sqrMagnitude > 1e-4f, "world bounds " + world);

            Matrix4x4 lookView, lookProj;
            LookAtMatrices(world, Width, Height, out lookView, out lookProj);
            int lookRt4 = DrawIsolated(mr, lookView, lookProj, mrt, depth);
            SaveMrt(mrt, outDir, "lookat");
            Require(lookRt4 > 0, "look-at RT4 nonBlack=" + lookRt4);

            int combinedRt4 = DrawIsolated(mr, cam.worldToCameraMatrix, GL.GetGPUProjectionMatrix(cam.projectionMatrix, true), mrt, depth);
            SaveMrt(mrt, outDir, "combined");
            report.AppendLine("combined-camera RT4 nonBlack=" + combinedRt4);

            File.Copy(Path.Combine(outDir, "lookat_RT4.png"), Path.Combine(outDir, "EID3328_GBuffer_RT4.png"), true);
            File.Copy(Path.Combine(outDir, "lookat_RT2.png"), Path.Combine(outDir, "EID3328_GBuffer_RT2.png"), true);
            File.Copy(Path.Combine(outDir, "lookat_RT0.png"), Path.Combine(outDir, "EID3328_GBuffer_RT0.png"), true);

            report.AppendLine("worldCenter=" + world.center.ToString("R", CultureInfo.InvariantCulture));
            report.AppendLine("worldSize=" + world.size.ToString("R", CultureInfo.InvariantCulture));
            report.AppendLine("instancePos=" + mr.transform.position.ToString("R", CultureInfo.InvariantCulture));
            report.AppendLine("RESULT=PASS");
            File.WriteAllText(Path.Combine(outDir, "capture_info.txt"), report.ToString(), Encoding.UTF8);
            File.WriteAllText(Path.Combine(projectRoot, ".rdctools/eid3328_verified/unity_validation.txt"), report.ToString(), Encoding.UTF8);
            Debug.Log("[EID3328] material rebind + GBuffer preview PASS\n" + report);
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
            busy = false;
        }
    }

    static Texture LoadTextureAny(int rid)
    {
        if (rid == 198300 || rid == 198309)
        {
            Texture2DArray array = AssetDatabase.LoadAssetAtPath<Texture2DArray>(
                "Assets/EID3332_EID3336_Combined/Resources/EID3490Textures/rid" + rid + "_array.asset");
            if (array != null) return array;
        }
        string[] roots =
        {
            "Assets/EID3332_EID3336_Combined/Resources/EID3336Textures/rid" + rid,
            "Assets/EID3332_EID3336_Combined/Resources/EID3332Textures/rid" + rid,
            "Assets/EID3332_EID3336_Combined/Resources/EID3490Textures/rid" + rid
        };
        string[] exts = { ".dds", ".png", ".tga", ".asset" };
        foreach (string root in roots)
        {
            foreach (string ext in exts)
            {
                Texture t = AssetDatabase.LoadAssetAtPath<Texture>(root + ext);
                if (t != null) return t;
            }
        }
        string[] guids = AssetDatabase.FindAssets("rid" + rid);
        foreach (string g in guids)
        {
            string path = AssetDatabase.GUIDToAssetPath(g);
            Texture t = AssetDatabase.LoadAssetAtPath<Texture>(path);
            if (t != null && (t is Texture2D || t is Texture2DArray)) return t;
        }
        return null;
    }

    static Vector4 ReadVector4(byte[] b, int o)
    {
        return new Vector4(
            BitConverter.ToSingle(b, o),
            BitConverter.ToSingle(b, o + 4),
            BitConverter.ToSingle(b, o + 8),
            BitConverter.ToSingle(b, o + 12));
    }

    static Bounds RendererWorldBounds(MeshRenderer mr)
    {
        var mf = mr.GetComponent<MeshFilter>();
        if (mf != null && mf.sharedMesh != null)
        {
            Bounds local = mf.sharedMesh.bounds;
            var b = new Bounds(mr.transform.TransformPoint(local.center), Vector3.zero);
            Vector3 e = local.extents;
            for (int x = -1; x <= 1; x += 2)
                for (int y = -1; y <= 1; y += 2)
                    for (int z = -1; z <= 1; z += 2)
                        b.Encapsulate(mr.transform.TransformPoint(local.center + Vector3.Scale(e, new Vector3(x, y, z))));
            b.Expand(1f);
            return b;
        }
        return mr.bounds;
    }

    static int DrawIsolated(MeshRenderer mr, Matrix4x4 view, Matrix4x4 proj, RenderTexture[] mrt, RenderTexture depth)
    {
        foreach (var rt in mrt)
        {
            var old = RenderTexture.active;
            RenderTexture.active = rt;
            GL.Clear(true, true, Color.clear);
            RenderTexture.active = old;
        }
        var colors = mrt.Select(x => new RenderTargetIdentifier(x)).ToArray();
        var cmd = new CommandBuffer { name = "EID3328 GBuffer preview" };
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
                name = "EID3328_preview_RT" + i,
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
            name = "EID3328_preview_Depth",
            hideFlags = HideFlags.HideAndDontSave
        };
        depth.Create();
        return depth;
    }

    static void LookAtMatrices(Bounds world, int w, int h, out Matrix4x4 view, out Matrix4x4 proj)
    {
        float fov = 35f;
        float radius = Mathf.Max(world.extents.magnitude, 2f);
        float distance = radius / Mathf.Tan(fov * Mathf.Deg2Rad * 0.5f) * 1.4f;
        Vector3 dir = new Vector3(0.55f, 0.35f, 0.76f).normalized;
        Vector3 pos = world.center - dir * distance;
        Matrix4x4 l2w = Matrix4x4.TRS(pos, Quaternion.LookRotation(world.center - pos, Vector3.up), Vector3.one);
        view = Matrix4x4.Scale(new Vector3(1f, 1f, -1f)) * l2w.inverse;
        float near = Mathf.Max(0.05f, distance - radius * 3f);
        float far = distance + radius * 4f;
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
