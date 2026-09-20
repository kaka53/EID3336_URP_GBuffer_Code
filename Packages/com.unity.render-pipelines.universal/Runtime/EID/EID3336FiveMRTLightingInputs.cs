using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

namespace UnityEngine.Rendering.Universal
{
    /// <summary>
    /// FiveMRT GBuffer handles published per camera for independent LightPasses.
    /// Shader.GetGlobalTexture("_GBuffer2") is empty on this path because GBufferPass
    /// only SetGlobalTexture's the RTHandle nameID; 4662 already consumes these handles.
    /// Static last-writer storage is not used: SceneView and Game would overwrite each other.
    /// </summary>
    public static class EID3336FiveMRTLightingInputs
    {
        struct Slot
        {
            public Texture depthCopy;
            public Texture gbuffer2;
            public Texture gbuffer3;
            public Texture gbuffer4;
        }

        static readonly Dictionary<int, Slot> s_ByCamera = new Dictionary<int, Slot>();

        internal static void Publish(Camera camera, RTHandle[] inputs, RTHandle sampledDepth)
        {
            if (camera == null)
                return;

            int id = camera.GetInstanceID();
            s_ByCamera.TryGetValue(id, out Slot slot);
            Texture depth = SlotTex(sampledDepth);
            Texture materialPacked = SlotTex(inputs, 2);
            Texture normal = SlotTex(inputs, 3);
            Texture baseColor = SlotTex(inputs, 4);
            if (depth != null)
                slot.depthCopy = depth;
            if (materialPacked != null)
                slot.gbuffer2 = materialPacked;
            if (normal != null)
                slot.gbuffer3 = normal;
            if (baseColor != null)
                slot.gbuffer4 = baseColor;
            s_ByCamera[id] = slot;
        }

        internal static void PublishGBufferColor(Camera camera, RTHandle[] inputs)
        {
            Publish(camera, inputs, null);
        }

        internal static void PublishTextures(Camera camera, Texture depth, Texture materialPacked, Texture normal, Texture baseColor)
        {
            if (camera == null)
                return;
            int id = camera.GetInstanceID();
            s_ByCamera.TryGetValue(id, out Slot slot);
            if (IsUsable(depth))
                slot.depthCopy = depth;
            if (IsUsable(materialPacked))
                slot.gbuffer2 = materialPacked;
            if (IsUsable(normal))
                slot.gbuffer3 = normal;
            if (IsUsable(baseColor))
                slot.gbuffer4 = baseColor;
            s_ByCamera[id] = slot;
        }

        static Texture SlotTex(RTHandle[] inputs, int index)
        {
            if (inputs == null || index >= inputs.Length)
                return null;
            return SlotTex(inputs[index]);
        }

        static Texture SlotTex(RTHandle handle)
        {
            if (handle == null)
                return null;
            if (handle.rt != null)
                return handle.rt;
            return handle;
        }

        public static bool TryGetVegetationLightPassInputs(Camera camera,
            out Texture depth, out Texture materialPacked, out Texture normal, out Texture baseColor)
        {
            depth = null;
            materialPacked = null;
            normal = null;
            baseColor = null;
            if (camera == null)
                return false;
            if (!s_ByCamera.TryGetValue(camera.GetInstanceID(), out Slot slot))
                return false;
            depth = slot.depthCopy;
            materialPacked = slot.gbuffer2;
            normal = slot.gbuffer3;
            baseColor = slot.gbuffer4;
            return IsUsable(depth) && IsUsable(materialPacked) && IsUsable(normal) && IsUsable(baseColor);
        }

        static bool IsUsable(Texture texture)
        {
            return texture != null && texture.width >= 8 && texture.height >= 8;
        }
    }
}
