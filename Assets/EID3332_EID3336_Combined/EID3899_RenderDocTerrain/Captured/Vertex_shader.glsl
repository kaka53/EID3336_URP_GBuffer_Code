#version 450

layout(location = 0) out vec2 _4;

void main()
{
    float _24 = float((uint(gl_VertexID) << 1u) & 2u);
    float _26 = float(uint(gl_VertexID) & 2u);
    vec2 _29 = (vec2(_24, _26) * 2.0) - vec2(1.0);
    vec4 _32 = vec4(_29, 1.0, 1.0);
    _32.z = 0.0;
    _32.y = -_29.y;
    gl_Position = _32;
    _4 = vec2(_24, 1.0 - _26);
}

