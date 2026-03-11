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
	a           = 2,
	b           = 4,
    x           = 8,
    y           = 16,
    select      = 32,
    guide       = 64,
	start       = 128,
    left_stick  = 256,
    right_stick = 512,
	l           = 1024,
	r           = 2048, 
	dpad_up     = 4096,
	dpad_down   = 8192,
	dpad_left   = 16384,
	dpad_right  = 32768,
	zl          = 4194304,
    zr          = 8388608
}

// Returns the enum value based on the raw button id
function controller_button_to_enum(button_value) {
	switch (button_value) {
		default:
			return controller_buttons.none;
		case sdl_controller_button.a:
			return controller_buttons.a;
		case sdl_controller_button.b:
			return controller_buttons.b;
		case sdl_controller_button.x:
			return controller_buttons.x;
		case sdl_controller_button.y:
			return controller_buttons.y;
		case sdl_controller_button.select:
			return controller_buttons.select;
		case sdl_controller_button.start:
			return controller_buttons.start;
		case sdl_controller_button.lstick:
			return controller_buttons.left_stick;
		case sdl_controller_button.rstick:
			return controller_buttons.right_stick;
		case sdl_controller_button.l:
			return controller_buttons.l;
		case sdl_controller_button.r:
			return controller_buttons.r;
		case sdl_controller_button.dup:
			return controller_buttons.dpad_up;
		case sdl_controller_button.ddown:
			return controller_buttons.dpad_down;
		case sdl_controller_button.dleft:
			return controller_buttons.dpad_left;
		case sdl_controller_button.dright:
			return controller_buttons.dpad_right;
		case sdl_controller_button.zl:
			return controller_buttons.zl;
		case sdl_controller_button.zr:
			return controller_buttons.zr;
	}
}

// Returns a list containing the button names
function controller_button_to_name(_state) {
    
    var _list = ds_list_create();
            
	if ((_state & controller_buttons.a) == controller_buttons.a)
        ds_list_add(_list, gamepad_get_button_name(sdl_controller_button.a));
	if ((_state & controller_buttons.b) == controller_buttons.b)
		ds_list_add(_list, gamepad_get_button_name(sdl_controller_button.b));
	if ((_state & controller_buttons.x) == controller_buttons.x)
		ds_list_add(_list, gamepad_get_button_name(sdl_controller_button.x));
	if ((_state & controller_buttons.y) == controller_buttons.y)
		ds_list_add(_list, gamepad_get_button_name(sdl_controller_button.y));
    if ((_state & controller_buttons.start) == controller_buttons.start)
		ds_list_add(_list, gamepad_get_button_name(sdl_controller_button.start));
	if ((_state & controller_buttons.guide) == controller_buttons.guide)
		ds_list_add(_list, gamepad_get_button_name(sdl_controller_button.guide));
	if ((_state & controller_buttons.select) == controller_buttons.select)
		ds_list_add(_list, gamepad_get_button_name(sdl_controller_button.select));
	if ((_state & controller_buttons.left_stick) == controller_buttons.left_stick)
		ds_list_add(_list, gamepad_get_button_name(sdl_controller_button.lstick));
	if ((_state & controller_buttons.right_stick) == controller_buttons.right_stick)
		ds_list_add(_list, gamepad_get_button_name(sdl_controller_button.rstick));
	if ((_state & controller_buttons.l) == controller_buttons.l)
		ds_list_add(_list, gamepad_get_button_name(sdl_controller_button.l));
	if ((_state & controller_buttons.r) == controller_buttons.r)
		ds_list_add(_list, gamepad_get_button_name(sdl_controller_button.r));
	if ((_state & controller_buttons.dpad_up) == controller_buttons.dpad_up)
		ds_list_add(_list, gamepad_get_button_name(sdl_controller_button.dup));
	if ((_state & controller_buttons.dpad_down) == controller_buttons.dpad_down)
		ds_list_add(_list, gamepad_get_button_name(sdl_controller_button.ddown));
	if ((_state & controller_buttons.dpad_left) == controller_buttons.dpad_left)
		ds_list_add(_list, gamepad_get_button_name(sdl_controller_button.dleft));
	if ((_state & controller_buttons.dpad_right) == controller_buttons.dpad_right)
		ds_list_add(_list, gamepad_get_button_name(sdl_controller_button.dright));
	if ((_state & controller_buttons.zl) == controller_buttons.zl)
		ds_list_add(_list, gamepad_get_button_name(sdl_controller_button.zl));
	if ((_state & controller_buttons.zr) == controller_buttons.zr)
		ds_list_add(_list, gamepad_get_button_name(sdl_controller_button.zr));
    
    return _list;
}

