// Variables
global.mid_transition = false;
global.room_target = -1;

// Functions
function transition_place_sequence(_transition_type) {
	if (layer_exists("Transition")) layer_destroy("Transition");
	var _lay = layer_create(-9999, "Transition");
	layer_sequence_create(_lay, 0, 0, _transition_type);
}

function transition_start(_room_target, _type_out, _type_in) {
	if (!global.mid_transition) {
		global.mid_transition = true;
		global.room_target = _room_target;
		transition_place_sequence(_type_out);
		layer_set_target_room(_room_target);
		transition_place_sequence(_type_in);
		layer_reset_target_room();
		return true;
	} else {
		return false;
	}
}


function transition_change_room() {
	room_goto(global.room_target);
}

function transition_finished() {
	layer_sequence_destroy(self.elementID);
	global.mid_transition = false;
}
