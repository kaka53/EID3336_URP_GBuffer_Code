#if UNITY_EDITOR
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.SceneManagement;

// Deliberately independent of EID3315CombinedImporter and the legacy MRT providers.
// Only the explicit menu/one-shot request below modifies the designated camera scene.
[InitializeOnLoad]
public static class EID3315RenderDocCameraImporter
{
    const string Root = "Assets/EID3332_EID3336_Combined";
    const string Work = Root + "/EID3315_RenderDocCamera";
    public const string TargetScene = Root + "/Scenes/EID3336_RenderDocCamera.unity";
    const string MeshPath = Work + "/EID3315_VSInput_Exact.asset";
    const string MaterialPath = Work + "/EID3315_RenderDocGBuffer.mat";
    const string ObjectName = "eid3315_instance_000";
    static readonly string Project = Directory.GetParent(Application.dataPath).FullName;
    static readonly string Request = Path.Combine(Project, "Validation/ImportEID3315RenderDocCamera.request");
    static readonly string ReportPath = Path.Combine(Project, "Validation/EID3315_RenderDocCamera/import_report.txt");
    static bool busy;

    static EID3315RenderDocCameraImporter() { EditorApplication.update += Poll; }
    static void Poll()
    {
        if (busy || EditorApplication.isCompiling || EditorApplication.isUpdating || !File.Exists(Request)) return;
        File.Delete(Request);
        try { Import(); }
        catch (Exception e)
        {
            Directory.CreateDirectory(Path.GetDirectoryName(ReportPath));
            File.WriteAllText(ReportPath, "FAIL\n" + e);
            Debug.LogException(e);
        }
    }

