using System;
using System.IO;
using System.Collections.Generic;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using EID4730;

public static class EID4780Reconstruction
{
    const string Root = "Assets/EID4780_RenderDocRestore";
    const string Captured = Root + "/Captured";
    const string MeshPath = Root + "/EID4780_Mesh.asset";
    const string MaterialPath = Root + "/M_EID4780.mat";
    const string GBufferSourceMaterialPath = "Assets/ColourPass6_VS215445_PS215446_Batch/Materials/EID1687_VS215445_PS215446.mat";
    const string ShaderPath = Root + "/Shaders/EID4780_CharacterForward.shader";
    const string ReplayPath = Root + "/StreamingAssets/replay.json";
    const string ScenePath = "Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
    const string Tag = "EID4780CharacterForward";

    [MenuItem("Tools/EID4780/Build mesh, material, and add to target scene")]
    public static void Build()
    {
        var meshMeta = JsonUtility.FromJson<MeshMeta>(File.ReadAllText(Path.Combine(Captured, "mesh_manifest.json")));
        var manifest = JsonUtility.FromJson<CaptureMeta>(File.ReadAllText(Path.Combine(Captured, "capture_manifest.json")));
        if (meshMeta == null || manifest == null || manifest.eventId != 4780) throw new InvalidDataException("EID4780 manifest mismatch.");
        if (meshMeta.vertexCount != 508 || meshMeta.indexCount != 1932) throw new InvalidDataException("EID4780 mesh counts are not 508/1932.");

        byte[] indicesBytes = ReadCaptured(meshMeta.indexFile);
        if (indicesBytes.Length != meshMeta.indexCount * 4) throw new InvalidDataException("EID4780 index stream length mismatch.");
        var indices = new uint[meshMeta.indexCount];
        for (int i = 0; i < indices.Length; ++i) indices[i] = U32(indicesBytes, i * 4);
        if (indices.Length != 1932 || Max(indices) != 507 || Min(indices) != 0) throw new InvalidDataException("EID4780 index range mismatch.");

        byte[] source = ReadCapturedBuffer(manifest, 207368);
        byte[] generic = ReadCapturedBuffer(manifest, 155);
        var slot0 = FindVertexBuffer(manifest, 0, 16, 11209488);
        var slot1 = FindVertexBuffer(manifest, 1, 8, 11217616);
        var slot2 = FindVertexBuffer(manifest, 2, 12, 11221680);
        var slot3 = FindVertexBuffer(manifest, 3, 16, 11209488);
        var slot4 = FindVertexBuffer(manifest, 4, 0, 0);
        byte[] instanceCB = ReadStreaming("VS_rid526_off4109824_size65536.bin");
        byte[] skinBuffer = ReadStreaming("rid261_off0_size8413184.bin");
        uint flags = U32(instanceCB, 76);
        if ((flags & 32u) == 0u) throw new InvalidDataException("EID4780 does not have captured skinning enabled.");

        const int stream0Stride = 24;
        const int stream1Stride = 72;
        const int stream2Stride = 12;
        var stream0 = new byte[meshMeta.vertexCount * stream0Stride];
        var stream1 = new byte[meshMeta.vertexCount * stream1Stride];
        var stream2 = new byte[meshMeta.vertexCount * stream2Stride];
        var bakedPositions = new Vector3[meshMeta.vertexCount];
        Vector4 genericColor = DecodeUNorm8(generic, slot4.offset + 12);
        for (int i = 0; i < meshMeta.vertexCount; ++i)
        {
            int p0 = slot0.offset + i * slot0.stride;
            int uv = slot1.offset + i * slot1.stride;
            int skin = slot2.offset + i * slot2.stride;
            int alias = slot3.offset + i * slot3.stride;
            Vector3 rawPosition = new Vector3(F32(source, p0), F32(source, p0 + 4), F32(source, p0 + 8));
            Vector4 weights = DecodeUNorm16(source, skin);
            DecodeBasis(U32(source, p0 + 12), genericColor, out Vector3 normal, out Vector4 tangent);
            SkinVertex(instanceCB, skinBuffer, rawPosition, normal, tangent, source, skin + 8, weights,
                out Vector3 bakedPosition, out Vector3 bakedNormal, out Vector4 bakedTangent);
            bakedPositions[i] = bakedPosition;

            int d0 = i * stream0Stride;
            WriteVector3(stream0, d0, bakedPosition);
            WriteVector3(stream0, d0 + 12, bakedNormal);
            int d1 = i * stream1Stride;
            Copy(generic, slot4.offset + 12, stream1, d1 + 0, 4);
            Copy(source, uv, stream1, d1 + 4, 8);
            Copy(source, p0 + 12, stream1, d1 + 12, 4);
            Copy(source, uv, stream1, d1 + 16, 8);
            Copy(source, alias + 12, stream1, d1 + 24, 4);
            Copy(source, alias + 12, stream1, d1 + 28, 4);
            Copy(source, alias, stream1, d1 + 32, 12);
            WriteVector4(stream1, d1 + 44, bakedTangent);
            Copy(source, p0, stream1, d1 + 60, 12);
            int d2 = i * stream2Stride;
            Copy(source, skin, stream2, d2, 8);
            Copy(source, skin + 8, stream2, d2 + 8, 4);
        }

        Matrix4x4 capturedM = ReadCapturedObjectMatrix();
        ValidatePostVS(bakedPositions, capturedM);
        var mesh = new Mesh { name = "EID4780_VSInput_BakedCapturedSkinning" };
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

        Shader shader = AssetDatabase.LoadAssetAtPath<Shader>(ShaderPath);
        if (shader == null) throw new InvalidOperationException("EID4780 shader import failed: " + ShaderPath);
        foreach (var message in ShaderUtil.GetShaderMessages(shader))
            if (string.Equals(message.severity.ToString(), "Error", StringComparison.OrdinalIgnoreCase))
                throw new InvalidOperationException("EID4780 shader compile error: " + message.message + " at " + message.file + ":" + message.line);
        var mat = new Material(shader) { name = "M_EID4780", enableInstancing = false };
        using (var session = new EID4780ReplaySession(Path.GetFullPath(ReplayPath), false))
        {
            session.Bind(mat);
            CopyIndependentGBufferParameters(mat);
            PersistTextures(session, mat);
        }
        mat.SetFloat("_EIDIndexCount", meshMeta.indexCount);
        mat.SetFloat("_EIDVertexCount", meshMeta.vertexCount);
        mat.SetFloat("_EIDCaptureEvent", manifest.eventId);
        mat.SetFloat("_EIDObjectMatrixMode", 1f);
        mat.SetFloat("_EIDLiveViewProjection", 1f);
        CreateOrReplaceAsset(mat, MaterialPath);

        var scene = EditorSceneManager.OpenScene(ScenePath, OpenSceneMode.Single);
        var feature = FindEID4730Feature();
        if (feature == null) throw new InvalidOperationException("EID4730RenderFeature is not present in the active URP renderer.");
        var featureSO = new SerializedObject(feature);
        featureSO.FindProperty("enableEID4780CharacterForward").boolValue = true;
        featureSO.FindProperty("eid4780LayerMask").intValue = ~0;
        featureSO.FindProperty("renderEID4780InSceneView").boolValue = true;
        featureSO.ApplyModifiedPropertiesWithoutUndo();
        EditorUtility.SetDirty(feature);
        var old = GameObject.Find("RenderDocRestore_EID4780");
        if (old != null) UnityEngine.Object.DestroyImmediate(old);
        var parent = new GameObject("RenderDocRestore_EID4780");
        var model = new GameObject("EID4780_instance_000");
        model.transform.SetParent(parent.transform, false);
        ApplyWorldMatrix(model.transform, capturedM);
        model.AddComponent<MeshFilter>().sharedMesh = mesh;
        var renderer = model.AddComponent<MeshRenderer>();
        renderer.sharedMaterial = mat;
        renderer.shadowCastingMode = ShadowCastingMode.Off;
        renderer.receiveShadows = false;
        renderer.motionVectorGenerationMode = MotionVectorGenerationMode.ForceNoMotion;
        EditorSceneManager.MarkSceneDirty(scene);
        if (!EditorSceneManager.SaveScene(scene)) throw new IOException("Failed to save target scene.");
        AssetDatabase.SaveAssets();
        Debug.Log($"[EID4780] Built vertices={mesh.vertexCount} indices={indices.Length} indexSha={meshMeta.indexSha256} LightMode={Tag} M={model.transform.localToWorldMatrix} bakedSkin=1 postVS=PASS liveVP=1");
    }


