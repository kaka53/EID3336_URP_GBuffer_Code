using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace UnityEngine.Rendering.Universal
{
    /// <summary>
    /// Implemented by scene-side integrations that append recovered RenderDoc
    /// geometry to URP deferred GBuffer validation/integration paths.
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

    /// <summary>
    /// Allocation-free provider registry used by GBufferPass. Providers register
    /// only while enabled, avoiding FindObjectsOfType during SceneView repaint.
    /// </summary>
    public static class EID3336URPGBufferProviderRegistry
    {
        static readonly List<IEID3336URPGBufferProvider> s_Providers =
            new List<IEID3336URPGBufferProvider>(4);

        internal static List<IEID3336URPGBufferProvider> Providers => s_Providers;

        public static void Register(IEID3336URPGBufferProvider provider)
        {
            if (provider != null && !s_Providers.Contains(provider))
                s_Providers.Add(provider);
        }

        public static void Unregister(IEID3336URPGBufferProvider provider)
        {
            if (provider != null)
                s_Providers.Remove(provider);
        }
    }
}