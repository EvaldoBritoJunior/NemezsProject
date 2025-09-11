global.magic_cards = [];

/// @param {real}  _card_id  Unique ID
/// @param {real}  _md  Card magic degree
function magic_card(_card_id, _md,
					_spr_card, _spr_cut_card, _spr_card_art, 
					_ability = undefined) constructor {
	card_id = _card_id;
	md = _md;
	
	spr_card = _spr_card;
	spr_cut_card = _spr_cut_card;
	spr_card_art = _spr_card_art;
	
	card_ability = _ability;
}

#region Card 0 - VITAL SIGIL
//Ability
var _act_func = function(_inst) {
	var _stat_types = [champ_stat_type.PWR, champ_stat_type.SKL, champ_stat_type.INT, champ_stat_type.DVT];
	var _options = [];
	var _act = -1;
	var _name = -1;
	var _stat = -1;
	
	var _stat_plus = function(_card_inst, _stat) {
		_card_inst.champ_add_modifier(
			_card_inst, new modifier(_stat, 2, value_target.BASE, math_ops.ADD)
		);
		end_act_menu(_card_inst);
	};
	
	for (var i = 0; i < 4; i++) {
		_name = global.language.act_card_stats[i];
		_stat = _stat_types[i];
		_act = new act_option(
			_name,
			_stat_plus, [_inst, _stat, self], 
			undefined, [],
			act_menu_draw_champ, [_inst]
		);
		
		array_push(_options, _act);
	}
	
	script_execute_ext(create_act_sub_menu, [_inst, _options]);
};
var _avail_func = function(_inst) {return true}
var _ability = new ability(_act_func, _avail_func);

// Card
var _card = new magic_card(
		0, 1,
		spr_magic_0, spr_magic_cut_0, spr_magic_art_0,
		_ability
	);

array_push(global.magic_cards, _card);

#endregion

#region Card 1 - FORM SHIFT
//Ability
_act_func = function(_inst) {
	var _types = [card_types.GRAY, card_types.RED, card_types.BLUE, card_types.GOLD];
	var _options = [];
	var _act = -1;
	var _name = -1;
	var _type = -1;
	
	var _func = function(_card_inst, _type) {
		_card_inst.champ_add_modifier(
			_card_inst, new modifier(champ_stat_type.TYPE, _type, value_target.CURRENT, math_ops.EQUALS, 1)
		);
		end_act_menu(_card_inst);
	};
	
	for (var i = 0; i < 4; i++) {
		_name = global.language.act_card_types[i];
		_type = _types[i];
		_act = new act_option(
			_name,
			_func, [_inst, _type, self], 
			undefined, [],
			act_menu_draw_champ, [_inst]
		);
		
		array_push(_options, _act);
	}
	
	script_execute_ext(create_act_sub_menu, [_inst, _options]);
};
_avail_func = function(_inst) {return true}
_ability = new ability(_act_func, _avail_func);

// Card
_card = new magic_card(
		1, 1,
		spr_magic_1, spr_magic_cut_1, spr_magic_art_1,
		_ability
	);

array_push(global.magic_cards, _card);

#endregion

#region Card 2 - AFFINITY SURGE
//Ability
_act_func = function(_inst) {
	var _stat_types = [
		champ_stat_type.GRAY_DMG, champ_stat_type.RED_DMG, 
		champ_stat_type.BLUE_DMG, champ_stat_type.GOLD_DMG
	];
	var _stat = _stat_types[_inst.card_type.get_value()];
	
	_inst.champ_add_modifier(
		_inst, new modifier(_stat, 15, value_target.BASE, math_ops.ADD)
	);
	end_act_menu(_inst);
};
_avail_func = function(_inst) {return true}
_ability = new ability(_act_func, _avail_func);

// Card
_card = new magic_card(
		2, 1,
		spr_magic_2, spr_magic_cut_2, spr_magic_art_2,
		_ability
	);

array_push(global.magic_cards, _card);

#endregion

