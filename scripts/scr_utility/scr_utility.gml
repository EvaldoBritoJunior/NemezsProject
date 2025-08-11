function draw_middle_center(_x, _y, _txt, _font = fnt_main_20, _color = c_white) {
	draw_set_font(_font);
	draw_set_color(_color)
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	draw_text(_x, _y, _txt);

	draw_set_color(c_white)
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}

function array_full_copy(_array) {
	var _len = array_length(_array);
	
	response = array_create(_len, -1);
    array_copy(response, 0, _array, 0, _len);
	
	return response;
}