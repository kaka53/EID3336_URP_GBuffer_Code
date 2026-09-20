using System;
using System.IO;
using UnityEditor;
using UnityEngine;
using UnityEngine.Experimental.Rendering;

[InitializeOnLoad]
internal static class EID4662ComputePass2CapturedResourcesAutoBinder
{
    const string AssetPath = "Assets/EID4662_ComputePass2/Settings/EID4662ComputePass2CapturedResources.asset";
    const string TextureRoot = "Assets/EID4662_ComputePass2/CapturedResources/Textures/";
    const string BufferRoot = "Assets/EID4662_ComputePass2/CapturedResources/Buffers/";
    const string NativeRoot = "Assets/EID4662_ComputePass2/CapturedResources/Native/";

    enum Encoding { Rgba16F, R32F, R10G10B10A2, R8, R11G11B10, R16G16UNorm, R8G8UNorm }

    static EID4662ComputePass2CapturedResourcesAutoBinder() => EditorApplication.delayCall += BindIfPresent;

    [MenuItem("EID4662/Compute Pass 2/Convert DDS To Native Textures")]
    public static void ConvertMenu() => ConvertAllDdsToNativeAssets();

    [MenuItem("EID4662/Compute Pass 2/Validate Compute Assets")]
    public static void ValidateComputeMenu()
    {
        string[] names = { "EID4542_Prepare.compute", "EID4546_Prepare.compute", "EID4550_Prepare.compute", "EID4554_SeedA.compute", "EID4558_SeedB.compute", "EID4562_Iterate.compute", "EID4586_BuildRes18.compute", "EID4590_BuildRes19.compute", "EID4594_BuildRes33.compute" };
        bool ok = true;
        foreach (string n in names)
        {
            var cs = AssetDatabase.LoadAssetAtPath<ComputeShader>("Assets/EID4662_ComputePass2/Shaders/" + n);
            if (cs == null) { Debug.LogError("[EID4662 ComputePass2] Missing ComputeShader: " + n); ok = false; continue; }
            try { int k = cs.FindKernel("CSMain"); Debug.Log("[EID4662 ComputePass2] Kernel OK " + n + " index=" + k); }
            catch (Exception e) { Debug.LogException(e); ok = false; }
        }
        if (!ok) throw new InvalidOperationException("EID4662 Compute Pass #2 compute asset validation failed.");
    }

    [MenuItem("EID4662/Compute Pass 2/Bind Exported Resources")]
    public static void BindMenu() => BindIfPresent();

    public static void ConvertAllDdsToNativeAssets()
    {
        Directory.CreateDirectory(Path.Combine(Application.dataPath, "EID4662_ComputePass2/CapturedResources/Native"));
        Convert("rid209495.dds", Encoding.Rgba16F);
        Convert("rid210490.dds", Encoding.R32F);
        Convert("rid209118.dds", Encoding.R32F);
        Convert("rid210525.dds", Encoding.R10G10B10A2);
        Convert("rid209510.dds", Encoding.R8);
        Convert("rid210516.dds", Encoding.R10G10B10A2);
        Convert("rid209543_depth_r32f.dds", Encoding.R32F, "rid209543_depth_r32f.asset");
        Convert("rid209547_stencil_r8.dds", Encoding.R8, "rid209547_stencil_r8.asset");
        Convert("rid210942.dds", Encoding.R8);
        Convert("rid210925.dds", Encoding.R11G11B10);
        Convert("rid209617.dds", Encoding.R11G11B10);
        Convert("rid209581.dds", Encoding.R8);
        Convert("rid210519.dds", Encoding.R16G16UNorm);
        Convert("rid210450.dds", Encoding.R11G11B10);
        Convert("rid210467.dds", Encoding.R8);
        Convert("rid209659.dds", Encoding.R11G11B10);
        Convert("rid209587.dds", Encoding.R8G8UNorm);
        AssetDatabase.SaveAssets();
        AssetDatabase.Refresh();
        Debug.Log("[EID4662 ComputePass2] Converted RenderDoc DDS payloads to native, sampleable Unity textures.");
    }

