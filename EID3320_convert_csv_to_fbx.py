#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Convert extracted EID3320 VS-input CSVs (from RenderDoc endfield06.rdc) to ASCII FBX for Unity.

Input (extracted from event 3320, DrawIndexed(1167)):
  Assets/EID3336_URP_Reconstruction/Models/EID3320_VSInput_vertices.csv
  Assets/EID3336_URP_Reconstruction/Models/EID3320_VSInput_indices.csv
Output:
  Assets/EID3336_URP_Reconstruction/Models/EID3320_VSInput.fbx

Structure mirrors eid_3315_world.fbx (verified to import into Unity 2022.3 with
normals + tangents + 2 UV sets + vertex colors):
  - all layer elements ByVertice + Direct
  - each UV set lives in its own Layer (Layer: 0 = normal/tangent/uv0/color,
    Layer: 1 = uv1, Layer: 2 = uv2)

Vertex attributes carried by the FBX (see EID3320_VSInput_layout.json):
  position -> Vertices                (capture _input0, model space, Y-up)
  UV0      -> LayerElementUV 0        (capture _input4)
  UV1      -> LayerElementUV 1        (capture _input5, also bound to _input6/_input7, same bytes)
  UV2      -> LayerElementUV 2        (capture _input1, raw float32 bits preserved)
  color    -> LayerElementColor 0     (capture _input3, constant white 1,1,1,1)
  normal   -> LayerElementNormal 0    (COMPUTED smooth normals; capture has NO normal attribute)
  tangent  -> LayerElementTangent 0   (COMPUTED from UV0, orthogonalized, 4D with handedness)

