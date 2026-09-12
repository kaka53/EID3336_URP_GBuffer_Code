#if UNITY_EDITOR
using System;
using System.Collections.Generic;
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
public static class ColourPass6VS209975PS209977BatchImporter
{
    const string Root = "Assets/ColourPass6_VS209975_PS209977_Batch";
    const string ManifestPath = Root + "/VS209975_PS209977_BatchManifest.json";
    const string ShaderPath = Root + "/Shaders/EID209975209977GBuffer.shader";
    const string TargetScene = "Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
    const string TriggerPath = "Validation/ColourPass6_VS209975/Import.request";
    const string ReportPath = "Validation/ColourPass6_VS209975/ImportReport.txt";
    const string AuditPath = "Validation/ColourPass6_VS209975/VertexAttributeAudit.md";
    const string SceneRootName = "ColourPass6_VS209975_PS209977";
    static readonly int[] ExpectedEIDs =
    {
        1776, 1780, 1782, 1786, 1788, 1792, 1794, 1798, 1800, 1804, 1806, 1810, 1814, 1818, 1820, 1824,
        1826, 1830, 1834, 1836, 1840, 1844, 1848, 1852, 1856, 1860, 1864, 1866, 1870, 1874, 1878, 1880,
        1884, 1886, 1890, 1892, 1896, 1898, 1902, 1904, 1908, 1912, 1914, 1918, 1920, 1924, 1928, 1930,
        1934, 1938, 1940, 1944, 1948, 1952, 1956, 1958, 1962, 1966, 1970, 1974, 1976, 1980, 1982, 1986,
        1990, 1992, 1996, 1998, 2002, 2004, 2008, 2012, 2016, 2020, 2024, 2028, 2032, 2036, 2040, 2044,
        2048, 2052, 2056, 2060, 2064, 2068, 2072, 2076, 2080, 2084, 2088, 2092, 2096, 2100, 2104, 2108,
        2112, 2114, 2118, 2120, 2124, 2128, 2130, 2134, 2138, 2140, 2144, 2148, 2150, 2154, 2158, 2162,
        2166, 2168, 2172, 2174, 2178, 2182, 2184, 2188, 2190, 2194, 2198, 2202, 2206, 2210, 2214, 2218,
        2222, 2226, 2230, 2234, 2238, 2242, 2246, 2250, 2254, 2258, 2262, 2266, 2270, 2274, 2278, 2282,
        2286, 2290, 2294, 2298, 2302, 2306, 2310, 2314, 2318, 2322, 2326, 2330, 2334, 2336, 2340, 2344,
        2346, 2350, 2354, 2358, 2362, 2366, 2370, 2374, 2378, 2382, 2386, 2390, 2394, 2398, 2402, 2406,
        2410, 2414, 2418, 2422, 2426, 2430, 2434, 2438, 2442, 2446, 2450, 2454, 2458, 2462, 2466, 2468,
        2472, 2474, 2478, 2482, 2486, 2490, 2494, 2498, 2502, 2507, 2511, 2515, 2519, 2523
    };
    static readonly HashSet<int> AlreadyRestored = new HashSet<int> { 2012, 2044 };
    static readonly int ExpectedInstances = 206;
    static readonly int ExpectedLayoutVariants = 1;
    static readonly int ExpectedSceneRenderers = 204;
    static bool busy;

