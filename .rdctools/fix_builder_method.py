from pathlib import Path
p=Path('Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/Editor/EID4922SkyAssetBuilder.cs')
s=p.read_text()
method=s[s.index('    [MenuItem("EID4922/Attach Sky Marker'):s.index('\n#endif')]
s=s[:s.index('    [MenuItem("EID4922/Attach Sky Marker')]+s[s.index('\n#endif'):]
insert_pos=s.rfind('\n}')
s=s[:insert_pos]+ '\n'+method + s[insert_pos:]
s=s.replace('feature.settings.injectionPoint = RenderPassEvent.BeforeRenderingSkybox;', 'feature.settings.injectionPoint = RenderPassEvent.AfterRenderingOpaques;')
p.write_text(s)
