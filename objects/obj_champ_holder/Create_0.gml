mouse_over = false;
data = global.card_phase_data;

#region Utility Functions

update_sprite = function() {
	var _card_instance = 
		card_owner == card_owners.PLAYER ? data.player_champs[field_position] 
			: data.enemy_champs[field_position];
	
	if (_card_instance == noone) {
		sprite_index = -1;
	} else if (field_position == 0){
		sprite_index = _card_instance.card.spr_card_art;
	} else {
		sprite_index = _card_instance.card.spr_cut_card_art;
	}
}

update_card_instance = function(_card_instance) {
	// Set card
	if (card_owner == card_owners.PLAYER) {
		data.player_champs[field_position] = _card_instance;
	} else {
		data.enemy_champs[field_position] = _card_instance;
	}
	update_sprite();
}

draw_card = function() {
	var layer_id = layer_get_id("Instances_above");
	var _card_instance = 
		card_owner == card_owners.PLAYER ? data.player_champs[field_position] 
			: data.enemy_champs[field_position];
	var _sprite = -1;
	
	if (_card_instance != noone) {
		if (card_owner == card_owners.PLAYER){
			draw_champ_card_instance(_card_instance, x + 230, room_height / 2);
		} else {
			draw_champ_card_instance(_card_instance, x - 230, room_height / 2);
		}
	}
}

draw_stats = function() {
	var _card_instance = 
		card_owner == card_owners.PLAYER ? data.player_champs[field_position] 
			: data.enemy_champs[field_position];
	if (_card_instance != noone) {
		var _vanguard = field_position == card_positions.VANGUARD;
		var _card = _card_instance.card;
		var _w = sprite_width;
		var _h = sprite_height;
		var _hp = _card_instance.hp;
		var _max = _card.hp;
		var _fnt = _vanguard ? fnt_main_30 : fnt_main_20;
		
		var _x1 = x - (_w * 0.35);
		var _y1 = y - (_h * 0.48);
		
		var _x1_hp = _vanguard ? _x1 - 41 : _x1 - 28;
		var _y1_hp = _vanguard ? _y1 + 27 : _y1 + 20;
		var _x2_hp = _vanguard ? _x1 + 37 : _x1 + 23;
		var _y2_hp = _vanguard ? _y1 + 34 : _y1 + 25;


		draw_middle_center_outline(_x1, _y1, _card_instance.hp, _fnt);
		draw_healthbar(_x1_hp, _y1_hp, _x2_hp, _y2_hp, 100 * _hp / _max, 
		c_black, c_red, c_lime, 0, true, true);

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
	var _this = self;
	if (card_owner == card_owners.PLAYER){
		instance_create_layer(640, 360, "Instances_above", obj_select_card_menu,
		{
			manager_inst: _this.manager_inst,
			draw_cut_func: global.draw_champ_cut_card,
			draw_func: global.draw_champ_card,
			return_func: _this.fin_init_step,
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