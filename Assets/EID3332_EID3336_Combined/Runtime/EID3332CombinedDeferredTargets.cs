using UnityEngine;
using UnityEngine.Experimental.Rendering;

[ExecuteAlways]
public sealed class EID3332CombinedDeferredTargets : MonoBehaviour
{
    public int width = 1366;
    public int height = 768;
    public bool debugFloatFormats;

    [System.NonSerialized] RenderTexture[] colors;
    [System.NonSerialized] RenderTexture depth;
    [System.NonSerialized] RenderTexture coverage;
    [System.NonSerialized] RenderTexture depthDebug;
    [System.NonSerialized] RenderTexture actualWorldPosition;
    [System.NonSerialized] RenderTexture actualNormal;

    static readonly GraphicsFormat[] ExactFormats =
    {
        GraphicsFormat.B10G11R11_UFloatPack32,
        GraphicsFormat.A2B10G10R10_UNormPack32,
        GraphicsFormat.A2B10G10R10_UNormPack32,
        GraphicsFormat.A2B10G10R10_UNormPack32,
        GraphicsFormat.R8G8B8A8_SRGB
    };

    void OnEnable() => Ensure();
    void OnValidate() { if (isActiveAndEnabled) Recreate(); }
    void OnDisable() => Release();
    void OnDestroy() => Release();

    public RenderTexture GetColor(int index)
    {
        Ensure();
        return colors != null && index >= 0 && index < colors.Length ? colors[index] : null;
    }

    public RenderTexture Depth { get { Ensure(); return depth; } }
    public RenderTexture Coverage { get { Ensure(); return coverage; } }
    public RenderTexture DepthDebug { get { Ensure(); return depthDebug; } }
    public RenderTexture ActualWorldPosition { get { Ensure(); return actualWorldPosition; } }
    public RenderTexture ActualNormal { get { Ensure(); return actualNormal; } }

    public void Ensure(int requestedWidth, int requestedHeight)
    {
        requestedWidth = Mathf.Max(1, requestedWidth);
        requestedHeight = Mathf.Max(1, requestedHeight);
        if (width != requestedWidth || height != requestedHeight)
        {
            width = requestedWidth;
            height = requestedHeight;
        }
        Ensure();
    }

    public void Ensure()
    {
        width = Mathf.Max(1, width);
        height = Mathf.Max(1, height);
        GraphicsFormat expected = debugFloatFormats ? GraphicsFormat.R16G16B16A16_SFloat : ExactFormats[0];
        if (colors != null && colors.Length == 5 && colors[0] != null &&
            colors[0].width == width && colors[0].height == height && colors[0].graphicsFormat == expected &&
            actualWorldPosition != null && actualNormal != null)
            return;
        Recreate();
    }

    public void Recreate()
    {
        Release();
        if (SystemInfo.supportedRenderTargetCount < 5)
        {
            Debug.LogError("[EID3332Combined] Five simultaneous render targets are required.", this);
            return;
        }
        colors = new RenderTexture[5];
        for (int i = 0; i < colors.Length; ++i)
        {
            GraphicsFormat format = debugFloatFormats ? GraphicsFormat.R16G16B16A16_SFloat : ExactFormats[i];
            var desc = new RenderTextureDescriptor(width, height, format, 0)
            {
                msaaSamples = 1,
                useMipMap = false,
                autoGenerateMips = false,
                sRGB = !debugFloatFormats && format == GraphicsFormat.R8G8B8A8_SRGB
            };
            colors[i] = new RenderTexture(desc)
            {
                name = "EID3332Combined_SceneMRT" + i,
                filterMode = FilterMode.Point,
                wrapMode = TextureWrapMode.Clamp
            };
            colors[i].Create();
        }

        var depthDesc = new RenderTextureDescriptor(width, height, GraphicsFormat.None, 0)
        {
            depthStencilFormat = GraphicsFormat.D32_SFloat_S8_UInt,
            msaaSamples = 1,
            useMipMap = false,
            autoGenerateMips = false
        };
        depth = new RenderTexture(depthDesc) { name = "EID3332Combined_SceneDepth", filterMode = FilterMode.Point };
        depth.Create();

        coverage = CreateAux("EID3332Combined_SceneCoverage", GraphicsFormat.R8_UNorm);
        depthDebug = CreateAux("EID3332Combined_SceneDepthDebug", GraphicsFormat.R32_SFloat);
        actualWorldPosition = CreateAux("EID3332Combined_ActualWorldPosition", GraphicsFormat.R32G32B32A32_SFloat);
        actualNormal = CreateAux("EID3332Combined_ActualNormalWS", GraphicsFormat.R16G16B16A16_SFloat);
    }

    RenderTexture CreateAux(string targetName, GraphicsFormat format)
    {
        var desc = new RenderTextureDescriptor(width, height, format, 0)
        {
            msaaSamples = 1,
            useMipMap = false,
            autoGenerateMips = false,
            sRGB = false
        };
        var rt = new RenderTexture(desc)
        {
            name = targetName,
            filterMode = FilterMode.Point,
            wrapMode = TextureWrapMode.Clamp
        };
        rt.Create();
        return rt;
    }

    public void Release()
    {
        if (colors != null)
            foreach (RenderTexture rt in colors) DestroyRT(rt);
        DestroyRT(depth);
        DestroyRT(coverage);
        DestroyRT(depthDebug);
        DestroyRT(actualWorldPosition);
        DestroyRT(actualNormal);
        colors = null;
        depth = null;
        coverage = null;
        depthDebug = null;
        actualWorldPosition = null;
        actualNormal = null;
    }

    static void DestroyRT(RenderTexture rt)
    {
        if (rt == null) return;
        rt.Release();
        if (Application.isPlaying) Destroy(rt); else DestroyImmediate(rt);
    }
}
