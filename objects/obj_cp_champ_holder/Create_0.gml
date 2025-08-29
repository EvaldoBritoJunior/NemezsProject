// Inherit the parent event
event_inherited();

my_turn = false;

#region Utility Functions
update_sprite = function() {
	var _card_instance = 
		card_owner == card_owners.PLAYER ? data.player_champs[field_position] 
			: data.enemy_champs[field_position];
	card = _card_instance;
	
	if (_card_instance == undefined) {
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
	var _card_instance = card;
	var _w = sprite_width;
	
	if (_card_instance != undefined) {
		if (card_owner == card_owners.PLAYER){
			draw_champ_card_instance(_card_instance, x + _w, room_height / 2);
		} else {
			draw_champ_card_instance(_card_instance, x - _w, room_height / 2);
		}
	}
}

draw_stats = function() {
	var _card_instance = card;
	if (_card_instance != undefined) {
		var _vanguard = field_position == card_positions.VANGUARD;
		var _card = _card_instance.card;
		var _terr = data.current_territory;
		
		var _w = sprite_width;
		var _h = sprite_height;
		var _hp = _card_instance.hp.get_value();
		var _max = _card_instance.hp.get_max_value();
		var _fnt = _vanguard ? fnt_main_30 : fnt_main_20;
		
		var _x1 = x - (_w * 0.35);
		var _y1 = y - (_h * 0.48);
		
		var _x1_hp = _vanguard ? _x1 - 41 : _x1 - 28;
		var _y1_hp = _vanguard ? _y1 + 27 : _y1 + 20;
		var _x2_hp = _vanguard ? _x1 + 37 : _x1 + 23;
		var _y2_hp = _vanguard ? _y1 + 34 : _y1 + 25;


		draw_middle_center_outline(_x1, _y1, _hp, _fnt);
		draw_healthbar(_x1_hp, _y1_hp, _x2_hp, _y2_hp, 100 * _hp / _max, 
		c_black, c_red, c_lime, 0, true, true);
		
		if (!_card_instance.has_acted && _terr != undefined) {
			var _terr_stat = _terr.iniciative_stat;
			var _color = my_turn ? c_yellow : c_silver;
			_x1 = x + (_w * 0.31);
			_y1 = y + (_h * 0.45);
			_fnt = _vanguard ? fnt_main_35 : fnt_main_25;
			
			if (_vanguard) {
				draw_sprite_stretched(spr_card_stat, _terr_stat, _x1 - 30, _y1 - 30, 55, 55);
				draw_middle_center_outline(_x1 + 45, _y1 - 5, card_stat_str(_card_instance.stats[_terr_stat].get_value()), _fnt, _color);
			} else {
				draw_sprite(spr_card_stat, _terr_stat, _x1, _y1);
				draw_middle_center_outline(_x1 + 27, _y1, card_stat_str(_card_instance.stats[_terr_stat].get_value()), _fnt, _color);
			}
		}
	}
}

#endregion

#region Set Act Step Function

set_act_step = function() {
	// Start	
	var _card_inst = card;
	var _go_back = new act_option(global.language.act_return, act_menu_go_back, [], undefined, [], act_menu_draw_champ, [_card_inst]);
	var _owner_is_player = (card_owner == card_owners.PLAYER);
	var _gear_hand_size = _owner_is_player ? data.player_gear_hand_size : data.enemy_gear_hand_size;
	var _gear_hand = _owner_is_player ? data.player_gear_hand : data.enemy_gear_hand;
	var _magic_hand_size = _owner_is_player ? data.player_magic_hand_size : data.enemy_magic_hand_size;
	var _magic_hand = _owner_is_player ? data.player_magic_hand : data.enemy_magic_hand;
	
	// Set equip gear act options
	var _act_equip = new act_option(
		global.language.act_equip, 
		create_act_sub_menu, [_card_inst, []], 
		check_any_avail, undefined,
		act_menu_draw_champ, [_card_inst]
	);
	var _opt_array = _act_equip.act_args[1];
	var _card = -1;
	for (var i = 0; i < _gear_hand_size; i++) {
		_card = _gear_hand[i];
		if (_card != undefined) {
			array_push(_opt_array, 
				new act_option(	_card.name,
								_card_inst.equip_gear, [_card_inst, _card, i, self],	
								_card_inst.can_equip_gear, [_card_inst, _card],
								act_menu_draw_gear, [_card]
				)
			);
		}
	}
	array_push(_opt_array, _go_back);	
	_act_equip.avail_args = _act_equip.act_args;
	_act_equip.avail = script_execute_ext(_act_equip.avail_func, _act_equip.avail_args);
	
	// Set use magic act options
	var _act_magic = new act_option(
		global.language.act_magic, 
		create_act_sub_menu, [_card_inst, []], 
		check_any_avail, undefined,
		act_menu_draw_champ, [_card_inst]);
		
	_opt_array = _act_magic.act_args[1];
	_card = -1;
	for (var i = 0; i < _magic_hand_size; i++) {
		_card = _magic_hand[i];
		if (_card != undefined) {
			array_push(_opt_array, 
				new act_option(	_card.name,
								_card_inst.use_magic, [_card_inst, _card, i, self],	// Change to spell function
								_card_inst.can_use_magic, [_card_inst, _card],
								act_menu_draw_magic, [_card]
				)
			);
		}
	}
	array_push(_opt_array, _go_back);	
	_act_magic.avail_args = _act_magic.act_args;
	_act_magic.avail = script_execute_ext(_act_magic.avail_func, _act_magic.avail_args);
	
	// Set use ability act option
	var _act_ability = new act_option(global.language.act_ability, 
		_card_inst.use_ability, [_card_inst, self],
		_card_inst.can_use_ability, [_card_inst],
		act_menu_draw_champ, [_card_inst]);
		
	_act_ability.avail = script_execute_ext(_act_ability.avail_func, _act_ability.avail_args);
	
	// Set do nothing option
	var _act_pass = new act_option(global.language.act_pass, 
		end_act_menu, [_card_inst, self], 
		undefined, [],
		act_menu_draw_champ, [_card_inst]);
		
	// Create select act menu
	return [_act_equip,	_act_magic, _act_ability, _act_pass];
}

#endregion

#region Step Functions

start_init_step = function(_card_array) {
	my_turn = true;
	var _this = self;
	if (card_owner == card_owners.PLAYER){
		instance_create_layer(640, 360, global.cp_layer_instances_above, obj_cp_select_card_menu,
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
		var _array_response = manager_inst.enemy_ia_inst.select_champ_card(field_position, _card_array)
		fin_init_step(_array_response);
	}
}

fin_init_step = function(_array_response) {
	var _selected_card = _array_response[0];
	manager_inst.champ_card_selection_remove(_selected_card);
	// Feather ignore once GM1041
	update_card_instance(new champ_instance(_selected_card, card_owner, field_position));
	my_turn = false;
	alarm[0] = 20;
}

start_act_step = function() {
	my_turn = true;
	if (card.has_acted) {
		throw("Card has already acted!");
	}
	data.apply_passives_all();

	var _this = self;
	var _card_inst = card;
	var _options_array = set_act_step();
	if (card_owner == card_owners.PLAYER) {
		instance_create_layer(room_width / 2, room_height / 2, global.cp_layer_instances_above, obj_cp_select_act_menu,
			{	
				title: global.language.select_act_title,
				options_array: _options_array,
				card_inst: _card_inst,
				manager_inst: _this.manager_inst,
				redo_func : _this.start_act_step,
				return_func : _this.fin_act_step
			}
		);
	} else {
		manager_inst.enemy_ia_inst.enemy_prepare_action(
			_options_array, _card_inst, _this.start_act_step, _this.fin_act_step
		);
	}
}

fin_act_step = function() {
	alarm[1] = 120;
}

#endregion

update_sprite();