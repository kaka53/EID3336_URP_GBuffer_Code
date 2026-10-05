using UnityEngine;

// Explicit values form the ABI with EID4662FullFS.hlsl and EID4666VegetationFS.hlsl. Do not reorder.
public enum EID4662LightingStage
{
    [InspectorName("最终画面（关闭调试）")] Final = 0,
    [InspectorName("输入：基础色")] BaseColor = 1,
    [InspectorName("输入：世界法线")] WorldNormal = 2,
    [InspectorName("输入：材质参数 / 粗糙度 / AO")] Material = 3,
    [InspectorName("输入：线性深度")] LinearDepth = 4,
    [InspectorName("主光：未乘阴影")] DirectUnshadowed = 5,
    [InspectorName("主光：阴影可见度 _29")] ShadowVisibility = 6,
    [InspectorName("主光：接触可见度 _33")] ContactVisibility = 7,
    [InspectorName("主光：应用阴影后")] DirectShadowed = 8,
    [InspectorName("AO：间接漫反射遮蔽")] DiffuseOcclusion = 9,
    [InspectorName("AO：间接高光遮蔽")] SpecularOcclusion = 10,
    [InspectorName("GI：屏幕 SH 调制前")] IrradianceBeforeScreenSH = 11,
    [InspectorName("GI：屏幕 SH 调制后")] IrradianceAfterScreenSH = 12,
    [InspectorName("GI：间接漫反射贡献")] IndirectDiffuse = 13,
    [InspectorName("反射：探针颜色")] ProbeReflection = 14,
    [InspectorName("反射：屏幕高光颜色")] ScreenReflection = 15,
    [InspectorName("反射：屏幕高光混合权重")] ScreenReflectionWeight = 16,
    [InspectorName("反射：混合后的颜色")] CombinedReflection = 17,
    [InspectorName("反射：间接高光贡献")] IndirectSpecular = 18,
    [InspectorName("累加：全部间接光")] CombinedIndirect = 19,
    [InspectorName("累加：主光 + 间接漫反射")] DirectAndDiffuse = 20,
    [InspectorName("累加：全部表面光（无雾）")] SurfaceWithoutFog = 21,
    [InspectorName("雾：总透射率")] FogTransmittance = 22,
    [InspectorName("雾：散射颜色贡献")] FogScattering = 23,
    [InspectorName("累加：表面光 + 雾（本 Pass）")] PassOutputWithFog = 24,
    [InspectorName("输入：环境 BRDF 响应")] EnvironmentBRDF = 25,
    [InspectorName("植被：背光透射（未乘阴影）")] VegetationTransmission = 26,
    [InspectorName("植被：包裹光照（未乘阴影）")] VegetationWrap = 27,
    [InspectorName("植被：正面间接漫反射")] VegetationFrontGI = 28,
    [InspectorName("植被：背面间接漫反射")] VegetationBackGI = 29,
}

public enum EID4662StageCameraScope
{
    [InspectorName("Game 和 Scene")] Both = 0,
    [InspectorName("仅 Game")] Game = 1,
    [InspectorName("仅 Scene")] Scene = 2
}

public enum EIDDeferredStageTarget
{
    [InspectorName("全部：4662 + 4666")] Both = 0,
    [InspectorName("仅普通表面：4662")] Surface4662 = 1,
    [InspectorName("仅植被：4666")] Vegetation4666 = 2
}
