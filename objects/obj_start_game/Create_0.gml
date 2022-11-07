progress = 0
slide_out = 0;

set_fullscreen = function() {
    
    if (global.fullscreen)
        window_set_fullscreen(false);
}

launch_game = function() {
    
	if (directory_exists(EXTERNAL_PATH_ORIGINAL))
		copy_dir(EXTERNAL_PATH_ORIGINAL, EXTERNAL_PATH);
	if (file_exists(GAME_PATH + GAME_EXE))
		execute_program(GAME_PATH + GAME_EXE, "", true)
	if (file_exists(GAME_PATH + GAME_EXE_OLD))
		execute_program(GAME_PATH + GAME_EXE_OLD, "", true)
        
    if (global.fullscreen)
        window_set_fullscreen(true);
    
	slide_out = 1;
}
    
timer(set_fullscreen, 45);

timer(launch_game, 60)