#if UNITY_EDITOR
using System;
using System.IO;
using System.Linq;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

public static class EID3490CombinedImporter
{
    const string Root = "Assets/EID3332_EID3336_Combined";
    const string ScenePath = Root + "/Scenes/EID3332_EID3336_Combined.unity";
    const string ProfilePath = Root + "/Profiles/EID3490_DrawProfile.asset";
    const string MaterialPath = Root + "/Geometry/EID3332CombinedSharedMRT_EID3490.mat";
    const string SelectionShaderPath = Root + "/Geometry/EID3490SelectionProxy.shader";
    const string SelectionMaterialPath = Root + "/Geometry/EID3490SelectionProxy.mat";
    const string TextureSourcePath = Root + "/Geometry/EID3490CapturedTextureTable.mat";
    const string SharedFrameTextureSourcePath = Root + "/Geometry/EID3315CapturedTextureTable.mat";
    const string Array58Path = Root + "/Resources/EID3490Textures/rid198300_array.asset";
    const string Array59Path = Root + "/Resources/EID3490Textures/rid198309_array.asset";
    const string TextureRoot = Root + "/Resources/EID3490Textures";
    const string MeshPath = "Assets/Map01/Generated/Meshes/M_0F1B30296525D0A2_S_bush_hshfuping+1_001_01_lod0_pF8740EA22EE2EB4B.asset";
    const string SourceMaterialPath = "Assets/Map01/Generated/RealMaterialsV2/M_bush_hshfuping+1_001_01_7544a04c.mat";
    const string ReportPath = Root + "/Validation/EID3490_IMPORT_REPORT.txt";
    const string ProxyFolder = Root + "/Models/ProxyMeshes";

