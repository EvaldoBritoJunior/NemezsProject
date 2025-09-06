enum bp_enemy_ia_state {
	ATTACK, RETREAT
}

global.battle_phase_data = -1;

function set_card_phase_data(_player_char, _enemy_char) {
	global.battle_phase_data = {
		player_char: _player_char,
		enemy_char: _enemy_char
	}
	
}