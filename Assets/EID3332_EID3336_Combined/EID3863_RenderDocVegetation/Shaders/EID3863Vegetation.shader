Shader "EID3863/URP/RenderDocVegetation"
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
  [HDR] _EID3863BaseColorTint ("基础色乘色", Color) = (0.561464,0.6058412,0.7183276,1)
  _EID3863OpacityDistanceParams ("透明距离参数 (起点,倍率,目标,半径)", Vector) = (0.023,4,0.7,28.40311)
  _EID3863MaterialDistanceParams ("材质距离参数 (起点,倍率,目标,半径)", Vector) = (0,1.818182,0.923,98.9001)
  _EID3863InstanceMaterial2 ("实例颜色覆盖 (RGB,权重)", Vector) = (0,0,0,0)
 }
 SubShader
 {
  Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="TransparentCutout" "Queue"="AlphaTest" }
  Pass
  {
   Name "EID3863_GBuffer_Compile5"
   Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
   Cull Off ZWrite On ZTest LEqual Blend Off
   Stencil { Ref 33 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
   HLSLPROGRAM
   #pragma target 5.0
   #pragma vertex EID3863Vertex
   #pragma fragment EID3863Fragment
   #pragma multi_compile_instancing
   #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
   #include "EID3863VegetationVS.hlsl"
   #include "EID3863VegetationPS.hlsl"
   EID3863VertexVaryings EID3863Vertex(EID3863VertexInput i)
   {
       UNITY_SETUP_INSTANCE_ID(i);
       EID3863VertexVaryings o = EID3863VertexMain(i);
       UNITY_TRANSFER_INSTANCE_ID(i, o);
       return o;
   }
   EID3863GBufferOutput EID3863Fragment(EID3863FragmentVaryings i, bool frontFace : SV_IsFrontFace)
   {
       UNITY_SETUP_INSTANCE_ID(i);
       return EID3863FragmentMain(i, frontFace);
   }
   ENDHLSL
  }
 }
}
