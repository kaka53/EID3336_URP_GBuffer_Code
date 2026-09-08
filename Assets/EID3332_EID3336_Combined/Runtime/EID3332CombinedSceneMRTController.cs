using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

[ExecuteAlways]
public sealed class EID3332CombinedSceneMRTController : MonoBehaviour
{
    [Serializable]
    public sealed class ProfileBinding
    {
        public EID3332CombinedDrawProfile profile;
        public Transform modelRoot;
        [Tooltip("Fallback material template. A GameObject with EID3336GBufferObjectParameters receives its own private runtime clone.")]
        public Material material;
        [Tooltip("Fallback per-profile buffers/constants. A matching per-GameObject component may supply its own exact resource component.")]
        public EID3332CombinedSceneMaterialResources resources;
        [Tooltip("Explicit per-instance live Transform sources. EID3336 renderer nodes live under captured control parents, so moving the renderer, its control, or the common root updates the raw instance.")]
        public Transform[] instanceTransforms = Array.Empty<Transform>();
        [Tooltip("Frozen initial world matrices for instanceTransforms. They keep absolute inspector positions meaningful before the first camera render.")]
        public Matrix4x4[] instanceTransformReferences = Array.Empty<Matrix4x4>();
        [NonSerialized] public Renderer[] renderers = Array.Empty<Renderer>();

        public Transform[] GetLiveTransformSources()
        {
            if (instanceTransforms != null && instanceTransforms.Length > 0) return instanceTransforms;
            Transform[] fallback = new Transform[renderers != null ? renderers.Length : 0];
            for (int i = 0; i < fallback.Length; ++i)
                fallback[i] = renderers[i] != null ? renderers[i].transform : null;
            return fallback;
        }
    }

    static readonly int InstanceIndexId = Shader.PropertyToID("_EID3336InstanceIndex");
    static readonly int UseVisibilityMaskId = Shader.PropertyToID("_EID3336UseVisibilityMask");
    static readonly int VisibilityFlipYId = Shader.PropertyToID("_EID3336VisibilityFlipY");
    static readonly int EnableVirtualTextureBranchId = Shader.PropertyToID("_EID3332CombinedEnableVirtualTextureBranch");
    static readonly int FlipMaterialUvYId = Shader.PropertyToID("_EID3332CombinedFlipMaterialUVY");
    static readonly int RouteBUseObjectTransformId = Shader.PropertyToID("_EID3336RouteBUseObjectTransform");
    static readonly int CurrentWorldToClipId = Shader.PropertyToID("_EID3336CurrentWorldToClip");
    static readonly int PreviousWorldToClipId = Shader.PropertyToID("_EID3336PreviousWorldToClip");
    static readonly int ModelDataWorldSpaceId = Shader.PropertyToID("_EID3336SceneModelDataInWorldSpace");
    static readonly int SceneModelBasisId = Shader.PropertyToID("_EID3336SceneModelBasis");

    readonly HashSet<int> reportedContractProblems = new HashSet<int>();

    [Tooltip("Legacy fallback only. Matching per-GameObject parameter components are now authoritative for their own draw switches.")]
    public bool profileOwnsMaterialSwitches = false;
    public Material sharedMrtMaterial;
    public EID3332CombinedSceneMaterialResources resources;
    public ProfileBinding[] bindings = Array.Empty<ProfileBinding>();

    void OnEnable() { Refresh(); }
    void OnValidate() { if (isActiveAndEnabled) Refresh(); }

    public void Refresh()
    {
        if (bindings == null) return;
        foreach (ProfileBinding binding in bindings)
        {
            if (binding == null) continue;
            binding.renderers = binding.modelRoot == null
                ? Array.Empty<Renderer>()
                : binding.modelRoot.GetComponentsInChildren<Renderer>(true);
            if (binding.renderers != null) Array.Sort(binding.renderers, CompareRenderers);
        }
    }

    static int CompareRenderers(Renderer a, Renderer b)
    {
        if (ReferenceEquals(a, b)) return 0;
        if (a == null) return 1;
        if (b == null) return -1;
        return string.CompareOrdinal(a.name, b.name);
    }

