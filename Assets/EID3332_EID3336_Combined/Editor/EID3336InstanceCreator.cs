using UnityEngine;
using UnityEditor;

namespace EID3336
{
    /// <summary>
    /// Editor utility to quickly instantiate EID3336 model instances in the scene
    /// </summary>
    public class EID3336InstanceCreator : EditorWindow
    {
        private GameObject modelPrefab;

        [MenuItem("EID3336/Create Model Instances")]
        public static void ShowWindow()
        {
            GetWindow<EID3336InstanceCreator>("EID3336 Setup");
        }

        private void OnGUI()
        {
            GUILayout.Label("EID3336 Model Instance Setup", EditorStyles.boldLabel);
            EditorGUILayout.Space();

            modelPrefab = (GameObject)EditorGUILayout.ObjectField(
                "Model Prefab",
                modelPrefab,
                typeof(GameObject),
                false);

            EditorGUILayout.HelpBox(
                "Drag EID3336_VSInput.fbx from Assets/EID3332_EID3336_Combined/Models/ here",
                MessageType.Info);

            EditorGUILayout.Space();

            GUI.enabled = modelPrefab != null;
            if (GUILayout.Button("Create 3 Instances in Scene", GUILayout.Height(40)))
            {
                CreateInstances();
            }
            GUI.enabled = true;

            EditorGUILayout.Space();

            if (GUILayout.Button("Clear All Instances"))
            {
                ClearInstances();
            }
        }

        private void CreateInstances()
        {
            if (modelPrefab == null)
            {
                EditorUtility.DisplayDialog("Error", "Please assign a model prefab first!", "OK");
                return;
            }

            // Instance data from EID3336_Scene_Config.json
            InstanceData[] instances = new InstanceData[]
            {
                new InstanceData
                {
                    name = "EID3336_Instance_000",
                    position = new Vector3(-533.9000244140625f, 86.23999786376953f, 445.9100036621094f),
                    rotation = new Vector3(169.05191680828034f, -24.805257467993787f, 6.111255702592921f),
                    scale = new Vector3(0.8519715076902064f, 0.8519714931076905f, 0.8519716687430247f)
                },
                new InstanceData
                {
                    name = "EID3336_Instance_001",
                    position = new Vector3(-515.034912109375f, 87.6861572265625f, 454.8173828125f),
                    rotation = new Vector3(-19.310454060182746f, 68.78710559096493f, 154.45097733136154f),
                    scale = new Vector3(1.0530015206346033f, 1.0529996416837601f, 1.0530015615392923f)
                },
                new InstanceData
                {
                    name = "EID3336_Instance_002",
                    position = new Vector3(-522.4000244140625f, 83.2699966430664f, 458.8999938964844f),
                    rotation = new Vector3(174.40617815686485f, -53.00015692390648f, 12.278443315584184f),
                    scale = new Vector3(1.0529995017491167f, 1.0529994401052556f, 1.0529999954554363f)
                }
            };

            // Create parent container
            GameObject container = GameObject.Find("EID3336_Instances");
            if (container == null)
            {
                container = new GameObject("EID3336_Instances");
                Undo.RegisterCreatedObjectUndo(container, "Create EID3336 Container");
            }

            // Create each instance
            foreach (var data in instances)
            {
                GameObject instance = (GameObject)PrefabUtility.InstantiatePrefab(modelPrefab, container.transform);
                instance.name = data.name;

                instance.transform.position = data.position;
                instance.transform.eulerAngles = data.rotation;
                instance.transform.localScale = data.scale;

                Undo.RegisterCreatedObjectUndo(instance, "Create " + data.name);
                Debug.Log($"Created {data.name} at {data.position}");
            }

            Selection.activeGameObject = container;
            EditorGUIUtility.PingObject(container);

            EditorUtility.DisplayDialog(
                "Success",
                $"Created {instances.Length} EID3336 model instances!\n\nCheck the Hierarchy for 'EID3336_Instances'",
                "OK");
        }

        private void ClearInstances()
        {
            GameObject container = GameObject.Find("EID3336_Instances");
            if (container != null)
            {
                if (EditorUtility.DisplayDialog(
                    "Confirm Clear",
                    "Delete all EID3336 instances?",
                    "Yes", "Cancel"))
                {
                    Undo.DestroyObjectImmediate(container);
                    Debug.Log("Cleared all EID3336 instances");
                }
            }
            else
            {
                EditorUtility.DisplayDialog("Info", "No instances found to clear.", "OK");
            }
        }

        private struct InstanceData
        {
            public string name;
            public Vector3 position;
            public Vector3 rotation;
            public Vector3 scale;
        }
    }
}
