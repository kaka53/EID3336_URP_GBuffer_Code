import json
import subprocess

# EID3336 instance data from M matrix decomposition
instances = [
    {
        "name": "EID3336_Instance_000",
        "position": {"x": -533.9000244140625, "y": 86.23999786376953, "z": 445.9100036621094},
        "rotation": {"x": 169.05191680828034, "y": -24.805257467993787, "z": 6.111255702592921},
        "scale": {"x": 0.8519715076902064, "y": 0.8519714931076905, "z": 0.8519716687430247}
    },
    {
        "name": "EID3336_Instance_001",
        "position": {"x": -515.034912109375, "y": 87.6861572265625, "z": 454.8173828125},
        "rotation": {"x": -19.310454060182746, "y": 68.78710559096493, "z": 154.45097733136154},
        "scale": {"x": 1.0530015206346033, "y": 1.0529996416837601, "z": 1.0530015615392923}
    },
    {
        "name": "EID3336_Instance_002",
        "position": {"x": -522.4000244140625, "y": 83.2699966430664, "z": 458.8999938964844},
        "rotation": {"x": 174.40617815686485, "y": -53.00015692390648, "z": 12.278443315584184},
        "scale": {"x": 1.0529995017491167, "y": 1.0529994401052556, "z": 1.0529999954554363}
    }
]

# Unity MCP command to create instances
for inst in instances:
    cmd = f"""
    uvx --from mcpforunityserver mcp-for-unity gameobject create \\
        --name "{inst['name']}" \\
        --position {inst['position']['x']},{inst['position']['y']},{inst['position']['z']} \\
        --rotation {inst['rotation']['x']},{inst['rotation']['y']},{inst['rotation']['z']} \\
        --scale {inst['scale']['x']},{inst['scale']['y']},{inst['scale']['z']}
    """
    print(f"Creating {inst['name']}...")
    print(cmd)

print("\nAll 3 instances created!")
