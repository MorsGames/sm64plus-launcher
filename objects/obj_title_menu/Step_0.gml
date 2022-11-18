/// @desc Changing the settings and whatnot

if (move == 2) {
	y_offset = lerp(y_offset, -room_height, 0.25);
	if (round(y_offset) <= -room_height) {
		
		switch (page) {
		    case 0:
				switch (selected_option) {
				    case 0:
						run_game();
				        break;
				    case 1:
				        instance_destroy();
						instance_create_layer(0, 0, layer, obj_settings_menu);
				        break;
				    case 3:
				        game_end()
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
						
						if (input_check(key.del)) {
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
		}
	}
}
else if (move == 1) {
	slide_in()
}
else {

	// Select an option
	if (input_check_pressed(key.select)) {
		if (page == 0 && selected_option == 2) {
			page = 1;
			selected_option = 0;
		}
		else if (page == 1 && selected_option == 3) {
			page = 0;
			selected_option = 2;
		}
		else {
			move = 2;
		}
		sfx_play(selected_option == 3 ? snd_cancel : snd_select)
	}
	if (input_check_pressed(key.back)) {
		game_end();	
	}
	if (input_check_hold_time(key.left) > 300 && input_check_hold_time(key.right) > 300 && input_check_hold_time(key.del) > 300) {
		if (directory_exists(EXTERNAL_PATH)) {
			directory_destroy(EXTERNAL_PATH);	
		}
		game_restart();
	}
}
if (scale < 1)
	scale += 0.015625;
	
box_size = lerp(box_size, page ? 112 : 96, 0.25);

// Change which option is selected
change_selected_option(4, 4, 1);