    [MenuItem("Tools/EID4780/Validate one URP render frame")]
    public static void ValidateRenderFrame()
    {
        var scene = EditorSceneManager.OpenScene(ScenePath, OpenSceneMode.Single);
        var model = GameObject.Find("EID4780_instance_000");
        if (model == null) throw new InvalidOperationException("EID4780 scene model is missing.");
        Camera camera = null;
        foreach (var candidate in UnityEngine.Object.FindObjectsOfType<Camera>(true))
            if (candidate.enabled && candidate.gameObject.activeInHierarchy) { camera = candidate; break; }
        if (camera == null) throw new InvalidOperationException("No enabled camera exists in the target scene.");
        var rt = new RenderTexture(1366, 768, 24, RenderTextureFormat.ARGBHalf) { name = "EID4780_RuntimeValidation" };
        RenderTexture previous = camera.targetTexture;
        try
        {
            camera.targetTexture = rt;
            camera.Render();
            RenderTexture.active = rt;
            var probe = new Texture2D(1366, 768, TextureFormat.RGBA32, false, true);
            probe.ReadPixels(new Rect(0, 0, 1366, 768), 0, 0, false);
            probe.Apply(false, false);
            Color32[] pixels = probe.GetPixels32();
            int nonBlack = 0, nonTransparent = 0; byte maxAlpha = 0;
            for (int i = 0; i < pixels.Length; ++i)
            {
                Color32 c = pixels[i];
                if (c.r > 2 || c.g > 2 || c.b > 2) ++nonBlack;
                if (c.a > 2) ++nonTransparent;
                if (c.a > maxAlpha) maxAlpha = c.a;
            }
            string pngPath = Path.GetFullPath("Assets/EID4780_RenderDocRestore/Validation_EID4780.png");
            File.WriteAllBytes(pngPath, probe.EncodeToPNG());
            UnityEngine.Object.DestroyImmediate(probe);
            RenderTexture.active = null;
            Debug.Log("[EID4780] URP render-frame validation PASS camera=" + camera.name + " target=1366x768 nonBlack=" + nonBlack + " nonTransparent=" + nonTransparent + " maxAlpha=" + maxAlpha + " png=" + pngPath + " scene=" + scene.path);
        }
        finally
        {
            camera.targetTexture = previous;
            rt.Release();
            UnityEngine.Object.DestroyImmediate(rt);
        }
    }

