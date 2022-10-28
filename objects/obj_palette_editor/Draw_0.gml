/// @desc The full screen text

draw_set_color(rgb_to_bgr(hex_to_real(color_string)))
draw_set_alpha(ease_out_sine(0, 1, progress))
draw_rectangle(0, 0, room_width, room_height, 0)
draw_set_color(COLOR_BLACK)
draw_set_alpha(ease_out_sine(0, 0.5, progress))
var _y = room_height/2 + (slide_out ? ease_out_back(-room_height*0.75, 0, progress) : ease_out_quart(room_height*0.75, 0, progress));
draw_rectangle(0, _y-64, room_width, _y+64, 0)
draw_set_alpha(1)
draw_set_color(c_white)

var _x  = room_width/2 + sin(current_frames)*shake;
var _y2 = room_height/2 + (slide_out ? ease_out_back(-room_height, 0, progress) : ease_out_quart(room_height, 0, progress));

draw_set_valign(fa_middle)
draw_text_custom(_x, _y2, "Enter a hex string of the color: " + color_string + "\n\nPress "+ input_action_get_name(key.select, true) + " when done.\nPress "+ input_action_get_name(key.del2, true) + " to reset.", 2)
draw_set_valign(fa_top)
