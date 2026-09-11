using System;using UnityEngine;using UnityEngine.Rendering;
[ExecuteAlways,DisallowMultipleComponent]
public sealed class EID3899TerrainController:MonoBehaviour
{
 public Material terrainMaterial;
 public TextAsset frameConstants,frameParameters,terrainParameters,pageTable,layerParameters;
 [Tooltip("仅控制片元的捕获相机参数。顶点始终由Unity实时矩阵变换。")]
 public bool capturedCameraParameters;
 ComputeBuffer[] buffers;byte[] liveFrame;uint[] liveWords;
 static readonly string[] Names={"EID3899Frame","EID3899FrameParameters","EID3899TerrainParameters","EID3899PageTable","EID3899Layers"};
 void OnEnable(){RenderPipelineManager.beginCameraRendering+=BeginCamera;TryBind();}
 void OnDisable(){RenderPipelineManager.beginCameraRendering-=BeginCamera;Release();}
 void OnValidate(){Release();}
 public void Bind(){TryBind();}
 bool TryBind(){if(!terrainMaterial)return false;TextAsset[] source={frameConstants,frameParameters,terrainParameters,pageTable,layerParameters};int[] sizes={1312,3200,208,17456,7168};for(int i=0;i<5;i++){if(!source[i]){WarnOnce("missing "+Names[i]);return false;}if(source[i].bytes.Length!=sizes[i]){WarnOnce("wrong buffer bound: "+Names[i]+" (got "+source[i].bytes.Length+", expected "+sizes[i]+"). EID3899 is skipped; existing renderers are preserved.");return false;}}if(buffers==null){buffers=new ComputeBuffer[5];for(int i=0;i<5;i++){byte[] raw=source[i].bytes;uint[] words=new uint[raw.Length/4];Buffer.BlockCopy(raw,0,words,0,raw.Length);buffers[i]=new ComputeBuffer(words.Length,4,ComputeBufferType.Constant);buffers[i].SetData(words);}liveFrame=(byte[])frameParameters.bytes.Clone();liveWords=new uint[liveFrame.Length/4];}for(int i=0;i<5;i++)terrainMaterial.SetConstantBuffer(Names[i],buffers[i],0,sizes[i]);terrainMaterial.SetFloat("_EID3899CapturedCameraParameters",capturedCameraParameters?1:0);return true;}
 bool warned; void WarnOnce(string message){if(warned)return;warned=true;Debug.LogError("EID3899TerrainController: "+message,this);}
 void BeginCamera(ScriptableRenderContext ctx,Camera camera){if(!isActiveAndEnabled||!camera)return;if(!TryBind()||buffers==null)return;Buffer.BlockCopy(frameParameters.bytes,0,liveFrame,0,liveFrame.Length);if(!capturedCameraParameters){var rt=camera.targetTexture;int w=Mathf.Max(1,rt?rt.width:camera.scaledPixelWidth),h=Mathf.Max(1,rt?rt.height:camera.scaledPixelHeight);Write(0,w);Write(4,h);Write(8,1f/w);Write(12,1f/h);Write(76,camera.orthographic?1:0);Write(312,0);Write(316,0);}Buffer.BlockCopy(liveFrame,0,liveWords,0,liveFrame.Length);buffers[1].SetData(liveWords);}
 void Write(int o,float v){Buffer.BlockCopy(BitConverter.GetBytes(v),0,liveFrame,o,4);}
 public string ValidateBuffers(){if(!TryBind()||buffers==null)return "SKIP: invalid EID3899 constants; existing renderers unchanged";TextAsset[] src={frameConstants,frameParameters,terrainParameters,pageTable,layerParameters};for(int i=0;i<5;i++){uint[] words=new uint[src[i].bytes.Length/4];buffers[i].GetData(words);byte[] raw=new byte[words.Length*4];Buffer.BlockCopy(words,0,raw,0,raw.Length);if(i==1&&!capturedCameraParameters)continue;byte[] original=src[i].bytes;for(int j=0;j<raw.Length;j++)if(raw[j]!=original[j])return "FAIL: "+Names[i]+" byte "+j;}return "PASS: correct sizes and immutable GPU cbuffers byte-identical";}
 void Release(){if(buffers!=null)foreach(var b in buffers)b?.Release();buffers=null;}
}
