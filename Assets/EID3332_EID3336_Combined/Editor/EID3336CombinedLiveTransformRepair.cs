#if UNITY_EDITOR
using System;
using System.Linq;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

public static class EID3336CombinedLiveTransformRepair
{
    const string CombinedScene = "Assets/EID3332_EID3336_Combined/Scenes/EID3332_EID3336_Combined.unity";
    const string ControlPrefix = "EID3336 Instance Control ";
    const string SourceFbx = "Assets/EID3332_EID3336_Combined/Models/eid_3336_world.fbx";
    const string ProxyFolder = "Assets/EID3332_EID3336_Combined/Models/ProxyMeshes";

    [MenuItem("Tools/EID3332+3336/Repair EID3336 Live Instance Controls")]
    public static void RepairCombinedScene()
    {
        Scene scene = SceneManager.GetActiveScene();
        if (!scene.IsValid() || scene.path != CombinedScene)
            scene = EditorSceneManager.OpenScene(CombinedScene, OpenSceneMode.Single);

        EID3332CombinedSceneMRTController mrt = UnityEngine.Object.FindObjectOfType<EID3332CombinedSceneMRTController>();
        if (mrt == null || mrt.bindings == null)
            throw new InvalidOperationException("Combined MRT controller/bindings are missing.");

        EID3332CombinedSceneMRTController.ProfileBinding binding = mrt.bindings
            .FirstOrDefault(x => x != null && x.profile != null && x.profile.eventId == 3336);
        if (binding == null || binding.modelRoot == null || binding.resources == null)
            throw new InvalidOperationException("EID3336 binding, model root, or resources are missing.");

        binding.resources.Reload();
        Transform[] modelTransforms = CreateOrRepair(binding.modelRoot, binding.resources);
        binding.instanceTransforms = modelTransforms;
        binding.instanceTransformReferences = modelTransforms.Select(x => x.localToWorldMatrix).ToArray();
        binding.resources.ResetLiveTransformReferences();
        mrt.Refresh();

        EditorUtility.SetDirty(binding.modelRoot.gameObject);
        EditorUtility.SetDirty(binding.resources);
        EditorUtility.SetDirty(mrt);
        EditorSceneManager.MarkSceneDirty(scene);
        EditorSceneManager.SaveScene(scene, CombinedScene);
        AssetDatabase.SaveAssets();
        Debug.Log("[EID3336 Live Transform] The three selectable model nodes now directly carry the captured instance transforms; selection mesh, pivot, and raw render are aligned.");
    }

    public static Transform[] CreateOrRepair(Transform modelRoot, EID3332CombinedSceneMaterialResources resources)
    {
        if (modelRoot == null || resources == null) return Array.Empty<Transform>();
        EnsureProxyFolder();

        Renderer[] renderers = GetOrderedRenderers(modelRoot);
        if (renderers.Length < 3)
            throw new InvalidOperationException("EID3336 requires three renderer instances; found " + renderers.Length + ".");

        GameObject[] prefabRoots = renderers
            .Select(x => PrefabUtility.GetOutermostPrefabInstanceRoot(x.gameObject))
            .Where(x => x != null).Distinct().ToArray();
        foreach (GameObject prefabRoot in prefabRoots)
            PrefabUtility.UnpackPrefabInstance(prefabRoot, PrefabUnpackMode.Completely, InteractionMode.AutomatedAction);

        renderers = GetOrderedRenderers(modelRoot);
        Mesh[] sourceMeshes = AssetDatabase.LoadAllAssetsAtPath(SourceFbx).OfType<Mesh>()
            .OrderBy(x => x.name, StringComparer.Ordinal).ToArray();
        if (sourceMeshes.Length < 3)
            throw new InvalidOperationException("Original EID3336 FBX does not contain three mesh assets.");

        Transform[] result = new Transform[3];
        for (int i = 0; i < 3; ++i)
        {
            Renderer renderer = renderers.FirstOrDefault(x => x.name == "eid3336_instance_" + i.ToString("000"));
            if (renderer == null) renderer = renderers[i];
            Mesh source = sourceMeshes.FirstOrDefault(x => x.name == renderer.name) ?? sourceMeshes[i];
            if (!resources.TryGetCapturedInstanceMatrix(i, out Matrix4x4 captured))
                throw new InvalidOperationException("Captured EID3336 instance matrix " + i + " is unavailable.");

            RebuildDirectModelProxy(renderer, source, modelRoot, captured, i);
            result[i] = renderer.transform;
        }

        // The intermediate control parents are no longer part of the runtime
        // contract. The actual clickable model nodes now own the instance TRS.
        Transform[] obsoleteControls = modelRoot.Cast<Transform>()
            .Where(x => x != null && x.name.StartsWith(ControlPrefix, StringComparison.Ordinal)).ToArray();
        foreach (Transform obsolete in obsoleteControls)
            if (obsolete != null && obsolete.childCount == 0) UnityEngine.Object.DestroyImmediate(obsolete.gameObject);

        return result;
    }

