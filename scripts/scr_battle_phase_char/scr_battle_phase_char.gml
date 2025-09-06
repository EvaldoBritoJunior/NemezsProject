enum attack_orig {
	CHAMPION,
	GEAR
}

enum char_state {
	FREE,
	SLIDE,
	ATTACK,
	ATTACKING
}

function char_attack_anim(
	_char_spr_attack, _char_spr_attack_hb, _dmg = 15, _projectile = false, _sturdy = 0
) constructor {
	char_spr_attack = _char_spr_attack;
	char_spr_attack_hb = _char_spr_attack_hb;
	dmg = _dmg;
	projectile = _projectile;
	sturdy = _sturdy;
}
		
function char_attack_chain(
	_attacks, _recharge_sec = 5, _type = 0, _spr_icon = spr_sample_card_art,
	_check_requirements = function() {return true}
) constructor {
	attacks = _attacks;
	type = _type;
	spr_icon = _spr_icon;
	avail = true;
	timer = time_source_create(time_source_game, _recharge_sec, time_source_units_seconds,
			function() {
				avail = true;
			}, []
	)
	check_requirements = _check_requirements;
}
		
function battle_character(_champ_card_inst) constructor {
	hp = _champ_card_inst.hp.get_value();
	max_hp = _champ_card_inst.hp.get_max_value();
	
	dmg_incr = [
		_champ_card_inst.type_dmg_incr[card_types.GRAY].get_value(),
		_champ_card_inst.type_dmg_incr[card_types.RED].get_value(),
		_champ_card_inst.type_dmg_incr[card_types.BLUE].get_value(),
		_champ_card_inst.type_dmg_incr[card_types.GOLD].get_value()
	];
	
	champ_attack = _champ_card_inst.gen_champ_attack(_champ_card_inst);
	gears_attacks =  _champ_card_inst.gen_gears_attacks(_champ_card_inst);
	
	char_spr_stand = spr_stand;
	char_spr_step = spr_step;
	char_spr_jump = spr_jump;
	char_spr_walk = spr_walk;
	char_spr_slide = spr_slide;
}