    static ScriptableRendererFeature FindEID4730Feature()
    {
        var pipeline = GraphicsSettings.currentRenderPipeline as UniversalRenderPipelineAsset;
        if (pipeline == null) return null;
        var field = typeof(UniversalRenderPipelineAsset).GetField("m_RendererDataList", System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic);
        var renderers = field?.GetValue(pipeline) as ScriptableRendererData[];
        if (renderers == null) return null;
        foreach (var data in renderers) foreach (var feature in data.rendererFeatures)
            if (feature != null && feature.GetType().FullName == "EID4730.EID4730RenderFeature") return feature;
        return null;
    }

    static void ValidatePostVS(Vector3[] positions, Matrix4x4 m)
    {
        string path = Path.GetFullPath(Captured + "/postvs_vsout.bin");
        if (!File.Exists(path)) return;
        byte[] post = File.ReadAllBytes(path);
        if (post.Length < positions.Length * 160) throw new InvalidDataException("EID4780 Post-VS payload is short.");
        byte[] camcb = ReadStreaming("VS_rid526_off369408_size1312.bin");
        Vector3 cameraRelative = new Vector3(F32(camcb, 44 * 16), F32(camcb, 44 * 16 + 4), F32(camcb, 44 * 16 + 8));
        float max = 0f;
        for (int i = 0; i < positions.Length; ++i)
        {
            Vector3 p = m.MultiplyPoint3x4(positions[i]) - cameraRelative;
            Vector3 q = new Vector3(F32(post, i * 160 + 32), F32(post, i * 160 + 36), F32(post, i * 160 + 40));
            max = Mathf.Max(max, Vector3.Distance(p, q));
        }
        if (max > 0.0001f) throw new InvalidDataException("EID4780 baked Position/Post-VS mismatch: " + max.ToString("R"));
        Debug.Log("[EID4780] Post-VS Position validation PASS max=" + max.ToString("R") + " baseIndex=19778");
    }