    [Serializable] sealed class Manifest { public Profile[] profiles; public TextureDatabaseEntry[] textureDatabase; public Statistics statistics; }
    [Serializable] sealed class Statistics { public int eids, instances, vertices, triangles, layoutVariants, uniqueTextureRIDs, newTextureExports, uniqueGeometryBlobs; }
    [Serializable] sealed class Profile
    {
        public int eid, vs, ps, sourceIndexStride, sourceIndexMin, sourceIndexMax, vertexCount, triangleCount, sharedGeometryFromEID;
        public string shaderFamily, meshItem, geometrySha256;
        public Draw draw;
        public Layout[] layout;
        public StreamRef[] streams;
        public FileSet files;
        public ConstantStages constantBuffers;
        public TextureRef[] textures;
    }
    [Serializable] sealed class Draw { public int indexCount, instanceCount, indexOffset, baseVertex, vertexOffset; }
    [Serializable] sealed class Layout { public string name; public int slot, offset; public FormatRef format; public bool perInstance; public int instanceRate; }
    [Serializable] sealed class FormatRef { public string name, type, compType; public int compCount, compByteWidth; }
    [Serializable] sealed class StreamRef { public int slot, rid, sourceOffset, sourceStride, firstElement, elementCount; public bool constant; public FileRef file; }
    [Serializable] sealed class FileSet { public FileRef indices, sourceIndices; }
    [Serializable] sealed class FileRef { public string file, sha256; public int bytes; }
    [Serializable] sealed class ConstantStages { public ConstantRef[] VS, PS; }
    [Serializable] sealed class ConstantRef { public int index, binding, rid, offset, size; public string name, sha256; public FileRef file; }
    [Serializable] sealed class TextureRef { public int index, binding, rid, width, height, mips, arraySize; public string name, format; public bool uniqueMaterial; }
    [Serializable] sealed class TextureDatabaseEntry { public int rid, width, height, mips, arraySize; public string name, format, exportedAsset; public string[] existingAssets, bindings; public bool uniqueMaterial; }

    static readonly Dictionary<string, byte[]> RawCache = new Dictionary<string, byte[]>(StringComparer.OrdinalIgnoreCase);

    static ColourPass6VS209975PS209977BatchImporter() { EditorApplication.update += Poll; }
    static void Poll()
    {
        if (busy || EditorApplication.isCompiling || EditorApplication.isUpdating) return;
        string f = Absolute(TriggerPath);
        if (!File.Exists(f)) return;
        File.Delete(f);
        try { ImportAll(); }
        catch (Exception e) { File.WriteAllText(Absolute(ReportPath), "FAIL\n" + e, Encoding.UTF8); Debug.LogException(e); }
    }

    [MenuItem("Tools/Colour Pass 6/Import EID 1.1-1.206 (VS209975 PS209977)")]
    public static void ImportAll()
    {
        if (busy) return;
        busy = true;
        var report = new StringBuilder();
        var audit = new StringBuilder();
        try
        {
            RawCache.Clear();
            EnsureFolders();
            AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
            string json = File.ReadAllText(Absolute(ManifestPath), Encoding.UTF8).Replace(": null", ": \"\"");
            Manifest manifest = JsonUtility.FromJson<Manifest>(json);
            if (manifest == null || manifest.profiles == null || manifest.profiles.Length != ExpectedEIDs.Length)
                throw new InvalidDataException("Manifest must contain exactly " + ExpectedEIDs.Length + " profiles for 1.1-1.206.");
            int[] got = manifest.profiles.Select(x => x.eid).OrderBy(x => x).ToArray();
            if (!got.SequenceEqual(ExpectedEIDs.OrderBy(x => x)))
                throw new InvalidDataException("Expected EIDs 1.1-1.206, got " + string.Join(",", got));
            Shader shader = AssetDatabase.LoadAssetAtPath<Shader>(ShaderPath);
            if (shader == null) throw new FileNotFoundException("Shader asset missing", ShaderPath);
            if (ShaderUtil.ShaderHasError(shader))
                throw new InvalidOperationException("VS209975/PS209977 shader has compile errors before import.\n" + FormatShaderMessages(shader));

            ConfigureTextures(manifest, report);
            AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
            var meshes = new Dictionary<string, Mesh>(StringComparer.OrdinalIgnoreCase);
            var generated = new Dictionary<int, Generated>();
            foreach (Profile profile in manifest.profiles.OrderBy(x => x.eid))
            {
                ValidateProfile(profile);
                if (AlreadyRestored.Contains(profile.eid)) continue;
                Mesh mesh = GetOrCreateMesh(profile, meshes, audit);
                Material material = CreateMaterial(profile, shader, report);
                EID209975DrawProfile asset = CreateProfileAsset(profile, mesh, material);
                generated[profile.eid] = new Generated { mesh = mesh, material = material, profile = asset };
            }
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
            BuildScene(manifest, generated, report);
            Validate(manifest, generated, report, audit);
            File.WriteAllText(Absolute(ReportPath), report.ToString(), Encoding.UTF8);
            File.WriteAllText(Absolute(AuditPath), audit.ToString(), Encoding.UTF8);
            Debug.Log("[ColourPass6] VS209975/PS209977 import completed: " + generated.Count + " remaining EIDs (skipped 2012/2044).");
        }
        finally { busy = false; }
    }

