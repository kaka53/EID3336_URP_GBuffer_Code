#if UNITY_EDITOR
using System;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering.Universal;
using UnityEngine.SceneManagement;

/// <summary>Non-destructive scene render smoke test with EID5537 removed from the feature queue.</summary>
public static class EID5537DisabledSmokeTest
{
    const string RendererPath = "Assets/EID3332_EID3336_Combined/Settings/EID3332Combined-Renderer.asset";
    const string ScenePath = "Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
    const string InputPath = "Assets/EID5618_RenderDocPostProcess/Materials/EID5618_InputProfile.asset";

    [MenuItem("EID5537/Test target scene with RenderFeature removed from queue")]
    public static void Run()
    {
        try
        {
            var renderer = AssetDatabase.LoadAssetAtPath<UniversalRendererData>(RendererPath);
            if (renderer == null) throw new InvalidOperationException("Combined renderer not found.");
            EID5537FixedFrameRendererFeature feature = null;
            foreach (var item in renderer.rendererFeatures)
                if (item is EID5537FixedFrameRendererFeature found) { feature = found; break; }
            if (feature != null)
                throw new InvalidOperationException("EID5537 is still present in the RendererFeature queue.");

            var input = AssetDatabase.LoadAssetAtPath<EID5618InputProfile>(InputPath);
            if (input == null || input.res9Source == EID5618InputProfile.Res9SourceMode.EID5537RenderFeature)
                throw new InvalidOperationException("EID5618 must not consume removed EID5537 output.");

            Scene scene = EditorSceneManager.OpenScene(ScenePath, OpenSceneMode.Single);
            if (!scene.IsValid()) throw new InvalidOperationException("Target scene did not open.");
            var cameraObject = GameObject.Find("EID3336 RenderDoc Camera");
            Camera camera = cameraObject != null ? cameraObject.GetComponent<Camera>() : null;
            if (camera == null) throw new InvalidOperationException("Target camera not found.");

            var output = new RenderTexture(1366, 768, 24, RenderTextureFormat.ARGBHalf)
            {
                name = "EID5537 Removed Smoke Camera Output"
            };
            RenderTexture previousTarget = camera.targetTexture;
            bool previousEnabled = camera.enabled;
            try
            {
                camera.enabled = false;
                output.Create();
                camera.targetTexture = output;
                camera.Render();
                if (!output.IsCreated()) throw new InvalidOperationException("Camera output was not created.");
                if (EID5537FixedFrameRendererFeature.GetCurrentOutput(camera) != null)
                    throw new InvalidOperationException("Removed EID5537 unexpectedly produced an output.");
            }
            finally
            {
                camera.targetTexture = previousTarget;
                camera.enabled = previousEnabled;
                output.Release();
                UnityEngine.Object.DestroyImmediate(output);
            }

            Debug.Log("[EID5537 removed smoke] PASS: target scene opened and camera rendered without EID5537 in the feature queue.");
            if (Application.isBatchMode) EditorApplication.Exit(0);
        }
        catch (Exception e)
        {
            Debug.LogException(e);
            if (Application.isBatchMode) EditorApplication.Exit(1);
        }
    }
}
#endif
