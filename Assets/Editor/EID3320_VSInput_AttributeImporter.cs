using UnityEngine;
using UnityEditor;
using System.Collections.Generic;
using System.Globalization;
using System.IO;

/// <summary>
/// Rebuilds the EID3320 VS-input mesh from the extracted RenderDoc CSVs so that
/// EVERY vertex attribute of the capture is carried in Unity mesh channels.
///
/// Menu: Tools > EID3320 > Rebuild VSInput Mesh (All Attributes)
///
/// Channel mapping (see EID3320_VSInput_layout.json):
///   capture _input0  (float3 position, model space) -> vertices
///   capture _input4  (UV0)                           -> uv   (channel 0)
///   capture _input5  (UV1, =_input6=_input7)        -> uv2  (channel 1)
///   capture _input1  (raw float32)                  -> uv3  (channel 2)
///   capture _input2  (const 255,0,0,255)            -> uv4  (channel 3, xy) + uv5 (channel 4, zw)
///   capture _input8  (const 255,0,0,0)              -> uv6  (channel 5, xy) + uv7 (channel 6, zw)
///   capture _input9  (const 0,0,0,0)                -> uv8  (channel 7, xy)
///   capture _input3  (const 255,255,255,255)        -> colors32
/// </summary>
public static class EID3320VSInputAttributeImporter
{
    private const string ModelsDir = "Assets/EID3336_URP_Reconstruction/Models";

    [MenuItem("Tools/EID3320/Rebuild VSInput Mesh (All Attributes)")]
    public static void Rebuild()
    {
        string root = Path.Combine(Application.dataPath, "EID3336_URP_Reconstruction", "Models");
        string vertPath = Path.Combine(root, "EID3320_VSInput_vertices.csv");
        string idxPath = Path.Combine(root, "EID3320_VSInput_indices.csv");
        if (!File.Exists(vertPath) || !File.Exists(idxPath))
        {
            Debug.LogError("EID3320: CSV files not found under " + root);
            return;
        }

        var positions = new List<Vector3>();
        var odd = new List<Vector2>();       // _input1 raw float (x = value)
        var uv0 = new List<Vector2>();       // _input4
        var uv1 = new List<Vector2>();       // _input5
        var input2 = new List<Vector2>();    // _input2 xy
        var input2zw = new List<Vector2>();  // _input2 zw
        var input8 = new List<Vector2>();    // _input8 xy
        var input8zw = new List<Vector2>();  // _input8 zw
        var input9 = new List<Vector2>();    // _input9 xy
        var colors = new List<Color32>();    // _input3

        string[] lines = File.ReadAllLines(vertPath);
        for (int r = 1; r < lines.Length; r++)
        {
            string[] c = lines[r].Split(',');
            positions.Add(new Vector3(P(c[1]), P(c[2]), P(c[3])));
            odd.Add(new Vector2(P(c[4]), 0f));
            uv0.Add(new Vector2(P(c[6]), P(c[7])));
            uv1.Add(new Vector2(P(c[8]), P(c[9])));
            colors.Add(new Color32(B(c[10]), B(c[11]), B(c[12]), B(c[13])));
            input2.Add(new Vector2(P(c[14]), P(c[15])));
            input2zw.Add(new Vector2(P(c[16]), P(c[17])));
            input8.Add(new Vector2(P(c[18]), P(c[19])));
            input8zw.Add(new Vector2(P(c[20]), P(c[21])));
            input9.Add(new Vector2(P(c[22]), P(c[23])));
        }

        string[] idxLines = File.ReadAllLines(idxPath);
        var tris = new List<int>(idxLines.Length * 3);
        for (int r = 1; r < idxLines.Length; r++)
        {
            string[] c = idxLines[r].Split(',');
            tris.Add(int.Parse(c[1]));
            tris.Add(int.Parse(c[2]));
            tris.Add(int.Parse(c[3]));
        }

        var mesh = new Mesh { name = "EID3320_VSInput_FullAttributes" };
        mesh.vertices = positions.ToArray();
        mesh.triangles = tris.ToArray();
        mesh.SetUVs(0, uv0);
        mesh.SetUVs(1, uv1);
        mesh.SetUVs(2, odd);
        mesh.SetUVs(3, input2);
        mesh.SetUVs(4, input2zw);
        mesh.SetUVs(5, input8);
        mesh.SetUVs(6, input8zw);
        mesh.SetUVs(7, input9);
        mesh.colors32 = colors.ToArray();
        mesh.RecalculateNormals();
        mesh.RecalculateBounds();

        string assetPath = ModelsDir + "/EID3320_VSInput_FullAttributes.asset";
        AssetDatabase.CreateAsset(mesh, assetPath);
        AssetDatabase.SaveAssets();
        Selection.activeObject = AssetDatabase.LoadAssetAtPath<Mesh>(assetPath);
        Debug.Log(string.Format(
            "EID3320 mesh rebuilt: {0} vertices, {1} triangles, channels: pos/uv0/uv1/uv3(_input1)/uv4-5(_input2)/uv6-7(_input8)/uv8(_input9)/color(_input3). Asset: {2}",
            mesh.vertexCount, mesh.triangles.Length / 3, assetPath));
    }

    private static float P(string s) =>
        float.Parse(s.Trim(), NumberStyles.Float, CultureInfo.InvariantCulture);

    private static byte B(string s) => byte.Parse(s.Trim());
}
