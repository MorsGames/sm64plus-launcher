// Brought together all the type related scripts here to make it easier to add new types
// (which happens very often!)

// All the option types
enum option_type {
	boolean,
	uint,
	float,
	key,
	star_message,
	noise_type,
	hud_layout,
	mouse_button,
	multiplier,
	percentage,
	camera_mode,
	graphics_backend_windows,
	graphics_backend_other,
	lives_mode,
	encore_mode,
	texture_filtering,
	moon_jump,
	monitor,
	green_demon_mode,
	color,
	blj_everywhere,
	lod,
	frame_rate,
	palette,
	fixes,
	draw_distance,
    controller_button
}

// Replace the constants in the json file
function replace_json_constants(_contents) {
	
	_contents = string_replace_all(_contents, "OS_ANY", "0");
	_contents = string_replace_all(_contents, "OS_WINDOWS", "1");
	_contents = string_replace_all(_contents, "OS_LINUX", "2");

	_contents = string_replace_all(_contents, "TYPE_BOOL", "0");
	_contents = string_replace_all(_contents, "TYPE_UINT", "1");
	_contents = string_replace_all(_contents, "TYPE_FLOAT", "2");
	_contents = string_replace_all(_contents, "TYPE_KEY", "3");
	_contents = string_replace_all(_contents, "TYPE_STAR_MESSAGE", "4");
	_contents = string_replace_all(_contents, "TYPE_NOISE_TYPE", "5");
	_contents = string_replace_all(_contents, "TYPE_HUD_LAYOUT", "6");
	_contents = string_replace_all(_contents, "TYPE_MOUSE_BUTTON", "7");
	_contents = string_replace_all(_contents, "TYPE_MULTIPLIER", "8");
	_contents = string_replace_all(_contents, "TYPE_PERCENTAGE", "9");
	_contents = string_replace_all(_contents, "TYPE_CAMERA_MODE", "10");
	_contents = string_replace_all(_contents, "TYPE_BACKEND_WINDOWS", "11");
	_contents = string_replace_all(_contents, "TYPE_BACKEND_LINUX", "12");
	_contents = string_replace_all(_contents, "TYPE_LIVES_MODE", "13");
	_contents = string_replace_all(_contents, "TYPE_ENCORE_MODE", "14");
	_contents = string_replace_all(_contents, "TYPE_TEXTURE_FILTERING", "15");
	_contents = string_replace_all(_contents, "TYPE_MOON_JUMP", "16");
	_contents = string_replace_all(_contents, "TYPE_MONITOR", "17");
	_contents = string_replace_all(_contents, "TYPE_GREEN_DEMON_MODE", "18");
	_contents = string_replace_all(_contents, "TYPE_COLOR", "19");
	_contents = string_replace_all(_contents, "TYPE_BLJ_EVERYWHERE", "20");
	_contents = string_replace_all(_contents, "TYPE_LOD", "21");
	_contents = string_replace_all(_contents, "TYPE_FRAME_RATE", "22");
	_contents = string_replace_all(_contents, "TYPE_PALETTE", "23");
	_contents = string_replace_all(_contents, "TYPE_FIXES", "24");
	_contents = string_replace_all(_contents, "TYPE_DRAW_DISTANCE", "25");
	_contents = string_replace_all(_contents, "TYPE_CONTROLLER_BUTTON", "26");

	return _contents;
}

