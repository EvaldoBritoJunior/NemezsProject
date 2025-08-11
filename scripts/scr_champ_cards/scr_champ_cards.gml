/// @param {real}  _card_id  Unique ID
/// @param {string}  _name  Card name
/// @param {real}  _hp  Card health points
/// @param {real}  _gw  Card gear weight
/// @param {real}  _md  Card magic degree
/// @param {array}  _stats  Card stats array [pwr, skl, wsd, dvt]
function champ_card(_card_id, _name, _hp, _gw, _md, _stats, 
					_spr_card, _spr_cut_card, _spr_card_art, _spr_cut_card_art) constructor {
	card_id = _card_id;
	name = _name;
	hp = _hp;
	gw = _gw;
	md = _md;
	stats = [6, 5, 4, 3];
	description = "Descricao";
	
	spr_card = _spr_card;
	spr_cut_card = _spr_cut_card;
	spr_card_art = _spr_card_art;
	spr_cut_card_art = _spr_cut_card_art
}

global.champ_cards = [
	new champ_card(
		0, "FIMOSE DRAGON", 230, 3, 2, [6, 5, 4, 3],
		spr_sample_card, spr_sample_half_card, spr_sample_card_art, spr_sample_half_art
	), 
	new champ_card(
		1, "FIMOSE DRAGON", 230, 3, 2, [6, 5, 4, 3],
		spr_sample_card, spr_sample_half_card, spr_sample_card_art, spr_sample_half_art
	),
	new champ_card(
		2, "FIMOSE DRAGON", 230, 3, 2, [6, 5, 4, 3],
		spr_sample_card, spr_sample_half_card, spr_sample_card_art, spr_sample_half_art
	),
	new champ_card(
		3, "FIMOSE DRAGON", 230, 3, 2, [6, 5, 4, 3],
		spr_sample_card, spr_sample_half_card, spr_sample_card_art, spr_sample_half_art
	),
	new champ_card(
		4, "FIMOSE DRAGON", 230, 3, 2, [6, 5, 4, 3],
		spr_sample_card, spr_sample_half_card, spr_sample_card_art, spr_sample_half_art
	),
	new champ_card(
		5, "FIMOSE DRAGON", 230, 3, 2, [6, 5, 4, 3],
		spr_sample_card, spr_sample_half_card, spr_sample_card_art, spr_sample_half_art
	),
	new champ_card(
		6, "FIMOSE DRAGON", 230, 3, 2, [6, 5, 4, 3],
		spr_sample_card, spr_sample_half_card, spr_sample_card_art, spr_sample_half_art
	),
	new champ_card(
		7, "FIMOSE DRAGON", 230, 3, 2, [6, 5, 4, 3],
		spr_sample_card, spr_sample_half_card, spr_sample_card_art, spr_sample_half_art
	)
];