using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace UnityEngine.Rendering.Universal
{
    /// <summary>
    /// Implemented by scene-side integrations that replace the lighting
    /// attachment in URP's DeferredPass instead of stock lighting. This keeps the extension
    /// in the embedded URP source path rather than a RendererFeature.
    /// </summary>
    // sourceFiveMrt is the actual per-camera layout selected by DeferredLights.
    // Providers must not infer it from legacy scene configuration.
    public interface IEID3336URPDeferredLightingProvider
    {
        bool RecordEID3336DeferredLighting(
            ScriptableRenderContext context,
            ref RenderingData renderingData,
            RTHandle[] gbufferAttachments,
            RTHandle lightingAttachment,
            RTHandle depthAttachment,
            RTHandle depthCopyTexture,
            bool sourceFiveMrt);
    }
}
