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

input_action_add(key.select, vk_space, gp_face1)
input_action_add(key.select2, vk_enter, gp_start)
input_action_add(key.back, vk_escape, gp_face2)
input_action_add(key.del, vk_backspace, gp_select)
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

// Set the window size
window_set_size(1280, 720);

// Load the launcher settings
ini_open(INI2_PATH)
global.fullscreen = ini_read_real("LAUNCHER", "fullscreen", false)
global.scaling_mode = ini_read_real("LAUNCHER", "scaling_mode", 1)
global.mute = ini_read_real("LAUNCHER", "mute", 0)
ini_close()

if (global.fullscreen)
	window_set_fullscreen(true)
else
	timer(window_center, 1);

window_set_cursor(global.fullscreen ? cr_none : cr_default);