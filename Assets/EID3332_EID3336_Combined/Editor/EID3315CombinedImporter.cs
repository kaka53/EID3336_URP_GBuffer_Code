#if UNITY_EDITOR
using System;
using System.IO;
using System.Linq;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

public static class EID3315CombinedImporter
{
    const string Root = "Assets/EID3332_EID3336_Combined";
    const string ScenePath = Root + "/Scenes/EID3332_EID3336_Combined.unity";
    const string ModelPath = Root + "/Models/eid_3315_world.fbx";
    const string ProfilePath = Root + "/Profiles/EID3315_DrawProfile.asset";
    const string SharedShaderPath = Root + "/Geometry/EID3332CombinedSharedMRT.shader";
    const string MaterialPath = Root + "/Geometry/EID3332CombinedSharedMRT_EID3315.mat";
    const string TextureSourceMaterialPath = Root + "/Geometry/EID3315CapturedTextureTable.mat";
    const string ReportPath = Root + "/Validation/EID3315_IMPORT_REPORT.txt";

    [MenuItem("Tools/EID3332+3336/Add EID3315 To Combined Scene")]
    public static void ImportIntoCombinedScene()
    {
        AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
        ConfigureModelImporter();
        AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);

        Shader shader = AssetDatabase.LoadAssetAtPath<Shader>(SharedShaderPath);
        GameObject modelAsset = AssetDatabase.LoadAssetAtPath<GameObject>(ModelPath);
        Material textureSource = AssetDatabase.LoadAssetAtPath<Material>(TextureSourceMaterialPath);
        TextAsset exportMetadata = AssetDatabase.LoadAssetAtPath<TextAsset>(Root + "/CapturedResources/EID3315/eid_3315_world_export.json");
        TextAsset instanceMetadata = AssetDatabase.LoadAssetAtPath<TextAsset>(Root + "/CapturedResources/EID3315/eid_3315_world_instances.csv");
        if (shader == null || modelAsset == null || textureSource == null || exportMetadata == null || instanceMetadata == null)
            throw new InvalidOperationException("EID3315 import assets are incomplete.");

        Material material = AssetDatabase.LoadAssetAtPath<Material>(MaterialPath);
        if (material == null)
        {
            material = new Material(shader) { name = "EID3315 Profile - Shared VS209986 PS209987" };
            AssetDatabase.CreateAsset(material, MaterialPath);
        }
        else
        {
            material.shader = shader;
            material.name = "EID3315 Profile - Shared VS209986 PS209987";
        }

        EID3332CombinedDrawProfile profile = AssetDatabase.LoadAssetAtPath<EID3332CombinedDrawProfile>(ProfilePath);
        if (profile == null)
        {
            profile = ScriptableObject.CreateInstance<EID3332CombinedDrawProfile>();
            AssetDatabase.CreateAsset(profile, ProfilePath);
        }
        profile.name = "EID3315 Draw Profile";
        profile.eventId = 3315;
        profile.indexCount = 23853;
        profile.instanceCount = 1;
        profile.indexOffset = 0;
        profile.baseVertex = 0;
        profile.vertexCount = 4766;
        profile.triangleCount = 7951;
        profile.vertexDataSource = Root + "/Resources/EID3315Raw/vertex_stream0.bytes + vertex_stream1.bytes";
        profile.indexDataSource = Root + "/Resources/EID3315Raw/indices_u16.bytes";
        profile.instanceDataSource = Root + "/CapturedResources/EID3315/eid_3315_world_instances.csv";
        profile.materialConstantsSource = "EID3315 captured VS209986/PS209987 constant buffers";
        profile.textureResourceGroup = "EID3315Textures";
        profile.verticesAlreadyWorldSpace = false;
        profile.applyExportMirrorX = false;
        profile.shaderInstanceOffset = 0;
        profile.vertexStream1StrideBytes = 8;
        profile.baseColorTextureId = 271247;
        profile.baseNormalTextureId = 198537;
        profile.layerControlTextureId = 227514;
        profile.detailNormalTextureId = 197602;
        profile.grassBlendMaskTextureId = 198541;
        // EID3315 DirectPort validation disables the screen-space VT/page-table branch.
        // Its captured depth/page-table inputs do not remain valid in the combined/live camera path.
        profile.enableVirtualTextureBranchInCapturedProjection = false;
        profile.enableVirtualTextureBranchInCurrentCamera = false;
        profile.flipMaterialUvY = false;
        // The combined scene reconstructs only the imported EIDs, so the original full-scene depth-delta mask is optional and disabled by default.
        profile.useCapturedVisibilityMaskInCapturedProjection = true;
        profile.capturedVisibilityFlipY = true;
        profile.capturedVisibilityMask = AssetDatabase.LoadAssetAtPath<Texture2D>("Assets/EID3315_GeometryTest/Reference/EID3315_RenderDocDepthDeltaVisibility.png");
        profile.textureSourceMaterial = textureSource;
        profile.modelAsset = modelAsset;
        profile.exportMetadata = exportMetadata;
        profile.instanceMetadata = instanceMetadata;
        EditorUtility.SetDirty(profile);
        EditorUtility.SetDirty(material);
        AssetDatabase.SaveAssets();

