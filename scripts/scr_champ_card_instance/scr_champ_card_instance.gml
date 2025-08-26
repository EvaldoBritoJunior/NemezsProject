enum champ_stat_type {
    HP, GW, MD, TYPE, STR, SKL, INT, DVT, CAN_EQUIP, CAN_MAGIC, CAN_ABILITY
}

enum value_target {
    BASE = -1, CURRENT = 0, MAX = 1, MIN = 2
}

enum math_ops {
    ADD,
    MULTIPLY,
	EQUALS
}

function modifier(_stat, _value, _target = value_target.CURRENT, _math_operation = math_ops.ADD, _duration = -1) constructor {
	stat = _stat;
	value  = _value;
	operation = _math_operation;
	target = _target;
	duration = _duration;
	active = true;
}

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
			switch (_mod.operation) {
	            case math_ops.ADD:
	                base_value += m.value;
	                break;
	            case math_ops.MULTIPLY:
	                base_value *= m.value;
	                break;
	            case math_ops.EQUALS:
	                base_value = m.value;
	                break;
			}
			if (base_value > max_value) {
				base_value = max_value;
		    }
		    if (base_value < min_value) {
		        base_value = min_value;
		    }
		} else {
			array_push(modifiers, _mod);
		}
        altered = true;     // mark dirty so GetValue will recalc
    };
	
	static remove_modifier = function(_mod) {
		var _m = -1;
		var _rmvd = false;
        for (var i = 0; i < array_length(modifiers); i++) {
            _m = modifiers[i];
            if (_m == _mod) {
				array_delete(modifiers, i, 1);
				_rmvd = true;
				break;
			}
        }
       if (_rmvd) altered = true;     // mark dirty so GetValue will recalc
    };

    static get_value = function() {
	    if (!altered) return current_value;

	    var values = [base_value, max_value, min_value];

	    for (var i = 0; i < array_length(modifiers); i++) {
	        var m = modifiers[i];
	        if (!m.active) continue;

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
			
			// Clamp current value
		    if (values[stat_target.CURRENT] > values[stat_target.MAX]) {
		        values[stat_target.CURRENT] = values[stat_target.MAX];
		    }
		    if (values[stat_target.CURRENT] < values[stat_target.MIN]) {
		        values[stat_target.CURRENT] = values[stat_target.MIN];
		    }
	    }

	    current_value     = values[stat_target.CURRENT];
	    current_max_value = values[stat_target.MAX];
	    current_min_value = values[stat_target.MIN];
	    altered           = false;

	    return current_value;
	};
	
	static get_max_value = function() {
		if (!altered) return current_max_value;
		get_value();
		return current_max_value;
	}
}

function champ_instance(_card, _card_owner, _card_pos) constructor {
	card = _card;
	card_owner = _card_owner;
	card_pos = _card_pos;
	
	hp = new champ_stat(_card.hp, _card.hp);
	gw = new champ_stat(0, _card.gw);
	md = new champ_stat(_card.md, 9);
	type = new champ_stat(_card.type, 3);
	stats = [new champ_stat(_card.stats[0], 6),
			 new champ_stat(_card.stats[1], 6),
			 new champ_stat(_card.stats[2], 6),
			 new champ_stat(_card.stats[3], 6)];
			 
	card_passive = _card.card_passive;
	card_ability = _card.card_ability;
	
	can_equip_gears = new champ_stat(true, true);
	can_use_magics = new champ_stat(true, true);
	can_use_abilities = new champ_stat(true, true);
	
	condition = -1;
	gears = [];
	
	static can_equip_gear = function(_card_inst, _gear) {
		var _champ_gw = _card_inst.gw.get_value();
		var _champ_max_gw = _card_inst.gw.get_max_value();
		var _gear_gw = _gear.gw;
		
		return (_champ_gw + _gear_gw <= _champ_max_gw);
    };
	
	static equip_gear = function(_card_inst, _gear, _idx) {
		redo_act_menu();
    };
	
	static can_use_magic = function(_card_inst, _magic) {
		var _magic_ability = _magic.card_ability;
		var _champ_md = _card_inst.md.get_value();
		var _magic_md = _magic.md;
		return (_card_inst.can_use_magics.get_value()
				&& _magic_md <= _champ_md
				&& _magic_ability.avail_func(_card_inst));
    };

	static use_magic = function(_card_inst, _magic, _idx) {
		script_execute_ext(_magic.card_ability.act_func, [_card_inst, _idx, self]);
    };
	
	static can_use_ability = function(_card_inst) {
		var _champ_ability = _card_inst.card_ability;
		return (_card_inst.can_use_abilities.get_value()
				&& _champ_ability != -1 
				&& _champ_ability.avail_func(_card_inst));
    };
	
	static use_ability = function(_card_inst) {
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
				_card_inst.type.add_modifier(_modifier);
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
				_card_inst.type.remove_modifier(_modifier);
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
}