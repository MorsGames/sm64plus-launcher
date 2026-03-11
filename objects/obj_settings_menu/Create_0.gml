/// @desc The options menu

event_inherited();

// Current category and option
section_category_indices = [];
switch (global.settings_section) {
	case settings_section.system:
		section_category_indices = [0, 1, -3]; // First two + Launcher shit
		break;
	case settings_section.game_config:
		section_category_indices = [-1]; // Presets
		for (var i = 0; i < array_length(global.game_config_category_indices); i++) {
			array_push(section_category_indices, global.game_config_category_indices[i]);
		}
		break;
	case settings_section.input_mapping:
		section_category_indices = [-2]; // Input presets (woah)
		for (var i = 0; i < array_length(global.input_mapping_category_indices); i++) {
			array_push(section_category_indices, global.input_mapping_category_indices[i]);
		}
		break;
}

tab_count = array_length(section_category_indices);
selected_tab = 0;
selected_category = section_category_indices[selected_tab];

obj_background.change_background(selected_category);
obj_background.message_timer = 0;

scroll_offset = array_create(tab_count, 0);
scroll_offset_view = array_create(tab_count, 0);

// The movement of the arrows at the top
arrow_frames = 0;
x_go = 0
title_h_shake = 0;

get_options_per_page = function() {
	
	return floor((room_height-180)/20);
}

// Change which category is selected
change_category = function() {
	var _hor_movement = input_check_pressed(input.right) - input_check_pressed(input.left) + input_check_pressed(input.page_right) - input_check_pressed(input.page_left);
	var _long_hor_movement = input_check_long(input.right) - input_check_long(input.left);
	var _original_tab = selected_tab;
	selected_tab = clamp(selected_tab + _hor_movement + wait(8)*_long_hor_movement, 0, tab_count-1);
    selected_category = section_category_indices[selected_tab];

	if (_hor_movement != 0 || _long_hor_movement != 0) {
		if (selected_tab != _original_tab) {
			var _page_idx = selected_tab;
			scroll_offset_view[_page_idx] = scroll_offset[_page_idx];
			selected_option = 0;
			shake = 0;
			obj_background.change_background(selected_category);
			sfx_play(snd_page);
		}
		else if (wait(8)*_long_hor_movement != 0 || _hor_movement != 0) {
			sfx_play(snd_denied);
			title_h_shake = 1;
		}
	}
	arrow_frames++;
}

