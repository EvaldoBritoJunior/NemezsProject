// Inherit the parent event
event_inherited();

update_sprite = function() {
	var _card_instance = data.enemy_gear_hand[field_position];
	card = _card_instance;
	
	if (_card_instance == undefined) {
		sprite_index = -1;
	} else {
		sprite_index = spr_enemy_magic_mark;
	}
}

update_sprite();

