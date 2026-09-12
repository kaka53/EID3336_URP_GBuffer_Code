#ifndef EID2012_VERTEX_INCLUDED
#define EID2012_VERTEX_INCLUDED

// RenderDoc EID2012, VS module 209975. Unity supplies object/camera matrices in real time.
struct EID2012VertexInput
{
    float3 positionOS : POSITION;
    float packedNormal : TEXCOORD1;
    float4 tangentOS : TANGENT;
    float4 color : COLOR;
    float2 uv0 : TEXCOORD0;
};

struct EID2012Varyings
{
    float2 uv : TEXCOORD0;
    float3 normalWS : TEXCOORD2;
    float4 tangentWS : TEXCOORD3;
    float3 currentClipXYW : TEXCOORD5;
    float3 previousClipXYW : TEXCOORD6;
    float4 positionCS : SV_POSITION;
};

void EID2012DecodePackedNormalTangent(float packedValue, float4 fallbackTangent, out float3 normalOS, out float4 tangentOS)
{
    uint packed = asuint(packedValue);
    bool packedEncoding = (packed & 1073741824u) > 0u;
    if (!packedEncoding)
    {
        normalOS = float3(packedValue, 0.0, 0.0);
        tangentOS = fallbackTangent;
        return;
    }

    float px = float((packed << 22u) >> 22u);
    float py = float((packed << 12u) >> 22u);
    float pt = float((packed << 2u) >> 22u);
    float2 oct = float2(px >= 512.0 ? px - 1024.0 : px,
                        py >= 512.0 ? py - 1024.0 : py) * 0.001956947147846221923828125;
    float z = 1.0 - abs(oct.x) - abs(oct.y);
    float2 folded = (1.0.xx - abs(oct.yx)) * (step(0.0.xx, oct.xy) * 2.0 - 1.0.xx);
    if (z < 0.0) oct = folded;
    normalOS = normalize(float3(oct, z));

    float tangentPacked = (pt >= 512.0 ? pt - 1024.0 : pt) * 0.001956947147846221923828125;
    float3 seed = normalOS.yzx - normalOS.zxy;
    float3 basisX = normalize(seed - dot(seed, normalOS) * normalOS);
    float signValue = tangentPacked < 0.0 ? -1.0 : 1.0;
    float reconstructed = 1.0 - (tangentPacked * signValue * 2.0);
    float2 tangent2 = normalize(float2(reconstructed, signValue * (1.0 - abs(reconstructed))));
    float3 tangent3 = mul(tangent2, float2x3(basisX, normalize(cross(normalOS, basisX))));
    tangentOS = float4(tangent3, (float((packed >> 31u) & 1u) * 2.0) - 1.0);
}

EID2012Varyings EID2012Vertex(EID2012VertexInput input)
{
    EID2012Varyings output;
    float3 normalOS;
    float4 tangentOS;
    EID2012DecodePackedNormalTangent(input.packedNormal, input.tangentOS, normalOS, tangentOS);

    float3 positionWS = TransformObjectToWorld(input.positionOS);
    float3 normalWS = normalize(TransformObjectToWorldNormal(normalOS));
    float3 tangentWS = normalize(TransformObjectToWorldDir(tangentOS.xyz));
    float tangentSign = tangentOS.w * GetOddNegativeScale();
    float4 positionCS = TransformWorldToHClip(positionWS);

    output.positionCS = positionCS;
    output.uv = input.uv0;
    output.normalWS = normalWS;
    output.tangentWS = float4(tangentWS, tangentSign);
    output.currentClipXYW = positionCS.xyw;
    // Deliberately use the current transform for both values until the project provides a
    // valid previous-frame matrix. This produces the captured neutral motion encoding and
    // prevents stale previous-frame data from creating a visible ghost when the object moves.
    output.previousClipXYW = positionCS.xyw;
    return output;
}

#endif



