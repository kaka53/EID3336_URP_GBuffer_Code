import os, json, struct, hashlib, time

EIDS = [
    1776, 1780, 1782, 1786, 1788, 1792, 1794, 1798, 1800, 1804, 1806, 1810, 1814, 1818, 1820, 1824,
    1826, 1830, 1834, 1836, 1840, 1844, 1848, 1852, 1856, 1860, 1864, 1866, 1870, 1874, 1878, 1880,
    1884, 1886, 1890, 1892, 1896, 1898, 1902, 1904, 1908, 1912, 1914, 1918, 1920, 1924, 1928, 1930,
    1934, 1938, 1940, 1944, 1948, 1952, 1956, 1958, 1962, 1966, 1970, 1974, 1976, 1980, 1982, 1986,
    1990, 1992, 1996, 1998, 2002, 2004, 2008, 2012, 2016, 2020, 2024, 2028, 2032, 2036, 2040, 2044,
    2048, 2052, 2056, 2060, 2064, 2068, 2072, 2076, 2080, 2084, 2088, 2092, 2096, 2100, 2104, 2108,
    2112, 2114, 2118, 2120, 2124, 2128, 2130, 2134, 2138, 2140, 2144, 2148, 2150, 2154, 2158, 2162,
    2166, 2168, 2172, 2174, 2178, 2182, 2184, 2188, 2190, 2194, 2198, 2202, 2206, 2210, 2214, 2218,
    2222, 2226, 2230, 2234, 2238, 2242, 2246, 2250, 2254, 2258, 2262, 2266, 2270, 2274, 2278, 2282,
    2286, 2290, 2294, 2298, 2302, 2306, 2310, 2314, 2318, 2322, 2326, 2330, 2334, 2336, 2340, 2344,
    2346, 2350, 2354, 2358, 2362, 2366, 2370, 2374, 2378, 2382, 2386, 2390, 2394, 2398, 2402, 2406,
    2410, 2414, 2418, 2422, 2426, 2430, 2434, 2438, 2442, 2446, 2450, 2454, 2458, 2462, 2466, 2468,
    2472, 2474, 2478, 2482, 2486, 2490, 2494, 2498, 2502, 2507, 2511, 2515, 2519, 2523,
]
MESH_ITEM = {eid: '1.%d' % (i + 1) for i, eid in enumerate(EIDS)}
FAMILY = 'VS209975_PS209977'
EXPECTED = (209975, 209977)
ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS209975_PS209977_Batch'
CAP = os.path.join(ROOT, 'Captured')
TEX = os.path.join(ROOT, 'TextureDatabase')
SH = os.path.join(ROOT, 'Shaders')
GEOM = os.path.join(CAP, 'Geometry')
CBS = os.path.join(CAP, 'CBuffers')
PROF = os.path.join(CAP, 'Profiles')
RESULT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_209975_209977_batch_result.json'
ASSETS = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets'
BUDGET = 70.0
UNIQUE_MATERIAL = {'res17', 'res19'}
for p in (CAP, TEX, SH, GEOM, CBS, PROF):
    os.makedirs(p, exist_ok=True)


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


