; RunnerInstaller.nsi
;
; This script is based on example1.nsi, but it remember the directory, 
; has uninstall support and (optionally) installs start menu shortcuts.
;
; It will install example2.nsi into a directory that the user selects,

;--------------------------------
!ifndef FULL_VERSION
!define FULL_VERSION      "1.0.0.0"
!endif
!ifndef SOURCE_DIR
!define SOURCE_DIR        "C:\source\temp\InstallerTest\runner"
!endif
!ifndef INSTALLER_FILENAME
!define INSTALLER_FILENAME    "C:\source\temp\InstallerTest\RunnerInstaller.exe"
!endif

!ifndef MAKENSIS
!define MAKENSIS          "%appdata%\GameMaker-Studio\makensis"
!endif

!ifndef COMPANY_NAME
!define COMPANY_NAME      ""
!endif

!ifndef COPYRIGHT_TXT
!define COPYRIGHT_TXT     "(c)Copyright 2013"
!endif

!ifndef FILE_DESC
!define FILE_DESC         "Created with GameMaker:Studio"
!endif

!ifndef LICENSE_NAME
!define LICENSE_NAME      "License.txt"
!endif

!ifndef ICON_FILE
!define ICON_FILE       "icon.ico"
!endif

!ifndef IMAGE_FINISHED
!define IMAGE_FINISHED      "Runner_finish.bmp"
!endif

!ifndef IMAGE_HEADER
!define IMAGE_HEADER      "Runner_header.bmp"
!endif

!ifndef PRODUCT_NAME
!define PRODUCT_NAME      "Runner"
!endif

!define APP_NAME        "${PRODUCT_NAME}"
!define SHORT_NAME        "${PRODUCT_NAME}"

!ifndef EXE_NAME
!define EXE_NAME "${PRODUCT_NAME}"
!endif

;............................................................
!define DEFAULTNORMALDESTINATON "$PROGRAMFILES\${EXE_NAME}"
!define DEFAULTPORTABLEDESTINATON "$EXEDIR\${EXE_NAME}"
!define INSTDIR_REG_ROOT "HKLM"
!define INSTDIR_REG_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"
!define UNINSTALLER_FILE "uninstall.exe"

; include the Uninstall log header
!include AdvUninstLog.nsh

; The name of the installer
Name "${APP_NAME}"
Caption "${APP_NAME}"
BrandingText "${APP_NAME}"

; The file to write
OutFile "${INSTALLER_FILENAME}"

; Request application privileges for Windows Vista
RequestExecutionlevel highest

; Set compression
SetCompressor LZMA

VIProductVersion "${FULL_VERSION}"
VIAddVersionKey /LANG=1033 "FileVersion" "${FULL_VERSION}"
VIAddVersionKey /LANG=1033 "ProductVersion" "${FULL_VERSION}"
VIAddVersionKey /LANG=1033 "ProductName" "${PRODUCT_NAME}"
VIAddVersionKey /LANG=1033 "CompanyName" "${PRODUCT_PUBLISHER}"
VIAddVersionKey /LANG=1033 "LegalCopyright" "${COPYRIGHT_TXT}"
VIAddVersionKey /LANG=1033 "FileDescription" "${FILE_DESC}"

; !define MUI_HEADERIMAGE
; !define MUI_HEADERIMAGE_BITMAP_NOSTRETCH
!define MUI_ICON            "${ICON_FILE}"
; !define MUI_WELCOMEFINISHPAGE_BITMAP  "${IMAGE_FINISHED}"
; !define MUI_HEADERIMAGE_BITMAP      "${IMAGE_HEADER}"
; !define MUI_WELCOMEFINISHPAGE_BITMAP_NOSTRETCH

Var NormalDestDir
Var PortableDestDir
Var PortableMode
Var UninstallMode

!include LogicLib.nsh
!include FileFunc.nsh
!include MUI2.nsh

!insertmacro UNATTENDED_UNINSTALL
Page Custom PortableModePageCreate PortableModePageLeave
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
    # These indented statements modify settings for MUI_PAGE_FINISH
    !define MUI_FINISHPAGE_RUN_TEXT "Run the launcher"
    !define MUI_FINISHPAGE_RUN "$INSTDIR\${EXE_NAME}.exe"
    !define MUI_FINISHPAGE_LINK "Download MSYS2 (Required for the building process)"
    !define MUI_FINISHPAGE_LINK_LOCATION "https://www.msys2.org/"
!insertmacro MUI_PAGE_FINISH

Var VCRedistSetupError

  UninstPage Custom un.UninstallModePageCreate un.UninstallModePageLeave
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "English"



