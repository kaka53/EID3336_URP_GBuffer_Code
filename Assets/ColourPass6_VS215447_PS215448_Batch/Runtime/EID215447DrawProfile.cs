using UnityEngine;

[CreateAssetMenu(menuName = "Colour Pass 6/VS215447 Draw Profile")]
public sealed class EID215447DrawProfile : ScriptableObject
{
    public int eventId;
    public int indexCount;
    public int instanceCount;
    public int vertexCount;
    public int triangleCount;
    public int sourceIndexStride;
    public int sourceIndexMin;
    public int sourceIndexMax;
    public string shaderFamily;
    public string meshItem;
    public int sharedGeometryFromEID;
    public bool bakedCapturedSkinning;
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
