// Variables
global.cp_manager = -1;
global.func_target = -1;

// Functions
function cp_place_sequence(_sequence, _depth) {
	if (layer_exists("Sequence")) layer_destroy("Sequence");
	global.cp_manager.show_cards_when_over = false;
	var _lay = layer_create(_depth, "Sequence");
	layer_sequence_create(_lay, 0, 0, _sequence);
}

function cp_sequence_start(_cp_manager, _func_target, _sequence, _depth = -9998) {
	global.cp_manager = _cp_manager;
	global.func_target = _func_target;
	cp_place_sequence(_sequence, _depth);
}

function cp_sequence_act() {
	global.func_target();
}

function cp_sequence_finished() {
	layer_sequence_destroy(self.elementID);
	global.cp_manager.show_cards_when_over = true;
}
