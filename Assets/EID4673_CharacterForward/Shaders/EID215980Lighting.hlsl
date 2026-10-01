#ifndef EID215980_LIGHTING_INCLUDED
#define EID215980_LIGHTING_INCLUDED

// Wave 1 lighting for bound PS ResourceId 215992 (disk dump named PS215980.spv).
// Isolate EID4730 = ColourPass6 EID1642 / VS215443.
// 215992 set1: _51 LUT rid195422, _56 albedo rid224056=_Res25, _58 tangent N rid223665=_Res26,
// _57 packed rid223959 (not wired), _50 256x1 rid191424 (never Get-Texture).
// SH / hemi / N·L use mapped _558 xyz. Do not flatten n.y (that was PS215980.cross, not 215992).
// sun xz flatten is only for xzFade (215992 _2071), not SH. Shadow Load _38, volume fog, SH _40-45 IrrOn=1.
// clipW MUST be VS clip.w (currentClipXYW.z). Fragment SV_POSITION.w is 1/w on Vulkan.
// Stub: instance _30, IES, shadowmap _37, triplanar t39, dual MRT 210525, cluster _28.

TEXTURE2D(_EID215980Lut);
SAMPLER(sampler_EID215980Lut);
TEXTURE2D(_EID215980Shadow);
TEXTURE3D(_EID215980Fog);
SAMPLER(sampler_EID215980Fog);
TEXTURE3D(_EID215980IrrFineData);
SAMPLER(sampler_EID215980IrrFineData);
TEXTURE3D(_EID215980IrrFineWeight);
TEXTURE3D(_EID215980IrrMedData);
TEXTURE3D(_EID215980IrrMedWeight);
TEXTURE3D(_EID215980IrrCoarseData);
TEXTURE3D(_EID215980IrrCoarseWeight);

float _EID215980IrrOn;

static const float3 EID215980_LumaW = float3(0.21267290413379669189, 0.71515220403671264648, 0.072175003588199615479);
static const float3 EID215980_LumaSH = float3(0.2125999927520751953125, 0.715200006961822509765625, 0.072200000286102294921875);
static const float3 EID215980_SunDir = float3(1.9536580353474164e-08, 0.5735763907432556, 0.8191519975662231);
static const float4 EID215980_SunColor = float4(1.0, 0.7902896404266357, 0.6293801665306091, 1.6927943229675293);
static const float4 EID215980_SH0 = float4(-0.0011741510825231671, 0.34582585096359253, 0.14659471809864044, 0.4507005214691162);
static const float4 EID215980_SH1 = float4(0.006098389159888029, 0.5179643034934998, 0.14906127750873566, 0.6433354020118713);
static const float4 EID215980_SH2 = float4(0.0135980024933815, 0.7077738642692566, 0.1498795747756958, 0.8406277298927307);
static const float EID215980_Exposure = 1.1486977338790894;
static const float EID215980_ShScale = 1.0446611881256104;
static const float4 EID215980_M79 = float4(0.0, 1.0, 0.7, 1.0);
static const float4 EID215980_M80 = float4(0.0, 0.0, 0.0, 0.0);
static const float3 EID215980_M84 = float3(1.0, 1.0, 1.0);
static const float3 EID215980_M85 = float3(0.0, 1.0, 0.0);
static const float4 EID215980_M86 = float4(0.15, 0.6, 1.0, 0.0);
static const float4 EID215980_M90 = float4(-0.43301272392272949, 0.5, 0.75, 0.0);
static const float4 EID215980_M91 = float4(0.0, 0.0, 1.0, 0.0);
static const float3 EID215980_CamFwdLut = float3(-0.9434158205986023, -0.06164082512259483, 0.3258327543735504);
static const float2 EID215980_CaptureSize = float2(1366.0, 768.0);
static const float4 EID215980_Fog43 = float4(10.9026460647583, 9.828215599060059, 8.884498596191406, 0.03500000014901161);
static const float4 EID215980_Fog44 = float4(-0.26649436354637146, 0.70587158203125, 0.6562970876693726, 0.00018000001728069037);
static const float4 EID215980_Fog45 = float4(2.331103801727295, 2.788999319076538, 2.913879871368408, 0.6000000238418579);
static const float4 EID215980_Fog46 = float4(0.0, 0.0, 0.0, -0.0022522523067891598);
static const float4 EID215980_Fog47 = float4(0.04275547340512276, 0.038542021065950394, 0.03484117239713669, 0.245194673538208);
static const float4 EID215980_Fog48 = float4(0.0017330222763121128, 0.0036124621983617544, 0.005700730253010988, -1.1950000524520874);
static const float4 EID215980_Fog49 = float4(50.0, 0.0014000000664964318, 0.05400000140070915, 0.0);
static const float4 EID215980_Fog50 = float4(0.0, -0.0010000000474974513, -6.600000381469727, 0.0010000000474974513);
static const float4 EID215980_Fog51 = float4(0.7654368877410889, 1.098894476890564, 1.515716552734375, 0.0);
static const float4 EID215980_Fog52 = float4(0.01600000075995922, 0.00020000000949949026, 154.0, 0.0);
static const float4 EID215980_Fog53 = float4(-1.9536580353474164e-08, -0.5735763907432556, -0.8191519975662231, 100.0);
static const float4 EID215980_Fog54 = float4(0.0, 0.0, 0.0, 4.0);
static const float4 EID215980_Fog55 = float4(86.0, 48.0, 128.0, 100.0);
static const float4 EID215980_Fog56 = float4(0.4901238679885864, -33.35523223876953, 32.0, 0.30000001192092896);
static const float4 EID215980_Fog57 = float4(0.0007320644217543304, 0.0013020833721384406, 16.0, 16.0);
static const float EID215980_Fog58z = 70.0;
static const float EID215980_Fog59w = 1.5;
static const uint EID215980_FogFrame = 5u;
static const float4 EID215980_M105 = float4(-556.83544921875, 106.5960693359375, -412.190673828125, -1.0);
static const float4 EID215980_M106 = float4(0.0078125, 0.015625, 0.0078125, 0.0);
static const float4 EID215980_M107 = float4(23.0, 13.0, 52.0, 144.0);
static const float3 EID215980_InstR0 = float3(-0.3432047367095947, 7.105427357601002e-15, -0.9392606616020203);
static const float3 EID215980_InstR1 = float3(1.2507011604157015e-07, 1.0, -4.570046741037004e-08);
static const float3 EID215980_InstR2 = float3(0.9392606616020203, -1.3315805347247078e-07, -0.3432047367095947);

