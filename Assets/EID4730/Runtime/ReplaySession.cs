using System;
using System.Collections.Generic;
using System.IO;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;

namespace EID4730
{
    public sealed class ReplaySession : IDisposable
    {
        [Serializable] public class FileEntry { public string file, sha256; public int size, mip, slice; }
        [Serializable] public class TextureEntry
        {
            public string name, dimension, format;
            public int resourceId, width, height, depth, slices, mips;
            public FileEntry[] files;
        }
        [Serializable] public class BufferEntry { public string name, kind, file, sha256; public int size; }
        [Serializable] public class Manifest
        {
            public int eventId, width, height, indexCount, vertexCount;
            public TextureEntry[] textures; public BufferEntry[] buffers; public FileEntry[] files;
        }
        [StructLayout(LayoutKind.Sequential)] struct Word16 { public uint x, y, z, w; }
        readonly List<UnityEngine.Object> objects = new List<UnityEngine.Object>();
        readonly List<ComputeBuffer> buffers = new List<ComputeBuffer>();
        readonly Dictionary<string, ComputeBuffer> bindings = new Dictionary<string, ComputeBuffer>();
        readonly Dictionary<string, int> constantSizes = new Dictionary<string, int>();
        readonly Dictionary<string, Texture> textures = new Dictionary<string, Texture>();
        readonly string root;
        readonly Material draw;
        public Manifest Capture { get; private set; }
        public Material Draw { get { return draw; } }
        public bool disposed { get; private set; }

        public ReplaySession(Shader shader, bool verifyHashes = true)
        {
            root = Path.Combine(Application.streamingAssetsPath, "EID4730");
            try
            {
                GraphicsDeviceType api = SystemInfo.graphicsDeviceType;
                if (api != GraphicsDeviceType.Vulkan && api != GraphicsDeviceType.Direct3D11)
                    throw new NotSupportedException("EID4730: shader is vulkan/d3d11 only. Current API=" + api);
                if (shader == null || !shader.isSupported)
                    throw new InvalidOperationException("EID4730: replay shader is missing or unsupported.");
                Capture = JsonUtility.FromJson<Manifest>(File.ReadAllText(Path.Combine(root, "replay.json")));
                if (Capture.eventId != 4730 || Capture.width != 1366 || Capture.height != 768 || Capture.indexCount != 69195)
                    throw new InvalidDataException("Unexpected capture manifest.");
                if (verifyHashes)
                    using (SHA256 hash = SHA256.Create())
                        foreach (FileEntry f in Capture.files)
                        {
                            byte[] bytes = Read(f.file);
                            if (bytes.Length != f.size || !string.Equals(BitConverter.ToString(hash.ComputeHash(bytes)).Replace("-", ""), f.sha256, StringComparison.OrdinalIgnoreCase))
                                throw new InvalidDataException("Capture integrity failure: " + f.file);
                        }
                draw = Own(new Material(shader) { name = "EID4730 original VS/FS live MVP", enableInstancing = false });
                foreach (TextureEntry t in Capture.textures)
                {
                    Texture tex = LoadTexture(t);
                    textures.Add(t.name, tex);
                    draw.SetTexture(t.name, tex);
                }
                foreach (BufferEntry b in Capture.buffers)
                {
                    if (b.name == "VS_23_24" || b.name == "VS_25_26" || b.name == "VS_27_29" || b.name == "VS_31")
                        continue;
                    byte[] bytes = Read(b.file);
                    if (bytes.Length != b.size) throw new InvalidDataException(b.file);
                    ComputeBuffer buffer;
                    if (b.kind == "constant")
                    {
                        if ((bytes.Length & 15) != 0) throw new InvalidDataException("Constant buffer alignment: " + b.name);
                        Word16[] words = new Word16[bytes.Length / 16];
                        for (int i = 0; i < words.Length; i++) words[i] = new Word16 { x = BitConverter.ToUInt32(bytes, i * 16), y = BitConverter.ToUInt32(bytes, i * 16 + 4), z = BitConverter.ToUInt32(bytes, i * 16 + 8), w = BitConverter.ToUInt32(bytes, i * 16 + 12) };
                        buffer = new ComputeBuffer(words.Length, 16, ComputeBufferType.Constant); buffers.Add(buffer); buffer.SetData(words);
                        constantSizes.Add(b.name, bytes.Length);
                    }
                    else buffer = Raw(bytes);
                    bindings.Add(b.name, buffer);
                }
            }
            catch { Dispose(); throw; }
        }
        T Own<T>(T value) where T : UnityEngine.Object { value.hideFlags = HideFlags.HideAndDontSave; objects.Add(value); return value; }
        byte[] Read(string name)
        {
            string path = Path.GetFullPath(Path.Combine(root, name));
            if (!path.StartsWith(Path.GetFullPath(root) + Path.DirectorySeparatorChar, StringComparison.OrdinalIgnoreCase)) throw new InvalidDataException("Invalid capture path.");
            return File.ReadAllBytes(path);
        }
        ComputeBuffer Raw(byte[] bytes)
        {
            if ((bytes.Length & 3) != 0) throw new InvalidDataException("Raw buffer alignment");
            uint[] words = new uint[bytes.Length / 4]; Buffer.BlockCopy(bytes, 0, words, 0, bytes.Length);
            var buffer = new ComputeBuffer(words.Length, 4, ComputeBufferType.Raw); buffers.Add(buffer); buffer.SetData(words); return buffer;
        }
        Texture LoadTexture(TextureEntry t)
        {
            GraphicsFormat format = (GraphicsFormat)Enum.Parse(typeof(GraphicsFormat), t.format);
            if (!SystemInfo.IsFormatSupported(format, FormatUsage.Sample)) throw new NotSupportedException("Unsupported captured texture: " + format);
            TextureCreationFlags flags = t.mips > 1 ? TextureCreationFlags.MipChain : TextureCreationFlags.None;
            Texture result;
            if (t.dimension == "texture3D") result = Own(new Texture3D(t.width, t.height, t.depth, format, flags, t.mips));
            else if (t.dimension == "textureCube") result = Own(new Cubemap(t.width, format, flags, t.mips));
            else result = Own(new Texture2D(t.width, t.height, format, t.mips, flags));
            result.name = t.name + " / resource " + t.resourceId; result.filterMode = FilterMode.Bilinear; result.wrapMode = TextureWrapMode.Clamp; result.anisoLevel = 0;
            foreach (FileEntry f in t.files)
            {
                byte[] data = Read(f.file);
                if (result is Texture3D volume) volume.SetPixelData(data, f.mip);
                else if (result is Cubemap cube) cube.SetPixelData(data, f.mip, (CubemapFace)f.slice);
                else ((Texture2D)result).SetPixelData(data, f.mip);
            }
            if (result is Texture3D v) v.Apply(false, true); else if (result is Cubemap c) c.Apply(false, true); else ((Texture2D)result).Apply(false, true);
            return result;
        }
        static readonly HashSet<string> FrameSkip = new HashSet<string>(StringComparer.Ordinal)
        {
            "FS_56", "FS_58", "FS_48_49", "VS_32_33"
        };

