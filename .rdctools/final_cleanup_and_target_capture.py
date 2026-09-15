from pathlib import Path
p=Path('Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/Runtime/EID4922SkyRendererFeature.cs')
s=p.read_text()
s=s.replace('        Debug.Log("[EID4922] enqueue camera=" + camera.name + " profile=" + settings.profile.name);\n','')
s=s.replace('        Debug.Log("[EID4922] execute camera=" + renderingData.cameraData.camera.name + " mesh=" + p.skyMesh.name + " material=" + p.skyMaterial.name + " capturedBuffers=" + p.useCapturedBuffers);\n','')
p.write_text(s)
p=Path('Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/Shaders/EID4922Sky.shader')
s=p.read_text().replace('[Enum(UnityEngine.Rendering.CullMode)] _EID4922Cull', '[HideInInspector] _EID4922Cull').replace('[Enum(UnityEngine.Rendering.CompareFunction)] _EID4922ZTest', '[HideInInspector] _EID4922ZTest').replace('_EID4922DebugMode ("Debug Mode"', '[HideInInspector] _EID4922DebugMode ("Debug Mode"')
p.write_text(s)
p=Path('Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/Editor/EID4922SkyAssetBuilder.cs')
s=p.read_text()
method=r'''
    [MenuItem("EID4922/Capture Target Scene Validation")]
    public static void CaptureTargetSceneValidation()
    {
        const string target = "Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
        Scene scene = EditorSceneManager.OpenScene(target, OpenSceneMode.Single);
        Camera camera = null;
        foreach (Camera item in UnityEngine.Object.FindObjectsOfType<Camera>(true)) if (item.GetComponent<EID4922SkyCamera>() != null) { camera = item; break; }
        if (camera == null) throw new System.Exception("Target scene EID4922 camera marker is missing");
        Directory.CreateDirectory("Validation/EID4922");
        RenderTexture rt = new RenderTexture(683, 384, 24, RenderTextureFormat.ARGBHalf, RenderTextureReadWrite.Linear); rt.Create();
        RenderTexture previous = camera.targetTexture, active = RenderTexture.active; camera.targetTexture = rt; camera.Render(); RenderTexture.active = rt;
        Texture2D image = new Texture2D(rt.width, rt.height, TextureFormat.RGBA32, false, true); image.ReadPixels(new Rect(0,0,rt.width,rt.height),0,0,false); image.Apply(false,false);
        string output = Path.GetFullPath("Validation/EID4922/EID4922_TargetScene.png"); File.WriteAllBytes(output, image.EncodeToPNG());
        camera.targetTexture=previous; RenderTexture.active=active; rt.Release(); UnityEngine.Object.DestroyImmediate(rt); UnityEngine.Object.DestroyImmediate(image);
        Debug.Log("[EID4922] target scene validation capture=" + output);
    }
'''
pos=s.rfind('\n}')
s=s[:pos]+'\n'+method+s[pos:]
p.write_text(s)