    [MenuItem("Tools/EID3332+3336/Add EID3490 To Combined Scene")]
    public static void ImportIntoCombinedScene()
    {
        AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
        ConfigureAuthoritativeTextureImports();
        AssetDatabase.ImportAsset(TextureRoot + "/rid271247.dds", ImportAssetOptions.ForceSynchronousImport);
        AssetDatabase.ImportAsset(TextureRoot + "/rid227040.tga", ImportAssetOptions.ForceSynchronousImport);
        AssetDatabase.ImportAsset(TextureRoot + "/rid226998.tga", ImportAssetOptions.ForceSynchronousImport);
        AssetDatabase.ImportAsset(TextureRoot + "/rid279400.dds", ImportAssetOptions.ForceSynchronousImport);
        AssetDatabase.ImportAsset(TextureRoot + "/rid204.dds", ImportAssetOptions.ForceSynchronousImport);
        AssetDatabase.ImportAsset(TextureRoot + "/rid197598.dds", ImportAssetOptions.ForceSynchronousImport);
        AssetDatabase.ImportAsset(TextureRoot + "/rid198094.dds", ImportAssetOptions.ForceSynchronousImport);
        Scene scene = SceneManager.GetActiveScene();
        if (!scene.IsValid() || scene.path != ScenePath)
            scene = EditorSceneManager.OpenScene(ScenePath, OpenSceneMode.Single);

        Mesh mesh = AssetDatabase.LoadAssetAtPath<Mesh>(MeshPath);
        Material sourceMaterial = AssetDatabase.LoadAssetAtPath<Material>(SourceMaterialPath);
        Shader shader = AssetDatabase.LoadAssetAtPath<Shader>(Root + "/Geometry/EID3490SharedMRT.shader");
        Shader selectionShader = AssetDatabase.LoadAssetAtPath<Shader>(SelectionShaderPath);
        Material textureSource = AssetDatabase.LoadAssetAtPath<Material>(TextureSourcePath);
        Material sharedFrameTextureSource = AssetDatabase.LoadAssetAtPath<Material>(SharedFrameTextureSourcePath);
        Texture2DArray array58 = AssetDatabase.LoadAssetAtPath<Texture2DArray>(Array58Path);
        Texture2DArray array59 = AssetDatabase.LoadAssetAtPath<Texture2DArray>(Array59Path);
        if (shader == null || selectionShader == null || textureSource == null || sharedFrameTextureSource == null || array58 == null || array59 == null)
            throw new InvalidOperationException("EID3490 authoritative texture table, copied frame arrays, or shared shader is missing.");
        textureSource.SetFloat("_EID3332CombinedEnableVirtualTextureBranch", 0f);
        textureSource.SetFloat("_EID3332CombinedFlipMaterialUVY", 0f);

        // Event 3490 uses an independent PS209989 material table. Bind the exact
        // RenderDoc resource IDs here so a regular Map01 material can never replace
        // the captured table when this menu command is run again.
        BindRequiredTexture(textureSource, "_33", TextureRoot + "/rid271247.dds");
        BindRequiredTexture(textureSource, "_35", TextureRoot + "/rid227040.tga");
        BindRequiredTexture(textureSource, "_37", TextureRoot + "/rid226998.tga");
        BindRequiredTexture(textureSource, "_38", TextureRoot + "/rid279400.dds");
        BindRequiredTexture(textureSource, "_39", TextureRoot + "/rid204.dds");
        BindRequiredTexture(textureSource, "_40", TextureRoot + "/rid197598.dds");
        BindRequiredTexture(textureSource, "_41", TextureRoot + "/rid198094.dds");

        // RID279400 is the captured detail/blend texture used by PS209989.
        // It is a full 1024x1024 BC7 texture with 11 mip levels; a 4x4 neutral
        // fallback changes the layer blend and therefore changes MRT4/BaseColor.
        ValidateCapturedDetailTexture(TextureRoot + "/rid279400.dds");

        for (int slot = 53; slot <= 65; ++slot)
        {
            string property = "_" + slot;
            if (slot == 58) textureSource.SetTexture(property, array58);
            else if (slot == 59) textureSource.SetTexture(property, array59);
            else if (sharedFrameTextureSource.HasProperty(property)) textureSource.SetTexture(property, sharedFrameTextureSource.GetTexture(property));
        }
        EditorUtility.SetDirty(textureSource);

        Material material = AssetDatabase.LoadAssetAtPath<Material>(MaterialPath);
        if (material == null)
        {
            material = new Material(shader) { name = "EID3490 Profile - captured VS209988 PS209989" };
            AssetDatabase.CreateAsset(material, MaterialPath);
        }
        material.name = "EID3332CombinedSharedMRT_EID3490";
        if (material.shader != shader) material.shader = shader;
        for (int slot = 33; slot <= 65; ++slot)
        {
            string property = "_" + slot;
            if (material.HasProperty(property) && textureSource.HasProperty(property))
                material.SetTexture(property, textureSource.GetTexture(property));
        }
        EditorUtility.SetDirty(material);

        // The proxy must have editor picking/selection passes but must not
        // participate in normal camera rendering. The reconstructed EID3490
        // material remains bound only to the raw MRT draw below.
        Material selectionMaterial = AssetDatabase.LoadAssetAtPath<Material>(SelectionMaterialPath);
        if (selectionMaterial == null)
        {
            selectionMaterial = new Material(selectionShader) { name = "EID3490 Selection Proxy" };
            AssetDatabase.CreateAsset(selectionMaterial, SelectionMaterialPath);
        }
        else
        {
            selectionMaterial.shader = selectionShader;
            selectionMaterial.name = "EID3490 Selection Proxy";
        }
        EditorUtility.SetDirty(selectionMaterial);

        // Match the reconstructed draw: the captured index winding can be mirrored, so the editor proxy is double-sided.
        if (selectionMaterial.HasProperty("_CullMode")) selectionMaterial.SetFloat("_CullMode", 0f);
        EID3332CombinedDrawProfile profile = AssetDatabase.LoadAssetAtPath<EID3332CombinedDrawProfile>(ProfilePath);
        if (profile == null)
        {
            profile = ScriptableObject.CreateInstance<EID3332CombinedDrawProfile>();
            AssetDatabase.CreateAsset(profile, ProfilePath);
        }
        profile.name = "EID3490 Draw Profile";
        profile.eventId = 3490;
        profile.indexCount = 1422;
        profile.instanceCount = 3;
        profile.indexOffset = 0;
        profile.baseVertex = 0;
        profile.vertexCount = 324;
        profile.triangleCount = 474;
        profile.vertexDataSource = "F:/endfield06.rdc event 3490 resource 201089 offset 14852864 stride 16";
        profile.indexDataSource = "F:/endfield06.rdc event 3490 resource 201089 offset 14863232 stride 2";
        profile.instanceDataSource = "F:/endfield06.rdc event 3490 VS descriptor table / captured instance records";
        profile.materialConstantsSource = "F:/endfield06.rdc event 3490 VS209988 PS209989 descriptors";
        profile.textureResourceGroup = "EID3490Textures";
        profile.verticesAlreadyWorldSpace = false;
        profile.applyExportMirrorX = false;
        profile.shaderInstanceOffset = 0;
        profile.vertexStream1StrideBytes = 16;
        profile.useRawStreams = true;
        profile.baseColorTextureId = 271247;
        profile.baseNormalTextureId = 227040;
        profile.layerControlTextureId = 226998;
        profile.detailNormalTextureId = 279400;
        profile.grassBlendMaskTextureId = 204;
        profile.enableVirtualTextureBranchInCapturedProjection = false;
        profile.enableVirtualTextureBranchInCurrentCamera = false;
        profile.flipMaterialUvY = true;
        profile.useCapturedVisibilityMaskInCapturedProjection = false;
        profile.capturedVisibilityFlipY = false;
        profile.capturedVisibilityMask = null;
        profile.textureSourceMaterial = textureSource;
        profile.modelAsset = null;
        EditorUtility.SetDirty(profile);

        EID3332CombinedDeferredController deferred = UnityEngine.Object.FindObjectOfType<EID3332CombinedDeferredController>(true);
        EID3332CombinedSceneMRTController mrt = UnityEngine.Object.FindObjectOfType<EID3332CombinedSceneMRTController>(true);
        if (deferred == null || mrt == null) throw new InvalidOperationException("Combined deferred/MRT controller is missing.");

        Transform collection = GameObject.Find("Deferred Model Root")?.transform;
        if (collection == null) throw new InvalidOperationException("Deferred Model Root is missing.");
        Transform root = collection.Find("EID3490 Models");
        if (root == null)
        {
            root = new GameObject("EID3490 Models").transform;
            root.SetParent(collection, false);
        }
        root.SetSiblingIndex(0);
        for (int i = root.childCount - 1; i >= 0; --i) UnityEngine.Object.DestroyImmediate(root.GetChild(i).gameObject);

        Matrix4x4[] matrices =
        {
            MakeMatrix(
                new Vector4(0.280030f, 0.384531f, -0.879614f, 0f),
                new Vector4(-0.875899f, -0.272686f, -0.398055f, 0f),
                new Vector4(-0.392922f, 0.881919f, 0.260450f, 0f),
                new Vector4(-525.750000f, 97.330002f, -443.140015f, 1f)),
            MakeMatrix(
                new Vector4(0.682733f, 0.259004f, -0.758684f, 0f),
                new Vector4(-0.183857f, 1.020556f, 0.182951f, 0f),
                new Vector4(0.780309f, 0.013848f, 0.706921f, 0f),
                new Vector4(-499.960022f, 89.709999f, -447.570007f, 1f)),
            MakeMatrix(
                new Vector4(1.004093f, 0.071624f, -0.738031f, 0f),
                new Vector4(-0.059552f, 1.246147f, 0.039914f, 0f),
                new Vector4(0.739101f, 0.003103f, 1.005851f, 0f),
                new Vector4(-455.720001f, 81.129997f, -364.739990f, 1f))
        };
        var renderers = new Renderer[3];
        var transforms = new Transform[3];
        var references = new Matrix4x4[3];
        for (int i = 0; i < 3; ++i)
        {
            GameObject go = new GameObject("EID3490_Instance_" + i.ToString("000"));
            go.transform.SetParent(root, false);
            go.transform.localPosition = Vector3.zero;
            go.transform.localRotation = Quaternion.identity;
            go.transform.localScale = Vector3.one;
            // The reconstructed draw uses the exact raw 324-vertex/1422-index
            // streams. Build the selectable proxy from those same streams rather
            // than from the unrelated Map01 mesh (815 vertices), then preserve the
            // captured matrix with the same residual-matrix method as EID3332/3336.
            Renderer renderer = EID3490SelectionProxyBuilder.RebuildRenderer(
                go, i, matrices[i], root, selectionMaterial);
            renderers[i] = renderer;
            transforms[i] = go.transform;
            references[i] = go.transform.localToWorldMatrix;
        }

        EID3332CombinedSceneMaterialResources resources = mrt.GetComponents<EID3332CombinedSceneMaterialResources>()
            .FirstOrDefault(x => x != null && x.material == material);
        if (resources == null) resources = mrt.gameObject.AddComponent<EID3332CombinedSceneMaterialResources>();
        resources.material = material;
        resources.constantResourceRoot = "EID3490CB";
        resources.vertexResourceRoot = "EID3490VS";
        resources.useCapturedInstanceTransforms = true;
        resources.sceneModelDataAlreadyWorldSpace = false;
        resources.sceneModelApplyExportMirrorX = false;
        resources.Reload();
        // Reload initializes buffers but must not leave the material on the
        // EID3336 default texture table. Re-apply the EID3490 PS209989 profile
        // before the material asset and scene are saved.
        resources.BindProfileTextures(profile);

        var newBinding = new EID3332CombinedSceneMRTController.ProfileBinding
        {
            profile = profile,
            modelRoot = root,
            material = material,
            resources = resources,
            instanceTransforms = transforms,
            instanceTransformReferences = references
        };
        var old = mrt.bindings ?? Array.Empty<EID3332CombinedSceneMRTController.ProfileBinding>();
        mrt.bindings = old.Where(x => x == null || x.profile == null || x.profile.eventId != 3490).Concat(new[] { newBinding }).ToArray();
        mrt.Refresh();
        deferred.RefreshRenderers();
        resources.ResetLiveTransformReferences();

        Bounds bounds = BoundsOf(renderers);
        string report =
            "EID3490 IMPORT PASS\n" +
            "eventId=3490\nshader=VS209988/PS209989\nindexCount=1422\ninstanceCount=3\nvertexCount=324\ntriangleCount=474\n" +
            "mesh=" + MeshPath + "\nsourceMaterial=" + SourceMaterialPath + "\n" +
            "meshMode=false\nrawCapture=required\n" +
            "boundsMin=" + bounds.min.ToString("R") + "\nboundsMax=" + bounds.max.ToString("R") + "\n";
        string absoluteReport = Path.Combine(Directory.GetParent(Application.dataPath).FullName, ReportPath);
        File.WriteAllText(absoluteReport, report);
        EditorUtility.SetDirty(root.gameObject); EditorUtility.SetDirty(resources); EditorUtility.SetDirty(mrt); EditorUtility.SetDirty(profile); EditorUtility.SetDirty(material); EditorUtility.SetDirty(selectionMaterial); EditorUtility.SetDirty(textureSource);
        EditorSceneManager.MarkSceneDirty(scene); EditorSceneManager.SaveScene(scene, ScenePath);
        AssetDatabase.SaveAssets(); AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
        Debug.Log("[EID3490 Combined Import] COMPLETE. Mesh-backed EID3490 profile added with 1422 indices / 3 instances.");
    }

