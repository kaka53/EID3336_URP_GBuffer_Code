using System;
using System.IO;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Experimental.Rendering;

/// <summary>
/// Private render targets and GPU buffers for the EID4662 RenderDoc Compute Pass #2 replay.
/// The generated targets are not camera color and are never used as substitutes for captured inputs.
/// </summary>
internal sealed class EID4662ComputePass2Resources : IDisposable
{
    public int FullWidth { get; private set; }
    public int FullHeight { get; private set; }
    public int HalfWidth { get; private set; }
    public int HalfHeight { get; private set; }

    public RenderTexture halfA;
    public RenderTexture halfB;
    public RenderTexture halfC;
    public RenderTexture pingA;
    public RenderTexture pingB;
    public RenderTexture fullScratch;
    public RenderTexture halfScratch;
    public RenderTexture packedFull;
    public RenderTexture packedHalf;

    public RenderTexture res18;
    public RenderTexture res19;
    public RenderTexture res33;
    public RenderTexture debugPreview;

    public ComputeBuffer dispatchArgs4542;
    public ComputeBuffer dispatchArgs4546;
    public ComputeBuffer dispatchArgs4550;
    public ComputeBuffer ssbo21;

    string bufferIdentity;

    public void Ensure(int fullWidth, int fullHeight)
    {
        fullWidth = Mathf.Max(1, fullWidth);
        fullHeight = Mathf.Max(1, fullHeight);
        int halfWidth = Mathf.Max(1, (fullWidth + 1) / 2);
        int halfHeight = Mathf.Max(1, (fullHeight + 1) / 2);
        if (FullWidth == fullWidth && FullHeight == fullHeight && AllCreated()) return;

        ReleaseTextures();
        FullWidth = fullWidth;
        FullHeight = fullHeight;
        HalfWidth = halfWidth;
        HalfHeight = halfHeight;

        halfA = Create("EID4662_ComputePass2_Work_209617", halfWidth, halfHeight, GraphicsFormat.R16G16B16A16_SFloat);
        halfB = Create("EID4662_ComputePass2_Work_210519", halfWidth, halfHeight, GraphicsFormat.R16G16B16A16_SFloat);
        halfC = Create("EID4662_ComputePass2_Work_209581", halfWidth, halfHeight, GraphicsFormat.R8_UNorm);
        pingA = Create("EID4662_ComputePass2_Work_PingA_210450", halfWidth, halfHeight, GraphicsFormat.R16G16B16A16_SFloat, true, 7);
        pingB = Create("EID4662_ComputePass2_Work_PingB_210467", halfWidth, halfHeight, GraphicsFormat.R8_UNorm, true, 7);
        fullScratch = Create("EID4662_ComputePass2_Work_Full", fullWidth, fullHeight, GraphicsFormat.R16G16B16A16_SFloat);
        halfScratch = Create("EID4662_ComputePass2_Work_Half", halfWidth, halfHeight, GraphicsFormat.R16G16B16A16_SFloat);
        packedFull = Create("EID4662_ComputePass2_Work_PackedFull", fullWidth, fullHeight, GraphicsFormat.A2B10G10R10_UNormPack32);
        packedHalf = Create("EID4662_ComputePass2_Work_PackedHalf", halfWidth, halfHeight, GraphicsFormat.A2B10G10R10_UNormPack32);
        res18 = Create("EID4662_ComputePass2_Res18_209659", halfWidth, halfHeight, GraphicsFormat.R16G16B16A16_SFloat);
        res19 = Create("EID4662_ComputePass2_Res19_209510", halfWidth, halfHeight, GraphicsFormat.R8_UNorm);
        res33 = Create("EID4662_ComputePass2_Res33", fullWidth, fullHeight, GraphicsFormat.R8G8_UNorm);
        debugPreview = Create("EID4662_ComputePass2_DebugPreview", fullWidth, fullHeight, GraphicsFormat.R16G16B16A16_SFloat);
    }

