#if UNITY_EDITOR
using System;
using System.IO;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using UnityEngine.Experimental.Rendering;

public static class EID4922SkyAssetBuilder
{
    const string Root = "Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky";
    const string SettingsPath = Root + "/Settings";
    const string ShaderPath = Root + "/Shaders/EID4922Sky.shader";
    const string MeshPath = Root + "/Meshes/EID4922_SkySphere.obj";
    const string ProfilePath = SettingsPath + "/EID4922SkyProfile.asset";
    const string MaterialPath = Root + "/Materials/EID4922Sky.mat";
    const string RendererPath = "Assets/EID3332_EID3336_Combined/Settings/EID3332Combined-Renderer.asset";
    const string ScenePath = Root + "/Scenes/EID4922_RenderDocSky.unity";

    [MenuItem("EID4922/Build RenderDoc Sky Assets")]
    public static void Build()
    {
        AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
        Shader shader = AssetDatabase.LoadAssetAtPath<Shader>(ShaderPath);
        Mesh mesh = AssetDatabase.LoadAssetAtPath<Mesh>(MeshPath);
        if (shader == null || mesh == null) throw new System.Exception("EID4922 shader or mesh import failed");
        ShaderMessage[] shaderMessages = ShaderUtil.GetShaderMessages(shader);
        if (ShaderUtil.ShaderHasError(shader))
        {
            var errors = new System.Text.StringBuilder();
            foreach (ShaderMessage message in shaderMessages) errors.AppendLine(message.severity + " " + message.file + ":" + message.line + " " + message.message);
            throw new System.Exception("EID4922 direct-port shader compile failed:\n" + errors);
        }

        Material mat = AssetDatabase.LoadAssetAtPath<Material>(MaterialPath);
        if (mat == null) { mat = new Material(shader); AssetDatabase.CreateAsset(mat, MaterialPath); }
        else mat.shader = shader;
        SetTexture(mat, "_EID4922Res19", Root + "/Textures/EID4922_res19.dds");
        SetTexture(mat, "_EID4922Res29", Root + "/Textures/EID4922_res29.dds");
        SetTexture(mat, "_EID4922Res27", Root + "/Textures/EID4922_res27.dds");
        SetTexture(mat, "_EID4922Res25", Root + "/Textures/EID4922_res25.dds");
        SetTexture(mat, "_EID4922Res23", Root + "/Textures/EID4922_res23.dds");
        SetTexture(mat, "_EID4922Res21", Root + "/Textures/EID4922_res21.dds");
        SetTexture(mat, "_EID4922Res20", Root + "/Textures/EID4922_res20.dds");
        Texture2D res19Raw = EnsureRawTexture2D(Root + "/CapturedResources/Texture_RID15375.dds", Root + "/Textures/EID4922_res19_raw.asset", 128, 128, GraphicsFormat.R16G16B16A16_SFloat);
        Texture3D res18 = EnsureRawTexture3D(Root + "/CapturedResources/Texture_RID209575.dds", Root + "/Textures/EID4922_res18_raw.asset", 86, 48, 128, GraphicsFormat.R16G16B16A16_SFloat);
        if (res19Raw != null) mat.SetTexture("_EID4922Res19", res19Raw);
        if (res18 != null) mat.SetTexture("_EID4922Res18", res18);
        mat.SetFloat("_EID4922Cull", 0f); mat.SetFloat("_EID4922ZTest", 4f); mat.SetFloat("_EID4922DebugMode", 0f);
        EditorUtility.SetDirty(mat);

        EID4922SkyProfile profile = AssetDatabase.LoadAssetAtPath<EID4922SkyProfile>(ProfilePath);
        if (profile == null) { profile = ScriptableObject.CreateInstance<EID4922SkyProfile>(); AssetDatabase.CreateAsset(profile, ProfilePath); }
        profile.skyMesh = mesh; profile.skyMaterial = mat;
        profile.frameUniforms11 = LoadText(Root + "/Settings/Frame_uniforms11.bytes");
        profile.viewUniforms13 = LoadText(Root + "/Settings/View_uniforms13.bytes");
        profile.objectUniforms15 = LoadText(Root + "/Settings/VS_uniforms15.bytes");
        profile.skyUniforms32 = LoadText(Root + "/Settings/PS_uniforms32.bytes");
        profile.res19 = res19Raw;
        profile.res29 = LoadTex2D(Root + "/Textures/EID4922_res29.dds");
        profile.res27 = LoadTex2D(Root + "/Textures/EID4922_res27.dds");
        profile.res25 = LoadTex2D(Root + "/Textures/EID4922_res25.dds");
        profile.res23 = LoadTex2D(Root + "/Textures/EID4922_res23.dds");
        profile.res21 = LoadTex2D(Root + "/Textures/EID4922_res21.dds");
        profile.res20 = LoadTex2D(Root + "/Textures/EID4922_res20.dds");
        profile.res18 = res18;
        EditorUtility.SetDirty(profile);

        AddFeature(profile);
        CreateScene();
        AssetDatabase.SaveAssets(); AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
        Debug.Log("[EID4922] RenderDoc sky assets built: " + ProfilePath + " scene=" + ScenePath);
    }

