/// @desc Drawing the shit

gpu_set_tex_filter(1);

if (!surface_exists(surf))
    surface_recreate();

// Draw the background to the surface
surface_set_target(surf)
var _size = 1.125*view_hport[0]/720;
var _x = -current_frames*0.75*_size;
var _y = (sin(current_frames/1024*pi)*16+8-24*(os_type != os_windows))*_size*1.75;

var _last_bg = backgrounds[background_index_last];
var _bg = backgrounds[background_index];

if (background_alpha < 1) {
	if (_last_bg == spr_void)
		gpu_set_tex_filter(0);
	draw_sprite_tiled_ext(_last_bg, 0, _x, _y, 4*_size, 3*_size, c_white, 1);
	if (_last_bg == spr_void) {
		draw_sprite_tiled_ext(_last_bg, 1, _x*1.5, _y*1.5, 4*_size, 3*_size, c_white, 0.5);
		gpu_set_tex_filter(1);
	}
}

if (background_alpha > 0) {
	if (_bg == spr_void)
		gpu_set_tex_filter(0);
	draw_sprite_tiled_ext(_bg, 0, _x, _y, 4*_size, 3*_size, c_white, background_alpha);
	if (_bg == spr_void) {
		draw_sprite_tiled_ext(_bg, 1, _x*1.5, _y*1.5, 4*_size, 3*_size, c_white, background_alpha*0.5);
		gpu_set_tex_filter(1);
	}
}

if (os_type == os_windows) {
	gpu_set_blendmode(bm_subtract)
	draw_rectangle_color(0, 0, view_wport[0]/3, view_hport[0], c_dkgray, c_black, c_black, c_dkgray, false)
	draw_rectangle_color(view_wport[0], 0, view_wport[0]-view_wport[0]/3, view_hport[0], c_black, c_dkgray, c_dkgray, c_black, false)
	gpu_set_blendmode(bm_normal)
}

//draw_sprite_tiled_ext(spr_fake_polygon, 0, _x*2, _y*2, 1, 1, c_white, 0.5);
surface_reset_target()

// Draw the surface with the sick ass shader
if (os_type == os_windows) {
	shader_set(shd_curve)
	shader_set_uniform_f(res_u, room_width, room_height)
}
draw_surface_stretched(surf, 0, 0, room_width, room_height)
if (os_type == os_windows)
	shader_reset();

/*gpu_set_blendmode(bm_add)
draw_rectangle_color(0, 0, room_width/4, room_height, $0F0F0F, c_black, c_black, $0F0F0F, 0)
draw_rectangle_color(room_width, 0, room_width-room_width/4, room_height, c_black, $0F0F0F, $0F0F0F, c_black, 0)
gpu_set_blendmode(bm_normal)*/

gpu_set_tex_filter(0);