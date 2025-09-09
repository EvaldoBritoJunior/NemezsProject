/// @param {real}  _card_id  Unique ID
/// @param {real}  _md  Card magic degree
function magic_card(_card_id, _md,
					_spr_card, _spr_cut_card, _spr_card_art, 
					_ability = undefined) constructor {
	card_id = _card_id;
	md = _md;
	
	spr_card = _spr_card;
	spr_cut_card = _spr_cut_card;
	spr_card_art = _spr_card_art;
	
	card_ability = _ability;
}

var _20_dmg_func = function(_inst) {
	var _data = global.card_phase_data;
	_inst.champ_add_modifier(_inst, new modifier(champ_stat_type.HP, -20, value_target.BASE));
	end_act_menu(_inst);
};
	
var _select_20_dmg = function(_inst) {
	var _act_pass = new act_option(
		global.language.act_pass, 
		end_act_menu, [_inst, self], 
		undefined, [],
		undefined, []
	);
	var _options = [_act_pass, _act_pass, _act_pass];
	script_execute_ext(create_act_sub_menu, [_inst, _options]);
};
	
var _true = function(_inst) {return true}

global.magic_cards = [];

#region Card 0

var _ability = undefined;

var _card = new magic_card(
		0, 1,
		spr_magic_0, spr_magic_cut_0, spr_magic_art_0,
		_ability
	);

array_push(global.magic_cards, _card);

#endregion

#region Card 1

_ability = undefined;

_card = new magic_card(
		1, 1,
		spr_magic_1, spr_magic_cut_1, spr_magic_art_1,
		_ability
	);

array_push(global.magic_cards, _card);

#endregion

#region Card 2

_ability = undefined;

_card = new magic_card(
		2, 1,
		spr_magic_2, spr_magic_cut_2, spr_magic_art_2,
		_ability
	);

array_push(global.magic_cards, _card);

#endregion

#region Card 3

_ability = undefined;

_card = new magic_card(
		3, 2,
		spr_magic_3, spr_magic_cut_3, spr_magic_art_3,
		_ability
	);

array_push(global.magic_cards, _card);

#endregion

#region Card 4

_ability = undefined;

_card = new magic_card(
		4, 2,
		spr_magic_4, spr_magic_cut_4, spr_magic_art_4,
		_ability
	);

array_push(global.magic_cards, _card);

#endregion

#region Card 5

_ability = undefined;

_card = new magic_card(
		5, 2,
		spr_magic_5, spr_magic_cut_5, spr_magic_art_5,
		_ability
	);

array_push(global.magic_cards, _card);

#endregion

#region Card 6

_ability = undefined;

_card = new magic_card(
		6, 3,
		spr_magic_6, spr_magic_cut_6, spr_magic_art_6,
		_ability
	);

array_push(global.magic_cards, _card);

#endregion

#region Card 7

_ability = undefined;

_card = new magic_card(
		7, 4,
		spr_magic_7, spr_magic_cut_7, spr_magic_art_7,
		_ability
	);

array_push(global.magic_cards, _card);

#endregion