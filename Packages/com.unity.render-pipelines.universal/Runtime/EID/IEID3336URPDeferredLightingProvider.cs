using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace UnityEngine.Rendering.Universal
{
    /// <summary>
    /// Implemented by scene-side integrations that replace the lighting
    /// attachment after URP's stock DeferredPass. This keeps the extension
    /// in the embedded URP source path rather than a RendererFeature.
    /// </summary>
    public interface IEID3336URPDeferredLightingProvider
    {
        bool RecordEID3336DeferredLighting(
            ScriptableRenderContext context,
            ref RenderingData renderingData,
            RTHandle[] gbufferAttachments,
            RTHandle lightingAttachment,
            RTHandle depthAttachment,
            RTHandle depthCopyTexture);
    }
}
