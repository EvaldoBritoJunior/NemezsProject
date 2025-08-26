draw_data();

draw_middle_center(room_width / 2, room_height / 2, data.enemy_champs[0].hp.get_value(), fnt_main_30, c_black);
draw_middle_center(100, 100, 
					$"Magic Hand:\nSize:{data.player_magic_hand_size}\nTrueSize:{array_length(data.player_magic_hand)}\np1:{data.player_magic_hand[0] != noone}\np2:{data.player_magic_hand[1] != noone}\np3:{data.player_magic_hand[2] != noone}", 
					fnt_main_30, c_red);
draw_middle_center(500, 100, 
					$"Gear Hand:\nSize:{data.player_gear_hand_size}\nTrueSize:{array_length(data.player_gear_hand)}\np1:{data.player_gear_hand[0] != noone}\np2:{data.player_gear_hand[1] != noone}\np3:{data.player_gear_hand[2] != noone}", 
					fnt_main_30, c_red)
draw_middle_center(900, 100, 
					$"Card:\nHp:{data.player_champs[0].hp.get_value()}\nMaxHp:{data.player_champs[0].hp.get_max_value()}", 
					fnt_main_30, c_red)