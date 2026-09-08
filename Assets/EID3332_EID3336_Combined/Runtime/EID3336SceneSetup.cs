using UnityEngine;

namespace EID3336
{
    /// <summary>
    /// Setup script to instantiate EID3336 model instances with their exact captured transforms.
    /// Based on RenderDoc capture data from event 3336.
    /// </summary>
    public class EID3336SceneSetup : MonoBehaviour
    {
        [Header("Model Reference")]
        [Tooltip("The EID3336_VSInput.fbx model to instantiate")]
        public GameObject modelPrefab;

        [Header("Instance Data")]
        [Tooltip("Automatically create instances on Start")]
        public bool autoCreateOnStart = true;

        // Instance transform data extracted from EID3336_Scene_Config.json
        private readonly InstanceData[] instances = new InstanceData[]
        {
            // Instance 0: EID3336_Instance_000
            new InstanceData
            {
                name = "EID3336_Instance_000",
                position = new Vector3(-533.9000244140625f, 86.23999786376953f, 445.9100036621094f),
                rotation = new Vector3(169.05191680828034f, -24.805257467993787f, 6.111255702592921f),
                scale = new Vector3(0.8519715076902064f, 0.8519714931076905f, 0.8519716687430247f)
            },
            // Instance 1: EID3336_Instance_001
            new InstanceData
            {
                name = "EID3336_Instance_001",
                position = new Vector3(-515.034912109375f, 87.6861572265625f, 454.8173828125f),
                rotation = new Vector3(-19.310454060182746f, 68.78710559096493f, 154.45097733136154f),
                scale = new Vector3(1.0530015206346033f, 1.0529996416837601f, 1.0530015615392923f)
            },
            // Instance 2: EID3336_Instance_002
            new InstanceData
            {
                name = "EID3336_Instance_002",
                position = new Vector3(-522.4000244140625f, 83.2699966430664f, 458.8999938964844f),
                rotation = new Vector3(174.40617815686485f, -53.00015692390648f, 12.278443315584184f),
                scale = new Vector3(1.0529995017491167f, 1.0529994401052556f, 1.0529999954554363f)
            }
        };

        private void Start()
        {
            if (autoCreateOnStart)
            {
                CreateInstances();
            }
        }

        /// <summary>
        /// Create all 3 instances in the scene with their captured transforms
        /// </summary>
        [ContextMenu("Create Instances")]
        public void CreateInstances()
        {
            if (modelPrefab == null)
            {
                Debug.LogError("EID3336SceneSetup: Model prefab is not assigned!");
                return;
            }

            // Clear existing instances
            ClearInstances();

            // Create each instance
            foreach (var data in instances)
            {
                GameObject instance = Instantiate(modelPrefab, transform);
                instance.name = data.name;

                // Apply transform
                instance.transform.position = data.position;
                instance.transform.eulerAngles = data.rotation;
                instance.transform.localScale = data.scale;

                Debug.Log($"Created {data.name} at position {data.position}");
            }

            Debug.Log($"EID3336: Created {instances.Length} model instances");
        }

        /// <summary>
        /// Clear all existing instances
        /// </summary>
        [ContextMenu("Clear Instances")]
        public void ClearInstances()
        {
            // Remove all children
            for (int i = transform.childCount - 1; i >= 0; i--)
            {
                if (Application.isPlaying)
                    Destroy(transform.GetChild(i).gameObject);
                else
                    DestroyImmediate(transform.GetChild(i).gameObject);
            }
        }

        private struct InstanceData
        {
            public string name;
            public Vector3 position;
            public Vector3 rotation;  // Euler angles in degrees
            public Vector3 scale;
        }

#if UNITY_EDITOR
        private void OnDrawGizmos()
        {
            // Visualize instance positions in Scene view
            Gizmos.color = Color.yellow;
            foreach (var data in instances)
            {
                Gizmos.DrawWireSphere(data.position, 1f);
            }
        }
#endif
    }
}
