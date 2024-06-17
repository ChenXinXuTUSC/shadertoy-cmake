#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec2 aTexCoord;

out vec4 vtxCoord;
out vec2 texCoord;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

void main()
{
	vtxCoord = projection * view * model * vec4(aPos, 1.0);
	texCoord = vec2(aTexCoord.x, aTexCoord.y);

	// muse send to pipe line
	gl_Position = vtxCoord;
}
