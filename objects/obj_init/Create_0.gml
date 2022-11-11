/// @desc Check if the game is built yet.

init();

if (!instance_exists(obj_persistent))
	instance_create_depth(0, 0, -100, obj_persistent);
	
start_file_checks = function() {
	timer(check_file, 90, true, true);
	timer_ms(change_text, 7200000);	
}

check_file = function(play_sound) {
	if (file_exists(GAME_PATH + GAME_EXE) || file_exists(GAME_PATH + GAME_EXE_OLD)) {
		
		// Update the game
		if (update && !input_check(key.del)) {
			
			file_delete(GAME_PATH + GAME_EXE);
			file_delete(GAME_PATH + GAME_EXE_OLD);
			
			ini_open(INI2_PATH);
			var _external = ini_read_real("GAME", "custom_textures", 1);
			ini_close();
			
			var _mingw_path = @"C:\msys64\mingw64.exe";
			if (!file_exists(_mingw_path))
				_mingw_path = get_open_filename("Find mingw64.exe in your MSYS2 installation folder.|mingw64.exe", "");
			execute_shell_admin(_mingw_path, "\\\"" + program_directory + "rebuild_clean.sh\\\" " + string(_external));
			
			str = "Update is in progress. Please wait...\n\nIf the other window gets closed, try restarting the launcher.";
			state = 3
			
			start_file_checks();
			
			update = false;
			
			return -1;
		}
		
		// Cancel the update process if no exe
		update = false;
		
        if (global.quick_launch && !input_check_pressed(key.del)) {
            instance_create_depth(0, 0, depth-1, obj_start_game);
            play_sound = true;
        }
        else
		    slide_out = 1;
		var _snd = play_sound ? snd_start : snd_select;
		if (!audio_is_playing(_snd))
			sfx_play(_snd)
		return 0;
	}
	return 1;
}

change_text = function() {
	str = "It seems like an error has occured. Try restarting the launcher and building again.";
}

state = 0;
progress = 0
slide_out = 0;
external_enabled = false;
update = false;

// The messages to show people if the game is indeed not built
str = "- DISCLAIMER -\n\nWhat you have right here is a non-profit fan project, and NOT an official Nintendo product. If you like what you're seeing here, please show your support to Nintendo directly!\n\nPress any key to continue.";

if (!file_exists(INI2_PATH)) {
	ini_open(INI2_PATH);
	ini_write_string("LAUNCHER", "version", VERSION);
	ini_close();
}
else if (file_exists(GAME_PATH + GAME_EXE) || file_exists(GAME_PATH + GAME_EXE_OLD)) {
	var _cur_ver = VERSION;
	ini_open(INI2_PATH);
	_cur_ver = ini_read_string("LAUNCHER", "version", VERSION);

	if (_cur_ver != VERSION) {
		
		str = "- A LAUNCHER UPDATE HAS BEEN DETECTED -\n\nThe launcher will now update the game files.\n\nPress any key to update.\nPress " + input_action_get_name(key.del, 1)  + " to skip.\n\nPS: You can later do this manually by choosing \"Update\" from the main menu."
	
		ini_write_string("LAUNCHER", "version", VERSION);
		
		update = true;
	}
	ini_close();
}