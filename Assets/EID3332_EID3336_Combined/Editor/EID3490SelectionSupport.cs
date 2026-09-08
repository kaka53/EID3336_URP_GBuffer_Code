#if UNITY_EDITOR
using System;
using System.Linq;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

/// <summary>
/// Keeps EID3490 selectable exactly like the other reconstructed model
/// profiles. The proxy mesh is made from the same raw draw streams used by
/// the procedural MRT path, while the proxy material exposes Unity URP's
/// Picking and SceneSelection passes for SceneView outline/highlight.
/// </summary>
[InitializeOnLoad]
public static class EID3490SelectionSupport
{
    const string Root = "Assets/EID3332_EID3336_Combined";
    const string ScenePath = Root + "/Scenes/EID3332_EID3336_Combined.unity";
    const string MaterialPath = Root + "/Geometry/EID3490SelectionProxy.mat";
    static bool repairInProgress;

    static EID3490SelectionSupport()
    {
        EditorApplication.delayCall -= RepairOpenCombinedScene;
        EditorApplication.delayCall += RepairOpenCombinedScene;
        EditorSceneManager.sceneOpened -= OnSceneOpened;
        EditorSceneManager.sceneOpened += OnSceneOpened;
    }

    static void OnSceneOpened(Scene scene, OpenSceneMode mode)
    {
        if (!scene.IsValid() || scene.path != ScenePath) return;
        EditorApplication.delayCall -= RepairOpenCombinedScene;
        EditorApplication.delayCall += RepairOpenCombinedScene;
    }

    [MenuItem("Tools/EID3332+3336/Repair EID3490 Selection Highlight")]
    public static void RepairOpenCombinedScene()
    {
        if (repairInProgress) return;
        repairInProgress = true;
        try
        {
            Scene scene = SceneManager.GetActiveScene();
            if (!scene.IsValid() || scene.path != ScenePath) return;

            GameObject rootObject = GameObject.Find("EID3490 Models");
            Material selectionMaterial = AssetDatabase.LoadAssetAtPath<Material>(MaterialPath);
            EID3332CombinedSceneMRTController mrt = UnityEngine.Object.FindObjectOfType<EID3332CombinedSceneMRTController>(true);
            if (rootObject == null || selectionMaterial == null || mrt == null) return;

            // EID3490's recovered index winding can be mirrored. Keep the
            // editor proxy double-sided, matching the reconstructed draw.
            if (selectionMaterial.HasProperty("_CullMode"))
            {
                selectionMaterial.SetFloat("_CullMode", 0f);
                EditorUtility.SetDirty(selectionMaterial);
            }

            EID3332CombinedSceneMRTController.ProfileBinding binding = (mrt.bindings ?? Array.Empty<EID3332CombinedSceneMRTController.ProfileBinding>())
                .FirstOrDefault(x => x != null && x.profile != null && x.profile.eventId == 3490);
            if (binding == null || binding.resources == null) return;

            binding.resources.Reload();
            Renderer[] renderers = rootObject.GetComponentsInChildren<MeshRenderer>(true)
                .OrderBy(x => x.name, StringComparer.Ordinal).ToArray();
            int repaired = 0;
            var transforms = new Transform[renderers.Length];
            var references = new Matrix4x4[renderers.Length];
            for (int i = 0; i < renderers.Length; ++i)
            {
                Renderer renderer = renderers[i];
                if (renderer == null) continue;
                if (!binding.resources.TryGetCapturedInstanceMatrix(i, out Matrix4x4 captured)) continue;

                EID3490SelectionProxyBuilder.RebuildRenderer(renderer.gameObject, i, captured, rootObject.transform, selectionMaterial);
                transforms[i] = renderer.transform;
                references[i] = renderer.transform.localToWorldMatrix;
                repaired++;
            }

            if (repaired == 0) return;
            if (selectionMaterial.shader == null || selectionMaterial.FindPass("ScenePickingPass") < 0 || selectionMaterial.FindPass("SceneSelectionPass") < 0)
                Debug.LogError("[EID3490 Selection] URP editor picking passes are missing from the proxy shader.");

            binding.instanceTransforms = transforms;
            binding.instanceTransformReferences = references;
            binding.resources.ResetLiveTransformReferences();
            mrt.Refresh();
            SceneView.RepaintAll();

            EditorUtility.SetDirty(rootObject);
            EditorUtility.SetDirty(binding.resources);
            EditorUtility.SetDirty(mrt);
            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
            Debug.Log("[EID3490 Selection] Rebuilt " + repaired + " proxy renderer(s) from raw 324-vertex draw data; SceneView picking/outline now follows the reconstructed geometry.");
        }
        finally
        {
            repairInProgress = false;
        }
    }
}
#endif