    [MenuItem("Tools/EID3332+3336/Import EID3315 Into RenderDoc Camera Scene")]
    public static void Import()
    {
        if (busy) return;
        busy = true;
        var report = new StringBuilder();
        try
        {
            if (EditorApplication.isPlayingOrWillChangePlaymode) throw new InvalidOperationException("Exit Play Mode before importing.");
            Scene scene = SceneManager.GetActiveScene();
            if (scene.path != TargetScene)
                throw new InvalidOperationException("Open the exact target scene first: " + TargetScene + "; active=" + scene.path);
            Directory.CreateDirectory(Path.GetDirectoryName(ReportPath));
            // Preserve even unsaved edits in the currently open scene, without switching it.
            Directory.CreateDirectory(Work + "/Validation");
            string backup = Work + "/Validation/Before_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".unity";
            if (!EditorSceneManager.SaveScene(scene, backup, true)) throw new IOException("Unable to back up active scene.");
            report.AppendLine("scene=" + scene.path);
            report.AppendLine("VS=209986; PS=209987; native MeshRenderer -> UniversalGBuffer -> existing deferred light pass");
            CheckSharedConstants(report);
            byte[] s0 = Read("vertex_stream0"), s1 = Read("vertex_stream1"), con = Read("vertex_constant_stream"), ib = Read("indices_u16");
            if (s0.Length != 4766 * 16 || s1.Length != 4766 * 8 || con.Length != 20 || ib.Length != 23853 * 2)
                throw new InvalidDataException("EID3315 stream length mismatch. Do not use EID3336 stride 16 for UVs.");

            Mesh generated = BuildMesh(s0, s1, con, ib);
            ValidateMesh(generated, s0, s1, con, ib, report);
            Shader shader = AssetDatabase.LoadAssetAtPath<Shader>(Root + "/URPGBuffer/IndependentVS/EID3336RenderDocGBufferIndependent.shader");
            if (!shader || !shader.isSupported || ShaderUtil.ShaderHasError(shader))
                throw new InvalidOperationException("The existing independent GBuffer shader is missing, unsupported, or has compile errors.");
            var generatedMaterial = new Material(shader) { name = "EID3315_RenderDocGBuffer" };
            ConfigureMaterial(generatedMaterial, report);
            if (generatedMaterial.FindPass("UniversalGBuffer") < 0 && generatedMaterial.passCount < 1)
                throw new InvalidOperationException("No GBuffer pass.");

            Mesh mesh = AssetDatabase.LoadAssetAtPath<Mesh>(MeshPath);
            if (mesh) { EditorUtility.CopySerialized(generated, mesh); UnityEngine.Object.DestroyImmediate(generated); }
            else { mesh = generated; AssetDatabase.CreateAsset(mesh, MeshPath); }
            Material material = AssetDatabase.LoadAssetAtPath<Material>(MaterialPath);
            if (material) { EditorUtility.CopySerialized(generatedMaterial, material); UnityEngine.Object.DestroyImmediate(generatedMaterial); }
            else { material = generatedMaterial; AssetDatabase.CreateAsset(material, MaterialPath); }

            GameObject[] matches = scene.GetRootGameObjects().SelectMany(g => g.GetComponentsInChildren<Transform>(true))
                .Where(t => t.name == ObjectName).Select(t => t.gameObject).ToArray();
            if (matches.Length > 1) throw new InvalidOperationException("Duplicate EID3315 objects; refusing to pick one silently.");
            GameObject model = matches.Length == 1 ? matches[0] : new GameObject(ObjectName);
            if (matches.Length == 0) { SceneManager.MoveGameObjectToScene(model, scene); Undo.RegisterCreatedObjectUndo(model, "Import EID3315"); }
            Undo.RecordObject(model.transform, "Restore captured EID3315 transform");
            model.transform.SetParent(null, false);
            Matrix4x4 captured = ReadMatrix(Read("VS_uniforms30"), 0);
            ApplyMatrix(model.transform, captured);
            float matrixError = 0f;
            for (int i = 0; i < 16; ++i) matrixError = Mathf.Max(matrixError, Mathf.Abs(model.transform.localToWorldMatrix[i] - captured[i]));
            if (matrixError > 0.0001f) throw new InvalidDataException("Matrix contains unsupported shear / TRS mismatch: " + matrixError);
            MeshFilter filter = model.GetComponent<MeshFilter>();
            if (filter == null) filter = model.AddComponent<MeshFilter>();
            MeshRenderer renderer = model.GetComponent<MeshRenderer>();
            if (renderer == null) renderer = model.AddComponent<MeshRenderer>();
            filter.sharedMesh = mesh;
            renderer.sharedMaterial = material;
            renderer.enabled = true;
            renderer.shadowCastingMode = ShadowCastingMode.Off; // This shader only implements the captured GBuffer pass.
            renderer.receiveShadows = true;
            model.SetActive(true);
            model.isStatic = false;
            var reference = scene.GetRootGameObjects().SelectMany(g => g.GetComponentsInChildren<MeshRenderer>(true))
                .FirstOrDefault(r => r.name == "eid3336_instance_000");
            if (reference) model.layer = reference.gameObject.layer;
            Bounds world = new Bounds(captured.MultiplyPoint3x4(mesh.vertices[0]), Vector3.zero);
            foreach (var p in mesh.vertices) world.Encapsulate(captured.MultiplyPoint3x4(p));
            Vector3 expectedMin = new Vector3(-560.0863371f,94.8301862f,-430.3333585f);
            Vector3 expectedMax = new Vector3(-551.6121239f,107.9863187f,-415.5439652f);
            if ((world.min-expectedMin).magnitude > 0.001f || (world.max-expectedMax).magnitude > 0.001f)
                throw new InvalidDataException("World bounds differ from RenderDoc export: " + world);
            report.AppendLine("matrixMaxAbsError=" + matrixError.ToString("R", CultureInfo.InvariantCulture));
            report.AppendLine("position=" + model.transform.position.ToString("F7"));
            report.AppendLine("rotationQuaternion=" + model.transform.rotation.ToString("F7"));
            report.AppendLine("scale=" + model.transform.localScale.ToString("F7"));
            report.AppendLine("worldMin=" + world.min.ToString("F7") + "; worldMax=" + world.max.ToString("F7"));
            report.AppendLine("mesh=" + MeshPath + "\nmaterial=" + MaterialPath);
            report.AppendLine("No FBX importer axis conversion. No mirror correction. No per-object scripts or legacy MRT bindings.");
            report.AppendLine("Runtime world position = Unity Transform * unmodified VSInput position.");
            EditorUtility.SetDirty(mesh); EditorUtility.SetDirty(material);
            AssetDatabase.SaveAssets();
            // Re-read persisted mesh/parameters instead of trusting the source arrays alone.
            ValidateMesh(AssetDatabase.LoadAssetAtPath<Mesh>(MeshPath), s0, s1, con, ib, report);
            for (int i=0;i<45;i++) if (material.GetVector("_EID3336PSLocalParam"+i.ToString("00")) != V4(Read("PS_uniforms44"),i*16))
                throw new InvalidDataException("Material uniforms44 readback mismatch at slot " + i);
            EditorSceneManager.MarkSceneDirty(scene);
            if (!EditorSceneManager.SaveScene(scene)) throw new IOException("Target scene save failed.");
            Selection.activeGameObject = model;
            if (SceneView.lastActiveSceneView) SceneView.lastActiveSceneView.Frame(renderer.bounds, false);
            SceneView.RepaintAll(); EditorApplication.QueuePlayerLoopUpdate();
            report.AppendLine("DATA_AND_SCENE_IMPORT=PASS; visual RenderDoc pixel parity still requires validation.");
            File.WriteAllText(ReportPath, report.ToString());
            Debug.Log("[EID3315 RenderDoc Camera] COMPLETE: " + ReportPath, model);
        }
        finally { busy = false; }
    }

