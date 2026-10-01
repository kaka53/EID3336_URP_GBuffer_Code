
using System;
using System.IO;
using System.Collections.Generic;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using UnityEngine.Experimental.Rendering;
using EID4730;

public static class EID4812Reconstruction
{
    const string Root = "Assets/EID4812_RenderDocRestore";
    const string Captured = Root + "/Captured";
    const string MeshPath = Root + "/EID4812_Mesh.asset";
    const string MaterialPath = Root + "/M_EID4812.mat";
    const string ShaderPath = Root + "/Shaders/EID4812_CharacterForward.shader";
    const string ReplayShaderPath = Root + "/StreamingAssets/replay.json";
    const string ScenePath = "Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
    const int EID4730FeatureFileId = 11400000;
    const string Tag = "CharacterForward";

    [MenuItem("Tools/EID4812/Build mesh, material, and add to target scene %#e")]
    public static void Build()
    {
        var meshMeta = JsonUtility.FromJson<MeshMeta>(File.ReadAllText(Path.Combine(Captured, "mesh_manifest.json")));
        var manifest = JsonUtility.FromJson<CaptureMeta>(File.ReadAllText(Path.Combine(Captured, "capture_manifest.json")));
        var indicesBytes = ReadBytes(meshMeta.indexFile);
        if (indicesBytes.Length != meshMeta.indexCount * 4)
            throw new InvalidDataException("EID4812 index stream length does not match the manifest.");

        var source = ReadCapturedBuffer(manifest, 207368);
        var generic = ReadCapturedBuffer(manifest, 155);
        var slot0 = FindVertexBuffer(manifest, 0, 16, 10685408);
        var slot1 = FindVertexBuffer(manifest, 1, 8, 10839520);
        var slot2 = FindVertexBuffer(manifest, 2, 12, 10916576);
        var slot3 = FindVertexBuffer(manifest, 3, 16, 10685408);
        var slot4 = FindVertexBuffer(manifest, 4, 0, 0);
        byte[] instanceCB = ReadStreamingBytes("VS_rid526_off4111616_size65536.bin");
        byte[] skinBuffer = ReadStreamingBytes("rid261_off0_size8413184.bin");
        uint flags = U32(instanceCB, 76);
        if ((flags & 32u) == 0u) throw new InvalidDataException("EID4812 does not have captured skinning enabled.");

        // Mirror the proven EID1727 layout strategy: bake the capture-time skinned pose into
        // the Unity mesh while retaining every original EID4812 IA attribute in auxiliary channels.
        const int stream0Stride = 24; // baked position + baked normal
        const int stream1Stride = 72; // original color/UV/packed words/position alias + baked tangent + raw position
        const int stream2Stride = 12; // original UNorm16 weights + UInt8 joints
        var stream0 = new byte[meshMeta.vertexCount * stream0Stride];
        var stream1 = new byte[meshMeta.vertexCount * stream1Stride];
        var stream2 = new byte[meshMeta.vertexCount * stream2Stride];
        var bakedPositions = new Vector3[meshMeta.vertexCount];
        Vector4 genericColor = DecodeUNorm8(generic, slot4.byteOffset + 12);

        for (int i = 0; i < meshMeta.vertexCount; i++)
        {
            int p0 = slot0.byteOffset + i * slot0.byteStride;
            int uv = slot1.byteOffset + i * slot1.byteStride;
            int skin = slot2.byteOffset + i * slot2.byteStride;
            int alias = slot3.byteOffset + i * slot3.byteStride;
            Vector3 rawPosition = new Vector3(F32(source, p0), F32(source, p0 + 4), F32(source, p0 + 8));
            Vector4 weights = DecodeUNorm16(source, skin);
            DecodeBasis(U32(source, p0 + 12), genericColor, out Vector3 normal, out Vector4 tangent);
            SkinVertex(instanceCB, skinBuffer, rawPosition, normal, tangent, source, skin + 8,
                weights, out Vector3 bakedPosition, out Vector3 bakedNormal, out Vector4 bakedTangent);
            bakedPositions[i] = bakedPosition;

            int d0 = i * stream0Stride;
            WriteVector3(stream0, d0, bakedPosition);
            WriteVector3(stream0, d0 + 12, bakedNormal);

            int d1 = i * stream1Stride;
            Copy(generic, slot4.byteOffset + 12, stream1, d1 + 0, 4);       // _input3 COLOR
            Copy(source, uv, stream1, d1 + 4, 8);                           // _input1 TEXCOORD0
            Copy(source, p0 + 12, stream1, d1 + 12, 4);                    // _input2 packed word
            Copy(source, uv, stream1, d1 + 16, 8);                          // _input4 duplicate UV
            Copy(source, alias + 12, stream1, d1 + 24, 4);                 // _input6 packed word
            Copy(source, alias + 12, stream1, d1 + 28, 4);                 // _input7 packed word alias
            Copy(source, alias, stream1, d1 + 32, 12);                     // _input5 original position alias
            WriteVector4(stream1, d1 + 44, bakedTangent);                  // baked tangent override
            Copy(source, p0, stream1, d1 + 60, 12);                        // preserved original _input0

            int d2 = i * stream2Stride;
            Copy(source, skin, stream2, d2, 8);                            // _input8 UNorm16 weights
            Copy(source, skin + 8, stream2, d2 + 8, 4);                    // _input9 UInt8 joints
        }

        var indices = new uint[meshMeta.indexCount];
        for (int i = 0; i < indices.Length; i++) indices[i] = U32(indicesBytes, i * 4);
        ValidateAgainstEID1727(bakedPositions, indices);

        var mesh = new Mesh { name = "EID4812_VSInput_BakedCapturedSkinning" };
        mesh.indexFormat = IndexFormat.UInt32;
        mesh.SetVertexBufferParams(meshMeta.vertexCount,
            new VertexAttributeDescriptor(VertexAttribute.Position, VertexAttributeFormat.Float32, 3, 0),
            new VertexAttributeDescriptor(VertexAttribute.Normal, VertexAttributeFormat.Float32, 3, 0),
            new VertexAttributeDescriptor(VertexAttribute.Color, VertexAttributeFormat.UNorm8, 4, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord0, VertexAttributeFormat.Float32, 2, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord1, VertexAttributeFormat.Float32, 1, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord2, VertexAttributeFormat.Float32, 2, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord3, VertexAttributeFormat.Float32, 1, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord4, VertexAttributeFormat.Float32, 1, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord5, VertexAttributeFormat.Float32, 3, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord6, VertexAttributeFormat.Float32, 4, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord7, VertexAttributeFormat.Float32, 3, 1),
            new VertexAttributeDescriptor(VertexAttribute.BlendWeight, VertexAttributeFormat.UNorm16, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.BlendIndices, VertexAttributeFormat.UInt8, 4, 2));
        mesh.SetVertexBufferData(stream0, 0, 0, stream0.Length, 0, MeshUpdateFlags.DontValidateIndices | MeshUpdateFlags.DontRecalculateBounds);
        mesh.SetVertexBufferData(stream1, 0, 0, stream1.Length, 1, MeshUpdateFlags.DontValidateIndices | MeshUpdateFlags.DontRecalculateBounds);
        mesh.SetVertexBufferData(stream2, 0, 0, stream2.Length, 2, MeshUpdateFlags.DontValidateIndices | MeshUpdateFlags.DontRecalculateBounds);
        mesh.SetIndexBufferParams(indices.Length, IndexFormat.UInt32);
        mesh.SetIndexBufferData(indices, 0, 0, indices.Length, MeshUpdateFlags.DontValidateIndices | MeshUpdateFlags.DontRecalculateBounds);
        mesh.subMeshCount = 1;
        mesh.SetSubMesh(0, new SubMeshDescriptor(0, indices.Length, MeshTopology.Triangles), MeshUpdateFlags.DontValidateIndices | MeshUpdateFlags.DontRecalculateBounds);
        mesh.RecalculateBounds();
        CreateOrReplaceAsset(mesh, MeshPath);
        var shader = AssetDatabase.LoadAssetAtPath<Shader>(ShaderPath);
        if (shader == null) throw new InvalidOperationException("Shader failed import: " + ShaderPath);
        var mat = new Material(shader) { name = "M_EID4812", enableInstancing = false };
        using (var replaySession = new EID4812ReplaySession(ReplayShaderPath, false))
        {
            // Only persist textures. This temporary session is disposed below;
            // GPU buffers are supplied just-in-time by EID4730RenderFeature.
            PersistTextures(replaySession, mat);
        }
        CreateOrReplaceAsset(mat, MaterialPath);
        mat.SetFloat("_EIDIndexCount", meshMeta.indexCount);
        mat.SetFloat("_EIDVertexCount", meshMeta.vertexCount);
        mat.SetFloat("_EIDCaptureEvent", manifest.eventId);
        mat.SetFloat("_EIDObjectMatrixMode", 1f);
        mat.SetFloat("_EIDLiveViewProjection", 1f);
        mat.SetFloat("_Cull", (float)CullMode.Off);
        

        var scene = EditorSceneManager.OpenScene(ScenePath, OpenSceneMode.Single);
        var renderFeature = FindEID4730Feature();
        if (renderFeature == null)
            throw new InvalidOperationException("The active URP RendererData does not contain EID4730RenderFeature. Not creating a fallback renderer or silently using another feature.");

        const string rootName = "RenderDocRestore_EID4812";
        var old = GameObject.Find(rootName);
        if (old != null) UnityEngine.Object.DestroyImmediate(old);
        var parent = new GameObject(rootName); // same identity grouping pattern as EID1727
        var model = new GameObject("EID4812_instance_000");
        model.transform.SetParent(parent.transform, false);
        Matrix4x4 capturedM = ReadCapturedObjectMatrix();
        ApplyWorldMatrix(model.transform, capturedM);
        var filter = model.AddComponent<MeshFilter>(); filter.sharedMesh = mesh;
        var renderer = model.AddComponent<MeshRenderer>();
        renderer.sharedMaterial = mat;
        renderer.shadowCastingMode = ShadowCastingMode.Off;
        renderer.receiveShadows = false;
        renderer.motionVectorGenerationMode = MotionVectorGenerationMode.ForceNoMotion;

        EID4812DepthStateRepair.DisableDuplicateGBuffer();
        EditorSceneManager.MarkSceneDirty(scene);
        if (!EditorSceneManager.SaveScene(scene)) throw new IOException("Failed to save target scene.");
        AssetDatabase.SaveAssets();
        Debug.Log($"[EID4812] Built {mesh.vertexCount} vertices / {indices.Length} indices. LightMode={Tag}; Feature={renderFeature.name}; shader={shader.name}; M={model.transform.localToWorldMatrix}; bakedSkin=1; EID1727Reference=PASS; Unity live VP.");
    }

