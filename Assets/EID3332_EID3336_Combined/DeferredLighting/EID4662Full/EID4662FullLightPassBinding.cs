using System;
using System.Collections.Generic;
using System.IO;
using System.Runtime.InteropServices;
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
#endif

/// <summary>
/// Isolated EID4662 full-FS binding. It intentionally has no dependency on the
/// legacy EID3336 B6 property names, buffers, or material instance.
/// </summary>
public sealed class EID4662FullLightPassBinding
{
    public enum RealtimeIndirectMode
    {
        CurrentCapturedResources = 0,
        DirectOnly = 1,
        IrradianceOnly = 2,
        ReflectionOnly = 3,
        WorldIndirectAndFog = 4
    }

    public enum SampleTextureOverrideMode
    {
        Unchanged = 0,
        ForceZero = 1,
        ForceOne = 2
    }

    public enum SampleTextureOverrideScope
    {
        AllAuxiliary = 0,
        ScreenSpace = 1,
        Irradiance = 2,
        Reflection = 3,
        VolumetricFog = 4,
        MaterialMask = 5
    }

    const string Root = "Assets/EID3332_EID3336_Combined/DeferredLighting/EID4662Full";
    const string ImportedRoot = Root + "/Resources/Imported";
    const string RawRoot = Root + "/Resources/Raw";

    readonly Dictionary<string, ComputeBuffer> constantBuffers = new Dictionary<string, ComputeBuffer>();
    ComputeBuffer clusterMaskBuffer;
    Texture3D zeroVolume, oneVolume;
    Texture2DArray zeroArray, oneArray;
    bool resourcesLoaded;

    struct UInt4 { public uint x, y, z, w; }

    public void Bind(Material material, bool useCapturedScreenSpace, RealtimeIndirectMode realtimeMode = RealtimeIndirectMode.CurrentCapturedResources,
        SampleTextureOverrideMode overrideMode = SampleTextureOverrideMode.Unchanged,
        SampleTextureOverrideScope overrideScope = SampleTextureOverrideScope.AllAuxiliary)
    {
        if (material == null) return;
        LoadTextures(material, useCapturedScreenSpace);
        LoadBuffers(material);
        if (!useCapturedScreenSpace) ApplyRealtimeMode(material, realtimeMode);
        ApplySampleTextureOverride(material, overrideMode, overrideScope);
        material.SetFloat("_EID4662EnableFullModules", realtimeMode == RealtimeIndirectMode.DirectOnly ? 0f : 1f);
        material.SetFloat("_EID4662OutputAlpha", 1f);
    }

    void ApplySampleTextureOverride(Material material, SampleTextureOverrideMode mode, SampleTextureOverrideScope scope)
    {
        if (mode == SampleTextureOverrideMode.Unchanged) return;
        bool zero = mode == SampleTextureOverrideMode.ForceZero;
        Texture2D value2D = zero ? Texture2D.blackTexture : Texture2D.whiteTexture;
        Texture3D value3D = zero ? GetNeutralVolume(false) : GetNeutralVolume(true);
        Texture2DArray valueArray = zero ? GetNeutralArray(false) : GetNeutralArray(true);

        bool all = scope == SampleTextureOverrideScope.AllAuxiliary;
        bool screen = all || scope == SampleTextureOverrideScope.ScreenSpace;
        bool irradiance = all || scope == SampleTextureOverrideScope.Irradiance;
        bool reflection = all || scope == SampleTextureOverrideScope.Reflection;
        bool fog = all || scope == SampleTextureOverrideScope.VolumetricFog;
        bool mask = all || scope == SampleTextureOverrideScope.MaterialMask;

        if (screen)
        {
            material.SetTexture("_18", value2D);
            material.SetTexture("_19", value2D);
            material.SetTexture("_20", value2D);
            material.SetTexture("_33", value2D);
            material.SetTexture("_38", value2D);
        }
        if (irradiance)
        {
            material.SetTexture("_39", value3D);
            material.SetTexture("_40", value3D);
            material.SetTexture("_41", value3D);
            material.SetTexture("_42", value3D);
            material.SetTexture("_43", value3D);
            material.SetTexture("_44", value3D);
        }
        if (reflection)
        {
            material.SetTexture("_21", valueArray);
            material.SetTexture("_29", value2D);
            material.SetTexture("_30", value2D);
            material.SetTexture("_32", value2D);
            material.SetTexture("_33", value2D);
        }
        if (fog) material.SetTexture("_34", value3D);
        if (mask) material.SetTexture("_45", value2D);
    }

