if (instance_exists(obj_menu_parent)) {
	
	var _settings_menu_exists = instance_exists(obj_settings_menu);

	if (_settings_menu_exists) {
		var _y_offset = abs(obj_settings_menu.y_offset);

		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text_custom(8, 4 + _y_offset, input_action_get_name(input.back, 1) + ": Save & Return", 1.5);
	
		draw_set_halign(fa_right);
		draw_text_custom(room_width - 8, 4 + _y_offset, input_action_get_name(input.select, 1) + ": Select", 1.5);

	}
	else {
		var _title_menu_exists = instance_exists(obj_title_menu);
		
		var _menu_transition_progress = 1;

		if (_title_menu_exists) {
			_menu_transition_progress = obj_title_menu.press_any_key_mode ? ease_in_cubic(0, 1, obj_title_menu.transition_counter) : ease_out_cubic(0, 1, obj_title_menu.transition_counter);
		}
		
		var _text_transition_progress = ease_out_cubic(0, 1, text_transition_counter);
		var _top_offset = (1 - _text_transition_progress) * -50;
		
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text_custom(8, 4 + _top_offset, "By Mors & Friends", 1.5);
		draw_set_halign(fa_right);
		draw_text_custom(room_width - 8, 4 + _top_offset, "Game: " + global.game_version + "\nLauncher: " + VERSION, 1.5);

		draw_set_valign(fa_bottom);

		var _message_slide_offset = ease_out_cubic(0, 50, message_position);

		var _prompt_offset = (1 - _text_transition_progress) * 50 + _menu_transition_progress * 50;
		
		draw_set_halign(fa_left);
		draw_text_custom(8, room_height - 6 + _prompt_offset + _message_slide_offset, input_action_get_name(input.back, 1) + ": Quit", 1.5);
		draw_set_halign(fa_right);
		draw_text_custom(room_width - 8, room_height - 6 + _prompt_offset, "Press any key to start!", 1.5);

		var _controls_offset = (1 - _menu_transition_progress) * 50;
		
		draw_set_halign(fa_left);
		draw_text_custom(8, room_height - 6 + _controls_offset + _message_slide_offset, input_action_get_name(input.back, 1) + ": Back", 1.5);
		draw_set_halign(fa_right);
		draw_text_custom(room_width - 8, room_height - 6 + _controls_offset, input_action_get_name(input.select, 1) + ": Select", 1.5);
	}

	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
}

if (message_position > 0) {
	
	draw_set_halign(fa_left)
	draw_set_valign(fa_bottom)
	draw_text_custom(ease_out_quint(-room_width/2, 8, message_position), room_height-6, message_text, 1.5)
	draw_set_valign(fa_top)
	draw_set_halign(fa_center)
}

if (fade <= 0)
	exit;

draw_set_color(COLOR_WHITE)
draw_set_alpha(fade)
draw_rectangle(0, 0, room_width, room_height, 0)
draw_set_alpha(1)
draw_set_color(c_white)