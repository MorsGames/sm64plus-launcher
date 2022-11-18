/// @desc The persistent object

// Set up the actions for the input system.

enum key {
	left,
	right,
	up,
	down,
	left2,
	right2,
	up2,
	down2,
    page_left,
    page_right,
	select,
	select2,
	back,
	del,
	del2,
	any
}

input_system_init()

input_action_add(key.left, vk_left, gp_padl)
input_action_add(key.right, vk_right, gp_padr)
input_action_add(key.up, vk_up, gp_padu)
input_action_add(key.down, vk_down, gp_padd)

input_action_add(key.left2, ord("A"), gp_stickll)
input_action_add(key.right2, ord("D"), gp_sticklr)
input_action_add(key.up2, ord("W"), gp_sticklu)
input_action_add(key.down2, ord("S"), gp_stickld)

input_action_add(key.page_left, -2, gp_shoulderl)
input_action_add(key.page_right, -2, gp_shoulderr)

input_action_add(key.select, vk_space, gp_face1)
input_action_add(key.select2, vk_enter, gp_start)
input_action_add(key.back, CURRENT_OS == os_windows ? vk_escape : vk_backspace, gp_face2)
input_action_add(key.del, CURRENT_OS == os_windows ? vk_backspace : vk_delete, gp_select)
input_action_add(key.del2, vk_delete, gp_select)

input_action_add(key.any, vk_anykey, gp_anybutton)

input_action_link(key.left2, key.left)
input_action_link(key.right2, key.right)
input_action_link(key.up2, key.up)
input_action_link(key.down2, key.down)

input_action_link(key.select2, key.select)
input_action_link(key.del2, key.del)

input_system_start()

// We are drawing the surface manually just in case
application_surface_draw_enable(false);

// LAUNCHER SETTINGS STUFF

// Load the json to memory
if (file_exists(LAUNCHER_CATEGORY_PATH)) {
    
    load_launcher_file();
    load_launcher_settings();
}
else {
    global.launcher_category = -1;
    
    global.fullscreen = false;
    global.mute_music = false;
    global.mute_sounds = false;
    
    global.scaling_mode = 1;
    global.quick_launch = false;
    global.close_on_launch = false;
    
    global.window_width = 1280;
    global.window_height = 720;
}

window_set_size(global.window_width, global.window_height);

if (!global.fullscreen)
	timer(window_center, 1);