shader_type canvas_item;

uniform vec4 ColorParameter : source_color = vec4(0.082269, 0.415209, 0.533856, 1.000000);


void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);  // Get the sprite's color
    if (tex_color.a < 0.1) {
        discard;  // Ignore fully transparent parts
    }
    
    // Apply effects only on visible parts
    COLOR = tex_color * ColorParameter;
}