#region Variables

data = global.card_phase_data;
winner = card_phase_winners.NOBODY;
default_background = spr_field_default;
enemy_ia_inst = undefined;

champ_holders = array_create(data.champ_qty * 2, undefined);
objects_step_order = [];
player_gear_holders = array_create(global.max_gear_qty, undefined);
player_magic_holders = array_create(global.max_magic_qty, undefined);
enemy_gear_holders = array_create(global.max_gear_qty, undefined);
enemy_magic_holders = array_create(global.max_magic_qty, undefined);

territory_holder = undefined;
instances_positions = [				// Champ holders
	//  Player      Enemy
		[410, 360], [870, 360],		// Vanguard
		[101, 227], [1179, 227],	// Rear I
		[101, 359], [1179, 359],	// Rear II
		[101, 492], [1179, 492]		// Rear III
	];
p_gear_holders_positions = [
		[574, 662], [457, 662],	[341, 662]
	];
p_magic_holders_positions = [
		[705, 662], [821, 662],	[938, 662]
	];
e_gear_holders_positions = [
		[574, 58], [457, 58], [341, 58]
	];
e_magic_holders_positions = [
		[705, 58], [821, 58], [938, 58]
	];
champ_card_selection = [];

#endregion

#region Data Functions

champ_card_selection_remove = function(_card) {
	var new_arr = [];
    var len = array_length(champ_card_selection);

    for (var i = 0; i < len; i++) {
        if (champ_card_selection[i].card_id != _card.card_id) { // only keep if it's not the target value
            array_push(new_arr, champ_card_selection[i]);
        }
    }
    champ_card_selection = new_arr;
}

#endregion

#region Sort Functions

stage_sort = function(_start, _end, _array = objects_step_order) {
    // clamp to array size
    var len = array_length(_array);
    _start = clamp(_start, 0, len - 1);
    _end = clamp(_end, 0, len - 1);

    // ensure _start <= _end
    if (_start > _end) {
        var tmp = _start; _start = _end; _end = tmp;
    }

    // slice the subarray
    var sub = array_create(_end - _start + 1);
    for (var i = 0; i <= _end - _start; i++) {
        sub[i] = _array[_start + i];
    }

    // sort only that subarray
    array_sort(sub, function(left, right) {
        if (left.initiative_value > right.initiative_value) return 1;
        if (left.initiative_value < right.initiative_value) return -1;
        return 0;
    });

    // put back into the main array
    for (var i = 0; i <= _end - _start; i++) {
        _array[_start + i] = sub[i];
    }
};

init_stage_sort = function() {
	var _turn_owner = data.turn_owner;
	var _max_i = array_length(objects_step_order) - 1;
	var _initiative_value = -1;
	var _obj = -1;
	// set initiative values
	for (var _i = 0; _i <= _max_i; _i++) {
		_obj = objects_step_order[_i];
		_initiative_value = (floor(_max_i / 2) - _obj.field_position) * 10;
		if (_obj.card_owner == _turn_owner) {
			_initiative_value++;
		}
		_obj.initiative_value = _initiative_value;
	}
	
	stage_sort(0, _max_i);
}

act_stage_sort = function() {
	var _turn_owner = data.turn_owner;
	var _terr = data.current_territory;
	var _max_i = array_length(objects_step_order) - 1;
	var _initiative_value = -1;
	var _obj = -1;
	var _owner_value = -1;
	var _position = -1;
	var _card_instance = -1;
	var _card_stat = -1;
	
	// Set initiative values
	for (var _i = current_step; _i <= _max_i; _i++) {
		_obj = objects_step_order[_i];
		_card_instance = _obj.card;
		_initiative_value = 1000;
		if (_card_instance != undefined) {
			_owner_value = _turn_owner == _obj.card_owner ? 1 : 0;
			_position = _obj.field_position;
			_card_stat = _card_instance.stats[_terr.iniciative_stat].get_value();
			
			if (_card_instance.has_acted) throw("Calculating initiative value for card that already acted");
			_initiative_value = _terr.iniciative_type == iniciative_types.BIGGER ? _card_stat * 100
																				: (10 - _card_stat) * 100;
			_initiative_value += (data.champ_qty - _position) * 10;
			_initiative_value += _owner_value;
		}
		_obj.initiative_value = _initiative_value;
	}
	
	stage_sort(0, _max_i);
}

#endregion

#region Utility Functions