// Get the display text for the option
function get_option_text(option) {
	var _name = option.name;
	var _type = option.type;
    try {
	    var _state = option.state;
    }
    catch(e) {
	    var _state = -1;
    }
	
	switch (_type) {
		case option_type.boolean:
		    return _name + (_state ? ":✔On" : ":❌Off");
		    break;
		case option_type.uint: 
		case option_type.float: 
		case option_type.monitor: 
		    return _name + ":❓" + string(_state);
		    break;
		case option_type.key: 
			var _text;
			
			if (_state == 0)
				_text = "❌None"
			else if (_state == 328)
				_text = "❓Up"
			else if (_state == 336)
				_text = "❓Down"
			else if (_state == 331)
				_text = "❓Left"
			else if (_state == 333)
				_text = "❓Right"
			else if (_state > array_length(global.key_names))
				_text = "❌Unknown"
			else
				_text = "❓" + global.key_names[_state-1];
		    return _name + ":" + _text + " [" + string(_state) + "]";
		    break;
		case option_type.star_message: 
		    switch (_state) {
				case 0:
					return _name + ":❌Nah";
				case 1:
					return _name + ":❓Always Ask";
				case 2:
					return _name + ":✔Yep";
				case 3:
					return _name + ":❓Legacy";
			}
		    break;
		case option_type.noise_type: 
		    switch (_state) {
				case 0:
					return _name + ":❓Chunky";
				case 1:
					return _name + ":❓High-Res";
				case 2:
					return _name + ":❓Transparency";
			}
		    break;
		case option_type.hud_layout: 
		    switch (_state) {
				case 0:
					return _name + ":❌Default";
				case 1:
					return _name + ":❓Enhanced";
				case 2:
					return _name + ":✔Modern";
			}
		    break;
		case option_type.mouse_button: 
		    switch (_state) {
				case n64_buttons.none:
					return _name + ":❌None";
				case n64_buttons.a:
					return _name + ":❓A (Jump)";
				case n64_buttons.b:
					return _name + ":❓B (Punch)";
				case n64_buttons.start:
					return _name + ":❓Start (Pause)";
				case n64_buttons.l:
					return _name + ":❓L (Center Camera)";
				case n64_buttons.r:
					return _name + ":❓R (Change Camera)";
				case n64_buttons.z:
					return _name + ":❓Z (Crouch)";
				case n64_buttons.c_up:
					return _name + ":❓C-Up (Zoom In)";
				case n64_buttons.c_down:
					return _name + ":❓C-Down (Zoom Out)";
				case n64_buttons.c_left:
					return _name + ":❓C-Left (Rotate Left)";
				case n64_buttons.c_right:
					return _name + ":❓C-Right (Rotate Right)";
			}
		    break;
		case option_type.multiplier:
			return _name + ":❓" + string(_state) + "x";
		    break;
		case option_type.percentage: 
			var _str;
			if (_state >= 1)
				_str = ":✔"
			else if (_state <= 0)
				_str = ":❌"
			else
				_str = ":❓";
		    return _name + _str + string(round(_state*100)) + "%";
		    break;
		case option_type.camera_mode: 
		    switch (_state) {
				case 0:
					return _name + ":✔Lakitu Cam";
				case 1:
					return _name + ":✔Mario Cam";
				case 2:
					return _name + ":❓Custom Cam";
			}
			break;
		case option_type.graphics_backend_windows:
			switch (_state) {
				case 0:
					return _name + ":✔Direct3D 11";
				case 1:
					return _name + ":❓Direct3D 12";
				case 2:
					return _name + ":❓OpenGL";
				default:
					return _name + ":❌Null";
			}
			break;
		case option_type.graphics_backend_other:
			switch (_state) {
				case 0:
					return _name + ":✔OpenGL";
				default:
					return _name + ":❌Null";
			}
			break;
		case option_type.lives_mode: 
		    switch (_state) {
				case 0:
					return _name + ":❌Off";
				case 1:
					return _name + ":✔On";
				case 2:
					return _name + ":❓On w/ Death Counter";
			}
			break;
		case option_type.encore_mode: 
		    switch (_state) {
				case 0:
					return _name + ":❌Off";
				case 1:
					return _name + ":✔On";
				case 2:
					return _name + ":❓Palette Only";
				case 3:
					return _name + ":❓Mirroring Only";
			}
			break;
		case option_type.texture_filtering: 
		    switch (_state) {
				case 0:
					return _name + ":❌Nearest Neighbor";
				case 1:
					return _name + ":❓3 Point";
				case 2:
					return _name + ":❓Bilinear";
			}
		    break;
		case option_type.moon_jump: 
		    switch (_state) {
				case 0:
					return _name + ":❌Off";
				case 1:
					return _name + ":❓Classic";
				case 2:
					return _name + ":✔Fixed";
			}
		    break;
		case option_type.green_demon_mode: 
		    switch (_state) {
				case 0:
					return _name + ":❌Off";
				case 1:
					return _name + ":✔On";
				case 2:
					return _name + ":❓Constant Chase!";
				case 3:
					return _name + ":❌Unfair Chase!!!";
			}
			break;
		case option_type.color: 
			return _name + ":❓#" + _state[1];
			break;
		case option_type.blj_everywhere: 
		    switch (_state) {
				case 0:
					return _name + ":❌Off";
				case 1:
					return _name + ":✔On";
				case 2:
					return _name + ":❓Grounded Longer";
				case 3:
					return _name + ":❓Rapidfire Mode";
			}
		    break;
		case option_type.lod: 
		    switch (_state) {
				case 0:
					return _name + ":❓Auto";
				case 1:
					return _name + ":❌Low";
				case 2:
					return _name + ":✔High";
			}
		    break;
		case option_type.frame_rate: 
		    switch (_state) {
				case 0:
					return _name + ":❌30 FPS";
				case 1:
					return _name + ":✔60 FPS";
			}
		    break;
		case option_type.palette: 
		    switch (_state) {
				default:
					return _name + ":✔Custom";
				case 1:
					return _name + ":❓Default Mario";
				case 2:
					return _name + ":❓Mario Tweaked";
				case 3:
					return _name + ":❓Fire Mario";
				case 4:
					return _name + ":❓Classic Mario";
				case 5:
					return _name + ":❓SMW Mario";
				case 6:
					return _name + ":❓Luigi";
				case 7:
					return _name + ":❓Fire Luigi";
				case 8:
					return _name + ":❓Classic Luigi";
				case 9:
					return _name + ":❓SMW Luigi";
				case 10:
					return _name + ":❓Wario";
				case 11:
					return _name + ":❓Waluigi";
				case 12:
					return _name + ":❓Hernesto";
			}
		    break;
		case option_type.fixes: 
		    switch (_state) {
				case 0:
					return _name + ":❌None";
				case 1:
					return _name + ":❓Gameplay";
				case 2:
					return _name + ":✔Gameplay + Collisions";
			}
		    break;
		case option_type.draw_distance:
			if (_state <= 0)
				return _name + ":✔Disabled";
			else
				return _name + ":❓" + string(_state) + "x";
		    break;
		case option_type.controller_button:

			var _list = controller_button_to_name(_state);
			
			var _size = ds_list_size(_list);
            var _str = "";

			if (_size == 0)
				_str = ":❌None";
			else {
				for (var i = 0; i < _size; i++) {
					if (i == 0)
						_str += ":❓(";
					else
						_str += " or (";
					_str += ds_list_find_value(_list, i) + ")";
				}
			}

            ds_list_destroy(_list);
            
            return _name + _str;
		    break;
	}
}