    static ScriptableRendererFeature FindEID4730Feature()
    {
        var pipeline = GraphicsSettings.currentRenderPipeline as UniversalRenderPipelineAsset;
        if (pipeline == null) return null;
        var field = typeof(UniversalRenderPipelineAsset).GetField("m_RendererDataList", System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic);
        var renderers = field?.GetValue(pipeline) as ScriptableRendererData[];
        if (renderers == null) return null;
        foreach (var data in renderers)
        {
            if (data == null) continue;
            var features = data.rendererFeatures;
            foreach (var feature in features)
                if (feature != null && feature.GetType().FullName == "EID4730.EID4730RenderFeature") return feature;
        }
        return null;
    }

    const string EID1727ReferenceMeshPath = "Assets/ColourPass6_VS239789_PS239790_Batch/Geometry/Meshes/EID1727_VSInput.asset";

    static byte[] ReadStreamingBytes(string file)
    {
        string directory = Path.GetFullPath(Root + "/StreamingAssets") + Path.DirectorySeparatorChar;
        string path = Path.GetFullPath(Path.Combine(directory, file));
        if (!path.StartsWith(directory, StringComparison.OrdinalIgnoreCase)) throw new InvalidDataException("Streaming path escape: " + file);
        return File.ReadAllBytes(path);
    }

