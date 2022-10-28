if (slide_out) {
	
	if (progress > 0)
		progress -= 0.03125
	else {
		obj_settings_menu.selected = false;
		instance_destroy();
	}
}
else {
	
	if (progress < 1)
		progress += 0.03125
        
    var _button_list = gamepad_get_buttons();
    
    button_value = 0;
        
    for (var i = 0; i < ds_list_size(_button_list); i++) {
		button_value |= controller_button_to_enum(_button_list[| i]);
	}
    
    show_debug_message(button_value)
    
    ds_list_destroy(_button_list);

    if (input_check_pressed(key.back) && button_value == 0) {
		slide_out = true;
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