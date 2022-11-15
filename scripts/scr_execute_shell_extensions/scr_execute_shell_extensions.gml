if (CURRENT_OS == os_windows) {
    global.__lib64Plus_execute = external_define("lib64Plus.dll", "execute", dll_cdecl, ty_real, 1, ty_string);
    global.__lib64Plus_execute_wait = external_define("lib64Plus.dll", "execute_wait", dll_cdecl, ty_real, 1, ty_string);
}
else {
    var _library = ARM ? "lib64Plus_arm64.so" : "lib64Plus_x64.so";
    global.__lib64Plus_execute = external_define(_library, "execute", dll_cdecl, ty_real, 1, ty_string);
    global.__lib64Plus_execute_wait = external_define(_library, "execute", dll_cdecl, ty_real, 1, ty_string);
}

function execute_shell(prog, arg, _wait = false) {
	
    return external_call(_wait ? global.__lib64Plus_execute_wait : global.__lib64Plus_execute, prog + " " + arg);
}

function execute_shell_admin(prog, arg) {
	
    if (CURRENT_OS == os_windows)
        return external_call(global.__lib64Plus_execute, "powershell.exe -Command \"Start-Process '" + prog + "' '" + arg + "' -Verb runAs\"");
}