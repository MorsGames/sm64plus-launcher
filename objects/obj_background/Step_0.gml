/// @desc Fade the background

if (background_alpha < 1)
	background_alpha += 0.125 / (1 + (os_type != os_windows) * 0.25);
if (message_timer > 0)
	message_timer--;
	
if (fade > 0)
	fade -= 0.0625;
	
if (message_move) {
	if (message_position < 1)
		message_position += 0.0625;
	if (message_timer <= 0)
		message_move = false;
}
else {
	if (message_position > 0)
		message_position -= 0.015625;
}