// Setting up the categories and options
global.categories = [];

// Section indices
global.system_category_indices = [];
global.game_config_category_indices = [];
global.input_mapping_category_indices = [];

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
		|| (_category.os == system.non_windows && CURRENT_OS == os_windows)) {
			
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
	
	calculate_category_ranges();
}

// Calculates the category ranges like a pro
function calculate_category_ranges() {
	
	global.system_category_indices = [0, 1];
	
	global.input_mapping_category_indices = [];
	for (var i = global.category_count - 3; i < global.category_count; i++) {
		array_push(global.input_mapping_category_indices, i);
	}
	
	global.game_config_category_indices = [];
	for (var i = 2; i < global.category_count - 3; i++) {
		array_push(global.game_config_category_indices, i);
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
			
			if (!partial_load
				&& ((_item.type != option_type.color && ini_key_exists(_category.title, _item.internal_name))
					|| (_item.type == option_type.color && ini_key_exists(_category.title, _item.internal_name + "_r") && ini_key_exists(_category.title, _item.internal_name + "_g") && ini_key_exists(_category.title, _item.internal_name + "_b")))) {
				
				ini_load_item(_item, _category);
			}
		}
	}
	ini_close()	
}

// Loads the settings for a specific range of categories
function load_settings_range(path, start_index, end_index, load_recommended = true) {
	
	if (load_recommended)
		load_settings_range(INTERNAL_PRESETS_PATH + "Recommended.ini", start_index, end_index, false);
	
	ini_open(path)
	
	for (var i = start_index; i <= end_index; i++) {
		
		var _category = global.categories[i];
		
		for (var j = 0; j < array_length(_category.items); j++) {
			
			var _item = _category.items[j];
			
			if ((_item.type != option_type.color && ini_key_exists(_category.title, _item.internal_name))
				|| (_item.type == option_type.color && ini_key_exists(_category.title, _item.internal_name + "_r") && ini_key_exists(_category.title, _item.internal_name + "_g") && ini_key_exists(_category.title, _item.internal_name + "_b"))) {
				
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

function set_sfx_volume(volume) {
    global.sfx_volume = volume;
}

function set_music_volume(volume) {
    global.music_volume = volume;
    
	if (room != rm_init) {
		if (global.music_volume <= 0) {
			audio_stop_sound(snd_music)
			global.music_instance = -1;
		}
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

function launcher_ini_key_exists(_item, _category = global.launcher_category) {

    if (_item.type == option_type.color) {
        return ini_key_exists(_category.title, _item.internal_name + "_r")
            && ini_key_exists(_category.title, _item.internal_name + "_g")
            && ini_key_exists(_category.title, _item.internal_name + "_b");
    }

    return ini_key_exists(_category.title, _item.internal_name);
}

function launcher_get_item_state(_internal_name, _default) {

    for (var j = 0; j < array_length(global.launcher_category.items); j++) {
        var _item = global.launcher_category.items[j];

        if (_item.internal_name == _internal_name) {
            if (variable_struct_exists(_item, "state")) {
                return _item.state;
            }

            _item.state = _default;
            return _item.state;
        }
    }

    return _default;
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

    if (file_exists(INI2_PATH)) {
        ini_open(INI2_PATH);

        for (var j = 0; j < array_length(global.launcher_category.items); j++) {
            var _item = global.launcher_category.items[j];

            if (launcher_ini_key_exists(_item, global.launcher_category)) {
                ini_load_item(_item, global.launcher_category);
            }
        }

        ini_close();
    }

    set_fullscreen(launcher_get_item_state("fullscreen", false));
    set_sfx_volume(launcher_get_item_state("sound_volume", 1));
    set_music_volume(launcher_get_item_state("music_volume", 1));

    global.scaling_mode = launcher_get_item_state("scaling_mode", 1);
    global.quick_launch = launcher_get_item_state("quick_launch", false);
    global.close_on_launch = launcher_get_item_state("close_on_launch", false);

    set_window_size(
        launcher_get_item_state("window_width", 1280),
        launcher_get_item_state("window_height", 720)
    );
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

// Saves the settings for a specific range of categories
function save_settings_range(path, start_index, end_index) {
	
	ini_open(path);
	for (var i = start_index; i <= end_index; i++) {
		var _category = global.categories[i];
		for (var j = 0; j < array_length(_category.items); j++) {
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