    public bool EnsureCapturedBuffers(EID4662ComputePass2CapturedResources captured)
    {
        if (captured == null) return false;
        string identity = string.Join("|", captured.dispatchArgs4542 ? captured.dispatchArgs4542.name : "",
            captured.dispatchArgs4546 ? captured.dispatchArgs4546.name : "",
            captured.dispatchArgs4550 ? captured.dispatchArgs4550.name : "",
            captured.ssbo21 ? captured.ssbo21.name : "");
        if (bufferIdentity == identity && dispatchArgs4542 != null && dispatchArgs4546 != null && dispatchArgs4550 != null && ssbo21 != null)
            return true;

        ReleaseBuffers();
        dispatchArgs4542 = CreateIndirectArgs(captured.dispatchArgs4542, "EID4662_Args_4542");
        dispatchArgs4546 = CreateIndirectArgs(captured.dispatchArgs4546, "EID4662_Args_4546");
        dispatchArgs4550 = CreateIndirectArgs(captured.dispatchArgs4550, "EID4662_Args_4550");
        ssbo21 = CreateRawBuffer(captured.ssbo21, "EID4662_SSBO21");
        bufferIdentity = identity;
        return dispatchArgs4542 != null && dispatchArgs4546 != null && dispatchArgs4550 != null && ssbo21 != null;
    }

    bool AllCreated()
    {
        return halfA != null && halfB != null && halfC != null && pingA != null && pingB != null &&
               fullScratch != null && halfScratch != null && packedFull != null && packedHalf != null &&
               res18 != null && res19 != null && res33 != null && debugPreview != null;
    }

    static RenderTexture Create(string name, int width, int height, GraphicsFormat format, bool mipMap = false, int mipCount = 1)
    {
        var desc = new RenderTextureDescriptor(width, height)
        {
            graphicsFormat = format,
            depthBufferBits = 0,
            msaaSamples = 1,
            volumeDepth = 1,
            dimension = TextureDimension.Tex2D,
            enableRandomWrite = true,
            useMipMap = mipMap,
            autoGenerateMips = false,
            mipCount = mipMap ? mipCount : 1,
            sRGB = false
        };
        var rt = new RenderTexture(desc)
        {
            name = name,
            filterMode = FilterMode.Point,
            wrapMode = TextureWrapMode.Clamp,
            hideFlags = HideFlags.HideAndDontSave
        };
        rt.Create();
        return rt;
    }

    static ComputeBuffer CreateIndirectArgs(TextAsset asset, string name)
    {
        if (asset == null || asset.bytes == null || asset.bytes.Length < 12) return null;
        byte[] bytes = asset.bytes;
        uint[] args = new uint[3];
        for (int i = 0; i < 3; ++i) args[i] = BitConverter.ToUInt32(bytes, i * 4);
        if (args[0] == 0 || args[1] == 0 || args[2] == 0) return null;
        var buffer = new ComputeBuffer(3, sizeof(uint), ComputeBufferType.IndirectArguments) { name = name };
        buffer.SetData(args);
        return buffer;
    }

    static ComputeBuffer CreateRawBuffer(TextAsset asset, string name)
    {
        if (asset == null || asset.bytes == null || asset.bytes.Length == 0 || (asset.bytes.Length & 3) != 0) return null;
        uint[] words = new uint[asset.bytes.Length / 4];
        Buffer.BlockCopy(asset.bytes, 0, words, 0, asset.bytes.Length);
        var buffer = new ComputeBuffer(words.Length, sizeof(uint), ComputeBufferType.Raw) { name = name };
        buffer.SetData(words);
        return buffer;
    }

    void ReleaseTextures()
    {
        Release(ref halfA); Release(ref halfB); Release(ref halfC);
        Release(ref pingA); Release(ref pingB);
        Release(ref fullScratch); Release(ref halfScratch);
        Release(ref packedFull); Release(ref packedHalf);
        Release(ref res18); Release(ref res19); Release(ref res33); Release(ref debugPreview);
    }

    void ReleaseBuffers()
    {
        dispatchArgs4542?.Release(); dispatchArgs4542 = null;
        dispatchArgs4546?.Release(); dispatchArgs4546 = null;
        dispatchArgs4550?.Release(); dispatchArgs4550 = null;
        ssbo21?.Release(); ssbo21 = null;
        bufferIdentity = null;
    }

    static void Release(ref RenderTexture rt)
    {
        if (rt == null) return;
        if (rt.IsCreated()) rt.Release();
        if (Application.isPlaying) UnityEngine.Object.Destroy(rt);
        else UnityEngine.Object.DestroyImmediate(rt);
        rt = null;
    }

    public void Dispose()
    {
        ReleaseTextures();
        ReleaseBuffers();
        FullWidth = FullHeight = HalfWidth = HalfHeight = 0;
    }
}




