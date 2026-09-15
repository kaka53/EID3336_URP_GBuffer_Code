import os, json, struct, hashlib, time

MESH_ITEM = {
    3083: '5.1', 3104: '5.1',
    3087: '5.2',
    3091: '5.3',
    3095: '5.4',
    3099: '5.5',
    3108: '5.6',
    3112: '5.7',
    3116: '5.8',
    3118: '5.9',
    3122: '5.10',
    3124: '5.11',
    3128: '5.12',
    3130: '5.13',
    3134: '5.14',
    3138: '5.15',
    3142: '5.16',
    3147: '5.17',
    3152: '5.18',
    3156: '5.19',
    3161: '5.20',
}
EIDS = [3083, 3104, 3087, 3091, 3095, 3099, 3108, 3112, 3116, 3118, 3122, 3124, 3128, 3130, 3134, 3138, 3142, 3147, 3152, 3156, 3161]
FAMILY = 'VS215500_PS215502'
EXPECTED = (215500, 215502)
ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215500_PS215502_Batch'
CAP = os.path.join(ROOT, 'Captured')
TEX = os.path.join(ROOT, 'TextureDatabase')
SH = os.path.join(ROOT, 'Shaders')
GEOM = os.path.join(CAP, 'Geometry')
CBS = os.path.join(CAP, 'CBuffers')
for p in (CAP, TEX, SH, GEOM, CBS):
    os.makedirs(p, exist_ok=True)

UNIQUE_MATERIAL = {'res31', 'res33', 'res35'}
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


