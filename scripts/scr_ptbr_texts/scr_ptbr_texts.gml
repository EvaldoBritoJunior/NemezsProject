global.ptbr_texts = {
	language_name: "Português (BR)",
	
	#region Opening
	
	//Title Screen
	opening_button_text: "Pressione Para Começar",
	
	// Main Menu
	start_duel_button_text: "➤ Iniciar Duelo",
	start_options_button_text: "Configurações",
	watch_tutorial_button_text: "Assistir Tutorial",
	give_feedback_button_text: "Dar Feedback",
	cancel_button_text: "Cancelar",
	
	watch_tutorial_url: "https://www.youtube.com/watch?v=jhQE8KUhDgY",
	give_feedback_url: "https://docs.google.com/forms/d/e/1FAIpQLScwW3BRSD6MymIX0ZLKaaUx-lNmxaqVA-0To8aT5MvyEaPzkw/viewform?usp=dialog",
	
	// Options Menu
	language_button: "Idioma:",
	input_name: "Nome:",
	input_name_confirm_text: "Pressione ENTER Para Confirmar",
	finish_config_button_text: "➤ Finalizar",
	
	#endregion
	
	#region Card Phase
	
	select_card_confirm_text: "Concluir",
	select_card_gears: "Deck de Gears",
	select_card_magics: "Deck de Magias",
	select_card_territories: "Territórios",
	
	select_act_title: "Selecione Ação:",
	select_vanguard_title: "Selecione o Próximo Vanguard:",
	act_equip: "Equipar Gear",
	act_ability: "Habilidade",
	act_magic: "Usar Magia",
	act_pass: "Não Fazer Nada",
	act_return: "Voltar",
	act_card_stats: ["Poder", "Perícia", "Inteligência", "Devoção"],
	act_card_types: ["Gray", "Red", "Blue", "Gold"],
	
	#endregion
	
	#region Champ Cards
	champ_names: [
		"GUERREIRO",
		"CAVALEIRO",
		"ARQUEIRO",
		"APRENDIZ",
		"ENGENHEIRO",
		"MAGO",
		"FEITICEIRA",
		"EXECUTORA"
	],
	
	champ_descriptions: [
		"[PASSIVA] Se esta carta tiver dois ou mais Gears equipados, aumenta cada Stat em um",
		"[PASSIVA] Se esta carta estiver na posicao Vanguard, ganha 20 HP total",
		"[HABILIDADE] Selecione um Champion inimigo e cause 10 dmg mais o bonus de dmg Red desta carta",
		"[PASSIVA] Se esta carta nao estiver na posicao Vanguard, ganha 2 MD",
		"[HABILIDADE] Compre uma carta de Gear",
		"[HABILIDADE] Selecione um Champion aliado e cure 10 HP mais o bonus de dmg Gold desta carta",
		"[HABILIDADE] Compre uma carta de Magia",
		"[PASSIVA] Se esta carta derrotou um Champion inimigo em Batalha, ganha bonus de 20 dmg para todos os tipos"
	],
	#endregion
	
	#region Gear Cards
	gear_names: [
		"LIVRO ACADEMICO",
		"LIVRO SAGRADO",
		"ARCO DO VENTO",
		"ARCO DO OUTONO",
		"ESCUDO OSSO",
		"ESCUDO SANCTUS",
		"ESPADA MAGICA",
		"ESPADA DE FOGO"
	],
	
	gear_descriptions: [
		"O Champion equipado ganha 1 MD",
		"O Champion equipado ganha 1 MD",
		"O Champion equipado ganha bonus de 15 dmg Gray",
		"O Champion equipado ganha bonus de 15 dmg Red",
		"O Champion equipado ganha 15 HP total",
		"O Champion equipado ganha 15 HP total",
		"O Champion equipado ganha bonus de 5 dmg para todos os tipos",
		"O Champion equipado ganha bonus de 5 dmg para todos os tipos"
	],
	
	#endregion
	
	#region Magic Cards
	magic_names: [
		"SIMBOLO VITAL",
		"MUDAR DE FORMA",
		"AFINIDADE",
		"HEX DO SILENCIO",
		"MALDICAO VITAL",
		"DADIVA VITAL",
		"BRADO DE GUERRA",
		"DESARMAR"
	],
	
	magic_descriptions: [
		"Escolha um Status e aumente em dois o Status do Champion que usou esta carta",
		"Escolha um tipo e mude o Champion que usou esta carta para ele ate o fim do turno",
		"O Champion que usou esta carta ganha bonus de 15 dmg para seu tipo atual",
		"Escolha um Champion inimigo e bloqueie seu uso de Magia ate o fim do turno",
		"Escolha um Champion inimigo e um Status: reduza o Stat do Champion em dois",
		"Escolha um Champion aliado e aumente todos seus Stats em um",
		"Todos os Champions ganham bonus de 10 dmg para seu tipo ate o fim do turno",
		"Escolha um Gear do Vanguard inimigo e remova-o"
	],
	
	#endregion
	
	#region Territory Cards
	territory_names: [
		"CIDADE ANTIGA",
		"PANTANO TURVO",
		"ILHA SOLITARIA",
		"TERRA NEVADA"
	],
	
	territory_descriptions: [
		"No inicio do turno, cada jogador compra um Gear e uma Magia adicionais",
		"No inicio do turno, todos os Champions perdem um ponto em Pericia ate o fim do turno",
		"No inicio do turno, Champions fora de Vanguard tem sua HABILIDADE bloqueada ate o fim do turno",
		"No inicio do turno, Champions fora de Vanguard sao bloqueados de equipar Gear ate o fim do turno"
	]
	#endregion
}