shader_type canvas_item;

uniform vec4 replace_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform vec4 replacement_color = vec4(0.0, 1.0, 0.0, 1.0);

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    if (color == replace_color) {
        color = replacement_color;
    }
    COLOR = color;
}