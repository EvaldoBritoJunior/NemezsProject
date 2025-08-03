// Inherit the parent event
event_inherited();

global.game_started = true;
transition_start(rm_opening_menu, sq_fade_out, sq_fade_in);