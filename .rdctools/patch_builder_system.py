from pathlib import Path
p=Path('Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/Editor/EID4922SkyAssetBuilder.cs')
s=p.read_text(); s=s.replace('#if UNITY_EDITOR\nusing System.IO;', '#if UNITY_EDITOR\nusing System;\nusing System.IO;')
s=s.replace('tex.LoadRawTextureData(rgba);', 'byte[] raw = new byte[rgba.Length * 4]; Buffer.BlockCopy(rgba, 0, raw, 0, raw.Length); tex.LoadRawTextureData(raw);')
p.write_text(s)