// Load the values for the item from the currently open ini
function ini_load_item(_item, _category) {
	
	switch (_item.type) {
					
		case option_type.boolean:
			_item.state = ini_read_string(_category.title, _item.internal_name, "false") == "true";
			break;
		case option_type.uint:
		case option_type.float:
		case option_type.key:
		case option_type.star_message:
		case option_type.noise_type:
		case option_type.hud_layout:
		case option_type.multiplier:
		case option_type.percentage:
		case option_type.camera_mode:
		case option_type.graphics_backend_windows:
		case option_type.graphics_backend_other:
		case option_type.lives_mode:
		case option_type.encore_mode:
		case option_type.texture_filtering:
		case option_type.moon_jump:
		case option_type.monitor:
		case option_type.green_demon_mode:
		case option_type.blj_everywhere:
		case option_type.lod:
		case option_type.frame_rate:
		case option_type.palette:
		case option_type.fixes:
		case option_type.draw_distance:
        case option_type.controller_button:
			_item.state = ini_read_real(_category.title, _item.internal_name, 0);
			break;
		case option_type.mouse_button:
			var _value = ini_read_real(_category.title, _item.internal_name, 0);
			_item.state = n64_button_to_enum(_value);
			break;
		case option_type.color:
			var _r = ini_read_real(_category.title, _item.internal_name + "_r", 0);
			var _g = ini_read_real(_category.title, _item.internal_name + "_g", 0);
			var _b = ini_read_real(_category.title, _item.internal_name + "_b", 0);
			_item.state[0] = make_color_rgb(_r, _g, _b);
			_item.state[1] = real_to_hex(make_color_rgb(_b, _g, _r), 6);
			break;
	}
}