    static TextAsset LoadText(string path) => AssetDatabase.LoadAssetAtPath<TextAsset>(path);
    static Texture2D LoadTex2D(string path) => AssetDatabase.LoadAssetAtPath<Texture2D>(path);

    static byte[] DdsPayload(string path)
    {
        byte[] all = File.ReadAllBytes(path);
        if (all.Length <= 148 || all[0] != (byte)'D' || all[1] != (byte)'D' || all[2] != (byte)'S' || all[3] != (byte)' ') return null;
        byte[] payload = new byte[all.Length - 148]; System.Buffer.BlockCopy(all, 148, payload, 0, payload.Length); return payload;
    }

    static float DecodeUF(uint v, int mantissaBits)
    {
        uint mantMask = (uint)((1 << mantissaBits) - 1); uint mant = v & mantMask; uint exp = v >> mantissaBits;
        if (exp == 0) return mant == 0 ? 0f : (mant / (float)(1 << mantissaBits)) * Mathf.Pow(2f, -14f);
        if (exp == 31) return mant == 0 ? float.PositiveInfinity : float.NaN;
        return (1f + mant / (float)(1 << mantissaBits)) * Mathf.Pow(2f, (int)exp - 15);
    }

    static Texture2D EnsureRawTexture2D(string dds, string assetPath, int width, int height, GraphicsFormat format)
    {
        Texture2D existing = AssetDatabase.LoadAssetAtPath<Texture2D>(assetPath); if (existing != null) return existing;
        byte[] src = DdsPayload(dds); float[] rgba = new float[width * height * 4];
        for (int i = 0; i < width * height; i++) { uint p = BitConverter.ToUInt32(src, i * 4); rgba[i * 4 + 0] = DecodeUF(p & 0x7ffu, 6); rgba[i * 4 + 1] = DecodeUF((p >> 11) & 0x7ffu, 6); rgba[i * 4 + 2] = DecodeUF((p >> 22) & 0x3ffu, 5); rgba[i * 4 + 3] = 1f; }
        Texture2D tex = new Texture2D(width, height, TextureFormat.RGBAFloat, false, true); tex.name = Path.GetFileNameWithoutExtension(assetPath); byte[] raw = new byte[rgba.Length * 4]; Buffer.BlockCopy(rgba, 0, raw, 0, raw.Length); tex.LoadRawTextureData(raw); tex.Apply(false, true); AssetDatabase.CreateAsset(tex, assetPath); return tex;
    }

