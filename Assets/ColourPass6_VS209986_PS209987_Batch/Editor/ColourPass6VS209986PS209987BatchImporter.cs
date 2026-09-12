#if UNITY_EDITOR
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using UnityEditor;
using Unity.Collections;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.SceneManagement;

/// <summary>
/// Batch importer for the Colour Pass #6 VS209986/PS209987 family.
/// It consumes the RenderDoc-exported byte ranges, keeps each EID's raw
/// streams and instance table isolated, and reuses the existing validated
/// VS/PS shader and shared frame textures.
/// </summary>
[InitializeOnLoad]
public static class ColourPass6VS209986PS209987BatchImporter
{
    const string Root = "Assets/ColourPass6_VS209986_PS209987_Batch";
    const string ManifestAssetPath = Root + "/VS209986_PS209987_BatchManifest.json";
    const string SharedShaderPath = "Assets/EID3332_EID3336_Combined/URPGBuffer/IndependentVS/EID3336RenderDocGBufferIndependent.shader";
    const string TargetScene = "Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
    const string SharedTextureGroup = "EID3336Textures";
    const string TriggerFile = "Validation/ColourPass6BatchImport.request";
    const string ReportFile = "Validation/ColourPass6BatchImportReport.txt";
    static bool busy;
    static readonly int[] Skipped = { 3315, 3320, 3332, 3336 };

    [Serializable] class Manifest { public Profile[] profiles; }
    [Serializable] class Profile
    {
        public int eid, vs, ps, vertexCount, triangleCount;
        public bool skipExisting;
        public Draw draw;
        public FileSet files;
        public TextureRef[] textures;
        public Layout[] layout;
    }
    [Serializable] class Draw { public int indexCount, instanceCount, indexOffset, baseVertex, vertexOffset; }
    [Serializable] class FileSet { public FileRef indices, vertexStream0, vertexStream1, vertexStream3; }
    [Serializable] class FileRef { public string file; }
    [Serializable] class TextureRef { public string name, format; public int rid, binding, width, height, mips, arraySize; }
    [Serializable] class Layout { public string name, format; public int slot, offset; public bool perInstance; }

    static ColourPass6VS209986PS209987BatchImporter()
    {
        EditorApplication.update += Poll;
    }

    static void Poll()
    {
        if (busy || EditorApplication.isCompiling || EditorApplication.isUpdating) return;
        string request = Absolute(TriggerFile);
        if (!File.Exists(request)) return;
        File.Delete(request);
        try { ImportAll(); }
        catch (Exception e)
        {
            File.WriteAllText(Absolute(ReportFile), "FAIL\n" + e, Encoding.UTF8);
            Debug.LogException(e);
        }
    }

