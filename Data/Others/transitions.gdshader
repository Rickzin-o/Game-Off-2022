shader_type canvas_item;

uniform int transition_type = 0;
uniform vec4 color : hint_color = vec4(1, 1, 1, 1);
uniform float diamond_size: hint_range(0, 1) = 0;
uniform float blur_intensity: hint_range(0, 32) = 4.0;
uniform float min_pixel: hint_range(1, 256) = 1;
uniform float max_pixel: hint_range(1, 256) = 128;
uniform float process_value: hint_range(0, 1) = 0;


vec2 get_pixel_uv(vec2 uv, float x)
{
	uv = floor(uv * x + 0.5) / x;
	return uv;
}

vec4 fade_transition(vec4 txt, vec4 fade_color, float v)
{
	txt.rgb = mix(txt.rgb, fade_color.rgb, v);
	return txt;
}

vec4 diamond_transition(vec4 txt, vec4 fade_color, vec2 uv, vec2 fragcoord, float size, float v) {
	float diamondPixelSize = size;
	float xFraction = fract(fragcoord.x / diamondPixelSize);
	float yFraction = fract(fragcoord.y / diamondPixelSize);
    
	float xDistance = abs(xFraction - 0.5);
	float yDistance = abs(yFraction - 0.5);
    
	if (xDistance + yDistance + uv.y > v * 3f) {
		return txt;
	}
	return fade_color;
}

vec4 blur(vec2 uv, sampler2D source, float intensity)
{
	float s = 0.004f * intensity;
	vec4 result = vec4 (0);
	result += texture(source, uv + vec2(-s, -s));
	result += 2.0 * texture(source, uv + vec2(-s, 0));
	result += texture(source, uv + vec2(-s, s));
	result += 2.0 * texture(source, uv + vec2(0, -s));
	result += 4.0 * texture(source, uv);
	result += 2.0 * texture(source, uv + vec2(0, s));
	result += texture(source, uv + vec2(s, -s));
	result += 2.0 * texture(source, uv + vec2(s, 0));
	result += texture(source, uv + vec2(s, -s));
	result = result * 0.0625;
	return result;
}

void fragment() 
{
	vec4 txt = texture(TEXTURE, UV);
	vec4 output_color = txt;
	vec2 fragcoord = FRAGCOORD.xy;
	
//	output_color = diamond_transition(txt, color, UV, FRAGCOORD.xy, diamond_size, process_value);
	float diamondPixelSize = diamond_size;
	float xFraction = fract(fragcoord.x / diamondPixelSize);
	float yFraction = fract(fragcoord.y / diamondPixelSize);
    
	float xDistance = abs(xFraction - 0.5);
	float yDistance = abs(yFraction - 0.5);
    
	if (xDistance + yDistance + UV.y > process_value * 3f) {
		discard;
	}

	
	COLOR = output_color;
}
