enum card_stats {
	PWR = 0, SKL = 1, INT = 2, DVT = 3
} 

enum iniciative_types {
	BIGGER = 0, SMALLER = 1
} 


/// @param {real}  _card_id  Unique ID
/// @param {string}  _name  Card name
/// @param {real}  _iniciative_type  Bigger + or Smaller -
/// @param {real}  _iniciative_stat  Target stat
function territory_card(_card_id, _name, _iniciative_type, _iniciative_stat,
						_spr_card, _spr_cut_card, _spr_card_art) constructor {
	card_id = _card_id;
	name = _name; 
	iniciative_type = _iniciative_type;
	iniciative_stat = _iniciative_stat;
	description = "Descricao";
	
	spr_card = _spr_card;
	spr_cut_card = _spr_cut_card;
	spr_card_art = _spr_card_art
}

global.territory_cards = [
	new territory_card(
		0, "TERRITORY N.", iniciative_types.BIGGER, card_stats.PWR,
		spr_sample_territory, spr_sample_cut_territory, spr_sample_territory_art
	), 
	new territory_card(
		1, "TERRITORY N.", iniciative_types.BIGGER, card_stats.SKL,
		spr_sample_territory, spr_sample_cut_territory, spr_sample_territory_art
	),
	new territory_card(
		2, "TERRITORY N.", iniciative_types.BIGGER, card_stats.INT,
		spr_sample_territory, spr_sample_cut_territory, spr_sample_territory_art
	),
	new territory_card(
		3, "TERRITORY N.", iniciative_types.BIGGER, card_stats.DVT,
		spr_sample_territory, spr_sample_cut_territory, spr_sample_territory_art
	),
	new territory_card(
		4, "TERRITORY N.", iniciative_types.BIGGER, card_stats.PWR,
		spr_sample_territory, spr_sample_cut_territory, spr_sample_territory_art
	)
];