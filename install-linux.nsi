!include "MUI2.nsh"
!include "LogicLib.nsh"


!define APPNAME "FPTUFIA AnIsSus"
!define APP_NAME_IN_INSTALLED_DIR "AnIsSus"
!define COMPANYNAME "FPTU FIA Technical Branch"
!define DESCRIPTION "This is an app made with love and Khia xP"
!define DEVELOPER "baolongv3" #License Holder
  # Files Directory
!define FILE_DIR "${__FILEDIR__}" #Remember to change it later to environment variable
!define LOGO_ICON_FILE "${FILE_DIR}/installer/logo.ico"
!define LICENSE_TEXT_FILE "${FILE_DIR}/installer/LICENSE.txt"
!define SPLASH_IMG_FILE "${FILE_DIR}/installer/splash.bmp"
!define HEADER_IMG_FILE "${FILE_DIR}/installer/header.bmp"
  # These three must be integers
!define VERSION 6.6.6
!define BUILDNUMBER 1		#Source control revision number
  # These will be displayed by the "Click here for support information" link in "Add/Remove Programs"
  # It is possible to use "mailto:" links in here to open email client
!define HELPURL "https://fptufia.live"
!define UPDATEURL "https://"
!define ABOUTURL "https://fptufia.live"
  # This is the size (in kB) of all the files copied into "Program Files"s

Unicode True
;Name and file
  Name "${APPNAME}"
  Icon "${LOGO_ICON_FILE}"
  OutFile "${APPNAME} Setup.exe"

  ;Default installation folder
  InstallDir "$PROGRAMFILES\${APPNAME}"

  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\${APPNAME}" ""

  ;Request application privileges for Windows Vista
  RequestExecutionLevel admin ;Require admin rights on NT6+ (When UAC is turned on)
XPStyle on

Function .onInit
    InitPluginsDir
    File /oname=$PLUGINSDIR\splash.bmp "${SPLASH_IMG_FILE}"
    Splash::show 5000 $PLUGINSDIR\splash
    Pop $0
FunctionEnd

Var StartMenuFolder
  
!macro VerifyUserIsAdmin
  UserInfo::GetAccountType
  pop $0
  ${If} $0 != "admin" ;Require admin rights on NT4+
	messageBox mb_iconstop "Dua bo may quyen admin roi moi duoc cai nhe :D"
	setErrorLevel 740 ;ERROR_ELEVATION_REQUIRED
	quit
  ${EndIf}
!macroend
;--------------------------------
;Interface Settings

  
  !define MUI_ABORTWARNING

;--------------------------------
;Pages

  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "${LICENSE_TEXT_FILE}"
  !insertmacro MUI_PAGE_DIRECTORY
  
  ;Start Menu Folder Page Configuration
  !define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU" 
  !define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\${APPNAME}" 
  !define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"
  
  !insertmacro MUI_PAGE_STARTMENU Application $StartMenuFolder
  
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH

  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "English"


