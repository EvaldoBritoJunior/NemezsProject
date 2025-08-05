if (active) {
    // Update the name_input from keyboard_string each frame
    name_input = keyboard_string;

    // (Optional) Limit length to, say, 12 characters
    var maxLength = 12;
    if (string_length(name_input) > maxLength) {
        name_input = string_copy(name_input, 1, maxLength);
        keyboard_string = name_input;  // Sync back to keyboard_string
    }

    // If Enter is pressed, save and exit input mode
    if (keyboard_check_pressed(vk_enter)) {
		if (name_input != "") { 
			global.player_data.name = name_input;   // Store final name globally
		}
        active = false;                  // Stop capturing input
		// Enable buttons
		enable_buttons(global.array_options_screen_buttons, true)
    }
}
