// Feather ignore once GM1041
array_size = array_length(options_array);

if (array_size == 0) {
	throw ($"Select act menu with invalid array size");
}

#region Variables

options_stack = [options_array];
selected = undefined;
card_spr = card_inst.card.spr_card; 
// Surface
surface_w = sprite_get_width(card_spr);
surface_h = sprite_get_height(card_spr) - 50;
surface_x = 680;
surface_y = 130;
inv_surface = -1;	//id surface

// Cell Size
cel_w = sprite_get_width(card_spr) - 63;
cel_h = 70;
cols = 1;
rows = array_size;
marg_x = 25;
marg_y = 45;

// Inventory
inv_y = 0;		// Current Position
inv_y_min = 0;
inv_y_max = rows * (cel_h + marg_y) - surface_h + marg_y;
inv_y_max = inv_y_max < inv_y_min ? inv_y_min : inv_y_max;
inventory = ds_grid_create(cols, rows);

#endregion

#region Utility Methods

draw_rectangle_set_color = function(_x1, _y1, _x2, _y2, _color = c_white) {
	draw_set_colour(_color);
	draw_rectangle(_x1, _y1, _x2, _y2, true);
	draw_set_colour(c_white);
}

check_point_over_surface = function() {
	return point_in_rectangle(mouse_x, mouse_y, surface_x, surface_y, surface_x + surface_w, surface_y + surface_h);
}

mouse_check = function() {
	if (selected.avail && mouse_check_button_pressed(mb_left)) {
		var _func = selected.act_func;
		script_execute_ext(_func, selected.act_args);
	}
}

custom_draw = function(_option, _point_over, _x1, _y1, _x2, _y2) {
	var _avail = _option.avail;
	var _fnt = fnt_main_25;
	var _color = _point_over ? c_gray : c_white;
	var _w = cel_w / 2;
	var _h = cel_h / 2;
	
	if (!_avail) {
		draw_middle_center_outline(_x1 + _w, _y1 + _h, _option.name, _fnt, c_grey)
		draw_rectangle_set_color(_x1, _y1, _x2, _y2, c_grey);
	}
	else if (_point_over) {
		draw_middle_center_outline(_x1 + _w - 3, _y1 + _h - 3, _option.name, _fnt, _color)
		draw_rectangle_set_color(_x1 - 3, _y1 - 3, _x2 - 3, _y2 - 3, c_white);
	} else {
		draw_middle_center_outline(_x1 + _w, _y1 + _h, _option.name, _fnt, _color)
		draw_rectangle_set_color(_x1, _y1, _x2, _y2, c_white);
	}
}

#endregion

#region Main Methods

fill_grid = function(_grid) {
	var _cols = ds_grid_width(_grid);
	var _rows = ds_grid_height(_grid);
	var _option = -1;
	var _value = 0; 
	for (var i = 0; i < _rows; i++) {
		for (var j = 0; j < _cols; j++) {
			_option = options_array[_value];
			_grid[# j, i] = _option;
			_value++;
		}
	}
}

draw_inventory = function() {
	// Scroll inventory
	if (mouse_wheel_up()) {inv_y += 20;}
	if (mouse_wheel_down()) {inv_y -= 20;}
	
	// Set Scroll Limit
	inv_y = clamp(inv_y, -inv_y_max, inv_y_min);
	
	// Draw Inventory
	for (var i = 0; i < rows; i++) {
		for (var j = 0; j < cols; j++) {
			var _point_over = false;
			var _x1 = marg_x + (j * cel_w) + (marg_x * j);
			var _y1 = inv_y + marg_y + (i * cel_h) + (marg_y * i);
			var _x2 = _x1 + cel_w;
			var _y2 = _y1 + cel_h;
			var _cel_value = inventory[# j, i];
			var _point_over_surface = check_point_over_surface();
			
			if (_point_over_surface) {
				_point_over = point_in_rectangle(mouse_x - surface_x, mouse_y - surface_y, _x1, _y1, _x2, _y2);
			}
			
			if (_cel_value != undefined) {
				if (_point_over) {
					selected = _cel_value;
					mouse_check();
				} 
				custom_draw(_cel_value, _point_over, _x1, _y1, _x2, _y2);
			}
		}
	}
}

draw_inventory_surface = function() {
	if (!surface_exists(inv_surface)) {
		inv_surface = surface_create(surface_w, surface_h);
	} else {
		surface_set_target(inv_surface)
		
		draw_clear_alpha(c_black, 0.0);
		draw_inventory();
		
		surface_reset_target();
		
		draw_surface(inv_surface, surface_x, surface_y);
	}
}

draw_buttons = function() {
	var _over_see_field = point_in_rectangle(mouse_x, mouse_y, 1177, 637, 1225, 685);
	var _spr_see_field = show ? 0 : 1;
	
	
	if (show) {
		// See field button
		if (_over_see_field) {
			draw_sprite(spr_select_card_see_field, _spr_see_field, -3, -3);
			draw_middle_center(1205 - 3, 660 - 3, ">");
			if (mouse_check_button_pressed(mb_left)) {
				show = false;
				manager_inst.show_cards_when_over = true;
			}
		} else {
			draw_sprite(spr_select_card_see_field, _spr_see_field, 0, 0);
			draw_middle_center(1205, 660, ">");
		}
		
	} else {
		if (_over_see_field) {
			draw_sprite(spr_select_card_see_field, _spr_see_field, -3, -3);
			draw_middle_center(1200 - 3, 660 - 3, "<");
			if (mouse_check_button_pressed(mb_left)) {
				selected = undefined;
				show = true;
				manager_inst.show_cards_when_over = false;
			}
		} else {
			draw_sprite(spr_select_card_see_field, _spr_see_field, 0, 0);
			draw_middle_center(1200, 660, "<");
		}
	}
}

draw_scroll_arrow = function() {
	var _x = 870;
	if(inv_y < inv_y_min) {
		draw_middle_center(_x, y + 30 - sprite_get_height(card_spr) / 2, "▲")
	}
	if (inv_y > -inv_y_max) {
		draw_middle_center(_x, y + 30 + sprite_get_height(card_spr) / 2, "▼")
	}
}

#endregion

fill_grid(inventory);
manager_inst.show_cards_when_over = false;