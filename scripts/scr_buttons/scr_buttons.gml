global.array_options_screen_buttons = [obj_input_name, obj_button_language]

global.draw_middle_center = function(_x, _y, _txt) {
	draw_set_font(fnt_main);

	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	draw_text(_x, _y, _txt);

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}

global.enable_buttons = function (_array, _enable) {
	for (var i = 0; i < array_length(_array); i++) {
		var button = _array[i];
		button.enabled = _enable;
	}
}