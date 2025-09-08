/// @param {real}  _card_id  Unique ID
/// @param {string}  _name  Card name
/// @param {real}  _gw  Card gear weight
/// @param {array}  _stats  Card stats array [pwr, skl, wsd, dvt]
/// @param {real}  _type  Card type (0, 3)
function gear_card(_card_id, _gw, _stats, _type,
				   _spr_card, _spr_cut_card, _spr_card_art,
				   _passive = undefined, _generate_attack = undefined) constructor {
	card_id = _card_id;
	gw = _gw;
	stats = _stats;
	card_type = _type;
	
	spr_card = _spr_card;
	spr_cut_card = _spr_cut_card;
	spr_card_art = _spr_card_art;
	
	card_passive = _passive;
	generate_attack = _generate_attack
}

// For avail func
gear_common_active_func = function(_inst, _gear) {
	var _champ_stats = _inst.stats;
	var _gear_stats = _gear.stats;
	return (_champ_stats[0].get_value() >= _gear_stats[0]
		 && _champ_stats[1].get_value() >= _gear_stats[1]
		 && _champ_stats[2].get_value() >= _gear_stats[2]
		 && _champ_stats[3].get_value() >= _gear_stats[3]
	);
}

// For passive
var _modifiers = [	
	new modifier(champ_stat_type.HP, 20, value_target.MAX, math_ops.ADD),
	new modifier(champ_stat_type.HP, 20, value_target.BASE, math_ops.ADD)
];


// For attack
var _generate_attack = function(_inst, _gear) {
	var _type = _gear.card_type;
	
	var _weak_attack = [ 
		new char_attack_anim(spr_char_sword_atk_1, spr_sword_atk_1)
	];
	
	var _str_attack = [ 
		new char_attack_anim(spr_char_sword_atk_1, spr_sword_atk_1), 
		new char_attack_anim(spr_char_sword_atk_1, spr_sword_atk_1), 
		new char_attack_anim(spr_char_sword_atk_1, spr_sword_atk_1, 15, true)
	];
	
	var _attacks = gear_common_active_func(_inst, _gear) ? _str_attack : _weak_attack;

	return new char_attack_chain(_attacks, 3, _type, _gear.spr_card_art);
}

var _passive = new passive(_modifiers, gear_common_active_func)
// Cards

global.gear_cards = [];

#region Card 0

var _passive = undefined;
var _generate_attack = undefined;

var _card = new gear_card(
		0, 1, [0, 0, 4, 2], card_types.BLUE,
		spr_gear_0, spr_gear_cut_0, spr_gear_art_0,
		_passive, _generate_attack
	);

array_push(global.gear_cards, _card);

#endregion

#region Card 1

_passive = undefined;
_generate_attack = undefined;

_card = new gear_card(
		1, 1, [0, 0, 1, 4], card_types.GOLD,
		spr_gear_1, spr_gear_cut_1, spr_gear_art_1,
		_passive, _generate_attack
	);

array_push(global.gear_cards, _card);

#endregion

#region Card 2

_passive = undefined;
_generate_attack = undefined;

_card = new gear_card(
		2, 1, [3, 4, 0, 0], card_types.GRAY,
		spr_gear_2, spr_gear_cut_2, spr_gear_art_2,
		_passive, _generate_attack
	);

array_push(global.gear_cards, _card);

#endregion

#region Card 3

_passive = undefined;
_generate_attack = undefined;

_card = new gear_card(
		3, 1, [2, 4, 4, 0], card_types.RED,
		spr_gear_3, spr_gear_cut_3, spr_gear_art_3,
		_passive, _generate_attack
	);

array_push(global.gear_cards, _card);

#endregion

#region Card 4

_passive = undefined;
_generate_attack = undefined;

_card = new gear_card(
		4, 1, [5, 2, 0, 0], card_types.GRAY,
		spr_gear_4, spr_gear_cut_4, spr_gear_art_4,
		_passive, _generate_attack
	);

array_push(global.gear_cards, _card);

#endregion

#region Card 5

_passive = undefined;
_generate_attack = undefined;

_card = new gear_card(
		5, 1, [4, 3, 0, 4], card_types.GOLD,
		spr_gear_5, spr_gear_cut_5, spr_gear_art_5,
		_passive, _generate_attack
	);

array_push(global.gear_cards, _card);

#endregion

#region Card 6

_passive = undefined;
_generate_attack = undefined;

_card = new gear_card(
		6, 1, [4, 4, 3, 0], card_types.BLUE,
		spr_gear_6, spr_gear_cut_6, spr_gear_art_6,
		_passive, _generate_attack
	);

array_push(global.gear_cards, _card);

#endregion

#region Card 7

_passive = undefined;
_generate_attack = undefined;

_card = new gear_card(
		7, 1, [4, 3, 0, 3], card_types.RED,
		spr_gear_7, spr_gear_cut_7, spr_gear_art_7,
		_passive, _generate_attack
	);

array_push(global.gear_cards, _card);

#endregion