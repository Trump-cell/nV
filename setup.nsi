!define ^Name maTHmU
Name ${^Name}

RequestExecutionLevel highest

# General Symbol Definitions
!define REGKEY "SOFTWARE\${^Name}"
!define VERSION 0.5.0
!define LONG_VERSION 0.5.0
!define COMPANY "maTHmU Research"
!define URL http://www.mathmu.cn/

# MUI Symbol Definitions
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install-colorful.ico"
!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_STARTMENUPAGE_REGISTRY_ROOT HKLM
!define MUI_STARTMENUPAGE_NODISABLE
!define MUI_STARTMENUPAGE_REGISTRY_KEY ${REGKEY}
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME StartMenuGroup
!define MUI_STARTMENUPAGE_DEFAULTFOLDER maTHmU
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall-colorful.ico"
!define MUI_UNFINISHPAGE_NOAUTOCLOSE

!define env_hklm 'HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"'
!define env_hkcu 'HKCU "Environment"'

# Included files
!include Sections.nsh
!include MUI2.nsh
!include winmessages.nsh
!include EnvVarUpdate.nsh

# Variables
Var StartMenuGroup

# Installer pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_STARTMENU Application $StartMenuGroup
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

# Installer languages
!insertmacro MUI_LANGUAGE SimpChinese

# Installer attributes
OutFile ${^Name}-${VERSION}-setup.exe
InstallDir $PROGRAMFILES\maTHmU
CRCCheck on
XPStyle on
ShowInstDetails show
VIProductVersion ${LONG_VERSION}
VIAddVersionKey ProductName maTHmU
VIAddVersionKey ProductVersion "${VERSION}"
VIAddVersionKey CompanyName "${COMPANY}"
VIAddVersionKey CompanyWebsite "${URL}"
VIAddVersionKey FileVersion "${VERSION}"
VIAddVersionKey FileDescription ""
VIAddVersionKey LegalCopyright ""
InstallDirRegKey HKLM "${REGKEY}" Path
ShowUninstDetails show

# Installer sections
Section -Main SEC0000
    SetOutPath $INSTDIR\conf
    SetOverwrite on
    File stage\conf\mU.ini
    File stage\conf\nV.ini
    SetOutPath $INSTDIR\bin
	SetOverwrite on
	File /r stage\bin\Release\*.exe
	File /r stage\bin\Release\*.dll
	File Boost_THREAD_LIBRARY_RELEASE-NOTFOUND
	File Boost_SYSTEM_LIBRARY_RELEASE-NOTFOUND
	File Boost_DATE_TIME_LIBRARY_RELEASE-NOTFOUND
	File Boost_REGEX_LIBRARY_RELEASE-NOTFOUND
	File D:\workspace\nV\Lib\gmp.dll
	File D:\workspace\nV\Lib\mpfr.dll
	File 
	SetOutPath $INSTDIR\lib
	SetOverwrite on
	File /r stage\lib\*
    WriteRegStr HKLM "${REGKEY}\Components" Main 1
SectionEnd

Section -post SEC0001
    WriteRegStr HKLM "${REGKEY}" Path $INSTDIR
    SetOutPath $INSTDIR
    WriteUninstaller $INSTDIR\uninstall.exe
    !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    SetOutPath $SMPROGRAMS\$StartMenuGroup
    CreateShortCut "$SMPROGRAMS\$StartMenuGroup\mU kernel.lnk" $INSTDIR\bin\mu.exe
	CreateShortCut "$SMPROGRAMS\$STartMenuGroup\nV kernel.lnk" $INSTDIR\bin\nv.exe
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\Uninstall $(^Name).lnk" $INSTDIR\uninstall.exe
    !insertmacro MUI_STARTMENU_WRITE_END
	WriteRegExpandStr ${env_hklm} MU_HOME "$INSTDIR"
	WriteRegExpandStr ${env_hklm} NV_HOME "$INSTDIR"
    ${EnvVarUpdate} $0 "PATH" "A" "HKLM" "$INSTDIR\bin"
	SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayName "$(^Name)"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayVersion "${VERSION}"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" Publisher "${COMPANY}"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" URLInfoAbout "${URL}"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayIcon $INSTDIR\uninstall.exe
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" UninstallString $INSTDIR\uninstall.exe
    WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" NoModify 1
    WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" NoRepair 1
