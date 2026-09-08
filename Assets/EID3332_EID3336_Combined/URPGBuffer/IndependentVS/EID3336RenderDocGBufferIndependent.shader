Shader "EID3336/URP/RenderDocGBufferIndependent"
{
    Properties
    {
        [Header(RenderDoc PS209987 Textures)]
        [NoScaleOffset] _33 ("基础色贴图 RGB颜色 A基础标量", 2D) = "white" {}
        [NoScaleOffset] _35 ("基础法线材质图 XY法线 ZW材质标量", 2D) = "bump" {}
        [NoScaleOffset] _37 ("三层混合遮罩 RGB分别控制三个覆盖层", 2D) = "white" {}
        [NoScaleOffset] _38 ("细节法线材质图 XY法线 ZW细节标量", 2D) = "bump" {}
        [NoScaleOffset] _39 ("投射混合遮罩 R通道", 2D) = "white" {}
        [NoScaleOffset] _40 ("投射权重纹理 R参与两路权重归一化", 2D) = "white" {}
        [NoScaleOffset] _41 ("投射颜色纹理 RGB颜色 A标量", 2D) = "white" {}
        [NoScaleOffset] _42 ("投射法线材质图 XY法线 Z材质标量 A遮蔽标量", 2D) = "white" {}
        [NoScaleOffset] _53 ("虚拟纹理基础法线页 XY法线 ZW材质数据", 2D) = "white" {}
        [NoScaleOffset] _54 ("虚拟纹理基础颜色页 RGB颜色", 2D) = "white" {}
        [NoScaleOffset] _55 ("虚拟纹理覆盖遮罩页 A通道", 2D) = "white" {}
        [NoScaleOffset] _56 ("虚拟纹理变化参数页 RGBA", 2D) = "white" {}
        [NoScaleOffset] _57 ("虚拟纹理材质层索引查找图", 2D) = "white" {}
        [NoScaleOffset] _58 ("虚拟纹理材质层颜色数组", 2DArray) = "" {}
        [NoScaleOffset] _59 ("虚拟纹理材质层法线参数数组", 2DArray) = "" {}
        [NoScaleOffset] _60 ("场景深度纹理 用于近表面混合", 2D) = "white" {}
        [NoScaleOffset] _61 ("虚拟纹理页表", 2D) = "white" {}
        [NoScaleOffset] _62 ("虚拟纹理物理页0", 2D) = "white" {}
        [NoScaleOffset] _63 ("虚拟纹理物理页1", 2D) = "white" {}
        [NoScaleOffset] _64 ("虚拟纹理物理页2", 2D) = "white" {}
        [NoScaleOffset] _65 ("虚拟纹理物理页3", 2D) = "white" {}

        [Header(Vertex Local Parameters)]
        _EID3336VSLocalParameter0 ("VS预留参数0 当前算法未读取", Vector) = (0,0,0,0)
        _EID3336VSLocalParameter1 ("VS预留参数1 当前算法未读取", Vector) = (0,0,0,0)
        _EID3336VSLocalParameter2 ("VS预留参数2 当前算法未读取", Vector) = (0,0,0,0)
        _EID3336VSLocalScale ("顶点局部缩放 XYZ 启用VS覆盖后生效", Vector) = (1,1,1,1)
        _EID3336VSLocalOffset ("顶点局部偏移 XYZ 启用VS覆盖后生效", Vector) = (0,0,0,0)
        _EID3336VSLocalFlags ("VS预留标志 当前算法未读取", Vector) = (0,0,0,0)
        [Toggle] _EID3336UseLocalVSOverrides ("启用顶点局部缩放与偏移", Float) = 0

        [Header(Recovered PS 43 44 Material Constants)]
        _EID3336PSLocalParam00 ("c00 基础法线强度与基础标量范围 X法线强度 Y未用 ZW由法线图Z插值", Vector) = (0,0,0,0)
        _EID3336PSLocalParam01 ("c01 遮蔽与背面法线 X基础遮蔽混合 YZ未用 W背面切线翻转", Vector) = (0,0,0,0)
        _EID3336PSLocalParam02 ("c02 基础色UV通道选择 XYZ未用 W在UV0和UV1间插值", Vector) = (0,0,0,0)
        _EID3336PSLocalParam03 ("c03 基础法线采样与标量来源 X选择UV YMip偏移 Z未用 W基础标量来源模式", Vector) = (0,0,0,0)
        _EID3336PSLocalParam04 ("c04 基础色与输出权重 X强制使用常量色 Y标量备用值 Z基础色倍率 W输出权重系数", Vector) = (0,0,0,0)
        _EID3336PSLocalParam05 ("c05 输出权重计算 X偏置 Y第二标量系数 ZW未用", Vector) = (0,0,0,0)
        _EID3336PSLocalParam06 ("c06 当前FS209987算法未使用 保留捕获原值", Vector) = (0,0,0,0)
        _EID3336PSLocalParam07 ("c07 GBuffer标志与权重禁用 X写入RT1标志 Y禁用权重 ZW未用", Vector) = (0,0,0,0)
        _EID3336PSLocalParam08 ("c08 基础颜色乘色 RGB直接乘基础色贴图 A未用", Vector) = (0,0,0,0)
        _EID3336PSLocalParam09 ("c09 当前FS209987算法未使用 保留捕获原值", Vector) = (0,0,0,0)
        _EID3336PSLocalParam10 ("c10 当前FS209987算法未使用 保留捕获原值", Vector) = (0,0,0,0)
        _EID3336PSLocalParam11 ("c11 基础色UV变换 XY缩放 ZW偏移", Vector) = (0,0,0,0)
        _EID3336PSLocalParam12 ("c12 基础法线UV变换 XY缩放 ZW偏移", Vector) = (0,0,0,0)
        _EID3336PSLocalParam13 ("c13 当前FS209987算法未使用 保留捕获原值", Vector) = (0,0,0,0)
        _EID3336PSLocalParam14 ("c14 当前FS209987算法未使用 保留捕获原值", Vector) = (0,0,0,0)
        _EID3336PSLocalParam15 ("c15 当前FS209987算法未使用 保留捕获原值", Vector) = (0,0,0,0)
        _EID3336PSLocalParam16 ("c16 当前FS209987算法未使用 保留捕获原值", Vector) = (0,0,0,0)
        _EID3336PSLocalParam17 ("c17 当前FS209987算法未使用 保留捕获原值", Vector) = (0,0,0,0)
        _EID3336PSLocalParam18 ("c18 当前FS209987算法未使用 保留捕获原值", Vector) = (0,0,0,0)
        _EID3336PSLocalParam19 ("c19 当前FS209987算法未使用 保留捕获原值", Vector) = (0,0,0,0)
        _EID3336PSLocalParam20 ("c20 当前FS209987算法未使用 保留捕获原值", Vector) = (0,0,0,0)
        _EID3336PSLocalParam21 ("c21 当前FS209987算法未使用 保留捕获原值", Vector) = (0,0,0,0)
        _EID3336PSLocalParam22 ("c22 细节层控制 X颜色材质选择 Y细节来源模式 Z细节法线强度 W细节混合强度", Vector) = (0,0,0,0)
        _EID3336PSLocalParam23 ("c23 细节距离与UV X淡入起点 Y淡入终点 Z选择UV W颜色调制倍率", Vector) = (0,0,0,0)
        _EID3336PSLocalParam24 ("c24 细节颜色调制 RGB乘色 A强制常量色权重", Vector) = (0,0,0,0)
        _EID3336PSLocalParam25 ("c25 细节贴图UV变换 XY缩放 ZW偏移", Vector) = (0,0,0,0)
        _EID3336PSLocalParam26 ("c26 投射采样坐标与法线 X投射轴索引 Y权重偏置 Z坐标缩放 W投射法线强度", Vector) = (0,0,0,0)
        _EID3336PSLocalParam27 ("c27 投射材质合成 X标量备用值 Y使用纹理A Z遮蔽混合 W法线合成模式", Vector) = (0,0,0,0)
        _EID3336PSLocalParam28 ("c28 投射混合控制 X禁用输出权重 Y启用纹理权重归一化 Z强制遮蔽为1 W颜色饱和度控制", Vector) = (0,0,0,0)
        _EID3336PSLocalParam29 ("c29 投射颜色强度 X颜色总倍率 YZW未用", Vector) = (0,0,0,0)
        _EID3336PSLocalParam30 ("c30 投射颜色乘色 RGB颜色倍率 A未用", Vector) = (0,0,0,0)
        _EID3336PSLocalParam31 ("c31 投射UV偏移 XY偏移 ZW未用", Vector) = (0,0,0,0)
        _EID3336PSLocalParam32 ("c32 投射遮罩来源 X选择UV Y选择遮罩通道 ZW未用", Vector) = (0,0,0,0)
        _EID3336PSLocalParam33 ("c33 三层遮罩UV与第1层标量 X选择UV Y第1层输出标量 ZW未用", Vector) = (0,0,0,0)
        _EID3336PSLocalParam34 ("c34 第2和第3层输出标量 X第2层 W第3层 YZ未用", Vector) = (0,0,0,0)
        _EID3336PSLocalParam35 ("c35 三层基础标量覆盖 XYZ分别对应第1到第3层 W未用", Vector) = (0,0,0,0)
        _EID3336PSLocalParam36 ("c36 第1和第2层遮罩整形 XY第1层宽度偏移 ZW第2层宽度偏移", Vector) = (0,0,0,0)
        _EID3336PSLocalParam37 ("c37 第3层遮罩整形 XY第3层宽度偏移 ZW未用", Vector) = (0,0,0,0)
        _EID3336PSLocalParam38 ("c38 第1覆盖层 RGB颜色 A遮罩强度", Vector) = (0,0,0,0)
        _EID3336PSLocalParam39 ("c39 第2覆盖层 RGB颜色 A遮罩强度", Vector) = (0,0,0,0)
        _EID3336PSLocalParam40 ("c40 第3覆盖层 RGB颜色 A遮罩强度", Vector) = (0,0,0,0)
        _EID3336PSLocalParam41 ("c41 三层遮罩UV变换 XY缩放 ZW偏移", Vector) = (0,0,0,0)
        _EID3336PSLocalParam42 ("c42 深度交界混合1 X距离缩放 Y法线回退偏置 Z指数 W未用", Vector) = (0,0,0,0)
        _EID3336PSLocalParam43 ("c43 深度交界颜色与标量 X基础色衰减 Y标量衰减 Z距离缩放 W指数", Vector) = (0,0,0,0)
        _EID3336PSLocalParam44 ("c44 深度交界覆盖控制 X控制覆盖保留和衰减 YZW未用", Vector) = (0,0,0,0)
        [Toggle] _EID3336PSUseLocalParams ("使用材质常量 开启用c00到c44 关闭用捕获值", Float) = 1

        [Header(Fragment Local Parameters)]
        _EID3336PSLocalUV0ScaleOffset ("最终输入UV0变换 XY缩放 ZW偏移", Vector) = (1,1,0,0)
        _EID3336PSLocalUV1ScaleOffset ("最终输入UV1变换 XY缩放 ZW偏移", Vector) = (1,1,0,0)
        _EID3336PSLocalFlags ("PS预留标志 当前算法未读取", Vector) = (0,0,0,0)
        [Toggle] _EID3336PSLocalUseUVTransform ("启用最终输入UV0和UV1变换", Float) = 0
        [Toggle] _EID3336PSLocalFlipUVY ("翻转最终输入UV0和UV1的Y轴", Float) = 0
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            Name "EID3336_RenderDoc_URP_UniversalGBuffer_Independent"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Off
            ZTest LEqual
            ZWrite On
            Blend Off
            Stencil
            {
                Ref 32
                Comp Always
                Pass Replace
                ReadMask 96
                WriteMask 96
            }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID3336IndependentVertex
            #pragma fragment EID3336IndependentGBufferFragment
            #include "EID3336RenderDocGBufferIndependent.hlsl"
            ENDHLSL
        }
    }

    CustomEditor "EID3336RenderDocGBufferShaderGUI"
}
