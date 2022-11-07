/// @desc The options menu

event_inherited();

// Current category and option
selected_category = 0;
obj_background.change_background(selected_category);
obj_background.message_timer = 0;

// The movement of the arrows at the top
arrow_frames = 0;
x_go = 0
box_width = 8
box_height = 8

get_options_per_page = function() {
	
	return floor((room_height-180)/20);
}

// Change which category is selected
change_category = function() {
	var _hor_movement = input_check_pressed(key.right) - input_check_pressed(key.left) + input_check_pressed(key.page_right) - input_check_pressed(key.page_left);
	var _long_hor_movement = input_check_long(key.right) - input_check_long(key.left);
	var _original_category = selected_category;
	selected_category = clamp(selected_category + _hor_movement + wait(8)*_long_hor_movement, -1, global.category_count-1);

	if (_hor_movement <> 0 || _long_hor_movement <> 0) {
		scroll_offset = 0;
		selected_option = 0;
		shake = 0;
		obj_background.change_background(selected_category);
	}
	if (_hor_movement+wait(8)*_long_hor_movement <> 0 && selected_category != _original_category)
		sfx_play(snd_page)
	arrow_frames++;
}

settings_page = function() {

	var _category = global.categories[selected_category];
	var _total_options = array_length(_category.items);
	
	// If the page isn't empty
	if (_total_options > 0) {
	
		// Change the option itself.
		var _option = _category.items[selected_option];
		if (input_check_pressed(key.select)) {
			switch (_option.type) {
				case option_type.boolean:
					_option.state = !_option.state;
					sfx_play(_option.state ? snd_select : snd_cancel)
					shake = 1;
					break;
				case option_type.color:
					selected = !selected;
					sfx_play(selected ? snd_select : snd_cancel)
					shake = 1;
					if (selected) {
						with (instance_create_depth(0, 0, depth-1, obj_palette_editor)) {
							item = _option;
						}
					}
					break;
				case option_type.controller_button:
					selected = !selected;
					sfx_play(selected ? snd_select : snd_cancel)
					shake = 1;
					if (selected) {
						with (instance_create_depth(0, 0, depth-1, obj_button_detector)) {
							item = _option;
						}
					}
					break;
				default:
					selected = !selected;
					sfx_play(selected ? snd_select1 : snd_select2)
					keyboard_string = "";
					if (!selected)
						shake = 1;
					break;
			}
		}
		if (selected) {
			// Change the state of the selected option
			var _hor_movement = input_check_pressed(key.right) - input_check_pressed(key.left);
			var _long_hor_movement = input_check_long(key.right) - input_check_long(key.left);
				
            var _old_state = _option.state;
			change_option_state(_option, _hor_movement, _long_hor_movement);
			
			if (_hor_movement <> 0 || (_long_hor_movement <> 0 && wait(4))) {
             
                if (_option.state == _old_state) {
                    sfx_play(snd_denied);
                    h_shake = 1
                }
                else
				    sfx_play(snd_option);
            }
		}
		else {
			// Change which option is selected
			do {
				 change_selected_option(_total_options, get_options_per_page()-2, round(x_go) == selected_category);
			}
			until (is_enabled(global.categories[selected_category].items, selected_option) || global.show_hidden)
	
			// Change the selected category
			change_category();
		
		}
	}
	else {
		change_category();
	}	
}

presets_page = function() {
	
	var _total_options = array_length(options)+1;

	// Select an option
	var _option;

	if (selected_option == _total_options-1)
		_option = -1;
	else
		_option = options[selected_option]
	

	if (selected) {
		if (input_check_pressed(key.select2)) {
			if (keyboard_string = "")
				keyboard_string = "Preset" + string_format(_total_options, 2, 0);
			save_settings(PRESETS_PATH + keyboard_string + ".ini");
			array_resize(options, 0)
			load_presets();
			selected = 0;
			obj_background.display_message("Saved the preset!")
			sfx_play(snd_select)
			selected_option = array_length(options);
			shake = 1;
		}
	}
	else {
		if (input_check_pressed(key.select)) {
			if (_option == -1) {
				selected = 1;
				keyboard_string = "";
			}
			else {
				load_settings(_option, true, true);
				fade = 1;
				obj_background.display_message("Loaded the settings!")
				sfx_play(snd_select)
				shake = 1;
			}
		}
		if (input_check_hold_time(key.select) == 120) {
			if (_option != -1) {
				load_settings(_option);
				fade = 1;
				obj_background.display_message("Loaded all the settings!")
				sfx_play(snd_start)
				shake = 1;
			}
		}
		if (input_check_hold_time(key.del) == 60) {
			if (_option != -1 && !string_count(INTERNAL_PRESETS_PATH, _option))  {
				if (file_delete(_option)) {
					array_resize(options, 0)
					load_presets();
					obj_background.display_message("Deleted the preset!")
					sfx_play(snd_cancel)
				
					selected_option = array_length(options);
				}
			}
		}

		// Change which option is selected
		change_selected_option(_total_options, get_options_per_page()-2, round(x_go) == -1);
		change_category();
	}	
}

// Load the files
load_preset_files = function(path) {
	_next_file = file_find_first(path + "*.ini", 0);

	while (_next_file != "") {
		array_push(options, path + _next_file);
		_next_file = file_find_next();
	}
	file_find_close();	
}
load_presets = function() {
	load_preset_files(INTERNAL_PRESETS_PATH);
	load_preset_files(PRESETS_PATH);
}
load_presets();

// Screen fade effect
fade = 0;