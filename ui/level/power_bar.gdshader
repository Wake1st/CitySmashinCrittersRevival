shader_type canvas_item;

uniform vec4 background_color : source_color;
uniform vec4 foreground_color : source_color;
instance uniform float weight = 0.0;

void fragment() {
	if (UV.x < weight) {
		COLOR = foreground_color;
	} else {
		COLOR = background_color;
	}
}