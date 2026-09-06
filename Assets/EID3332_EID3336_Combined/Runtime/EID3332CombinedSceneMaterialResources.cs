using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.IO;
using UnityEngine;
using UnityEngine.Rendering;

[ExecuteAlways]
public sealed class EID3332CombinedSceneMaterialResources : MonoBehaviour
{
    public Material material;
    [Tooltip("Serialized exact VS buffer payloads for this draw. When assigned, these bytes are authoritative; Resources files remain the fallback.")]
    public EID3336VSBufferParameters serializedVSBufferParameters;
    [Tooltip("Captured constant-buffer resource root for this draw profile.")]
    public string constantResourceRoot = "EID3336CB";
    [Tooltip("Captured vertex resource root for this draw profile.")]
    public string vertexResourceRoot = "EID3336VS";
    [Tooltip("Use the original EID3336 _28_30 matrices without replacing them from scene node transforms. SceneModel world-space handling is configured by the controller.")]
    public bool useCapturedInstanceTransforms;
    public bool sceneModelDataAlreadyWorldSpace;
    public bool sceneModelApplyExportMirrorX;
    [Tooltip("Legacy serialized fields only. Raw resources are already exact per-event slices; offsets are not applied again.")]
    public int vertexStreamByteOffset;
    public int indexByteOffset;
    public int vertexStreamByteLength = 27456;
    public int indexByteLength = 0;

    sealed class ConstantBinding { public string name; public GraphicsBuffer buffer; public int size; }
    static readonly int RawStream1StrideId = Shader.PropertyToID("_EID3336RawStream1StrideBytes");

    static readonly (string name, string resource, bool vertex)[] ConstantSpecs =
    {
        ("VS_24_25", "_24_25", true), ("VS_26_27", "_26_27", true),
        ("_18_19", "_18_19", false), ("_20_21", "_20_21", false),
        ("_22_24", "_22_24", false), ("_43_44", "_43_44", false),
        ("_45_46", "_45_46", false), ("_47_48", "_47_48", false),
        ("_49_50", "_49_50", false), ("_51_52", "_51_52", false)
    };

    [StructLayout(LayoutKind.Sequential, Size = 256)]
    struct Raw256
    {
        public Vector4 a0, a1, a2, a3;       // VS_29._m0 columns
        public Vector4 a4, a5;               // VS_29._m1, _m2
        public Vector4 a6, a7, a8, a9;       // VS_29._m3 columns
        public Vector4 a10, a11, a12, a13, a14, a15;
    }

    readonly List<ConstantBinding> constants = new List<ConstantBinding>();
    readonly Dictionary<int, Texture> textures = new Dictionary<int, Texture>();
    ComputeBuffer instanceSsbo, vertexSsbo;
    ComputeBuffer rawStream0, rawStream1, rawConstants, rawIndices;
    int loadedCapturedEvent = -1;
    Raw256[] instanceRecords;
    Raw256[] capturedInstanceRecords;
    Matrix4x4[] sceneTransformReferences;
    int[] sceneTransformReferenceIds;
    Texture2DArray array58, array59;
    Texture2D visibilityMask;
    EID3332CombinedDrawProfile boundTextureProfile;
    string loadedConstantResourceRoot;
    string loadedVertexResourceRoot;
    EID3336VSBufferParameters loadedSerializedVSBufferParameters;

    void OnEnable() { Reload(); }
    void OnDisable() { Release(); }
    void OnDestroy() { Release(); }

