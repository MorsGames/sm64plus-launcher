/// @desc Drawing the stuff

d3d_transform_set_translation(0, y_offset, 0);

// Options count
var _total_options = array_length(options);

draw_set_color(COLOR_BLACK)
draw_set_alpha(0.625)
draw_rectangle(BOX_TITLE_LEFT, TITLE_MENU_Y, BOX_TITLE_RIGHT-1, TITLE_MENU_Y+19*_total_options+20, 0)
draw_set_alpha(1)
	
// Highlight the selected item.
draw_set_color(COLOR_YELLOW)
draw_set_alpha(sin(current_frames/16)/24+0.625);
draw_rectangle(BOX_TITLE_LEFT+8, TITLE_MENU_Y+10 + select_y, BOX_TITLE_RIGHT-9, TITLE_MENU_Y+26 + select_y, 0)
draw_set_alpha(1);
	
// Items
for (var i=0; i<_total_options; i++) {
	
	draw_option(room_width/2, TITLE_MENU_Y+8 + i*20, page ? options2[i] : options[i], 1.5);
}

// title
gpu_set_tex_filter(1)
var _logo_scale = ease_out_elastic(0, 1, max(0, scale));
var _screen_scale = (room_height-120)/(BASE_HEIGHT-120);
var _actual_scale = min(_screen_scale, room_width/400)*_logo_scale/2
draw_sprite_ext(spr_logo, 0, room_width/2, 120*_screen_scale, _actual_scale, _actual_scale, 0, c_white, 1);
gpu_set_tex_filter(0)

d3d_transform_set_identity();