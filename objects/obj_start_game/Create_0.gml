progress = 0
slide_out = 0;

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
    
if (global.fullscreen)
    timer(window_set_fullscreen, 30, false, false);

timer(launch_game, 60)