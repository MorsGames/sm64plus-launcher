function execute_shell_admin(prog, arg){
	
	return ProcessExecuteAsync("powershell.exe -Command \"Start-Process '" + prog + "' '" + arg + "' -Verb runAs\"");
}