var _hp = char.hp;

if (_hp > 0 ) {
	// Input
	check_right		= keyboard_check(vk_left);
	check_left		= keyboard_check(vk_right);
	check_up		= keyboard_check(vk_up);
	press_attack	= keyboard_check_pressed(ord("D"));
	press_equip_atk = keyboard_check_pressed(ord("S"));
	press_sth_equip = keyboard_check_pressed(ord("A"));
	press_up		= keyboard_check_pressed(vk_up);
	press_down		= keyboard_check_pressed(vk_down);

	// Act

	if (press_sth_equip) sth_equip();

	switch (state) {
		case char_state.ATTACK:
			char_attack(selected_attack);
			break;
		case char_state.ATTACKING:
			char_attacking(selected_attack);
			break;
		default:
			char_movement();
			break;
	}
} else {
	if (!dying) {
		gravity = 0;
		vspeed = 0;
		sprite_index = spr_death
		dying = true;
	} else if (check_animation_end()) {
		manager_inst.end_battle();
		instance_destroy();
	}
}
