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

function champ_instance(_card) constructor {
	hp = _card.hp;
	stats = array_full_copy(_card.stats);
	type = _card.type;
	
	card = _card;
}

function reset_card_phase_data(_champ_qty = 4) {
	
	global.card_phase_data = {
		enemy_name: "Nemesis",
		champ_qty: _champ_qty,
		#region Field Vars
		turn_owner: noone,
		turn_stage: card_phase_stages.INIT_STAGE,
		current_territory: noone,
		#endregion
		
		#region Player Vars
		player_champs: array_create(_champ_qty, noone),
		player_gear_hand_size: 0,
		player_gear_hand: array_create(max_gear_qty, noone),
		player_magic_hand_size: 0,
		player_magic_hand: array_create(max_magic_qty, noone),
		
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
		enemy_champs: array_create(_champ_qty, noone),
		enemy_gear_hand_size: 0,
		enemy_gear_hand: array_create(max_gear_qty, noone),
		enemy_magic_hand_size: 0,
		enemy_magic_hand: array_create(max_magic_qty, noone),
		
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
		playerDrawGear: function() {
			var _response = noone;
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
		
		playerDrawMagic: function() {
		    var _response = noone;
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
		
		playerDrawTerritory: function() {
		    var _response = noone;
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
		
		enemyDrawGear: function() {
		    var _response = noone;
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
		
		enemyDrawMagic: function() {
		    var _response = noone;
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
		
		enemyDrawTerritory: function() {
		    var _response = noone;
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

reset_card_phase_data();