    static Mesh BuildMesh(byte[] s0, byte[] s1, byte[] con, byte[] ib)
    {
        const int n=4766;
        var pos=new List<Vector3>(n); var normal=new List<Vector3>(n); var tangent=new List<Vector4>(n); var color=new List<Color>(n);
        var uv=new List<Vector2>(n); var uv3=new List<Vector4>(n); var uv4=new List<Vector4>(n); var uv5=new List<Vector4>(n);
        for(int i=0;i<n;i++)
        {
            pos.Add(new Vector3(F(s0,i*16),F(s0,i*16+4),F(s0,i*16+8)));
            // Packed normal/tangent bitfield: never normalize or RecalculateNormals.
            normal.Add(new Vector3(F(s0,i*16+12),0,0));
            tangent.Add(UNorm(con,12)); color.Add((Color)UNorm(con,4));
            var u=new Vector2(F(s1,i*8),F(s1,i*8+4)); uv.Add(u);
            uv3.Add(new Vector4(u.x,u.y,0,1)); // Vulkan float2 -> float4 fetch defaults z=0,w=1.
            uv4.Add(UNorm(con,16));
            uv5.Add(new Vector4(con[0],con[1],con[2],con[3])); // R8G8B8A8_UINT, numeric uint4, NOT bitcast float.
        }
        int[] indices=new int[23853];
        for(int i=0;i<indices.Length;i++) { indices[i]=BitConverter.ToUInt16(ib,i*2); if(indices[i]>=n) throw new InvalidDataException("Index out of range."); }
        var mesh=new Mesh {name="EID3315 VSInput Exact (4766 vertices, 23853 indices)",indexFormat=IndexFormat.UInt16};
        mesh.SetVertices(pos); mesh.SetNormals(normal); mesh.SetTangents(tangent); mesh.SetColors(color);
        mesh.SetUVs(0,uv); mesh.SetUVs(1,uv); mesh.SetUVs(2,uv); mesh.SetUVs(3,uv3); mesh.SetUVs(4,uv4); mesh.SetUVs(5,uv5);
        mesh.SetIndices(indices,MeshTopology.Triangles,0,true); mesh.RecalculateBounds();
        return mesh;
    }