float EID215980Exp2Over(float k)
{
    float ak = abs(k);
    return (ak > 5.9604644775390625e-08) ? ((1.0 - exp2(-k)) / k) : (0.693147182464599609375 - (0.2402265071868896484375 * k));
}

float2 EID215980CaptureXY(float2 fragXY)
{
    return fragXY * (EID215980_CaptureSize / max(_ScreenParams.xy, 1.0));
}

float3 EID215980FogJitter(int2 pix)
{
    uint3 h = (uint3(int3(pix, int(EID215980_FogFrame))) * 1664525u) + 1013904223u;
    uint a = h.x + (h.y * h.z);
    uint b = h.y + (h.z * a);
    uint c = h.z + (a * b);
    uint d = a + (b * c);
    uint3 u = uint3(d, b + (c * d), 0u) >> 16u;
    return (float3(u) * 1.525902189314365386962890625e-05) * 2.0 - 1.0;
}

float EID215980BoxFade(float3 rel, float xz, float y, float inv)
{
    return max(clamp((max(abs(rel.x), abs(rel.z)) - xz) * inv, 0.0, 1.0), clamp((abs(rel.y) - y) * inv, 0.0, 1.0));
}

void EID215980SampleCascadeUv(float3 worldPos, float scale, bool clampUv, out float3 dataUv, out float3 weightUv)
{
    float3 t = ((worldPos * scale) + 0.5) * EID215980_M106.xyz;
    float3 uvw = t - floor(t);
    if (clampUv)
    {
        float3 halfTex = EID215980_M106.xyz * 0.5;
        uvw = clamp(uvw, halfTex, 1.0 - halfTex);
    }
    dataUv = uvw;
    float yHalf = EID215980_M106.y * 0.5;
    weightUv = float3(uvw.x, clamp(uvw.y, yHalf, 1.0 - yHalf) * 0.3333333432674407958984375, uvw.z);
}

void EID215980AddCascade(float4 data, float4 w0, float4 w1, float4 w2, float fade,
    inout float accW, inout float4 c0, inout float4 c1, inout float4 c2)
{
    accW += w0.w * fade;
    c0 += float4((w0.xyz * 4.0 - 2.0) * data.x, data.x) * fade;
    c1 += float4((w1.xyz * 4.0 - 2.0) * data.y, data.y) * fade;
    c2 += float4((w2.xyz * 4.0 - 2.0) * data.z, data.z) * fade;
}