draw_data = function () {
	var _data = global.card_phase_data;
	var _player_turn = data.turn_owner == card_owners.PLAYER;
	var _player_gear_gyd_size = array_length(_data.player_gear_gyd);
	var _player_magic_gyd_size = array_length(_data.player_magic_gyd);
	var _enemy_gear_gyd_size = array_length(_data.enemy_gear_gyd);
	var _enemy_magic_gyd_size = array_length(_data.enemy_magic_gyd);
	
	draw_set_font(fnt_main_20);

	#region Player data
	if (_player_turn) draw_set_color(c_yellow);
	draw_text(10, 620, global.player_data.name); // Name
	if (_player_turn) draw_set_color(c_white);

	draw_set_font(fnt_main_30);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	draw_text(90, 687, _player_gear_gyd_size); // Used gear
	draw_text(204, 687, _player_magic_gyd_size); // Used magic

	#endregion

	#region Enemy data
	draw_text(1133, 75, _enemy_gear_gyd_size);  // Used gear
	draw_text(1247, 75, _enemy_magic_gyd_size);  // Used magic

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_font(fnt_main_20);
	
	if (!_player_turn) draw_set_color(c_yellow);
	draw_text(1055, 8, _data.enemy_name);  // Name
	draw_set_color(c_white);

	#endregion
}

create_objects = function() {
	var _this = self;
	
	// Enemy IA
	enemy_ia_inst = instance_create_layer(x, y, "Instances", obj_cp_enemy_ia, {manager_inst: _this});
	
	// Champ holders
	for (var _i = 0; _i < array_length(champ_holders); _i++) {
		champ_holders[_i] = instance_create_layer(
			instances_positions[_i][0], instances_positions[_i][1], "Instances", obj_cp_champ_holder,
			{
				card_owner : (_i % 2),
				field_position : floor(_i / 2),
				manager_inst : _this
			});
	}
	
	// Player gear holders
	for (var _i = 0; _i < array_length(player_gear_holders); _i++) {
		player_gear_holders[_i] = instance_create_layer(
			p_gear_holders_positions[_i][0], p_gear_holders_positions[_i][1], "Instances", obj_cp_player_gear_holder,
			{
				field_position : _i,
				manager_inst : _this
			});
	}
	
	// Player magic holders
	for (var _i = 0; _i < array_length(player_magic_holders); _i++) {
		player_magic_holders[_i] = instance_create_layer(
			p_magic_holders_positions[_i][0], p_magic_holders_positions[_i][1], "Instances", obj_cp_player_magic_holder,
			{
				field_position : _i,
				manager_inst : _this
			});
	}
	
	// Enemy gear holders
	for (var _i = 0; _i < array_length(enemy_gear_holders); _i++) {
		enemy_gear_holders[_i] = instance_create_layer(
			e_gear_holders_positions[_i][0], e_gear_holders_positions[_i][1], "Instances", obj_cp_enemy_gear_holder,
			{
				field_position : _i,
				manager_inst : _this
			});
	}
	
	// Enemy magic holders
	for (var _i = 0; _i < array_length(enemy_magic_holders); _i++) {
		enemy_magic_holders[_i] = instance_create_layer(
			e_magic_holders_positions[_i][0], e_magic_holders_positions[_i][1], "Instances", obj_cp_enemy_magic_holder,
			{
				field_position : _i,
				manager_inst : _this
			});
	}
	
	// Territory holder
	territory_holder = instance_create_layer(
			room_width / 2, room_height / 2, "Instances", obj_cp_territory_holder,
			{
				manager_inst : _this
			});
}

draw_stage_draws = function() {
	//Player draw
	var _card = data.player_draw_gear();
	if (_card != undefined) {
		player_gear_holders[data.player_gear_hand_size - 1].update_sprite();
	}
	
	_card = data.player_draw_magic();
	if (_card != undefined) {
		player_magic_holders[data.player_gear_hand_size - 1].update_sprite();
	}
	
	//Enemy draw
	_card = data.enemy_draw_gear();
	if (_card != undefined) {
		enemy_gear_holders[data.enemy_gear_hand_size - 1].update_sprite();
	}
	
	_card = data.enemy_draw_magic();
	if (_card != undefined) {
		enemy_magic_holders[data.enemy_gear_hand_size - 1].update_sprite();
	}
}

