using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

[ExecuteAlways]
public sealed class EID3332CombinedDeferredBootstrap : MonoBehaviour
{
    public UniversalRenderPipelineAsset pipeline;
    static RenderPipelineAsset previousGraphics;
    static RenderPipelineAsset previousQuality;
    static EID3332CombinedDeferredBootstrap active;

    void OnEnable()
    {
        if (active != null && active != this) active.Restore();
        active = this;
        Apply();
    }

    void OnValidate() { if (isActiveAndEnabled) Apply(); }
    void OnDisable() { if (active == this) Restore(); }
    void OnDestroy() { if (active == this) Restore(); }

    public void Apply()
    {
        if (pipeline == null) return;
        if (GraphicsSettings.defaultRenderPipeline != pipeline)
        {
            if (previousGraphics == null) previousGraphics = GraphicsSettings.defaultRenderPipeline;
            GraphicsSettings.defaultRenderPipeline = pipeline;
        }
        if (QualitySettings.renderPipeline != pipeline)
        {
            if (previousQuality == null) previousQuality = QualitySettings.renderPipeline;
            QualitySettings.renderPipeline = pipeline;
        }
    }

    void Restore()
    {
        if (GraphicsSettings.defaultRenderPipeline == pipeline && previousGraphics != null)
            GraphicsSettings.defaultRenderPipeline = previousGraphics;
        if (QualitySettings.renderPipeline == pipeline)
            QualitySettings.renderPipeline = previousQuality;
        previousGraphics = null;
        previousQuality = null;
        active = null;
    }
}
