#if UNITY_EDITOR
using System;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.Rendering;

[InitializeOnLoad]
public static class EID3336RouteBMeshBuilder
{
    static readonly string TriggerPath = Path.Combine(Directory.GetParent(Application.dataPath).FullName, "Validation/route_b_build.trigger");

    static EID3336RouteBMeshBuilder()
    {
        if (File.Exists(TriggerPath))
        {
            File.Delete(TriggerPath);
            EditorApplication.delayCall += BuildRouteB;
        }
    }

    const string ScenePath = "Assets/EID3332_EID3336_Combined/Scenes/EID3332_EID3336_Combined.unity";
    const string MeshPath = "Assets/EID3332_EID3336_Combined/Models/RouteB/EID3336_RouteB_RawMesh.asset";
    const string MaterialPath = "Assets/EID3332_EID3336_Combined/URPGBuffer/EID3336RouteBGBuffer.mat";

    [MenuItem("Tools/EID3332+3336/Build EID3336 Route B Mesh Path")]
    public static void BuildRouteB()
    {
        AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
        Mesh mesh = BuildMeshAsset();
        ConfigureScene(mesh);
        AssetDatabase.SaveAssets();
        AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
        Debug.Log("[EID3336 Route B] MeshRenderer path configured: " + MeshPath);
    }

    static Mesh BuildMeshAsset()
    {
        string root = "Assets/EID3332_EID3336_Combined/Resources/EID3336Raw/";
        TextAsset stream0Asset = AssetDatabase.LoadAssetAtPath<TextAsset>(root + "vertex_stream0.bytes");
        TextAsset stream1Asset = AssetDatabase.LoadAssetAtPath<TextAsset>(root + "vertex_stream1.bytes");
        TextAsset constantsAsset = AssetDatabase.LoadAssetAtPath<TextAsset>(root + "vertex_constant_stream.bytes");
        TextAsset indicesAsset = AssetDatabase.LoadAssetAtPath<TextAsset>(root + "indices_u16.bytes");
        if (stream0Asset == null || stream1Asset == null || constantsAsset == null || indicesAsset == null)
            throw new InvalidOperationException("EID3336 Route B raw stream assets are incomplete.");

        byte[] stream0 = stream0Asset.bytes;
        byte[] stream1 = stream1Asset.bytes;
        byte[] constants = constantsAsset.bytes;
        byte[] indexBytes = indicesAsset.bytes;
        if (stream0.Length % 16 != 0 || stream1.Length % 16 != 0 || indexBytes.Length % 2 != 0)
            throw new InvalidOperationException("EID3336 Route B raw stream alignment is invalid.");

        int vertexCount = stream0.Length / 16;
        int indexCount = indexBytes.Length / 2;
        var vertices = new List<Vector3>(vertexCount);
        var normals = new List<Vector3>(vertexCount);
        var tangents = new List<Vector4>(vertexCount);
        var colors = new List<Color>(vertexCount);
        var uv0 = new List<Vector2>(vertexCount);
        var uv1 = new List<Vector2>(vertexCount);
        var uv2 = new List<Vector2>(vertexCount);
        var uv3 = new List<Vector4>(vertexCount);
        var uv4 = new List<Vector4>(vertexCount);
        var uv5 = new List<Vector4>(vertexCount);

        Vector4 tangent = DecodeUNorm8(ReadUInt32(constants, 12));
        Vector4 color = DecodeUNorm8(ReadUInt32(constants, 4));
        Vector4 extra = DecodeUNorm8(ReadUInt32(constants, 16));
        uint extraIndex = ReadUInt32(constants, 0);

        for (int i = 0; i < vertexCount; ++i)
        {
            int p0 = i * 16;
            int p1 = i * 16;
            uint packedNormal = ReadUInt32(stream0, p0 + 12);
            Vector2 a = new Vector2(ReadFloat(stream1, p1), ReadFloat(stream1, p1 + 4));
            Vector2 b = new Vector2(ReadFloat(stream1, p1 + 8), ReadFloat(stream1, p1 + 12));
            vertices.Add(new Vector3(ReadFloat(stream0, p0), ReadFloat(stream0, p0 + 4), ReadFloat(stream0, p0 + 8)));
            normals.Add(new Vector3(UIntAsFloat(packedNormal), 0f, 0f));
            tangents.Add(tangent);
            colors.Add(color);
            uv0.Add(a);
            uv1.Add(b);
            uv2.Add(b);
            uv3.Add(new Vector4(b.x, b.y, 0f, 1f));
            uv4.Add(extra);
            uv5.Add(new Vector4(UIntAsFloat(extraIndex), 0f, 0f, 0f));
        }

        int[] indices = new int[indexCount];
        for (int i = 0; i < indexCount; ++i)
            indices[i] = ReadUInt16(indexBytes, i * 2);

        Mesh mesh = AssetDatabase.LoadAssetAtPath<Mesh>(MeshPath);
        if (mesh == null)
        {
            Directory.CreateDirectory(Path.Combine(Application.dataPath, "EID3332_EID3336_Combined/Models/RouteB"));
            mesh = new Mesh { name = "EID3336 Route B Raw Mesh" };
            AssetDatabase.CreateAsset(mesh, MeshPath);
        }
        else
        {
            mesh.Clear();
        }
        mesh.indexFormat = IndexFormat.UInt16;
        mesh.SetVertices(vertices);
        mesh.SetNormals(normals);
        mesh.SetTangents(tangents);
        mesh.SetColors(colors);
        mesh.SetUVs(0, uv0);
        mesh.SetUVs(1, uv1);
        mesh.SetUVs(2, uv2);
        mesh.SetUVs(3, uv3);
        mesh.SetUVs(4, uv4);
        mesh.SetUVs(5, uv5);
        mesh.SetIndices(indices, MeshTopology.Triangles, 0, true);
        mesh.subMeshCount = 1;
        mesh.RecalculateBounds();
        EditorUtility.SetDirty(mesh);
        return mesh;
    }

