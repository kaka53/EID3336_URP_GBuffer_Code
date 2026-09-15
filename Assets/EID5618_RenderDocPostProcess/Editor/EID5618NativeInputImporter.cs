#if UNITY_EDITOR
using System;
using System.IO;
using UnityEditor;
using UnityEngine;

internal static class EID5618NativeInputImporter
{
    const string Root = "Assets/EID5618_RenderDocPostProcess/CapturedInputs";
    const string Out = Root + "/UnityNative";

    [MenuItem("EID5618/Create native float input assets")]
    public static void Run()
    {
        Directory.CreateDirectory(Path.Combine(Application.dataPath, "EID5618_RenderDocPostProcess/CapturedInputs/UnityNative"));
        Texture2D res9 = CreateFromDds("res9", Root + "/res9.dds", 1366, 768);
        Texture2D res10 = CreateFromDds("res10", Root + "/res10_rgba16f.dds", 683, 384);
        Texture2D res11 = CreateFromDds("res11", Root + "/res11.dds", 1024, 32);
        AssetDatabase.SaveAssets();
        UpdateReferences(res9, res10, res11);
        AssetDatabase.SaveAssets();
        AssetDatabase.Refresh();
        Debug.Log($"[EID5618] Native inputs created: res9={res9 != null}, res10={res10 != null}, res11={res11 != null}");
        EditorApplication.Exit(0);
    }

    static Texture2D CreateFromDds(string name, string assetPath, int width, int height)
    {
        byte[] dds = File.ReadAllBytes(assetPath);
        int dataOffset = 148;
        int expected = width * height * 8;
        if (dds.Length - dataOffset != expected)
            throw new InvalidDataException($"{assetPath}: expected {expected} bytes after DDS header, got {dds.Length - dataOffset}");
        string outputPath = Out + "/" + name + ".asset";
        AssetDatabase.DeleteAsset(outputPath);
        Texture2D texture = new Texture2D(width, height, TextureFormat.RGBAHalf, false, true)
        {
            name = name + "_NativeRGBAHalf",
            filterMode = FilterMode.Bilinear,
            wrapMode = TextureWrapMode.Clamp,
            anisoLevel = 0,
        };
        byte[] pixels = new byte[expected];
        Buffer.BlockCopy(dds, dataOffset, pixels, 0, expected);
        texture.SetPixelData(pixels, 0);
        texture.Apply(false, false);
        AssetDatabase.CreateAsset(texture, outputPath);
        return AssetDatabase.LoadAssetAtPath<Texture2D>(outputPath);
    }

    static void UpdateReferences(Texture2D res9, Texture2D res10, Texture2D res11)
    {
        var profile = AssetDatabase.LoadAssetAtPath<EID5618InputProfile>("Assets/EID5618_RenderDocPostProcess/Materials/EID5618_InputProfile.asset");
        if (profile != null)
        {
            profile.res9Captured = res9;
            profile.res10 = res10;
            profile.res11Captured = res11;
            EditorUtility.SetDirty(profile);
        }
        var material = AssetDatabase.LoadAssetAtPath<Material>("Assets/EID5618_RenderDocPostProcess/Materials/EID5618_ExactRenderDoc.mat");
        if (material != null)
        {
            material.SetTexture("_EID5618Res9", res9);
            material.SetTexture("_EID5618Res10", res10);
            material.SetTexture("_EID5618Res11", res11);
            EditorUtility.SetDirty(material);
        }
    }
}
#endif
