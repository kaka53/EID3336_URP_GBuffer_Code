using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using EID4730;

public static class EID4785GPUValidation
{
    const string Root="Assets/EID4785_RenderDocRestore";
    const string Out=".rdctools/eid4785_verified";
    static readonly Color Sentinel=new Color(-10,-10,-10,-10);
    public static void Run()
    {
        var log=new StringBuilder(); log.AppendLine("device="+SystemInfo.graphicsDeviceType);
        try
        {
            EditorSceneManager.OpenScene("Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity",OpenSceneMode.Single);
            var obj=GameObject.Find("EID4785_instance_000");if(obj==null)throw new Exception("Missing corrected instance");
            var mesh=obj.GetComponent<MeshFilter>().sharedMesh;var mat=obj.GetComponent<MeshRenderer>().sharedMaterial;
            if(mesh.vertexCount!=10035||mesh.GetIndexCount(0)!=34362)throw new Exception("Wrong source geometry");
            var go=new GameObject("EID4785 temporary validation camera");var camera=go.AddComponent<Camera>();camera.enabled=false;
            var center=obj.transform.TransformPoint(mesh.bounds.center);camera.transform.position=center+new Vector3(0,0,3f);camera.transform.LookAt(center,Vector3.up);
            camera.orthographic=true;camera.orthographicSize=1.05f;camera.aspect=1;camera.nearClipPlane=0.01f;camera.farClipPlane=10;
            var colors=new RenderTexture[5];for(int i=0;i<5;i++){colors[i]=new RenderTexture(512,512,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);colors[i].Create();}
            var depth=new RenderTexture(512,512,24,RenderTextureFormat.Depth);depth.Create();
            var ids=new RenderTargetIdentifier[5];for(int i=0;i<5;i++)ids[i]=colors[i];
            var vp=GL.GetGPUProjectionMatrix(camera.projectionMatrix,true)*camera.worldToCameraMatrix;
            using(var session=new EID4785ReplaySession("Assets/StreamingAssets/EID4785Replay/replay.json", true, false))
            {
                session.Bind(mat,false);
                for(int prepass=0;prepass<2;prepass++)
                {
                    var cmd=new CommandBuffer {name="EID4785 Equal depth contract validation"};
                    cmd.SetViewProjectionMatrices(camera.worldToCameraMatrix,camera.projectionMatrix);
                    cmd.SetGlobalMatrix("unity_MatrixVP",vp);cmd.SetGlobalVector("_WorldSpaceCameraPos",camera.transform.position);
                    cmd.SetRenderTarget(ids,depth);cmd.ClearRenderTarget(true,true,Sentinel);
                    if(prepass==1)cmd.DrawMesh(mesh,obj.transform.localToWorldMatrix,mat,0,1);
                    cmd.SetRenderTarget(new[]{ids[0],ids[1]},depth);cmd.ClearRenderTarget(false,true,Sentinel);
                    cmd.DrawMesh(mesh,obj.transform.localToWorldMatrix,mat,0,0);
                    Graphics.ExecuteCommandBuffer(cmd);cmd.Release();
                    for(int target=0;target<2;target++)
                    {
                        RenderTexture.active=colors[target];var cpu=new Texture2D(512,512,TextureFormat.RGBAFloat,false,true);cpu.ReadPixels(new Rect(0,0,512,512),0,0);cpu.Apply();
                        var pixels=cpu.GetPixels();int changed=0,nonfinite=0;var png=new Texture2D(512,512,TextureFormat.RGBA32,false,true);
                        for(int n=0;n<pixels.Length;n++)
                        {
                            var c=pixels[n];if(float.IsNaN(c.r)||float.IsInfinity(c.r)||float.IsNaN(c.g)||float.IsInfinity(c.g)||float.IsNaN(c.b)||float.IsInfinity(c.b))nonfinite++;
                            bool written=Mathf.Abs(c.r+10)>0.01f||Mathf.Abs(c.g+10)>0.01f||Mathf.Abs(c.b+10)>0.01f;
                            if(written)changed++;
                            pixels[n]=written?new Color(Mathf.Clamp01(c.r),Mathf.Clamp01(c.g),Mathf.Clamp01(c.b),1):new Color(0.07f,0.07f,0.07f,1);
                        }
                        log.AppendLine("prepass="+prepass+" MRT="+target+" coveredPixels="+changed+" nonfinite="+nonfinite);
                        if((prepass==0&&changed!=0)||(prepass==1&&changed==0)||nonfinite>0)throw new Exception("Equal-depth GPU contract failed");
                        if(prepass==1){png.SetPixels(pixels);png.Apply();File.WriteAllBytes(Out+"/unity_isolated_"+SystemInfo.graphicsDeviceType+"_mrt"+target+".png",png.EncodeToPNG());}
                        UnityEngine.Object.DestroyImmediate(cpu);UnityEngine.Object.DestroyImmediate(png);
                    }
                }
            }
            RenderTexture.active=null;foreach(var x in colors){x.Release();UnityEngine.Object.DestroyImmediate(x);}depth.Release();UnityEngine.Object.DestroyImmediate(depth);UnityEngine.Object.DestroyImmediate(go);
            log.AppendLine("RESULT=PASS (isolated GPU coverage and shared-depth test, not pixel equivalence)");File.WriteAllText(Out+"/gpu_validation_"+SystemInfo.graphicsDeviceType+".txt",log.ToString());Debug.Log(log.ToString());
        }
        catch(Exception e){log.AppendLine(e.ToString());log.AppendLine("RESULT=FAIL");File.WriteAllText(Out+"/gpu_validation_"+SystemInfo.graphicsDeviceType+".txt",log.ToString());Debug.LogError(log.ToString());if(Application.isBatchMode)EditorApplication.Exit(1);}
    }
    public static void RunSceneAndGPU()
    {
        Run();
        RunSceneOnly();
    }
    public static void RunSceneOnly()
    {
        EditorSceneManager.OpenScene("Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity",OpenSceneMode.Single);
        var log=new StringBuilder();log.AppendLine("device="+SystemInfo.graphicsDeviceType);
        try
        {
            var obj=GameObject.Find("EID4785_instance_000");obj.GetComponent<EID4785ReplayBinder>().Rebind();
            var camera=GameObject.Find("EID3336 RenderDoc Camera").GetComponent<Camera>();
            var target=new RenderTexture(1366,768,24,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);target.Create();
            var old=camera.targetTexture;camera.targetTexture=target;using (EID4730.EID4730RenderFeature.BeginIsolatedAttachmentDiagnostics()) { camera.Render();camera.Render(); }camera.targetTexture=old;
            var auxiliary=Shader.GetGlobalTexture("_EID4785_AuxiliaryMRT") as RenderTexture;
            if(auxiliary==null)throw new Exception("EID4730 feature did not expose EID4785 second MRT");
            log.AppendLine("camera="+camera.name+" auxiliary="+auxiliary.width+"x"+auxiliary.height+" format="+auxiliary.graphicsFormat);
            log.AppendLine("meshBounds="+obj.GetComponent<MeshRenderer>().bounds);
            int auxPixels=SaveSceneTexture(auxiliary,"scene_auxiliary",log);
            SaveSceneTexture(target,"scene_camera",log);
            if(auxPixels==0 || auxPixels>=auxiliary.width*auxiliary.height/2)throw new Exception("Invalid EID4785 auxiliary coverage (zero or implausibly fullscreen)");
            log.AppendLine("RESULT=PASS (scene feature executed and auxiliary pixels read back; not original-frame pixel equivalence)");
            File.WriteAllText(Out+"/scene_validation_"+SystemInfo.graphicsDeviceType+".txt",log.ToString());
            Debug.Log(log.ToString());target.Release();UnityEngine.Object.DestroyImmediate(target);
        }
        catch(Exception e){log.AppendLine(e.ToString());log.AppendLine("RESULT=FAIL");File.WriteAllText(Out+"/scene_validation_"+SystemInfo.graphicsDeviceType+".txt",log.ToString());Debug.LogError(log.ToString());if(Application.isBatchMode)EditorApplication.Exit(1);}
    }
    static int SaveSceneTexture(RenderTexture source,string name,StringBuilder log)
    {
        // Packed R10G10B10A2 cannot be directly ReadPixels-converted to RGBAFloat on D3D11.
        var staging=new RenderTexture(source.width,source.height,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);staging.Create();
        Graphics.Blit(source,staging);
        RenderTexture.active=staging;var cpu=new Texture2D(source.width,source.height,TextureFormat.RGBAFloat,false,true);cpu.ReadPixels(new Rect(0,0,source.width,source.height),0,0);cpu.Apply();
        var pixels=cpu.GetPixels();int count=0,nonfinite=0;
        for(int n=0;n<pixels.Length;n++)
        {
            var c=pixels[n];if(c.r+c.g+c.b>1e-4f)count++;
            if(float.IsNaN(c.r)||float.IsInfinity(c.r)||float.IsNaN(c.g)||float.IsInfinity(c.g)||float.IsNaN(c.b)||float.IsInfinity(c.b))nonfinite++;
            pixels[n]=new Color(Mathf.LinearToGammaSpace(Mathf.Max(0,c.r)),Mathf.LinearToGammaSpace(Mathf.Max(0,c.g)),Mathf.LinearToGammaSpace(Mathf.Max(0,c.b)),1);
        }
        var png=new Texture2D(source.width,source.height,TextureFormat.RGBA32,false);png.SetPixels(pixels);png.Apply();
        File.WriteAllBytes(Out+"/"+name+"_"+SystemInfo.graphicsDeviceType+".png",png.EncodeToPNG());
        log.AppendLine(name+" nonBlack="+count+" nonfinite="+nonfinite);
        RenderTexture.active=null;staging.Release();UnityEngine.Object.DestroyImmediate(staging);UnityEngine.Object.DestroyImmediate(cpu);UnityEngine.Object.DestroyImmediate(png);if(nonfinite>0)throw new Exception("Nonfinite scene readback");return count;
    }

}