    static EID3336GBufferObjectParameters GetObjectParameters(ProfileBinding binding, int index)
    {
        if (binding == null) return null;
        Renderer renderer = binding.renderers != null && index >= 0 && index < binding.renderers.Length
            ? binding.renderers[index] : null;
        EID3336GBufferObjectParameters parameters = renderer != null
            ? renderer.GetComponent<EID3336GBufferObjectParameters>() : null;

        Transform[] sources = binding.GetLiveTransformSources();
        Transform source = sources != null && index >= 0 && index < sources.Length ? sources[index] : null;
        if (parameters == null && source != null)
            parameters = source.GetComponent<EID3336GBufferObjectParameters>();
        if (parameters == null && renderer != null)
            parameters = renderer.GetComponentInParent<EID3336GBufferObjectParameters>();
        if (parameters == null && binding.modelRoot != null)
            parameters = binding.modelRoot.GetComponent<EID3336GBufferObjectParameters>();
        return parameters;
    }

    void ReportContractProblemOnce(ProfileBinding binding, int index,
        EID3336GBufferObjectParameters parameters, string problem)
    {
        Renderer renderer = binding != null && binding.renderers != null && index >= 0 && index < binding.renderers.Length
            ? binding.renderers[index] : null;
        int objectId = renderer != null ? renderer.gameObject.GetInstanceID()
            : parameters != null ? parameters.gameObject.GetInstanceID()
            : binding != null && binding.modelRoot != null ? binding.modelRoot.gameObject.GetInstanceID() : index;
        int eventId = binding != null && binding.profile != null ? binding.profile.eventId : -1;
        int key = objectId ^ (eventId * 397);
        if (!reportedContractProblems.Add(key)) return;
        Debug.LogError("[EID GBuffer Per-Object] " + problem +
            ". Draw is NOT skipped; the verified profile fallback is used. event=" + eventId +
            " object=" + (renderer != null ? renderer.name : parameters != null ? parameters.name : "<missing>"),
            renderer != null ? renderer : (UnityEngine.Object)parameters);
    }

    void ResolveObjectDraw(ProfileBinding binding, int index,
        EID3332CombinedSceneMaterialResources fallbackResources, Material fallbackMaterial,
        out EID3336GBufferObjectParameters parameters,
        out EID3332CombinedSceneMaterialResources drawResources, out Material drawMaterial)
    {
        parameters = GetObjectParameters(binding, index);
        drawResources = fallbackResources;
        drawMaterial = fallbackMaterial;

        if (parameters == null)
        {
            ReportContractProblemOnce(binding, index, null, "missing EID3336GBufferObjectParameters");
            return;
        }
        if (!parameters.MatchesProfile(binding.profile))
        {
            ReportContractProblemOnce(binding, index, parameters,
                "component event/profile does not match the active Draw Profile");
            parameters = null;
            return;
        }
        if (parameters.drawResources != null)
            drawResources = parameters.drawResources;
        else
            ReportContractProblemOnce(binding, index, parameters,
                "component has no drawResources reference");

        Material privateMaterial = parameters.GetOrCreateRuntimeMaterial(fallbackMaterial);
        if (privateMaterial != null)
            drawMaterial = privateMaterial;
        else
            ReportContractProblemOnce(binding, index, parameters,
                "component has no usable drawMaterial template");
    }

    void ApplyObjectSwitches(CommandBuffer cmd, EID3332CombinedDrawProfile profile,
        EID3336GBufferObjectParameters parameters, Material drawMaterial, bool capturedProjection)
    {
        if (parameters != null)
        {
            parameters.ApplyForDraw(cmd, drawMaterial, capturedProjection);
            return;
        }

        bool enableVirtualTexture = profile != null && (capturedProjection
            ? profile.enableVirtualTextureBranchInCapturedProjection
            : profile.enableVirtualTextureBranchInCurrentCamera);
        bool flipUvY = profile != null && profile.flipMaterialUvY;
        drawMaterial.SetFloat(EnableVirtualTextureBranchId, enableVirtualTexture ? 1f : 0f);
        drawMaterial.SetFloat(FlipMaterialUvYId, flipUvY ? 1f : 0f);
        cmd.SetGlobalFloat(EnableVirtualTextureBranchId, enableVirtualTexture ? 1f : 0f);
        cmd.SetGlobalFloat(FlipMaterialUvYId, flipUvY ? 1f : 0f);
    }

    public Renderer[] GetAllRenderers()
    {
        var list = new List<Renderer>();
        if (bindings != null)
            foreach (ProfileBinding binding in bindings)
                if (binding != null && binding.renderers != null)
                    foreach (Renderer renderer in binding.renderers)
                        if (renderer != null) list.Add(renderer);
        return list.ToArray();
    }

