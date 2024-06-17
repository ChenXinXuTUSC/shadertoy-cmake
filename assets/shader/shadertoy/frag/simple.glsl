#version 330 core

out vec4 fragColor;

in vec4 vtxCoord;
in vec2 texCoord;

uniform sampler2D texture1;

// other input
uniform float iTime;
uniform vec3  iResolution;

void main()
{   
    vec2 uv = vtxCoord.xy;

    vec3 col = 0.5 + 0.5 * cos(iTime + uv.xyx + vec3(0.0, 2.0, 4.0));
    fragColor = mix(
        texture(texture1, texCoord),
        vec4(col, 1.0),
        (1.0 + sin(iTime)) / 2.0
    );
}
