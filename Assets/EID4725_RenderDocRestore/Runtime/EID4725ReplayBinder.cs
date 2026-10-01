using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using UnityEngine.Rendering;

namespace EID4730
{
    [ExecuteAlways, DisallowMultipleComponent]
    public sealed class EID4725ReplayBinder : MonoBehaviour
    {
        public Material material;
        static readonly HashSet<EID4725ReplayBinder> active = new HashSet<EID4725ReplayBinder>();
        [NonSerialized] EID4725ReplaySession session;
        [NonSerialized] Renderer targetRenderer;
        [NonSerialized] float retryAfter;

        void OnEnable()
        {
            active.Add(this);
            RenderPipelineManager.beginCameraRendering -= PrepareForCamera;
            RenderPipelineManager.beginCameraRendering += PrepareForCamera;
            targetRenderer = GetComponent<Renderer>();
            Rebind();
        }

        // GBuffer now uses the captured skin buffers too, before CharacterForward.
        void PrepareForCamera(ScriptableRenderContext context, Camera camera)
        {
            if (isActiveAndEnabled) BindForDraw();
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
                if (current != null && current.shader != null && current.shader.name == "EID/URP/EID4725_RenderDoc")
                    material = current;
            }
            if (material == null) return false;
            try
            {
                if (session == null || !session.IsValid)
                {
                    session?.Dispose();
                    session = null;
                    session = new EID4725ReplaySession(Path.Combine(Application.streamingAssetsPath, "EID4725Replay/replay.json"), true, false);
                }
                session.Bind(material, false);
                return true;
            }
            catch (Exception e)
            {
                session?.Dispose();
                session = null;
                retryAfter = Time.realtimeSinceStartup + 5f;
                Debug.LogError("[EID4725] Forward resources could not be bound. The GBuffer alone does not supply the final face color. " + e, this);
                return false;
            }
        }

        void OnDisable()
        {
            RenderPipelineManager.beginCameraRendering -= PrepareForCamera;
            active.Remove(this);
            session?.Dispose();
            session = null;
        }
    }
}