    // RenderDocCaptured path. Every instance resolves and binds the parameter
    // component on its corresponding selectable GameObject immediately before DrawProcedural.
    public void DrawCapturedRawMRT(CommandBuffer cmd)
    {
        if (cmd == null || bindings == null) return;
        Refresh();

        foreach (ProfileBinding binding in bindings)
        {
            if (binding == null || binding.profile == null) continue;
            if (binding.modelRoot != null && !binding.modelRoot.gameObject.activeInHierarchy) continue;

            Material fallbackMaterial = binding.material != null ? binding.material : sharedMrtMaterial;
            EID3332CombinedSceneMaterialResources fallbackResources = binding.resources != null ? binding.resources : resources;
            if (fallbackMaterial == null || fallbackResources == null) continue;

            bool useCapturedMask = binding.profile.useCapturedVisibilityMaskInCapturedProjection ||
                                   (binding.profile.eventId == 3336 && binding.profile.capturedVisibilityMask == null);
            bool flipVisibilityY = binding.profile.capturedVisibilityFlipY ||
                                   (binding.profile.eventId == 3336 && binding.profile.capturedVisibilityMask == null);
            int instanceCount = Mathf.Max(1, binding.profile.instanceCount);
            int indexCount = Mathf.Max(0, binding.profile.indexCount);

            for (int instance = 0; instance < instanceCount; ++instance)
            {
                ResolveObjectDraw(binding, instance, fallbackResources, fallbackMaterial,
                    out EID3336GBufferObjectParameters objectParameters,
                    out EID3332CombinedSceneMaterialResources drawResources,
                    out Material drawMaterial);
                if (drawMaterial == null || drawResources == null) continue;

                // Exact object-local binding sequence. Nothing from a later EID/profile
                // is allowed to leak into this recorded draw.
                drawResources.material = drawMaterial;
                drawResources.BindProfileTextures(binding.profile);
                drawResources.ApplyProfileStreamLayout(binding.profile);
                if (!drawResources.BindCapturedProfile(binding.profile)) continue;
                drawResources.ApplyCapturedInstanceTransforms();
                drawResources.BindObjectForCommandBuffer(cmd, binding.profile, useCapturedMask);

                ApplyObjectSwitches(cmd, binding.profile, objectParameters, drawMaterial, true);
                drawMaterial.SetFloat(UseVisibilityMaskId, useCapturedMask ? 1f : 0f);
                drawMaterial.SetFloat(VisibilityFlipYId, flipVisibilityY ? 1f : 0f);
                cmd.SetGlobalFloat(UseVisibilityMaskId, useCapturedMask ? 1f : 0f);
                cmd.SetGlobalFloat(VisibilityFlipYId, flipVisibilityY ? 1f : 0f);
                // The fixed replay must always consume captured VS_30_m0 matrices.
                cmd.SetGlobalFloat(RouteBUseObjectTransformId, 0f);

                int pass = drawMaterial.FindPass("EID3332Combined_FiveMRTProcedural");
                if (pass < 0) continue;
                cmd.SetGlobalInt(InstanceIndexId, binding.profile.shaderInstanceOffset + instance);
                cmd.DrawProcedural(Matrix4x4.identity, drawMaterial, pass,
                    MeshTopology.Triangles, indexCount, 1);
            }
        }
    }

