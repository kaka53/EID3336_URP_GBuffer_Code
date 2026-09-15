from pathlib import Path
p=Path('Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/Editor/EID4922SkyAssetBuilder.cs')
s=p.read_text()
method=r'''
    [MenuItem("EID4922/Capture Standalone Validation")]
    public static void CaptureValidation()
    {
        Scene scene = EditorSceneManager.OpenScene(ScenePath, OpenSceneMode.Single);
        Camera camera = null;
        foreach (Camera item in UnityEngine.Object.FindObjectsOfType<Camera>(true)) { camera = item; if (item.name == "EID4922_RenderDocCamera") break; }
        if (camera == null) throw new System.Exception("EID4922 validation camera is missing");
        Directory.CreateDirectory("Validation/EID4922");
        RenderTexture rt = new RenderTexture(1366, 768, 24, RenderTextureFormat.ARGBHalf, RenderTextureReadWrite.Linear) { name = "EID4922_Validation_RT" };
        rt.Create();
        RenderTexture previous = camera.targetTexture;
        RenderTexture active = RenderTexture.active;
        camera.targetTexture = rt;
        camera.Render();
        RenderTexture.active = rt;
        Texture2D image = new Texture2D(rt.width, rt.height, TextureFormat.RGBA32, false, true);
        image.ReadPixels(new Rect(0, 0, rt.width, rt.height), 0, 0, false);
        image.Apply(false, false);
        string output = Path.GetFullPath("Validation/EID4922/EID4922_Unity.png");
        File.WriteAllBytes(output, image.EncodeToPNG());
        camera.targetTexture = previous; RenderTexture.active = active;
        rt.Release(); UnityEngine.Object.DestroyImmediate(rt); UnityEngine.Object.DestroyImmediate(image);
        Debug.Log("[EID4922] validation capture=" + output);
    }
'''
pos=s.rfind('\n}')
s=s[:pos]+'\n'+method+s[pos:]
p.write_text(s)