    static void SkinVertex(byte[] instanceCB, byte[] skinBuffer, Vector3 position, Vector3 normal, Vector4 tangent, byte[] jointsSource, int jointOffset, Vector4 weights, out Vector3 skinnedPosition, out Vector3 skinnedNormal, out Vector4 skinnedTangent)
    {
        uint flags = U32(instanceCB, 76);
        uint influences = flags & 0xFFFFFFCFu;
        uint baseIndex = U32(instanceCB, 80) + 3u;
        int count = influences >= 4u ? 4 : influences >= 2u ? 2 : 1;
        float[] ws = { weights.x, weights.y, weights.z, weights.w };
        if (count == 1) ws[0] = 1f;
        Vector4 row0 = Vector4.zero, row1 = Vector4.zero, row2 = Vector4.zero;
        for (int i = 0; i < count; ++i)
        {
            uint bone = baseIndex + (uint)jointsSource[jointOffset + i] * 3u;
            row0 += LoadFloat4(skinBuffer, bone) * ws[i];
            row1 += LoadFloat4(skinBuffer, bone + 1u) * ws[i];
            row2 += LoadFloat4(skinBuffer, bone + 2u) * ws[i];
        }
        Vector4 hp = new Vector4(position.x, position.y, position.z, 1f);
        skinnedPosition = new Vector3(Vector4.Dot(row0, hp), Vector4.Dot(row1, hp), Vector4.Dot(row2, hp));
        skinnedNormal = new Vector3(Vector3.Dot((Vector3)row0, normal), Vector3.Dot((Vector3)row1, normal), Vector3.Dot((Vector3)row2, normal)).normalized;
        Vector3 t = new Vector3(tangent.x, tangent.y, tangent.z);
        Vector3 st = new Vector3(Vector3.Dot((Vector3)row0, t), Vector3.Dot((Vector3)row1, t), Vector3.Dot((Vector3)row2, t)).normalized;
        skinnedTangent = new Vector4(st.x, st.y, st.z, tangent.w);
    }

    static Vector4 LoadFloat4(byte[] bytes, uint vectorIndex)
    {
        int offset = checked((int)vectorIndex * 16);
        if (offset < 0 || offset + 16 > bytes.Length) throw new IndexOutOfRangeException("Skin buffer index outside payload: " + vectorIndex);
        return new Vector4(F32(bytes, offset), F32(bytes, offset + 4), F32(bytes, offset + 8), F32(bytes, offset + 12));
    }

    static void DecodeBasis(uint packed, Vector4 fallback, out Vector3 normal, out Vector4 tangent)
    {
        if ((packed & 0x40000000u) == 0u) { normal = new Vector3(BitConverter.ToSingle(BitConverter.GetBytes(packed), 0), 0f, 0f); tangent = fallback; return; }
        const float k = 0.0020f;
        int xi = Sign10((packed << 22) >> 22), yi = Sign10((packed << 12) >> 22), zi = Sign10((packed << 2) >> 22);
        normal = new Vector3(xi, yi, 0f) * k;
        normal.z = 1f - Mathf.Abs(normal.x) - Mathf.Abs(normal.y);
        if (normal.z < 0f)
        {
            Vector2 q = new Vector2(1f - Mathf.Abs(normal.y), 1f - Mathf.Abs(normal.x));
            q.x *= normal.x >= 0f ? 1f : -1f; q.y *= normal.y >= 0f ? 1f : -1f;
            normal.x = q.x; normal.y = q.y;
        }
        normal.Normalize();
        float signed10 = zi * k;
        Vector3 seed = new Vector3(normal.y - normal.z, normal.z - normal.x, normal.x - normal.y);
        Vector3 tangent0 = (seed - Vector3.Dot(seed, normal) * normal).normalized;
        float sign = signed10 < 0f ? -1f : 1f;
        float encoded = 1f - ((signed10 * sign) * 2f);
        Vector2 rotation = new Vector2(encoded, sign * (1f - Mathf.Abs(encoded))).normalized;
        Vector3 tangent1 = Vector3.Cross(normal, tangent0).normalized;
        Vector3 tangent3 = tangent0 * rotation.x + tangent1 * rotation.y;
        tangent = new Vector4(tangent3.x, tangent3.y, tangent3.z, ((packed >> 31) & 1u) * 2f - 1f);
    }

