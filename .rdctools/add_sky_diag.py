from pathlib import Path
p=Path('Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/Runtime/EID4922SkyRendererFeature.cs')
s=p.read_text()
s=s.replace('renderer.EnqueuePass(pass);', 'Debug.Log("[EID4922] enqueue camera=" + camera.name + " profile=" + settings.profile.name);\n        renderer.EnqueuePass(pass);',1)
s=s.replace('CommandBuffer cmd = CommandBufferPool.Get("EID4922 RenderDoc Sky");', 'Debug.Log("[EID4922] execute camera=" + renderingData.cameraData.camera.name + " mesh=" + p.skyMesh.name + " material=" + p.skyMaterial.name + " capturedBuffers=" + p.useCapturedBuffers);\n        CommandBuffer cmd = CommandBufferPool.Get("EID4922 RenderDoc Sky");')
p.write_text(s)
