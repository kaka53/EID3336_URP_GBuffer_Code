@echo off
chcp 65001 >nul
echo ============================================================
echo EID3320 RenderDoc 导出工具
echo ============================================================
echo.

echo [步骤 1] 请确保你已经在 RenderDoc 中导出了 EID3320 的顶点数据
echo.
echo 导出方法：
echo 1. 在 RenderDoc 中打开 endfield06.rdc
echo 2. 找到 EID3320 的 Draw Call
echo 3. 切换到 Mesh Viewer ^> VS Input
echo 4. 右键导出为 CSV 格式
echo.

set /p csv_path="请输入导出的 CSV 文件路径（或拖拽文件到此窗口）: "

REM 移除引号
set csv_path=%csv_path:"=%

if not exist "%csv_path%" (
    echo.
    echo [错误] 文件不存在: %csv_path%
    echo.
    pause
    exit /b 1
)

echo.
echo [步骤 2] 转换 CSV 到 FBX 格式...
echo.

python convert_renderdoc_to_fbx.py "%csv_path%"

if %errorlevel% neq 0 (
    echo.
    echo [错误] 转换失败，请检查 Python 环境和依赖
    echo.
    echo 需要的 Python 库:
    echo - numpy
    echo - csv (内置)
    echo.
    echo 可选库（用于 FBX 导出）:
    echo - bpy (Blender Python API)
    echo - fbx (FBX SDK Python bindings)
    echo.
    pause
    exit /b 1
)

echo.
echo [步骤 3] 完成！
echo.
echo 模型已导出到: Assets\EID3336_URP_Reconstruction\Models\EID3320_VSInput.fbx
echo.
echo 下一步：
echo 1. 打开 Unity 项目
echo 2. 找到导入的 FBX 文件
echo 3. 在 Inspector 中设置导入参数（参考 EID3320_Export_Guide.md）
echo 4. 确保勾选 "Read/Write Enabled" 以保留所有顶点属性
echo.

pause
