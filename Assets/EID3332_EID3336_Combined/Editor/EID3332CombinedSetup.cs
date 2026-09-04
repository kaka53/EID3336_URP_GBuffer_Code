#if UNITY_EDITOR
using System;
using System.IO;
using System.Linq;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using UnityEngine.SceneManagement;

public static class EID3332CombinedSetup
{
    public const string Root = "Assets/EID3332_EID3336_Combined";
    public const string IsolatedScene = Root + "/Scenes/EID3332_Isolated.unity";
    public const string CombinedScene = Root + "/Scenes/EID3332_EID3336_Combined.unity";
    public const string RendererPath = Root + "/Settings/EID3332Combined-Renderer.asset";
    public const string PipelinePath = Root + "/Settings/EID3332Combined-URP.asset";
    public const string Profile3332Path = Root + "/Profiles/EID3332_DrawProfile.asset";
    public const string Profile3336Path = Root + "/Profiles/EID3336_DrawProfile.asset";

    const string SourceRenderer = "Assets/EID3336_URP_Reconstruction/DeferredLightingStage6/Settings/EID3336DeferredStage6-Renderer.asset";
    const string SourcePipeline = "Assets/EID3336_URP_Reconstruction/DeferredLightingStage6/Settings/EID3336DeferredStage6-URP.asset";

    [MenuItem("Tools/EID3332+3336/Build Independent Workspace")]
    public static void Build()
    {
        EnsureFolders();
        AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
        ConfigureModelImporter(Root + "/Models/eid_3332_world.fbx");
        ConfigureModelImporter(Root + "/Models/eid_3336_world.fbx");
        AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);

        Material fallback = MaterialAt(Root + "/Geometry/EID3332CombinedGBuffer.shader", Root + "/Geometry/EID3332CombinedGBuffer.mat", "EID3332Combined GBuffer Diagnostics");
        Material shared3332 = MaterialAt(Root + "/Geometry/EID3332CombinedSharedMRT.shader", Root + "/Geometry/EID3332CombinedSharedMRT_EID3332.mat", "EID3332 Profile - Shared VS209986 PS209987");
        Material shared3336 = MaterialAt(Root + "/Geometry/EID3332CombinedSharedMRT.shader", Root + "/Geometry/EID3332CombinedSharedMRT_EID3336.mat", "EID3336 Profile - Shared VS209986 PS209987");
        Material b6 = MaterialAt(Root + "/Geometry/EID3332CombinedB6Lighting.shader", Root + "/Geometry/EID3332CombinedB6Lighting.mat", "EID3332+EID3336 Shared B6");
        Material composite = MaterialAt(Root + "/Geometry/EID3332CombinedComposite.shader", Root + "/Geometry/EID3332CombinedComposite.mat", "EID3332Combined Composite");

        EID3332CombinedDrawProfile p3332 = Profile(Profile3332Path, 3332, 4791, 1, 829, 1597,
            Root + "/Models/eid_3332_world.fbx",
            Root + "/CapturedResources/EID3332/eid_3332_world_export.json",
            Root + "/CapturedResources/EID3332/eid_3332_world_instances.csv");
        EID3332CombinedDrawProfile p3336 = Profile(Profile3336Path, 3336, 7980, 3, 5139, 7980,
            Root + "/Models/eid_3336_world.fbx",
            Root + "/CapturedResources/EID3336/eid_3336_world_export.json",
            Root + "/CapturedResources/EID3336/eid_3336_world_instances.csv");

