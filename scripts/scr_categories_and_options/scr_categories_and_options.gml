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

// All the key names
global.key_names = ["Esc", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=", "Backspace", "Tab", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "[", "]", "Enter", "Ctrl (Left)", "A", "S", "D", "F", "G", "H", "J", "K", "L", ";", "'", "`", "Shift (Left)", "\\", "Z", "X", "C", "V", "B", "N", "M", ",", ".", "/", "Shift (Right)", "* (Numpad)", "Alt (Left)", "Space", "Caps Lock", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "Num Lock", "Scroll Lock", "7 (Numpad)", "8 (Numpad)", "9 (Numpad)", "- (Numpad)", "4 (Numpad)", "5 (Numpad)", "6 (Numpad)", "+ (Numpad)", "1 (Numpad)", "2 (Numpad)", "3 (Numpad)", "0 (Numpad)", ". (Numpad)", "F11", "F12", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "= (Numpad)", "^", "@", ":", "_", "Unknown", "Unknown", "Unknown", "Unknown", "Enter (Numpad)", "Ctrl (Right)", ", (Numpad)", "/ (Numpad)", "Unknown", "Alt (Right)", "Pause", "Home", "Up (Numpad)", "Page Up", "Left (Numpad)", "Right (Numpad)", "End", "Down (Numpad)", "Page Down", "Insert", "Delete", "Windows", "Windows (Right)"];

// Setting up the categories and options
global.categories = [];

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