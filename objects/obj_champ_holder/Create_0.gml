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

fin_init_step = function(_array_response) {
	var _selected_card = _array_response[0]
	update_card_instance(new champ_instance(_selected_card));
	alarm[0] = 20;
}

start_init_step = function() {
	if (card_owner == card_owners.PLAYER){
		instance_create_layer(640, 360, "Instances_above", obj_select_card_menu,
		{
			father_obj: self,
			return_func: self.fin_init_step,
			card_array: global.champ_cards,
			select_amount: 1,
			title: get_position_name(field_position)
		});
	} else {
		fin_init_step(global.champ_cards);
	}
}