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
            if (m_DeferredLights.UseEID3336FiveMRT)
                ConfigureTarget(lightingAttachment);
            else
                ConfigureTarget(lightingAttachment, depthAttachment);
        }

        // ScriptableRenderPass
        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            m_DeferredLights.ExecuteDeferredPass(context, ref renderingData);
        }

        private class PassData
        {
            internal TextureHandle color;
            internal TextureHandle depth;
            internal TextureHandle[] gbuffer;

            internal RenderingData renderingData;
            internal DeferredLights deferredLights;
        }

        internal void Render(RenderGraph renderGraph, TextureHandle color, TextureHandle depth, TextureHandle[] gbuffer, ref RenderingData renderingData)
        {
            using (var builder = renderGraph.AddRenderPass<PassData>("Deferred Lighting Pass", out var passData,
                base.profilingSampler))
            {
                passData.color = builder.UseColorBuffer(color, 0);
                passData.depth = m_DeferredLights.UseEID3336FiveMRT
                    ? builder.ReadTexture(depth)
                    : builder.UseDepthBuffer(depth, DepthAccess.ReadWrite);
                passData.deferredLights = m_DeferredLights;
                passData.gbuffer = gbuffer;
                passData.renderingData = renderingData;

                for (int i = 0; i < gbuffer.Length; ++i)
                {
                    if (i != m_DeferredLights.GBufferLightingIndex)
                        builder.ReadTexture(gbuffer[i]);
                }

                builder.AllowPassCulling(false);

                builder.SetRenderFunc((PassData data, RenderGraphContext context) =>
                {
                    if (data.deferredLights.UseEID3336FiveMRT)
                    {
                        // Resolve graph-owned inputs at execution time; never use compatibility RTHandles here.
                        var inputs = new RTHandle[5];
                        for (int i = 0; i < inputs.Length; ++i)
                            inputs[i] = data.gbuffer[i];
                        data.deferredLights.ExecuteEID3336LightPass(context.renderContext,
                            ref data.renderingData, inputs, data.depth);
                    }
                    else
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