#region Card 3 - HEX OF SILENCE
//Ability
_act_func = function(_inst) {
	var _data = global.card_phase_data;
	var _player_card = (_inst.card_owner == card_owners.PLAYER);
	var _options = [];
	var _card = -1;
	var _act = -1;
	var _name = -1;
	
	var _func = function(_card_inst, _card_target) {
		_card_target.champ_add_modifier(
			_card_target, new modifier(champ_stat_type.CAN_MAGIC, false, value_target.CURRENT, math_ops.EQUALS, 1)
		);
		end_act_menu(_card_inst);
	};
	
	for (var i = 0; i < _data.champ_qty; i++) {
		_card = _player_card ? _data.enemy_champs[i] : _data.player_champs[i];
		if (_card == undefined) continue;
		_name = global.language.champ_names[_card.card.card_id];
		_act = new act_option(
			_name,
			_func, [_inst, _card, self], 
			undefined, [],
			act_menu_draw_champ, [_card]
		);
		array_push(_options, _act);
	}
	
	script_execute_ext(create_act_sub_menu, [_inst, _options]);
};

_avail_func = function(_inst) {return true}
_ability = new ability(_act_func, _avail_func);
//Card
_card = new magic_card(
		3, 2,
		spr_magic_3, spr_magic_cut_3, spr_magic_art_3,
		_ability
	);

array_push(global.magic_cards, _card);

#endregion

#region Card 4 - VITAL CURSE
//Ability
_act_func = function(_inst) {
	var _data = global.card_phase_data;
	var _player_card = (_inst.card_owner == card_owners.PLAYER);
	var _options = [];
	var _card = -1;
	var _act = -1;
	var _name = -1;
	
	var _act_func_II = function(_inst, _target) {
		var _stat_types = [champ_stat_type.PWR, champ_stat_type.SKL, champ_stat_type.INT, champ_stat_type.DVT];
		var _options = [];
		var _act = -1;
		var _name = -1;
		var _stat = -1;
	
		var _func = function(_card_inst, _target, _stat) {
			_target.champ_add_modifier(
				_target, new modifier(_stat, -2, value_target.BASE, math_ops.ADD, 1)
			);
			end_act_menu(_card_inst);
		};
	
		for (var i = 0; i < 4; i++) {
			_name = global.language.act_card_stats[i];
			_stat = _stat_types[i];
			_act = new act_option(
				_name,
				_func, [_inst, _target, _stat, self], 
				undefined, [],
				act_menu_draw_champ, [_target]
			);
			array_push(_options, _act);
		}
	
		script_execute_ext(create_act_sub_menu, [_inst, _options]);
	};
	
	for (var i = 0; i < _data.champ_qty; i++) {
		_card = _player_card ? _data.enemy_champs[i] : _data.player_champs[i];
		if (_card == undefined) continue;
		_name = global.language.champ_names[_card.card.card_id];
		_act = new act_option(
			_name,
			_act_func_II, [_inst, _card, self], 
			undefined, [],
			act_menu_draw_champ, [_card]
		);
		
		array_push(_options, _act);
	}
	
	script_execute_ext(create_act_sub_menu, [_inst, _options]);
};

_avail_func = function(_inst) {return true}
_ability = new ability(_act_func, _avail_func);

var _avail_func = function(_inst) {return true}
var _ability = new ability(_act_func, _avail_func);

_card = new magic_card(
		4, 2,
		spr_magic_4, spr_magic_cut_4, spr_magic_art_4,
		_ability
	);

array_push(global.magic_cards, _card);

#endregion

#region Card 5 - VITAL GIFT
//Ability
_act_func = function(_inst) {
	var _data = global.card_phase_data;
	var _player_card = (_inst.card_owner == card_owners.PLAYER);
	var _options = [];
	var _card = -1;
	var _act = -1;
	var _name = -1;
	
	var _func = function(_card_inst, _card_target) {
		_card_target.champ_add_modifier(
			_card_target, new modifier(champ_stat_type.PWR, 1, value_target.CURRENT, math_ops.ADD, 1)
		);
		_card_target.champ_add_modifier(
			_card_target, new modifier(champ_stat_type.SKL, 1, value_target.CURRENT, math_ops.ADD, 1)
		);
		_card_target.champ_add_modifier(
			_card_target, new modifier(champ_stat_type.INT, 1, value_target.CURRENT, math_ops.ADD, 1)
		);
		_card_target.champ_add_modifier(
			_card_target, new modifier(champ_stat_type.DVT, 1, value_target.CURRENT, math_ops.ADD, 1)
		);
		
		end_act_menu(_card_inst);
	};
	
	for (var i = 0; i < _data.champ_qty; i++) {
		_card = _player_card ? _data.player_champs[i] : _data.enemy_champs[i];
		if (_card == undefined) continue;
		_name = global.language.champ_names[_card.card.card_id];
		_act = new act_option(
			_name,
			_func, [_inst, _card, self], 
			undefined, [],
			act_menu_draw_champ, [_card]
		);
		
		array_push(_options, _act);
	}
	
	script_execute_ext(create_act_sub_menu, [_inst, _options]);
};