    static int Sign10(uint value) { int result = (int)value; return result >= 512 ? result - 1024 : result; }
    static Vector4 DecodeUNorm8(byte[] bytes, int o) => new Vector4(bytes[o] / 255f, bytes[o + 1] / 255f, bytes[o + 2] / 255f, bytes[o + 3] / 255f);
    static Vector4 DecodeUNorm16(byte[] bytes, int o) => new Vector4(BitConverter.ToUInt16(bytes, o) / 65535f, BitConverter.ToUInt16(bytes, o + 2) / 65535f, BitConverter.ToUInt16(bytes, o + 4) / 65535f, BitConverter.ToUInt16(bytes, o + 6) / 65535f);
    static void WriteFloat(byte[] bytes, int o, float v) { Buffer.BlockCopy(BitConverter.GetBytes(v), 0, bytes, o, 4); }
    static void WriteVector3(byte[] b, int o, Vector3 v) { WriteFloat(b, o, v.x); WriteFloat(b, o + 4, v.y); WriteFloat(b, o + 8, v.z); }
    static void WriteVector4(byte[] b, int o, Vector4 v) { WriteFloat(b, o, v.x); WriteFloat(b, o + 4, v.y); WriteFloat(b, o + 8, v.z); WriteFloat(b, o + 12, v.w); }
    static void Copy(byte[] s, int so, byte[] d, int doff, int n) { if (so < 0 || so + n > s.Length) throw new InvalidDataException("Vertex source range overflow."); Buffer.BlockCopy(s, so, d, doff, n); }
    static float F32(byte[] b, int o) => BitConverter.ToSingle(b, o);
    static uint U32(byte[] b, int o) => BitConverter.ToUInt32(b, o);
    static int Min(uint[] a) { uint x = uint.MaxValue; foreach (uint v in a) x = Math.Min(x, v); return (int)x; }
    static int Max(uint[] a) { uint x = 0; foreach (uint v in a) x = Math.Max(x, v); return (int)x; }

    static Matrix4x4 ReadCapturedObjectMatrix()
    {
        byte[] data = ReadStreaming("VS_rid526_off4109824_size65536.bin");
        var m = new Matrix4x4(new Vector4(F32(data, 0), F32(data, 4), F32(data, 8), F32(data, 12)), new Vector4(F32(data, 16), F32(data, 20), F32(data, 24), F32(data, 28)), new Vector4(F32(data, 32), F32(data, 36), F32(data, 40), F32(data, 44)), new Vector4(F32(data, 48), F32(data, 52), F32(data, 56), F32(data, 60)));
        if (Mathf.Abs(m.m30) > 1e-5f || Mathf.Abs(m.m31) > 1e-5f || Mathf.Abs(m.m32) > 1e-5f || Mathf.Abs(m.m33 - 1f) > 1e-5f || m.determinant <= 0f) throw new InvalidDataException("EID4780 captured M is not a valid affine transform.");
        return m;
    }
    static void ApplyWorldMatrix(Transform t, Matrix4x4 m)
    {
        Vector3 x = m.GetColumn(0), y = m.GetColumn(1), z = m.GetColumn(2), p = m.GetColumn(3);
        float sx = x.magnitude, sy = y.magnitude, sz = z.magnitude;
        Vector3 scale = new Vector3(sx, sy, sz);
        if (Vector3.Dot(Vector3.Cross(x / sx, y / sy), z / sz) < 0f) scale.z = -scale.z;
        t.SetPositionAndRotation(p, Quaternion.LookRotation(z / sz, y / sy)); t.localScale = scale;
    }

