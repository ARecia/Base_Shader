#version 330

in vec3 a_Position;
uniform vec4 u_Trans;

void main()
{
	vec4 newPosition;
	// u_Trans.w 로 스케일(크기)을 곱하고, u_Trans.xy 로 이동 적용
	newPosition.xy = (a_Position.xy * u_Trans.w) + u_Trans.xy;
	newPosition.z = a_Position.z;
	newPosition.w = 1.0;
	gl_Position = newPosition;
}