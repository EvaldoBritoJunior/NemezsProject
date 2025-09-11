global.max_gear_qty = 3;
global.max_magic_qty = 3;
global.cp_layer_instances_above = "Instances_above";
global.cp_layer_assets_below = "Assets_below";

global.card_phase_data = -1;

enum card_phase_stages {
	INIT_STAGE, ACT_STAGE, END_STAGE
} 

enum card_owners {
	PLAYER, ENEMY
} 

enum card_positions {
	VANGUARD, REARI, REARII, REARIII
} 
	
enum card_phase_winners {
	NOBODY, PLAYER, ENEMY, DRAW
} 

function reset_card_phase_data(_champ_qty = 4) {
	
	global.card_phase_data = {
		enemy_name: "Nemesis",
		champ_qty: _champ_qty,
		#region Field Vars
		turn_owner: undefined,
		turn_stage: card_phase_stages.INIT_STAGE,
		current_territory: undefined,
		#endregion
		
		#region Player Vars
		player_champs: array_create(_champ_qty, undefined),
		player_gear_hand_size: 0,
		player_gear_hand: array_create(global.max_gear_qty, undefined),
		player_magic_hand_size: 0,
		player_magic_hand: array_create(global.max_magic_qty, undefined),
		
		player_gear_orig_deck: [],
		player_magic_orig_deck: [],
		player_territory_orig_deck: [],
		
		player_gear_deck: [],
		player_magic_deck: [],
		player_territory_deck: [],
		
		player_champs_gyd: [],
		player_gear_gyd: [],
		player_magic_gyd: [],
		player_territory_gyd: [],
		#endregion
		
		#region Enemy Vars
		enemy_champs: array_create(_champ_qty, undefined),
		enemy_gear_hand_size: 0,
		enemy_gear_hand: array_create(global.max_gear_qty, undefined),
		enemy_magic_hand_size: 0,
		enemy_magic_hand: array_create(global.max_magic_qty, undefined),
		
		enemy_gear_orig_deck: [],
		enemy_magic_orig_deck: [],
		enemy_territory_orig_deck: [],
		
		enemy_gear_deck: [],
		enemy_magic_deck: [],
		enemy_territory_deck: [],
		
		enemy_champs_gyd: [],
		enemy_gear_gyd: [],
		enemy_magic_gyd: [],
		enemy_territory_gyd: [],
		#endregion
		
		#region Draw Card Functions
		player_draw_gear: function() {
			var _response = undefined;
			var _size = -1;
			var _index = -1;
			
			if (!(player_gear_hand_size >= global.max_gear_qty)) {
				_size = array_length(player_gear_deck);
				if (_size == 0) {
					player_gear_deck = array_full_copy(player_gear_orig_deck);
					_size = array_length(player_gear_deck);
				}
				
				_index = irandom(_size - 1);
				_response = player_gear_deck[_index];
				array_delete(player_gear_deck, _index, 1);
				player_gear_hand[player_gear_hand_size] = _response;
				player_gear_hand_size++;
			}
			
			return _response;
		},
		
		player_draw_magic: function() {
		    var _response = undefined;
			var _size = -1;
			var _index = -1;
			
			if (!(player_magic_hand_size >= global.max_magic_qty)) {
				_size = array_length(player_magic_deck);
				if (_size == 0) {
					player_magic_deck = array_full_copy(player_magic_orig_deck);
					_size = array_length(player_magic_deck);
				}
				
				_index = irandom(_size - 1);
				_response = player_magic_deck[_index];
				array_delete(player_magic_deck, _index, 1);
				player_magic_hand[player_magic_hand_size] = _response;
				player_magic_hand_size++;
			}
			
			return _response;
		},
		
		player_draw_territory: function() {
		    var _response = undefined;
			var _size = -1;
			var _index = -1;

			_size = array_length(player_territory_deck);
			if (_size == 0) {
				player_territory_deck = array_full_copy(player_territory_orig_deck);
				_size = array_length(player_territory_deck);
			}
				
			_index = irandom(_size - 1);
			_response = player_territory_deck[_index];
			array_delete(player_territory_deck, _index, 1);
			
			return _response;
		},
		
		enemy_draw_gear: function() {
		    var _response = undefined;
			var _size = -1;
			var _index = -1;
			
			if (!(enemy_gear_hand_size >= global.max_gear_qty)) {
				_size = array_length(enemy_gear_deck);
				if (_size == 0) {
					enemy_gear_deck = array_full_copy(enemy_gear_orig_deck);
					_size = array_length(enemy_gear_deck);
				}
				
				_index = irandom(_size - 1);
				_response = enemy_gear_deck[_index];
				array_delete(enemy_gear_deck, _index, 1);
				enemy_gear_hand[enemy_gear_hand_size] = _response;
				enemy_gear_hand_size++;
			}
			
			return _response;
		},
		
		enemy_draw_magic: function() {
		    var _response = undefined;
			var _size = -1;
			var _index = -1;
			
			if (!(enemy_magic_hand_size >= global.max_magic_qty)) {
				_size = array_length(enemy_magic_deck);
				if (_size == 0) {
					enemy_magic_deck = array_full_copy(enemy_magic_orig_deck);
					_size = array_length(enemy_magic_deck);
				}
				
				_index = irandom(_size - 1);
				_response = enemy_magic_deck[_index];
				array_delete(enemy_magic_deck, _index, 1);
				enemy_magic_hand[enemy_magic_hand_size] = _response;
				enemy_magic_hand_size++;
			}
			
			return _response;
		},
		
		enemy_draw_territory: function() {
		    var _response = undefined;
			var _size = -1;
			var _index = -1;

			_size = array_length(enemy_territory_deck);
			if (_size == 0) {
				enemy_territory_deck = array_full_copy(enemy_territory_orig_deck);
				_size = array_length(enemy_territory_deck);
			}
				
			_index = irandom(_size - 1);
			_response = enemy_territory_deck[_index];
			array_delete(enemy_territory_deck, _index, 1);
			
			return _response;
		},
		
		#endregion
		
		#region Switch Cards Functions
		
		switch_player_champs: function(_data, _pos1, _pos2, _bool_end_select = false) {
			var _champs = _data.player_champs;
			var _c1 = _champs[_pos1];
			var _c2 = _champs[_pos2];
			
			if (_c1 != undefined) _c1.card_pos = _pos2;
			if (_c2 != undefined) _c2.card_pos = _pos1;
			
			_champs[_pos1] = _c2;
			_champs[_pos2] = _c1;
			
			if (_bool_end_select) end_act_menu(_c2);
		},
		
		switch_enemy_champs: function(_data, _pos1, _pos2, _bool_end_select = false) {
			var _champs = _data.enemy_champs;
			var _c1 = _champs[_pos1];
			var _c2 = _champs[_pos2];
			
			if (_c1 != undefined) _c1.card_pos = _pos2;
			if (_c2 != undefined) _c2.card_pos = _pos1;
			
			_champs[_pos1] = _c2;
			_champs[_pos2] = _c1;
			
			if (_bool_end_select) end_act_menu(_c2);
		},
		
		#endregion
		
		#region Remove Card Functions
		
		player_rmv_champ: function(_idx) {
			var _champ = player_champs[_idx];
			_champ.remove_gears(_champ);
			array_push(player_champs_gyd, _champ);
			player_champs[_idx] = undefined;
		},
		
		player_rmv_gear: function(_idx) {
			if (player_gear_hand_size == 0) throw("Tried to remove player gear with empty hand");
			player_gear_hand_size--;
			array_delete(player_gear_hand, _idx, 1);
			array_push(player_gear_hand, undefined);
		},
		
		player_rmv_magic: function(_idx) {
			if (player_magic_hand_size <= _idx) throw($"Tried to remove player magic {_idx} with hand size {player_magic_hand_size}");
			var _magic = player_magic_hand[_idx];
			player_magic_hand_size--;
			array_delete(player_magic_hand, _idx, 1);
			array_push(player_magic_hand, undefined);
			array_push(player_magic_gyd, _magic);
		},
		
		enemy_rmv_champ: function(_idx) {
			var _champ = enemy_champs[_idx];
			_champ.remove_gears(_champ);
			array_push(enemy_champs_gyd, _champ);
			enemy_champs[_idx] = undefined;
		},
		
		enemy_rmv_gear: function(_idx) {
			if (enemy_gear_hand_size == 0) throw("Tried to remove enemy gear with empty hand");
			enemy_gear_hand_size--;
			array_delete(enemy_gear_hand, _idx, 1);
			array_push(enemy_gear_hand, undefined);
		},
		
		enemy_rmv_magic: function(_idx) {
			if (enemy_magic_hand_size <= _idx) throw($"Tried to remove enemy magic {_idx} with hand size {enemy_magic_hand_size}");
			var _magic = enemy_magic_hand[_idx];
			enemy_magic_hand_size--;
			array_delete(enemy_magic_hand, _idx, 1);
			array_push(enemy_magic_hand, undefined);
			array_push(enemy_magic_gyd, _magic);
		},
		
		#endregion
		
		#region Check Field Functions
		
		check_champs_hp: function() {
			var _champ = -1;
			var _return = false;
			
			for (var i = 0; i < champ_qty; i++) {
				_champ = player_champs[i];
				if (_champ != undefined && _champ.hp.get_value() == 0) {
					player_rmv_champ(i);
					_return = true;
				}
				
				_champ = enemy_champs[i];
				if (_champ != undefined && _champ.hp.get_value() == 0) {
					enemy_rmv_champ(i);
					_return = true;
				}
			}
			
			return _return;
		},
			
		check_victory: function() {
			var _player_lost = true;
			var _enemy_lost = true;
			var _return = card_phase_winners.NOBODY;
			
			for (var i = 0; i < champ_qty; i++) {
				if (player_champs[i] != undefined) {
					_player_lost = false;
					break;
				}
			}
			
			for (var i = 0; i < champ_qty; i++) {
				if (enemy_champs[i] != undefined) {
					_enemy_lost = false;
					break;
				}
			}
			
			if (_player_lost && _enemy_lost) {
				_return = card_phase_winners.DRAW;
			} else if (_player_lost) {
				_return = card_phase_winners.ENEMY;
			} else if (_enemy_lost) {
				_return = card_phase_winners.PLAYER;
			}
			
			return _return;
		},
			
		#endregion
		
		#region Apply Functions
		apply_passives_all: function() {
			var _champ = -1;
			for (var i = 0; i < champ_qty; i++) {
				_champ = player_champs[i];
				if (_champ != undefined) _champ.champ_apply_passives(_champ);
				
				_champ = enemy_champs[i];
				if (_champ != undefined) _champ.champ_apply_passives(_champ);
			}
		},
		
		reduce_modifiers_duration_all: function() {
			var _champ = -1;
			for (var i = 0; i < champ_qty; i++) {
				_champ = player_champs[i];
				if (_champ != undefined) _champ.champ_reduce_modifiers_duration(_champ);
				
				_champ = enemy_champs[i];
				if (_champ != undefined) _champ.champ_reduce_modifiers_duration(_champ);
			}
		},
		
		apply_battle_result: function() {
			var _battle_data = global.battle_phase_data;
			var _champ = -1;
			var _curr_hp = -1;
			
			if (_battle_data.player_char.hp <= 0) {
				player_rmv_champ(0);
			} else {
				_champ = player_champs[0];
				_curr_hp = _champ.hp.get_value();
				_champ.champ_add_modifier(
					_champ, new modifier(champ_stat_type.HP, _battle_data.player_char.hp - _curr_hp, value_target.BASE)
				);
			}
			if (_battle_data.enemy_char.hp <= 0) {
				enemy_rmv_champ(0);
			} else {
				_champ = enemy_champs[0];
				_curr_hp = _champ.hp.get_value();
				_champ.champ_add_modifier(
					_champ, new modifier(champ_stat_type.HP, _battle_data.enemy_char.hp - _curr_hp, value_target.BASE)
				);
			}
		}
		
		#endregion
			
	}
	
}

function get_position_name(_pos) {
	switch (_pos)
	{
	    case card_positions.VANGUARD:
	        return "VANGUARD";
	    case card_positions.REARI:
	        return "REARI";
		case card_positions.REARII:
	        return "REARII";
		case card_positions.REARIII:
	        return "REARIII";
		default:
			throw $"Invalid position: {_pos}";
	}
}

reset_card_phase_data(1);