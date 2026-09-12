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
public static class ColourPass8VS209982PS209983BatchImporter
{
    const string Root = "Assets/ColourPass8_VS209982_PS209983_Batch";
    const string ManifestPath = Root + "/VS209982_PS209983_BatchManifest.json";
    const string ShaderPath = Root + "/Shaders/EID209982209983GBuffer.shader";
    const string TargetScene = "Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
    const string TriggerPath = "Validation/ColourPass8Batch/Import.request";
    const string ReportPath = "Validation/ColourPass8Batch/ImportReport.txt";
    const string AuditPath = "Validation/ColourPass8Batch/VertexAttributeAudit.md";
    const string SceneRootName = "ColourPass8_VS209982_PS209983";
    static bool busy;

    [Serializable] sealed class Manifest { public Profile[] profiles; public TextureDatabaseEntry[] textureDatabase; public Statistics statistics; }
    [Serializable] sealed class Statistics { public int eids, instances, vertices, triangles, layoutVariants, uniqueTextureRIDs, newTextureExports; }
    [Serializable] sealed class Profile
    {
        public int eid, vs, ps, sourceIndexStride, sourceIndexMin, sourceIndexMax, vertexCount, triangleCount;
        public string shaderFamily;
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
    [Serializable] sealed class TextureRef { public int index, binding, rid, width, height, mips, arraySize; public string name, format; }
    [Serializable] sealed class TextureDatabaseEntry { public int rid, width, height, mips, arraySize; public string name, format, exportedAsset; public string[] existingAssets; }
    [Serializable] sealed class ReadWriteStages { public BufferRef[] VS; }
    [Serializable] sealed class BufferRef { public int index, binding, rid, offset, size; public string name, sha256; public FileRef file; }

    static readonly Dictionary<string, byte[]> RawCache = new Dictionary<string, byte[]>(StringComparer.OrdinalIgnoreCase);

    static ColourPass8VS209982PS209983BatchImporter() { EditorApplication.update += Poll; }
    static void Poll()
    {
        if (busy || EditorApplication.isCompiling || EditorApplication.isUpdating) return;
        string f = Absolute(TriggerPath);
        if (!File.Exists(f)) return;
        File.Delete(f);
        try { ImportAll(); }
        catch (Exception e) { File.WriteAllText(Absolute(ReportPath), "FAIL\n" + e, Encoding.UTF8); Debug.LogException(e); }
    }

    [MenuItem("Tools/Colour Pass 8/Import EID 8.1-8.18 (VS209982 PS209983)")]
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
            Manifest manifest = JsonUtility.FromJson<Manifest>(File.ReadAllText(Absolute(ManifestPath), Encoding.UTF8));
            if (manifest == null || manifest.profiles == null || manifest.profiles.Length != 18) throw new InvalidDataException("Manifest must contain exactly 18 profiles.");
            Shader shader = AssetDatabase.LoadAssetAtPath<Shader>(ShaderPath);
            if (shader == null) throw new FileNotFoundException("Shader asset missing", ShaderPath);
            if (ShaderUtil.ShaderHasError(shader)) throw new InvalidOperationException("VS209982/PS209983 shader has compile errors before import.");

            ConfigureTextures(manifest, report);
            AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
            var generated = new Dictionary<int, Generated>();
            var meshByGeometry = new Dictionary<string, Mesh>(StringComparer.Ordinal);
            foreach (Profile profile in manifest.profiles.OrderBy(x => x.eid))
            {
                ValidateProfile(profile);
                string geometryKey = GeometryKey(profile);
                Mesh mesh;
                if (!meshByGeometry.TryGetValue(geometryKey, out mesh))
                {
                    mesh = CreateMesh(profile, audit);
                    meshByGeometry.Add(geometryKey, mesh);
                }
                else audit.AppendLine("## EID " + profile.eid + "\n- Mesh reused by SHA-256 geometry key: `" + mesh.name + "`\n");
                Material material = CreateMaterial(profile, shader, report);
                EID209982DrawProfile asset = CreateProfileAsset(profile, mesh, material);
                generated[profile.eid] = new Generated { mesh = mesh, material = material, profile = asset };
            }
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
            BuildScene(manifest, generated, report);
            Validate(manifest, generated, report, audit);
            File.WriteAllText(Absolute(ReportPath), report.ToString(), Encoding.UTF8);
            File.WriteAllText(Absolute(AuditPath), audit.ToString(), Encoding.UTF8);
            Debug.Log("[ColourPass8] VS209982/PS209983 import completed: 18 EIDs, " + manifest.profiles.Sum(x => x.draw.instanceCount) + " instances.");
        }
        finally { busy = false; }
    }

    sealed class Generated { public Mesh mesh; public Material material; public EID209982DrawProfile profile; }

    static void ValidateProfile(Profile p)
    {
        if (p.vs != 209982 || p.ps != 209983) throw new InvalidDataException("EID" + p.eid + " shader family mismatch.");
        if (p.layout == null || p.layout.Length != 9) throw new InvalidDataException("EID" + p.eid + " must expose all 9 RenderDoc VS inputs.");
        string[] required = { "_input0", "_input1", "_input2", "_input3", "_input4", "_input5", "_input6", "_input7", "_input8" };
        foreach (string name in required) if (p.layout.All(x => x.name != name)) throw new InvalidDataException("EID" + p.eid + " missing " + name);
        if (p.files == null || p.files.indices == null || string.IsNullOrEmpty(p.files.indices.file)) throw new InvalidDataException("EID" + p.eid + " index file missing.");
        if (p.streams == null || p.streams.Length == 0) throw new InvalidDataException("EID" + p.eid + " streams missing.");
        foreach (StreamRef s in p.streams) if (s.file == null || !File.Exists(Absolute(Root + "/" + s.file.file))) throw new FileNotFoundException("EID" + p.eid + " stream missing: slot " + s.slot);
    }

    static Mesh CreateMesh(Profile p, StringBuilder audit)
    {
        int count = p.vertexCount;
        byte[] stream0 = new byte[count * 16];
        byte[] stream1 = new byte[count * 24];
        byte[] stream2 = new byte[count * 16];

        for (int v = 0; v < count; ++v)
        {
            byte[] pos = ReadInput(p, "_input0", v, 12);
            byte[] packed = ReadInput(p, "_input1", v, 4);
            Buffer.BlockCopy(pos, 0, stream0, v * 16, 12);
            Buffer.BlockCopy(packed, 0, stream0, v * 16 + 12, 4);
            CopyInput(p, "_input4", v, stream1, v * 24 + 0, 8);
            CopyInput(p, "_input5", v, stream1, v * 24 + 8, 8);
            CopyInput(p, "_input6", v, stream1, v * 24 + 16, 8);
            CopyInput(p, "_input2", v, stream2, v * 16 + 0, 4);
            CopyInput(p, "_input3", v, stream2, v * 16 + 4, 4);
            CopyInput(p, "_input7", v, stream2, v * 16 + 8, 4);
            CopyInput(p, "_input8", v, stream2, v * 16 + 12, 4);

        }

        byte[] idxBytes = ReadFile(p.files.indices.file);
        uint[] indices32 = new uint[p.draw.indexCount];
        for (int i = 0; i < indices32.Length; ++i) indices32[i] = BitConverter.ToUInt32(idxBytes, i * 4);

        string path = Root + "/Geometry/Meshes/EID" + p.eid + "_VSInput.asset";
        Mesh old = AssetDatabase.LoadAssetAtPath<Mesh>(path);
        if (old != null) AssetDatabase.DeleteAsset(path);
        var mesh = new Mesh { name = Path.GetFileNameWithoutExtension(path) };
        if (count > 65535) mesh.indexFormat = IndexFormat.UInt32;
        var desc = new[]
        {
            new VertexAttributeDescriptor(VertexAttribute.Position, VertexAttributeFormat.Float32, 3, 0),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord6, VertexAttributeFormat.Float32, 1, 0),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord0, VertexAttributeFormat.Float32, 2, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord1, VertexAttributeFormat.Float32, 2, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord2, VertexAttributeFormat.Float32, 2, 1),
            new VertexAttributeDescriptor(VertexAttribute.Color, VertexAttributeFormat.UNorm8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord3, VertexAttributeFormat.UNorm8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord4, VertexAttributeFormat.UNorm8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.BlendIndices, VertexAttributeFormat.UInt8, 4, 2),
        };
        mesh.SetVertexBufferParams(count, desc);
        mesh.SetVertexBufferData(stream0, 0, 0, stream0.Length, 0, MeshUpdateFlags.DontRecalculateBounds | MeshUpdateFlags.DontValidateIndices);
        mesh.SetVertexBufferData(stream1, 0, 0, stream1.Length, 1, MeshUpdateFlags.DontRecalculateBounds | MeshUpdateFlags.DontValidateIndices);
        mesh.SetVertexBufferData(stream2, 0, 0, stream2.Length, 2, MeshUpdateFlags.DontRecalculateBounds | MeshUpdateFlags.DontValidateIndices);
        mesh.SetIndexBufferParams(indices32.Length, IndexFormat.UInt32);
        mesh.SetIndexBufferData(indices32, 0, 0, indices32.Length, MeshUpdateFlags.DontRecalculateBounds | MeshUpdateFlags.DontValidateIndices);
        mesh.subMeshCount = 1;
        mesh.SetSubMesh(0, new SubMeshDescriptor(0, indices32.Length, MeshTopology.Triangles), MeshUpdateFlags.DontRecalculateBounds | MeshUpdateFlags.DontValidateIndices);
        mesh.RecalculateBounds();
        AssetDatabase.CreateAsset(mesh, path);

        audit.AppendLine("## EID " + p.eid);
        audit.AppendLine("- Vertices: `" + p.vertexCount + "`; Indices: `" + p.draw.indexCount + "`; Instances: `" + p.draw.instanceCount + "`");
        audit.AppendLine("- Unity native streams: `Position Float32x3 + packedBasis TexCoord6 Float32x1`, `UV0/1/2 Float32x2`, `input2/input3/input7 UNorm8x4`, `input8 UInt8x4`");
        audit.AppendLine("- Captured layout: `" + string.Join("; ", p.layout.Select(x => x.name + "=slot" + x.slot + "+" + x.offset + " " + x.format.name)) + "`");
        return mesh;
    }

    static Material CreateMaterial(Profile p, Shader shader, StringBuilder report)
    {
        string path = Root + "/Materials/EID" + p.eid + "_VS209982_PS209983.mat";
        Material m = AssetDatabase.LoadAssetAtPath<Material>(path);
        if (m == null) { m = new Material(shader); AssetDatabase.CreateAsset(m, path); }
        m.shader = shader; m.name = Path.GetFileNameWithoutExtension(path);
        byte[] local = ReadCB(p, "PS", "uniforms36");
        if (local.Length != 400) throw new InvalidDataException("EID" + p.eid + " PS uniforms36 expected 400 bytes, got " + local.Length);
        for (int i = 0; i < 25; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));
        byte[] meta = ReadCB(p, "PS", "uniforms38");
        m.SetVector("_InstanceMeta", ReadVector4(meta, 0));
        byte[] states = ReadCB(p, "PS", "uniforms23");
        m.SetVector("_InstanceStateYZ", new Vector4(ReadFloat(states, 68), ReadFloat(states, 72), 0, 0));
        byte[] globals = ReadCB(p, "PS", "uniforms20");
        m.SetFloat("_EID209983MipBias", ReadFloat(globals, 416));
        Texture baseTex = LoadTexture(p, "res31");
        Texture normalTex = LoadTexture(p, "res33");
        if (baseTex == null || normalTex == null) throw new FileNotFoundException("EID" + p.eid + " res31/res33 texture binding is incomplete.");
        m.SetTexture("_Res31", baseTex); m.SetTexture("_Res33", normalTex);
        EditorUtility.SetDirty(m);
        report.AppendLine("EID" + p.eid + ": material res31=RID" + Rid(p, "res31") + " res33=RID" + Rid(p, "res33") + " PS uniforms36=400B");
        return m;
    }

    static EID209982DrawProfile CreateProfileAsset(Profile p, Mesh mesh, Material material)
    {
        string path = Root + "/Profiles/EID" + p.eid + "_DrawProfile.asset";
        EID209982DrawProfile d = AssetDatabase.LoadAssetAtPath<EID209982DrawProfile>(path);
        if (d == null) { d = ScriptableObject.CreateInstance<EID209982DrawProfile>(); AssetDatabase.CreateAsset(d, path); }
        d.name = Path.GetFileNameWithoutExtension(path); d.eventId = p.eid; d.geometryKey = GeometryKey(p); d.indexCount = p.draw.indexCount; d.instanceCount = p.draw.instanceCount; d.vertexCount = p.vertexCount; d.triangleCount = p.triangleCount; d.sourceIndexStride = p.sourceIndexStride; d.sourceIndexMin = p.sourceIndexMin; d.sourceIndexMax = p.sourceIndexMax; d.shaderFamily = p.shaderFamily; 
        d.vertexInputLayout = p.layout.Select(x => x.name + " slot=" + x.slot + " offset=" + x.offset + " format=" + x.format.name).ToArray();
        d.sourceStreams = p.streams.Select(x => "slot=" + x.slot + " stride=" + x.sourceStride + " file=" + x.file.file).ToArray();
        d.indexSource = p.files.sourceIndices.file; d.vsConstantSources = string.Join(";", p.constantBuffers.VS.Select(x => x.name + "=" + x.file.file)); d.psConstantSources = string.Join(";", p.constantBuffers.PS.Select(x => x.name + "=" + x.file.file)); d.textureBindings = string.Join(";", p.textures.Select(x => x.name + "=RID" + x.rid));
        d.capturedInstanceMatrices = Enumerable.Range(0, p.draw.instanceCount).Select(i => ReadInstanceMatrix(p, i)).ToArray(); d.material = material; d.mesh = mesh; EditorUtility.SetDirty(d); return d;
    }

    static void BuildScene(Manifest manifest, Dictionary<int, Generated> generated, StringBuilder report)
    {
        Scene scene = EditorSceneManager.OpenScene(TargetScene, OpenSceneMode.Single);
        GameObject old = scene.GetRootGameObjects().FirstOrDefault(x => x.name == SceneRootName);
        if (old != null) UnityEngine.Object.DestroyImmediate(old);
        GameObject root = new GameObject(SceneRootName);
        foreach (Profile p in manifest.profiles.OrderBy(x => x.eid))
        {
            GameObject eidRoot = new GameObject("EID" + p.eid); eidRoot.transform.SetParent(root.transform, false);
            Generated g = generated[p.eid];
            for (int i = 0; i < p.draw.instanceCount; ++i)
            {
                GameObject go = new GameObject("EID" + p.eid + "_instance_" + i.ToString("000")); go.transform.SetParent(eidRoot.transform, false);
                MeshFilter mf = go.AddComponent<MeshFilter>(); mf.sharedMesh = g.mesh;
                MeshRenderer mr = go.AddComponent<MeshRenderer>(); mr.sharedMaterial = g.material; mr.shadowCastingMode = ShadowCastingMode.Off; mr.receiveShadows = false; mr.motionVectorGenerationMode = MotionVectorGenerationMode.ForceNoMotion;
                byte[] states = ReadCB(p, "PS", "uniforms23");
                var block = new MaterialPropertyBlock();
                block.SetVector("_InstanceStateYZ", new Vector4(ReadFloat(states, i * 256 + 68), ReadFloat(states, i * 256 + 72), 0, 0));
                mr.SetPropertyBlock(block);
                ApplyWorldMatrix(go.transform, ReadInstanceMatrix(p, i));
            }
        }
        EditorSceneManager.MarkSceneDirty(scene); EditorSceneManager.SaveScene(scene);
        report.AppendLine("scene=" + TargetScene); report.AppendLine("sceneRoot=" + SceneRootName); report.AppendLine("sceneRenderers=" + manifest.profiles.Sum(x => x.draw.instanceCount));
    }

    static void Validate(Manifest manifest, Dictionary<int, Generated> generated, StringBuilder report, StringBuilder audit)
    {
        int instances = manifest.profiles.Sum(x => x.draw.instanceCount);
        if (instances != 52) throw new InvalidDataException("8.1-8.18 instance total expected 52, got " + instances);
        if (manifest.profiles.Select(x => LayoutKey(x)).Distinct().Count() != 3) throw new InvalidDataException("Expected 3 captured vertex layout variants.");
        if (generated.Values.Select(x => x.mesh).Distinct().Count() != 18) throw new InvalidDataException("Expected 18 unique meshes after geometry reuse.");
        foreach (Profile p in manifest.profiles)
        {
            Generated g = generated[p.eid];
            if (g.mesh == null || g.mesh.vertexCount != p.vertexCount) throw new InvalidDataException("EID" + p.eid + " persisted mesh mismatch.");
            if (g.mesh.GetIndexCount(0) != (uint)p.draw.indexCount) throw new InvalidDataException("EID" + p.eid + " persisted index count mismatch.");
            VertexAttributeDescriptor[] attributes = g.mesh.GetVertexAttributes();
            RequireAttribute(p.eid, attributes, VertexAttribute.Position, VertexAttributeFormat.Float32, 3);
            RequireAttribute(p.eid, attributes, VertexAttribute.TexCoord6, VertexAttributeFormat.Float32, 1);
            RequireAttribute(p.eid, attributes, VertexAttribute.TexCoord0, VertexAttributeFormat.Float32, 2);
            RequireAttribute(p.eid, attributes, VertexAttribute.TexCoord1, VertexAttributeFormat.Float32, 2);
            RequireAttribute(p.eid, attributes, VertexAttribute.TexCoord2, VertexAttributeFormat.Float32, 2);
            RequireAttribute(p.eid, attributes, VertexAttribute.Color, VertexAttributeFormat.UNorm8, 4);
            RequireAttribute(p.eid, attributes, VertexAttribute.TexCoord3, VertexAttributeFormat.UNorm8, 4);
            RequireAttribute(p.eid, attributes, VertexAttribute.TexCoord4, VertexAttributeFormat.UNorm8, 4);
            RequireAttribute(p.eid, attributes, VertexAttribute.BlendIndices, VertexAttributeFormat.UInt8, 4);
            if (g.material == null || g.material.shader == null || g.material.shader.name != "EID/URP/VS209982_PS209983_GBuffer") throw new InvalidDataException("EID" + p.eid + " material shader mismatch.");
            byte[] local = ReadCB(p, "PS", "uniforms36");
            for (int i = 0; i < 25; ++i)
                if (!Approximately(g.material.GetVector("_P" + i.ToString("00")), ReadVector4(local, i * 16)))
                    throw new InvalidDataException("EID" + p.eid + " material _P" + i.ToString("00") + " differs from RenderDoc uniforms36.");
            if (g.material.GetTexture("_Res31") != LoadTexture(p, "res31") || g.material.GetTexture("_Res33") != LoadTexture(p, "res33"))
                throw new InvalidDataException("EID" + p.eid + " texture binding differs from RenderDoc RID table.");
        }
        report.AppendLine("profiles=18"); report.AppendLine("instances=52"); report.AppendLine("uniqueMeshes=" + generated.Values.Select(x => x.mesh).Distinct().Count()); report.AppendLine("layoutVariants=3"); report.AppendLine("vertexAttributes=COMPLETE_9_OF_9"); report.AppendLine("resourcePolicy=RID_DEDUPLICATED_MATERIAL_CONSTANTS_PER_EID"); report.AppendLine("materialUniforms=RENDERDOC_EXACT_UNIFORMS36_25_FLOAT4"); report.AppendLine("nativeVertexFormats=PASS"); report.AppendLine("validation=PASS");
        audit.Insert(0, "# VS209982 / PS209983 Vertex Attribute Audit\n\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\n- EIDs: `8.1-8.18 / 18 draws`\n- Layout variants: `3`\n- Rule: RenderDoc source slots are decoded per EID and repacked without changing attribute format or value semantics.\n\n");
    }

    static void RequireAttribute(int eid, VertexAttributeDescriptor[] attributes, VertexAttribute attribute, VertexAttributeFormat format, int dimension)
    {
        if (!attributes.Any(x => x.attribute == attribute && x.format == format && x.dimension == dimension))
            throw new InvalidDataException("EID" + eid + " native vertex declaration missing " + attribute + " " + format + "x" + dimension + ". Actual: " + string.Join(", ", attributes.Select(x => x.attribute + " " + x.format + "x" + x.dimension + " stream" + x.stream)));
    }

    static bool Approximately(Vector4 a, Vector4 b)
    {
        return Mathf.Abs(a.x - b.x) <= 1e-6f && Mathf.Abs(a.y - b.y) <= 1e-6f && Mathf.Abs(a.z - b.z) <= 1e-6f && Mathf.Abs(a.w - b.w) <= 1e-6f;
    }

    static string GeometryKey(Profile p) => p.files.indices.sha256 + "|" + string.Join("|", p.streams.OrderBy(x => x.slot).Select(x => x.slot + ":" + x.file.sha256 + ":" + x.sourceStride + ":" + x.elementCount)) + "|" + LayoutKey(p);
    static string LayoutKey(Profile p) => string.Join("|", p.layout.Select(x => x.slot + ":" + x.offset + ":" + x.format.name));
    static bool HasCapturedSkinning(Profile p)
    {
        if (p.readWriteResources == null || p.readWriteResources.VS == null || p.readWriteResources.VS.Length == 0) return false;
        byte[] cb = ReadCB(p, "VS", "uniforms28"); return (BitConverter.ToUInt32(cb, 76) & 32u) != 0u;
    }

    static void SkinVertex(byte[] instanceCB, byte[] skin, Vector3 p, Vector3 n, Vector4 t, byte[] joints, Vector4 weights, out Vector3 sp, out Vector3 sn, out Vector4 st)
    {
        uint flags = BitConverter.ToUInt32(instanceCB, 76); uint influences = flags & 0xFFFFFFCFu;
        uint baseIndex = BitConverter.ToUInt32(instanceCB, 80) + 3u;
        Vector4 r0 = Vector4.zero, r1 = Vector4.zero, r2 = Vector4.zero;
        int count = influences >= 4 ? 4 : influences >= 2 ? 2 : 1;
        float[] ws = { weights.x, weights.y, weights.z, weights.w };
        if (count == 1) ws[0] = 1f;
        for (int i = 0; i < count; ++i)
        {
            uint b = baseIndex + (uint)joints[i] * 3u;
            r0 += LoadFloat4(skin, b) * ws[i]; r1 += LoadFloat4(skin, b + 1u) * ws[i]; r2 += LoadFloat4(skin, b + 2u) * ws[i];
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
        int o = checked((int)vectorIndex * 16); if (o < 0 || o + 16 > b.Length) throw new IndexOutOfRangeException("Captured skin buffer index " + vectorIndex + " exceeds " + b.Length + " bytes."); return ReadVector4(b, o);
    }

    static void DecodeBasis(uint packed, Vector4 fallback, out Vector3 n, out Vector4 t)
    {
        if ((packed & 0x40000000u) == 0u) { n = new Vector3(BitConverter.ToSingle(BitConverter.GetBytes(packed), 0), 0, 1).normalized; t = fallback; return; }
        int xi = Sign10((packed << 22) >> 22), yi = Sign10((packed << 12) >> 22), zi = Sign10((packed << 2) >> 22);
        n = new Vector3(xi, yi, 0) * 0.001956947147846222f; n.z = 1f - Mathf.Abs(n.x) - Mathf.Abs(n.y);
        if (n.z < 0f) { Vector2 q = new Vector2(1f - Mathf.Abs(n.y), 1f - Mathf.Abs(n.x)); q.x *= n.x >= 0 ? 1 : -1; q.y *= n.y >= 0 ? 1 : -1; n.x = q.x; n.y = q.y; }
        n.Normalize(); Vector3 seed = new Vector3(n.y - n.z, n.z - n.x, n.x - n.y); Vector3 t0 = (seed - Vector3.Dot(seed, n) * n).normalized; float sign = zi < 0 ? -1f : 1f; float enc = 1f - Mathf.Abs(zi) * 0.003913894295692444f; Vector2 r = new Vector2(enc, sign * (1f - Mathf.Abs(enc))).normalized; Vector3 tv = (t0 * r.x + Vector3.Cross(n, t0).normalized * r.y).normalized; t = new Vector4(tv.x, tv.y, tv.z, ((packed >> 31) & 1u) * 2f - 1f);
    }
    static int Sign10(uint v) { int x = (int)v; return x >= 512 ? x - 1024 : x; }

    static byte[] ReadInput(Profile p, string name, int vertex, int bytes)
    {
        Layout l = p.layout.First(x => x.name == name); StreamRef s = p.streams.First(x => x.slot == l.slot); byte[] raw = ReadFile(s.file.file); int o = (s.constant ? 0 : vertex * s.sourceStride) + l.offset; if (o < 0 || o + bytes > raw.Length) throw new IndexOutOfRangeException("EID" + p.eid + " " + name + " read " + o + "+" + bytes + " exceeds " + raw.Length); byte[] r = new byte[bytes]; Buffer.BlockCopy(raw, o, r, 0, bytes); return r;
    }
    static void CopyInput(Profile p, string name, int vertex, byte[] dst, int dstOffset, int bytes) { byte[] x = ReadInput(p, name, vertex, bytes); Buffer.BlockCopy(x, 0, dst, dstOffset, bytes); }
    static byte[] ReadCB(Profile p, string stage, string name) { ConstantRef[] a = stage == "VS" ? p.constantBuffers.VS : p.constantBuffers.PS; ConstantRef cb = a.FirstOrDefault(x => x.name == name); if (cb == null) throw new InvalidDataException("EID" + p.eid + " missing " + stage + " " + name); return ReadFile(cb.file.file); }
    static byte[] ReadFile(FileRef f) => ReadFile(f.file);
    static byte[] ReadFile(string rel) { string path = Absolute(Root + "/" + rel); if (!RawCache.TryGetValue(path, out byte[] b)) { b = File.ReadAllBytes(path); RawCache[path] = b; } return b; }

    static Matrix4x4 ReadInstanceMatrix(Profile p, int instance)
    {
        byte[] b = ReadCB(p, "VS", "uniforms28"); int o = instance * 256; Matrix4x4 m = Matrix4x4.identity; for (int c = 0; c < 4; ++c) for (int r = 0; r < 4; ++r) m[r, c] = ReadFloat(b, o + (c * 4 + r) * 4); return m;
    }
    static void ApplyWorldMatrix(Transform t, Matrix4x4 m)
    {
        Vector3 x = m.GetColumn(0), y = m.GetColumn(1), z = m.GetColumn(2), p = m.GetColumn(3); float sx = x.magnitude, sy = y.magnitude, sz = z.magnitude; if (sx < 1e-7f || sy < 1e-7f || sz < 1e-7f) { t.SetPositionAndRotation(p, Quaternion.identity); t.localScale = Vector3.one; return; } Vector3 scale = new Vector3(sx, sy, sz); if (Vector3.Dot(Vector3.Cross(x / sx, y / sy), z / sz) < 0f) scale.z = -scale.z; t.SetPositionAndRotation(p, Quaternion.LookRotation(z / sz, y / sy)); t.localScale = scale;
    }

    static Manifest activeManifest;
    static void ConfigureTextures(Manifest m, StringBuilder report)
    {
        activeManifest = m;
        int configured = 0, reused = 0;
        foreach (TextureDatabaseEntry e in m.textureDatabase)
        {
            string path = ResolveTexturePath(e);
            if (string.IsNullOrEmpty(path)) continue;
            AssetDatabase.ImportAsset(path, ImportAssetOptions.ForceSynchronousImport);
            TextureImporter ti = AssetImporter.GetAtPath(path) as TextureImporter;
            if (ti != null)
            {
                ti.sRGBTexture = e.format != null && e.format.IndexOf("SRGB", StringComparison.OrdinalIgnoreCase) >= 0;
                ti.textureType = TextureImporterType.Default; ti.mipmapEnabled = e.mips > 1;
                ti.wrapMode = TextureWrapMode.Repeat; ti.filterMode = FilterMode.Bilinear; ti.SaveAndReimport(); configured++;
            }
            if (string.IsNullOrEmpty(e.exportedAsset)) reused++;
        }
        report.AppendLine("uniqueTextureRIDs=" + m.textureDatabase.Length + " configured=" + configured + " reusedExisting=" + reused);
    }
    static string ResolveTexturePath(TextureDatabaseEntry e)
    {
        if (e == null) return null;
        if (!string.IsNullOrEmpty(e.exportedAsset))
        {
            string local = Root + "/" + e.exportedAsset;
            if (File.Exists(Absolute(local))) return local;
        }
        if (e.existingAssets != null)
            foreach (string path in e.existingAssets)
                if (!string.IsNullOrEmpty(path) && !path.EndsWith(".meta", StringComparison.OrdinalIgnoreCase) && File.Exists(Absolute(path)))
                    return path;
        return null;
    }
    static Texture LoadTexture(Profile p, string name)
    {
        int rid = Rid(p, name);
        TextureDatabaseEntry e = activeManifest != null ? activeManifest.textureDatabase.FirstOrDefault(x => x.rid == rid) : null;
        string path = ResolveTexturePath(e);
        return string.IsNullOrEmpty(path) ? null : AssetDatabase.LoadAssetAtPath<Texture>(path);
    }
    static int Rid(Profile p, string name) { TextureRef t = p.textures.FirstOrDefault(x => x.name == name); return t == null ? 0 : t.rid; }

    static Vector4 DecodeUNorm4(byte[] b) => new Vector4(b[0] / 255f, b[1] / 255f, b[2] / 255f, b[3] / 255f);
    static Vector4 ReadVector4(byte[] b, int o) => new Vector4(ReadFloat(b, o), ReadFloat(b, o + 4), ReadFloat(b, o + 8), ReadFloat(b, o + 12));
    static float ReadFloat(byte[] b, int o) => BitConverter.ToSingle(b, o);
    static void WriteFloat(byte[] b, int o, float v) { byte[] x = BitConverter.GetBytes(v); Buffer.BlockCopy(x, 0, b, o, 4); }
    static void WriteVector3(byte[] b, int o, Vector3 v) { WriteFloat(b, o, v.x); WriteFloat(b, o + 4, v.y); WriteFloat(b, o + 8, v.z); }
    static void WriteVector4(byte[] b, int o, Vector4 v) { WriteFloat(b, o, v.x); WriteFloat(b, o + 4, v.y); WriteFloat(b, o + 8, v.z); WriteFloat(b, o + 12, v.w); }
    static string Absolute(string path) => Path.Combine(Directory.GetParent(Application.dataPath).FullName, path.Replace('/', Path.DirectorySeparatorChar));
    static void EnsureFolders() { foreach (string p in new[] { Root + "/Runtime", Root + "/Editor", Root + "/Geometry/Meshes", Root + "/Materials", Root + "/Profiles", "Validation/ColourPass8Batch" }) Directory.CreateDirectory(Absolute(p)); }
}
#endif




