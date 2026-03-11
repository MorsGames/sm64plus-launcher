#include "library.h"

#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <math.h>

#ifdef _WIN32
#include <SDL.h>
#else
#include <SDL2/SDL.h>
#endif

#define BTN_A            (1 << 1)
#define BTN_B            (1 << 2)
#define BTN_X            (1 << 3)
#define BTN_Y            (1 << 4)
#define BTN_SELECT       (1 << 5)
#define BTN_GUIDE        (1 << 6)
#define BTN_START        (1 << 7)
#define BTN_LSTICK       (1 << 8)
#define BTN_RSTICK       (1 << 9)
#define BTN_L            (1 << 10)
#define BTN_R            (1 << 11)
#define BTN_DUP          (1 << 12)
#define BTN_DDOWN        (1 << 13)
#define BTN_DLEFT        (1 << 14)
#define BTN_DRIGHT       (1 << 15)
#define BTN_ZL           (1 << 22)
#define BTN_ZR           (1 << 23)

typedef enum {
    LOGICAL_BTN_A = 0,
    LOGICAL_BTN_B,
    LOGICAL_BTN_X,
    LOGICAL_BTN_Y,
    LOGICAL_BTN_SELECT,
    LOGICAL_BTN_START,
    LOGICAL_BTN_GUIDE,
    LOGICAL_BTN_LSTICK,
    LOGICAL_BTN_RSTICK,
    LOGICAL_BTN_L,
    LOGICAL_BTN_R,
    LOGICAL_BTN_DUP,
    LOGICAL_BTN_DDOWN,
    LOGICAL_BTN_DLEFT,
    LOGICAL_BTN_DRIGHT,
    LOGICAL_BTN_ZL,
    LOGICAL_BTN_ZR,
    LOGICAL_BTN_STICKLL,
    LOGICAL_BTN_STICKLR,
    LOGICAL_BTN_STICKLU,
    LOGICAL_BTN_STICKLD,
    LOGICAL_BTN_STICKRL,
    LOGICAL_BTN_STICKRR,
    LOGICAL_BTN_STICKRU,
    LOGICAL_BTN_STICKRD,
    LOGICAL_BTN_ANY
} LogicalButton;

typedef enum {
    AXIS_LEFT_X = 0,
    AXIS_LEFT_Y,
    AXIS_RIGHT_X,
    AXIS_RIGHT_Y,
    AXIS_TRIGGER_L,
    AXIS_TRIGGER_R
} ControllerAxis;

static bool init_ok = false;
static SDL_GameController *sdl_cntrl = NULL;
static bool haptics_enabled = false;
static SDL_Haptic *sdl_haptic = NULL;

static uint32_t g_pressedButtons = 0;
static float g_axes[6] = {0};

static SDL_Haptic *controller_sdl_init_haptics(const int joy)
{
    if (!haptics_enabled) return NULL;

    SDL_Haptic *hap = SDL_HapticOpen(joy);
    if (hap == NULL) return NULL;

    if (SDL_HapticRumbleSupported(hap) != SDL_TRUE)
    {
        SDL_HapticClose(hap);
        return NULL;
    }

    if (SDL_HapticRumbleInit(hap) != 0)
    {
        SDL_HapticClose(hap);
        return NULL;
    }

    return hap;
}

DLL_EXPORT double controller_init(double allow_non_xinput)
{
    if (init_ok) return 1.0;

#if defined(_WIN32) || defined(_WIN64)
    if (allow_non_xinput == 0.0)
    {
        // Prioritize XInput by disabling other joystick backends.
        SDL_SetHint(SDL_HINT_JOYSTICK_RAWINPUT, "0");
        SDL_SetHint(SDL_HINT_JOYSTICK_HIDAPI, "0");
    }
#endif

    if (SDL_Init(SDL_INIT_GAMECONTROLLER) != 0)
    {
        printf("SDL init error: %s\n", SDL_GetError());
        return 0.0;
    }

    haptics_enabled = (SDL_InitSubSystem(SDL_INIT_HAPTIC) == 0);
    if (!haptics_enabled)
    {
        printf("Haptic init failed (ignoring): %s\n", SDL_GetError());
    }
    
    if (SDL_GameControllerAddMappingsFromFile("gamecontrollerdb.txt") < 0)
    {
        printf("Failed to load gamecontrollerdb.txt: %s\n", SDL_GetError());
    }

    init_ok = true;
    printf("controller_init: OK\n");
    return 1.0;
}

