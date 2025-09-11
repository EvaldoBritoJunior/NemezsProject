global.champ_cards = [];

function card_sprites(
	_char_stand, _char_step, _char_walk, _char_jump, _char_slide,
	_char_atk_sword, _char_atk_bow, _char_atk_shield, _char_atk_book_str, _char_atk_book_weak
) constructor {
	char_stand = _char_stand;
	char_step = _char_step;
	char_walk = _char_walk;
	char_jump = _char_jump;
	char_slide = _char_slide;
	
	char_atk_sword = _char_atk_sword;
	char_atk_bow = _char_atk_bow;
	char_atk_shield = _char_atk_shield;
	char_atk_book_str = _char_atk_book_str;
	char_atk_book_weak = _char_atk_book_weak;
	
}

/// @param {real}  _card_id  Unique ID
/// @param {real}  _hp  Card health points
/// @param {real}  _gw  Card gear weight
/// @param {real}  _md  Card magic degree
/// @param {array}  _stats  Card stats array [pwr, skl, wsd, dvt]
/// @param {real}  _type  Card type (0, 3)
function champ_card(_card_id, _hp, _gw, _md, _stats, _type,
					_spr_card, _spr_cut_card, _spr_card_art, _spr_cut_card_art,
					_passive = undefined, _ability = undefined, 
					_generate_attack = undefined, _card_sprs = undefined) constructor {
	card_id = _card_id;
	hp = _hp;
	gw = _gw;
	md = _md;
	stats = _stats;
	card_type = _type;
	
	spr_card = _spr_card;
	spr_cut_card = _spr_cut_card;
	spr_card_art = _spr_card_art;
	spr_cut_card_art = _spr_cut_card_art;
	
	card_passive = _passive;
	card_ability = _ability;
	generate_attack = _generate_attack;
	card_sprs = _card_sprs;
}

#region Card 0 - Squire
//Sprites
var _battle_sprites = new card_sprites(
	spr_stand_0, spr_step_0, spr_walk_0, spr_jump_0, spr_slide_0,
	spr_atk_sword_0, spr_atk_bow_0, spr_atk_shield_0, spr_atk_book_str_0, spr_atk_book_weak_0
);
//Passive
var _modifiers = [	
	new modifier(champ_stat_type.PWR, 1, value_target.CURRENT, math_ops.ADD),
	new modifier(champ_stat_type.SKL, 1, value_target.CURRENT, math_ops.ADD),
	new modifier(champ_stat_type.INT, 1, value_target.CURRENT, math_ops.ADD),
	new modifier(champ_stat_type.DVT, 1, value_target.CURRENT, math_ops.ADD)
];
var _active_func = function(_inst) {
	return array_length(_inst.gears) > 1;
}
var _passive = new passive(_modifiers, _active_func);
//Ability
var _act_func = undefined;
var _avail_func = undefined;
var _ability = undefined;
//Attack
var _generate_attack = function(_card, _type) {
	var _char_atk = _card.card_sprs.char_atk_sword;
	var _atk_anim = spr_sword_atk_1;
	var _attacks = [ 
		new char_attack_anim(_char_atk, _atk_anim, 10, false, 3), 
		new char_attack_anim(_char_atk, _atk_anim, 10, false, 3), 
		new char_attack_anim(_char_atk, _atk_anim, 14, false, 3)
	];

	return new char_attack_chain(_attacks, 3, _type, _card.spr_card_art);
}
// Card
var _card = new champ_card(
		0, 240, 2, 2, [5, 4, 3, 3], card_types.GRAY,
		spr_champ_0, spr_champ_cut_0, spr_champ_art_0, spr_champ_half_art_0,
		_passive, _ability, _generate_attack, _battle_sprites
	)

array_push(global.champ_cards, _card);

#endregion

#region Card 1 - Knight
//Passive
_modifiers = [	
	new modifier(champ_stat_type.HP, 20, value_target.MAX, math_ops.ADD),
	new modifier(champ_stat_type.HP, 20, value_target.BASE, math_ops.ADD)
];
_active_func = function(_inst) {return _inst.card_pos == 0}
_passive = new passive(_modifiers, _active_func);
//Ability
_ability = undefined;
//Attack
_generate_attack = function(_card, _type) {
	var _spr_atk = _card.card_sprs.char_atk_shield;
	var _atk_anim = spr_shield_atk;
	var _attacks = [ 
		new char_attack_anim(_spr_atk, _atk_anim, 20, false, 4)
	];

	return new char_attack_chain(_attacks, 2, _type, _card.spr_card_art);
}
//Card
_card = new champ_card(
		1, 280, 2, 1, [4, 3, 2, 3], card_types.GRAY,
		spr_champ_1, spr_champ_cut_1, spr_champ_art_1, spr_champ_half_art_1,
		_passive, _ability, _generate_attack, _battle_sprites
	)

