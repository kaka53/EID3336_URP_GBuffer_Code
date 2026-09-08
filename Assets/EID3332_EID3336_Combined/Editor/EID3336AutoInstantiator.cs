using UnityEngine;
using UnityEditor;

namespace EID3336
{
    /// <summary>
    /// Immediately creates EID3336 instances when this script is compiled
    /// </summary>
    [InitializeOnLoad]
    public static class EID3336AutoInstantiator
    {
        static EID3336AutoInstantiator()
        {
            // Auto-create instances when Unity compiles this script
            EditorApplication.delayCall += CreateInstancesIfNeeded;
        }

        private static void CreateInstancesIfNeeded()
        {
            // Check if instances already exist
            if (GameObject.Find("EID3336_Instances") != null)
            {
                Debug.Log("EID3336 instances already exist in scene");
                return;
            }

            // Find the model
            string modelPath = "Assets/EID3332_EID3336_Combined/Models/EID3336_VSInput.fbx";
            GameObject modelPrefab = AssetDatabase.LoadAssetAtPath<GameObject>(modelPath);

            if (modelPrefab == null)
            {
                Debug.LogWarning($"EID3336: Model not found at {modelPath}");
                return;
            }

            CreateInstances(modelPrefab);
        }

        [MenuItem("EID3336/Create Instances Now")]
        public static void CreateInstancesMenuItem()
        {
            string modelPath = "Assets/EID3332_EID3336_Combined/Models/EID3336_VSInput.fbx";
            GameObject modelPrefab = AssetDatabase.LoadAssetAtPath<GameObject>(modelPath);

            if (modelPrefab == null)
            {
                EditorUtility.DisplayDialog("Error", $"Model not found at {modelPath}", "OK");
                return;
            }

            CreateInstances(modelPrefab);
        }

        private static void CreateInstances(GameObject modelPrefab)
        {
            // Instance data from M matrix decomposition
            var instances = new[]
            {
                new {
                    name = "EID3336_Instance_000",
                    position = new Vector3(-533.9000244140625f, 86.23999786376953f, 445.9100036621094f),
                    rotation = new Vector3(169.05191680828034f, -24.805257467993787f, 6.111255702592921f),
                    scale = new Vector3(0.8519715076902064f, 0.8519714931076905f, 0.8519716687430247f)
                },
                new {
                    name = "EID3336_Instance_001",
                    position = new Vector3(-515.034912109375f, 87.6861572265625f, 454.8173828125f),
                    rotation = new Vector3(-19.310454060182746f, 68.78710559096493f, 154.45097733136154f),
                    scale = new Vector3(1.0530015206346033f, 1.0529996416837601f, 1.0530015615392923f)
                },
                new {
                    name = "EID3336_Instance_002",
                    position = new Vector3(-522.4000244140625f, 83.2699966430664f, 458.8999938964844f),
                    rotation = new Vector3(174.40617815686485f, -53.00015692390648f, 12.278443315584184f),
                    scale = new Vector3(1.0529995017491167f, 1.0529994401052556f, 1.0529999954554363f)
                }
            };

            // Create parent container
            GameObject container = new GameObject("EID3336_Instances");
            Undo.RegisterCreatedObjectUndo(container, "Create EID3336 Container");

            // Create each instance
            foreach (var data in instances)
            {
                GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(modelPrefab, container.transform);
                instance.name = data.name;

                instance.transform.position = data.position;
                instance.transform.eulerAngles = data.rotation;
                instance.transform.localScale = data.scale;

                Undo.RegisterCreatedObjectUndo(instance, "Create " + data.name);
                Debug.Log($"[EID3336] Created {data.name} at {data.position}");
            }

            Selection.activeGameObject = container;
            EditorGUIUtility.PingObject(container);

            Debug.Log($"[EID3336] Successfully created {instances.Length} model instances!");
        }
    }
}