    static void ValidateAgainstEID1727(Vector3[] positions, uint[] indices)
    {
        Mesh reference = AssetDatabase.LoadAssetAtPath<Mesh>(EID1727ReferenceMeshPath);
        if (reference == null) throw new FileNotFoundException("EID1727 reference mesh is missing.", EID1727ReferenceMeshPath);
        Vector3[] rp = reference.vertices;
        if (rp.Length != positions.Length) throw new InvalidDataException("EID1727/EID4812 vertex-count mismatch.");
        float maxPositionError = 0f;
        for (int i = 0; i < positions.Length; i++) maxPositionError = Mathf.Max(maxPositionError, Vector3.Distance(positions[i], rp[i]));
        if (maxPositionError > 0.00001f) throw new InvalidDataException("EID4812 baked mesh does not match EID1727 reference; max position error=" + maxPositionError);
        int[] ri = reference.GetIndices(0);
        if (ri.Length != indices.Length) throw new InvalidDataException("EID1727/EID4812 index-count mismatch.");
        for (int i = 0; i < indices.Length; i++) if ((uint)ri[i] != indices[i]) throw new InvalidDataException("EID1727/EID4812 index mismatch at " + i);
        Debug.Log($"[EID4812] EID1727 mesh reference verified: vertices={positions.Length}, indices={indices.Length}, maxPositionError={maxPositionError:R}.");
    }

