import os, json, struct, hashlib, time

MESH_ITEM = {
    3844: '58.1',
}
EIDS = [3844]
FAMILY = 'VS215843_PS215844'
EXPECTED = (215843, 215844)
INSTANCE_STRIDE = 96
ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215843_PS215844_Batch'
CAP = os.path.join(ROOT, 'Captured')
TEX = os.path.join(ROOT, 'TextureDatabase')
SH = os.path.join(ROOT, 'Shaders')
GEOM = os.path.join(CAP, 'Geometry')
CBS = os.path.join(CAP, 'CBuffers')
INST = os.path.join(CAP, 'Instances')
for p in (CAP, TEX, SH, GEOM, CBS, INST):
    os.makedirs(p, exist_ok=True)

UNIQUE_MATERIAL = {'res25', 'res27'}
VS_SHARED = set()
ASSETS = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets'


def rid(x):
    try:
        return int(x)
    except Exception:
        return 0


def fmt(f):
    return {
        'name': f.Name(),
        'type': str(f.type),
        'compType': str(f.compType),
        'compCount': int(f.compCount),
        'compByteWidth': int(f.compByteWidth),
    }


def save(path, data):
    data = bytes(data)
    h = hashlib.sha256(data).hexdigest()
    reuse = os.path.exists(path) and open(path, 'rb').read() == data
    if not reuse:
        os.makedirs(os.path.dirname(path), exist_ok=True)
        open(path, 'wb').write(data)
    return {
        'file': os.path.relpath(path, ROOT).replace('\\', '/'),
        'bytes': len(data),
        'sha256': h,
        'reused': reuse,
    }


def save_dedup(folder, stem, data):
    data = bytes(data)
    h = hashlib.sha256(data).hexdigest()
    path = os.path.join(folder, '%s_%s.bytes' % (stem, h[:16]))
    return save(path, data)