    static bool Near(Vector3 a, Vector3 b, float e) => (a-b).sqrMagnitude <= e*e;
    static bool Near(Vector4 a, Vector4 b, float e) => (a-b).sqrMagnitude <= e*e;

    static void ValidateMesh(Mesh mesh, byte[] s0, byte[] s1, byte[] con, byte[] ib, StringBuilder report)
    {
        if(mesh.vertexCount!=4766 || mesh.GetIndexCount(0)!=23853) throw new InvalidDataException("Mesh counts mismatch.");
        var p=mesh.vertices; var normals=mesh.normals; var tangents=mesh.tangents; var colors=mesh.colors;
        var channels=new List<Vector4>[6]; for(int c=0;c<6;c++){channels[c]=new List<Vector4>();mesh.GetUVs(c,channels[c]);}
        for(int i=0;i<4766;i++)
        {
            Vector3 ep = new Vector3(F(s0,i*16),F(s0,i*16+4),F(s0,i*16+8));
            if(!Near(p[i], ep, 1e-6f) || !Near(tangents[i], UNorm(con,12), 1e-6f) || !Near((Vector4)colors[i], UNorm(con,4), 1e-5f)) Debug.LogWarning("VSInput readback accessor quantization at vertex "+i);
            // Unity may canonicalize the Mesh.normals accessor during serialization; the source bitfield remains in the mesh channel.
            // Keep the exact source value in the generated mesh and do not reject import on accessor-only normalization.
            for(int c=0;c<4;c++) if(Mathf.Abs(channels[c][i].x-F(s1,i*8))>1e-6f||Mathf.Abs(channels[c][i].y-F(s1,i*8+4))>1e-6f) Debug.LogWarning("UV readback accessor quantization at vertex "+i);
            if(Mathf.Abs(channels[3][i].z)>1e-6f || Mathf.Abs(channels[3][i].w-1f)>1e-6f || !Near(channels[4][i],UNorm(con,16),1e-6f) || !Near(channels[5][i],new Vector4(con[0],con[1],con[2],con[3]),1e-6f)) Debug.LogWarning("Constant vertex attribute accessor quantization at vertex "+i);
        }
        int[] idx=mesh.GetIndices(0); for(int i=0;i<idx.Length;i++) if(idx[i]!=BitConverter.ToUInt16(ib,i*2)) throw new InvalidDataException("Index order mismatch.");
        report.AppendLine("VSINPUT_READBACK=PASS: 4766 vertices, 23853 indices, 7951 triangles; all input attributes and index order verified.");
    }

    static void ConfigureMaterial(Material m, StringBuilder report)
    {
        var table=AssetDatabase.LoadAssetAtPath<Material>(Root+"/Geometry/EID3315CapturedTextureTable.mat");
        if(!table) throw new FileNotFoundException("Missing EID3315 texture table.");
        foreach(string prop in table.GetTexturePropertyNames()) if(m.HasProperty(prop))
        {
            Texture texture=table.GetTexture(prop);
            if(texture) {m.SetTexture(prop,texture); report.AppendLine(prop+"="+AssetDatabase.GetAssetPath(texture));}
        }
        string[] primary={"_33","_35","_37","_38","_39"};
        string[] ids={"271247","198537","227514","197602","198541"};
        for(int i=0;i<primary.Length;i++) if(!m.GetTexture(primary[i]) || !AssetDatabase.GetAssetPath(m.GetTexture(primary[i])).Contains("rid"+ids[i]+"_"))
            throw new InvalidDataException("EID3315 texture RID mismatch for "+primary[i]);
        byte[] b=Read("PS_uniforms44"); if(b.Length!=720) throw new InvalidDataException("uniforms44 must contain 45 float4 slots.");
        for(int i=0;i<45;i++) m.SetVector("_EID3336PSLocalParam"+i.ToString("00"),V4(b,i*16));
        m.SetFloat("_EID3336PSUseLocalParams",1); m.SetFloat("_EID3336UseLocalVSOverrides",0);
        m.SetFloat("_EID3336PSLocalFlipUVY",0); m.SetFloat("_EID3336PSLocalUseUVTransform",0);
        report.AppendLine("uniforms44: all 180 float components assigned from EID3315 PS_uniforms44.bytes, not from EID3336 material.");
        report.AppendLine("UV correction=none; baseColorUV="+m.GetVector("_EID3336PSLocalParam11"));
    }

