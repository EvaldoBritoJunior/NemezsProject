player_card = new champ_instance(global.champ_cards[0], card_owners.PLAYER, 0);
enemy_card = new champ_instance(global.champ_cards[1], card_owners.ENEMY, 0);

player_char = new battle_character(player_card);
enemy_char = new battle_character(enemy_card);

start = function() {
	var _this = self;
	var _x = 135;
	var _y = 515;

	instance_create_depth(_x, _y, depth - 1, obj_bp_player_character, 
		{char: player_char, enemy: enemy_char, manager_inst: _this});

	instance_create_depth(room_width - _x, _y, depth - 2, obj_bp_enemy_character, 
		{char: enemy_char, enemy: player_char, manager_inst: _this});
	
	instance_create_layer(640, 360, "Instances", obj_solid);
}

end_battle = function() {
	game_end();
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
	draw_outline(_x_name, _y_name, player_card.card.name, fnt_main_25);
	draw_healthbar(_x_hp_1, _y_hp_1, _x_hp_2, _y_hp_2, 
		(100 * player_char.hp) / player_char.max_hp, c_black, c_green, c_lime, 0, true, true);
	
	// Enemy Info
	draw_sprite(enemy_card.card.spr_cut_card_art, 0, _width - _x_spr, _y_spr);
	draw_right_outline(_width - _x_name, _y_name, enemy_card.card.name, fnt_main_25);
	draw_healthbar(_width - _x_hp_2 - 1, _y_hp_1, _width - _x_hp_1 - 1, _y_hp_2, 
		(100 * enemy_char.hp) / enemy_char.max_hp, c_black, c_lime, c_lime, 0, true, true);
	
}