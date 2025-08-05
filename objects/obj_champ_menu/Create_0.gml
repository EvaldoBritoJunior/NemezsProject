#region Variables

selected = noone;
// Surface
surface_w = room_height + 100;
surface_h = room_height;
surface_x = room_width - room_height - 100;
surface_y = 0;
inv_surface = -1;

// Cell Size
c_sprite = spr_sample_card_art;
cel_w = sprite_get_width(c_sprite) / 2;
cel_h = sprite_get_height(c_sprite) / 2;
cols = 3;
rows = 3;
marg_x = 60;
marg_y = 60;

// Inventory
inv_y = 0;		// Current Position
inv_y_min = 0;
inv_y_max = rows * (cel_h + marg_y) - surface_h + marg_y;
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
			_grid[# j, i] = c_sprite;
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
			var cel_value = inventory[# j, i];
			
			var _point_over_surface = check_point_over_surface();
			if (_point_over_surface) {
				_point_over = point_in_rectangle(mouse_x - surface_x, mouse_y - surface_y, _x1, _y1, _x2, _y2);
			}
			if (_point_over) {
				selected = cel_value;
				draw_sprite_stretched(c_sprite, _point_over, _x1 - 3, _y1 - 3, cel_w - 3, cel_h - 3);
			} else {
				draw_sprite_stretched(c_sprite, _point_over, _x1, _y1, cel_w, cel_h);
			}
			//draw_middle_center(_x1 + cel_w * 0.5, _y1 + cel_h * 0.5, cel_value.language_name);
			draw_rectangle(_x1, _y1, _x2, _y2, true);
		}
	}
}

draw_inventory_surface = function() {
	if (!surface_exists(inv_surface)) {
		inv_surface = surface_create(surface_w, surface_h);
	} else {
		surface_set_target(inv_surface)
		
		draw_clear_alpha(c_black, 0.5);
		draw_inventory();
		
		surface_reset_target();
		
		draw_surface(inv_surface, surface_x, surface_y);
	}
}

#endregion

fill_grid(inventory);