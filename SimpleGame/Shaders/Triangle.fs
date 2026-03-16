#version 330

layout(location=0) out vec4 FragColor;
uniform vec4 u_Color;

void main()
{
	// 무조건 vec4(1) 대신 외부에서 받아온 색상 사용
	FragColor = u_Color;
}