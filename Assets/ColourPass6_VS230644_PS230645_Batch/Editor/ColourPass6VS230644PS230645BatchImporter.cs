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
public static class ColourPass6VS230644PS230645BatchImporter
{
    const string Root = "Assets/ColourPass6_VS230644_PS230645_Batch";
    const string ManifestPath = Root + "/VS230644_PS230645_BatchManifest.json";
    const string ShaderPath = Root + "/Shaders/EID230644230645GBuffer.shader";
    const string TargetScene = "Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
    const string TriggerPath = "Validation/ColourPass6_VS230644/Import.request";
    const string ReportPath = "Validation/ColourPass6_VS230644/ImportReport.txt";
    const string AuditPath = "Validation/ColourPass6_VS230644/VertexAttributeAudit.md";
    const string SceneRootName = "ColourPass6_VS230644_PS230645";
    static readonly int[] ExpectedEIDs = { 2583, 2587, 2591, 2595, 2599 };
    static readonly int ExpectedInstances = 8;
    static readonly int ExpectedLayoutVariants = 1;
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
        public ReadWriteStages readWriteResources;
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
    [Serializable] sealed class ReadWriteStages { public BufferRef[] VS; }
    [Serializable] sealed class BufferRef { public int index, binding, rid, offset, size; public string name, sha256; public FileRef file; }

    static readonly Dictionary<string, byte[]> RawCache = new Dictionary<string, byte[]>(StringComparer.OrdinalIgnoreCase);
    static Manifest currentManifest;

    static ColourPass6VS230644PS230645BatchImporter() { EditorApplication.update += Poll; }
    static void Poll()
    {
        if (busy || EditorApplication.isCompiling || EditorApplication.isUpdating) return;
        string f = Absolute(TriggerPath);
        if (!File.Exists(f)) return;
        File.Delete(f);
        try { ImportAll(); }
        catch (Exception e) { File.WriteAllText(Absolute(ReportPath), "FAIL\n" + e, Encoding.UTF8); Debug.LogException(e); }
    }

    [MenuItem("Tools/Colour Pass 6/Import EID 22.1-22.5 (VS230644 PS230645)")]
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
            currentManifest = manifest;
            if (manifest == null || manifest.profiles == null || manifest.profiles.Length != ExpectedEIDs.Length)
                throw new InvalidDataException("Manifest must contain exactly " + ExpectedEIDs.Length + " profiles for 22.1-22.5.");
            int[] got = manifest.profiles.Select(x => x.eid).OrderBy(x => x).ToArray();
            if (!got.SequenceEqual(ExpectedEIDs.OrderBy(x => x)))
                throw new InvalidDataException("Expected EIDs 22.1-22.5, got " + string.Join(",", got));
            Shader shader = AssetDatabase.LoadAssetAtPath<Shader>(ShaderPath);
            if (shader == null) throw new FileNotFoundException("Shader asset missing", ShaderPath);
            if (ShaderUtil.ShaderHasError(shader))
                throw new InvalidOperationException("VS230644/PS230645 shader has compile errors before import.\n" + FormatShaderMessages(shader));

