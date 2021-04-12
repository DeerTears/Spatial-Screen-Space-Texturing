shader_type spatial;
render_mode unshaded;
// Renders a tileable 2D texture to screen, using spatial polygons as a mask.
// Remove blur from textures by unchecking "Detect 3D" and "Filter" in Import.
// Demo: https://github.com/DeerTears/Polygon-Mask-for-2D-Textures/

uniform sampler2D tiling_texture;
uniform float tiling_scale = 1.0;
const float DEFAULT_SCALE = 8.0;

void fragment() {
	vec2 uv = FRAGCOORD.xy;
	vec2 tiling_uv = uv / (DEFAULT_SCALE * tiling_scale * -1.0);
	vec4 texture_result = texture(tiling_texture, tiling_uv);
	ALBEDO = texture_result.rgb;
	ALPHA = texture_result.a;
}
