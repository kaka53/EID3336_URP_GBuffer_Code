Shader "EID/URP/VS215839_PS215840_GBuffer"
{
    Properties
    {
        [NoScaleOffset] _Res23 ("基础颜色贴图（RenderDoc PS资源23）", 2D) = "white" {}
        [NoScaleOffset] _Res25 ("法线与材质遮罩（RenderDoc PS资源25）", 2D) = "white" {}
        [NoScaleOffset] _EID215839VSRes29 ("顶点地形遮罩（VS资源29）", 2D) = "black" {}
        _EID3863NormalStrength ("法线强度（未参与 PS）", Float) = 0
        _EID3863DoubleSidedNormal ("背面法线翻转", Float) = 0
        _EID3863MaterialClass ("材质分类编码", Range(0,1)) = 0.075
        _EID3863PackedNormalWeight ("打包法线权重", Range(0,1)) = 1
        _EID3863NormalMaskWeight ("法线遮罩权重", Range(0,1)) = 0.01
        _EID3863RoughnessMaskWeight ("粗糙度遮罩权重", Range(0,1)) = 0.833
        _EID3863BaseColorReplaceWeight ("基础色替换权重", Range(0,1)) = 0
        _EID3863BaseColorMultiplier ("基础色强度", Float) = 1
        [HDR] _EID3863BaseColorTint ("基础色乘色", Color) = (1,1,1,1)
        _EID3863OpacityDistanceParams ("透明距离参数 (起点,倍率,目标,半径)", Vector) = (0,5,0.5,8.999)
        _EID3863MaterialDistanceParams ("材质距离参数 (起点,倍率,目标,半径)", Vector) = (0,10,1,8.999)
        _EID215839Billboard ("uniforms31 child6 广告牌", Float) = 0
        _StencilRef ("Stencil Ref", Float) = 1
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" "DisableBatching"="True" }
        Pass
        {
            Name "VS215839_PS215840_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Off
            ZWrite On
            ZTest Equal
            Blend Off
            Stencil { Ref [_StencilRef] Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID215839Vertex
            #pragma fragment EID215840Fragment
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "EID215839VegetationVS.hlsl"
            #include "EID215839VegetationPS.hlsl"
            EID3863VertexVaryings EID215839Vertex(EID3863VertexInput i)
            {
                return EID3863VertexMain(i);
            }
            EID3863GBufferOutput EID215840Fragment(EID3863FragmentVaryings i, bool frontFace : SV_IsFrontFace)
            {
                return EID3863FragmentMain(i, frontFace);
            }
            ENDHLSL
        }
    }
}
