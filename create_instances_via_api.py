import requests
import json

# Unity MCP server endpoint
MCP_URL = "http://localhost:8080/api"

def create_gameobject(name, position, rotation, scale):
    """Create a GameObject in Unity via MCP API"""
    payload = {
        "name": name,
        "position": position,
        "rotation": rotation,
        "scale": scale,
        "parent": "EID3336_Instances"
    }

    response = requests.post(f"{MCP_URL}/gameobject/create", json=payload)
    return response.json()

def create_parent_container():
    """Create parent container GameObject"""
    payload = {"name": "EID3336_Instances"}
    response = requests.post(f"{MCP_URL}/gameobject/create", json=payload)
    return response.json()

# EID3336 instance data
instances = [
    {
        "name": "EID3336_Instance_000",
        "position": [-533.9000244140625, 86.23999786376953, 445.9100036621094],
        "rotation": [169.05191680828034, -24.805257467993787, 6.111255702592921],
        "scale": [0.8519715076902064, 0.8519714931076905, 0.8519716687430247]
    },
    {
        "name": "EID3336_Instance_001",
        "position": [-515.034912109375, 87.6861572265625, 454.8173828125],
        "rotation": [-19.310454060182746, 68.78710559096493, 154.45097733136154],
        "scale": [1.0530015206346033, 1.0529996416837601, 1.0530015615392923]
    },
    {
        "name": "EID3336_Instance_002",
        "position": [-522.4000244140625, 83.2699966430664, 458.8999938964844],
        "rotation": [174.40617815686485, -53.00015692390648, 12.278443315584184],
        "scale": [1.0529995017491167, 1.0529994401052556, 1.0529999954554363]
    }
]

print("Creating parent container...")
try:
    result = create_parent_container()
    print(f"Container created: {result}")
except Exception as e:
    print(f"Container may already exist: {e}")

print("\nCreating EID3336 model instances...")
for inst in instances:
    try:
        result = create_gameobject(
            inst["name"],
            inst["position"],
            inst["rotation"],
            inst["scale"]
        )
        print(f"✓ Created {inst['name']}")
    except Exception as e:
        print(f"✗ Failed to create {inst['name']}: {e}")

print("\n✓ All 3 instances created in Unity scene!")
