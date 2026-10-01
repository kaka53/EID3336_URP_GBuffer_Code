#if UNITY_EDITOR
using System;
using System.IO;
using UnityEditor;
using UnityEngine;
using UnityEngine.Experimental.Rendering;

[InitializeOnLoad]
public static class EID4673CapturedNativeConverter
{
    const string NativeRoot = "Assets/EID4673_CharacterForward/Captured/UnityNative/";

    static EID4673CapturedNativeConverter() => EditorApplication.delayCall += ConvertMissing;

    [MenuItem("EID4673/Convert Captured Raw To Native")]
    public static void ConvertMenu() => ConvertAll(true);

    static void ConvertMissing() => ConvertAll(false);

    static void ConvertAll(bool forceLog)
    {
        Directory.CreateDirectory(Path.Combine(Application.dataPath, "EID4673_CharacterForward/Captured/UnityNative"));
        bool wrote = false;
        wrote |= ConvertRaw2D("rid195216.bin", 256, 1, GraphicsFormat.R8G8B8A8_UNorm, FilterMode.Bilinear, TextureWrapMode.Clamp);
        wrote |= ConvertRaw2D("rid195422.bin", 256, 256, GraphicsFormat.R8G8B8A8_UNorm, FilterMode.Bilinear, TextureWrapMode.Clamp);
        wrote |= ConvertRaw2D("rid209554.bin", 1366, 768, GraphicsFormat.R8G8_UNorm, FilterMode.Point, TextureWrapMode.Clamp);
        wrote |= ConvertRaw3D("rid209575.bin", 86, 48, 128, TextureFormat.RGBAHalf, FilterMode.Bilinear, TextureWrapMode.Clamp);
        wrote |= ConvertRaw3D("rid198555.bin", 128, 192, 128, TextureFormat.RGBA32, FilterMode.Bilinear, TextureWrapMode.Clamp);
        wrote |= ConvertRaw3D("rid198561.bin", 128, 192, 128, TextureFormat.RGBA32, FilterMode.Bilinear, TextureWrapMode.Clamp);
        wrote |= ConvertRaw3D("rid198567.bin", 128, 192, 128, TextureFormat.RGBA32, FilterMode.Bilinear, TextureWrapMode.Clamp);
        wrote |= ConvertR11G11B10ToHalf3D("rid198552.bin", 128, 64, 128);
        wrote |= ConvertR11G11B10ToHalf3D("rid198558.bin", 128, 64, 128);
        wrote |= ConvertR11G11B10ToHalf3D("rid198564.bin", 128, 64, 128);
        if (wrote)
        {
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
            Debug.Log("[EID4673] Converted captured raw bins to UnityNative LUT195422/shadow/fog/irr.");
        }
        else if (forceLog)
        {
            Debug.Log("[EID4673] UnityNative LUT195422/shadow/fog/irr already exist.");
        }
    }

    static bool ConvertRaw2D(string fileName, int width, int height, GraphicsFormat format, FilterMode filter, TextureWrapMode wrap)
    {
        string output = NativeRoot + Path.GetFileNameWithoutExtension(fileName) + ".asset";
        if (AssetDatabase.LoadAssetAtPath<Texture2D>(output) != null)
            return false;
        string source = Path.Combine(Application.dataPath, "EID4673_CharacterForward/Captured/Raw", fileName);
        if (!File.Exists(source))
        {
            Debug.LogWarning("[EID4673] Missing raw: " + source);
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

    static bool ConvertRaw3D(string fileName, int width, int height, int depth, TextureFormat format, FilterMode filter, TextureWrapMode wrap)
    {
        string output = NativeRoot + Path.GetFileNameWithoutExtension(fileName) + ".asset";
        if (AssetDatabase.LoadAssetAtPath<Texture3D>(output) != null)
            return false;
        string source = Path.Combine(Application.dataPath, "EID4673_CharacterForward/Captured/Raw", fileName);
        if (!File.Exists(source))
        {
            Debug.LogWarning("[EID4673] Missing raw: " + source);
            return false;
        }
        byte[] raw = File.ReadAllBytes(source);
        var tex = new Texture3D(width, height, depth, format, false);
        tex.name = Path.GetFileNameWithoutExtension(fileName);
        tex.wrapMode = wrap;
        tex.filterMode = filter;
        tex.SetPixelData(raw, 0);
        tex.Apply(false, true);
        AssetDatabase.CreateAsset(tex, output);
        return true;
    }

    static bool ConvertR11G11B10ToHalf3D(string fileName, int width, int height, int depth)
    {
        string output = NativeRoot + Path.GetFileNameWithoutExtension(fileName) + ".asset";
        if (AssetDatabase.LoadAssetAtPath<Texture3D>(output) != null)
            return false;
        string source = Path.Combine(Application.dataPath, "EID4673_CharacterForward/Captured/Raw", fileName);
        if (!File.Exists(source))
        {
            Debug.LogWarning("[EID4673] Missing raw: " + source);
            return false;
        }
        byte[] packed = File.ReadAllBytes(source);
        int voxels = width * height * depth;
        if (packed.Length < voxels * 4)
        {
            Debug.LogWarning("[EID4673] Short R11G11B10 raw: " + source + " bytes=" + packed.Length);
            return false;
        }
        byte[] halfs = new byte[voxels * 8];
        ushort one = Mathf.FloatToHalf(1f);
        for (int i = 0; i < voxels; i++)
        {
            uint pck = (uint)(packed[i * 4] | (packed[i * 4 + 1] << 8) | (packed[i * 4 + 2] << 16) | (packed[i * 4 + 3] << 24));
            int o = i * 8;
            WriteU16(halfs, o, Mathf.FloatToHalf(DecodeUFloat(pck & 0x7FFu, 6)));
            WriteU16(halfs, o + 2, Mathf.FloatToHalf(DecodeUFloat((pck >> 11) & 0x7FFu, 6)));
            WriteU16(halfs, o + 4, Mathf.FloatToHalf(DecodeUFloat((pck >> 22) & 0x3FFu, 5)));
            WriteU16(halfs, o + 6, one);
        }
        var tex = new Texture3D(width, height, depth, TextureFormat.RGBAHalf, false);
        tex.name = Path.GetFileNameWithoutExtension(fileName);
        tex.wrapMode = TextureWrapMode.Clamp;
        tex.filterMode = FilterMode.Bilinear;
        tex.SetPixelData(halfs, 0);
        tex.Apply(false, true);
        AssetDatabase.CreateAsset(tex, output);
        return true;
    }

    static void WriteU16(byte[] dst, int offset, ushort value)
    {
        dst[offset] = (byte)value;
        dst[offset + 1] = (byte)(value >> 8);
    }

    static float DecodeUFloat(uint bits, int mantissaBits)
    {
        uint mantissaMask = (1u << mantissaBits) - 1u;
        uint m = bits & mantissaMask;
        uint e = (bits >> mantissaBits) & 0x1Fu;
        if (e == 31u)
            return m == 0u ? float.PositiveInfinity : float.NaN;
        if (e == 0u)
        {
            if (m == 0u)
                return 0f;
            return (m / (float)(1 << mantissaBits)) * Mathf.Pow(2f, -14);
        }
        uint f = ((e + (127u - 15u)) << 23) | (m << (23 - mantissaBits));
        return BitConverter.ToSingle(BitConverter.GetBytes(f), 0);
    }
}
#endif
