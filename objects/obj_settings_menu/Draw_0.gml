/// @desc Drawing the stuff

var _options_per_page = get_options_per_page();

d3d_transform_set_translation(0, y_offset, 0);

draw_set_color(COLOR_BLACK)
draw_set_alpha(0.625)
//draw_rectangle(0, 16, room_width-1, 51, 0)
draw_rectangle(BOX_SPACING, 64, room_width-BOX_SPACING-1, room_height-92, 0)
draw_rectangle(box_width, room_height-83, room_width-box_width-1, room_height-box_height-1, 0)
draw_set_alpha(1)
draw_set_color(c_white)

for (var _current_category=-1; _current_category<global.category_count; _current_category++) {
	
	var _offset = _current_category-x_go;
	var _x_offset = _offset*room_width;

	if (round(_x_offset+room_width/2) < room_width && round(_x_offset+room_width/2) > -room_width) {
	
		// Get the stuff
		
		var _total_options;
		
		if (_current_category < 0) {
			_total_options = array_length(options)+1;
		
			draw_letters(_x_offset+room_width/2, 30, "PRESETS", 1.5);
			
			var _category = -1;
		}
		else {
		
			var _category = global.categories[_current_category];
		
			_total_options = array_length(_category.items);
			var _option = _category.items[min(selected_option, _total_options-1)];
	
			// Category title
			draw_letters(_x_offset+room_width/2, 30, _category.title, 1.5);
		}
	
		if (_current_category != -1) {
			draw_text_custom(_x_offset+room_width/2-160-abs(sin(arrow_frames/32))*8, 24, "<", 1.5)
		}
		if (_current_category != global.category_count-1) {
			draw_text_custom(_x_offset+room_width/2+160+abs(sin(arrow_frames/32))*8, 24, ">", 1.5)
		}
	
		var _alpha = 1-abs(_x_offset)/room_width;

		// If the category isn't empty
		if (_total_options > 0) {
	
			// Highlight the selected item.
			var _selected_item = global.categories[max(0, selected_category)].items[selected_option];
			if (_selected_item.type == option_type.color) {
				
				draw_set_color(_selected_item.state[0])
				if (selected)
					draw_set_alpha(_alpha/2);
				else
					draw_set_alpha(_alpha);
			}
			else {
				
				draw_set_color(COLOR_YELLOW)
				if (selected)
					draw_set_alpha(_alpha/3);
				else
					draw_set_alpha((sin(current_frames/16)/24+0.625)*_alpha);
			}
			draw_rectangle(BOX_SPACING+8, clamp(74 + select_y, 72, room_height-100), room_width-BOX_SPACING-9, clamp(90 + select_y, 72, room_height-100), 0)
			draw_set_alpha(_alpha);
	
			// Items
			for (var i=scroll_offset; i<min(_total_options, scroll_offset+_options_per_page); i++) {
				
				var _hovered = i == selected_option;
				var _x_pos = room_width/2 + add_shake(_hovered, h_shake);
				var _y_pos = (i-scroll_offset)*20 + add_shake(_hovered, shake);
				
				if (_current_category < 0) {
					
					if (i == _total_options-1) {
						
						if (selected)
							draw_option(_x_pos, 72 + _y_pos, keyboard_string + ((current_frames/32)%2 ? "_" : " "), 1.5);
						else
							draw_option(_x_pos, 72 + _y_pos, "✔[Add New Preset] ", 1.5);
					}
					else {
						
						var _name = filename_change_ext(filename_name(options[i]), "");
						var _name_lower = string_lower(_name);
						draw_option(_x_pos, 72 + _y_pos, (_name_lower == "recommended" || _name_lower == "vanilla" || _name_lower == "modern") ? _name : ("❓" + _name + " "), 1.5);
					}
				}
				else {
					
					var _str;
					if (selected && _hovered
                        && _category.items[i].type != option_type.color
                        && _category.items[i].type != option_type.controller_button) {
                            
                            var _item = _category.items[i];
                            var _text = get_option_text(_item);
                            var _limit = get_option_limit(_item)
                            
                            switch (_limit) {
                                case option_limit.both:
						            _str = "⬛<⬜" + _text + "⬛> ";
                                    break;
                                case option_limit.left:
						            _str = "⬛<⬜" + _text + "   ";
                                    break;
                                case option_limit.right:
						            _str = "   " + _text + "⬛> ";
                                    break;
                                case option_limit.none:
						            _str = _text;
                                    break;
                            }
                            
                        }
					else
						_str = get_option_text(_category.items[i]);
						
					// Draw the option itself!
					var _enabled_by = _category.items[i].enabled_by;
					var _disabled_by = _category.items[i].disabled_by;
					var _is_enabled = (_enabled_by < 0 || !is_numeric(_category.items[_enabled_by].state) || _category.items[_enabled_by].state > 0) &&
						(_disabled_by < 0 || !is_numeric(_category.items[_disabled_by].state) || _category.items[_disabled_by].state <= 0)
					
					draw_option(_x_pos, 72 + _y_pos, _str, 1.5, _is_enabled);
				}
			}
			
			if (_total_options-scroll_offset > _options_per_page)
				draw_option(room_width/2, 72 + _options_per_page*20 - 4 + sin(arrow_frames/16), "v", 1.5);

			// Description
			if (_current_category < 0) {
				draw_text_custom(room_width/2, room_height-75, "Here you can save or load your settings as presets.", 1.5)
			}
			else {
				var _description = _option.description;
				if (string_height_ext(_description, 12, room_width/1.5-32) > 36)
					draw_text_custom(room_width/2, room_height-71, _description, 1)
				else
					draw_text_custom(room_width/2, room_height-75, _description, 1.5)
			}
			draw_set_alpha(1);
		}
	}
}

d3d_transform_set_identity()

draw_set_alpha(fade*0.75);
draw_rectangle(0, 0, room_width, room_height, 0);
draw_set_alpha(1);