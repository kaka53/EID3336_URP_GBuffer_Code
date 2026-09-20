using UnityEngine;

[CreateAssetMenu(menuName = "Endfield CP2/Exact Replay Inputs", fileName = "EndfieldCP2_ExactReplayInputs")]
public sealed class EndfieldCP2ExactReplayInputs : ScriptableObject
{
    [Header("第0步 Baseline blit（不是 EID4518 的 4 张图）")]
    [Tooltip("209526 R8 1366x768 after EID4534 upsample. 对照用捕获图，EID4518 不读。")]
    public Texture aoFull;

    [Tooltip("209659 R11G11B10 683x384 after EID4586. EID4518 不读。")]
    public Texture ssrColor;

    [Tooltip("209510 R8 683x384 after EID4590 SSR mask. EID4518 写的是当时的 edge，不是这张最终 mask。")]
    public Texture ssrMask;

    [Tooltip("209587 R8G8 1366x768 after EID4594. Baseline blit 对照图；EID4594 CS 成功后 _EndfieldContact 改绑 UAV。4662 _33 由 Feature bindDeferredLightPass 总开关决定。")]
    public Texture contact;

    [Header("第1-3步 HiZ / LinDepth")]
    [Tooltip("209535 D32 plane as UnityNative R32F 1366x768. EID4486 HiZ 捕获源（Feature hizDepthSource=Captured209535）。EID4518 不绑。")]
    public Texture depthFull209535;

    [Tooltip("EID4486 uniforms14, 48 captured bytes.")]
    public TextAsset uniforms14;

    [Tooltip("EID4490-4510 uniforms14, 6 x 256-byte slots (48B used each).")]
    public TextAsset uniforms14Down;

    [Tooltip("209118 after EID4486, mip0 reference. Not written.")]
    public Texture hizRef209118;

    [Tooltip("209543 D32 plane as UnityNative R32F 1366x768. EID4514 LinDepth 捕获源（Feature hizDepthSource=Captured209535）。")]
    public Texture depthFull209543;

    [Tooltip("EID4514 uniforms6, 3200 captured bytes.")]
    public TextAsset uniforms6;

    [Tooltip("EID4514 uniforms11, 80 captured bytes.")]
    public TextAsset uniforms11;

    [Header("EID4518 GTAO：RenderDoc 只有 2 RO + 2 RW；深度用运行时 LinDepth mip")]
    [Tooltip("209566 oct-normal。CS 只 Load .xy。Feature hizDepthSource=Captured209535 时绑这张；LiveGBuffer 时用 Combined/FiveMRT RT3（octa .xy），不要绑 GBuffer2 / _CameraNormalsTexture。")]
    public Texture octNormal209566;

    [Tooltip("EID4518 uniforms5, 1312 captured bytes.")]
    public TextAsset uniforms5;

    [Tooltip("EID4518 uniforms10, 80 captured bytes (same payload as uniforms11).")]
    public TextAsset uniforms10;

    [Header("EID4522 Temporal：RenderDoc 4 RO + 1 RW；写 RGBA = AO, min(z*0.01,1), blendW, 0")]
    [Tooltip("210525 R10G10B10A2 1366x768。CS 只 Load .xy 做 motion-like offset。不要绑 IHV DDS。")]
    public Texture motion210525;

    [Tooltip("209486 RGBA16F 683x384。EID4522 ping-pong 第一帧 seed，不是每帧绑定。Game 相机后续帧 _History 用上一帧 UAV。不要清 0。")]
    public Texture history209486;

    [Tooltip("EID4522 / EID4526 / EID4530 uniforms8, 80 captured bytes (same payload as uniforms10). EID4526 读 210487.R + 4518 edge，写 209581 R8。EID4530 读 209581 + 4518 edge，写回 209584（盖 4518 生 AO）。")]
    public TextAsset uniforms8;

    [Header("EID4594 ContactShadow：读 209543 depth，写 R8G8；与 SSR 无关；4662 _33 由 Feature bindDeferredLightPass 控制")]
    [Tooltip("EID4594 uniforms6, 1312 captured bytes。不是 EID4514 的 3200B uniforms6。")]
    public TextAsset uniforms6Contact;

    [Tooltip("EID4594 uniforms11, 80 captured bytes。不是 EID4514 的 uniforms11。")]
    public TextAsset uniforms11Contact;
}
