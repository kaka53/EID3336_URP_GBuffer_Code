using System.Collections.Generic;
using UnityEngine;

/// <summary>
/// Explicit RenderDoc resource manifest for EID4662 Compute Pass #2.
/// Every field is an exported resource from the same capture/frame. The replay
/// feature refuses to execute when a required field is missing; there are no
/// camera-color, global-texture, white-texture, or black-texture fallbacks.
/// </summary>
[CreateAssetMenu(fileName = "EID4662ComputePass2CapturedResources", menuName = "EID4662/Compute Pass 2 Captured Resources")]
public sealed class EID4662ComputePass2CapturedResources : ScriptableObject
{
    [Header("RenderDoc compute inputs")]
    [Tooltip("ResourceId 209495: full-resolution HDR input used by the first dispatch.")]
    public Texture resource209495;
    [Tooltip("ResourceId 210490: half-resolution R32 mip texture.")]
    public Texture resource210490;
    [Tooltip("ResourceId 209118: half-resolution R32 mip texture.")]
    public Texture resource209118;
    [Tooltip("ResourceId 210525: full-resolution packed auxiliary texture.")]
    public Texture resource210525;
    [Tooltip("ResourceId 209510: half-resolution R8 texture; also the EID4590 output reference.")]
    public Texture resource209510;
    [Tooltip("ResourceId 210516: half-resolution packed auxiliary texture.")]
    public Texture resource210516;
    [Tooltip("ResourceId 209543 view 0: captured D32S8 depth plane.")]
    public Texture resource209543Depth;
    [Tooltip("ResourceId 209543 view 1 / 209547: captured stencil view. This must be a separately exported stencil-compatible texture; it is not replaced by white/black.")]
    public Texture resource209547Stencil;
    [Tooltip("ResourceId 210942: mip texture read by EID4554.")]
    public Texture resource210942;
    [Tooltip("ResourceId 210925: mip texture read by EID4558.")]
    public Texture resource210925;
    [Tooltip("ResourceId 209617: EID4542..4550 intermediate reference.")]
    public Texture resource209617;
    [Tooltip("ResourceId 209581: EID4542..4550 intermediate reference.")]
    public Texture resource209581;
    [Tooltip("ResourceId 210519: half-resolution R16G16 input/reference.")]
    public Texture resource210519;
    [Tooltip("ResourceId 210450: R11G11B10 mip ping-pong resource.")]
    public Texture resource210450;
    [Tooltip("ResourceId 210467: R8 mip ping-pong resource.")]
    public Texture resource210467;

    [Header("RenderDoc reference outputs")]
    [Tooltip("ResourceId 209659 / Res18.")]
    public Texture resource209659Res18;
    [Tooltip("ResourceId 209587 / Res33.")]
    public Texture resource209587Res33;

    [Header("Captured dispatch arguments and SSBO")]
    [Tooltip("ResourceId 210484 offset 0: three uint indirect arguments for EID4542.")]
    public TextAsset dispatchArgs4542;
    [Tooltip("ResourceId 210484 offset 12: three uint indirect arguments for EID4546.")]
    public TextAsset dispatchArgs4546;
    [Tooltip("ResourceId 210484 offset 24: three uint indirect arguments for EID4550.")]
    public TextAsset dispatchArgs4550;
    [Tooltip("ResourceId 210522: ssbo21 bytes bound by the compute shaders.")]
    public TextAsset ssbo21;

    [Header("Capture identity")]
    public string sourceCapture = "F:/endfield06.rdc";
    public int sourceFrameEvent = 4542;
    public string resourceSetNote = "All resources must come from one RenderDoc capture and matching frame state.";

    public bool IsCompleteForDispatchChain(out string missing)
    {
        var list = new List<string>();
        Require(resource209495, "ResourceId 209495", list);
        Require(resource210490, "ResourceId 210490", list);
        Require(resource209118, "ResourceId 209118", list);
        Require(resource210525, "ResourceId 210525", list);
        Require(resource209510, "ResourceId 209510", list);
        Require(resource210516, "ResourceId 210516", list);
        Require(resource209543Depth, "ResourceId 209543 depth view", list);
        Require(resource209547Stencil, "ResourceId 209543/209547 stencil view", list);
        Require(resource210942, "ResourceId 210942", list);
        Require(resource210925, "ResourceId 210925", list);
        Require(resource209617, "ResourceId 209617", list);
        Require(resource209581, "ResourceId 209581", list);
        Require(resource210519, "ResourceId 210519", list);
        Require(resource210450, "ResourceId 210450", list);
        Require(resource210467, "ResourceId 210467", list);
        Require(dispatchArgs4542, "ResourceId 210484 args[0]", list);
        Require(dispatchArgs4546, "ResourceId 210484 args[1]", list);
        Require(dispatchArgs4550, "ResourceId 210484 args[2]", list);
        Require(ssbo21, "ResourceId 210522 / ssbo21", list);
        missing = string.Join(", ", list);
        return list.Count == 0;
    }

    public bool IsCompleteForDispatchChain() => IsCompleteForDispatchChain(out _);

    static void Require(Object value, string name, List<string> missing)
    {
        if (value == null) missing.Add(name);
    }
}