    Texture3D GetNeutralVolume(bool one)
    {
        if (one && oneVolume != null) return oneVolume;
        if (!one && zeroVolume != null) return zeroVolume;
        Texture3D volume = new Texture3D(1, 1, 1, TextureFormat.RGBA32, false)
        { name = one ? "EID4662_OneVolume" : "EID4662_ZeroVolume", filterMode = FilterMode.Point, wrapMode = TextureWrapMode.Clamp, hideFlags = HideFlags.HideAndDontSave };
        volume.SetPixel(0, 0, 0, one ? Color.white : Color.black);
        volume.Apply(false, true);
        if (one) oneVolume = volume; else zeroVolume = volume;
        return volume;
    }

    Texture2DArray GetNeutralArray(bool one)
    {
        if (one && oneArray != null) return oneArray;
        if (!one && zeroArray != null) return zeroArray;
        Texture2DArray array = new Texture2DArray(1, 1, 1, TextureFormat.RGBA32, false)
        { name = one ? "EID4662_OneArray" : "EID4662_ZeroArray", filterMode = FilterMode.Point, wrapMode = TextureWrapMode.Clamp, hideFlags = HideFlags.HideAndDontSave };
        array.SetPixels(new[] { one ? Color.white : Color.black }, 0, 0);
        array.Apply(false, true);
        if (one) oneArray = array; else zeroArray = array;
        return array;
    }

    void ApplyRealtimeMode(Material material, RealtimeIndirectMode mode)
    {
        if (mode == RealtimeIndirectMode.CurrentCapturedResources) return;

        bool irradiance = mode == RealtimeIndirectMode.IrradianceOnly ||
                          mode == RealtimeIndirectMode.WorldIndirectAndFog;
        bool reflection = mode == RealtimeIndirectMode.ReflectionOnly ||
                          mode == RealtimeIndirectMode.WorldIndirectAndFog;
        bool fog = mode == RealtimeIndirectMode.WorldIndirectAndFog;

        // Screen-space resources remain disabled for a moving camera.
        material.SetTexture("_18", Texture2D.blackTexture);
        material.SetTexture("_19", Texture2D.blackTexture);
        material.SetTexture("_20", Texture2D.whiteTexture);
        material.SetTexture("_38", Texture2D.blackTexture);
        material.SetTexture("_45", Texture2D.whiteTexture);

        // World-space indirect modules are enabled independently for staged
        // validation. The atlas and volumetric resources are not tied to the
        // current screen; reflection validity/visibility use neutral masks in
        // a moving Unity camera instead of a previous captured view.
        if (reflection)
        {
            // Keep the imported Reflection Atlas and use neutral validity and
            // visibility so the captured screen mask cannot create ghosting.
            material.SetTexture("_29", Texture2D.whiteTexture);
            material.SetTexture("_33", Texture2D.whiteTexture);
        }
        else
        {
            material.SetTexture("_21", GetNeutralArray(false));
            material.SetTexture("_29", Texture2D.blackTexture);
            material.SetTexture("_33", Texture2D.whiteTexture);
        }
        if (!fog)
            material.SetTexture("_34", GetNeutralVolume(false));
        if (!irradiance)
        {
            Texture3D neutral = GetNeutralVolume(false);
            material.SetTexture("_39", neutral);
            material.SetTexture("_40", neutral);
            material.SetTexture("_41", neutral);
            material.SetTexture("_42", neutral);
            material.SetTexture("_43", neutral);
            material.SetTexture("_44", neutral);
        }
    }

    void LoadTextures(Material material, bool useCapturedScreenSpace)
    {
#if UNITY_EDITOR
        SetTexture(material, "_18", "screen_specular_color_b7.asset");
        SetTexture(material, "_19", "screen_specular_weight_b8.asset");
        SetTexture(material, "_20", "ssao_b18.asset");
        SetTexture(material, "_21", "reflection_atlas_mip3.asset");
        SetTexture(material, "_29", "reflection_validity_b6.asset");
        SetTexture(material, "_30", "reflection_tint_lut_b24.asset");
        SetTexture(material, "_32", "brdf_lut_b10.asset");
        SetTexture(material, "_33", "reflection_visibility_b22.asset");
        SetTexture(material, "_34", "volumetric_fog_b17.asset");
        SetTexture(material, "_37", "sh_decode_lut_b25.asset");
        SetTexture(material, "_38", "screen_sh_b5.asset");
        SetTexture(material, "_39", "irr_weight_coarse_b14.asset");
        SetTexture(material, "_40", "irr_data_coarse_b11.asset");
        SetTexture(material, "_41", "irr_weight_medium_b15.asset");
        SetTexture(material, "_42", "irr_data_medium_b12.asset");
        SetTexture(material, "_43", "irr_weight_fine_b16.asset");
        SetTexture(material, "_44", "irr_data_fine_b13.asset");
        SetTexture(material, "_45", "mask_b4.asset");

        // Screen-space captures are valid only for the captured camera. Reusing
        // them in SceneView or a moving Game camera produces the previous-view
        // ghosting/flicker. Keep world/LUT resources, but neutralize view-bound
        // inputs for a live Unity camera.
        if (!useCapturedScreenSpace)
        {
            material.SetTexture("_18", Texture2D.blackTexture);
            material.SetTexture("_19", Texture2D.blackTexture);
            material.SetTexture("_20", Texture2D.whiteTexture);
            material.SetTexture("_38", Texture2D.blackTexture);
            material.SetTexture("_45", Texture2D.whiteTexture);
        }
#endif
    }

#if UNITY_EDITOR
    static void SetTexture(Material material, string property, string file)
    {
        if (!material.HasProperty(property)) return;
        Texture texture = AssetDatabase.LoadAssetAtPath<Texture>(ImportedRoot + "/" + file);
        if (texture != null) material.SetTexture(property, texture);
    }
#endif

