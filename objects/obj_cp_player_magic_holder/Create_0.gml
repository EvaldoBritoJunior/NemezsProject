// Inherit the parent event
event_inherited();

update_sprite = function() {
	var _card_instance = 
		card_owner == card_owners.PLAYER ? data.player_champs[field_position] 
			: data.enemy_champs[field_position];
	
	if (_card_instance == noone) {
		sprite_index = -1;
	} else if (field_position == 0){
		sprite_index = _card_instance.card.spr_card_art;
	} else {
		sprite_index = _card_instance.card.spr_cut_card_art;
	}
}

draw_card = function() {
	var layer_id = layer_get_id("Instances_above");
	var _card_instance = 
		card_owner == card_owners.PLAYER ? data.player_champs[field_position] 
			: data.enemy_champs[field_position];
	var _sprite = -1;
	
	if (_card_instance != noone) {
		if (card_owner == card_owners.PLAYER){
			draw_champ_card_instance(_card_instance, x + 230, room_height / 2);
		} else {
			draw_champ_card_instance(_card_instance, x - 230, room_height / 2);
		}
	}
}

update_sprite();

