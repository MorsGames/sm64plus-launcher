progress = 0
slide_out = 0;

launch_game = function() {
	//audio_pause_sound(global.music)
	//execute_program("cmd.exe", "\"cd /d \"" + GAME_PATH + "\" && \"" + GAME_EXE + "\"\"", true)
	if (directory_exists(EXTERNAL_PATH_ORIGINAL))
		copy_dir(EXTERNAL_PATH_ORIGINAL, EXTERNAL_PATH);
	if (file_exists(GAME_PATH + GAME_EXE))
		execute_program(GAME_PATH + GAME_EXE, "", true)
	if (file_exists(GAME_PATH + GAME_EXE_OLD))
		execute_program(GAME_PATH + GAME_EXE_OLD, "", true)
	slide_out = 1;
	//audio_resume_sound(global.music)
	//audio_sound_gain(global.music, 1, 100)
}

//sfx_play(snd_startgame)
//audio_sound_gain(global.music, 0, 500)
timer(launch_game, 60)