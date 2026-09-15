from pathlib import Path
p=Path('Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/Shaders/EID4922Sky.hlsl')
s=p.read_text()
old='''struct EID4922FragOutput { float4 rt0 : SV_Target0; float4 rt1 : SV_Target1; };
EID4922FragOutput EID4922PixelMain(EID4922FragInput input)
{
    gl_FragCoord=input.positionCS; gl_FragCoord.w=1.0/max(input.positionCS.w,1e-6); _4=input.worldPos; _5=input.screenPos; _6=input.prevPos; frag_main();
    EID4922FragOutput o; o.rt0=_7; o.rt1=_8; return o;
}'''
new='''float4 EID4922PixelMain(EID4922FragInput input) : SV_Target0
{
    gl_FragCoord=input.positionCS; gl_FragCoord.w=1.0/max(input.positionCS.w,1e-6); _4=input.worldPos; _5=input.screenPos; _6=input.prevPos; frag_main();
    return _7;
}'''
assert old in s
p.write_text(s.replace(old,new))
p=Path('Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/Shaders/EID4922Sky.shader')
s=p.read_text().replace('BeforeRenderingSkybox','AfterRenderingOpaques').replace('RenderPassEvent.BeforeRenderingSkybox','RenderPassEvent.AfterRenderingOpaques')
p.write_text(s)
p=Path('Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/Editor/EID4922SkyAssetBuilder.cs')
s=p.read_text()
# inject attach target method before final #endif
insert=r'''
    [MenuItem("EID4922/Attach Sky Marker To EID3336 RenderDoc Camera")]
    public static void AttachToTargetScene()
    {
        const string target = "Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
        Scene scene = EditorSceneManager.OpenScene(target, OpenSceneMode.Single);
        Camera[] cameras = Object.FindObjectsOfType<Camera>(true);
        if (cameras.Length == 0) throw new System.Exception("No camera found in target scene");
        Camera selected = cameras[0];
        foreach (Camera c in cameras) if (c.name.IndexOf("RenderDoc", System.StringComparison.OrdinalIgnoreCase) >= 0) { selected = c; break; }
        EID4922SkyCamera marker = selected.GetComponent<EID4922SkyCamera>();
        if (marker == null) marker = selected.gameObject.AddComponent<EID4922SkyCamera>();
        marker.enabledForSky = true;
        EditorSceneManager.MarkSceneDirty(scene); EditorSceneManager.SaveScene(scene);
        Debug.Log("[EID4922] marker attached to target camera: " + selected.name);
    }
'''
s=s.replace('\n#endif', '\n'+insert+'\n#endif')
p.write_text(s)
