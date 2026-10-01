using System;
using System.IO;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;

namespace EID4730
{
    public sealed class EID4789ReplaySession : IDisposable
    {
        [Serializable] sealed class ReplayManifest { public int eventId, width, height, indexCount, vertexCount; public TextureEntry[] textures; public BufferEntry[] buffers; public FileEntry[] files; }
        [Serializable] sealed class TextureEntry { public string name, dimension, format; public int resourceId, register, width, height, depth, slices, mips; public FileEntry[] files; }
        [Serializable] sealed class BufferEntry { public string name, kind, file, sha256; public int size, byteOffset; }
        [Serializable] sealed class FileEntry { public string file, sha256; public int size, mip, slice; }
        [StructLayout(LayoutKind.Sequential)] struct Word16 { public uint x, y, z, w; }

        readonly List<UnityEngine.Object> objects = new List<UnityEngine.Object>();
        readonly List<ComputeBuffer> buffers = new List<ComputeBuffer>();
        readonly Dictionary<string, ComputeBuffer> bindings = new Dictionary<string, ComputeBuffer>();
        readonly Dictionary<string, int> sizes = new Dictionary<string, int>();
        readonly Dictionary<string, Texture> textures = new Dictionary<string, Texture>();
        readonly string root;

        public IEnumerable<KeyValuePair<string, Texture>> TextureBindings => textures;
        public int TextureBindingCount => textures.Count;
        public int BufferBindingCount => bindings.Count;
        public bool IsValid
        {
            get
            {
                if (buffers.Count == 0) return false;
                foreach (var b in buffers) if (b == null || !b.IsValid()) return false;
                return true;
            }
        }


        public EID4789ReplaySession(string manifestPath, bool makeNoLongerReadable = true, bool loadTextures = true)
        {
            root = Path.GetDirectoryName(Path.GetFullPath(manifestPath));
            var m = JsonUtility.FromJson<ReplayManifest>(File.ReadAllText(manifestPath));
            if (m == null || m.eventId != 4789 || m.indexCount != 5001 || m.vertexCount != 1521)
                throw new InvalidDataException("EID4789 manifest mismatch");
            Verify(m.files);
            try
            {
                foreach (var t in loadTextures ? m.textures : Array.Empty<TextureEntry>())
                {
                    var x = CreateTexture(t, out bool expand);
                    foreach (var f in t.files)
                    {
                        var b = Read(f.file);
                        if (expand) b = ExpandB10G11(b);
                        if (x is Texture3D volume) volume.SetPixelData(b, f.mip);
                        else if (x is Cubemap cube) cube.SetPixelData(b, f.mip, (CubemapFace)f.slice);
                        else ((Texture2D)x).SetPixelData(b, f.mip);
                    }
                    if (x is Texture3D volumeApply) volumeApply.Apply(false, makeNoLongerReadable);
                    else if (x is Cubemap cubeApply) cubeApply.Apply(false, makeNoLongerReadable);
                    else ((Texture2D)x).Apply(false, makeNoLongerReadable);
                    textures.Add(t.name, x);
                }
                foreach (var e in m.buffers)
                {
                    var b = Read(e.file);
                    if (b.Length != e.size) throw new InvalidDataException(e.file);
                    ComputeBuffer cb;
                    if (e.kind == "storage")
                    {
                        cb = Raw(b);
                    }
                    else
                    {
                        if ((b.Length & 15) != 0) throw new InvalidDataException("Constant buffer alignment " + e.file);
                        var words = new Word16[b.Length / 16];
                        for (int i = 0; i < words.Length; i++)
                            words[i] = new Word16
                            {
                                x = BitConverter.ToUInt32(b, i * 16),
                                y = BitConverter.ToUInt32(b, i * 16 + 4),
                                z = BitConverter.ToUInt32(b, i * 16 + 8),
                                w = BitConverter.ToUInt32(b, i * 16 + 12)
                            };
                        cb = new ComputeBuffer(words.Length, 16, ComputeBufferType.Constant);
                        buffers.Add(cb);
                        cb.SetData(words);
                        sizes.Add(e.name, b.Length);
                    }
                    bindings.Add(e.name, cb);
                }
            }
            catch
            {
                Dispose();
                throw;
            }
        }

        void Verify(FileEntry[] files)
        {
            using (var sha = System.Security.Cryptography.SHA256.Create())
            {
                foreach (var f in files)
                {
                    var b = Read(f.file);
                    if (b.Length != f.size || !string.Equals(BitConverter.ToString(sha.ComputeHash(b)).Replace("-", ""), f.sha256, StringComparison.OrdinalIgnoreCase))
                        throw new InvalidDataException("EID4789 payload verification failed: " + f.file);
                }
            }
        }

        byte[] Read(string relative)
        {
            var p = Path.GetFullPath(Path.Combine(root, relative));
            if (!p.StartsWith(root + Path.DirectorySeparatorChar, StringComparison.OrdinalIgnoreCase))
                throw new InvalidDataException("Invalid EID4789 payload path");
            return File.ReadAllBytes(p);
        }

