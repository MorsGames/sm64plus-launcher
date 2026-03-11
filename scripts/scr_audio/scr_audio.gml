
/// Plays a sound effect.
function sfx_play(sound) {
	
	// Ignore if the game is muted
	if (global.sfx_volume <= 0)
		exit;
		
	// Always only play a single instance of the sound effects
	audio_stop_sound(sound)
	var _snd = audio_play_sound(sound, 0, 0)
	audio_sound_gain(_snd, global.sfx_volume, 0)
}

/// Plays music.
function music_play(music) {
	
	// Ignore if the game is muted
	if (global.music_volume <= 0)
		exit;
		
	// Don't play if it's already playing
	if (!audio_is_playing(music)) {
		global.music_instance = audio_play_sound(music, 0, 1)
	}
	
	audio_sound_gain(global.music_instance, global.music_volume, 0)
}

// FUCK THIS SHIT!!!!!!!

/*
function load_audio() {
	
	var _path = "C:\\Users\\Mors\\Documents\\GitHub\\sm64-port\\sound\\samples\\sfx_mario\\0B.aiff";
	var _buff = buffer_create(1024, buffer_grow, 1);

	if (file_exists(_path)) {
		
	    var _file = file_bin_open(_path, 0);
	    var _size = file_bin_size(_file);

	    for(var i = 0; i < _size; i++) {
	        buffer_write(_buff, buffer_u8, file_bin_read_byte(_file));
	    }
		
	    file_bin_close(_file);
		
		var a = buffer_read(_buff,buffer_u8)<<24;
		a |= buffer_read(_buff,buffer_u8)<<16;
		a |= buffer_read(_buff,buffer_u8)<<8;
		a |= buffer_read(_buff,buffer_u8);

	    var audio = audio_create_buffer_sound(a, buffer_u8, 16000, 0, _size, audio_mono);
		audio_play_sound(audio, 0, 0)
	}
	else
		show_message("whooper... yum");
}*/