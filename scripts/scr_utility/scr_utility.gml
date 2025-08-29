function draw_middle_center(_x, _y, _txt, _font = fnt_main_20, _color = c_white) {
	draw_set_font(_font);
	draw_set_color(_color);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	draw_text(_x, _y, _txt);

	draw_set_color(c_white)
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}

function draw_outline(_x, _y, _text, _font = fnt_main_20, _text_color = c_white) {
	var _outline_color = c_black;
	var _outline_thickness = 1; 
	
	draw_set_font(_font);
	draw_set_color(_outline_color);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	// Draw outline in multiple directions
	draw_text(_x - _outline_thickness, _y - _outline_thickness, _text); // Top-left
	draw_text(_x + _outline_thickness, _y - _outline_thickness, _text); // Top-right
	draw_text(_x - _outline_thickness, _y + _outline_thickness, _text); // Bottom-left
	draw_text(_x + _outline_thickness, _y + _outline_thickness, _text); // Bottom-right
	draw_text(_x - _outline_thickness, _y, _text); // Left
	draw_text(_x + _outline_thickness, _y, _text); // Right
	draw_text(_x, _y - _outline_thickness, _text); // Up
	draw_text(_x, _y + _outline_thickness, _text); // Down

	// Set the color for the main text and draw it on top
	draw_set_color(_text_color);
	draw_text(_x, _y, _text);
}

function draw_middle_center_outline(_x, _y, _text, _font = fnt_main_20, _text_color = c_white) {
	var _outline_color = c_black;
	var _outline_thickness = 1; 
	
	draw_set_font(_font);
	draw_set_color(_outline_color);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	// Draw outline in multiple directions
	draw_text(_x - _outline_thickness, _y - _outline_thickness, _text); // Top-left
	draw_text(_x + _outline_thickness, _y - _outline_thickness, _text); // Top-right
	draw_text(_x - _outline_thickness, _y + _outline_thickness, _text); // Bottom-left
	draw_text(_x + _outline_thickness, _y + _outline_thickness, _text); // Bottom-right
	draw_text(_x - _outline_thickness, _y, _text); // Left
	draw_text(_x + _outline_thickness, _y, _text); // Right
	draw_text(_x, _y - _outline_thickness, _text); // Up
	draw_text(_x, _y + _outline_thickness, _text); // Down

	// Set the color for the main text and draw it on top
	draw_set_color(_text_color);
	draw_text(_x, _y, _text);

	// Reset
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}

function array_full_copy(_array) {
	var _len = array_length(_array);
	var _response = array_create(_len, -1);
    array_copy(_response, 0, _array, 0, _len);
	
	return _response;
}

function array_index_of(arr, value) {
    var _size = array_length(arr);
    for (var i = 0; i < _size; i++) {
        if (arr[i] == value) {
            return i;
        }
    }
    return -1;
}