DLL_EXPORT double controller_shutdown(void)
{
    if (!init_ok) return 1.0;

    if (sdl_haptic != NULL)
    {
        SDL_HapticClose(sdl_haptic);
        sdl_haptic = NULL;
    }
    if (sdl_cntrl != NULL)
    {
        SDL_GameControllerClose(sdl_cntrl);
        sdl_cntrl = NULL;
    }

    SDL_QuitSubSystem(SDL_INIT_HAPTIC);
    SDL_QuitSubSystem(SDL_INIT_GAMECONTROLLER);
    
    init_ok = false;
    return 1.0;
}

#define SET_BUTTON(SDL_BUTTON, BIT) if (SDL_GameControllerGetButton(sdl_cntrl, SDL_BUTTON)) g_pressedButtons |= BIT

DLL_EXPORT double controller_poll(void)
{
    if (!init_ok) return 0.0;

    SDL_GameControllerUpdate();

    if (sdl_cntrl != NULL && !SDL_GameControllerGetAttached(sdl_cntrl))
    {
        if (sdl_haptic != NULL)
        {
            SDL_HapticClose(sdl_haptic);
            sdl_haptic = NULL;
        }
        SDL_GameControllerClose(sdl_cntrl);
        sdl_cntrl = NULL;
    }

    if (sdl_cntrl == NULL)
    {
        for (int i = 0; i < SDL_NumJoysticks(); i++)
        {
            if (SDL_IsGameController(i))
            {
                sdl_cntrl = SDL_GameControllerOpen(i);
                if (sdl_cntrl != NULL)
                {
                    printf("Opened controller %d: %s (Vendor ID: 0x%04X)\n", i, SDL_GameControllerName(sdl_cntrl), SDL_GameControllerGetVendor(sdl_cntrl));
                    sdl_haptic = controller_sdl_init_haptics(i);
                    break;
                }
            }
        }
        if (sdl_cntrl == NULL)
        {
            g_pressedButtons = 0;
            for(int i=0; i<6; i++) g_axes[i] = 0;
            return 0.0;
        }
    }

    g_pressedButtons = 0;

    SET_BUTTON(SDL_CONTROLLER_BUTTON_A, BTN_A);
    SET_BUTTON(SDL_CONTROLLER_BUTTON_B, BTN_B);
    SET_BUTTON(SDL_CONTROLLER_BUTTON_X, BTN_X);
    SET_BUTTON(SDL_CONTROLLER_BUTTON_Y, BTN_Y);
    SET_BUTTON(SDL_CONTROLLER_BUTTON_BACK, BTN_SELECT);
    SET_BUTTON(SDL_CONTROLLER_BUTTON_GUIDE, BTN_GUIDE);
    SET_BUTTON(SDL_CONTROLLER_BUTTON_START, BTN_START);
    SET_BUTTON(SDL_CONTROLLER_BUTTON_LEFTSTICK, BTN_LSTICK);
    SET_BUTTON(SDL_CONTROLLER_BUTTON_RIGHTSTICK, BTN_RSTICK);
    SET_BUTTON(SDL_CONTROLLER_BUTTON_LEFTSHOULDER, BTN_L);
    SET_BUTTON(SDL_CONTROLLER_BUTTON_RIGHTSHOULDER, BTN_R);
    SET_BUTTON(SDL_CONTROLLER_BUTTON_DPAD_UP, BTN_DUP);
    SET_BUTTON(SDL_CONTROLLER_BUTTON_DPAD_DOWN, BTN_DDOWN);
    SET_BUTTON(SDL_CONTROLLER_BUTTON_DPAD_LEFT, BTN_DLEFT);
    SET_BUTTON(SDL_CONTROLLER_BUTTON_DPAD_RIGHT, BTN_DRIGHT);

    int16_t ltrig = SDL_GameControllerGetAxis(sdl_cntrl, SDL_CONTROLLER_AXIS_TRIGGERLEFT);
    int16_t rtrig = SDL_GameControllerGetAxis(sdl_cntrl, SDL_CONTROLLER_AXIS_TRIGGERRIGHT);

    if (ltrig > 30 * 256) g_pressedButtons |= BTN_ZL;
    if (rtrig > 30 * 256) g_pressedButtons |= BTN_ZR;

    g_axes[AXIS_LEFT_X] = SDL_GameControllerGetAxis(sdl_cntrl, SDL_CONTROLLER_AXIS_LEFTX) / 32767.0f;
    g_axes[AXIS_LEFT_Y] = SDL_GameControllerGetAxis(sdl_cntrl, SDL_CONTROLLER_AXIS_LEFTY) / 32767.0f;
    g_axes[AXIS_RIGHT_X] = SDL_GameControllerGetAxis(sdl_cntrl, SDL_CONTROLLER_AXIS_RIGHTX) / 32767.0f;
    g_axes[AXIS_RIGHT_Y] = SDL_GameControllerGetAxis(sdl_cntrl, SDL_CONTROLLER_AXIS_RIGHTY) / 32767.0f;
    g_axes[AXIS_TRIGGER_L] = ltrig / 32767.0f;
    g_axes[AXIS_TRIGGER_R] = rtrig / 32767.0f;

    return (double)g_pressedButtons;
}

