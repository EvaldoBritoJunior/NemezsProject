/// @param {real}  _card_id  Unique ID
/// @param {string}  _name  Card name
/// @param {real}  _hp  Card health points
/// @param {real}  _gw  Card gear weight
/// @param {real}  _md  Card magic degree
/// @param {array}  _stats  Card stats array [pwr, skl, wsd, dvt]
/// @param {real}  _type  Card type (0, 3)
function champ_card(_card_id, _hp, _gw, _md, _stats, _type,
					_spr_card, _spr_cut_card, _spr_card_art, _spr_cut_card_art,
					_passive = undefined, _ability = undefined, 
					_generate_attack = undefined, _battle_sprites = undefined) constructor {
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
	battle_sprites = _battle_sprites;
}

#region Util
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
var _generate_attack_I = function(_card, _type) {
	var _attacks = [ 
		new char_attack_anim(spr_atk_sword_0, spr_sword_atk_1), 
		new char_attack_anim(spr_atk_sword_0, spr_sword_atk_1), 
		new char_attack_anim(spr_atk_sword_0, spr_sword_atk_1, 15, true)
	];

	return new char_attack_chain(_attacks, 3, _type, _card.spr_card_art);
}
#endregion

// Cards
global.champ_cards = [];

var _battle_sprites = undefined;

#region Card 0

var _passive = undefined;
var _ability = undefined;
var _generate_attack = undefined;

var _card = new champ_card(
		0, 240, 2, 2, [5, 4, 3, 3], card_types.GRAY,
		spr_champ_0, spr_champ_cut_0, spr_champ_art_0, spr_champ_half_art_0,
		_passive, _ability, _generate_attack_I, _battle_sprites
	)

array_push(global.champ_cards, _card);

#endregion

#region Card 1

_passive = undefined;
_ability = undefined;
_generate_attack = undefined;

_card = new champ_card(
		1, 280, 2, 1, [4, 3, 2, 3], card_types.GRAY,
		spr_champ_1, spr_champ_cut_1, spr_champ_art_1, spr_champ_half_art_1,
		_passive, _ability, _generate_attack_I, _battle_sprites
	)

array_push(global.champ_cards, _card);

#endregion

#region Card 2

_passive = undefined;
_ability = undefined;
_generate_attack = undefined;

_card = new champ_card(
		2, 200, 2, 0, [3, 6, 2, 2], card_types.RED,
		spr_champ_2, spr_champ_cut_2, spr_champ_art_2, spr_champ_half_art_2,
		_passive, _ability, _generate_attack, _battle_sprites
	)

array_push(global.champ_cards, _card);

#endregion

#region Card 3

_passive = undefined;
_ability = undefined;
_generate_attack = undefined;

_card = new champ_card(
		3, 220, 2, 2, [2, 4, 5, 4], card_types.BLUE,
		spr_champ_3, spr_champ_cut_3, spr_champ_art_3, spr_champ_half_art_3,
		_passive, _ability, _generate_attack, _battle_sprites
	)

array_push(global.champ_cards, _card);

#endregion

#region Card 4

_passive = undefined;
_ability = undefined;
_generate_attack = undefined;

_card = new champ_card(
		4, 260, 3, 0, [6, 3, 2, 2], card_types.GOLD,
		spr_champ_4, spr_champ_cut_4, spr_champ_art_4, spr_champ_half_art_4,
		_passive, _ability, _generate_attack, _battle_sprites
	)

array_push(global.champ_cards, _card);

#endregion

#region Card 5

_passive = undefined;
_ability = undefined;
_generate_attack = undefined;

_card = new champ_card(
		5, 200, 1, 3, [3, 3, 6, 4], card_types.GOLD,
		spr_champ_5, spr_champ_cut_5, spr_champ_art_5, spr_champ_half_art_5,
		_passive, _ability, _generate_attack, _battle_sprites
	)

array_push(global.champ_cards, _card);

#endregion

#region Card 6

_passive = undefined;
_ability = undefined;
_generate_attack = undefined;

_card = new champ_card(
		6, 200, 1, 3, [2, 3, 6, 6], card_types.BLUE,
		spr_champ_6, spr_champ_cut_6, spr_champ_art_6, spr_champ_half_art_6,
		_passive, _ability, _generate_attack, _battle_sprites
	)

array_push(global.champ_cards, _card);

#endregion

#region Card 7

_passive = undefined;
_ability = undefined;
_generate_attack = undefined;

_card = new champ_card(
		7, 220, 2, 2, [4, 5, 1, 4], card_types.RED,
		spr_champ_7, spr_champ_cut_7, spr_champ_art_7, spr_champ_half_art_7,
		_passive, _ability, _generate_attack_I, _battle_sprites
	)

array_push(global.champ_cards, _card);

#endregion