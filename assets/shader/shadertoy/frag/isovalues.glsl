#version 330 core

out vec4 fragColor;

in vec2 texCoord;
in vec4 vtxCoord;

// texture samplers
uniform sampler2D texture1;
uniform sampler2D texture2;

// other input
uniform float iTime;
uniform vec3  iResolution;

// default shader
// void main()
// {
// 	vec2 uv = vtxCoord.xy + 1.0;
//     vec3 color = 0.5 + 0.5 * cos(iTime + uv.xyx + vec3(0.0, 2.0, 4.0));

//     fragColor = vec4(color, 1.0);
// }

// user shader

float noise3( vec3 x ) {
    vec3 p = floor(x),f = fract(x);

    f = f*f*(3.-2.*f);  // or smoothstep     // to make derivative continuous at borders

#define hash3(p)  fract(sin(1e3*dot(p,vec3(1,57,-13.7)))*4375.5453)        // rand
    
    return mix( mix(mix( hash3(p+vec3(0,0,0)), hash3(p+vec3(1,0,0)),f.x),       // triilinear interp
                    mix( hash3(p+vec3(0,1,0)), hash3(p+vec3(1,1,0)),f.x),f.y),
                mix(mix( hash3(p+vec3(0,0,1)), hash3(p+vec3(1,0,1)),f.x),       
                    mix( hash3(p+vec3(0,1,1)), hash3(p+vec3(1,1,1)),f.x),f.y), f.z);
}

#define noise(x) (noise3(x)+noise3(x+11.5)) / 2. // pseudoperlin improvement from foxes idea 


void main()
{
	vec2 uv = vtxCoord.xy;
    
    float n = noise(vec3(uv * 8.0, 0.1 * iTime));
    float v = sin(6.28*10.*n);
    float t = iTime;

    v = smoothstep(1.,0., .5*abs(v)/fwidth(v));

    fragColor = mix(
        exp(-0.1) * texture(texture1, uv + vec2(1.0, sin(t) * 10.0)),
        0.5 + 0.5 * sin(12.0 * n + vec4(0, 2.1, -2.1, 0)),
        v
    );
}
