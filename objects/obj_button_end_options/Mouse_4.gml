// Inherit the parent event
event_inherited();

if (!global.game_started) {
	transition_start(rm_opening_main, sq_fade_out, sq_tittle_fade_in);
} else {
	transition_start(rm_opening_menu, sq_fade_out, sq_fade_in);
}