array_push(global.champ_cards, _card);

#endregion

#region Card 2 - Archer
// Passive
_passive = undefined;
//Ability
_act_func = function(_inst) {
	var _data = global.card_phase_data;
	var _player_card = (_inst.card_owner == card_owners.PLAYER);
	var _options = [];
	var _card = -1;
	var _act = -1;
	var _name = -1;
	
	var _20_dmg_func = function(_card_inst, _card_target) {
		var _value = min(0, -10 - _card_inst.type_dmg_incr[card_types.RED].get_value());
		_card_target.champ_add_modifier(
			_card_target, new modifier(champ_stat_type.HP, _value, value_target.BASE, math_ops.ADD)
		);
		end_act_menu(_card_inst);
	};
	
	for (var i = 0; i < _data.champ_qty; i++) {
		_card = _player_card ? _data.enemy_champs[i] : _data.player_champs[i];
		if (_card == undefined) continue;
		_name = global.language.champ_names[_card.card.card_id];
		_act = new act_option(
			_name,
			_20_dmg_func, [_inst, _card, self], 
			undefined, [],
			act_menu_draw_champ, [_card]
		);
		
		array_push(_options, _act);
	}
	
	script_execute_ext(create_act_sub_menu, [_inst, _options]);
};

_avail_func = function(_inst) {return true}
_ability = new ability(_act_func, _avail_func);
// Atk
_generate_attack = function(_card, _type) {
	var _spr_atk = _card.card_sprs.char_atk_bow;
	var _atk_anim = spr_bow_atk;
	var _attacks = [ 
		new char_attack_anim(_spr_atk, _atk_anim, 10, true, 1)
	];

	return new char_attack_chain(_attacks, 1, _type, _card.spr_card_art);
}

_card = new champ_card(
		2, 200, 2, 0, [3, 6, 2, 2], card_types.RED,
		spr_champ_2, spr_champ_cut_2, spr_champ_art_2, spr_champ_half_art_2,
		_passive, _ability, _generate_attack, _battle_sprites
	)

array_push(global.champ_cards, _card);

#endregion

#region Card 3 - Apprentice
//Passive
_modifiers = [	
	new modifier(champ_stat_type.MD, 2, value_target.CURRENT, math_ops.ADD)
];
_active_func = function(_inst) {return _inst.card_pos != 0}
_passive = new passive(_modifiers, _active_func);
//Ability
_ability = undefined;
//Attack
_generate_attack = function(_card, _type) {
	var _char_atk = _card.card_sprs.char_atk_sword;
	var _atk_anim = spr_sword_atk_1;
	var _attacks = [ 
		new char_attack_anim(_char_atk, _atk_anim, 10, false, 3), 
		new char_attack_anim(_char_atk, _atk_anim, 10, false, 3), 
		new char_attack_anim(_char_atk, _atk_anim, 14, false, 3)
	];

	return new char_attack_chain(_attacks, 3, _type, _card.spr_card_art);
}
//Card
_card = new champ_card(
		3, 220, 2, 1, [2, 4, 5, 4], card_types.BLUE,
		spr_champ_3, spr_champ_cut_3, spr_champ_art_3, spr_champ_half_art_3,
		_passive, _ability, _generate_attack, _battle_sprites
	)

array_push(global.champ_cards, _card);

#endregion

#region Card 4 - Enginner
// Passive
_passive = undefined;
//Ability
_act_func = function(_inst) {
	var _data = global.card_phase_data;
	if (_inst.card_owner == card_owners.PLAYER) {
		_data.player_draw_gear();
	} else {
		_data.enemy_draw_gear();
	}
	end_act_menu(_inst);
};
_avail_func = function(_inst) {
	var _data = global.card_phase_data;
	var _size = (_inst.card_owner == card_owners.PLAYER) ? _data.player_gear_hand_size : _data.enemy_gear_hand_size; 
	
	return (_size < global.max_gear_qty);
}
_ability = new ability(_act_func, _avail_func);
// Atk
_generate_attack = function(_card, _type) {
	var _spr_atk = _card.card_sprs.char_atk_shield;
	var _atk_anim = spr_shield_atk;
	var _attacks = [ 
		new char_attack_anim(_spr_atk, _atk_anim, 20, false, 4)
	];

	return new char_attack_chain(_attacks, 2, _type, _card.spr_card_art);
}

_card = new champ_card(
		4, 260, 3, 0, [6, 3, 2, 2], card_types.GOLD,
		spr_champ_4, spr_champ_cut_4, spr_champ_art_4, spr_champ_half_art_4,
		_passive, _ability, _generate_attack, _battle_sprites
	)

array_push(global.champ_cards, _card);

#endregion

