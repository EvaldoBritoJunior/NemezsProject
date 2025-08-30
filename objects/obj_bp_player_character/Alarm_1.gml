if (!place_meeting(x, y - 10, obj_solid)) {
	event_user(0);
} else {
	alarm[1] = 1;
}