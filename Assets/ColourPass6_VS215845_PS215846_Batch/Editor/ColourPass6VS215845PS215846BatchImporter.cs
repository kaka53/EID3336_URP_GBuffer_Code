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
public static class ColourPass6VS215845PS215846BatchImporter
{
    const string Root = "Assets/ColourPass6_VS215845_PS215846_Batch";
    const string ManifestPath = Root + "/VS215845_PS215846_BatchManifest.json";
    const string ShaderPath = Root + "/Shaders/EID215845215846GBuffer.shader";
    const string TargetScene = "Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
    const string TriggerPath = "Validation/ColourPass6_VS215845/Import.request";
    const string ReportPath = "Validation/ColourPass6_VS215845/ImportReport.txt";
    const string AuditPath = "Validation/ColourPass6_VS215845/VertexAttributeAudit.md";
    const string SceneRootName = "ColourPass6_VS215845_PS215846";
    const string CombinedTex = "Assets/EID3332_EID3336_Combined/EID3863_RenderDocVegetation/ImportedTextures/";
    static readonly int[] ExpectedEIDs = { 3849, 3853 };
    static readonly int ExpectedInstances = 156;
    static readonly int ExpectedLayoutVariants = 1;
    static readonly int ExpectedUniqueMeshes = 2;
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

    static ColourPass6VS215845PS215846BatchImporter() { EditorApplication.update += Poll; }
    static void Poll()
    {
        if (busy || EditorApplication.isCompiling || EditorApplication.isUpdating) return;
        string f = Absolute(TriggerPath);
        if (!File.Exists(f)) return;
        File.Delete(f);
        try { ImportAll(); }
        catch (Exception e) { File.WriteAllText(Absolute(ReportPath), "FAIL\n" + e, Encoding.UTF8); Debug.LogException(e); }
    }

