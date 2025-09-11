/// @description Act Redo

choice_draw_idx++;
if (choice_draw_idx < array_length(choice_draw_funcs)) {
	draw_choices = true;
	alarm[0] = 200;
} else {
	draw_choices = false;
	manager_inst.show_cards_when_over = true;
	redo_func();
}