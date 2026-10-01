#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

// Isolated GPU regression; does not edit scene, mesh, or material assets.
public static class EID1727GBufferDepthAudit
{
    const string Dir = ".rdctools/eid1727_gbuffer";
    const string ShaderPath = "Assets/ColourPass6_VS239789_PS239790_Batch/Shaders/EID239789239790GBuffer.shader";
    [MenuItem("Tools/EID4812/Audit EID1727 GBuffer Depth")]
    public static void Run()
    {
        Directory.CreateDirectory(Dir);
        var report = new StringBuilder();
        var targets = new RenderTexture[5];
        RenderTexture depth = null;
        var previous = RenderTexture.active;
        Shader oldShader = null;
        Material oldMaterial = null;
        GameObject cameraObject = null;
        try
        {
            AssetDatabase.ImportAsset(ShaderPath, ImportAssetOptions.ForceUpdate | ImportAssetOptions.ForceSynchronousImport);
            report.AppendLine("time=" + DateTime.Now.ToString("O") + " device=" + SystemInfo.graphicsDeviceType + " reversedZ=" + SystemInfo.usesReversedZBuffer);
            foreach (var name in new[] { "EID1727_instance_000", "EID1717_instance_000" })
            {
                var go = GameObject.Find(name);
                if (go == null) throw new Exception("Missing " + name);
                var r = go.GetComponent<Renderer>(); var m = r.sharedMaterial;
                report.AppendLine(name + " active=" + go.activeInHierarchy + " renderer=" + r.enabled + " forceOff=" + r.forceRenderingOff + " layer=" + go.layer + " queue=" + m.renderQueue + " gbuffer=" + m.GetShaderPassEnabled("UniversalGBuffer") + " supported=" + m.shader.isSupported + " material=" + AssetDatabase.GetAssetPath(m));
            }
            var obj = GameObject.Find("EID1727_instance_000");
            var mesh = obj.GetComponent<MeshFilter>().sharedMesh;
            var mat = obj.GetComponent<Renderer>().sharedMaterial;
            var matrix = obj.transform.localToWorldMatrix;
            var source = File.ReadAllText(ShaderPath).Replace("Shader \"EID/URP/VS239789_PS239790_GBuffer\"", "Shader \"Hidden/EID1727/BeforeDepthFix\"")
                .Replace("ZTest LEqual", "ZTest GEqual")
                .Replace("\"EID239789239790GBuffer.hlsl\"", "\"Assets/ColourPass6_VS239789_PS239790_Batch/Shaders/EID239789239790GBuffer.hlsl\"");
            oldShader = ShaderUtil.CreateShaderAsset(source);
            oldMaterial = new Material(oldShader); oldMaterial.CopyPropertiesFromMaterial(mat);
            cameraObject = new GameObject("EID1727 isolated audit camera") { hideFlags = HideFlags.HideAndDontSave };
            var cam = cameraObject.AddComponent<Camera>(); cam.enabled = false;
            var center = matrix.MultiplyPoint3x4(mesh.bounds.center);
            float radius = mesh.bounds.extents.magnitude;
            cam.transform.position = center + matrix.MultiplyVector(new Vector3(0, 0, radius * 2.5f));
            cam.transform.LookAt(center); cam.orthographic = true; cam.orthographicSize = radius * 1.1f;
            cam.aspect = 1; cam.nearClipPlane = .01f; cam.farClipPlane = radius * 10 + 1;
            var ids = new RenderTargetIdentifier[5];
            for (int i = 0; i < 5; i++) { targets[i] = new RenderTexture(256, 256, 0, RenderTextureFormat.ARGBFloat, RenderTextureReadWrite.Linear); targets[i].Create(); ids[i] = targets[i]; }
            depth = new RenderTexture(256, 256, 24, RenderTextureFormat.Depth); depth.Create();
            int[] counts = new int[2];
            for (int test = 0; test < 2; test++)
            {
                var m = test == 0 ? oldMaterial : mat;
                var pass = m.FindPass("VS239789_PS239790_UniversalGBuffer");
                using (var cmd = new CommandBuffer())
                {
                    cmd.SetViewProjectionMatrices(cam.worldToCameraMatrix, cam.projectionMatrix);
                    cmd.SetGlobalMatrix("unity_MatrixVP", GL.GetGPUProjectionMatrix(cam.projectionMatrix, true) * cam.worldToCameraMatrix);
                    cmd.SetRenderTarget(ids, depth);
                    cmd.ClearRenderTarget(true, true, new Color(-10, -10, -10, -10));
                    cmd.DrawMesh(mesh, matrix, m, 0, pass);
                    Graphics.ExecuteCommandBuffer(cmd);
                }
                RenderTexture.active = targets[4];
                var cpu = new Texture2D(256, 256, TextureFormat.RGBAFloat, false, true);
                try
                {
                    cpu.ReadPixels(new Rect(0, 0, 256, 256), 0, 0); cpu.Apply();
                    int bad = 0;
                    foreach (var c in cpu.GetPixels()) { if (c.a > -9) counts[test]++; if (float.IsNaN(c.r) || float.IsInfinity(c.r)) bad++; }
                    report.AppendLine((test == 0 ? "before_GEqual" : "after_LEqual") + " rt4CoveredPixels=" + counts[test] + " invalidRed=" + bad);
                }
                finally { UnityEngine.Object.DestroyImmediate(cpu); }
                foreach (var message in ShaderUtil.GetShaderMessages(m.shader))
                    if (message.severity == UnityEditor.Rendering.ShaderCompilerMessageSeverity.Error) throw new Exception(message.message);
            }
            if (counts[0] != 0 || counts[1] < 100) throw new Exception("Unexpected depth regression result");
            EID4812DepthStateRepair.Audit();
            report.AppendLine("RESULT=PASS (isolated GBuffer GPU regression, not full scene pixel equivalence)");
        }
        catch (Exception e) { report.AppendLine("RESULT=FAIL\n" + e); Debug.LogException(e); }
        finally
        {
            RenderTexture.active = previous;
            foreach (var rt in targets) if (rt != null) { rt.Release(); UnityEngine.Object.DestroyImmediate(rt); }
            if (depth != null) { depth.Release(); UnityEngine.Object.DestroyImmediate(depth); }
            if (oldMaterial != null) UnityEngine.Object.DestroyImmediate(oldMaterial);
            if (oldShader != null) UnityEngine.Object.DestroyImmediate(oldShader);
            if (cameraObject != null) UnityEngine.Object.DestroyImmediate(cameraObject);
            File.WriteAllText(Dir + "/audit.txt", report.ToString());
        }
    }
}
#endif