    [MenuItem("Tools/Colour Pass 6/Import EID 46.1-46.2 (VS215845 PS215846)")]
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
                throw new InvalidDataException("Manifest must contain exactly " + ExpectedEIDs.Length + " profiles for 46.1-46.2.");
            int[] got = manifest.profiles.Select(x => x.eid).OrderBy(x => x).ToArray();
            if (!got.SequenceEqual(ExpectedEIDs.OrderBy(x => x)))
                throw new InvalidDataException("Expected EIDs 46.1-46.2, got " + string.Join(",", got));
            Shader shader = AssetDatabase.LoadAssetAtPath<Shader>(ShaderPath);
            if (shader == null) throw new FileNotFoundException("Shader asset missing", ShaderPath);
            if (ShaderUtil.ShaderHasError(shader))
                throw new InvalidOperationException("VS215845/PS215846 shader has compile errors before import.\n" + FormatShaderMessages(shader));

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
                EID215845DrawProfile asset = CreateProfileAsset(profile, source, expanded, material, instanceBytes);
                generated[profile.eid] = new Generated { source = source, expanded = expanded, material = material, profile = asset, instanceBytes = instanceBytes };
            }
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
            BuildScene(manifest, generated, report);
            Validate(manifest, generated, sourceMeshes, report, audit);
            File.WriteAllText(Absolute(ReportPath), report.ToString(), Encoding.UTF8);
            File.WriteAllText(Absolute(AuditPath), audit.ToString(), Encoding.UTF8);
            Debug.Log("[ColourPass6] VS215845/PS215846 import completed: " + manifest.profiles.Length + " EIDs, " + manifest.profiles.Sum(x => x.draw.instanceCount) + " instances.");
        }
        finally { busy = false; currentManifest = null; }
    }

    sealed class Generated
    {
        public Mesh source;
        public Mesh expanded;
        public Material material;
        public EID215845DrawProfile profile;
        public TextAsset instanceBytes;
    }

    static void ValidateProfile(Profile p)
    {
        if (p.vs != 215845 || p.ps != 215846) throw new InvalidDataException("EID" + p.eid + " shader family mismatch VS215845/PS215846.");
        if (p.layout == null || p.layout.Length != 6) throw new InvalidDataException("EID" + p.eid + " must expose the 6 RenderDoc VS inputs.");
        string[] required = { "_input0", "_input1", "_input2", "_input3", "_input4", "_input5" };
        foreach (string name in required) if (p.layout.All(x => x.name != name)) throw new InvalidDataException("EID" + p.eid + " missing " + name);
        if (p.files == null || p.files.indices == null || string.IsNullOrEmpty(p.files.indices.file)) throw new InvalidDataException("EID" + p.eid + " index file missing.");
        if (p.streams == null || p.streams.Length == 0) throw new InvalidDataException("EID" + p.eid + " streams missing.");
        foreach (StreamRef s in p.streams) if (s.file == null || !File.Exists(Absolute(Root + "/" + s.file.file))) throw new FileNotFoundException("EID" + p.eid + " stream missing: slot " + s.slot);
        if (p.instanceBuffer == null || string.IsNullOrEmpty(p.instanceBuffer.file)) throw new InvalidDataException("EID" + p.eid + " instance buffer missing.");
        if (p.instanceStride != 96) throw new InvalidDataException("EID" + p.eid + " instance stride expected 96, got " + p.instanceStride);
        if (Rid(p, "res26") == 0 || Rid(p, "res28") == 0) throw new InvalidDataException("EID" + p.eid + " missing unique material slots res26/res28.");
        byte[] local = ReadCB(p, "PS", "uniforms31");
        if (local.Length < 368) throw new InvalidDataException("EID" + p.eid + " PS uniforms31 expected 368 bytes, got " + local.Length);
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
        var positions = new Vector3[count];
        var packed = new Vector3[count];
        var tangents = new Vector4[count];
        var extra = new Vector4[count];
        var uv0 = new Vector2[count];
        var uv1 = new Vector2[count];
        var uv3 = new Vector2[count];
        for (int v = 0; v < count; ++v)
        {
            byte[] pos = ReadInput(p, "_input0", v, 12);
            positions[v] = new Vector3(BitConverter.ToSingle(pos, 0), BitConverter.ToSingle(pos, 4), BitConverter.ToSingle(pos, 8));
            uint bits = BitConverter.ToUInt32(ReadInput(p, "_input1", v, 4), 0);
            packed[v] = new Vector3(BitConverter.Int32BitsToSingle(unchecked((int)bits)), 0f, 0f);
            byte[] t = ReadInput(p, "_input2", v, 4);
            tangents[v] = new Vector4(t[0] / 255f, t[1] / 255f, t[2] / 255f, t[3] / 255f);
            extra[v] = ReadVector4(ReadInput(p, "_input3", v, 16), 0);
            byte[] u0 = ReadInput(p, "_input4", v, 8);
            uv0[v] = new Vector2(BitConverter.ToSingle(u0, 0), BitConverter.ToSingle(u0, 4));
            byte[] u1 = ReadInput(p, "_input5", v, 8);
            uv1[v] = new Vector2(BitConverter.ToSingle(u1, 0), BitConverter.ToSingle(u1, 4));
            uv3[v] = Vector2.zero;
        }

        byte[] idxBytes = ReadFile(p.files.indices.file);
        int[] indices = new int[p.draw.indexCount];
        for (int i = 0; i < indices.Length; ++i) indices[i] = (int)BitConverter.ToUInt32(idxBytes, i * 4);

        string path = SourceMeshPath(p.sharedGeometryFromEID != 0 ? p.sharedGeometryFromEID : p.eid);
        Mesh old = AssetDatabase.LoadAssetAtPath<Mesh>(path);
        if (old != null) AssetDatabase.DeleteAsset(path);
        var mesh = new Mesh { name = "EID" + (p.sharedGeometryFromEID != 0 ? p.sharedGeometryFromEID : p.eid) + " VS215845 Source", indexFormat = IndexFormat.UInt32 };
        mesh.vertices = positions;
        mesh.normals = packed;
        mesh.tangents = tangents;
        mesh.SetUVs(0, uv0);
        mesh.SetUVs(1, uv1);
        mesh.SetUVs(2, extra);
        mesh.SetUVs(3, uv3);
        mesh.SetIndices(indices, MeshTopology.Triangles, 0, true);
        mesh.RecalculateBounds();
        AssetDatabase.CreateAsset(mesh, path);

        audit.AppendLine("## EID " + p.eid + " item " + p.meshItem);
        audit.AppendLine("- Source vertices: `" + p.vertexCount + "`; Indices: `" + p.draw.indexCount + "`; Instances: `" + p.draw.instanceCount + "`");
        audit.AppendLine("- Shared geometry from EID: `" + p.sharedGeometryFromEID + "`");
        audit.AppendLine("- Unity streams: `Position xyz`, `Normal.x packed input1 bits`, `Tangent input2 UNorm8`, `UV2 input3 float4`, `UV0 input4`, `UV1 input5`, `UV3 instanceIndex`");
        audit.AppendLine("- Captured layout: `" + string.Join("; ", p.layout.Select(x => x.name + "=slot" + x.slot + "+" + x.offset + " " + x.format.name)) + "`\n");
        return mesh;
    }

    static Mesh CreateExpandedMesh(Profile p)
    {
        int baseV = p.vertexCount;
        int baseI = p.draw.indexCount;
        int inst = p.draw.instanceCount;
        int count = baseV * inst;
        int indexCount = baseI * inst;

        Mesh source = CreateSourceMeshScratch(p);
        var srcPos = source.vertices;
        var srcNrm = source.normals;
        var srcTan = source.tangents;
        var srcUv0 = new List<Vector2>(); source.GetUVs(0, srcUv0);
        var srcUv1 = new List<Vector2>(); source.GetUVs(1, srcUv1);
        var srcExtra = new List<Vector4>(); source.GetUVs(2, srcExtra);
        int[] srcIdx = source.GetIndices(0);

        var dstPos = new Vector3[count];
        var dstNrm = new Vector3[count];
        var dstTan = new Vector4[count];
        var dstUv0 = new Vector2[count];
        var dstUv1 = new Vector2[count];
        var dstExtra = new Vector4[count];
        var dstUv3 = new Vector2[count];
        var dstIdx = new int[indexCount];
        for (int i = 0; i < inst; ++i)
        {
            int vo = i * baseV;
            for (int v = 0; v < baseV; ++v)
            {
                dstPos[vo + v] = srcPos[v];
                dstNrm[vo + v] = srcNrm[v];
                dstTan[vo + v] = srcTan[v];
                dstUv0[vo + v] = srcUv0[v];
                dstUv1[vo + v] = srcUv1[v];
                dstExtra[vo + v] = srcExtra[v];
                dstUv3[vo + v] = new Vector2(i, 0f);
            }
            for (int k = 0; k < baseI; ++k)
                dstIdx[i * baseI + k] = srcIdx[k] + vo;
        }

        string path = ExpandedMeshPath(p.eid);
        Mesh old = AssetDatabase.LoadAssetAtPath<Mesh>(path);
        if (old != null) AssetDatabase.DeleteAsset(path);
        var mesh = new Mesh { name = "EID" + p.eid + " VS215845 Expanded x" + inst, indexFormat = IndexFormat.UInt32 };
        mesh.vertices = dstPos;
        mesh.normals = dstNrm;
        mesh.tangents = dstTan;
        mesh.SetUVs(0, dstUv0);
        mesh.SetUVs(1, dstUv1);
        mesh.SetUVs(2, dstExtra);
        mesh.SetUVs(3, dstUv3);
        mesh.SetIndices(dstIdx, MeshTopology.Triangles, 0, false);

        byte[] instBytes = ReadFile(p.instanceBuffer.file);
        var bounds = new Bounds(ReadTranslation(instBytes, 0), Vector3.one);
        for (int i = 1; i < inst; ++i) bounds.Encapsulate(ReadTranslation(instBytes, i));
        bounds.Expand(4f);
        mesh.bounds = bounds;
        AssetDatabase.CreateAsset(mesh, path);
        return mesh;
    }

    static Mesh CreateSourceMeshScratch(Profile p)
    {
        int count = p.vertexCount;
        var positions = new Vector3[count];
        var packed = new Vector3[count];
        var tangents = new Vector4[count];
        var extra = new Vector4[count];
        var uv0 = new Vector2[count];
        var uv1 = new Vector2[count];
        for (int v = 0; v < count; ++v)
        {
            byte[] pos = ReadInput(p, "_input0", v, 12);
            positions[v] = new Vector3(BitConverter.ToSingle(pos, 0), BitConverter.ToSingle(pos, 4), BitConverter.ToSingle(pos, 8));
            uint bits = BitConverter.ToUInt32(ReadInput(p, "_input1", v, 4), 0);
            packed[v] = new Vector3(BitConverter.Int32BitsToSingle(unchecked((int)bits)), 0f, 0f);
            byte[] t = ReadInput(p, "_input2", v, 4);
            tangents[v] = new Vector4(t[0] / 255f, t[1] / 255f, t[2] / 255f, t[3] / 255f);
            extra[v] = ReadVector4(ReadInput(p, "_input3", v, 16), 0);
            byte[] u0 = ReadInput(p, "_input4", v, 8);
            uv0[v] = new Vector2(BitConverter.ToSingle(u0, 0), BitConverter.ToSingle(u0, 4));
            byte[] u1 = ReadInput(p, "_input5", v, 8);
            uv1[v] = new Vector2(BitConverter.ToSingle(u1, 0), BitConverter.ToSingle(u1, 4));
        }
        byte[] idxBytes = ReadFile(p.files.indices.file);
        int[] indices = new int[p.draw.indexCount];
        for (int i = 0; i < indices.Length; ++i) indices[i] = (int)BitConverter.ToUInt32(idxBytes, i * 4);
        var mesh = new Mesh { indexFormat = IndexFormat.UInt32 };
        mesh.vertices = positions;
        mesh.normals = packed;
        mesh.tangents = tangents;
        mesh.SetUVs(0, uv0);
        mesh.SetUVs(1, uv1);
        mesh.SetUVs(2, extra);
        mesh.SetIndices(indices, MeshTopology.Triangles, 0, false);
        return mesh;
    }

    static Material CreateMaterial(Profile p, Shader shader, StringBuilder report)
    {
        string path = Root + "/Materials/EID" + p.eid + "_VS215845_PS215846.mat";
        Material m = AssetDatabase.LoadAssetAtPath<Material>(path);
        if (m == null) { m = new Material(shader); AssetDatabase.CreateAsset(m, path); }
        m.shader = shader; m.name = "EID" + p.eid + " VS215845 PS215846";
        byte[] local = ReadCB(p, "PS", "uniforms31");
        m.SetVector("_P00", ReadVector4(local, 0));
        m.SetVector("_P01", ReadVector4(local, 16));
        m.SetVector("_P02", ReadVector4(local, 32));
        m.SetVector("_P03", ReadVector4(local, 48));
        m.SetVector("_P04", ReadVector4(local, 64));
        m.SetVector("_P05", ReadVector4(local, 80));
        m.SetVector("_P06", ReadVector4(local, 96));
        m.SetVector("_P07", ReadVector4(local, 112));
        m.SetVector("_P08", ReadVector4(local, 128));
        m.SetVector("_P09", ReadVector4(local, 144));
        m.SetVector("_P10", ReadVector4(local, 160));
        m.SetVector("_P11", ReadVector4(local, 176));
        m.SetVector("_P12", ReadVector4(local, 192));
        m.SetVector("_P13", ReadVector4(local, 208));
        m.SetVector("_P14", ReadVector4(local, 224));
        m.SetVector("_P15", ReadVector4(local, 240));
        m.SetVector("_P16", ReadVector4(local, 256));
        m.SetVector("_P17", ReadVector4(local, 272));
        m.SetVector("_P18", ReadVector4(local, 288));
        m.SetVector("_P19", ReadVector4(local, 304));
        m.SetVector("_P20", ReadVector4(local, 320));
        m.SetVector("_P21", ReadVector4(local, 336));
        m.SetVector("_P22", ReadVector4(local, 352));
        m.SetFloat("_StencilRef", 33f);

        Texture baseTex = LoadTexture(p, "res26");
        Texture normalTex = LoadTexture(p, "res28");
        if (baseTex == null || normalTex == null)
            throw new FileNotFoundException("EID" + p.eid + " res26/res28 texture binding is incomplete.");
        m.SetTexture("_Res26", baseTex);
        m.SetTexture("_Res28", normalTex);
        EditorUtility.SetDirty(m);
        report.AppendLine("EID" + p.eid + ": material res26=RID" + Rid(p, "res26") + " res28=RID" + Rid(p, "res28") + " instances=" + p.draw.instanceCount + " PS uniforms31=" + local.Length + "B");
        return m;
    }

    static TextAsset LoadInstanceBytes(Profile p)
    {
        string path = Root + "/" + p.instanceBuffer.file;
        TextAsset t = AssetDatabase.LoadAssetAtPath<TextAsset>(path);
        if (t == null) throw new FileNotFoundException("EID" + p.eid + " instance TextAsset missing", path);
        return t;
    }

    static EID215845DrawProfile CreateProfileAsset(Profile p, Mesh source, Mesh expanded, Material material, TextAsset instanceBytes)
    {
        string path = Root + "/Profiles/EID" + p.eid + "_DrawProfile.asset";
        EID215845DrawProfile d = AssetDatabase.LoadAssetAtPath<EID215845DrawProfile>(path);
        if (d == null) { d = ScriptableObject.CreateInstance<EID215845DrawProfile>(); AssetDatabase.CreateAsset(d, path); }
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
            EID215845InstanceBinder binder = go.AddComponent<EID215845InstanceBinder>();
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
        if (instances != ExpectedInstances) throw new InvalidDataException("46.1-46.2 instance total expected " + ExpectedInstances + ", got " + instances);
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
            if (g.material == null || g.material.shader == null || g.material.shader.name != "EID/URP/VS215845_PS215846_GBuffer")
                throw new InvalidDataException("EID" + p.eid + " material shader mismatch.");
            if (g.instanceBytes == null || g.instanceBytes.bytes.Length < p.draw.instanceCount * 96)
                throw new InvalidDataException("EID" + p.eid + " instance bytes mismatch.");
        }
        report.AppendLine("profiles=" + manifest.profiles.Length);
        report.AppendLine("instances=" + instances);
        report.AppendLine("layoutVariants=" + layouts);
        report.AppendLine("uniqueMeshes=" + uniqueGeom);
        report.AppendLine("vertexAttributes=COMPLETE_6_OF_6");
        report.AppendLine("drawPath=ONE_MESHRENDERER_PER_EID_EXPANDED_CARD");
        report.AppendLine("resourcePolicy=RID_DEDUPLICATED_UNIQUE_MATERIAL");
        report.AppendLine("validation=PASS");
        audit.Insert(0, "# VS215845 / PS215846 Vertex Attribute Audit\n\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\n- EIDs: `46.1-46.2` (`3849,3853`)\n- Layout variants: `1` (`c31cfb96d90d3b85`)\n- Unique source meshes: `2`\n- Instances: `156` via uniforms26 stride 96, one MeshRenderer per EID\n- Packed `_input1` on `NORMAL.x`; live Unity VP; unique DXT5nm PS no clip; stencil 33 both; ZTest Equal; no VS terrain\n\n");
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
            }
            unique++;
            report.AppendLine("ihvTexture=" + path + " format=" + e.format + " sRGB=" + srgb);
        }
        report.AppendLine("localUniqueMaterialRIDs=" + unique);
    }
    static Texture LoadTexture(Profile p, string name)
    {
        int rid = Rid(p, name);
        Texture t = AssetDatabase.LoadAssetAtPath<Texture>(Root + "/TextureDatabase/rid" + rid + ".dds");
        if (t != null) return t;
        t = AssetDatabase.LoadAssetAtPath<Texture>(CombinedTex + "rid" + rid + ".asset");
        if (t != null) return t;
        t = AssetDatabase.LoadAssetAtPath<Texture>(CombinedTex + "PS_res23_rid" + rid + ".asset");
        if (t != null) return t;
        t = AssetDatabase.LoadAssetAtPath<Texture>(CombinedTex + "PS_res25_rid" + rid + ".asset");
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
            .Distinct(StringComparer.OrdinalIgnoreCase))
        {
            t = AssetDatabase.LoadAssetAtPath<Texture>(pth);
            if (t != null) return t;
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
            "Validation/ColourPass6_VS215845"
        }) Directory.CreateDirectory(Absolute(p));
    }
}
#endif