set_has_acted = function() {
	var _size = array_length(champ_holders);
	var _card = -1;
	for (var _i = 0; _i < _size; _i++) {
		_card = champ_holders[_i].card;
		if (_card != undefined) _card.has_acted = false;
	}
}

update_all_sprites = function() {
	// Champ holders
	for (var _i = 0; _i < array_length(champ_holders); _i++) {
		champ_holders[_i].update_sprite();
	}
	
	// Player gear holders
	for (var _i = 0; _i < array_length(player_gear_holders); _i++) {
		player_gear_holders[_i].update_sprite();
	}
	
	// Player magic holders
	for (var _i = 0; _i < array_length(player_magic_holders); _i++) {
		player_magic_holders[_i].update_sprite();
	}
	
	// Enemy gear holders
	for (var _i = 0; _i < array_length(enemy_gear_holders); _i++) {
		enemy_gear_holders[_i].update_sprite();
	}
	
	// Enemy magic holders
	for (var _i = 0; _i < array_length(enemy_magic_holders); _i++) {
		enemy_magic_holders[_i].update_sprite();
	}
	
	// Territory holder
	territory_holder.update_sprite();
}

check_game_state = function(_func) {
	var _result = data.check_champs_hp();
	if (_result) {
		var _winner = data.check_victory()
		if (_winner != card_phase_winners.NOBODY) {
			game_end();
		} else {
			enemy_set_vanguard(self.player_set_vanguard, _func);
		}
	} else {
		_func();
	}
}

enemy_set_vanguard = function(_func, _arg) {
	var _champ_array = data.enemy_champs;
	var _champ = _champ_array[0];
	if (_champ == undefined) {
		enemy_ia_inst.choose_new_vanguard(_func, _arg);
	} else {
		_func(_arg);
	}
}

player_set_vanguard = function(_func) {
	var _this = self;
	var _champ_array = data.player_champs;
	var _size = array_length(_champ_array);
	var _champ = _champ_array[0];
	var _opt_array = []
	if (_champ == undefined) {
		for (var i = 1; i < _size; i++) {
			_champ = _champ_array[i];
			if (_champ != undefined) {
				array_push(_opt_array, 
					new act_option(	
						_champ.card.name,
						data.switch_player_champs, [data, 0, i, true, self],	
						undefined, [],
						act_menu_draw_champ, [_champ]
					)
				);
			}
		}
	
		instance_create_layer(room_width / 2, room_height / 2, global.cp_layer_instances_above, obj_cp_select_act_menu,
			{	
				title: global.language.select_vanguard_title,
				options_array: _opt_array,
				manager_inst: _this,
				return_func : _func
			}
		);
	} else {
		_func();
	}
}

check_step_order = function() {
    var _size = array_length(champ_holders);
    var _inst, _card, _pos, _last;

    for (var i = 0; i < _size; i++) {
        _inst = champ_holders[i];
        _card = _inst.card;

        if (_card != undefined && !_card.has_acted) {
            // ensure it's in the list
            if (!array_contains(objects_step_order, _inst)) {
                array_push(objects_step_order, _inst);
            }
        } else {
            // remove if it shouldn't be there
            _pos = array_index_of(objects_step_order, _inst);
            if (_pos != -1) {
                _last = array_length(objects_step_order) - 1;
                if (_pos != _last) {
                    objects_step_order[_pos] = objects_step_order[_last];
                }
                array_pop(objects_step_order);
            }
        }
    }
};

#endregion

#region Set Decks Functions

set_gear_decks = function () {
	var _this = self;
	var _card_array = global.gear_cards;
	var _select_amount = data.champ_qty * 2;
	var _enemy_gear_deck = enemy_ia_inst.select_gear_deck(_select_amount, _card_array);

	data.enemy_gear_orig_deck = _enemy_gear_deck;
	data.enemy_gear_deck = array_full_copy(_enemy_gear_deck);
	
	instance_create_layer(640, 360, global.cp_layer_instances_above, obj_cp_select_card_menu,
		{
			card_array: _card_array,
			select_amount: _select_amount,
			title: global.language.select_card_gears,
			manager_inst: _this,
			draw_cut_func: global.draw_gear_cut_card,
			draw_func: global.draw_gear_card,
			return_func: _this.set_magic_decks
		});
}

