global.champ_qty = 4;
global.max_gear_qty = 3;
global.max_magic_qty = 3;

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
		#region Field
		turn_owner: noone,
		turn_stage: card_phase_stages.INIT_STAGE,
		current_territory: noone,
		#endregion
		
		#region Player
		player_champs: array_create(_champ_qty, noone),
		player_gear_hand: array_create(max_gear_qty, noone),
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
		
		#region Enemy
		enemy_champs: array_create(_champ_qty, noone),
		enemy_gear_hand: array_create(max_gear_qty, noone),
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
		enemy_territory_gyd: []
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