    static void ApplyWorldMatrix(Transform transform, Matrix4x4 matrix)
    {
        Vector3 x = matrix.GetColumn(0), y = matrix.GetColumn(1), z = matrix.GetColumn(2), position = matrix.GetColumn(3);
        float sx = x.magnitude, sy = y.magnitude, sz = z.magnitude;
        if (sx < 1e-7f || sy < 1e-7f || sz < 1e-7f)
        {
            transform.SetPositionAndRotation(position, Quaternion.identity);
            transform.localScale = Vector3.one;
            return;
        }
        Vector3 scale = new Vector3(sx, sy, sz);
        if (Vector3.Dot(Vector3.Cross(x / sx, y / sy), z / sz) < 0f) scale.z = -scale.z;
        transform.SetPositionAndRotation(position, Quaternion.LookRotation(z / sz, y / sy));
        transform.localScale = scale;
    }

    static Vector4 DecodeUNorm8(byte[] bytes, int offset) => new Vector4(bytes[offset] / 255f, bytes[offset + 1] / 255f, bytes[offset + 2] / 255f, bytes[offset + 3] / 255f);
    static Vector4 DecodeUNorm16(byte[] bytes, int offset) => new Vector4(BitConverter.ToUInt16(bytes, offset) / 65535f, BitConverter.ToUInt16(bytes, offset + 2) / 65535f, BitConverter.ToUInt16(bytes, offset + 4) / 65535f, BitConverter.ToUInt16(bytes, offset + 6) / 65535f);

    static void SkinVertex(byte[] instanceCB, byte[] skinBuffer, Vector3 position, Vector3 normal, Vector4 tangent,
        byte[] jointSource, int jointOffset, Vector4 weights, out Vector3 skinnedPosition, out Vector3 skinnedNormal, out Vector4 skinnedTangent)
    {
        uint flags = U32(instanceCB, 76);
        uint influences = flags & 0xFFFFFFCFu;
        uint baseIndex = U32(instanceCB, 80) + 3u; // _m2.x: current-pose matrices, matching EID1727 and VS_484.
        int count = influences >= 4u ? 4 : influences >= 2u ? 2 : 1;
        float[] ws = { weights.x, weights.y, weights.z, weights.w };
        if (count == 1) ws[0] = 1f;
        Vector4 row0 = Vector4.zero, row1 = Vector4.zero, row2 = Vector4.zero;
        for (int i = 0; i < count; i++)
        {
            uint bone = baseIndex + (uint)jointSource[jointOffset + i] * 3u;
            row0 += LoadFloat4(skinBuffer, bone) * ws[i];
            row1 += LoadFloat4(skinBuffer, bone + 1u) * ws[i];
            row2 += LoadFloat4(skinBuffer, bone + 2u) * ws[i];
        }
        Vector4 hp = new Vector4(position.x, position.y, position.z, 1f);
        skinnedPosition = new Vector3(Vector4.Dot(row0, hp), Vector4.Dot(row1, hp), Vector4.Dot(row2, hp));
        skinnedNormal = new Vector3(Vector3.Dot((Vector3)row0, normal), Vector3.Dot((Vector3)row1, normal), Vector3.Dot((Vector3)row2, normal)).normalized;
        Vector3 tangent3 = tangent;
        Vector3 transformedTangent = new Vector3(Vector3.Dot((Vector3)row0, tangent3), Vector3.Dot((Vector3)row1, tangent3), Vector3.Dot((Vector3)row2, tangent3)).normalized;
        skinnedTangent = new Vector4(transformedTangent.x, transformedTangent.y, transformedTangent.z, tangent.w);
    }

