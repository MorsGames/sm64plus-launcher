#include "library.h"

#include <stdlib.h>
#include <stdio.h>

#ifdef _WIN32

#include <windows.h>

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

    // i mean... it works!!!!!
    system(path);

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

    // Does not wait atm
    system(path);

#endif

}