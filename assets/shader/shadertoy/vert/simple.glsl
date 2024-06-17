#version 330 core

layout (location = 0) in vec2 aPos;
layout (location = 1) in vec2 aTexCoord;

out vec4 vtxCoord;
out vec2 texCoord;

void main()
{
    texCoord = aTexCoord;
    vtxCoord = vec4(aPos, 0.0, 1.0);
    gl_Position = vtxCoord;
}
