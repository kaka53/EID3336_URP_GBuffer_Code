using UnityEngine.Experimental.GlobalIllumination;
using UnityEngine.Profiling;
using Unity.Collections;
using UnityEngine.Experimental.Rendering.RenderGraphModule;

// cleanup code
// listMinDepth and maxDepth should be stored in a different uniform block?
// Point lights stored as vec4
// RelLightIndices should be stored in ushort instead of uint.
// TODO use Unity.Mathematics
// TODO Check if there is a bitarray structure (with dynamic size) available in Unity

namespace UnityEngine.Rendering.Universal.Internal
{
    // Render all tiled-based deferred lights.
    internal class DeferredPass : ScriptableRenderPass
    {
        DeferredLights m_DeferredLights;

        public DeferredPass(RenderPassEvent evt, DeferredLights deferredLights)
        {
            base.profilingSampler = new ProfilingSampler(nameof(DeferredPass));
            base.renderPassEvent = evt;
            m_DeferredLights = deferredLights;
        }

        // ScriptableRenderPass
        public override void Configure(CommandBuffer cmd, RenderTextureDescriptor cameraTextureDescripor)
        {
            var lightingAttachment = m_DeferredLights.GbufferAttachments[m_DeferredLights.GBufferLightingIndex];
            var depthAttachment = m_DeferredLights.DepthAttachmentHandle;
            if (m_DeferredLights.UseRenderPass)
                ConfigureInputAttachments(m_DeferredLights.DeferredInputAttachments, m_DeferredLights.DeferredInputIsTransient);

            // TODO: Cannot currently bind depth texture as read-only!
            ConfigureTarget(lightingAttachment, depthAttachment);
        }

        // ScriptableRenderPass
        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            // EID route-B source-level integration point. Run before stock
            // deferred lighting so the recovered result is not overwritten by
            // StencilDeferred. The provider writes the same lighting attachment
            // that stock URP would shade, then we skip stock light accumulation.
            if (RecordEID3336DeferredLighting(context, ref renderingData))
                return;

            // Raw RT0..RT4 do not implement UnityGBuffer's four-target
            // decoder. If the EID provider intentionally disables B6 for a
            // GBuffer capture, leave the lighting target untouched instead of
            // feeding the raw attachments into StencilDeferred.
            if (m_DeferredLights.UseEID3336FiveMRT)
                return;

            m_DeferredLights.ExecuteDeferredPass(context, ref renderingData);

            // EID route-B source-level integration point. Meshes have already
            // populated the standard URP GBuffer through DrawRenderers(). The
            // provider is called after stock deferred lighting so it can use
            // the same GBuffer/depth attachments and replace the lighting
            // result without a second RendererFeature pass.
            // Provider was already given first refusal above; this call is
            // retained only for non-route-B providers that do not replace the
            // stock pass. Route-B returns true and exits before reaching here.
            RecordEID3336DeferredLighting(context, ref renderingData);
        }

        bool RecordEID3336DeferredLighting(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            bool replaced = false;
            var providers = Object.FindObjectsOfType<MonoBehaviour>(true);
            if (providers == null || providers.Length == 0)
                return false;

            for (int i = 0; i < providers.Length; ++i)
            {
                if (!(providers[i] is IEID3336URPDeferredLightingProvider provider))
                    continue;
                try
                {
                    RTHandle[] gbufferAttachments = m_DeferredLights.GbufferAttachments;
                    RTHandle lightingAttachment = gbufferAttachments != null &&
                        gbufferAttachments.Length > m_DeferredLights.GBufferLightingIndex
                        ? gbufferAttachments[m_DeferredLights.GBufferLightingIndex] : null;
                    replaced |= provider.RecordEID3336DeferredLighting(
                        context,
                        ref renderingData,
                        gbufferAttachments,
                        lightingAttachment,
                        m_DeferredLights.DepthAttachment,
                        m_DeferredLights.DepthCopyTexture,
                        m_DeferredLights.UseEID3336FiveMRT);
                }
                catch (System.Exception ex)
                {
                    Debug.LogException(ex, providers[i]);
                }
            }
            return replaced;
        }

        private class PassData
        {
            internal TextureHandle color;
            internal TextureHandle depth;

            internal RenderingData renderingData;
            internal DeferredLights deferredLights;
        }

        internal void Render(RenderGraph renderGraph, TextureHandle color, TextureHandle depth, TextureHandle[] gbuffer, ref RenderingData renderingData)
        {
            using (var builder = renderGraph.AddRenderPass<PassData>("Deferred Lighting Pass", out var passData,
                base.profilingSampler))
            {
                passData.color = builder.UseColorBuffer(color, 0);
                passData.depth = builder.UseDepthBuffer(depth, DepthAccess.ReadWrite);
                passData.deferredLights = m_DeferredLights;
                passData.renderingData = renderingData;

                for (int i = 0; i < gbuffer.Length; ++i)
                {
                    if (i != m_DeferredLights.GBufferLightingIndex)
                        builder.ReadTexture(gbuffer[i]);
                }

                builder.AllowPassCulling(false);

                builder.SetRenderFunc((PassData data, RenderGraphContext context) =>
                {
                    data.deferredLights.ExecuteDeferredPass(context.renderContext, ref data.renderingData);
                });
            }
        }
        // ScriptableRenderPass
        public override void OnCameraCleanup(CommandBuffer cmd)
        {
            m_DeferredLights.OnCameraCleanup(cmd);
        }
    }
}