settings_page = function(launcher_settings) {

	var _category = launcher_settings ? global.launcher_category : global.categories[selected_category];
	var _total_options = array_length(_category.items);
	
	// If the page isn't empty
	if (_total_options > 0) {
	
		// Change the option itself
		var _option = _category.items[selected_option];
		if (input_check_pressed(input.select)) {
			switch (_option.type) {
				case option_type.boolean:
					_option.state = !_option.state;
					sfx_play(_option.state ? snd_select : snd_cancel)
					shake = 1;
					break;
				case option_type.color:
					selected = !selected;
					if (selected) {
						old_state = [];
						array_copy(old_state, 0, _option.state, 0, array_length(_option.state));
					}
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
					if (selected) 
						old_state = _option.state;
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
					if (selected)
						old_state = _option.state;
					sfx_play(selected ? snd_select1 : snd_select2)
					keyboard_string = "";
					if (!selected)
						shake = 1;
					break;
			}
		}
		if (selected) {
			// Change the state of the selected option
			var _hor_movement = input_check_pressed(input.right) - input_check_pressed(input.left);
			var _long_hor_movement = input_check_long(input.right) - input_check_long(input.left);
				
			var _old_state = _option.state;
			change_option_state(_option, _hor_movement, _long_hor_movement, launcher_settings, _category);
			
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
			change_selected_option(_total_options, get_options_per_page()-2, round(x_go) == selected_tab, selected_tab - 2);
	
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
		_option = options[selected_option].path
	

	if (selected) {
		if (input_check_pressed(input.select2)) {
			if (keyboard_string = "")
				keyboard_string = "Preset" + string_format(_total_options, 2, 0);
			save_settings_range(PRESETS_PATH + keyboard_string + ".ini", 2, global.category_count - 4);
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
		if (input_check_pressed(input.select)) {
			if (_option == -1) {
				selected = 1;
				keyboard_string = "";
			}
			else {
				load_settings_range(_option, 2, global.category_count - 4, true);
				fade = 1;
				obj_background.display_message("Loaded the settings!")
				sfx_play(snd_select)
				shake = 1;
			}
		}
		if (input_check_hold_time(input.select) == 120) {
			if (_option != -1) {
				load_settings_range(_option, 0, global.category_count - 4);
				fade = 1;
				obj_background.display_message("Loaded all the settings!")
				sfx_play(snd_start)
				shake = 1;
			}
		}
		if (input_check_hold_time(input.del) == 60) {
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
		change_selected_option(_total_options, get_options_per_page()-2, round(x_go) == selected_tab, selected_tab - 2);
		change_category();
	}	
}

input_presets_page = function() {
	
	var _total_options = array_length(input_options)+1;

	// Select an option
	var _option;

	if (selected_option == _total_options-1)
		_option = -1;
	else
		_option = input_options[selected_option].path
	

	if (selected) {
		if (input_check_pressed(input.select2)) {
			if (keyboard_string = "")
				keyboard_string = "Input Preset" + string_format(_total_options, 2, 0);
            
            if (!directory_exists(INPUT_PRESETS_PATH))
                directory_create(INPUT_PRESETS_PATH);
            
			save_settings_range(INPUT_PRESETS_PATH + keyboard_string + ".ini", global.category_count - 3, global.category_count - 1);
			array_resize(input_options, 0)
			load_input_presets();
			selected = 0;
			obj_background.display_message("Saved the input preset!")
			sfx_play(snd_select)
			selected_option = array_length(input_options);
			shake = 1;
		}
	}
	else {
		if (input_check_pressed(input.select)) {
			if (_option == -1) {
				selected = 1;
				keyboard_string = "";
			}
			else {
				load_settings_range(_option, global.category_count - 3, global.category_count - 1, true);
				fade = 1;
				obj_background.display_message("Loaded the input settings!")
				sfx_play(snd_select)
				shake = 1;
			}
		}
		if (input_check_hold_time(input.del) == 60) {
			if (_option != -1 && !string_count(INTERNAL_INPUT_PRESETS_PATH, _option))  {
				if (file_delete(_option)) {
					array_resize(input_options, 0)
					load_input_presets();
					obj_background.display_message("Deleted the input preset!")
					sfx_play(snd_cancel)
				
					selected_option = array_length(input_options);
				}
			}
		}

		// Change which option is selected
		change_selected_option(_total_options, get_options_per_page()-2, round(x_go) == selected_tab, selected_tab - 2);
		change_category();
	}	
}

// Load the files
load_preset_files = function(path, _options_array = options) {
	_next_file = file_find_first(path + "*.ini", 0);

	while (_next_file != "") {
		var _full_path = path + _next_file;
		ini_open(_full_path);
		var _desc = ini_read_string("INFO", "description", "");
		ini_close();
		
		array_push(_options_array, {
			path: _full_path,
			description: _desc
		});
		_next_file = file_find_next();
	}
	file_find_close();	
}
load_presets = function() {
	load_preset_files(INTERNAL_PRESETS_PATH);
	load_preset_files(PRESETS_PATH);
}
load_presets();

input_options = [];
load_input_presets = function() {
	load_preset_files(INTERNAL_INPUT_PRESETS_PATH, input_options);
	load_preset_files(INPUT_PRESETS_PATH, input_options);
	
	// Always make "Default" the first one listed
	for (var i = 0; i < array_length(input_options); i++) {
		if (filename_change_ext(filename_name(input_options[i].path), "") == "Default") {
			var _val = input_options[i];
			array_delete(input_options, i, 1);
			array_insert(input_options, 0, _val);
			break;
		}
	}
}
load_input_presets();

// Screen fade effect
fade = 0;
selected_highlight_color = COLOR_YELLOW;
selected_highlight_alpha = 1;

old_state = 0;

slide_out = function() {
	
	y_offset = lerp(y_offset, -room_height, 0.25);
	
	if (round(y_offset) <= -room_height) {
		
		instance_destroy();
		with (instance_create_layer(0, 0, layer, obj_title_menu)) {
			page = 3;
			selected_option = global.settings_section;
			select_y = selected_option * 20;
			press_any_key_mode = false;
			transition_counter = 1;
		}
	}	
}

revert_changes = function() {
	var _id = section_category_indices[selected_tab];
	if (_id >= 0 || _id == -3) {
		var _category = (_id == -3) ? global.launcher_category : global.categories[selected_category];
		var _option = _category.items[selected_option];
		
		if (is_array(old_state)) {
			array_copy(_option.state, 0, old_state, 0, array_length(old_state));
		} else {
			_option.state = old_state;
		}

		if (_id == -3) {
			if (_option.internal_name == "sound_volume") set_sfx_volume(_option.state);
			if (_option.internal_name == "music_volume") set_music_volume(_option.state);
		}
	}
}
