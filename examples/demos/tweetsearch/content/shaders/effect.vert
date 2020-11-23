#version 440

layout(location = 0) in vec4 qt_Vertex;
layout(location = 1) in vec2 qt_MultiTexCoord0;
layout(location = 0) out vec2 qt_TexCoord0;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float delta;
    float h;
    float factor;
};


void main() {
    vec4 pos = qt_Vertex;
    if (qt_MultiTexCoord0.y == 0.0)
        pos.x += factor * (1. - delta) * (qt_MultiTexCoord0.x * -2.0 + 1.0);
    else if (qt_MultiTexCoord0.y == 1.0)
        pos.x += factor * (delta) * (qt_MultiTexCoord0.x * -2.0 + 1.0);
    else
        pos.y = delta * h;
    gl_Position = qt_Matrix * pos;
    qt_TexCoord0 = qt_MultiTexCoord0;
}
