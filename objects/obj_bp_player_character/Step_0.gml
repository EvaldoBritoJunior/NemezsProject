// Input
check_right		= keyboard_check(vk_right);
check_left		= keyboard_check(vk_left);
check_up		= keyboard_check(vk_up);
press_attack	= keyboard_check_pressed(ord("D"));
press_up		= keyboard_check_pressed(vk_up);
press_down		= keyboard_check_pressed(vk_down);

switch (state) {
	case char_state.ATTACK:
		char_attack(attacks);
		break;
	case char_state.ATTACKING:
		char_attacking(attacks);
		break;
	default:
		char_movement();
		break;
}
