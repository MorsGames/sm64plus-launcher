/// @desc Load stuff

// Load the letter images and whatnot
load_letters();

// Load the categories
load_categories();

// Load the game version
var _file = file_text_open_read(VERSION_FILE_PATH);
global.game_version = file_text_read_string(_file);
file_text_close(_file);

// Load the settings

// Show hidden settings
global.show_hidden = input_check(key.del);

if (global.show_hidden) {
	obj_background.display_message("Enabled the hidden categories.")
}

// Delete the categories that shouldn't be seen
delete_categories();

// If we have settings load that, otherwise load the default
if (file_exists(INI_PATH))
	load_settings(INI_PATH);
else
	load_settings(INTERNAL_PRESETS_PATH + "Recommended.ini", false);