def work(c):
    t0 = time.time()
    actions = {}

    def walk(xs):
        for a in xs:
            if a.eventId in EIDS:
                actions[a.eventId] = a
            walk(a.children)

    walk(c.GetRootActions())
    missing = [x for x in EIDS if x not in actions]
    if missing:
        raise RuntimeError('Missing EIDs: ' + str(missing))

    cache = {}

    def getbuf(resource, off, size):
        k = (rid(resource), int(off), int(size))
        if k not in cache:
            cache[k] = bytes(c.GetBufferData(resource, int(off), int(size)))
        return cache[k]

    texdesc = {rid(t.resourceId): t for t in c.GetTextures()}
    profiles = []
    texture_refs = {}
    common = {}
    geom_seen = {}
    cb_seen = {}

    for eid in EIDS:
        a = actions[eid]
        c.SetFrameEvent(eid, False)
        s = c.GetPipelineState()
        vs = rid(s.GetShader(rd.ShaderStage.Vertex))
        ps = rid(s.GetShader(rd.ShaderStage.Pixel))
        if (vs, ps) != EXPECTED:
            raise RuntimeError('EID%d shader mismatch %d/%d' % (eid, vs, ps))

        ib = s.GetIBuffer()
        istride = int(ib.byteStride)
        icount = int(a.numIndices)
        ioff = int(ib.byteOffset) + int(a.indexOffset) * istride
        rawidx = getbuf(ib.resourceId, ioff, icount * istride)
        if istride == 2:
            indices = list(struct.unpack('<%dH' % icount, rawidx))
        elif istride == 4:
            indices = list(struct.unpack('<%dI' % icount, rawidx))
        else:
            raise RuntimeError('EID%d unsupported index stride %d' % (eid, istride))
        imin = min(indices) if indices else 0
        imax = max(indices) if indices else -1
        first = int(a.baseVertex) + imin
        vcount = imax - imin + 1
        normalized = [int(x) - imin for x in indices]
        normraw = struct.pack('<%dI' % len(normalized), *normalized)

        inputs = list(s.GetVertexInputs())
        vbs = s.GetVBuffers()
        layouts = []
        streams = []
        stream_blobs = []
        for x in inputs:
            layouts.append({
                'name': x.name,
                'slot': int(x.vertexBuffer),
                'offset': int(x.byteOffset),
                'format': fmt(x.format),
                'perInstance': bool(x.perInstance),
                'instanceRate': int(x.instanceRate),
            })
        for slot in sorted(set(x.vertexBuffer for x in inputs)):
            vb = vbs[slot]
            sin = [x for x in inputs if x.vertexBuffer == slot]
            stride = int(vb.byteStride)
            if stride > 0:
                count = int(a.numInstances) if all(x.perInstance for x in sin) else vcount
                start = int(a.instanceOffset) if all(x.perInstance for x in sin) else first
                raw = getbuf(vb.resourceId, int(vb.byteOffset) + start * stride, count * stride)
            else:
                size = max(int(x.byteOffset) + int(x.format.compCount) * int(x.format.compByteWidth) for x in sin)
                count = 1
                start = 0
                raw = getbuf(vb.resourceId, int(vb.byteOffset), size)
            stream_blobs.append((int(slot), raw, {
                'slot': int(slot),
                'rid': rid(vb.resourceId),
                'sourceOffset': int(vb.byteOffset),
                'sourceStride': stride,
                'firstElement': start,
                'elementCount': count,
                'constant': stride == 0,
            }))

        geom_hash = hashlib.sha256()
        geom_hash.update(normraw)
        for slot, raw, meta in stream_blobs:
            geom_hash.update(struct.pack('<ii', slot, len(raw)))
            geom_hash.update(raw)
        geom_hash.update(json.dumps(layouts, sort_keys=True).encode('utf8'))
        gsha = geom_hash.hexdigest()
        if gsha in geom_seen:
            files = dict(geom_seen[gsha]['files'])
            streams = list(geom_seen[gsha]['streams'])
            shared_from = geom_seen[gsha]['eid']
        else:
            files = {
                'indices': save_dedup(GEOM, 'indices_u32', normraw),
                'sourceIndices': save_dedup(GEOM, 'indices_source_u%d' % (istride * 8), rawidx),
            }
            streams = []
            for slot, raw, meta in stream_blobs:
                fr = save_dedup(GEOM, 'vertex_stream%d' % slot, raw)
                rec = dict(meta)
                rec['file'] = fr
                streams.append(rec)
            geom_seen[gsha] = {'eid': eid, 'files': files, 'streams': streams}
            shared_from = eid

        cbs = {}
        instance_file = None
        instance_count = int(a.numInstances)
        for stage, key in [(rd.ShaderStage.Vertex, 'VS'), (rd.ShaderStage.Pixel, 'PS')]:
            refl = s.GetShaderReflection(stage)
            arr = []
            for i, u in enumerate(s.GetConstantBlocks(stage)):
                d = u.descriptor
                name = refl.constantBlocks[i].name if i < len(refl.constantBlocks) else 'cb%d' % i
                sz = int(d.byteSize)
                if key == 'VS' and name == 'uniforms26':
                    need = instance_count * INSTANCE_STRIDE
                    raw = getbuf(d.resource, d.byteOffset, need)
                    instance_file = save(os.path.join(INST, 'EID%d_uniforms26_%d.bytes' % (eid, instance_count)), raw)
                    h = hashlib.sha256(raw).hexdigest()
                    fr = instance_file
                elif sz > 4096:
                    raw = b''
                    h = 'skipped-large-%d' % sz
                    fr = save(os.path.join(CBS, '%s_%02d_%s_skipped.bytes' % (key, i, name)), raw)
                else:
                    raw = getbuf(d.resource, d.byteOffset, sz)
                    h = hashlib.sha256(raw).hexdigest()
                    if h in cb_seen:
                        fr = cb_seen[h]
                    else:
                        fr = save(os.path.join(CBS, '%s_%02d_%s_%s.bytes' % (key, i, name, h[:16])), raw)
                        cb_seen[h] = fr
                rec = {
                    'index': i,
                    'name': name,
                    'binding': int(u.access.byteOffset),
                    'rid': rid(d.resource),
                    'offset': int(d.byteOffset),
                    'size': sz,
                    'sha256': h,
                    'file': fr,
                }
                arr.append(rec)
                common.setdefault(h, {'sha256': h, 'size': len(raw), 'stages': set(), 'names': set(), 'eids': []})
                common[h]['stages'].add(key)
                common[h]['names'].add(name)
                common[h]['eids'].append(eid)
            cbs[key] = arr

        if instance_file is None:
            raise RuntimeError('EID%d missing VS uniforms26 instance array' % eid)

        def collect_textures(stage, key):
            refl = s.GetShaderReflection(stage)
            rr = list(refl.readOnlyResources)
            out = []
            for i, u in enumerate(s.GetReadOnlyResources(stage)):
                d = u.descriptor
                r = rid(d.resource)
                name = rr[i].name if i < len(rr) else 'tex%d' % i
                td = texdesc.get(r)
                tr = {
                    'index': i,
                    'name': name,
                    'binding': int(u.access.byteOffset),
                    'rid': r,
                    'format': td.format.Name() if td else '',
                    'width': int(td.width) if td else 0,
                    'height': int(td.height) if td else 0,
                    'mips': int(td.mips) if td else 0,
                    'arraySize': int(td.arraysize) if td else 0,
                    'uniqueMaterial': name in UNIQUE_MATERIAL,
                    'stage': key,
                }
                out.append(tr)
                z = texture_refs.setdefault(r, dict(tr, eids=[], bindings=[], stages=[]))
                z['eids'].append(eid)
                z['bindings'].append(name)
                z['stages'].append(key)
            return out

        textures = collect_textures(rd.ShaderStage.Pixel, 'PS')
        vs_textures = collect_textures(rd.ShaderStage.Vertex, 'VS')

        profiles.append({
            'eid': eid,
            'shaderFamily': FAMILY,
            'vs': vs,
            'ps': ps,
            'meshItem': MESH_ITEM[eid],
            'sharedGeometryFromEID': shared_from,
            'geometrySha256': gsha,
            'draw': {
                'indexCount': icount,
                'instanceCount': instance_count,
                'indexOffset': int(a.indexOffset),
                'baseVertex': int(a.baseVertex),
                'vertexOffset': int(a.vertexOffset),
            },
            'sourceIndexStride': istride,
            'sourceIndexMin': imin,
            'sourceIndexMax': imax,
            'vertexCount': vcount,
            'triangleCount': icount // 3,
            'instanceStride': INSTANCE_STRIDE,
            'layout': layouts,
            'streams': streams,
            'files': files,
            'instanceBuffer': instance_file,
            'constantBuffers': cbs,
            'textures': textures,
            'vsTextures': vs_textures,
        })

    shader_src = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65'
    shader_files = {
        'VS215843': {
            'spv': save(os.path.join(SH, 'VS215843.spv'), open(os.path.join(shader_src, '951f4c6338c81689_VS.spv'), 'rb').read()),
            'disassembly': save(os.path.join(SH, 'VS215843.spvasm'), open(os.path.join(shader_src, '951f4c6338c81689_VS.spvasm'), 'rb').read()),
            'sha256': hashlib.sha256(open(os.path.join(shader_src, '951f4c6338c81689_VS.spv'), 'rb').read()).hexdigest(),
        },
        'PS215844': {
            'spv': save(os.path.join(SH, 'PS215844.spv'), open(os.path.join(shader_src, 'd3eb4657e302f3fe_PS.spv'), 'rb').read()),
            'disassembly': save(os.path.join(SH, 'PS215844.spvasm'), open(os.path.join(shader_src, 'd3eb4657e302f3fe_PS.spvasm'), 'rb').read()),
            'sha256': hashlib.sha256(open(os.path.join(shader_src, 'd3eb4657e302f3fe_PS.spv'), 'rb').read()).hexdigest(),
        },
    }

    existing = {}
    search_roots = [
        os.path.join(ASSETS, 'ColourPass6_VS215843_PS215844_Batch', 'TextureDatabase'),
    ]
    for search in search_roots:
        if not os.path.isdir(search):
            continue
        for root, dirs, fs in os.walk(search):
            for fn in fs:
                low = fn.lower()
                if low.endswith('.meta') or low.endswith('.raw'):
                    continue
                for r in texture_refs:
                    if ('rid%d' % r) in low:
                        existing.setdefault(r, []).append(os.path.relpath(os.path.join(root, fn), r'D:/endcopy/EID3336_URP_GBuffer_Workspace').replace('\\', '/'))

    exported = []
    skipped_existing = []
    reused_unique = []
    for r, v in sorted(texture_refs.items()):
        bindings = set(v.get('bindings', []))
        is_unique = bool(UNIQUE_MATERIAL.intersection(bindings))
        is_vs_shared = bool(VS_SHARED.intersection(bindings))
        if not is_unique and not is_vs_shared:
            continue
        if existing.get(r):
            skipped_existing.append({'rid': r, 'existing': existing[r]})
            continue
        path = os.path.join(TEX, 'rid%d.dds' % r)
        rel = 'TextureDatabase/rid%d.dds' % r
        if os.path.exists(path):
            reused_unique.append(r)
            continue
        exported.append({'rid': r, 'path': rel, 'result': 'deferred-save'})

    commons = []
    for h, v in common.items():
        commons.append({
            'sha256': h,
            'size': v['size'],
            'stages': sorted(v['stages']),
            'names': sorted(v['names']),
            'eids': sorted(set(v['eids'])),
            'sharedBy': len(set(v['eids'])),
        })

    out = {
        'version': 1,
        'shaderFamily': FAMILY,
        'requestedEIDs': EIDS,
        'notes': {
            'vsSha256': shader_files['VS215843']['sha256'],
            'psSha256': shader_files['PS215844']['sha256'],
            'instanceStride': INSTANCE_STRIDE,
            'psUniqueSlots': sorted(UNIQUE_MATERIAL),
            'vsSharedSlots': sorted(VS_SHARED),
            'packedOn': 'NORMAL.x',
            'existingTextureRIDsReused': skipped_existing,
            'geometrySharing': {h[:16]: v['eid'] for h, v in geom_seen.items()},
            'stencil': 'Ref 33 ReadMask 255 WriteMask 255 Always Replace',
        },
        'profiles': profiles,
        'shaderFiles': shader_files,
        'textureDatabase': [],
        'commonBufferAudit': sorted(commons, key=lambda x: (-x['sharedBy'], x['sha256'])),
        'statistics': {
            'eids': len(profiles),
            'instances': sum(x['draw']['instanceCount'] for x in profiles),
            'vertices': sum(x['vertexCount'] for x in profiles),
            'triangles': sum(x['triangleCount'] for x in profiles),
            'layoutVariants': len(set(json.dumps(x['layout'], sort_keys=True) for x in profiles)),
            'uniqueGeometryBlobs': len(geom_seen),
            'uniqueTextureRIDs': len(texture_refs),
            'uniqueMaterialRIDs': len([r for r, v in texture_refs.items() if UNIQUE_MATERIAL.intersection(v.get('bindings', []))]),
            'newTextureExports': len(exported),
            'reusedExistingTextureRIDs': len(skipped_existing),
        },
        'elapsedSeconds': time.time() - t0,
    }
    for r, v in sorted(texture_refs.items()):
        v['eids'] = sorted(set(v['eids']))
        v['bindings'] = sorted(set(v['bindings']))
        v['stages'] = sorted(set(v.get('stages', [])))
        v['existingAssets'] = sorted(existing.get(r, []))
        unique = bool(UNIQUE_MATERIAL.intersection(v['bindings'])) or bool(VS_SHARED.intersection(v['bindings']))
        local = os.path.join(TEX, 'rid%d.dds' % r)
        v['uniqueMaterial'] = bool(UNIQUE_MATERIAL.intersection(v['bindings']))
        if unique and os.path.exists(local):
            v['exportedAsset'] = 'TextureDatabase/rid%d.dds' % r
        elif unique and v['existingAssets']:
            v['exportedAsset'] = v['existingAssets'][0]
        else:
            v['exportedAsset'] = next((x['path'] for x in exported if x['rid'] == r), None)
        out['textureDatabase'].append(v)

    open(os.path.join(ROOT, 'VS215843_PS215844_BatchManifest.json'), 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))
    result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215843_215844_batch_result.json'
    summary = {
        'statistics': out['statistics'],
        'elapsedSeconds': out['elapsedSeconds'],
        'missingEIDs': missing,
        'exportedTextures': exported,
        'reusedUniqueTextureRIDs': reused_unique,
        'skippedExistingTextureRIDs': skipped_existing,
        'geometrySharing': out['notes']['geometrySharing'],
    }
    open(result_path, 'w', encoding='utf8').write(json.dumps(summary, indent=2, default=str))
    return summary


print(json.dumps(ctx.replay(work), default=str))
