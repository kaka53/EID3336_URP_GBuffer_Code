#version 450
#if defined(GL_EXT_control_flow_attributes)
#extension GL_EXT_control_flow_attributes : require
#define SPIRV_CROSS_FLATTEN [[flatten]]
#define SPIRV_CROSS_BRANCH [[dont_flatten]]
#define SPIRV_CROSS_UNROLL [[unroll]]
#define SPIRV_CROSS_LOOP [[dont_unroll]]
#else
#define SPIRV_CROSS_FLATTEN
#define SPIRV_CROSS_BRANCH
#define SPIRV_CROSS_UNROLL
#define SPIRV_CROSS_LOOP
#endif
layout(early_fragment_tests) in;

float _197;

layout(binding = 0, std140) uniform _10_11
{
    layout(row_major) mat4 _m0;
    layout(row_major) mat4 _m1;
    layout(row_major) mat4 _m2;
    layout(row_major) mat4 _m3;
    layout(row_major) mat4 _m4;
    layout(row_major) mat4 _m5;
    layout(row_major) mat4 _m6;
    layout(row_major) mat4 _m7;
    layout(row_major) mat4 _m8;
    layout(row_major) mat4 _m9;
    layout(row_major) mat4 _m10;
    vec4 _m11;
    layout(row_major) mat4 _m12;
    layout(row_major) mat4 _m13;
    layout(row_major) mat4 _m14;
    layout(row_major) mat4 _m15;
    layout(row_major) mat4 _m16;
    layout(row_major) mat4 _m17;
    layout(row_major) mat4 _m18;
    layout(row_major) mat4 _m19;
    layout(row_major) mat4 _m20;
    vec4 _m21;
} _11;

layout(binding = 19, std140) uniform _12_13
{
    vec4 _m0;
    vec4 _m1;
    vec4 _m2;
    vec4 _m3;
    vec4 _m4;
    vec4 _m5;
    vec4 _m6[6];
    vec4 _m7[6];
    vec4 _m8;
    vec4 _m9;
    vec4 _m10;
    vec4 _m11;
    vec4 _m12;
    vec4 _m13;
    vec4 _m14;
    vec4 _m15;
    float _m16;
    float _m17;
    float _m18;
    uint _m19;
    vec4 _m20;
    ivec4 _m21;
    vec4 _m22;
    vec4 _m23;
    vec4 _m24;
    vec4 _m25;
    vec4 _m26;
    vec4 _m27;
    vec4 _m28;
    vec4 _m29;
    vec4 _m30;
    vec4 _m31;
    vec4 _m32[4];
    vec4 _m33[4];
    vec4 _m34[4];
    vec4 _m35[4];
    vec4 _m36;
    vec4 _m37;
    vec4 _m38[4];
    vec4 _m39[4];
    vec4 _m40[4];
    vec4 _m41;
    vec4 _m42;
    vec4 _m43;
    vec4 _m44;
    vec4 _m45;
    vec4 _m46;
    vec4 _m47;
    vec4 _m48;
    vec4 _m49;
    vec4 _m50;
    vec4 _m51;
    vec4 _m52;
    vec4 _m53;
    vec4 _m54;
    vec4 _m55;
    vec4 _m56;
    vec4 _m57;
    vec4 _m58;
    vec4 _m59;
    vec4 _m60;
    vec4 _m61;
    vec4 _m62;
    vec4 _m63;
    vec4 _m64;
    vec4 _m65;
    vec4 _m66;
    vec4 _m67;
    vec4 _m68;
    vec4 _m69;
    vec4 _m70;
    vec4 _m71;
    vec4 _m72;
    vec4 _m73;
    vec4 _m74;
    vec4 _m75;
    vec4 _m76;
    vec4 _m77;
    vec4 _m78;
    vec4 _m79;
    vec4 _m80;
    vec4 _m81;
    vec4 _m82;
    vec4 _m83;
    vec4 _m84;
    vec4 _m85;
    vec4 _m86;
    vec4 _m87;
    vec4 _m88;
    vec4 _m89;
    vec4 _m90;
    vec4 _m91;
    vec4 _m92;
    vec4 _m93;
    vec4 _m94;
    vec4 _m95;
    vec4 _m96;
    vec4 _m97;
    vec4 _m98;
    vec4 _m99[2];
    vec4 _m100[2];
    float _m101;
    float _m102;
    float _m103;
    float _m104;
    vec4 _m105;
    vec4 _m106;
    vec4 _m107;
    vec4 _m108;
    vec4 _m109;
    vec4 _m110;
    vec4 _m111;
    vec4 _m112;
    vec4 _m113;
    vec4 _m114;
    vec4 _m115;
    vec4 _m116;
    vec4 _m117;
    vec4 _m118;
    vec4 _m119;
    vec4 _m120;
    vec4 _m121;
    vec4 _m122;
    vec4 _m123;
    vec4 _m124;
    vec4 _m125;
    vec4 _m126;
    vec4 _m127;
    vec4 _m128;
    vec4 _m129;
    vec4 _m130;
    vec4 _m131;
    vec4 _m132;
    vec4 _m133;
    vec4 _m134;
    layout(row_major) mat4 _m135;
    vec4 _m136;
    vec4 _m137;
    vec4 _m138[32];
} _13;

layout(binding = 20, std140) uniform _21_22
{
    vec4 _m0;
    vec4 _m1;
    vec4 _m2;
    vec4 _m3;
    vec4 _m4;
    ivec4 _m5;
    vec4 _m6;
    vec4 _m7;
    vec4 _m8;
    vec4 _m9;
    vec4 _m10;
    uint _m11;
    uint _m12;
    float _m13;
    float _m14;
    float _m15;
    float _m16;
    float _m17;
    float _m18;
} _22;

layout(binding = 21, std140) uniform _23_24
{
    uvec4 _m0[64];
    uvec4 _m1[1024];
    ivec4 _m2;
    ivec4 _m3;
    uvec4 _m4;
} _24;

