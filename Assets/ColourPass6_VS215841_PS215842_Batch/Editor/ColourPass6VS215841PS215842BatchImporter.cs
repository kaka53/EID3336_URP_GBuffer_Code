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
public static class ColourPass6VS215841PS215842BatchImporter
{
    const string Root = "Assets/ColourPass6_VS215841_PS215842_Batch";
    const string ManifestPath = Root + "/VS215841_PS215842_BatchManifest.json";
    const string ShaderPath = Root + "/Shaders/EID215841215842GBuffer.shader";
    const string TargetScene = "Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
    const string TriggerPath = "Validation/ColourPass6_VS215841/Import.request";
    const string ReportPath = "Validation/ColourPass6_VS215841/ImportReport.txt";
    const string AuditPath = "Validation/ColourPass6_VS215841/VertexAttributeAudit.md";
    const string SceneRootName = "ColourPass6_VS215841_PS215842";
    const string Res31Path = "Assets/EID3332_EID3336_Combined/EID3863_RenderDocVegetation/ImportedTextures/rid210510.asset";
    static readonly int[] ExpectedEIDs = { 3781, 3784, 3787, 3790, 3793, 3796, 3799, 3802, 3805, 3809, 3812, 3816, 3819, 3822, 3825, 3828, 3831, 3835, 3839 };
    static readonly int ExpectedInstances = 10841;
    static readonly int ExpectedLayoutVariants = 1;
    static readonly int ExpectedUniqueMeshes = 5;
    static bool busy;

