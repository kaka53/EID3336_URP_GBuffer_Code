from pathlib import Path
p=Path('Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/Runtime/EID4922SkyProfile.cs')
s=p.read_text(); s=s.replace('public Texture2D res19;','public Texture res19;').replace('public Texture3D res18;','public Texture res18;'); p.write_text(s)
p=Path('Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/Editor/EID4922SkyAssetBuilder.cs')
s=p.read_text()
s=s.replace('using UnityEngine.Rendering.Universal;','using UnityEngine.Rendering.Universal;\nusing UnityEngine.Experimental.Rendering;')
s=s.replace('        Texture3D res18 = AssetDatabase.LoadAssetAtPath<Texture3D>(Root + "/Textures/EID4922_res18.dds");', '''        Texture2D res19Raw = EnsureRawTexture2D(Root + "/CapturedResources/Texture_RID15375.dds", Root + "/Textures/EID4922_res19_raw.asset", 128, 128, GraphicsFormat.R11G11B10_UFloatPack32);
        Texture3D res18 = EnsureRawTexture3D(Root + "/CapturedResources/Texture_RID209575.dds", Root + "/Textures/EID4922_res18_raw.asset", 86, 48, 128, GraphicsFormat.R16G16B16A16_SFloat);
        if (res19Raw != null) mat.SetTexture("_EID4922Res19", res19Raw);''')
s=s.replace('        profile.res19 = LoadTex2D(Root + "/Textures/EID4922_res19.dds");','        profile.res19 = res19Raw;')
needle='    static Texture2D LoadTex2D(string path) => AssetDatabase.LoadAssetAtPath<Texture2D>(path);'
insert='''    static Texture2D LoadTex2D(string path) => AssetDatabase.LoadAssetAtPath<Texture2D>(path);

    static byte[] DdsPayload(string path)
    {
        byte[] all = File.ReadAllBytes(path);
        if (all.Length <= 148 || all[0] != (byte)'D' || all[1] != (byte)'D' || all[2] != (byte)'S' || all[3] != (byte)' ') return null;
        byte[] payload = new byte[all.Length - 148]; System.Buffer.BlockCopy(all, 148, payload, 0, payload.Length); return payload;
    }

    static Texture2D EnsureRawTexture2D(string dds, string assetPath, int width, int height, GraphicsFormat format)
    {
        Texture2D existing = AssetDatabase.LoadAssetAtPath<Texture2D>(assetPath); if (existing != null) return existing;
        Texture2D tex = new Texture2D(width, height, format, TextureCreationFlags.None); tex.name = Path.GetFileNameWithoutExtension(assetPath); tex.LoadRawTextureData(DdsPayload(dds)); tex.Apply(false, true); AssetDatabase.CreateAsset(tex, assetPath); return tex;
    }

    static Texture3D EnsureRawTexture3D(string dds, string assetPath, int width, int height, int depth, GraphicsFormat format)
    {
        Texture3D existing = AssetDatabase.LoadAssetAtPath<Texture3D>(assetPath); if (existing != null) return existing;
        Texture3D tex = new Texture3D(width, height, depth, format, TextureCreationFlags.None); tex.name = Path.GetFileNameWithoutExtension(assetPath); tex.LoadRawTextureData(DdsPayload(dds)); tex.Apply(false, true); AssetDatabase.CreateAsset(tex, assetPath); return tex;
    }'''
s=s.replace(needle,insert)
p.write_text(s)