def profile_path(eid):
    return os.path.join(PROF, 'EID%d.json' % eid)


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
    done = set()

    for eid in EIDS:
        path = profile_path(eid)
        if not os.path.exists(path):
            continue
        rec = json.load(open(path, 'r', encoding='utf8'))
        profiles.append(rec)
        done.add(eid)
        gsha = rec.get('geometrySha256')
        if gsha and gsha not in geom_seen:
            geom_seen[gsha] = {
                'eid': rec.get('sharedGeometryFromEID', eid),
                'files': rec.get('files'),
                'streams': rec.get('streams'),
            }
        for key, arr in rec.get('constantBuffers', {}).items():
            for cb in arr or []:
                h = cb.get('sha256')
                if h:
                    cb_seen[h] = cb.get('file')
                    common.setdefault(h, {'sha256': h, 'size': cb.get('size', 0), 'stages': set(), 'names': set(), 'eids': []})
                    common[h]['stages'].add(key)
                    common[h]['names'].add(cb.get('name'))
                    common[h]['eids'].append(eid)
        for tr in rec.get('textures', []):
            r = tr.get('rid')
            z = texture_refs.setdefault(r, dict(tr, eids=[], bindings=[]))
            z['eids'].append(eid)
            z['bindings'].append(tr.get('name'))

    timed_out = False
    for eid in EIDS:
        if eid in done:
            continue
        if time.time() - t0 > BUDGET:
            timed_out = True
            break
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
                if key == 'VS' and name == 'uniforms26':
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

        rec = {
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
            'readWriteResources': {'VS': []},
            'textures': textures,
            'instanceMatricesRowMajor': instance_mats,
        }
        open(profile_path(eid), 'w', encoding='utf8').write(json.dumps(rec, indent=2, default=str))
        profiles.append(rec)
        done.add(eid)

    shader_files = {}
    if 1776 in done or any(os.path.exists(os.path.join(SH, n)) for n in ('VS209975.spv', 'PS209977.spv')):
        try:
            c.SetFrameEvent(EIDS[0], False)
            s = c.GetPipelineState()
            pso = s.GetGraphicsPipelineObject()
            for stage, key in [(rd.ShaderStage.Vertex, 'VS209975'), (rd.ShaderStage.Pixel, 'PS209977')]:
                dest_spv = os.path.join(SH, key + '.spv')
                if os.path.exists(dest_spv) and os.path.exists(os.path.join(SH, key + '.spvasm')):
                    shader_files[key] = {
                        'spv': {'file': 'Shaders/%s.spv' % key, 'bytes': os.path.getsize(dest_spv)},
                        'disassembly': {'file': 'Shaders/%s.spvasm' % key, 'bytes': os.path.getsize(os.path.join(SH, key + '.spvasm'))},
                    }
                    continue
                refl = s.GetShaderReflection(stage)
                shader_files[key] = {
                    'spv': save(os.path.join(SH, key + '.spv'), bytes(refl.rawBytes)),
                    'disassembly': save(os.path.join(SH, key + '.spvasm'), c.DisassembleShader(pso, refl, 'SPIR-V (RenderDoc)').encode('utf8')),
                    'sha256': hashlib.sha256(bytes(refl.rawBytes)).hexdigest(),
                }
        except Exception as e:
            shader_files['error'] = str(e)

    existing = {}

    exported = []
    skipped_shared = []
    reused_unique = []
    tex_timed_out = False
    if len(done) == len(EIDS):
        for r, v in sorted(texture_refs.items()):
            if time.time() - t0 > BUDGET:
                tex_timed_out = True
                break
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

    remaining = [x for x in EIDS if x not in done]
    complete = (not remaining) and (not tex_timed_out)
    out = {
        'version': 1,
        'shaderFamily': FAMILY,
        'requestedEIDs': EIDS,
        'notes': {
            'algorithmFrom': 'EID2012 VS209975/PS209977 Unity port, live Unity VP',
            'psUniqueSlots': sorted(UNIQUE_MATERIAL),
            'sharedGlobalsNotReexported': skipped_shared,
            'geometrySharing': {h[:16]: v['eid'] for h, v in geom_seen.items()},
            'alreadyRestoredSkipScene': [2012, 2044],
            'partial': not complete,
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

    if complete:
        open(os.path.join(ROOT, 'VS209975_PS209977_BatchManifest.json'), 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))

    summary = {
        'complete': complete,
        'timedOutDraws': timed_out,
        'timedOutTextures': tex_timed_out,
        'doneEIDs': sorted(done),
        'remainingEIDs': remaining,
        'statistics': out['statistics'],
        'elapsedSeconds': out['elapsedSeconds'],
        'exportedTextures': exported,
        'reusedUniqueTextureRIDs': reused_unique,
        'skippedSharedTextureRIDs': skipped_shared,
        'uniqueMaterialRIDs': out['statistics']['uniqueMaterialRIDs'],
        'geometryBlobs': len(geom_seen),
    }
    open(RESULT, 'w', encoding='utf8').write(json.dumps(summary, indent=2, default=str))
    return summary


print(json.dumps(ctx.replay(work), default=str))