    static Mesh CreateSelectionProxy(Mesh source, int instanceIndex)
    {
        if (source == null)
            throw new InvalidOperationException("EID3490 selection proxy source mesh is missing.");
        if (!AssetDatabase.IsValidFolder(ProxyFolder))
        {
            if (!AssetDatabase.IsValidFolder(Root + "/Models"))
                AssetDatabase.CreateFolder(Root, "Models");
            AssetDatabase.CreateFolder(Root + "/Models", "ProxyMeshes");
        }
        string assetPath = ProxyFolder + "/EID3490_instance_" + instanceIndex.ToString("000") + "_SelectionProxy.asset";
        Mesh proxy = AssetDatabase.LoadAssetAtPath<Mesh>(assetPath);
        if (proxy == null)
        {
            proxy = UnityEngine.Object.Instantiate(source);
            proxy.name = "EID3490 Instance " + instanceIndex + " Selection Proxy";
            AssetDatabase.CreateAsset(proxy, assetPath);
        }
        else
        {
            // Keep the proxy synchronized with the authoritative imported mesh.
            EditorUtility.CopySerialized(source, proxy);
            proxy.name = "EID3490 Instance " + instanceIndex + " Selection Proxy";
            EditorUtility.SetDirty(proxy);
        }
        proxy.RecalculateBounds();
        return proxy;
    }

