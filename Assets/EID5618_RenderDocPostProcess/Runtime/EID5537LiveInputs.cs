using UnityEngine;
using UnityEngine.Experimental.Rendering;

/// <summary>
/// Explicit hand-off from live EID5519/EID5528/history producers to EID5537.
/// The caller owns every resource. Publish during a preceding pass Execute,
/// AFTER EID5537 AddRenderPasses has begun this camera render. No captured fallbacks.
/// </summary>
public static class EID5537LiveInputs
{
    public sealed class Dependencies
    {
        public RenderTexture packedMotion; // RID209540, EID5519 MRT1, NOT ordinary UV velocity.
        public RenderTexture rejectionMask; // RID209614, EID5528, 344x192 for this capture.
        public RenderTexture historyColor;  // RID209495, previous temporal result, not current colour.
        public ComputeBuffer uniforms12B7;  // 192 bytes, current dimensions/filter/history-reset state.
        public ComputeBuffer uniforms6B8;   // 3200 bytes, matching live camera/jitter/coordinate convention.
    }

    static Camera expectedCamera;
    static Dependencies pending;

    internal static void BeginCamera(Camera camera)
    {
        expectedCamera = camera;
        pending = null;
    }

    internal static void Reset()
    {
        expectedCamera = null;
        pending = null;
    }

    // Single target-camera contract. The caller must publish again on EACH
    // camera render, including multiple Camera.Render calls in one frame.
    public static bool Publish(Camera camera, Dependencies inputs)
    {
        if (camera == null || camera != expectedCamera || inputs == null) return false;
        pending = inputs;
        return true;
    }

    internal static bool TryConsume(Camera camera, RenderTexture color, RenderTexture depth,
        out Dependencies inputs, out string reason)
    {
        inputs = null;
        var supplied = pending;
        pending = null;
        if (camera == null || camera != expectedCamera)
        {
            reason = "camera render does not own the live input hand-off";
            return false;
        }
        // Do not infer semantic compatibility merely from a global texture name.
        if (supplied == null)
        {
            reason = "waiting for EID5519 packed motion, EID5528 mask, history and live b7/b8";
            return false;
        }
        if (!FullSize(color) || color.sRGB ||
            (color.graphicsFormat != GraphicsFormat.B10G11R11_UFloatPack32 &&
             color.graphicsFormat != GraphicsFormat.R16G16B16A16_SFloat &&
             color.graphicsFormat != GraphicsFormat.R32G32B32A32_SFloat))
        {
            reason = "current camera color must be single-sample linear HDR 1366x768; no implicit resize/flip";
            return false;
        }
        if (!FullSize(depth) || depth.depthStencilFormat != GraphicsFormat.D32_SFloat_S8_UInt)
        {
            reason = "current camera depth must be sampleable single-sample D32S8 1366x768";
            return false;
        }
        if (!FullSize(supplied.packedMotion) ||
            supplied.packedMotion.graphicsFormat != GraphicsFormat.A2B10G10R10_UNormPack32)
        {
            reason = "res15 requires EID5519 R10G10B10A2 packed motion/flags at 1366x768";
            return false;
        }
        var mask = supplied.rejectionMask;
        if (mask == null || !mask.IsCreated() || mask.width != 344 || mask.height != 192 ||
            mask.antiAliasing != 1 || mask.dimension != UnityEngine.Rendering.TextureDimension.Tex2D ||
            mask.graphicsFormat != GraphicsFormat.R8_UNorm)
        {
            reason = "res16 requires EID5528 R8 mask at 344x192";
            return false;
        }
        if (!FullSize(supplied.historyColor) ||
            supplied.historyColor.graphicsFormat != GraphicsFormat.R16G16B16A16_SFloat ||
            supplied.historyColor == color || supplied.historyColor == supplied.packedMotion)
        {
            reason = "res17 requires an independent previous-history RGBAHalf RT at 1366x768";
            return false;
        }
        if (!ValidBuffer(supplied.uniforms12B7, 192) || !ValidBuffer(supplied.uniforms6B8, 3200))
        {
            reason = "live b7/b8 must be valid 192/3200-byte constant buffers";
            return false;
        }
        inputs = supplied;
        reason = null;
        return true;
    }

    static bool FullSize(RenderTexture texture)
    {
        return texture != null && texture.IsCreated() && texture.width == 1366 && texture.height == 768 &&
            texture.antiAliasing == 1 && texture.dimension == UnityEngine.Rendering.TextureDimension.Tex2D &&
            texture.memorylessMode == RenderTextureMemoryless.None;
    }

    static bool ValidBuffer(ComputeBuffer buffer, int bytes)
    {
        return buffer != null && buffer.IsValid() && buffer.count * buffer.stride == bytes;
    }
}