    [ContextMenu("Reload EID3336 Scene Material Resources")]
    public void Reload()
    {
        Release();
        if (material == null) return;
        loadedConstantResourceRoot = constantResourceRoot;
        loadedVertexResourceRoot = vertexResourceRoot;
        loadedSerializedVSBufferParameters = serializedVSBufferParameters;
        foreach (var spec in ConstantSpecs)
        {
            string root = spec.vertex ? vertexResourceRoot : constantResourceRoot;
            byte[] bytes = LoadSerializedOrResource(spec.name, root + "/" + spec.resource);
            if (bytes == null || bytes.Length == 0) continue;
            int size = (bytes.Length + 15) & ~15;
            uint[] words = new uint[size / 4];
            Buffer.BlockCopy(bytes, 0, words, 0, bytes.Length);
            var buffer = new GraphicsBuffer(GraphicsBuffer.Target.Constant, words.Length, 4);
            buffer.SetData(words);
            constants.Add(new ConstantBinding { name = spec.name, buffer = buffer, size = size });
        }

        byte[] instanceBytes = LoadSerializedOrResource("VS_28_30", vertexResourceRoot + "/_28_30");
        if (instanceBytes != null && instanceBytes.Length % 256 == 0)
        {
            instanceRecords = new Raw256[instanceBytes.Length / 256];
            GCHandle pin = GCHandle.Alloc(instanceRecords, GCHandleType.Pinned);
            try { Marshal.Copy(instanceBytes, 0, pin.AddrOfPinnedObject(), instanceBytes.Length); }
            finally { pin.Free(); }
            capturedInstanceRecords = (Raw256[])instanceRecords.Clone();
            instanceSsbo = new ComputeBuffer(instanceRecords.Length, 256, ComputeBufferType.Structured);
            instanceSsbo.SetData(instanceRecords);
            material.SetBuffer("VS_30_m0", instanceSsbo);
        }

        byte[] vertexBytes = LoadSerializedOrResource("VS_32", vertexResourceRoot + "/_32");
        if (vertexBytes != null)
        {
            int padded = (vertexBytes.Length + 3) & ~3;
            uint[] words = new uint[padded / 4];
            Buffer.BlockCopy(vertexBytes, 0, words, 0, vertexBytes.Length);
            vertexSsbo = new ComputeBuffer(words.Length, 4, ComputeBufferType.Raw);
            vertexSsbo.SetData(words);
            material.SetBuffer("VS_32", vertexSsbo);
        }
        // Captured raw buffers are loaded lazily by BindCapturedProfile. Live Mesh mode does not need them.
        BindConstants();
        BindTextures(boundTextureProfile);
        visibilityMask = Resources.Load<Texture2D>("EID3336Textures/EID3336VisibilityMask");
        if (visibilityMask != null)
        {
            visibilityMask.filterMode = FilterMode.Point;
            visibilityMask.wrapMode = TextureWrapMode.Clamp;
            material.SetTexture("_EID3336VisibilityMask", visibilityMask);
        }
        BindRawResources();
    }

    public void ApplyProfileStreamLayout(EID3332CombinedDrawProfile profile)
    {
        if (material != null) material.SetFloat(RawStream1StrideId, profile != null && profile.vertexStream1StrideBytes > 0 ? profile.vertexStream1StrideBytes : 16);
    }

    public void ApplyCapturedInstanceTransforms()
    {
        if (capturedInstanceRecords == null || instanceSsbo == null) return;
        if (instanceRecords == null || instanceRecords.Length != capturedInstanceRecords.Length)
            instanceRecords = (Raw256[])capturedInstanceRecords.Clone();
        else
            Array.Copy(capturedInstanceRecords, instanceRecords, capturedInstanceRecords.Length);
        instanceSsbo.SetData(instanceRecords);
    }
    public void ApplySceneTransforms(Renderer[] renderers)
    {
        ApplySceneTransforms(renderers, null, null);
    }

    public void ApplySceneTransforms(Renderer[] renderers, Transform[] liveTransformSources)
    {
        ApplySceneTransforms(renderers, liveTransformSources, null);
    }

