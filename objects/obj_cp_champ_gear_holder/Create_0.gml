// Inherit the parent event
event_inherited();

update_sprite = function() {
	var _card_instance = champ_inst.gears[position];
	card = _card_instance;
}

draw_card = function() {
	var _card_instance = card;
	var _w = sprite_width + 160;
	
	if (_card_instance != undefined) {
		draw_equipped_gear_card(champ_inst, _card_instance, x + _w, room_height / 2);
	}
}

update_sprite();

