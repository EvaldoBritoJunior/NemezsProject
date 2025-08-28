data = global.card_phase_data;

redo_func = -1;
return_func = -1;
card_inst = -1;

#region Init stage functions

select_champ_card = function(_field_position, _card_array) {
	var _response = [];
	var _size = array_length(_card_array);
	
	array_push(_response, _card_array[irandom(_size - 1)]);
	
	return _response;
}

select_gear_deck = function(_select_amount, _card_array) {
	var _remove_from = array_full_copy(_card_array);
	var _response = [];
	var _size = array_length(_card_array);
	var _index = -1;
	
	for (var i = 0; i < _select_amount; i++) {
		_index = irandom(_size - 1);
		array_push(_response, _remove_from[_index]);
		array_delete(_remove_from, _index, 1);
		_size--;
	}
	
	return _response;
}

select_magic_deck = function(_select_amount, _card_array) {
	var _remove_from = array_full_copy(_card_array);
	var _response = [];
	var _size = array_length(_card_array);
	var _index = -1;
	
	for (var i = 0; i < _select_amount; i++) {
		_index = irandom(_size - 1);
		array_push(_response, _remove_from[_index]);
		array_delete(_remove_from, _index, 1);
		_size--;
	}
	
	return _response;
}

select_territory_deck = function(_select_amount, _card_array) {
	var _remove_from = array_full_copy(_card_array);
	var _response = [];
	var _size = array_length(_card_array);
	var _index = -1;
	
	for (var i = 0; i < _select_amount; i++) {
		_index = irandom(_size - 1);
		array_push(_response, _remove_from[_index]);
		array_delete(_remove_from, _index, 1);
		_size--;
	}
	
	return _response;
}

#endregion


#region Act stage functions

enemy_prepare_action = function(_options_array, _card_inst, _redo_func, _return_func) {
	card_inst = _card_inst;
	redo_func = _redo_func;
	return_func = _return_func;

	enemy_select_action(_options_array);
}

enemy_select_action = function(_options_array) {
	var _size = array_length(_options_array);
	var _avail_options = [];
	var _option = -1;
	for (var i = 0; i < _size; i++) {
		_option = _options_array[i];
		if (_option.avail && _option.act_func != act_menu_go_back) array_push(_avail_options, _option);
	}
	
	randomize();
	_size = array_length(_avail_options);
	var _selected = irandom(_size - 1);
	_option = _avail_options[_selected];
	var _func = _option.act_func;
	var _args = _option.act_args;
	script_execute_ext(_func, _args);
}

choose_new_vanguard = function(_func, _arg) {
	var _avail_options = [];
	var _champs = data.enemy_champs;
	var _size = array_length(_champs);
	
	for (var i = 1; i < _size; i++) {
		if (_champs[i] != undefined) array_push(_avail_options, i);
	}
	
	_size = array_length(_avail_options);
	var _selected = irandom(_size - 1);
	data.switch_enemy_champs(data, 0, _selected);
	
	_func(_arg);
}

#endregion