    static void Convert(string fileName, Encoding encoding, string outputName = null)
    {
        string source = Path.Combine(Application.dataPath, "EID4662_ComputePass2/CapturedResources/Textures", fileName);
        if (!File.Exists(source)) { Debug.LogWarning("[EID4662 ComputePass2] Missing DDS: " + source); return; }
        outputName ??= Path.GetFileNameWithoutExtension(fileName) + ".asset";
        string output = NativeRoot + outputName;
        if (AssetDatabase.LoadAssetAtPath<Texture2D>(output) != null) return;
        byte[] dds = File.ReadAllBytes(source);
        if (dds.Length < 128 || dds[0] != 'D' || dds[1] != 'D' || dds[2] != 'S') { Debug.LogError("Invalid DDS: " + fileName); return; }
        int height = BitConverter.ToInt32(dds, 12), width = BitConverter.ToInt32(dds, 16);
        int sourceMips = Math.Max(1, BitConverter.ToInt32(dds, 28));
        int offset = dds.Length >= 148 && dds[84] == 'D' && dds[85] == 'X' && dds[86] == '1' && dds[87] == '0' ? 148 : 128;
        int sourceBpp = SourceBytesPerPixel(encoding);
        bool semanticRgba = encoding != Encoding.R32F && encoding != Encoding.R8;
        GraphicsFormat outputFormat = semanticRgba ? GraphicsFormat.R32G32B32A32_SFloat : encoding == Encoding.R32F ? GraphicsFormat.R32_SFloat : GraphicsFormat.R8_UNorm;
        int outputBpp = semanticRgba ? 16 : sourceBpp;
        int fullMips = 1; int w = width, h = height;
        while (w != 1 || h != 1) { fullMips++; w = Math.Max(1, w >> 1); h = Math.Max(1, h >> 1); }
        var flags = fullMips > 1 ? TextureCreationFlags.MipChain : TextureCreationFlags.None;
        var tex = new Texture2D(width, height, outputFormat, flags);
        if (tex == null) { Debug.LogError("Unity cannot create native texture for " + fileName + " format=" + outputFormat); return; }
        byte[] raw = new byte[TotalBytes(width, height, fullMips, outputBpp)];
        w = width; h = height; int dst = 0;
        for (int mip = 0; mip < fullMips; mip++)
        {
            int srcLength = Math.Max(1, w) * Math.Max(1, h) * sourceBpp;
            int dstLength = Math.Max(1, w) * Math.Max(1, h) * outputBpp;
            if (mip < sourceMips)
            {
                if (offset + srcLength > dds.Length) { UnityEngine.Object.DestroyImmediate(tex); Debug.LogError("DDS payload truncated: " + fileName + " mip=" + mip); return; }
                if (!semanticRgba) Buffer.BlockCopy(dds, offset, raw, dst, dstLength);
                else DecodeMip(dds, offset, raw, dst, w, h, encoding);
                offset += srcLength;
            }
            dst += dstLength; w = Math.Max(1, w >> 1); h = Math.Max(1, h >> 1);
        }
        tex.name = Path.GetFileNameWithoutExtension(outputName);
        tex.wrapMode = TextureWrapMode.Clamp; tex.filterMode = FilterMode.Point;
        tex.LoadRawTextureData(raw); tex.Apply(false, true);
        AssetDatabase.CreateAsset(tex, output);
    }

    static int TotalBytes(int width, int height, int mips, int bpp)
    {
        int result = 0, w = width, h = height;
        for (int i = 0; i < mips; i++) { result += Math.Max(1, w) * Math.Max(1, h) * bpp; w = Math.Max(1, w >> 1); h = Math.Max(1, h >> 1); }
        return result;
    }

    static int SourceBytesPerPixel(Encoding e) => e == Encoding.R8 ? 1 : e == Encoding.R8G8UNorm ? 2 : e == Encoding.Rgba16F ? 8 : 4;

    static void DecodeMip(byte[] src, int srcOffset, byte[] dst, int dstOffset, int width, int height, Encoding encoding)
    {
        int count = width * height;
        for (int i = 0; i < count; i++)
        {
            int p = srcOffset + i * SourceBytesPerPixel(encoding); float r, g, b, a = 1;
            if (encoding == Encoding.R10G10B10A2) { uint v = BitConverter.ToUInt32(src, p); r = (v & 1023u) / 1023f; g = ((v >> 10) & 1023u) / 1023f; b = ((v >> 20) & 1023u) / 1023f; a = ((v >> 30) & 3u) / 3f; }
            else if (encoding == Encoding.R11G11B10) { uint v = BitConverter.ToUInt32(src, p); r = UnpackFloat(v & 0x7ffu, 6); g = UnpackFloat((v >> 11) & 0x7ffu, 6); b = UnpackFloat((v >> 22) & 0x3ffu, 5); }
            else if (encoding == Encoding.R16G16UNorm) { r = BitConverter.ToUInt16(src, p) / 65535f; g = BitConverter.ToUInt16(src, p + 2) / 65535f; b = 0; }
            else if (encoding == Encoding.R8G8UNorm) { r = src[p] / 255f; g = src[p + 1] / 255f; b = 0; }
            else { ushort hr = BitConverter.ToUInt16(src, p); ushort hg = BitConverter.ToUInt16(src, p + 2); ushort hb = BitConverter.ToUInt16(src, p + 4); ushort ha = BitConverter.ToUInt16(src, p + 6); r = HalfToFloat(hr); g = HalfToFloat(hg); b = HalfToFloat(hb); a = HalfToFloat(ha); }
            int d = dstOffset + i * 16; Buffer.BlockCopy(BitConverter.GetBytes(r), 0, dst, d, 4); Buffer.BlockCopy(BitConverter.GetBytes(g), 0, dst, d + 4, 4); Buffer.BlockCopy(BitConverter.GetBytes(b), 0, dst, d + 8, 4); Buffer.BlockCopy(BitConverter.GetBytes(a), 0, dst, d + 12, 4);
        }
    }

