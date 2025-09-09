//player_card = new champ_instance(global.champ_cards[1], card_owners.PLAYER, 0);
//player_card.gears = global.gear_cards;
//enemy_card = new champ_instance(global.champ_cards[4], card_owners.ENEMY, 0);

player_card = global.card_phase_data.player_champs[0];
enemy_card = global.card_phase_data.enemy_champs[0];

player_char = new battle_character(player_card);
enemy_char = new battle_character(enemy_card);

start = function() {
	var _this = self;
	var _x = 135;
	var _y = 515;
	var _card_instance = global.card_phase_data.current_territory;
	if (_card_instance == undefined) var _card_instance = global.territory_cards[0];
    var _background_id = layer_get_id("Background");
    var _background_element_id = layer_background_get_id(_background_id);
	
	if (_card_instance == undefined) {
		layer_background_sprite(_background_element_id, spr_field_default);
		instance_create_layer(640, 360, "Instances", obj_solid);
	} else {
		layer_background_sprite(_background_element_id, _card_instance.spr_card_art);
		instance_create_layer(640, 360, "Instances", obj_solid, {sprite_index: _card_instance.spr_card_ground});
	}
	
	var _enemy_ia_inst = instance_create_layer(x, y, "Instances", obj_bp_enemy_ia);

	var _player_char_inst = instance_create_depth(_x, _y, depth - 1, obj_bp_player_character, 
		{char: player_char, enemy: enemy_char, manager_inst: _this});

	var _enemy_char_inst = instance_create_depth(room_width - _x, _y, depth - 2, obj_bp_enemy_character, 
		{char: enemy_char, enemy: player_char, manager_inst: _this, ia: _enemy_ia_inst});
		
	_enemy_ia_inst.player_char = _player_char_inst;
	_enemy_ia_inst.enemy_char = _enemy_char_inst;
}

end_battle = function() {
	global.card_phase_data.turn_stage = card_phase_stages.END_STAGE;
	
	object_set_sprite(obj_sq_util, player_card.card.spr_card_art);
	object_set_sprite(obj_sq_util_II, enemy_card.card.spr_card_art);
	transition_start(rm_card_phase, sq_into_battle, sq_out_battle);
}

draw_stats = function() {
	draw_sprite(spr_bp_field_marks, 0, 640, 360);
	var _width = room_width;
	var _x_spr = 121;
	var _y_spr = 125;
	
	var _x_name = 235;
	var _y_name = 88;
	
	var _x_hp_1 = 23;
	var _y_hp_1 = 50;
	var _x_hp_2 = 554;
	var _y_hp_2 = 87;
	
	// Player info
	draw_sprite(player_card.card.spr_cut_card_art, 0, _x_spr, _y_spr);
	
	var _name = global.language.champ_names[player_card.card.card_id];
	draw_outline(_x_name, _y_name, _name, fnt_main_25);
	
	draw_healthbar(_x_hp_1, _y_hp_1, _x_hp_2, _y_hp_2, 
		(100 * player_char.hp) / player_char.max_hp, c_black, c_green, c_lime, 0, true, true);
	
	// Enemy Info
	draw_sprite(enemy_card.card.spr_cut_card_art, 0, _width - _x_spr, _y_spr);
	
	_name = global.language.champ_names[enemy_card.card.card_id];
	draw_right_outline(_width - _x_name, _y_name, _name, fnt_main_25);
	
	draw_healthbar(_width - _x_hp_2 - 1, _y_hp_1, _width - _x_hp_1 - 1, _y_hp_2, 
		(100 * enemy_char.hp) / enemy_char.max_hp, c_black, c_green, c_lime, 0, true, true);
	
}
	
set_card_phase_data(player_char, enemy_char);