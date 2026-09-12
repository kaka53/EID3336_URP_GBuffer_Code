using UnityEngine;

[CreateAssetMenu(menuName = "EID/VS215445 PS215446 Draw Profile", fileName = "EID215445DrawProfile")]
public sealed class EID215445DrawProfile : ScriptableObject
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
    public int capturedStencilRef;
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
