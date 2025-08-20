mouse_over = false;

#region Utility Functions

update_sprite = function() {
	var _data = global.card_phase_data;
	var _card_instance = 
		card_owner == card_owners.PLAYER ? _data.player_champs[field_position] 
			: _data.enemy_champs[field_position];
	
	if (_card_instance == noone) {
		sprite_index = -1;
	} else if (field_position == 0){
		sprite_index = _card_instance.card.spr_card_art;
	} else {
		sprite_index = _card_instance.card.spr_cut_card_art;
	}
}

update_card_instance = function(_card_instance) {
	var _data = global.card_phase_data
	// Set card
	if (card_owner == card_owners.PLAYER) {
		_data.player_champs[field_position] = _card_instance;
	} else {
		_data.enemy_champs[field_position] = _card_instance;
	}
	update_sprite();
}

draw_card = function() {
	var _data = global.card_phase_data;
	var layer_id = layer_get_id("Instances_above");
	var _card_instance = 
		card_owner == card_owners.PLAYER ? _data.player_champs[field_position] 
			: _data.enemy_champs[field_position];
	var _sprite = -1;
	
	if (_card_instance != noone) {
		if (card_owner == card_owners.PLAYER){
			draw_champ_card_instance(_card_instance, x + 230, room_height / 2);
		} else {
			draw_champ_card_instance(_card_instance, x - 230, room_height / 2);
		}
	}
}

#endregion

#region Step Functions

fin_init_step = function(_array_response) {
	var _selected_card = _array_response[0];
	manager_inst.champ_card_selection_remove(_selected_card);
	// Feather ignore once GM1041
	update_card_instance(new champ_instance(_selected_card));
	alarm[0] = 20;
}

start_init_step = function(_card_array) {
	if (card_owner == card_owners.PLAYER){
		instance_create_layer(640, 360, "Instances_above", obj_select_card_menu,
		{
			manager_inst: self.manager_inst,
			draw_cut_func: global.draw_champ_cut_card,
			draw_func: global.draw_champ_card,
			return_func: self.fin_init_step,
			card_array: _card_array,
			select_amount: 1,
			title: get_position_name(field_position)
		});
	} else {
		fin_init_step(_card_array);
	}
}

#endregion

update_sprite();