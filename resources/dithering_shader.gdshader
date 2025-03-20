shader_type canvas_item;

uniform vec4 ColorParameter : source_color = vec4(0.082269, 0.415209, 0.533856, 1.000000);
uniform float dither_threshold : hint_range(0.0, 1.0) = 0.5;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);  // Get the sprite's color
    if (tex_color.a < 0.1) {
        discard;  // Ignore fully transparent parts
    }

	ivec2 screen_pos = ivec2(FRAGCOORD.xy); // Get least significant bit
    float checker_pattern = float((screen_pos.x & 1) ^ (screen_pos.y & 1 )); // XOR for checkerboard

    // Discard pixels based on threshold
    if (checker_pattern > dither_threshold) {
        discard;
    }
    // Apply effects only on visible parts
    COLOR = tex_color * ColorParameter;
}