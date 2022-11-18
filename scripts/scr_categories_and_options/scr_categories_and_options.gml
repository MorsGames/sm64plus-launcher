// When you object oriented programming

global.category_count = 0;

// The systems the settings are available for
enum system {
	
	any,
	windows,
	non_windows
}

// The N64 controller buttons, in an easier to work with form
enum n64_buttons {
	
	none,
	a,
	b,
	start,
	l,
	r, 
	z,
	c_up,
	c_down,
	c_left,
	c_right,
	count
}

// All the raw N64 button ids
global.n64_button_values = [0, 0x8000, 0x4000, 0x1000, 0x0020, 0x0010, 0x2000, 0x0008, 0x0004, 0x0002, 0x0001]

// Returns the enum value based on the raw button id
function n64_button_to_enum(button_value) {
	switch (button_value) {
		case 0:
			return n64_buttons.none;
		case 0x8000:
			return n64_buttons.a;
		case 0x4000:
			return n64_buttons.b;
		case 0x1000:
			return n64_buttons.start;
		case 0x0020:
			return n64_buttons.l;
		case 0x0010:
			return n64_buttons.r;
		case 0x2000:
			return n64_buttons.z;
		case 0x0008:
			return n64_buttons.c_up;
		case 0x0004:
			return n64_buttons.c_down;
		case 0x0002:
			return n64_buttons.c_left;
		case 0x0001:
			return n64_buttons.c_right;
	}
}

// The Xbox controller buttons, in an easier to work with form
// These are based on SDL button codes (2 ^ (n + 1))
enum controller_buttons {
	
	none        = 0,
	a           = 1 << 1,
	b           = 1 << 2,
    x           = 1 << 3,
    y           = 1 << 4,
    select      = 1 << 5,
    guide       = 1 << 6,
	start       = 1 << 7,
    left_stick  = 1 << 8,
    right_stick = 1 << 9,
	l           = 1 << 10,
	r           = 1 << 11, 
	dpad_up     = 1 << 12,
	dpad_down   = 1 << 13,
	dpad_left   = 1 << 14,
	dpad_right  = 1 << 15,
	zl          = 1 << 22,
    zr          = 1 << 23
}

// Returns the enum value based on the raw button id
function controller_button_to_enum(button_value) {
	switch (button_value) {
		default:
			return controller_buttons.none;
		case gp_face1:
			return controller_buttons.a;
		case gp_face2:
			return controller_buttons.b;
		case gp_face3:
			return controller_buttons.x;
		case gp_face4:
			return controller_buttons.y;
		case gp_select:
			return controller_buttons.select;
		case gp_start:
			return controller_buttons.start;
		case gp_stickl:
			return controller_buttons.left_stick;
		case gp_stickr:
			return controller_buttons.right_stick;
		case gp_shoulderl:
			return controller_buttons.l;
		case gp_shoulderr:
			return controller_buttons.r;
		case gp_padu:
			return controller_buttons.dpad_up;
		case gp_padd:
			return controller_buttons.dpad_down;
		case gp_padl:
			return controller_buttons.dpad_left;
		case gp_padr:
			return controller_buttons.dpad_right;
		case gp_shoulderlb:
			return controller_buttons.zl;
		case gp_shoulderrb:
			return controller_buttons.zr;
	}
}

