/// @desc Save the settings

save_settings(INI_PATH);

ini_open(INI2_PATH);
for (var j=0; j<array_length(global.launcher_category.items); j++) {
	var _item = global.launcher_category.items[j];
	ini_save_item(_item, global.launcher_category);
}
ini_close();

load_launcher_settings();

obj_background.display_message("Saved the settings!")