    [MenuItem("Tools/Colour Pass 6/Import VS209986 PS209987 Remaining EIDs")]
    public static void ImportAll()
    {
        if (busy) return;
        busy = true;
        var report = new StringBuilder();
        try
        {
            EnsureFolders();
            AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
            Manifest manifest = LoadManifest();
            Shader shader = AssetDatabase.LoadAssetAtPath<Shader>(SharedShaderPath);
            if (shader == null || ShaderUtil.ShaderHasError(shader))
                throw new InvalidOperationException("Validated VS209986/PS209987 shader is missing or has compile errors: " + SharedShaderPath);

            List<Profile> todo = manifest.profiles == null
                ? new List<Profile>()
                : manifest.profiles.Where(p => p != null && !Skipped.Contains(p.eid) && !p.skipExisting).ToList();
            report.AppendLine("date=" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss", CultureInfo.InvariantCulture));
            report.AppendLine("shader=VS209986/PS209987");
            report.AppendLine("targetScene=" + TargetScene);
            report.AppendLine("requested=" + todo.Count);

            foreach (Profile p in todo)
            {
                ValidateProfile(p);
                PrepareRawResources(p, report);
                PreparePerEidShaderResources(p, report);
                Material material = CreateMaterial(p, shader, report);
                EID3332CombinedDrawProfile profile = CreateProfile(p, material, report);
                Mesh mesh = CreatePreviewMesh(p, report);
                AttachProfileToScene(p, profile, material, mesh, report);
            }

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
            ValidatePersistedMeshes(todo, report);
            UpdateTargetSceneBindings(todo, report);
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
            File.WriteAllText(Absolute(ReportFile), report.ToString(), Encoding.UTF8);
            Debug.Log("[ColourPass6 Batch] Imported " + todo.Count + " EIDs into " + TargetScene);
        }
        finally { busy = false; }
    }

    static Manifest LoadManifest()
    {
        string path = Absolute(ManifestAssetPath);
        if (!File.Exists(path)) throw new FileNotFoundException("Missing batch manifest", path);
        Manifest m = JsonUtility.FromJson<Manifest>(File.ReadAllText(path));
        if (m == null || m.profiles == null || m.profiles.Length == 0)
            throw new InvalidDataException("Manifest has no profiles: " + path);
        return m;
    }

    static void ValidateProfile(Profile p)
    {
        if (p.vs != 209986 || p.ps != 209987) throw new InvalidDataException("Unexpected shader family for EID" + p.eid);
        if (p.draw == null || p.draw.indexCount <= 0 || p.draw.instanceCount <= 0)
            throw new InvalidDataException("Invalid draw contract for EID" + p.eid);
        if (p.files == null || p.files.vertexStream0 == null || p.files.vertexStream1 == null || p.files.vertexStream3 == null || p.files.indices == null)
            throw new InvalidDataException("Missing raw stream references for EID" + p.eid);
        byte[] s0 = ReadManifestFile(p.files.vertexStream0.file);
        byte[] s1 = ReadManifestFile(p.files.vertexStream1.file);
        byte[] c = ReadManifestFile(p.files.vertexStream3.file);
        byte[] ib = ReadManifestFile(p.files.indices.file);
        if (s0.Length != p.vertexCount * 16) throw new InvalidDataException("EID" + p.eid + " stream0 length mismatch: " + s0.Length);
        int stride = Stream1Stride(p);
        if (s1.Length != p.vertexCount * stride) throw new InvalidDataException("EID" + p.eid + " stream1 length mismatch: " + s1.Length + " stride=" + stride);
        if (c.Length < 20) throw new InvalidDataException("EID" + p.eid + " packed vertex constants are incomplete");
        if (ib.Length != p.draw.indexCount * 2) throw new InvalidDataException("EID" + p.eid + " index length mismatch");
        if (p.vertexCount > 65535) throw new InvalidDataException("EID" + p.eid + " requires UInt32 indices, not supported by the captured u16 contract");
    }

    static int Stream1Stride(Profile p)
    {
        return p.layout != null && p.layout.Any(x => x != null && x.slot == 1 && x.offset >= 8)
            ? 16 : 8;
    }

    static void PrepareRawResources(Profile p, StringBuilder report)
    {
        string rawDir = Absolute(Root + "/Resources/EID" + p.eid + "Raw");
        Directory.CreateDirectory(rawDir);
        CopyBytes(p.files.vertexStream0.file, Path.Combine(rawDir, "vertex_stream0.bytes"));
        CopyBytes(p.files.vertexStream1.file, Path.Combine(rawDir, "vertex_stream1.bytes"));
        CopyBytes(p.files.vertexStream3.file, Path.Combine(rawDir, "vertex_constant_stream.bytes"));
        CopyBytes(p.files.indices.file, Path.Combine(rawDir, "indices_u16.bytes"));
        ImportBytes(rawDir, "vertex_stream0.bytes");
        ImportBytes(rawDir, "vertex_stream1.bytes");
        ImportBytes(rawDir, "vertex_constant_stream.bytes");
        ImportBytes(rawDir, "indices_u16.bytes");
        report.AppendLine("EID" + p.eid + ": raw streams ready");
    }

    static void PreparePerEidShaderResources(Profile p, StringBuilder report)
    {
        string vsDir = Absolute(Root + "/Resources/EID" + p.eid + "VS");
        Directory.CreateDirectory(vsDir);
        // Frame VS constants are byte-identical for this shader family and are
        // copied once per resource root only because the runtime loader takes a
        // root name. The instance table remains EID-specific.
        CopyExistingIfMissing("Assets/EID3332_EID3336_Combined/Resources/EID3336VS/_24_25.bytes", Path.Combine(vsDir, "_24_25.bytes"));
        CopyExistingIfMissing("Assets/EID3332_EID3336_Combined/Resources/EID3336VS/_26_27.bytes", Path.Combine(vsDir, "_26_27.bytes"));
        CopyBytes(p.files != null && p.files.vertexStream0 != null ? FindFile(p, "VS_uniforms30.bytes") : null, Path.Combine(vsDir, "_28_30.bytes"));
        ImportBytes(vsDir, "_24_25.bytes");
        ImportBytes(vsDir, "_26_27.bytes");
        ImportBytes(vsDir, "_28_30.bytes");
        report.AppendLine("EID" + p.eid + ": instance VS_30 isolated");
    }

    static Material CreateMaterial(Profile p, Shader shader, StringBuilder report)
    {
        string matPath = Root + "/Materials/EID" + p.eid + "_VS209986_PS209987.mat";
        EnsureParent(matPath);
        Material m = AssetDatabase.LoadAssetAtPath<Material>(matPath);
        if (m == null)
        {
            m = new Material(shader) { name = "EID" + p.eid + " - VS209986 PS209987" };
            AssetDatabase.CreateAsset(m, matPath);
        }
        else { m.shader = shader; m.name = "EID" + p.eid + " - VS209986 PS209987"; }

        // Bind the complete PS resource table, not only the five primary local
        // slots. _40.._42 and _53.._65 are read by PS209987 branches too.
        if (p.textures != null)
        {
            foreach (TextureRef t in p.textures)
            {
                if (t == null || string.IsNullOrEmpty(t.name)) continue;
                int propertyId = ParseResourcePropertyId(t.name);
                if (propertyId <= 0 || !m.HasProperty("_" + propertyId)) continue;
                Texture texture = LoadTextureAny(t.rid);
                if (texture != null) m.SetTexture("_" + propertyId, texture);
                else Debug.LogWarning("[ColourPass6 Batch] texture RID" + t.rid + " missing for _" + propertyId);
            }
        }
        byte[] ps = ReadManifestFile(FindFile(p, "PS_uniforms44.bytes"));
        if (ps.Length != 720) throw new InvalidDataException("EID" + p.eid + " PS_uniforms44 must be 720 bytes");
        for (int i = 0; i < 45; ++i)
            m.SetVector("_EID3336PSLocalParam" + i.ToString("00"), ReadVector4(ps, i * 16));
        m.SetFloat("_EID3336PSUseLocalParams", 1f);
        m.SetFloat("_EID3336UseLocalVSOverrides", 0f);
        m.SetFloat("_EID3336RawStream1StrideBytes", Stream1Stride(p));
        m.SetFloat("_EID3336PSLocalUseUVTransform", 0f);
        m.SetFloat("_EID3336PSLocalFlipUVY", 0f);
        m.SetFloat("_EID3336RouteBUseObjectTransform", 0f);
        EditorUtility.SetDirty(m);
        report.AppendLine("EID" + p.eid + ": material local uniforms44 + textures assigned");
        return m;
    }

    static EID3332CombinedDrawProfile CreateProfile(Profile p, Material material, StringBuilder report)
    {
        string profilePath = Root + "/Profiles/EID" + p.eid + "_DrawProfile.asset";
        EnsureParent(profilePath);
        EID3332CombinedDrawProfile d = AssetDatabase.LoadAssetAtPath<EID3332CombinedDrawProfile>(profilePath);
        if (d == null) { d = ScriptableObject.CreateInstance<EID3332CombinedDrawProfile>(); AssetDatabase.CreateAsset(d, profilePath); }
        d.name = "EID" + p.eid + " Draw Profile";
        d.eventId = p.eid;
        d.indexCount = p.draw.indexCount;
        d.instanceCount = p.draw.instanceCount;
        d.indexOffset = p.draw.indexOffset;
        d.baseVertex = p.draw.baseVertex;
        d.vertexCount = p.vertexCount;
        d.triangleCount = p.triangleCount;
        d.vertexDataSource = Root + "/Resources/EID" + p.eid + "Raw/vertex_stream0.bytes + vertex_stream1.bytes";
        d.indexDataSource = Root + "/Resources/EID" + p.eid + "Raw/indices_u16.bytes";
        d.instanceDataSource = Root + "/Resources/EID" + p.eid + "VS/_28_30.bytes";
        d.materialConstantsSource = "EID" + p.eid + " PS209987 uniforms44.bytes";
        d.textureResourceGroup = SharedTextureGroup;
        d.verticesAlreadyWorldSpace = false;
        d.applyExportMirrorX = false;
        d.shaderInstanceOffset = 0;
        d.vertexStream1StrideBytes = Stream1Stride(p);
        d.useRawStreams = true;
        d.baseColorTextureId = RidByName(p, "res33", 0);
        d.baseNormalTextureId = RidByName(p, "res35", 0);
        d.layerControlTextureId = RidByName(p, "res37", 0);
        d.detailNormalTextureId = RidByName(p, "res38", 0);
        d.grassBlendMaskTextureId = RidByName(p, "res39", 0);
        d.enableVirtualTextureBranchInCapturedProjection = false;
        d.enableVirtualTextureBranchInCurrentCamera = false;
        d.flipMaterialUvY = false;
        d.useCapturedVisibilityMaskInCapturedProjection = false;
        d.capturedVisibilityFlipY = false;
        d.capturedVisibilityMask = null;
        d.modelAsset = null;
        d.exportMetadata = AssetDatabase.LoadAssetAtPath<TextAsset>(Root + "/VS209986_PS209987_BatchManifest.json");
        d.instanceMetadata = null;
        EditorUtility.SetDirty(d);
        report.AppendLine("EID" + p.eid + ": profile asset ready");
        return d;
    }

    static Mesh CreatePreviewMesh(Profile p, StringBuilder report)
    {
        string meshPath = Root + "/Geometry/Meshes/EID" + p.eid + "_RawPreview.asset";
        EnsureParent(meshPath);
        Mesh mesh = AssetDatabase.LoadAssetAtPath<Mesh>(meshPath);
        if (mesh == null) { mesh = new Mesh { name = "EID" + p.eid + " Raw Preview" }; AssetDatabase.CreateAsset(mesh, meshPath); }
        else mesh.Clear();

        byte[] s0 = ReadManifestFile(p.files.vertexStream0.file);
        byte[] s1 = ReadManifestFile(p.files.vertexStream1.file);
        byte[] constants = ReadManifestFile(p.files.vertexStream3.file);
        byte[] ib = ReadManifestFile(p.files.indices.file);
        int stride = Stream1Stride(p);
        var vertices = new List<Vector3>(p.vertexCount);
        var normals = new List<Vector3>(p.vertexCount);
        var tangents = new List<Vector4>(p.vertexCount);
        var colors = new List<Color>(p.vertexCount);
        var uv0 = new List<Vector2>(p.vertexCount);
        var uv1 = new List<Vector2>(p.vertexCount);
        var uv2 = new List<Vector2>(p.vertexCount);
        var uv3 = new List<Vector4>(p.vertexCount);
        var uv4 = new List<Vector4>(p.vertexCount);
        var uv5 = new List<Vector4>(p.vertexCount);

        // Slot 3 is a 20-byte constant attribute record in this shader family:
        // tangent at +12, color at +4, UV4 at +16 and the integer UV5 value at +0.
        Vector4 tangent = DecodeUNorm8(ReadUInt32(constants, 12));
        Vector4 color = DecodeUNorm8(ReadUInt32(constants, 4));
        Vector4 extra = DecodeUNorm8(ReadUInt32(constants, 16));
        Vector4 extraIndex = new Vector4(constants[0], constants[1], constants[2], constants[3]);

        for (int i = 0; i < p.vertexCount; ++i)
        {
            int p0 = i * 16;
            int p1 = i * stride;
            uint packedNormal = ReadUInt32(s0, p0 + 12);
            Vector2 a = new Vector2(ReadFloat(s1, p1), ReadFloat(s1, p1 + 4));
            Vector2 b = stride >= 16
                ? new Vector2(ReadFloat(s1, p1 + 8), ReadFloat(s1, p1 + 12))
                : a;
            vertices.Add(new Vector3(ReadFloat(s0, p0), ReadFloat(s0, p0 + 4), ReadFloat(s0, p0 + 8)));
            // Preserve the captured packed-normal bit pattern through the
            // float NORMAL channel; the recovered VS consumes NORMAL.x as uint bits.
            normals.Add(new Vector3(UIntAsFloat(packedNormal), 0f, 0f));
            tangents.Add(tangent);
            colors.Add(color);
            uv0.Add(a);
            uv1.Add(b);
            uv2.Add(b);
            uv3.Add(new Vector4(b.x, b.y, 0f, 1f));
            uv4.Add(extra);
            // _input9 is R8G8B8A8_UINT: preserve the four numeric byte lanes.
            // Do not bit-cast the packed uint32; the captured shader consumes uint4.
            uv5.Add(extraIndex);
        }

        int[] indices = new int[p.draw.indexCount];
        for (int i = 0; i < indices.Length; ++i) indices[i] = BitConverter.ToUInt16(ib, i * 2);
        // Keep the captured packed formats. Unity supports four vertex streams,
        // so the three aliased UV inputs are duplicated into one float stream;
        // this preserves the shader values while retaining UNORM/UINT formats.
        VertexAttributeDescriptor[] layout =
        {
            new VertexAttributeDescriptor(VertexAttribute.Position, VertexAttributeFormat.Float32, 3, 0),
            new VertexAttributeDescriptor(VertexAttribute.Normal, VertexAttributeFormat.Float32, 1, 0),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord0, VertexAttributeFormat.Float32, 2, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord1, VertexAttributeFormat.Float32, 2, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord2, VertexAttributeFormat.Float32, 2, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord3, VertexAttributeFormat.Float32, 4, 1),
            new VertexAttributeDescriptor(VertexAttribute.Tangent, VertexAttributeFormat.UNorm8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.Color, VertexAttributeFormat.UNorm8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord4, VertexAttributeFormat.UNorm8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord5, VertexAttributeFormat.UInt8, 4, 3),
        };
        byte[] stream1Bytes = new byte[p.vertexCount * 40];
        byte[] stream2Bytes = new byte[p.vertexCount * 12];
        byte[] stream3Bytes = new byte[p.vertexCount * 4];
        for (int i = 0; i < p.vertexCount; ++i)
        {
            int p1 = i * stride;
            int d1 = i * 40;
            int d2 = i * 12;
            Vector2 b = stride >= 16
                ? new Vector2(ReadFloat(s1, p1 + 8), ReadFloat(s1, p1 + 12))
                : new Vector2(ReadFloat(s1, p1), ReadFloat(s1, p1 + 4));
            Buffer.BlockCopy(s1, p1, stream1Bytes, d1 + 0, 8); // UV0
            Buffer.BlockCopy(BitConverter.GetBytes(b.x), 0, stream1Bytes, d1 + 8, 4);
            Buffer.BlockCopy(BitConverter.GetBytes(b.y), 0, stream1Bytes, d1 + 12, 4); // UV1
            Buffer.BlockCopy(BitConverter.GetBytes(b.x), 0, stream1Bytes, d1 + 16, 4);
            Buffer.BlockCopy(BitConverter.GetBytes(b.y), 0, stream1Bytes, d1 + 20, 4); // UV2
            Buffer.BlockCopy(BitConverter.GetBytes(b.x), 0, stream1Bytes, d1 + 24, 4);
            Buffer.BlockCopy(BitConverter.GetBytes(b.y), 0, stream1Bytes, d1 + 28, 4);
            Buffer.BlockCopy(BitConverter.GetBytes(0f), 0, stream1Bytes, d1 + 32, 4);
            Buffer.BlockCopy(BitConverter.GetBytes(1f), 0, stream1Bytes, d1 + 36, 4); // UV3
            Buffer.BlockCopy(constants, 12, stream2Bytes, d2 + 0, 4);  // TANGENT UNORM8
            Buffer.BlockCopy(constants, 4, stream2Bytes, d2 + 4, 4);   // COLOR UNORM8
            Buffer.BlockCopy(constants, 16, stream2Bytes, d2 + 8, 4);  // UV4 UNORM8
            Buffer.BlockCopy(constants, 0, stream3Bytes, i * 4, 4);       // UV5 UINT8
        }
        var flags = MeshUpdateFlags.DontRecalculateBounds | MeshUpdateFlags.DontValidateIndices | MeshUpdateFlags.DontNotifyMeshUsers;
        mesh.SetVertexBufferParams(p.vertexCount, layout);
        mesh.SetVertexBufferData(s0, 0, 0, s0.Length, 0, flags);
        mesh.SetVertexBufferData(stream1Bytes, 0, 0, stream1Bytes.Length, 1, flags);
        mesh.SetVertexBufferData(stream2Bytes, 0, 0, stream2Bytes.Length, 2, flags);
        mesh.SetVertexBufferData(stream3Bytes, 0, 0, stream3Bytes.Length, 3, flags);
        ushort[] indexData = new ushort[indices.Length];
        for (int i = 0; i < indices.Length; ++i) indexData[i] = (ushort)indices[i];
        mesh.SetIndexBufferParams(indexData.Length, IndexFormat.UInt16);
        mesh.SetIndexBufferData(indexData, 0, 0, indexData.Length, flags);
        Bounds bounds = new Bounds(vertices[0], Vector3.zero);
        for (int i = 1; i < vertices.Count; ++i) bounds.Encapsulate(vertices[i]);
        mesh.SetSubMesh(0, new SubMeshDescriptor(0, indexData.Length, MeshTopology.Triangles)
        {
            baseVertex = 0,
            firstVertex = 0,
            vertexCount = p.vertexCount,
            bounds = bounds
        }, flags);
        mesh.bounds = bounds;
        mesh.UploadMeshData(false);
        ValidatePreviewMesh(mesh, p, s0, s1, constants, ib);
        ValidateVertexDeclaration(mesh, p);
        EditorUtility.SetDirty(mesh);
        report.AppendLine("EID" + p.eid + ": preview mesh ready vertices=" + p.vertexCount + " indices=" + p.draw.indexCount + " attributes=POSITION,NORMAL,TANGENT,COLOR,UV0-UV5; readback=PASS");
        return mesh;
    }
    static void ValidatePreviewMesh(Mesh mesh, Profile p, byte[] s0, byte[] s1, byte[] constants, byte[] ib)
    {
        if (mesh == null || mesh.vertexCount != p.vertexCount || mesh.GetIndexCount(0) != p.draw.indexCount)
            throw new InvalidDataException("EID" + p.eid + " mesh count readback mismatch");
        if (mesh.vertices.Length != p.vertexCount || mesh.normals.Length != p.vertexCount ||
            mesh.tangents.Length != p.vertexCount || mesh.colors.Length != p.vertexCount)
            throw new InvalidDataException("EID" + p.eid + " standard vertex channel length mismatch");
        var uv = new List<Vector4>[6];
        for (int c = 0; c < uv.Length; ++c)
        {
            uv[c] = new List<Vector4>(p.vertexCount);
            mesh.GetUVs(c, uv[c]);
            if (uv[c].Count != p.vertexCount)
                throw new InvalidDataException("EID" + p.eid + " UV" + c + " length=" + uv[c].Count + " expected=" + p.vertexCount);
        }
        Vector4 expectedTangent = DecodeUNorm8(ReadUInt32(constants, 12));
        Vector4 expectedColor = DecodeUNorm8(ReadUInt32(constants, 4));
        Vector4 expectedUv4 = DecodeUNorm8(ReadUInt32(constants, 16));
        Vector4 expectedUv5 = new Vector4(constants[0], constants[1], constants[2], constants[3]);
        int stride = Stream1Stride(p);
        int[] idx = mesh.GetIndices(0);
        for (int i = 0; i < p.vertexCount; ++i)
        {
            int p0 = i * 16;
            int p1 = i * stride;
            Vector3 expectedPosition = new Vector3(ReadFloat(s0, p0), ReadFloat(s0, p0 + 4), ReadFloat(s0, p0 + 8));
            Vector2 a = new Vector2(ReadFloat(s1, p1), ReadFloat(s1, p1 + 4));
            Vector2 b = stride >= 16 ? new Vector2(ReadFloat(s1, p1 + 8), ReadFloat(s1, p1 + 12)) : a;
            Vector3 actualNormal = mesh.normals[i];
            if ((mesh.vertices[i] - expectedPosition).sqrMagnitude > 1e-12f)
                throw new InvalidDataException("EID" + p.eid + " POSITION mismatch at vertex " + i);
            if (BitConverter.SingleToInt32Bits(actualNormal.x) != BitConverter.SingleToInt32Bits(ReadFloat(s0, p0 + 12)))
                throw new InvalidDataException("EID" + p.eid + " NORMAL packed bits mismatch at vertex " + i);
            if ((mesh.tangents[i] - expectedTangent).sqrMagnitude > 1e-10f || ((Vector4)mesh.colors[i] - expectedColor).sqrMagnitude > 1e-8f)
                throw new InvalidDataException("EID" + p.eid + " TANGENT/COLOR mismatch at vertex " + i);
            if ((new Vector4(uv[0][i].x, uv[0][i].y, 0f, 0f) - new Vector4(a.x, a.y, 0f, 0f)).sqrMagnitude > 1e-10f)
                throw new InvalidDataException("EID" + p.eid + " UV0 mismatch at vertex " + i);
            for (int c = 1; c <= 2; ++c)
                if ((uv[c][i] - new Vector4(b.x, b.y, 0f, 0f)).sqrMagnitude > 1e-10f)
                    throw new InvalidDataException("EID" + p.eid + " UV" + c + " mismatch at vertex " + i);
            if ((uv[3][i] - new Vector4(b.x, b.y, 0f, 1f)).sqrMagnitude > 1e-10f)
                throw new InvalidDataException("EID" + p.eid + " UV3 mismatch at vertex " + i);
            if ((uv[4][i] - expectedUv4).sqrMagnitude > 1e-10f || (uv[5][i] - expectedUv5).sqrMagnitude > 1e-8f)
                throw new InvalidDataException("EID" + p.eid + " UV4/UV5 mismatch at vertex " + i);
        }
        for (int i = 0; i < idx.Length; ++i)
        {
            int expected = BitConverter.ToUInt16(ib, i * 2);
            if (idx[i] != expected || idx[i] < 0 || idx[i] >= p.vertexCount)
                throw new InvalidDataException("EID" + p.eid + " index mismatch at " + i + " actual=" + idx[i] + " expected=" + expected);
        }
    }