void EID215980EvalSH(float3 positionWS, float3 n, out float3 sh, out float3 shDirN, out float shEnergy, out float3 shChroma)
{
    float4 sh0 = EID215980_SH0;
    float4 sh1 = EID215980_SH1;
    float4 sh2 = EID215980_SH2;
    [branch]
    if (_EID215980IrrOn > 0.5)
    {
        float3 camFwd = EID215980_CamFwdLut;
        float fadeC = EID215980BoxFade(positionWS - (EID215980_M105.xyz + (camFwd * (-EID215980_M107.w))), 464.0, 208.0, 0.03125);
        if ((EID215980_M105.w != 0.0) && (fadeC < 1.0))
        {
            float4 c0 = 0.0;
            float4 c1 = 0.0;
            float4 c2 = 0.0;
            float accW = 0.0;
            float3 dataUv;
            float3 weightUv;
            float fadeF = EID215980BoxFade(positionWS - (EID215980_M105.xyz + (camFwd * (-EID215980_M107.y))), 29.0, 13.0, 0.5);
            if (fadeF < 1.0)
            {
                EID215980SampleCascadeUv(positionWS, 2.0, false, dataUv, weightUv);
                EID215980AddCascade(
                    SAMPLE_TEXTURE3D_LOD(_EID215980IrrFineData, sampler_EID215980IrrFineData, dataUv, 0),
                    SAMPLE_TEXTURE3D_LOD(_EID215980IrrFineWeight, sampler_EID215980IrrFineData, weightUv, 0),
                    SAMPLE_TEXTURE3D_LOD(_EID215980IrrFineWeight, sampler_EID215980IrrFineData, float3(weightUv.x, weightUv.y + 0.3333333432674407958984375, weightUv.z), 0),
                    SAMPLE_TEXTURE3D_LOD(_EID215980IrrFineWeight, sampler_EID215980IrrFineData, float3(weightUv.x, weightUv.y + 0.666666686534881591796875, weightUv.z), 0),
                    1.0 - fadeF, accW, c0, c1, c2);
            }
            float fadeM = EID215980BoxFade(positionWS - (EID215980_M105.xyz + (camFwd * (-EID215980_M107.z))), 116.0, 52.0, 0.125);
            if (fadeM < 1.0)
            {
                EID215980SampleCascadeUv(positionWS, 0.5, false, dataUv, weightUv);
                EID215980AddCascade(
                    SAMPLE_TEXTURE3D_LOD(_EID215980IrrMedData, sampler_EID215980IrrFineData, dataUv, 0),
                    SAMPLE_TEXTURE3D_LOD(_EID215980IrrMedWeight, sampler_EID215980IrrFineData, weightUv, 0),
                    SAMPLE_TEXTURE3D_LOD(_EID215980IrrMedWeight, sampler_EID215980IrrFineData, float3(weightUv.x, weightUv.y + 0.3333333432674407958984375, weightUv.z), 0),
                    SAMPLE_TEXTURE3D_LOD(_EID215980IrrMedWeight, sampler_EID215980IrrFineData, float3(weightUv.x, weightUv.y + 0.666666686534881591796875, weightUv.z), 0),
                    fadeF * (1.0 - fadeM), accW, c0, c1, c2);
            }
            if (fadeM > 0.0)
            {
                EID215980SampleCascadeUv(positionWS, 0.125, true, dataUv, weightUv);
                EID215980AddCascade(
                    SAMPLE_TEXTURE3D_LOD(_EID215980IrrCoarseData, sampler_EID215980IrrFineData, dataUv, 0),
                    SAMPLE_TEXTURE3D_LOD(_EID215980IrrCoarseWeight, sampler_EID215980IrrFineData, weightUv, 0),
                    SAMPLE_TEXTURE3D_LOD(_EID215980IrrCoarseWeight, sampler_EID215980IrrFineData, float3(weightUv.x, weightUv.y + 0.3333333432674407958984375, weightUv.z), 0),
                    SAMPLE_TEXTURE3D_LOD(_EID215980IrrCoarseWeight, sampler_EID215980IrrFineData, float3(weightUv.x, weightUv.y + 0.666666686534881591796875, weightUv.z), 0),
                    fadeM * (1.0 - fadeC), accW, c0, c1, c2);
            }
            float w01 = clamp(accW * 2.0 - 1.0, 0.0, 1.0);
            float d = w01 - fadeC;
            float s = (w01 + fadeC) * 0.5;
            sh0 = c0 + float4(EID215980_SH0.x * s, (EID215980_SH0.y * s) + ((EID215980_SH0.w * d) * 0.5), EID215980_SH0.z * s, (EID215980_SH0.w * s) + ((EID215980_SH0.y * d) * 0.375));
            sh1 = c1 + float4(EID215980_SH1.x * s, (EID215980_SH1.y * s) + ((EID215980_SH1.w * d) * 0.5), EID215980_SH1.z * s, (EID215980_SH1.w * s) + ((EID215980_SH1.y * d) * 0.375));
            sh2 = c2 + float4(EID215980_SH2.x * s, (EID215980_SH2.y * s) + ((EID215980_SH2.w * d) * 0.5), EID215980_SH2.z * s, (EID215980_SH2.w * s) + ((EID215980_SH2.y * d) * 0.375));
        }
    }

    float4 nSh = float4(n, 1.0);
    sh = max(float3(dot(sh0, nSh), dot(sh1, nSh), dot(sh2, nSh)), 0.0) * EID215980_ShScale;
    float3 shDir = (sh0.xyz * EID215980_LumaSH.x) + (sh1.xyz * EID215980_LumaSH.y) + (sh2.xyz * EID215980_LumaSH.z);
    shDir *= rsqrt(max(1.1754943508222875e-38, dot(shDir, shDir)));
    float shAbsY = abs(shDir.y);
    shDirN = float3(shDir.x, shAbsY, shDir.z);
    float4 shDir4 = float4(shDirN, 1.0);
    float3 shPeak = max(float3(dot(sh0, shDir4), dot(sh1, shDir4), dot(sh2, shDir4)), 0.0);
    shEnergy = max(max(max(shPeak.x, shPeak.y), shPeak.z), 0.0) * EID215980_ShScale;

    float4 a = lerp(float4(sh.z, sh.y, -1.0, 0.666666686534881591796875), float4(sh.y, sh.z, 0.0, -0.3333333432674407958984375), step(sh.z, sh.y).xxxx);
    float4 b = lerp(float4(a.x, a.y, a.w, sh.x), float4(sh.x, a.y, a.z, a.x), step(a.x, sh.x).xxxx);
    float delta = b.x - min(b.w, b.y);
    float hue = frac(abs(b.z + ((b.w - b.y) / ((6.0 * delta) + 9.9999997473787516355514526367188e-05))));
    float sat = min(delta / (b.x + 9.9999997473787516355514526367188e-05), lerp(0.699999988079071044921875, 0.3499999940395355224609375, smoothstep(0.449999988079071044921875, 0.3499999940395355224609375, abs(hue - 0.5))) * saturate(b.x));
    float value = 2.0 / (2.0 - sat);
    shChroma = lerp(1.0.xxx, saturate(abs((frac(hue.xxx + float3(1.0, 0.666666686534881591796875, 0.3333333432674407958984375)) * 6.0) - 3.0.xxx) - 1.0.xxx), sat.xxx) * value;
}

