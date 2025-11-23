shader_type canvas_item;

instance uniform float weight = 0.0;
instance uniform bool invert = false;

void fragment() {
	if (invert) {
		vec4 color = texture(TEXTURE, UV);
		float alpha = color.a * (sin(TIME * 4.4)*0.4 + 0.6);
		COLOR = vec4(1.0 - color.rgb, alpha);
	}
	
	if (UV.x > weight) {
		COLOR.a = 0.0;
	}
}