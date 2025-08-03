#region Variables

// Surface
surface_w = 1080;
surface_h = 620;
surface_x = 100;
surface_y = 100;
inv_surface = -1;

// Cell Size
cel_size = 200;
cols = 4;
rows = 10;
marg = 20;

// Inventory
inv_y = 0;
inv_y_min = 0;
inv_y_max = rows * (cel_size + marg) + cel_size - surface_h;
inventory = ds_grid_create(cols, rows);

#endregion

#region Methods

fill_grid = function(_grid) {
	var _cols = ds_grid_width(_grid);
	var _rows = ds_grid_height(_grid);
	var _value = 0; 
	for (var i = 0; i < _rows; i++) {
		for (var j = 0; j < _cols; j++) {
			_grid[# j, i] = _value;
			_value++;
		}
	}
}

draw_inventory = function() {
	// Scroll inventory
	if (mouse_wheel_up()) {inv_y += 50;}
	if (mouse_wheel_down()) {inv_y -= 50;}
	
	// Set Scroll Limit
	inv_y = clamp(inv_y, -inv_y_max, inv_y_min);
	
	// Draw Inventory
	for (var i = 0; i < rows; i++) {
		for (var j = 0; j < cols; j++) {
			var _point_over = false;
			var _x1 = marg + (j * cel_size) + (marg * j);
			var _y1 = inv_y + marg + (i * cel_size) + (marg * i);
			var _x2 = _x1 + cel_size;
			var _y2 = _y1 + cel_size;
			
			var _point_over_surface = point_in_rectangle(mouse_x, mouse_y, surface_x, surface_y, surface_x + surface_w, surface_y + surface_h);
			if (_point_over_surface) {
				_point_over = point_in_rectangle(mouse_x - surface_x, mouse_y - surface_y, _x1, _y1, _x2, _y2);
			}
			draw_rectangle(_x1, _y1, _x2, _y2, true);
			
			var cel_value = inventory[# j, i]
			
			draw_middle_center(_x1, _y1, cel_value);
			draw_sprite_stretched(spr_caixa_item, _point_over, _x1, _y1, cel_size, cel_size);
			draw_sprite_stretched(spr_itens, cel_value%11, _x1, _y1, cel_size, cel_size);
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