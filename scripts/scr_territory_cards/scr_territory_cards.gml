enum iniciative_types {
	BIGGER = 0, SMALLER = 1
} 


/// @param {real}  _card_id  Unique ID
/// @param {string}  _name  Card name
/// @param {real}  _iniciative_type  Bigger + or Smaller -
/// @param {real}  _iniciative_stat  Target stat
function territory_card(_card_id, _iniciative_type, _iniciative_stat,
						_spr_card, _spr_cut_card, _spr_card_art, _spr_card_ground,
						_effect = undefined) constructor {
	card_id = _card_id;
	iniciative_type = _iniciative_type;
	iniciative_stat = _iniciative_stat;
	
	spr_card = _spr_card;
	spr_cut_card = _spr_cut_card;
	spr_card_art = _spr_card_art;
	spr_card_ground = _spr_card_ground;
	
	effect = _effect
}

var _ex_effect = function() {
	var _data = global.card_phase_data;
	var _card = _data.enemy_champs[0];
	_card.champ_add_modifier(_card, new modifier(champ_stat_type.HP, 20, value_target.MAX, math_ops.ADD, 1));
	var _card = _data.player_champs[0];
	_card.champ_add_modifier(_card, new modifier(champ_stat_type.HP, 20, value_target.MAX, math_ops.ADD, 1));
}

global.territory_cards = [];

#region Card 0

var _effect = undefined;

var _card = new territory_card(
		0, iniciative_types.BIGGER, card_stats.INT,
		spr_territory_0, spr_territory_cut_0, spr_territory_art_0, spr_territory_ground_0,
		_effect
	);

array_push(global.territory_cards, _card);

#endregion

#region Card 1

_effect = undefined;

_card = new territory_card(
		1, iniciative_types.SMALLER, card_stats.SKL,
		spr_territory_1, spr_territory_cut_1, spr_territory_art_1, spr_territory_ground_1,
		_effect
	);

array_push(global.territory_cards, _card);

#endregion

#region Card 2

_effect = undefined;

_card = new territory_card(
		2, iniciative_types.BIGGER, card_stats.DVT,
		spr_territory_2, spr_territory_cut_2, spr_territory_art_2, spr_territory_ground_2,
		_effect
	);

array_push(global.territory_cards, _card);

#endregion

#region Card 3

_effect = undefined;

_card = new territory_card(
		3, iniciative_types.BIGGER, card_stats.PWR,
		spr_territory_3, spr_territory_cut_3, spr_territory_art_3, spr_territory_ground_3,
		_effect
	);

array_push(global.territory_cards, _card);

#endregion