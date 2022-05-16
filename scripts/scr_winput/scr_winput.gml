// wInput Lite by Mors
// http://www.mors-games.com/

// A heavily cut down and modified version of wInput, made exclusively for a few of my projects.

// There's no license. Go home.
 
#macro __WINPUT_VERSION "1.0.3"

show_debug_message("wInput Lite v" + __WINPUT_VERSION + " by Mors");

#macro gp_stickll 100
#macro gp_sticklr 101
#macro gp_sticklu 102
#macro gp_stickld 103
#macro gp_stickrl 104
#macro gp_stickrr 105
#macro gp_stickru 106
#macro gp_stickrd 107
#macro gp_anybutton 108

enum __check_type {
	pressed,
	held,
	released,
	hold_time,
	size
}

enum __device_type {
	keyboard,
	gamepad
}

function __create_input_states() {
	global.__input_state = ds_grid_create(__check_type.size, global.__action_size);
	for (var j = 0; j < global.__action_size; j++) {
		global.__gb_last[j] = 0;
	}
}

function __input_system_clear(reset_inputs_only) {
	if (!reset_inputs_only) {
		ds_grid_clear(global.__input_state, 0);
		global.__last_pressed = -1;
	}
	for (var j2 = 0; j2 < global.__action_size; j2++) {
		if (reset_inputs_only) {
		    for (var j = 0; j < __check_type.size; j++) {
				if (j != __check_type.hold_time) {
		    		global.__input_state[# j, j2] = 0;
				}
		    }
		}
	}
}

/// @func input_check(action_index)
/// @desc Returns true if the given action is currently held down.
/// @param {real} action_index Index of the action that should be checked.
/// @returns {bool} If the action is currently held down.
function input_check(action_index) {
	gml_pragma("forceinline");
	return global.__input_state[# __check_type.held, action_index];
}

/// @func input_check_pressed(action_index)
/// @desc Returns true if the given action has just been pressed.
/// @param {real} action_index Index of the action that should be checked.
/// @returns {bool} If the action has just been pressed.
function input_check_pressed(action_index) {
	gml_pragma("forceinline");
	return global.__input_state[# __check_type.pressed, action_index];
}

/// @func keyboard_check_released(action_index)
/// @desc Returns true if the given action has just been released.
/// @param {real} action_index Index of the action that should be checked.
/// @returns {bool} If the action has just been released or not.
function input_check_released(action_index) {
	gml_pragma("forceinline");
	return global.__input_state[# __check_type.released, action_index];
}

/// @func input_check_long(action_index)
/// @desc Returns true if the given action was held down for a certain amount of time.
/// @param {real} action_index Index of the action that should be checked.
/// @returns {bool} If the action was held down for a certain amount of time.
function input_check_long(action_index) {
	gml_pragma("forceinline");
	return global.__input_state[# __check_type.held, action_index] && (global.__input_state[# __check_type.hold_time, action_index] >= global.__long_press_threshold);
}

/// @func input_check_hold_time(action_index)
/// @desc Returns how long the given action was held down for.
/// @param {real} action_index Index of the action that should be checked.
/// @returns {bool} How long the given action was held down for, in frames.
function input_check_hold_time(action_index) {
	gml_pragma("forceinline");
	return global.__input_state[# __check_type.hold_time, action_index];
}

/// @func input_get_last_pressed()
/// @desc Gets the last pressed action's index.
/// @returns {real} The last pressed action's index.
function input_get_last_pressed() {
	gml_pragma("forceinline");
	return global.__last_pressed;
}

/// @func input_get_type()
/// @desc Gets the last pressed action's type.
function input_get_type() {
	gml_pragma("forceinline");
	return global.__input_type;
}

/// @func input_action_add(action_index, keyboard_key[OPTIONAL], gamepad_button[OPTIONAL])
/// @desc Add a new action to the input system.
/// @param {real} action_index The index used to identify this action. Using an enum is recommended.
/// @param {keyboard_key} keyboard_key[OPTIONAL] The keyboard key mapped to the action.
/// @param {gamepad_button} gamepad_button[OPTIONAL] The gamepad_button mapped to the action.
function input_action_add(action_index) {
	var _keyboard_key = noone;
	var _gamepad_button = noone;
	if (argument_count > 1)
		_keyboard_key = argument[1];
	if (argument_count > 2)
		_gamepad_button = argument[2];
	ds_map_add(global.__action_map, action_index, {
		kk: _keyboard_key,
		gb: _gamepad_button
	});
	global.__action_size++;
}

/// @func input_action_remap(action_index, keyboard_key[OPTIONAL], gamepad_button[OPTIONAL])
/// @desc Changes the inputs for an already existing action.
/// @param {real} action_index The index used to identify this action. Using an enum is recommended.
/// @param {keyboard_key} keyboard_key[OPTIONAL] The keyboard key mapped to the action.
/// @param {gamepad_button} gamepad_button[OPTIONAL] The gamepad_button mapped to the action.
function input_action_remap(action_index) {
	var _keyboard_key = noone;
	var _gamepad_button = noone;
	if (argument_count > 1)
		_keyboard_key = argument[1];
	if (argument_count > 2)
		_gamepad_button = argument[2];
	ds_map_replace(global.__action_map, action_index, {
		kk: _keyboard_key,
		gb: _gamepad_button
	});
}

/// @func input_action_link(from, to)
/// @desc Links an action to another one, so all the checks for the linked actions return same as the one it's linked to.
/// @param {real} from The action that's going to get linked from.
/// @param {real} to The action that's going to get linked to.
function input_action_link(from, to) {
	global.__action_link[? from] = to;
}

/// @func input_action_get_keyboard_key(action_index)
/// @desc Gets the keyboard key assigned to an action.
/// @param {real} action_index The action we want the keyboard key of.
/// @returns {keyboard_key} The keyboard key that's assigned to this action.
function input_action_get_keyboard_key(action_index)
{
	var _struct = global.__action_map[? action_index];
	if (is_struct(_struct))
		return _struct.kk;
	else
		return -1;
}

/// @func input_action_get_gamepad_button(action_index)
/// @desc Gets the gamepad button assigned to an action.
/// @param {real} action_index The action we want the gamepad button of.
/// @returns {gamepad_button} The gamepad button that's assigned to this action.
function input_action_get_gamepad_button(action_index) {
	return global.__action_map[? action_index].gb
}

/// @func input_system_init()
/// @desc Initializes the input system.
function input_system_init() {
	global.__last_pressed = 0;
	global.__input_type = 0;
	global.__analog_threshold = 0.75;
	global.__long_press_threshold = 20;
	global.__tick_speed = 1;
	global.__action_size = 0;
	global.__action_map = 0;
	global.__action_link = ds_map_create();
	global.__action_map = ds_map_create();
	gamepad_set_axis_deadzone(0, 0.0625);
}

/// @func input_system_start()
/// @desc Starts the input system so the checks can be used.
function input_system_start() {
	__create_input_states();
	__input_system_clear(0);
}

/// @func input_system_destroy()
/// @desc Destroys all the data structures used for the input system.
function input_system_destroy() {
	ds_map_destroy(global.__action_link)
	ds_map_destroy(global.__action_map)
}

/// @func input_system_update()
/// @desc Updates the input system. Should be running at the Begin Step event.
function input_system_update() {
	__input_system_clear(1);
	var _action_index = ds_map_find_first(global.__action_map)
	for (var i = 0; i < ds_map_size(global.__action_map); i++) {
		var _pressed = 0, _held = 0, _released = 0, _gb = 0, _gb_pressed = 0, _gb_released = 0;
		var _action = ds_map_find_value(global.__action_map, _action_index);
		for (var j = 0; j < 3; j++) {
			switch (_action.gb) {
				case gp_stickll:
					_gb |= gamepad_axis_value(j, gp_axislh) < -global.__analog_threshold;
					break;
				case gp_sticklr:
					_gb |= gamepad_axis_value(j, gp_axislh) > global.__analog_threshold;
					break;
				case gp_sticklu:
					_gb |= gamepad_axis_value(j, gp_axislv) < -global.__analog_threshold;
					break;
				case gp_stickld:
					_gb |= gamepad_axis_value(j, gp_axislv) > global.__analog_threshold;
					break;
				case gp_stickrl:
					_gb |= gamepad_axis_value(j, gp_axisrh) < -global.__analog_threshold;
					break;
				case gp_stickrr:
					_gb |= gamepad_axis_value(j, gp_axisrh) > global.__analog_threshold;
					break;
				case gp_stickru:
					_gb |= gamepad_axis_value(j, gp_axisrv) < -global.__analog_threshold;
					break;
				case gp_stickrd:
					_gb |= gamepad_axis_value(j, gp_axisrv) > global.__analog_threshold;
					break;
				case gp_anybutton:
					for (var k = gp_face1; k < gp_axisrv; k++) {
						if (gamepad_button_value(j, k) > global.__analog_threshold
						|| gamepad_axis_value(j, k) > global.__analog_threshold
						|| gamepad_axis_value(j, k) < -global.__analog_threshold) {
							_gb = 2;
						}
					}
					break;
				default:
					_gb |= gamepad_button_value(j, _action.gb) > global.__analog_threshold;
					break;
			}
		}
		if (_gb != global.__gb_last[i]) {
			_gb_pressed = _gb;
			_gb_released = global.__gb_last[i];
		}
		global.__gb_last[i] = _gb;
		
		_pressed = keyboard_check_pressed(_action.kk) || _gb_pressed;
		_held = keyboard_check(_action.kk) || _gb;
		_released = keyboard_check_released(_action.kk) || _gb_released;
		
		global.__input_state[# __check_type.pressed, _action_index] = _pressed;
		global.__input_state[# __check_type.held, _action_index] = _held;
		global.__input_state[# __check_type.released, _action_index] = _released;
		if (_pressed && _action.kk != vk_anykey && _gb != 2) {
			global.__last_pressed = _action_index;
		}
		if (_held) {
			global.__input_state[# __check_type.hold_time, _action_index] += global.__tick_speed;
		}
		if (_released) {
			global.__input_state[# __check_type.hold_time, _action_index] = 0;
		}
		if (_gb_pressed)
			global.__input_type = __device_type.gamepad;
		else if (keyboard_check_pressed(_action.kk))
		|| (mouse_check_button_pressed(mb_any))
			global.__input_type = __device_type.keyboard;
		_action_index = ds_map_find_next(global.__action_map, _action_index);
	}
	var _from = ds_map_find_first(global.__action_link)
	for (var i = 0; i < ds_map_size(global.__action_link); i++) {
		var _to = ds_map_find_value(global.__action_link, _from);
		global.__input_state[# __check_type.pressed, _to] += global.__input_state[# __check_type.pressed, _from];
		global.__input_state[# __check_type.held, _to] += global.__input_state[# __check_type.held, _from];
		global.__input_state[# __check_type.released, _to] += global.__input_state[# __check_type.released, _from];
		if (global.__input_state[# __check_type.held, _from]) {
			global.__input_state[# __check_type.hold_time, _to] = global.__input_state[# __check_type.hold_time, _from];
		}
		if (global.__input_state[# __check_type.released, _from] || global.__input_state[# __check_type.pressed, _to]) {
			global.__input_state[# __check_type.hold_time, _from] = 0;
			global.__input_state[# __check_type.hold_time, _to] = 0;
		}
		_from = ds_map_find_next(global.__action_link, _from);
	}
}

/// @func input_system_async()
/// @desc Changes the input type if a gamepad is connected or disconnected. Should be running at the Async System event.
function input_system_async() {
	switch (async_load[?"event_type"]) {
		case "gamepad discovered":
		    global.__input_type = __device_type.gamepad;
		break;
		case "gamepad lost":
		    global.__input_type = __device_type.keyboard;
		break;
	}
}

/// @func input_action_get_name(action_index, brackets[OPTIONAL])
/// @desc Returns the name of an action, based on the active input type's naming scheme.
/// @param {real} action_index Index of the action.
/// @param {real} brackets[OPTIONAL] Wrap the returned string with round or angle brackets depending on the input type. Defaults to 0.
function input_action_get_name(action_index) {
	var _brackets = 0;
	if (argument_count > 1)
		_brackets = argument[1];
	var _action = global.__action_map[? action_index];
	if (_action == undefined) {
		return "";
	}
	var _string;
	switch (global.__input_type) {
	    case __device_type.gamepad:
			_string = gamepad_get_button_name(_action.gb);
			if (_brackets) {
				_string = "(" + _string + ")";
			}
			break;
	    case __device_type.keyboard:
	        _string = keyboard_get_key_name(_action.kk);
			if (_brackets) {
				_string = "<" + _string + ">";
			}
			break;
	}
	return _string;
}

/// @func keyboard_get_key_name(key_index)
/// @desc Returns the name of a keyboard key.
/// @param {keyboard_key} key_index Index of the keyboard key.
/// @returns {string} Name of the keyboard key.
function keyboard_get_key_name(key_index) {
	if (key_index > 64 && key_index < 127) {
	    return chr(key_index);
	}
	switch (key_index) {
	    case vk_shift:
	        return "SHIFT";
	        break;
	    case vk_control:
	        return "CONTROL";
	        break;
	    case vk_alt:
	        return "ALT";
	        break;
	    case vk_tab:
	        return "TAB";
	        break;
	    case vk_backspace:
	        return "BACKSPACE";
	        break;
		case vk_enter:
	        return "ENTER";
	        break;
	    case vk_space:
	        return "SPACE";
	        break;
	    case vk_escape:
	        return "ESCAPE";
	        break;
	    case vk_delete:
	        return "DELETE";
	        break;
	    case vk_insert:
	        return "INSERT";
	        break;
	    case vk_end:
	        return "END";
	        break;
	    case vk_home:
	        return "HOME";
	        break;
	    case vk_pageup:
	        return "PAGE UP";
	        break;
	    case vk_pagedown:
	        return "PAGE DOWN";
	        break;
	    case vk_up:
	        return "UP";
	        break;
	    case vk_down:
	        return "DOWN";
	        break;
	    case vk_left:
	        return "LEFT";
	        break;
	    case vk_right:
	        return "RIGHT";
	        break;
	    case vk_numpad0:
	        return "NUMPAD 0";
	        break;
	    case vk_numpad1:
	        return "NUMPAD 1";
	        break;
	    case vk_numpad2:
	        return "NUMPAD 2";
	        break;
	    case vk_numpad3:
	        return "NUMPAD 3";
	        break;
	    case vk_numpad4:
	        return "NUMPAD 4";
	        break;
	    case vk_numpad5:
	        return "NUMPAD 5";
	        break;
	    case vk_numpad6:
	        return "NUMPAD 6";
	        break;
	    case vk_numpad7:
	        return "NUMPAD 7";
	        break;
	    case vk_numpad8:
	        return "NUMPAD 8";
	        break;
	    case vk_numpad9:
	        return "NUMPAD 9";
	        break;
	    case vk_add:
	        return "NUMPAD +";
	        break;
	    case vk_subtract:
	        return "NUMPAD -";
	        break;
	    case vk_divide:
	        return "NUMPAD /";
	        break;
	    case vk_multiply:
	        return "NUMPAD *";
	        break;
		case vk_lalt:
	        return "LEFT ALT";
	        break;
	    case vk_lcontrol:
	        return "LEFT CONTROL";
	        break;
	    case vk_ralt:
	        return "RIGHT ALT";
	        break;
	    case vk_rcontrol:
	        return "RIGHT CONTROL";
	        break;
		case vk_anykey:
	        return "ANY KEY";
	        break;
	    default:
	        return "";
	        break;
	}
}

/// @func gamepad_get_button_name(button_index)
/// @desc Returns the name of a gamepad button, based on Xbox naming scheme.
/// @param {gamepad_button} button_index Index of the gamepad button.
/// @returns {string} Name of the gamepad button.
function gamepad_get_button_name(button_index) {
	switch (button_index) {
	    case gp_face1:
		case 32786: // For some reason HTML5 export returns this for gp_face1?
	        return "A";
	        break;
	    case gp_face2:
	        return "B";
	        break;
	    case gp_face3:
	        return "X";
	        break;
	    case gp_face4:
	        return "Y";
	        break;
	    case gp_shoulderl:
	        return "L";
	        break;
		case gp_shoulderlb:
	        return "LT";
	        break;
	    case gp_shoulderr:
	        return "R";
	        break;
	    case gp_shoulderrb:
	        return "RT";
	        break;
	    case gp_select:
	        return "SELECT";
	        break;
	    case gp_start:
	        return "START";
	        break;
	    case gp_stickl:
	        return "LEFT STICK";
	        break;
	    case gp_padu:
	        return "D-PAD UP";
	        break;
	    case gp_padd:
	        return "D-PAD DOWN";
	        break;
	    case gp_padl:
	        return "D-PAD LEFT";
	        break;
	    case gp_padr:
	        return "D-PAD RIGHT";
	        break;
	    case gp_sticklu:
	        return "LEFT STICK UP";
	        break;
	    case gp_stickld:
	        return "LEFT STICK DOWN";
	        break;
	    case gp_stickll:
	        return "LEFT STICK LEFT";
	        break;
	    case gp_sticklr:
	        return "LEFT STICK RIGHT";
	        break;
	    case gp_stickru:
	        return "RIGHT STICK UP";
	        break;
	    case gp_stickrd:
	        return "RIGHT STICK DOWN";
	        break;
	    case gp_stickrl:
	        return "RIGHT STICK LEFT";
	        break;
	    case gp_stickrr:
	        return "RIGHT STICK RIGHT";
	        break;
	    case gp_anybutton:
	        return "ANY";
	        break;
	    default:
	        return "";
	        break;
	}
}