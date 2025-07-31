draw_self();

draw_set_font(fnt_main);

draw_set_valign(fa_middle);

draw_text(x - 340, y, global.language.input_name);

draw_set_valign(fa_top);


if (active) {
    // While active, show the current input (with placeholder if empty)
    var displayText = name_input + "|";
    global.draw_middle_center(x, y, displayText);  // Draw on UI (GUI) layer
} else {
    // After saving, you could show a confirmation or proceed
     global.draw_middle_center(x, y, global.player_info.name);
}