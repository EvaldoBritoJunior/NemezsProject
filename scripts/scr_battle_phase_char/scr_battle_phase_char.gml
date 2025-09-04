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

attack = [ new char_attack_anim(spr_char_sword_atk_1, spr_sword_atk_1, 15, true) ];
attacks = [ new char_attack_anim(spr_char_sword_atk_1, spr_sword_atk_1)
			, new char_attack_anim(spr_char_sword_atk_1, spr_sword_atk_1)
			, new char_attack_anim(spr_char_sword_atk_1, spr_sword_atk_1, 15, true)
		];
		
		
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
		
global.attack_chain = new char_attack_chain(attack, 3, 0);
global.attacks_chain = new char_attack_chain(attacks, 3, 1, spr_sample_gear_art);
global.attacks_chain1 = new char_attack_chain(attacks, 3, 2, spr_sample_gear_art);
global.attacks_chain2 = new char_attack_chain(attacks, 3, 3, spr_sample_gear_art);

function battle_character(_champ_card_inst) constructor {
	hp = _champ_card_inst.hp.get_value();
	max_hp = _champ_card_inst.hp.get_max_value();
	
	dmg_incr = [
		_champ_card_inst.type_dmg_incr[card_types.GRAY].get_value(),
		_champ_card_inst.type_dmg_incr[card_types.RED].get_value(),
		_champ_card_inst.type_dmg_incr[card_types.BLUE].get_value(),
		_champ_card_inst.type_dmg_incr[card_types.GOLD].get_value()
	];
	
	champ_attack = global.attack_chain;
	gears_attacks = [global.attacks_chain, global.attacks_chain1, global.attacks_chain2];
	
	char_spr_stand = spr_stand;
	char_spr_step = spr_step;
	char_spr_jump = spr_jump;
	char_spr_walk = spr_walk;
	char_spr_slide = spr_slide;
}
