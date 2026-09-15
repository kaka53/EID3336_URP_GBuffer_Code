"""
从 RenderDoc endfield06 捕获中提取 EID3320 顶点数据并生成 FBX
基于项目中已有的 EID3336 导出结构
"""
import struct
import json
import numpy as np
from pathlib import Path

def create_eid3320_manifest():
    """创建 EID3320 的 manifest，基于 EID3336 的结构"""
    manifest = {
        "eid": 3320,
        "draw": "vkCmdDrawIndexed(需要从RenderDoc获取)",
        "stage": "VSInput",
        "coordinate_space": "model",
        "fbx_axis": "Y-up, -Z front, X right",
        "fbx_unit_scale": "meter",
        "status": "需要从 RenderDoc endfield06 捕获中提取原始数据"
    }
    return manifest

def write_placeholder_structure():
    """创建 EID3320 的目录结构和占位文件"""
    base_path = Path("D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/EID3336_URP_Reconstruction/Models")
    eid3320_path = base_path / "EID3320"
    raw_path = eid3320_path / "Raw"

    # 创建目录
    raw_path.mkdir(parents=True, exist_ok=True)

    # 写入 manifest
    manifest = create_eid3320_manifest()
    manifest_file = eid3320_path / "manifest.json"
    with open(manifest_file, 'w', encoding='utf-8') as f:
        json.dump(manifest, f, indent=2, ensure_ascii=False)

    # 创建说明文件
    readme = eid3320_path / "README.txt"
    with open(readme, 'w', encoding='utf-8') as f:
        f.write("""EID3320 数据提取说明
===================

当前状态：等待从 RenderDoc 提取原始数据

需要的操作：
1. 打开 RenderDoc
2. 加载 endfield06.rdc 捕获文件
3. 定位 EID3320 的 Draw Call (Event ID 3320)
4. 导出顶点数据：
   - 方法A：Mesh Viewer > VS Input > Export to CSV
   - 方法B：使用 RenderDoc Python API 导出原始缓冲区

导出后需要的文件：
- vertex_stream0.bytes (位置、UV0等)
- vertex_stream1.bytes (法线、切线等)
- indices_u16.bytes 或 indices_u32.bytes (索引)
- vertex_input_layout.json (顶点布局信息)

将这些文件放到 Raw/ 目录后，运行转换脚本生成 FBX。
""")

    print(f"✓ 创建了 EID3320 目录结构: {eid3320_path}")
    print(f"✓ 创建了 manifest: {manifest_file}")
    print(f"✓ 创建了说明文件: {readme}")

    return eid3320_path

# 检查 RenderDoc Python API 是否可用
try:
    import renderdoc as rd
    RENDERDOC_AVAILABLE = True
    print("✓ RenderDoc Python API 可用")
except ImportError:
    RENDERDOC_AVAILABLE = False
    print("⚠ RenderDoc Python API 不可用")

if __name__ == "__main__":
    print("=" * 70)
    print("EID3320 数据提取准备工具")
    print("=" * 70)
    print()

    # 创建目录结构
    eid3320_path = write_placeholder_structure()

    print()
    print("下一步：")
    if RENDERDOC_AVAILABLE:
        print("1. RenderDoc Python API 已可用")
        print("2. 提供 endfield06.rdc 文件路径")
        print("3. 运行自动提取脚本")
    else:
        print("1. 手动在 RenderDoc 中打开 endfield06.rdc")
        print("2. 找到 EID3320 draw call")
        print("3. 导出顶点数据到 Raw/ 目录")
        print("4. 运行 convert_eid3320_to_fbx.py")

    print()
    print(f"目标目录: {eid3320_path}")
