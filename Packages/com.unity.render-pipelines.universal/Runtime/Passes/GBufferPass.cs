using UnityEngine.Experimental.GlobalIllumination;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Profiling;
using Unity.Collections;
using UnityEngine.Experimental.Rendering.RenderGraphModule;

namespace UnityEngine.Rendering.Universal.Internal
{
    // Render all tiled-based deferred lights.
    internal class GBufferPass : ScriptableRenderPass
    {
        static readonly int s_CameraNormalsTextureID = Shader.PropertyToID("_CameraNormalsTexture");
        static readonly int s_EID3336PipelineMVPId = Shader.PropertyToID("_EID3336PipelineMVP");
        static ShaderTagId s_ShaderTagLit = new ShaderTagId("Lit");
        static ShaderTagId s_ShaderTagSimpleLit = new ShaderTagId("SimpleLit");
        static ShaderTagId s_ShaderTagUnlit = new ShaderTagId("Unlit");
        static ShaderTagId s_ShaderTagComplexLit = new ShaderTagId("ComplexLit");
        static ShaderTagId s_ShaderTagUniversalGBuffer = new ShaderTagId("UniversalGBuffer");
        static ShaderTagId s_ShaderTagUniversalMaterialType = new ShaderTagId("UniversalMaterialType");

        ProfilingSampler m_ProfilingSampler = new ProfilingSampler("Render GBuffer");

        DeferredLights m_DeferredLights;

        static ShaderTagId[] s_ShaderTagValues;
        static RenderStateBlock[] s_RenderStateBlocks;

        FilteringSettings m_FilteringSettings;
        RenderStateBlock m_RenderStateBlock;
        private PassData m_PassData;

        public GBufferPass(RenderPassEvent evt, RenderQueueRange renderQueueRange, LayerMask layerMask, StencilState stencilState, int stencilReference, DeferredLights deferredLights)
        {
            base.profilingSampler = new ProfilingSampler(nameof(GBufferPass));
            base.renderPassEvent = evt;
            m_PassData = new PassData();

            m_DeferredLights = deferredLights;
            m_FilteringSettings = new FilteringSettings(renderQueueRange, layerMask);
            m_RenderStateBlock = new RenderStateBlock(RenderStateMask.Nothing);

            m_RenderStateBlock.stencilState = stencilState;
            m_RenderStateBlock.stencilReference = stencilReference;
            m_RenderStateBlock.mask = RenderStateMask.Stencil;

            if (s_ShaderTagValues == null)
            {
                s_ShaderTagValues = new ShaderTagId[5];
                s_ShaderTagValues[0] = s_ShaderTagLit;
                s_ShaderTagValues[1] = s_ShaderTagSimpleLit;
                s_ShaderTagValues[2] = s_ShaderTagUnlit;
                s_ShaderTagValues[3] = s_ShaderTagComplexLit;
                s_ShaderTagValues[4] = new ShaderTagId(); // Special catch all case for materials where UniversalMaterialType is not defined or the tag value doesn't match anything we know.
            }

            if (s_RenderStateBlocks == null)
            {
                s_RenderStateBlocks = new RenderStateBlock[5];
                s_RenderStateBlocks[0] = DeferredLights.OverwriteStencil(m_RenderStateBlock, (int)StencilUsage.MaterialMask, (int)StencilUsage.MaterialLit);
                s_RenderStateBlocks[1] = DeferredLights.OverwriteStencil(m_RenderStateBlock, (int)StencilUsage.MaterialMask, (int)StencilUsage.MaterialSimpleLit);
                s_RenderStateBlocks[2] = DeferredLights.OverwriteStencil(m_RenderStateBlock, (int)StencilUsage.MaterialMask, (int)StencilUsage.MaterialUnlit);
                s_RenderStateBlocks[3] = DeferredLights.OverwriteStencil(m_RenderStateBlock, (int)StencilUsage.MaterialMask, (int)StencilUsage.MaterialUnlit);  // Fill GBuffer, but skip lighting pass for ComplexLit
                s_RenderStateBlocks[4] = s_RenderStateBlocks[0];
            }
        }

        public void Dispose()
        {
            m_DeferredLights.ReleaseGbufferResources();
        }