            ConfigureTextures(manifest, report);
            AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
            var meshes = new Dictionary<string, Mesh>(StringComparer.OrdinalIgnoreCase);
            var generated = new Dictionary<int, Generated>();
            foreach (Profile profile in manifest.profiles.OrderBy(x => x.eid))
            {
                ValidateProfile(profile);
                Mesh mesh = GetOrCreateMesh(profile, meshes, audit);
                Material material = CreateMaterial(profile, shader, report);
                EID230644DrawProfile asset = CreateProfileAsset(profile, mesh, material);
                generated[profile.eid] = new Generated { mesh = mesh, material = material, profile = asset };
            }
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
            BuildScene(manifest, generated, report);
            Validate(manifest, generated, report, audit);
            File.WriteAllText(Absolute(ReportPath), report.ToString(), Encoding.UTF8);
            File.WriteAllText(Absolute(AuditPath), audit.ToString(), Encoding.UTF8);
            Debug.Log("[ColourPass6] VS230644/PS230645 import completed: " + manifest.profiles.Length + " EIDs, " + manifest.profiles.Sum(x => x.draw.instanceCount) + " instances.");
        }
        finally { busy = false; currentManifest = null; }
    }

    sealed class Generated { public Mesh mesh; public Material material; public EID230644DrawProfile profile; }

    static void ValidateProfile(Profile p)
    {
        if (p.vs != 230644 || p.ps != 230645) throw new InvalidDataException("EID" + p.eid + " shader family mismatch.");
        if (p.layout == null || p.layout.Length != 8) throw new InvalidDataException("EID" + p.eid + " must expose all 8 RenderDoc VS inputs.");
        string[] required = { "_input0", "_input1", "_input2", "_input3", "_input4", "_input5", "_input6", "_input7" };
        foreach (string name in required) if (p.layout.All(x => x.name != name)) throw new InvalidDataException("EID" + p.eid + " missing " + name);
        if (p.files == null || p.files.indices == null || string.IsNullOrEmpty(p.files.indices.file)) throw new InvalidDataException("EID" + p.eid + " index file missing.");
        if (p.streams == null || p.streams.Length == 0) throw new InvalidDataException("EID" + p.eid + " streams missing.");
        foreach (StreamRef s in p.streams) if (s.file == null || !File.Exists(Absolute(Root + "/" + s.file.file))) throw new FileNotFoundException("EID" + p.eid + " stream missing: slot " + s.slot);
        if (Rid(p, "res23") == 0 || Rid(p, "res25") == 0 || Rid(p, "res27") == 0 || Rid(p, "res29") == 0)
            throw new InvalidDataException("EID" + p.eid + " missing material slots res23/res25/res27/res29.");
        byte[] local = ReadCB(p, "PS", "uniforms32");
        if (local.Length < 256) throw new InvalidDataException("EID" + p.eid + " PS uniforms32 expected 256 bytes, got " + local.Length);
        byte[] inst = ReadCB(p, "VS", "uniforms27");
        if (inst.Length < p.draw.instanceCount * 256) throw new InvalidDataException("EID" + p.eid + " VS uniforms27 too small: " + inst.Length);
        byte[] overlay = ReadCB(p, "PS", "uniforms20");
        if (overlay.Length < p.draw.instanceCount * 256) throw new InvalidDataException("EID" + p.eid + " PS uniforms20 too small: " + overlay.Length);
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
        byte[] stream0 = new byte[count * 24];
        byte[] stream1 = new byte[count * 32];
        byte[] stream2 = new byte[count * 16];
        byte[] stream3 = new byte[count * 28];
        bool bakeSkin = HasCapturedSkinning(p);
        byte[] skin = null;
        if (bakeSkin)
        {
            if (p.readWriteResources == null || p.readWriteResources.VS == null || p.readWriteResources.VS.Length == 0 || p.readWriteResources.VS[0].file == null || string.IsNullOrEmpty(p.readWriteResources.VS[0].file.file))
                throw new FileNotFoundException("EID" + p.eid + " captured skin flag is set but ssbo29 file is missing.");
            skin = ReadFile(p.readWriteResources.VS[0].file.file);
        }
        byte[] instanceCB = ReadCB(p, "VS", "uniforms27");

        for (int v = 0; v < count; ++v)
        {
            byte[] pos = ReadInput(p, "_input0", v, 12);
            byte[] packed = ReadInput(p, "_input1", v, 4);
            Buffer.BlockCopy(pos, 0, stream0, v * 24, 12);
            Buffer.BlockCopy(packed, 0, stream0, v * 24 + 12, 4);
            CopyInput(p, "_input3", v, stream1, v * 32 + 0, 16);
            CopyInput(p, "_input4", v, stream1, v * 32 + 16, 16);
            CopyInput(p, "_input2", v, stream2, v * 16 + 0, 4);
            CopyInput(p, "_input5", v, stream2, v * 16 + 4, 4);
            Vector4 weights = ReadWeights(p, v);
            WriteUNorm8(stream2, v * 16 + 8, weights);
            CopyInput(p, "_input7", v, stream2, v * 16 + 12, 4);

            Vector3 n; Vector4 t;
            DecodeBasis(BitConverter.ToUInt32(packed, 0), DecodeUNorm4(ReadInput(p, "_input2", v, 4)), out n, out t);
            if (bakeSkin && skin != null)
            {
                Vector3 position = new Vector3(BitConverter.ToSingle(pos, 0), BitConverter.ToSingle(pos, 4), BitConverter.ToSingle(pos, 8));
                byte[] joints = ReadInput(p, "_input7", v, 4);
                SkinVertex(instanceCB, skin, position, n, t, joints, weights, out Vector3 sp, out Vector3 sn, out Vector4 st);
                WriteFloat(stream0, v * 24 + 0, sp.x);
                WriteFloat(stream0, v * 24 + 4, sp.y);
                WriteFloat(stream0, v * 24 + 8, sp.z);
                n = sn;
                t = st;
            }
            WriteVector3(stream3, v * 28, n);
            WriteVector4(stream3, v * 28 + 12, t);
        }

        byte[] idxBytes = ReadFile(p.files.indices.file);
        uint[] indices32 = new uint[p.draw.indexCount];
        for (int i = 0; i < indices32.Length; ++i) indices32[i] = BitConverter.ToUInt32(idxBytes, i * 4);

        string path = MeshPath(p.sharedGeometryFromEID != 0 ? p.sharedGeometryFromEID : p.eid);
        Mesh old = AssetDatabase.LoadAssetAtPath<Mesh>(path);
        if (old != null) AssetDatabase.DeleteAsset(path);
        var mesh = new Mesh { name = "EID" + (p.sharedGeometryFromEID != 0 ? p.sharedGeometryFromEID : p.eid) + " VS230644 Complete VSInput" };
        if (count > 65535) mesh.indexFormat = IndexFormat.UInt32;
        var desc = new[]
        {
            new VertexAttributeDescriptor(VertexAttribute.Position, VertexAttributeFormat.Float32, 3, 0),
            new VertexAttributeDescriptor(VertexAttribute.Normal, VertexAttributeFormat.Float32, 3, 0),
            new VertexAttributeDescriptor(VertexAttribute.Color, VertexAttributeFormat.UNorm8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord0, VertexAttributeFormat.Float32, 4, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord1, VertexAttributeFormat.Float32, 4, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord2, VertexAttributeFormat.SNorm8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord3, VertexAttributeFormat.UNorm8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.BlendIndices, VertexAttributeFormat.UInt8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord4, VertexAttributeFormat.Float32, 3, 3),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord5, VertexAttributeFormat.Float32, 4, 3),
        };
        mesh.SetVertexBufferParams(count, desc);
        mesh.SetVertexBufferData(stream0, 0, 0, stream0.Length, 0, MeshUpdateFlags.DontRecalculateBounds | MeshUpdateFlags.DontValidateIndices);
        mesh.SetVertexBufferData(stream1, 0, 0, stream1.Length, 1, MeshUpdateFlags.DontRecalculateBounds | MeshUpdateFlags.DontValidateIndices);
        mesh.SetVertexBufferData(stream2, 0, 0, stream2.Length, 2, MeshUpdateFlags.DontRecalculateBounds | MeshUpdateFlags.DontValidateIndices);
        mesh.SetVertexBufferData(stream3, 0, 0, stream3.Length, 3, MeshUpdateFlags.DontRecalculateBounds | MeshUpdateFlags.DontValidateIndices);
        mesh.SetIndexBufferParams(indices32.Length, IndexFormat.UInt32);
        mesh.SetIndexBufferData(indices32, 0, 0, indices32.Length, MeshUpdateFlags.DontRecalculateBounds | MeshUpdateFlags.DontValidateIndices);
        mesh.subMeshCount = 1;
        mesh.SetSubMesh(0, new SubMeshDescriptor(0, indices32.Length, MeshTopology.Triangles), MeshUpdateFlags.DontRecalculateBounds | MeshUpdateFlags.DontValidateIndices);
        mesh.RecalculateBounds();
        AssetDatabase.CreateAsset(mesh, path);

        audit.AppendLine("## EID " + p.eid + " item " + p.meshItem);
        audit.AppendLine("- Vertices: `" + p.vertexCount + "`; Indices: `" + p.draw.indexCount + "`; Instances: `" + p.draw.instanceCount + "`");
        audit.AppendLine("- Shared geometry from EID: `" + p.sharedGeometryFromEID + "`");
        audit.AppendLine("- Unity native streams: `Position Float32x3 + Normal Float32x3 packed _input1 in .x`, `input3/input4 Float32x4`, `input5 SNorm8x4`, `input2/input6 UNorm8x4`, `input7 UInt8x4`, `TEXCOORD4/5 baked n/t`");
        audit.AppendLine("- Captured layout: `" + string.Join("; ", p.layout.Select(x => x.name + "=slot" + x.slot + "+" + x.offset + " " + x.format.name)) + "`");
        audit.AppendLine("- Captured skinning baked: `" + HasCapturedSkinning(p) + "`\n");
        return mesh;
    }

    static Material CreateMaterial(Profile p, Shader shader, StringBuilder report)
    {
        string path = Root + "/Materials/EID" + p.eid + "_VS230644_PS230645.mat";
        Material m = AssetDatabase.LoadAssetAtPath<Material>(path);
        if (m == null) { m = new Material(shader); AssetDatabase.CreateAsset(m, path); }
        m.shader = shader; m.name = "EID" + p.eid + " VS230644 PS230645";
        byte[] local = ReadCB(p, "PS", "uniforms32");
        for (int i = 0; i < 16; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));
        ApplyInstanceOverlay(m, p, 0);
        byte[] globals = ReadCB(p, "PS", "uniforms17");
        m.SetFloat("_EID230645MipBias", ReadFloat(globals, 416));
        m.SetFloat("_EID230645GlobalY", ReadFloat(globals, 436));
        m.SetFloat("_UseBakedSkinning", HasCapturedSkinning(p) ? 1f : 0f);
        Texture albedo = LoadTexture(p, "res23");
        Texture nrm = LoadTexture(p, "res25");
        Texture packed = LoadTexture(p, "res27");
        Texture overlayTex = LoadTexture(p, "res29");
        if (albedo == null || nrm == null || packed == null || overlayTex == null)
            throw new FileNotFoundException("EID" + p.eid + " res23/res25/res27/res29 texture binding is incomplete.");
        m.SetTexture("_Res23", albedo);
        m.SetTexture("_Res25", nrm);
        m.SetTexture("_Res27", packed);
        m.SetTexture("_Res29", overlayTex);
        EditorUtility.SetDirty(m);
        report.AppendLine("EID" + p.eid + ": material res23=RID" + Rid(p, "res23") + " res25=RID" + Rid(p, "res25") + " res27=RID" + Rid(p, "res27") + " res29=RID" + Rid(p, "res29") + " PS uniforms32=" + local.Length + "B");
        return m;
    }

    static EID230644DrawProfile CreateProfileAsset(Profile p, Mesh mesh, Material material)
    {
        string path = Root + "/Profiles/EID" + p.eid + "_DrawProfile.asset";
        EID230644DrawProfile d = AssetDatabase.LoadAssetAtPath<EID230644DrawProfile>(path);
        if (d == null) { d = ScriptableObject.CreateInstance<EID230644DrawProfile>(); AssetDatabase.CreateAsset(d, path); }
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
        d.bakedCapturedSkinning = HasCapturedSkinning(p);
        d.vertexInputLayout = p.layout.Select(x => x.name + " slot=" + x.slot + " offset=" + x.offset + " format=" + x.format.name).ToArray();
        d.sourceStreams = p.streams.Select(x => "slot=" + x.slot + " stride=" + x.sourceStride + " file=" + x.file.file).ToArray();
        d.indexSource = p.files.sourceIndices.file;
        d.vsConstantSources = string.Join(";", p.constantBuffers.VS.Select(x => x.name + "=" + x.file.file));
        d.psConstantSources = string.Join(";", p.constantBuffers.PS.Select(x => x.name + "=" + x.file.file));
        d.textureBindings = string.Join(";", p.textures.Select(x => x.name + "=RID" + x.rid));
        d.capturedInstanceMatrices = Enumerable.Range(0, p.draw.instanceCount).Select(i => ReadInstanceMatrix(p, i)).ToArray();
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
        foreach (Profile p in manifest.profiles.OrderBy(x => x.eid))
        {
            GameObject eidRoot = new GameObject("EID" + p.eid);
            eidRoot.transform.SetParent(root.transform, false);
            Generated g = generated[p.eid];
            for (int i = 0; i < p.draw.instanceCount; ++i)
            {
                GameObject go = new GameObject("EID" + p.eid + "_instance_" + i.ToString("000"));
                go.transform.SetParent(eidRoot.transform, false);
                MeshFilter mf = go.AddComponent<MeshFilter>(); mf.sharedMesh = g.mesh;
                MeshRenderer mr = go.AddComponent<MeshRenderer>();
                Material mat = i == 0 ? g.material : UnityEngine.Object.Instantiate(g.material);
                ApplyInstanceOverlay(mat, p, i);
                if (i != 0)
                {
                    string matPath = Root + "/Materials/EID" + p.eid + "_instance_" + i.ToString("000") + ".mat";
                    Material existing = AssetDatabase.LoadAssetAtPath<Material>(matPath);
                    if (existing != null) AssetDatabase.DeleteAsset(matPath);
                    AssetDatabase.CreateAsset(mat, matPath);
                }
                mr.sharedMaterial = mat;
                mr.shadowCastingMode = ShadowCastingMode.Off;
                mr.receiveShadows = false;
                mr.motionVectorGenerationMode = MotionVectorGenerationMode.ForceNoMotion;
                ApplyWorldMatrix(go.transform, ReadInstanceMatrix(p, i));
            }
        }
        EditorSceneManager.MarkSceneDirty(scene);
        EditorSceneManager.SaveScene(scene);
        report.AppendLine("scene=" + TargetScene);
        report.AppendLine("sceneRoot=" + SceneRootName);
        report.AppendLine("sceneRenderers=" + manifest.profiles.Sum(x => x.draw.instanceCount));
    }

    static void Validate(Manifest manifest, Dictionary<int, Generated> generated, StringBuilder report, StringBuilder audit)
    {
        int instances = manifest.profiles.Sum(x => x.draw.instanceCount);
        if (instances != ExpectedInstances) throw new InvalidDataException("22.1-22.5 instance total expected " + ExpectedInstances + ", got " + instances);
        int layouts = manifest.profiles.Select(LayoutKey).Distinct().Count();
        if (layouts != ExpectedLayoutVariants) throw new InvalidDataException("Expected " + ExpectedLayoutVariants + " captured vertex layout variants, got " + layouts);
        foreach (Profile p in manifest.profiles)
        {
            Generated g = generated[p.eid];
            if (g.mesh == null || g.mesh.vertexCount != p.vertexCount) throw new InvalidDataException("EID" + p.eid + " persisted mesh mismatch.");
            if (g.material == null || g.material.shader == null || g.material.shader.name != "EID/URP/VS230644_PS230645_GBuffer")
                throw new InvalidDataException("EID" + p.eid + " material shader mismatch.");
        }
        report.AppendLine("profiles=" + manifest.profiles.Length);
        report.AppendLine("instances=" + instances);
        report.AppendLine("layoutVariants=" + layouts);
        report.AppendLine("vertexAttributes=COMPLETE_8_OF_8");
        report.AppendLine("resourcePolicy=RID_DEDUPLICATED_UNIQUE_MATERIAL_REUSE_EXISTING_ASSETS");
        report.AppendLine("validation=PASS");
        audit.Insert(0, "# VS230644 / PS230645 Vertex Attribute Audit\n\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\n- EIDs: `22.1-22.5`\n- Layout variants: `" + layouts + "` (`1b4b25536f636481`)\n- Shader: live Unity VP; unique res23/25/27/29; PS uniforms32 256B; Cull Back; ZWrite On; stencil 32; skip skin (flags 0); no VAT; no res31 layer\n\n");
    }

    static string LayoutKey(Profile p) => string.Join("|", p.layout.Select(x => x.slot + ":" + x.offset + ":" + x.format.name));
    static bool HasCapturedSkinning(Profile p)
    {
        byte[] cb = ReadCB(p, "VS", "uniforms27");
        return cb.Length >= 80 && (BitConverter.ToUInt32(cb, 76) & 32u) != 0u;
    }

    static Vector4 ReadWeights(Profile p, int vertex)
    {
        Layout l = p.layout.First(x => x.name == "_input6");
        int bytes = Math.Max(1, l.format.compCount * l.format.compByteWidth);
        byte[] raw = ReadInput(p, "_input6", vertex, bytes);
        if (l.format.compByteWidth >= 2)
            return new Vector4(BitConverter.ToUInt16(raw, 0) / 65535f, BitConverter.ToUInt16(raw, 2) / 65535f, BitConverter.ToUInt16(raw, 4) / 65535f, BitConverter.ToUInt16(raw, 6) / 65535f);
        return DecodeUNorm4(raw);
    }

    static void SkinVertex(byte[] instanceCB, byte[] skin, Vector3 p, Vector3 n, Vector4 t, byte[] joints, Vector4 weights, out Vector3 sp, out Vector3 sn, out Vector4 st)
    {
        uint flags = BitConverter.ToUInt32(instanceCB, 76);
        uint influences = flags & 0xFFFFFFCFu;
        uint baseIndex = BitConverter.ToUInt32(instanceCB, 80) + 3u;
        Vector4 r0 = Vector4.zero, r1 = Vector4.zero, r2 = Vector4.zero;
        int count = influences >= 4 ? 4 : influences >= 2 ? 2 : 1;
        float[] ws = { weights.x, weights.y, weights.z, weights.w };
        if (count == 1) ws[0] = 1f;
        for (int i = 0; i < count; ++i)
        {
            uint b = baseIndex + (uint)joints[i] * 3u;
            r0 += LoadFloat4(skin, b) * ws[i];
            r1 += LoadFloat4(skin, b + 1u) * ws[i];
            r2 += LoadFloat4(skin, b + 2u) * ws[i];
        }
        Vector4 hp = new Vector4(p.x, p.y, p.z, 1f);
        sp = new Vector3(Vector4.Dot(r0, hp), Vector4.Dot(r1, hp), Vector4.Dot(r2, hp));
        sn = new Vector3(Vector3.Dot(new Vector3(r0.x, r0.y, r0.z), n), Vector3.Dot(new Vector3(r1.x, r1.y, r1.z), n), Vector3.Dot(new Vector3(r2.x, r2.y, r2.z), n)).normalized;
        Vector3 tv = new Vector3(t.x, t.y, t.z);
        Vector3 ts = new Vector3(Vector3.Dot(new Vector3(r0.x, r0.y, r0.z), tv), Vector3.Dot(new Vector3(r1.x, r1.y, r1.z), tv), Vector3.Dot(new Vector3(r2.x, r2.y, r2.z), tv)).normalized;
        st = new Vector4(ts.x, ts.y, ts.z, t.w);
    }

    static Vector4 LoadFloat4(byte[] b, uint vectorIndex)
    {
        int o = checked((int)vectorIndex * 16);
        if (o < 0 || o + 16 > b.Length) throw new IndexOutOfRangeException("Captured skin buffer index " + vectorIndex + " exceeds " + b.Length + " bytes.");
        return ReadVector4(b, o);
    }

    static void DecodeBasis(uint packed, Vector4 fallback, out Vector3 n, out Vector4 t)
    {
        if ((packed & 0x40000000u) == 0u)
        {
            n = new Vector3(BitConverter.ToSingle(BitConverter.GetBytes(packed), 0), 0f, 0f);
            t = fallback;
            return;
        }
        const float k = 0.0019569471478462219f;
        int xi = Sign10((packed << 22) >> 22), yi = Sign10((packed << 12) >> 22), zi = Sign10((packed << 2) >> 22);
        n = new Vector3(xi, yi, 0f) * k;
        n.z = 1f - Mathf.Abs(n.x) - Mathf.Abs(n.y);
        if (n.z < 0f)
        {
            Vector2 q = new Vector2(1f - Mathf.Abs(n.y), 1f - Mathf.Abs(n.x));
            q.x *= n.x >= 0f ? 1f : -1f;
            q.y *= n.y >= 0f ? 1f : -1f;
            n.x = q.x;
            n.y = q.y;
        }
        n.Normalize();
        float signed10 = zi * k;
        Vector3 seed = new Vector3(n.y - n.z, n.z - n.x, n.x - n.y);
        Vector3 t0 = (seed - Vector3.Dot(seed, n) * n).normalized;
        float tangentSign = signed10 < 0f ? -1f : 1f;
        float encoded = 1f - ((signed10 * tangentSign) * 2f);
        Vector2 r = new Vector2(encoded, tangentSign * (1f - Mathf.Abs(encoded)));
        r.Normalize();
        Vector3 t1 = Vector3.Cross(n, t0).normalized;
        Vector3 tv = t0 * r.x + t1 * r.y;
        t = new Vector4(tv.x, tv.y, tv.z, ((packed >> 31) & 1u) * 2f - 1f);
    }

    static int Sign10(uint v) { int x = (int)v; return x >= 512 ? x - 1024 : x; }
    static Vector4 DecodeUNorm4(byte[] b) => new Vector4(b[0] / 255f, b[1] / 255f, b[2] / 255f, b[3] / 255f);
    static void WriteUNorm8(byte[] b, int o, Vector4 v)
    {
        b[o] = (byte)Mathf.Clamp(Mathf.RoundToInt(v.x * 255f), 0, 255);
        b[o + 1] = (byte)Mathf.Clamp(Mathf.RoundToInt(v.y * 255f), 0, 255);
        b[o + 2] = (byte)Mathf.Clamp(Mathf.RoundToInt(v.z * 255f), 0, 255);
        b[o + 3] = (byte)Mathf.Clamp(Mathf.RoundToInt(v.w * 255f), 0, 255);
    }
    static void WriteFloat(byte[] b, int o, float v) { byte[] x = BitConverter.GetBytes(v); Buffer.BlockCopy(x, 0, b, o, 4); }
    static void WriteVector3(byte[] b, int o, Vector3 v) { WriteFloat(b, o, v.x); WriteFloat(b, o + 4, v.y); WriteFloat(b, o + 8, v.z); }
    static void WriteVector4(byte[] b, int o, Vector4 v) { WriteFloat(b, o, v.x); WriteFloat(b, o + 4, v.y); WriteFloat(b, o + 8, v.z); WriteFloat(b, o + 12, v.w); }

    static byte[] ReadInput(Profile p, string name, int vertex, int bytes)
    {
        Layout l = p.layout.First(x => x.name == name); StreamRef s = p.streams.First(x => x.slot == l.slot); byte[] raw = ReadFile(s.file.file); int o = (s.constant ? 0 : vertex * s.sourceStride) + l.offset; if (o < 0 || o + bytes > raw.Length) throw new IndexOutOfRangeException("EID" + p.eid + " " + name + " read " + o + "+" + bytes + " exceeds " + raw.Length); byte[] r = new byte[bytes]; Buffer.BlockCopy(raw, o, r, 0, bytes); return r;
    }
    static void CopyInput(Profile p, string name, int vertex, byte[] dst, int dstOffset, int bytes) { byte[] x = ReadInput(p, name, vertex, bytes); Buffer.BlockCopy(x, 0, dst, dstOffset, bytes); }
    static byte[] ReadCB(Profile p, string stage, string name) { ConstantRef[] a = stage == "VS" ? p.constantBuffers.VS : p.constantBuffers.PS; ConstantRef cb = a.FirstOrDefault(x => x.name == name); if (cb == null) throw new InvalidDataException("EID" + p.eid + " missing " + stage + " " + name); return ReadFile(cb.file.file); }
    static byte[] ReadFile(FileRef f) => ReadFile(f.file);
    static byte[] ReadFile(string rel) { string path = Absolute(Root + "/" + rel); if (!RawCache.TryGetValue(path, out byte[] b)) { b = File.ReadAllBytes(path); RawCache[path] = b; } return b; }

    static void ApplyInstanceOverlay(Material m, Profile p, int instance)
    {
        byte[] overlay = ReadCB(p, "PS", "uniforms20");
        int o = instance * 256;
        m.SetVector("_InstanceStateYZ", new Vector4(ReadFloat(overlay, o + 68), ReadFloat(overlay, o + 72), 0, 0));
        m.SetVector("_InstanceChild5", ReadVector4(overlay, o + 176));
        m.SetVector("_InstanceChild6", ReadVector4(overlay, o + 192));
        m.SetVector("_InstanceChild8", ReadVector4(overlay, o + 224));
        EditorUtility.SetDirty(m);
    }

    static Matrix4x4 ReadInstanceMatrix(Profile p, int instance)
    {
        byte[] b = ReadCB(p, "VS", "uniforms27"); int o = instance * 256; Matrix4x4 m = Matrix4x4.identity; for (int c = 0; c < 4; ++c) for (int r = 0; r < 4; ++r) m[r, c] = ReadFloat(b, o + (c * 4 + r) * 4); return m;
    }
    static void ApplyWorldMatrix(Transform t, Matrix4x4 m)
    {
        Vector3 x = m.GetColumn(0), y = m.GetColumn(1), z = m.GetColumn(2), p = m.GetColumn(3); float sx = x.magnitude, sy = y.magnitude, sz = z.magnitude; if (sx < 1e-7f || sy < 1e-7f || sz < 1e-7f) { t.SetPositionAndRotation(p, Quaternion.identity); t.localScale = Vector3.one; return; } Vector3 scale = new Vector3(sx, sy, sz); if (Vector3.Dot(Vector3.Cross(x / sx, y / sy), z / sz) < 0f) scale.z = -scale.z; t.SetPositionAndRotation(p, Quaternion.LookRotation(z / sz, y / sy)); t.localScale = scale;
    }

    static void ConfigureTextures(Manifest m, StringBuilder report)
    {
        int unique = 0;
        foreach (TextureDatabaseEntry e in m.textureDatabase)
        {
            if (!e.uniqueMaterial) continue;
            string path = null;
            if (!string.IsNullOrEmpty(e.exportedAsset))
                path = e.exportedAsset.StartsWith("Assets/", StringComparison.OrdinalIgnoreCase) ? e.exportedAsset : Root + "/" + e.exportedAsset;
            if (string.IsNullOrEmpty(path) || !File.Exists(Absolute(path))) continue;
            if (!path.StartsWith(Root, StringComparison.OrdinalIgnoreCase)) continue;
            AssetDatabase.ImportAsset(path, ImportAssetOptions.ForceSynchronousImport);
            bool srgb = e.format != null && e.format.IndexOf("SRGB", StringComparison.OrdinalIgnoreCase) >= 0;
            TextureImporter ti = AssetImporter.GetAtPath(path) as TextureImporter;
            if (ti != null)
            {
                ti.sRGBTexture = srgb;
                ti.textureType = TextureImporterType.Default;
                ti.mipmapEnabled = e.mips > 1;
                ti.wrapMode = TextureWrapMode.Repeat;
                ti.filterMode = FilterMode.Bilinear;
                ti.SaveAndReimport();
            }
            else
            {
                string absMeta = Absolute(path + ".meta");
                if (File.Exists(absMeta))
                {
                    string text = File.ReadAllText(absMeta);
                    string want = "sRGBTexture: " + (srgb ? "1" : "0");
                    string next = System.Text.RegularExpressions.Regex.Replace(text, @"sRGBTexture: [01]", want);
                    if (next != text) File.WriteAllText(absMeta, next);
                }
                AssetDatabase.ImportAsset(path, ImportAssetOptions.ForceSynchronousImport);
                report.AppendLine("ihvTexture=" + path + " format=" + e.format + " sRGB=" + srgb);
            }
            unique++;
        }
        report.AppendLine("localUniqueMaterialRIDs=" + unique + " (existing family assets reused when RID already present)");
    }
    static Texture LoadTexture(Profile p, string name)
    {
        int rid = Rid(p, name);
        Texture t = AssetDatabase.LoadAssetAtPath<Texture>(Root + "/TextureDatabase/rid" + rid + ".dds");
        if (t != null) return t;
        var candidates = new List<string>();
        if (currentManifest != null && currentManifest.textureDatabase != null)
        {
            TextureDatabaseEntry e = currentManifest.textureDatabase.FirstOrDefault(x => x.rid == rid);
            if (e != null)
            {
                if (!string.IsNullOrEmpty(e.exportedAsset))
                    candidates.Add(e.exportedAsset.StartsWith("Assets/", StringComparison.OrdinalIgnoreCase) ? e.exportedAsset : Root + "/" + e.exportedAsset);
                if (e.existingAssets != null) candidates.AddRange(e.existingAssets);
            }
        }
        string[] hits = AssetDatabase.FindAssets("rid" + rid);
        foreach (string guid in hits)
        {
            string pth = AssetDatabase.GUIDToAssetPath(guid);
            if (!string.IsNullOrEmpty(pth)) candidates.Add(pth);
        }
        foreach (string pth in candidates
            .Where(x => !string.IsNullOrEmpty(x) && !x.EndsWith(".meta", StringComparison.OrdinalIgnoreCase) && !x.EndsWith(".raw", StringComparison.OrdinalIgnoreCase))
            .Distinct(StringComparer.OrdinalIgnoreCase)
            .OrderBy(TexturePathRank))
        {
            t = AssetDatabase.LoadAssetAtPath<Texture>(pth);
            if (t != null) return t;
        }
        return null;
    }
    static int TexturePathRank(string path)
    {
        int rank = 0;
        if (path.IndexOf("SelectedMips", StringComparison.OrdinalIgnoreCase) >= 0) rank += 8;
        if (path.IndexOf("_mip0", StringComparison.OrdinalIgnoreCase) >= 0) rank += 4;
        if (path.EndsWith(".tga", StringComparison.OrdinalIgnoreCase)) rank += 2;
        if (!path.EndsWith(".dds", StringComparison.OrdinalIgnoreCase)) rank += 1;
        if (path.IndexOf("/Resources/", StringComparison.OrdinalIgnoreCase) < 0) rank += 1;
        return rank;
    }
    static int Rid(Profile p, string name) { TextureRef t = p.textures.FirstOrDefault(x => x.name == name); return t == null ? 0 : t.rid; }

    static Vector4 ReadVector4(byte[] b, int o) => new Vector4(ReadFloat(b, o), ReadFloat(b, o + 4), ReadFloat(b, o + 8), ReadFloat(b, o + 12));
    static float ReadFloat(byte[] b, int o) => BitConverter.ToSingle(b, o);
    static string FormatShaderMessages(Shader shader)
    {
        ShaderMessage[] msgs = ShaderUtil.GetShaderMessages(shader);
        if (msgs == null || msgs.Length == 0) return "(ShaderUtil.GetShaderMessages returned none)";
        var sb = new StringBuilder();
        foreach (ShaderMessage m in msgs)
            sb.AppendLine(m.severity + " " + m.file + ":" + m.line + " " + m.message);
        return sb.ToString();
    }
    static string Absolute(string path) => Path.Combine(Directory.GetParent(Application.dataPath).FullName, path.Replace('/', Path.DirectorySeparatorChar));
    static void EnsureFolders()
    {
        foreach (string p in new[] {
            Root + "/Runtime", Root + "/Editor", Root + "/Geometry/Meshes", Root + "/Materials", Root + "/Profiles",
            "Validation/ColourPass6_VS230644"
        }) Directory.CreateDirectory(Absolute(p));
    }
}
#endif
