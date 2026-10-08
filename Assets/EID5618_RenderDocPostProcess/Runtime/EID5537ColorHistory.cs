using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

// One bounded history slot for the feature's selected game camera. Changing
// cameras invalidates it; it never reuses another camera's temporal samples.
// History plus the pass output; normalized current color is allocated on demand.
// Optional normalized raw depth: 1366x768 R32F (no linearization).
internal sealed class EID5537ColorHistory
{
    public RTHandle CurrentColor { get; private set; }
    public RTHandle Read { get; private set; }
    public RTHandle CurrentDepth { get; private set; }
    public bool Valid { get; private set; }
    public int AllocationCount { get; private set; }
    Camera owner;
    Vector2Int sourceSize;
    GraphicsFormat sourceFormat;
    Matrix4x4 previousView;
    Matrix4x4 previousProjection;
    double lastTime;
    bool previousPlaying;
    bool previousFlip;

    public void Ensure(RenderTextureDescriptor descriptor, bool liveDepth, bool copyColor)
    {
        RTHandle current = CurrentColor;
        RTHandle history = Read;
        bool allocatedCurrent = copyColor && EnsureTexture(ref current, descriptor, "EID5537_Live13_RGBA16F");
        bool allocatedHistory = EnsureTexture(ref history, descriptor, "EID5537_History800_RGBA16F");
        CurrentColor = current;
        Read = history;
        AllocationCount += (allocatedCurrent ? 1 : 0) + (allocatedHistory ? 1 : 0);
        if (allocatedCurrent || allocatedHistory) Invalidate();
        if (liveDepth)
        {
            var depthDescriptor = descriptor;
            depthDescriptor.graphicsFormat = GraphicsFormat.R32_SFloat;
            RTHandle depth = CurrentDepth;
            bool allocatedDepth = EnsureTexture(ref depth, depthDescriptor, "EID5537_Live790_RawDepth_R32F");
            CurrentDepth = depth;
            if (allocatedDepth) AllocationCount++;
            if (allocatedDepth) Invalidate();
        }
        // Keep optional auxiliaries until Dispose; view/mode switches must not
        // repeatedly destroy and allocate the same bounded set of textures.
    }

    static bool EnsureTexture(ref RTHandle handle, RenderTextureDescriptor descriptor, string initialName)
    {
        // Do NOT compare names or filter modes here. Read and the pass output
        // exchange roles, so ReAllocateIfNeeded(name: fixedName) would erase
        // valid history every frame and fill URP's stale-resource pool.
        if (handle != null && handle.rt != null && handle.rt.IsCreated() &&
            handle.rt.width == descriptor.width && handle.rt.height == descriptor.height &&
            handle.rt.graphicsFormat == descriptor.graphicsFormat) return false;
        handle?.Release();
        handle = RTHandles.Alloc(descriptor, FilterMode.Point, TextureWrapMode.Clamp, name: initialName);
        return true;
    }

    public bool NeedsReset(Camera camera, Vector2Int size, GraphicsFormat format, bool flipY)
    {
        return !Valid || camera == null || camera != owner || sourceSize != size || sourceFormat != format ||
            previousPlaying != Application.isPlaying || previousFlip != flipY ||
            Time.realtimeSinceStartupAsDouble - lastTime > 1.0 ||
            MatrixChanged(previousView, camera.worldToCameraMatrix) ||
            MatrixChanged(previousProjection, camera.nonJitteredProjectionMatrix);
    }

    // Call only AFTER successful GPU command submission. The previous Read
    // becomes the next output, while this completed output becomes Read.
    public void Commit(ref RTHandle output, Camera camera, Vector2Int size, GraphicsFormat format, bool flipY)
    {
        RTHandle oldRead = Read;
        Read = output;
        output = oldRead;
        owner = camera;
        sourceSize = size;
        sourceFormat = format;
        previousView = camera.worldToCameraMatrix;
        previousProjection = camera.nonJitteredProjectionMatrix;
        previousPlaying = Application.isPlaying;
        previousFlip = flipY;
        lastTime = Time.realtimeSinceStartupAsDouble;
        Valid = true;
    }

    public void Invalidate() { Valid = false; }

    static bool MatrixChanged(Matrix4x4 a, Matrix4x4 b)
    {
        for (int i = 0; i < 16; ++i)
            if (Mathf.Abs(a[i] - b[i]) > 0.00001f) return true;
        return false;
    }

    public void Dispose()
    {
        CurrentDepth?.Release();
        CurrentDepth = null;
        CurrentColor?.Release();
        Read?.Release();
        CurrentColor = null;
        Read = null;
        owner = null;
        Valid = false;
    }
}
