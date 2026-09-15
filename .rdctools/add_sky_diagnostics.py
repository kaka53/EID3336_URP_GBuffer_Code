from pathlib import Path
p=Path('Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/Shaders/EID4922Sky.shader')
s=p.read_text()
s=s.replace('    Properties\n    {', '    Properties\n    {\n        [Enum(UnityEngine.Rendering.CullMode)] _EID4922Cull ("Cull", Float) = 1\n        [Enum(UnityEngine.Rendering.CompareFunction)] _EID4922ZTest ("ZTest", Float) = 7\n        _EID4922DebugMode ("Debug Mode", Float) = 0')
s=s.replace('            Cull Front\n            ZWrite Off\n            ZTest GEqual', '            Cull [_EID4922Cull]\n            ZWrite Off\n            ZTest [_EID4922ZTest]')
p.write_text(s)
p=Path('Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/Shaders/EID4922Sky.hlsl')
s=p.read_text()
insert='float _EID4922DebugMode;\n\n'
pos=s.index('struct EID4922VertexInput')
s=s[:pos]+insert+s[pos:]
s=s.replace('''float4 EID4922PixelMain(EID4922Varyings input) : SV_Target0
{
    gl_FragCoord = input.positionCS;''','''float4 EID4922PixelMain(EID4922Varyings input) : SV_Target0
{
    if (_EID4922DebugMode > 0.5) return float4(1.0, 1.0, 1.0, 1.0);
    gl_FragCoord = input.positionCS;''')
p.write_text(s)
p=Path('Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/Editor/EID4922SkyAssetBuilder.cs')
s=p.read_text()
s=s.replace('        EditorUtility.SetDirty(mat);', '        mat.SetFloat("_EID4922Cull", 1f); mat.SetFloat("_EID4922ZTest", 7f); mat.SetFloat("_EID4922DebugMode", 0f);\n        EditorUtility.SetDirty(mat);',1)
method=r'''
    [MenuItem("EID4922/Capture Diagnostic Variants")]
    public static void CaptureDiagnosticVariants()
    {
        Scene scene = EditorSceneManager.OpenScene(ScenePath, OpenSceneMode.Single);
        Camera camera = null;
        foreach (Camera item in UnityEngine.Object.FindObjectsOfType<Camera>(true)) { camera = item; if (item.name == "EID4922_RenderDocCamera") break; }
        EID4922SkyProfile profile = AssetDatabase.LoadAssetAtPath<EID4922SkyProfile>(ProfilePath);
        if (camera == null || profile == null || profile.skyMaterial == null) throw new System.Exception("EID4922 diagnostic assets missing");
        Directory.CreateDirectory("Validation/EID4922");
        float[,] modes = { {0f,8f,1f}, {1f,8f,1f}, {0f,7f,1f}, {1f,7f,1f}, {1f,7f,0f} };
        string[] names = { "01_White_CullOff_ZAlways", "02_White_CullFront_ZAlways", "03_White_CullOff_ZGEqual", "04_White_CullFront_ZGEqual", "05_Exact" };
        Material material = profile.skyMaterial;
        for (int i = 0; i < names.Length; i++)
        {
            material.SetFloat("_EID4922Cull", modes[i,0]); material.SetFloat("_EID4922ZTest", modes[i,1]); material.SetFloat("_EID4922DebugMode", modes[i,2]);
            RenderTexture rt = new RenderTexture(683, 384, 24, RenderTextureFormat.ARGBHalf, RenderTextureReadWrite.Linear); rt.Create();
            RenderTexture previous = camera.targetTexture, active = RenderTexture.active; camera.targetTexture = rt; camera.Render(); RenderTexture.active = rt;
            Texture2D image = new Texture2D(rt.width, rt.height, TextureFormat.RGBA32, false, true); image.ReadPixels(new Rect(0,0,rt.width,rt.height),0,0,false); image.Apply(false,false);
            File.WriteAllBytes(Path.GetFullPath("Validation/EID4922/" + names[i] + ".png"), image.EncodeToPNG());
            camera.targetTexture=previous; RenderTexture.active=active; rt.Release(); UnityEngine.Object.DestroyImmediate(rt); UnityEngine.Object.DestroyImmediate(image);
        }
        material.SetFloat("_EID4922Cull", 1f); material.SetFloat("_EID4922ZTest", 7f); material.SetFloat("_EID4922DebugMode", 0f); EditorUtility.SetDirty(material); AssetDatabase.SaveAssets();
        Debug.Log("[EID4922] diagnostic variants captured");
    }
'''
pos=s.rfind('\n}')
s=s[:pos]+'\n'+method+s[pos:]
p.write_text(s)
