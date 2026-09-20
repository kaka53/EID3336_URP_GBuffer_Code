#if UNITY_EDITOR
using System;
using System.IO;
using UnityEditor;
using UnityEngine;
using UnityEngine.Experimental.Rendering;

[InitializeOnLoad]
internal static class EID4649CapturedNativeConverter
{
    const string NativeRoot = "Assets/EID4649_ColourPass20/Captured/UnityNative/";
    const string RawRoot = "Assets/EID4649_ColourPass20/Captured/Raw/";

    static EID4649CapturedNativeConverter() => EditorApplication.delayCall += ConvertMissing;

    [MenuItem("EID4649/Convert Captured Raw To Native")]
    public static void ConvertMenu() => ConvertAll(true);

    static void ConvertMissing() => ConvertAll(false);

    static void ConvertAll(bool forceLog)
    {
        Directory.CreateDirectory(Path.Combine(Application.dataPath, "EID4649_ColourPass20/Captured/UnityNative"));
        bool wrote = false;
        wrote |= ConvertRaw("rid209590.bin", 342, 192, GraphicsFormat.R8_UNorm, FilterMode.Point, TextureWrapMode.Clamp);
        wrote |= ConvertRaw("rid209560.bin", 1366, 768, GraphicsFormat.R32_SFloat, FilterMode.Point, TextureWrapMode.Clamp);
        wrote |= ConvertRaw("rid209068.bin", 2048, 2048, GraphicsFormat.R16_UNorm, FilterMode.Point, TextureWrapMode.Clamp);
        wrote |= ConvertRaw("rid209071.bin", 4096, 4096, GraphicsFormat.R16_UNorm, FilterMode.Point, TextureWrapMode.Clamp);
        wrote |= ConvertRaw("rid209554.bin", 1366, 768, GraphicsFormat.R8G8_UNorm, FilterMode.Point, TextureWrapMode.Clamp);
        wrote |= ConvertBc7("rid198185.bin", 1024, 1024);
        if (wrote)
        {
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
            Debug.Log("[EID4649] Converted captured raw bins to UnityNative Texture2D type 2.");
        }
        else if (forceLog)
        {
            Debug.Log("[EID4649] UnityNative textures already exist.");
        }
    }

    static bool ConvertRaw(string fileName, int width, int height, GraphicsFormat format, FilterMode filter, TextureWrapMode wrap)
    {
        string output = NativeRoot + Path.GetFileNameWithoutExtension(fileName) + ".asset";
        if (AssetDatabase.LoadAssetAtPath<Texture2D>(output) != null)
            return false;
        string source = Path.Combine(Application.dataPath, "EID4649_ColourPass20/Captured/Raw", fileName);
        if (!File.Exists(source))
        {
            Debug.LogWarning("[EID4649] Missing raw: " + source);
            return false;
        }
        byte[] raw = File.ReadAllBytes(source);
        var tex = new Texture2D(width, height, format, TextureCreationFlags.None);
        tex.name = Path.GetFileNameWithoutExtension(fileName);
        tex.wrapMode = wrap;
        tex.filterMode = filter;
        tex.LoadRawTextureData(raw);
        tex.Apply(false, true);
        AssetDatabase.CreateAsset(tex, output);
        return true;
    }

    static bool ConvertBc7(string fileName, int width, int height)
    {
        string output = NativeRoot + Path.GetFileNameWithoutExtension(fileName) + ".asset";
        if (AssetDatabase.LoadAssetAtPath<Texture2D>(output) != null)
            return false;
        string source = Path.Combine(Application.dataPath, "EID4649_ColourPass20/Captured/Raw", fileName);
        if (!File.Exists(source))
        {
            Debug.LogWarning("[EID4649] Missing raw: " + source);
            return false;
        }
        byte[] raw = File.ReadAllBytes(source);
        var tex = new Texture2D(width, height, TextureFormat.BC7, false, true)
        {
            name = Path.GetFileNameWithoutExtension(fileName),
            wrapMode = TextureWrapMode.Repeat,
            filterMode = FilterMode.Trilinear,
            anisoLevel = 1
        };
        tex.SetPixelData(raw, 0);
        tex.Apply(false, true);
        AssetDatabase.CreateAsset(tex, output);
        return true;
    }
}
#endif