        public override void Configure(CommandBuffer cmd, RenderTextureDescriptor cameraTextureDescriptor)
        {
            RTHandle[] gbufferAttachments = m_DeferredLights.GbufferAttachments;

            if (cmd != null)
            {
                var allocateGbufferDepth = true;
                if (m_DeferredLights.UseRenderPass && (m_DeferredLights.DepthCopyTexture != null && m_DeferredLights.DepthCopyTexture.rt != null))
                {
                    m_DeferredLights.GbufferAttachments[m_DeferredLights.GbufferDepthIndex] = m_DeferredLights.DepthCopyTexture;
                    allocateGbufferDepth = false;
                }
                // Create and declare the render targets used in the pass
                for (int i = 0; i < gbufferAttachments.Length; ++i)
                {
                    // Lighting buffer has already been declared with line ConfigureCameraTarget(m_ActiveCameraColorAttachment.Identifier(), ...) in DeferredRenderer.Setup
                    if (i == m_DeferredLights.GBufferLightingIndex)
                        continue;

                    // Normal buffer may have already been created if there was a depthNormal prepass before.
                    // DepthNormal prepass is needed for forward-only materials when SSAO is generated between gbuffer and deferred lighting pass.
                    if (i == m_DeferredLights.GBufferNormalSmoothnessIndex && m_DeferredLights.HasNormalPrepass)
                        continue;

                    if (i == m_DeferredLights.GbufferDepthIndex && !allocateGbufferDepth)
                        continue;

                    // No need to setup temporaryRTs if we are using input attachments as they will be Memoryless
                    if (m_DeferredLights.UseRenderPass && i != m_DeferredLights.GBufferRenderingLayers && (i != m_DeferredLights.GbufferDepthIndex && !m_DeferredLights.HasDepthPrepass))
                        continue;

                    m_DeferredLights.ReAllocateGBufferIfNeeded(cameraTextureDescriptor, i);

                    cmd.SetGlobalTexture(m_DeferredLights.GbufferAttachments[i].name, m_DeferredLights.GbufferAttachments[i].nameID);
                }
            }

            if (m_DeferredLights.UseRenderPass)
                m_DeferredLights.UpdateDeferredInputAttachments();

            if (m_DeferredLights.UseEID3336FiveMRT)
            {
                // The source contract is RT0..RT4. Attachment 5 is the
                // camera-color/lighting target and must not be bound during
                // geometry. Optional URP attachments are excluded as well.
                RTHandle[] rawAttachments = new RTHandle[5];
                GraphicsFormat[] rawFormats = new GraphicsFormat[5];
                for (int i = 0; i < 5; ++i)
                {
                    rawAttachments[i] = m_DeferredLights.GbufferAttachments[i];
                    rawFormats[i] = m_DeferredLights.GbufferFormats[i];
                }
                ConfigureTarget(rawAttachments, m_DeferredLights.DepthAttachment, rawFormats);
            }
            else
            {
                ConfigureTarget(m_DeferredLights.GbufferAttachments, m_DeferredLights.DepthAttachment, m_DeferredLights.GbufferFormats);
            }

            // The recovered five-MRT path owns persistent RTHandles and is rendered every frame.
            // Do not load color/depth from the previous frame: an uncovered pixel would otherwise
            // keep the previous object's GBuffer/depth and appear as a moving-object ghost.
            // Keep stock URP's original load/clear policy unchanged for the normal four-MRT path.
            if (m_DeferredLights.UseEID3336FiveMRT)
                ConfigureClear(ClearFlag.Color | ClearFlag.Depth, Color.clear);
            else
                ConfigureClear(ClearFlag.None, Color.black);
        }

        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            var cmd = renderingData.commandBuffer;
            m_PassData.filteringSettings = m_FilteringSettings;
            using (new ProfilingScope(cmd, m_ProfilingSampler))
            {
                m_PassData.deferredLights = m_DeferredLights;

                // User can stack several scriptable renderers during rendering but deferred renderer should only lit pixels added by this gbuffer pass.
                // If we detect we are in such case (camera is in overlay mode), we clear the highest bits of stencil we have control of and use them to
                // mark what pixel to shade during deferred pass. Gbuffer will always mark pixels using their material types.


                ref CameraData cameraData = ref renderingData.cameraData;
                ShaderTagId lightModeTag = s_ShaderTagUniversalGBuffer;
                m_PassData.drawingSettings = CreateDrawingSettings(lightModeTag, ref renderingData, renderingData.cameraData.defaultOpaqueSortFlags);

                // Bind the independent EID3336 VS resources directly from URP.
                EID3336RenderDocPipelineShaderResources.Bind(cmd);

                // Feed the active camera view-projection into the recovered VS.
                // The VS applies the per-draw instance/object transform itself,
                // so this is the matrix occupying the captured VS_25_m8 clip slot.
                Camera pipelineCamera = renderingData.cameraData.camera;
                if (pipelineCamera != null)
                {
                    Matrix4x4 pipelineMVP = GL.GetGPUProjectionMatrix(
                        pipelineCamera.projectionMatrix, true) * pipelineCamera.worldToCameraMatrix;
                    cmd.SetGlobalMatrix(s_EID3336PipelineMVPId, pipelineMVP);
                }

                // The material advertises UniversalGBuffer and writes the
                // selected MRT contract. DrawRenderers is still the URP path in
                // five-MRT mode; no provider/RendererFeature is required.
                ExecutePass(context, m_PassData, ref renderingData);

                // If any sub-system needs camera normal texture, make it available.
                // Input attachments will only be used when this is not needed so safe to skip in that case
                if (!m_DeferredLights.UseRenderPass)
                    renderingData.commandBuffer.SetGlobalTexture(s_CameraNormalsTextureID, m_DeferredLights.GbufferAttachments[m_DeferredLights.GBufferNormalSmoothnessIndex]);
            }
        }

