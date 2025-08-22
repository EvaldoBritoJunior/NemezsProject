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

