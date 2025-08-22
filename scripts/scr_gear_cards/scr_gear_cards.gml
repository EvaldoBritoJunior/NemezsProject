/// @param {real}  _card_id  Unique ID
/// @param {string}  _name  Card name
/// @param {real}  _gw  Card gear weight
/// @param {array}  _stats  Card stats array [pwr, skl, wsd, dvt]
/// @param {real}  _type  Card type (0, 3)
function gear_card(_card_id, _name, _gw, _stats, _type,
					_spr_card, _spr_cut_card, _spr_card_art) constructor {
	card_id = _card_id;
	name = _name;
	gw = _gw;
	stats = _stats;
	type = _type;
	description = $"Descricao :{_card_id}";
	
	spr_card = _spr_card;
	spr_cut_card = _spr_cut_card;
	spr_card_art = _spr_card_art
}

global.gear_cards = [
	new gear_card(
		0, "GEAR NAME", 1, [0, 0, 0, 0], 0,
		spr_sample_gear, spr_sample_cut_gear, spr_sample_gear_art
	), 
	new gear_card(
		1, "GEAR NAME", 2, [4, 3, 2, 1], 1,
		spr_sample_gear, spr_sample_cut_gear, spr_sample_gear_art
	),
	new gear_card(
		2, "GEAR NAME", 3, [1, 2, 3, 4], 2,
		spr_sample_gear, spr_sample_cut_gear, spr_sample_gear_art
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