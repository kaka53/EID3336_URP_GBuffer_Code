#if UNITY_EDITOR
using UnityEditor;
using UnityEngine;

/// <summary>
/// Material inspector for the recovered EID3336 PS209987 parameter bank.
/// The shader still stores the exact float4 packing; this GUI only exposes
/// scalar/color/vector controls and writes the same underlying property.
/// </summary>
public sealed class EID3336RenderDocGBufferShaderGUI : ShaderGUI
{
    static readonly string[] ParamNames =
    {
        "_EID3336PSLocalParam00", "_EID3336PSLocalParam01", "_EID3336PSLocalParam02", "_EID3336PSLocalParam03", "_EID3336PSLocalParam04",
        "_EID3336PSLocalParam05", "_EID3336PSLocalParam06", "_EID3336PSLocalParam07", "_EID3336PSLocalParam08", "_EID3336PSLocalParam09",
        "_EID3336PSLocalParam10", "_EID3336PSLocalParam11", "_EID3336PSLocalParam12", "_EID3336PSLocalParam13", "_EID3336PSLocalParam14",
        "_EID3336PSLocalParam15", "_EID3336PSLocalParam16", "_EID3336PSLocalParam17", "_EID3336PSLocalParam18", "_EID3336PSLocalParam19",
        "_EID3336PSLocalParam20", "_EID3336PSLocalParam21", "_EID3336PSLocalParam22", "_EID3336PSLocalParam23", "_EID3336PSLocalParam24",
        "_EID3336PSLocalParam25", "_EID3336PSLocalParam26", "_EID3336PSLocalParam27", "_EID3336PSLocalParam28", "_EID3336PSLocalParam29",
        "_EID3336PSLocalParam30", "_EID3336PSLocalParam31", "_EID3336PSLocalParam32", "_EID3336PSLocalParam33", "_EID3336PSLocalParam34",
        "_EID3336PSLocalParam35", "_EID3336PSLocalParam36", "_EID3336PSLocalParam37", "_EID3336PSLocalParam38", "_EID3336PSLocalParam39",
        "_EID3336PSLocalParam40", "_EID3336PSLocalParam41", "_EID3336PSLocalParam42", "_EID3336PSLocalParam43", "_EID3336PSLocalParam44"
    };

    static readonly ColorProperty[] Colors =
    {
        new ColorProperty(8, "基础颜色乘色 RGB", false),
        new ColorProperty(24, "细节颜色调制 RGB", false),
        new ColorProperty(30, "投射颜色乘色 RGB", false),
        new ColorProperty(38, "第1覆盖层颜色 RGB", true),
        new ColorProperty(39, "第2覆盖层颜色 RGB", true),
        new ColorProperty(40, "第3覆盖层颜色 RGB", true),
    };

    struct ColorProperty
    {
        public readonly int Index;
        public readonly string Label;
        public readonly bool ShowAlpha;
        public ColorProperty(int index, string label, bool showAlpha) { Index = index; Label = label; ShowAlpha = showAlpha; }
    }

    // A parameter bank is still one float4 in HLSL. The controls below expose
    // the scalar channel that is actually consumed by the recovered algorithm.
    static readonly string[,] ScalarLabels =
    {
        { "基础法线强度", "基础遮蔽混合", "基础色UV选择", "法线采样UV选择" },
        { "基础遮蔽混合", "未使用", "未使用", "背面切线翻转" },
        { "未使用", "未使用", "未使用", "UV0/UV1混合" },
        { "法线UV选择", "法线Mip偏移", "未使用", "基础标量来源" },
        { "强制常量色", "标量备用值", "基础色倍率", "输出权重" },
        { "输出权重偏置", "第二标量系数", "未使用", "未使用" },
        { "未使用", "未使用", "未使用", "未使用" },
        { "RT1标志", "权重禁用", "未使用", "未使用" },
    };

