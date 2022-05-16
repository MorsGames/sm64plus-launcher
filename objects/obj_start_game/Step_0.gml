if (slide_out) {
	
	if (progress > 0)
		progress -= 0.03125
	else {
		instance_destroy();
		audio_resume_sound(snd_music)
		instance_create_layer(0, 0, layer, obj_title_menu);
		
		if (file_exists(INI_PATH)) {
			load_settings(INI_PATH);
		}
		else {
			load_settings(INTERNAL_PRESETS_PATH + "Recommended.ini", false);
		}
	}
}
else {
	
	if (progress < 1)
		progress += 0.03125
}
