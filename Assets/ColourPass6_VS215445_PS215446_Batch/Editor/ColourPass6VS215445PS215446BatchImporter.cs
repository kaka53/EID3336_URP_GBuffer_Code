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
public static class ColourPass6VS215445PS215446BatchImporter
{
    const string Root = "Assets/ColourPass6_VS215445_PS215446_Batch";
    const string ManifestPath = Root + "/VS215445_PS215446_BatchManifest.json";
    const string ShaderPath = Root + "/Shaders/EID215445215446GBuffer.shader";
    const string TargetScene = "Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
    const string TriggerPath = "Validation/ColourPass6_VS215445/Import.request";
    const string ReportPath = "Validation/ColourPass6_VS215445/ImportReport.txt";
    const string AuditPath = "Validation/ColourPass6_VS215445/VertexAttributeAudit.md";
    const string SceneRootName = "ColourPass6_VS215445_PS215446";
    static readonly int[] ExpectedEIDs = { 1632, 1637, 1687 };
    static readonly int ExpectedInstances = 3;
    static readonly int ExpectedLayoutVariants = 3;
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
        public Raster raster;
        public int[] instanceFlags;
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
    [Serializable] sealed class Raster { public string cullMode, fillMode, depthFunction; public bool frontCCW, depthWrites; public int stencilRef, blendCount; public bool blend0Enabled; }

    static readonly Dictionary<string, byte[]> RawCache = new Dictionary<string, byte[]>(StringComparer.OrdinalIgnoreCase);
    static Manifest currentManifest;

    static ColourPass6VS215445PS215446BatchImporter() { EditorApplication.update += Poll; }
    static void Poll()
    {
        if (busy || EditorApplication.isCompiling || EditorApplication.isUpdating) return;
        string f = Absolute(TriggerPath);
        if (!File.Exists(f)) return;
        File.Delete(f);
        try { ImportAll(); }
        catch (Exception e) { File.WriteAllText(Absolute(ReportPath), "FAIL\n" + e, Encoding.UTF8); Debug.LogException(e); }
    }

    [MenuItem("Tools/Colour Pass 6/Import EID 26.1-26.3 (VS215445 PS215446)")]
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
                throw new InvalidDataException("Manifest must contain exactly " + ExpectedEIDs.Length + " profiles for 26.1-26.3.");
            int[] got = manifest.profiles.Select(x => x.eid).OrderBy(x => x).ToArray();
            if (!got.SequenceEqual(ExpectedEIDs.OrderBy(x => x)))
                throw new InvalidDataException("Expected EIDs 26.1-26.3, got " + string.Join(",", got));
            Shader shader = AssetDatabase.LoadAssetAtPath<Shader>(ShaderPath);
            if (shader == null) throw new FileNotFoundException("Shader asset missing", ShaderPath);
            if (ShaderUtil.ShaderHasError(shader))
                throw new InvalidOperationException("VS215445/PS215446 shader has compile errors before import.\n" + FormatShaderMessages(shader));

