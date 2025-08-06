#region Variables

data = global.card_phase_data;
default_background = spr_field_default;
objects_step_order = array_create(global.champ_qty * 2, noone);
instances_positions = [
	//  Player      Enemy
		[420, 360], [859, 360],		// Vanguard
		[101, 227], [1179, 227],	// Rear I
		[101, 360], [1179, 360],	// Rear II
		[101, 492], [1179, 492]		// Rear III
	];
	
#endregion

#region Utility Functions

draw_data = function () {
	draw_set_font(fnt_main_20);

	//draw_text(x, y, $"({mouse_x},{mouse_y})");

	#region Player data
	draw_text(10, 620, global.player_data.name); // Name

	draw_set_font(fnt_main_30);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	draw_text(90, 687, 10); // Used gear
	draw_text(204, 687, 11); // Used magic

	#endregion

	#region Enemy data
	draw_text(1133, 75, 5);  // Used gear
	draw_text(1247, 75, 0);  // Used magic

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_font(fnt_main_20);
	
	draw_text(1055, 8, global.player_data.name);  // Name

	#endregion
}
	
stage_sort = function() {
	array_sort(objects_step_order, function(left, right) {
	    if (left.initiative_value < right.initiative_value)
	        return 1;
	    else if (left.initiative_value > right.initiative_value)
	        return -1;
	    else
	        return 0;
	});
}

init_stage_sort = function() {
	var _turn_owner = data.turn_owner;
	var _max_i = array_length(objects_step_order) - 1;
	var _initiative_value = -1;
	var _obj = -1;
	// set initiative values
	for (var _i = 0; _i <= _max_i; _i++) {
		_obj = objects_step_order[_i];
		_initiative_value = (floor(_max_i / 2) - _obj.field_position) * 10;
		if (_obj.owner == _turn_owner) {
			_initiative_value++;
		}
		_obj.initiative_value = _initiative_value;
	}
	
	stage_sort();
}

#endregion

#region Stage Functions

end_stage = function () {
	game_end();
}

init_stage_step = function() {
	current_step++;
	if (current_step < array_length(objects_step_order)) {
		objects_step_order[current_step].start_init_step();
	} else {
		end_stage();
	}
}
	
start_stage = function () {
	current_step = -1;
	var _this = self;
	if (data.turn_stage == card_phase_stages.INIT_STAGE) {
		// Decide first
		var _first = card_owners.ENEMY; // choose(card_owners.PLAYER, card_owners.ENEMY);
		data.turn_owner = _first;
		// Create instances + Assigne positions + Sort
		for (var _i = 0; _i < array_length(objects_step_order); _i++) {
			objects_step_order[_i] = instance_create_layer(
				instances_positions[_i][0], instances_positions[_i][1], "Instances", obj_champ_holder,
				{
				    owner : (_i % 2),
				    field_position : floor(_i / 2),
					manager_inst : _this
				});
		}
		
		init_stage_sort();
		
		// Call step function
		init_stage_step();
	} else if (data.turn_stage == card_phase_stages.ACT_STAGE) {
		
	} else if (data.turn_stage == card_phase_stages.END_STAGE) {
		
	} else {
		
	}
}

#endregion