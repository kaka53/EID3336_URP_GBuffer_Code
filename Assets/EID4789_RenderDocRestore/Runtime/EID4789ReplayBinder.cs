using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using UnityEngine.Rendering;

namespace EID4730
{
    public static class EID4789ReplayPaths
    {
        public static string ManifestPath()
        {
            var projectRoot = Directory.GetParent(Application.dataPath).FullName;
            return Path.Combine(projectRoot, ".rdctools", "eid4789_verified", "replay", "replay.json");
        }
    }

    [ExecuteAlways, DisallowMultipleComponent]
    public sealed class EID4789ReplayBinder : MonoBehaviour
    {
        public Material material;
        static readonly HashSet<EID4789ReplayBinder> active = new HashSet<EID4789ReplayBinder>();
        [NonSerialized] EID4789ReplaySession session;
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
                if (current != null && current.shader != null && current.shader.name == "Hidden/EID4789/CharacterForward")
                    material = current;
            }
            if (material == null) return false;
            try
            {
                if (session == null || !session.IsValid)
                {
                    session?.Dispose();
                    session = null;
                    session = new EID4789ReplaySession(EID4789ReplayPaths.ManifestPath(), true, false);
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
                Debug.LogError("[EID4789] Forward resources could not be bound. The GBuffer alone does not supply the final EID1696 color. " + e, this);
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