    static float UnpackFloat(uint bits, int mantissaBits)
    {
        uint mantissaMask = (1u << mantissaBits) - 1u; uint mantissa = bits & mantissaMask; uint exponent = bits >> mantissaBits;
        if (exponent == 0) return (float)(mantissa / (double)(1u << mantissaBits) * Math.Pow(2, -14));
        if (exponent == ((1u << 5) - 1u)) return mantissa == 0 ? float.PositiveInfinity : float.NaN;
        return (float)((1.0 + mantissa / (double)(1u << mantissaBits)) * Math.Pow(2, exponent - 15));
    }

    static float HalfToFloat(ushort h)
    {
        uint sign = (uint)(h >> 15), exp = (uint)((h >> 10) & 31), mant = (uint)(h & 1023);
        if (exp == 0) return (float)((sign == 0 ? 1 : -1) * mant / 1024.0 * Math.Pow(2, -14));
        if (exp == 31) return mant == 0 ? (sign == 0 ? float.PositiveInfinity : float.NegativeInfinity) : float.NaN;
        return (float)((sign == 0 ? 1 : -1) * (1 + mant / 1024.0) * Math.Pow(2, exp - 15));
    }

    public static void BindIfPresent()
    {
        var asset = AssetDatabase.LoadAssetAtPath<EID4662ComputePass2CapturedResources>(AssetPath); if (asset == null) return;
        Undo.RecordObject(asset, "Bind EID4662 Compute Pass 2 RenderDoc resources");
        asset.resource209495 = LoadTexture("rid209495.dds"); asset.resource210490 = LoadTexture("rid210490.dds"); asset.resource209118 = LoadTexture("rid209118.dds"); asset.resource210525 = LoadTexture("rid210525.dds"); asset.resource209510 = LoadTexture("rid209510.dds"); asset.resource210516 = LoadTexture("rid210516.dds"); asset.resource209543Depth = LoadTexture("rid209543_depth_r32f.dds"); asset.resource209547Stencil = LoadTexture("rid209547_stencil_r8.dds"); asset.resource210942 = LoadTexture("rid210942.dds"); asset.resource210925 = LoadTexture("rid210925.dds"); asset.resource209617 = LoadTexture("rid209617.dds"); asset.resource209581 = LoadTexture("rid209581.dds"); asset.resource210519 = LoadTexture("rid210519.dds"); asset.resource210450 = LoadTexture("rid210450.dds"); asset.resource210467 = LoadTexture("rid210467.dds"); asset.resource209659Res18 = LoadTexture("rid209659.dds"); asset.resource209587Res33 = LoadTexture("rid209587.dds");
        asset.dispatchArgs4542 = LoadText("dispatchArgs4542.bytes"); asset.dispatchArgs4546 = LoadText("dispatchArgs4546.bytes"); asset.dispatchArgs4550 = LoadText("dispatchArgs4550.bytes"); asset.ssbo21 = LoadText("ssbo21.bytes"); asset.sourceCapture = "F:/endfield06.rdc"; asset.sourceFrameEvent = 4542;
        EditorUtility.SetDirty(asset); AssetDatabase.SaveAssets(); Debug.Log(asset.IsCompleteForDispatchChain(out string missing) ? "[EID4662 ComputePass2] Bound all exported RenderDoc resources." : "[EID4662 ComputePass2] Missing exported fields: " + missing);
    }

    static Texture LoadTexture(string fileName)
    {
        string nativeName = Path.GetFileNameWithoutExtension(fileName) + ".asset"; if (fileName == "rid209543_depth_r32f.dds") nativeName = "rid209543_depth_r32f.asset"; if (fileName == "rid209547_stencil_r8.dds") nativeName = "rid209547_stencil_r8.asset";
        var native = AssetDatabase.LoadAssetAtPath<Texture>(NativeRoot + nativeName); if (native != null) return native;
        return AssetDatabase.LoadAssetAtPath<Texture>(TextureRoot + fileName);
    }
    static TextAsset LoadText(string fileName) => AssetDatabase.LoadAssetAtPath<TextAsset>(BufferRoot + fileName);
}
