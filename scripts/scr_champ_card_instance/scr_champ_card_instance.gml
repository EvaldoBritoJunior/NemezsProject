function champ_stat(_base, _max, _min = 0) constructor {
    base_value = _base;
	current_value = _base;
	max_value = _max;
	current_max_value = _max;
	min_value = _min;
	current_min_value = _min;
    modifiers = [];        // hold modifier structs
    altered = false;       // flag to recalc current_value

    static add_modifier = function(_mod) {
		if (_mod.target == value_target.BASE) {
			get_value();
			switch (_mod.operation) {
	            case math_ops.ADD:
	                base_value += _mod.value;
	                break;
			}
			if (base_value > current_max_value) {
				base_value = current_max_value;
		    }
		    if (base_value < current_min_value) {
		        base_value = current_min_value;
		    }
		} else {
			array_push(modifiers, _mod);
		}
        altered = true;     // mark dirty so GetValue will recalc
    };
	
	static remove_modifier = function(_mod, _idx = -1) {
		var _m = -1;
		var _rmvd = false;
		var _size = array_length(modifiers);
		if (_mod.target == value_target.BASE) {
			switch (_mod.operation) {
	            case math_ops.ADD:
	                base_value -= _mod.value;
	                break;
			}
			if (base_value > current_max_value) {
				base_value = current_max_value;
		    }
		    if (base_value < current_min_value) {
		        base_value = current_min_value;
		    }
			_rmvd = true;
		} else {
			if (_idx != -1) {
				array_delete(modifiers, _idx, 1);
				_rmvd = true;
			} else {
		        for (var i = 0; i < _size; i++) {
		            _m = modifiers[i];
		            if (_m == _mod) {
						array_delete(modifiers, i, 1);
						_rmvd = true;
						break;
					}
		        }
			}
		}
       if (_rmvd) altered = true;     // mark dirty so GetValue will recalc
    };

    static get_value = function() {
	    if (!altered) return current_value;

	    var values = [base_value, max_value, min_value];

	    for (var i = 0; i < array_length(modifiers); i++) {
	        var m = modifiers[i];

	        var t = m.target;
	        switch (m.operation) {
	            case math_ops.ADD:
	                values[t] += m.value;
	                break;
	            case math_ops.MULTIPLY:
	                values[t] *= m.value;
	                break;
	            case math_ops.EQUALS:
	                values[t]  = m.value;
	                break;
	        }
	    }
		// Clamp current value
		if (values[value_target.CURRENT] > values[value_target.MAX]) {
		    values[value_target.CURRENT] = values[value_target.MAX];
		}
		if (values[value_target.CURRENT] < values[value_target.MIN]) {
		    values[value_target.CURRENT] = values[value_target.MIN];
		}

	    current_value     = values[value_target.CURRENT];
	    current_max_value = values[value_target.MAX];
	    current_min_value = values[value_target.MIN];
	    altered           = false;

	    return current_value;
	};
	
	static get_max_value = function() {
		if (!altered) return current_max_value;
		get_value();
		return current_max_value;
	}
		
	static reduce_modifiers_duration = function() {
		var _remove = [];
		var _size = array_length(modifiers);
		var _m;

	    for (var i = 0; i < _size; i++) {
	        _m = modifiers[i];
	        if (_m.duration != -1) {
				_m.duration--;
				if (_m.duration == 0) {
					array_push(_remove, _m);
				}
			}
	    }
		
		_size = array_length(_remove);
		for (var i = 0; i < _size; i++) {
	        _m = _remove[i];
			remove_modifier(_m, i);
	    }
	}
}

