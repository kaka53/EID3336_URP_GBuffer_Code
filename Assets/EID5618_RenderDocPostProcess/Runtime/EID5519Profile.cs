using UnityEngine;
[CreateAssetMenu(menuName="EID5519/Captured Inputs")]
public sealed class EID5519Profile : ScriptableObject
{
 public Shader shader;
 public Texture currentDepth, currentMotion, previousDepth, previousMotion;
 public TextAsset cameraConstants, frameConstants;
}
