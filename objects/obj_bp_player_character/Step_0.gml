if place_meeting(x, y + vspeed + 1, obj_solid) {
	ground = true;
} else {
	ground = false;
}

// Movement
if (ground) {
	// Move Right
	if (keyboard_check(vk_right) 
		&& !(x + vel + 5 >= 1230)
		&& !place_meeting(x + vel + 5, y, obj_solid) 
		&& can_move
	) {
		if (init_step == true) {
			init_step = false;
			is_step = true;
		} else if (is_step == false) {
			vel = walk_speed;
			if (can_sprite_change) sprite_index = char_spr_walk;
			image_speed = 0.15;
		}
		image_xscale = -1;
	// Move Left
	} else if (keyboard_check(vk_left) 
		&& !(x + vel - 5 <= 50)
		&& !place_meeting(x + vel - 5, y, obj_solid) 
		&& can_move
	) {
		if (init_step == true) {
			init_step = false;
			is_step = true;
		} else if (is_step == false) {
			vel = -walk_speed;
			if (can_sprite_change) sprite_index = char_spr_walk;
			image_speed = 0.15;
		}
		image_xscale = 1;
	} else if (is_step == false && can_move) {
		step_timer = 0;
		vel = 0;
		if (can_sprite_change) sprite_index = char_spr_stand;
		init_step = true;
	}

	// Sidestepping
	if (can_move) {
		if (is_step == true) {
			vel = (-image_xscale) * step_speed;
			if (can_sprite_change) sprite_index = char_spr_step;
	
			step_timer += 1;
			if (step_timer >= step_frames) {
				step_timer = 0;
				is_step = false;
			}
		} 
	} else {
		is_step = false;
	}
	
} else {
	if (can_sprite_change) sprite_index = char_spr_jump;
	init_step = false;
	step_timer = 0;
	is_step = false;
	
	if (can_move) {
		if (keyboard_check(vk_right) && !place_meeting(x + vel + 1, y, obj_solid)) {
			vel = walk_speed;
			image_xscale = -1;
		} else if (keyboard_check(vk_left) && !place_meeting(x + vel - 1, y, obj_solid)) {
			vel = -walk_speed;
			image_xscale = 1;
		} else {
			vel = 0;
		}
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
if ((can_move || is_slide) 
&& ground 
&& keyboard_check_pressed(vk_up) 
&& !keyboard_check(vk_down)
&& !(is_slide && place_meeting(x, y-3, obj_solid))) {
	if (is_slide == true) {
		event_user(0);
	}
	
	vspeed = -jump_speed;
	if (can_sprite_change) sprite_index = char_spr_jump;
	ground = false;
}

//MinJumping
if (!ground && vspeed < 0 && can_min_jump == true && !keyboard_check(vk_up)) {
	can_min_jump = false;
	vspeed = 0;
}

//Acting
if (keyboard_check_pressed(ord("D")) && instance_number(obj_bp_bullet) < 3 && can_shoot) {
	var _box, _id;
	if (image_xscale == 1) {
		_box = bbox_left;
	} else {
		_box = bbox_right;
	}
	
	_id = instance_create_layer(_box + image_xscale * (walk_speed), y, "Instances", obj_bp_bullet);
	_id.hspeed = -image_xscale * (walk_speed) * 2;
	is_shoot = true;
	alarm[0] = 20;
}

// Sliding
if (can_move && ground == true && keyboard_check(vk_down) && !is_slide) {
	is_slide = true;
	sprite_index = char_spr_slide;
	vel = slide_speed * -image_xscale;
	alarm[1] = slide_frames;
}

if (is_slide) {
	mask_index = spr_mask_slide;
	can_move = false;
	can_sprite_change = false;
	can_shoot = false;
	
	if ((keyboard_check(vk_left) && image_xscale == -1 && !place_meeting(x, y-3, obj_solid))
		||(keyboard_check(vk_right) && image_xscale == 1 && !place_meeting(x, y-3, obj_solid))
		||!ground
		||(x + vel + 5 >= 1230)
		||(x + vel - 5 <= 50)
		||(image_xscale == -1 && place_meeting(x + vel + 5, y, obj_solid))
		||(image_xscale == 1 && place_meeting(x + vel - 5, y, obj_solid))
	) {
		event_user(0);
	} else if (keyboard_check(vk_right)) && image_xscale == 1 && place_meeting(x, y-3, obj_solid) {
		vel = -vel;
		image_xscale = -image_xscale;
	} else if (keyboard_check(vk_left)) && image_xscale == -1 && place_meeting(x, y-3, obj_solid) {
		vel = -vel;
		image_xscale = -image_xscale;
	}
	
}

// Sprites
if is_shoot == false {
	char_spr_stand = spr_stand;
	char_spr_step = spr_step;
	char_spr_jump = spr_jump;
	char_spr_walk = spr_walk;
} else {
	char_spr_stand = spr_stand_shoot;
	char_spr_step = spr_stand_shoot;
	char_spr_jump = spr_jump_shoot;
	char_spr_walk = spr_walk_shoot;
}
