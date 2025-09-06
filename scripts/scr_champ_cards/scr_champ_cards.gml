/// @param {real}  _card_id  Unique ID
/// @param {string}  _name  Card name
/// @param {real}  _hp  Card health points
/// @param {real}  _gw  Card gear weight
/// @param {real}  _md  Card magic degree
/// @param {array}  _stats  Card stats array [pwr, skl, wsd, dvt]
/// @param {real}  _type  Card type (0, 3)
function champ_card(_card_id, _name, _hp, _gw, _md, _stats, _type,
					_spr_card, _spr_cut_card, _spr_card_art, _spr_cut_card_art,
					_passive = undefined, _ability = undefined, _generate_attack = undefined) constructor {
	card_id = _card_id;
	name = _name;
	hp = _hp;
	gw = _gw;
	md = _md;
	stats = _stats;
	type = _type;
	description = format_description("A mina aqui no baile, se prepara pra sentar, rebolando desse jeito, vai me fazer delirar");
	
	spr_card = _spr_card;
	spr_cut_card = _spr_cut_card;
	spr_card_art = _spr_card_art;
	spr_cut_card_art = _spr_cut_card_art;
	
	card_passive = _passive;
	card_ability = _ability;
	generate_attack = _generate_attack;
}

// For ability
var _20_dmg_func = function(_inst) {
	var _data = global.card_phase_data;
	var _card = global.card_phase_data.enemy_champs[0];
	_card.champ_add_modifier(_card, new modifier(champ_stat_type.HP, -100, value_target.BASE));
	var _card = global.card_phase_data.player_champs[0];
	_card.champ_add_modifier(_card, new modifier(champ_stat_type.HP, -100, value_target.BASE));
	end_act_menu(_inst);
};

// For passive
var _modifiers = [	
	new modifier(champ_stat_type.HP, 20, value_target.MAX, math_ops.ADD),
	new modifier(champ_stat_type.HP, 20, value_target.BASE, math_ops.ADD)
];

// For avail func
var _true = function(_inst) {return true}

// For attack
var _generate_attack = function(_card, _type) {
	var _attacks = [ 
		new char_attack_anim(spr_char_sword_atk_1, spr_sword_atk_1), 
		new char_attack_anim(spr_char_sword_atk_1, spr_sword_atk_1), 
		new char_attack_anim(spr_char_sword_atk_1, spr_sword_atk_1, 15, true)
	];

	return new char_attack_chain(_attacks, 3, _type, _card.spr_card_art);
}

// Cards
global.champ_cards = [
	new champ_card(
		0, "CHAMP Problemn", 230, 2, 2, [5, 5, 4, 3], 0,
		spr_sample_card, spr_sample_cut_card, spr_sample_card_art, spr_sample_half_art,
		undefined, new ability(_20_dmg_func, _true), _generate_attack
	), 
	new champ_card(
		1, "CHAMP NAME", 230, 6, 2, [6, 6, 6, 6], 1,
		spr_sample_card, spr_sample_cut_card, spr_sample_card_art, spr_sample_half_art,
		undefined, new ability(_20_dmg_func, _true), _generate_attack
	),
	new champ_card(
		2, "CHAMP NAME", 230, 3, 2, [0, 1, 2, 3], 2,
		spr_sample_card, spr_sample_cut_card, spr_sample_card_art, spr_sample_half_art,
		undefined, new ability(_20_dmg_func, _true), _generate_attack
	),
	new champ_card(
		3, "CHAMP NAME", 230, 3, 2, [3, 2, 1, 0], 3,
		spr_sample_card, spr_sample_cut_card, spr_sample_card_art, spr_sample_half_art,
		undefined, new ability(_20_dmg_func, _true), _generate_attack
	),
	new champ_card(
		4, "CHAMP NAME", 230, 3, 2, [6, 5, 4, 3], 3,
		spr_sample_card, spr_sample_cut_card, spr_sample_card_art, spr_sample_half_art,
		new passive(_modifiers, _true), undefined, _generate_attack
	),
	new champ_card(
		5, "CHAMP NAME", 230, 3, 2, [6, 5, 4, 3], 0,
		spr_sample_card, spr_sample_cut_card, spr_sample_card_art, spr_sample_half_art,
		new passive(_modifiers, _true), undefined, _generate_attack
	),
	new champ_card(
		6, "CHAMP NAME", 230, 3, 2, [6, 5, 4, 3], 1,
		spr_sample_card, spr_sample_cut_card, spr_sample_card_art, spr_sample_half_art,
		new passive(_modifiers, _true), undefined, _generate_attack
	),
	new champ_card(
		7, "CHAMP NAME", 230, 3, 2, [6, 5, 4, 3], 2,
		spr_sample_card, spr_sample_cut_card, spr_sample_card_art, spr_sample_half_art,
		new passive(_modifiers, _true), undefined, _generate_attack
	)
];