/// @desc The options menu

event_inherited();

scale = -0.25

// The options
options = ["Start Game", "Settings", "Update", "Quit"];
options2 = ["Update Launcher", "Pull & Rebuild", "Pull, Clean & Rebuild", "Back"];

page = 0;

box_size = 96;

run_game = function() {
	sfx_play(snd_start);
	audio_pause_sound(snd_music)
	instance_create_layer(0, 0, layer, obj_start_game);
	instance_destroy();
}

music_play(snd_music)
	
bop = function() {
	if (!global.mute_music)
		scale = 0.5;	
}

start_bopping = function() {
	timer_ms(bop, BPM_IN_MS, true);	
}

timer_ms(start_bopping, 1500);