set_magic_decks = function (_gear_cards) {
	data.player_gear_orig_deck = _gear_cards;
	data.player_gear_deck = array_full_copy(_gear_cards);
	
	var _this = self;
	var _card_array = global.magic_cards;
	var _select_amount = data.champ_qty * 2;
	var _enemy_magic_deck = enemy_ia_inst.select_magic_deck(_select_amount, _card_array);

	data.enemy_magic_orig_deck = _enemy_magic_deck;
	data.enemy_magic_deck = array_full_copy(_enemy_magic_deck);
	
	instance_create_layer(640, 360, global.cp_layer_instances_above, obj_cp_select_card_menu,
		{
			card_array: _card_array,
			select_amount: _select_amount,
			title: global.language.select_card_magics,
			manager_inst: _this,
			draw_cut_func: global.draw_magic_cut_card,
			draw_func: global.draw_magic_card,
			return_func: _this.set_field_decks
		});
}

set_field_decks = function (_magic_cards) {
	data.player_magic_orig_deck = _magic_cards;
	data.player_magic_deck = array_full_copy(_magic_cards);
	
	var _this = self;
	var _card_array = global.territory_cards;
	var _select_amount = data.champ_qty;
	var _enemy_territory_deck = enemy_ia_inst.select_territory_deck(_select_amount, _card_array);

	data.enemy_territory_orig_deck = _enemy_territory_deck;
	data.enemy_territory_deck = array_full_copy(_enemy_territory_deck);
	
	instance_create_layer(640, 360, global.cp_layer_instances_above, obj_cp_select_card_menu,
		{
			card_array: _card_array,
			select_amount: _select_amount,
			title: global.language.select_card_territories,
			manager_inst: _this,
			draw_cut_func: global.draw_territory_cut_card,
			draw_func: global.draw_territory_card,
			return_func: _this.end_set_decks
		});

}

end_set_decks = function (_terr_cards) {
	data.player_territory_orig_deck = _terr_cards;
	data.player_territory_deck = array_full_copy(_terr_cards);
	draw_stage_draws();
	data.turn_stage = card_phase_stages.ACT_STAGE;
	start_stage();
}

#endregion

#region Stage Functions

start_stage = function () {
	current_step = -1;
	if (data.turn_stage == card_phase_stages.INIT_STAGE) {
		champ_card_selection = array_full_copy(global.champ_cards);
		randomize();
		var _first = irandom(1); //choose(card_owners.PLAYER, card_owners.ENEMY);
		data.turn_owner = _first;
		create_objects();
		objects_step_order = array_full_copy(champ_holders);
		init_stage_sort();
		init_stage_step();
		
	} else if (data.turn_stage == card_phase_stages.ACT_STAGE) {
		draw_stage_draws();
		//draw & set field
		var _terr_card = -1;
		if (data.turn_owner == card_owners.PLAYER) {
			_terr_card = data.player_draw_territory();
		} else {
			_terr_card = data.enemy_draw_territory();
		}
		data.current_territory = _terr_card;
		territory_holder.update_sprite();
		objects_step_order = array_full_copy(champ_holders);
		set_has_acted();
		//act_stage_step
		act_stage_step();
		
	} else if (data.turn_stage == card_phase_stages.END_STAGE) {
		
	} else {
		
	}
}

init_stage_step = function() {
	current_step++;
	var _size = array_length(objects_step_order);
	if (_size != 0) {
		array_pop(objects_step_order).start_init_step(champ_card_selection);
	} else {
		end_stage();
	}
}

act_stage_step = function(bool_check_game = true) {
	current_step++;
	if (bool_check_game) {
		update_all_sprites();
		check_game_state(self.act_stage_stepII);
	} else {
		act_stage_stepII(false);
	}
}

act_stage_stepII = function(bool_check_game = true) {
	if (bool_check_game) {
		update_all_sprites();
		check_step_order();
	}
	var _size = array_length(objects_step_order);
	if (_size != 0) {
		act_stage_sort();
		if (objects_step_order[_size - 1].card == undefined) {
			array_pop(objects_step_order);
			act_stage_step(false);
		} else {
			array_pop(objects_step_order).start_act_step();
		}
	} else {
		end_stage();
	}
}

end_stage = function () {
	if (data.turn_stage == card_phase_stages.INIT_STAGE) {
		set_gear_decks();
	} else if (data.turn_stage == card_phase_stages.ACT_STAGE) {
		
	} else if (data.turn_stage == card_phase_stages.END_STAGE) {
		
	} else {
		
	}
}

#endregion

test_act = false;