Section "${APP_NAME}" SEC_GAME

    SetOutPath "$INSTDIR"

    ${If} $PortableMode = 0

        !insertmacro UNINSTALL.LOG_OPEN_INSTALL

        File /r "${SOURCE_DIR}\*.*"

        !insertmacro UNINSTALL.LOG_CLOSE_INSTALL
    
        WriteRegStr ${INSTDIR_REG_ROOT} "${INSTDIR_REG_KEY}" "InstallDir" "$INSTDIR"
        WriteRegStr ${INSTDIR_REG_ROOT} "${INSTDIR_REG_KEY}" "DisplayName" "${APP_NAME}"
        ;Same as create shortcut you need to use ${UNINSTALLER_FILE} instead of anything else.
        WriteRegStr ${INSTDIR_REG_ROOT} "${INSTDIR_REG_KEY}" "UninstallString" "$INSTDIR\${UNINSTALLER_FILE}"
        WriteRegDWORD ${INSTDIR_REG_ROOT} "${INSTDIR_REG_KEY}" "NoModify" 1
        WriteRegDWORD ${INSTDIR_REG_ROOT} "${INSTDIR_REG_KEY}" "NoRepair" 1
        WriteRegStr ${INSTDIR_REG_ROOT} "${INSTDIR_REG_KEY}" "DisplayIcon" "$INSTDIR\${EXE_NAME}.exe"

        WriteUninstaller "$INSTDIR\${UNINSTALLER_FILE}"

        ${GetSize} "$INSTDIR" "/S=0K" $0 $1 $2
        IntFmt $0 "0x%08X" $0
        WriteRegDWORD ${INSTDIR_REG_ROOT} "${INSTDIR_REG_KEY}" "EstimatedSize" "$0"

    ${Else}
    
        File /r "${SOURCE_DIR}\*.*"

        ; Create the file the application uses to detect portable mode
        FileOpen $0 "$INSTDIR\portable.dat" w
        FileWrite $0 "PORTABLE"
        FileClose $0
    ${EndIf}

SectionEnd


Section "Visual C++ Redistributable" SEC_VCREDIST

    SetOutPath "$TEMP"
    File "${MAKENSIS}\vcredist_x86_2015.exe"
    DetailPrint "Running Visual Studio 2015 x86 Redistributable Setup..."
    ExecWait '"$TEMP\vcredist_x86_2015.exe" /quiet /norestart' $VCRedistSetupError
    DetailPrint "end VS2015 x86"
    Delete "$TEMP\vcredist_x86_2015.exe"

    SetOutPath "$INSTDIR"

SectionEnd


Section "Start Menu Shortcut" SEC_START

    CreateShortcut "$SMPROGRAMS\${APP_NAME}.lnk" "$INSTDIR\${EXE_NAME}.exe"
    ;CreateShortcut "$SMPROGRAMS\Uninstall ${EXE_NAME}.lnk" "$INSTDIR\${UNINSTALLER_FILE}"
  
SectionEnd


Section /o "Desktop Shortcut" SEC_DESKTOP

    CreateShortCut "$DESKTOP\${APP_NAME}.lnk" "$INSTDIR\${EXE_NAME}.exe" ""
  
SectionEnd


Section Uninstall

    Delete "$SMPROGRAMS\${APP_NAME}.lnk"
    ;Delete "$SMPROGRAMS\Uninstall ${APP_NAME}.lnk"

    DeleteRegKey /ifempty ${INSTDIR_REG_ROOT} "${INSTDIR_REG_KEY}"

    ${If} $UninstallMode = 0
      ; RMDir /r $INSTDIR
      RMDir /r $INSTDIR\sm64plus
    ${EndIf}

    ;begin uninstall, especially for MUI could be added in UN.onInit function instead
    ;!insertmacro UNINSTALL.LOG_BEGIN_UNINSTALL

    ;uninstall from path, must be repeated for every install logged path individual
    !insertmacro UNINSTALL.LOG_UNINSTALL "$INSTDIR"

    ;uninstall from path, must be repeated for every install logged path individual
    !insertmacro UNINSTALL.LOG_UNINSTALL "$APPDATA\${APP_NAME}"

    ;end uninstall, after uninstall from all logged paths has been performed
    !insertmacro UNINSTALL.LOG_END_UNINSTALL
         

SectionEnd

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SEC_GAME} "The launcher files."
    !insertmacro MUI_DESCRIPTION_TEXT ${SEC_VCREDIST} "A library required for the launcher itself to work. The installation of it is skipped if it's already found on your system."
    !insertmacro MUI_DESCRIPTION_TEXT ${SEC_START} "The shortcut to the launcher on the Start Menu."
    !insertmacro MUI_DESCRIPTION_TEXT ${SEC_DESKTOP} "The shortcut to the launcher on your Desktop."
!insertmacro MUI_FUNCTION_DESCRIPTION_END