DLL_EXPORT double controller_get_button(double logical_button_id)
{
    if (!init_ok || sdl_cntrl == NULL) return 0.0;

    int id = (int)logical_button_id;
    switch (id)
    {
        case LOGICAL_BTN_A: return (g_pressedButtons & BTN_A) ? 1.0 : 0.0;
        case LOGICAL_BTN_B: return (g_pressedButtons & BTN_B) ? 1.0 : 0.0;
        case LOGICAL_BTN_X: return (g_pressedButtons & BTN_X) ? 1.0 : 0.0;
        case LOGICAL_BTN_Y: return (g_pressedButtons & BTN_Y) ? 1.0 : 0.0;
        case LOGICAL_BTN_SELECT: return (g_pressedButtons & BTN_SELECT) ? 1.0 : 0.0;
        case LOGICAL_BTN_START: return (g_pressedButtons & BTN_START) ? 1.0 : 0.0;
        case LOGICAL_BTN_GUIDE: return (g_pressedButtons & BTN_GUIDE) ? 1.0 : 0.0;
        case LOGICAL_BTN_LSTICK: return (g_pressedButtons & BTN_LSTICK) ? 1.0 : 0.0;
        case LOGICAL_BTN_RSTICK: return (g_pressedButtons & BTN_RSTICK) ? 1.0 : 0.0;
        case LOGICAL_BTN_L: return (g_pressedButtons & BTN_L) ? 1.0 : 0.0;
        case LOGICAL_BTN_R: return (g_pressedButtons & BTN_R) ? 1.0 : 0.0;
        case LOGICAL_BTN_DUP: return (g_pressedButtons & BTN_DUP) ? 1.0 : 0.0;
        case LOGICAL_BTN_DDOWN: return (g_pressedButtons & BTN_DDOWN) ? 1.0 : 0.0;
        case LOGICAL_BTN_DLEFT: return (g_pressedButtons & BTN_DLEFT) ? 1.0 : 0.0;
        case LOGICAL_BTN_DRIGHT: return (g_pressedButtons & BTN_DRIGHT) ? 1.0 : 0.0;
        case LOGICAL_BTN_ZL: return (g_pressedButtons & BTN_ZL) ? 1.0 : 0.0;
        case LOGICAL_BTN_ZR: return (g_pressedButtons & BTN_ZR) ? 1.0 : 0.0;
        case LOGICAL_BTN_STICKLL: return (g_axes[AXIS_LEFT_X] < -0.75) ? 1.0 : 0.0;
        case LOGICAL_BTN_STICKLR: return (g_axes[AXIS_LEFT_X] > 0.75) ? 1.0 : 0.0;
        case LOGICAL_BTN_STICKLU: return (g_axes[AXIS_LEFT_Y] < -0.75) ? 1.0 : 0.0;
        case LOGICAL_BTN_STICKLD: return (g_axes[AXIS_LEFT_Y] > 0.75) ? 1.0 : 0.0;
        case LOGICAL_BTN_STICKRL: return (g_axes[AXIS_RIGHT_X] < -0.75) ? 1.0 : 0.0;
        case LOGICAL_BTN_STICKRR: return (g_axes[AXIS_RIGHT_X] > 0.75) ? 1.0 : 0.0;
        case LOGICAL_BTN_STICKRU: return (g_axes[AXIS_RIGHT_Y] < -0.75) ? 1.0 : 0.0;
        case LOGICAL_BTN_STICKRD: return (g_axes[AXIS_RIGHT_Y] > 0.75) ? 1.0 : 0.0;
        case LOGICAL_BTN_ANY: return (g_pressedButtons != 0 || 
                                     fabs(g_axes[0]) > 0.75 || fabs(g_axes[1]) > 0.75 ||
                                     fabs(g_axes[2]) > 0.75 || fabs(g_axes[3]) > 0.75) ? 2.0 : 0.0;
        default: return 0.0;
    }
}

DLL_EXPORT double controller_get_axis(double axis_id)
{
    if (!init_ok || sdl_cntrl == NULL) return 0.0;
    int id = (int)axis_id;
    if (id < 0 || id >= 6) return 0.0;
    return (double)g_axes[id];
}

DLL_EXPORT const char* controller_get_name(void)
{
    if (!init_ok || sdl_cntrl == NULL) return "";
    return SDL_GameControllerName(sdl_cntrl);
}
