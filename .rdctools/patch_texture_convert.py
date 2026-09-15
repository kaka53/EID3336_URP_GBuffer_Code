from pathlib import Path
p=Path('Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/Editor/EID4922SkyAssetBuilder.cs')
s=p.read_text()
s=s.replace('GraphicsFormat.R11G11B10_UFloatPack32','GraphicsFormat.R16G16B16A16_SFloat')
start=s.index('    static Texture2D EnsureRawTexture2D')
end=s.index('    static void SetTexture', start)
new=r'''    static float DecodeUF(uint v, int mantissaBits)
    {
        uint mantMask = (uint)((1 << mantissaBits) - 1); uint mant = v & mantMask; uint exp = v >> mantissaBits;
        if (exp == 0) return mant == 0 ? 0f : (mant / (float)(1 << mantissaBits)) * Mathf.Pow(2f, -14f);
        if (exp == 31) return mant == 0 ? float.PositiveInfinity : float.NaN;
        return (1f + mant / (float)(1 << mantissaBits)) * Mathf.Pow(2f, (int)exp - 15);
    }

    static Texture2D EnsureRawTexture2D(string dds, string assetPath, int width, int height, GraphicsFormat format)
    {
        Texture2D existing = AssetDatabase.LoadAssetAtPath<Texture2D>(assetPath); if (existing != null) return existing;
        byte[] src = DdsPayload(dds); float[] rgba = new float[width * height * 4];
        for (int i = 0; i < width * height; i++) { uint p = BitConverter.ToUInt32(src, i * 4); rgba[i * 4 + 0] = DecodeUF(p & 0x7ffu, 6); rgba[i * 4 + 1] = DecodeUF((p >> 11) & 0x7ffu, 6); rgba[i * 4 + 2] = DecodeUF((p >> 22) & 0x3ffu, 5); rgba[i * 4 + 3] = 1f; }
        Texture2D tex = new Texture2D(width, height, TextureFormat.RGBAFloat, false, true); tex.name = Path.GetFileNameWithoutExtension(assetPath); tex.LoadRawTextureData(rgba); tex.Apply(false, true); AssetDatabase.CreateAsset(tex, assetPath); return tex;
    }

    static float HalfToFloat(ushort h)
    {
        uint sign = (uint)(h >> 15) & 1, exp = (uint)(h >> 10) & 31, mant = (uint)(h & 1023);
        uint bits; if (exp == 0) bits = mant == 0 ? sign << 31 : (sign << 31) | (uint)Mathf.Clamp(Mathf.RoundToInt(Mathf.Log(mant / 1024f, 2f) + 127f), 0, 255) << 23;
        else if (exp == 31) bits = (sign << 31) | 0x7f800000u | (mant << 13);
        else bits = (sign << 31) | ((exp + 112) << 23) | (mant << 13);
        return BitConverter.ToSingle(BitConverter.GetBytes(bits), 0);
    }

    static Texture3D EnsureRawTexture3D(string dds, string assetPath, int width, int height, int depth, GraphicsFormat format)
    {
        Texture3D existing = AssetDatabase.LoadAssetAtPath<Texture3D>(assetPath); if (existing != null) return existing;
        byte[] src = DdsPayload(dds); Color[] colors = new Color[width * height * depth];
        for (int i = 0; i < colors.Length; i++) colors[i] = new Color(HalfToFloat(BitConverter.ToUInt16(src, i * 8 + 0)), HalfToFloat(BitConverter.ToUInt16(src, i * 8 + 2)), HalfToFloat(BitConverter.ToUInt16(src, i * 8 + 4)), HalfToFloat(BitConverter.ToUInt16(src, i * 8 + 6)));
        Texture3D tex = new Texture3D(width, height, depth, TextureFormat.RGBAHalf, false); tex.name = Path.GetFileNameWithoutExtension(assetPath); tex.SetPixels(colors); tex.Apply(false, true); AssetDatabase.CreateAsset(tex, assetPath); return tex;
    }
'''
s=s[:start]+new+s[end:]
p.write_text(s)