float3 EID215980ApplyFog(float3 lit, float3 positionWS, float3 viewToCam, float dist, float clipW, float2 capXY)
{
    float3 camPos = GetCameraPositionWS();
    float h = positionWS.y * EID215980_Fog46.w;
    float denom = max(0.01, h + EID215980_Fog47.w);
    float optical = max(0.0, (dist * EID215980_Fog44.w) - EID215980_Fog43.w);
    float3 tExp = exp(EID215980_Fog45.xyz * ((-optical) * (((1.0 - exp(-denom)) / denom) * exp(h + EID215980_Fog48.w))));

    float3 viewAway = -viewToCam;
    float cosSun = dot(viewAway, EID215980_Fog44.xyz);
    float g = EID215980_Fog45.w;
    float g2 = g * g;
    float phaseDenom = (1.0 + g2) - ((2.0 * g) * cosSun);

    float cosCam = dot(viewAway, -EID215980_CamFwdLut);
    float hCorr = (EID215980_Fog55.w * ((cosCam > 5.9604644775390625e-08) ? (1.0 / cosCam) : 0.0)) * (1.0 / max(dist, 1e-8));
    float3 toCam = positionWS - camPos;
    float yCam = camPos.y + (hCorr * toCam.y);
    float yPos = toCam.y - (hCorr * toCam.y);
    float distH = (1.0 - hCorr) * dist;

    float k1 = max(-127.0, EID215980_Fog49.z * yPos);
    float k2 = max(-127.0, EID215980_Fog52.x * yPos);
    float fogInt =
        (EID215980_Fog49.y * exp2(-max(-127.0, EID215980_Fog49.z * (yCam - EID215980_Fog49.x)))) * EID215980Exp2Over(k1)
        + (EID215980_Fog52.y * exp2(-max(-127.0, EID215980_Fog52.x * (yCam - EID215980_Fog52.z)))) * EID215980Exp2Over(k2);
    float a = saturate((dist * EID215980_Fog50.w) + EID215980_Fog50.z);
    float trans = saturate((max(saturate(exp2(-(fogInt * distH))), EID215980_Fog51.w) + saturate((dist * EID215980_Fog50.y) + EID215980_Fog50.x)) + a);
    float3 fogAdd = (EID215980_Fog51.xyz * (1.0 - trans))
        + (((EID215980_Fog54.xyz * pow(saturate(dot(viewToCam, EID215980_Fog53.xyz)), EID215980_Fog54.w))
            * (1.0 - saturate(exp2(-(fogInt * max(distH - EID215980_Fog53.w, 0.0)))))) * (1.0 - a));
    float3 scatter = saturate(
        ((EID215980_Fog46.xyz * (0.059683103114366531372 * (1.0 + (cosSun * cosSun)))) + EID215980_Fog48.xyz)
        + (EID215980_Fog47.xyz * ((1.0 - g2) / max((12.56637096405029296875 * phaseDenom) * sqrt(phaseDenom), 0.001))))
        * 255.0 * (1.0 - tExp);

    float3 jitter = EID215980FogJitter(int2(capXY));
    float2 fogUv = (capXY + (jitter.xy * EID215980_Fog59w)) * EID215980_Fog57.xy;
    float fogArg = max((clipW * EID215980_Fog56.x) + EID215980_Fog56.y, 1.1754943508222875e-38);
    float fogZ = (log2(fogArg) * EID215980_Fog56.z) / EID215980_Fog55.z;
    float4 vol = SAMPLE_TEXTURE3D_LOD(_EID215980Fog, sampler_EID215980Fog, float3(fogUv, fogZ), 0);
    vol = lerp(float4(0.0, 0.0, 0.0, 1.0), vol, saturate((clipW - EID215980_Fog58z) * 1000000.0));
    float transV = trans * vol.w;
    float3 fogAddV = vol.xyz + (fogAdd * vol.w);
    return (lit * (tExp * transV)) + ((scatter * transV) + fogAddV);
}