Function .onInit

    ;prepare log always within .onInit function
    !insertmacro UNINSTALL.LOG_PREPARE_INSTALL

    StrCpy $NormalDestDir "${DEFAULTNORMALDESTINATON}"
    StrCpy $PortableDestDir "${DEFAULTPORTABLEDESTINATON}"

    ${GetParameters} $9

    ClearErrors
    ${GetOptions} $9 "/?" $8
    ${IfNot} ${Errors}
        MessageBox MB_ICONINFORMATION|MB_SETFOREGROUND "\
        /PORTABLE : Extract application to a specific folder without editing registry.$\n\
        /S : Silent install$\n\
        /D=%directory% : Specify destination directory$\n"
        Quit
    ${EndIf}

    ClearErrors
    ${GetOptions} $9 "/PORTABLE" $8
    ${IfNot} ${Errors}
        StrCpy $PortableMode 1
        StrCpy $0 $PortableDestDir
    ${Else}
        StrCpy $PortableMode 0
        StrCpy $0 $NormalDestDir
        ${If} ${Silent}
            Call RequireAdmin
        ${EndIf}
    ${EndIf}

    ${If} $INSTDIR == ""
        ; User did not use /D to specify a directory, 
        ; we need to set a default based on the install mode
        StrCpy $INSTDIR $0
    ${EndIf}
    Call SetModeDestinationFromInstdir
FunctionEnd

Function .onInstSuccess

    ;create/update log always within .onInstSuccess function
    !insertmacro UNINSTALL.LOG_UPDATE_INSTALL

FunctionEnd

Function UN.onInit

         ;begin uninstall, could be added on top of uninstall section instead
         !insertmacro UNINSTALL.LOG_BEGIN_UNINSTALL

FunctionEnd


Function RequireAdmin
    UserInfo::GetAccountType
    Pop $8
    ${If} $8 != "admin"
        MessageBox MB_ICONSTOP "You need administrator rights to install ${EXE_NAME}."
        SetErrorLevel 740 ;ERROR_ELEVATION_REQUIRED
        Abort
    ${EndIf}
FunctionEnd


Function SetModeDestinationFromInstdir
    ${If} $PortableMode = 0
        StrCpy $NormalDestDir $INSTDIR
    ${Else}
        StrCpy $PortableDestDir $INSTDIR
    ${EndIf}
FunctionEnd

Function PortableModePageCreate

    Call SetModeDestinationFromInstdir
    !insertmacro MUI_HEADER_TEXT "Welcome" "Choose how you want to install ${EXE_NAME}."
    nsDialogs::Create 1018
    Pop $0
    ${NSD_CreateLabel} 0 10u 100% 24u "Welcome to the installer for ${EXE_NAME}! With this installer you can either do a full installation or just extract all the necessary game files to a folder."
    Pop $0
    ${NSD_CreateRadioButton} 30u 50u -30u 8u "Full installation (Recommended)"
    Pop $1
    ${NSD_CreateRadioButton} 30u 70u -30u 8u "Extract files (Portable)"
    Pop $2
    ${If} $PortableMode = 0
        SendMessage $1 ${BM_SETCHECK} ${BST_CHECKED} 0
    ${Else}
        SendMessage $2 ${BM_SETCHECK} ${BST_CHECKED} 0
    ${EndIf}
    nsDialogs::Show

FunctionEnd

Function PortableModePageLeave

    IntOp $0 ${SF_SELECTED} | ${SF_RO}
    SectionSetFlags ${SEC_GAME} $0

    ${NSD_GetState} $1 $0
    ${If} $0 <> ${BST_UNCHECKED}

        IntOp $0 ${SF_SELECTED} | ${SF_RO}
        SectionSetFlags ${SEC_VCREDIST} $0
        SectionSetFlags ${SEC_START} ${SF_SELECTED}
        SectionSetFlags ${SEC_DESKTOP} 0

        StrCpy $PortableMode 0
        StrCpy $INSTDIR $NormalDestDir
        Call RequireAdmin

    ${Else}

        SectionSetFlags ${SEC_VCREDIST} ${SF_RO}
        SectionSetFlags ${SEC_START} ${SF_RO}
        SectionSetFlags ${SEC_DESKTOP} ${SF_RO}

        StrCpy $PortableMode 1
        StrCpy $INSTDIR $PortableDestDir
    ${EndIf}

FunctionEnd

Function un.UninstallModePageCreate

    !insertmacro MUI_HEADER_TEXT "Welcome" "Choose how you want to uninstall ${EXE_NAME}."
    nsDialogs::Create 1018
    Pop $0
    ${NSD_CreateLabel} 0 10u 100% 24u "Welcome to the uninstaller for ${EXE_NAME}. Before starting the uninstallation please make sure that ${EXE_NAME} is not running."
    Pop $0
    ${NSD_CreateRadioButton} 30u 50u -30u 8u "Full uninstallation"
    Pop $1
    ${NSD_CreateRadioButton} 30u 70u -30u 8u "Only uninstall the launcher"
    Pop $2
    ${If} $UninstallMode = 0
        SendMessage $1 ${BM_SETCHECK} ${BST_CHECKED} 0
    ${Else}
        SendMessage $2 ${BM_SETCHECK} ${BST_CHECKED} 0
    ${EndIf}
    nsDialogs::Show

FunctionEnd

Function un.UninstallModePageLeave

    ${NSD_GetState} $1 $0
    ${If} $0 <> ${BST_UNCHECKED}
        StrCpy $UninstallMode 0
    ${Else}
        StrCpy $UninstallMode 1
    ${EndIf}

FunctionEnd