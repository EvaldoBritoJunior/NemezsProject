type = attack_chain.type;
tgt_hit_by_attack = ds_list_create();
sprite_index = attack.char_spr_attack_hb;

apply_dmg = function(_attack_chain, _attack) {
	if (attack.sturdy < _attack.sturdy) instance_destroy();
}

check_animation_end = function() {
	var _sprite = sprite_index;
	var _image = image_index;
	if (argument_count > 0) _sprite = argument[0];
	if (argument_count > 1) _image = argument[1];
	
	var _type = sprite_get_speed_type(sprite_index);
	var _spd = sprite_get_speed(sprite_index) * image_speed;
	
	if (_type == spritespeed_framespersecond) _spd = _spd/room_speed;
	if (argument_count > 2) _spd = argument[2];
	
	return _image + _spd >= sprite_get_number(_sprite);
}

process_attack = function() {
	var _tgt_hit_by_attack_now = ds_list_create();
	var _hits = instance_place_list(x, y, obj_bp_player_char_parent, _tgt_hit_by_attack_now, false);

	for (var i = 0; i < _hits; i++) {
		var _hitID = ds_list_find_value(_tgt_hit_by_attack_now, i);
		if (ds_list_find_index(tgt_hit_by_attack, _hitID) == -1) {
			ds_list_add(tgt_hit_by_attack, _hitID);
			_hitID.apply_dmg(attack_chain, attack); 
		}
	}

	ds_list_destroy(_tgt_hit_by_attack_now);
	
	if (check_animation_end()) {
		if (attack.projectile) {
			hspeed = -15 * image_xscale;
			image_speed = 0;
		} else {
			instance_destroy();
		}
	}
}