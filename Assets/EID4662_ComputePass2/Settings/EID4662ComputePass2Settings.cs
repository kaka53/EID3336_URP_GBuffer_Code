using UnityEngine;

[CreateAssetMenu(fileName = "EID4662ComputePass2Settings", menuName = "EID4662/Compute Pass 2 Settings")]
public sealed class EID4662ComputePass2Settings : ScriptableObject
{
    [Header("Captured dispatch chain")]
    public string[] dispatchEids = { "4542", "4546", "4550", "4554", "4558", "4562", "4566", "4570", "4574", "4578", "4582", "4586", "4590", "4594" };
    [Header("Published global textures")]
    public string res18Global = "_EID4662_Res18";
    public string res19Global = "_EID4662_Res19";
    public string res33Global = "_EID4662_Res33";
    [Header("Debug")]
    [Range(0, 3)] public int debugOutput;
    public bool publishGlobalOutputs = true;
}
