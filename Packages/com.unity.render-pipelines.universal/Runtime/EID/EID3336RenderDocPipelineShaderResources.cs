using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine;
using UnityEngine.Rendering;

namespace UnityEngine.Rendering.Universal.Internal
{
    // Pipeline-owned resource bridge for the independent EID3336 UniversalGBuffer
    // shader. No scene-side MonoBehaviour is required for these bindings.
    internal static class EID3336RenderDocPipelineShaderResources
    {
        static readonly (string shaderName, string resourcePath)[] ConstantResources =
        {
            ("VS_24_25", "EID3336VS/_24_25"),
            ("VS_26_27", "EID3336VS/_26_27"),
            ("_18_19", "EID3336CB/_18_19"),
            ("_20_21", "EID3336CB/_20_21"),
            ("_22_24", "EID3336CB/_22_24"),
            ("_43_44_CAPTURE", "EID3336CB/_43_44"),
            ("_45_46", "EID3336CB/_45_46"),
            ("_47_48", "EID3336CB/_47_48"),
            ("_49_50", "EID3336CB/_49_50"),
            ("_51_52", "EID3336CB/_51_52")
        };

        static readonly Dictionary<int, GraphicsBuffer> constants = new Dictionary<int, GraphicsBuffer>();
        [StructLayout(LayoutKind.Sequential, Size = 256)]
        struct Raw256
        {
            public Vector4 a0, a1, a2, a3, a4, a5, a6, a7;
            public Vector4 a8, a9, a10, a11, a12, a13, a14, a15;
        }

        static ComputeBuffer instanceBuffer;
        static ComputeBuffer vertexBuffer;
        static bool initialized;
        static bool available;
        static bool warned;

        public static bool Bind(CommandBuffer cmd)
        {
            if (cmd == null) return false;
            Ensure();
            if (!available) return false;

            foreach (var pair in constants)
                if (pair.Value != null)
                    cmd.SetGlobalConstantBuffer(pair.Value, pair.Key, 0, pair.Value.count * 4);
            if (instanceBuffer != null)
                cmd.SetGlobalBuffer(Shader.PropertyToID("VS_30_m0"), instanceBuffer);
            if (vertexBuffer != null)
                cmd.SetGlobalBuffer(Shader.PropertyToID("VS_32"), vertexBuffer);
            return true;
        }

        static void Ensure()
        {
            if (initialized && available) return;
            initialized = true;
            bool foundAny = false;
            foreach (var entry in ConstantResources)
            {
                byte[] bytes = LoadBytes(entry.resourcePath);
                if (bytes == null || bytes.Length == 0) continue;
                int padded = (bytes.Length + 15) & ~15;
                uint[] words = new uint[padded / 4];
                Buffer.BlockCopy(bytes, 0, words, 0, bytes.Length);
                var buffer = new GraphicsBuffer(GraphicsBuffer.Target.Constant, words.Length, 4);
                buffer.SetData(words);
                constants[Shader.PropertyToID(entry.shaderName)] = buffer;
                foundAny = true;
            }

            byte[] instanceBytes = LoadBytes("EID3336VS/_28_30");
            if (instanceBytes != null && instanceBytes.Length >= 256 && instanceBytes.Length % 256 == 0)
            {
                int count = instanceBytes.Length / 256;
                Raw256[] records = new Raw256[count];
                GCHandle pin = GCHandle.Alloc(records, GCHandleType.Pinned);
                try { Marshal.Copy(instanceBytes, 0, pin.AddrOfPinnedObject(), instanceBytes.Length); }
                finally { pin.Free(); }
                instanceBuffer = new ComputeBuffer(count, 256, ComputeBufferType.Structured);
                instanceBuffer.SetData(records);
                foundAny = true;
            }

            byte[] vertexBytes = LoadBytes("EID3336VS/_32");
            if (vertexBytes != null && vertexBytes.Length > 0)
            {
                int padded = (vertexBytes.Length + 3) & ~3;
                uint[] words = new uint[padded / 4];
                Buffer.BlockCopy(vertexBytes, 0, words, 0, vertexBytes.Length);
                vertexBuffer = new ComputeBuffer(words.Length, 4, ComputeBufferType.Raw);
                vertexBuffer.SetData(words);
                foundAny = true;
            }
            available = foundAny;
            if (!available && !warned)
            {
                warned = true;
                Debug.LogWarning("EID3336 RenderDoc VS resources are not available under Resources/EID3336VS or Resources/EID3336CB yet.");
            }
        }

        static byte[] LoadBytes(string resourcePath)
        {
            TextAsset asset = Resources.Load<TextAsset>(resourcePath);
            return asset != null ? asset.bytes : null;
        }
    }
}

