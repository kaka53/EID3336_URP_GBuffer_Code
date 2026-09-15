#!/usr/bin/env python3
import requests
import json

MCP_URL = "http://localhost:8080/mcp"

# C# code to create instances
csharp_code = """
using UnityEngine;
using UnityEditor;

string modelPath = "Assets/EID3332_EID3336_Combined/Models/EID3336_VSInput.fbx";
GameObject modelPrefab = AssetDatabase.LoadAssetAtPath<GameObject>(modelPath);

if (modelPrefab == null) { return "ERROR: Model not found"; }

GameObject container = new GameObject("EID3336_Instances");

var instances = new[] {
    new { name = "EID3336_Instance_000", pos = new Vector3(-533.9f, 86.24f, 445.91f), rot = new Vector3(169.05f, -24.81f, 6.11f), scale = new Vector3(0.852f, 0.852f, 0.852f) },
    new { name = "EID3336_Instance_001", pos = new Vector3(-515.03f, 87.69f, 454.82f), rot = new Vector3(-19.31f, 68.79f, 154.45f), scale = new Vector3(1.053f, 1.053f, 1.053f) },
    new { name = "EID3336_Instance_002", pos = new Vector3(-522.4f, 83.27f, 458.9f), rot = new Vector3(174.41f, -53.0f, 12.28f), scale = new Vector3(1.053f, 1.053f, 1.053f) }
};

foreach (var d in instances) {
    GameObject inst = (GameObject)PrefabUtility.InstantiatePrefab(modelPrefab, container.transform);
    inst.name = d.name;
    inst.transform.position = d.pos;
    inst.transform.eulerAngles = d.rot;
    inst.transform.localScale = d.scale;
}
return "Created 3 instances";
"""

payload = {
    "jsonrpc": "2.0",
    "method": "tools/call",
    "id": 1,
    "params": {
        "name": "execute_code",
        "arguments": {"code": csharp_code}
    }
}

headers = {
    "Content-Type": "application/json",
    "Accept": "application/json, text/event-stream"
}

print("Sending request to Unity MCP...")
response = requests.post(MCP_URL, json=payload, headers=headers, stream=True)
print(f"Status: {response.status_code}")

if response.status_code == 200:
    print("Response:")
    for line in response.iter_lines():
        if line:
            print(line.decode('utf-8'))
else:
    print(f"Error: {response.text}")
