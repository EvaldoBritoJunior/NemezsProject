state = bp_enemy_ia_state.ATTACK;
slide = false;
sth_equip = false;
attack_type = 0;

timer_attack_type = 
	time_source_create(time_source_game, 1, time_source_units_seconds,
		function() {
			attack_type = attack_type == 0 ? 1 : 0;
			time_source_start(timer_attack_type);
		}, []
	);
	
timer_attacking = 
	time_source_create(time_source_game, 2, time_source_units_seconds,
		function() {
			state = bp_enemy_ia_state.RETREAT;
			slide = true;
			time_source_start(timer_retreating);
		}, []
	);
	
timer_retreating = 
	time_source_create(time_source_game, 1, time_source_units_seconds,
		function() {
			state = bp_enemy_ia_state.ATTACK;
			sth_equip = true;
			time_source_start(timer_attacking);
		}, []
	);

#region Util functions

player_at_right	= function() {
	var _player_x_pos = player_char.x;
	var _enemy_x_pos = enemy_char.x;
	
	return (_player_x_pos >= _enemy_x_pos)
}

x_distance = function() {
	var _player_x_pos = player_char.x;
	var _enemy_x_pos = enemy_char.x;
	
	return abs(_player_x_pos - _enemy_x_pos);
}

y_distance = function() {
	var _player_y_pos = player_char.y;
	var _enemy_y_pos = enemy_char.y;
	
	return abs(_player_y_pos - _enemy_y_pos);
}

#endregion

#region Control functions

check_right	= function() {
	if (!( instance_exists(player_char) && instance_exists(enemy_char) )) return false;
	var _response = false;
	
	if (x_distance() > 100) {
		if (state == bp_enemy_ia_state.ATTACK && player_at_right()) {
			_response = true;
		} else if (state == bp_enemy_ia_state.RETREAT && !player_at_right()) {
			_response = true;
		}
	}
	
	return _response;
}

check_left	= function() {
	if (!( instance_exists(player_char) && instance_exists(enemy_char) )) return false;
	return (x_distance() > 100 && !check_right());
}

check_up = function() {
	if (!( instance_exists(player_char) && instance_exists(enemy_char) )) return false;
	var _response = false;
	
	if (press_up || !enemy_char.ground) {
		_response = true;
	}
	
	return _response;
}

press_up = function() {
	if (!( instance_exists(player_char) && instance_exists(enemy_char) )) return false;
	var _response = false;
	
	if (enemy_char.ground) {
		if (state == bp_enemy_ia_state.RETREAT && player_char.state == char_state.ATTACKING) {
			_response = true;
		} else if (state == bp_enemy_ia_state.ATTACK && y_distance() > 200) {
			_response = true;
		}
	} 
	
	return _response;
}
	
press_down = function() {
	if (!( instance_exists(player_char) && instance_exists(enemy_char) )) return false;
	var _response = false;
	if (enemy_char.ground && slide) {
		_response = true;
		slide = false;
	}
	return _response;
}

press_attack = function() {
	if (!( instance_exists(player_char) && instance_exists(enemy_char) )) return false;
	var _response = false;
	
	if (attack_type == 0 && state == bp_enemy_ia_state.ATTACK && x_distance() < 130 && y_distance() < 50) {
		_response = true;
	}
	
	return _response;
}

press_equip_atk = function() {
	if (!( instance_exists(player_char) && instance_exists(enemy_char) )) return false;
	var _response = false;
	
	if (attack_type == 1 && state == bp_enemy_ia_state.ATTACK && x_distance() < 130 && y_distance() < 50) {
		_response = true;
	}
	
	return _response;
}

press_sth_equip	= function() {
	if (!( instance_exists(player_char) && instance_exists(enemy_char) )) return false;
	var _response = false;
	
	if (sth_equip) {
		_response = true;
		sth_equip = false;
	}
	return _response;
}

#endregion

time_source_start(timer_attacking);
time_source_start(timer_attack_type);