float3 EID215980LitColor(float3 albedoTinted, float3 positionWS, float3 normalWS, bool isFrontFace, float4 positionCS)
{
    float specScale = _P04.z;
    float specSat = _P04.w;
    float twoSided = _P01.y;
    float rough = _P00.z;
    float3 scaled = albedoTinted * specScale;
    float3 specCol = lerp(dot(scaled, EID215980_LumaW).xxx, scaled, specSat.xxx);
    float3 n = normalize(normalWS) * (isFrontFace ? 1.0 : ((-1.0) + (2.0 * twoSided)));
    float kd = 0.96 - (rough * 0.96);
    float3 diffAlbedo = albedoTinted * kd;
    float3 specDiff = specCol * kd;

    float3 camRel = positionWS - GetCameraPositionWS();
    float dist2 = dot(camRel, camRel);
    float rdist = rsqrt(max(dist2, 9.9999999392252903e-09));
    float3 viewToCam = (-camRel) * rdist;
    float dist = dist2 * rdist;

    float3 sh;
    float3 shDirN;
    float shEnergy;
    float3 shChroma;
    EID215980EvalSH(positionWS, n, sh, shDirN, shEnergy, shChroma);

    float3 sunDir = lerp(EID215980_SunDir, EID215980_M90.xyz, EID215980_M80.w);
    float3 sunFlat = normalize(float3(sunDir.x, 6.103515625e-05, sunDir.z));
    float3 sunRgb = lerp(EID215980_SunColor.xyz, EID215980_M84, EID215980_M91.y);
    float3 sunCol = sunRgb * lerp(EID215980_SunColor.w, 1.0, EID215980_M91.w);

    float ndlLut = clamp(dot(n, sunDir) + (EID215980_M90.w * EID215980_M91.x), -1.0, 1.0);
    float3 camFwd = EID215980_CamFwdLut;
    float4 lut0s = SAMPLE_TEXTURE2D_LOD(_EID215980Lut, sampler_EID215980Lut, float2(ndlLut * 0.5 + 0.5, 0.5), 0);
    float4 lut1s = SAMPLE_TEXTURE2D_LOD(_EID215980Lut, sampler_EID215980Lut, float2((dot(n, camFwd) * 0.5) + 0.5, 0.5), 0);
    float lut0w = lut0s.w;
    float3 lut0rgb = lut0s.rgb;
    float lut0chroma = max(max(lut0rgb.x, lut0rgb.y), lut0rgb.z) - min(min(lut0rgb.x, lut0rgb.y), lut0rgb.z);
    float lut1w = lut1s.w;
    float lutMix = min(1.0, lut0w);

    float hemi = (clamp(dot(n, EID215980_M85) + EID215980_M86.x, 0.0, 1.0) * EID215980_M86.y) + EID215980_M86.z;
    float3 shTint = hemi.xxx * lerp(shChroma, 1.0.xxx, (EID215980_M80.y * lutMix).xxx);

    float2 capXY = EID215980CaptureXY(positionCS.xy);
    float shadow = lerp(lerp(1.0, LOAD_TEXTURE2D(_EID215980Shadow, int2(capXY)).x, 1.0), 1.0, EID215980_M80.z);
    float3 specScaled = specDiff * EID215980_M79.z;
    float3 specSoft = specScaled * 0.65;
    float diffLuma = dot(diffAlbedo, EID215980_LumaW);
    float3 satBoost = float3(1.2, 1.2, 1.2);
    float3 energyA = lerp(lerp(dot(specSoft, EID215980_LumaW).xxx, specSoft, satBoost), specScaled, saturate(lut1w + lut0w).xxx);
    float3 energyB = lerp(energyA, diffAlbedo, lutMix.xxx);
    float3 energyTint = energyB * ((1.0 - lut0chroma).xxx + (lut0rgb * lut0chroma));
    float energyKeep = clamp(dot(energyB, EID215980_LumaW) * (1.0 / max(dot(energyTint, EID215980_LumaW), 0.001)), 0.0, 1.5);
    float3 energy = lerp(lerp(specScaled, lerp(diffLuma.xxx, diffAlbedo, satBoost), lut1w.xxx), energyTint * energyKeep, shadow.xxx);

    float shBoost = lerp(min(lerp(0.64999997615814208984375, 1.0, shEnergy), 1.5), clamp(shEnergy, 1.25, 1.75), EID215980_M80.x);
    float3 indirectA = (shTint * shBoost) * EID215980_M79.w;
    float3 sunTinted = lerp(dot(sunCol, EID215980_LumaW).xxx, sunCol, lutMix.xxx);
    float3 indirectB = (sunTinted + ((shTint * clamp(shEnergy, 0.0, 1.5)) * ((1.0 - EID215980_M91.y).xxx + (sunRgb * EID215980_M91.y)))) * EID215980_M79.y;
    float3 litRgb = (lerp(indirectA, indirectB, shadow.xxx) * energy);

    float litLuma = dot(litRgb, EID215980_LumaW);
    float lift = clamp(litLuma - 0.5, 0.0, 0.5);
    float3 lit = lerp(litLuma.xxx, litRgb, ((lift * lift) + 1.0).xxx);

    float ndl = dot(sunDir, n);
    float wrap = saturate((-ndl) * ((ndl * 0.5) - 1.0) + 0.5);
    float wrapMix = lerp(dot(shDirN, n) * 1.0, wrap, shadow);
    wrapMix = clamp(wrapMix, 0.0, 1.0);
    float3 wrapSun = lerp(sh * (1.0 / max(max(max(sh.x, sh.y), sh.z) * 0.5, 1.0)), sunCol, shadow.xxx) * wrapMix;
    float2 camXz = camFwd.xz;
    camXz *= rsqrt(max(1.1754943508222875e-38, dot(camXz, camXz)));
    float xzFade = ((1.0 - shadow) + (clamp(-dot(sunFlat.xz, camXz), 0.0, 1.0) * shadow)) * (1.0 - EID215980_M91.x);
    float viewFade = smoothstep(0.6000000238418579, 0.800000011920929, 1.0 - abs(dot(viewToCam, n)));
    float lumFade = (1.0 - shadow) + (smoothstep(0.10000000149011612, 0.039999999105930328, diffLuma) * shadow);
    lit += (((wrapSun * xzFade) * viewFade) * lumFade) * max(0.15000000596046448.xxx, diffAlbedo);

    lit *= EID215980_Exposure;
    return EID215980ApplyFog(lit, positionWS, viewToCam, dist, max(positionCS.w, 1e-4), capXY);
}

#endif
