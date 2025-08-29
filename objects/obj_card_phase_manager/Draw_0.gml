draw_data();

var _size = array_length(objects_step_order);
var obj = -1;
for (var i = 0; i < _size; i++) {
	obj = objects_step_order[i];
	draw_middle_center(225, 50 + (i * 50), obj.initiative_value, undefined, c_red)
}

if (test_act){
	draw_middle_center(200, 150, 
						$"P Magic Hand:\nSize:{data.player_magic_hand_size}\nTrueSize:{array_length(data.player_magic_hand)}\np1:{data.player_magic_hand[0] != undefined}\np2:{data.player_magic_hand[1] != undefined}\np3:{data.player_magic_hand[2] != undefined}", 
						fnt_main_30, c_yellow);
	draw_middle_center(600, 150, 
						$"P Gear Hand:\nSize:{data.player_gear_hand_size}\nTrueSize:{array_length(data.player_gear_hand)}\np1:{data.player_gear_hand[0] != undefined}\np2:{data.player_gear_hand[1] != undefined}\np3:{data.player_gear_hand[2] != undefined}", 
						fnt_main_30, c_yellow);
	draw_middle_center(1000, 150, 
						$"P Card:\nHp:{data.player_champs[0].hp.get_value()}\nMaxHp:{data.player_champs[0].hp.get_max_value()}", 
						fnt_main_30, c_yellow);
						
						
	draw_middle_center(200, 500, 
						$"E Magic Hand:\nSize:{data.enemy_magic_hand_size}\nTrueSize:{array_length(data.enemy_magic_hand)}\np1:{data.enemy_magic_hand[0] != undefined}\np2:{data.enemy_magic_hand[1] != undefined}\np3:{data.enemy_magic_hand[2] != undefined}", 
						fnt_main_30, c_red);
	draw_middle_center(600, 500, 
						$"E Gear Hand:\nSize:{data.enemy_gear_hand_size}\nTrueSize:{array_length(data.enemy_gear_hand)}\np1:{data.enemy_gear_hand[0] != undefined}\np2:{data.enemy_gear_hand[1] != undefined}\np3:{data.enemy_gear_hand[2] != undefined}", 
						fnt_main_30, c_red);
	draw_middle_center(1000, 500, 
						$"E Card:\nHp:{data.enemy_champs[0].hp.get_value()}\nMaxHp:{data.enemy_champs[0].hp.get_max_value()}", 
						fnt_main_30, c_red);
						
}