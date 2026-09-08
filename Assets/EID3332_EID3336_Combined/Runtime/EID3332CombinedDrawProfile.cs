using UnityEngine;

[CreateAssetMenu(menuName = "EID3332 Combined/Scene MRT Draw Profile", fileName = "SceneMRTDrawProfile")]
public sealed class EID3332CombinedDrawProfile : ScriptableObject
{
    [Header("RenderDoc draw")]
    public int eventId;
    public int indexCount;
    public int instanceCount;
    public int indexOffset;
    public int baseVertex;
    public int vertexCount;
    public int triangleCount;

    [Header("Data and coordinate contract")]
    public string vertexDataSource;
    public string indexDataSource;
    public string instanceDataSource;
    public string materialConstantsSource;
    public string textureResourceGroup;
    public bool verticesAlreadyWorldSpace = true;
    public bool applyExportMirrorX;
    [Tooltip("The shader table index used by this draw. Captured profiles start at zero.")]
    public int shaderInstanceOffset;
    [Tooltip("Stride in bytes of one vertex in raw stream1. EID3315 uses packed 8-byte UV pairs; EID3332/EID3336 use 16-byte records.")]
    public int vertexStream1StrideBytes = 16;
    [Tooltip("Use captured raw VB/IB for this profile. Disable for Mesh-backed profiles.")]
    public bool useRawStreams = true;

    [Header("Profile material resources")]
    [Tooltip("Base color texture resource ID used by this draw profile.")]
    public int baseColorTextureId = 271247;
    [Tooltip("Base normal texture resource ID used by this draw profile.")]
    public int baseNormalTextureId = 222331;
    [Tooltip("Layer control texture resource ID used by this draw profile.")]
    public int layerControlTextureId = 224843;
    [Tooltip("Detail/blend normal texture resource ID used by this draw profile.")]
    public int detailNormalTextureId = 197602;
    [Tooltip("Grass blend mask texture resource ID used by this draw profile.")]
    public int grassBlendMaskTextureId = 246832;

    [Header("Virtual texture branch")]
    [Tooltip("Enable the captured screen-space/page-table virtual-texture branch in RenderDocCaptured mode.")]
    public bool enableVirtualTextureBranchInCapturedProjection = true;
    [Tooltip("Enable the captured screen-space/page-table virtual-texture branch with the live Unity camera. Usually disabled unless all screen-space VT inputs are regenerated for that camera.")]
    public bool enableVirtualTextureBranchInCurrentCamera = true;

    [Header("Captured texture coordinates")]
    [Tooltip("Flip VS output UV0/UV1 Y before PS texture sampling. Required by EID3315 RenderDoc TGA exports.")]
    public bool flipMaterialUvY;

    [Header("Captured projection visibility")]
    public bool useCapturedVisibilityMaskInCapturedProjection;
    public bool capturedVisibilityFlipY;
    public Texture2D capturedVisibilityMask;

    [Header("Source assets")]
    [Tooltip("Optional captured material used as the authoritative texture table for this draw profile.")]
    public Material textureSourceMaterial;
    public GameObject modelAsset;
    public TextAsset exportMetadata;
    public TextAsset instanceMetadata;
}



