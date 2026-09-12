using UnityEngine;

[CreateAssetMenu(menuName = "EID/VS209975 PS209977 Draw Profile", fileName = "EID209975DrawProfile")]
public sealed class EID209975DrawProfile : ScriptableObject
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