        static void RecordEID3336Providers(ScriptableRenderContext context, ref RenderingData renderingData, DeferredLights deferredLights)
        {
            var providers = Object.FindObjectsOfType<MonoBehaviour>(true);
            Debug.Log("[EID3336 GBufferPass] provider scan camera=" + (renderingData.cameraData.camera != null ? renderingData.cameraData.camera.name : "null") + " count=" + (providers != null ? providers.Length.ToString() : "0") + " five=" + (deferredLights != null && deferredLights.UseEID3336FiveMRT));
            if (providers == null || providers.Length == 0)
                return;
            for (int i = 0; i < providers.Length; ++i)
            {
                if (providers[i] is IEID3336URPGBufferProvider provider)
                {
                    Debug.Log("[EID3336 GBufferPass] provider=" + providers[i].GetType().FullName);
                    try
                    {
                        provider.RecordEID3336GBuffer(context, ref renderingData,
                            deferredLights.GbufferAttachments,
                            deferredLights.DepthAttachment);
                    }
                    catch (System.Exception ex)
                    {
                        Debug.LogException(ex, providers[i]);
                    }
                }
            }
        }
        static void ExecutePass(ScriptableRenderContext context, PassData data, ref RenderingData renderingData, bool useRenderGraph = false)
        {
            // RenderGraph also reaches this common draw function, so the global
            // RenderDoc buffers and active camera matrix are bound here rather
            // than only in the legacy Execute entry point.
            EID3336RenderDocPipelineShaderResources.Bind(renderingData.commandBuffer);
            var pipelineCamera = renderingData.cameraData.camera;
            if (pipelineCamera != null)
            {
                Matrix4x4 pipelineMVP = GL.GetGPUProjectionMatrix(
                    pipelineCamera.projectionMatrix, true) * pipelineCamera.worldToCameraMatrix;
                renderingData.commandBuffer.SetGlobalMatrix(s_EID3336PipelineMVPId, pipelineMVP);
            }

            bool usesRenderingLayers = data.deferredLights.UseRenderingLayers && !data.deferredLights.HasRenderingLayerPrepass;
            if (usesRenderingLayers)
                CoreUtils.SetKeyword(renderingData.commandBuffer, ShaderKeywordStrings.WriteRenderingLayers, true);

            context.ExecuteCommandBuffer(renderingData.commandBuffer);
            renderingData.commandBuffer.Clear();

            if (data.deferredLights.IsOverlay)
            {
                data.deferredLights.ClearStencilPartial(renderingData.commandBuffer);
                context.ExecuteCommandBuffer(renderingData.commandBuffer);
                renderingData.commandBuffer.Clear();
            }

            NativeArray<ShaderTagId> tagValues = new NativeArray<ShaderTagId>(s_ShaderTagValues, Allocator.Temp);
            NativeArray<RenderStateBlock> stateBlocks = new NativeArray<RenderStateBlock>(s_RenderStateBlocks, Allocator.Temp);

            context.DrawRenderers(renderingData.cullResults, ref data.drawingSettings, ref data.filteringSettings, s_ShaderTagUniversalMaterialType, false, tagValues, stateBlocks);

            tagValues.Dispose();
            stateBlocks.Dispose();

            // The independent EID3336 path is now a normal UniversalGBuffer
            // material draw. Providers are used only as a readback bridge for
            // validation; they must run after DrawRenderers so they cannot
            // replace or overdraw the standard URP GBuffer result.
            if (!data.deferredLights.UseEID3336FiveMRT)
                RecordEID3336Providers(context, ref renderingData, data.deferredLights);

            // Render objects that did not match any shader pass with error shader
            RenderingUtils.RenderObjectsWithError(context, ref renderingData.cullResults, renderingData.cameraData.camera, data.filteringSettings, SortingCriteria.None);

            // If any sub-system needs camera normal texture, make it available.
            // Input attachments will only be used when this is not needed so safe to skip in that case
            if (!data.deferredLights.UseRenderPass)
                renderingData.commandBuffer.SetGlobalTexture(s_CameraNormalsTextureID, data.deferredLights.GbufferAttachments[data.deferredLights.GBufferNormalSmoothnessIndex]);

            // Clean up
            if (usesRenderingLayers)
            {
                CoreUtils.SetKeyword(renderingData.commandBuffer, ShaderKeywordStrings.WriteRenderingLayers, false);
                context.ExecuteCommandBuffer(renderingData.commandBuffer);
                renderingData.commandBuffer.Clear();
            }
        }

