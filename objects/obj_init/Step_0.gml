/// @desc Open the URL for MSYS.

if (slide_out) {
	
	if (progress > 0)
		progress -= 1/64
	else {
		
		if (directory_exists(EXTERNAL_PATH_ORIGINAL)) {
			copy_dir(EXTERNAL_PATH_ORIGINAL, EXTERNAL_PATH);
		}
		//load_audio();
		room_goto_next();
	}
	exit;
}

if (progress < 1)
	progress += 0.03125

if (state == 0) {
	if (input_check_pressed(input.any)) {
		external_enabled = !input_check_pressed(input.del);
		state++;
		if (check_file(false))
			str = (CURRENT_OS == os_windows) ? ("Hello there! Before starting, we first need to build the game. Don't worry, the process is extremely simple!\n\n" +
				"First, we need to download MSYS2. Press <SPACE> to head to the download page.\n\nOnce downloaded, run the installer, and click \"Next\" until the installation is complete. If you want to change the installation folder, keep in mind that installing it to any drive other than C might cause issues.\n\n" +
				(external_enabled ? "Once you're done, press <ENTER> to continue." : "Press <ENTER> to continue.\n\n= Custom texture support has been disabled! ="))
				: ("Hello there! Before starting, we first need to build the game.\n\n" + 
                "The process here involves a bit of terminal usage, so I hope you're comfortable with that.\n" + 
				"It is not very hard though, all you need to do is to follow the instructions.\n\n" + 
                "Press any key to open the instructions.")
	}
}
else if (state == 1) {
	if (CURRENT_OS != os_windows) && (input_check_pressed(input.any)) {
		url_open("https://github.com/MorsGames/sm64plus/wiki/Manual-Building-Guide")	
		game_end();
	}
	else if (keyboard_check_pressed(vk_space))
		url_open("https://www.msys2.org/");
	else if (keyboard_check_pressed(vk_enter)) {
        // If the rom is already in the collect place
        if (file_exists(game_save_id + "baserom.us.z64")) {
            state = 3;
            start_building();
        }
        // Otherwise
        else {
    		state = 2;
    		str = "Next you will be asked to choose a US Super Mario 64 ROM.\n\n" + 
    "The ROM should be in Z64 (Big Endian) format.\n\nAfter that, the necessary files will get downloaded and the building process will start.\n\n" +
    "Press <ENTER> to continue.";
        }
	}
}
else if (state == 2) {
	if (keyboard_check_pressed(vk_enter)) {
		var _original_path = get_open_filename("Z64 ROM File (*.z64)|*.z64|All Files (*.*)|*.*", "");
		if (_original_path != "") {
			file_copy(_original_path, game_save_id + "baserom.us.z64")
			str = "Building is in progress. Please wait...\n\nIf the other window gets closed, and you get stuck here, try restarting the launcher.";
			state = 3
            start_building();
		}
	}
}