def matrix(raw, off=0):
    f = struct.unpack_from('<16f', raw, off)
    return [
        [f[0], f[4], f[8], f[12]],
        [f[1], f[5], f[9], f[13]],
        [f[2], f[6], f[10], f[14]],
        [f[3], f[7], f[11], f[15]],
    ]


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
        instance_mats = []
        for stage, key in [(rd.ShaderStage.Vertex, 'VS'), (rd.ShaderStage.Pixel, 'PS')]:
            refl = s.GetShaderReflection(stage)
            arr = []
            for i, u in enumerate(s.GetConstantBlocks(stage)):
                d = u.descriptor
                name = refl.constantBlocks[i].name if i < len(refl.constantBlocks) else 'cb%d' % i
                raw = getbuf(d.resource, d.byteOffset, d.byteSize)
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
                    'size': int(d.byteSize),
                    'sha256': h,
                    'file': fr,
                }
                arr.append(rec)
                common.setdefault(h, {'sha256': h, 'size': len(raw), 'stages': set(), 'names': set(), 'eids': []})
                common[h]['stages'].add(key)
                common[h]['names'].add(name)
                common[h]['eids'].append(eid)
                if key == 'VS' and name == 'uniforms28':
                    for ii in range(int(a.numInstances)):
                        instance_mats.append(matrix(raw, ii * 256))
            cbs[key] = arr

        reflps = s.GetShaderReflection(rd.ShaderStage.Pixel)
        rr = list(reflps.readOnlyResources)
        textures = []
        for i, u in enumerate(s.GetReadOnlyResources(rd.ShaderStage.Pixel)):
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
            }
            textures.append(tr)
            z = texture_refs.setdefault(r, dict(tr, eids=[], bindings=[]))
            z['eids'].append(eid)
            z['bindings'].append(name)

        rws = {'VS': []}
        reflvs = s.GetShaderReflection(rd.ShaderStage.Vertex)
        try:
            for i, u in enumerate(s.GetReadWriteResources(rd.ShaderStage.Vertex)):
                d = u.descriptor
                name = reflvs.readWriteResources[i].name if i < len(reflvs.readWriteResources) else 'rw%d' % i
                rws['VS'].append({
                    'index': i,
                    'name': name,
                    'binding': int(u.access.byteOffset),
                    'rid': rid(d.resource),
                    'offset': int(d.byteOffset),
                    'size': int(d.byteSize),
                })
        except Exception:
            pass

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
                'instanceCount': int(a.numInstances),
                'indexOffset': int(a.indexOffset),
                'baseVertex': int(a.baseVertex),
                'vertexOffset': int(a.vertexOffset),
            },
            'sourceIndexStride': istride,
            'sourceIndexMin': imin,
            'sourceIndexMax': imax,
            'vertexCount': vcount,
            'triangleCount': icount // 3,
            'layout': layouts,
            'streams': streams,
            'files': files,
            'constantBuffers': cbs,
            'readWriteResources': rws,
            'textures': textures,
            'instanceMatricesRowMajor': instance_mats,
        })

    c.SetFrameEvent(EIDS[0], False)
    s = c.GetPipelineState()
    pso = s.GetGraphicsPipelineObject()
    shader_files = {}
    for stage, key in [(rd.ShaderStage.Vertex, 'VS215500'), (rd.ShaderStage.Pixel, 'PS215502')]:
        refl = s.GetShaderReflection(stage)
        shader_files[key] = {
            'spv': save(os.path.join(SH, key + '.spv'), bytes(refl.rawBytes)),
            'disassembly': save(os.path.join(SH, key + '.spvasm'), c.DisassembleShader(pso, refl, 'SPIR-V (RenderDoc)').encode('utf8')),
            'sha256': hashlib.sha256(bytes(refl.rawBytes)).hexdigest(),
        }

    existing = {}
    for root, dirs, fs in os.walk(ASSETS):
        if os.path.abspath(root).startswith(os.path.abspath(TEX)):
            continue
        for fn in fs:
            low = fn.lower()
            if low.endswith('.meta') or low.endswith('.raw'):
                continue
            for r in texture_refs:
                if ('rid%d' % r) in low:
                    existing.setdefault(r, []).append(os.path.relpath(os.path.join(root, fn), r'D:/endcopy/EID3336_URP_GBuffer_Workspace').replace('\\', '/'))

    exported = []
    skipped_shared = []
    reused_unique = []
    for r, v in sorted(texture_refs.items()):
        is_unique = bool(UNIQUE_MATERIAL.intersection(v.get('bindings', [])))
        if not is_unique:
            skipped_shared.append(r)
            continue
        path = os.path.join(TEX, 'rid%d.dds' % r)
        rel = 'TextureDatabase/rid%d.dds' % r
        if os.path.exists(path):
            reused_unique.append(r)
            continue
        cfg = rd.TextureSave()
        cfg.resourceId = next(t.resourceId for t in c.GetTextures() if rid(t.resourceId) == r)
        cfg.destType = rd.FileType.DDS
        cfg.mip = -1
        cfg.slice = rd.TextureSliceMapping()
        res = c.SaveTexture(cfg, path)
        exported.append({'rid': r, 'path': rel, 'result': str(res)})

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
            'vsIdenticalTo': 'VS209980 sha256 9bfd93b2c33c7fc3b5cd8a925416a97659118ab7fa9de1fc5694095854423896',
            'psUniqueSlots': sorted(UNIQUE_MATERIAL),
            'sharedGlobalsNotReexported': skipped_shared,
            'geometrySharing': {h[:16]: v['eid'] for h, v in geom_seen.items()},
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
            'skippedSharedTextureRIDs': len(skipped_shared),
        },
        'elapsedSeconds': time.time() - t0,
    }
    for r, v in sorted(texture_refs.items()):
        v['eids'] = sorted(set(v['eids']))
        v['bindings'] = sorted(set(v['bindings']))
        v['existingAssets'] = sorted(existing.get(r, []))
        unique = bool(UNIQUE_MATERIAL.intersection(v['bindings']))
        local = os.path.join(TEX, 'rid%d.dds' % r)
        v['uniqueMaterial'] = unique
        if unique and os.path.exists(local):
            v['exportedAsset'] = 'TextureDatabase/rid%d.dds' % r
        else:
            v['exportedAsset'] = next((x['path'] for x in exported if x['rid'] == r), None)
        out['textureDatabase'].append(v)

    open(os.path.join(ROOT, 'VS215500_PS215502_BatchManifest.json'), 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))
    result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215500_215502_batch_result.json'
    summary = {
        'statistics': out['statistics'],
        'elapsedSeconds': out['elapsedSeconds'],
        'missingEIDs': missing,
        'exportedTextures': exported,
        'reusedUniqueTextureRIDs': reused_unique,
        'skippedSharedTextureRIDs': skipped_shared,
        'geometrySharing': out['notes']['geometrySharing'],
    }
    open(result_path, 'w', encoding='utf8').write(json.dumps(summary, indent=2, default=str))
    return summary


print(json.dumps(ctx.replay(work), default=str))
