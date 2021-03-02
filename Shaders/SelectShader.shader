shader_type canvas_item;

uniform bool enabled;

void fragment() {
	if (enabled == true){
	vec4 curr_color = texture(TEXTURE,UV, 0.0).rgba;
	if (curr_color == vec4(0,0,0,0)){
		COLOR = curr_color;
	}else{
		curr_color.r = 1.0 - curr_color.r;
		curr_color.g = 1.0 - curr_color.g;
		curr_color.b = 1.0 - curr_color.b;
		COLOR.rgba = curr_color;
	}

}else{
	COLOR = texture(TEXTURE,UV);
}
}