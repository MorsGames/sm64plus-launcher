progress = 0
slide_out = 0;

go_windowed = function() {
    
    if (global.fullscreen) {
        window_set_fullscreen(false);
        window_set_cursor(cr_default);
    }
}

launch_game = function() {
    
	if (directory_exists(EXTERNAL_PATH_ORIGINAL))
		copy_dir(EXTERNAL_PATH_ORIGINAL, EXTERNAL_PATH);
	if (file_exists(GAME_PATH + GAME_EXE))
		execute_shell(GAME_PATH + GAME_EXE, "", !global.close_on_launch)
	if (file_exists(GAME_PATH + GAME_EXE_OLD))
		execute_shell(GAME_PATH + GAME_EXE_OLD, "", !global.close_on_launch)
        
    if (room == rm_init)
        instance_destroy(obj_init);
        
    if (!global.close_on_launch) {
        if (global.fullscreen) {
            window_set_fullscreen(true);
            window_set_cursor(cr_none);
        }
	    slide_out = 1;
    }
}

if (global.close_on_launch)
    timer(game_end, 150);
    
var _time = global.close_on_launch ? 105 : 45;

timer(go_windowed, _time);

timer(launch_game, _time + 15);