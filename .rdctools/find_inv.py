import json
from pathlib import Path

# look up remaining 57-65 from inventory files
for p in [
    r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/remaining_12_65_inventory.json',
    r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/scan_12_65.json',
    r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_12_65_shaders.json',
]:
    path = Path(p)
    print('exists', path, path.exists(), 'size', path.stat().st_size if path.exists() else None)
