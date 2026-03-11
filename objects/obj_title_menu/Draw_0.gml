/// @desc Drawing the stuff

d3d_transform_set_translation(0, y_offset, 0);

var _transition_progress = press_any_key_mode ? ease_in_cubic(0, 1, transition_counter) : ease_out_cubic(0, 1, transition_counter);

// Title logo positioning
gpu_set_tex_filter(1)
var _logo_scale = ease_out_elastic(0, 1, max(0, scale));
var _screen_scale = (room_height-120)/(BASE_HEIGHT-120);
var _additional_scale = lerp(0.5625, 0.5, _transition_progress);
var _actual_scale = min(_screen_scale, room_width/400)*_logo_scale*_additional_scale

var _logo_center_y = room_height/2;
var _logo_normal_y = 120*_screen_scale;
var _logo_y = lerp(_logo_center_y, _logo_normal_y, _transition_progress);

draw_sprite_ext(spr_logo, 0, room_width/2, _logo_y, _actual_scale, _actual_scale, 0, c_white, 1);
gpu_set_tex_filter(0)

if (_transition_progress > 0)
{
	// Options count
	var _options_array = options;
	if (page == 1) _options_array = options2;
	if (page == 2) _options_array = options3;
	if (page == 3) _options_array = options4;
	
	var _total_options = array_length(_options_array);
	
	// Menu background
	var _menu_offset = (1 - _transition_progress) * 200;
	
	draw_set_color(COLOR_BLACK)
	draw_set_alpha(0.625)
	draw_rectangle(BOX_TITLE_LEFT, TITLE_MENU_Y + _menu_offset, BOX_TITLE_RIGHT-1, TITLE_MENU_Y+box_height + _menu_offset, 0)
	draw_set_alpha(1)
		
	// Highlight the selected item
	draw_set_color(COLOR_YELLOW)
	draw_set_alpha((sin(current_frames/16)/24+0.625));
	draw_rectangle(BOX_TITLE_LEFT+8, TITLE_MENU_Y+10 + select_y + _menu_offset, BOX_TITLE_RIGHT-9, TITLE_MENU_Y+26 + select_y + _menu_offset, 0)
	draw_set_alpha(1);
		
	// Items
	var _items_offset = (1 - _transition_progress) * 200;
	
	if (page == 2) {
		draw_option(room_width/2, TITLE_MENU_Y+8 + _items_offset, "Are you sure you want to quit?", 1.5, false);
		for (var i=0; i<_total_options; i++) {
			draw_option(room_width/2, TITLE_MENU_Y+8 + (i+1)*20 + _items_offset, _options_array[i], 1.5);
		}
	} else {
		for (var i=0; i<_total_options; i++) {
			draw_option(room_width/2, TITLE_MENU_Y+8 + i*20 + _items_offset, _options_array[i], 1.5);
		}
	}
}

d3d_transform_set_identity();