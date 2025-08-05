// Inherit the parent event
event_inherited();

draw_self();

draw_set_font(fnt_main_20);

draw_set_valign(fa_middle);

draw_text(x - 340, ystart, global.language.language_button);

draw_set_valign(fa_top);

draw_middle_center(x, y, global.language.language_name);

if (instance_exists(obj_language_menu)) {
	draw_set_font(fnt_main_20);
	draw_set_halign(fa_right);
	draw_set_valign(fa_middle);

	draw_text(x + 135, y - 5, "▼");

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}