layout(binding = 18, std140) uniform _25_26
{
    vec4 _m0[64];
    vec4 _m1[64];
    vec4 _m2[64];
    vec4 _m3[64];
    vec4 _m4[64];
    vec4 _m5[64];
    vec4 _m6[64];
} _26;

layout(binding = 22, std140) uniform _27_28
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
    float _m4;
    float _m5;
    float _m6;
    float _m7;
    float _m8;
    float _m9;
    float _m10;
    float _m11;
    float _m12;
    float _m13;
    float _m14;
    float _m15;
    float _m16;
    float _m17;
    float _m18;
    float _m19;
    vec4 _m20;
    vec4 _m21;
    vec4 _m22;
    vec4 _m23;
    vec4 _m24;
    vec4 _m25;
    float _m26;
    float _m27;
    float _m28;
    float _m29;
    float _m30;
    float _m31;
    vec4 _m32;
    vec4 _m33;
} _28;

layout(binding = 23, std430) buffer _43_44
{
    uint _m0[];
} _44;

uniform sampler2D SPIRV_Cross_Combined;
uniform sampler2D SPIRV_Cross_Combined_1;
uniform sampler2D SPIRV_Cross_Combined_2;
uniform sampler2D SPIRV_Cross_Combined_3;
uniform sampler2D SPIRV_Cross_Combined_4;
uniform sampler2D SPIRV_Cross_Combined_5;
uniform sampler2D SPIRV_Cross_Combined_6;
uniform sampler2D SPIRV_Cross_Combined_7;
uniform sampler2D SPIRV_Cross_Combined_8;
uniform sampler2D SPIRV_Cross_Combined_9;
uniform sampler2D SPIRV_Cross_Combined_10;
uniform sampler2D SPIRV_Cross_Combined_11;
uniform sampler2DArray SPIRV_Cross_Combined_12;
uniform sampler2DArray SPIRV_Cross_Combined_13;

layout(location = 0) in vec2 _4;
layout(location = 0) out vec4 _5;
layout(location = 2) out vec4 _6;
layout(location = 3) out vec4 _7;
layout(location = 4) out vec4 _8;
layout(location = 1) out vec4 _9;

mat4 spvWorkaroundRowMajor(mat4 wrap) { return wrap; }