            ConfigureTextures(manifest, report);
            AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
            var meshes = new Dictionary<string, Mesh>(StringComparer.OrdinalIgnoreCase);
            var generated = new Dictionary<int, Generated>();
            foreach (Profile profile in manifest.profiles.OrderBy(x => x.eid))
            {
                ValidateProfile(profile);
                Mesh mesh = GetOrCreateMesh(profile, meshes, audit);
                Material material = CreateMaterial(profile, shader, report);
                EID215445DrawProfile asset = CreateProfileAsset(profile, mesh, material);
                generated[profile.eid] = new Generated { mesh = mesh, material = material, profile = asset };
            }
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
            BuildScene(manifest, generated, report);
            Validate(manifest, generated, report, audit);
            File.WriteAllText(Absolute(ReportPath), report.ToString(), Encoding.UTF8);
            File.WriteAllText(Absolute(AuditPath), audit.ToString(), Encoding.UTF8);
            Debug.Log("[ColourPass6] VS215445/PS215446 import completed: " + manifest.profiles.Length + " EIDs, " + manifest.profiles.Sum(x => x.draw.instanceCount) + " instances.");
        }
        finally { busy = false; currentManifest = null; }
    }

    sealed class Generated { public Mesh mesh; public Material material; public EID215445DrawProfile profile; }

    static void ValidateProfile(Profile p)
    {
        if (p.vs != 215445 || p.ps != 215446) throw new InvalidDataException("EID" + p.eid + " shader family mismatch.");
        if (p.layout == null || p.layout.Length != 6) throw new InvalidDataException("EID" + p.eid + " must expose all 6 RenderDoc VS inputs.");
        string[] required = { "_input0", "_input1", "_input2", "_input4", "_input5", "_input6" };
        foreach (string name in required) if (p.layout.All(x => x.name != name)) throw new InvalidDataException("EID" + p.eid + " missing " + name);
        if (p.files == null || p.files.indices == null || string.IsNullOrEmpty(p.files.indices.file)) throw new InvalidDataException("EID" + p.eid + " index file missing.");
        if (p.streams == null || p.streams.Length == 0) throw new InvalidDataException("EID" + p.eid + " streams missing.");
        foreach (StreamRef s in p.streams) if (s.file == null || !File.Exists(Absolute(Root + "/" + s.file.file))) throw new FileNotFoundException("EID" + p.eid + " stream missing: slot " + s.slot);
        if (Rid(p, "res27") == 0)
            throw new InvalidDataException("EID" + p.eid + " missing material slot res27.");
        byte[] local = ReadCB(p, "PS", "uniforms26");
        if (local.Length < 320) throw new InvalidDataException("EID" + p.eid + " PS uniforms26 expected 320 bytes, got " + local.Length);
        byte[] inst = ReadCB(p, "VS", "uniforms23");
        if (inst.Length < p.draw.instanceCount * 256) throw new InvalidDataException("EID" + p.eid + " VS uniforms23 too small: " + inst.Length);
        byte[] packed = ReadCB(p, "PS", "uniforms21");
        if (packed.Length < p.draw.instanceCount * 256) throw new InvalidDataException("EID" + p.eid + " PS uniforms21 too small: " + packed.Length);
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
        byte[] stream1 = new byte[count * 8];
        byte[] stream2 = new byte[count * 8];
        byte[] stream3 = new byte[count * 12];
        bool bakeSkin = HasCapturedSkinning(p);
        byte[] skin = null;
        if (bakeSkin)
        {
            BufferRef ssbo = FindSkinBuffer(p);
            if (ssbo == null || ssbo.file == null || string.IsNullOrEmpty(ssbo.file.file))
                throw new FileNotFoundException("EID" + p.eid + " captured skin flag is set but ssbo25 file is missing.");
            skin = ReadFile(ssbo.file.file);
        }
        byte[] instanceCB = ReadCB(p, "VS", "uniforms23");

        for (int v = 0; v < count; ++v)
        {
            byte[] pos = ReadInput(p, "_input0", v, 12);
            Vector3 fallbackN = ReadFloat3(p, "_input2", v);
            byte[] packedBytes = BitConverter.GetBytes(BitConverter.ToSingle(BitConverter.GetBytes(fallbackN.x), 0));
            Buffer.BlockCopy(pos, 0, stream0, v * 24, 12);
            WriteFloat(stream0, v * 24 + 12, fallbackN.x);
            WriteFloat(stream0, v * 24 + 16, fallbackN.y);
            WriteFloat(stream0, v * 24 + 20, fallbackN.z);
            CopyInput(p, "_input1", v, stream1, v * 8, 8);
            Vector4 weights = ReadWeights(p, v);
            WriteUNorm8(stream2, v * 8 + 0, weights);
            uint[] joints = ReadJoints(p, v);
            stream2[v * 8 + 4] = (byte)joints[0];
            stream2[v * 8 + 5] = (byte)joints[1];
            stream2[v * 8 + 6] = (byte)joints[2];
            stream2[v * 8 + 7] = (byte)joints[3];

            uint packed = BitConverter.ToUInt32(BitConverter.GetBytes(fallbackN.x), 0);
            Vector3 n = DecodeNormal(packed, fallbackN);
            if (bakeSkin && skin != null)
            {
                Vector3 position = new Vector3(BitConverter.ToSingle(pos, 0), BitConverter.ToSingle(pos, 4), BitConverter.ToSingle(pos, 8));
                SkinVertex(instanceCB, skin, position, n, joints, weights, out Vector3 sp, out Vector3 sn);
                WriteFloat(stream0, v * 24 + 0, sp.x);
                WriteFloat(stream0, v * 24 + 4, sp.y);
                WriteFloat(stream0, v * 24 + 8, sp.z);
                n = sn;
            }
            WriteVector3(stream3, v * 12, n);
        }

        byte[] idxBytes = ReadFile(p.files.indices.file);
        uint[] indices32 = new uint[p.draw.indexCount];
        for (int i = 0; i < indices32.Length; ++i) indices32[i] = BitConverter.ToUInt32(idxBytes, i * 4);

        string path = MeshPath(p.sharedGeometryFromEID != 0 ? p.sharedGeometryFromEID : p.eid);
        Mesh old = AssetDatabase.LoadAssetAtPath<Mesh>(path);
        if (old != null) AssetDatabase.DeleteAsset(path);
        var mesh = new Mesh { name = "EID" + (p.sharedGeometryFromEID != 0 ? p.sharedGeometryFromEID : p.eid) + " VS215445 Complete VSInput" };
        if (count > 65535) mesh.indexFormat = IndexFormat.UInt32;
        var desc = new[]
        {
            new VertexAttributeDescriptor(VertexAttribute.Position, VertexAttributeFormat.Float32, 3, 0),
            new VertexAttributeDescriptor(VertexAttribute.Normal, VertexAttributeFormat.Float32, 3, 0),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord0, VertexAttributeFormat.Float32, 2, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord3, VertexAttributeFormat.UNorm8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.BlendIndices, VertexAttributeFormat.UInt8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord4, VertexAttributeFormat.Float32, 3, 3),
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
        audit.AppendLine("- Unity native streams: `Position Float32x3 + Normal Float32x3 packed _input2 in .x`, `UV0 Float32x2 from _input1`, `input5 weights UNorm8x4`, `input6 UInt8x4`, `TEXCOORD4 baked skinned n`; captured `_input4` previous-pos unused (live Unity VP copies current clip)");
        audit.AppendLine("- Captured layout: `" + string.Join("; ", p.layout.Select(x => x.name + "=slot" + x.slot + "+" + x.offset + " " + x.format.name)) + "`");
        audit.AppendLine("- Captured skinning baked: `" + HasCapturedSkinning(p) + "`; stencil `" + CapturedStencil(p) + "`\n");
        return mesh;
    }

    static Material CreateMaterial(Profile p, Shader shader, StringBuilder report)
    {
        string path = Root + "/Materials/EID" + p.eid + "_VS215445_PS215446.mat";
        Material m = AssetDatabase.LoadAssetAtPath<Material>(path);
        if (m == null) { m = new Material(shader); AssetDatabase.CreateAsset(m, path); }
        m.shader = shader; m.name = "EID" + p.eid + " VS215445 PS215446";
        byte[] local = ReadCB(p, "PS", "uniforms26");
        for (int i = 0; i < 20; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));
        byte[] instanceCB = ReadCB(p, "PS", "uniforms21");
        m.SetVector("_InstancePacked", ReadVector4(instanceCB, 80));
        byte[] globals = ReadCB(p, "PS", "uniforms18");
        m.SetFloat("_EID215446MipBias", ReadFloat(globals, 416));
        m.SetFloat("_UseBakedSkinning", HasCapturedSkinning(p) ? 1f : 0f);
        
        Texture albedo = LoadTexture(p, "res27");
        if (albedo == null)
            throw new FileNotFoundException("EID" + p.eid + " res27 texture binding is incomplete.");
        m.SetTexture("_Res27", albedo);
        EditorUtility.SetDirty(m);
        report.AppendLine("EID" + p.eid + ": material res27=RID" + Rid(p, "res27") + " PS uniforms26=" + local.Length + "B");
        return m;
    }

    static EID215445DrawProfile CreateProfileAsset(Profile p, Mesh mesh, Material material)
    {
        string path = Root + "/Profiles/EID" + p.eid + "_DrawProfile.asset";
        EID215445DrawProfile d = AssetDatabase.LoadAssetAtPath<EID215445DrawProfile>(path);
        if (d == null) { d = ScriptableObject.CreateInstance<EID215445DrawProfile>(); AssetDatabase.CreateAsset(d, path); }
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
        d.capturedStencilRef = CapturedStencil(p);
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
                ApplyInstancePacked(mat, p, i);
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
        if (instances != ExpectedInstances) throw new InvalidDataException("26.1-26.3 instance total expected " + ExpectedInstances + ", got " + instances);
        int layouts = manifest.profiles.Select(LayoutKey).Distinct().Count();
        if (layouts != ExpectedLayoutVariants) throw new InvalidDataException("Expected " + ExpectedLayoutVariants + " captured vertex layout variants, got " + layouts);
        foreach (Profile p in manifest.profiles)
        {
            Generated g = generated[p.eid];
            if (g.mesh == null || g.mesh.vertexCount != p.vertexCount) throw new InvalidDataException("EID" + p.eid + " persisted mesh mismatch.");
            if (g.material == null || g.material.shader == null || g.material.shader.name != "EID/URP/VS215445_PS215446_GBuffer")
                throw new InvalidDataException("EID" + p.eid + " material shader mismatch.");
        }
        report.AppendLine("profiles=" + manifest.profiles.Length);
        report.AppendLine("instances=" + instances);
        report.AppendLine("layoutVariants=" + layouts);
        report.AppendLine("vertexAttributes=COMPLETE_6_OF_6");
        report.AppendLine("resourcePolicy=RID_DEDUPLICATED_UNIQUE_MATERIAL_REUSE_EXISTING_ASSETS");
        report.AppendLine("validation=PASS");
        audit.Insert(0, "# VS215445 / PS215446 Vertex Attribute Audit\n\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\n- EIDs: `26.1-26.3`\n- Layout variants: `" + layouts + "`\n- Shader: live Unity VP; unique res27 albedo; PS uniforms26 320B; Cull Back; ZWrite On; stencil Ref 36; Queue Geometry; packed `_input2` on NORMAL.x oct-only; wrap albedo; skin bake ssbo25 via uniforms23 when bit 32 set\n\n");
    }

    static string LayoutKey(Profile p) => string.Join("|", p.layout.Select(x => x.slot + ":" + x.offset + ":" + x.format.name));
    static int CapturedStencil(Profile p) => p.raster != null ? p.raster.stencilRef : 36;
    static bool HasCapturedSkinning(Profile p)
    {
        byte[] cb = ReadCB(p, "VS", "uniforms23");
        return cb.Length >= 80 && (BitConverter.ToUInt32(cb, 76) & 32u) != 0u;
    }

    static BufferRef FindSkinBuffer(Profile p)
    {
        if (p.readWriteResources == null || p.readWriteResources.VS == null) return null;
        return p.readWriteResources.VS.FirstOrDefault(x => x.name != null && x.name.IndexOf("ssbo", StringComparison.OrdinalIgnoreCase) >= 0)
            ?? p.readWriteResources.VS.FirstOrDefault();
    }

    static Vector4 ReadWeights(Profile p, int vertex)
    {
        Layout l = p.layout.First(x => x.name == "_input5");
        int bytes = Math.Max(4, l.format.compCount * l.format.compByteWidth);
        byte[] raw = ReadInput(p, "_input5", vertex, bytes);
        if (l.format.compByteWidth >= 4)
            return new Vector4(BitConverter.ToSingle(raw, 0), BitConverter.ToSingle(raw, 4), BitConverter.ToSingle(raw, 8), BitConverter.ToSingle(raw, 12));
        if (l.format.compByteWidth >= 2)
            return new Vector4(BitConverter.ToUInt16(raw, 0) / 65535f, BitConverter.ToUInt16(raw, 2) / 65535f, BitConverter.ToUInt16(raw, 4) / 65535f, BitConverter.ToUInt16(raw, 6) / 65535f);
        return DecodeUNorm4(raw);
    }

    static uint[] ReadJoints(Profile p, int vertex)
    {
        Layout l = p.layout.First(x => x.name == "_input6");
        int bytes = Math.Max(4, l.format.compCount * l.format.compByteWidth);
        byte[] raw = ReadInput(p, "_input6", vertex, bytes);
        if (l.format.compByteWidth >= 4)
            return new uint[] { BitConverter.ToUInt32(raw, 0), BitConverter.ToUInt32(raw, 4), BitConverter.ToUInt32(raw, 8), BitConverter.ToUInt32(raw, 12) };
        return new uint[] { raw[0], raw[1], raw[2], raw[3] };
    }

    static Vector3 ReadFloat3(Profile p, string name, int vertex)
    {
        Layout l = p.layout.First(x => x.name == name);
        int bytes = Math.Max(4, l.format.compCount * l.format.compByteWidth);
        byte[] raw = ReadInput(p, name, vertex, bytes);
        float x = BitConverter.ToSingle(raw, 0);
        float y = raw.Length >= 8 ? BitConverter.ToSingle(raw, 4) : 0f;
        float z = raw.Length >= 12 ? BitConverter.ToSingle(raw, 8) : 0f;
        return new Vector3(x, y, z);
    }

    static void SkinVertex(byte[] instanceCB, byte[] skin, Vector3 p, Vector3 n, uint[] joints, Vector4 weights, out Vector3 sp, out Vector3 sn)
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
            uint b = baseIndex + joints[i] * 3u;
            r0 += LoadFloat4(skin, b) * ws[i];
            r1 += LoadFloat4(skin, b + 1u) * ws[i];
            r2 += LoadFloat4(skin, b + 2u) * ws[i];
        }
        Vector4 hp = new Vector4(p.x, p.y, p.z, 1f);
        sp = new Vector3(Vector4.Dot(r0, hp), Vector4.Dot(r1, hp), Vector4.Dot(r2, hp));
        sn = new Vector3(Vector3.Dot(new Vector3(r0.x, r0.y, r0.z), n), Vector3.Dot(new Vector3(r1.x, r1.y, r1.z), n), Vector3.Dot(new Vector3(r2.x, r2.y, r2.z), n)).normalized;
    }

    static Vector4 LoadFloat4(byte[] b, uint vectorIndex)
    {
        int o = checked((int)vectorIndex * 16);
        if (o < 0 || o + 16 > b.Length) throw new IndexOutOfRangeException("Captured skin buffer index " + vectorIndex + " exceeds " + b.Length + " bytes.");
        return ReadVector4(b, o);
    }

    static Vector3 DecodeNormal(uint packed, Vector3 fallback)
    {
        if ((packed & 0x40000000u) == 0u)
            return fallback.sqrMagnitude > 1e-12f ? fallback.normalized : Vector3.up;
        const float k = 0.0019569471478462219f;
        int xi = Sign10((packed << 22) >> 22), yi = Sign10((packed << 12) >> 22);
        Vector3 n = new Vector3(xi, yi, 0f) * k;
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
        return n;
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

    static byte[] ReadInput(Profile p, string name, int vertex, int bytes)
    {
        Layout l = p.layout.First(x => x.name == name); StreamRef s = p.streams.First(x => x.slot == l.slot); byte[] raw = ReadFile(s.file.file); int o = (s.constant ? 0 : vertex * s.sourceStride) + l.offset; if (o < 0 || o + bytes > raw.Length) throw new IndexOutOfRangeException("EID" + p.eid + " " + name + " read " + o + "+" + bytes + " exceeds " + raw.Length); byte[] r = new byte[bytes]; Buffer.BlockCopy(raw, o, r, 0, bytes); return r;
    }
    static void CopyInput(Profile p, string name, int vertex, byte[] dst, int dstOffset, int bytes) { byte[] x = ReadInput(p, name, vertex, bytes); Buffer.BlockCopy(x, 0, dst, dstOffset, bytes); }
    static byte[] ReadCB(Profile p, string stage, string name) { ConstantRef[] a = stage == "VS" ? p.constantBuffers.VS : p.constantBuffers.PS; ConstantRef cb = a.FirstOrDefault(x => x.name == name); if (cb == null) throw new InvalidDataException("EID" + p.eid + " missing " + stage + " " + name); return ReadFile(cb.file.file); }
    static byte[] ReadFile(FileRef f) => ReadFile(f.file);
    static byte[] ReadFile(string rel) { string path = Absolute(Root + "/" + rel); if (!RawCache.TryGetValue(path, out byte[] b)) { b = File.ReadAllBytes(path); RawCache[path] = b; } return b; }

    static void ApplyInstancePacked(Material m, Profile p, int instance)
    {
        byte[] overlay = ReadCB(p, "PS", "uniforms21");
        m.SetVector("_InstancePacked", ReadVector4(overlay, instance * 256 + 80));
        EditorUtility.SetDirty(m);
    }

    static Matrix4x4 ReadInstanceMatrix(Profile p, int instance)
    {
        byte[] b = ReadCB(p, "VS", "uniforms23"); int o = instance * 256; Matrix4x4 m = Matrix4x4.identity; for (int c = 0; c < 4; ++c) for (int r = 0; r < 4; ++r) m[r, c] = ReadFloat(b, o + (c * 4 + r) * 4); return m;
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
            "Validation/ColourPass6_VS215445"
        }) Directory.CreateDirectory(Absolute(p));
    }
}
#endif
