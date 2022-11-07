if (slide_out) {
	
	if (progress > 0)
		progress -= 0.03125
	else {
		if (save) {
			item.state[0] = rgb_to_bgr(hex_to_real(color_string))
			item.state[1] = real_to_hex(hex_to_real(color_string), 6)
		}
		obj_settings_menu.selected = false;
		instance_destroy();
	}
}
else {
	
	if (progress < 1)
		progress += 0.03125
	
	if (clipboard_has_text() && keyboard_check(vk_control) && keyboard_check_pressed(ord("V"))) {
		sfx_play(snd_select2);
		keyboard_string = clipboard_get_text()
	}
	color_string = string_copy(string_replace_all(string_replace_all(string_replace_all(keyboard_string, " ", ""), "#", ""), "R", choose("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F")), 0, 6);
	keyboard_string = color_string;
	
	if (keyboard_check(vk_control)) {
		if (keyboard_check_pressed(ord("C"))) {
			clipboard_set_text(color_string);
			sfx_play(snd_select1);
		}
		if (keyboard_check_pressed(ord("X"))) {
			clipboard_set_text(color_string);
			sfx_play(snd_select1);
			color_string = "";
			keyboard_string = "";
		}
	}
	
	if (input_check_pressed(key.del2)) {
		reset_color();
		shake = 32;
		sfx_play(snd_denied);
		obj_background.display_message("Loaded the default color.")
	}

	if (input_check_pressed(key.select)) {
		if (string_length(color_string) < 6) {
			shake = 8;
			sfx_play(snd_denied);
		}
		else {
			slide_out = true;
			sfx_play(snd_select)
		}
	}
	if (input_check_pressed(key.back)) {
		slide_out = true;
		save = false;
		sfx_play(snd_cancel)
	}
}


if (shake > 0)
	shake --;