        public void Bind(CommandBuffer cmd)
        {
            BindResources(cmd, true, false);
        }

        public void BindFrame(CommandBuffer cmd)
        {
            BindResources(cmd, false, true);
        }

        void BindResources(CommandBuffer cmd, bool bindDraw, bool skipInstance)
        {
            if (disposed) throw new ObjectDisposedException(nameof(ReplaySession));
            foreach (var pair in textures)
            {
                if (skipInstance && FrameSkip.Contains(pair.Key)) continue;
                if (bindDraw) draw.SetTexture(pair.Key, pair.Value);
                cmd.SetGlobalTexture(pair.Key, pair.Value);
            }
            foreach (var pair in bindings)
            {
                if (skipInstance && FrameSkip.Contains(pair.Key)) continue;
                int id = Shader.PropertyToID(pair.Key);
                if (constantSizes.TryGetValue(pair.Key, out int size))
                {
                    if (bindDraw) draw.SetConstantBuffer(id, pair.Value, 0, size);
                    cmd.SetGlobalConstantBuffer(pair.Value, id, 0, size);
                }
                else
                {
                    if (bindDraw) draw.SetBuffer(pair.Key, pair.Value);
                    cmd.SetGlobalBuffer(id, pair.Value);
                }
            }
        }
        public void Dispose()
        {
            if (disposed) return; disposed = true;
            foreach (var b in buffers) b.Release(); buffers.Clear(); bindings.Clear(); textures.Clear();
            foreach (var o in objects) if (o != null) { if (Application.isPlaying) UnityEngine.Object.Destroy(o); else UnityEngine.Object.DestroyImmediate(o); }
            objects.Clear();
        }
    }
}