    static Vector4 LoadFloat4(byte[] bytes, uint vectorIndex)
    {
        int offset = checked((int)vectorIndex * 16);
        if (offset < 0 || offset + 16 > bytes.Length) throw new IndexOutOfRangeException("Captured skin buffer index outside payload: " + vectorIndex);
        return new Vector4(F32(bytes, offset), F32(bytes, offset + 4), F32(bytes, offset + 8), F32(bytes, offset + 12));
    }

    static void DecodeBasis(uint packed, Vector4 fallback, out Vector3 normal, out Vector4 tangent)
    {
        if ((packed & 0x40000000u) == 0u)
        {
            normal = new Vector3(BitConverter.ToSingle(BitConverter.GetBytes(packed), 0), 0f, 0f);
            tangent = fallback;
            return;
        }
        const float k = 0.0020f; // Match the verified EID1727 mesh importer.
        int xi = Sign10((packed << 22) >> 22), yi = Sign10((packed << 12) >> 22), zi = Sign10((packed << 2) >> 22);
        normal = new Vector3(xi, yi, 0f) * k;
        normal.z = 1f - Mathf.Abs(normal.x) - Mathf.Abs(normal.y);
        if (normal.z < 0f)
        {
            Vector2 q = new Vector2(1f - Mathf.Abs(normal.y), 1f - Mathf.Abs(normal.x));
            q.x *= normal.x >= 0f ? 1f : -1f;
            q.y *= normal.y >= 0f ? 1f : -1f;
            normal.x = q.x; normal.y = q.y;
        }
        normal.Normalize();
        float signed10 = zi * k;
        Vector3 seed = new Vector3(normal.y - normal.z, normal.z - normal.x, normal.x - normal.y);
        Vector3 tangent0 = (seed - Vector3.Dot(seed, normal) * normal).normalized;
        float tangentSign = signed10 < 0f ? -1f : 1f;
        float encoded = 1f - ((signed10 * tangentSign) * 2f);
        Vector2 rotation = new Vector2(encoded, tangentSign * (1f - Mathf.Abs(encoded))).normalized;
        Vector3 tangent1 = Vector3.Cross(normal, tangent0).normalized;
        Vector3 tangent3 = tangent0 * rotation.x + tangent1 * rotation.y;
        tangent = new Vector4(tangent3.x, tangent3.y, tangent3.z, ((packed >> 31) & 1u) * 2f - 1f);
    }

    static int Sign10(uint value) { int result = (int)value; return result >= 512 ? result - 1024 : result; }
    static void WriteFloat(byte[] bytes, int offset, float value) { byte[] raw = BitConverter.GetBytes(value); Buffer.BlockCopy(raw, 0, bytes, offset, 4); }
    static void WriteVector3(byte[] bytes, int offset, Vector3 value) { WriteFloat(bytes, offset, value.x); WriteFloat(bytes, offset + 4, value.y); WriteFloat(bytes, offset + 8, value.z); }
    static void WriteVector4(byte[] bytes, int offset, Vector4 value) { WriteFloat(bytes, offset, value.x); WriteFloat(bytes, offset + 4, value.y); WriteFloat(bytes, offset + 8, value.z); WriteFloat(bytes, offset + 12, value.w); }
    static Matrix4x4 ReadCapturedObjectMatrix()
    {
        const string matrixFile = Root + "/StreamingAssets/VS_rid526_off4111616_size65536.bin";
        byte[] data = File.ReadAllBytes(Path.GetFullPath(matrixFile));
        if (data.Length != 65536) throw new InvalidDataException("Unexpected EID4812 instance cbuffer size: " + data.Length);

        // RenderDoc stores the HLSL column_major float4x4 as four consecutive columns.
        var matrix = new Matrix4x4(
            new Vector4(F32(data, 0), F32(data, 4), F32(data, 8), F32(data, 12)),
            new Vector4(F32(data, 16), F32(data, 20), F32(data, 24), F32(data, 28)),
            new Vector4(F32(data, 32), F32(data, 36), F32(data, 40), F32(data, 44)),
            new Vector4(F32(data, 48), F32(data, 52), F32(data, 56), F32(data, 60)));
        if (Mathf.Abs(matrix.m30) > 1e-5f || Mathf.Abs(matrix.m31) > 1e-5f || Mathf.Abs(matrix.m32) > 1e-5f || Mathf.Abs(matrix.m33 - 1f) > 1e-5f)
            throw new InvalidDataException("EID4812 captured M is not affine.");
        if (matrix.determinant <= 0f) throw new InvalidDataException("EID4812 captured M has invalid handedness/determinant.");
        return matrix;
    }
    static byte[] ReadBytes(string relative)
    {
        string path = Path.GetFullPath(Path.Combine(Captured, relative));
        string root = Path.GetFullPath(Captured) + Path.DirectorySeparatorChar;
        if (!path.StartsWith(root, StringComparison.OrdinalIgnoreCase)) throw new InvalidDataException("Path escapes captured directory: " + relative);
        return File.ReadAllBytes(path);
    }
    static float F32(byte[] b, int o) => BitConverter.ToSingle(b, o);
    static uint U32(byte[] b, int o) => BitConverter.ToUInt32(b, o);

