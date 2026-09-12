using System;
using UnityEngine;

[CreateAssetMenu(fileName = "EID3336_VSBufferParameters", menuName = "EID3336/VS Buffer Parameters")]
public sealed class EID3336VSBufferParameters : ScriptableObject
{
    [Serializable]
    public sealed class ParameterRecord
    {
        public string name;
        public string type;
        public int byteOffset;
        public int byteSize;
        public Vector4[] values;
        public string[] formattedValues;
    }

    [Serializable]
    public sealed class BufferRecord
    {
        public string name;
        public string shaderResourceName;
        public string stage;
        public string kind;
        public int descriptorSet;
        [HideInInspector] public int set; // legacy alias for older exporter data
        public int binding;
        public int resourceId;
        public int byteSize;
        public int sourceOffset;
        public int rangeStart;
        public int rangeEnd;
        public int variableCount;
        public int structuredStride;
        public int structuredElementCount;
        public string sourceResource;
        [Tooltip("Exact RenderDoc payload, retained for runtime binding.")]
        public byte[] data;
        [Tooltip("Decoded numeric values shown by the Inspector. Matrices and arrays are expanded into 16-byte rows.")]
        public ParameterRecord[] parameters;
    }

    [Serializable]
    public sealed class InputRecord
    {
        public string name;
        public string type;
        public int stream;
        public int offset;
        public int stride;
        public string semantic;
        public string notes;
    }

    public int eventId = 3336;
    public int vertexShaderId = 209986;
    public int indexCount = 7980;
    public int instanceCount = 3;
    public int vertexCount = 1716;
    public int indexStride = 2;
    public string sourceDescription = "RenderDoc EID3336 / VS module 209986 / numeric values decoded from captured VS buffers";
    public BufferRecord[] buffers = Array.Empty<BufferRecord>();
    public InputRecord[] inputLayout = Array.Empty<InputRecord>();

    public byte[] GetBytes(string name)
    {
        BufferRecord record = GetRecord(name);
        return record != null ? record.data : null;
    }

    public BufferRecord GetRecord(string name)
    {
        if (buffers == null || string.IsNullOrEmpty(name)) return null;
        for (int i = 0; i < buffers.Length; ++i)
            if (buffers[i] != null && buffers[i].name == name)
                return buffers[i];
        return null;
    }

    public bool Has(string name)
    {
        byte[] bytes = GetBytes(name);
        return bytes != null && bytes.Length > 0;
    }

    public bool Validate(out string error)
    {
        if (eventId != 3336 || vertexShaderId != 209986)
        {
            error = "Event/VS mismatch.";
            return false;
        }
        if (buffers == null || buffers.Length == 0)
        {
            error = "No serialized VS buffers.";
            return false;
        }
        string[] required = { "VS_24_25", "VS_26_27", "VS_28_30", "VS_32", "EID3336RawStream0", "EID3336RawStream1", "EID3336RawConstants", "EID3336RawIndices" };
        for (int i = 0; i < required.Length; ++i)
            if (!Has(required[i]))
            {
                error = "Missing serialized buffer: " + required[i];
                return false;
            }
        if (GetBytes("VS_24_25").Length != 1312 || GetBytes("VS_26_27").Length != 3200 || GetBytes("VS_28_30").Length != 65536 || GetBytes("VS_32").Length != 8413184)
        {
            error = "Serialized VS buffer size mismatch.";
            return false;
        }
        if (GetBytes("EID3336RawStream0").Length != 27456 || GetBytes("EID3336RawStream1").Length != 27456 || GetBytes("EID3336RawConstants").Length != 20 || GetBytes("EID3336RawIndices").Length != 15960)
        {
            error = "Serialized raw draw buffer size mismatch.";
            return false;
        }
        if (GetRecord("VS_24_25").sourceOffset != 369408 || GetRecord("VS_26_27").sourceOffset != 370944 || GetRecord("VS_28_30").sourceOffset != 7495168)
        {
            error = "RenderDoc source offset mismatch.";
            return false;
        }
        if (GetRecord("VS_24_25").variableCount != 22 || GetRecord("VS_26_27").variableCount != 139 || GetRecord("VS_28_30").variableCount != 1)
        {
            error = "RenderDoc variable count mismatch.";
            return false;
        }
        error = null;
        return true;
    }
}


