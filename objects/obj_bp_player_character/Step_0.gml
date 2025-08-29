if place_meeting(x, y + vspeed + 1, obj_solid) {
	ground = true;
} else {
	ground = false;
}

// Movement
if (ground) {
	if keyboard_check(vk_right) && !place_meeting(x + vel + 5, y, obj_solid) {
		if (init_step == true) {
			init_step = false;
			is_step = true;
		} else if (is_step == false) {
			vel = walk_speed;
			sprite_index = spr_walk;
			image_speed = 0.15;
		}
		image_xscale = -1;
	} else if keyboard_check(vk_left) && !place_meeting(x + vel - 5, y, obj_solid) {
		if (init_step == true) {
			init_step = false;
			is_step = true;
		} else if (is_step == false) {
			vel = -walk_speed;
			sprite_index = spr_walk;
			image_speed = 0.15;
		}
		image_xscale = 1;
	} else if (is_step == false) {
		step_timer = 0;
		vel = 0;
		sprite_index = spr_stand;
		init_step = true;
	}

	// Sidestepping
	if (is_step == true) {
		vel = (-image_xscale) * step_speed;
		sprite_index = spr_step;
	
		step_timer += 1;
		if (step_timer >= step_frames) {
			step_timer = 0;
			is_step = false;
		}
	} 
} else {
	sprite_index = spr_jump;
	init_step = false;
	step_timer = 0;
	is_step = false;
	
	if keyboard_check(vk_right) && !place_meeting(x + vel + 1, y, obj_solid) {
		vel = walk_speed;
		image_xscale = -1;
	} else if keyboard_check(vk_left) && !place_meeting(x + vel - 1, y, obj_solid) {
		vel = -walk_speed;
		image_xscale = 1;
	} else {
		vel = 0;
	}
}

//Allow movement
x += vel;

//Gravity
if (ground) {
	gravity = 0;
	can_min_jump = true;
} else {
	gravity = grav;
	if (vspeed > max_vspeed) {
		vspeed = max_vspeed;
	}
}

//Jumping
if (ground && keyboard_check_pressed(vk_up)) {
	vspeed = -jump_speed;
	sprite_index = spr_jump;
	ground = false;
}

//MinJumping
if (!ground && vspeed < 0 && can_min_jump == true && !keyboard_check(vk_up)) {
	can_min_jump = false;
	vspeed = 0;
}
