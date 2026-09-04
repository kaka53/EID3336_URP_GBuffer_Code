using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace UnityEngine.Rendering.Universal
{
    /// <summary>
    /// Implemented by scene-side integrations that need to append recovered
    /// RenderDoc geometry to the URP deferred GBuffer. The callback is invoked
    /// from URP's real GBufferPass. A provider may request the source-level
    /// five-MRT path, in which case stock UniversalGBuffer draws are skipped
    /// and the provider owns RenderDoc RT0-RT4.
    /// </summary>
    public interface IEID3336URPGBufferProvider
    {
        bool UseEID3336FiveMRT(Camera camera);
        bool RecordEID3336GBuffer(
            ScriptableRenderContext context,
            ref RenderingData renderingData,
            RTHandle[] gbufferAttachments,
            RTHandle depthAttachment);
    }
}