        private class PassData
        {
            internal TextureHandle[] gbuffer;
            internal TextureHandle depth;

            internal RenderingData renderingData;

            internal DeferredLights deferredLights;
            internal FilteringSettings filteringSettings;
            internal DrawingSettings drawingSettings;
        }

        internal void Render(RenderGraph renderGraph, TextureHandle cameraColor, TextureHandle cameraDepth,
            ref RenderingData renderingData, ref UniversalRenderer.RenderGraphFrameResources frameResources)
        {
            using (var builder = renderGraph.AddRenderPass<PassData>("GBuffer Pass", out var passData, m_ProfilingSampler))
            {
                passData.gbuffer = frameResources.gbuffer = m_DeferredLights.GbufferTextureHandles;
                for (int i = 0; i < m_DeferredLights.GBufferSliceCount; i++)
                {
                    var gbufferSlice = renderingData.cameraData.cameraTargetDescriptor;
                    gbufferSlice.depthBufferBits = 0; // make sure no depth surface is actually created
                    gbufferSlice.stencilFormat = GraphicsFormat.None;

                    if (i != m_DeferredLights.GBufferLightingIndex)
                    {
                        gbufferSlice.graphicsFormat = m_DeferredLights.GetGBufferFormat(i);
                        frameResources.gbuffer[i] = UniversalRenderer.CreateRenderGraphTexture(renderGraph, gbufferSlice, DeferredLights.k_GBufferNames[i], true);
                    }
                    else
                    {
                        frameResources.gbuffer[i] = cameraColor;
                    }
                    // CameraColor is a separate LightPass output, not a sixth geometry MRT.
                    if (!m_DeferredLights.UseEID3336FiveMRT || i < 5)
                        passData.gbuffer[i] = builder.UseColorBuffer(frameResources.gbuffer[i], i);
                }

                passData.deferredLights = m_DeferredLights;
                passData.depth = builder.UseDepthBuffer(cameraDepth, DepthAccess.Write);

                passData.renderingData = renderingData;

                builder.AllowPassCulling(false);

                passData.filteringSettings = m_FilteringSettings;
                ShaderTagId lightModeTag = s_ShaderTagUniversalGBuffer;
                passData.drawingSettings = CreateDrawingSettings(lightModeTag, ref passData.renderingData, renderingData.cameraData.defaultOpaqueSortFlags);

                builder.SetRenderFunc((PassData data, RenderGraphContext context) =>
                {
                    ExecutePass(context.renderContext, data, ref data.renderingData, true);
                });

            }
            using (var builder = renderGraph.AddRenderPass<PassData>("Set GBuffer Globals", out var passData, m_ProfilingSampler))
            {
                passData.gbuffer = frameResources.gbuffer = m_DeferredLights.GbufferTextureHandles;
                for (int i = 0; i < m_DeferredLights.GBufferSliceCount; i++)
                {
                    // CameraColor is a separate LightPass output, not a sixth geometry MRT.
                    if (!m_DeferredLights.UseEID3336FiveMRT || i < 5)
                        passData.gbuffer[i] = builder.UseColorBuffer(frameResources.gbuffer[i], i);
                }
                passData.depth = builder.UseDepthBuffer(cameraDepth, DepthAccess.Read);
                passData.renderingData = renderingData;
                passData.deferredLights = m_DeferredLights;

                builder.AllowPassCulling(false);

                builder.SetRenderFunc((PassData data, RenderGraphContext context) =>
                {
                    for (int i = 0; i < data.gbuffer.Length; i++)
                    {
                        if (i != data.deferredLights.GBufferLightingIndex)
                            data.renderingData.commandBuffer.SetGlobalTexture(DeferredLights.k_GBufferNames[i], data.gbuffer[i]);
                    }
                });
            }
        }
    }
}









