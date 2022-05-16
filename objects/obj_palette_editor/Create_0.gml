/// @desc Unfinished palette editor
// Needs proper UI

progress = 0
slide_out = 0;

item = -1;

keyboard_string = ""
color_string = ""

set_color = function() {
	color_string = item.state[1]
	keyboard_string = color_string
}

timer(set_color, 1)

// Resets the colors to all N64 defaults
reset_color = function() {
	
	switch (item.internal_name)	{
		case "color_cap_main":
			color_string = "FF0000";
			break;
		case "color_cap_shading":
			color_string = "7F0000";
			break;
		
		case "color_shirt_main":
			color_string = "FF0000";
			break;
		case "color_shirt_shading":
			color_string = "7F0000";
			break;
			
		case "color_overalls_main":
			color_string = "0000FF";
			break;
		case "color_overalls_shading":
			color_string = "00007F";
			break;
			
		case "color_gloves_main":
			color_string = "FFFFFF";
			break;
		case "color_gloves_shading":
			color_string = "7F7F7F";
			break;
			
		case "color_shoes_main":
			color_string = "721C0E";
			break;
		case "color_shoes_shading":
			color_string = "390E07";
			break;
			
		case "color_skin_main":
			color_string = "FEC179";
			break;
		case "color_skin_shading":
			color_string = "7F603C";
			break;
			
		case "color_hair_main":
			color_string = "730600";
			break;
		case "color_hair_shading":
			color_string = "390300";
			break;
	}
	keyboard_string = color_string;
}

save = true;

shake = 0