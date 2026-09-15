using UnityEngine;

[CreateAssetMenu(menuName = "EID/VS215496 PS215498 Draw Profile", fileName = "EID215496DrawProfile")]
public sealed class EID215496DrawProfile : ScriptableObject
{
    public int eventId;
    public int indexCount;
    public int instanceCount;
    public int vertexCount;
    public int triangleCount;
    public int sourceIndexStride;
    public int sourceIndexMin;
    public int sourceIndexMax;
    public bool bakedCapturedSkinning;
    public string shaderFamily;
    public string meshItem;
    public int sharedGeometryFromEID;
    public string[] vertexInputLayout;
    public string[] sourceStreams;
    public string indexSource;
    public string vsConstantSources;
    public string psConstantSources;
    public string textureBindings;
    public Matrix4x4[] capturedInstanceMatrices;
    public Material material;
    public Mesh mesh;
}