// Save the values for the item to the currently open ini
function ini_save_item(_item, _category) {
	
	switch (_item.type) {
		
		case option_type.boolean:
			ini_write_string(_category.title, _item.internal_name, _item.state ? "true" : "false");
			break;
		case option_type.uint:
		case option_type.float:
		case option_type.key:
		case option_type.star_message:
		case option_type.noise_type:
		case option_type.hud_layout:
		case option_type.multiplier:
		case option_type.percentage:
		case option_type.camera_mode:
		case option_type.graphics_backend_windows:
		case option_type.graphics_backend_other:
		case option_type.lives_mode:
		case option_type.encore_mode:
		case option_type.texture_filtering:
		case option_type.moon_jump:
		case option_type.monitor:
		case option_type.green_demon_mode:
		case option_type.blj_everywhere:
		case option_type.lod:
		case option_type.frame_rate:
		case option_type.palette:
		case option_type.fixes:
		case option_type.draw_distance:
        case option_type.controller_button:
			ini_write_real(_category.title, _item.internal_name, _item.state);
			break;
		case option_type.mouse_button:
			ini_write_real(_category.title, _item.internal_name, global.n64_button_values[_item.state]);
			break;
		case option_type.color:
			ini_write_real(_category.title, _item.internal_name + "_r", color_get_red(_item.state[0]));
			ini_write_real(_category.title, _item.internal_name + "_g", color_get_green(_item.state[0]));
			ini_write_real(_category.title, _item.internal_name + "_b", color_get_blue(_item.state[0]));
			break;
	}	
}

// Changes the state/value of the option based on movement values
function change_option_state(_option, _hor_movement, _long_hor_movement) {
	
	switch (_option.type) {
		case option_type.uint:
			var _keyboard_value = get_digits(keyboard_string);
			if (_keyboard_value != "")
				_option.state = max(0, _keyboard_value);
			else
				_option.state = max(0, _option.state + _hor_movement + _long_hor_movement * 2);
			break;
		case option_type.float:
			var _keyboard_value = get_digits(keyboard_string);
			if (_keyboard_value != "")
				_option.state = _keyboard_value;
			else
				_option.state += (_hor_movement + _long_hor_movement * 2)/10;
			break;
		case option_type.key:
			var _keyboard_value = get_digits(keyboard_string);
			if (_keyboard_value != "")
				_option.state = clamp(_keyboard_value, 1, 999);
			else {
				_option.state = clamp(_option.state + _hor_movement + wait(4)*_long_hor_movement, 1, 336);
				while (_hor_movement + _long_hor_movement != 0 && string_copy(get_option_text(_option), string_length(_option.name)+3, 7) == "Unknown") {
					_option.state = clamp(_option.state + _hor_movement + _long_hor_movement, 1, 336);
				}
			}
			break;
		case option_type.encore_mode:
		case option_type.blj_everywhere:
		case option_type.green_demon_mode:
			_option.state = clamp(_option.state + _hor_movement + wait(4)*_long_hor_movement, 0, 3);
		break;
		case option_type.star_message:
			_option.state = clamp(_option.state + _hor_movement + wait(4)*_long_hor_movement, 0, global.show_hidden ? 3 : 2);
		break;
		case option_type.camera_mode:
		case option_type.noise_type:
		case option_type.hud_layout:
		case option_type.lives_mode:
		case option_type.texture_filtering:
		case option_type.moon_jump:
		case option_type.lod:
		case option_type.fixes:
			_option.state = clamp(_option.state + _hor_movement + wait(4)*_long_hor_movement, 0, 2);
			break;
		case option_type.graphics_backend_windows:
			_option.state = clamp(_option.state + _hor_movement + wait(4)*_long_hor_movement, 0, 2);
			break;
		case option_type.graphics_backend_other:
			_option.state = 0;
			break;
		case option_type.mouse_button:
			_option.state = clamp(_option.state + _hor_movement + wait(4)*_long_hor_movement, 0, n64_buttons.count-1);
			break;
		case option_type.multiplier:
			_option.state = max(0.1, _option.state + (_hor_movement + _long_hor_movement * 2)/10);
			break;
		case option_type.percentage:
			_option.state = clamp(_option.state + (_hor_movement + wait(2)*_long_hor_movement)/20, 0, 1);
			break;
		case option_type.monitor:
			_option.state = clamp(_option.state + _hor_movement + wait(4)*_long_hor_movement, 1, 10);
			break;
		case option_type.frame_rate:
			_option.state = clamp(_option.state + _hor_movement + wait(4)*_long_hor_movement, 0, 1);
			break;
		case option_type.palette:
			_option.state = clamp(_option.state + _hor_movement + wait(4)*_long_hor_movement, 0, 11);
			break;
		case option_type.draw_distance:
			_option.state = max(0, _option.state + (_hor_movement + wait(4)*_long_hor_movement * 2)/2);
			break;
	}	
}

