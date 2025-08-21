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
	description = "Descricao";
	
	spr_card = _spr_card;
	spr_cut_card = _spr_cut_card;
	spr_card_art = _spr_card_art
}

global.gear_cards = [
	new gear_card(
		0, "FIMOSE DRAGON", 3, [6, 5, 4, 3], 0,
		spr_sample_gear, spr_sample_cut_gear, spr_sample_card_art
	), 
	new gear_card(
		1, "FIMOSE DRAGON", 3, [6, 5, 4, 3], 1,
		spr_sample_gear, spr_sample_cut_gear, spr_sample_card_art
	),
	new gear_card(
		2, "FIMOSE DRAGON", 3, [6, 5, 4, 3], 2,
		spr_sample_gear, spr_sample_cut_gear, spr_sample_card_art
	),
	new gear_card(
		3, "FIMOSE DRAGON", 3, [6, 5, 4, 3], 3,
		spr_sample_gear, spr_sample_cut_gear, spr_sample_card_art
	),
	new gear_card(
		4, "FIMOSE DRAGON", 3, [6, 5, 4, 3], 3,
		spr_sample_gear, spr_sample_cut_gear, spr_sample_card_art
	),
	new gear_card(
		5, "FIMOSE DRAGON", 3, [6, 5, 4, 3], 2,
		spr_sample_gear, spr_sample_cut_gear, spr_sample_card_art
	),
	new gear_card(
		6, "FIMOSE DRAGON", 3, [6, 5, 4, 3], 1,
		spr_sample_gear, spr_sample_cut_gear, spr_sample_card_art
	),
	new gear_card(
		7, "FIMOSE DRAGON", 3, [6, 5, 4, 3], 0,
		spr_sample_gear, spr_sample_cut_gear, spr_sample_card_art
	),
	new gear_card(
		8, "FIMOSE DRAGON", 3, [6, 5, 4, 3], 0,
		spr_sample_gear, spr_sample_cut_gear, spr_sample_card_art
	),
	new gear_card(
		9, "FIMOSE DRAGON", 3, [6, 5, 4, 3], 1,
		spr_sample_gear, spr_sample_cut_gear, spr_sample_card_art
	)
];