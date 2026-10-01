Shader "Hidden/EID4883/HairOutline" {
 Properties {
 [NoScaleOffset] EID4883VS_34("Captured EID4883VS_34",2D)=""{}
 [NoScaleOffset] EID4883PS_37("Captured EID4883PS_37",2D)=""{}
 [NoScaleOffset] EID4883PS_36("Captured EID4883PS_36",2D)=""{}
 [NoScaleOffset] EID4883PS_44("Captured EID4883PS_44",3D)=""{}
 [NoScaleOffset] EID4883PS_42("Captured EID4883PS_42",3D)=""{}
 [NoScaleOffset] EID4883PS_40("Captured EID4883PS_40",3D)=""{}
 [NoScaleOffset] EID4883PS_43("Captured EID4883PS_43",3D)=""{}
 [NoScaleOffset] EID4883PS_41("Captured EID4883PS_41",3D)=""{}
 [NoScaleOffset] EID4883PS_39("Captured EID4883PS_39",3D)=""{}
 [NoScaleOffset] EID4883PS_51("Captured EID4883PS_51",3D)=""{}
 [NoScaleOffset] EID4883PS_48("Captured EID4883PS_48",2D)=""{}
 [NoScaleOffset] EID4883PS_25("Captured EID4883PS_25",2D)=""{}
 [NoScaleOffset] EID4883PS_50("Captured EID4883PS_50",2D)=""{}
 [NoScaleOffset] EID4883PS_47("Captured EID4883PS_47",2D)=""{}
 [NoScaleOffset] EID4883PS_49("Captured EID4883PS_49",2D)=""{}
}
 SubShader {
 Tags {"RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="AlphaTest+1"}
 Pass {
 Name "EID4883 CharacterForward" Tags {"LightMode"="EID4883CharacterForward"}
 Cull Front ZTest Equal ZWrite On Blend Off
 HLSLPROGRAM
 #pragma target 5.0
 #pragma use_dxc
 #pragma only_renderers d3d11 vulkan
 #pragma vertex EID4883Vertex
 #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
 #include "VS_EID4883_Live.hlsl"
 #include "EID4883VertexWrapper.hlsl"
 #pragma fragment EID4883Fragment
 #include "PS_EID4883_Live.hlsl"
 EID4883PS_SPIRV_Cross_Output EID4883Fragment(EID4883VS_SPIRV_Cross_Output i){
 EID4883PS_SPIRV_Cross_Input x=(EID4883PS_SPIRV_Cross_Input)0;
 x.EID4883PS_3=i.EID4883VS_12;x.EID4883PS_4=i.EID4883VS_13;x.EID4883PS_5=i.EID4883VS_14;x.EID4883PS_6=i.EID4883VS_16;x.EID4883PS_7=i.EID4883VS_17;x.EID4883PS_9=i.EID4883VS_19;x.EID4883PS_gl_FragCoord=i.EID4883VS_gl_Position;return EID4883PS_main(x);
 }
 ENDHLSL
 }
 Pass {
 Name "EID1766 OutlineGBuffer" Tags {"LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit"}
 Cull Front ZTest LEqual ZWrite On Blend Off
 Stencil {Ref 36 Comp GEqual Pass Replace ReadMask 16 WriteMask 239}
 ColorMask RGBA 0
 ColorMask 0 1
 ColorMask 0 2
 ColorMask 0 3
 ColorMask 0 4
 HLSLPROGRAM
 #pragma target 5.0
 #pragma use_dxc
 #pragma only_renderers d3d11 vulkan
 #pragma vertex EID4883Vertex
 #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
 #include "VS_EID4883_Live.hlsl"
 #include "EID4883VertexWrapper.hlsl"
 #pragma fragment OutlineDepthFragment
 Texture2D<float4> EID4883PS_50;
 float4 OutlineDepthFragment(EID4883VS_SPIRV_Cross_Output i):SV_Target0{
 clip(EID4883PS_50.SampleBias(EID4883_linear_repeat_sampler,i.EID4883VS_12,EID4883VS_23_m16).x-EID4883VS_33_m30);
 return 0;
 }
 ENDHLSL
 }
 }
 Fallback Off
}
