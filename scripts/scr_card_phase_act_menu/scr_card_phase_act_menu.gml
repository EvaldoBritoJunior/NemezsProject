function act_option(_name, _act_func, _act_args, _avail_func, _avail_args, _draw_func = undefined, _draw_args = []) constructor {
	name = _name;
	act_func = _act_func;
	act_args = _act_args;
	avail_func = _avail_func;
	avail_args = _avail_args;
	avail = _avail_func == undefined ? true : false;
	draw_func = _draw_func;
	draw_args = _draw_args;
}

function update_act_menu() {
	var _size = array_length(options_stack);
	options_array = options_stack[_size - 1];
	selected = undefined;
	rows = array_length(options_array);
	inv_y = 0;
	inv_y_max = rows * (cel_h + marg_y) - surface_h + marg_y;
	inventory = ds_grid_create(cols, rows);
	fill_grid(inventory);
}

function create_act_sub_menu(_card_inst, _options) {
	if(_card_inst.card_owner == card_owners.PLAYER) {
		// Store old options in array
		array_push(options_stack, _options);
		update_act_menu();
	} else {
		enemy_select_action(_options);
	}
}

function act_menu_go_back() {
	array_pop(options_stack);
	update_act_menu();
}

function end_act_menu(_card_inst) {
	if (_card_inst.card_owner = card_owners.PLAYER) {
		self.manager_inst.show_cards_when_over = true;
		self.return_func();
		instance_destroy(self);
	} else {
		self.return_func();
	}
}

function redo_act_menu(_card_inst) {
	if (_card_inst.card_owner = card_owners.PLAYER) {
		self.manager_inst.show_cards_when_over = true;
		self.redo_func();
		instance_destroy(self);
		
	} else {
		self.return_func();
	}
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

function check_any_avail(_, _act_args) {
	var any_avail = false;
	var e = -1;
	for (var i = 0; i < array_length(_act_args); i++) {
		e = _act_args[i];
		
		if (e.avail_func == undefined) continue; 
		else if (e.avail_args != undefined) e.avail = script_execute_ext(e.avail_func, e.avail_args);
		else e.avail_func();
		
		if (e.avail) any_avail = true;
	}
	return any_avail;
}