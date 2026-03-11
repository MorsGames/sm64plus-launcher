if (slide_out)
{	
	if (progress > 0)
		progress -= 0.03125
	else {
		obj_settings_menu.selected = false;
		instance_destroy();
	}
}
else
{	
	if (progress < 1)
		progress += 0.03125
        
    button_value = controller_poll_sdl();
    
	if (button_value == 0)
		counter = 120;

    if (input_check_pressed(input.back) && button_value == 0) {
		slide_out = true;
        item.state = 0;
		sfx_play(snd_cancel)
	}
    else if (keyboard_check_pressed(vk_anykey)) {
		shake = 8;
		sfx_play(snd_denied);
	}
	if (counter <= 0) {
		slide_out = true;
        item.state = button_value;
		sfx_play(snd_select)
	}
    else if (button_value != 0)
        counter--;
}


if (shake > 0)
	shake --;
