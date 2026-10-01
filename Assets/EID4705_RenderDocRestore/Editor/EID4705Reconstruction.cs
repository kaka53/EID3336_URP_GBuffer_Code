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

public static class EID4705Reconstruction
{
    const string Root = "Assets/EID4705_RenderDocRestore";
    const string ScenePath = "Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
    const string MeshPath = Root + "/EID4705_Mesh.asset";
    const string MaterialPath = Root + "/M_EID4705.mat";
    const string ReportPath = ".rdctools/eid4705_verified/unity_validation.txt";
    static readonly StringBuilder report = new StringBuilder();
    static void Require(bool condition, string message) { if (!condition) throw new InvalidDataException(message); report.AppendLine("PASS " + message); }
    static string Hash(byte[] b) { using (var s=SHA256.Create()) return BitConverter.ToString(s.ComputeHash(b)).Replace("-", "").ToLowerInvariant(); }
    static Matrix4x4 CapturedMatrix()
    {
        byte[] b=File.ReadAllBytes(Root+"/Captured/Verified/matrix.bytes"); var m=new Matrix4x4();
        for(int c=0;c<4;c++) for(int r=0;r<4;r++) m[r,c]=BitConverter.ToSingle(b,(c*4+r)*4);
        return m;
    }
    [MenuItem("Tools/EID4705/Apply Verified Restore")]
    public static void Build()
    {
        report.Clear();
        try
        {
            Require(SystemInfo.graphicsDeviceType != GraphicsDeviceType.Null, "real graphics device: "+SystemInfo.graphicsDeviceType);
            AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
            Shader shader=AssetDatabase.LoadAssetAtPath<Shader>(Root+"/Shaders/EID4705_CharacterForward.shader");
            Require(shader != null, "shader found");
            var sub=ShaderUtil.GetShaderData(shader).ActiveSubshader;
            Require(sub != null && sub.PassCount==1,"one shader pass");
            for(int i=0;i<sub.PassCount;i++) foreach(var platform in new[]{ShaderCompilerPlatform.D3D,ShaderCompilerPlatform.Vulkan}) foreach(var stage in new[]{ShaderType.Vertex,ShaderType.Fragment})
            {
                var c=sub.GetPass(i).CompileVariant(stage,Array.Empty<string>(),platform,BuildTarget.StandaloneWindows64,false);
                if(c.Messages!=null)foreach(var msg in c.Messages)report.AppendLine(msg.severity+" "+msg.message+" "+msg.file+":"+msg.line);
                bool ok=c.Success && c.ShaderData!=null && c.ShaderData.Length>0;
                if(c.ShaderData!=null && c.ShaderData.Length>0)File.WriteAllBytes(".rdctools/eid4705_verified/compiled_"+i+"_"+platform+"_"+stage+".bin",c.ShaderData);
                if(platform==ShaderCompilerPlatform.D3D)Require(ok,"compile "+i+" "+platform+" "+stage+" bytes="+(c.ShaderData?.Length??0));
                else report.AppendLine("VULKAN_DIAGNOSTIC pass="+i+" stage="+stage+" success="+ok+" bytes="+(c.ShaderData?.Length??0)+"; validate with native Vulkan GPU separately");
            }
            Mesh mesh=BuildMesh();
            Material mat=AssetDatabase.LoadAssetAtPath<Material>(MaterialPath);
            if(mat==null){mat=new Material(shader);AssetDatabase.CreateAsset(mat,MaterialPath);} else mat.shader=shader;
            mat.renderQueue=2000; mat.enableInstancing=false;
            using(var session=new EID4705ReplaySession("Assets/StreamingAssets/EID4705Replay/replay.json",false))
            {
                foreach(var pair in session.TextureBindings)
                {
                    string path=Root+"/Textures/"+pair.Key+".asset";
                    var texture=AssetDatabase.LoadAssetAtPath<Texture>(path);
                    if(texture==null){texture=UnityEngine.Object.Instantiate(pair.Value);texture.hideFlags=HideFlags.None;AssetDatabase.CreateAsset(texture,path);}
                    else { EditorUtility.CopySerialized(pair.Value,texture); texture.hideFlags=HideFlags.None; EditorUtility.SetDirty(texture); }
                    mat.SetTexture(pair.Key,texture);
                }
                Require(session.TextureBindingCount==16 && session.BufferBindingCount==15, "16 textures / 15 buffers loaded and hash checked");
            }
            EditorUtility.SetDirty(mat);AssetDatabase.SaveAssets();
            var scene=EditorSceneManager.OpenScene(ScenePath,OpenSceneMode.Single);
            var existing=scene.GetRootGameObjects().Where(g=>g.name=="EID4705_RenderDocRestore").ToArray();
            foreach(var g in existing)UnityEngine.Object.DestroyImmediate(g);
            var root=new GameObject("EID4705_RenderDocRestore");var obj=new GameObject("EID4705_instance_000");obj.transform.SetParent(root.transform,false);
            var m=CapturedMatrix(); obj.transform.localPosition=m.GetColumn(3);
            obj.transform.localRotation=Quaternion.LookRotation(m.GetColumn(2),m.GetColumn(1));
            obj.transform.localScale=new Vector3(((Vector3)m.GetColumn(0)).magnitude,((Vector3)m.GetColumn(1)).magnitude,((Vector3)m.GetColumn(2)).magnitude);
            float max=0;for(int r=0;r<4;r++)for(int c=0;c<4;c++)max=Mathf.Max(max,Mathf.Abs(obj.transform.localToWorldMatrix[r,c]-m[r,c]));
            Require(max<0.000001f,"single-M Transform reconstruction max error="+max);
            obj.AddComponent<MeshFilter>().sharedMesh=mesh;var renderer=obj.AddComponent<MeshRenderer>();renderer.sharedMaterial=mat;
            renderer.shadowCastingMode=ShadowCastingMode.Off;renderer.receiveShadows=false;
            var binder=obj.AddComponent<EID4705ReplayBinder>();binder.material=mat;binder.Rebind();
            var data=AssetDatabase.LoadAssetAtPath<UniversalRendererData>("Assets/EID3332_EID3336_Combined/Settings/EID3332Combined-Renderer.asset");
            Require(data!=null,"renderer data found");bool found=false;
            foreach(var f in data.rendererFeatures)if(f!=null&&f.GetType().Name=="EID4730RenderFeature")
            {var so=new SerializedObject(f);so.FindProperty("enableEID4705CharacterForward").boolValue=true;so.FindProperty("renderEID4705InSceneView").boolValue=true;so.ApplyModifiedPropertiesWithoutUndo();f.SetActive(true);EditorUtility.SetDirty(f);found=true;}
            Require(found,"EID4705 enabled inside EID4730 RenderFeature");
            var source=AssetDatabase.LoadAssetAtPath<Material>("Assets/ColourPass6_VS215441_PS215442_Batch/Materials/EID1622_VS215441_PS215442.mat");
            Require(source!=null,"matched EID1622 GBuffer material");
            source.SetShaderPassEnabled("VS215999_PS216000_EID4730CharacterForward", false);
            EditorUtility.SetDirty(source);
            EditorSceneManager.MarkSceneDirty(scene);Require(EditorSceneManager.SaveScene(scene),"scene saved");AssetDatabase.SaveAssets();
            VerifyMesh(AssetDatabase.LoadAssetAtPath<Mesh>(MeshPath));
            report.AppendLine("SCENE="+ScenePath);report.AppendLine("Visual/pixel comparison: NOT YET VERIFIED. Secondary forward MRT allocated in EID4730 feature; scene execution validation pending.");
            report.AppendLine("RESULT=PASS");File.WriteAllText(ReportPath,report.ToString());Debug.Log(report.ToString());
        }
        catch(Exception e){report.AppendLine(e.ToString());report.AppendLine("RESULT=FAIL");File.WriteAllText(ReportPath,report.ToString());Debug.LogError(report.ToString());if(Application.isBatchMode)EditorApplication.Exit(1);throw;}
    }
    static readonly string[] StreamHashes = { "3bc1a2fc17cc0699e5131e18b3d330d59914a80a12cb66821c46f708e5889738", "b4aa96012f18d01d9d2d92a659d17ec56a86d7ea09a85f76c7368164d08c085e", "720f0a2bdacf8f48b01011b0bad41c4e0e33d04740fe18d83720a3a2ee6a5cf7" };
    const string IndexHash="0337333b81f66b29bcafa87b745fca4744a24c180661fa42f8563bd2ea48c886";
    static Mesh BuildMesh()
    {
        var mesh=AssetDatabase.LoadAssetAtPath<Mesh>(MeshPath);bool create=mesh==null;if(create)mesh=new Mesh();else mesh.Clear();
        mesh.name="EID4705 VS215981 1158 vertices 5922 indices verified";
        mesh.SetVertexBufferParams(1158,
            new VertexAttributeDescriptor(VertexAttribute.Position,VertexAttributeFormat.Float32,3,0),
            new VertexAttributeDescriptor(VertexAttribute.Normal,VertexAttributeFormat.Float32,3,0),
            new VertexAttributeDescriptor(VertexAttribute.Tangent,VertexAttributeFormat.Float32,4,0),
            new VertexAttributeDescriptor(VertexAttribute.Color,VertexAttributeFormat.UNorm8,4,1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord0,VertexAttributeFormat.Float32,2,1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord1,VertexAttributeFormat.Float32,1,1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord2,VertexAttributeFormat.Float32,2,1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord3,VertexAttributeFormat.Float32,1,1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord4,VertexAttributeFormat.Float32,3,1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord5,VertexAttributeFormat.Float32,3,1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord6,VertexAttributeFormat.UNorm16,4,2),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord7,VertexAttributeFormat.UInt8,4,2));
        int[] strides={40,52,12};
        for(int i=0;i<3;i++)
        {
            byte[] b=File.ReadAllBytes(Root+"/Captured/Verified/native_stream"+i+".bytes");
            Require(Hash(b)==StreamHashes[i],"verified stream"+i+" SHA256");Require(mesh.GetVertexBufferStride(i)==strides[i],"stride"+i+"="+strides[i]);
            mesh.SetVertexBufferData(b,0,0,b.Length,i);
        }
        byte[] ix=File.ReadAllBytes(Root+"/Captured/Verified/indices.bytes");Require(Hash(ix)==IndexHash,"original index hash");
        mesh.SetIndexBufferParams(5922,IndexFormat.UInt16);mesh.SetIndexBufferData(ix,0,0,ix.Length);mesh.subMeshCount=1;mesh.SetSubMesh(0,new SubMeshDescriptor(0,5922,MeshTopology.Triangles));mesh.RecalculateBounds();
        if(create)AssetDatabase.CreateAsset(mesh,MeshPath);else EditorUtility.SetDirty(mesh);VerifyMesh(mesh);return mesh;
    }
    static void VerifyMesh(Mesh mesh)
    {
        Require(mesh.vertexCount==1158 && mesh.GetIndexCount(0)==5922,"native mesh counts1158/5922");
        using(var d=Mesh.AcquireReadOnlyMeshData(mesh))
        {
            for(int i=0;i<3;i++)Require(Hash(d[0].GetVertexData<byte>(i).ToArray())==StreamHashes[i],"native mesh full stream"+i+" bytes match verified source");
            Require(Hash(d[0].GetIndexData<byte>().ToArray())==IndexHash,"native mesh index bytes exact capture match");
        }
    }
}
