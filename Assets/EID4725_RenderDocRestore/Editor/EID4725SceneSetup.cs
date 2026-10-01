using System;
using System.IO;
using System.Linq;
using System.Text;
using System.Security.Cryptography;
using UnityEditor;
using UnityEditor.Rendering;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using EID4730;

public static class EID4725SceneSetup
{
    const string Root = "Assets/EID4725_RenderDocRestore";
    const string ScenePath = "Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
    const string MeshPath = Root + "/Geometry/EID4725_Mesh.asset";
    const string MaterialPath = Root + "/M_EID4725.mat";
    const string ReportPath = ".rdctools/eid4725_correct/unity_validation.txt";
    static readonly StringBuilder report = new StringBuilder();
    static void Require(bool condition, string message) { if (!condition) throw new InvalidDataException(message); report.AppendLine("PASS " + message); }
    static string Hash(byte[] b) { using (var s=SHA256.Create()) return BitConverter.ToString(s.ComputeHash(b)).Replace("-", "").ToLowerInvariant(); }
    static Matrix4x4 CapturedMatrix()
    {
        byte[] b=File.ReadAllBytes(Root+"/Captured/matrix.bytes"); var m=new Matrix4x4();
        for(int c=0;c<4;c++) for(int r=0;r<4;r++) m[r,c]=BitConverter.ToSingle(b,(c*4+r)*4);
        return m;
    }
    [MenuItem("Tools/EID4725/Apply Verified Restore")]
    public static void Apply()
    {
        report.Clear();
        try
        {
            Require(SystemInfo.graphicsDeviceType != GraphicsDeviceType.Null, "real graphics device: "+SystemInfo.graphicsDeviceType);
            AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
            Shader shader=AssetDatabase.LoadAssetAtPath<Shader>(Root+"/Shaders/EID4725_RenderDoc.shader");
            Require(shader != null, "shader found");
            var sub=ShaderUtil.GetShaderData(shader).ActiveSubshader;
            Require(sub != null && sub.PassCount==2,"two shader passes");
            for(int i=0;i<sub.PassCount;i++) foreach(var platform in new[]{ShaderCompilerPlatform.D3D,ShaderCompilerPlatform.Vulkan}) foreach(var stage in new[]{ShaderType.Vertex,ShaderType.Fragment})
            {
                var c=sub.GetPass(i).CompileVariant(stage,Array.Empty<string>(),platform,BuildTarget.StandaloneWindows64,false);
                if(c.Messages!=null)foreach(var msg in c.Messages)report.AppendLine(msg.severity+" "+msg.message+" "+msg.file+":"+msg.line);
                bool ok=c.Success && c.ShaderData!=null && c.ShaderData.Length>0;
                if(c.ShaderData!=null && c.ShaderData.Length>0)File.WriteAllBytes(".rdctools/eid4725_correct/compiled_"+i+"_"+platform+"_"+stage+".bin",c.ShaderData);
                if(platform==ShaderCompilerPlatform.D3D)Require(ok,"compile "+i+" "+platform+" "+stage+" bytes="+(c.ShaderData?.Length??0));
                else report.AppendLine("VULKAN_DIAGNOSTIC pass="+i+" stage="+stage+" success="+ok+" bytes="+(c.ShaderData?.Length??0)+"; validate with native Vulkan GPU separately");
            }
            Mesh mesh=BuildMesh();
            Material mat=AssetDatabase.LoadAssetAtPath<Material>(MaterialPath);
            if(mat==null){mat=new Material(shader);AssetDatabase.CreateAsset(mat,MaterialPath);} else mat.shader=shader;
            mat.renderQueue=2000; mat.enableInstancing=false;
            using(var session=new EID4725ReplaySession("Assets/StreamingAssets/EID4725Replay/replay.json",false))
            {
                foreach(var pair in session.TextureBindings)
                {
                    string path=Root+"/Textures/"+pair.Key+".asset";
                    var texture=AssetDatabase.LoadAssetAtPath<Texture>(path);
                    if(texture==null){texture=UnityEngine.Object.Instantiate(pair.Value);texture.hideFlags=HideFlags.None;AssetDatabase.CreateAsset(texture,path);}
                    else { EditorUtility.CopySerialized(pair.Value,texture); texture.hideFlags=HideFlags.None; EditorUtility.SetDirty(texture); }
                    mat.SetTexture(pair.Key,texture);
                }
                Require(session.TextureBindingCount==20 && session.BufferBindingCount==15,"20 textures / 15 buffers loaded and hash checked");
            }
            var source=AssetDatabase.LoadAssetAtPath<Material>("Assets/ColourPass6_VS215445_PS215446_Batch/Materials/EID1637_VS215445_PS215446.mat");
            Require(source!=null,"matched EID1637 GBuffer material");
            const string gp="_EID4725_GBuffer_";
            mat.SetTexture(gp+"Res27",source.GetTexture("_Res27"));
            for(int i=0;i<20;i++)mat.SetVector(gp+"P"+i.ToString("00"),source.GetVector("_P"+i.ToString("00")));
            mat.SetVector(gp+"InstancePacked",source.GetVector("_InstancePacked"));
            mat.SetFloat(gp+"EID215446MipBias",source.GetFloat("_EID215446MipBias"));mat.SetFloat(gp+"UseBakedSkinning",0);
            EditorUtility.SetDirty(mat);AssetDatabase.SaveAssets();
            var scene=EditorSceneManager.OpenScene(ScenePath,OpenSceneMode.Single);
            var existing=scene.GetRootGameObjects().Where(g=>g.name=="EID4725_RenderDocRestore").ToArray();
            foreach(var g in existing)UnityEngine.Object.DestroyImmediate(g);
            var root=new GameObject("EID4725_RenderDocRestore");var obj=new GameObject("EID4725_instance_000");obj.transform.SetParent(root.transform,false);
            var m=CapturedMatrix(); obj.transform.localPosition=m.GetColumn(3);
            obj.transform.localRotation=Quaternion.LookRotation(m.GetColumn(2),m.GetColumn(1));
            obj.transform.localScale=new Vector3(((Vector3)m.GetColumn(0)).magnitude,((Vector3)m.GetColumn(1)).magnitude,((Vector3)m.GetColumn(2)).magnitude);
            float max=0;for(int r=0;r<4;r++)for(int c=0;c<4;c++)max=Mathf.Max(max,Mathf.Abs(obj.transform.localToWorldMatrix[r,c]-m[r,c]));
            Require(max<0.000001f,"single-M Transform reconstruction max error="+max);
            obj.AddComponent<MeshFilter>().sharedMesh=mesh;var renderer=obj.AddComponent<MeshRenderer>();renderer.sharedMaterial=mat;
            renderer.shadowCastingMode=ShadowCastingMode.Off;renderer.receiveShadows=false;
            var binder=obj.AddComponent<EID4725ReplayBinder>();binder.material=mat;binder.Rebind();
            var data=AssetDatabase.LoadAssetAtPath<UniversalRendererData>("Assets/EID3332_EID3336_Combined/Settings/EID3332Combined-Renderer.asset");
            Require(data!=null,"renderer data found");bool found=false;
            foreach(var f in data.rendererFeatures)if(f!=null&&f.GetType().Name=="EID4730RenderFeature")
            {var so=new SerializedObject(f);so.FindProperty("enableEID4725CharacterForward").boolValue=true;so.FindProperty("renderEID4725InSceneView").boolValue=true;so.ApplyModifiedPropertiesWithoutUndo();f.SetActive(true);EditorUtility.SetDirty(f);found=true;}
            Require(found,"EID4725 enabled inside EID4730 RenderFeature");
            EditorSceneManager.MarkSceneDirty(scene);Require(EditorSceneManager.SaveScene(scene),"scene saved");AssetDatabase.SaveAssets();
            VerifyMesh(AssetDatabase.LoadAssetAtPath<Mesh>(MeshPath));
            report.AppendLine("SCENE="+ScenePath);report.AppendLine("Visual/pixel comparison: NOT YET VERIFIED. Secondary forward MRT allocated in EID4730 feature; scene execution validation pending.");
            report.AppendLine("RESULT=PASS");File.WriteAllText(ReportPath,report.ToString());Debug.Log(report.ToString());
        }
        catch(Exception e){report.AppendLine(e.ToString());report.AppendLine("RESULT=FAIL");File.WriteAllText(ReportPath,report.ToString());Debug.LogError(report.ToString());if(Application.isBatchMode)EditorApplication.Exit(1);throw;}
    }
    static Mesh BuildMesh()
    {
        byte[] vertices=File.ReadAllBytes(Root+"/Captured/vertices.bytes"),indices=File.ReadAllBytes(Root+"/Captured/indices.bytes");
        Require(Hash(vertices)=="1a15b7c5c5a2c19fdbbe07ace711d5ced0cb1c4ff13301ae6494968231220f3a","1701 captured vertices SHA256");
        Require(Hash(indices)=="eb9d42aa449efcfe909042723669c65bc73930bde0479f2ff9dc9943635957d2","8460 captured indices SHA256");
        var mesh=AssetDatabase.LoadAssetAtPath<Mesh>(MeshPath);bool created=mesh==null;if(created)mesh=new Mesh();else mesh.Clear();
        mesh.name="EID4725 VS215989 exact 1701 vertices 8460 indices";
        mesh.SetVertexBufferParams(1701,
          new VertexAttributeDescriptor(VertexAttribute.Position,VertexAttributeFormat.Float32,3),
          new VertexAttributeDescriptor(VertexAttribute.Normal,VertexAttributeFormat.Float32,3),
          new VertexAttributeDescriptor(VertexAttribute.Tangent,VertexAttributeFormat.Float32,4),
          new VertexAttributeDescriptor(VertexAttribute.TexCoord0,VertexAttributeFormat.Float32,2),
          new VertexAttributeDescriptor(VertexAttribute.TexCoord1,VertexAttributeFormat.Float32,3),
          new VertexAttributeDescriptor(VertexAttribute.TexCoord2,VertexAttributeFormat.Float32,3),
          new VertexAttributeDescriptor(VertexAttribute.TexCoord3,VertexAttributeFormat.Float32,3),
          new VertexAttributeDescriptor(VertexAttribute.TexCoord4,VertexAttributeFormat.Float32,4),
          new VertexAttributeDescriptor(VertexAttribute.TexCoord5,VertexAttributeFormat.UInt32,4));
        Require(mesh.GetVertexBufferStride(0)==116,"native vertex stride116 / joints UInt32");
        mesh.SetVertexBufferData(vertices,0,0,vertices.Length);mesh.SetIndexBufferParams(8460,IndexFormat.UInt16);mesh.SetIndexBufferData(indices,0,0,indices.Length);
        mesh.subMeshCount=1;mesh.SetSubMesh(0,new SubMeshDescriptor(0,8460,MeshTopology.Triangles));mesh.RecalculateBounds();
        if(created)AssetDatabase.CreateAsset(mesh,MeshPath);else EditorUtility.SetDirty(mesh);
        VerifyMesh(mesh);return mesh;
    }
    static void VerifyMesh(Mesh mesh)
    {
        Require(mesh.vertexCount==1701 && mesh.GetIndexCount(0)==8460,"native mesh counts");
        using(var d=Mesh.AcquireReadOnlyMeshData(mesh))
        {
            Require(Hash(d[0].GetVertexData<byte>(0).ToArray())=="1a15b7c5c5a2c19fdbbe07ace711d5ced0cb1c4ff13301ae6494968231220f3a","native mesh vertex bytes exactly match capture");
            Require(Hash(d[0].GetIndexData<byte>().ToArray())=="eb9d42aa449efcfe909042723669c65bc73930bde0479f2ff9dc9943635957d2","native mesh index bytes exactly match capture");
        }
    }
}
