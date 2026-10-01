Shader "Hidden/EID4730/OriginalVSFS"
{
 Properties
 {
  [NoScaleOffset] FS_39 ("FS_39", 2D) = "white" {}
  [NoScaleOffset] FS_40 ("FS_40", 2D) = "white" {}
  [NoScaleOffset] FS_42 ("FS_42", 3D) = "" {}
  [NoScaleOffset] FS_43 ("FS_43", 3D) = "" {}
  [NoScaleOffset] FS_44 ("FS_44", 3D) = "" {}
  [NoScaleOffset] FS_45 ("FS_45", 3D) = "" {}
  [NoScaleOffset] FS_46 ("FS_46", 3D) = "" {}
  [NoScaleOffset] FS_47 ("FS_47", 3D) = "" {}
  [NoScaleOffset] FS_50 ("FS_50", 2D) = "white" {}
  [NoScaleOffset] FS_51 ("FS_51", 2D) = "white" {}
  [NoScaleOffset] FS_52 ("FS_52", 2D) = "white" {}
  [NoScaleOffset] FS_53 ("FS_53", 2D) = "white" {}
  [NoScaleOffset] FS_54 ("FS_54", 2D) = "white" {}
  [NoScaleOffset] FS_55 ("FS_55", 2D) = "white" {}
  [NoScaleOffset] FS_56 ("FS_56", 2D) = "white" {}
  [NoScaleOffset] FS_57 ("FS_57", 2D) = "white" {}
  [NoScaleOffset] FS_58 ("FS_58", 2D) = "white" {}
  [NoScaleOffset] FS_60 ("FS_60", Cube) = "" {}
  [NoScaleOffset] FS_61 ("FS_61", 2D) = "white" {}
  [NoScaleOffset] FS_66 ("FS_66", 3D) = "" {}
 }
 SubShader
 {
  Tags { "RenderPipeline"="UniversalPipeline" "Queue"="Geometry" }
  Pass
  {
   Name "EID4730 Character Forward live MVP"
   Tags { "LightMode"="EID4730OriginalVSFSDisabled" }
   Cull Back ZTest LEqual ZWrite On Blend Off
   ColorMask RGB
   HLSLPROGRAM
   #pragma target 5.0
   #pragma only_renderers d3d11 vulkan
   #pragma exclude_renderers gles gles3 glcore
   #pragma vertex EIDLiveVertex
   #pragma fragment EIDLiveFragment
   #define EID_LIVE_MVP 1
   #include "Replay.hlsl"
   ENDHLSL
  }
 }
 Fallback Off
}