    public void ApplySceneTransforms(Renderer[] renderers, Transform[] liveTransformSources, Matrix4x4[] explicitTransformReferences)
    {
        if (instanceRecords == null || instanceSsbo == null) return;
        if (renderers == null) return;

        int sourceCount = liveTransformSources != null && liveTransformSources.Length > 0
            ? liveTransformSources.Length : renderers.Length;
        int count = Mathf.Min(sourceCount, instanceRecords.Length);
        if (useCapturedInstanceTransforms)
        {
            // CurrentUnityCamera keeps the exact captured instance basis, then
            // applies only the Transform delta made in the Unity scene. This
            // preserves the initial RenderDoc position/winding/normal basis and
            // still lets every model node move, rotate and scale in real time.
            bool useExplicitReferences = explicitTransformReferences != null && explicitTransformReferences.Length >= count;
            if (!useExplicitReferences) EnsureSceneTransformReferences(renderers, liveTransformSources, count);
            for (int i = 0; i < count; ++i)
            {
                Transform source = ResolveTransformSource(renderers, liveTransformSources, i);
                if (source == null || capturedInstanceRecords == null || i >= capturedInstanceRecords.Length) continue;
                Matrix4x4 reference = useExplicitReferences ? explicitTransformReferences[i] : sceneTransformReferences[i];
                Matrix4x4 current = source.localToWorldMatrix;
                Matrix4x4 delta = current * reference.inverse;
                Matrix4x4 captured = MatrixFromRecord(capturedInstanceRecords[i], false);
                Matrix4x4 capturedPrevious = MatrixFromRecord(capturedInstanceRecords[i], true);
                Raw256 record = capturedInstanceRecords[i];
                SetRecordMatrix(ref record, delta * captured, false);
                SetRecordMatrix(ref record, delta * capturedPrevious, true);

                // VS_29._m2.w carries the captured tangent handedness sign.
                // Keep it consistent if a user deliberately crosses handedness
                // with a negative live scale.
                float handedness = Determinant3x3(delta) < 0f ? -1f : 1f;
                record.a5.w = capturedInstanceRecords[i].a5.w * handedness;
                instanceRecords[i] = record;
            }
            instanceSsbo.SetData(instanceRecords);
            return;
        }

        for (int i = 0; i < count; ++i)
        {
            Transform source = ResolveTransformSource(renderers, liveTransformSources, i);
            if (source == null) continue;
            Matrix4x4 matrix = sceneModelDataAlreadyWorldSpace
                ? Matrix4x4.identity
                : source.localToWorldMatrix;
            if (sceneModelApplyExportMirrorX)
                matrix = matrix * Matrix4x4.Scale(new Vector3(-1.0f, 1.0f, 1.0f));
            Raw256 record = instanceRecords[i];
            SetRecordMatrix(ref record, matrix, false);
            SetRecordMatrix(ref record, matrix, true);
            instanceRecords[i] = record;
        }
        instanceSsbo.SetData(instanceRecords);
    }

    static Transform ResolveTransformSource(Renderer[] renderers, Transform[] liveTransformSources, int index)
    {
        if (liveTransformSources != null && index >= 0 && index < liveTransformSources.Length && liveTransformSources[index] != null)
            return liveTransformSources[index];
        return renderers != null && index >= 0 && index < renderers.Length && renderers[index] != null
            ? renderers[index].transform : null;
    }

    void EnsureSceneTransformReferences(Renderer[] renderers, Transform[] liveTransformSources, int count)
    {
        bool rebuild = sceneTransformReferences == null || sceneTransformReferenceIds == null ||
                       sceneTransformReferences.Length != count || sceneTransformReferenceIds.Length != count;
        if (!rebuild)
            for (int i = 0; i < count; ++i)
            {
                Transform source = ResolveTransformSource(renderers, liveTransformSources, i);
                int id = source != null ? source.GetInstanceID() : 0;
                if (sceneTransformReferenceIds[i] != id) { rebuild = true; break; }
            }
        if (!rebuild) return;

        sceneTransformReferences = new Matrix4x4[count];
        sceneTransformReferenceIds = new int[count];
        for (int i = 0; i < count; ++i)
        {
            Transform source = ResolveTransformSource(renderers, liveTransformSources, i);
            sceneTransformReferenceIds[i] = source != null ? source.GetInstanceID() : 0;
            sceneTransformReferences[i] = source != null ? source.localToWorldMatrix : Matrix4x4.identity;
        }
    }

    [ContextMenu("Reset Live Transform References")]
    public void ResetLiveTransformReferences()
    {
        sceneTransformReferences = null;
        sceneTransformReferenceIds = null;
    }

