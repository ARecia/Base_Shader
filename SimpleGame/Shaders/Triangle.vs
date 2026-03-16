#version 330

in vec3 a_Position;

uniform float u_Time;

void sin1()
{
	vec4 newPosition;

	float t = u_Time * 2;
	newPosition.x = a_Position.x + t;
	newPosition.y = a_Position.y + 0.5 * sin(t * 2 * 3.141592);

	newPosition.z = 0.0;
	newPosition.w = 1.0;

	gl_Position = newPosition;
}

// 사각형이 원운동동하게 만들기
vec4 moveInCircle()
{
	vec4 newPosition;

	// u_Time에 곱하는 값으로 원을 도는 속도를 조절합니다.
	float theta = u_Time * 2.0; 

	// 반지름 설정: 1.0으로 하면 사각형이 화면 밖으로 절반쯤 나갑니다.
	// 사각형이 화면 모서리에 예쁘게 '접하도록' 하려면 크기(0.1)를 고려해 0.95 정도로 맞춥니다.
	float radius = 0.95; 

	// 원의 방정식 적용
	float offsetX = radius * cos(theta);
	float offsetY = radius * sin(theta);

	// VBO의 원래 정점 좌표에 원 궤도의 오프셋을 더해줍니다.
	// (기존 a_Position은 제자리에 유지한 상태에서 위치만 이동)
	newPosition.x = a_Position.x + offsetX;
	newPosition.y = a_Position.y + offsetY;
	
	newPosition.z = 0.0;
	newPosition.w = 1.0;

	return newPosition;
}

float bounce(float time, float limit, float speed)
{
	float t = time * speed;
	return abs(mod(t, limit * 4.0) - limit * 2.0) - limit;
}

// 핀볼 움직임을 처리하는 전용 함수
void pinball()
{
	vec4 newPosition;

	float limit = 0.9;
	float speedX = 1.3;
	float speedY = 1.7;

	newPosition.x = a_Position.x + bounce(u_Time, limit, speedX);
	newPosition.y = a_Position.y + bounce(u_Time, limit, speedY);
	newPosition.z = 0.0;
	newPosition.w = 1.0;

	// 최종 위치를 직접 할당
	gl_Position = newPosition;
}

void main()
{
	// 메인 함수는 깔끔하게 호출만 담당
	pinball();
}

