using System;
using UnityEngine;
using UnityEngine.Rendering;

[ExecuteAlways]
public sealed class EID3336RouteBMeshRendererAdapter : MonoBehaviour
{
    [Serializable]
    public sealed class Entry
    {
        public Renderer renderer;
        public EID3332CombinedDrawProfile profile;
        public EID3332CombinedSceneMaterialResources resources;
        public Material material;
        public int instanceIndex;
    }

    [Header("Route B: standard MeshRenderer path")]
    public bool enabledForCurrentCamera = true;
    [Tooltip("Use independent renderer property blocks for per-instance shader values.")]
    public bool usePerRendererPropertyBlocks = true;
    [Tooltip("When enabled, UV/profile switches and texture choices are read from each material and are not overwritten every frame. Only live camera/Transform/instance values are supplied by the pipeline.")]
    public bool materialOwnsProfileParameters = true;
    [Tooltip("Force the recovered EID material on the renderer so URP's UniversalGBuffer pass owns the draw.")]
    public bool assignRouteBMaterial = true;
    public Material routeBMaterial;
    public Entry[] entries = Array.Empty<Entry>();

    static readonly int InstanceIndexId = Shader.PropertyToID("_EID3336InstanceIndex");
    static readonly int CurrentWorldToClipId = Shader.PropertyToID("_EID3336CurrentWorldToClip");
    static readonly int PreviousWorldToClipId = Shader.PropertyToID("_EID3336PreviousWorldToClip");
    static readonly int SceneModelWorldId = Shader.PropertyToID("_EID3336SceneModelDataInWorldSpace");
    static readonly int FlipMaterialUvYId = Shader.PropertyToID("_EID3332CombinedFlipMaterialUVY");
    static readonly int EnableVirtualTextureBranchId = Shader.PropertyToID("_EID3332CombinedEnableVirtualTextureBranch");
    static readonly int UseVisibilityMaskId = Shader.PropertyToID("_EID3336UseVisibilityMask");
    static readonly int VisibilityFlipYId = Shader.PropertyToID("_EID3336VisibilityFlipY");
    static readonly int RouteBUseObjectTransformId = Shader.PropertyToID("_EID3336RouteBUseObjectTransform");
    static readonly int RouteBObjectToWorldId = Shader.PropertyToID("_EID3336RouteBObjectToWorld");

    MaterialPropertyBlock propertyBlock;
    Camera activeCamera;
    Material[] originalMaterials;

    void OnEnable()
    {
        RefreshEntries();
        ApplyAll();
    }

    void OnDisable()
    {
        RestoreMaterials();
    }

    void OnValidate()
    {
        if (!isActiveAndEnabled)
            return;
        RefreshEntries();
        ApplyAll();
    }

    void LateUpdate()
    {
        // The source five-MRT controller owns these draws. Route B must not
        // rewrite shared renderer materials while that path is active.
        if (isActiveAndEnabled && enabledForCurrentCamera && !IsFiveMrtActive())
            ApplyAll();
    }

    bool IsFiveMrtActive()
    {
        var controller = GetComponent<EID3332CombinedDeferredController>();
        return controller != null && controller.useURPFiveMRT && controller.sharedMrtController != null;
    }

    public void SetCamera(Camera camera)
    {
        activeCamera = camera;
        ApplyAll();
    }

    public void RefreshEntries()
    {
        if (entries == null)
            return;
        if (originalMaterials == null || originalMaterials.Length != entries.Length)
            originalMaterials = new Material[entries.Length];
        for (int i = 0; i < entries.Length; ++i)
        {
            Entry entry = entries[i];
            if (entry == null || entry.renderer == null || entry.profile == null)
                continue;
            if (originalMaterials[i] == null)
                originalMaterials[i] = entry.renderer.sharedMaterial;
            Material material = entry.material != null ? entry.material : routeBMaterial;
            if (assignRouteBMaterial && material != null)
                entry.renderer.sharedMaterial = material;
            if (entry.resources != null && material != null)
            {
                entry.resources.material = material;
                if (!materialOwnsProfileParameters)
                    entry.resources.BindProfileTextures(entry.profile);
                entry.resources.ApplyProfileStreamLayout(entry.profile);
                entry.resources.BindForDraw(!materialOwnsProfileParameters);
            }
        }
    }