    public bool TryGetLiveInstanceMatrix(int index, out Matrix4x4 matrix)
    {
        matrix = Matrix4x4.identity;
        if (instanceRecords == null || index < 0 || index >= instanceRecords.Length) return false;
        matrix = MatrixFromRecord(instanceRecords[index], false);
        return true;
    }

    public bool TryGetCapturedInstanceMatrix(int index, out Matrix4x4 matrix)
    {
        matrix = Matrix4x4.identity;
        if (capturedInstanceRecords == null || index < 0 || index >= capturedInstanceRecords.Length) return false;
        matrix = MatrixFromRecord(capturedInstanceRecords[index], false);
        return true;
    }

    static Matrix4x4 MatrixFromRecord(Raw256 record, bool previous)
    {
        Matrix4x4 matrix = Matrix4x4.identity;
        if (previous)
        {
            matrix.SetColumn(0, record.a6); matrix.SetColumn(1, record.a7);
            matrix.SetColumn(2, record.a8); matrix.SetColumn(3, record.a9);
        }
        else
        {
            matrix.SetColumn(0, record.a0); matrix.SetColumn(1, record.a1);
            matrix.SetColumn(2, record.a2); matrix.SetColumn(3, record.a3);
        }
        return matrix;
    }

    static void SetRecordMatrix(ref Raw256 record, Matrix4x4 matrix, bool previous)
    {
        if (previous)
        {
            record.a6 = matrix.GetColumn(0); record.a7 = matrix.GetColumn(1);
            record.a8 = matrix.GetColumn(2); record.a9 = matrix.GetColumn(3);
        }
        else
        {
            record.a0 = matrix.GetColumn(0); record.a1 = matrix.GetColumn(1);
            record.a2 = matrix.GetColumn(2); record.a3 = matrix.GetColumn(3);
        }
    }

    static float Determinant3x3(Matrix4x4 m)
    {
        return m.m00 * (m.m11 * m.m22 - m.m12 * m.m21)
             - m.m01 * (m.m10 * m.m22 - m.m12 * m.m20)
             + m.m02 * (m.m10 * m.m21 - m.m11 * m.m20);
    }

    public void BindForDraw(bool bindProfileVisibilityMask = true)
    {
        BindConstants();
        if (material != null && instanceSsbo != null) material.SetBuffer("VS_30_m0", instanceSsbo);
        if (material != null && vertexSsbo != null) material.SetBuffer("VS_32", vertexSsbo);
        BindRawResources(bindProfileVisibilityMask);
    }

    /// <summary>
    /// Records this profile's buffers into the same command buffer as its draw.
    /// The old Shader.SetGlobalConstantBuffer/material.SetBuffer path is safe
    /// for the single-profile EID3336 replay, but is not safe when several
    /// profiles are recorded into one command buffer: the last profile could
    /// overwrite the resources seen by earlier draws.
    /// </summary>
    public void BindObjectForCommandBuffer(CommandBuffer cmd, EID3332CombinedDrawProfile profile, bool bindProfileVisibilityMask = true)
    {
        if (cmd == null) return;
        // BindProfileTextures has already populated this resource component's
        // object-local table. Copy every texture to this object's private
        // material immediately before recording its draw.
        BindForCommandBuffer(cmd, bindProfileVisibilityMask);
        if (material == null) return;
        int[] props = {33,35,37,38,39,40,41,42,53,54,55,56,57,58,59,60,61,62,63,64,65};
        int baseColor = profile != null ? profile.baseColorTextureId : 271247;
        int baseNormal = profile != null ? profile.baseNormalTextureId : 222331;
        int layerControl = profile != null ? profile.layerControlTextureId : 224843;
        int detailNormal = profile != null ? profile.detailNormalTextureId : 197602;
        int grassMask = profile != null ? profile.grassBlendMaskTextureId : 246832;
        int[] rids = profile != null && profile.eventId == 3490
            ? new[] {baseColor,baseNormal,layerControl,detailNormal,grassMask,197598,198094,0,198259,198278,198267,198263,198284,198300,198309,209602,209085,209115,209112,209109,209106}
            : new[] {baseColor,baseNormal,layerControl,detailNormal,grassMask,204,197598,198094,198259,198278,198267,198263,198284,198300,198309,209602,209085,209115,209112,209109,209106};
        for (int i = 0; i < props.Length; ++i)
        {
            Texture value = null;
            if (rids[i] != 0) textures.TryGetValue(rids[i], out value);
            material.SetTexture("_" + props[i], value);
        }
        // A private material has its own serialized Texture property state.
        // Setting the command-buffer global alone is insufficient for a
        // DrawProcedural material that declares _EID3336VisibilityMask: the
        // cloned material can otherwise override the global with null and
        // clip every fragment. Bind the exact active mask to this object too.
        if (bindProfileVisibilityMask)
        {
            Texture2D activeVisibilityMask = boundTextureProfile != null && boundTextureProfile.capturedVisibilityMask != null
                ? boundTextureProfile.capturedVisibilityMask : visibilityMask;
            if (activeVisibilityMask != null)
                material.SetTexture("_EID3336VisibilityMask", activeVisibilityMask);
        }
        // Keep the legacy EID3336 material contract as well as the command
        // buffer globals. Unity binds these structured buffers as material
        // resources on D3D11; omitting this makes a private per-object
        // material render no fragments even though the global bindings exist.
        BindForDraw(bindProfileVisibilityMask);
    }

