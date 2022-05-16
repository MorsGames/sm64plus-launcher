/// @desc Show le epic text
draw_clear(COLOR_BLACK);
draw_set_color(COLOR_WHITE);
draw_set_valign(fa_middle)
if (!slide_out)
	draw_set_alpha(progress)
draw_text_ext_transformed(room_width/2, room_height/2-1, str, 12, room_width/2-32, 2, 2, 0)
draw_set_valign(fa_left)

if (slide_out) {

	draw_set_alpha(ease_out_sine(1, 0, clamp(progress*2-1, 0, 1)))
	draw_rectangle(0, 0, room_width, room_height, 0)
}
draw_set_alpha(1)