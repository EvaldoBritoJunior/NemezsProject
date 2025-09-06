enum iniciative_types {
	BIGGER = 0, SMALLER = 1
} 


/// @param {real}  _card_id  Unique ID
/// @param {string}  _name  Card name
/// @param {real}  _iniciative_type  Bigger + or Smaller -
/// @param {real}  _iniciative_stat  Target stat
function territory_card(_card_id, _name, _iniciative_type, _iniciative_stat,
						_spr_card, _spr_cut_card, _spr_card_art,
						_effect = undefined) constructor {
	card_id = _card_id;
	name = _name; 
	iniciative_type = _iniciative_type;
	iniciative_stat = _iniciative_stat;
	description = $"Descricao {_card_id}";
	
	spr_card = _spr_card;
	spr_cut_card = _spr_cut_card;
	spr_card_art = _spr_card_art;
	
	effect = _effect
}

var _ex_effect = function() {
	var _data = global.card_phase_data;
	var _card = _data.enemy_champs[0];
	_card.champ_add_modifier(_card, new modifier(champ_stat_type.HP, 20, value_target.MAX, math_ops.ADD, 1));
	var _card = _data.player_champs[0];
	_card.champ_add_modifier(_card, new modifier(champ_stat_type.HP, 20, value_target.MAX, math_ops.ADD, 1));
}

global.territory_cards = [
	new territory_card(
		0, "TERRITORY N.", iniciative_types.SMALLER, card_stats.PWR,
		spr_sample_territory, spr_sample_cut_territory, spr_sample_territory_art,
		_ex_effect
	), 
	new territory_card(
		1, "TERRITORY N.", iniciative_types.SMALLER, card_stats.SKL,
		spr_sample_territory, spr_sample_cut_territory, spr_sample_territory_art,
		_ex_effect
	),
	new territory_card(
		2, "TERRITORY N.", iniciative_types.SMALLER, card_stats.INT,
		spr_sample_territory, spr_sample_cut_territory, spr_sample_territory_art,
		_ex_effect
	),
	new territory_card(
		3, "TERRITORY N.", iniciative_types.SMALLER, card_stats.DVT,
		spr_sample_territory, spr_sample_cut_territory, spr_sample_territory_art,
		_ex_effect
	),
	new territory_card(
		4, "TERRITORY N.", iniciative_types.SMALLER, card_stats.PWR,
		spr_sample_territory, spr_sample_cut_territory, spr_sample_territory_art,
		_ex_effect
	)
];