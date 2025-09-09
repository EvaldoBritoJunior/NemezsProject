global.eng_texts = {
	language_name: "English",
	
	#region Opening
	
	//Title Screen
	opening_button_text: "Press To Start",
	
	// Main Menu
	start_duel_button_text: "➤ Start Duel",
	start_options_button_text: "Settings",
	
	// Options Menu
	language_button: "Language:",
	input_name: "Name:",
	input_name_confirm_text: "Press ENTER To Confirm",
	finish_config_button_text: "➤ Finish",
	
	#endregion
	
	#region Card Phase
	
	select_card_confirm_text: "Finish",
	select_card_gears: "Gear Deck",
	select_card_magics: "Magic Deck",
	select_card_territories: "Territory Deck",
	
	select_act_title: "Select Action:",
	select_vanguard_title: "Select Next Vanguard:",
	act_equip: "Equip Gear",
	act_ability: "Use Ability",
	act_magic: "Use Magic",
	act_pass: "Do Nothing",
	act_return: "Return",
	
	#endregion
	
	#region Champ Cards
	champ_names: [
		"SQUIRE",
		"KNIGHT",
		"ARCHER",
		"APPRENTICE",
		"ENGINEER",
		"MAGE",
		"WIZARD",
		"EXECUTOR"
	],
	
	champ_descriptions: [
		"[PASSIVE] If this card has two or more Gears equipped, increases each Stat by one",
		"[PASSIVE] If this card is in the Vanguard position, gains 20 total HP",
		"[ABILITY] Select a enemy Champion and inflict 10 dmg plus this card Red dmg bonus",
		"[PASSIVE] If this card is not in the Vanguard position, gains 2 MD",
		"[ABILITY] Draw a Gear card",
		"[ABILITY] Select a ally Champion and heal 10 HP plus this card Gold dmg bonus",
		"[ABILITY] Draw a Magic card",
		"[PASSIVE] If this card has defeated a enemy Champion in Battle, gains 20 dmg bonus for all types"
	],
	#endregion
	
	#region Gear Cards
	gear_names: [
		"ACADEMY BOOK",
		"PRAYERBOOK",
		"WIND BOW",
		"AUTUMN BOW",
		"JAW SHIELD",
		"SANCTUS SHIELD",
		"MAGIC SWORD",
		"FIRE SWORD"
	],
	
	gear_descriptions: [
		"The equipped Champion gains 1 MD",
		"The equipped Champion gains 1 MD",
		"The equipped Champion gains 15 Gray dmg bonus",
		"The equipped Champion gains 15 Red dmg bonus",
		"The equipped Champion gains 15 total HP",
		"The equipped Champion gains 15 total HP",
		"The equipped Champion gains 5 dmg bonus for all types",
		"The equipped Champion gains 5 dmg bonus for all types"
	],
	
	#endregion
	
	#region Magic Cards
	magic_names: [
		"VITAL SIGIL",
		"FORM SHIFT",
		"AFFINITY SURGE",
		"HEX OF SILENCE",
		"VITAL CURSE",
		"VITAL GIFT",
		"OLD WARCRY",
		"DISARM"
	],
	
	magic_descriptions: [
		"Choose a Stat and increase the Champion that used this card Stat by two",
		"Choose a type and change the Champion that used this card to it until the end of the turn",
		"The Champion that used this card gains 10 dmg bonus to its type",
		"Choose a enemy Champion and block its use of Magics until the end of the turn",
		"Choose a enemy champion and a Stat: decrease the Champion Stat by two",
		"Choose a ally champion and a Stat: increase the Champion Stat by two",
		"All Champions gain 10 dmg bonus to its type until the end of the turn",
		"Choose a enemy Champion and break its Gears"
	],
	
	#endregion
	
	#region Territory Cards
	territory_names: [
		"OLD TOWN",
		"MURKY SWAMP",
		"LONE ISLAND",
		"SNOWLAND"
	],
	
	territory_descriptions: [
		"At the start of the turn, each player draws one additional Gear and Magic",
		"At the start of the turn, all Champions lose one Skill until the end of the turn",
		"At the start of the turn, non Vanguard Champions are set not to use Ability until the end of the turn",
		"At the start of the turn, non Vanguard Champions are set not to equip Gear until the end of the turn"
	]
	#endregion
}