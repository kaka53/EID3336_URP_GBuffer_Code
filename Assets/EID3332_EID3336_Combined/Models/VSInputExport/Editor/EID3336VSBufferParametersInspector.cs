#if UNITY_EDITOR
using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(EID3336VSBufferParameters))]
public sealed class EID3336VSBufferParametersInspector : Editor
{
    Vector2 scroll;
    bool[] expanded = new bool[8];
    bool showAllStructuredRows;

    public override void OnInspectorGUI()
    {
        var asset = (EID3336VSBufferParameters)target;
        EditorGUILayout.LabelField("RenderDoc VS Buffer Parameters", EditorStyles.boldLabel);
        EditorGUILayout.LabelField("Event / VS", asset.eventId + " / " + asset.vertexShaderId);
        EditorGUILayout.LabelField("Draw", "indices=" + asset.indexCount + "  instances=" + asset.instanceCount + "  vertices=" + asset.vertexCount);
        EditorGUILayout.LabelField("Source", asset.sourceDescription, EditorStyles.wordWrappedLabel);
        EditorGUILayout.Space(4);

        if (asset.buffers == null) return;
        if (expanded.Length != asset.buffers.Length) expanded = new bool[asset.buffers.Length];
        scroll = EditorGUILayout.BeginScrollView(scroll);
        for (int i = 0; i < asset.buffers.Length; ++i)
        {
            var b = asset.buffers[i];
            if (b == null) continue;
            expanded[i] = EditorGUILayout.Foldout(expanded[i], b.shaderResourceName + "  (" + b.name + ")", true);
            if (!expanded[i]) continue;
            EditorGUI.indentLevel++;
            EditorGUILayout.LabelField("Set / Binding", b.descriptorSet + " / " + b.binding);
            EditorGUILayout.LabelField("Resource ID", b.resourceId.ToString());
            EditorGUILayout.LabelField("Byte range", b.rangeStart + " - " + b.rangeEnd + " (" + b.byteSize + " bytes)");
            EditorGUILayout.LabelField("RenderDoc variables", b.variableCount.ToString());
            if (b.structuredStride > 0)
                EditorGUILayout.LabelField("Structured records", b.structuredElementCount + " x " + b.structuredStride + " bytes");
            if (b.parameters != null)
            {
                int limit = b.name == "VS_28_30" && !showAllStructuredRows ? Mathf.Min(16, b.parameters.Length) : b.parameters.Length;
                EditorGUILayout.LabelField("Decoded numeric rows", b.parameters.Length.ToString());
                for (int j = 0; j < limit; ++j)
                {
                    var p = b.parameters[j];
                    if (p == null) continue;
                    EditorGUILayout.LabelField(p.name + "  [" + p.type + "]  offset=" + p.byteOffset + " size=" + p.byteSize, EditorStyles.boldLabel);
                    if (p.values != null)
                        for (int k = 0; k < p.values.Length; ++k)
                            EditorGUILayout.Vector4Field("  " + (p.type.Contains("x4") ? "column " : "value ") + k, p.values[k]);
                }
                if (b.name == "VS_28_30" && b.parameters.Length > limit)
                    showAllStructuredRows = EditorGUILayout.ToggleLeft("Show all uniforms30 rows (4096 rows)", showAllStructuredRows);
            }
            EditorGUI.indentLevel--;
            EditorGUILayout.Space(6);
        }
        EditorGUILayout.EndScrollView();
    }
}
#endif

