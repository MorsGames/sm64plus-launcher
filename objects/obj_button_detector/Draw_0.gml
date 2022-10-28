/// @desc The full screen text

draw_set_color(COLOR_WHITE)
draw_set_alpha(ease_out_sine(0, 0.75, progress))
draw_rectangle(0, 0, room_width, room_height, 0)
draw_set_color(COLOR_BLACK)
draw_set_alpha(ease_out_sine(0, 0.75, progress))
var _y = room_height/2 + (slide_out ? ease_out_back(-room_height*0.75, 0, progress) : ease_out_quart(room_height*0.75, 0, progress));
draw_rectangle(0, _y-64, room_width, _y+64, 0)
draw_set_alpha(1)
draw_set_color(c_white)

var _x  = room_width/2 + sin(current_frames)*shake;
var _y2 = room_height/2 + (slide_out ? ease_out_back(-room_height, 0, progress) : ease_out_quart(room_height, 0, progress));

var _list = controller_button_to_name(button_value);
			
var _size = ds_list_size(_list);
var _str = "";

if (_size == 0)
	_str = "-";
else {
	for (var i = 0; i < _size; i++) {
		if (i == 0)
			_str += "(";
		else
			_str += " or (";
		_str += ds_list_find_value(_list, i) + ")";
	}
}

ds_list_destroy(_list);


draw_set_valign(fa_middle)
draw_text_custom(_x, _y2, "Hold the controller buttons you want to this action assign to for " + string(floor(counter/60)) + " seconds.\n\n" + _str, 2)
draw_set_valign(fa_top)