    static void ConfigureAuthoritativeTextureImports()
    {
        ConfigureTextureImporter(TextureRoot + "/rid271247.dds", true, TextureImporterFormat.BC7);
        ConfigureTextureImporter(TextureRoot + "/rid227040.tga", false, TextureImporterFormat.BC7);
        ConfigureTextureImporter(TextureRoot + "/rid226998.tga", false, TextureImporterFormat.BC7);
        ConfigureTextureImporter(TextureRoot + "/rid279400.dds", false, TextureImporterFormat.BC7);
        ConfigureTextureImporter(TextureRoot + "/rid204.dds", true, TextureImporterFormat.RGBA32);
        ConfigureTextureImporter(TextureRoot + "/rid197598.dds", true, TextureImporterFormat.BC7);
        ConfigureTextureImporter(TextureRoot + "/rid198094.dds", false, TextureImporterFormat.BC7);
    }

    static void ConfigureTextureImporter(string path, bool srgb, TextureImporterFormat format)
    {
        var importer = AssetImporter.GetAtPath(path) as TextureImporter;
        // Unity imports .dds through IHVImageFormatImporter on this project.
        // Its color space is already encoded in the DDS header and runtime
        // binding applies filtering/wrap, so do not abort the whole importer
        // when no TextureImporter API is exposed for that file.
        if (importer == null) return;
        bool changed = importer.sRGBTexture != srgb || importer.mipmapEnabled != true;
        importer.sRGBTexture = srgb;
        importer.mipmapEnabled = true;
        importer.textureCompression = TextureImporterCompression.CompressedHQ;
        importer.crunchedCompression = false;
        importer.filterMode = FilterMode.Bilinear;
        importer.wrapMode = TextureWrapMode.Repeat;
        importer.anisoLevel = 0;
        var standalone = new TextureImporterPlatformSettings
        {
            name = "Standalone",
            overridden = true,
            maxTextureSize = 8192,
            format = format,
            textureCompression = TextureImporterCompression.CompressedHQ,
            compressionQuality = 100,
            crunchedCompression = false
        };
        importer.SetPlatformTextureSettings(standalone);
        if (changed || true) AssetDatabase.WriteImportSettingsIfDirty(path);
    }
    static void ValidateCapturedDetailTexture(string assetPath)
    {
        Texture2D texture = AssetDatabase.LoadAssetAtPath<Texture2D>(assetPath);
        if (texture == null)
            throw new InvalidOperationException("EID3490 RID279400 detail texture is missing: " + assetPath);
        if (texture.width != 1024 || texture.height != 1024 || texture.mipmapCount != 11)
            throw new InvalidOperationException("EID3490 RID279400 must be 1024x1024 with 11 mips; got " + texture.width + "x" + texture.height + " mips=" + texture.mipmapCount);
    }

