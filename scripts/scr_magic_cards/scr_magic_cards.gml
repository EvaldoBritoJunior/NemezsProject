/// @param {real}  _card_id  Unique ID
/// @param {string}  _name  Card name
/// @param {real}  _md  Card magic degree
function magic_card(_card_id, _name, _md,
					_spr_card, _spr_cut_card, _spr_card_art
					, _ability = noone) constructor {
	card_id = _card_id;
	name = _name;
	md = _md;
	description = $"Descricao :{_card_id}";
	
	spr_card = _spr_card;
	spr_cut_card = _spr_cut_card;
	spr_card_art = _spr_card_art;
	
	card_ability = _ability;
}

var _20_dmg_func = function(_inst) {
	var _data = global.card_phase_data;
	var _card_t = _data.enemy_champs[0];
	_inst.champ_add_modifier(_inst, new modifier(champ_stat_type.HP, -20, value_target.BASE));
	end_act_menu();
};
	
var _select_20_dmg = function(_inst) {
	var _act_pass = new act_option(global.language.act_pass, 
		function() {
			end_act_menu();
		}, [self], 
		-1, [],
		-1, []);
	var _options = [_act_pass, _act_pass, _act_pass];
	script_execute_ext(create_act_sub_menu, [_options]);
};
	
var _true = function(_inst) {return true}

global.magic_cards = [
	new magic_card(
		0, "MAGIC NAME", 1,
		spr_sample_magic, spr_sample_cut_magic, spr_sample_magic_art,
		new ability(_select_20_dmg, _true)
	), 
	new magic_card(
		1, "MAGIC NAME", 2,
		spr_sample_magic, spr_sample_cut_magic, spr_sample_magic_art,
		new ability(_20_dmg_func, _true)
	),
	new magic_card(
		2, "MAGIC NAME", 2,
		spr_sample_magic, spr_sample_cut_magic, spr_sample_magic_art,
		new ability(_20_dmg_func, _true)
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