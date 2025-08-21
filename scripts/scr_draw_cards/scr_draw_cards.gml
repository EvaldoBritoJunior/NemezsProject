function card_stat_str(_stat) {
	switch (_stat)
	{
	    case 6:
	        return "S";
	    case 5:
	        return "A";
		case 4:
	        return "B";
		case 3:
	        return "C";
		case 2:
	        return "D";
		case 1:
	        return "E";
	    case 0:
	        return "-";
		default:
	        throw ($"Invalid stat value: {_stat}");
	}
}

#region Draw card elements	
function draw_card_stats(_stats, _x, _y) {
	draw_middle_center_outline(_x - 85, _y + 228, card_stat_str(_stats[0]), font_card_text_25);
	draw_middle_center_outline(_x - 16, _y + 228, card_stat_str(_stats[1]), font_card_text_25);
	draw_middle_center_outline(_x + 52, _y + 228, card_stat_str(_stats[2]), font_card_text_25);
	draw_middle_center_outline(_x + 116, _y + 228, card_stat_str(_stats[3]), font_card_text_25);
}

function draw_card_inst_stats(_stats, _stats_orig, _x, _y) {
    var offsets = [-85, -16, 52, 116];
    var y_pos   = _y + 228;

    for (var i = 0; i < array_length(offsets); i++) {
        var value = _stats[i];
        var value_orig = _stats_orig[i];
        var xpos = _x + offsets[i];
        
        var col = undefined;
        if (value > value_orig) {
            col = c_green;
        } else if (value < value_orig) {
            col = c_red;
        }
        
        draw_middle_center_outline(xpos, y_pos, card_stat_str(value), font_card_text_25, col);
    }
}

function draw_card_type(_type, _x, _y) {
	draw_sprite(spr_card_type, _type, _x, _y + 81);
}

function draw_card_name(_text, _x, _y) {
	draw_middle_center_outline(_x, _y  + 21, _text, font_card_text_23);
	draw_line_width(_x - 130, _y + 38, _x + 130, _y + 38, 3);
}

function draw_card_description(_card, _x, _y) {
	var _text = _card.description;
	draw_outline(_x - 135, _y + 125, _text, font_card_text_10);
}

function draw_cut_card_name(_text, _x, _y, _w, _h) {
	var _x_pos = _x + (_w / 2);
	var _x1 = _x_pos - (_w / 3);
	var _x2 = _x_pos + (_w / 3)
	var _y_pos = _y + _h / 1.3;
	draw_middle_center_outline(_x_pos, _y_pos, _text, font_card_text_13);
	draw_line_width(_x1, _y_pos + 7, _x2, _y_pos + 7, 1);
}

function draw_cut_card_type(_type, _x, _y, _w, _h) {
	var _size = 30;
	var _x_pos = _x + (_w / 2) - (_size / 2);
	var _y_pos = _y + _h - (_size * 1.1);
	draw_sprite_stretched(spr_card_type, _type, _x_pos, _y_pos, _size, _size);
}

#endregion

#region Draw cards

function draw_champ_cut_card(_card, _x, _y, _w, _h){
	draw_sprite_stretched(_card.spr_cut_card, 0, _x, _y, _w, _h);
	draw_cut_card_name(_card.name, _x, _y, _w, _h);
	draw_cut_card_type(_card.type, _x, _y, _w, _h);
	
	draw_middle_center_outline(_x + 50, _y + 25, $"{_card.hp}hp", font_card_text_10);
	draw_middle_center_outline(_x + 40, _y + 25 + 23, $"{_card.gw}gw", font_card_text_10);
	draw_middle_center_outline(_x + 40, _y + 25 + 43, $"{_card.md}md", font_card_text_10);
}

function draw_champ_card(_card, _x, _y){
	draw_sprite(_card.spr_card, 0, _x, _y);
	draw_card_name(_card.name, _x, _y);
	draw_card_description(_card, _x, _y);
	draw_card_stats(_card.stats, _x, _y);
	draw_card_type(_card.type, _x, _y);
	
	draw_middle_center_outline(_x - 75, _y - 225, "hp", font_card_text_10);
	draw_middle_center_outline(_x - 117, _y - 232, _card.hp, font_card_text_20);
	
	draw_middle_center_outline(_x - 113, _y - 184, "gw", font_card_text_10);
	draw_middle_center_outline(_x - 137, _y - 191, _card.gw, font_card_text_20);
	
	draw_middle_center_outline(_x - 113, _y - 143, "md", font_card_text_10);
	draw_middle_center_outline(_x - 137, _y - 150, _card.md, font_card_text_20);
}

function draw_champ_card_instance(_card_inst, _x, _y){
	var _card = _card_inst.card;
	var _stats = _card_inst.stats;
	var _stats_orig = _card.stats;
	
	draw_sprite(_card.spr_card, 0, _x, _y);
	draw_card_name(_card.name, _x, _y);
	draw_card_description(_card, _x, _y);
	
	draw_card_inst_stats(_stats, _stats_orig, _x, _y);
	
	draw_card_type(_card_inst.type, _x, _y);
	
	draw_middle_center_outline(_x - 75, _y - 225, "hp", font_card_text_10);
	draw_middle_center_outline(_x - 117, _y - 232, _card.hp, font_card_text_20);
	
	draw_middle_center_outline(_x - 113, _y - 184, "gw", font_card_text_10);
	draw_middle_center_outline(_x - 137, _y - 191, _card.gw, font_card_text_20);
	
	draw_middle_center_outline(_x - 113, _y - 143, "md", font_card_text_10);
	draw_middle_center_outline(_x - 137, _y - 150, _card.md, font_card_text_20);
	
}
		
function draw_gear_cut_card(_card, _x, _y, _w, _h){
	draw_sprite_stretched(_card.spr_cut_card, 0, _x, _y, _w, _h);
	draw_cut_card_name(_card.name, _x, _y, _w, _h);
	draw_cut_card_type(_card.type, _x, _y, _w, _h);
	
	draw_middle_center_outline(_x + 40, _y + 25, $"{_card.gw}gw", font_card_text_10);
}

function draw_gear_card(_card, _x, _y){
	draw_sprite(_card.spr_card, 0, _x, _y);
	draw_card_name(_card.name, _x, _y);
	draw_card_description(_card, _x, _y);
	draw_card_stats(_card.stats, _x, _y);
	draw_card_type(_card.type, _x, _y);
	
	draw_middle_center_outline(_x - 113, _y - 225, "gw", font_card_text_10);
	draw_middle_center_outline(_x - 137, _y - 232, _card.gw, font_card_text_20);
}

function draw_magic_cut_card(_card, _x, _y, _w, _h){
	draw_sprite_stretched(_card.spr_cut_card, 0, _x, _y, _w, _h);
	draw_cut_card_name(_card.name, _x, _y, _w, _h);

	draw_middle_center_outline(_x + 40, _y + 25, $"{_card.md}md", font_card_text_10);
}

function draw_magic_card(_card, _x, _y){
	draw_sprite(_card.spr_card, 0, _x, _y);
	draw_card_name(_card.name, _x, _y);
	draw_card_description(_card, _x, _y);
	
	draw_middle_center_outline(_x - 113, _y - 225, "md", font_card_text_10);
	draw_middle_center_outline(_x - 137, _y - 232, _card.md, font_card_text_20);
}
#endregion