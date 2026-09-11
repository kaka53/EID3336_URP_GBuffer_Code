Shader "EID/URP/VS215841_PS215842_GBuffer"
{
    Properties
    {
        [Header(RenderDoc_Unique_Material_Textures)]
        _Res23 ("res23 基础颜色 Binding4", 2D) = "white" {}
        _Res25 ("res25 法线 Binding3", 2D) = "bump" {}
        _Res31 ("res31 地形遮罩 Binding2", 2D) = "black" {}
        [Header(RenderDoc_PS_uniforms28)]
        _DoubleSided ("child5 双面法线", Float) = 1
        _MaterialClass ("child9 材质分类", Float) = 0.62
        _PackedNormalWeight ("child10 打包法线权重", Float) = 0.115
        _NormalMaskWeight ("child14 法线遮罩权重", Float) = 0.376
        _RoughnessMaskWeight ("child15 粗糙度遮罩权重", Float) = 0.547
        _BaseColorReplaceWeight ("child20 基础色替换权重", Float) = 0
        _BaseColorMultiplier ("child21 基础色强度", Float) = 1
        _AlphaCutoff ("透贴裁剪阈值", Range(0,1)) = 0.5
        [HDR] _BaseColorTint ("child32 基础色乘色", Color) = (1,1,1,1)
        _OpacityDistanceParams ("child33 透明距离 (起点,倍率,目标,半径)", Vector) = (0.023,1.36986,0.632,28.40311)
        _MaterialDistanceParams ("child34 材质距离 (起点,倍率,目标,半径)", Vector) = (0,1.81818,0.923,98.9001)
        [Header(RenderDoc_VS_uniforms33)]
        _WindHeightScale ("child6 高度风摆缩放", Float) = 1
        _HeightFadeStart ("child38 高度淡出起点", Float) = 10
        _HeightFadeScale ("child39 高度淡出倍率", Float) = 0.07
        [Header(RenderDoc_Shared)]
        _WindScale ("1-uniforms20.child4 风摆总开关", Float) = 1
        _MaskExtent ("uniforms24.child131", Vector) = (32,512,1,0)
        _MaskCenter ("uniforms24.child132", Vector) = (-556.875,-412.25,-556.875,-412.25)
        _ViewDir ("uniforms30.child0 视线", Vector) = (0,-0.573576,-0.819152,0)
        _EID215842MipBias ("uniforms17.child16 Mip Bias", Float) = -1
        _CardVertexCount ("源卡片顶点数", Float) = 16
        _CapturedVP0 ("uniforms22.child8 row0", Vector) = (0,0,0,0)
        _CapturedVP1 ("uniforms22.child8 row1", Vector) = (0,0,0,0)
        _CapturedVP2 ("uniforms22.child8 row2", Vector) = (0,0,0,0)
        _CapturedVP3 ("uniforms22.child8 row3", Vector) = (0,0,0,0)
        _CapturedPrevVP0 ("uniforms22.child15 row0", Vector) = (0,0,0,0)
        _CapturedPrevVP1 ("uniforms22.child15 row1", Vector) = (0,0,0,0)
        _CapturedPrevVP2 ("uniforms22.child15 row2", Vector) = (0,0,0,0)
        _CapturedPrevVP3 ("uniforms22.child15 row3", Vector) = (0,0,0,0)
        _CapturedCamPos ("uniforms22.child11", Vector) = (0,0,0,0)
        _CapturedPrevCamPos ("uniforms22.child21", Vector) = (0,0,0,0)
        _CapturedCamUp ("camUp from child1[0].y / child1[2].y", Vector) = (0.175364,0,-0.061641,0)
        _JitterZW ("uniforms24.child9.zw", Vector) = (0,0,0,0)
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="TransparentCutout" "Queue"="AlphaTest" "DisableBatching"="True" }
        Pass
        {
            Name "VS215841_PS215842_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Off
            ZWrite On
            ZTest LEqual
            Blend Off
            Stencil { Ref 33 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID215841Vertex
            #pragma fragment EID215842Fragment
            #include "EID215841215842GBuffer.hlsl"
            ENDHLSL
        }
    }
}
