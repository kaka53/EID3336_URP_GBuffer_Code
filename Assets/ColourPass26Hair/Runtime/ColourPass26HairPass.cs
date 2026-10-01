using System;
using System.IO;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using UnityEngine.Experimental.Rendering;

namespace EID4730
{
    // Capture-specific hair supplement. Does not replace or mutate source renderers/materials.
    public sealed class ColourPass26HairPass : ScriptableRenderPass, IDisposable
    {
        [System.Runtime.InteropServices.StructLayout(System.Runtime.InteropServices.LayoutKind.Sequential)]
        struct Word16 { public uint x,y,z,w; }
        [Serializable] public class Manifest { public Draw[] draws; public Tex[] textures; public Geometry[] geometry; }
        [Serializable] public class Geometry {public int vertexCount,indexCount;public string positionFile,attributeFile,skinFile,defaultColorFile;}
        [Serializable] public class Draw { public int eid; public Stage[] stages; }
        [Serializable] public class Stage { public string stage; public Buf[] buffers; public TexRef[] textures; }
        [Serializable] public class Buf { public string shaderName, kind, file; }
        [Serializable] public class TexRef { public string shaderName; public int id; }
        [Serializable] public class Tex { public int id,width,height,depth,dimension,slices,mips; public string format; public Sub[] files; }
        [Serializable] public class Sub { public int mip,slice; public string file; }
        public static bool DiagnosticDisable;
        public static bool DiagnosticAlways;
        public static int LastDrawCount;
        public static Action<CommandBuffer,RTHandle,int,bool> Capture;
        public static Action<CommandBuffer,RTHandle,int> CaptureDepth;
        readonly List<UnityEngine.Object> owned = new List<UnityEngine.Object>();
        readonly Dictionary<string,ComputeBuffer> buffers = new Dictionary<string,ComputeBuffer>();
        readonly Dictionary<int,Texture> textures = new Dictionary<int,Texture>();
        readonly Dictionary<Mesh,Mesh> meshes = new Dictionary<Mesh,Mesh>();
        Material[] materials;
        Manifest manifest;
        readonly Shader frontShader,backShader;
        RTHandle color,depth,aux;
        bool failed;
        readonly Func<RTHandle> sharedAuxiliary;
        string Root => Path.Combine(Application.streamingAssetsPath,"ColourPass26Hair");
        T Own<T>(T x) where T:UnityEngine.Object {x.hideFlags=HideFlags.HideAndDontSave;owned.Add(x);return x;}
        public ColourPass26HairPass(Func<RTHandle> shared = null,Shader front=null,Shader back=null) { sharedAuxiliary=shared;frontShader=front;backShader=back;renderPassEvent=RenderPassEvent.BeforeRenderingTransparents;}
        public void SetTargets(RTHandle c,RTHandle d) {color=c;depth=d;}
        public override void OnCameraSetup(CommandBuffer cmd,ref RenderingData data)
        {
            if (color==null || depth==null) return;
            ConfigureTarget(color,depth);
            ConfigureClear(ClearFlag.None,Color.clear);
            if (DiagnosticDisable) return;
            var desc=data.cameraData.cameraTargetDescriptor;desc.depthBufferBits=0;desc.msaaSamples=1;
            desc.graphicsFormat=GraphicsFormat.A2B10G10R10_UNormPack32;
            RenderingUtils.ReAllocateIfNeeded(ref aux,desc,FilterMode.Point,TextureWrapMode.Clamp,name:"CP26Hair Auxiliary");
        }
        byte[] Read(string file) => File.ReadAllBytes(Path.Combine(Root,file));
        static byte[] Expand(byte[] bytes)
        {
            var result=new byte[bytes.Length*4];
            for(int i=0;i<bytes.Length/4;i++) {
                uint v=BitConverter.ToUInt32(bytes,i*4);
                for(int c=0;c<4;c++) {
                    float f=1;
                    if(c<3) {int bits=c==2?5:6;uint x=(v>>(c==0?0:c==1?11:22))&((1u<<(bits+5))-1);int e=(int)(x>>bits);uint m=x&((1u<<bits)-1);f=e==0?(float)(m*Math.Pow(2,-14-bits)):(float)((1+m/(double)(1<<bits))*Math.Pow(2,e-15));}
                    Buffer.BlockCopy(BitConverter.GetBytes(f),0,result,i*16+c*4,4);
                }
            }
            return result;
        }
        Texture Load(Tex t)
        {
            if(textures.TryGetValue(t.id,out var cached))return cached;
            GraphicsFormat f;
            switch(t.format) {
                case "BC7_UNORM":f=GraphicsFormat.RGBA_BC7_UNorm;break;
                case "BC7_SRGB":f=GraphicsFormat.RGBA_BC7_SRGB;break;
                case "D16":f=GraphicsFormat.R16_UNorm;break;
                case "R8G8B8A8_SRGB":f=GraphicsFormat.R8G8B8A8_SRGB;break;
                case "R8G8B8A8_UNORM":f=GraphicsFormat.R8G8B8A8_UNorm;break;
                case "R16G16B16A16_FLOAT":f=GraphicsFormat.R16G16B16A16_SFloat;break;
                case "R11G11B10_FLOAT":f=GraphicsFormat.R32G32B32A32_SFloat;break;
                default:throw new NotSupportedException(t.format);
            }
            if(t.slices!=1)throw new NotSupportedException("Unexpected hair texture array");
            var flags=t.mips>1?TextureCreationFlags.MipChain:TextureCreationFlags.None;
            Texture x=t.dimension==3?(Texture)Own(new Texture3D(t.width,t.height,t.depth,f,flags,t.mips)):Own(new Texture2D(t.width,t.height,f,t.mips,flags));
            foreach(var sub in t.files) {
                byte[] bytes=Read(sub.file);if(t.format=="R11G11B10_FLOAT")bytes=Expand(bytes);
                if(x is Texture3D v)v.SetPixelData(bytes,sub.mip);else ((Texture2D)x).SetPixelData(bytes,sub.mip);
            }
            if(x is Texture3D vol)vol.Apply(false,true);else ((Texture2D)x).Apply(false,true);
            x.name="CP26 RID"+t.id;x.filterMode=FilterMode.Bilinear;x.wrapMode=TextureWrapMode.Clamp;textures.Add(t.id,x);return x;
        }
        void Initialize()
        {
            if(materials!=null)return;
            manifest=JsonUtility.FromJson<Manifest>(File.ReadAllText(Path.Combine(Root,"manifest.json")));
            var result=new Material[manifest.draws.Length];
            for(int i=0;i<result.Length;i++) {
                var d=manifest.draws[i];var shader=i%2==0?frontShader:backShader;
                if(shader==null)shader=Shader.Find("Hidden/ColourPass26Hair/"+(i%2==0?"Front":"Back"));
                if(shader==null||!shader.isSupported)throw new Exception("CP26 hair shader missing/unsupported");
                var mat=Own(new Material(shader));mat.name="CP26 EID"+d.eid;
                foreach(var s in d.stages) {
                    foreach(var b in s.buffers) {
                        // Vulkan storage buffers are reflected as read-write resources even for HLSL ByteAddressBuffer.
                        // Bind captured data, not dummy zeros: light-list and transform paths can access these buffers.
                        if(b.kind=="storage") {
                            if(!buffers.TryGetValue(b.file,out var raw)) {var bytes=Read(b.file);if(bytes.Length%4!=0)throw new Exception("Unaligned storage buffer");var words=new uint[bytes.Length/4];Buffer.BlockCopy(bytes,0,words,0,bytes.Length);raw=new ComputeBuffer(words.Length,4,ComputeBufferType.Raw);raw.SetData(words);buffers.Add(b.file,raw);}
                            mat.SetBuffer(b.shaderName,raw);continue;
                        }
                        if(!buffers.TryGetValue(b.file,out var cb)) {byte[] bytes=Read(b.file);var words=new Word16[bytes.Length/16];for(int k=0;k<words.Length;k++)words[k]=new Word16{x=BitConverter.ToUInt32(bytes,k*16),y=BitConverter.ToUInt32(bytes,k*16+4),z=BitConverter.ToUInt32(bytes,k*16+8),w=BitConverter.ToUInt32(bytes,k*16+12)};cb=new ComputeBuffer(words.Length,16,ComputeBufferType.Constant);cb.SetData(words);buffers.Add(b.file,cb);}
                        mat.SetConstantBuffer(b.shaderName,cb,0,(int)new FileInfo(Path.Combine(Root,b.file)).Length);
                    }
                    foreach(var t in s.textures)mat.SetTexture(t.shaderName,Load(Array.Find(manifest.textures,v=>v.id==t.id)));
                }
                result[i]=mat;
            }
            materials=result;
        }
        // Shader reimport can invalidate native material bindings without destroying this pass.
        // Replay captured bindings for each draw rather than relying on Initialize() side effects.
        void BindDrawResources(CommandBuffer cmd,int index)
        {
            var mat=materials[index];
            foreach(var stage in manifest.draws[index].stages) {
                foreach(var binding in stage.buffers) {
                    var buffer=buffers[binding.file];
                    if(binding.kind=="storage") {
                        mat.SetBuffer(binding.shaderName,buffer);
                        cmd.SetGlobalBuffer(Shader.PropertyToID(binding.shaderName),buffer);
                    } else {
                        int size=buffer.count*buffer.stride;
                        mat.SetConstantBuffer(binding.shaderName,buffer,0,size);
                        cmd.SetGlobalConstantBuffer(buffer,Shader.PropertyToID(binding.shaderName),0,size);
                    }
                }
                foreach(var texture in stage.textures) {
                    var value=textures[texture.id];
                    mat.SetTexture(texture.shaderName,value);
                    cmd.SetGlobalTexture(Shader.PropertyToID(texture.shaderName),value);
                }
            }
        }
        Mesh Canonical(Mesh source)
        {
            if(meshes.TryGetValue(source,out var m))return m;
            // Source GBuffer meshes contain baked positions, and baked normals/tangents in UV4/5.
            var normals=new List<Vector3>();var tangents=new List<Vector4>();source.GetUVs(4,normals);source.GetUVs(5,tangents);
            if(normals.Count!=source.vertexCount||tangents.Count!=source.vertexCount)throw new Exception("CP26 source lacks captured baked basis: "+source.name);
            m=Own(new Mesh());m.name=source.name+" CP26 canonical";m.indexFormat=source.indexFormat;
            m.vertices=source.vertices;m.SetNormals(normals);m.SetTangents(tangents);
            var geometry=Array.Find(manifest.geometry,g=>g.vertexCount==source.vertexCount && g.indexCount==source.GetIndexCount(0));
            if(geometry==null)throw new Exception("No captured vertex streams for "+source.name);
            var positions=Read(geometry.positionFile);var attributes=Read(geometry.attributeFile);var skin=Read(geometry.skinFile);var defaults=Read(geometry.defaultColorFile);
            var raw=new List<Vector3>();var packed=new List<Vector3>();var direction=new List<Vector4>();var uv=new List<Vector2>();var weights=new List<Vector4>();var previousPacked=new List<Vector4>();var bones=new BoneWeight[source.vertexCount];var colors=new Color32[source.vertexCount];
            for(int i=0;i<source.vertexCount;i++) {
                int p=i*16,a=i*12;raw.Add(new Vector3(BitConverter.ToSingle(positions,p),BitConverter.ToSingle(positions,p+4),BitConverter.ToSingle(positions,p+8)));
                float packedValue=BitConverter.ToSingle(positions,p+12);packed.Add(new Vector3(packedValue,0,0));previousPacked.Add(new Vector4(packedValue,0,0,1));
                uv.Add(new Vector2(BitConverter.ToSingle(attributes,a),BitConverter.ToSingle(attributes,a+4)));
                direction.Add(new Vector4(Mathf.Max(-1,(sbyte)attributes[a+8]/127f),Mathf.Max(-1,(sbyte)attributes[a+9]/127f),Mathf.Max(-1,(sbyte)attributes[a+10]/127f),Mathf.Max(-1,(sbyte)attributes[a+11]/127f)));
                var w=new Vector4(BitConverter.ToUInt16(skin,a)/65535f,BitConverter.ToUInt16(skin,a+2)/65535f,BitConverter.ToUInt16(skin,a+4)/65535f,BitConverter.ToUInt16(skin,a+6)/65535f);weights.Add(w);
                bones[i]=new BoneWeight{weight0=w.x,weight1=w.y,weight2=w.z,weight3=w.w,boneIndex0=skin[a+8],boneIndex1=skin[a+9],boneIndex2=skin[a+10],boneIndex3=skin[a+11]};
                colors[i]=new Color32(defaults[12],defaults[13],defaults[14],defaults[15]);
            }
            m.SetUVs(0,uv);m.SetUVs(1,packed);m.SetUVs(2,packed);m.SetUVs(3,previousPacked);m.SetUVs(4,direction);m.SetUVs(5,raw);m.SetUVs(6,raw);m.SetUVs(7,weights);m.colors32=colors;m.boneWeights=bones;
            m.SetIndices(source.GetIndices(0),MeshTopology.Triangles,0);m.bounds=source.bounds;meshes.Add(source,m);return m;
        }
        public override void Execute(ScriptableRenderContext context,ref RenderingData data)
        {
            LastDrawCount=0;if(DiagnosticDisable||failed||color==null||depth==null||aux==null)return;
            var cmd=CommandBufferPool.Get("ColourPass26 Hair transparency");
            try {
                var camera=data.cameraData.camera;var sources=new Renderer[2];
                foreach(var r in UnityEngine.Object.FindObjectsOfType<MeshRenderer>()) {
                    int index=r.name=="EID1717_instance_000"?0:r.name=="EID1721_instance_000"?1:-1;
                    if(index<0||!r.enabled||!r.gameObject.activeInHierarchy||(camera.cullingMask&(1<<r.gameObject.layer))==0)continue;
                    if(sources[index]!=null)throw new Exception("Ambiguous CP26 source "+r.name);sources[index]=r;
                }
                if(sources[0]==null&&sources[1]==null)return;
                Initialize();
                var auxiliary=sharedAuxiliary?.Invoke() ?? aux;
                if (auxiliary==aux) {cmd.SetRenderTarget(aux);cmd.ClearRenderTarget(false,true,Color.clear);}
                cmd.SetRenderTarget(new RenderTargetIdentifier[]{color.nameID,auxiliary.nameID},depth.nameID);
                // Match the active URP camera target orientation (GameView and explicit RTs differ).
                var view=data.cameraData.GetViewMatrix();var proj=data.cameraData.GetGPUProjectionMatrix();
                cmd.SetGlobalMatrix("_CP26BLiveVP",proj*view);cmd.SetGlobalMatrix("_CP26BLiveP",proj);cmd.SetGlobalMatrix("_CP26BLiveView",view);
                var desc=data.cameraData.cameraTargetDescriptor;cmd.SetGlobalVector("_CP26BLiveScreen",new Vector4(desc.width,desc.height,1f/desc.width,1f/desc.height));
                for(int i=0;i<4;i++) {
                    var r=sources[i/2];if(r==null)continue;var source=r.GetComponent<MeshFilter>().sharedMesh;
                    int expected=i<2?32772:45003;if(source==null||source.GetIndexCount(0)!=(uint)expected)throw new Exception("CP26 source topology mismatch");
                    BindDrawResources(cmd,i);
                    materials[i].SetMatrix("_CP26ObjectToWorld",r.localToWorldMatrix);
                    materials[i].SetMatrix("_CP26ObjectToClip",proj*view*r.localToWorldMatrix);
                    materials[i].SetFloat("_CP26ZTest",DiagnosticAlways ? 8 : 2);
                    // Scene depth was produced by baked GBuffer geometry and its two-stage world/VP transform.
                    // Match that rasterization exactly; captured clip remains available to isolated reference audits.
                    materials[i].SetFloat("_CP26UseCapturedProjection",0);
                    materials[i].SetFloat("_CP26UseSceneDepthGeometry",1);
                    materials[i].SetMatrix("_CP26SceneVP",proj*view);
                    CaptureDepth?.Invoke(cmd,depth,manifest.draws[i].eid);
                    // Diagnostic readback may switch attachments; restore the actual draw destination.
                    cmd.SetRenderTarget(new RenderTargetIdentifier[]{color.nameID,auxiliary.nameID},depth.nameID);
                    Capture?.Invoke(cmd,color,manifest.draws[i].eid,false);
                    cmd.SetRenderTarget(new RenderTargetIdentifier[]{color.nameID,auxiliary.nameID},depth.nameID);
                    cmd.BeginSample("EID"+manifest.draws[i].eid+" Hair Alpha");cmd.DrawMesh(Canonical(source),r.localToWorldMatrix,materials[i],0,0);cmd.EndSample("EID"+manifest.draws[i].eid+" Hair Alpha");
                    Capture?.Invoke(cmd,color,manifest.draws[i].eid,true);LastDrawCount++;
                }
                cmd.SetRenderTarget(color,depth);context.ExecuteCommandBuffer(cmd);
            } catch(Exception e) {failed=true;Debug.LogException(e);}
            finally {CommandBufferPool.Release(cmd);}
        }
        public void Dispose() {foreach(var b in buffers.Values)b.Release();buffers.Clear();foreach(var o in owned)if(o!=null)UnityEngine.Object.DestroyImmediate(o);owned.Clear();textures.Clear();meshes.Clear();materials=null;aux?.Release();aux=null;failed=false;}
    }
}

