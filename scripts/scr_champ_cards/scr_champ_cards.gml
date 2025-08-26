enum card_types {
	GRAY = 0, RED = 1, BLUE = 2, GOLD = 3
} 

function passive(_modifiers, _avail_func) constructor {
	modifiers  = _modifiers;
	avail_func = _avail_func;
    avail = false;
}

function ability(_act_func, _avail_func) constructor {
	act_func = _act_func;
	avail_func = _avail_func;
    avail = false;
}

/// @param {real}  _card_id  Unique ID
/// @param {string}  _name  Card name
/// @param {real}  _hp  Card health points
/// @param {real}  _gw  Card gear weight
/// @param {real}  _md  Card magic degree
/// @param {array}  _stats  Card stats array [pwr, skl, wsd, dvt]
/// @param {real}  _type  Card type (0, 3)
function champ_card(_card_id, _name, _hp, _gw, _md, _stats, _type,
					_spr_card, _spr_cut_card, _spr_card_art, _spr_cut_card_art,
					_passive = -1, _ability = -1) constructor {
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

global.champ_cards = [
	new champ_card(
		0, "CHAMP NAME", 230, 2, 2, [6, 5, 4, 3], 0,
		spr_sample_card, spr_sample_cut_card, spr_sample_card_art, spr_sample_half_art
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