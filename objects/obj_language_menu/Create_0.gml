#region Variables

selected = noone;
// Surface
surface_w = sprite_get_width(spr_button_naked_half);
surface_h = sprite_get_height(spr_button_naked_half) * 2.5;
surface_x = x - 148;
surface_y = y + 25;
inv_surface = noone;

// Cell Size
cel_w = sprite_get_width(spr_button_naked_half);
cel_h = sprite_get_height(spr_button_naked_half);
cols = 1;
rows = array_length(global.available_languages) - 1;
marg = 0;

// Inventory
inv_y = 0;
inv_y_min = 0;
inv_y_max = rows * (cel_h + marg) - surface_h;
inventory = ds_grid_create(cols, rows);

#endregion

#region Methods

check_point_over_surface = function() {
	return point_in_rectangle(mouse_x, mouse_y, surface_x, surface_y, surface_x + surface_w, surface_y + surface_h);
}

fill_grid = function(_grid) {
	var _cols = ds_grid_width(_grid);
	var _rows = ds_grid_height(_grid);
	var _value = 0; 
	for (var i = 0; i < _rows; i++) {
		for (var j = 0; j < _cols; j++) {
			var _language = global.available_languages[_value]
			if (_language != global.language) {
				_grid[# j, i] = _language;
			} else {
				_value++;
				_grid[# j, i] = global.available_languages[_value];
			}
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
			var _x1 = marg + (j * cel_w) + (marg * j);
			var _y1 = inv_y + marg + (i * cel_h) + (marg * i);
			var _x2 = _x1 + cel_w;
			var _y2 = _y1 + cel_h;
			var cel_value = inventory[# j, i];
			
			var _point_over_surface = check_point_over_surface();
			if (_point_over_surface) {
				_point_over = point_in_rectangle(mouse_x - surface_x, mouse_y - surface_y, _x1, _y1, _x2, _y2);
			}
			if (_point_over) {
				selected = cel_value;
			}
			
			draw_sprite_stretched(spr_button_naked_half, _point_over, _x1, _y1, cel_w, cel_h);
			draw_middle_center(_x1 + cel_w * 0.5, _y1 + cel_h * 0.5, cel_value.language_name);
			draw_rectangle(_x1, _y1, _x2, _y2, true);
		}
	}
}

draw_inventory_surface = function() {
	if (!surface_exists(inv_surface)) {
		inv_surface = surface_create(surface_w, surface_h);
	} else {
		surface_set_target(inv_surface)
		
		draw_clear_alpha(c_black, 0);
		draw_inventory();
		
		surface_reset_target();
		
		draw_surface(inv_surface, surface_x, surface_y);
	}
}

#endregion

fill_grid(inventory);