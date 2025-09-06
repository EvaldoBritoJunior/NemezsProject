#region Variables

champ_attack = char.champ_attack;
gears_attacks = char.gears_attacks;
gears_size = array_length(gears_attacks);
selected_gear = gears_size == 0 ? -1 : 0;
dying = false;

// Directions
left = 1;
right = -1;
image_xscale = left;

// Input
check_right = false;
check_left  = false;
press_up    = false;
press_down  = false;

// Current speed
vel = 0;

//Attack variables
selected_attack = champ_attack;
selected_attack_orig = attack_orig.CHAMPION;
state = char_state.FREE;
press_attack_holder	= false;
attack_step = 0;
can_sprite_change = true;

// Bounds variables
LEFT_BOUND  = 50;
RIGHT_BOUND = 1230;
MARGIN      = 5;

//Physics variables
grav = 0.25 * 5;
jump_speed = (4.75 + grav) * 5;
walk_speed = 1.3 * 5;
max_vspeed = 7 * 5;
step_speed = 1/7 * 5;
step_frames = 7;
slide_speed = 2.5 * 5;
slide_frames = 26;

//Sprites variables
char_spr_stand = char.char_spr_stand;
char_spr_step = char.char_spr_step;
char_spr_jump = char.char_spr_jump;
char_spr_walk = char.char_spr_walk;
char_spr_slide = char.char_spr_slide;

//ETC
ground = true;
init_step = true;
is_step = false;
step_timer = 0;
can_min_jump = true;
#endregion

#region Util Functions

sth_equip = function() {
	if (gears_size > 1) {
		selected_gear = (selected_gear == gears_size - 1) ? 0 : selected_gear + 1;
	}
}

check_animation_end = function() {
	var _sprite = sprite_index;
	var _image = image_index;
	if (argument_count > 0) _sprite = argument[0];
	if (argument_count > 1) _image = argument[1];
	
	var _type = sprite_get_speed_type(sprite_index);
	var _spd = sprite_get_speed(sprite_index) * image_speed;
	
	if (_type == spritespeed_framespersecond) _spd = _spd/room_speed;
	if (argument_count > 2) _spd = argument[2];
	
	return _image + _spd >= sprite_get_number(_sprite);
}

#endregion

#region Movement Functions

create_attack = function(_attack_chain, _attack_step) {
	var _attack = _attack_chain.attacks[_attack_step]
	if (sprite_index != _attack.char_spr_attack) {
		sprite_index = _attack.char_spr_attack;
		image_index = 0;
	}
	var _xscale = image_xscale
	instance_create_layer(x, y, global.cp_layer_instances_above, obj_bp_enemy_attack, 
	{attack_chain: _attack_chain, attack: _attack, image_xscale: _xscale});
}

char_attack = function(_attack_chain) {
	if (_attack_chain.avail) {
		gravity = 0;
		vspeed = 0;
	
		create_attack(_attack_chain, attack_step);
		state = char_state.ATTACKING;
	} else {
		state = char_state.FREE;
	}
}

char_attacking = function(_attack_chain) {
	var _attack_anim_seq = _attack_chain.attacks;
	var _size = array_length(_attack_anim_seq);
	
	if (press_attack && selected_attack_orig == attack_orig.CHAMPION 
	|| press_equip_atk && selected_attack_orig == attack_orig.GEAR) press_attack_holder = true;
	
	if (check_animation_end()) {
		if (press_attack_holder && attack_step < _size - 1) {
			state = char_state.ATTACK;
			attack_step++;
		} else {
			attack_step = 0;
			_attack_chain.avail = false;
			time_source_start(_attack_chain.timer);
			sprite_index = char_spr_stand;
			state = char_state.FREE;
		}
		press_attack_holder = false;
	}
}