SectionEnd

# Macro for selecting uninstaller sections
!macro SELECT_UNSECTION SECTION_NAME UNSECTION_ID
    Push $R0
    ReadRegStr $R0 HKLM "${REGKEY}\Components" "${SECTION_NAME}"
    StrCmp $R0 1 0 next${UNSECTION_ID}
    !insertmacro SelectSection "${UNSECTION_ID}"
    GoTo done${UNSECTION_ID}
next${UNSECTION_ID}:
    !insertmacro UnselectSection "${UNSECTION_ID}"
done${UNSECTION_ID}:
    Pop $R0
!macroend

# Uninstaller sections
Section /o -un.Main UNSEC0000
	RMDir /r $INSTDIR\lib
	RMDir /r $INSTDIR\bin
	RMDir /r $INSTDIR\conf
    DeleteRegValue HKLM "${REGKEY}\Components" Main
SectionEnd

Section -un.post UNSEC0001
    DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)"
    ${un.EnvVarUpdate} $0 "PATH" "R" "HKLM" "$INSTDIR\bin"
	DeleteRegValue ${env_hklm} MU_HOME
	DeleteRegValue ${env_hklm} NV_HOME
	SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\Uninstall $(^Name).lnk"
	Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\nV kernel.lnk"
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\mU kernel.lnk"
    Delete /REBOOTOK $INSTDIR\uninstall.exe
    DeleteRegValue HKLM "${REGKEY}" StartMenuGroup
    DeleteRegValue HKLM "${REGKEY}" Path
    DeleteRegKey /IfEmpty HKLM "${REGKEY}\Components"
    DeleteRegKey /IfEmpty HKLM "${REGKEY}"
    RmDir /REBOOTOK $SMPROGRAMS\$StartMenuGroup
    RmDir /REBOOTOK $INSTDIR
SectionEnd

# Installer functions
Function .onInit
    InitPluginsDir
	
	ReadRegStr $0 HKLM "${REGKEY}\Components" Main
	${If} $0 == '1'
		MessageBox MB_OK 'A previous installation of maTHmU is detected. Please uninstall that first.'
		Abort
	${EndIf}
	
	ReadRegDWORD $0 HKLM "SOFTWARE\Wow6432Node\Microsoft\VisualStudio\10.0\VC\Runtimes\x86" Installed
	ReadRegDWORD $1 HKLM "SOFTWARE\Wow6432Node\Microsoft\VisualStudio\10.0\VC\VCRedist\x86" Installed
	ReadRegDWORD $2 HKLM "SOFTWARE\Microsoft\VisualStudio\10.0\VC\Runtimes\x86" Installed
	ReadRegDWORD $3 HKLM "SOFTWARE\Microsoft\VisualStudio\10.0\VC\VCRedist\x86" Installed
	${If} $0 != 1 
	${AndIf} $1 != 1 
	${AndIf} $2 != 1 
	${AndIf} $3 != 1
		MessageBox MB_OK 'maTHmU requires Visual C++ 2010 Redistributable Package (x86) to function properly. Please download and install that first.'
		Abort
	${EndIf}
FunctionEnd

# Uninstaller functions
Function un.onInit
    ReadRegStr $INSTDIR HKLM "${REGKEY}" Path
    !insertmacro MUI_STARTMENU_GETFOLDER Application $StartMenuGroup
    !insertmacro SELECT_UNSECTION Main ${UNSEC0000}
FunctionEnd

