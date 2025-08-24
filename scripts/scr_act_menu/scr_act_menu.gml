function act_option(_name, _act_func, _act_args, _avail_func, _avail_args, _draw_func = function(){}, _draw_args = [-1]) constructor {
	name = _name;
	act_func = _act_func;
	act_args = _act_args;
	avail_func = _avail_func;
	avail_args = _avail_args;
	avail = true;
	draw_func = _draw_func;
	draw_args = _draw_args;
}

function update_act_menu() {
	var _size = array_length(options_stack);
	options_array = options_stack[_size - 1];
	selected = noone;
	rows = array_length(options_array);
	inv_y = 0;
	inv_y_max = rows * (cel_h + marg_y) - surface_h + marg_y;
	inventory = ds_grid_create(cols, rows);
	fill_grid(inventory);
}

function create_act_sub_menu(_options) {
	// Store old options in array
	array_push(options_stack, _options);
	update_act_menu();
}

function act_menu_go_back() {
	array_pop(options_stack);
	update_act_menu();
}

function act_menu_draw_champ(_card_inst) {
	draw_champ_card_instance(_card_inst, 410, 390);
}

function act_menu_draw_gear(_gear) {
	draw_gear_card(_gear, 410, 390);
}

function act_menu_draw_magic(_magic) {
	draw_magic_card(_magic, 410, 390);
}

function act_menu_draw_territory(_terr) {
	draw_territory_card(_terr, 410, 390);
}