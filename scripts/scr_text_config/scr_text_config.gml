global.language = global.eng_texts;

global.available_languages = [
	global.ptbr_texts,
	global.eng_texts
];

array_sort(available_languages, function(left, right) {
    if (left.language_name < right.language_name)
        return -1;
    else if (left.language_name > right.language_name)
        return 1;
    else
        return 0;
});

function format_line(_text) {
    // Only process if last char is a space
	var _size =  string_length(_text);
    if (string_char_at(_text, _size) == " ") {
        // Remove trailing space(s)
        _text = string_copy(_text, 1, _size - 1);

        // Find last space in the trimmed string
        var _last_space = string_last_pos(" ", _text);

        if (_last_space > 0) {
            // Insert an extra space after the last space
            var _before = string_copy(_text, 1, _last_space);
            var _after  = string_copy(_text, _last_space + 1, string_length(_text) - _last_space);
            _text = _before + " " + _after;
        }
    }
    
    return _text;
}

function format_description(_text) {
	draw_set_font(font_card_text_10);
    var _result = "";
    var _len = string_length(_text);
	var i = 1;

    while (i <= _len) {
        var _char = string_char_at(_text, i);
        
        // Check if adding this char would overflow
        if (string_width(_result + _char) > 267) {
			_result = format_line(_result);
            _result += "\n";
			if (_char == " ") {
				i++;
				_char = string_char_at(_text, i);
			} 
        }
        
        _result += _char;
		i++;
    }
    
    return _result;
}