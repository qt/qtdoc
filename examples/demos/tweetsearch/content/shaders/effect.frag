#version 440



layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(binding = 1) uniform sampler2D sourceA;
layout(binding = 2) uniform sampler2D sourceB;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float delta;
};

void main() {
    vec4 tex = vec4(qt_TexCoord0.x, qt_TexCoord0.y * 2.0, qt_TexCoord0.x, (qt_TexCoord0.y-0.5) * 2.0);
    float shade = clamp(delta*2.0, 0.5, 1.0);
    vec4 col;
    if (qt_TexCoord0.y < 0.5) {
        col = texture(sourceA, tex.xy) * (shade);
    } else {
        col = texture(sourceB, tex.zw) * (1.5 - shade);
        col.w = 1.0;
    }
    fragColor = col * qt_Opacity;
}