enum option_limit {
    none,
    left,
    right,
    both
}

// Gets the current option limits
function get_option_limit(_option) {
    
    var _state = _option.state;
	
	switch (_option.type) {
        
		case option_type.uint:
        case option_type.draw_distance:
			return (_state <= 0) ? option_limit.right : option_limit.both;
            
		case option_type.float:
		case option_type.multiplier:
			return option_limit.both;
            
		case option_type.key:
			var _keyboard_value = get_digits(keyboard_string);
			if (_keyboard_value != "") {
                if (_state <= 1)
                    return option_limit.right;
                else if (_state >= 999)
                    return option_limit.left;
                else
                    return option_limit.both;
            }
			else {
                if (_state <= 1)
                    return option_limit.right;
                else if (_state >= 336)
                    return option_limit.left;
                else
                    return option_limit.both;
			}
            
		case option_type.encore_mode:
		case option_type.blj_everywhere:
		case option_type.green_demon_mode:
            if (_state <= 0)
                return option_limit.right;
            else if (_state >= 3)
                return option_limit.left;
            else
                return option_limit.both;
                
		case option_type.star_message:
            if (_state <= 0)
                return option_limit.right;
            else if (_state >= global.show_hidden ? 3 : 2)
                return option_limit.left;
            else
                return option_limit.both;
                
		case option_type.camera_mode:
		case option_type.noise_type:
		case option_type.hud_layout:
		case option_type.lives_mode:
		case option_type.texture_filtering:
		case option_type.moon_jump:
		case option_type.lod:
		case option_type.fixes:
		case option_type.graphics_backend_windows:
            if (_state <= 0)
                return option_limit.right;
            else if (_state >= 2)
                return option_limit.left;
            else
                return option_limit.both;
                
		case option_type.graphics_backend_other:
            return option_limit.none;
            
		case option_type.mouse_button:
			return (_state <= 0.1) ? option_limit.right : option_limit.both;
            
		case option_type.percentage:
            if (_state <= 0)
                return option_limit.right;
            else if (_state >= 1)
                return option_limit.left;
            else
                return option_limit.both;
                
		case option_type.monitor:
            if (_state <= 1)
                return option_limit.right;
            else if (_state >= 10)
                return option_limit.left;
            else
                return option_limit.both;
                
		case option_type.frame_rate:
            if (_state <= 0)
                return option_limit.right;
            else if (_state >= 1)
                return option_limit.left;
            else
                return option_limit.both;
            
		case option_type.palette:
            if (_state <= 0)
                return option_limit.right;
            else if (_state >= 11)
                return option_limit.left;
            else
                return option_limit.both;
                
        default:
            return option_limit.both;
	}	
}
