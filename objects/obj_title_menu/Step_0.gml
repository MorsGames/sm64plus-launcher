/// @desc Changing the settings and whatnot

if (press_any_key_mode) {
    // Transitioning back to the "press any key" screen
    if (transition_counter > 0) {
        transition_counter = max(0, transition_counter - transition_speed);
    }
} else {
    // Transitioning to the main menu
    if (transition_counter < 1) {
        transition_counter = min(1, transition_counter + transition_speed);
    }
}


if (press_any_key_mode) {
    if (transition_counter == 0) {
        if (input_check_pressed(input.any)) {
            press_any_key_mode = false;
        }
        if (input_check_pressed(input.back)) {
            press_any_key_mode = false;
			page = 2;
			selected_option = 1;
			select_y = 40; // TODO: Magic number
			sfx_play(snd_select);
        }
    }
} else if (transition_counter >= 1 && move == 0) {
    if (input_check_pressed(input.back)) {
		if (page == 0) {
			press_any_key_mode = true;
			sfx_play(snd_cancel);
		}
		else {
			var _prev_page = page;
			page = 0;
			if (_prev_page == 3)
				selected_option = 1;
			else
				selected_option = (_prev_page == 2) ? 3 : 2;
			sfx_play(snd_cancel);
		}
    }
}


if (move == 2) {
	y_offset = lerp(y_offset, -room_height, 0.25);
	if (round(y_offset) <= -room_height) {
		
		switch (page) {
		    case 0:
				switch (selected_option) {
					case 0:
						run_game();
				        break;
				}
				break;
			case 1:
				switch (selected_option) {
				    case 0:
						url_open("https://mfgg.net/index.php?act=resdb&param=02&c=2&id=38190");
						move = 1;
						y_offset = room_height;
				        break;
				    case 1:
				    case 2:
						ini_open(INI3_PATH)
						var _external = ini_read_real("GAME", "custom_textures", 1);
						
						if (input_check(input.del)) {
							_external = !_external;
							ini_write_real("GAME", "custom_textures", _external);
						}
							
						ini_close()
					
						var _mingw_path = @"C:\msys64\mingw64.exe";
						if (!file_exists(_mingw_path))
							_mingw_path = get_open_filename("Find mingw64.exe in your MSYS2 installation folder.|mingw64.exe", "");
						execute_shell_admin(_mingw_path, "\\\"" + program_directory + ((selected_option == 1) ? "rebuild.sh" : "rebuild_clean.sh") + "\\\" " + string(_external));
						move = 1;
						y_offset = room_height;
				        break;
				}
				break;
			case 3:
				instance_destroy();
				instance_create_layer(0, 0, layer, obj_settings_menu);
				break;
		}
	}
}
else if (move == 1) {
	slide_in()
}
else if (!press_any_key_mode && transition_counter >= 1) {

	// Select an option
	if (input_check_pressed(input.select)) {
		var _played_sound = false;
		if (page == 0 && selected_option == 1) {
			page = 3;
			selected_option = 0;
		}
		else if (page == 0 && selected_option == 2) {
			page = 1;
			selected_option = 0;
		}
		else if (page == 0 && selected_option == 3) {
			page = 2;
			selected_option = 1;
		}
		else if (page == 1 && selected_option == 3) {
			page = 0;
			selected_option = 2;
			sfx_play(snd_cancel);
			_played_sound = true;
		}
		else if (page == 2) {
			if (selected_option == 0) {
				game_end();
			}
			else {
				page = 0;
				selected_option = 3;
				sfx_play(snd_cancel);
				_played_sound = true;
			}
		}
		else if (page == 3) {
			if (selected_option == 3) {
				page = 0;
				selected_option = 1;
				sfx_play(snd_cancel);
				_played_sound = true;
			}
			else {
				global.settings_section = selected_option;
				move = 2;
			}
		}
		else {
			move = 2;
		}
		
		if (!_played_sound) {
			sfx_play(selected_option == 3 ? snd_cancel : snd_select)
		}
	}
	if (input_check_hold_time(input.left) > 300 && input_check_hold_time(input.right) > 300 && input_check_hold_time(input.del) > 300) {
		if (directory_exists(EXTERNAL_PATH)) {
			directory_destroy(EXTERNAL_PATH);	
		}
		game_restart();
	}
}
if (scale < 1)
	scale += 0.015625;
	
box_size = lerp(box_size, (page == 1) ? 112 : ((page == 2) ? 144 : 96), 0.25);
box_height = lerp(box_height, (page == 2) ? 77 : 96, 0.25);

// Change which option is selected
if (!press_any_key_mode && transition_counter >= 1) {
	var _total_options = (page == 2) ? 2 : 4;
	change_selected_option(_total_options, _total_options, 1, page, (page == 2) ? -1 : 0);
}