    static float HalfToFloat(ushort h)
    {
        uint sign = (uint)(h >> 15) & 1, exp = (uint)(h >> 10) & 31, mant = (uint)(h & 1023);
        uint bits; if (exp == 0) bits = mant == 0 ? sign << 31 : (sign << 31) | (uint)Mathf.Clamp(Mathf.RoundToInt(Mathf.Log(mant / 1024f, 2f) + 127f), 0, 255) << 23;
        else if (exp == 31) bits = (sign << 31) | 0x7f800000u | (mant << 13);
        else bits = (sign << 31) | ((exp + 112) << 23) | (mant << 13);
        return BitConverter.ToSingle(BitConverter.GetBytes(bits), 0);
    }

    static Texture3D EnsureRawTexture3D(string dds, string assetPath, int width, int height, int depth, GraphicsFormat format)
    {
        Texture3D existing = AssetDatabase.LoadAssetAtPath<Texture3D>(assetPath); if (existing != null) return existing;
        byte[] src = DdsPayload(dds); Color[] colors = new Color[width * height * depth];
        for (int i = 0; i < colors.Length; i++) colors[i] = new Color(HalfToFloat(BitConverter.ToUInt16(src, i * 8 + 0)), HalfToFloat(BitConverter.ToUInt16(src, i * 8 + 2)), HalfToFloat(BitConverter.ToUInt16(src, i * 8 + 4)), HalfToFloat(BitConverter.ToUInt16(src, i * 8 + 6)));
        Texture3D tex = new Texture3D(width, height, depth, TextureFormat.RGBAHalf, false); tex.name = Path.GetFileNameWithoutExtension(assetPath); tex.SetPixels(colors); tex.Apply(false, true); AssetDatabase.CreateAsset(tex, assetPath); return tex;
    }
    static void SetTexture(Material m, string property, string path)
    {
        Texture t = AssetDatabase.LoadAssetAtPath<Texture>(path);
        if (t != null && m.HasProperty(property)) m.SetTexture(property, t);
    }

    static void AddFeature(EID4922SkyProfile profile)
    {
        UniversalRendererData data = AssetDatabase.LoadAssetAtPath<UniversalRendererData>(RendererPath);
        if (data == null) throw new System.Exception("Renderer data not found: " + RendererPath);
        EID4922SkyRendererFeature feature = null;
        foreach (var f in data.rendererFeatures)
            if (f is EID4922SkyRendererFeature) feature = (EID4922SkyRendererFeature)f;
        if (feature == null)
        {
            feature = ScriptableObject.CreateInstance<EID4922SkyRendererFeature>();
            feature.name = "EID4922SkyRendererFeature";
            AssetDatabase.AddObjectToAsset(feature, data);
            data.rendererFeatures.Add(feature);
        }
        feature.settings.profile = profile;
        feature.settings.onlyCameraWithMarker = true;
        feature.settings.renderInSceneView = true;
        feature.settings.renderInGameView = true;
        feature.settings.injectionPoint = EID4922SkyRendererFeature.StableSkyPassEvent;
        SerializedObject serialized = new SerializedObject(data);
        SerializedProperty map = serialized.FindProperty("m_RendererFeatureMap");
        if (map != null)
        {
            map.arraySize = data.rendererFeatures.Count;
            for (int i = 0; i < data.rendererFeatures.Count; i++)
            {
                AssetDatabase.TryGetGUIDAndLocalFileIdentifier(data.rendererFeatures[i], out string _, out long localId);
                map.GetArrayElementAtIndex(i).longValue = localId;
            }
        }
        serialized.ApplyModifiedPropertiesWithoutUndo();
        EditorUtility.SetDirty(feature); EditorUtility.SetDirty(data);
    }

