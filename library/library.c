#include "library.h"

#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

#ifdef _WIN32
#include <SDL.h>
#else
#include <SDL2/SDL.h>
#endif

#ifdef _WIN32

#include <windows.h>

#endif

typedef struct display_mode_entry {
    int width;
    int height;
    int refresh_rate;
} display_mode_entry;

static bool display_mode_video_ready(void)
{
    if (SDL_WasInit(SDL_INIT_VIDEO) != 0)
    {
        return true;
    }

    if (SDL_InitSubSystem(SDL_INIT_VIDEO) == 0)
    {
        return true;
    }

    if (SDL_Init(SDL_INIT_VIDEO) == 0)
    {
        return true;
    }

    printf("SDL video init error: %s\n", SDL_GetError());
    return false;
}

static bool display_mode_equals(display_mode_entry a, display_mode_entry b)
{
    return a.width == b.width && a.height == b.height && a.refresh_rate == b.refresh_rate;
}

static display_mode_entry display_mode_from_sdl(const SDL_DisplayMode *mode)
{
    display_mode_entry entry;
    entry.width = mode->w;
    entry.height = mode->h;
    entry.refresh_rate = mode->refresh_rate > 0 ? mode->refresh_rate : 0;
    return entry;
}

static int collect_display_modes(int display_index, display_mode_entry **out_entries)
{
    int mode_count;
    int unique_count;
    display_mode_entry *entries;

    if (out_entries == NULL)
    {
        return 0;
    }

    *out_entries = NULL;

    if (!display_mode_video_ready())
    {
        return 0;
    }

    if (display_index < 0 || display_index >= SDL_GetNumVideoDisplays())
    {
        return 0;
    }

    mode_count = SDL_GetNumDisplayModes(display_index);
    if (mode_count <= 0)
    {
        SDL_DisplayMode current_mode;

        if (SDL_GetCurrentDisplayMode(display_index, &current_mode) != 0)
        {
            return 0;
        }

        entries = (display_mode_entry *)calloc(1, sizeof(*entries));
        if (entries == NULL)
        {
            return 0;
        }

        entries[0] = display_mode_from_sdl(&current_mode);
        *out_entries = entries;
        return 1;
    }

    entries = (display_mode_entry *)calloc((size_t)mode_count, sizeof(*entries));
    if (entries == NULL)
    {
        return 0;
    }

    unique_count = 0;

    for (int i = 0; i < mode_count; i++)
    {
        SDL_DisplayMode mode;
        display_mode_entry candidate;
        bool duplicate;

        if (SDL_GetDisplayMode(display_index, i, &mode) != 0)
        {
            continue;
        }

        candidate = display_mode_from_sdl(&mode);
        duplicate = false;

        for (int j = 0; j < unique_count; j++)
        {
            if (display_mode_equals(entries[j], candidate))
            {
                duplicate = true;
                break;
            }
        }

        if (!duplicate)
        {
            entries[unique_count++] = candidate;
        }
    }

    if (unique_count <= 0)
    {
        SDL_DisplayMode current_mode;

        if (SDL_GetCurrentDisplayMode(display_index, &current_mode) == 0)
        {
            entries[0] = display_mode_from_sdl(&current_mode);
            unique_count = 1;
        }
    }

    if (unique_count <= 0)
    {
        free(entries);
        return 0;
    }

    *out_entries = entries;
    return unique_count;
}

DLL_EXPORT double display_mode_get_display_count(void)
{
    if (!display_mode_video_ready())
    {
        return 0.0;
    }

    return (double)SDL_GetNumVideoDisplays();
}

DLL_EXPORT double display_mode_get_count(double display_index)
{
    display_mode_entry *entries;
    int count = collect_display_modes((int)display_index, &entries);

    free(entries);
    return (double)count;
}

DLL_EXPORT const char* display_mode_get_value(double display_index, double mode_index)
{
    static char mode_value[64];
    display_mode_entry *entries;
    int count;
    int index = (int)mode_index;

    mode_value[0] = '\0';

    count = collect_display_modes((int)display_index, &entries);
    if (count <= 0)
    {
        return mode_value;
    }

    if (index < 0 || index >= count)
    {
        free(entries);
        return mode_value;
    }

    snprintf(
        mode_value,
        sizeof(mode_value),
        "%dx%d@%d",
        entries[index].width,
        entries[index].height,
        entries[index].refresh_rate
    );

    free(entries);
    return mode_value;
}

DLL_EXPORT void execute(char *path)
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

DLL_EXPORT void execute_wait(char *path)
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
    system(path);

#endif

}