    static void ConfigureScene(Mesh mesh)
    {
        Scene scene = EditorSceneManager.OpenScene(ScenePath, OpenSceneMode.Single);
        EID3332CombinedDeferredController controller = UnityEngine.Object.FindObjectOfType<EID3332CombinedDeferredController>(true);
        EID3332CombinedSceneMRTController mrt = UnityEngine.Object.FindObjectOfType<EID3332CombinedSceneMRTController>(true);
        if (controller == null || mrt == null) throw new InvalidOperationException("Combined controller/MRT controller missing.");
        Material routeMaterial = AssetDatabase.LoadAssetAtPath<Material>(MaterialPath);
        if (routeMaterial == null) throw new InvalidOperationException("Route B material missing: " + MaterialPath);

        EID3336RouteBMeshRendererAdapter adapter = controller.GetComponent<EID3336RouteBMeshRendererAdapter>();
        if (adapter == null) adapter = controller.gameObject.AddComponent<EID3336RouteBMeshRendererAdapter>();
        adapter.routeBMaterial = routeMaterial;
        adapter.enabledForCurrentCamera = true;
        adapter.assignRouteBMaterial = true;

        var binding = FindBinding(mrt, 3336);
        if (binding == null || binding.profile == null || binding.resources == null)
            throw new InvalidOperationException("EID3336 binding is incomplete.");
        binding.resources.material = routeMaterial;
        binding.resources.BindProfileTextures(binding.profile);
        binding.resources.ApplyProfileStreamLayout(binding.profile);
        binding.resources.BindForDraw();
        binding.resources.ApplyCapturedInstanceTransforms();

        Renderer[] renderers = binding.modelRoot != null ? binding.modelRoot.GetComponentsInChildren<Renderer>(true) : Array.Empty<Renderer>();
        Array.Sort(renderers, (a, b) => string.CompareOrdinal(a != null ? a.name : "", b != null ? b.name : ""));
        var entries = new EID3336RouteBMeshRendererAdapter.Entry[renderers.Length];
        for (int i = 0; i < renderers.Length; ++i)
        {
            Renderer renderer = renderers[i];
            if (renderer == null) continue;
            MeshFilter filter = renderer.GetComponent<MeshFilter>();
            if (filter == null) filter = renderer.gameObject.AddComponent<MeshFilter>();
            filter.sharedMesh = mesh;
            renderer.sharedMaterial = routeMaterial;
            int instanceIndex = ParseInstanceIndex(renderer.name, i);
            if (binding.resources.TryGetCapturedInstanceMatrix(instanceIndex, out Matrix4x4 capturedMatrix))
                ApplyWorldMatrix(renderer.transform, capturedMatrix);
            entries[i] = new EID3336RouteBMeshRendererAdapter.Entry
            {
                renderer = renderer,
                profile = binding.profile,
                resources = binding.resources,
                material = routeMaterial,
                instanceIndex = instanceIndex
            };
        }
        adapter.entries = entries;

        // Route B is only the current Unity camera path. Keep RenderDocCaptured
        // on the old provider for baseline comparison, but don't let the legacy
        // custom RendererFeature enqueue a second live geometry pass.
        if (controller.targetCamera != null)
        {
            int requiredMask = 0;
            for (int i = 0; i < renderers.Length; ++i)
                if (renderers[i] != null) requiredMask |= 1 << renderers[i].gameObject.layer;
            controller.targetCamera.cullingMask |= requiredMask;
            EditorUtility.SetDirty(controller.targetCamera);
        }
        controller.useRouteBMeshRendererForCurrentCamera = true;
        EditorUtility.SetDirty(controller);
        EditorUtility.SetDirty(adapter);
        EditorUtility.SetDirty(mrt);
        EditorSceneManager.MarkSceneDirty(scene);
        EditorSceneManager.SaveScene(scene);
    }