        UniversalRendererData renderer = CreateRenderer();
        UniversalRenderPipelineAsset pipeline = CreatePipeline(renderer);
        CreateScene(IsolatedScene, true, fallback, shared3332, shared3336, b6, composite, pipeline, p3332, p3336);
        CreateScene(CombinedScene, false, fallback, shared3332, shared3336, b6, composite, pipeline, p3332, p3336);
        AssetDatabase.SaveAssets();
        AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
        Debug.Log("[EID3332Combined Setup] COMPLETE scenes=" + IsolatedScene + ", " + CombinedScene);
    }

    static void EnsureFolders()
    {
        string project = Directory.GetParent(Application.dataPath).FullName;
        foreach (string sub in new[] { "Scenes", "Runtime", "Geometry", "Editor", "Settings", "CapturedResources/EID3332", "CapturedResources/EID3336", "Models", "Profiles", "Validation" })
            Directory.CreateDirectory(Path.Combine(project, Root, sub));
    }

    static void ConfigureModelImporter(string path)
    {
        ModelImporter importer = AssetImporter.GetAtPath(path) as ModelImporter;
        if (importer == null) return;
        importer.globalScale = 1f;
        importer.useFileScale = true;
        importer.importCameras = false;
        importer.importLights = false;
        importer.importAnimation = false;
        importer.isReadable = true;
        importer.SaveAndReimport();
    }

    static Material MaterialAt(string shaderPath, string materialPath, string name)
    {
        Shader shader = AssetDatabase.LoadAssetAtPath<Shader>(shaderPath);
        if (shader == null) throw new InvalidOperationException("Missing shader: " + shaderPath);
        Material material = AssetDatabase.LoadAssetAtPath<Material>(materialPath);
        if (material == null) { material = new Material(shader) { name = name }; AssetDatabase.CreateAsset(material, materialPath); }
        else { material.shader = shader; material.name = name; }
        EditorUtility.SetDirty(material);
        return material;
    }

    static EID3332CombinedDrawProfile Profile(string path, int eid, int indices, int instances, int vertices, int triangles, string model, string json, string csv)
    {
        EID3332CombinedDrawProfile p = AssetDatabase.LoadAssetAtPath<EID3332CombinedDrawProfile>(path);
        if (p == null) { p = ScriptableObject.CreateInstance<EID3332CombinedDrawProfile>(); AssetDatabase.CreateAsset(p, path); }
        p.name = "EID" + eid + " Draw Profile";
        p.eventId = eid; p.indexCount = indices; p.instanceCount = instances; p.indexOffset = 0; p.baseVertex = 0;
        p.vertexCount = vertices; p.triangleCount = triangles;
        // Unity imports the one-node EID3332 FBX with X mirrored relative to the
        // RenderDoc world-space bbox. Its scene Transform carries the sole fix.
        // FBX world coordinates are preserved semantically, but Unity stores
        // the imported mesh behind axis-conversion transforms. Use RendererLocal
        // so the shader receives renderer.localToWorldMatrix for both profiles.
        p.verticesAlreadyWorldSpace = false;
        p.applyExportMirrorX = false; p.shaderInstanceOffset = 0;
        p.vertexStream1StrideBytes = 16;
        p.vertexDataSource = Root + "/Resources/EID" + eid + "Raw/vertex_stream0.bytes + vertex_stream1.bytes";
        p.indexDataSource = Root + "/Resources/EID" + eid + "Raw/indices_u16.bytes";
        p.instanceDataSource = csv; p.materialConstantsSource = "Shared VS209986/PS209987 captured constant buffers";
        p.textureResourceGroup = eid == 3332 ? "EID3332Textures" : "EID3336Textures";
        p.baseColorTextureId = 271247;
        p.baseNormalTextureId = eid == 3332 ? 222162 : 222331;
        p.layerControlTextureId = eid == 3332 ? 222165 : 224843;
        p.detailNormalTextureId = 197602;
        p.grassBlendMaskTextureId = eid == 3332 ? 247705 : 246832;
        p.modelAsset = AssetDatabase.LoadAssetAtPath<GameObject>(model);
        p.exportMetadata = AssetDatabase.LoadAssetAtPath<TextAsset>(json);
        p.instanceMetadata = AssetDatabase.LoadAssetAtPath<TextAsset>(csv);
        EditorUtility.SetDirty(p); return p;
    }

    static UniversalRendererData CreateRenderer()
    {
        if (AssetDatabase.LoadAssetAtPath<UnityEngine.Object>(RendererPath) != null) AssetDatabase.DeleteAsset(RendererPath);
        if (!AssetDatabase.CopyAsset(SourceRenderer, RendererPath)) throw new InvalidOperationException("Could not copy URP renderer source.");
        AssetDatabase.ImportAsset(RendererPath, ImportAssetOptions.ForceSynchronousImport);
        UniversalRendererData data = AssetDatabase.LoadAssetAtPath<UniversalRendererData>(RendererPath);
        foreach (UnityEngine.Object sub in AssetDatabase.LoadAllAssetsAtPath(RendererPath))
            if (sub != null && sub != data && sub is ScriptableRendererFeature) UnityEngine.Object.DestroyImmediate(sub, true);
        data.rendererFeatures.Clear();
        EID3332CombinedDeferredFeature feature = ScriptableObject.CreateInstance<EID3332CombinedDeferredFeature>();
        feature.name = "EID3332CombinedDeferredFeature";
        feature.settings.injectionPoint = RenderPassEvent.BeforeRenderingOpaques;
        feature.settings.previewPoint = RenderPassEvent.AfterRenderingPostProcessing;
        AssetDatabase.AddObjectToAsset(feature, data); data.rendererFeatures.Add(feature);
        AssetDatabase.TryGetGUIDAndLocalFileIdentifier(feature, out string _, out long localId);
        SerializedObject so = new SerializedObject(data);
        SerializedProperty map = so.FindProperty("m_RendererFeatureMap");
        if (map != null) { map.arraySize = 1; map.GetArrayElementAtIndex(0).longValue = localId; }
        SerializedProperty native = so.FindProperty("m_UseNativeRenderPass"); if (native != null) native.boolValue = false;
        so.ApplyModifiedPropertiesWithoutUndo(); EditorUtility.SetDirty(feature); EditorUtility.SetDirty(data);
        AssetDatabase.SaveAssets(); return data;
    }

    static UniversalRenderPipelineAsset CreatePipeline(UniversalRendererData renderer)
    {
        if (AssetDatabase.LoadAssetAtPath<UnityEngine.Object>(PipelinePath) != null) AssetDatabase.DeleteAsset(PipelinePath);
        if (!AssetDatabase.CopyAsset(SourcePipeline, PipelinePath)) throw new InvalidOperationException("Could not copy URP pipeline source.");
        AssetDatabase.ImportAsset(PipelinePath, ImportAssetOptions.ForceSynchronousImport);
        UniversalRenderPipelineAsset pipeline = AssetDatabase.LoadAssetAtPath<UniversalRenderPipelineAsset>(PipelinePath);
        pipeline.name = "EID3332Combined-URP";
        SerializedObject so = new SerializedObject(pipeline);
        SerializedProperty list = so.FindProperty("m_RendererDataList"); list.arraySize = 1; list.GetArrayElementAtIndex(0).objectReferenceValue = renderer;
        SerializedProperty index = so.FindProperty("m_DefaultRendererIndex"); if (index != null) index.intValue = 0;
        SerializedProperty msaa = so.FindProperty("m_MSAA"); if (msaa != null) msaa.intValue = 1;
        SerializedProperty scale = so.FindProperty("m_RenderScale"); if (scale != null) scale.floatValue = 1f;
        so.ApplyModifiedPropertiesWithoutUndo(); EditorUtility.SetDirty(pipeline); AssetDatabase.SaveAssets(); return pipeline;
    }

    static void CreateScene(string path, bool isolated, Material fallback, Material shared3332, Material shared3336, Material b6, Material composite,
        UniversalRenderPipelineAsset pipeline, EID3332CombinedDrawProfile p3332, EID3332CombinedDrawProfile p3336)
    {
        Scene previousActive = SceneManager.GetActiveScene();
        bool preservePrevious = previousActive.IsValid() && previousActive.isLoaded && !string.IsNullOrEmpty(previousActive.path);
        Scene scene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene,
            preservePrevious ? NewSceneMode.Additive : NewSceneMode.Single);
        scene.name = Path.GetFileNameWithoutExtension(path);
        SceneManager.SetActiveScene(scene);
        GameObject root = new GameObject("Deferred Model Root");
        GameObject root3332 = new GameObject("EID3332 Models"); root3332.transform.SetParent(root.transform, false);
        GameObject model3332 = PrefabUtility.InstantiatePrefab(p3332.modelAsset, scene) as GameObject;
        model3332.name = "EID3332 World Model (829v 1597t)"; model3332.transform.SetParent(root3332.transform, false); Reset(model3332.transform);
        // One correction only: RotateY(-180) * ScaleZ(-1) == mirror X.
        // This converts Unity's imported +X bbox back to RenderDoc's -X world bbox.
        model3332.transform.localRotation = Quaternion.Euler(0f, -180f, 0f);
        model3332.transform.localScale = new Vector3(1f, 1f, -1f);

        GameObject root3336 = new GameObject("EID3336 Models"); root3336.transform.SetParent(root.transform, false);
        GameObject model3336 = null;
        if (!isolated)
        {
            model3336 = PrefabUtility.InstantiatePrefab(p3336.modelAsset, scene) as GameObject;
            model3336.name = "EID3336 World Models (3 instances)"; model3336.transform.SetParent(root3336.transform, false); Reset(model3336.transform);
        }
        else root3336.SetActive(false);

        GameObject cameraGo = new GameObject("EID3332 Combined Deferred Camera");
        Camera camera = cameraGo.AddComponent<Camera>(); camera.tag = "MainCamera"; camera.clearFlags = CameraClearFlags.SolidColor;
        camera.backgroundColor = new Color(.035f, .045f, .06f, 1f); camera.cullingMask = 0; camera.allowHDR = true; camera.allowMSAA = false;
        camera.nearClipPlane = .05f; camera.farClipPlane = 5000f; camera.aspect = 1366f / 768f;
        FrameCamera(camera, root.GetComponentsInChildren<Renderer>(true));

        GameObject host = new GameObject("EID3332+EID3336 Combined Deferred Workspace");
        EID3332CombinedDeferredTargets targets = host.AddComponent<EID3332CombinedDeferredTargets>();
        targets.width = 1366; targets.height = 768; targets.debugFloatFormats = false;
        EID3332CombinedSceneMaterialResources resources3332 = host.AddComponent<EID3332CombinedSceneMaterialResources>();
        resources3332.material = shared3332; resources3332.constantResourceRoot = "EID3332CB"; resources3332.vertexResourceRoot = "EID3332VS"; resources3332.useCapturedInstanceTransforms = false; resources3332.sceneModelDataAlreadyWorldSpace = false; resources3332.sceneModelApplyExportMirrorX = false;
        resources3332.Reload();
        EID3332CombinedSceneMaterialResources resources3336 = null;
        Transform[] controls3336 = Array.Empty<Transform>();
        Matrix4x4[] controlReferences3336 = Array.Empty<Matrix4x4>();
        if (!isolated)
        {
            resources3336 = host.AddComponent<EID3332CombinedSceneMaterialResources>();
            resources3336.material = shared3336; resources3336.constantResourceRoot = "EID3336CB"; resources3336.vertexResourceRoot = "EID3336VS"; resources3336.useCapturedInstanceTransforms = false; resources3336.sceneModelDataAlreadyWorldSpace = false; resources3336.sceneModelApplyExportMirrorX = false;
            resources3336.Reload();
            controls3336 = EID3336CombinedLiveTransformRepair.CreateOrRepair(root3336.transform, resources3336);
            controls3336 = EID3336CombinedLiveTransformRepair.GetOrderedRenderers(root3336.transform).Take(3).Select(x => x.transform).ToArray();
            controlReferences3336 = controls3336.Select(x => x.localToWorldMatrix).ToArray();
        }
        EID3332CombinedSceneMRTController mrt = host.AddComponent<EID3332CombinedSceneMRTController>();
        mrt.sharedMrtMaterial = shared3332; mrt.resources = resources3332;
        mrt.bindings = isolated ? new[] {
            new EID3332CombinedSceneMRTController.ProfileBinding { profile = p3332, modelRoot = root3332.transform, material = shared3332, resources = resources3332 }
        } : new[] {
            new EID3332CombinedSceneMRTController.ProfileBinding { profile = p3332, modelRoot = root3332.transform, material = shared3332, resources = resources3332 },
            new EID3332CombinedSceneMRTController.ProfileBinding { profile = p3336, modelRoot = root3336.transform, material = shared3336, resources = resources3336, instanceTransforms = controls3336, instanceTransformReferences = controlReferences3336 }
        };
        mrt.Refresh();

        EID3332CombinedDeferredController controller = host.AddComponent<EID3332CombinedDeferredController>();
        controller.targetCamera = camera; controller.eid3332Root = root3332.transform; controller.eid3336Root = isolated ? null : root3336.transform;
        controller.gbufferMaterial = fallback; controller.sharedMrtController = mrt; controller.targets = targets;
        controller.cameraCompositeMaterial = composite; controller.b6LightingMaterial = b6; controller.enableB6Lighting = true;
        controller.normalDeferredDisplay = true; controller.renderInSceneView = true; controller.autoSizeTargetsToCamera = true;
        controller.projectionSource = EID3332CombinedDeferredController.ProjectionSource.CurrentUnityCamera;
        controller.reconstructionFlipY = true; controller.b6FlipY = true;
        controller.b6ScreenSHWeight = 0f; controller.b6ScreenSpecularContributionWeight = 0f; controller.b6ProbeReflectionWeight = 0f; controller.b6CapturedVisibilityWeight = 0f;
        controller.RefreshRenderers(); controller.LoadCapturedMatrices();
        EID3332CombinedDeferredBootstrap bootstrap = host.AddComponent<EID3332CombinedDeferredBootstrap>(); bootstrap.pipeline = pipeline;

        EditorUtility.SetDirty(camera); EditorUtility.SetDirty(targets); EditorUtility.SetDirty(resources3332); if (resources3336 != null) EditorUtility.SetDirty(resources3336); EditorUtility.SetDirty(mrt); EditorUtility.SetDirty(controller); EditorUtility.SetDirty(bootstrap);
        EditorSceneManager.MarkSceneDirty(scene);
        EditorSceneManager.SaveScene(scene, path);
        if (preservePrevious && previousActive.IsValid() && previousActive.isLoaded) SceneManager.SetActiveScene(previousActive);
        EditorSceneManager.CloseScene(scene, true);
    }

    static void Reset(Transform t) { t.localPosition = Vector3.zero; t.localRotation = Quaternion.identity; t.localScale = Vector3.one; }

    static void FrameCamera(Camera camera, Renderer[] renderers)
    {
        bool has = false; Bounds bounds = new Bounds(Vector3.zero, Vector3.one);
        foreach (Renderer r in renderers) { if (r == null) continue; if (!has) { bounds = r.bounds; has = true; } else bounds.Encapsulate(r.bounds); }
        float halfVertical = Mathf.Tan(camera.fieldOfView * .5f * Mathf.Deg2Rad);
        float halfHorizontal = halfVertical * Mathf.Max(.1f, camera.aspect);
        float distanceY = bounds.extents.y / Mathf.Max(.01f, halfVertical);
        float distanceX = bounds.extents.x / Mathf.Max(.01f, halfHorizontal);
        float distance = Mathf.Max(2f, Mathf.Max(distanceX, distanceY) * 1.12f + bounds.extents.z);
        camera.transform.position = bounds.center + new Vector3(0f, 0f, -distance);
        camera.transform.rotation = Quaternion.LookRotation(bounds.center - camera.transform.position, Vector3.up);
        camera.nearClipPlane = Mathf.Max(.01f, distance * .001f); camera.farClipPlane = Mathf.Max(1000f, distance + bounds.extents.magnitude * 4f);
    }
}
#endif