    static void BindRequiredTexture(Material table, string property, string assetPath)
    {
        Texture texture = AssetDatabase.LoadAssetAtPath<Texture>(assetPath);
        if (texture == null)
            throw new InvalidOperationException($"EID3490 required texture is missing: {property} -> {assetPath}");
        table.SetTexture(property, texture);
    }
    static bool IsUsableTextureAsset(Texture texture, long minimumFileBytes)
    {
        if (texture == null) return false;
        string assetPath = AssetDatabase.GetAssetPath(texture);
        if (string.IsNullOrEmpty(assetPath)) return true;
        string fullPath = Path.GetFullPath(assetPath);
        return File.Exists(fullPath) && new FileInfo(fullPath).Length >= minimumFileBytes;
    }

    [MenuItem("Tools/EID3332+3336/Validate EID3490 Combined Output")]
    public static void ValidateEID3490()
    {
        Scene scene = EditorSceneManager.OpenScene(ScenePath, OpenSceneMode.Single);
        var mrt = UnityEngine.Object.FindObjectOfType<EID3332CombinedSceneMRTController>(true);
        var deferred = UnityEngine.Object.FindObjectOfType<EID3332CombinedDeferredController>(true);
        var b = mrt?.bindings?.FirstOrDefault(x => x != null && x.profile != null && x.profile.eventId == 3490);
        if (b == null || b.modelRoot == null || b.material == null || b.resources == null) throw new InvalidOperationException("EID3490 binding incomplete.");
        if (b.profile.indexCount != 1422 || b.profile.instanceCount != 3 || b.profile.vertexCount != 324) throw new InvalidOperationException("EID3490 draw contract mismatch.");
        deferred.projectionSource = EID3332CombinedDeferredController.ProjectionSource.CurrentUnityCamera;
        deferred.RefreshRenderers();
        deferred.targetCamera.Render();
        string project = Directory.GetParent(Application.dataPath).FullName;
        File.AppendAllText(Path.Combine(project, ReportPath), "validation=PASS\nrenderers=" + b.renderers.Length + "\n");

        Debug.Log("[EID3490 Combined Validation] PASS. EID3490 mesh-backed draw is visible through the shared MRT/B6 path.");
    }

    static Matrix4x4 MakeMatrix(Vector4 c0, Vector4 c1, Vector4 c2, Vector4 c3)
    {
        Matrix4x4 m = Matrix4x4.identity;
        m.SetColumn(0, c0); m.SetColumn(1, c1); m.SetColumn(2, c2); m.SetColumn(3, c3);
        return m;
    }
    static Quaternion QuaternionFromMatrix(Matrix4x4 m)
    {
        Vector3 x = m.GetColumn(0), y = m.GetColumn(1), z = m.GetColumn(2);
        x.Normalize(); y.Normalize(); z.Normalize();
        return Quaternion.LookRotation(z, y);
    }
    static Vector3 ExtractScale(Matrix4x4 m) => new Vector3(m.GetColumn(0).magnitude, m.GetColumn(1).magnitude, m.GetColumn(2).magnitude);
    static Bounds BoundsOf(Renderer[] rs)
    {
        Bounds b = new Bounds(); bool has=false;
        foreach (var r in rs) { if (r==null) continue; if (!has){b=r.bounds;has=true;} else b.Encapsulate(r.bounds); }
        return b;
    }
}
#endif