    public void BindForCommandBuffer(CommandBuffer cmd, bool bindProfileVisibilityMask = true)
    {
        if (cmd == null) return;
        foreach (var binding in constants)
        {
            if (binding.buffer != null)
                cmd.SetGlobalConstantBuffer(binding.buffer, Shader.PropertyToID(binding.name), 0, binding.size);
        }
        if (instanceSsbo != null) cmd.SetGlobalBuffer(Shader.PropertyToID("VS_30_m0"), instanceSsbo);
        if (vertexSsbo != null) cmd.SetGlobalBuffer(Shader.PropertyToID("VS_32"), vertexSsbo);
        if (rawStream0 != null) cmd.SetGlobalBuffer(Shader.PropertyToID("EID3336RawStream0"), rawStream0);
        if (rawStream1 != null) cmd.SetGlobalBuffer(Shader.PropertyToID("EID3336RawStream1"), rawStream1);
        if (rawConstants != null) cmd.SetGlobalBuffer(Shader.PropertyToID("EID3336RawConstants"), rawConstants);
        if (rawIndices != null) cmd.SetGlobalBuffer(Shader.PropertyToID("EID3336RawIndices"), rawIndices);
        if (bindProfileVisibilityMask)
        {
            Texture2D activeVisibilityMask = boundTextureProfile != null && boundTextureProfile.capturedVisibilityMask != null
                ? boundTextureProfile.capturedVisibilityMask : visibilityMask;
            if (activeVisibilityMask != null)
                cmd.SetGlobalTexture(Shader.PropertyToID("_EID3336VisibilityMask"), activeVisibilityMask);
        }
    }

    public void BindProfileTextures(EID3332CombinedDrawProfile profile)
    {
        boundTextureProfile = profile;
        BindTextures(profile);
        Texture2D profileMask = profile != null ? profile.capturedVisibilityMask : null;
        Texture2D activeMask = profileMask != null ? profileMask : visibilityMask;
        if (activeMask != null && material != null)
        {
            activeMask.filterMode = FilterMode.Point;
            activeMask.wrapMode = TextureWrapMode.Clamp;
            material.SetTexture("_EID3336VisibilityMask", activeMask);
        }
    }

    public bool BindCapturedProfile(EID3332CombinedDrawProfile profile)
    {
        if (profile == null) return false;
        if (loadedCapturedEvent != profile.eventId || rawStream0 == null || rawStream1 == null || rawConstants == null || rawIndices == null)
            LoadCapturedRawSet(profile.eventId);
        BindConstants();
        BindRawResources();
        return rawStream0 != null && rawStream1 != null && rawConstants != null && rawIndices != null;
    }