        ComputeBuffer Raw(byte[] b)
        {
            if ((b.Length & 3) != 0) throw new InvalidDataException("Raw buffer alignment");
            var w = new uint[b.Length / 4];
            Buffer.BlockCopy(b, 0, w, 0, b.Length);
            var cb = new ComputeBuffer(w.Length, 4, ComputeBufferType.Raw);
            buffers.Add(cb);
            cb.SetData(w);
            return cb;
        }

        Texture CreateTexture(TextureEntry t, out bool expand)
        {
            var fmt = (GraphicsFormat)Enum.Parse(typeof(GraphicsFormat), t.format);
            expand = fmt == GraphicsFormat.B10G11R11_UFloatPack32 && !SystemInfo.IsFormatSupported(fmt, FormatUsage.Sample);
            if (expand) fmt = GraphicsFormat.R32G32B32A32_SFloat;
            if (!SystemInfo.IsFormatSupported(fmt, FormatUsage.Sample))
                throw new NotSupportedException("EID4789 unsupported format " + fmt);
            var flags = t.mips > 1 ? TextureCreationFlags.MipChain : TextureCreationFlags.None;
            Texture x;
            if (t.dimension == "texture3D") x = new Texture3D(t.width, t.height, t.depth, fmt, flags, t.mips);
            else if (t.dimension == "textureCube") x = new Cubemap(t.width, fmt, flags, t.mips);
            else x = new Texture2D(t.width, t.height, fmt, t.mips, flags);
            x.name = "EID4789 " + t.name + " rid" + t.resourceId;
            x.filterMode = FilterMode.Bilinear;
            x.wrapMode = TextureWrapMode.Clamp;
            return Own(x);
        }

        static byte[] ExpandB10G11(byte[] packed)
        {
            if ((packed.Length & 3) != 0) throw new InvalidDataException("EID4789 B10G11R11 data is not 32-bit aligned");
            byte[] expanded = new byte[packed.Length * 4];
            for (int i = 0; i < packed.Length; i += 4)
            {
                uint word = BitConverter.ToUInt32(packed, i);
                uint r = word & 0x7ffu, g = (word >> 11) & 0x7ffu, b = (word >> 22) & 0x3ffu;
                float rf = DecodeUnsignedFloat(r, 6), gf = DecodeUnsignedFloat(g, 6), bf = DecodeUnsignedFloat(b, 5);
                Buffer.BlockCopy(BitConverter.GetBytes(rf), 0, expanded, i * 4, 4);
                Buffer.BlockCopy(BitConverter.GetBytes(gf), 0, expanded, i * 4 + 4, 4);
                Buffer.BlockCopy(BitConverter.GetBytes(bf), 0, expanded, i * 4 + 8, 4);
                Buffer.BlockCopy(BitConverter.GetBytes(1.0f), 0, expanded, i * 4 + 12, 4);
            }
            return expanded;
        }

        static float DecodeUnsignedFloat(uint bits, int mantissaBits)
        {
            uint mantissaMask = (1u << mantissaBits) - 1u;
            uint exponent = bits >> mantissaBits, mantissa = bits & mantissaMask;
            if (exponent == 0) return (float)(mantissa * Math.Pow(2.0, 1 - 15 - mantissaBits));
            if (exponent == 31) return mantissa == 0 ? float.PositiveInfinity : float.NaN;
            return (float)((1.0 + mantissa / (double)(1u << mantissaBits)) * Math.Pow(2.0, (int)exponent - 15));
        }

        T Own<T>(T x) where T : UnityEngine.Object
        {
            x.hideFlags = HideFlags.HideAndDontSave;
            objects.Add(x);
            return x;
        }

        public void Bind(Material material, bool includeTextures = true)
        {
            if (includeTextures) foreach (var p in textures) material.SetTexture(p.Key, p.Value);
            foreach (var p in bindings)
            {
                foreach (var alias in Aliases(p.Key))
                {
                    if (sizes.TryGetValue(p.Key, out var size)) material.SetConstantBuffer(alias, p.Value, 0, size);
                    else material.SetBuffer(alias, p.Value);
                }
            }
        }

        public void Bind(CommandBuffer cmd)
        {
            foreach (var p in textures) cmd.SetGlobalTexture(p.Key, p.Value);
            foreach (var p in bindings)
            {
                foreach (var alias in Aliases(p.Key))
                {
                    int id = Shader.PropertyToID(alias);
                    if (sizes.TryGetValue(p.Key, out var size)) cmd.SetGlobalConstantBuffer(p.Value, id, 0, size);
                    else cmd.SetGlobalBuffer(id, p.Value);
                }
            }
        }

        static IEnumerable<string> Aliases(string name)
        {
            yield return name;
        }

        public void Dispose()
        {
            foreach (var b in buffers) b.Release();
            buffers.Clear();
            foreach (var x in objects) if (x != null) UnityEngine.Object.DestroyImmediate(x);
            objects.Clear();
        }
    }
}