        Scene scene = SceneManager.GetActiveScene();
        if (!scene.IsValid() || scene.path != ScenePath)
            scene = EditorSceneManager.OpenScene(ScenePath, OpenSceneMode.Single);

        EID3332CombinedSceneMRTController mrt = UnityEngine.Object.FindObjectOfType<EID3332CombinedSceneMRTController>();
        EID3332CombinedDeferredController deferred = UnityEngine.Object.FindObjectOfType<EID3332CombinedDeferredController>();
        if (mrt == null || deferred == null)
            throw new InvalidOperationException("Combined deferred controller is missing from " + ScenePath);

        Transform modelCollection = GameObject.Find("Deferred Model Root")?.transform;
        if (modelCollection == null) throw new InvalidOperationException("Deferred Model Root is missing.");
        Transform root3315 = modelCollection.Find("EID3315 Models");
        if (root3315 == null)
        {
            GameObject rootObject = new GameObject("EID3315 Models");
            root3315 = rootObject.transform;
            root3315.SetParent(modelCollection, false);
        }
        root3315.SetSiblingIndex(0);
        for (int i = root3315.childCount - 1; i >= 0; --i)
            UnityEngine.Object.DestroyImmediate(root3315.GetChild(i).gameObject);

        GameObject model = PrefabUtility.InstantiatePrefab(modelAsset, scene) as GameObject;
        if (model == null) throw new InvalidOperationException("Could not instantiate EID3315 model.");
        model.name = "EID3315 World Model (4766v 7951t)";
        model.transform.SetParent(root3315, false);
        model.transform.localPosition = Vector3.zero;
        // The exported FBX uses the same world-space/Y-up/-Z-front convention as EID3332.
        // Keep exactly one Unity import correction so the selectable mesh matches captured world space.
        model.transform.localRotation = Quaternion.Euler(0f, -180f, 0f);
        model.transform.localScale = new Vector3(1f, 1f, -1f);

        EID3332CombinedSceneMaterialResources resources = mrt.GetComponents<EID3332CombinedSceneMaterialResources>()
            .FirstOrDefault(x => x != null && x.constantResourceRoot == "EID3315CB");
        if (resources == null) resources = mrt.gameObject.AddComponent<EID3332CombinedSceneMaterialResources>();
        resources.material = material;
        resources.constantResourceRoot = "EID3315CB";
        resources.vertexResourceRoot = "EID3315VS";
        resources.useCapturedInstanceTransforms = false;
        resources.sceneModelDataAlreadyWorldSpace = false;
        resources.sceneModelApplyExportMirrorX = false;
        resources.Reload();

        Renderer[] renderers = root3315.GetComponentsInChildren<Renderer>(true)
            .Where(x => x != null).OrderBy(x => x.name, StringComparer.Ordinal).ToArray();
        if (renderers.Length != 1)
            throw new InvalidOperationException("EID3315 must contain exactly one renderer; found " + renderers.Length + ".");
        Transform[] transforms = renderers.Select(x => x.transform).ToArray();
        Matrix4x4[] references = transforms.Select(x => x.localToWorldMatrix).ToArray();

        var binding = new EID3332CombinedSceneMRTController.ProfileBinding
        {
            profile = profile,
            modelRoot = root3315,
            material = material,
            resources = resources,
            instanceTransforms = transforms,
            instanceTransformReferences = references
        };
        var oldBindings = mrt.bindings ?? Array.Empty<EID3332CombinedSceneMRTController.ProfileBinding>();
        mrt.bindings = new[] { binding }.Concat(oldBindings.Where(x => x == null || x.profile == null || x.profile.eventId != 3315)).ToArray();
        mrt.Refresh();

        deferred.eid3315Root = root3315;
        deferred.RefreshRenderers();
        resources.ResetLiveTransformReferences();

