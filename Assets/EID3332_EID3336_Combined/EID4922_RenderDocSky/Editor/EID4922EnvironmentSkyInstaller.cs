#if UNITY_EDITOR
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

[InitializeOnLoad]
public static class EID4922EnvironmentSkyInstaller
{
    const string Root = "Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky";
    const string ProfilePath = Root + "/Settings/EID4922SkyProfile.asset";
    const string MaterialPath = Root + "/Materials/EID4922EnvironmentSkybox.mat";
    const string ShaderName = "EID4922/EnvironmentSkybox";
    const string TargetScene = "Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
    const string RendererPath = "Assets/EID3332_EID3336_Combined/Settings/EID3332Combined-Renderer.asset";

    static EID4922EnvironmentSkyInstaller()
    {
        // Environment Skybox mode is intentionally disabled. The active route
        // is EID4922SkyRendererFeature; keep installation manual only.
    }

    static void InstallForWorkspace()
    {
        if (SessionState.GetBool("EID4922EnvironmentSkyInstalled", false)) return;
        if (EditorApplication.isCompiling || EditorApplication.isUpdating)
        {
            EditorApplication.delayCall += InstallForWorkspace;
            return;
        }
        Install(true);
        SessionState.SetBool("EID4922EnvironmentSkyInstalled", true);
    }

    [MenuItem("EID4922/Install Native Environment Skybox")]
    public static void InstallFromMenu() => Install(true);

    static void InstallIfTargetSceneIsOpen()
    {
        if (EditorApplication.isCompiling || EditorApplication.isUpdating) return;
        if (EditorSceneManager.GetActiveScene().path == TargetScene)
            Install(false);
    }

    static void Install(bool openTargetScene)
    {
        if (EditorApplication.isCompiling || EditorApplication.isUpdating) return;
        AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);

        if (openTargetScene && EditorSceneManager.GetActiveScene().path != TargetScene)
            EditorSceneManager.OpenScene(TargetScene, OpenSceneMode.Single);

        EID4922SkyProfile profile = AssetDatabase.LoadAssetAtPath<EID4922SkyProfile>(ProfilePath);
        Shader shader = Shader.Find(ShaderName);
        if (profile == null || shader == null)
        {
            Debug.LogWarning("[EID4922] Native skybox install deferred: profile or shader is not imported yet.");
            return;
        }

        Material material = AssetDatabase.LoadAssetAtPath<Material>(MaterialPath);
        if (material == null)
        {
            material = new Material(shader) { name = "EID4922EnvironmentSkybox" };
            AssetDatabase.CreateAsset(material, MaterialPath);
        }
        else
        {
            material.shader = shader;
        }
        SetTexture(material, "_EID4922Res19", profile.res19);
        SetTexture(material, "_EID4922Res29", profile.res29);
        SetTexture(material, "_EID4922Res27", profile.res27);
        SetTexture(material, "_EID4922Res25", profile.res25);
        SetTexture(material, "_EID4922Res23", profile.res23);
        SetTexture(material, "_EID4922Res21", profile.res21);
        SetTexture(material, "_EID4922Res20", profile.res20);
        SetTexture(material, "_EID4922Res18", profile.res18);
        material.SetFloat("_EID4922ZTest", (float)CompareFunction.Always);
        EditorUtility.SetDirty(material);

        DisableCustomDrawFeature();

        Scene scene = EditorSceneManager.GetActiveScene();
        if (scene.path != TargetScene)
        {
            Debug.LogWarning("[EID4922] Native skybox material created, but target scene is not active: " + scene.path);
            AssetDatabase.SaveAssets();
            return;
        }

        RenderSettings.skybox = material;
        foreach (Camera camera in Object.FindObjectsOfType<Camera>(true))
            camera.clearFlags = CameraClearFlags.Skybox;

        GameObject root = GameObject.Find("EID4922EnvironmentSky");
        if (root == null) root = new GameObject("EID4922EnvironmentSky");
        EID4922EnvironmentSkyBinder binder = root.GetComponent<EID4922EnvironmentSkyBinder>();
        if (binder == null) binder = root.AddComponent<EID4922EnvironmentSkyBinder>();
        binder.profile = profile;
        binder.environmentMaterial = material;
        binder.geometryRadius = Mathf.Max(1f, profile.skyRadius);
        binder.assignRenderSettingsSkybox = true;
        EditorUtility.SetDirty(root);
        EditorSceneManager.MarkSceneDirty(scene);
        EditorSceneManager.SaveScene(scene);
        AssetDatabase.SaveAssets();
        Debug.Log("[EID4922] Native Environment Skybox installed: " + MaterialPath);
    }

    static void SetTexture(Material material, string property, Texture texture)
    {
        if (texture != null && material.HasProperty(property)) material.SetTexture(property, texture);
    }

    static void DisableCustomDrawFeature()
    {
        UniversalRendererData renderer = AssetDatabase.LoadAssetAtPath<UniversalRendererData>(RendererPath);
        if (renderer == null) return;
        foreach (ScriptableRendererFeature feature in renderer.rendererFeatures)
        {
            if (feature is EID4922SkyRendererFeature sky)
            {
                // The native Environment Skybox now owns this draw. Disable the
                // legacy command-buffer DrawMesh feature entirely to prevent a
                // second sky render or accumulation in SceneView/GameView.
                sky.settings.renderInSceneView = false;
                sky.settings.renderInGameView = false;
                sky.SetActive(false);
                EditorUtility.SetDirty(sky);
            }
        }
        EditorUtility.SetDirty(renderer);
    }
}
#endif

