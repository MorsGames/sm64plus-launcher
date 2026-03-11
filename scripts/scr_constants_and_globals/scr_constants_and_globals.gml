#macro DEBUG true

#macro ARM false

#macro PATH (global.debug_path != "" ? (global.debug_path + @"/") : (program_directory + @"/sm64plus/"))
#macro GFX_PATH (PATH + @"textures/")
#macro GAME_PATH (PATH + @"build/us_pc/")
#macro CATEGORIES_PATH (PATH + @"launcher/categories.json")
#macro LAUNCHER_CATEGORY_PATH (PATH + @"launcher/launcher_settings.json")
#macro GAME_EXE ((CURRENT_OS == os_windows) ? "sm64.us.exe" : "sm64.us")
#macro GAME_EXE_OLD ((CURRENT_OS == os_windows) ? "sm64.us.f3dex2e.exe" : "sm64.us.f3dex2e")
#macro INI_PATH (game_save_id + @"settings.ini")
#macro INI2_PATH (game_save_id + @"launcher_settings.ini")
#macro INI3_PATH (game_save_id + @"launcher_config.ini")
#macro PRESETS_PATH (game_save_id + @"presets/")
#macro INTERNAL_PRESETS_PATH PATH + (@"launcher/presets/")
#macro INPUT_PRESETS_PATH (game_save_id + @"input_presets/")
#macro INTERNAL_INPUT_PRESETS_PATH PATH + (@"launcher/input_presets/")
#macro EXTERNAL_PATH (game_save_id + @"gfx")
#macro EXTERNAL_PATH_ORIGINAL (PATH + @"build/us_pc/gfx")
#macro VERSION_FILE_PATH (PATH + @"VERSION")

#macro VERSION "v4.0.0"

#macro MIN_WIDTH 512
#macro MIN_HEIGHT 240

#macro BASE_WIDTH 640
#macro BASE_HEIGHT 360	

#macro BOX_SPACING clamp(112-640+room_width, 8, 112)
#macro BOX_SPACING_2 clamp(32-640+room_width, 8, 32)
#macro BOX_TITLE_LEFT (room_width/2-box_size)
#macro BOX_TITLE_RIGHT (room_width/2+box_size)
#macro TITLE_MENU_Y (room_height-120)

#macro COLOR_BLACK $0B0709
#macro COLOR_WHITE c_white/*$EFFBFF*/
#macro COLOR_YELLOW $00EFFF

#macro CURRENT_OS os_type

enum settings_section {
	system,
	game_config,
	input_mapping
}

// Not sure if these are right lol
#macro SONG_BPM 130
#macro BPM_IN_MS (60000/SONG_BPM)

global.font = font_add_sprite(spr_font, ord(" "), false, 1);

// Debug/Development mode
var _file = file_text_open_read(game_save_id + "path.txt");
    
if (_file == -1) {
    if (DEBUG) {
        show_message("Please create a file in your working directory (\"%LOCALAPPDATA%\\SM64Plus\") called \"path.txt\" and put the path to the game's repository there.");
        game_end();
    }
    else {
        global.debug_path = "";
    }
}
else {
    global.debug_path = file_text_read_string(_file);
    file_text_close(_file);
}

// Forgot why I needed to set these here
function init() {
	
	draw_set_font(global.font);
	draw_set_halign(fa_center);
}