    static void RebuildDirectModelProxy(Renderer renderer, Mesh source, Transform modelRoot, Matrix4x4 captured, int instanceIndex)
    {
        MeshFilter filter = renderer.GetComponent<MeshFilter>();
        SkinnedMeshRenderer skinned = renderer as SkinnedMeshRenderer;
        if (filter == null && skinned == null)
            throw new InvalidOperationException("EID3336 renderer " + renderer.name + " has no supported mesh component.");

        // Establish the authoritative desired world-space selection geometry:
        // Unity's FBX import mirrors X relative to the RenderDoc-exported world mesh.
        AssignMesh(filter, skinned, source);
        renderer.transform.SetParent(modelRoot, false);
        SetWorldMatrix(renderer.transform, Matrix4x4.Scale(new Vector3(-1f, 1f, 1f)));
        Vector3 desiredWorldCenter = renderer.bounds.center;

        // The model node itself carries the captured instance Transform. Rebase
        // the world-baked FBX vertices into that node's local space so clicking
        // the model selects the same object and pivot that drives the raw draw.
        SetWorldMatrix(renderer.transform, captured);
        Matrix4x4 localFromImported = renderer.transform.worldToLocalMatrix * Matrix4x4.Scale(new Vector3(-1f, 1f, 1f));

        string assetPath = ProxyFolder + "/EID3336_instance_" + instanceIndex.ToString("000") + "_SelectionProxy.asset";
        Mesh oldProxy = AssetDatabase.LoadAssetAtPath<Mesh>(assetPath);
        AssignMesh(filter, skinned, source);
        if (oldProxy != null) AssetDatabase.DeleteAsset(assetPath);

        Mesh proxy = UnityEngine.Object.Instantiate(source);
        proxy.name = "EID3336 Instance " + instanceIndex + " Selection Proxy";
        Vector3[] vertices = proxy.vertices;
        for (int v = 0; v < vertices.Length; ++v)
            vertices[v] = localFromImported.MultiplyPoint3x4(vertices[v]);
        proxy.vertices = vertices;

        Vector3[] normals = proxy.normals;
        if (normals != null && normals.Length == vertices.Length)
        {
            Matrix4x4 normalMatrix = localFromImported.inverse.transpose;
            for (int n = 0; n < normals.Length; ++n)
                normals[n] = normalMatrix.MultiplyVector(normals[n]).normalized;
            proxy.normals = normals;
        }
        proxy.RecalculateBounds();
        AssetDatabase.CreateAsset(proxy, assetPath);
        AssignMesh(filter, skinned, proxy);

        // Compensate the small TRS-decomposition difference of captured affine
        // matrices without changing the node's captured Transform/pivot.
        Vector3 centerErrorWorld = desiredWorldCenter - renderer.bounds.center;
        if (centerErrorWorld.sqrMagnitude > 1e-10f)
        {
            Vector3 centerErrorLocal = renderer.transform.worldToLocalMatrix.MultiplyVector(centerErrorWorld);
            vertices = proxy.vertices;
            for (int v = 0; v < vertices.Length; ++v) vertices[v] += centerErrorLocal;
            proxy.vertices = vertices;
            proxy.RecalculateBounds();
            EditorUtility.SetDirty(proxy);
        }

        EditorUtility.SetDirty(renderer);
        EditorUtility.SetDirty(renderer.gameObject);
    }

    static void AssignMesh(MeshFilter filter, SkinnedMeshRenderer skinned, Mesh mesh)
    {
        if (filter != null) filter.sharedMesh = mesh;
        if (skinned != null) skinned.sharedMesh = mesh;
    }

    static void EnsureProxyFolder()
    {
        if (!AssetDatabase.IsValidFolder(ProxyFolder))
            AssetDatabase.CreateFolder("Assets/EID3332_EID3336_Combined/Models", "ProxyMeshes");
    }

    public static Renderer[] GetOrderedRenderers(Transform modelRoot)
    {
        return modelRoot == null ? Array.Empty<Renderer>() : modelRoot.GetComponentsInChildren<Renderer>(true)
            .Where(x => x != null).OrderBy(x => x.name, StringComparer.Ordinal).ToArray();
    }

    static void SetWorldMatrix(Transform target, Matrix4x4 world)
    {
        Matrix4x4 local = target.parent != null ? target.parent.worldToLocalMatrix * world : world;
        Vector3 x = local.GetColumn(0);
        Vector3 y = local.GetColumn(1);
        Vector3 z = local.GetColumn(2);
        Vector3 scale = new Vector3(x.magnitude, y.magnitude, z.magnitude);
        float determinant = Vector3.Dot(x, Vector3.Cross(y, z));
        if (determinant < 0f) scale.z = -scale.z;

        Vector3 up = scale.y > 1e-7f ? y / scale.y : Vector3.up;
        Vector3 forward = Mathf.Abs(scale.z) > 1e-7f ? z / scale.z : Vector3.forward;
        target.localRotation = forward.sqrMagnitude < 1e-8f || up.sqrMagnitude < 1e-8f || Vector3.Cross(forward, up).sqrMagnitude < 1e-8f
            ? Quaternion.identity : Quaternion.LookRotation(forward, up);
        target.localPosition = local.GetColumn(3);
        target.localScale = scale;
    }
}
#endif
