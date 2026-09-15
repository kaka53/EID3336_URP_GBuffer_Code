import os, json, struct, hashlib, time

MESH_ITEM = {
    1627: '13.1',
    1642: '13.2',
    1647: '13.3',
    1652: '13.4',
    1657: '13.5',
    1682: '13.6',
    1692: '13.7',
    1696: '13.8',
}
EIDS = [1627, 1642, 1647, 1652, 1657, 1682, 1692, 1696]
FAMILY = 'VS215443_PS215444'
EXPECTED = (215443, 215444)
ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215443_PS215444_Batch'
CAP = os.path.join(ROOT, 'Captured')
TEX = os.path.join(ROOT, 'TextureDatabase')
SH = os.path.join(ROOT, 'Shaders')
GEOM = os.path.join(CAP, 'Geometry')
CBS = os.path.join(CAP, 'CBuffers')
for p in (CAP, TEX, SH, GEOM, CBS):
    os.makedirs(p, exist_ok=True)

UNIQUE_MATERIAL = {'res25', 'res26'}
SHARED_REQUIRED = set()
ASSETS = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets'
EXPECTED_INPUTS = set('_input%d' % i for i in range(7))


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
    raster = None
    skin_flags = []
    culls = []

    for eid in EIDS:
        a = actions[eid]
        c.SetFrameEvent(eid, False)
        s = c.GetPipelineState()
        vs = rid(s.GetShader(rd.ShaderStage.Vertex))
        ps = rid(s.GetShader(rd.ShaderStage.Pixel))
        if (vs, ps) != EXPECTED:
            raise RuntimeError('EID%d shader mismatch %d/%d' % (eid, vs, ps))

        rs = s.GetRasterState()
        ds = s.GetDepthTestState()
        st = s.GetStencilFaces()
        blends = s.GetColorBlends()
        culls.append(str(rs.cullMode))
        rec_raster = {
            'cullMode': str(rs.cullMode),
            'fillMode': str(rs.fillMode),
            'frontCCW': bool(rs.frontCCW),
            'depthFunction': str(ds.depthFunction),
            'depthWrites': bool(ds.depthWrites),
            'stencilRef': int(st[0].reference) if st else -1,
            'blendCount': len(blends),
            'blend0Enabled': bool(blends[0].enabled) if blends else None,
        }
        if raster is None:
            raster = rec_raster

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
        names = set(x.name for x in inputs)
        if names != EXPECTED_INPUTS:
            raise RuntimeError('EID%d expected 7 VS inputs _input0.._input6, got %s' % (eid, sorted(names)))
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
        geom_hash.update(json.dumps(layouts, sort_keys=True).encode('utf8'))
        for slot, raw, meta in stream_blobs:
            geom_hash.update(struct.pack('<ii', slot, len(raw)))
            geom_hash.update(raw)
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
        instance_flags = []
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
                if key == 'VS' and name == 'uniforms25':
                    for ii in range(int(a.numInstances)):
                        instance_mats.append(matrix(raw, ii * 256))
                        flags = struct.unpack_from('<I', raw, ii * 256 + 76)[0]
                        instance_flags.append(flags)
            cbs[key] = arr
        skin_flags.append({'eid': eid, 'flags': instance_flags})

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
                raw = getbuf(d.resource, d.byteOffset, d.byteSize)
                h = hashlib.sha256(raw).hexdigest()
                if h in cb_seen:
                    fr = cb_seen[h]
                else:
                    fr = save(os.path.join(CBS, 'VS_%02d_%s_%s.bytes' % (i, name, h[:16])), raw)
                    cb_seen[h] = fr
                rws['VS'].append({
                    'index': i,
                    'name': name,
                    'binding': int(u.access.byteOffset),
                    'rid': rid(d.resource),
                    'offset': int(d.byteOffset),
                    'size': int(d.byteSize),
                    'sha256': h,
                    'file': fr,
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
            'instanceFlags': instance_flags,
            'raster': rec_raster,
        })

    c.SetFrameEvent(EIDS[0], False)
    s = c.GetPipelineState()
    pso = s.GetGraphicsPipelineObject()
    shader_files = {}
    for stage, key in [(rd.ShaderStage.Vertex, 'VS215443'), (rd.ShaderStage.Pixel, 'PS215444')]:
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
    skipped_existing = []
    reused_unique = []
    for r, v in sorted(texture_refs.items()):
        is_unique = bool(UNIQUE_MATERIAL.intersection(v.get('bindings', [])))
        if not is_unique:
            continue
        if existing.get(r):
            skipped_existing.append({'rid': r, 'existing': existing[r]})
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

    nonzero_skin = [x for x in skin_flags if any((f & 32) != 0 for f in x['flags'])]
    out = {
        'version': 1,
        'shaderFamily': FAMILY,
        'requestedEIDs': EIDS,
        'notes': {
            'psUniqueSlots': sorted(UNIQUE_MATERIAL),
            'psSharedAlbedo': sorted(SHARED_REQUIRED),
            'instanceBuffer': 'VS uniforms25 / PS uniforms19 stride 256',
            'localMaterialCB': 'PS uniforms24 288B packed as 18 float4',
            'skinning': 'ssbo27 Binding7; flags uniforms25 child1.w bit32',
            'raster': raster,
            'cullModes': culls,
            'liveUnityVP': True,
            'packedNormal': 'NORMAL.x from _input2',
            'existingTextureRIDsReused': skipped_existing,
            'geometrySharing': {h[:16]: v['eid'] for h, v in geom_seen.items()},
            'nonzeroSkinEIDs': [x['eid'] for x in nonzero_skin],
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
            'nonzeroSkinInstances': sum(sum(1 for f in x['flags'] if (f & 32) != 0) for x in skin_flags),
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
        elif unique and v['existingAssets']:
            v['exportedAsset'] = v['existingAssets'][0]
        else:
            v['exportedAsset'] = next((x['path'] for x in exported if x['rid'] == r), None)
        out['textureDatabase'].append(v)

    open(os.path.join(ROOT, 'VS215443_PS215444_BatchManifest.json'), 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))
    result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215443_215444_batch_result.json'
    summary = {
        'statistics': out['statistics'],
        'elapsedSeconds': out['elapsedSeconds'],
        'missingEIDs': missing,
        'exportedTextures': exported,
        'reusedUniqueTextureRIDs': reused_unique,
        'skippedExistingTextureRIDs': skipped_existing,
        'geometrySharing': out['notes']['geometrySharing'],
        'raster': raster,
        'cullModes': culls,
        'nonzeroSkinEIDs': out['notes']['nonzeroSkinEIDs'],
    }
    open(result_path, 'w', encoding='utf8').write(json.dumps(summary, indent=2, default=str))
    return summary


ctx.replay(work)
