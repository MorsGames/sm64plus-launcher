/// @desc Changing the settings and whatnot

if (move == 2) {
	slide_out();
}
else if (move == 1) {
	slide_in();
}
else {
	
	x_go = lerp(x_go, selected_category, 0.375)
	
	if (!instance_exists(obj_palette_editor) && !instance_exists(obj_button_detector)) {
	
		if (selected_category == -1)
			presets_page();
		else
			settings_page(selected_category <= -2);
	
		// Back to the main menu
		go_back();
	}
}


// Fade out
if (fade > 0)
	fade -= 1/60
	
box_width = lerp(box_width, selected_category == -1 ? BOX_SPACING_2 : 8, 0.375)
box_height = lerp(box_height, selected_category == -1 ? 28 : 8, 0.375)