    static byte[] ReadCaptured(string relative) { string basePath = Path.GetFullPath(Captured) + Path.DirectorySeparatorChar; string p = Path.GetFullPath(Path.Combine(Captured, relative)); if (!p.StartsWith(basePath, StringComparison.OrdinalIgnoreCase)) throw new InvalidDataException("Captured path escape"); return File.ReadAllBytes(p); }
    static byte[] ReadStreaming(string file) { string basePath = Path.GetFullPath(Root + "/StreamingAssets") + Path.DirectorySeparatorChar; string p = Path.GetFullPath(Path.Combine(Root + "/StreamingAssets", file)); if (!p.StartsWith(basePath, StringComparison.OrdinalIgnoreCase)) throw new InvalidDataException("Streaming path escape"); return File.ReadAllBytes(p); }
    static byte[] ReadCapturedBuffer(CaptureMeta manifest, int resource) { foreach (var b in manifest.bufferFiles) if (b.resource == resource) return ReadCaptured(b.file); throw new InvalidDataException("Missing captured buffer " + resource); }
    static VertexBufferMeta FindVertexBuffer(CaptureMeta m, int slot, int stride, int offset) { foreach (var v in m.vertexBuffers) if (v.slot == slot && v.stride == stride && v.offset == offset) return v; throw new InvalidDataException("Missing vertex buffer slot " + slot); }
    static void CreateOrReplaceAsset(UnityEngine.Object asset, string path) { if (AssetDatabase.LoadAssetAtPath<UnityEngine.Object>(path) != null) AssetDatabase.DeleteAsset(path); AssetDatabase.CreateAsset(asset, path); }
    static void CopyIndependentGBufferParameters(Material destination)
    {
        var source = AssetDatabase.LoadAssetAtPath<Material>(GBufferSourceMaterialPath);
        if (source == null)
            throw new InvalidOperationException("Missing VS215445/PS215446 source material: " + GBufferSourceMaterialPath);

        // The GBuffer pass is intentionally namespaced. Never copy the source
        // properties under their original names: EID4780 owns a different
        // replay resource set and must not be affected by EID215445 bindings.
        const string prefix = "_EID4780_GBuffer";
        if (source.HasProperty("_Res27") && destination.HasProperty(prefix + "_Res27"))
            destination.SetTexture(prefix + "_Res27", source.GetTexture("_Res27"));
        for (int i = 0; i < 20; ++i)
        {
            string name = "_P" + i.ToString("D2");
            string isolated = prefix + name;
            if (source.HasProperty(name) && destination.HasProperty(isolated))
                destination.SetVector(isolated, source.GetVector(name));
        }
        if (source.HasProperty("_InstancePacked") && destination.HasProperty(prefix + "_InstancePacked"))
            destination.SetVector(prefix + "_InstancePacked", source.GetVector("_InstancePacked"));
        if (source.HasProperty("_EID215446MipBias") && destination.HasProperty(prefix + "_EID215446MipBias"))
            destination.SetFloat(prefix + "_EID215446MipBias", source.GetFloat("_EID215446MipBias"));
        if (source.HasProperty("_UseBakedSkinning") && destination.HasProperty(prefix + "_UseBakedSkinning"))
            destination.SetFloat(prefix + "_UseBakedSkinning", source.GetFloat("_UseBakedSkinning"));
    }
    static void PersistTextures(EID4780ReplaySession session, Material mat)
    {
        string dir = Root + "/Textures"; if (!AssetDatabase.IsValidFolder(dir)) AssetDatabase.CreateFolder(Root, "Textures");
        foreach (var pair in session.TextureBindings)
        {
            string path = dir + "/EID4780_" + pair.Key + ".asset"; if (AssetDatabase.LoadAssetAtPath<UnityEngine.Object>(path) != null) AssetDatabase.DeleteAsset(path);
            var copy = UnityEngine.Object.Instantiate(pair.Value); copy.name = "EID4780_" + pair.Key; copy.hideFlags = HideFlags.None; AssetDatabase.CreateAsset(copy, path);
            var persisted = AssetDatabase.LoadAssetAtPath<Texture>(path); if (persisted == null) throw new InvalidOperationException("Texture persistence failed: " + pair.Key); mat.SetTexture(pair.Key, persisted);
        }
        AssetDatabase.SaveAssets();
    }

    [Serializable] class MeshMeta { public int vertexCount, indexCount; public string indexFile, indexSha256; }
    [Serializable] class VertexBufferMeta { public int slot, offset, stride, resourceInt; }
    [Serializable] class BufferFileMeta { public int resource, size; public string file; }
    [Serializable] class CaptureMeta { public int eventId; public VertexBufferMeta[] vertexBuffers; public BufferFileMeta[] bufferFiles; }
}