    static void CreateScene()
    {
        Scene scene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Single);
        GameObject go = new GameObject("EID4922 RenderDoc Sky Camera");
        Camera cam = go.AddComponent<Camera>();
        go.AddComponent<EID4922SkyCamera>();
        cam.name = "EID4922_RenderDocCamera";
        cam.clearFlags = CameraClearFlags.SolidColor; cam.backgroundColor = Color.black;
        cam.fieldOfView = 60f; cam.nearClipPlane = 0.1f; cam.farClipPlane = 20000f;
        cam.transform.position = new Vector3(-560.8156f, 108.86644f, -410.79202f);
        Vector3 forward = new Vector3(0.943416f, 0.061641f, -0.325833f);
        Vector3 up = new Vector3(0f, 0.982572f, 0.185882f);
        cam.transform.rotation = Quaternion.LookRotation(forward, up);
        cam.depthTextureMode = DepthTextureMode.Depth;
        GameObject root = new GameObject("EID4922 RenderDoc Sky Workspace");
        root.transform.position = cam.transform.position;
        EditorSceneManager.SaveScene(scene, ScenePath);
    }
    [MenuItem("EID4922/Attach Sky Marker To EID3336 RenderDoc Camera")]
    public static void AttachToTargetScene()
    {
        const string target = "Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
        Scene scene = EditorSceneManager.OpenScene(target, OpenSceneMode.Single);
        Camera[] cameras = UnityEngine.Object.FindObjectsOfType<Camera>(true);
        if (cameras.Length == 0) throw new System.Exception("No camera found in target scene");
        Camera selected = cameras[0];
        foreach (Camera c in cameras) if (c.name.IndexOf("RenderDoc", System.StringComparison.OrdinalIgnoreCase) >= 0) { selected = c; break; }
        EID4922SkyCamera marker = selected.GetComponent<EID4922SkyCamera>();
        if (marker == null) marker = selected.gameObject.AddComponent<EID4922SkyCamera>();
        marker.enabledForSky = true;
        EditorSceneManager.MarkSceneDirty(scene); EditorSceneManager.SaveScene(scene);
        Debug.Log("[EID4922] marker attached to target camera: " + selected.name);
    }


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
        material.SetFloat("_EID4922Cull", 0f); material.SetFloat("_EID4922ZTest", 4f); material.SetFloat("_EID4922DebugMode", 0f); EditorUtility.SetDirty(material); AssetDatabase.SaveAssets();
        Debug.Log("[EID4922] diagnostic variants captured");
    }


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


    [MenuItem("EID4922/Capture Realtime Camera Views")]
    public static void CaptureRealtimeCameraViews()
    {
        EditorSceneManager.OpenScene(ScenePath, OpenSceneMode.Single);
        Camera camera = null;
        foreach (Camera item in UnityEngine.Object.FindObjectsOfType<Camera>(true))
        {
            camera = item;
            if (item.name == "EID4922_RenderDocCamera") break;
        }
        if (camera == null) throw new System.Exception("EID4922 realtime validation camera is missing");

        Directory.CreateDirectory("Validation/EID4922");
        Quaternion originalRotation = camera.transform.rotation;
        CaptureCameraPng(camera, Path.GetFullPath("Validation/EID4922/EID4922_RealtimeView_A.png"));
        camera.transform.rotation = Quaternion.Euler(0f, 45f, 0f) * originalRotation;
        CaptureCameraPng(camera, Path.GetFullPath("Validation/EID4922/EID4922_RealtimeView_B.png"));
        camera.transform.rotation = originalRotation;
        Debug.Log("[EID4922] realtime camera views captured");
    }

    static void CaptureCameraPng(Camera camera, string output)
    {
        RenderTexture rt = new RenderTexture(683, 384, 24, RenderTextureFormat.ARGBHalf, RenderTextureReadWrite.Linear);
        rt.Create();
        RenderTexture previous = camera.targetTexture;
        RenderTexture active = RenderTexture.active;
        camera.targetTexture = rt;
        camera.Render();
        RenderTexture.active = rt;
        Texture2D image = new Texture2D(rt.width, rt.height, TextureFormat.RGBA32, false, true);
        image.ReadPixels(new Rect(0, 0, rt.width, rt.height), 0, 0, false);
        image.Apply(false, false);
        File.WriteAllBytes(output, image.EncodeToPNG());
        camera.targetTexture = previous;
        RenderTexture.active = active;
        rt.Release();
        UnityEngine.Object.DestroyImmediate(rt);
        UnityEngine.Object.DestroyImmediate(image);
    }

}


#endif