void main()
{
    vec4 _211 = vec4((_4.x * 2.0) - 1.0, 1.0 - (2.0 * _4.y), 0.0, 1.0);
    _211.z = textureLod(SPIRV_Cross_Combined, _4, 0.0).x;
    vec4 _220 = _211 * spvWorkaroundRowMajor(_11._m6);
    vec3 _224 = _220.xyz / vec3(_220.w);
    vec3 _225 = _224.xyz;
    vec4 _244 = vec4((_225 - _11._m11.xyz) + (_11._m11.xyz - _11._m21.xyz), 1.0) * spvWorkaroundRowMajor(_11._m15);
    vec2 _245 = vec4(gl_FragCoord.xy, _197, _197).xy;
    uvec2 _250 = uvec2(_245);
    vec3 _264;
    do
    {
        if (_13._m4.w == 0.0)
        {
            _264 = _11._m11.xyz - _225;
            break;
        }
        else
        {
            _264 = spvWorkaroundRowMajor(_11._m0)[2].xyz;
            break;
        }
        break; // unreachable workaround
    } while(false);
    float _274;
    vec2 _278;
    ivec2 _283;
    int _288;
    ivec2 _289;
    int _295;
    float _265 = dot(_264, _264);
    vec3 _268 = _264 * inversesqrt(isnan(9.9999999392252902907785028219223e-09) ? _265 : (isnan(_265) ? 9.9999999392252902907785028219223e-09 : max(_265, 9.9999999392252902907785028219223e-09)));
    vec2 _876;
    do
    {
        vec2 _271 = _224.xz;
        _274 = _22._m4.z;
        vec2 _275 = vec2(_274);
        _278 = _22._m4.xy;
        vec2 _279 = (_271 / _275) - _278;
        ivec2 _280 = ivec2(_279);
        _283 = _24._m3.xy;
        ivec2 _284 = _280 - _283;
        bvec2 _285 = greaterThanEqual(_280, ivec2(0));
        _288 = _22._m5.x;
        _289 = ivec2(_288);
        bvec2 _290 = lessThan(_280, _289);
        bvec2 _291 = bvec2(_285.x && _290.x, _285.y && _290.y);
        bvec2 _292 = greaterThanEqual(_284, ivec2(1));
        bvec2 _293 = bvec2(_291.x && _292.x, _291.y && _292.y);
        _295 = _24._m3.z;
        bvec2 _298 = lessThan(_284, ivec2(_295 - 1));
        bool _300 = all(bvec2(_293.x && _298.x, _293.y && _298.y));
        float _428;
        float _429;
        bool _430;
        if (_300)
        {
            int _306 = (_284.y * _295) + _284.x;
            uvec4 _317 = (_24._m0[clamp(_306 >> 2, 0, 63)] >> (uvec4(uint((_306 & 3) << 3)) & uvec4(31u))) & uvec4(255u);
            uint _327 = (((_317.w << 24u) | (_317.z << 16u)) | (_317.y << 8u)) | _317.x;
            uint _329 = (_327 >> 20u) & 1023u;
            float _330 = float(_329);
            vec2 _340 = (_279 * float(1u << (uint(_22._m6.x) & 31u))) * _22._m6.y;
            vec2 _341 = dFdx(_340);
            vec2 _342 = dFdy(_340);
            float _343 = dot(_341, _341);
            float _344 = dot(_342, _342);
            float _345 = _22._m6.x - _330;
            float _349 = (0.5 * log2(isnan(_344) ? _343 : (isnan(_343) ? _344 : max(_343, _344)))) - _345;
            float _353 = (0.5 * log2(isnan(_344) ? _343 : (isnan(_343) ? _344 : min(_343, _344)))) - _345;
            vec2 _354 = fract(_279);
            bvec2 _355 = greaterThanEqual(_284, ivec2(0));
            bvec2 _356 = bvec2(_291.x && _355.x, _291.y && _355.y);
            bvec2 _358 = lessThan(_284, ivec2(_295));
            bool _360 = all(bvec2(_356.x && _358.x, _356.y && _358.y));
            vec4 _393;
            bool _394;
            if (_360)
            {
                float _365 = float(1u << (_329 & 31u));
                vec4 _388 = roundEven(textureLod(SPIRV_Cross_Combined_1, (clamp(_354 * _365, vec2(0.5), vec2(_365 - 0.5)) + vec2(float(_327 & 1023u), float((_327 >> 10u) & 1023u))) * _22._m6.w, floor(clamp(mix(_349, _353, 0.449999988079071044921875), 0.0, _330))) * 255.0);
                _393 = _388;
                _394 = !all(greaterThan(_388.xyz, vec3(254.0)));
            }
            else
            {
                _393 = vec4(0.0);
                _394 = false;
            }
            bool _395 = _360 && _394;
            float _424;
            if (_395)
            {
                _424 = textureLod(SPIRV_Cross_Combined_2, ((clamp(fract(_354 * exp2(_22._m6.x - _393.z)) * _22._m6.y, vec2(0.5), vec2(_22._m6.y - 0.5)) + vec2(_22._m16)) + (_393.xy * _22._m15)) * _22._m6.z, 0.0).z;
            }
            else
            {
                _424 = 1.0;
            }
            _428 = _353;
            _429 = _349;
            _430 = _300 && (_395 && (_424 > 0.0));
        }
        else
        {
            _428 = 0.0;
            _429 = 0.0;
            _430 = _300;
        }
        if (!_430)
        {
            _876 = _271;
            break;
        }
        vec2 _437 = clamp(_279, vec2(0.0), vec2(float(_288) - 9.9999997473787516355514526367188e-05));
        ivec2 _438 = ivec2(_437);
        int _439 = _438.x;
        int _440 = _438.y;
        int _443 = (_439 | (_439 << 4)) & 3855;
        int _446 = (_443 | (_443 << 2)) & 13107;
        int _452 = (_440 | (_440 << 4)) & 3855;
        int _455 = (_452 | (_452 << 2)) & 13107;
        int _460 = ((_446 | (_446 << 1)) & 21845) | (((_455 | (_455 << 1)) & 21845) << 1);
        uvec4 _471 = (_24._m1[clamp(_460 >> 2, 0, 1023)] >> (uvec4(uint((_460 & 3) << 3)) & uvec4(31u))) & uvec4(255u);
        uint _481 = (((_471.w << 24u) | (_471.z << 16u)) | (_471.y << 8u)) | _471.x;
        int _484 = int((_481 >> 16u) & 255u);
        ivec2 _486 = ivec2(_484) & ivec2(31);
        int _501 = int(_481 & 65535u) - 1;
        vec2 _536 = (textureLod(SPIRV_Cross_Combined_3, ((((((_437 - vec2((_438 >> _486) << _486)) / vec2(float(1 << (_484 & 31)))).xyxy * _22._m0.xxyy) + (vec2(float(_501 & (_22._m5.y - 1)), float(_501 >> (_22._m5.z & 31))) * _22._m4.w).xyxy) + _22._m1.xxyy) * vec2(1.0, _22._m14).xyxy).xy, 0.0).xy * 2.0) - vec2(1.0);
        float _540 = 1.0 - dot(vec2(1.0), abs(_536));
        vec3 _542 = vec3(_536.x, _540, _536.y);
        vec3 _554;
        if (_540 < 0.0)
        {
            vec2 _552 = (vec2(1.0) - abs(_542.zx)) * mix(vec2(-1.0), vec2(1.0), greaterThanEqual(_542.xz, vec2(0.0)));
            _554 = vec3(_552.x, _542.y, _552.y);
        }
        else
        {
            _554 = _542;
        }
        vec3 _555 = normalize(_554);
        vec3 _557 = normalize(cross(_555, vec3(0.0, 0.0, 1.0)));
        vec3 _558 = cross(_557, _555);
        vec3 _563 = normalize(vec3(dot(_268, _557), dot(_268, _558), dot(_268, _555)));
        float _566 = _563.z;
        vec2 _569 = ((-_563.xy) / vec2(_566)) * 0.300000011920928955078125;
        float _570 = _569.x;
        vec3 _575 = (_557 * _570) + (_558 * _569.y);
        vec3 _576 = vec3(_575.x, _575.z, vec3(_570, _569.y, -1.0).z);
        vec2 _577 = _575.xz;
        float _583 = length(_577);
        vec3 _585;
        float _592;
        _585 = vec3(_271 - (_577 * 0.5), 1.0);
        _592 = 0.0;
        vec3 _586;
        bool _589;
        float _593;
        bool _723;
        bool _588 = true;
        uint _590 = 0u;
        for (;;)
        {
            if ((_590 < 8u) && _588)
            {
                vec2 _600 = (_585.xy / _275) - _278;
                ivec2 _601 = ivec2(_600);
                vec2 _602 = fract(_600);
                ivec2 _603 = _601 - _283;
                bvec2 _604 = greaterThanEqual(_601, ivec2(0));
                bvec2 _605 = lessThan(_601, _289);
                bvec2 _606 = bvec2(_604.x && _605.x, _604.y && _605.y);
                bvec2 _607 = greaterThanEqual(_603, ivec2(0));
                bvec2 _608 = bvec2(_606.x && _607.x, _606.y && _607.y);
                bvec2 _610 = lessThan(_603, ivec2(_295));
                bool _612 = all(bvec2(_608.x && _610.x, _608.y && _610.y));
                vec4 _673;
                bool _674;
                if (_612)
                {
                    int _618 = (_603.y * _295) + _603.x;
                    uvec4 _629 = (_24._m0[clamp(_618 >> 2, 0, 63)] >> (uvec4(uint((_618 & 3) << 3)) & uvec4(31u))) & uvec4(255u);
                    uint _639 = (((_629.w << 24u) | (_629.z << 16u)) | (_629.y << 8u)) | _629.x;
                    uint _641 = (_639 >> 20u) & 1023u;
                    float _645 = float(1u << (_641 & 31u));
                    vec4 _668 = roundEven(textureLod(SPIRV_Cross_Combined_1, (clamp(_602 * _645, vec2(0.5), vec2(_645 - 0.5)) + vec2(float(_639 & 1023u), float((_639 >> 10u) & 1023u))) * _22._m6.w, floor(clamp(mix(_429, _428, 0.449999988079071044921875), 0.0, float(_641)))) * 255.0);
                    _673 = _668;
                    _674 = !all(greaterThan(_668.xyz, vec3(254.0)));
                }
                else
                {
                    _673 = vec4(0.0);
                    _674 = false;
                }
                bool _675 = _612 && _674;
                float _709;
                float _710;
                if (_675)
                {
                    vec4 _706 = textureLod(SPIRV_Cross_Combined_2, ((clamp(fract(_602 * exp2(_22._m6.x - _673.z)) * _22._m6.y, vec2(0.5), vec2(_22._m6.y - 0.5)) + vec2(_22._m16)) + (_673.xy * _22._m15)) * _22._m6.z, 0.0);
                    _709 = _706.x;
                    _710 = _706.z;
                }
                else
                {
                    _709 = 0.5;
                    _710 = 1.0;
                }
                _589 = _588 && (_675 && (_710 > 0.0));
                if ((_709 >= _585.z) || (!_589))
                {
                    _723 = _589;
                    break;
                }
                _593 = ((_585.z - _709) * _710) / (_710 + _583);
                _586 = _585 + (_576 * _593);
                _585 = _586;
                _588 = _589;
                _590++;
                _592 = _593;
                continue;
            }
            else
            {
                _723 = _588;
                break;
            }
        }
        vec3 _725 = _585 - (_576 * _592);
        vec3 _730 = _576 * (0.5 * (_725.z - _585.z));
        vec3 _733;
        vec3 _736;
        bool _738;
        _733 = _725 + _730;
        _736 = _730;
        _738 = _723;
        vec3 _737;
        bool _739;
        vec3 _734;
        for (uint _740 = 0u; (_740 < 3u) && _738; _733 = _734, _736 = _737, _738 = _739, _740++)
        {
            vec2 _748 = (_733.xy / _275) - _278;
            ivec2 _749 = ivec2(_748);
            vec2 _750 = fract(_748);
            ivec2 _751 = _749 - _283;
            bvec2 _752 = greaterThanEqual(_749, ivec2(0));
            bvec2 _753 = lessThan(_749, _289);
            bvec2 _754 = bvec2(_752.x && _753.x, _752.y && _753.y);
            bvec2 _755 = greaterThanEqual(_751, ivec2(0));
            bvec2 _756 = bvec2(_754.x && _755.x, _754.y && _755.y);
            bvec2 _758 = lessThan(_751, ivec2(_295));
            bool _760 = all(bvec2(_756.x && _758.x, _756.y && _758.y));
            vec4 _821;
            bool _822;
            if (_760)
            {
                int _766 = (_751.y * _295) + _751.x;
                uvec4 _777 = (_24._m0[clamp(_766 >> 2, 0, 63)] >> (uvec4(uint((_766 & 3) << 3)) & uvec4(31u))) & uvec4(255u);
                uint _787 = (((_777.w << 24u) | (_777.z << 16u)) | (_777.y << 8u)) | _777.x;
                uint _789 = (_787 >> 20u) & 1023u;
                float _793 = float(1u << (_789 & 31u));
                vec4 _816 = roundEven(textureLod(SPIRV_Cross_Combined_1, (clamp(_750 * _793, vec2(0.5), vec2(_793 - 0.5)) + vec2(float(_787 & 1023u), float((_787 >> 10u) & 1023u))) * _22._m6.w, floor(clamp(mix(_429, _428, 0.449999988079071044921875), 0.0, float(_789)))) * 255.0);
                _821 = _816;
                _822 = !all(greaterThan(_816.xyz, vec3(254.0)));
            }
            else
            {
                _821 = vec4(0.0);
                _822 = false;
            }
            bool _823 = _760 && _822;
            float _857;
            float _858;
            if (_823)
            {
                vec4 _854 = textureLod(SPIRV_Cross_Combined_2, ((clamp(fract(_750 * exp2(_22._m6.x - _821.z)) * _22._m6.y, vec2(0.5), vec2(_22._m6.y - 0.5)) + vec2(_22._m16)) + (_821.xy * _22._m15)) * _22._m6.z, 0.0);
                _857 = _854.x;
                _858 = _854.z;
            }
            else
            {
                _857 = 0.5;
                _858 = 1.0;
            }
            _739 = _738 && (_823 && (_858 > 0.0));
            _737 = _736 * 0.5;
            if (_857 < _733.z)
            {
                _734 = _733 + _737;
            }
            else
            {
                _734 = _733 - _737;
            }
        }
        if (_738)
        {
            _876 = mix(_271, _733.xy, vec2(smoothstep(0.07999999821186065673828125, 0.119999997317790985107421875, abs(_566)))).xy;
            break;
        }
        _876 = _271;
        break;
    } while(false);
    vec3 _880 = vec3(_876.x, _224.y, _876.y);
    vec3 _881 = dFdx(_880);
    vec3 _882 = dFdy(_880);
    float _883 = 1.0 / _274;
    vec2 _884 = _880.xz;
    vec2 _886 = (_884 * _883) - _278;
    vec2 _890 = vec2(_22._m5.xx) - vec2(9.9999999747524270787835121154785e-07);
    vec2 _891 = mix(mix(min(_886, _890), _890, isnan(_886)), _886, isnan(_890));
    vec2 _892 = mix(mix(max(vec2(0.0), _891), _891, isnan(vec2(0.0))), vec2(0.0), isnan(_891));
    ivec2 _893 = ivec2(_892);
    vec2 _894 = fract(_892);
    ivec2 _895 = _893 - _283;
    bvec2 _896 = greaterThanEqual(_893, ivec2(0));
    bvec2 _897 = lessThan(_893, _289);
    bvec2 _898 = bvec2(_896.x && _897.x, _896.y && _897.y);
    bvec2 _899 = greaterThanEqual(_895, ivec2(0));
    bvec2 _900 = bvec2(_898.x && _899.x, _898.y && _899.y);
    bvec2 _902 = lessThan(_895, ivec2(_295));
    bool _904 = all(bvec2(_900.x && _902.x, _900.y && _902.y));
    vec4 _1051;
    vec2 _1052;
    vec2 _1053;
    bool _1054;
    if (_904)
    {
        int _910 = (_895.y * _295) + _895.x;
        uvec4 _921 = (_24._m0[clamp(_910 >> 2, 0, 63)] >> (uvec4(uint((_910 & 3) << 3)) & uvec4(31u))) & uvec4(255u);
        uint _931 = (((_921.w << 24u) | (_921.z << 16u)) | (_921.y << 8u)) | _921.x;
        uint _933 = (_931 >> 20u) & 1023u;
        float _934 = float(_933);
        float _937 = float(1u << (_933 & 31u));
        vec2 _946 = _881.xz * _883;
        vec2 _948 = _882.xz * _883;
        float _957 = float(1u << (uint(_22._m6.x) & 31u)) * _22._m6.y;
        vec2 _958 = _946 * _957;
        vec2 _959 = _948 * _957;
        float _960 = dot(_958, _958);
        float _961 = dot(_959, _959);
        float _962 = _22._m6.x - _934;
        float _973 = floor(clamp(mix((0.5 * log2(isnan(_961) ? _960 : (isnan(_960) ? _961 : max(_960, _961)))) - _962, (0.5 * log2(isnan(_961) ? _960 : (isnan(_960) ? _961 : min(_960, _961)))) - _962, 0.449999988079071044921875), 0.0, _934));
        vec4 _988 = roundEven(textureLod(SPIRV_Cross_Combined_1, (floor(clamp(_894 * _937, vec2(0.5), vec2(_937 - 0.5)) + vec2(float(_931 & 1023u), float((_931 >> 10u) & 1023u))) + vec2(0.5)) * _22._m6.w, _973) * 255.0);
        int _994 = int(_250.x);
        int _996 = int(_250.y);
        int _999 = _24._m2.x - 1;
        int _1004 = _24._m2.y & 31;
        if (((_994 & _999) + ((_996 & _999) << _1004)) == _24._m3.w)
        {
            float _1012 = _988.z;
            int _1019 = int(clamp(clamp(clamp(_962 + _973, 0.0, _22._m6.x) - _1012, -1.0, 1.0) + _1012, _962, _22._m6.x));
            uvec2 _1026 = uvec2(_894 * exp2(_22._m6.x)) >> (uvec2(uint(_1019)) & uvec2(31u));
            _44._m0[(_24._m4.x + uint(((_994 >> _1004) + ((_996 >> _1004) * _24._m2.z)) << 2)) >> 2u] = (((2147483648u | uint(_1019 << 24)) | (uint(_910) << 16u)) | (_1026.y << 8u)) | _1026.x;
        }
        _1051 = _988;
        _1052 = _948;
        _1053 = _946;
        _1054 = !all(greaterThan(_988.xyz, vec3(254.0)));
    }
    else
    {
        _1051 = vec4(0.0);
        _1052 = vec2(0.0);
        _1053 = vec2(0.0);
        _1054 = false;
    }
    vec2 _1059 = clamp(_892, vec2(0.0), vec2(float(_288) - 9.9999997473787516355514526367188e-05));
    ivec2 _1060 = ivec2(_1059);
    int _1061 = _1060.x;
    int _1062 = _1060.y;
    int _1065 = (_1061 | (_1061 << 4)) & 3855;
    int _1068 = (_1065 | (_1065 << 2)) & 13107;
    int _1074 = (_1062 | (_1062 << 4)) & 3855;
    int _1077 = (_1074 | (_1074 << 2)) & 13107;
    int _1082 = ((_1068 | (_1068 << 1)) & 21845) | (((_1077 | (_1077 << 1)) & 21845) << 1);
    uvec4 _1093 = (_24._m1[clamp(_1082 >> 2, 0, 1023)] >> (uvec4(uint((_1082 & 3) << 3)) & uvec4(31u))) & uvec4(255u);
    uint _1103 = (((_1093.w << 24u) | (_1093.z << 16u)) | (_1093.y << 8u)) | _1093.x;
    int _1106 = int((_1103 >> 16u) & 255u);
    ivec2 _1108 = ivec2(_1106) & ivec2(31);
    vec2 _1117 = (_1059 - vec2((_1060 >> _1108) << _1108)) / vec2(float(1 << (_1106 & 31)));
    vec2 _1120 = vec2(1.0, _22._m14);
    int _1123 = int(_1103 & 65535u) - 1;
    vec2 _1137 = vec2(float(_1123 & (_22._m5.y - 1)), float(_1123 >> (_22._m5.z & 31))) * _22._m4.w;
    uint _1141 = uint(_1106) & 31u;
    float _1143 = float(_22._m11 >> _1141);
    float _1148 = float(_22._m12 << _1141);
    vec2 _1149 = _1117 * _1148;
    vec4 _1191 = (((_1117.xyxy * _22._m0.xxyy) + _1137.xyxy) + _22._m1.xxyy) * _1120.xyxy;
    vec4 _1196 = textureLod(SPIRV_Cross_Combined_3, _1191.xy, 0.0);
    vec2 _1199 = (_1196.xy * 2.0) - vec2(1.0);
    float _1200 = _1199.x;
    float _1202 = 1.0 - dot(_1199, _1199);
    float _1204 = sqrt(isnan(0.0) ? _1202 : (isnan(_1202) ? 0.0 : max(_1202, 0.0)));
    float _1205 = _1199.y;
    vec3 _1206 = vec3(_1200, _1204, _1205);
    float _1314;
    float _1315;
    float _1316;
    float _1317;
    float _1318;
    vec3 _1319;
    vec3 _1320;
    float _1321;
    if (_904 && _1054)
    {
        float _1231 = float(uint(exp2(_22._m6.x - _1051.z)));
        vec2 _1251 = ((clamp(fract(_894 * _1231) * _22._m6.y, vec2(0.5), vec2(_22._m6.y - 0.5)) + vec2(_22._m16)) + (_1051.xy * _22._m15)) * _22._m6.z;
        _1251.y = _1251.y * _22._m13;
        float _1258 = (_1231 * _22._m6.y) * _22._m6.z;
        vec2 _1265 = (_1053 * _1258) * _13._m17;
        vec2 _1266 = (_1052 * _1258) * _13._m17;
        vec4 _1268 = textureGrad(SPIRV_Cross_Combined_6, _1251, _1265, _1266);
        vec4 _1288;
        if (_22._m17 > 0.0)
        {
            vec4 _1282 = textureGrad(SPIRV_Cross_Combined_7, _1251, _1265, _1266);
            vec4 _1286 = textureGrad(SPIRV_Cross_Combined_8, _1251, _1265, _1266);
            _1288 = vec4(_1282.x, _1282.y, _1286.x, _1286.y);
        }
        else
        {
            _1288 = textureGrad(SPIRV_Cross_Combined_7, _1251, _1265, _1266);
        }
        vec4 _1292 = textureGrad(SPIRV_Cross_Combined_9, _1251, _1265, _1266);
        vec2 _1295 = (_1288.xy * 2.0) - vec2(1.0);
        float _1298 = 1.0 - dot(_1295, _1295);
        float _1308 = _1292.x;
        _1314 = _1308;
        _1315 = (_1288.w * 2.0) - 1.0;
        _1316 = _1292.w;
        _1317 = _1292.y;
        _1318 = _1288.z;
        _1319 = _1268.xyz;
        _1320 = vec3(_1295.x, sqrt(isnan(0.0) ? _1298 : (isnan(_1298) ? 0.0 : max(_1298, 0.0))), _1295.y);
        _1321 = clamp(_1268.w - _1308, 0.0, 1.0);
    }
    else
    {
        _1314 = 0.5;
        _1315 = 0.0;
        _1316 = 0.0;
        _1317 = _1196.z;
        _1318 = _1196.w;
        _1319 = textureLod(SPIRV_Cross_Combined_4, _1191.zw, 0.0).xyz;
        _1320 = _1206;
        _1321 = clamp(textureLod(SPIRV_Cross_Combined_5, ((_1137 + (((floor(_1149) + clamp(fract(_1149), vec2(0.5 / _1143), vec2((_1143 - 0.5) * (1.0 / _1143)))) / vec2(_1148)) * _22._m0.w)) + vec2(_22._m1.w)) * _1120, 0.0).w - 0.5, 0.0, 1.0);
    }
    vec3 _1388;
    float _1323 = clamp(_1321 * 2.17391300201416015625, 0.0, 1.0);
    vec3 _1326 = mix(_1319, _1319 * 0.64999997615814208984375, vec3(_1323));
    float _1327 = mix(_1318, 0.0, _1323);
    float _1329 = mix(_1317, _1317 * 0.89999997615814208984375, _1323);
    vec3 _1333 = mix(_1320, vec3(0.0, 1.0, 0.0), vec3((isnan(1.0) ? _1323 : (isnan(_1323) ? 1.0 : min(_1323, 1.0))) * 0.980000019073486328125));
    float _1338 = -dot(_1206, _880);
    uint _1340 = _250.x;
    uint _1342 = _250.y;
    vec4 _1349 = vec4((vec2(uvec2(_1340 + 1u, _1342)) + vec2(0.5)) * _13._m0.zw, 0.0, 1.0);
    vec2 _1352 = (_1349.xy * 2.0) - vec2(1.0);
    vec4 _1353 = vec4(_1352.x, _1352.y, _1349.z, _1349.w);
    _1353.y = -_1352.y;
    vec4 _1357 = _1353 * spvWorkaroundRowMajor(_11._m6);
    vec3 _1363 = (_1357.xyz / vec3(_1357.w)).xyz - _11._m11.xyz;
    vec4 _1371 = vec4((vec2(uvec2(_1340, _1342 + 1u)) + vec2(0.5)) * _13._m0.zw, 0.0, 1.0);
    vec2 _1374 = (_1371.xy * 2.0) - vec2(1.0);
    vec4 _1375 = vec4(_1374.x, _1374.y, _1371.z, _1371.w);
    _1375.y = -_1374.y;
    vec4 _1379 = _1375 * spvWorkaroundRowMajor(_11._m6);
    vec3 _1385 = (_1379.xyz / vec3(_1379.w)).xyz - _11._m11.xyz;
    vec3 _1400;
    bool _1401;
    do
    {
        _1388 = vec4(_1200, _1204, _1205, _1338).xyz;
        float _1389 = dot(_1363, _1388);
        if (_1389 == 0.0)
        {
            _1400 = vec3(0.0);
            _1401 = false;
            break;
        }
        float _1396 = (-(dot(_11._m11.xyz, _1388) + _1338)) / _1389;
        _1400 = _11._m11.xyz + (_1363 * _1396);
        _1401 = _1396 >= 0.0;
        break;
    } while(false);
    vec3 _1405;
    if (_1401)
    {
        _1405 = _1400 - _880;
    }
    else
    {
        _1405 = vec3(0.0);
    }
    vec3 _1419;
    bool _1420;
    do
    {
        float _1408 = dot(_1385, _1388);
        if (_1408 == 0.0)
        {
            _1419 = vec3(0.0);
            _1420 = false;
            break;
        }
        float _1415 = (-(dot(_11._m11.xyz, _1388) + _1338)) / _1408;
        _1419 = _11._m11.xyz + (_1385 * _1415);
        _1420 = _1415 >= 0.0;
        break;
    } while(false);
    vec3 _1424;
    if (_1420)
    {
        _1424 = _1419 - _880;
    }
    else
    {
        _1424 = vec3(0.0);
    }
    float _1425 = length(_1405);
    float _1426 = length(_1424);
    float _1431 = log2(1.0 / ((0.300000011920928955078125 * (isnan(_1426) ? _1425 : (isnan(_1425) ? _1426 : max(_1425, _1426)))) + 6.103515625e-05));
    vec2 _1435 = exp2(vec2(floor(_1431), ceil(_1431)));
    vec3 _1438 = floor(_880 * _1435.x);
    uvec2 _1440 = floatBitsToUint(_1438.xy);
    uint _1445 = (_1440.x * 374761393u) + (_1440.y * 668265263u);
    uint _1448 = (_1445 ^ (_1445 >> 13u)) * 1274126177u;
    uvec2 _1455 = floatBitsToUint(vec2(float(_1448 ^ (_1448 >> 16u)) * 2.3283064365386962890625e-10, _1438.z));
    uint _1460 = (_1455.x * 374761393u) + (_1455.y * 668265263u);
    uint _1463 = (_1460 ^ (_1460 >> 13u)) * 1274126177u;
    vec3 _1470 = floor(_880 * _1435.y);
    uvec2 _1472 = floatBitsToUint(_1470.xy);
    uint _1477 = (_1472.x * 374761393u) + (_1472.y * 668265263u);
    uint _1480 = (_1477 ^ (_1477 >> 13u)) * 1274126177u;
    uvec2 _1487 = floatBitsToUint(vec2(float(_1480 ^ (_1480 >> 16u)) * 2.3283064365386962890625e-10, _1470.z));
    uint _1492 = (_1487.x * 374761393u) + (_1487.y * 668265263u);
    uint _1495 = (_1492 ^ (_1492 >> 13u)) * 1274126177u;
    float _1500 = fract(_1431);
    float _1501 = mix(float(_1463 ^ (_1463 >> 16u)) * 2.3283064365386962890625e-10, float(_1495 ^ (_1495 >> 16u)) * 2.3283064365386962890625e-10, _1500);
    float _1502 = 1.0 - _1500;
    float _1503 = isnan(_1502) ? _1500 : (isnan(_1500) ? _1502 : min(_1500, _1502));
    float _1504 = 1.0 - _1503;
    float _1508 = (2.0 * _1503) * _1504;
    float _1513 = 1.0 - _1501;
    vec3 _1519 = step(vec3(_1501), vec3(_1503, _1504, 1.0));
    float _1526 = clamp(dot(_1519 * (vec3(1.0) - vec3(0.0, _1519.xy)), vec3((_1501 * _1501) / _1508, (_1501 - (0.5 * _1503)) / _1504, 1.0 - ((_1513 * _1513) / _1508))), 0.0, 1.0);
    vec3 _1527 = abs(_1206);
    vec3 _1528 = _1527 * _1527;
    vec3 _1529 = _1528 * _1528;
    vec3 _1530 = _1529 * _1529;
    vec3 _1538 = _1530 / vec3(((_1530.x + _1530.y) + _1530.z) + 6.103515625e-05);
    float _1539 = _1538.x;
    vec3 _1544 = step(vec3(_1526), vec3(_1539, _1539 + _1538.y, 1.0));
    vec3 _1549 = _1544 * (vec3(1.0) - vec3(0.0, _1544.xy));
    float _1551 = _1549.x;
    float _1553 = _1549.y;
    float _1557 = _1549.z;
    vec3 _1576 = cross(_1206, vec3(0.0, 0.0, 1.0));
    vec2 _1579 = ((((_1117 * _22._m9.x) + _1137) + vec2(_22._m9.y)) * _1120) * _22._m8.xy;
    vec2 _1582 = floor(_1579 - vec2(0.5)) + vec2(0.5);
    vec2 _1584 = _1579 - _1582;
    vec2 _1585 = vec2(1.0) - _1584;
    float _1586 = _1585.x;
    float _1587 = _1585.y;
    float _1588 = _1586 * _1587;
    float _1593 = _1588 + (_1584.x * _1587);
    vec4 _1597 = step(vec4(_1526), vec4(_1588, _1593, _1593 + (_1586 * _1584.y), 1.0));
    uint _1605 = uint(dot(_1597 * (vec4(1.0) - vec4(0.0, _1597.xyz)), vec4(0.0, 1.0, 2.0, 3.0)));
    uvec2 _1621 = uvec2(floor((textureLod(SPIRV_Cross_Combined_10, _22._m8.zw * (_1582 + vec2(float(_1605 & 1u), float(_1605 >> 1u))), 0.0).xy * 255.5) * vec2(0.25)));
    vec4 _1631 = textureLod(SPIRV_Cross_Combined_11, _1191.zw, 0.0);
    float _1632 = _1631.w;
    float _1633 = _1632 * _1632;
    float _1639 = _26._m1[_1621.y].x * _22._m3.y;
    vec2 _1644 = ((((_880.zy * _1551) + (_884 * _1553)) + (_880.xy * _1557)) * _1639) + vec2(_26._m1[_1621.y].z);
    vec4 _1645 = vec4(((_1405.zy * _1551) + (_1405.xz * _1553)) + (_1405.xy * _1557), ((_1424.zy * _1551) + (_1424.xz * _1553)) + (_1424.xy * _1557)) * _1639;
    uint _1647 = uint(floatBitsToInt(_26._m1[_1621.y].y));
    vec4 _1677;
    vec2 _1678;
    SPIRV_CROSS_BRANCH
    if (((_1647 >> 13u) & 1u) == 0u)
    {
        vec4 _1656 = _1645 * 0.5;
        vec4 _1660 = vec4(_22._m10.z);
        uint _1663 = (_1647 >> 11u) & 3u;
        _1677 = mix(mix(min(_1656, _1660), _1660, isnan(_1656)), _1656, isnan(_1660));
        _1678 = clamp(fract(_1644) * 0.5, _22._m10.xx, _22._m10.yy) + (vec2(float(_1663 & 1u), float(_1663 >> 1u)) * 0.5);
    }
    else
    {
        _1677 = _1645;
        _1678 = _1644;
    }
    vec3 _1683 = vec3(_1678, float((_1647 >> 6u) & 31u));
    vec4 _1687 = textureGrad(SPIRV_Cross_Combined_12, _1683, _1677.xy, _1677.zw);
    vec4 _1691 = textureGrad(SPIRV_Cross_Combined_13, _1683, _1677.xy, _1677.zw);
    vec4 _1717 = (vec4(0.0, _1691.w, _1687.w, _1691.z) * _26._m4[_1621.y]) + _26._m3[_1621.y];
    vec2 _1723 = ((_1691.xy * 2.0) - vec2(1.0)).xy;
    float _1727 = sqrt(1.0 - clamp(dot(_1723, _1723), 0.0, 1.0));
    vec2 _1729 = _1723 * _26._m0[_1621.y].w;
    float _1740 = roundEven(_26._m3[_1621.y].x * 255.0);
    float _1749 = 1.0 - clamp(_1204, 0.0, 1.0);
    float _1752 = clamp(mix(-3.0, 4.0, 5.0 * _1749), 0.0, 1.0);
    float _1755 = clamp(mix(-0.20000000298023223876953125, 1.2000000476837158203125, 0.89999997615814208984375 * _1749), 0.0, 1.0);
    vec3 _1756 = vec3(_1755);
    vec2 _1764 = vec2(_1314, mix(_1314, _1717.z, _1755));
    vec2 _1766 = (_1764 * _1764) * _1764;
    vec2 _1772 = vec2(_1766.x * (1.0 - _1752), _1766.y * _1752);
    float _1773 = dot(_1772, vec2(1.0));
    vec2 _1776 = _1772 / vec2(isnan(6.103515625e-05) ? _1773 : (isnan(_1773) ? 6.103515625e-05 : max(_1773, 6.103515625e-05)));
    float _1777 = _1776.y;
    vec3 _1778 = vec3(_1777);
    vec3 _1779 = mix(_1326, mix(_1326, (_1687.xyz * _26._m2[_1621.y].xyz) + ((mix(_1631.xyz, _26._m0[_1621.y].xyz, vec3(1.0 - _1633)) * _1633) - (_26._m0[_1621.y].xyz * _1633)), _1756), _1778);
    uint _1787 = uint(_28._m6);
    vec2 _1807 = (((_245 * _13._m0.zw) * 2.0) - vec2(1.0)) + (_13._m9.zw * 2.0);
    float _1813 = _244.w;
    vec2 _1817 = vec2(_1807.x, -_1807.y) - (_244.xy / vec2(isnan(9.9999999392252902907785028219223e-09) ? _1813 : (isnan(_1813) ? 9.9999999392252902907785028219223e-09 : max(_1813, 9.9999999392252902907785028219223e-09))));
    _1817.y = -_1817.y;
    vec2 _1830 = ((sqrt(sqrt(abs(_1817 * 0.5))) * vec2(ivec2(sign(_1817)))) * 0.5) + vec2(0.5);
    vec4 _1831 = vec4(0.0);
    _1831.y = mix(_1329, mix(_1329, _1717.y, _1755), _1777);
    _1831.z = 0.0;
    vec3 _1833 = normalize(normalize(mix(_1333, normalize(mix(_1333, normalize(((_1576 * _1729.x) + (cross(_1576, _1206) * _1729.y)) + (_1206 * (isnan(_1727) ? 6.103515625e-05 : (isnan(6.103515625e-05) ? _1727 : max(6.103515625e-05, _1727))))), _1756)), _1778)));
    vec2 _1838 = _1833.xz / vec2(dot(vec3(1.0), abs(_1833)));
    vec3 _1852;
    if (_1833.y <= 0.0)
    {
        vec2 _1850 = (vec2(1.0) - abs(_1838.yx)) * mix(vec2(-1.0), vec2(1.0), greaterThanEqual(_1838.xy, vec2(0.0)));
        _1852 = vec3(_1850.x, _1833.y, _1850.y);
    }
    else
    {
        _1852 = vec3(_1838.x, _1833.y, _1838.y);
    }
    vec2 _1855 = (_1852.xz * 0.5) + vec2(0.5);
    vec4 _1856 = vec4(_1855.x, _1855.y, vec4(0.0).z, vec4(0.0).w);
    _1856.z = mix(_1327, mix(_1327, _1717.w, _1755), _1777);
    _1831.w = float(_1787 / 4u) * 0.3333333432674407958984375;
    _1856.w = float(_1787 % 4u) * 0.3333333432674407958984375;
    vec4 _1866 = vec4(_1779.x, _1779.y, _1779.z, vec4(0.0).w);
    _1866.w = ((clamp(_1315, 0.0, 1.0) * _28._m5) + _28._m4) * (1.0 - clamp(abs((mix(_1316, mix(_1316, (_1740 == 19.0) ? 1.0 : ((_1740 == 15.0) ? 0.5 : 0.0), _1755), _1777) * 2.0) - 1.0), 0.0, 1.0));
    vec4 _1868 = vec4(_1830.x, _1830.y, vec4(0.0).z, vec4(0.0).w);
    _1868.z = 0.0;
    _1868.w = 0.0;
    _5 = vec4(0.0, 0.0, 0.0, 0.5);
    _6 = _1831;
    _7 = _1856;
    _8 = _1866;
    _9 = _1868;
}

