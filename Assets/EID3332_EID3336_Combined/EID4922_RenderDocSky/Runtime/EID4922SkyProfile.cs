using UnityEngine;

[CreateAssetMenu(menuName = "EID4922/RenderDoc Sky Profile")]
public sealed class EID4922SkyProfile : ScriptableObject
{
    public Mesh skyMesh;
    public Material skyMaterial;
    [Header("RenderDoc constant buffers")]
    public TextAsset frameUniforms11;
    public TextAsset viewUniforms13;
    public TextAsset objectUniforms15;
    public TextAsset skyUniforms32;
    [Header("RenderDoc textures")]
    public Texture res19;
    public Texture2D res29;
    public Texture2D res27;
    public Texture2D res25;
    public Texture2D res23;
    public Texture2D res21;
    public Texture2D res20;
    public Texture res18;
    [Header("Capture matching")]
    public bool useCapturedBuffers = true;
    [Tooltip("Use the current Unity camera view/projection every render. Keeps the sky centered on the camera and allows SceneView/GameView rotation.")]
    public bool useRealtimeCameraMatrices = true;
    [Min(1f)] public float skyRadius = 7198f;
    public bool enableAuxiliaryTarget = false;
    public Color fallbackColor = new Color(0.08f, 0.16f, 0.35f, 1f);
}