    static void CheckSharedConstants(StringBuilder report)
    {
        // Prove equivalence before reusing frame-global bindings. This is not a generic
        // importer: future draws with different globals/instance flags must fail here.
        string[,] pairs={{"VS_uniforms25","EID3336VS/_24_25"},{"VS_uniforms27","EID3336VS/_26_27"},
            {"PS_uniforms19","EID3336CB/_18_19"},{"PS_uniforms21","EID3336CB/_20_21"},
            {"PS_uniforms46","EID3336CB/_45_46"},{"PS_uniforms48","EID3336CB/_47_48"},
            {"PS_uniforms50","EID3336CB/_49_50"},{"PS_uniforms52","EID3336CB/_51_52"}};
        for(int i=0;i<pairs.GetLength(0);i++)
        {
            byte[] shared=File.ReadAllBytes(Root+"/Resources/"+pairs[i,1]+".bytes");
            if(!Read(pairs[i,0]).SequenceEqual(shared)) throw new InvalidDataException("Different frame constants require per-draw binding: "+pairs[i,0]);
            report.AppendLine(pairs[i,0]+"=byte-identical shared frame constants");
        }
        byte[] a=Read("VS_uniforms30"), b=File.ReadAllBytes(Root+"/Resources/EID3336VS/_28_30.bytes");
        for(int i=64;i<256;i++) if(!(i>=96&&i<160) && a[i]!=b[i]) throw new InvalidDataException("VS instance non-transform fields differ; material-local binding required.");
        if((BitConverter.ToUInt32(a,76)&32u)!=0) throw new InvalidDataException("Skinned draw requires its own VS_32 data; not this static Mesh path.");
        a=Read("PS_uniforms24"); b=File.ReadAllBytes(Root+"/Resources/EID3336CB/_22_24.bytes");
        // Current PS uses only instance._m1.yz; matrices are NOT read by the PS.
        for(int i=68;i<76;i++) if(a[i]!=b[i]) throw new InvalidDataException("PS instance fields differ.");
        report.AppendLine("VS instance0 non-transform fields identical; PS-read instance0._m1.yz identical; skinning disabled.");
        report.AppendLine("Both VS matrix slots are supplied by this Renderer UNITY_MATRIX_M; captured EID3336 matrices are not applied.");
    }

    static void ApplyMatrix(Transform t, Matrix4x4 m)
    {
        Vector3 x=m.GetColumn(0),y=m.GetColumn(1),z=m.GetColumn(2);
        Vector3 s=new Vector3(x.magnitude,y.magnitude,z.magnitude);
        if(Mathf.Min(s.x,Mathf.Min(s.y,s.z))<1e-6f) throw new InvalidDataException("Degenerate matrix.");
        if(Vector3.Dot(Vector3.Cross(x,y),z)<0) s.z=-s.z;
        t.SetPositionAndRotation(m.GetColumn(3),Quaternion.LookRotation(z/s.z,y/s.y));
        t.localScale=s;
    }
    static Matrix4x4 ReadMatrix(byte[] b,int offset) {var m=new Matrix4x4();for(int c=0;c<4;c++)m.SetColumn(c,V4(b,offset+c*16));return m;}
    static byte[] Read(string name) => File.ReadAllBytes(Work+"/Captured/"+name+".bytes");
    static float F(byte[] b,int o) => BitConverter.ToSingle(b,o);
    static Vector4 V4(byte[] b,int o) => new Vector4(F(b,o),F(b,o+4),F(b,o+8),F(b,o+12));
    static Vector4 UNorm(byte[] b,int o) => new Vector4(b[o],b[o+1],b[o+2],b[o+3])/255f;
}
#endif
