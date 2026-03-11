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

enum input {
    left,
    right,
    up,
    down,
    left2,
    right2,
    up2,
    down2,
    page_left,
    page_right,
    select,
    select2,
    back,
    del,
    del2,
    any
}

global.key_names = ["Esc", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=", "Backspace", "Tab", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "[", "]", "Enter", "Ctrl (Left)", "A", "S", "D", "F", "G", "H", "J", "K", "L", ";", "'", "`", "Shift (Left)", "\\", "Z", "X", "C", "V", "B", "N", "M", ",", ".", "/", "Shift (Right)", "* (Numpad)", "Alt (Left)", "Space", "Caps Lock", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "Num Lock", "Scroll Lock", "7 (Numpad)", "8 (Numpad)", "9 (Numpad)", "- (Numpad)", "4 (Numpad)", "5 (Numpad)", "6 (Numpad)", "+ (Numpad)", "1 (Numpad)", "2 (Numpad)", "3 (Numpad)", "0 (Numpad)", ". (Numpad)", "F11", "F12", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "= (Numpad)", "^", "@", ":", "_", "Unknown", "Unknown", "Unknown", "Unknown", "Enter (Numpad)", "Ctrl (Right)", ", (Numpad)", "/ (Numpad)", "Unknown", "Alt (Right)", "Pause", "Home", "Up (Numpad)", "Page Up", "Left (Numpad)", "Right (Numpad)", "End", "Down (Numpad)", "Page Down", "Insert", "Delete", "Windows", "Windows (Right)"];

function ControllerType(_a, _b, _x, _y, _start, _guide, _select, _lstick, _rstick, _l, _r, _dup, _ddown, _dleft, _dright, _zl, _zr, _select_button = sdl_controller_button.a, _back_button = sdl_controller_button.b) constructor {
    a = _a;
    b = _b;
    x = _x;
    y = _y;
    start = _start;
    guide = _guide;
    select = _select;
    lstick = _lstick;
    rstick = _rstick;
    l = _l;
    r = _r;
    dup = _dup;
    ddown = _ddown;
    dleft = _dleft;
    dright = _dright;
    zl = _zl;
    zr = _zr;
    select_button = _select_button;
    back_button = _back_button;
}

global.controller_type = 0;
global.controller_types = [

    // XInput
    new ControllerType(
        "A", 
        "B", 
        "X", 
        "Y", 
        "Start", 
        "Guide", 
        "Select", 
        "Left Stick Press", 
        "Right Stick Press", 
        "Left Shoulder",
        "Right Shoulder",
        "D-Pad Up",
        "D-Pad Down", 
        "D-Pad Left", 
        "D-Pad Right", 
        "Left Trigger", 
        "Right Trigger"),

    // Switch N64
    new ControllerType(
        "B", 
        "A", 
        "C-Left", 
        "C-Up", 
        "Start", 
        "Home", 
        "C-Right", 
        "ZR", 
        "C-Down", 
        "L", 
        "R", 
        "D-Pad Up", 
        "D-Pad Down", 
        "D-Pad Left", 
        "D-Pad Right", 
        "Z", 
        "C-Down",
        sdl_controller_button.b,
        sdl_controller_button.a),

    // 8BitDo 64
    new ControllerType(
        "A", 
        "B", 
        "Unknown 1", 
        "Unknown 2", 
        "Start", 
        "Heart", 
        "Select", 
        "Stick Press", 
        "Unknown 3", 
        "L", 
        "R", 
        "D-Pad Up", 
        "D-Pad Down", 
        "D-Pad Left", 
        "D-Pad Right", 
        "Left Z", 
        "Right Z",
        sdl_controller_button.b,
        sdl_controller_button.a)
];

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
    
    controller_init_bindings()
    controller_init_sdl(1)
    
    input_action_add(input.left, vk_left, sdl_controller_button.dleft)
    input_action_add(input.right, vk_right, sdl_controller_button.dright)
    input_action_add(input.up, vk_up, sdl_controller_button.dup)
    input_action_add(input.down, vk_down, sdl_controller_button.ddown)
    
    input_action_add(input.left2, ord("A"), sdl_controller_button.stickll)
    input_action_add(input.right2, ord("D"), sdl_controller_button.sticklr)
    input_action_add(input.up2, ord("W"), sdl_controller_button.sticklu)
    input_action_add(input.down2, ord("S"), sdl_controller_button.stickld)
    
    input_action_add(input.page_left, -2, sdl_controller_button.l)
    input_action_add(input.page_right, -2, sdl_controller_button.r)
    
    input_action_add(input.select, vk_space, sdl_controller_button.a) // Gets remapped later
    input_action_add(input.select2, vk_enter, sdl_controller_button.start)
    input_action_add(input.back, CURRENT_OS == os_windows ? vk_escape : vk_backspace, sdl_controller_button.b) // Gets remapped later
    input_action_add(input.del, CURRENT_OS == os_windows ? vk_backspace : vk_delete, sdl_controller_button.select)
    input_action_add(input.del2, vk_delete, sdl_controller_button.select)
    
    input_action_add(input.any, vk_anykey, sdl_controller_button.any)
    
    input_action_link(input.left2, input.left)
    input_action_link(input.right2, input.right)
    input_action_link(input.up2, input.up)
    input_action_link(input.down2, input.down)
    
    input_action_link(input.select2, input.select)
    input_action_link(input.del2, input.del)

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
    
    controller_poll_sdl();
    
    var _controller_name = controller_get_name_sdl();
    var _new_type = 0;
    if (_controller_name == "Nintendo N64 Controller") {
        _new_type = 1;
    } else if (_controller_name == "8BitDo 64") {
        _new_type = 2;
    }
    
    if (_new_type != global.controller_type) {
        global.controller_type = _new_type;
        var _type = global.controller_types[global.controller_type];
        input_action_remap(input.select, vk_space, _type.select_button)
        input_action_remap(input.back, CURRENT_OS == os_windows ? vk_escape : vk_backspace, _type.back_button)
    }

    var _action_index = ds_map_find_first(global.__action_map)
    for (var i = 0; i < ds_map_size(global.__action_map); i++) {
        var _pressed = 0, _held = 0, _released = 0, _gb = 0, _gb_pressed = 0, _gb_released = 0;
        var _action = ds_map_find_value(global.__action_map, _action_index);
        
        _gb = controller_button_value_sdl(_action.gb);
        
        if (_gb != global.__gb_last[_action_index]) {
            _gb_pressed = _gb;
            _gb_released = global.__gb_last[_action_index];
        }
        global.__gb_last[_action_index] = _gb;
        
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
/// @func input_system_async()
/// @desc Changes the input type if a gamepad is connected or disconnected. Should be running at the Async System event.
    }
}