    // CurrentUnityCamera path. Recovered raw geometry/material data is retained;
    // ApplySceneTransforms updates the instance table from current GameObject Transforms.
    public void DrawCurrentCameraMRT(CommandBuffer cmd, Matrix4x4 worldToClip,
        bool useRawStreams = true, bool useCapturedInstanceTransformsForRaw = true)
    {
        if (cmd == null || bindings == null) return;
        Refresh();

        foreach (ProfileBinding binding in bindings)
        {
            if (binding == null || binding.profile == null || binding.renderers == null) continue;
            if (binding.modelRoot != null && !binding.modelRoot.gameObject.activeInHierarchy) continue;

            Material fallbackMaterial = binding.material != null ? binding.material : sharedMrtMaterial;
            EID3332CombinedSceneMaterialResources fallbackResources = binding.resources != null ? binding.resources : resources;
            if (fallbackMaterial == null || fallbackResources == null) continue;

            bool profileUseRawStreams = useRawStreams && binding.profile.useRawStreams;
            int drawCount = Mathf.Max(1, binding.profile.instanceCount);
            int indexCount = Mathf.Max(0, binding.profile.indexCount);

            for (int instance = 0; instance < drawCount; ++instance)
            {
                Renderer renderer = instance < binding.renderers.Length ? binding.renderers[instance] : null;
                if (!profileUseRawStreams &&
                    (renderer == null || !renderer.enabled || !renderer.gameObject.activeInHierarchy))
                    continue;

                ResolveObjectDraw(binding, instance, fallbackResources, fallbackMaterial,
                    out EID3336GBufferObjectParameters objectParameters,
                    out EID3332CombinedSceneMaterialResources drawResources,
                    out Material drawMaterial);
                if (drawMaterial == null || drawResources == null) continue;

                drawResources.material = drawMaterial;
                drawResources.BindProfileTextures(binding.profile);
                drawResources.ApplyProfileStreamLayout(binding.profile);
                bool previousCapturedTransformMode = drawResources.useCapturedInstanceTransforms;
                drawResources.useCapturedInstanceTransforms = profileUseRawStreams && useCapturedInstanceTransformsForRaw;
                drawResources.sceneModelDataAlreadyWorldSpace = binding.profile.verticesAlreadyWorldSpace;
                drawResources.sceneModelApplyExportMirrorX = binding.profile.applyExportMirrorX;

                bool resourcesReady = true;
                if (profileUseRawStreams)
                    resourcesReady = drawResources.BindCapturedProfile(binding.profile);
                else
                    drawResources.BindForDraw(false);

                if (resourcesReady)
                    drawResources.ApplySceneTransforms(binding.renderers,
                        binding.GetLiveTransformSources(), binding.instanceTransformReferences);
                drawResources.useCapturedInstanceTransforms = previousCapturedTransformMode;
                if (!resourcesReady) continue;

                // Record buffers/textures/constants against this object's private
                // material immediately before the object's draw.
                drawResources.BindObjectForCommandBuffer(cmd, binding.profile, false);
                ApplyObjectSwitches(cmd, binding.profile, objectParameters, drawMaterial, false);
                drawMaterial.SetFloat(UseVisibilityMaskId, 0f);
                drawMaterial.SetMatrix(CurrentWorldToClipId, worldToClip);
                drawMaterial.SetMatrix(PreviousWorldToClipId, worldToClip);
                drawMaterial.SetFloat(ModelDataWorldSpaceId,
                    binding.profile.verticesAlreadyWorldSpace ? 1f : 0f);
                drawMaterial.SetMatrix(SceneModelBasisId, Matrix4x4.identity);
                cmd.SetGlobalFloat(UseVisibilityMaskId, 0f);
                cmd.SetGlobalMatrix(CurrentWorldToClipId, worldToClip);
                cmd.SetGlobalMatrix(PreviousWorldToClipId, worldToClip);
                cmd.SetGlobalFloat(ModelDataWorldSpaceId,
                    binding.profile.verticesAlreadyWorldSpace ? 1f : 0f);
                cmd.SetGlobalMatrix(SceneModelBasisId, Matrix4x4.identity);
                // Live movement is already written into VS_30_m0 by ApplySceneTransforms.
                // Keep the shader-side override disabled to avoid a second transform.
                cmd.SetGlobalFloat(RouteBUseObjectTransformId, 0f);
                cmd.SetGlobalInt(InstanceIndexId, binding.profile.shaderInstanceOffset + instance);

                if (profileUseRawStreams)
                {
                    int pass = drawMaterial.FindPass("EID3332Combined_FiveMRTCurrentCameraProcedural");
                    if (pass < 0) continue;
                    cmd.DrawProcedural(Matrix4x4.identity, drawMaterial, pass,
                        MeshTopology.Triangles, indexCount, 1);
                }
                else
                {
                    int pass = drawMaterial.FindPass("EID3332Combined_FiveMRTCurrentCamera");
                    if (pass < 0 || renderer == null) continue;
                    Mesh mesh = GetMesh(renderer);
                    int submeshes = mesh == null ? 1 : Mathf.Max(1, mesh.subMeshCount);
                    for (int submesh = 0; submesh < submeshes; ++submesh)
                        cmd.DrawRenderer(renderer, drawMaterial, submesh, pass);
                }
            }
        }
    }

    static Mesh GetMesh(Renderer renderer)
    {
        if (renderer is SkinnedMeshRenderer skinned) return skinned.sharedMesh;
        MeshFilter filter = renderer.GetComponent<MeshFilter>();
        return filter != null ? filter.sharedMesh : null;
    }
}