    void LoadCapturedRawSet(int eventId)
    {
        ReleaseRawResources();
        string root = "EID" + eventId + "Raw";
        string serializedPrefix = eventId == 3336 ? "EID3336Raw" : null;
        rawStream0 = CreateRawResource(root + "/vertex_stream0", "EID" + eventId + "RawStream0", serializedPrefix == null ? null : "EID3336RawStream0");
        rawStream1 = CreateRawResource(root + "/vertex_stream1", "EID" + eventId + "RawStream1", serializedPrefix == null ? null : "EID3336RawStream1");
        rawConstants = CreateRawResource(root + "/vertex_constant_stream", "EID" + eventId + "RawConstants", serializedPrefix == null ? null : "EID3336RawConstants");
        rawIndices = CreateRawResource(root + "/indices_u16", "EID" + eventId + "RawIndices", serializedPrefix == null ? null : "EID3336RawIndices");
        loadedCapturedEvent = eventId;
        BindRawResources();
    }

    byte[] LoadSerializedOrResource(string serializedName, string resourcePath)
    {
        if (serializedVSBufferParameters != null)
        {
            byte[] serialized = serializedVSBufferParameters.GetBytes(serializedName);
            if (serialized != null && serialized.Length > 0) return serialized;
        }
        return LoadBinaryBytes(resourcePath);
    }

    byte[] LoadBinaryBytes(string resourcePath)
    {
        TextAsset asset = Resources.Load<TextAsset>(resourcePath);
        if (asset != null && asset.bytes != null && asset.bytes.Length > 0) return asset.bytes;
        // Keep a direct-file fallback available in the Editor as well as in a
        // player preview. Some Unity domain reloads do not expose newly-created
        // .bytes assets through Resources.Load until a later refresh.
        string relative = resourcePath.Replace('\\', '/').TrimStart('/');
        string projectRoot = Directory.GetParent(Application.dataPath).FullName;
        string absolute = Path.Combine(projectRoot, "Assets", "EID3332_EID3336_Combined", "Resources", relative.Replace('/', Path.DirectorySeparatorChar) + ".bytes");
        if (File.Exists(absolute))
        {
            try { return File.ReadAllBytes(absolute); }
            catch (Exception ex) { Debug.LogError("[EID3332Combined Resources] Read failed " + absolute + ": " + ex.Message, this); }
        }        return null;
    }

    ComputeBuffer CreateRawResource(string path, string name, string serializedName = null)
    {
        byte[] bytes = string.IsNullOrEmpty(serializedName) ? LoadBinaryBytes(path) : LoadSerializedOrResource(serializedName, path);
        if (bytes == null || bytes.Length == 0)
        {
            Debug.LogError("[EID3332Combined Resources] Missing raw asset Resources/" + path, this);
            return null;
        }
        // Files under EID3332Raw/EID3336Raw/EID3490Raw are already exact
        // RenderDoc byte ranges. Never apply Vulkan absolute offsets a second time.
        int padded = (bytes.Length + 3) & ~3;
        uint[] words = new uint[padded / 4];
        Buffer.BlockCopy(bytes, 0, words, 0, bytes.Length);
        var buffer = new ComputeBuffer(words.Length, 4, ComputeBufferType.Raw) { name = name + " bytes=" + bytes.Length };
        buffer.SetData(words);
        return buffer;
    }

    void ReleaseRawResources()
    {
        rawStream0?.Release(); rawStream0 = null;
        rawStream1?.Release(); rawStream1 = null;
        rawConstants?.Release(); rawConstants = null;
        rawIndices?.Release(); rawIndices = null;
        loadedCapturedEvent = -1;
    }
    void BindRawResources(bool bindProfileVisibilityMask = true)
    {
        if (material == null) return;
        if (rawStream0 != null) material.SetBuffer("EID3336RawStream0", rawStream0);
        if (rawStream1 != null) material.SetBuffer("EID3336RawStream1", rawStream1);
        if (rawConstants != null) material.SetBuffer("EID3336RawConstants", rawConstants);
        if (rawIndices != null) material.SetBuffer("EID3336RawIndices", rawIndices);
        if (bindProfileVisibilityMask)
        {
            Texture2D activeVisibilityMask = boundTextureProfile != null && boundTextureProfile.capturedVisibilityMask != null
                ? boundTextureProfile.capturedVisibilityMask : visibilityMask;
            if (activeVisibilityMask != null) material.SetTexture("_EID3336VisibilityMask", activeVisibilityMask);
        }
    }

