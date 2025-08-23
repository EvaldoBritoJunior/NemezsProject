// Inherit the parent event
event_inherited();

update_sprite = function() {
	var _card_instance = data.current_territory;
    var _background_id = layer_get_id("Background");
    var _background_element_id = layer_background_get_id(_background_id);
	var _assets_below_id = layer_get_id(global.cp_layer_assets_below);
	
	if (_card_instance == noone) {
		visible = false;
		layer_set_visible(_assets_below_id, true);
		layer_background_sprite(_background_element_id, spr_field_default);
	} else {
		visible = true;
		layer_set_visible(_assets_below_id, false);
		layer_background_sprite(_background_element_id, _card_instance.spr_card_art);
	}
}

draw_card = function() {
	var _card_instance = data.current_territory;
	var _x = data.turn_owner == card_owners.PLAYER ? x - 230 : x + 230;
	
	if (_card_instance != noone) {
		draw_territory_card(_card_instance, _x, room_height / 2);
	}
}

update_sprite();