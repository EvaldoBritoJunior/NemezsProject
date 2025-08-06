global.array_options_screen_buttons = [obj_input_name, obj_button_language, obj_button_end_options]

function enable_buttons(_array, _enable) {
	for (var i = 0; i < array_length(_array); i++) {
		var button = _array[i];
		button.enabled = _enable;
	}
}