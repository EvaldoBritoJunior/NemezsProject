if (show) {
	draw_self();
	draw_inventory_surface();

	draw_middle_center(1052, 55, title, fnt_main_30);

	if (selected != undefined) {
		draw_func(selected, 1052, room_height / 2);
	}
}

draw_buttons();