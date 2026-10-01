using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using UnityEngine.Rendering;

namespace EID4730
{
    public static class EID4720ReplayPaths
    {
        public static string ManifestPath()
        {
            var projectRoot = Directory.GetParent(Application.dataPath).FullName;
            return Path.Combine(Application.streamingAssetsPath, "EID4720Replay", "replay.json");
        }
    }

    [ExecuteAlways, DisallowMultipleComponent]
    public sealed class EID4720ReplayBinder : MonoBehaviour
    {
        public Material material;
        static readonly HashSet<EID4720ReplayBinder> active = new HashSet<EID4720ReplayBinder>();
        [NonSerialized] EID4720ReplaySession session;
        [NonSerialized] Renderer targetRenderer;
        [NonSerialized] float retryAfter;

        void OnEnable()
        {
            active.Add(this);
            targetRenderer = GetComponent<Renderer>();
            Rebind();
        }

        public void Rebind()
        {
            retryAfter = 0;
            BindForDraw();
        }

        // Shader reimport clears non-serialized buffer bindings without calling OnEnable.
        // Reassert these on the actual renderer material immediately before DrawRenderers.
        // Textures and independent GBuffer properties remain owned by the material asset.
        public static int PrepareActiveForDraw(CommandBuffer cmd = null)
        {
            int count = 0;
            foreach (var binder in active)
                if (binder != null && binder.isActiveAndEnabled && binder.BindForDraw(cmd)) ++count;
            return count;
        }

        bool BindForDraw(CommandBuffer cmd = null)
        {
            if (Time.realtimeSinceStartup < retryAfter) return false;
            if (targetRenderer == null) targetRenderer = GetComponent<Renderer>();
            if (targetRenderer != null)
            {
                var current = targetRenderer.sharedMaterial;
                if (current != null && current.shader != null && current.shader.name == "Hidden/EID4720/CharacterForward")
                    material = current;
            }
            if (material == null) return false;
            try
            {
                if (session == null || !session.IsValid)
                {
                    session?.Dispose();
                    session = null;
                    session = new EID4720ReplaySession(EID4720ReplayPaths.ManifestPath(), true, false);
                }
                session.Bind(material, false);
                if (cmd != null) session.Bind(cmd);
                return true;
            }
            catch (Exception e)
            {
                session?.Dispose();
                session = null;
                retryAfter = Time.realtimeSinceStartup + 5f;
                Debug.LogError("[EID4720] Forward resources could not be bound. The GBuffer alone does not supply the final EID1696 color. " + e, this);
                return false;
            }
        }

        void OnDisable()
        {
            active.Remove(this);
            session?.Dispose();
            session = null;
        }
    }
}
