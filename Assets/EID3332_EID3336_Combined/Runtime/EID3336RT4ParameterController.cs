using System;
using UnityEngine;
using UnityEngine.Rendering;

/// <summary>
/// Profile fallback table for the recovered EID GBuffer path. Per-object
/// EID3336GBufferObjectParameters components are preferred; this table is only
/// used when a model has not yet received its own component.
///
/// The RenderDoc-accurate RT4 algorithm is not tuned here. RT4 is always the
/// value produced by the recovered PS and packed from PS209987._16.
/// </summary>
[ExecuteAlways]
public sealed class EID3336RT4ParameterController : MonoBehaviour
{
    [Serializable]
    public sealed class ProfileParameters
    {
        public int eventId;
        public bool flipMaterialUvY;
    }

    static readonly int FlipUvYId = Shader.PropertyToID("_EID3332CombinedFlipMaterialUVY");

    [Header("Fallback profile parameters")]
    public ProfileParameters eid3332 = Create(3332, true, false);
    public ProfileParameters eid3336 = Create(3336, true, false);
    public ProfileParameters eid3315 = Create(3315, false, false);
    public ProfileParameters eid3490 = Create(3490, false, true);

    [Header("Diagnostics")]
    public bool logBindingsOnEnable = true;
    public bool logEveryDraw;
    [NonSerialized] public int lastAppliedEventId = -1;

    static ProfileParameters Create(int eventId, bool unused, bool flip)
    {
        return new ProfileParameters
        {
            eventId = eventId,
            flipMaterialUvY = flip
        };
    }

    void OnEnable()
    {
        EnsureDefaults();
        if (logBindingsOnEnable) LogConfiguration();
    }

    void OnValidate() => EnsureDefaults();

    void EnsureDefaults()
    {
        if (eid3332 == null) eid3332 = Create(3332, true, false);
        if (eid3336 == null) eid3336 = Create(3336, true, false);
        if (eid3315 == null) eid3315 = Create(3315, false, false);
        if (eid3490 == null) eid3490 = Create(3490, false, true);
        eid3332.eventId = 3332;
        eid3336.eventId = 3336;
        eid3315.eventId = 3315;
        eid3490.eventId = 3490;
    }

    ProfileParameters ForEvent(int eventId)
    {
        if (eventId == 3332) return eid3332;
        if (eventId == 3336) return eid3336;
        if (eventId == 3315) return eid3315;
        if (eventId == 3490) return eid3490;
        return null;
    }

    /// <summary>
    /// Records the per-object profile switches immediately before that
    /// object's draw. No RT4 post-process values are sent to the shader.
    /// </summary>
    public void ApplyForDraw(CommandBuffer cmd, EID3332CombinedDrawProfile profile,
        EID3336GBufferObjectParameters objectParameters = null, Material targetMaterial = null)
    {
        if (cmd == null) return;
        EnsureDefaults();

        int profileEvent = profile != null ? profile.eventId : -1;
        ProfileParameters fallback = ForEvent(profileEvent);
        if (fallback == null)
        {
            Debug.LogError($"[EID3336 GBuffer Params] no fallback table for event {profileEvent}; refusing to use another EID profile.");
            fallback = Create(profileEvent, false, false);
        }

        int eventId = objectParameters != null ? objectParameters.eventId : fallback.eventId;
        if (objectParameters != null && eventId != profileEvent)
        {
            Debug.LogError($"[EID3336 GBuffer Params] object '{objectParameters.name}' event {eventId} does not match profile event {profileEvent}; profile defaults used.", objectParameters);
            objectParameters = null;
        }

        bool flipUv = objectParameters != null ? objectParameters.flipMaterialUvY : fallback.flipMaterialUvY;
        lastAppliedEventId = profileEvent;
        // Set the value on the exact private material used by this draw.
        // CommandBuffer global state is not a reliable per-draw material
        // contract when URP records several profiles into one pass.
        if (targetMaterial != null) targetMaterial.SetFloat(FlipUvYId, flipUv ? 1f : 0f);
        cmd.SetGlobalFloat(FlipUvYId, flipUv ? 1f : 0f);

        if (logEveryDraw)
            Debug.Log($"[EID3336 GBuffer Params] apply object={(objectParameters != null ? objectParameters.name : "<fallback>")} profile={profileEvent} flipUVY={flipUv}");
    }

    [ContextMenu("Reset fallback profiles to RenderDoc defaults")]
    public void ResetToRenderDocDefaults()
    {
        eid3332 = Create(3332, true, false);
        eid3336 = Create(3336, true, false);
        eid3315 = Create(3315, false, false);
        eid3490 = Create(3490, false, true);
    }

    [ContextMenu("Log fallback profile configuration")]
    public void LogConfiguration()
    {
        EnsureDefaults();
        Log(eid3332); Log(eid3336); Log(eid3315); Log(eid3490);
    }

    static void Log(ProfileParameters p)
    {
        Debug.Log($"[EID3336 GBuffer Params] event={p.eventId} source=RenderDoc profile flipUVY={p.flipMaterialUvY}");
    }
}
