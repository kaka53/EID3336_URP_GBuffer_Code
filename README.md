# EID3332 / EID3336 URP Reconstruction — Code Only

This repository contains only the source portion of the isolated RenderDoc-to-Unity
reconstruction. It is intentionally separate from the runnable asset release.

## Included

- EID3332/EID3336/EID3315/EID3490 C# runtime and editor scripts
- Shared MRT, GBuffer, deferred-lighting and composite HLSL/Shader source
- Route B URP adapter source
- Customized URP 14.0.12 C#, HLSL and Shader source
- Assembly definitions and Unity `.meta` files for the source tree
- Package manifest/lock file and Unity editor version

## Not included

Models, textures, materials, scenes, ScriptableObject assets, RenderDoc raw
buffers, validation images, Unity `Library`, and generated IDE project files are
not included. This repository cannot render by itself until the corresponding
asset release is supplied.

The runnable asset release is maintained separately at:
`D:\endcopy\EID3336_URP_GBuffer_Git`

## Source layout

- `Assets/EID3332_EID3336_Combined/` — reconstruction runtime/editor/shader source
- `Packages/com.unity.render-pipelines.universal/` — customized URP package source
- `Packages/manifest.json` and `Packages/packages-lock.json` — package declarations
- `ProjectSettings/ProjectVersion.txt` — required Unity version (`2022.3.62f1c1`)

## Git usage

This repository contains no Git LFS payloads and is suitable for a normal small
Git repository. Do not add captured assets to this repository accidentally; put
large runtime data in the separate asset release or a dedicated LFS repository.