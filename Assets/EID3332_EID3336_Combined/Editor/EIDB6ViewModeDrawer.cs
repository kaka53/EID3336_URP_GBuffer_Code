#if UNITY_EDITOR
using UnityEditor;
using UnityEngine;

/// <summary>Named material popup for all reconstructed B6 debug outputs.</summary>
public sealed class EIDB6ViewModeDrawer : MaterialPropertyDrawer
{
    static readonly string[] Labels =
    {
        "Final Lighting", "Direct Lighting", "Indirect Diffuse", "Indirect Specular",
        "Captured Lighting", "BRDF", "Base Color", "Normal WS", "World Position",
        "Material", "Linear Depth", "Probe Reflection", "Screen Specular",
        "Combined Indirect", "Probe Weight", "Reflection Validity",
        "GBuffer 0", "GBuffer 1", "GBuffer 2", "GBuffer 3"
    };

    public override void OnGUI(Rect position, MaterialProperty prop, string label, MaterialEditor editor)
    {
        EditorGUI.BeginChangeCheck();
        int current = Mathf.Clamp(Mathf.RoundToInt(prop.floatValue), 0, Labels.Length - 1);
        int next = EditorGUI.Popup(position, label, current, Labels);
        if (EditorGUI.EndChangeCheck()) prop.floatValue = next;
    }
}
#endif
