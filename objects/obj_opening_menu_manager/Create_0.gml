avail_buttons = [];

remove_buttons = function() {
	var _size = array_length(avail_buttons);
	var _button = -1;
	for (var i = 0; i < _size; i++) {
		_button = avail_buttons[i];
		if (instance_exists(_button)) {
			instance_destroy(_button)
		}
	}
}

create_init_objects = function() {	
	var _x = 640;
	var _y = 180;
	var _distance = 125;
	var _this = self;
	var _button = -1;
	
	remove_buttons();
	
	// Start Duel
	_button = instance_create_layer(
		_x, _y, "Instances", obj_button_generic,
		{
			draw_text_func : 
				function() {
					draw_middle_center(x - 10, y, global.language.start_duel_button_text);
				},
			left_pressed_func : 
				function() {
					manager_inst.create_select_card_mode_objects();
				},
			manager_inst : _this
		});
	array_push(avail_buttons, _button);
	
	// Tutorial
	_y += _distance;
	_button = instance_create_layer(
		_x, _y, "Instances", obj_button_generic,
		{
			draw_text_func : 
				function() {
					draw_middle_center(x, y, global.language.watch_tutorial_button_text);
				},
			left_pressed_func : 
				function() {
					url_open(global.language.watch_tutorial_url);
				},
			manager_inst : _this
		});
	array_push(avail_buttons, _button);
	
	// Config
	_y += _distance;
	_button = instance_create_layer(
		_x, _y, "Instances", obj_button_generic,
		{
			draw_text_func : 
				function() {
					draw_middle_center(x, y, global.language.start_options_button_text);
				},
			left_pressed_func : 
				function() {
					transition_start(rm_opening_options, sq_fade_out, sq_fade_in);
				},
			manager_inst : _this
		});
	array_push(avail_buttons, _button);
		
	// Forms
	_y += _distance;
	_button = instance_create_layer(
		_x, _y, "Instances", obj_button_generic,
		{
			draw_text_func : 
				function() {
					draw_middle_center(x, y, global.language.give_feedback_button_text);
				},
			left_pressed_func : 
				function() {
					url_open(global.language.give_feedback_url);
				},
			manager_inst : _this
		});
	array_push(avail_buttons, _button);
}

create_select_card_mode_objects = function() {
	var _x = 640;
	var _y = 180;
	var _distance = 100;
	var _this = self;
	var _button = -1;
	remove_buttons();
	
	// 1 x 1
	_button = instance_create_layer(
		_x, _y, "Instances", obj_button_generic,
		{
			draw_text_func : 
				function() {
					draw_middle_center(x, y, "1 x 1");
				},
			left_pressed_func : 
				function() {
					reset_card_phase_data(1);
					transition_start(rm_card_phase, sq_out_to_duel, sq_fade_in);
				},
			manager_inst : _this
		});
	array_push(avail_buttons, _button);
	
	// 2 x 2
	_y += _distance;
	_button = instance_create_layer(
		_x, _y, "Instances", obj_button_generic,
		{
			draw_text_func : 
				function() {
					draw_middle_center(x, y, "2 x 2");
				},
			left_pressed_func : 
				function() {
					reset_card_phase_data(2);
					transition_start(rm_card_phase, sq_out_to_duel, sq_fade_in);
				},
			manager_inst : _this
		});
	array_push(avail_buttons, _button);
	
	// 3 x 3
	_y += _distance;
	_button = instance_create_layer(
		_x, _y, "Instances", obj_button_generic,
		{
			draw_text_func : 
				function() {
					draw_middle_center(x, y, "3 x 3");
				},
			left_pressed_func : 
				function() {
					reset_card_phase_data(3);
					transition_start(rm_card_phase, sq_out_to_duel, sq_fade_in);
				},
			manager_inst : _this
		});
	array_push(avail_buttons, _button);
	
	// 4 x 4
	_y += _distance;
	_button = instance_create_layer(
		_x, _y, "Instances", obj_button_generic,
		{
			draw_text_func : 
				function() {
					draw_middle_center(x, y, "4 x 4");
				},
			left_pressed_func : 
				function() {
					reset_card_phase_data(4);
					transition_start(rm_card_phase, sq_out_to_duel, sq_fade_in);
				},
			manager_inst : _this
		});
	array_push(avail_buttons, _button);
	
	// Cancel
	_y += _distance;
	_button = instance_create_layer(
		_x, _y, "Instances", obj_button_generic,
		{
			draw_text_func : 
				function() {
					draw_middle_center(x, y, global.language.cancel_button_text);
				},
			left_pressed_func : 
				function() {
					manager_inst.create_init_objects();
				},
			manager_inst : _this
		});
	array_push(avail_buttons, _button);
}