global.language = global.eng_texts;

global.available_languages = [
	global.ptbr_texts,
	global.eng_texts
];

array_sort(available_languages,function(left, right) {
    if (left.language_name < right.language_name)
        return -1;
    else if (left.language_name > right.language_name)
        return 1;
    else
        return 0;
});