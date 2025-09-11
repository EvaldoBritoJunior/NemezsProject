global.card_type_colors = [ #71797e, #b90e01, #26619c, #ffba00 ];

enum card_types {
	GRAY = 0, RED = 1, BLUE = 2, GOLD = 3
} 

enum card_stats {
	PWR = 0, SKL = 1, INT = 2, DVT = 3
} 

enum champ_stat_type {
    HP, GW, MD, TYPE, 
	PWR, SKL, INT, DVT, 
	CAN_EQUIP, CAN_MAGIC, CAN_ABILITY,
	GRAY_DMG, RED_DMG, BLUE_DMG, GOLD_DMG
}

enum value_target {
    BASE = -1, CURRENT = 0, MAX = 1, MIN = 2
}

enum math_ops {
    ADD,
    MULTIPLY,
	EQUALS
}

function modifier(_stat_type, _value, _target = value_target.CURRENT, _math_operation = math_ops.ADD, _duration = -1) constructor {
	stat = _stat_type;
	value  = _value;
	target = _target;
	operation = _math_operation;
	duration = _duration;
}

function passive(_modifiers, _active_func) constructor {
	modifiers  = _modifiers;
	active_func = _active_func;
}

function ability(_act_func, _avail_func) constructor {
	act_func = _act_func;
	avail_func = _avail_func;
    avail = false;
}