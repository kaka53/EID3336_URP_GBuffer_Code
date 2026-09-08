using UnityEngine;
using UnityEngine.Rendering;

/// <summary>
/// Per-rendered-GameObject contract for one recovered RenderDoc draw.
/// The MRT controller resolves this component immediately before the object's
/// draw and binds its private material, raw resources, texture table and PS switches.
/// </summary>
[ExecuteAlways]
[DisallowMultipleComponent]
public sealed class EID3336GBufferObjectParameters : MonoBehaviour
{
    static readonly int EnableVirtualTextureBranchId = Shader.PropertyToID("_EID3332CombinedEnableVirtualTextureBranch");
    static readonly int FlipMaterialUvYId = Shader.PropertyToID("_EID3332CombinedFlipMaterialUVY");

    [Header("RenderDoc draw identity")]
    [Tooltip("RenderDoc event represented by this GameObject.")]
    public int eventId = 3336;
    [Tooltip("Exact draw profile used by this GameObject.")]
    public EID3332CombinedDrawProfile drawProfile;
    [Tooltip("Exact captured constants/raw buffers/texture resource table used by this GameObject.")]
    public EID3332CombinedSceneMaterialResources drawResources;
    [Tooltip("Template only. A private runtime material is created for this GameObject; the shared asset is never modified by per-object draws.")]
    public Material drawMaterial;

    [Header("Recovered pixel-shader switches")]
    [Tooltip("Captured PS virtual-texture branch state in RenderDocCaptured projection.")]
    public bool enableVirtualTextureBranchInCapturedProjection = true;
    [Tooltip("PS virtual-texture branch state in CurrentUnityCamera projection.")]
    public bool enableVirtualTextureBranchInCurrentCamera = true;
    [Tooltip("Flip the recovered material UV Y before PS sampling. EID3336 is false.")]
    public bool flipMaterialUvY;

    [Header("Runtime diagnostics (read only)")]
    [SerializeField, HideInInspector] string lastBoundObject;
    [SerializeField, HideInInspector] int lastBoundEventId = -1;

    [System.NonSerialized] Material runtimeMaterial;
    [System.NonSerialized] Material runtimeTemplate;

    public bool MatchesProfile(EID3332CombinedDrawProfile profile)
    {
        return isActiveAndEnabled && profile != null && eventId == profile.eventId && drawProfile == profile;
    }

    public Material GetOrCreateRuntimeMaterial(Material fallbackTemplate)
    {
        Material template = drawMaterial != null ? drawMaterial : fallbackTemplate;
        if (template == null) return null;

        if (runtimeMaterial == null || runtimeTemplate != template || runtimeMaterial.shader != template.shader)
        {
            ReleaseRuntimeMaterial();
            runtimeTemplate = template;
            runtimeMaterial = new Material(template)
            {
                name = template.name + " [" + name + " EID" + eventId + "]",
                hideFlags = HideFlags.HideAndDontSave
            };
        }
        return runtimeMaterial;
    }

    /// <summary>Writes this object's recovered switches to the exact private material and command buffer used by its next draw.</summary>
    public void ApplyForDraw(CommandBuffer cmd, Material target, bool renderDocCapturedProjection)
    {
        if (target == null) return;
        bool enableVirtualTexture = renderDocCapturedProjection
            ? enableVirtualTextureBranchInCapturedProjection
            : enableVirtualTextureBranchInCurrentCamera;

        target.SetFloat(EnableVirtualTextureBranchId, enableVirtualTexture ? 1f : 0f);
        target.SetFloat(FlipMaterialUvYId, flipMaterialUvY ? 1f : 0f);
        if (cmd != null)
        {
            cmd.SetGlobalFloat(EnableVirtualTextureBranchId, enableVirtualTexture ? 1f : 0f);
            cmd.SetGlobalFloat(FlipMaterialUvYId, flipMaterialUvY ? 1f : 0f);
        }
        lastBoundObject = name;
        lastBoundEventId = eventId;
    }

    public void Configure(EID3332CombinedDrawProfile profile,
        EID3332CombinedSceneMaterialResources resources, Material material, bool resetRecoveredSwitches)
    {
        bool profileChanged = drawProfile != profile || eventId != (profile != null ? profile.eventId : eventId);
        drawProfile = profile;
        drawResources = resources;
        drawMaterial = material;
        if (profile != null) eventId = profile.eventId;
        if (resetRecoveredSwitches || profileChanged) ApplyProfileDefaults();
        ReleaseRuntimeMaterial();
    }

    [ContextMenu("Reset switches from Draw Profile")]
    public void ApplyProfileDefaults()
    {
        if (drawProfile == null) return;
        eventId = drawProfile.eventId;
        enableVirtualTextureBranchInCapturedProjection = drawProfile.enableVirtualTextureBranchInCapturedProjection;
        enableVirtualTextureBranchInCurrentCamera = drawProfile.enableVirtualTextureBranchInCurrentCamera;
        flipMaterialUvY = drawProfile.flipMaterialUvY;
    }

    void OnDisable() => ReleaseRuntimeMaterial();
    void OnDestroy() => ReleaseRuntimeMaterial();

    void ReleaseRuntimeMaterial()
    {
        if (runtimeMaterial != null)
        {
            if (Application.isPlaying) Destroy(runtimeMaterial);
            else DestroyImmediate(runtimeMaterial);
        }
        runtimeMaterial = null;
        runtimeTemplate = null;
    }
}
