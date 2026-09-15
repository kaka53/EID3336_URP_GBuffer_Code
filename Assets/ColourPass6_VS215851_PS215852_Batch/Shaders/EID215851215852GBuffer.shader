Shader "EID/URP/VS215851_PS215852_GBuffer"
{
    Properties
    {
        [NoScaleOffset] _Res23 ("基础颜色贴图（RenderDoc PS资源23）", 2D) = "white" {}
        [NoScaleOffset] _Res25 ("法线与材质遮罩（RenderDoc PS资源25）", 2D) = "white" {}
        [NoScaleOffset] _EID3863VSRes34 ("顶点地形遮罩（VS资源34）", 2D) = "black" {}
        [NoScaleOffset] _EID3863VSRes35 ("顶点风场纹理A（VS资源35）", 2D) = "black" {}
        [NoScaleOffset] _EID3863VSRes36 ("顶点风场纹理B（VS资源36）", 2D) = "black" {}
        [NoScaleOffset] _EID3863VSRes37 ("顶点风噪声（VS资源37）", 2D) = "black" {}
        _EID3863NormalStrength ("法线强度", Float) = 3.02
        _EID3863DoubleSidedNormal ("背面法线翻转", Float) = 1
        _EID3863NormalFlatten ("法线贴图趋平权重", Range(0,1)) = 0.515
        _EID3863MaterialClass ("材质分类编码", Range(0,1)) = 0.62
        _EID3863PackedNormalWeight ("打包法线权重", Range(0,1)) = 0.115
        _EID3863RoughnessMin ("粗糙度最小值", Range(0,1)) = 0
        _EID3863RoughnessMax ("粗糙度最大值", Range(0,1)) = 1
        _EID3863NormalMaskWeight ("法线遮罩权重", Range(0,1)) = 0.376
        _EID3863RoughnessMaskWeight ("粗糙度遮罩权重", Range(0,1)) = 0.547
        _EID3863BaseColorReplaceWeight ("基础色替换权重", Range(0,1)) = 0
        _EID3863BaseColorMultiplier ("基础色强度", Float) = 1
        _EID3863AlphaCutoff ("透贴裁剪阈值", Range(0,1)) = 0.5
        [HDR] _EID3863BaseColorTint ("基础色乘色", Color) = (0.660518,0.822159,0.932695,1)
        _EID3863OpacityDistanceParams ("透明距离参数 (起点,倍率,目标,半径)", Vector) = (0,16.66667,1,0.470567)
        _EID3863MaterialDistanceParams ("材质距离参数 (起点,倍率,目标,半径)", Vector) = (0.027,9.09091,0.803,4.555247)
        _EID215851Wind0 ("uniforms39 m6/m16/m17/m19", Vector) = (0,0.5,10,0.04)
        _EID215851Wind1 ("uniforms39 m24/m25/m27/m28", Vector) = (1,0,0.5,10)
        _EID215851Wind2 ("uniforms39 m29/m30/m31", Vector) = (2,0.1,0.5,0)
        _StencilRef ("Stencil Ref", Float) = 33
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="TransparentCutout" "Queue"="AlphaTest" "DisableBatching"="True" }
        Pass
        {
            Name "VS215851_PS215852_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Off
            ZWrite On
            ZTest Equal
            Blend Off
            Stencil { Ref [_StencilRef] Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID215851Vertex
            #pragma fragment EID215852Fragment
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "EID215851VegetationVS.hlsl"
            #include "EID215851VegetationPS.hlsl"
            EID3863VertexVaryings EID215851Vertex(EID3863VertexInput i)
            {
                return EID3863VertexMain(i);
            }
            EID3863GBufferOutput EID215852Fragment(EID3863FragmentVaryings i, bool frontFace : SV_IsFrontFace)
            {
                return EID3863FragmentMain(i, frontFace);
            }
            ENDHLSL
        }
    }
}