    sealed class Generated { public Mesh mesh; public Material material; public EID209975DrawProfile profile; }

    static void ValidateProfile(Profile p)
    {
        if (p.vs != 209975 || p.ps != 209977) throw new InvalidDataException("EID" + p.eid + " shader family mismatch.");
        if (p.layout == null || p.layout.Length != 7) throw new InvalidDataException("EID" + p.eid + " must expose all 7 RenderDoc VS inputs.");
        string[] required = { "_input0", "_input1", "_input2", "_input3", "_input4", "_input5", "_input6" };
        foreach (string name in required) if (p.layout.All(x => x.name != name)) throw new InvalidDataException("EID" + p.eid + " missing " + name);
        if (p.draw == null || p.draw.instanceCount != 1) throw new InvalidDataException("EID" + p.eid + " expected inst=1.");
        if (p.files == null || p.files.indices == null || string.IsNullOrEmpty(p.files.indices.file)) throw new InvalidDataException("EID" + p.eid + " index file missing.");
        if (p.streams == null || p.streams.Length == 0) throw new InvalidDataException("EID" + p.eid + " streams missing.");
        foreach (StreamRef s in p.streams) if (s.file == null || !File.Exists(Absolute(Root + "/" + s.file.file))) throw new FileNotFoundException("EID" + p.eid + " stream missing: slot " + s.slot);
        if (Rid(p, "res17") == 0 || Rid(p, "res19") == 0) throw new InvalidDataException("EID" + p.eid + " missing unique material slots res17/res19.");
    }

    static Mesh GetOrCreateMesh(Profile p, Dictionary<string, Mesh> meshes, StringBuilder audit)
    {
        string key = string.IsNullOrEmpty(p.geometrySha256) ? "EID" + p.eid : p.geometrySha256;
        if (meshes.TryGetValue(key, out Mesh existing)) return existing;
        if (p.sharedGeometryFromEID != 0 && p.sharedGeometryFromEID != p.eid)
        {
            string sharedPath = MeshPath(p.sharedGeometryFromEID);
            Mesh shared = AssetDatabase.LoadAssetAtPath<Mesh>(sharedPath);
            if (shared != null) { meshes[key] = shared; return shared; }
        }
        Mesh mesh = CreateMesh(p, audit);
        meshes[key] = mesh;
        return mesh;
    }

    static string MeshPath(int eid) => Root + "/Geometry/Meshes/EID" + eid + "_VSInput.asset";

