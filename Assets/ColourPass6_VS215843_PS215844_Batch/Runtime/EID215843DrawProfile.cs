using UnityEngine;

[CreateAssetMenu(menuName = "EID/VS215843 PS215844 Draw Profile", fileName = "EID215843DrawProfile")]
public sealed class EID215843DrawProfile : ScriptableObject
{
    public int eventId;
    public int indexCount;
    public int instanceCount;
    public int vertexCount;
    public int triangleCount;
    public int sourceIndexStride;
    public int sourceIndexMin;
    public int sourceIndexMax;
    public int instanceStride = 96;
    public string shaderFamily;
    public string meshItem;
    public int sharedGeometryFromEID;
    public string[] vertexInputLayout;
    public string[] sourceStreams;
    public string indexSource;
    public string instanceSource;
    public string vsConstantSources;
    public string psConstantSources;
    public string textureBindings;
    public Material material;
    public Mesh sourceMesh;
    public Mesh expandedMesh;
    public TextAsset instanceBytes;
}
