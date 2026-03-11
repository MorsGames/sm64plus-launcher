enum sdl_controller_button {
    a = 0,
    b = 1,
    x = 2,
    y = 3,
    select = 4,
    start = 5,
    guide = 6,
    lstick = 7,
    rstick = 8,
    l = 9,
    r = 10,
    dup = 11,
    ddown = 12,
    dleft = 13,
    dright = 14,
    zl = 15,
    zr = 16,
    stickll = 17,
    sticklr = 18,
    sticklu = 19,
    stickld = 20,
    stickrl = 21,
    stickrr = 22,
    stickru = 23,
    stickrd = 24,
    any = 25
}

enum sdl_controller_axis {
    left_x = 0,
    left_y = 1,
    right_x = 2,
    right_y = 3,
    trigger_l = 4,
    trigger_r = 5
}

function controller_init_bindings() {
    if (CURRENT_OS == os_windows) {
        var _lib = "lib64Plus.dll";
    }
    else {
        var _lib = ARM ? "lib64Plus_arm64.so" : "lib64Plus_x64.so";
    }

    global.__controller_init = external_define(_lib, "controller_init", dll_cdecl, ty_real, 1, ty_real);
    global.__controller_shutdown = external_define(_lib, "controller_shutdown", dll_cdecl, ty_real, 0);
    global.__controller_poll = external_define(_lib, "controller_poll", dll_cdecl, ty_real, 0);
    global.__controller_get_button = external_define(_lib, "controller_get_button", dll_cdecl, ty_real, 1, ty_real);
    global.__controller_get_axis = external_define(_lib, "controller_get_axis", dll_cdecl, ty_real, 1, ty_real);
    global.__controller_get_name = external_define(_lib, "controller_get_name", dll_cdecl, ty_string, 0);
    global.__display_mode_get_display_count = external_define(_lib, "display_mode_get_display_count", dll_cdecl, ty_real, 0);
    global.__display_mode_get_count = external_define(_lib, "display_mode_get_count", dll_cdecl, ty_real, 1, ty_real);
    global.__display_mode_get_value = external_define(_lib, "display_mode_get_value", dll_cdecl, ty_string, 2, ty_real, ty_real);
}

function controller_init_sdl(allow_non_xinput) {
    return external_call(global.__controller_init, allow_non_xinput);
}

function controller_shutdown_sdl() {
    return external_call(global.__controller_shutdown);
}

function controller_poll_sdl() {
    return external_call(global.__controller_poll);
}

function controller_button_value_sdl(btn_id) {
    return external_call(global.__controller_get_button, btn_id);
}

function controller_axis_value_sdl(axis_id) {
    return external_call(global.__controller_get_axis, axis_id);
}

function controller_get_name_sdl() {
    return external_call(global.__controller_get_name);
}

function display_mode_get_display_count_sdl() {
    return external_call(global.__display_mode_get_display_count);
}

function display_mode_get_count_sdl(display_index) {
    return external_call(global.__display_mode_get_count, display_index);
}

function display_mode_get_value_sdl(display_index, mode_index) {
    return external_call(global.__display_mode_get_value, display_index, mode_index);
}
