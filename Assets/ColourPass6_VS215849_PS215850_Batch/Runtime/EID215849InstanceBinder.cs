using System.Runtime.InteropServices;
using UnityEngine;
using UnityEngine.Rendering;

[ExecuteAlways, DisallowMultipleComponent]
public sealed class EID215849InstanceBinder : MonoBehaviour
{
    public EID215849DrawProfile profile;
    public Material material;
    public Mesh expandedMesh;

    [StructLayout(LayoutKind.Sequential)]
    struct InstanceRec
    {
        public float m00, m01, m02, m03;
        public float m10, m11, m12, m13;
        public float m20, m21, m22, m23;
        public float m30, m31, m32, m33;
        public float m1x, m1y, m1z, m1w;
        public float m2x, m2y, m2z, m2w;
    }

    ComputeBuffer instances;

    void OnEnable()
    {
        Bind();
        RenderPipelineManager.beginCameraRendering -= OnBeginCamera;
        RenderPipelineManager.beginCameraRendering += OnBeginCamera;
        Camera.onPreCull -= OnPreCullCamera;
        Camera.onPreCull += OnPreCullCamera;
    }

    void OnDisable()
    {
        RenderPipelineManager.beginCameraRendering -= OnBeginCamera;
        Camera.onPreCull -= OnPreCullCamera;
        Release();
    }

    void OnValidate()
    {
        if (!isActiveAndEnabled) return;
        BindBuffer();
    }

    void LateUpdate()
    {
        EnsureBound();
    }

    void OnWillRenderObject()
    {
        EnsureBound();
    }

    void OnBeginCamera(ScriptableRenderContext context, Camera camera)
    {
        EnsureBound();
    }

    void OnPreCullCamera(Camera camera)
    {
        EnsureBound();
    }

    public void Bind()
    {
        BindBuffer();
        ApplyMeshAndRenderer();
    }

    void EnsureBound()
    {
        if (!isActiveAndEnabled) return;
        if (instances == null || !instances.IsValid()) BindBuffer();
        else AttachBuffer();
    }

    void BindBuffer()
    {
        Release();
        if (profile == null || profile.instanceBytes == null || material == null) return;
        byte[] raw = profile.instanceBytes.bytes;
        int count = profile.instanceCount;
        int stride = profile.instanceStride > 0 ? profile.instanceStride : 96;
        int need = count * stride;
        if (raw == null || raw.Length < need || stride != 96) return;

        var recs = new InstanceRec[count];
        GCHandle handle = GCHandle.Alloc(recs, GCHandleType.Pinned);
        try { Marshal.Copy(raw, 0, handle.AddrOfPinnedObject(), need); }
        finally { handle.Free(); }

        instances = new ComputeBuffer(count, stride, ComputeBufferType.Structured);
        instances.SetData(recs);
        if (material.HasProperty("_EID3863AlphaCutoff"))
            material.SetFloat("_EID3863AlphaCutoff", 0.5f);
        AttachBuffer();
    }

    void AttachBuffer()
    {
        if (material == null || instances == null || !instances.IsValid()) return;
        material.SetBuffer("_EID215849Instances", instances);
    }

    void ApplyMeshAndRenderer()
    {
        if (expandedMesh != null)
        {
            var filter = GetComponent<MeshFilter>();
            if (filter) filter.sharedMesh = expandedMesh;
        }
        if (material == null) return;
        var renderer = GetComponent<MeshRenderer>();
        if (!renderer) return;
        renderer.sharedMaterial = material;
        renderer.lightProbeUsage = LightProbeUsage.Off;
        renderer.reflectionProbeUsage = ReflectionProbeUsage.Off;
        renderer.allowOcclusionWhenDynamic = false;
        renderer.motionVectorGenerationMode = MotionVectorGenerationMode.ForceNoMotion;
        renderer.shadowCastingMode = ShadowCastingMode.Off;
        renderer.receiveShadows = false;
        renderer.SetPropertyBlock(null);
    }

    void Release()
    {
        if (instances != null)
        {
            instances.Release();
            instances = null;
        }
    }
}