    void Update() { if (material != null && (loadedConstantResourceRoot != constantResourceRoot || loadedVertexResourceRoot != vertexResourceRoot || loadedSerializedVSBufferParameters != serializedVSBufferParameters)) Reload(); else BindForDraw(); }

    void BindConstants()
    {
        // Material.SetConstantBuffer is not implemented by the D3D11 backend
        // used by this workspace.  The exact replay path binds these named
        // cbuffers globally.  Profiles are still isolated because the caller
        // binds the selected resource table immediately before each draw; no
        // draw is recorded between two profile bindings.
        foreach (var binding in constants)
            if (binding.buffer != null)
                Shader.SetGlobalConstantBuffer(Shader.PropertyToID(binding.name), binding.buffer, 0, binding.size);
    }

    void BindTextures(EID3332CombinedDrawProfile profile)
    {
        // A resource component can be rebound for different profiles while the
        // editor is repainting. Do not let a missing slot inherit a texture from
        // the previous profile; EID3490 must remain isolated from EID3336.
        textures.Clear();
        int baseColor = profile != null ? profile.baseColorTextureId : 271247;
        int baseNormal = profile != null ? profile.baseNormalTextureId : 222331;
        int layerControl = profile != null ? profile.layerControlTextureId : 224843;
        int detailNormal = profile != null ? profile.detailNormalTextureId : 197602;
        int grassMask = profile != null ? profile.grassBlendMaskTextureId : 246832;
        int[] props = {33,35,37,38,39,40,41,42,53,54,55,56,57,58,59,60,61,62,63,64,65};
        int[] rids = profile != null && profile.eventId == 3490
            ? new[] {baseColor,baseNormal,layerControl,detailNormal,grassMask,197598,198094,0,198259,198278,198267,198263,198284,198300,198309,209602,209085,209115,209112,209109,209106}
            : new[] {baseColor,baseNormal,layerControl,detailNormal,grassMask,204,197598,198094,198259,198278,198267,198263,198284,198300,198309,209602,209085,209115,209112,209109,209106};
        // Always clear all slots before binding a profile-local table. Without this,
        // an absent EID3490 slot can retain the previous EID3336 material texture.
        for (int i = 0; i < props.Length; ++i)
            if (material != null) material.SetTexture("_" + props[i], null);
        if (profile != null && profile.eventId == 3490)
        {
            // EID3490 is a PS209989 profile. Resolve its texture IDs directly
            // from the profile-local Resources folder instead of trusting a
            // serialized Material PPtr that may have been cached as null after
            // the old Map01 texture table was removed.
            BindEID3490DirectTextures(props, rids);
        }

        Material source = profile != null ? profile.textureSourceMaterial : null;
        if (source != null)
        {
            for (int i = 0; i < props.Length; ++i)
            {
                string property = "_" + props[i];
                Texture texture = source.HasProperty(property) ? source.GetTexture(property) : null;
                if (texture == null) continue;
                ConfigureTexture(texture, rids[i]);
                textures[rids[i]] = texture;
                material.SetTexture(property, texture);
            }
            if (profile != null && profile.eventId == 3490)
            {
                Texture2DArray profileArray58 = Resources.Load<Texture2DArray>("EID3490Textures/rid198300_array");
                Texture2DArray profileArray59 = Resources.Load<Texture2DArray>("EID3490Textures/rid198309_array");
                if (profileArray58 != null) { material.SetTexture("_58", profileArray58); textures[198300] = profileArray58; }
                if (profileArray59 != null) { material.SetTexture("_59", profileArray59); textures[198309] = profileArray59; }
            }
            return;
        }

        string profileRoot = profile != null && !string.IsNullOrEmpty(profile.textureResourceGroup)
            ? profile.textureResourceGroup : "EID3336Textures";
        bool profileHasBaseSet = profile != null && profileRoot != "EID3336Textures";
        bool allowLegacyFallback = profile == null || profileRoot == "EID3336Textures";
        foreach (int id in rids)
        {
            bool isProfileBase = id == baseColor || id == baseNormal || id == layerControl || id == detailNormal || id == grassMask;
            string root = profileHasBaseSet ? profileRoot : "EID3336Textures";
            Texture2D tex = Resources.Load<Texture2D>($"{root}/rid{id}");
            if (tex == null && root != "EID3336Textures" && allowLegacyFallback)
                tex = Resources.Load<Texture2D>($"EID3336Textures/rid{id}");
            if (tex == null) continue;
            ConfigureTexture(tex, id);
            textures[id] = tex;
        }
        array58 = array58 != null ? array58 : BuildArray(198300, false);
        array59 = array59 != null ? array59 : BuildArray(198309, true);
        if (array58 != null) textures[198300] = array58;
        if (array59 != null) textures[198309] = array59;
        for (int i = 0; i < props.Length; ++i)
            if (textures.TryGetValue(rids[i], out Texture texture)) material.SetTexture("_" + props[i], texture);
    }