// Returns a list containing the button names
function controller_button_to_name(_state) {
    
    var _list = ds_list_create();
            
	if ((_state & controller_buttons.a) == controller_buttons.a)
        ds_list_add(_list, "A");
	if ((_state & controller_buttons.b) == controller_buttons.b)
		ds_list_add(_list, "B");
	if ((_state & controller_buttons.x) == controller_buttons.x)
		ds_list_add(_list, "X");
	if ((_state & controller_buttons.y) == controller_buttons.y)
		ds_list_add(_list, "Y");
    if ((_state & controller_buttons.start) == controller_buttons.start)
		ds_list_add(_list, "Start");
	if ((_state & controller_buttons.guide) == controller_buttons.guide)
		ds_list_add(_list, "Guide");
	if ((_state & controller_buttons.select) == controller_buttons.select)
		ds_list_add(_list, "Select");
	if ((_state & controller_buttons.left_stick) == controller_buttons.left_stick)
		ds_list_add(_list, "Left Stick Press");
	if ((_state & controller_buttons.right_stick) == controller_buttons.right_stick)
		ds_list_add(_list, "Right Stick Press");
	if ((_state & controller_buttons.l) == controller_buttons.l)
		ds_list_add(_list, "Left Shoulder");
	if ((_state & controller_buttons.r) == controller_buttons.r)
		ds_list_add(_list, "Right Shoulder");
	if ((_state & controller_buttons.dpad_up) == controller_buttons.dpad_up)
		ds_list_add(_list, "D-Pad Up");
	if ((_state & controller_buttons.dpad_down) == controller_buttons.dpad_down)
		ds_list_add(_list, "D-Pad Down");
	if ((_state & controller_buttons.dpad_left) == controller_buttons.dpad_left)
		ds_list_add(_list, "D-Pad Left");
	if ((_state & controller_buttons.dpad_right) == controller_buttons.dpad_right)
		ds_list_add(_list, "D-Pad Right");
	if ((_state & controller_buttons.zl) == controller_buttons.zl)
		ds_list_add(_list, "Left Trigger");
	if ((_state & controller_buttons.zr) == controller_buttons.zr)
		ds_list_add(_list, "Right Trigger");
    
    return _list;
}

