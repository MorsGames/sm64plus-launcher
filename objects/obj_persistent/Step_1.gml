/// @desc Various stuff

// Ignore our input system when using hotkeys
if (!keyboard_check(vk_alt))
	input_system_update()
	
// Hotkeys!
else {
	
	if (keyboard_check_pressed(vk_enter)) {
        
        set_fullscreen(!global.fullscreen);
		
		sfx_play(snd_select)

		ini_open(INI2_PATH)
		ini_write_real("LAUNCHER", "fullscreen", global.fullscreen)
		ini_close()
        
        for (var j=0; j<array_length(global.launcher_category.items); j++) {
			
			var _item = global.launcher_category.items[j];
			
			if (_item.internal_name == "fullscreen")
				_item.state = global.fullscreen;
		}
	}
	if (keyboard_check_pressed(ord("M"))) {
        
        set_mute(!global.mute);
		
		sfx_play(snd_select)

		ini_open(INI2_PATH)
		ini_write_real("LAUNCHER", "mute", global.mute)
		ini_close()	
                
        for (var j=0; j<array_length(global.launcher_category.items); j++) {
			
			var _item = global.launcher_category.items[j];
			
			if (_item.internal_name == "mute")
				_item.state = global.mute;
		}
	}
}

// Run the timer update code.
timer_system_update()


// Resize the view
if (global.fullscreen) {
	var _width = display_get_width()
	var _height = display_get_height()
}
else {
	var _width = window_get_width()
	var _height = window_get_height()
}

if (view_wport[0] != _width || view_hport[0] != _height) {

	if (_width < MIN_WIDTH*2 && _height < MIN_HEIGHT*2) {
		_width = MIN_WIDTH*2;
		_height = MIN_HEIGHT*2;
		window_set_size(_width, _height);
	}
	else {
		if (_width < MIN_WIDTH*2) {
			_width = MIN_WIDTH*2;
			window_set_size(_width, _height);
		}
		if (_height < MIN_HEIGHT*2) {
			_height = MIN_HEIGHT*2;
			window_set_size(_width, _height);
		}
	}
	
	var _scale;
	
	if (global.scaling_mode > 0)
		_scale = max(2, min(floor(_width/BASE_WIDTH/global.scaling_mode)*global.scaling_mode, floor(_height/BASE_HEIGHT/global.scaling_mode)*global.scaling_mode))
	else
		_scale = max(2, min(_width/BASE_WIDTH, _height/BASE_HEIGHT))

	room_width = _width/_scale
	room_height = _height/_scale
	camera_set_view_size(view_camera[0], room_width, room_height)
	view_wport[0] = _width;
	view_hport[0] = _height;
	surface_resize(application_surface, min(_width, 3840), min(_height, 2160*2))
	
	with (obj_background) {
		surface_free(surf);
		surface_recreate();
	}
}