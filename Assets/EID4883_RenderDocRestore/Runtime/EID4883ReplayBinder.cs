using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using UnityEngine.Rendering;

namespace EID4730
{
    [ExecuteAlways, DisallowMultipleComponent]
    public sealed class EID4883ReplayBinder : MonoBehaviour
    {
        public Material material;
        static readonly HashSet<EID4883ReplayBinder> active = new HashSet<EID4883ReplayBinder>();
        [NonSerialized] EID4883ReplaySession session;
        [NonSerialized] Renderer targetRenderer;
        [NonSerialized] float retryAfter;

        void OnEnable()
        {
            active.Add(this);
            RenderPipelineManager.beginCameraRendering += BeginCamera;
            targetRenderer = GetComponent<Renderer>();
            Rebind();
        }

        void BeginCamera(ScriptableRenderContext context,Camera camera){
            if(!isActiveAndEnabled||!BindForDraw())return;
            PrepareCamera(material,camera);
        }
        public static void PrepareCamera(Material m,Camera c){
            var p=GL.GetGPUProjectionMatrix(c.projectionMatrix,true);
            m.SetMatrix("_EID4883LiveP",p);m.SetMatrix("_EID4883LiveView",c.worldToCameraMatrix);m.SetMatrix("_EID4883LiveVP",p*c.worldToCameraMatrix);
            int w=Mathf.Max(1,c.pixelWidth),h=Mathf.Max(1,c.pixelHeight);m.SetVector("_EID4883LiveScreen",new Vector4(w,h,1f/w,1f/h));
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
                if (current != null && current.shader != null && current.shader.name == "Hidden/EID4883/HairOutline")
                    material = current;
            }
            if (material == null) return false;
            try
            {
                if (session == null || !session.IsValid)
                {
                    session?.Dispose();
                    session = null;
                    session = new EID4883ReplaySession(Path.Combine(Application.streamingAssetsPath, "EID4883Replay/replay.json"), true, false);
                }
                session.Bind(material, false);
                return true;
            }
            catch (Exception e)
            {
                session?.Dispose();
                session = null;
                retryAfter = Time.realtimeSinceStartup + 5f;
                Debug.LogError("[EID4883] Forward resources could not be bound. The GBuffer alone does not supply the final hair color. " + e, this);
                return false;
            }
        }

        void OnDisable()
        {
            active.Remove(this);
            RenderPipelineManager.beginCameraRendering -= BeginCamera;
            session?.Dispose();
            session = null;
        }
    }
}
