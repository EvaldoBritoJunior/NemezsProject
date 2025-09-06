var _hp = char.hp;

if (_hp > 0 ) {
	// Input
	check_right		= ia.check_right();
	check_left		= ia.check_left();
	check_up		= ia.check_up();
	press_attack	= ia.press_attack();
	press_equip_atk = ia.press_equip_atk();
	press_sth_equip = ia.press_sth_equip();
	press_up		= ia.press_up();
	press_down		= ia.press_down();

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