function champ_instance(_card, _card_owner, _card_pos) constructor {
	card = _card;
	card_owner = _card_owner;
	card_pos = _card_pos;
	
	hp = new champ_stat(_card.hp, _card.hp);
	gw = new champ_stat(0, _card.gw);
	md = new champ_stat(_card.md, 9);
	card_type = new champ_stat(_card.card_type, 3);
	stats = [
		new champ_stat(_card.stats[0], 6),
		new champ_stat(_card.stats[1], 6),
		new champ_stat(_card.stats[2], 6),
		new champ_stat(_card.stats[3], 6)
	];
	type_dmg_incr = [
		new champ_stat(0, 100, -100),
		new champ_stat(0, 100, -100),
		new champ_stat(0, 100, -100),
		new champ_stat(0, 100, -100)
	];
			 
	card_passive = _card.card_passive;
	card_passive_state = false;
	card_ability = _card.card_ability;
	
	can_equip_gears = new champ_stat(true, true);
	can_use_magics = new champ_stat(true, true);
	can_use_abilities = new champ_stat(true, true);
	
	condition = undefined;
	condition_state = false;
	
	gears = [];
	gears_state = [];
	
	has_acted = false;
	
	static can_equip_gear = function(_card_inst, _gear) {
		var _champ_gw = _card_inst.gw.get_value();
		var _champ_max_gw = _card_inst.gw.get_max_value();
		var _gear_gw = _gear.gw;
		
		return (_champ_gw + _gear_gw <= _champ_max_gw);
    };
	
	static equip_gear = function(_card_inst, _gear, _idx) {
		if (!_card_inst.can_equip_gear(_card_inst, _gear)) throw("Tried to equip gear when cant equip"); 
		var _data = global.card_phase_data;
		if (_card_inst.card_owner = card_owners.PLAYER) {
			_data.player_rmv_gear(_idx);
		} else {
			_data.enemy_rmv_gear(_idx);
		}
		_card_inst.champ_add_modifier(_card_inst, new modifier(champ_stat_type.GW, _gear.gw, value_target.BASE))
		array_push(_card_inst.gears, _gear);
		array_push(_card_inst.gears_state, false);
		redo_act_menu(_card_inst);
    };
	
	static can_use_magic = function(_card_inst, _magic) {
		var _magic_ability = _magic.card_ability;
		var _champ_md = _card_inst.md.get_value();
		var _magic_md = _magic.md;
		return (_card_inst.can_use_magics.get_value()
				&& _magic_md <= _champ_md
				&& _magic_ability != undefined
				&& _magic_ability.avail_func(_card_inst));
    };

	static use_magic = function(_card_inst, _magic, _idx) {
		if (!_card_inst.can_use_magic(_card_inst, _magic)) throw("Tried to use magic when cant use magic"); 
		var _data = global.card_phase_data;
		if (_card_inst.card_owner = card_owners.PLAYER) {
			_data.player_rmv_magic(_idx);
		} else {
			_data.enemy_rmv_magic(_idx);
		}
		script_execute_ext(_magic.card_ability.act_func, [_card_inst, self]);
    };
	
	static can_use_ability = function(_card_inst) {
		var _champ_ability = _card_inst.card_ability;
		return (_card_inst.can_use_abilities.get_value()
				&& _champ_ability != undefined
				&& _champ_ability.avail_func(_card_inst));
    };
	
	static use_ability = function(_card_inst) {
		if (!_card_inst.can_use_ability(_card_inst)) throw("Tried to use ability when cant use ability"); 
		script_execute_ext(_card_inst.card_ability.act_func, [_card_inst, self]);
    };
	
	static champ_add_modifier = function(_card_inst, _modifier) {
		switch (_modifier.stat) {
			case champ_stat_type.HP:
				_card_inst.hp.add_modifier(_modifier);
				break;
			case champ_stat_type.GW:
				_card_inst.gw.add_modifier(_modifier);
				break;
			case champ_stat_type.MD:
				_card_inst.md.add_modifier(_modifier);
				break;
			case champ_stat_type.TYPE:
				_card_inst.card_type.add_modifier(_modifier);
				break;
			case champ_stat_type.STR:
				_card_inst.stats[0].add_modifier(_modifier);
				break;
			case champ_stat_type.SKL:
				_card_inst.stats[1].add_modifier(_modifier);
				break;
			case champ_stat_type.INT:
				_card_inst.stats[2].add_modifier(_modifier);
				break;
			case champ_stat_type.DVT:
				_card_inst.stats[3].add_modifier(_modifier);
				break;
			case champ_stat_type.CAN_EQUIP:
				_card_inst.can_equip_gears.add_modifier(_modifier);
				break;
			case champ_stat_type.CAN_MAGIC:
				_card_inst.can_use_magics.add_modifier(_modifier);
				break;
			case champ_stat_type.CAN_ABILITY:
				_card_inst.can_use_abilities.add_modifier(_modifier);
				break;
			case champ_stat_type.GRAY_DMG:
				_card_inst.type_dmg_incr[card_types.GRAY].add_modifier(_modifier);
				break;
			case champ_stat_type.RED_DMG:
				_card_inst.type_dmg_incr[card_types.RED].add_modifier(_modifier);
				break;
			case champ_stat_type.BLUE_DMG:
				_card_inst.type_dmg_incr[card_types.BLUE].add_modifier(_modifier);
				break;
			case champ_stat_type.GOLD_DMG:
				_card_inst.type_dmg_incr[card_types.GOLD].add_modifier(_modifier);
				break;
			default:
				throw($"Invalid Champion Stat: {_modifier.stat}");
		}
    };
	
	static champ_remove_modifier = function(_card_inst, _modifier) {
		switch (_modifier.stat) {
			case champ_stat_type.HP:
				_card_inst.hp.remove_modifier(_modifier);
				break;
			case champ_stat_type.GW:
				_card_inst.gw.remove_modifier(_modifier);
				break;
			case champ_stat_type.MD:
				_card_inst.md.remove_modifier(_modifier);
				break;
			case champ_stat_type.TYPE:
				_card_inst.card_type.remove_modifier(_modifier);
				break;
			case champ_stat_type.STR:
				_card_inst.stats[0].remove_modifier(_modifier);
				break;
			case champ_stat_type.SKL:
				_card_inst.stats[1].remove_modifier(_modifier);
				break;
			case champ_stat_type.INT:
				_card_inst.stats[2].remove_modifier(_modifier);
				break;
			case champ_stat_type.DVT:
				_card_inst.stats[3].remove_modifier(_modifier);
				break;
			case champ_stat_type.CAN_EQUIP:
				_card_inst.can_equip_gears.remove_modifier(_modifier);
				break;
			case champ_stat_type.CAN_MAGIC:
				_card_inst.can_use_magics.remove_modifier(_modifier);
				break;
			case champ_stat_type.CAN_ABILITY:
				_card_inst.can_use_abilities.remove_modifier(_modifier);
				break;
			default:
				throw($"Invalid Champion Stat: {_modifier.stat}");
		}
    };
		
	static champ_reduce_modifiers_duration = function(_card_inst) {
		_card_inst.hp.reduce_modifiers_duration();
		_card_inst.gw.reduce_modifiers_duration();
		_card_inst.md.reduce_modifiers_duration();
		_card_inst.card_type.reduce_modifiers_duration();
		_card_inst.stats[0].reduce_modifiers_duration();
		_card_inst.stats[1].reduce_modifiers_duration();
		_card_inst.stats[2].reduce_modifiers_duration();
		_card_inst.stats[3].reduce_modifiers_duration();
		_card_inst.can_equip_gears.reduce_modifiers_duration();
		_card_inst.can_use_magics.reduce_modifiers_duration();
		_card_inst.can_use_abilities.reduce_modifiers_duration();
		_card_inst.type_dmg_incr[card_types.GRAY].reduce_modifiers_duration();
		_card_inst.type_dmg_incr[card_types.RED].reduce_modifiers_duration();
		_card_inst.type_dmg_incr[card_types.BLUE].reduce_modifiers_duration();
		_card_inst.type_dmg_incr[card_types.GOLD].reduce_modifiers_duration();
	}
		
	static champ_apply_passive = function(_card_inst, _passive, _current_state, _new_state, _gear = undefined) {
		if (_passive != undefined) {
			var _modifiers = _passive.modifiers;
			var _size = array_length(_modifiers);
		
			if (_current_state != _new_state) {
				for (var i = 0; i < _size; i++) {
					if (_new_state) {
						champ_add_modifier(_card_inst, _modifiers[i]);
					} else {
						champ_remove_modifier(_card_inst, _modifiers[i]);
					}
				}
			}
		}
    };
	
	static champ_apply_passives = function(_card_inst) {
		// Main Passive
		var _passive = _card_inst.card_passive;
		if (_passive != undefined) {
			var _current_state = _card_inst.card_passive_state;
			var _new_state = _passive.active_func(_card_inst);
		
			_card_inst.champ_apply_passive(_card_inst, _passive, _current_state, _new_state);
		
			_card_inst.card_passive_state = _new_state;
		}
		
		// Gears Passives
		var _gears = _card_inst.gears;
		var _gear = undefined;
		var _size = array_length(_gears);
		
		for (var i = 0; i < _size; i++) {
			_gear = _gears[i];
			_passive = _gear.card_passive;
			if (_passive != undefined) {
				_current_state = _card_inst.gears_state[i];
				_new_state = _passive.active_func(_card_inst, _gear);
		
				_card_inst.champ_apply_passive(_card_inst, _passive, _current_state, _new_state, _gear);
		
				_card_inst.gears_state[i] = _new_state;
			}
		}
	}
	
	static champ_remove_passive = function(_card_inst, _passive, _current_state, _gear = undefined) {
		if (_passive != undefined) {
			var _new_state = false;
			var _modifiers = _passive.modifiers;
			var _size = array_length(_modifiers);
		
			if (_current_state != _new_state) {
				for (var i = 0; i < _size; i++) {
					champ_remove_modifier(_card_inst, _modifiers[i]);
				}
			}
		}
    };
	
	static remove_gear = function(_card_inst, _idx) {
		var _gears = _card_inst.gears;
		var _gears_state = _card_inst.gears_state;
		var _gear = _gears[_idx];
		var _passive = _gear.card_passive;
		var _current_state = _gears_state[_idx];
		
		if (_passive != undefined) {
			_card_inst.champ_remove_passive(_card_inst, _passive, _current_state, _gear);
		}
		
		array_delete(_gears, _idx, 1);
		array_delete(_gears_state, _idx, 1);
	}
	
	static remove_gears = function(_card_inst) {
	    var _gears = _card_inst.gears;
	    var _size = array_length(_gears);
    
	    for (var i = _size - 1; i >= 0; i--) {
	        _card_inst.remove_gear(_card_inst, i);
	    }
	}
		
	static gen_champ_attack = function(_card_inst) {
		var _card = _card_inst.card;
		return _card.generate_attack(_card, _card_inst.card_type.get_value());
	}
	
	static gen_gears_attacks = function(_card_inst) {
		var _return = [];
		var _gears = _card_inst.gears;
		var _size = array_length(_gears);
		var _gear = -1;
		var _attack = -1;
		
		for (var i = 0; i < _size; i++) {
			_gear = _gears[i];
			_attack = _gear.generate_attack(_card_inst, _gear);
			array_push(_return, _attack);
		}
		
		return _return;
	}
}