    public override void OnGUI(MaterialEditor editor, MaterialProperty[] properties)
    {
        if (editor == null || editor.target == null) return;
        Material material = editor.target as Material;
        if (material == null) return;

        EditorGUILayout.LabelField("EID3336 RenderDoc 参数", EditorStyles.boldLabel);
        EditorGUILayout.HelpBox("材质球只管理局部材质参数；相机、MVP、GBuffer资源和帧常量由渲染管线提供。修改颜色/标量会写回同一个 float4 属性，不改变 Shader 内存布局。", MessageType.Info);

        DrawTextureProperties(editor, properties);
        EditorGUILayout.Space(4);
        DrawToggle(editor, properties, "_EID3336PSUseLocalParams", "使用材质球PS参数");
        EditorGUILayout.HelpBox("关闭后使用 RenderDoc 捕获的 uniforms44 参数；开启后使用下方材质球参数。", MessageType.None);

        EditorGUILayout.Space(4);
        EditorGUILayout.LabelField("基础 / 法线 / 输出标量", EditorStyles.boldLabel);
        for (int i = 0; i <= 7; ++i) DrawScalarBank(editor, properties, i);

        EditorGUILayout.Space(4);
        EditorGUILayout.LabelField("颜色与纹理向量", EditorStyles.boldLabel);
        foreach (var c in Colors) DrawColorBank(editor, properties, c);
        DrawVectorBank(editor, properties, 11, "基础色 UV：XY缩放，ZW偏移");
        DrawVectorBank(editor, properties, 12, "基础法线 UV：XY缩放，ZW偏移");
        DrawScalarBank(editor, properties, 22);
        DrawScalarBank(editor, properties, 23);
        DrawVectorBank(editor, properties, 25, "细节贴图 UV：XY缩放，ZW偏移");
        DrawScalarBank(editor, properties, 26);
        DrawScalarBank(editor, properties, 27);
        DrawScalarBank(editor, properties, 28);
        DrawScalarBank(editor, properties, 29);
        DrawVectorBank(editor, properties, 31, "投射 UV 偏移：XY");
        for (int i = 32; i <= 37; ++i) DrawScalarBank(editor, properties, i);
        DrawVectorBank(editor, properties, 41, "三层遮罩 UV：XY缩放，ZW偏移");
        for (int i = 42; i <= 44; ++i) DrawScalarBank(editor, properties, i);

        EditorGUILayout.Space(4);
        EditorGUILayout.LabelField("未参与当前 FS209987 路径的保留参数", EditorStyles.boldLabel);
        for (int i = 6; i <= 7; ++i) DrawVectorBank(editor, properties, i, "捕获保留值；当前算法未直接读取");
        for (int i = 13; i <= 21; ++i) DrawVectorBank(editor, properties, i, "捕获保留值；当前算法未直接读取");
        for (int i = 30; i == 30; ++i) { } // c30 is already exposed as color.

        EditorGUILayout.Space(4);
        DrawOtherLocalProperties(editor, properties);
    }

    static void DrawTextureProperties(MaterialEditor editor, MaterialProperty[] properties)
    {
        EditorGUILayout.LabelField("纹理资源", EditorStyles.boldLabel);
        string[] ids = { "_33", "_35", "_37", "_38", "_39", "_40", "_41", "_42", "_53", "_54", "_55", "_56", "_57", "_58", "_59", "_60", "_61", "_62", "_63", "_64", "_65" };
        foreach (string id in ids)
        {
            MaterialProperty p = Find(properties, id);
            if (p != null) editor.TexturePropertySingleLine(new GUIContent(p.displayName), p);
        }
    }

    static void DrawScalarBank(MaterialEditor editor, MaterialProperty[] properties, int index)
    {
        MaterialProperty p = Find(properties, ParamNames[index]);
        if (p == null) return;
        Vector4 v = p.vectorValue;
        EditorGUI.BeginChangeCheck();
        EditorGUILayout.LabelField(p.displayName, EditorStyles.boldLabel);
        for (int c = 0; c < 4; ++c)
        {
            string label = index < ScalarLabels.GetLength(0) ? ScalarLabels[index, c] : ChannelLabel(index, c);
            if (string.IsNullOrEmpty(label) || label == "未使用")
            {
                EditorGUI.BeginDisabledGroup(true);
                EditorGUILayout.FloatField(ChannelName(c) + "（未使用）", Channel(v, c));
                EditorGUI.EndDisabledGroup();
            }
            else SetChannel(ref v, c, EditorGUILayout.FloatField(ChannelName(c) + " " + label, Channel(v, c)));
        }
        if (EditorGUI.EndChangeCheck()) p.vectorValue = v;
    }

