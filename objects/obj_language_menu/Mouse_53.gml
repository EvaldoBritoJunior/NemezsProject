if (check_point_over_surface()) {
	if (selected != undefined) {
		global.language = selected;
	}
}

enable_buttons(global.array_options_screen_buttons, true);
instance_destroy();