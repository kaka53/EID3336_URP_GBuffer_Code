#if UNITY_EDITOR
using System;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;

/// <summary>
/// One-time migration from controller/profile-owned tuning to material-owned
/// tuning. Runtime camera matrices, object transforms, render targets, depth
/// and GPU buffers remain pipeline supplied.
/// </summary>
public static class EIDRouteBMaterialParameterMigration
{
    const string ScenePath = "Assets/EID3332_EID3336_Combined/Scenes/EID3332_EID3336_Combined.unity";

    [MenuItem("Tools/EID3332+3336/Route B/Bake Parameters Into Materials")]
    public static void BakeParametersIntoMaterials()
    {
        var scene = EditorSceneManager.OpenScene(ScenePath, OpenSceneMode.Single);
        if (!scene.IsValid()) throw new InvalidOperationException("Unable to open Route-B scene.");

        var controller = UnityEngine.Object.FindObjectOfType<EID3332CombinedDeferredController>(true);
        var adapter = UnityEngine.Object.FindObjectOfType<EID3336RouteBMeshRendererAdapter>(true);
        if (controller == null || adapter == null)
            throw new InvalidOperationException("Route-B controller or MeshRenderer adapter is missing.");

        // Bake B6 tunables and captured texture references once.
        controller.ApplyControllerB6TuningToMaterial();
        if (controller.b6LightingMaterial != null)
        {
            Material b6 = controller.b6LightingMaterial;
            b6.SetFloat("_EID3336B6UseURPGBuffer", 1f);
            b6.SetFloat("_EID3336B6MaterialTarget", 1f);
            b6.SetFloat("_EID3336B6NormalTarget", 2f);
            b6.SetFloat("_EID3336B6BaseColorTarget", 0f);
            b6.SetFloat("_EID3336B6ReconstructionFlipY", 0f);
            b6.SetFloat("_EID3336B6FlipY", 0f);
            EditorUtility.SetDirty(b6);
        }
        controller.b6MaterialOwnsTuningParameters = true;
        EditorUtility.SetDirty(controller);

        // Bake each profile's textures and non-live switches into its material.
        if (adapter.entries != null)
        {
            foreach (var entry in adapter.entries)
            {
                if (entry == null || entry.profile == null) continue;
                Material material = entry.material != null ? entry.material : adapter.routeBMaterial;
                if (material == null) continue;
                if (entry.resources != null)
                {
                    entry.resources.material = material;
                    entry.resources.BindProfileTextures(entry.profile);
                    entry.resources.ApplyProfileStreamLayout(entry.profile);
                    entry.resources.BindForDraw(true);
                    EditorUtility.SetDirty(entry.resources);
                }
                material.SetFloat("_EID3336SceneModelDataInWorldSpace", entry.profile.verticesAlreadyWorldSpace ? 1f : 0f);
                material.SetFloat("_EID3332CombinedFlipMaterialUVY", entry.profile.flipMaterialUvY ? 1f : 0f);
                material.SetFloat("_EID3332CombinedEnableVirtualTextureBranch", entry.profile.enableVirtualTextureBranchInCurrentCamera ? 1f : 0f);
                material.SetFloat("_EID3336UseVisibilityMask", 0f);
                material.SetFloat("_EID3336VisibilityFlipY", 0f);
                material.SetFloat("_EIDRouteBMetallicScale", 1f);
                material.SetFloat("_EIDRouteBRoughnessScale", 1f);
                material.SetFloat("_EIDRouteBOcclusionScale", 1f);
                material.SetFloat("_EIDRouteBNormalStrength", 1f);
                EditorUtility.SetDirty(material);
            }
        }
        adapter.materialOwnsProfileParameters = true;
        EditorUtility.SetDirty(adapter);

        EditorSceneManager.MarkSceneDirty(scene);
        EditorSceneManager.SaveScene(scene);
        AssetDatabase.SaveAssets();
        AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
        Debug.Log("[EID Route B] Material parameter migration PASS. Tunables are material-owned; live camera/Transform/RT/buffers remain pipeline-owned.");
    }
}
#endif
