#ifndef INC_64PLUS_LIBRARY_H
#define INC_64PLUS_LIBRARY_H

#ifdef _WIN32
#define DLL_EXPORT __declspec(dllexport)
#else
#define DLL_EXPORT
#endif

// Execute!
DLL_EXPORT void execute(char *path);
DLL_EXPORT void execute_wait(char *path);

// Display Mode
DLL_EXPORT double display_mode_get_display_count(void);
DLL_EXPORT double display_mode_get_count(double display_index);
DLL_EXPORT const char* display_mode_get_value(double display_index, double mode_index);

// Controller
DLL_EXPORT double controller_init(double allow_non_xinput);
DLL_EXPORT double controller_shutdown(void);
DLL_EXPORT double controller_poll(void);
DLL_EXPORT double controller_get_button(double logical_button_id);
DLL_EXPORT double controller_get_axis(double axis_id);
DLL_EXPORT const char* controller_get_name(void);

#endif //INC_64PLUS_LIBRARY_H
