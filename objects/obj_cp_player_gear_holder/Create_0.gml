// Inherit the parent event
event_inherited();

update_sprite = function() {
	var _card_instance = data.player_gear_hand[field_position];
	card = _card_instance;
	if (_card_instance == noone) {
		sprite_index = -1;
	} else {
		sprite_index = _card_instance.spr_card_art;
	}
}

draw_card = function() {
	var _card_instance = card;
	
	if (_card_instance != noone) {
		draw_gear_card(_card_instance, x, room_height / 2);
	}
}

update_sprite();

