if (instance_exists(obj_menu_parent)) {
	
	draw_set_halign(fa_left)
	draw_text_custom(8, 4, input_action_get_name(key.select, 1)+": Select", 1.5)

	if (instance_exists(obj_settings_menu)) {//&& obj_presets_menu.selected_option != array_length(obj_presets_menu.options)) {
		
		var _y = ease_in_sine(0, 32, 1+min(obj_settings_menu.x_go, 0)) + abs(obj_settings_menu.y_offset);
		
		draw_set_valign(fa_bottom)
		draw_text_custom(ease_out_quint(8, -room_width/2, message_position), room_height-6+_y, "Hold " + input_action_get_name(key.select, 1) + " to Fully Reload", 1.5)
		draw_set_halign(fa_right)
		draw_text_custom(room_width-8, room_height-6+_y, "Hold " + input_action_get_name(key.del, 1) + " to Delete", 1.5)
		draw_set_valign(fa_top)
	}
	
	draw_set_halign(fa_right)
	draw_text_custom(room_width-8+abs(obj_menu_parent.y_offset), 4, input_action_get_name(key.back, 1) + (instance_exists(obj_title_menu) ? ": Quit" : ": Save & Return"), 1.5)
	draw_set_halign(fa_center)
	
	if (instance_exists(obj_title_menu)) {
		
		var _y = abs(obj_title_menu.y_offset);
		
		draw_set_halign(fa_left)
		draw_set_valign(fa_bottom)
		draw_text_custom(ease_out_quint(8, -room_width/2, message_position), room_height-6+_y, "2021 - 2022 | Mors", 1.5)
		draw_set_halign(fa_right)
		draw_text_custom(room_width-8, room_height-6+_y, "Game: " + global.game_version + "\nLauncher: " + VERSION, 1.5)
		draw_set_valign(fa_top)
		draw_set_halign(fa_center)
	}
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