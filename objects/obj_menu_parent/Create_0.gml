/// @desc Some shared functions

// The options
options = []

// Current option
selected_option = 0;

// Whether if an option is selected or not.
selected = 0;

// The selection y
select_y = 0

// Offset of the menu
scroll_offset = [0];
scroll_offset_view = [0];

// The screen offsets
y_offset = room_height;
move = 1;

// Shake
shake = 0;
h_shake = 0;

// Change which option is selected
change_selected_option = function(total_options, items_per_page, can_be_changed, page_id, indicator_offset = 0) {
	
	var _ver_movement = can_be_changed ? input_check_pressed(input.down) - input_check_pressed(input.up) : 0;
	var _long_ver_movement = wait(3)*(can_be_changed ? input_check_long(input.down) - input_check_long(input.up) : 0);
	var _movement = _ver_movement + _long_ver_movement;
	var _original_option = selected_option;
	selected_option = (selected_option +_movement) % total_options;
	if (selected_option < 0) {
		selected_option = total_options - 1;
	}
	
	if (_movement <> 0 && selected_option != _original_option)
		sfx_play(snd_move);
		
	var _page_idx = page_id + 2;
	var _target = (array_length(scroll_offset) > _page_idx) ? scroll_offset[_page_idx] : 0;
	var _max_target = max(0, total_options - items_per_page - 2);

	var _scroll_margin_top = 2;
	var _scroll_margin_bottom = 0;
	
	var _cap = max(0, items_per_page - 1);
	var _top_margin = min(_scroll_margin_top, _cap);
	var _bottom_margin = min(_scroll_margin_bottom, _cap);
	var _bottom_trigger = _target + (items_per_page - 1) - _bottom_margin;
	var _top_trigger = _target + _top_margin;
	if (selected_option > _bottom_trigger && _target < _max_target)
		_target += 1;
	if (selected_option < _top_trigger && _target > 0)
		_target -= 1;

	_target = clamp(_target, 0, _max_target);

	scroll_offset[_page_idx] = _target;

	var _view = (array_length(scroll_offset_view) > _page_idx) ? scroll_offset_view[_page_idx] : 0;
	_view += clamp(lerp(_view, _target, 0.375) - _view, -2, 2);
	scroll_offset_view[_page_idx] = _view;

	select_y += clamp(lerp(select_y, (selected_option-_view-indicator_offset)*20, 0.375)-select_y, -32, 32);
	
	return _movement;
}

slide_in = function() {
	
	y_offset = lerp(y_offset, 0, 0.25);
	
	if (round(y_offset) <= 0) {
		
		y_offset = 0
		move = 0
	}	
}

// Back to the main menu
go_back = function() {
	
	if (input_check_pressed(input.back)) {
		
		if (selected) {
			revert_changes();
			selected = 0;
			sfx_play(snd_cancel);
		}
		else {
			move = 2;
			sfx_play(snd_cancel);
		}
	}
}

revert_changes = function() {
	// sorry nothing
}

add_shake = function(hovered, shake_amount) {
	if (hovered && shake_amount > 0)
		return sin(current_frames)*shake_amount;
	else
		return 0;
}