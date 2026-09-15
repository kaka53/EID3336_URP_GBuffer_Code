def work(controller):
    controller.SetFrameEvent(3320, True)
    state = controller.GetPipelineState()

    vis = []
    try:
        for a in state.GetVertexInputs():
            vis.append({
                'name': a.name,
                'index': a.index,
                'vertexBuffer': a.vertexBuffer,
                'byteOffset': a.byteOffset,
                'perInstance': a.perInstance,
                'instanceRate': a.instanceRate,
                'byteSize': a.byteSize,
                'format': serialize.format_description(a.format),
            })
    except Exception as e:
        vis = {'error': str(e)}

    refl = state.GetShaderReflection(rd.ShaderStage.Vertex)

    buf_info = {}
    for rid in [211534, 155]:
        for b in controller.GetBuffers():
            if int(b.resourceId) == rid:
                buf_info[str(rid)] = serialize.buffer_description(b)
                break

    return {
        'vertex_inputs': vis,
        'vs_reflection': serialize.shader_reflection(refl),
        'buffers': buf_info,
    }

ctx.replay(work)
