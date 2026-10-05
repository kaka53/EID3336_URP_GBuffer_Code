#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;

// Explicit, one-shot repair only. No per-frame Transform enforcement.
[InitializeOnLoad]
public static class EID3863CaptureRepair
{
    const string D = "D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/eid3863_scale_1005";
    const string Capture = "Assets/EID3332_EID3336_Combined/EID3863_RenderDocVegetation/Captured/VS_uniforms28_65536.bytes";
    static EID3863CaptureRepair() { EditorApplication.update += Tick; }
    static void Tick()
    {
        if (EditorApplication.isCompiling || EditorApplication.isUpdating || !File.Exists(D + "/fix.request")) return;
        File.Delete(D + "/fix.request");
        try { Repair(); } catch (Exception e) { File.WriteAllText(D + "/fix_result.txt", e.ToString()); Debug.LogException(e); }
    }

    public static bool HasCompleteInstanceGroup(UnityEngine.SceneManagement.Scene scene)
    {
        foreach (var root in scene.GetRootGameObjects())
        {
            if (root.name != "EID3863_Vegetation_Instances" || !root.activeInHierarchy || root.transform.childCount != 297) continue;
            for (int i = 0; i < 297; i++)
            {
                var t = root.transform.Find("EID3863_Instance_" + i.ToString("D3"));
                if (!t || !t.gameObject.activeInHierarchy) return false;
                var mf = t.GetComponent<MeshFilter>(); var mr = t.GetComponent<MeshRenderer>();
                if (!mf || !mf.sharedMesh || mf.sharedMesh.vertexCount != 40 || !mr || !mr.enabled || !mr.sharedMaterial || mr.sharedMaterial.shader.name != "EID3863/URP/RenderDocVegetation") return false;
            }
            return true;
        }
        return false;
    }

    public static int DisableDuplicateBatch(UnityEngine.SceneManagement.Scene scene)
    {
        if (!HasCompleteInstanceGroup(scene)) return 0;
        int count = 0;
        foreach (var b in Resources.FindObjectsOfTypeAll<EID215849InstanceBinder>())
        {
            if (b.gameObject.scene != scene || !b.profile || b.profile.eventId != 3863 || !b.gameObject.activeSelf) continue;
            Undo.RecordObject(b.gameObject, "EID3863: disable duplicate captured draw");
            b.gameObject.SetActive(false); EditorUtility.SetDirty(b.gameObject); count++;
        }
        return count;
    }

    [MenuItem("EID3332-EID3336/EID3863/Restore Captured Transforms And Remove Duplicate Draw")]
    public static void Repair()
    {
        var root = GameObject.Find("EID3863_Vegetation_Instances");
        if (!root || !HasCompleteInstanceGroup(root.scene)) throw new InvalidOperationException("Expected the complete 297-instance EID3863 group.");
        if (root.transform.localToWorldMatrix != Matrix4x4.identity) throw new InvalidOperationException("Unexpected parent transform; inspect before restoring child transforms.");
        byte[] raw = File.ReadAllBytes(Capture);
        Directory.CreateDirectory(D + "/backup");
        // Save copies only: never save unrelated live camera edits over the original scene.
        if (!EditorSceneManager.SaveScene(root.scene, D + "/backup/scene_live_before.unity", true)) throw new IOException("Live backup failed.");
        int changed = 0; float maxAfter = 0; var log = new StringBuilder();
        for (int i = 0; i < 297; i++)
        {
            var expected = Matrix4x4.zero;
            for (int c = 0; c < 4; c++) for (int r = 0; r < 4; r++) expected[r,c] = BitConverter.ToSingle(raw, i*96+c*16+r*4);
            var t = root.transform.Find("EID3863_Instance_" + i.ToString("D3"));
            float error = Difference(expected, t.localToWorldMatrix);
            if (error > 0.0001f)
            {
                Undo.RecordObject(t, "EID3863: restore captured instance transform");
                Vector3 x=expected.GetColumn(0), y=expected.GetColumn(1), z=expected.GetColumn(2);
                t.SetPositionAndRotation(expected.GetColumn(3), Quaternion.LookRotation(z.normalized, y.normalized));
                t.localScale = new Vector3(x.magnitude, y.magnitude, z.magnitude);
                EditorUtility.SetDirty(t); changed++; log.AppendLine(t.name + " beforeError=" + error.ToString("R"));
            }
            maxAfter = Mathf.Max(maxAfter, Difference(expected, t.localToWorldMatrix));
        }
        int duplicates = DisableDuplicateBatch(root.scene);
        EditorSceneManager.MarkSceneDirty(root.scene);
        if (!EditorSceneManager.SaveScene(root.scene, D + "/scene_live_after.unity", true)) throw new IOException("After snapshot failed.");
        if (maxAfter > 0.0001f) throw new InvalidOperationException("Transform validation failed: " + maxAfter);
        log.AppendLine("PASS correctedTransforms="+changed+" disabledDuplicateDraws="+duplicates+" instances=297 maxMatrixError="+maxAfter.ToString("R"));
        File.WriteAllText(D+"/fix_result.txt",log.ToString());
        SceneView.RepaintAll(); EditorApplication.QueuePlayerLoopUpdate();
    }
    static float Difference(Matrix4x4 a, Matrix4x4 b) { float e=0; for(int i=0;i<16;i++) e=Mathf.Max(e,Mathf.Abs(a[i]-b[i])); return e; }
}
#endif
