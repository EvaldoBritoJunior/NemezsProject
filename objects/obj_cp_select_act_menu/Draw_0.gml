if (show) {
	draw_self();
	draw_inventory_surface();
	draw_scroll_arrow();
	if (selected == undefined) {
		draw_champ_card_instance(card_inst, 410, y + 30);
	} else if (selected.draw_func != undefined) {
		script_execute_ext(selected.draw_func, selected.draw_args);
	}
	draw_middle_center(x, 50, global.language.select_act_title, fnt_main_30)
}

draw_buttons();