#region Card 5 - Mage
// Passive
_passive = undefined;
//Ability
_act_func = function(_inst) {
	var _data = global.card_phase_data;
	var _player_card = (_inst.card_owner == card_owners.PLAYER);
	var _options = [];
	var _card = -1;
	var _act = -1;
	var _name = -1;
	
	var _heal_func = function(_card_inst, _card_target) {
		var _value = max(0, 10 + _card_inst.type_dmg_incr[card_types.GOLD].get_value());
		_card_target.champ_add_modifier(
			_card_target, new modifier(champ_stat_type.HP, _value, value_target.BASE, math_ops.ADD)
		);
		end_act_menu(_card_inst);
	};
	
	for (var i = 0; i < _data.champ_qty; i++) {
		_card = _player_card ? _data.player_champs[i] : _data.enemy_champs[i];
		if (_card == undefined) continue;
		_name = global.language.champ_names[_card.card.card_id];
		_act = new act_option(
			_name,
			_heal_func, [_inst, _card, self], 
			undefined, [],
			act_menu_draw_champ, [_card]
		);
		
		array_push(_options, _act);
	}
	
	script_execute_ext(create_act_sub_menu, [_inst, _options]);
};

_avail_func = function(_inst) {return true}
_ability = new ability(_act_func, _avail_func);
// Atk
_generate_attack = function(_card, _type) {
	var _spr_atk = _card.card_sprs.char_atk_book_str;
	var _atk_anim = spr_book_atk_str;
	var _attacks = [ 
		new char_attack_anim(_spr_atk, _atk_anim, 20, true, 3)
	];

	return new char_attack_chain(_attacks, 3, _type, _card.spr_card_art);
}

_card = new champ_card(
		5, 200, 1, 3, [3, 3, 6, 4], card_types.GOLD,
		spr_champ_5, spr_champ_cut_5, spr_champ_art_5, spr_champ_half_art_5,
		_passive, _ability, _generate_attack, _battle_sprites
	)

array_push(global.champ_cards, _card);

#endregion

#region Card 6 - Wizard
// Passive
_passive = undefined;
//Ability
_act_func = function(_inst) {
	var _data = global.card_phase_data;
	if (_inst.card_owner == card_owners.PLAYER) {
		_data.player_draw_magic();
	} else {
		_data.enemy_draw_magic();
	}
	end_act_menu(_inst);
};
_avail_func = function(_inst) {
	var _data = global.card_phase_data;
	var _size = (_inst.card_owner == card_owners.PLAYER) ? _data.player_magic_hand_size : _data.enemy_magic_hand_size; 
	
	return (_size < global.max_magic_qty);
}
_ability = new ability(_act_func, _avail_func);
// Atk
_generate_attack = function(_card, _type) {
	var _spr_atk = _card.card_sprs.char_atk_book_str;
	var _atk_anim = spr_book_atk_str;
	var _attacks = [ 
		new char_attack_anim(_spr_atk, _atk_anim, 20, true, 3)
	];

	return new char_attack_chain(_attacks, 3, _type, _card.spr_card_art);
}

_card = new champ_card(
		6, 200, 1, 3, [2, 3, 6, 6], card_types.BLUE,
		spr_champ_6, spr_champ_cut_6, spr_champ_art_6, spr_champ_half_art_6,
		_passive, _ability, _generate_attack, _battle_sprites
	)

array_push(global.champ_cards, _card);

#endregion

#region Card 7 - Executor

//Passive
var _modifiers = [	
	new modifier(champ_stat_type.RED_DMG, 15, value_target.BASE, math_ops.ADD),
	new modifier(champ_stat_type.BLUE_DMG, 15, value_target.BASE, math_ops.ADD),
	new modifier(champ_stat_type.GOLD_DMG, 15, value_target.BASE, math_ops.ADD),
	new modifier(champ_stat_type.GRAY_DMG, 15, value_target.BASE, math_ops.ADD)
];
_active_func = function(_inst) {
	var _data = global.card_phase_data;
	var _already_active = _inst.card_passive_state;
	var _activate = (_data.turn_stage == card_phase_stages.END_STAGE && _inst.card_pos == 0);
	return (_already_active || _activate);
}
_passive = new passive(_modifiers, _active_func);
//Ability
_ability = undefined;
//Atk
_generate_attack = function(_card, _type) {
	var _spr_atk = _card.card_sprs.char_atk_bow;
	var _atk_anim = spr_bow_atk;
	var _attacks = [ 
		new char_attack_anim(_spr_atk, _atk_anim, 10, true, 1)
	];

	return new char_attack_chain(_attacks, 1, _type, _card.spr_card_art);
}
//Card
_card = new champ_card(
		7, 220, 2, 2, [4, 5, 1, 4], card_types.RED,
		spr_champ_7, spr_champ_cut_7, spr_champ_art_7, spr_champ_half_art_7,
		_passive, _ability, _generate_attack, _battle_sprites
	)

array_push(global.champ_cards, _card);

#endregion