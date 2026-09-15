#!/usr/bin/env python3
"""
Direct Unity GameObject creation via MCP execute_code tool
"""
import requests
import json
import sys

MCP_URL = "http://localhost:8080/mcp"

def execute_unity_code(code):
    """Execute C# code in Unity Editor via MCP"""
    payload = {
        "jsonrpc": "2.0",
        "method": "tools/call",
        "id": 1,
        "params": {
            "name": "execute_code",
            "arguments": {
                "code": code
            }
        }
    }

    headers = {
        "Content-Type": "application/json",
        "Accept": "application/json"
    }

    response = requests.post(MCP_URL, json=payload, headers=headers)
    print(f"Status: {response.status_code}")
    print(f"Response: {response.text[:500]}")
    return response

# C# code to create 3 EID3336 instances
unity_csharp_code = """
using UnityEngine;
using UnityEditor;

// Load model
string modelPath = "Assets/EID3332_EID3336_Combined/Models/EID3336_VSInput.fbx";
GameObject modelPrefab = AssetDatabase.LoadAssetAtPath<GameObject>(modelPath);

if (modelPrefab == null)
{
    Debug.LogError("Model not found at " + modelPath);
    return "ERROR: Model not found";
}

// Create parent
GameObject container = new GameObject("EID3336_Instances");

// Instance data from M matrix
var instances = new[] {
    new { name = "EID3336_Instance_000",
          pos = new Vector3(-533.9f, 86.24f, 445.91f),
          rot = new Vector3(169.05f, -24.81f, 6.11f),
          scale = new Vector3(0.852f, 0.852f, 0.852f) },
    new { name = "EID3336_Instance_001",
          pos = new Vector3(-515.03f, 87.69f, 454.82f),
          rot = new Vector3(-19.31f, 68.79f, 154.45f),
          scale = new Vector3(1.053f, 1.053f, 1.053f) },
    new { name = "EID3336_Instance_002",
          pos = new Vector3(-522.4f, 83.27f, 458.9f),
          rot = new Vector3(174.41f, -53.0f, 12.28f),
          scale = new Vector3(1.053f, 1.053f, 1.053f) }
};

// Create each instance
foreach (var data in instances)
{
    GameObject inst = (GameObject)PrefabUtility.InstantiatePrefab(modelPrefab, container.transform);
    inst.name = data.name;
    inst.transform.position = data.pos;
    inst.transform.eulerAngles = data.rot;
    inst.transform.localScale = data.scale;
    Debug.Log("Created " + data.name);
}

Selection.activeGameObject = container;
return "SUCCESS: Created 3 EID3336 instances";
"""

print("Executing Unity code to create EID3336 instances...")
print("=" * 60)

try:
    response = execute_unity_code(unity_csharp_code)

    if response.status_code == 200:
        print("\n✓ Code sent to Unity successfully!")
        print("Check Unity Console and Hierarchy for 'EID3336_Instances'")
    else:
        print(f"\n✗ Failed with status {response.status_code}")

except Exception as e:
    print(f"\n✗ Error: {e}")
    sys.exit(1)
