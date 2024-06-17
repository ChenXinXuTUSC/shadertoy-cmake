#version 330 core

out vec4 fragColor;

in vec2 texCoord;
in vec4 vtxCoord;

in vec2  iResolution;
in float iTime;

uniform sampler2D screenTexture;

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
    vec2  U = (vtxCoord.xy + 0.5) * 800.0;
    vec2  R = vec2(800.0, 800.0);

    float n = noise(vec3(U*8./R.y, .1*iTime));
    float v = sin(6.28 * 10. * n);
    float t = iTime;

    v = smoothstep(1.,0., .5*abs(v)/fwidth(v));

    fragColor = mix(
        exp(-33.0/R.y) * texture(screenTexture, (U + vec2(1.0, sin(t))) / R),
        .5+.5*sin(12.*n+vec4(0,2.1,-2.1,0)),
        v
    );
} 