    void LoadBuffers(Material material)
    {
        if (!resourcesLoaded)
        {
            CreateConstantBuffer("_6_7", "cb_uniforms7_b26.bin", 1312);
            CreateConstantBuffer("_8_9", "cb_uniforms9_b29.bin", 3200);
            CreateConstantBuffer("_24_26", "cb_uniforms26_b30.bin", 4160);
            CreateConstantBuffer("_27_28", "cb_uniforms28_b27.bin", 32864);
            CreateConstantBuffer("_35_36", "cb_uniforms36_b28.bin", 128);
            clusterMaskBuffer = CreateRawBuffer("ssbo_cluster_b31.bin");
            resourcesLoaded = true;
        }

        BindConstant(material, "_6_7", 1312);
        BindConstant(material, "_8_9", 3200);
        BindConstant(material, "_24_26", 4160);
        BindConstant(material, "_27_28", 32864);
        BindConstant(material, "_35_36", 128);
        if (clusterMaskBuffer != null) material.SetBuffer("_23", clusterMaskBuffer);
    }

    void BindConstant(Material material, string name, int size)
    {
        if (constantBuffers.TryGetValue(name, out ComputeBuffer buffer) && buffer != null)
            material.SetConstantBuffer(Shader.PropertyToID(name), buffer, 0, size);
    }

    void CreateConstantBuffer(string name, string file, int expectedSize)
    {
        string path = ProjectFile(RawRoot + "/" + file);
        if (!File.Exists(path)) return;
        byte[] bytes = File.ReadAllBytes(path);
        if (bytes.Length != expectedSize || (bytes.Length & 15) != 0) return;
        UInt4[] words = new UInt4[bytes.Length / 16];
        for (int i = 0; i < words.Length; ++i)
        {
            words[i].x = BitConverter.ToUInt32(bytes, i * 16 + 0);
            words[i].y = BitConverter.ToUInt32(bytes, i * 16 + 4);
            words[i].z = BitConverter.ToUInt32(bytes, i * 16 + 8);
            words[i].w = BitConverter.ToUInt32(bytes, i * 16 + 12);
        }
        ComputeBuffer buffer = new ComputeBuffer(words.Length, 16, ComputeBufferType.Constant);
        buffer.SetData(words);
        constantBuffers[name] = buffer;
    }

    ComputeBuffer CreateRawBuffer(string file)
    {
        string path = ProjectFile(RawRoot + "/" + file);
        if (!File.Exists(path)) return null;
        byte[] bytes = File.ReadAllBytes(path);
        if (bytes.Length == 0 || (bytes.Length & 3) != 0) return null;
        uint[] words = new uint[bytes.Length / 4];
        Buffer.BlockCopy(bytes, 0, words, 0, bytes.Length);
        ComputeBuffer buffer = new ComputeBuffer(words.Length, 4, ComputeBufferType.Raw);
        buffer.SetData(words);
        return buffer;
    }

    static string ProjectFile(string assetPath)
    {
        return Path.Combine(Directory.GetParent(Application.dataPath).FullName,
            assetPath.Replace('/', Path.DirectorySeparatorChar));
    }

    static void DestroyNeutralTexture<T>(ref T texture) where T : UnityEngine.Object
    {
        if (texture == null) return;
        if (Application.isPlaying) UnityEngine.Object.Destroy(texture);
        else UnityEngine.Object.DestroyImmediate(texture);
        texture = null;
    }

    public void Release()
    {
        foreach (ComputeBuffer buffer in constantBuffers.Values)
            buffer?.Release();
        constantBuffers.Clear();
        clusterMaskBuffer?.Release();
        clusterMaskBuffer = null;
        DestroyNeutralTexture(ref zeroVolume);
        DestroyNeutralTexture(ref oneVolume);
        DestroyNeutralTexture(ref zeroArray);
        DestroyNeutralTexture(ref oneArray);
        resourcesLoaded = false;
    }
}
