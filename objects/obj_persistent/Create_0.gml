/// @desc The persistent object

// Set up the actions for the input system.

input_system_init()

// We are drawing the surface manually just in case
application_surface_draw_enable(false);

// LAUNCHER SETTINGS STUFF

// Load the json to memory
if (file_exists(LAUNCHER_CATEGORY_PATH))
{
    load_launcher_file();
    load_launcher_settings();
}
else
{
    global.launcher_category = -1;
    
    global.fullscreen = false;
    global.music_volume = 1;
    global.music_instance = -1;
    global.sfx_volume = 1;
    
    global.scaling_mode = 1;
    global.quick_launch = false;
    global.close_on_launch = false;
	global.controller_type = 0;
    
    global.window_width = 1280;
    global.window_height = 720;
}

window_set_size(global.window_width, global.window_height);

if (!global.fullscreen)
	timer(window_center, 1);