The remaining constant attributes (_input2/_input8/_input9) and lossless per-vertex data are
in EID3320_VSInput_vertices.csv and can be rebuilt into Unity channels via
Assets/Editor/EID3320_VSInput_AttributeImporter.cs (menu Tools > EID3320).
"""
import csv
import os

BASE = os.path.dirname(os.path.abspath(__file__))
MODELS = os.path.join(BASE, "Assets", "EID3336_URP_Reconstruction", "Models")


def load_vertices():
    verts = []
    with open(os.path.join(MODELS, "EID3320_VSInput_vertices.csv"), newline="") as f:
        for row in csv.reader(f):
            if not row or row[0] == "vertex":
                continue
            verts.append(row)
    return verts


def load_triangles():
    tris = []
    with open(os.path.join(MODELS, "EID3320_VSInput_indices.csv"), newline="") as f:
        for row in csv.reader(f):
            if not row or row[0] == "triangle":
                continue
            tris.append((int(row[1]), int(row[2]), int(row[3])))
    return tris


def compute_normals(verts, tris):
    px = [float(v[1]) for v in verts]
    py = [float(v[2]) for v in verts]
    pz = [float(v[3]) for v in verts]
    norm = [[0.0, 0.0, 0.0] for _ in verts]
    for a, b, c in tris:
        ux, uy, uz = px[b] - px[a], py[b] - py[a], pz[b] - pz[a]
        vx, vy, vz = px[c] - px[a], py[c] - py[a], pz[c] - pz[a]
        nx, ny, nz = uy * vz - uz * vy, uz * vx - ux * vz, ux * vy - uy * vx
        for i in (a, b, c):
            norm[i][0] += nx
            norm[i][1] += ny
            norm[i][2] += nz
    out = []
    for n in norm:
        length = (n[0] * n[0] + n[1] * n[1] + n[2] * n[2]) ** 0.5
        if length > 1e-12:
            out.append((n[0] / length, n[1] / length, n[2] / length))
        else:
            out.append((0.0, 1.0, 0.0))
    return out


def compute_tangents(verts, tris, normals):
    """Per-vertex tangents (xyz + handedness w) from UV0, orthogonalized against normals."""
    px = [float(v[1]) for v in verts]
    py = [float(v[2]) for v in verts]
    pz = [float(v[3]) for v in verts]
    ux = [float(v[6]) for v in verts]
    uy = [float(v[7]) for v in verts]
    tan = [[0.0, 0.0, 0.0] for _ in verts]
    for a, b, c in tris:
        e1 = (px[b] - px[a], py[b] - py[a], pz[b] - pz[a])
        e2 = (px[c] - px[a], py[c] - py[a], pz[c] - pz[a])
        du1 = ux[b] - ux[a]
        dv1 = uy[b] - uy[a]
        du2 = ux[c] - ux[a]
        dv2 = uy[c] - uy[a]
        r = du1 * dv2 - du2 * dv1
        if abs(r) < 1e-12:
            continue
        r = 1.0 / r
        t = (dv2 * e1[0] - dv1 * e2[0]) * r, (dv2 * e1[1] - dv1 * e2[1]) * r, (dv2 * e1[2] - dv1 * e2[2]) * r
        for i in (a, b, c):
            tan[i][0] += t[0]
            tan[i][1] += t[1]
            tan[i][2] += t[2]
    out = []
    for i, n in enumerate(normals):
        acc = tan[i]
        t = acc
        dot = t[0] * n[0] + t[1] * n[1] + t[2] * n[2]
        t = (t[0] - dot * n[0], t[1] - dot * n[1], t[2] - dot * n[2])
        length = (t[0] * t[0] + t[1] * t[1] + t[2] * t[2]) ** 0.5
        if length < 1e-8:
            up = (0.0, 1.0, 0.0) if abs(n[1]) < 0.99 else (1.0, 0.0, 0.0)
            t = (up[1] * n[2] - up[2] * n[1], up[2] * n[0] - up[0] * n[2], up[0] * n[1] - up[1] * n[0])
            length = (t[0] * t[0] + t[1] * t[1] + t[2] * t[2]) ** 0.5
        t = (t[0] / length, t[1] / length, t[2] / length)
        w = 1.0 if (n[1] * t[2] - n[2] * t[1]) * acc[0] + (n[2] * t[0] - n[0] * t[2]) * acc[1] + (n[0] * t[1] - n[1] * t[0]) * acc[2] >= 0 else -1.0
        out.append((t[0], t[1], t[2], w))
    return out


def fnum(x):
    return repr(float(x))


def build_fbx(verts, tris, normals, tangents):
    n = len(verts)
    L = []
    A = L.append
    A("; FBX 7.4.0 project file")
    A("; Exported from RenderDoc capture F:/endfield06.rdc, event 3320 (VS input, model space)")
    A("; Generated by EID3320_convert_csv_to_fbx.py")
    A("FBXHeaderExtension: {")
    A("\tFBXHeaderVersion: 1003")
    A("\tFBXVersion: 7400")
    A('\tCreator: "EID3320 RenderDoc Exporter"')
    A("\tCreationTimeStamp: {")
    A("\t\tVersion: 1000")
    A("\t\tYear: 2026")
    A("\t\tMonth: 9")
    A("\t\tDay: 8")
    A("\t\tHour: 15")
    A("\t\tMinute: 30")
    A("\t\tSecond: 0")
    A("\t\tMillisecond: 0")
    A("\t}")
    A("}")
    A("GlobalSettings: {")
    A("\tVersion: 1000")
    A("\tProperties70: {")
    A('\t\tP: "UpAxis", "int", "Integer", "",1')
    A('\t\tP: "UpAxisSign", "int", "Integer", "",1')
    A('\t\tP: "FrontAxis", "int", "Integer", "",2')
    A('\t\tP: "FrontAxisSign", "int", "Integer", "",1')
    A('\t\tP: "CoordAxis", "int", "Integer", "",0')
    A('\t\tP: "CoordAxisSign", "int", "Integer", "",1')
    A('\t\tP: "OriginalUpAxis", "int", "Integer", "",1')
    A('\t\tP: "OriginalUpAxisSign", "int", "Integer", "",1')
    A('\t\tP: "UnitScaleFactor", "double", "Number", "",1')
    A('\t\tP: "OriginalUnitScaleFactor", "double", "Number", "",1')
    A("\t}")
    A("}")
    A("Documents: {")
    A("\tCount: 1")
    A('\tDocument: 1, "Document::Scene", "Scene" {')
    A("\t\tProperties70: {")
    A("\t\t}")
    A("\t\tRootNode: 0")
    A("\t}")
    A("}")
    A("References: {")
    A("}")
    A("Definitions: {")
    A("\tVersion: 100")
    A("\tCount: 2")
    A('\tObjectType: "Geometry" {')
    A("\t\tCount: 1")
    A("\t}")
    A('\tObjectType: "Model" {')
    A("\t\tCount: 1")
    A("\t}")
    A("}")
    A("Objects: {")
    A('\tGeometry: 100000, "Geometry::EID3320_VSInput", "Mesh" {')
    A("\t\tGeometryVersion: 124")
    A("\t\tVertices: *%d {" % (n * 3))
    A("\t\t\ta: " + ",".join(fnum(v[1]) + "," + fnum(v[2]) + "," + fnum(v[3]) for v in verts))
    A("\t\t}")
    pvi = []
    for a, b, c in tris:
        pvi.extend((a, b, -(c + 1)))
    A("\t\tPolygonVertexIndex: *%d {" % len(pvi))
    A("\t\t\ta: " + ",".join(str(x) for x in pvi))
    A("\t\t}")
    A("\t\tLayerElementNormal: 0 {")
    A("\t\t\tVersion: 101")
    A('\t\t\tName: ""')
    A('\t\t\tMappingInformationType: "ByVertice"')
    A('\t\t\tReferenceInformationType: "Direct"')
    A("\t\t\tNormals: *%d {" % (n * 3))
    A("\t\t\t\ta: " + ",".join(fnum(t[0]) + "," + fnum(t[1]) + "," + fnum(t[2]) for t in normals))
    A("\t\t\t}")
    A("\t\t}")
    A("\t\tLayerElementTangent: 0 {")
    A("\t\t\tVersion: 101")
    A('\t\t\tName: ""')
    A('\t\t\tMappingInformationType: "ByVertice"')
    A('\t\t\tReferenceInformationType: "Direct"')
    A("\t\t\tTangents: *%d {" % (n * 4))
    A("\t\t\t\ta: " + ",".join(fnum(t[0]) + "," + fnum(t[1]) + "," + fnum(t[2]) + "," + fnum(t[3]) for t in tangents))
    A("\t\t\t}")
    A("\t\t}")
    A("\t\tLayerElementUV: 0 {")
    A("\t\t\tVersion: 101")
    A('\t\t\tName: "UV0"')
    A('\t\t\tMappingInformationType: "ByVertice"')
    A('\t\t\tReferenceInformationType: "Direct"')
    A("\t\t\tUV: *%d {" % (n * 2))
    A("\t\t\t\ta: " + ",".join(fnum(v[6]) + "," + fnum(v[7]) for v in verts))
    A("\t\t\t}")
    A("\t\t}")
    A("\t\tLayerElementUV: 1 {")
    A("\t\t\tVersion: 101")
    A('\t\t\tName: "UV1"')
    A('\t\t\tMappingInformationType: "ByVertice"')
    A('\t\t\tReferenceInformationType: "Direct"')
    A("\t\t\tUV: *%d {" % (n * 2))
    A("\t\t\t\ta: " + ",".join(fnum(v[8]) + "," + fnum(v[9]) for v in verts))
    A("\t\t\t}")
    A("\t\t}")
    A("\t\tLayerElementUV: 2 {")
    A("\t\t\tVersion: 101")
    A('\t\t\tName: "UV3_input1"')
    A('\t\t\tMappingInformationType: "ByVertice"')
    A('\t\t\tReferenceInformationType: "Direct"')
    A("\t\t\tUV: *%d {" % (n * 2))
    A("\t\t\t\ta: " + ",".join(fnum(v[4]) + ",0" for v in verts))
    A("\t\t\t}")
    A("\t\t}")
    A("\t\tLayerElementColor: 0 {")
    A("\t\t\tVersion: 101")
    A('\t\t\tName: "VertexColor"')
    A('\t\t\tMappingInformationType: "ByVertice"')
    A('\t\t\tReferenceInformationType: "Direct"')
    A("\t\t\tColors: *%d {" % (n * 4))
    A("\t\t\t\ta: " + ",".join(
        "%f,%f,%f,%f" % (int(v[10]) / 255.0, int(v[11]) / 255.0, int(v[12]) / 255.0, int(v[13]) / 255.0)
        for v in verts))
    A("\t\t\t}")
    A("\t\t}")
    A("\t\tLayer: 0 {")
    A("\t\t\tVersion: 100")
    A("\t\t\tLayerElement: {")
    A('\t\t\t\tType: "LayerElementNormal"')
    A("\t\t\t\tTypedIndex: 0")
    A("\t\t\t}")
    A("\t\t\tLayerElement: {")
    A('\t\t\t\tType: "LayerElementTangent"')
    A("\t\t\t\tTypedIndex: 0")
    A("\t\t\t}")
    A("\t\t\tLayerElement: {")
    A('\t\t\t\tType: "LayerElementUV"')
    A("\t\t\t\tTypedIndex: 0")
    A("\t\t\t}")
    A("\t\t\tLayerElement: {")
    A('\t\t\t\tType: "LayerElementColor"')
    A("\t\t\t\tTypedIndex: 0")
    A("\t\t\t}")
    A("\t\t}")
    A("\t\tLayer: 1 {")
    A("\t\t\tVersion: 100")
    A("\t\t\tLayerElement: {")
    A('\t\t\t\tType: "LayerElementUV"')
    A("\t\t\t\tTypedIndex: 1")
    A("\t\t\t}")
    A("\t\t}")
    A("\t\tLayer: 2 {")
    A("\t\t\tVersion: 100")
    A("\t\t\tLayerElement: {")
    A('\t\t\t\tType: "LayerElementUV"')
    A("\t\t\t\tTypedIndex: 2")
    A("\t\t\t}")
    A("\t\t}")
    A("\t}")
    A('\tModel: 100001, "Model::EID3320_VSInput", "Mesh" {')
    A("\t\tVersion: 232")
    A("\t\tProperties70: {")
    A('\t\t\tP: "InheritType", "enum", "", "",1')
    A('\t\t\tP: "Lcl Translation", "Lcl Translation", "", "A",0,0,0')
    A('\t\t\tP: "Lcl Rotation", "Lcl Rotation", "", "A",0,0,0')
    A('\t\t\tP: "Lcl Scaling", "Lcl Scaling", "", "A",1,1,1')
    A("\t\t}")
    A("\t\tShading: T")
    A('\t\tCulling: "CullingOff"')
    A("\t}")
    A("}")
    A("Connections: {")
    A("\tC: \"OO\",100000,100001")
    A("\tC: \"OO\",100001,0")
    A("}")
    return "\n".join(L) + "\n"


def main():
    verts = load_vertices()
    tris = load_triangles()
    if len(verts) != 217 or len(tris) != 389:
        raise SystemExit(
            "unexpected input: %d vertices / %d triangles (expected 217/389)" % (len(verts), len(tris))
        )
    normals = compute_normals(verts, tris)
    tangents = compute_tangents(verts, tris, normals)
    fbx = build_fbx(verts, tris, normals, tangents)
    out = os.path.join(MODELS, "EID3320_VSInput.fbx")
    tmp = out + ".tmp"
    with open(tmp, "w", encoding="utf-8", newline="\n") as f:
        f.write(fbx)
    os.replace(tmp, out)  # atomic replace so Unity never sees a half-written file
    print("wrote %s (%d bytes, %d vertices, %d triangles)" % (out, len(fbx), len(verts), len(tris)))


if __name__ == "__main__":
    main()