#region Test Act Stage
/*
set_test_act = function() {
	data.player_gear_hand_size = 3;
	data.player_gear_hand = [global.gear_cards[0], global.gear_cards[1], global.gear_cards[2]];
	data.player_magic_hand_size = 3;
	data.player_magic_hand = [global.magic_cards[0], global.magic_cards[1], global.magic_cards[2]];
	
	data.enemy_gear_hand_size = 3;
	data.enemy_gear_hand = [global.gear_cards[0], global.gear_cards[1], global.gear_cards[2]];
	//data.enemy_magic_hand_size = 3;
	//data.enemy_magic_hand = [global.magic_cards[0], global.magic_cards[1], global.magic_cards[2]];
	
	
	data.enemy_champs[0] = new champ_instance(global.champ_cards[1], card_owners.ENEMY, 0);
	data.player_champs[0] = new champ_instance(global.champ_cards[0], card_owners.PLAYER, 0);
	test_act_menu();
}

test_act_menu = function() {
	data.apply_passives_all();
	if (data.check_champs_hp()) {
		var _winner = data.check_victory()
		if (_winner != card_phase_winners.NOBODY) {
			winner = _winner;
			test_act = false;
		}
	}
	else {
		// Start
		var _this = self;
		var _card_inst = data.player_champs[0];
		var _go_back = new act_option(global.language.act_return, act_menu_go_back, [], undefined, [], act_menu_draw_champ, [_card_inst]);
	
		// Set equip gear act options
		var _act_equip = new act_option(
			global.language.act_equip, 
			create_act_sub_menu, [_card_inst, []], 
			check_any_avail, undefined,
			act_menu_draw_champ, [_card_inst]
		);
		var _opt_array = _act_equip.act_args[1];
		var _card = -1;
		for (var i = 0; i < data.player_gear_hand_size; i++) {
			_card = data.player_gear_hand[i];
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
		for (var i = 0; i < data.player_magic_hand_size; i++) {
			_card = data.player_magic_hand[i];
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
		instance_create_layer(room_width / 2, room_height / 2, global.cp_layer_instances_above, obj_cp_select_act_menu,
			{	
				options_array: [
					_act_equip,		
					_act_magic,
					_act_ability,
					_act_pass
				],
				card_inst: _card_inst,
				manager_inst: _this,
				redo_func : _this.test_act_menu,
				return_func : _this.test_enemy_act
			}
		)
	}

}

test_enemy_act = function() {
	data.enemy_champs[0].champ_apply_passives(data.enemy_champs[0]);
	data.player_champs[0].champ_apply_passives(data.player_champs[0]);
	// Start
	var _this = self;
	var _card_inst = data.enemy_champs[0];
	var _go_back = new act_option(global.language.act_return, act_menu_go_back, [], undefined, [], act_menu_draw_champ, [_card_inst]);
	
	// Set equip gear act options
	var _act_equip = new act_option(
		global.language.act_equip, 
		create_act_sub_menu, [_card_inst, []], 
		check_any_avail, undefined,
		act_menu_draw_champ, [_card_inst]
	);
	var _opt_array = _act_equip.act_args[1];
	var _card = -1;
	for (var i = 0; i < data.enemy_gear_hand_size; i++) {
		_card = data.enemy_gear_hand[i];
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
	for (var i = 0; i < data.enemy_magic_hand_size; i++) {
		_card = data.enemy_magic_hand[i];
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
	enemy_prepare_action([_act_equip,_act_magic,_act_ability,_act_pass], _card_inst, _this, _this.test_enemy_act, _this.test_act_menu);
}

manager_inst = -1;
redo_func = -1;
return_func = -1;
card_inst = -1;
enemy_prepare_action = function(_options_array, _card_inst, _manager_inst, _redo_func, _return_func) {
	manager_inst = _manager_inst;
	card_inst = _card_inst;
	redo_func = _redo_func;
	return_func = _return_func;

	enemy_select_action(_options_array);
}

enemy_select_action = function(_options_array) {
	var _size = array_length(_options_array);
	var _avail_options = [];
	var _option = -1;
	for (var i = 0; i < _size; i++) {
		_option = _options_array[i];
		if (_option.avail) array_push(_avail_options, _option);
	}
	
	_size = array_length(_avail_options);
	randomize();
	var _selected = irandom(_size - 1);
	_option = _avail_options[_selected];
	var _func = _option.act_func;
	var _args = _option.act_args;
	script_execute_ext(_func, _args);
}
*/
#endregion