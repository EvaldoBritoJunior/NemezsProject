/// @param {real}  _card_id  Unique ID
/// @param {string}  _name  Card name
/// @param {real}  _gw  Card gear weight
/// @param {array}  _stats  Card stats array [pwr, skl, wsd, dvt]
/// @param {real}  _type  Card type (0, 3)
function gear_card(_card_id, _name, _gw, _stats, _type,
				   _spr_card, _spr_cut_card, _spr_card_art,
				   _passive = undefined) constructor {
	card_id = _card_id;
	name = _name;
	gw = _gw;
	stats = _stats;
	type = _type;
	description = $"Descricao :{_card_id}";
	
	spr_card = _spr_card;
	spr_cut_card = _spr_cut_card;
	spr_card_art = _spr_card_art;
	
	card_passive = _passive;
}

var _gear_common_active_func = function(_inst, _gear) {
	var _champ_stats = _inst.stats;
	var _gear_stats = _gear.stats;
	return (_champ_stats[0].get_value() >= _gear_stats[0]
		 && _champ_stats[1].get_value() >= _gear_stats[1]
		 && _champ_stats[2].get_value() >= _gear_stats[2]
		 && _champ_stats[3].get_value() >= _gear_stats[3]
	);
}

var _modifiers = [	new modifier(champ_stat_type.HP, 20, value_target.BASE, math_ops.ADD), 
					new modifier(champ_stat_type.HP, 20, value_target.MAX, math_ops.ADD)
				];

global.gear_cards = [
	new gear_card(
		0, "GEAR NAME", 1, [0, 0, 0, 0], 0,
		spr_sample_gear, spr_sample_cut_gear, spr_sample_gear_art,
		new passive(_modifiers, _gear_common_active_func)
	), 
	new gear_card(
		1, "GEAR NAME", 2, [6, 6, 6, 6], 1,
		spr_sample_gear, spr_sample_cut_gear, spr_sample_gear_art,
		new passive(_modifiers, _gear_common_active_func)
	),
	new gear_card(
		2, "GEAR NAME", 3, [1, 2, 3, 4], 2,
		spr_sample_gear, spr_sample_cut_gear, spr_sample_gear_art,
		new passive(_modifiers, _gear_common_active_func)
	),
	new gear_card(
		3, "GEAR NAME", 3, [6, 5, 4, 3], 3,
		spr_sample_gear, spr_sample_cut_gear, spr_sample_gear_art
	),
	new gear_card(
		4, "GEAR NAME", 2, [3, 4, 5, 6], 3,
		spr_sample_gear, spr_sample_cut_gear, spr_sample_gear_art
	),
	new gear_card(
		5, "GEAR NAME", 1, [1, 1, 2, 3], 2,
		spr_sample_gear, spr_sample_cut_gear, spr_sample_gear_art
	),
	new gear_card(
		6, "GEAR NAME", 1, [5, 5, 0, 0], 1,
		spr_sample_gear, spr_sample_cut_gear, spr_sample_gear_art
	),
	new gear_card(
		7, "GEAR NAME", 2, [1, 5, 4, 3], 0,
		spr_sample_gear, spr_sample_cut_gear, spr_sample_gear_art
	),
	new gear_card(
		8, "GEAR NAME", 3, [6, 1, 4, 1], 0,
		spr_sample_gear, spr_sample_cut_gear, spr_sample_gear_art
	),
	new gear_card(
		9, "GEAR NAME", 2, [6, 5, 0, 0], 1,
		spr_sample_gear, spr_sample_cut_gear, spr_sample_gear_art
	)
];