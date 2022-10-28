/// @desc The full screen text

draw_set_color(COLOR_WHITE)
draw_set_alpha(ease_out_sine(0, 1, progress))
draw_rectangle(0, 0, room_width, room_height, 0)
draw_set_alpha(1)

draw_set_color(COLOR_BLACK)
draw_set_valign(fa_middle)
draw_text_custom_inverted(room_width/2, room_height/2 + (slide_out ? ease_out_back(-room_height, 0, progress) : ease_out_quart(room_height, 0, progress)), "Launching game...", 2)
draw_set_valign(fa_top)
draw_set_color(c_white)