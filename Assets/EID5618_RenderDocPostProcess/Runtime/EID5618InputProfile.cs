using UnityEngine;

/// <summary>
/// Exact EID5618 RenderDoc image and constant-buffer inputs.
/// Res9 can be selected between the captured EID5537 output, the generated
/// EID5537 pass, and the live Unity camera colour. The captured mode is the
/// deterministic RenderDoc comparison path; live mode is only for runtime use.
/// </summary>
[CreateAssetMenu(menuName = "EID5618/RenderDoc Input Profile", fileName = "EID5618_InputProfile")]
public sealed class EID5618InputProfile : ScriptableObject
{
    public enum Res9SourceMode
    {
        CapturedEID5537 = 0,
        GeneratedEID5537 = 1,
        LiveCameraColor = 2,
    }

    [Header("EID5618 captured inputs")]
    [Tooltip("RenderDoc EID5618 res9, normally the output of EID5537.")]
    public Texture res9Captured;
    [Tooltip("RenderDoc res10 half-resolution auxiliary image.")]
    public Texture res10;
    [Tooltip("RenderDoc res11 packed 3D LUT.")]
    public Texture res11Captured;

    [Header("EID5537 inputs for GeneratedEID5537")]
    [Tooltip("EID5537 res14 depth input.")]
    public Texture eid5537Res14;
    [Tooltip("EID5537 res13 R11G11B10 input.")]
    public Texture eid5537Res13;
    [Tooltip("EID5537 res17 RGBA16F input.")]
    public Texture eid5537Res17;
    [Tooltip("EID5537 res16 mask input.")]
    public Texture eid5537Res16;
    [Tooltip("EID5537 res15 input.")]
    public Texture eid5537Res15;

    [Header("Captured constant buffers")]
    [Tooltip("RenderDoc uniforms14 bound at b5 (416 bytes).")]
    public TextAsset uniforms14B5;
    [Tooltip("RenderDoc uniforms6 bound at b6 (3200 bytes).")]
    public TextAsset uniforms6B6;

    [Header("Runtime source selection")]
    [Tooltip("CapturedEID5537 is the deterministic RenderDoc comparison path. GeneratedEID5537 runs the migrated EID5537 FS. LiveCameraColor is the runtime diagnostic fallback.")]
    public Res9SourceMode res9Source = Res9SourceMode.CapturedEID5537;
    [Tooltip("Rewrite only captured screen-size fields in b6 for the current camera RT.")]
    public bool updateCapturedScreenSize = false;
    [Tooltip("仅在 LiveCameraColor 模式下，将 Unity 相机颜色输入垂直翻转一次；用于修正相机 RT 与 RenderDoc 屏幕纹理的 Y 原点差异。")]
    public bool flipLiveCameraY = false;
    public bool warnWhenMissing = true;
}
