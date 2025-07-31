if (global.start == true) {
	image_index = 1 
	image_speed = 0
}
if (!global.start == true) {
	image_index = 0 
	image_speed = 0
}  

if (keyboard_check_pressed(_x)) {
	game_end()
}