// Feather ignore once GM1041
array_size = array_length(card_array);

if (array_size == 0 || array_size < select_amount) {
	throw ($"Select card menu with invalid array size");
}

#region Variables

selected = noone;
selected_array = array_create(array_size, false);
selected_amount = 0;
// Surface
surface_w = room_height + 100;
surface_h = room_height;
surface_x = 0;
surface_y = 0;
inv_surface = -1;

// Cell Size
c_sprite = card_array[0].spr_cut_card;
cel_w = sprite_get_width(c_sprite) / 1.9;
cel_h = sprite_get_height(c_sprite) / 1.9;
cols = 3;
rows = ceil(array_size / 3);
marg_x = 45;
marg_y = 60;

// Inventory
inv_y = 0;		// Current Position
inv_y_min = 0;
inv_y_max = rows * (cel_h + marg_y) - surface_h + marg_y;
inventory = ds_grid_create(cols, rows);

#endregion

#region Methods

draw_rectangle_set_color = function(_x1, _y1, _x2, _y2, _color = c_white) {
	draw_set_colour(_color);
	draw_rectangle(_x1, _y1, _x2, _y2, true);
	draw_set_colour(c_white);
}

check_point_over_surface = function() {
	return point_in_rectangle(mouse_x, mouse_y, surface_x, surface_y, surface_x + surface_w, surface_y + surface_h);
}

mouse_check = function(_position) {
	if (mouse_check_button_pressed(mb_left)) {
		if (selected_array[_position]) {
			selected_array[_position] = false;
			selected_amount--;
		} else if (selected_amount < select_amount) {
			selected_array[_position] = true;
			selected_amount++;
		}
	}
}

custom_draw_sprite = function(_array_pos, _point_over, _x1, _y1, _x2, _y2, _sprite) {
	var _color = c_white;
	if (selected_array[_array_pos]) {
		_color = c_black;
	}
	
	if (_point_over && (selected_array[_array_pos] || selected_amount < select_amount)) {
		draw_sprite_stretched(_sprite, 0, _x1 - 3, _y1 - 3, cel_w - 3, cel_h - 3);
		draw_rectangle_set_color(_x1 - 3, _y1 - 3, _x2 - 3, _y2 - 3, _color);
	} else {
		draw_sprite_stretched(_sprite, 0, _x1, _y1, cel_w, cel_h);
		draw_rectangle_set_color(_x1, _y1, _x2, _y2, _color);
	}
}

fill_grid = function(_grid) {
	var _cols = ds_grid_width(_grid);
	var _rows = ds_grid_height(_grid);
	var _position = 0;
	for (var i = 0; i < _rows; i++) {
		for (var j = 0; j < _cols; j++) {
			_position = (i * 3) + j;
			if (_position < array_size) {
				_grid[# j, i] = card_array[_position];
			} else {
				_grid[# j, i] = noone;
			}
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
			var _array_pos = i * 3 + j;
			var _sprite = -1;
			var _point_over_surface = check_point_over_surface();
			
			if (_point_over_surface) {
				_point_over = point_in_rectangle(mouse_x - surface_x, mouse_y - surface_y, _x1, _y1, _x2, _y2);
			}
			
			if (_cel_value != noone) {
				_sprite = _cel_value.spr_cut_card;
				if (_point_over) {
					selected = _cel_value;
					mouse_check(_array_pos);
				} 
				custom_draw_sprite(_array_pos, _point_over, _x1, _y1, _x2, _y2, _sprite);
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

end_selection = function() {
	var _response = [];
	for (var i = 0; i < array_size; i++) {
		if (selected_array[i]) {
			array_push(_response, card_array[i])
		}
	}
	manager_inst.show_cards_when_over = true;
	return_func(_response);
	instance_destroy();
}

draw_buttons = function() {
	var _over_confirm = point_in_rectangle(mouse_x, mouse_y, 966, 637, 1133, 685);
	var _act_confirm = (selected_amount == select_amount);
	var _spr_confirm = _act_confirm ? 1 : 0;
	var _txt_confirm = _act_confirm ? global.language.select_card_confirm_text : $"{selected_amount} | {select_amount}";
	
	var _over_see_field = _over_confirm ? false : point_in_rectangle(mouse_x, mouse_y, 1177, 637, 1225, 685);
	var _spr_see_field = show ? 0 : 1;
	
	
	if (show) {
		// Confirm button
		if (_over_confirm && _act_confirm) {
			draw_sprite(spr_select_card_confirm, _spr_confirm, -3, -3);
			draw_middle_center(1052 - 3, 660 - 3, _txt_confirm);
			if (mouse_check_button_pressed(mb_left)) {
				end_selection();
			}
		} else {
			draw_sprite(spr_select_card_confirm, _spr_confirm, 0, 0);
			draw_middle_center(1052, 660, _txt_confirm);
		}
		
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
				selected = noone;
				show = true;
				manager_inst.show_cards_when_over = false;
			}
		} else {
			draw_sprite(spr_select_card_see_field, _spr_see_field, 0, 0);
			draw_middle_center(1200, 660, "<");
		}
	}
}

#endregion

fill_grid(inventory);
manager_inst.show_cards_when_over = false;