    static EID3332CombinedSceneMRTController.ProfileBinding FindBinding(EID3332CombinedSceneMRTController mrt, int eventId)
    {
        if (mrt.bindings == null) return null;
        for (int i = 0; i < mrt.bindings.Length; ++i)
            if (mrt.bindings[i] != null && mrt.bindings[i].profile != null && mrt.bindings[i].profile.eventId == eventId)
                return mrt.bindings[i];
        return null;
    }

    static int ParseInstanceIndex(string name, int fallback)
    {
        int p = name.LastIndexOf('_');
        if (p >= 0 && int.TryParse(name.Substring(p + 1), out int value)) return value;
        return fallback;
    }

    static void ApplyWorldMatrix(Transform target, Matrix4x4 matrix)
    {
        if (target == null) return;
        Vector3 x = matrix.GetColumn(0);
        Vector3 y = matrix.GetColumn(1);
        Vector3 z = matrix.GetColumn(2);
        Vector3 position = matrix.GetColumn(3);
        float sx = x.magnitude;
        float sy = y.magnitude;
        float sz = z.magnitude;
        if (sx < 1e-6f || sy < 1e-6f || sz < 1e-6f) return;
        Vector3 scale = new Vector3(sx, sy, sz);
        if (Vector3.Dot(Vector3.Cross(x / sx, y / sy), z / sz) < 0f) scale.z = -scale.z;
        Quaternion rotation = Quaternion.LookRotation(z / sz, y / sy);
        Transform parent = target.parent;
        if (parent == null)
        {
            target.SetPositionAndRotation(position, rotation);
            target.localScale = scale;
            return;
        }
        Matrix4x4 local = parent.worldToLocalMatrix * matrix;
        Vector3 lx = local.GetColumn(0);
        Vector3 ly = local.GetColumn(1);
        Vector3 lz = local.GetColumn(2);
        float lsx = lx.magnitude;
        float lsy = ly.magnitude;
        float lsz = lz.magnitude;
        if (lsx < 1e-6f || lsy < 1e-6f || lsz < 1e-6f) return;
        Vector3 localScale = new Vector3(lsx, lsy, lsz);
        if (Vector3.Dot(Vector3.Cross(lx / lsx, ly / lsy), lz / lsz) < 0f) localScale.z = -localScale.z;
        target.localPosition = local.GetColumn(3);
        target.localRotation = Quaternion.LookRotation(lz / lsz, ly / lsy);
        target.localScale = localScale;
    }
    static uint ReadUInt32(byte[] bytes, int offset) => BitConverter.ToUInt32(bytes, offset);
    static int ReadUInt16(byte[] bytes, int offset) => BitConverter.ToUInt16(bytes, offset);
    static float ReadFloat(byte[] bytes, int offset) => BitConverter.ToSingle(bytes, offset);
    static float UIntAsFloat(uint value) => BitConverter.ToSingle(BitConverter.GetBytes(value), 0);
    static Vector4 DecodeUNorm8(uint value) => new Vector4(value & 255u, (value >> 8) & 255u, (value >> 16) & 255u, (value >> 24) & 255u) / 255f;
}
#endif
