#include "library.h"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#ifdef _WIN32

#include <windows.h>

#else

#include <ctype.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

static void execute_unix(const char *path, int wait_for_exit)
{
    char *cmd = strdup(path);

    if (!cmd)
    {
        perror("strdup failed");
        return;
    }

    size_t path_len = strlen(cmd);
    while (path_len > 0 && isspace((unsigned char)cmd[path_len - 1]))
    {
        cmd[--path_len] = '\0';
    }

    if (path_len == 0)
    {
        free(cmd);
        return;
    }

    pid_t pid = fork();

    if (pid == 0)
    {
        if (!wait_for_exit)
        {
            // Double-fork so the launched process is re-parented and avoids becoming a zombie.
            pid_t child = fork();

            if (child == 0)
            {
                execl(cmd, cmd, (char *)NULL);
                execl("/bin/sh", "sh", "-c", cmd, (char *)NULL);
                perror("exec failed");
                _exit(EXIT_FAILURE);
            }
            else if (child < 0)
            {
                perror("fork failed");
                _exit(EXIT_FAILURE);
            }

            _exit(0);
        }

        execl(cmd, cmd, (char *)NULL);
        execl("/bin/sh", "sh", "-c", cmd, (char *)NULL);
        perror("exec failed");
        _exit(EXIT_FAILURE);
    }
    else if (pid > 0)
    {
        waitpid(pid, NULL, 0);
    }
    else
    {
        perror("fork failed");
    }

    free(cmd);
}

#endif

void execute(char *path)
{
#ifdef _WIN32

    STARTUPINFO si;
    PROCESS_INFORMATION pi;

    ZeroMemory( &si, sizeof(si) );
    si.cb = sizeof(si);
    ZeroMemory( &pi, sizeof(pi) );

    if (CreateProcess(NULL,
                      path,
                      NULL,
                      NULL,
                      FALSE,
                      CREATE_NEW_PROCESS_GROUP,
                      NULL,
                      NULL,
                      &si,
                      &pi)
            )
    {
        // Close process and thread handles.
        CloseHandle(pi.hProcess);
        CloseHandle(pi.hThread);
    }
    else
    {
        printf("CreateProcess failed (%d).\n", GetLastError() );
    }

#else

    execute_unix(path, 0);

#endif

}

void execute_wait(char *path)
{
#ifdef _WIN32

    STARTUPINFO si;
    PROCESS_INFORMATION pi;

    ZeroMemory( &si, sizeof(si) );
    si.cb = sizeof(si);
    ZeroMemory( &pi, sizeof(pi) );

    if (CreateProcess(NULL,
                      path,
                      NULL,
                      NULL,
                      FALSE,
                      0,
                      NULL,
                      NULL,
                      &si,
                      &pi)
            )
    {
        // Wait until child process exits.
        WaitForSingleObject(pi.hProcess, INFINITE);

        // Close process and thread handles.
        CloseHandle(pi.hProcess);
        CloseHandle(pi.hThread);
    }
    else
    {
        printf("CreateProcess failed (%d).\n", GetLastError() );
    }

#else

    execute_unix(path, 1);

#endif

}
