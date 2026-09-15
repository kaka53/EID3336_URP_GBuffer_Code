from pathlib import Path
p=Path('Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/Editor/EID4922SkyAssetBuilder.cs')
s=p.read_text().replace('throw new System.Exception("EID4922 direct-port shader compile failed:\n" + errors);','throw new System.Exception("EID4922 direct-port shader compile failed:\\n" + errors);')
# Handle prior literal line break form explicitly.
s=s.replace('throw new System.Exception("EID4922 direct-port shader compile failed:\n" + errors);','throw new System.Exception("EID4922 direct-port shader compile failed:\\n" + errors);')
p.write_text(s)
