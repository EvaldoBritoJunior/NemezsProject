data = global.card_phase_data;
default_background = spr_field_default;

draw_data = function () {
	draw_set_font(fnt_main_20);

	//draw_text(x, y, $"({mouse_x},{mouse_y})");

	#region Player data
	draw_text(10, 620, global.player_data.name); // Name

	draw_set_font(fnt_main_30);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	draw_text(90, 687, 10); // Used gear
	draw_text(204, 687, 11); // Used magic

	#endregion

	#region Enemy data
	draw_text(1133, 75, 5);  // Used gear
	draw_text(1247, 75, 0);  // Used magic

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_font(fnt_main_20);
	
	draw_text(1055, 8, global.player_data.name);  // Name

	#endregion
}