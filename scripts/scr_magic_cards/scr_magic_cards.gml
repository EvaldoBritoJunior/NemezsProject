/// @param {real}  _card_id  Unique ID
/// @param {string}  _name  Card name
/// @param {real}  _md  Card magic degree
function magic_card(_card_id, _name, _md,
					_spr_card, _spr_cut_card, _spr_card_art) constructor {
	card_id = _card_id;
	name = _name;
	md = _md;
	description = "Descricao";
	
	spr_card = _spr_card;
	spr_cut_card = _spr_cut_card;
	spr_card_art = _spr_card_art
}


global.magic_cards = [
	new magic_card(
		0, "MAGIC NAME", 1,
		spr_sample_magic, spr_sample_cut_magic, spr_sample_magic_art
	), 
	new magic_card(
		1, "MAGIC NAME", 2,
		spr_sample_magic, spr_sample_cut_magic, spr_sample_magic_art
	),
	new magic_card(
		2, "MAGIC NAME", 3,
		spr_sample_magic, spr_sample_cut_magic, spr_sample_magic_art
	),
	new magic_card(
		3, "MAGIC NAME", 1,
		spr_sample_magic, spr_sample_cut_magic, spr_sample_magic_art
	),
	new magic_card(
		4, "MAGIC NAME", 2,
		spr_sample_magic, spr_sample_cut_magic, spr_sample_magic_art
	),
	new magic_card(
		5, "MAGIC NAME", 3,
		spr_sample_magic, spr_sample_cut_magic, spr_sample_magic_art
	),
	new magic_card(
		6, "MAGIC NAME", 3,
		spr_sample_magic, spr_sample_cut_magic, spr_sample_magic_art
	),
	new magic_card(
		7, "MAGIC NAME", 2,
		spr_sample_magic, spr_sample_cut_magic, spr_sample_magic_art
	),
	new magic_card(
		8, "MAGIC NAME", 1,
		spr_sample_magic, spr_sample_cut_magic, spr_sample_magic_art
	),
	new magic_card(
		9, "MAGIC NAME", 2,
		spr_sample_magic, spr_sample_cut_magic, spr_sample_magic_art
	)
];