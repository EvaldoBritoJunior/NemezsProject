/// @param {real}  _card_id  Unique ID
/// @param {string}  _name  Card name
/// @param {real}  _hp  Card health points
/// @param {real}  _gw  Card gear weight
/// @param {real}  _md  Card magic degree
/// @param {array}  _stats  Card stats array [pwr, skl, wsd, dvt]
/// @param {real}  _type  Card type (0, 3)
function champ_card(_card_id, _name, _hp, _gw, _md, _stats, _type,
					_spr_card, _spr_cut_card, _spr_card_art, _spr_cut_card_art,
					_passive = undefined, _ability = undefined) constructor {
	card_id = _card_id;
	name = _name;
	hp = _hp;
	gw = _gw;
	md = _md;
	stats = _stats;
	type = _type;
	description = $"Descricao :{_card_id}";
	
	spr_card = _spr_card;
	spr_cut_card = _spr_cut_card;
	spr_card_art = _spr_card_art;
	spr_cut_card_art = _spr_cut_card_art;
	
	card_passive = _passive;
	card_ability = _ability;
}

var _20_dmg_func = function(_inst) {
	var _data = global.card_phase_data;
	var _card_t = _data.enemy_champs[0];
	_inst.champ_add_modifier(_inst, new modifier(champ_stat_type.HP, -300, value_target.BASE));
	end_act_menu();
};

var _modifiers = [	
	new modifier(champ_stat_type.HP, 20, value_target.MAX, math_ops.ADD),
	new modifier(champ_stat_type.HP, 20, value_target.BASE, math_ops.ADD)
];

var _true = function(_inst) {return true}

global.champ_cards = [
	new champ_card(
		0, "CHAMP NAME", 230, 2, 2, [5, 5, 4, 3], 0,
		spr_sample_card, spr_sample_cut_card, spr_sample_card_art, spr_sample_half_art,
		new passive(_modifiers, _true), new ability(_20_dmg_func, _true)
	), 
	new champ_card(
		1, "CHAMP NAME", 230, 3, 2, [3, 4, 5, 6], 1,
		spr_sample_card, spr_sample_cut_card, spr_sample_card_art, spr_sample_half_art
	),
	new champ_card(
		2, "CHAMP NAME", 230, 3, 2, [0, 1, 2, 3], 2,
		spr_sample_card, spr_sample_cut_card, spr_sample_card_art, spr_sample_half_art
	),
	new champ_card(
		3, "CHAMP NAME", 230, 3, 2, [3, 2, 1, 0], 3,
		spr_sample_card, spr_sample_cut_card, spr_sample_card_art, spr_sample_half_art
	),
	new champ_card(
		4, "CHAMP NAME", 230, 3, 2, [6, 5, 4, 3], 3,
		spr_sample_card, spr_sample_cut_card, spr_sample_card_art, spr_sample_half_art
	),
	new champ_card(
		5, "CHAMP NAME", 230, 3, 2, [6, 5, 4, 3], 0,
		spr_sample_card, spr_sample_cut_card, spr_sample_card_art, spr_sample_half_art
	),
	new champ_card(
		6, "CHAMP NAME", 230, 3, 2, [6, 5, 4, 3], 1,
		spr_sample_card, spr_sample_cut_card, spr_sample_card_art, spr_sample_half_art
	),
	new champ_card(
		7, "CHAMP NAME", 230, 3, 2, [6, 5, 4, 3], 2,
		spr_sample_card, spr_sample_cut_card, spr_sample_card_art, spr_sample_half_art
	)
];