Section "install" 
    SetOutPath $INSTDIR
    File "installer/logo.ico"
    File "${FILE_DIR}/${APP_NAME_IN_INSTALLED_DIR}.exe"
    File "${FILE_DIR}/${APP_NAME_IN_INSTALLED_DIR}.py"
    File "${FILE_DIR}/${APP_NAME_IN_INSTALLED_DIR}.sh"
    File "${FILE_DIR}/${APP_NAME_IN_INSTALLED_DIR}-32.exe"
    SetOutPath "$INSTDIR\game"
    File /r "game/*.*"
    SetOutPath "$INSTDIR\lib"
    File /r "lib/*.*"
    SetOutPath "$INSTDIR\renpy"
    File /r "renpy/*.*"

    writeUninstaller "$INSTDIR\uninstall.exe"
    SetOutPath $INSTDIR
    
    

    # Start Menu

    CreateDirectory "$SMPROGRAMS\${APPNAME}"
    CreateShortCut "$SMPROGRAMS\${APPNAME}\${APPNAME}.lnk" "$INSTDIR\${APP_NAME_IN_INSTALLED_DIR}.exe" "" "$INSTDIR\logo.ico"
    CreateShortCut "$SMPROGRAMS\${APPNAME}\uninstall.lnk" "$INSTDIR\uninstall.exe" "" ""
    
    # Desktop Shortcut
    CreateShortCut "$DESKTOP\${APPNAME}.lnk" "$INSTDIR\${APP_NAME_IN_INSTALLED_DIR}.exe" "" "$INSTDIR\logo.ico"

    # Registry information for add/remove programs
    WriteRegStr HKLM "Software\Microstft\Windows\CurrentVersion\Uninstall\${APPNAME}" "DisplayName" "${APPNAME} - ${DESCRIPTION}"
    WriteRegStr HKLM "Software\Microstft\Windows\CurrentVersion\Uninstall\${APPNAME}" "UninstallString" "$\"$INSTDIR\uninstall.exe$\""
    WriteRegStr HKLM "Software\Microstft\Windows\CurrentVersion\Uninstall\${APPNAME}" "QuitUninstallString" "$\"$INSTDIR\uninstall.exe$\" /S"
    WriteRegStr HKLM "Software\Microstft\Windows\CurrentVersion\Uninstall\${APPNAME}" "DisplayIcon" "$\"$INSTDIR\logo.ico$\""
    WriteRegStr HKLM "Software\Microstft\Windows\CurrentVersion\Uninstall\${APPNAME}" "Publisher" "$\"${COMPANYNAME}$\""
    WriteRegStr HKLM "Software\Microstft\Windows\CurrentVersion\Uninstall\${APPNAME}" "HelpLink" "$\"${HELPURL}$\""
    WriteRegStr HKLM "Software\Microstft\Windows\CurrentVersion\Uninstall\${APPNAME}" "URLUpdateInfo" "$\"${UPDATEURL}$\""
    WriteRegStr HKLM "Software\Microstft\Windows\CurrentVersion\Uninstall\${APPNAME}" "URLInfoAbout" "$\"${ABOUTURL}$\""
    WriteRegStr HKLM "Software\Microstft\Windows\CurrentVersion\Uninstall\${APPNAME}" "DisplayVersion" "$\"${VERSION}.${BUILDNUMBER}$\""
    # There is no option for modifying or reparing the install
    WriteRegDWORD HKLM "Software\Microstft\Windows\CurrentVersion\Uninstall\${APPNAME}" "NoModify" 1
    WriteRegDWORD HKLM "Software\Microstft\Windows\CurrentVersion\Uninstall\${APPNAME}" "NoRepair" 1
   
SectionEnd

  VIProductVersion "${VERSION}.${BUILDNUMBER}"
  VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductName" "${APPNAME}"
  VIAddVersionKey /LANG=${LANG_ENGLISH} "Comments" "${DESCRIPTION}"
  VIAddVersionKey /LANG=${LANG_ENGLISH} "CompanyName" "${COMPANYNAME}"
  VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalTrademarks" "${APPNAME} is a trademark of ${COMPANYNAME}"
  VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalCopyright" "${DEVELOPER} | ${COMPANYNAME}"
  VIAddVersionKey /LANG=${LANG_ENGLISH} "FileDescription" "${APPNAME}"
  VIAddVersionKey /LANG=${LANG_ENGLISH} "FileVersion" "${VERSION}.${BUILDNUMBER}"
  VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductVersion" "${VERSION}.${BUILDNUMBER}"


function un.onInit		
	# Verify the uninstaller - last chance to back out
	MessageBox MB_OKCANCEL "Sus khong?" IDOK next
		Abort
	next:
	!insertmacro VerifyUserIsAdmin
functionEnd


Section "uninstall"
  #Remove Start Menu Launcher
  delete "$SMPROGRAMS\${APPNAME}\${APPNAME}.lnk"
  delete "$SMPROGRAMS\${APPNAME}\uninstall.lnk"
  #Remove Desktop Shortcut
  delete "$DESKTOP\${APPNAME}.lnk"
  #Try to remove the Start Menu folder - this will only happen if it is empty
  rmDir "$SMPROGRAMS\${APPNAME}"

	
  # ALways delete uninstaller as the last section
  delete $INSTDIR\uninstall.exe

  # Try to remove the install directory - this will only happen if it is empty
  rmDir /r $INSTDIR

  #Delete installation folder from registry if available - this will only happen if it is empty
  DeleteRegKey /ifempty HKCU "Software\${APPNAME}"

  # Remove uninstaller information from the registry
  DeleteRegKey HKLM "Software\Microstft\Windows\CurrentVersion\Uninstall\${APPNAME}"
SectionEnd