_avail_func = function(_inst) {return true}
_ability = new ability(_act_func, _avail_func);
// Card

_card = new magic_card(
		5, 2,
		spr_magic_5, spr_magic_cut_5, spr_magic_art_5,
		_ability
	);

array_push(global.magic_cards, _card);

#endregion

#region Card 6 - OLD WARCRY
//Ability
_act_func = function(_inst) {
	var _data = global.card_phase_data;
	var _card = -1;
	var _stat_types = [
		champ_stat_type.GRAY_DMG, champ_stat_type.RED_DMG, 
		champ_stat_type.BLUE_DMG, champ_stat_type.GOLD_DMG
	];
	var _stat = -1;
	
	for (var i = 0; i < _data.champ_qty; i++) {
		_card = _data.player_champs[i];
		if (_card != undefined) {
			_stat = _stat_types[_card.card_type.get_value()];
			_card.champ_add_modifier(
				_card, new modifier(_stat, 10, value_target.BASE, math_ops.ADD)
			);
		}
		
		_card = _data.enemy_champs[i];
		if (_card != undefined) {
			_stat = _stat_types[_card.card_type.get_value()];
			_card.champ_add_modifier(
				_card, new modifier(_stat, 10, value_target.BASE, math_ops.ADD)
			);
		}
	}
	
	end_act_menu(_inst);
};
var _avail_func = function(_inst) {return true}
var _ability = new ability(_act_func, _avail_func);
// Card
_card = new magic_card(
		6, 3,
		spr_magic_6, spr_magic_cut_6, spr_magic_art_6,
		_ability
	);

array_push(global.magic_cards, _card);

#endregion

#region Card 7 - DISARM
//Ability
_act_func = function(_inst) {
	var _data = global.card_phase_data;
	var _player_card = (_inst.card_owner == card_owners.PLAYER);
	var _options = [];
	var _card = -1;
	var _act = -1;
	var _name = -1;
	
	var _card_target = _player_card ? _data.enemy_champs[0] : _data.player_champs[0];
	var _gears = _card_target.gears;
	var _gears_size = array_length(_gears);
	
	if (_gears_size == 0) throw($"Invalid use of: {global.language.magic_names[7]}");
	
	var _func = function(_card_inst, _card_target, _idx) {
		_card_target.remove_gear(_card_target, _idx);
		end_act_menu(_card_inst);
	};
	
	for (var i = 0; i < _gears_size; i++) {
		_card = _gears[i];
		if (_card == undefined) continue;
		_name = global.language.gear_names[_card.card_id];
		_act = new act_option(
			_name,
			_func, [_inst, _card_target, i, self], 
			undefined, [],
			act_menu_draw_gear, [_card]
		);
		
		array_push(_options, _act);
	}
	
	script_execute_ext(create_act_sub_menu, [_inst, _options]);
};

_avail_func = function(_inst) {
	var _data = global.card_phase_data;
	var _player_card = (_inst.card_owner == card_owners.PLAYER);
	
	var _card_target = _player_card ? _data.enemy_champs[0] : _data.player_champs[0];
	var _gears = _card_target.gears;
	return (array_length(_gears) > 0);
}
_ability = new ability(_act_func, _avail_func);
// Card
_card = new magic_card(
		7, 3,
		spr_magic_7, spr_magic_cut_7, spr_magic_art_7,
		_ability
	);

array_push(global.magic_cards, _card);

#endregion