    public void ApplyAll()
    {
        if (!enabledForCurrentCamera || entries == null)
            return;
        Camera camera = activeCamera != null ? activeCamera : Camera.main;
        Matrix4x4 worldToClip = camera != null
            ? GL.GetGPUProjectionMatrix(camera.projectionMatrix, true) * camera.worldToCameraMatrix
            : Matrix4x4.identity;
        for (int i = 0; i < entries.Length; ++i)
        {
            Entry entry = entries[i];
            if (entry == null || entry.renderer == null || entry.profile == null)
                continue;
            Material material = entry.material != null ? entry.material : routeBMaterial;
            if (material == null)
                material = entry.renderer.sharedMaterial;
            if (material == null)
                continue;
            if (assignRouteBMaterial && entry.renderer.sharedMaterial != material)
                entry.renderer.sharedMaterial = material;
            if (entry.resources != null)
            {
                entry.resources.material = material;
                if (!materialOwnsProfileParameters)
                    entry.resources.BindProfileTextures(entry.profile);
                entry.resources.ApplyProfileStreamLayout(entry.profile);
                entry.resources.BindForDraw(!materialOwnsProfileParameters);
            }
            if (!usePerRendererPropertyBlocks)
            {
                ApplyMaterial(material, entry, worldToClip, materialOwnsProfileParameters);
                continue;
            }
            propertyBlock ??= new MaterialPropertyBlock();
            propertyBlock.Clear();
            entry.renderer.GetPropertyBlock(propertyBlock);
            ApplyPropertyBlock(propertyBlock, entry, worldToClip, materialOwnsProfileParameters);
            entry.renderer.SetPropertyBlock(propertyBlock);
        }
    }

    public void RestoreMaterials()
    {
        if (entries == null || originalMaterials == null)
            return;
        for (int i = 0; i < entries.Length && i < originalMaterials.Length; ++i)
        {
            if (entries[i]?.renderer != null && originalMaterials[i] != null)
                entries[i].renderer.sharedMaterial = originalMaterials[i];
        }
    }

    static void ApplyMaterial(Material material, Entry entry, Matrix4x4 worldToClip, bool materialOwnsProfileParameters)
    {
        material.SetInt(InstanceIndexId, entry.instanceIndex);
        material.SetMatrix(CurrentWorldToClipId, worldToClip);
        material.SetMatrix(PreviousWorldToClipId, worldToClip);
        material.SetFloat(RouteBUseObjectTransformId, 1f);
        material.SetMatrix(RouteBObjectToWorldId, entry.renderer.localToWorldMatrix);
        if (!materialOwnsProfileParameters)
            ApplyLegacyProfileParameters(material, entry);
    }

    static void ApplyPropertyBlock(MaterialPropertyBlock block, Entry entry, Matrix4x4 worldToClip, bool materialOwnsProfileParameters)
    {
        block.SetInt(InstanceIndexId, entry.instanceIndex);
        block.SetMatrix(CurrentWorldToClipId, worldToClip);
        block.SetMatrix(PreviousWorldToClipId, worldToClip);
        block.SetFloat(RouteBUseObjectTransformId, 1f);
        block.SetMatrix(RouteBObjectToWorldId, entry.renderer.localToWorldMatrix);
        if (!materialOwnsProfileParameters)
        {
            block.SetFloat(SceneModelWorldId, entry.profile.verticesAlreadyWorldSpace ? 1f : 0f);
            block.SetFloat(FlipMaterialUvYId, entry.profile.flipMaterialUvY ? 1f : 0f);
            block.SetFloat(EnableVirtualTextureBranchId, 0f);
            block.SetFloat(UseVisibilityMaskId, 0f);
            block.SetFloat(VisibilityFlipYId, 0f);
        }
    }

    static void ApplyLegacyProfileParameters(Material material, Entry entry)
    {
        material.SetFloat(SceneModelWorldId, entry.profile.verticesAlreadyWorldSpace ? 1f : 0f);
        material.SetFloat(FlipMaterialUvYId, entry.profile.flipMaterialUvY ? 1f : 0f);
        material.SetFloat(EnableVirtualTextureBranchId, 0f);
        material.SetFloat(UseVisibilityMaskId, 0f);
        material.SetFloat(VisibilityFlipYId, 0f);
    }
}