        Bounds bounds = renderers[0].bounds;
        string report =
            "EID3315 IMPORT PASS\n" +
            "eventId=3315\nshader=VS209986/PS209987\nindexCount=23853\ninstanceCount=1\nvertexCount=4766\ntriangleCount=7951\n" +
            "drawOrder=" + string.Join(",", mrt.bindings.Where(x => x != null && x.profile != null).Select(x => x.profile.eventId.ToString()).ToArray()) + "\n" +
            "rendererCount=" + renderers.Length + "\n" +
            "selectionBoundsMin=" + bounds.min.ToString("R") + "\nselectionBoundsMax=" + bounds.max.ToString("R") + "\n" +
            "constantRoot=EID3315CB\nvertexRoot=EID3315VS\nrawRoot=EID3315Raw\ntextureSource=" + TextureSourceMaterialPath + "\n";
        File.WriteAllText(Path.Combine(Directory.GetParent(Application.dataPath).FullName, ReportPath), report);

        EditorUtility.SetDirty(root3315.gameObject);
        EditorUtility.SetDirty(resources);
        EditorUtility.SetDirty(mrt);
        EditorUtility.SetDirty(deferred);
        EditorSceneManager.MarkSceneDirty(scene);
        EditorSceneManager.SaveScene(scene, ScenePath);
        AssetDatabase.ImportAsset(ReportPath, ImportAssetOptions.ForceUpdate);
        AssetDatabase.SaveAssets();
        Debug.Log("[EID3315 Combined Import] COMPLETE. Draw order 3315 -> 3332 -> 3336; shared MRT/depth/B6 enabled.");
    }

    [MenuItem("Tools/EID3332+3336/Validate EID3315 Combined Output")]
    public static void ValidateCombinedOutput()
    {
        Scene scene = SceneManager.GetActiveScene();
        if (!scene.IsValid() || scene.path != ScenePath)
            scene = EditorSceneManager.OpenScene(ScenePath, OpenSceneMode.Single);

        EID3332CombinedSceneMRTController mrt = UnityEngine.Object.FindObjectOfType<EID3332CombinedSceneMRTController>();
        EID3332CombinedDeferredController deferred = UnityEngine.Object.FindObjectOfType<EID3332CombinedDeferredController>();
        if (mrt == null || deferred == null || deferred.targetCamera == null || deferred.targets == null)
            throw new InvalidOperationException("Combined EID3315 validation objects are missing.");

        var binding3315 = (mrt.bindings ?? Array.Empty<EID3332CombinedSceneMRTController.ProfileBinding>())
            .FirstOrDefault(x => x != null && x.profile != null && x.profile.eventId == 3315);
        if (binding3315 == null || binding3315.modelRoot == null || binding3315.resources == null || binding3315.material == null)
            throw new InvalidOperationException("EID3315 binding is incomplete.");
        if (mrt.bindings.Length < 3 || mrt.bindings[0] != binding3315)
            throw new InvalidOperationException("Draw order must start with EID3315 and contain all three profiles.");
        if (binding3315.profile.indexCount != 23853 || binding3315.profile.instanceCount != 1 || binding3315.profile.vertexCount != 4766 || binding3315.profile.triangleCount != 7951)
            throw new InvalidOperationException("EID3315 draw profile parameters do not match RenderDoc.");
        if (binding3315.profile.textureSourceMaterial == null)
            throw new InvalidOperationException("EID3315 captured texture table is not bound.");

        string project = Directory.GetParent(Application.dataPath).FullName;
        foreach (string file in new[]
        {
            Root + "/Resources/EID3315Raw/vertex_stream0.bytes",
            Root + "/Resources/EID3315Raw/vertex_stream1.bytes",
            Root + "/Resources/EID3315Raw/vertex_constant_stream.bytes",
            Root + "/Resources/EID3315Raw/indices_u16.bytes",
            Root + "/Resources/EID3315VS/_28_30.bytes",
            Root + "/Resources/EID3315CB/_43_44.bytes"
        })
            if (!File.Exists(Path.Combine(project, file))) throw new FileNotFoundException("Missing EID3315 resource", file);

        bool root3315State = binding3315.modelRoot.gameObject.activeSelf;
        bool root3332State = deferred.eid3332Root != null && deferred.eid3332Root.gameObject.activeSelf;
        bool root3336State = deferred.eid3336Root != null && deferred.eid3336Root.gameObject.activeSelf;
        EID3332CombinedDeferredController.ProjectionSource oldProjection = deferred.projectionSource;
        RenderTexture oldTarget = deferred.targetCamera.targetTexture;
        const int width = 960, height = 540;
        RenderTexture output = new RenderTexture(width, height, 24, RenderTextureFormat.ARGB32)
        {
            name = "EID3315 Combined Validation Output"
        };
        output.Create();

        try
        {
            binding3315.modelRoot.gameObject.SetActive(true);
            if (deferred.eid3332Root != null) deferred.eid3332Root.gameObject.SetActive(false);
            if (deferred.eid3336Root != null) deferred.eid3336Root.gameObject.SetActive(false);
            deferred.projectionSource = EID3332CombinedDeferredController.ProjectionSource.RenderDocCaptured;
            deferred.targetCamera.targetTexture = output;
            binding3315.resources.Reload();
            mrt.Refresh();
            deferred.RefreshRenderers();
            deferred.targetCamera.Render();

            int onlyMrtPixels = SaveTexture(deferred.targets.GetColor(4), Root + "/Validation/EID3315_Only_RenderDocCaptured_MRT4.png");
            int onlyFinalPixels = SaveTexture(output, Root + "/Validation/EID3315_Only_RenderDocCaptured_Final.png");
            if (onlyMrtPixels == 0 || onlyFinalPixels == 0)
                throw new InvalidOperationException("EID3315-only render is empty.");

            if (deferred.eid3332Root != null) deferred.eid3332Root.gameObject.SetActive(true);
            if (deferred.eid3336Root != null) deferred.eid3336Root.gameObject.SetActive(true);
            mrt.Refresh();
            deferred.RefreshRenderers();
            deferred.targetCamera.Render();
            int combinedPixels = SaveTexture(output, Root + "/Validation/EID3315_EID3332_EID3336_RenderDocCaptured_Final.png");
            if (combinedPixels == 0) throw new InvalidOperationException("Three-profile combined render is empty.");

            File.AppendAllText(Path.Combine(project, ReportPath),
                "validation=PASS\nEID3315OnlyMRT4Pixels=" + onlyMrtPixels +
                "\nEID3315OnlyFinalPixels=" + onlyFinalPixels +
                "\nCombinedFinalPixels=" + combinedPixels + "\n");
            AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
            Debug.Log("[EID3315 Combined Validation] PASS. EID3315-only and three-profile final outputs are non-empty.");
        }
        finally
        {
            binding3315.modelRoot.gameObject.SetActive(root3315State);
            if (deferred.eid3332Root != null) deferred.eid3332Root.gameObject.SetActive(root3332State);
            if (deferred.eid3336Root != null) deferred.eid3336Root.gameObject.SetActive(root3336State);
            deferred.projectionSource = oldProjection;
            deferred.targetCamera.targetTexture = oldTarget;
            output.Release();
            UnityEngine.Object.DestroyImmediate(output);
            mrt.Refresh();
            deferred.RefreshRenderers();
            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene, ScenePath);
        }
    }

    static int SaveTexture(RenderTexture source, string assetPath)
    {
        if (source == null) return 0;
        RenderTexture staging = RenderTexture.GetTemporary(source.width, source.height, 0, RenderTextureFormat.ARGB32, RenderTextureReadWrite.Linear);
        Graphics.Blit(source, staging);
        RenderTexture previous = RenderTexture.active;
        RenderTexture.active = staging;
        Texture2D image = new Texture2D(staging.width, staging.height, TextureFormat.RGBA32, false, true);
        image.ReadPixels(new Rect(0, 0, staging.width, staging.height), 0, 0);
        image.Apply(false, false);
        Color32[] pixels = image.GetPixels32();
        int nonBlack = 0;
        for (int i = 0; i < pixels.Length; ++i)
            if (pixels[i].r > 2 || pixels[i].g > 2 || pixels[i].b > 2 || pixels[i].a > 2) ++nonBlack;
        string absolute = Path.Combine(Directory.GetParent(Application.dataPath).FullName, assetPath);
        File.WriteAllBytes(absolute, image.EncodeToPNG());
        UnityEngine.Object.DestroyImmediate(image);
        RenderTexture.active = previous;
        RenderTexture.ReleaseTemporary(staging);
        return nonBlack;
    }
    static void ConfigureModelImporter()
    {
        ModelImporter importer = AssetImporter.GetAtPath(ModelPath) as ModelImporter;
        if (importer == null) return;
        importer.globalScale = 1f;
        importer.useFileScale = true;
        importer.importCameras = false;
        importer.importLights = false;
        importer.importAnimation = false;
        importer.isReadable = true;
        importer.SaveAndReimport();
    }
}
#endif




