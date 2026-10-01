using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using UnityEngine.Rendering;

namespace EID4730
{
    [ExecuteAlways, DisallowMultipleComponent]
    public sealed class EID4785ReplayBinder : MonoBehaviour
    {
        public Material material;
        static readonly HashSet<EID4785ReplayBinder> active = new HashSet<EID4785ReplayBinder>();
        [NonSerialized] EID4785ReplaySession session;
        [NonSerialized] Renderer targetRenderer;
        [NonSerialized] float retryAfter;
#if UNITY_EDITOR
        public int SuccessfulDrawBindings { get; private set; }
#endif

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

        // Material assets retain textures/properties, not runtime CB/SSBO bindings.
        // Called by EID4730 immediately before this draw for Game and SceneView cameras.
        public static int PrepareActiveForDraw(CommandBuffer cmd = null)
        {
            int count = 0;
            foreach (var binder in active)
                if (binder != null && binder.isActiveAndEnabled && binder.BindForDraw(cmd))
                {
                    ++count;
#if UNITY_EDITOR
                    ++binder.SuccessfulDrawBindings;
#endif
                }
            return count;
        }

        bool BindForDraw(CommandBuffer cmd = null)
        {
            if (Time.realtimeSinceStartup < retryAfter) return false;
            if (targetRenderer == null) targetRenderer = GetComponent<Renderer>();
            if (targetRenderer == null || !targetRenderer.enabled) return false;
            // The renderer's current material is authoritative after material replacement/import.
            var current = targetRenderer.sharedMaterial;
            if (current == null || current.shader == null || current.shader.name != "Hidden/EID4785/CharacterForward")
                return false;
            material = current;
            try
            {
                if (session == null || !session.IsValid)
                {
                    session?.Dispose();
                    session = null;
                    session = new EID4785ReplaySession(Path.Combine(Application.streamingAssetsPath, "EID4785Replay/replay.json"), true, false);
                }
                // Do not replace repaired persistent textures or independent GBuffer parameters.
                // Existing healthy buffers are reused; no file IO/allocation on the normal path.
                session.Bind(material, false);
                // Submit captured CB/SSBO bindings in the same command stream as this camera's draw.
                // Material-side setters alone are not the command-scoped binding contract.
                // The session intentionally has no textures: preserve the repaired volumes and live CP20 input.
                if (cmd != null) session.Bind(cmd);
                return true;
            }
            catch (Exception e)
            {
                session?.Dispose();
                session = null;
                retryAfter = Time.realtimeSinceStartup + 5f;
                Debug.LogError("[EID4785] Runtime CB/SSBO binding failed; automatic retry in 5 seconds. " + e, this);
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
