shader_type canvas_item;

instance uniform float weight = 0.0;

void fragment() {
	if (UV.x > weight) {
		COLOR.a = 0.0;
	}
}