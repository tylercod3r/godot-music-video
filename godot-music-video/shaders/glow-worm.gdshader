// overview:  apply to a sphere, and get a glowing worm!

shader_type spatial;

void vertex() {
	// Called for every vertex the material is visible on.
	VERTEX.y += sin(TIME * 5.0 + VERTEX.x * 10.0 ) * 0.2;
	VERTEX.x += VERTEX.x * 5.0;
}

void fragment() {
	//// cool fx #1
	//if (UV.x > 0.5){
		//ALBEDO = vec3(0, 0.2, 1);
		//ROUGHNESS = 1.0;
		//RIM = 1.0;
	//}else{
		//ALBEDO = vec3(1, 0.2, 1);
		//ROUGHNESS = 0.2;
		//RIM = 1.0;
	//}

	// cool fx #2
	vec3 color;
	color.r = sin(TIME * 5.0 + VERTEX.x) + 1.0;
	color.g = sin(TIME * 6.0 + VERTEX.x) + 1.0;
	color.b = sin(TIME * 7.0 + VERTEX.x) + 1.0;
	ALBEDO = color;
	ROUGHNESS = 0.2;
	RIM = 1.0;

}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
