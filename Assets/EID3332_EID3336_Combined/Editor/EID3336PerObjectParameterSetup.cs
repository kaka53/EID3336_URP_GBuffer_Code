#if UNITY_EDITOR
using System;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

/// <summary>
/// Explicit one-time installer/repair tool. It never runs on scene-open and never
/// silently saves a production scene. Every Renderer participating in the combined
/// MRT pass receives one visible EID3336GBufferObjectParameters component.
/// </summary>
public static class EID3336PerObjectParameterSetup
{
    const string CombinedScenePath = "Assets/EID3332_EID3336_Combined/Scenes/EID3332_EID3336_Combined.unity";

    [MenuItem("Tools/EID3332+3336/Install Per-GameObject GBuffer Parameters")]
    public static void InstallActiveScene()
    {
        Scene scene = SceneManager.GetActiveScene();
        if (!scene.IsValid()) throw new InvalidOperationException("No active scene.");
        Install(scene, true);
    }

    // Safe batch entry point used by validation/CI. Opening and saving the scene
    // is explicit here; there is no InitializeOnLoad callback.
    public static void InstallCombinedSceneBatch()
    {
        Scene scene = EditorSceneManager.OpenScene(CombinedScenePath, OpenSceneMode.Single);
        if (!scene.IsValid()) throw new InvalidOperationException("Unable to open " + CombinedScenePath);
        Install(scene, true);
        Debug.Log("[EID GBuffer Per-Object] BATCH INSTALL PASS");
    }

    [MenuItem("Tools/EID3332+3336/Validate Per-GameObject GBuffer Parameters")]
    public static void ValidateActiveScene()
    {
        Scene scene = SceneManager.GetActiveScene();
        int count = Validate(scene, true);
        Debug.Log("[EID GBuffer Per-Object] VALIDATION PASS renderers=" + count + " scene=" + scene.path);
    }

    static void Install(Scene scene, bool save)
    {
        bool changed = false;
        int rendererCount = 0;
        EID3332CombinedSceneMRTController[] controllers =
            UnityEngine.Object.FindObjectsOfType<EID3332CombinedSceneMRTController>(true);

        foreach (EID3332CombinedSceneMRTController controller in controllers)
        {
            if (controller == null || controller.gameObject.scene != scene) continue;
            controller.Refresh();
            if (controller.bindings == null) continue;

            foreach (EID3332CombinedSceneMRTController.ProfileBinding binding in controller.bindings)
            {
                if (binding == null || binding.profile == null || binding.renderers == null) continue;
                EID3332CombinedSceneMaterialResources resources = binding.resources != null
                    ? binding.resources : controller.resources;
                Material material = binding.material != null ? binding.material : controller.sharedMrtMaterial;

                foreach (Renderer renderer in binding.renderers)
                {
                    if (renderer == null) continue;
                    rendererCount++;
                    changed |= Ensure(renderer.gameObject, binding.profile, resources, material);
                }
            }
        }

        if (rendererCount == 0)
            throw new InvalidOperationException("No MRT renderers were found in " + scene.path);
        Validate(scene, false);

        if (changed)
        {
            EditorSceneManager.MarkSceneDirty(scene);
            if (save) EditorSceneManager.SaveScene(scene);
            AssetDatabase.SaveAssets();
        }
        Debug.Log("[EID GBuffer Per-Object] installed/repaired components=" + rendererCount +
                  " changed=" + changed + " scene=" + scene.path);
    }

    static bool Ensure(GameObject gameObject, EID3332CombinedDrawProfile profile,
        EID3332CombinedSceneMaterialResources resources, Material material)
    {
        EID3336GBufferObjectParameters component =
            gameObject.GetComponent<EID3336GBufferObjectParameters>();
        bool created = component == null;
        if (created)
            component = Undo.AddComponent<EID3336GBufferObjectParameters>(gameObject);

        bool contractChanged = component.eventId != profile.eventId ||
                               component.drawProfile != profile ||
                               component.drawResources != resources ||
                               component.drawMaterial != material;
        if (created || contractChanged)
        {
            Undo.RecordObject(component, "Configure recovered GBuffer draw");
            component.Configure(profile, resources, material, true);
            EditorUtility.SetDirty(component);
            return true;
        }
        return false;
    }

    static int Validate(Scene scene, bool throwOnFailure)
    {
        int count = 0;
        string failure = null;
        EID3332CombinedSceneMRTController[] controllers =
            UnityEngine.Object.FindObjectsOfType<EID3332CombinedSceneMRTController>(true);
        foreach (EID3332CombinedSceneMRTController controller in controllers)
        {
            if (controller == null || controller.gameObject.scene != scene) continue;
            controller.Refresh();
            if (controller.bindings == null) continue;
            foreach (EID3332CombinedSceneMRTController.ProfileBinding binding in controller.bindings)
            {
                if (binding == null || binding.profile == null || binding.renderers == null) continue;
                foreach (Renderer renderer in binding.renderers)
                {
                    if (renderer == null) continue;
                    count++;
                    EID3336GBufferObjectParameters component =
                        renderer.GetComponent<EID3336GBufferObjectParameters>();
                    if (component == null || !component.MatchesProfile(binding.profile) ||
                        component.drawResources == null || component.drawMaterial == null)
                    {
                        failure = "Renderer '" + renderer.name + "' does not own a complete parameter contract for EID" +
                                  binding.profile.eventId;
                        break;
                    }
                }
                if (failure != null) break;
            }
            if (failure != null) break;
        }
        if (failure != null && throwOnFailure) throw new InvalidOperationException(failure);
        if (failure != null) throw new InvalidOperationException(failure);
        return count;
    }
}
#endif
