// Script for rendering text. Kinda messy.

// Load a single letter as a sprite.
function load_letter(name) {
    
    if (name == "4200")
        name = "5600";
    
    var _path = GFX_PATH + "segment2\\segment2.0" + name + ".rgba16.png";
    if (file_exists(_path))
        return sprite_add(_path, 1, 0, 0, 0, 0);
    else {
        if (name == "5000")
            return spr_placeholder
        return load_letter("5000");
    }
}

// Load all the letters into an array.
function load_letters() {
    
    var _letters;
    
    //Starting from the first to last.
    for (var i=0; i<26; i++) {
        _letters[i] = load_letter(real_to_hex((10+i)*512));
    }
    global.letters = _letters;
}

// Convert number to hexadecimal string.
function real_to_hex(value, digits = -1) {
    
    var _get_letter = function(num) {
        return (num < 10) ? string(num) : chr(55+num);
    }
    
	var _string = "";
	var _letters = 0;
	do {
	    _string = _get_letter(value % 16) + _string;
	    value = value div 16;
		if (digits != -1)
			_letters++;
	}
	until (value == 0)
	
	if (digits != -1) {
		repeat(digits-_letters) {
			_string = "0" + _string;
		}
	}

    return _string;
}

function hex_to_real(value) {
    
	var _result = 0;

	var _zero = ord("0");
	var _nine = ord("9");
	var _A = ord("A");
	var _F = ord("F");

	for (var i=1; i<=string_length(value); i++) {
	    var _c = ord(string_char_at(string_upper(value), i));
	    _result *= 16;
	    if (_c >= _zero && _c <= _nine){
	        _result = _result+(_c-_zero);
	    }
		else if (_c >= _A && _c <= _F){
	        _result = _result+(_c-_A+10);
	    }
		else {
			_result = 0;
	    }
	}

	return _result;
}

function rgb_to_bgr(value) {
	return make_color_rgb(color_get_blue(value), color_get_green(value), color_get_red(value))	
}

// Draw string from a letter array
function draw_letters(_x, _y, str, scale) {
    
    var _length = string_length(str);
	str = string_replace(str, "V", "U")
    
    for (var i=0; i<_length; i++) {
        
        var _char = string_char_at(str, i+1);
        if (_char == " ")
            continue;
            
        var _value = ord(_char)-65;
        var _xx = _x + (i-(_length)/2)*13*scale;
        draw_sprite_stretched_ext(global.letters[_value], 0, _xx, _y + scale*2 - 8, 16*scale, 16*scale, c_black, 0.75);
        draw_sprite_stretched_ext(global.letters[_value], 0, _xx, _y - 8, 16*scale, 16*scale, c_white, 1);
    }
}

// Draw an option with support for different colors per characters
function draw_option(_x, _y, str, scale, enabled = true) {
    
    var _length = string_length(str);
	var _color = c_white;
    
    for (var i=0; i<_length; i++) {
		
		var _char = string_char_at(str, i+1);
		
		if (_char == "✔") {
			_color = c_lime;
		}
		else if (_char == "❌") {
			_color = c_red;
		}
		else if (_char == "❓") {
			_color = c_aqua;
		}
		else if (_char == "⬜") {
			_color = c_white;
		}
		else if (_char == "⬛") {
			_color = c_ltgray;
		}
		else if (_char != " ") {
			var _xx = _x + (i-(_length-1)/2)*6*scale;
		
			if (_char == ">")
				_xx += abs(sin(current_frames/32))*8;
			if (_char == "<")
				_xx -= abs(sin(current_frames/32))*8;
			
		    draw_set_color(COLOR_BLACK)
		    draw_text_transformed(_xx+scale, _y+scale, _char, scale, scale , 0)
		    draw_set_color(enabled ? _color : c_gray)
		    draw_text_transformed(_xx, _y, _char, scale, scale , 0)
		}
    }
    

}

// Just draw a text
function draw_description(_x, _y, str, scale) {

	draw_set_color(COLOR_BLACK)
	draw_text_ext_transformed(_x+scale, _y+scale, str, 12, room_width/scale-32, scale, scale, 0)
	draw_set_color(c_white)
	draw_text_ext_transformed(_x, _y, str, 12, room_width/scale-32, scale, scale, 0)
}

function draw_description_inverted(_x, _y, str, scale) {

	draw_set_color(c_white)
	draw_text_ext_transformed(_x+scale, _y+scale, str, 12, room_width/scale-32, scale, scale, 0)
	draw_set_color(COLOR_BLACK)
	draw_text_ext_transformed(_x, _y, str, 12, room_width/scale-32, scale, scale, 0)
	draw_set_color(c_white)
}