    static void DrawColorBank(MaterialEditor editor, MaterialProperty[] properties, ColorProperty cp)
    {
        MaterialProperty p = Find(properties, ParamNames[cp.Index]);
        if (p == null) return;
        Vector4 v = p.vectorValue;
        EditorGUI.BeginChangeCheck();
        Color rgb = EditorGUILayout.ColorField(new GUIContent(cp.Label), new Color(v.x, v.y, v.z, 1f), true, false, false);
        v.x = rgb.r; v.y = rgb.g; v.z = rgb.b;
        if (cp.ShowAlpha) v.w = EditorGUILayout.Slider("A 遮罩强度", v.w, 0f, 1f);
        else { EditorGUI.BeginDisabledGroup(true); EditorGUILayout.FloatField("A（算法未使用）", v.w); EditorGUI.EndDisabledGroup(); }
        if (EditorGUI.EndChangeCheck()) p.vectorValue = v;
    }

    static void DrawVectorBank(MaterialEditor editor, MaterialProperty[] properties, int index, string label)
    {
        MaterialProperty p = Find(properties, ParamNames[index]);
        if (p == null) return;
        EditorGUI.BeginChangeCheck();
        Vector4 v = EditorGUILayout.Vector4Field(new GUIContent(p.displayName + " - " + label), p.vectorValue);
        if (EditorGUI.EndChangeCheck()) p.vectorValue = v;
    }

    static void DrawToggle(MaterialEditor editor, MaterialProperty[] properties, string id, string label)
    {
        MaterialProperty p = Find(properties, id);
        if (p != null) editor.ShaderProperty(p, label);
    }

    static void DrawOtherLocalProperties(MaterialEditor editor, MaterialProperty[] properties)
    {
        DrawToggle(editor, properties, "_EID3336UseLocalVSOverrides", "启用顶点局部缩放和偏移");
        DrawVectorBankById(editor, properties, "_EID3336VSLocalScale", "顶点局部缩放 XYZ");
        DrawVectorBankById(editor, properties, "_EID3336VSLocalOffset", "顶点局部偏移 XYZ");
        DrawToggle(editor, properties, "_EID3336PSLocalUseUVTransform", "启用最终UV变换");
        DrawVectorBankById(editor, properties, "_EID3336PSLocalUV0ScaleOffset", "最终UV0：XY缩放，ZW偏移");
        DrawVectorBankById(editor, properties, "_EID3336PSLocalUV1ScaleOffset", "最终UV1：XY缩放，ZW偏移");
        DrawToggle(editor, properties, "_EID3336PSLocalFlipUVY", "翻转最终UV的Y轴");
    }

    static void DrawVectorBankById(MaterialEditor editor, MaterialProperty[] properties, string id, string label)
    {
        MaterialProperty p = Find(properties, id); if (p == null) return;
        p.vectorValue = EditorGUILayout.Vector4Field(label, p.vectorValue);
    }

    static MaterialProperty Find(MaterialProperty[] properties, string name)
    {
        foreach (MaterialProperty p in properties) if (p != null && p.name == name) return p;
        return null;
    }
    static string ChannelName(int c) { return c == 0 ? "X" : c == 1 ? "Y" : c == 2 ? "Z" : "W"; }
    static string ChannelLabel(int i, int c) { return "参数通道" + ChannelName(c); }
    static float Channel(Vector4 v, int c) { return c == 0 ? v.x : c == 1 ? v.y : c == 2 ? v.z : v.w; }
    static void SetChannel(ref Vector4 v, int c, float x) { if (c == 0) v.x=x; else if(c==1)v.y=x; else if(c==2)v.z=x; else v.w=x; }
}
#endif
