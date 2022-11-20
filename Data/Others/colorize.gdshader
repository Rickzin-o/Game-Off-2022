shader_type canvas_item;

uniform bool colorized = false;
uniform vec4 color: hint_color = vec4(1, 1, 1, 1);
uniform float mix_weight = 1;

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	if (colorized) {
		vec3 colorized_texture_rgb = mix(texture_color.rgb, color.rgb, mix_weight);
		COLOR = vec4(colorized_texture_rgb, texture_color.a);
	} else {
		COLOR = texture_color
	}
}