#if UNITY_EDITOR
using System;
using System.IO;
using System.Reflection;
using UnityEditor;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public static class EID5537FixedFrameSetup
{
    const string Base = "Assets/EID5618_RenderDocPostProcess/";
    const string Inputs = Base + "CapturedInputs/EID5537/";
    const string RendererPath = "Assets/EID3332_EID3336_Combined/Settings/EID3332Combined-Renderer.asset";
    const string ProfilePath = Base + "Materials/EID5537_FixedFrameProfile.asset";
    const string Native = Inputs + "UnityNative/";

    [MenuItem("EID5537/Install fixed-frame RenderFeature")]
    public static void Install()
    {
        AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
        var renderer = AssetDatabase.LoadAssetAtPath<UniversalRendererData>(RendererPath);
        if (renderer == null) throw new InvalidOperationException("Combined renderer not found.");
        var profile = AssetDatabase.LoadAssetAtPath<EID5537FixedFrameProfile>(ProfilePath);
        if (profile == null)
        {
            profile = ScriptableObject.CreateInstance<EID5537FixedFrameProfile>();
            AssetDatabase.CreateAsset(profile, ProfilePath);
        }
        Directory.CreateDirectory(Native);
        profile.res14Depth = ImportDds("res14", 10, GraphicsFormat.R16G16B16A16_SFloat, 8, FilterMode.Point);
        profile.res13Color = ImportDds("res13", 26, GraphicsFormat.R32G32B32A32_SFloat, 4, FilterMode.Bilinear);
        profile.res17Color = ImportDds("res17", 10, GraphicsFormat.R16G16B16A16_SFloat, 8, FilterMode.Point);
        profile.res16Mask = ImportDds("res16", 61, GraphicsFormat.R8_UNorm, 1, FilterMode.Bilinear);
        profile.res15Color = ImportDds("res15", 24, GraphicsFormat.R32G32B32A32_SFloat, 4, FilterMode.Bilinear);
        profile.uniforms12B7 = Require<TextAsset>(Inputs + "eid5537_uniforms12_b7.bytes");
        profile.uniforms6B8 = Require<TextAsset>(Inputs + "eid5537_uniforms6_b8.bytes");
        EditorUtility.SetDirty(profile);

        EID5537FixedFrameRendererFeature feature = null;
        foreach (var entry in renderer.rendererFeatures)
            if (entry is EID5537FixedFrameRendererFeature existing) { feature = existing; break; }
        if (feature == null)
        {
            feature = ScriptableObject.CreateInstance<EID5537FixedFrameRendererFeature>();
            feature.name = "EID5537FixedFrameRendererFeature";
            AssetDatabase.AddObjectToAsset(feature, renderer);
            int before5618 = renderer.rendererFeatures.FindIndex(f => f is EID5618PostProcessRendererFeature);
            renderer.rendererFeatures.Insert(before5618 < 0 ? renderer.rendererFeatures.Count : before5618, feature);
        }
        feature.settings.profile = profile;
        feature.settings.shader = Require<Shader>(Base + "Shaders/EID5537Res9.shader");
        feature.settings.injectionPoint = RenderPassEvent.AfterRenderingPostProcessing;
        feature.settings.renderInGameView = true;
        feature.settings.renderInSceneView = false;
        feature.settings.enabledForCamera = true;
        EditorUtility.SetDirty(feature);
        EditorUtility.SetDirty(renderer);
        typeof(ScriptableRendererData).GetMethod("ValidateRendererFeatures", BindingFlags.Instance | BindingFlags.NonPublic)
            ?.Invoke(renderer, null);
        AssetDatabase.SaveAssets();
        Debug.Log("[EID5537] Fixed-frame RenderFeature installed before EID5618; camera colour and res9Source unchanged.");
    }

    static T Require<T>(string path) where T : UnityEngine.Object
    {
        T asset = AssetDatabase.LoadAssetAtPath<T>(path);
        if (asset == null) throw new InvalidOperationException("EID5537 input missing or not importable: " + path);
        return asset;
    }

    static Texture2D ImportDds(string name, int dxgi, GraphicsFormat format, int bytesPerPixel, FilterMode filter)
    {
        string assetPath = Native + name + ".asset";
        Texture2D existing = AssetDatabase.LoadAssetAtPath<Texture2D>(assetPath);
        if (existing != null) return existing;
        byte[] dds = File.ReadAllBytes(Inputs + name + ".dds");
        if (dds.Length < 148 || BitConverter.ToUInt32(dds, 0) != 0x20534444 ||
            BitConverter.ToInt32(dds, 128) != dxgi)
            throw new InvalidDataException(name + ": invalid DDS/DXGI format");
        int width = BitConverter.ToInt32(dds, 16), height = BitConverter.ToInt32(dds, 12);
        int size = checked(width * height * bytesPerPixel);
        if (dds.Length != 148 + size) throw new InvalidDataException(name + ": unexpected DDS payload length");
        if (!SystemInfo.IsFormatSupported(format, FormatUsage.Sample))
            throw new NotSupportedException(name + ": graphics format not sampleable: " + format);
        var texture = new Texture2D(width, height, format, TextureCreationFlags.None)
        {
            name = "EID5537_" + name, filterMode = filter,
            wrapMode = TextureWrapMode.Clamp, anisoLevel = 0
        };
        var payload = new byte[size];
        Buffer.BlockCopy(dds, 148, payload, 0, size);
        if (dxgi == 26 || dxgi == 24) payload = ExpandPacked(payload, dxgi);
        texture.LoadRawTextureData(payload);
        texture.Apply(false, true);
        AssetDatabase.CreateAsset(texture, assetPath);
        return texture;
    }

    static byte[] ExpandPacked(byte[] input, int dxgi)
    {
        var result = new byte[input.Length * 4];
        for (int i = 0; i < input.Length / 4; i++)
        {
            uint bits = BitConverter.ToUInt32(input, i * 4);
            float r, g, b, a;
            if (dxgi == 26)
            {
                r = DecodeUFloat(bits & 0x7ff, 6);
                g = DecodeUFloat((bits >> 11) & 0x7ff, 6);
                b = DecodeUFloat((bits >> 22) & 0x3ff, 5);
                a = 1f;
            }
            else
            {
                r = (bits & 1023) / 1023f;
                g = ((bits >> 10) & 1023) / 1023f;
                b = ((bits >> 20) & 1023) / 1023f;
                a = ((bits >> 30) & 3) / 3f;
            }
            Buffer.BlockCopy(BitConverter.GetBytes(r), 0, result, i * 16, 4);
            Buffer.BlockCopy(BitConverter.GetBytes(g), 0, result, i * 16 + 4, 4);
            Buffer.BlockCopy(BitConverter.GetBytes(b), 0, result, i * 16 + 8, 4);
            Buffer.BlockCopy(BitConverter.GetBytes(a), 0, result, i * 16 + 12, 4);
        }
        return result;
    }

    static float DecodeUFloat(uint bits, int mantissaBits)
    {
        uint mantissaMask = (uint)((1 << mantissaBits) - 1);
        uint exponent = bits >> mantissaBits;
        uint mantissa = bits & mantissaMask;
        if (exponent == 31) return mantissa == 0 ? float.PositiveInfinity : float.NaN;
        if (exponent == 0) return mantissa * Mathf.Pow(2f, -14 - mantissaBits);
        return (1f + mantissa / (float)(1 << mantissaBits)) * Mathf.Pow(2f, (int)exponent - 15);
    }
}
#endif