/// @func input_system_async()
/// @desc Changes the input type if a gamepad is connected or disconnected. Should be running at the Async System event.
function input_system_async() {
    switch (async_load[?"event_type"]) {
        case "gamepad discovered":
            global.__input_type = __device_type.gamepad;
/// @func input_action_get_name(action_index, brackets[OPTIONAL])
/// @desc Returns the name of an action, based on the active input type's naming scheme.
/// @param {real} action_index Index of the action.
/// @param {real} brackets[OPTIONAL] Wrap the returned string with round or angle brackets depending on the input type. Defaults to 0.
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
/// @func keyboard_get_key_name(key_index)
/// @desc Returns the name of a keyboard input.
/// @param {keyboard_key} key_index Index of the keyboard input.
/// @returns {string} Name of the keyboard input.
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
/// @desc Returns the name of a keyboard input.
/// @param {keyboard_key} key_index Index of the keyboard input.
/// @returns {string} Name of the keyboard input.
function keyboard_get_key_name(key_index) {
    if (key_index > 64 && key_index < 127) {
        return chr(key_index);
    }
    switch (key_index) {
        case vk_shift: return "Shift (Left)";
        case vk_control: return "Ctrl (Left)";
        case vk_alt: return "Alt (Left)";
        case vk_tab: return "Tab";
        case vk_backspace: return "Backspace";
        case vk_enter: return "Enter";
        case vk_space: return "Space";
        case vk_escape: return "Esc";
        case vk_delete: return "Delete";
        case vk_insert: return "Insert";
        case vk_end: return "End";
        case vk_home: return "Home";
        case vk_pageup: return "Page Up";
        case vk_pagedown: return "Page Down";
        case vk_up: return "Up";
        case vk_down: return "Down";
        case vk_left: return "Left";
        case vk_right: return "Right";
/// @func keyboard_get_scan_name(scan_code)
/// @desc Returns the name of a keyboard key based on its scan code.
/// @param {real} scan_code Scan code of the keyboard input.
/// @returns {string} Name of the keyboard input.
        case vk_numpad0: return "0 (Numpad)";
        case vk_numpad1: return "1 (Numpad)";
        case vk_numpad2: return "2 (Numpad)";
        case vk_numpad3: return "3 (Numpad)";
        case vk_numpad4: return "4 (Numpad)";
        case vk_numpad5: return "5 (Numpad)";
        case vk_numpad6: return "6 (Numpad)";
        case vk_numpad7: return "7 (Numpad)";
/// @func gamepad_get_button_name(button_index)
/// @desc Returns the name of a gamepad button.
/// @param {gamepad_button} button_index Index of the gamepad button.
/// @returns {string} Name of the gamepad button.
        case vk_numpad8: return "8 (Numpad)";
        case vk_numpad9: return "9 (Numpad)";
        case vk_add: return "+ (Numpad)";
        case vk_subtract: return "- (Numpad)";
        case vk_divide: return "/ (Numpad)";
        case vk_multiply: return "* (Numpad)";
        case vk_lalt: return "Alt (Left)";
        case vk_lcontrol: return "Ctrl (Left)";
        case vk_ralt: return "Alt (Right)";
        case vk_rcontrol: return "Ctrl (Right)";
        case vk_anykey: return "ANY KEY";
        default: return "";
    }
}

/// @func keyboard_get_scan_name(scan_code)
/// @desc Returns the name of a keyboard key based on its scan code.
/// @param {real} scan_code Scan code of the keyboard input.
/// @returns {string} Name of the keyboard input.
function keyboard_get_scan_name(scan_code) {
    if (scan_code == 0) return "None";
    if (scan_code == 328) return "Up";
    if (scan_code == 336) return "Down";
    if (scan_code == 331) return "Left";
    if (scan_code == 333) return "Right";
    if (scan_code > 0 && scan_code <= array_length(global.key_names)) {
        return global.key_names[scan_code - 1];
    }
    return "Unknown";
}

/// @func gamepad_get_button_name(button_index)
/// @desc Returns the name of a gamepad button.
/// @param {gamepad_button} button_index Index of the gamepad button.
/// @returns {string} Name of the gamepad button.
function gamepad_get_button_name(button_index) {
    var _names = global.controller_types[global.controller_type];
    switch (button_index) {
        case sdl_controller_button.a: return _names.a;
        case sdl_controller_button.b: return _names.b;
        case sdl_controller_button.x: return _names.x;
        case sdl_controller_button.y: return _names.y;
        case sdl_controller_button.l: return _names.l;
        case sdl_controller_button.zl: return _names.zl;
        case sdl_controller_button.r: return _names.r;
        case sdl_controller_button.zr: return _names.zr;
        case sdl_controller_button.select: return _names.select;
        case sdl_controller_button.start: return _names.start;
        case sdl_controller_button.guide: return _names.guide;
        case sdl_controller_button.lstick: return _names.lstick;
        case sdl_controller_button.rstick: return _names.rstick;
        case sdl_controller_button.dup: return _names.dup;
        case sdl_controller_button.ddown: return _names.ddown;
        case sdl_controller_button.dleft: return _names.dleft;
        case sdl_controller_button.dright: return _names.dright;
        case sdl_controller_button.sticklu: return "LEFT STICK UP";
        case sdl_controller_button.stickld: return "LEFT STICK DOWN";
        case sdl_controller_button.stickll: return "LEFT STICK LEFT";
        case sdl_controller_button.sticklr: return "LEFT STICK RIGHT";
        case sdl_controller_button.stickru: return "RIGHT STICK UP";
        case sdl_controller_button.stickrd: return "RIGHT STICK DOWN";
        case sdl_controller_button.stickrl: return "RIGHT STICK LEFT";
        case sdl_controller_button.stickrr: return "RIGHT STICK RIGHT";
        case sdl_controller_button.any: return "ANY";
        default: return "";
    }
}