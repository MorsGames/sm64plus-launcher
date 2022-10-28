/// @desc Some shared functions

// The options
options = []

// Current option
selected_option = 0;

// Whether if an option is selected or not.
selected = 0;

// The selection y
select_y = 0

// Offset of the menu
scroll_offset = 0;

// The screen offsets
y_offset = room_height;
move = 1;

// Shake
shake = 0;

// Change which option is selected
change_selected_option = function(total_options, items_per_page, can_be_changed, indicator_offset = 0) {
	
	var _ver_movement = can_be_changed ? input_check_pressed(key.down) - input_check_pressed(key.up) : 0;
	var _long_ver_movement = wait(3)*(can_be_changed ? input_check_long(key.down) - input_check_long(key.up) : 0);
	var _movement = _ver_movement + _long_ver_movement;
	var _original_option = selected_option;
	selected_option = (selected_option +_movement) % total_options;
	if (selected_option < 0) {
		selected_option = total_options - 1;
	}
	
	if (_movement <> 0 && selected_option != _original_option)
		sfx_play(snd_move);
		
	if (selected_option > scroll_offset + items_per_page && scroll_offset < total_options - items_per_page - 2)
		scroll_offset += 1;
	if (selected_option < scroll_offset + 1 && scroll_offset > 0)
		scroll_offset -= 1;

	select_y += clamp(lerp(select_y, (selected_option-scroll_offset-indicator_offset)*20, 0.375)-select_y, -32, 32);
	
	return _movement;
}

slide_in = function() {
	
	y_offset = lerp(y_offset, 0, 0.25);
	
	if (round(y_offset) <= 0) {
		
		y_offset = 0
		move = 0
	}	
}

slide_out = function() {
	
	y_offset = lerp(y_offset, -room_height, 0.25);
	
	if (round(y_offset) <= -room_height) {
		
		instance_destroy();
		instance_create_layer(0, 0, layer, obj_title_menu);
	}	
}

// Back to the main menu
go_back = function() {
	
	if (input_check_pressed(key.back)) {
		
		if (selected) {
			selected = 0;
			sfx_play(snd_select2);
		}
		else {
			move = 2;
			sfx_play(snd_cancel);
		}
	}
}

add_shake = function(hovered) {
	if (hovered && shake > 0)
		return sin(current_frames)*shake;
	else
		return 0;
}