// All the key names
global.key_names = ["Esc", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=", "Backspace", "Tab", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "[", "]", "Enter", "Ctrl (Left)", "A", "S", "D", "F", "G", "H", "J", "K", "L", ";", "'", "`", "Shift (Left)", "\\", "Z", "X", "C", "V", "B", "N", "M", ",", ".", "/", "Shift (Right)", "* (Numpad)", "Alt (Left)", "Space", "Caps Lock", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "Num Lock", "Scroll Lock", "7 (Numpad)", "8 (Numpad)", "9 (Numpad)", "- (Numpad)", "4 (Numpad)", "5 (Numpad)", "6 (Numpad)", "+ (Numpad)", "1 (Numpad)", "2 (Numpad)", "3 (Numpad)", "0 (Numpad)", ". (Numpad)", "F11", "F12", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "= (Numpad)", "^", "@", ":", "_", "Unknown", "Unknown", "Unknown", "Unknown", "Enter (Numpad)", "Ctrl (Right)", ", (Numpad)", "/ (Numpad)", "Unknown", "Alt (Right)", "Pause", "Home", "Up (Numpad)", "Page Up", "Left (Numpad)", "Right (Numpad)", "End", "Down (Numpad)", "Page Down", "Insert", "Delete", "Windows", "Windows (Right)"];

// Setting up the categories and options
global.categories = [];

// Launcher stuff
global.launcher_category = {};

// Loads all the categories and options
function load_categories() {
	
	// Load the json to memory
	var _file = file_text_open_read(CATEGORIES_PATH);
	var _contents = "";

	while (!file_text_eof(_file)) {
		_contents += file_text_readln(_file);
	}
	file_text_close(_file);

	// Replace the constants
	_contents = replace_json_constants(_contents);

	// Parse the result
	global.categories = json_parse(_contents);
	global.category_count = array_length(global.categories);	
}

// Clean up the categories and settings we don't need
function delete_categories() {
	
	for (var i=0; i<global.category_count; i++) {
		
		var _category = global.categories[i];
		
		// Delete the categories
		if ((_category.os == system.windows && CURRENT_OS != os_windows) 
		|| (_category.os == system.non_windows && CURRENT_OS == os_windows)
		|| (_category.hidden && !global.show_hidden)) {
			
			array_delete(global.categories, i, 1);
			i--;
			global.category_count--;
		}
		// Delete the settings
		else {
			
			var _item_count = array_length(_category.items);
			
			for (var j=0; j<_item_count; j++) {
			
				var _item = _category.items[j];
			
				if ((_item.os == system.windows && CURRENT_OS != os_windows) || (_item.os == system.non_windows && CURRENT_OS == os_windows)) {
					
					array_delete(_category.items, j, 1);
					j--;
					_item_count--;
				}
			}
		}
	}
}

// Loads the settings
function load_settings(path, load_recommended = true, partial_load = false) {
	
	// Load the recommended settings first in case the setting is missing in the ini file due to an update
	// Some settings get loaded twice, so this can be optimized a lot
	if (load_recommended)
		load_settings(INTERNAL_PRESETS_PATH + "Recommended.ini", false, partial_load);
	
	// Actually load the settings from the path
	ini_open(path)
	
	for (var i=0; i<global.category_count; i++) {
		
		var _category = global.categories[i];
		
		for (var j=0; j<array_length(_category.items); j++) {
			
			var _item = _category.items[j];
			
			if ((!partial_load || _category.reload_with_preset)
				&& ((_item.type != option_type.color && ini_key_exists(_category.title, _item.internal_name))
					|| (_item.type == option_type.color && ini_key_exists(_category.title, _item.internal_name + "_r") && ini_key_exists(_category.title, _item.internal_name + "_g") && ini_key_exists(_category.title, _item.internal_name + "_b")))) {
				
				ini_load_item(_item, _category);
			}
		}
	}
	ini_close()	
}

function set_fullscreen(fullscreen) {
    
    global.fullscreen = fullscreen;
		
    window_set_fullscreen(global.fullscreen)
    window_set_cursor(global.fullscreen ? cr_none : cr_default);
}

function set_mute(mute_sounds, mute_music) {
    
    global.mute_sounds = mute_sounds;
    global.mute_music = mute_music;
    
	if (room != rm_init) {
        
		if (global.mute_music)
			audio_stop_sound(snd_music)
		else
			music_play(snd_music)
	}
}

function set_window_size(window_width, window_height) {
    
    if (window_width < MIN_WIDTH)
        window_width = MIN_WIDTH;
    if (window_height < MIN_HEIGHT)
        window_height = MIN_HEIGHT;
    
    if (global.window_width == window_width && global.window_height == window_height)
        exit;
    
    global.window_width = window_width;
    global.window_height = window_height;
		
    window_set_size(global.window_width, global.window_height);
}

function load_launcher_file() {
    var _launcher_file = file_text_open_read(LAUNCHER_CATEGORY_PATH);
    var _launcher_contents = "";

    while (!file_text_eof(_launcher_file)) {
    	_launcher_contents += file_text_readln(_launcher_file);
    }
    file_text_close(_launcher_file);

    // Replace the constants
    _launcher_contents = replace_json_constants(_launcher_contents);

    // Parse the result
    global.launcher_category = json_parse(_launcher_contents);

    // Set the window size
    global.window_width = -1;
    global.window_height = -1;
}

// Load the settings for the launcher
function load_launcher_settings() {
    
    ini_open(INI2_PATH)
		
    for (var j=0; j<array_length(global.launcher_category.items); j++) {
			
    	var _item = global.launcher_category.items[j];
			
    	ini_load_item(_item, global.launcher_category);
    }
    
    set_fullscreen(ini_read_string("LAUNCHER", "fullscreen", "false") == "true");
    set_mute(ini_read_string("LAUNCHER", "mute_sounds", "false") == "true", ini_read_string("LAUNCHER", "mute_music", "false") == "true");
    
    global.scaling_mode = ini_read_real("LAUNCHER", "scaling_mode", 1);
    global.quick_launch = ini_read_string("LAUNCHER", "quick_launch", "false") == "true";
    global.close_on_launch = ini_read_string("LAUNCHER", "close_on_launch", "false") == "true";
    
    set_window_size(ini_read_real("LAUNCHER", "window_width", 1280), ini_read_real("LAUNCHER", "window_height", 720));
}

// Saves the settings
function save_settings(path) {
	
	ini_open(path);
	for (var i=0; i<global.category_count; i++) {
		var _category = global.categories[i];
		for (var j=0; j<array_length(_category.items); j++) {
			var _item = _category.items[j];
			ini_save_item(_item, _category);
		}
	}
	ini_close();
}

// Return if the setting is enabled or disabled
function is_enabled(items, index) {
	
	var _enabled_by = items[index].enabled_by;
	var _disabled_by = items[index].disabled_by;
	return (_enabled_by < 0 || !is_numeric(items[_enabled_by].state) || items[_enabled_by].state > 0) &&
		(_disabled_by < 0 || !is_numeric(items[_disabled_by].state) || items[_disabled_by].state <= 0)
}