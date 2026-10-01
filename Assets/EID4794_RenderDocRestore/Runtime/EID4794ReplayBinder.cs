using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

namespace EID4730
{
    [ExecuteAlways, DisallowMultipleComponent]
    public sealed class EID4794ReplayBinder : MonoBehaviour
    {
        public Material material;
        static readonly HashSet<EID4794ReplayBinder> active = new HashSet<EID4794ReplayBinder>();
        [NonSerialized] EID4794ReplaySession session;
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
        public static int PrepareActiveForDraw()
        {
            int count = 0;
            foreach (var binder in active)
                if (binder != null && binder.isActiveAndEnabled && binder.BindForDraw()) ++count;
            return count;
        }

        bool BindForDraw()
        {
            if (Time.realtimeSinceStartup < retryAfter) return false;
            if (targetRenderer == null) targetRenderer = GetComponent<Renderer>();
            if (targetRenderer != null)
            {
                var current = targetRenderer.sharedMaterial;
                if (current != null && current.shader != null && current.shader.name == "Hidden/EID4794/CharacterForward")
                    material = current;
            }
            if (material == null) return false;
            try
            {
                if (session == null || !session.IsValid)
                {
                    session?.Dispose();
                    session = null;
                    session = new EID4794ReplaySession(Path.Combine(Application.streamingAssetsPath, "EID4794Replay/replay.json"), true, false);
                }
                session.Bind(material, false);
                return true;
            }
            catch (Exception e)
            {
                session?.Dispose();
                session = null;
                retryAfter = Time.realtimeSinceStartup + 5f;
                Debug.LogError("[EID4794] Forward resources could not be bound. The GBuffer alone does not supply the final hair color. " + e, this);
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