    [Serializable] class MeshMeta { public int vertexCount, indexCount; public string vertexFile, normalFile, indexFile; }
    [Serializable] class VertexBufferMeta { public int slot, byteOffset, byteStride, resourceInt; }
    [Serializable] class BufferFileMeta { public int resource, size; public string file; }
    [Serializable] class CaptureMeta { public int eventId; public VertexBufferMeta[] vertexBuffers; public BufferFileMeta[] bufferFiles; }

    static VertexBufferMeta FindVertexBuffer(CaptureMeta manifest, int slot, int stride, int offset)
    {
        foreach (var v in manifest.vertexBuffers)
            if (v.slot == slot && v.byteStride == stride && v.byteOffset == offset) return v;
        throw new InvalidDataException($"Missing EID4812 vertex buffer slot {slot} stride {stride} offset {offset}");
    }
    static byte[] ReadCapturedBuffer(CaptureMeta manifest, int resource)
    {
        foreach (var b in manifest.bufferFiles)
            if (b.resource == resource)
            {
                var data = ReadBytes(b.file);
                if (data.Length != b.size) throw new InvalidDataException("Captured buffer size mismatch: " + b.file);
                return data;
            }
        throw new InvalidDataException("Missing captured buffer resource " + resource);
    }
    static void Copy(byte[] source, int sourceOffset, byte[] destination, int destinationOffset, int count)
    {
        if (sourceOffset < 0 || sourceOffset + count > source.Length) throw new InvalidDataException("Vertex source range overflow");
        Buffer.BlockCopy(source, sourceOffset, destination, destinationOffset, count);
    }
    static void PersistTextures(EID4812ReplaySession session, Material mat)
    {
        const string dir = Root + "/Textures";
        if (!AssetDatabase.IsValidFolder(dir)) AssetDatabase.CreateFolder(Root, "Textures");
        foreach (var pair in session.TextureBindings)
        {
            string path = dir + "/EID4812_" + pair.Key + ".asset";
            if (AssetDatabase.LoadAssetAtPath<UnityEngine.Object>(path) != null) AssetDatabase.DeleteAsset(path);
            var copy = UnityEngine.Object.Instantiate(pair.Value);
            copy.name = "EID4812_" + pair.Key;
            copy.hideFlags = HideFlags.None;
            AssetDatabase.CreateAsset(copy, path);
            var persisted = AssetDatabase.LoadAssetAtPath<Texture>(path);
            if (persisted == null) throw new InvalidOperationException("Failed to persist texture " + pair.Key);
            mat.SetTexture(pair.Key, persisted);
        }
        AssetDatabase.SaveAssets();
    }

    static void CreateOrReplaceAsset(UnityEngine.Object asset, string path) { if (AssetDatabase.LoadAssetAtPath<UnityEngine.Object>(path) != null) AssetDatabase.DeleteAsset(path); AssetDatabase.CreateAsset(asset,path); }
}

