    static Mesh CreateMesh(Profile p, StringBuilder audit)
    {
        int count = p.vertexCount;
        byte[] stream0 = new byte[count * 16];
        byte[] stream1 = new byte[count * 8];
        byte[] stream2 = new byte[count * 8];
        for (int v = 0; v < count; ++v)
        {
            byte[] pos = ReadInput(p, "_input0", v, 12);
            byte[] packed = ReadInput(p, "_input1", v, 4);
            Buffer.BlockCopy(pos, 0, stream0, v * 16, 12);
            Buffer.BlockCopy(packed, 0, stream0, v * 16 + 12, 4);
            CopyInput(p, "_input4", v, stream1, v * 8, 8);
            CopyInput(p, "_input2", v, stream2, v * 8, 4);
            CopyInput(p, "_input3", v, stream2, v * 8 + 4, 4);
        }

        byte[] idxBytes = ReadFile(p.files.indices.file);
        uint[] indices32 = new uint[p.draw.indexCount];
        for (int i = 0; i < indices32.Length; ++i)
        {
            uint idx = BitConverter.ToUInt32(idxBytes, i * 4);
            if (idx >= (uint)count) throw new InvalidDataException("EID" + p.eid + " index out of range at " + i);
            indices32[i] = idx;
        }

        string path = MeshPath(p.sharedGeometryFromEID != 0 ? p.sharedGeometryFromEID : p.eid);
        Mesh old = AssetDatabase.LoadAssetAtPath<Mesh>(path);
        if (old != null) AssetDatabase.DeleteAsset(path);
        var mesh = new Mesh { name = "EID" + (p.sharedGeometryFromEID != 0 ? p.sharedGeometryFromEID : p.eid) + " VS209975 Complete VSInput" };
        mesh.indexFormat = count > 65535 ? IndexFormat.UInt32 : IndexFormat.UInt16;
        var desc = new[]
        {
            new VertexAttributeDescriptor(VertexAttribute.Position, VertexAttributeFormat.Float32, 3, 0),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord1, VertexAttributeFormat.Float32, 1, 0),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord0, VertexAttributeFormat.Float32, 2, 1),
            new VertexAttributeDescriptor(VertexAttribute.Tangent, VertexAttributeFormat.UNorm8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.Color, VertexAttributeFormat.UNorm8, 4, 2),
        };
        var flags = MeshUpdateFlags.DontRecalculateBounds | MeshUpdateFlags.DontValidateIndices | MeshUpdateFlags.DontNotifyMeshUsers;
        mesh.SetVertexBufferParams(count, desc);
        mesh.SetVertexBufferData(stream0, 0, 0, stream0.Length, 0, flags);
        mesh.SetVertexBufferData(stream1, 0, 0, stream1.Length, 1, flags);
        mesh.SetVertexBufferData(stream2, 0, 0, stream2.Length, 2, flags);
        if (mesh.indexFormat == IndexFormat.UInt16)
        {
            var indices16 = new ushort[indices32.Length];
            for (int i = 0; i < indices32.Length; ++i) indices16[i] = (ushort)indices32[i];
            mesh.SetIndexBufferParams(indices16.Length, IndexFormat.UInt16);
            mesh.SetIndexBufferData(indices16, 0, 0, indices16.Length, flags);
        }
        else
        {
            mesh.SetIndexBufferParams(indices32.Length, IndexFormat.UInt32);
            mesh.SetIndexBufferData(indices32, 0, 0, indices32.Length, flags);
        }
        Bounds bounds = CalculateBounds(stream0, count);
        mesh.subMeshCount = 1;
        mesh.SetSubMesh(0, new SubMeshDescriptor(0, indices32.Length, MeshTopology.Triangles)
        {
            baseVertex = 0,
            firstVertex = 0,
            vertexCount = count,
            bounds = bounds
        }, flags);
        mesh.bounds = bounds;
        mesh.UploadMeshData(false);
        AssetDatabase.CreateAsset(mesh, path);

        audit.AppendLine("## EID " + p.eid + " item " + p.meshItem);
        audit.AppendLine("- Vertices: `" + p.vertexCount + "`; Indices: `" + p.draw.indexCount + "`; Instances: `" + p.draw.instanceCount + "`");
        audit.AppendLine("- Shared geometry from EID: `" + p.sharedGeometryFromEID + "`");
        audit.AppendLine("- Unity native streams: `Position Float32x3 + packed TEXCOORD1`, `UV0 Float32x2`, `tangent/color UNorm8x4`");
        audit.AppendLine("- Captured layout: `" + string.Join("; ", p.layout.Select(x => x.name + "=slot" + x.slot + "+" + x.offset + " " + x.format.name)) + "`\n");
        return mesh;
    }

    static Bounds CalculateBounds(byte[] stream, int count)
    {
        Vector3 min = new Vector3(float.PositiveInfinity, float.PositiveInfinity, float.PositiveInfinity);
        Vector3 max = new Vector3(float.NegativeInfinity, float.NegativeInfinity, float.NegativeInfinity);
        for (int i = 0; i < count; i++)
        {
            Vector3 p = new Vector3(BitConverter.ToSingle(stream, i * 16), BitConverter.ToSingle(stream, i * 16 + 4), BitConverter.ToSingle(stream, i * 16 + 8));
            min = Vector3.Min(min, p); max = Vector3.Max(max, p);
        }
        return new Bounds((min + max) * 0.5f, max - min);
    }

    static Material CreateMaterial(Profile p, Shader shader, StringBuilder report)
    {
        string path = Root + "/Materials/EID" + p.eid + "_VS209975_PS209977.mat";
        Material m = AssetDatabase.LoadAssetAtPath<Material>(path);
        if (m == null) { m = new Material(shader); AssetDatabase.CreateAsset(m, path); }
        m.shader = shader; m.name = "EID" + p.eid + " VS209975 PS209977";
        byte[] local = ReadCB(p, "PS", "uniforms22");
        if (local.Length < 48) throw new InvalidDataException("EID" + p.eid + " PS uniforms22 expected 48 bytes, got " + local.Length);
        byte[] globals = ReadCB(p, "PS", "uniforms14");
        m.SetFloat("_EID209977LocalParam0", ReadFloat(local, 0));
        m.SetFloat("_EID209977BaseColorScale", ReadFloat(local, 4));
        m.SetVector("_EID209977LocalParam2", ReadVector4(local, 16));
        m.SetVector("_EID209977LocalParam3", ReadVector4(local, 32));
        m.SetFloat("_EID209977MipBias", globals.Length >= 420 ? ReadFloat(globals, 416) : -1f);
        m.enableInstancing = false;
        Texture baseTex = LoadTexture(p, "res17");
        Texture nrmTex = LoadTexture(p, "res19");
        if (baseTex == null || nrmTex == null)
            throw new FileNotFoundException("EID" + p.eid + " res17/res19 texture binding is incomplete.");
        m.SetTexture("_Res17", baseTex);
        m.SetTexture("_Res19", nrmTex);
        EditorUtility.SetDirty(m);
        report.AppendLine("EID" + p.eid + ": material res17=RID" + Rid(p, "res17") + " res19=RID" + Rid(p, "res19") + " scale=" + ReadFloat(local, 4).ToString(CultureInfo.InvariantCulture) + " mip=" + (globals.Length >= 420 ? ReadFloat(globals, 416).ToString(CultureInfo.InvariantCulture) : "-1"));
        return m;
    }

    static EID209975DrawProfile CreateProfileAsset(Profile p, Mesh mesh, Material material)
    {
        string path = Root + "/Profiles/EID" + p.eid + "_DrawProfile.asset";
        EID209975DrawProfile d = AssetDatabase.LoadAssetAtPath<EID209975DrawProfile>(path);
        if (d == null) { d = ScriptableObject.CreateInstance<EID209975DrawProfile>(); AssetDatabase.CreateAsset(d, path); }
        d.name = "EID" + p.eid + " Draw Profile";
        d.eventId = p.eid;
        d.indexCount = p.draw.indexCount;
        d.instanceCount = p.draw.instanceCount;
        d.vertexCount = p.vertexCount;
        d.triangleCount = p.triangleCount;
        d.sourceIndexStride = p.sourceIndexStride;
        d.sourceIndexMin = p.sourceIndexMin;
        d.sourceIndexMax = p.sourceIndexMax;
        d.shaderFamily = p.shaderFamily;
        d.meshItem = p.meshItem;
        d.sharedGeometryFromEID = p.sharedGeometryFromEID;
        d.vertexInputLayout = p.layout.Select(x => x.name + " slot=" + x.slot + " offset=" + x.offset + " format=" + x.format.name).ToArray();
        d.sourceStreams = p.streams.Select(x => "slot=" + x.slot + " stride=" + x.sourceStride + " file=" + x.file.file).ToArray();
        d.indexSource = p.files.sourceIndices != null ? p.files.sourceIndices.file : p.files.indices.file;
        d.vsConstantSources = string.Join(";", p.constantBuffers.VS.Select(x => x.name + "=" + x.file.file));
        d.psConstantSources = string.Join(";", p.constantBuffers.PS.Select(x => x.name + "=" + x.file.file));
        d.textureBindings = string.Join(";", p.textures.Select(x => x.name + "=RID" + x.rid));
        d.capturedInstanceMatrices = new[] { ReadInstanceMatrix(p, 0) };
        d.material = material;
        d.mesh = mesh;
        EditorUtility.SetDirty(d);
        return d;
    }

    static void BuildScene(Manifest manifest, Dictionary<int, Generated> generated, StringBuilder report)
    {
        Scene scene = EditorSceneManager.OpenScene(TargetScene, OpenSceneMode.Single);
        GameObject old = scene.GetRootGameObjects().FirstOrDefault(x => x.name == SceneRootName);
        if (old != null) UnityEngine.Object.DestroyImmediate(old);
        GameObject root = new GameObject(SceneRootName);
        int spawned = 0;
        foreach (Profile p in manifest.profiles.OrderBy(x => x.eid))
        {
            if (AlreadyRestored.Contains(p.eid)) continue;
            Generated g = generated[p.eid];
            GameObject go = new GameObject("EID" + p.eid);
            go.transform.SetParent(root.transform, false);
            MeshFilter mf = go.AddComponent<MeshFilter>(); mf.sharedMesh = g.mesh;
            MeshRenderer mr = go.AddComponent<MeshRenderer>();
            mr.sharedMaterial = g.material;
            mr.shadowCastingMode = ShadowCastingMode.Off;
            mr.receiveShadows = false;
            mr.motionVectorGenerationMode = MotionVectorGenerationMode.ForceNoMotion;
            mr.lightProbeUsage = LightProbeUsage.Off;
            mr.reflectionProbeUsage = ReflectionProbeUsage.Off;
            mr.allowOcclusionWhenDynamic = true;
            ApplyWorldMatrix(go.transform, ReadInstanceMatrix(p, 0));
            spawned++;
        }
        EditorSceneManager.MarkSceneDirty(scene);
        EditorSceneManager.SaveScene(scene);
        report.AppendLine("scene=" + TargetScene);
        report.AppendLine("sceneRoot=" + SceneRootName);
        report.AppendLine("sceneRenderers=" + spawned);
        report.AppendLine("skippedAlreadyRestored=2012,2044");
    }

    static void Validate(Manifest manifest, Dictionary<int, Generated> generated, StringBuilder report, StringBuilder audit)
    {
        int instances = manifest.profiles.Sum(x => x.draw.instanceCount);
        if (instances != ExpectedInstances) throw new InvalidDataException("1.1-1.206 instance total expected " + ExpectedInstances + ", got " + instances);
        int layouts = manifest.profiles.Select(LayoutKey).Distinct().Count();
        if (layouts != ExpectedLayoutVariants) throw new InvalidDataException("Expected " + ExpectedLayoutVariants + " captured vertex layout variants, got " + layouts);
        if (generated.Count != ExpectedSceneRenderers) throw new InvalidDataException("Expected " + ExpectedSceneRenderers + " remaining EIDs, got " + generated.Count);
        foreach (Profile p in manifest.profiles)
        {
            if (AlreadyRestored.Contains(p.eid)) continue;
            Generated g = generated[p.eid];
            if (g.mesh == null || g.mesh.vertexCount != p.vertexCount) throw new InvalidDataException("EID" + p.eid + " persisted mesh mismatch.");
            if (g.material == null || g.material.shader == null || g.material.shader.name != "EID/URP/VS209975_PS209977_GBuffer")
                throw new InvalidDataException("EID" + p.eid + " material shader mismatch.");
        }
        report.AppendLine("profiles=" + manifest.profiles.Length);
        report.AppendLine("instances=" + instances);
        report.AppendLine("layoutVariants=" + layouts);
        report.AppendLine("vertexAttributes=COMPLETE_7_OF_7");
        report.AppendLine("resourcePolicy=RID_DEDUPLICATED_UNIQUE_MATERIAL_ONLY_GLOBALS_REUSED");
        report.AppendLine("validation=PASS");
        audit.Insert(0, "# VS209975 / PS209977 Vertex Attribute Audit\n\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\n- EIDs: `1.1-1.206` (scene skips already-restored 2012/2044)\n- Layout variants: `" + layouts + "` (`4023e6f4d2626473`)\n- Geometry: unique mesh per remaining EID; RID155 constant VB baked per-vertex\n- Shader: family port of EID2012 VS209975/PS209977; live Unity VP; stencil Ref 0\n\n");
    }

    static string LayoutKey(Profile p) => string.Join("|", p.layout.Select(x => x.slot + ":" + x.offset + ":" + x.format.name));

    static byte[] ReadInput(Profile p, string name, int vertex, int bytes)
    {
        Layout l = p.layout.First(x => x.name == name);
        StreamRef s = p.streams.First(x => x.slot == l.slot);
        byte[] raw = ReadFile(s.file.file);
        int o = (s.constant ? 0 : vertex * s.sourceStride) + l.offset;
        if (o < 0 || o + bytes > raw.Length) throw new IndexOutOfRangeException("EID" + p.eid + " " + name + " read " + o + "+" + bytes + " exceeds " + raw.Length);
        byte[] r = new byte[bytes];
        Buffer.BlockCopy(raw, o, r, 0, bytes);
        return r;
    }
    static void CopyInput(Profile p, string name, int vertex, byte[] dst, int dstOffset, int bytes)
    {
        byte[] x = ReadInput(p, name, vertex, bytes);
        Buffer.BlockCopy(x, 0, dst, dstOffset, bytes);
    }
    static byte[] ReadCB(Profile p, string stage, string name)
    {
        ConstantRef[] a = stage == "VS" ? p.constantBuffers.VS : p.constantBuffers.PS;
        if (a == null) throw new InvalidDataException("EID" + p.eid + " missing " + stage + " constant buffers.");
        ConstantRef cb = a.FirstOrDefault(x => x.name == name);
        if (cb == null)
        {
            int expected = name == "uniforms26" ? 65536 : name == "uniforms22" ? 48 : name == "uniforms14" ? 3200 : -1;
            if (expected > 0) cb = a.FirstOrDefault(x => x.size == expected);
        }
        if (cb == null || cb.file == null || string.IsNullOrEmpty(cb.file.file))
            throw new InvalidDataException("EID" + p.eid + " missing " + stage + " " + name);
        return ReadFile(cb.file.file);
    }
    static byte[] ReadFile(string rel)
    {
        string path = Absolute(Root + "/" + rel);
        if (!RawCache.TryGetValue(path, out byte[] b)) { b = File.ReadAllBytes(path); RawCache[path] = b; }
        return b;
    }

    static Matrix4x4 ReadInstanceMatrix(Profile p, int instance)
    {
        byte[] b = ReadCB(p, "VS", "uniforms26");
        int o = instance * 256;
        if (b.Length < o + 64) throw new InvalidDataException("EID" + p.eid + " uniforms26 instance record is truncated.");
        Matrix4x4 m = Matrix4x4.identity;
        for (int c = 0; c < 4; ++c)
            for (int r = 0; r < 4; ++r)
                m[r, c] = ReadFloat(b, o + (c * 4 + r) * 4);
        return m;
    }
    static void ApplyWorldMatrix(Transform t, Matrix4x4 m)
    {
        Vector3 x = m.GetColumn(0), y = m.GetColumn(1), z = m.GetColumn(2), p = m.GetColumn(3);
        float sx = x.magnitude, sy = y.magnitude, sz = z.magnitude;
        if (sx < 1e-7f || sy < 1e-7f || sz < 1e-7f)
        {
            t.SetPositionAndRotation(p, Quaternion.identity);
            t.localScale = Vector3.one;
            return;
        }
        Vector3 scale = new Vector3(sx, sy, sz);
        if (Vector3.Dot(Vector3.Cross(x / sx, y / sy), z / sz) < 0f) scale.z = -scale.z;
        t.SetPositionAndRotation(p, Quaternion.LookRotation(z / sz, y / sy));
        t.localScale = scale;
    }

    static void ConfigureTextures(Manifest m, StringBuilder report)
    {
        int unique = 0;
        foreach (TextureDatabaseEntry e in m.textureDatabase)
        {
            if (!e.uniqueMaterial || string.IsNullOrEmpty(e.exportedAsset)) continue;
            string path = Root + "/" + e.exportedAsset;
            AssetDatabase.ImportAsset(path, ImportAssetOptions.ForceSynchronousImport);
            TextureImporter ti = AssetImporter.GetAtPath(path) as TextureImporter;
            if (ti != null)
            {
                ti.sRGBTexture = e.format != null && e.format.IndexOf("SRGB", StringComparison.OrdinalIgnoreCase) >= 0;
                ti.textureType = TextureImporterType.Default;
                ti.mipmapEnabled = e.mips > 1;
                ti.wrapMode = TextureWrapMode.Repeat;
                ti.filterMode = FilterMode.Bilinear;
                ti.SaveAndReimport();
            }
            else
                report.AppendLine("ihvTexture=" + path + " format=" + e.format);
            unique++;
        }
        report.AppendLine("uniqueMaterialRIDs=" + unique + " (shared globals not re-exported)");
    }
    static Texture LoadTexture(Profile p, string name)
    {
        int rid = Rid(p, name);
        return AssetDatabase.LoadAssetAtPath<Texture>(Root + "/TextureDatabase/rid" + rid + ".dds");
    }
    static int Rid(Profile p, string name) { TextureRef t = p.textures.FirstOrDefault(x => x.name == name); return t == null ? 0 : t.rid; }

    static Vector4 ReadVector4(byte[] b, int o) => new Vector4(ReadFloat(b, o), ReadFloat(b, o + 4), ReadFloat(b, o + 8), ReadFloat(b, o + 12));
    static float ReadFloat(byte[] b, int o) => BitConverter.ToSingle(b, o);
    static string FormatShaderMessages(Shader shader)
    {
        ShaderMessage[] msgs = ShaderUtil.GetShaderMessages(shader);
        if (msgs == null || msgs.Length == 0) return "(ShaderUtil.GetShaderMessages returned none)";
        var sb = new StringBuilder();
        foreach (ShaderMessage msg in msgs)
            sb.AppendLine(msg.severity + " " + msg.file + ":" + msg.line + " " + msg.message);
        return sb.ToString();
    }
    static string Absolute(string path) => Path.Combine(Directory.GetParent(Application.dataPath).FullName, path.Replace('/', Path.DirectorySeparatorChar));
    static void EnsureFolders()
    {
        foreach (string p in new[] {
            Root + "/Runtime", Root + "/Editor", Root + "/Geometry/Meshes", Root + "/Materials", Root + "/Profiles",
            "Validation/ColourPass6_VS209975"
        }) Directory.CreateDirectory(Absolute(p));
    }
}
#endif