char_movement = function() {
	// Helpers (local boolean checks)
	var can_move = function() { 
		return state == char_state.FREE;
	};
	var can_move_right_with = function(_dist) {
		return !(x + _dist >= RIGHT_BOUND) && !place_meeting(x + _dist, y, obj_solid);
	};
	var can_move_left_with = function(_dist) {
		return !(x + _dist <= LEFT_BOUND)  && !place_meeting(x + _dist, y, obj_solid);
	};

	// --- Ground detection ---
	ground = place_meeting(x, y + vspeed + 1, obj_solid);

	// --- Movement (ground vs air) ---
	if (ground) {
		// --- Grounded movement: walking or initiating sidestep ---
		if (can_move()) {
			// Move Right
			if (check_right && can_move_right_with(walk_speed + MARGIN)) {
				// start a step if needed
				if (init_step) {
					init_step = false;
					is_step = true;
				} else if (!is_step) {
					vel = walk_speed;
					if (can_sprite_change) sprite_index = char_spr_walk;
				}
				image_xscale = right;
		
			// Move Left
			} else if (check_left && can_move_left_with(-walk_speed - MARGIN)) {
				if (init_step) {
					init_step = false;
					is_step = true;
				} else if (!is_step) {
					vel = -walk_speed;
					if (can_sprite_change) sprite_index = char_spr_walk;
				}
				image_xscale = left;
		
			// Idle (on ground)
			} else if (!is_step) {
				step_timer = 0;
				vel = 0;
				if (can_sprite_change) sprite_index = char_spr_stand;
				init_step = true;
			}
		
			// Sidestep (short burst movement)
			if (is_step) {
				vel = (-image_xscale) * step_speed; // move opposite of facing sign
				if (can_sprite_change) sprite_index = char_spr_step;
		
				step_timer += 1;
				if (step_timer >= step_frames) {
					step_timer = 0;
					is_step = false;
				}
			}
		} else {
			// movement globally disabled
			is_step = false;
		}
	
	} else {
		// --- Airborne ---
		if (can_sprite_change) sprite_index = char_spr_jump;
		init_step = false;
		step_timer = 0;
		is_step = false;
	
		if (can_move()) {
			// allow limited horizontal control in air (same collision + bounds checks)
			if (check_right && can_move_right_with(walk_speed + MARGIN)) {
				vel = walk_speed;
				image_xscale = right;
			} else if (check_left && can_move_left_with(-walk_speed - MARGIN)) {
				vel = -walk_speed;
				image_xscale = left;
			} else {
				vel = 0;
			}
		}
	}

	// --- Apply horizontal movement ---
	x += vel;

	// --- Gravity and vertical speed clamp ---
	if (ground) {
		gravity = 0;
		can_min_jump = true;
	} else {
		gravity = grav;
		if (vspeed > max_vspeed) vspeed = max_vspeed;
	}

	// --- Jumping ---
	var hit_ceiling = place_meeting(x, y - 10, obj_solid);

	if ((can_move || state == char_state.SLIDE) && ground && press_up && !press_down 
		&& !(state == char_state.SLIDE && hit_ceiling))
	{
		if (state == char_state.SLIDE) alarm[1] = 1;; // call slide-end
		vspeed = -jump_speed;
		if (can_sprite_change) sprite_index = char_spr_jump;
		ground = false;
	}

	// --- Min-jump (release early) ---
	if (!ground && vspeed < 0 && can_min_jump && !check_up) {
		can_min_jump = false;
		vspeed = 0;
	}

	// --- Start Slide ---
	if (can_move() && ground && press_down && !(state == char_state.SLIDE)) {
		sprite_index = char_spr_slide;
		vel = slide_speed * -image_xscale;
		alarm[1] = slide_frames;
		state = char_state.SLIDE;
	}

	// --- Sliding behaviour ---				   
	if (state == char_state.SLIDE) {
		mask_index = spr_mask_slide;
		can_sprite_change = false;
	
		// helpers for slide checks
		var forward_blocked = (image_xscale == right && place_meeting(x + vel + MARGIN, y, obj_solid))
						   || (image_xscale == left && place_meeting(x + vel - MARGIN, y, obj_solid));
		var at_bounds = (x + vel + MARGIN >= RIGHT_BOUND) || (x + vel - MARGIN <= LEFT_BOUND);
		var wrong_input_and_not_ceiling = (check_left && image_xscale == right && !hit_ceiling)
									   || (check_right && image_xscale == left && !hit_ceiling);
	
		// Conditions that cancel slide
		if (wrong_input_and_not_ceiling || !ground || forward_blocked) {
			alarm[1] = 1;
		}
		// If the player hits wall, flip direction
		if (at_bounds || forward_blocked)
		{
			vel = -vel;
			image_xscale = -image_xscale;
		}
	}
	if (state == char_state.FREE) {
		if (press_attack) {
			selected_attack = champ_attack;
			selected_attack_orig = attack_orig.CHAMPION;
			state = char_state.ATTACK;
		} else if (press_equip_atk && gears_size > 0) {
			selected_attack = gears_attacks[selected_gear];
			selected_attack_orig = attack_orig.GEAR;
			state = char_state.ATTACK;
		}
	}
}

#endregion

#region Dmg Functions

apply_dmg = function(_attack_chain, _attack) {
	var _type = _attack_chain.card_type;
	var _dmg = _attack.dmg;
	var _dmg_incr = enemy.dmg_incr[_type];
	
	char.hp -= _dmg * (1 + (_dmg_incr / 100));
}

#endregion