    static void ValidatePersistedMeshes(List<Profile> todo, StringBuilder report)
    {
        foreach (Profile p in todo)
        {
            string meshPath = Root + "/Geometry/Meshes/EID" + p.eid + "_RawPreview.asset";
            Mesh mesh = AssetDatabase.LoadAssetAtPath<Mesh>(meshPath);
            if (mesh == null) throw new InvalidDataException("EID" + p.eid + " persisted mesh missing: " + meshPath);
            byte[] s0 = ReadManifestFile(p.files.vertexStream0.file);
            byte[] s1 = ReadManifestFile(p.files.vertexStream1.file);
            byte[] constants = ReadManifestFile(p.files.vertexStream3.file);
            byte[] ib = ReadManifestFile(p.files.indices.file);
            ValidatePreviewMesh(mesh, p, s0, s1, constants, ib);
            ValidateVertexDeclaration(mesh, p);
            report.AppendLine("EID" + p.eid + ": persisted vertex attributes=PASS (POSITION,NORMAL,TANGENT,COLOR,UV0-UV5; index order preserved; native declaration verified)");
        }
    }

    static void ValidateVertexDeclaration(Mesh mesh, Profile p)
    {
        VertexAttributeDescriptor[] actual = mesh.GetVertexAttributes();
        VertexAttributeDescriptor[] expected =
        {
            new VertexAttributeDescriptor(VertexAttribute.Position, VertexAttributeFormat.Float32, 3, 0),
            new VertexAttributeDescriptor(VertexAttribute.Normal, VertexAttributeFormat.Float32, 1, 0),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord0, VertexAttributeFormat.Float32, 2, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord1, VertexAttributeFormat.Float32, 2, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord2, VertexAttributeFormat.Float32, 2, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord3, VertexAttributeFormat.Float32, 4, 1),
            new VertexAttributeDescriptor(VertexAttribute.Tangent, VertexAttributeFormat.UNorm8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.Color, VertexAttributeFormat.UNorm8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord4, VertexAttributeFormat.UNorm8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord5, VertexAttributeFormat.UInt8, 4, 3),
        };
        if (actual == null || actual.Length != expected.Length)
            throw new InvalidDataException("EID" + p.eid + " native vertex declaration count=" + (actual == null ? 0 : actual.Length) + " expected=" + expected.Length);
        // Unity returns descriptors in VertexAttribute enum order, not the
        // descriptor-array order supplied above. Compare by semantic.
        foreach (VertexAttributeDescriptor e in expected)
        {
            VertexAttributeDescriptor a = actual.FirstOrDefault(x => x.attribute == e.attribute);
            if (a.attribute != e.attribute || a.format != e.format || a.dimension != e.dimension || a.stream != e.stream)
                throw new InvalidDataException("EID" + p.eid + " native vertex declaration mismatch for " + e.attribute + ": actual=" + a + " expected=" + e);
        }
        int[] expectedStrides = { 16, 40, 12, 4 };
        for (int stream = 0; stream < expectedStrides.Length; ++stream)
        {
            int stride = mesh.GetVertexBufferStride(stream);
            if (stride != expectedStrides[stream])
                throw new InvalidDataException("EID" + p.eid + " native vertex stream" + stream + " stride=" + stride + " expected=" + expectedStrides[stream]);
        }
    }

    static void AttachProfileToScene(Profile p, EID3332CombinedDrawProfile profile, Material material, Mesh mesh, StringBuilder report)
    {
        Scene scene = EditorSceneManager.OpenScene(TargetScene, OpenSceneMode.Single);
        EID3332CombinedDeferredController deferred = UnityEngine.Object.FindObjectOfType<EID3332CombinedDeferredController>(true);
        Transform batchParent = deferred != null && deferred.eid3336Root != null
            ? deferred.eid3336Root
            : FindTransform(scene, "ColourPass6_VS209986_PS209987");
        Transform parent = batchParent.Find("EID" + p.eid);
        GameObject eidRoot = parent != null ? parent.gameObject : new GameObject("EID" + p.eid);
        if (parent == null) eidRoot.transform.SetParent(batchParent, false);
        parent = eidRoot.transform;
        parent.name = "EID" + p.eid;
        int expected = p.draw.instanceCount;
        for (int i = 0; i < expected; ++i)
        {
            string name = "EID" + p.eid + "_instance_" + i.ToString("000", CultureInfo.InvariantCulture);
            Transform t = parent.Find(name);
            GameObject go = t != null ? t.gameObject : new GameObject(name);
            if (t == null) { go.transform.SetParent(parent, false); }
            MeshFilter mf = go.GetComponent<MeshFilter>();
            if (mf == null) mf = go.AddComponent<MeshFilter>();
            MeshRenderer mr = go.GetComponent<MeshRenderer>();
            if (mr == null) mr = go.AddComponent<MeshRenderer>();
            mf.sharedMesh = mesh;
            mr.sharedMaterial = material;
            mr.shadowCastingMode = ShadowCastingMode.Off;
            mr.receiveShadows = false;
            mr.enabled = true;
            Matrix4x4 captured = ReadCapturedMatrix(p, i);
            ApplyWorldMatrix(go.transform, captured);
        }
        // Remove stale preview instances if a previous manifest had more.
        for (int i = parent.childCount - 1; i >= expected; --i)
            if (parent.GetChild(i).name.StartsWith("EID" + p.eid + "_instance_", StringComparison.Ordinal))
                UnityEngine.Object.DestroyImmediate(parent.GetChild(i).gameObject);
        EditorSceneManager.MarkSceneDirty(scene);
        EditorSceneManager.SaveScene(scene, TargetScene);
        report.AppendLine("EID" + p.eid + ": scene nodes=" + expected);
    }

    static void UpdateTargetSceneBindings(List<Profile> todo, StringBuilder report)
    {
        Scene scene = EditorSceneManager.OpenScene(TargetScene, OpenSceneMode.Single);
        EID3332CombinedSceneMRTController mrt = UnityEngine.Object.FindObjectOfType<EID3332CombinedSceneMRTController>(true);
        if (mrt == null)
        {
            EID3332CombinedDeferredController deferred = UnityEngine.Object.FindObjectOfType<EID3332CombinedDeferredController>(true);
            if (deferred == null) throw new InvalidOperationException("No deferred controller in " + TargetScene);
            deferred.RefreshRenderers();
            EditorUtility.SetDirty(deferred);
            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene, TargetScene);
            report.AppendLine("existing deferred controller refreshed; shared MRT controller not replaced");
            return;
        }
        var bindings = (mrt.bindings ?? Array.Empty<EID3332CombinedSceneMRTController.ProfileBinding>()).ToList();
        foreach (Profile p in todo)
        {
            Transform root = FindTransform(scene, "ColourPass6_VS209986_PS209987/EID" + p.eid);
            if (root == null) throw new InvalidOperationException("Scene root missing for EID" + p.eid);
            string profilePath = Root + "/Profiles/EID" + p.eid + "_DrawProfile.asset";
            string matPath = Root + "/Materials/EID" + p.eid + "_VS209986_PS209987.mat";
            EID3332CombinedDrawProfile profile = AssetDatabase.LoadAssetAtPath<EID3332CombinedDrawProfile>(profilePath);
            Material material = AssetDatabase.LoadAssetAtPath<Material>(matPath);
            if (profile == null || material == null) throw new InvalidOperationException("Generated assets missing for EID" + p.eid);
            EID3332CombinedSceneMaterialResources resources = FindResourceComponent(mrt.gameObject, p.eid);
            if (resources == null) resources = mrt.gameObject.AddComponent<EID3332CombinedSceneMaterialResources>();
            resources.material = material;
            resources.constantResourceRoot = "EID3336CB";
            resources.vertexResourceRoot = "EID" + p.eid + "VS";
            resources.useCapturedInstanceTransforms = true;
            resources.sceneModelDataAlreadyWorldSpace = false;
            resources.sceneModelApplyExportMirrorX = false;
            resources.Reload();
            var binding = bindings.FirstOrDefault(x => x != null && x.profile != null && x.profile.eventId == p.eid);
            if (binding == null)
            {
                binding = new EID3332CombinedSceneMRTController.ProfileBinding();
                bindings.Add(binding);
            }
            binding.profile = profile;
            binding.modelRoot = root;
            binding.material = material;
            binding.resources = resources;
            Renderer[] rs = root.GetComponentsInChildren<Renderer>(true).OrderBy(x => x.name, StringComparer.Ordinal).ToArray();
            binding.renderers = rs;
            binding.instanceTransforms = rs.Select(x => x.transform).ToArray();
            binding.instanceTransformReferences = rs.Select(x => x.transform.localToWorldMatrix).ToArray();
        }
        mrt.bindings = bindings.ToArray();
        mrt.Refresh();
        EditorUtility.SetDirty(mrt);
        EditorSceneManager.MarkSceneDirty(scene);
        EditorSceneManager.SaveScene(scene, TargetScene);
        report.AppendLine("controller bindings updated=" + todo.Count);
    }

    static EID3332CombinedSceneMaterialResources FindResourceComponent(GameObject host, int eid)
    {
        foreach (var r in host.GetComponents<EID3332CombinedSceneMaterialResources>())
        {
            if (r != null && r.vertexResourceRoot == "EID" + eid + "VS") return r;
        }
        return null;
    }

    static Transform FindTransform(Scene scene, string path)
    {
        string[] parts = path.Split('/');
        foreach (GameObject root in scene.GetRootGameObjects())
        {
            if (root.name != parts[0]) continue;
            Transform t = root.transform;
            for (int i = 1; i < parts.Length && t != null; ++i) t = t.Find(parts[i]);
            if (t != null) return t;
        }
        // First-run root creation is allowed.
        if (parts.Length > 0 && parts[0] == "ColourPass6_VS209986_PS209987")
        {
            GameObject root = scene.GetRootGameObjects().FirstOrDefault(x => x.name == parts[0]);
            if (root == null) { root = new GameObject(parts[0]); SceneManager.MoveGameObjectToScene(root, scene); }
            Transform t = root.transform;
            for (int i = 1; i < parts.Length; ++i)
            {
                Transform child = t.Find(parts[i]);
                if (child == null) { GameObject go = new GameObject(parts[i]); go.transform.SetParent(t, false); child = go.transform; }
                t = child;
            }
            return t;
        }
        return null;
    }

    static Matrix4x4 ReadCapturedMatrix(Profile p, int instance)
    {
        string path = FindFile(p, "VS_uniforms30.bytes");
        byte[] data = ReadManifestFile(path);
        int offset = instance * 256;
        if (offset + 64 > data.Length) return Matrix4x4.identity;
        Matrix4x4 m = Matrix4x4.identity;
        for (int c = 0; c < 4; ++c)
            for (int r = 0; r < 4; ++r)
                m[r, c] = ReadFloat(data, offset + (c * 4 + r) * 4);
        return m;
    }

    static void ApplyWorldMatrix(Transform t, Matrix4x4 m)
    {
        Vector3 x = m.GetColumn(0), y = m.GetColumn(1), z = m.GetColumn(2);
        Vector3 p = m.GetColumn(3);
        float sx = x.magnitude, sy = y.magnitude, sz = z.magnitude;
        if (sx < 1e-6f || sy < 1e-6f || sz < 1e-6f) { t.SetPositionAndRotation(p, Quaternion.identity); t.localScale = Vector3.one; return; }
        Vector3 scale = new Vector3(sx, sy, sz);
        if (Vector3.Dot(Vector3.Cross(x / sx, y / sy), z / sz) < 0f) scale.z = -scale.z;
        t.SetPositionAndRotation(p, Quaternion.LookRotation(z / sz, y / sy));
        t.localScale = scale;
    }

    static int ParseResourcePropertyId(string resourceName)
    {
        if (string.IsNullOrEmpty(resourceName) || !resourceName.StartsWith("res", StringComparison.OrdinalIgnoreCase)) return 0;
        return int.TryParse(resourceName.Substring(3), NumberStyles.Integer, CultureInfo.InvariantCulture, out int value) ? value : 0;
    }

    static Texture LoadTextureAny(int rid)
    {
        if (rid == 198300 || rid == 198309)
        {
            string arrayPath = "Assets/EID3332_EID3336_Combined/Resources/EID3490Textures/rid" + rid + "_array.asset";
            Texture2DArray array = AssetDatabase.LoadAssetAtPath<Texture2DArray>(arrayPath);
            if (array != null) return array;
        }
        string preferred = "Assets/EID3332_EID3336_Combined/Resources/" + SharedTextureGroup + "/rid" + rid + ".dds";
        Texture t = AssetDatabase.LoadAssetAtPath<Texture>(preferred);
        if (t != null) return t;
        string preferredPng = "Assets/EID3332_EID3336_Combined/Resources/" + SharedTextureGroup + "/rid" + rid + ".png";
        t = AssetDatabase.LoadAssetAtPath<Texture>(preferredPng);
        if (t != null) return t;
        string[] guids = AssetDatabase.FindAssets("rid" + rid);
        foreach (string g in guids)
        {
            string path = AssetDatabase.GUIDToAssetPath(g);
            t = AssetDatabase.LoadAssetAtPath<Texture>(path);
            if (t != null && (t is Texture2D || t is Texture2DArray)) return t;
        }
        return null;
    }

    static Texture2D LoadTexture(int rid) => LoadTextureAny(rid) as Texture2D;
    static int GetRid(Dictionary<string, int> map, string name) => map.TryGetValue(name, out int v) ? v : 0;
    static int RidByName(Profile p, string name, int fallback) => p.textures == null ? fallback : (p.textures.FirstOrDefault(x => x != null && x.name == name)?.rid ?? fallback);

    static string FindFile(Profile p, string fileName)
    {
        string[] candidates = { p.files?.indices?.file, p.files?.vertexStream0?.file, p.files?.vertexStream1?.file, p.files?.vertexStream3?.file };
        // Constant files are not part of FileSet in the compact importer model;
        // resolve them directly from the profile directory.
        string direct = Root + "/Captured/EID" + p.eid + "/" + fileName;
        if (File.Exists(Absolute(direct))) return direct;
        return direct;
    }

    static byte[] ReadManifestFile(string rel)
    {
        if (string.IsNullOrEmpty(rel)) throw new FileNotFoundException("Empty manifest file reference");
        string normalized = rel.Replace('\\', '/');
        string path = normalized.StartsWith("Assets/", StringComparison.OrdinalIgnoreCase)
            ? Absolute(normalized)
            : Absolute(Root + "/" + normalized.TrimStart('/'));
        if (!File.Exists(path)) throw new FileNotFoundException("Manifest referenced file missing: " + rel, path);
        return File.ReadAllBytes(path);
    }

    static void CopyBytes(string manifestPath, string destination)
    {
        if (string.IsNullOrEmpty(manifestPath)) throw new FileNotFoundException("Missing byte-file reference");
        byte[] data = ReadManifestFile(manifestPath);
        Directory.CreateDirectory(Path.GetDirectoryName(destination));
        if (!File.Exists(destination) || !File.ReadAllBytes(destination).SequenceEqual(data)) File.WriteAllBytes(destination, data);
    }

    static void CopyExistingIfMissing(string assetPath, string destination)
    {
        string src = Absolute(assetPath);
        Directory.CreateDirectory(Path.GetDirectoryName(destination));
        if (!File.Exists(src)) throw new FileNotFoundException("Shared constant missing", src);
        if (!File.Exists(destination) || !File.ReadAllBytes(destination).SequenceEqual(File.ReadAllBytes(src))) File.Copy(src, destination, true);
    }

    static void ImportBytes(string directory, string fileName)
    {
        string full = Path.Combine(directory, fileName);
        string asset = ToAssetPath(full);
        AssetDatabase.ImportAsset(asset, ImportAssetOptions.ForceSynchronousImport);
    }

    static Vector4 ReadVector4(byte[] b, int o) => new Vector4(ReadFloat(b, o), ReadFloat(b, o + 4), ReadFloat(b, o + 8), ReadFloat(b, o + 12));
    static float ReadFloat(byte[] b, int o) => BitConverter.ToSingle(b, o);
    static uint ReadUInt32(byte[] b, int o) => BitConverter.ToUInt32(b, o);
    static float UIntAsFloat(uint value) => BitConverter.ToSingle(BitConverter.GetBytes(value), 0);
    static Vector4 DecodeUNorm8(uint value) => new Vector4(value & 255u, (value >> 8) & 255u, (value >> 16) & 255u, (value >> 24) & 255u) / 255f;

    static string Absolute(string projectRelative) => Path.Combine(Directory.GetParent(Application.dataPath).FullName, projectRelative.Replace('/', Path.DirectorySeparatorChar));
    static string ToAssetPath(string full) => "Assets" + full.Substring(Absolute("Assets").Length).Replace(Path.DirectorySeparatorChar, '/');
    static void EnsureParent(string assetPath) => Directory.CreateDirectory(Path.GetDirectoryName(Absolute(assetPath)));
    [MenuItem("Tools/Colour Pass 6/Validate Imported EIDs")]
    public static void ValidateImportedEIDs()
    {
        Scene scene = EditorSceneManager.OpenScene(TargetScene, OpenSceneMode.Single);
        EID3332CombinedDeferredController deferred = UnityEngine.Object.FindObjectOfType<EID3332CombinedDeferredController>(true);
        if (deferred == null || deferred.eid3336Root == null) throw new InvalidOperationException("Target scene deferred controller/eid3336Root is missing.");
        Manifest manifest = LoadManifest();
        var report = new StringBuilder();
        int totalRenderers = 0;
        foreach (Profile p in manifest.profiles.Where(x => x != null && !Skipped.Contains(x.eid) && !x.skipExisting))
        {
            Transform root = deferred.eid3336Root.Find("EID" + p.eid);
            if (root == null) throw new InvalidOperationException("Missing scene root EID" + p.eid);
            Renderer[] rs = root.GetComponentsInChildren<Renderer>(true);
            if (rs.Length != p.draw.instanceCount) throw new InvalidOperationException("EID" + p.eid + " renderer count=" + rs.Length + " expected=" + p.draw.instanceCount);
            Material mat = rs.Length > 0 ? rs[0].sharedMaterial : null;
            if (mat == null || mat.shader == null || mat.shader.name != "EID3336/URP/RenderDocGBufferIndependent")
                throw new InvalidOperationException("EID" + p.eid + " material/shader binding is invalid");
            totalRenderers += rs.Length;
            report.AppendLine("EID" + p.eid + " PASS renderers=" + rs.Length + " material=" + mat.name + " stride=" + Stream1Stride(p));
        }
        report.AppendLine("validation=PASS");
        report.AppendLine("totalRenderers=" + totalRenderers);
        File.AppendAllText(Absolute(ReportFile), report.ToString(), Encoding.UTF8);
        Debug.Log("[ColourPass6 Batch] VALIDATION PASS, renderers=" + totalRenderers);
    }
    static void EnsureFolders()
    {
        foreach (string dir in new[] { Root + "/Editor", Root + "/Materials", Root + "/Profiles", Root + "/Geometry/Meshes", Root + "/Resources" })
            Directory.CreateDirectory(Absolute(dir));
    }
}
#endif











