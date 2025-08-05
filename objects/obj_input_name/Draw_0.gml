event_inherited();
draw_self();

draw_set_font(fnt_main_20);

draw_set_valign(fa_middle);

draw_text(x - 340, y, global.language.input_name);

draw_set_valign(fa_top);


if (active) {
    // While active, show the current input (with placeholder if empty)
    var displayText = name_input + "|";
    draw_middle_center(x, y, displayText);  // Draw on UI (GUI) layer
	draw_set_font(fnt_main_20);

	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	draw_text(room_width / 2, room_height - 50,  global.language.input_name_confirm_text);

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
} else {
    // After saving, you could show a confirmation or proceed
     draw_middle_center(x, y, global.player_data.name);
}