    [Serializable] sealed class Manifest { public Profile[] profiles; public TextureDatabaseEntry[] textureDatabase; public Statistics statistics; }
    [Serializable] sealed class Statistics { public int eids, instances, vertices, triangles, layoutVariants, uniqueTextureRIDs, newTextureExports, uniqueGeometryBlobs; }
    [Serializable] sealed class Profile
    {
        public int eid, vs, ps, sourceIndexStride, sourceIndexMin, sourceIndexMax, vertexCount, triangleCount, sharedGeometryFromEID, instanceStride;
        public string shaderFamily, meshItem, geometrySha256;
        public Draw draw;
        public Layout[] layout;
        public StreamRef[] streams;
        public FileSet files;
        public FileRef instanceBuffer;
        public ConstantStages constantBuffers;
        public TextureRef[] textures;
        public TextureRef[] vsTextures;
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
    static Manifest currentManifest;

    static ColourPass6VS215841PS215842BatchImporter() { EditorApplication.update += Poll; }
    static void Poll()
    {
        if (busy || EditorApplication.isCompiling || EditorApplication.isUpdating) return;
        string f = Absolute(TriggerPath);
        if (!File.Exists(f)) return;
        File.Delete(f);
        try { ImportAll(); }
        catch (Exception e) { File.WriteAllText(Absolute(ReportPath), "FAIL\n" + e, Encoding.UTF8); Debug.LogException(e); }
    }

    [MenuItem("Tools/Colour Pass 6/Import EID 7.1-7.19 (VS215841 PS215842)")]
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
                throw new InvalidDataException("Manifest must contain exactly " + ExpectedEIDs.Length + " profiles for 7.1-7.19.");
            int[] got = manifest.profiles.Select(x => x.eid).OrderBy(x => x).ToArray();
            if (!got.SequenceEqual(ExpectedEIDs.OrderBy(x => x)))
                throw new InvalidDataException("Expected EIDs 7.1-7.19, got " + string.Join(",", got));
            Shader shader = AssetDatabase.LoadAssetAtPath<Shader>(ShaderPath);
            if (shader == null) throw new FileNotFoundException("Shader asset missing", ShaderPath);
            if (ShaderUtil.ShaderHasError(shader))
                throw new InvalidOperationException("VS215841/PS215842 shader has compile errors before import.\n" + FormatShaderMessages(shader));

            ConfigureTextures(manifest, report);
            AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
            var sourceMeshes = new Dictionary<string, Mesh>(StringComparer.OrdinalIgnoreCase);
            var generated = new Dictionary<int, Generated>();
            foreach (Profile profile in manifest.profiles.OrderBy(x => x.eid))
            {
                ValidateProfile(profile);
                Mesh source = GetOrCreateSourceMesh(profile, sourceMeshes, audit);
                Mesh expanded = CreateExpandedMesh(profile);
                Material material = CreateMaterial(profile, shader, report);
                TextAsset instanceBytes = LoadInstanceBytes(profile);
                EID215841DrawProfile asset = CreateProfileAsset(profile, source, expanded, material, instanceBytes);
                generated[profile.eid] = new Generated { source = source, expanded = expanded, material = material, profile = asset, instanceBytes = instanceBytes };
            }
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
            BuildScene(manifest, generated, report);
            Validate(manifest, generated, sourceMeshes, report, audit);
            File.WriteAllText(Absolute(ReportPath), report.ToString(), Encoding.UTF8);
            File.WriteAllText(Absolute(AuditPath), audit.ToString(), Encoding.UTF8);
            Debug.Log("[ColourPass6] VS215841/PS215842 import completed: " + manifest.profiles.Length + " EIDs, " + manifest.profiles.Sum(x => x.draw.instanceCount) + " instances.");
        }
        finally { busy = false; currentManifest = null; }
    }

    sealed class Generated
    {
        public Mesh source;
        public Mesh expanded;
        public Material material;
        public EID215841DrawProfile profile;
        public TextAsset instanceBytes;
    }

    static void ValidateProfile(Profile p)
    {
        if (p.vs != 215841 || p.ps != 215842) throw new InvalidDataException("EID" + p.eid + " shader family mismatch.");
        if (p.layout == null || p.layout.Length != 5) throw new InvalidDataException("EID" + p.eid + " must expose the 5 RenderDoc VS inputs.");
        string[] required = { "_input0", "_input1", "_input2", "_input4", "_input6" };
        foreach (string name in required) if (p.layout.All(x => x.name != name)) throw new InvalidDataException("EID" + p.eid + " missing " + name);
        if (p.files == null || p.files.indices == null || string.IsNullOrEmpty(p.files.indices.file)) throw new InvalidDataException("EID" + p.eid + " index file missing.");
        if (p.streams == null || p.streams.Length == 0) throw new InvalidDataException("EID" + p.eid + " streams missing.");
        foreach (StreamRef s in p.streams) if (s.file == null || !File.Exists(Absolute(Root + "/" + s.file.file))) throw new FileNotFoundException("EID" + p.eid + " stream missing: slot " + s.slot);
        if (p.instanceBuffer == null || string.IsNullOrEmpty(p.instanceBuffer.file)) throw new InvalidDataException("EID" + p.eid + " instance buffer missing.");
        if (p.instanceStride != 96) throw new InvalidDataException("EID" + p.eid + " instance stride expected 96, got " + p.instanceStride);
        if (Rid(p, "res23") == 0 || Rid(p, "res25") == 0) throw new InvalidDataException("EID" + p.eid + " missing unique material slots res23/res25.");
        byte[] local = ReadCB(p, "PS", "uniforms28");
        if (local.Length < 240) throw new InvalidDataException("EID" + p.eid + " PS uniforms28 expected 240 bytes, got " + local.Length);
        byte[] inst = ReadFile(p.instanceBuffer.file);
        int need = p.draw.instanceCount * 96;
        if (inst.Length < need) throw new InvalidDataException("EID" + p.eid + " instance bytes " + inst.Length + " < " + need);
    }

    static Mesh GetOrCreateSourceMesh(Profile p, Dictionary<string, Mesh> meshes, StringBuilder audit)
    {
        string key = string.IsNullOrEmpty(p.geometrySha256) ? "EID" + p.eid : p.geometrySha256;
        if (meshes.TryGetValue(key, out Mesh existing)) return existing;
        if (p.sharedGeometryFromEID != 0 && p.sharedGeometryFromEID != p.eid)
        {
            string sharedPath = SourceMeshPath(p.sharedGeometryFromEID);
            Mesh shared = AssetDatabase.LoadAssetAtPath<Mesh>(sharedPath);
            if (shared != null) { meshes[key] = shared; return shared; }
        }
        Mesh mesh = CreateSourceMesh(p, audit);
        meshes[key] = mesh;
        return mesh;
    }

    static string SourceMeshPath(int eid) => Root + "/Geometry/Meshes/EID" + eid + "_VSInput.asset";
    static string ExpandedMeshPath(int eid) => Root + "/Geometry/Meshes/EID" + eid + "_Expanded.asset";

    static Mesh CreateSourceMesh(Profile p, StringBuilder audit)
    {
        int count = p.vertexCount;
        byte[] packedStreams = BuildPackedVertices(p);

        byte[] idxBytes = ReadFile(p.files.indices.file);
        uint[] indices32 = new uint[p.draw.indexCount];
        for (int i = 0; i < indices32.Length; ++i) indices32[i] = BitConverter.ToUInt32(idxBytes, i * 4);

        string path = SourceMeshPath(p.sharedGeometryFromEID != 0 ? p.sharedGeometryFromEID : p.eid);
        Mesh old = AssetDatabase.LoadAssetAtPath<Mesh>(path);
        if (old != null) AssetDatabase.DeleteAsset(path);
        var mesh = new Mesh { name = "EID" + (p.sharedGeometryFromEID != 0 ? p.sharedGeometryFromEID : p.eid) + " VS215841 Card" };
        var desc = new[]
        {
            new VertexAttributeDescriptor(VertexAttribute.Position, VertexAttributeFormat.Float32, 4, 0),
            new VertexAttributeDescriptor(VertexAttribute.Color, VertexAttributeFormat.UNorm8, 4, 0),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord0, VertexAttributeFormat.Float32, 2, 0),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord1, VertexAttributeFormat.Float32, 1, 0),
        };
        mesh.SetVertexBufferParams(count, desc);
        mesh.SetVertexBufferData(packedStreams, 0, 0, packedStreams.Length, 0, MeshUpdateFlags.DontRecalculateBounds | MeshUpdateFlags.DontValidateIndices);
        mesh.SetIndexBufferParams(indices32.Length, IndexFormat.UInt32);
        mesh.SetIndexBufferData(indices32, 0, 0, indices32.Length, MeshUpdateFlags.DontRecalculateBounds | MeshUpdateFlags.DontValidateIndices);
        mesh.subMeshCount = 1;
        mesh.SetSubMesh(0, new SubMeshDescriptor(0, indices32.Length, MeshTopology.Triangles), MeshUpdateFlags.DontRecalculateBounds | MeshUpdateFlags.DontValidateIndices);
        mesh.RecalculateBounds();
        AssetDatabase.CreateAsset(mesh, path);

        audit.AppendLine("## EID " + p.eid + " item " + p.meshItem);
        audit.AppendLine("- Source vertices: `" + p.vertexCount + "`; Indices: `" + p.draw.indexCount + "`; Instances: `" + p.draw.instanceCount + "`");
        audit.AppendLine("- Shared geometry from EID: `" + p.sharedGeometryFromEID + "`");
        audit.AppendLine("- Unity native streams: `Position Float32x4 (xyz + packed input1)`, `Color UNorm8x4 input2`, `UV0 Float32x2 input4/input6`, `UV1 Float32 instanceIndex`");
        audit.AppendLine("- Captured layout: `" + string.Join("; ", p.layout.Select(x => x.name + "=slot" + x.slot + "+" + x.offset + " " + x.format.name)) + "`\n");
        return mesh;
    }

    static byte[] BuildPackedVertices(Profile p)
    {
        int count = p.vertexCount;
        byte[] packed = new byte[count * 32];
        for (int v = 0; v < count; ++v)
        {
            byte[] pos = ReadInput(p, "_input0", v, 12);
            byte[] packedBasis = ReadInput(p, "_input1", v, 4);
            Buffer.BlockCopy(pos, 0, packed, v * 32, 12);
            Buffer.BlockCopy(packedBasis, 0, packed, v * 32 + 12, 4);
            CopyInput(p, "_input2", v, packed, v * 32 + 16, 4);
            CopyInput(p, "_input4", v, packed, v * 32 + 20, 8);
            WriteFloat(packed, v * 32 + 28, 0f);
        }
        return packed;
    }

    static Mesh CreateExpandedMesh(Profile p)
    {
        int baseV = p.vertexCount;
        int baseI = p.draw.indexCount;
        int inst = p.draw.instanceCount;
        int count = baseV * inst;
        int indexCount = baseI * inst;

        byte[] srcVerts = BuildPackedVertices(p);
        byte[] idxBytes = ReadFile(p.files.indices.file);
        uint[] srcIdx = new uint[baseI];
        for (int i = 0; i < baseI; ++i) srcIdx[i] = BitConverter.ToUInt32(idxBytes, i * 4);

        byte[] dstVerts = new byte[count * 32];
        uint[] dstIdx = new uint[indexCount];
        for (int i = 0; i < inst; ++i)
        {
            Buffer.BlockCopy(srcVerts, 0, dstVerts, i * baseV * 32, baseV * 32);
            for (int v = 0; v < baseV; ++v)
                WriteFloat(dstVerts, (i * baseV + v) * 32 + 28, i);
            for (int k = 0; k < baseI; ++k)
                dstIdx[i * baseI + k] = srcIdx[k] + (uint)(i * baseV);
        }

        string path = ExpandedMeshPath(p.eid);
        Mesh old = AssetDatabase.LoadAssetAtPath<Mesh>(path);
        if (old != null) AssetDatabase.DeleteAsset(path);
        var mesh = new Mesh { name = "EID" + p.eid + " VS215841 Expanded x" + inst };
        mesh.indexFormat = IndexFormat.UInt32;
        var desc = new[]
        {
            new VertexAttributeDescriptor(VertexAttribute.Position, VertexAttributeFormat.Float32, 4, 0),
            new VertexAttributeDescriptor(VertexAttribute.Color, VertexAttributeFormat.UNorm8, 4, 0),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord0, VertexAttributeFormat.Float32, 2, 0),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord1, VertexAttributeFormat.Float32, 1, 0),
        };
        mesh.SetVertexBufferParams(count, desc);
        mesh.SetVertexBufferData(dstVerts, 0, 0, dstVerts.Length, 0, MeshUpdateFlags.DontRecalculateBounds | MeshUpdateFlags.DontValidateIndices);
        mesh.SetIndexBufferParams(indexCount, IndexFormat.UInt32);
        mesh.SetIndexBufferData(dstIdx, 0, 0, dstIdx.Length, MeshUpdateFlags.DontRecalculateBounds | MeshUpdateFlags.DontValidateIndices);
        mesh.subMeshCount = 1;
        mesh.SetSubMesh(0, new SubMeshDescriptor(0, indexCount, MeshTopology.Triangles), MeshUpdateFlags.DontRecalculateBounds | MeshUpdateFlags.DontValidateIndices);

        byte[] instBytes = ReadFile(p.instanceBuffer.file);
        var bounds = new Bounds(ReadTranslation(instBytes, 0), Vector3.one);
        for (int i = 1; i < inst; ++i) bounds.Encapsulate(ReadTranslation(instBytes, i));
        bounds.Expand(4f);
        mesh.bounds = bounds;
        AssetDatabase.CreateAsset(mesh, path);
        return mesh;
    }

    static Material CreateMaterial(Profile p, Shader shader, StringBuilder report)
    {
        string path = Root + "/Materials/EID" + p.eid + "_VS215841_PS215842.mat";
        Material m = AssetDatabase.LoadAssetAtPath<Material>(path);
        if (m == null) { m = new Material(shader); AssetDatabase.CreateAsset(m, path); }
        m.shader = shader; m.name = "EID" + p.eid + " VS215841 PS215842";
        byte[] local = ReadCB(p, "PS", "uniforms28");
        m.SetFloat("_DoubleSided", ReadFloat(local, 20));
        m.SetFloat("_MaterialClass", ReadFloat(local, 36));
        m.SetFloat("_PackedNormalWeight", ReadFloat(local, 40));
        m.SetFloat("_NormalMaskWeight", ReadFloat(local, 56));
        m.SetFloat("_RoughnessMaskWeight", ReadFloat(local, 60));
        m.SetFloat("_BaseColorReplaceWeight", ReadFloat(local, 80));
        m.SetFloat("_BaseColorMultiplier", ReadFloat(local, 84));
        m.SetFloat("_AlphaCutoff", 0.5f);
        m.SetColor("_BaseColorTint", ReadVector4(local, 128));
        m.SetVector("_OpacityDistanceParams", ReadVector4(local, 144));
        m.SetVector("_MaterialDistanceParams", ReadVector4(local, 160));
        m.SetFloat("_WindHeightScale", ReadFloat(local, 24));
        m.SetFloat("_HeightFadeStart", ReadFloat(local, 224));
        m.SetFloat("_HeightFadeScale", ReadFloat(local, 228));

        byte[] u20 = ReadCB(p, "VS", "uniforms20");
        m.SetFloat("_WindScale", 1f - ReadFloat(u20, 16));
        byte[] u24 = ReadCB(p, "VS", "uniforms24");
        m.SetVector("_MaskExtent", ReadVector4(u24, 2528));
        m.SetVector("_MaskCenter", ReadVector4(u24, 2544));
        m.SetFloat("_EID215842MipBias", ReadFloat(u24, 416));
        Vector4 jitter = ReadVector4(u24, 304);
        m.SetVector("_JitterZW", new Vector4(jitter.z, jitter.w, 0, 0));
        byte[] u30 = ReadCB(p, "PS", "uniforms30");
        m.SetVector("_ViewDir", ReadVector4(u30, 0));
        byte[] u22 = ReadCB(p, "VS", "uniforms22");
        m.SetVector("_CapturedVP0", ReadVector4(u22, 512));
        m.SetVector("_CapturedVP1", ReadVector4(u22, 528));
        m.SetVector("_CapturedVP2", ReadVector4(u22, 544));
        m.SetVector("_CapturedVP3", ReadVector4(u22, 560));
        m.SetVector("_CapturedPrevVP0", ReadVector4(u22, 912));
        m.SetVector("_CapturedPrevVP1", ReadVector4(u22, 928));
        m.SetVector("_CapturedPrevVP2", ReadVector4(u22, 944));
        m.SetVector("_CapturedPrevVP3", ReadVector4(u22, 960));
        m.SetVector("_CapturedCamPos", ReadVector4(u22, 704));
        m.SetVector("_CapturedPrevCamPos", ReadVector4(u22, 1296));
        m.SetVector("_CapturedCamUp", new Vector4(ReadFloat(u22, 80), 0f, ReadFloat(u22, 88), 0f));
        m.SetFloat("_CardVertexCount", p.vertexCount);

        Texture baseTex = LoadTexture(p, "res23");
        Texture normalTex = LoadTexture(p, "res25");
        Texture maskTex = AssetDatabase.LoadAssetAtPath<Texture>(Res31Path);
        if (baseTex == null || normalTex == null || maskTex == null)
            throw new FileNotFoundException("EID" + p.eid + " res23/res25/res31 texture binding is incomplete.");
        m.SetTexture("_Res23", baseTex);
        m.SetTexture("_Res25", normalTex);
        m.SetTexture("_Res31", maskTex);
        EditorUtility.SetDirty(m);
        report.AppendLine("EID" + p.eid + ": material res23=RID" + Rid(p, "res23") + " res25=RID" + Rid(p, "res25") + " res31=RID210510 instances=" + p.draw.instanceCount + " PS uniforms28=" + local.Length + "B");
        return m;
    }

    static TextAsset LoadInstanceBytes(Profile p)
    {
        string path = Root + "/" + p.instanceBuffer.file;
        TextAsset t = AssetDatabase.LoadAssetAtPath<TextAsset>(path);
        if (t == null) throw new FileNotFoundException("EID" + p.eid + " instance TextAsset missing", path);
        return t;
    }

    static EID215841DrawProfile CreateProfileAsset(Profile p, Mesh source, Mesh expanded, Material material, TextAsset instanceBytes)
    {
        string path = Root + "/Profiles/EID" + p.eid + "_DrawProfile.asset";
        EID215841DrawProfile d = AssetDatabase.LoadAssetAtPath<EID215841DrawProfile>(path);
        if (d == null) { d = ScriptableObject.CreateInstance<EID215841DrawProfile>(); AssetDatabase.CreateAsset(d, path); }
        d.name = "EID" + p.eid + " Draw Profile";
        d.eventId = p.eid;
        d.indexCount = p.draw.indexCount;
        d.instanceCount = p.draw.instanceCount;
        d.vertexCount = p.vertexCount;
        d.triangleCount = p.triangleCount;
        d.sourceIndexStride = p.sourceIndexStride;
        d.sourceIndexMin = p.sourceIndexMin;
        d.sourceIndexMax = p.sourceIndexMax;
        d.instanceStride = 96;
        d.shaderFamily = p.shaderFamily;
        d.meshItem = p.meshItem;
        d.sharedGeometryFromEID = p.sharedGeometryFromEID;
        d.vertexInputLayout = p.layout.Select(x => x.name + " slot=" + x.slot + " offset=" + x.offset + " format=" + x.format.name).ToArray();
        d.sourceStreams = p.streams.Select(x => "slot=" + x.slot + " stride=" + x.sourceStride + " file=" + x.file.file).ToArray();
        d.indexSource = p.files.sourceIndices != null ? p.files.sourceIndices.file : "";
        d.instanceSource = p.instanceBuffer.file;
        d.vsConstantSources = string.Join(";", p.constantBuffers.VS.Select(x => x.name + "=" + x.file.file));
        d.psConstantSources = string.Join(";", p.constantBuffers.PS.Select(x => x.name + "=" + x.file.file));
        d.textureBindings = string.Join(";", p.textures.Select(x => x.name + "=RID" + x.rid));
        d.material = material;
        d.sourceMesh = source;
        d.expandedMesh = expanded;
        d.instanceBytes = instanceBytes;
        EditorUtility.SetDirty(d);
        return d;
    }

    static void BuildScene(Manifest manifest, Dictionary<int, Generated> generated, StringBuilder report)
    {
        Scene scene = EditorSceneManager.OpenScene(TargetScene, OpenSceneMode.Single);
        GameObject old = scene.GetRootGameObjects().FirstOrDefault(x => x.name == SceneRootName);
        if (old != null) UnityEngine.Object.DestroyImmediate(old);
        GameObject root = new GameObject(SceneRootName);
        int renderers = 0;
        foreach (Profile p in manifest.profiles.OrderBy(x => x.eid))
        {
            Generated g = generated[p.eid];
            GameObject go = new GameObject("EID" + p.eid);
            go.transform.SetParent(root.transform, false);
            MeshFilter mf = go.AddComponent<MeshFilter>();
            mf.sharedMesh = g.expanded;
            MeshRenderer mr = go.AddComponent<MeshRenderer>();
            mr.sharedMaterial = g.material;
            mr.shadowCastingMode = ShadowCastingMode.Off;
            mr.receiveShadows = false;
            mr.motionVectorGenerationMode = MotionVectorGenerationMode.ForceNoMotion;
            mr.lightProbeUsage = LightProbeUsage.Off;
            mr.reflectionProbeUsage = ReflectionProbeUsage.Off;
            mr.allowOcclusionWhenDynamic = false;
            EID215841InstanceBinder binder = go.AddComponent<EID215841InstanceBinder>();
            binder.profile = g.profile;
            binder.material = g.material;
            binder.expandedMesh = g.expanded;
            binder.Bind();
            EditorUtility.SetDirty(mr);
            EditorUtility.SetDirty(binder);
            renderers++;
        }
        EditorSceneManager.MarkSceneDirty(scene);
        EditorSceneManager.SaveScene(scene);
        report.AppendLine("scene=" + TargetScene);
        report.AppendLine("sceneRoot=" + SceneRootName);
        report.AppendLine("sceneRenderers=" + renderers);
    }

    static void Validate(Manifest manifest, Dictionary<int, Generated> generated, Dictionary<string, Mesh> sourceMeshes, StringBuilder report, StringBuilder audit)
    {
        int instances = manifest.profiles.Sum(x => x.draw.instanceCount);
        if (instances != ExpectedInstances) throw new InvalidDataException("7.1-7.19 instance total expected " + ExpectedInstances + ", got " + instances);
        int layouts = manifest.profiles.Select(LayoutKey).Distinct().Count();
        if (layouts != ExpectedLayoutVariants) throw new InvalidDataException("Expected " + ExpectedLayoutVariants + " captured vertex layout variants, got " + layouts);
        int uniqueGeom = manifest.profiles.Select(x => x.geometrySha256).Distinct().Count();
        if (uniqueGeom != ExpectedUniqueMeshes) throw new InvalidDataException("Expected " + ExpectedUniqueMeshes + " unique meshes, got " + uniqueGeom);
        if (sourceMeshes.Count != ExpectedUniqueMeshes) throw new InvalidDataException("Persisted unique source meshes expected " + ExpectedUniqueMeshes + ", got " + sourceMeshes.Count);
        foreach (Profile p in manifest.profiles)
        {
            Generated g = generated[p.eid];
            if (g.source == null || g.source.vertexCount != p.vertexCount) throw new InvalidDataException("EID" + p.eid + " source mesh mismatch.");
            if (g.expanded == null || g.expanded.vertexCount != p.vertexCount * p.draw.instanceCount)
                throw new InvalidDataException("EID" + p.eid + " expanded mesh mismatch.");
            if (g.material == null || g.material.shader == null || g.material.shader.name != "EID/URP/VS215841_PS215842_GBuffer")
                throw new InvalidDataException("EID" + p.eid + " material shader mismatch.");
            if (g.instanceBytes == null || g.instanceBytes.bytes.Length < p.draw.instanceCount * 96)
                throw new InvalidDataException("EID" + p.eid + " instance bytes mismatch.");
        }
        report.AppendLine("profiles=" + manifest.profiles.Length);
        report.AppendLine("instances=" + instances);
        report.AppendLine("layoutVariants=" + layouts);
        report.AppendLine("uniqueMeshes=" + uniqueGeom);
        report.AppendLine("vertexAttributes=COMPLETE_5_OF_5");
        report.AppendLine("drawPath=ONE_MESHRENDERER_PER_EID_EXPANDED_CARD");
        report.AppendLine("resourcePolicy=RID_DEDUPLICATED_UNIQUE_MATERIAL_REUSE_RID210510");
        report.AppendLine("validation=PASS");
        audit.Insert(0, "# VS215841 / PS215842 Vertex Attribute Audit\n\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\n- EIDs: `7.1-7.19`\n- Layout variants: `1` (`45735b857ded1837`)\n- Unique source cards: `5`\n- Instances: `10841` via uniforms27 stride 96, one MeshRenderer per EID\n- Shader: VS215841 world-space instance M[3] + live Unity VP + PS215842 octahedron from res25.xy, stencil Ref 33\n\n");
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
    static void CopyInput(Profile p, string name, int vertex, byte[] dst, int dstOffset, int bytes) { byte[] x = ReadInput(p, name, vertex, bytes); Buffer.BlockCopy(x, 0, dst, dstOffset, bytes); }
    static byte[] ReadCB(Profile p, string stage, string name)
    {
        ConstantRef[] a = stage == "VS" ? p.constantBuffers.VS : p.constantBuffers.PS;
        ConstantRef cb = a.FirstOrDefault(x => x.name == name);
        if (cb == null) throw new InvalidDataException("EID" + p.eid + " missing " + stage + " " + name);
        return ReadFile(cb.file.file);
    }
    static byte[] ReadFile(string rel)
    {
        string path = Absolute(Root + "/" + rel);
        if (!RawCache.TryGetValue(path, out byte[] b)) { b = File.ReadAllBytes(path); RawCache[path] = b; }
        return b;
    }

    static Vector3 ReadTranslation(byte[] b, int instance)
    {
        int o = instance * 96 + 48;
        return new Vector3(ReadFloat(b, o), ReadFloat(b, o + 4), ReadFloat(b, o + 8));
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
            unique++;
            report.AppendLine("ihvTexture=" + path + " format=" + e.format);
        }
        report.AppendLine("localUniqueMaterialRIDs=" + unique + " (RID210510 reused from EID3863)");
    }
    static Texture LoadTexture(Profile p, string name)
    {
        int rid = Rid(p, name);
        Texture t = AssetDatabase.LoadAssetAtPath<Texture>(Root + "/TextureDatabase/rid" + rid + ".dds");
        if (t != null) return t;
        if (currentManifest != null && currentManifest.textureDatabase != null)
        {
            TextureDatabaseEntry e = currentManifest.textureDatabase.FirstOrDefault(x => x.rid == rid);
            if (e != null)
            {
                if (!string.IsNullOrEmpty(e.exportedAsset))
                {
                    string path = e.exportedAsset.StartsWith("Assets/", StringComparison.OrdinalIgnoreCase) ? e.exportedAsset : Root + "/" + e.exportedAsset;
                    t = AssetDatabase.LoadAssetAtPath<Texture>(path);
                    if (t != null) return t;
                }
                if (e.existingAssets != null)
                {
                    foreach (string pth in e.existingAssets)
                    {
                        t = AssetDatabase.LoadAssetAtPath<Texture>(pth);
                        if (t != null) return t;
                    }
                }
            }
        }
        return null;
    }
    static int Rid(Profile p, string name)
    {
        TextureRef t = p.textures != null ? p.textures.FirstOrDefault(x => x.name == name) : null;
        if (t != null) return t.rid;
        t = p.vsTextures != null ? p.vsTextures.FirstOrDefault(x => x.name == name) : null;
        return t == null ? 0 : t.rid;
    }

    static Vector4 ReadVector4(byte[] b, int o) => new Vector4(ReadFloat(b, o), ReadFloat(b, o + 4), ReadFloat(b, o + 8), ReadFloat(b, o + 12));
    static float ReadFloat(byte[] b, int o) => BitConverter.ToSingle(b, o);
    static void WriteFloat(byte[] b, int o, float v) { byte[] x = BitConverter.GetBytes(v); Buffer.BlockCopy(x, 0, b, o, 4); }
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
            "Validation/ColourPass6_VS215841"
        }) Directory.CreateDirectory(Absolute(p));
    }
}
#endif