    void BindEID3490DirectTextures(int[] props, int[] rids)
    {
        // Only the Set1 material slots belong to EID3490. Set0 frame/
        // screen-space resources (props 53..65) stay on the shared frame table.
        for (int i = 0; i < 8 && i < props.Length; ++i)
        {
            int rid = rids[i];
            if (rid == 0) continue;
            Texture texture = null;
            if (rid == 198300) texture = Resources.Load<Texture2DArray>("EID3490Textures/rid198300_array");
            else if (rid == 198309) texture = Resources.Load<Texture2DArray>("EID3490Textures/rid198309_array");
            else texture = Resources.Load<Texture2D>($"EID3490Textures/rid{rid}");
            if (texture == null)
            {
                Debug.LogError($"[EID3490 Texture Binding] Missing RID{rid} for _{props[i]}");
                continue;
            }
            ConfigureTexture(texture, rid);
            textures[rid] = texture;
            material.SetTexture("_" + props[i], texture);
        }
    }

    static void ConfigureTexture(Texture texture, int id)
    {
        if (texture == null) return;
        bool pointClamp = id == 209602 || id == 209085 || id == 198284;
        bool linearClamp = id == 198259 || id == 198278 || id == 198267 || id == 198263 || id == 209115 || id == 209112 || id == 209109 || id == 209106;
        texture.filterMode = pointClamp ? FilterMode.Point : FilterMode.Bilinear;
        texture.wrapMode = (pointClamp || linearClamp) ? TextureWrapMode.Clamp : TextureWrapMode.Repeat;
        texture.anisoLevel = 0;
    }
    Texture2DArray BuildArray(int rid, bool linear)
    {
        Texture2D first = Resources.Load<Texture2D>($"EID3336Textures/rid{rid}_slice00");
        if (first == null) return null;
        var array = new Texture2DArray(first.width, first.height, 27, first.format, true, linear)
        { name = $"EID3336 Scene rid{rid}", wrapMode = TextureWrapMode.Repeat, filterMode = FilterMode.Bilinear, anisoLevel = 0 };
        for (int slice = 0; slice < 27; ++slice)
        {
            Texture2D source = Resources.Load<Texture2D>($"EID3336Textures/rid{rid}_slice{slice:00}");
            if (source == null) continue;
            for (int mip = 0; mip < Mathf.Min(source.mipmapCount, array.mipmapCount); ++mip)
                Graphics.CopyTexture(source, 0, mip, array, slice, mip);
        }
        return array;
    }

    void Release()
    {
        foreach (var binding in constants) binding.buffer?.Release();
        constants.Clear(); textures.Clear();
        instanceSsbo?.Release(); instanceSsbo = null; instanceRecords = null; capturedInstanceRecords = null;
        vertexSsbo?.Release(); vertexSsbo = null;
        ReleaseRawResources();
        visibilityMask = null;
        DestroyRuntimeObject(array58); DestroyRuntimeObject(array59); array58 = null; array59 = null;
    }

    static void DestroyRuntimeObject(UnityEngine.Object value)
    {
        if (value == null) return;
        if (Application.isPlaying) Destroy(value); else DestroyImmediate(value);
    }
}


















