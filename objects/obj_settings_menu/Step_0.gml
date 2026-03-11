/// @desc Changing the settings and whatnot

if (move == 2) {
	slide_out();
}
else if (move == 1) {
	slide_in();
}
else {
	
	x_go = lerp(x_go, selected_tab, 0.375)
	
	if (!instance_exists(obj_palette_editor) && !instance_exists(obj_button_detector)) {
	
		var _id = section_category_indices[selected_tab];
		if (_id == -1)
			presets_page();
		else if (_id == -2)
			input_presets_page();
		else
			settings_page(_id == -3);
	
		// Back to the main menu
		go_back();
	}
}

for (var i = 0; i < tab_count; i++) {

	var _offset = i - x_go;

	if (abs(_offset) >= 1) {
		scroll_offset[i] = 0;
		scroll_offset_view[i] = 0;
	}
}


// Fade out
if (fade > 0)
	fade -= 1/60

if (title_h_shake > 0)
	title_h_shake -= 0.0625;
else
	title_h_shake = 0;
