/// @desc Drawing the stuff

var _options_per_page = get_options_per_page();

d3d_transform_set_translation(0, y_offset, 0);

draw_set_color(COLOR_BLACK)
draw_set_alpha(0.625)
//draw_rectangle(0, 16, room_width-1, 51, 0)
draw_rectangle(BOX_SPACING, 64, room_width-BOX_SPACING-1, room_height-92, 0)
draw_rectangle(8, room_height-83, room_width-8-1, room_height-8-1, 0)
draw_set_alpha(1)
draw_set_color(c_white)

for (var _tab_index=0; _tab_index<tab_count; _tab_index++) {
	
	var _id = section_category_indices[_tab_index];
	var _offset = _tab_index-x_go;
	var _x_offset = _offset*room_width;

	if (round(_x_offset+room_width/2) < room_width && round(_x_offset+room_width/2) > -room_width) {
	
		// Get the stuff
		
		var _total_options;
		var _title_x = _x_offset+room_width/2 + add_shake(true, title_h_shake);
		
		if (_id == -1) {
			_total_options = array_length(options)+1;
			draw_letters(_title_x, 30, "PRESETS", 1.5);
		}
		else if (_id == -2) {
			_total_options = array_length(input_options)+1;
			draw_letters(_title_x, 30, "INPUT PRESETS", 1.5);
		}
		else {
			var _category = _id == -3 ? global.launcher_category : global.categories[_id];
			_total_options = array_length(_category.items);
	
			// Category title
			draw_letters(_title_x, 30, _category.title, 1.5);
		}
	
		if (_tab_index != 0) {
			draw_text_custom(_title_x-160-abs(sin(arrow_frames/32))*8, 24, "<", 1.5)
		}
		if (_tab_index != tab_count-1) {
			draw_text_custom(_title_x+160+abs(sin(arrow_frames/32))*8, 24, ">", 1.5)
		}
	
		var _alpha = 1-abs(_x_offset)/room_width;

		// If the category isn't empty
		if (_total_options > 0) {
	
			var _selected_id = section_category_indices[selected_tab];
			if (_selected_id >= 0 || _selected_id == -3) {
				var _cat = (_selected_id == -3) ? global.launcher_category : global.categories[_selected_id];
				var _n = array_length(_cat.items);
				var _selected_item = _cat.items[min(selected_option, _n - 1)];
				var _target_color = (_selected_item.type == option_type.color) ? _selected_item.state[0] : COLOR_YELLOW;
				selected_highlight_color = merge_color(selected_highlight_color, _target_color, 0.25);
				draw_set_color(selected_highlight_color)
				var _target_alpha;
				if (_selected_item.type == option_type.color) {
					_target_alpha = selected ? 0.5 : 1;
				} else {
					_target_alpha = selected ? (1/3) : (sin(current_frames/16)/16+0.5625);
				}
				selected_highlight_alpha = lerp(selected_highlight_alpha, _target_alpha, 0.5);
				draw_set_alpha(selected_highlight_alpha);
				draw_rectangle(BOX_SPACING+8, clamp(74 + select_y, 72, room_height-100), room_width-BOX_SPACING-9, clamp(90 + select_y, 72, room_height-100), 0)
				draw_set_alpha(_alpha);
			}
			else {
				selected_highlight_color = merge_color(selected_highlight_color, COLOR_YELLOW, 0.25);
				draw_set_color(selected_highlight_color);
				var _target_alpha = selected ? (1/3) : (sin(current_frames/16)/16+0.5625);
				selected_highlight_alpha = lerp(selected_highlight_alpha, _target_alpha, 0.5);
				draw_set_alpha(selected_highlight_alpha);
				draw_rectangle(BOX_SPACING+8, clamp(74 + select_y, 72, room_height-100), room_width-BOX_SPACING-9, clamp(90 + select_y, 72, room_height-100), 0)
				draw_set_alpha(_alpha);
			}
	
			// Items
			var _page_idx_draw = _tab_index;
			var _view = scroll_offset_view[_page_idx_draw];

			var _list_top = 72 - 20;
			var _list_bottom = 72 + _options_per_page*20;
			var _fade_band = 20;

			for (var i=floor(_view); i<min(_total_options, ceil(_view)+_options_per_page); i++) {
				
				var _hovered = i == selected_option;
				var _x_pos = room_width/2 + add_shake(_hovered, h_shake);
				var _y_pos = (i-_view)*20 + add_shake(_hovered, shake);

				var _abs_y = 72 + (i-_view)*20;
				var _top_a = clamp((_abs_y - _list_top) / _fade_band, 0, 1);
				var _bot_a = clamp((_list_bottom - _abs_y) / _fade_band, 0, 1);
				var _edge_alpha = min(_top_a, _bot_a);
				draw_set_alpha(_alpha * _edge_alpha);
				
				if (_id == -1 || _id == -2) {
					
					if (i == _total_options-1) {
						
						if (selected)
							draw_option(_x_pos, 72 + _y_pos, keyboard_string + ((current_frames/32)%2 ? "_" : " "), 1.5);
						else
							draw_option(_x_pos, 72 + _y_pos, "✔[Add New Preset] ", 1.5);
					}
					else {
						var _options_array = _id == -1 ? options : input_options;
						var _internal_path = _id == -1 ? INTERNAL_PRESETS_PATH : INTERNAL_INPUT_PRESETS_PATH;
						var _path = _options_array[i].path;
						var _name = filename_change_ext(filename_name(_path), "");
						var _is_internal = string_pos(_internal_path, _path) > 0;
						draw_option(_x_pos, 72 + _y_pos, _is_internal ? _name : ("❓" + _name + " "), 1.5);
					}
				}
				else {
					var _category = _id == -3 ? global.launcher_category : global.categories[_id];
					var _str;
					if (selected && _hovered
                        && _category.items[i].type != option_type.color
                        && _category.items[i].type != option_type.controller_button) {
                            
                            var _item = _category.items[i];
                            var _text = get_option_text(_item, _category);
                            var _limit = get_option_limit(_item, _category)
                            
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
						_str = get_option_text(_category.items[i], _category);
						
					// Draw the option itself!
					var _enabled_by = _category.items[i].enabled_by;
					var _disabled_by = _category.items[i].disabled_by;
					var _is_enabled = (_enabled_by < 0 || !is_numeric(_category.items[_enabled_by].state) || _category.items[_enabled_by].state > 0) &&
						(_disabled_by < 0 || !is_numeric(_category.items[_disabled_by].state) || _category.items[_disabled_by].state <= 0)
					
					draw_option(_x_pos, 72 + _y_pos, _str, 1.5, _is_enabled);
				}
			}
			draw_set_alpha(_alpha);

			if (_total_options-round(_view) > _options_per_page)
				draw_option(room_width/2, 72 + _options_per_page*20 - 4 + sin(arrow_frames/16), "\u007F", 1.5);

			// Description
			var _description = "";
			if (_id == -1 || _id == -2) {
				var _options_array = _id == -1 ? options : input_options;
				if (selected_option < array_length(_options_array)) {
					_description = _options_array[selected_option].description;
				}
				
				if (_description == "") {
					_description = (_id == -1) ? "Here you can save or load your settings as presets." : "Here you can save or load your input mappings as presets.";
				}
			}
			else {
				var _category = _id == -3 ? global.launcher_category : global.categories[_id];
				var _option = _category.items[min(selected_option, _total_options-1)];
				_description = _option.description;
			}

			if (string_height_ext(_description, 12, room_width/1.5-32) > 36)
				draw_text_custom(room_width/2, room_height-71, _description, 1)
			else
				draw_text_custom(room_width/2, room_height-75, _description, 1.5)
			draw_set_alpha(1);
		}
	}
}

d3d_transform_set_identity()

draw_set_alpha(fade*0.75);
draw_rectangle(0, 0, room_width, room_height, 0);
draw_set_alpha(1);
