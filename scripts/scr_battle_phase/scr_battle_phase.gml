enum char_state {
	FREE,
	SLIDE,
	ATTACK,
	ATTACKING
}

function char_attack_anim(
	_char_spr_attack, _char_spr_attack_hb, _dmg = 5
) constructor {
	char_spr_attack = _char_spr_attack;
	char_spr_attack_hb = _char_spr_attack_hb;
	dmg = _dmg;
	type = _type;
}

function char_attack_chain(
	_attacks, _recharge_sec = 5, _type = 0, _art = spr_sample_card_art, _check_requirements = function() {return true}
) constructor {
	attacks = _attacks;
	type = _type;
	art_spr = _art_spr;
	avail = true;
	timer = time_source_create(time_source_game, _recharge_sec, time_source_units_seconds,
			function() {
				avail = true;
			}, []
	)
}

attack = [ new char_attack_anim(spr_char_sword_atk_1, spr_sword_atk_1) ];
attacks = [ new char_attack_anim(spr_char_sword_atk_1, spr_sword_atk_1), 
			new char_attack_anim(spr_char_sword_atk_1, spr_sword_atk_1), 
			new char_attack_anim(spr_char_sword_atk_1, spr_sword_atk_1)
		];
		
attack_chain = new char_attack_chain(attack, 3, 0, spr_sample_card_art);
attacks_chain = new char_attack_chain(attacks, 3, 2, spr_sample_gear_art);

function battle_character(_champ_card_inst) constructor {
	hp = _champ_card_inst.hp.get_value();
	max_hp = _champ_card_inst.hp.get_max_value();
	
	gray_dmg_incr = _champ_card_inst.type_dmg_incr[card_types.GRAY].get_value();
	red_dmg_incr = _champ_card_inst.type_dmg_incr[card_types.RED].get_value();
	blue_dmg_incr = _champ_card_inst.type_dmg_incr[card_types.BLUE].get_value();
	gold_dmg_incr = _champ_card_inst.type_dmg_incr[card_types.GOLD].get_value();
	
	champ_attack = attack_chain;
	gears_attacks = [attacks_chain];
	
	char_spr_stand = spr_stand;
	char_spr_step = spr_step;
	char_spr_jump = spr_jump;
	char_spr_walk = spr_walk;
	char_spr_slide = spr_slide;
}
