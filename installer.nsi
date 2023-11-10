OutFile "obs-multistream-setup.exe"

Unicode true
RequestExecutionLevel user

SetDatablockOptimize on
SetCompress auto
SetCompressor /SOLID lzma

Name "OBS-Multistream"
Caption "Multi RTMP Output Plugin for OBS Studio"
Icon "${NSISDIR}\Contrib\Graphics\Icons\win-install.ico"

Var /Global DefInstDir
Function .onInit
    ReadEnvStr $0 "ALLUSERSPROFILE"
    StrCpy $DefInstDir "$0\obs-studio\plugins\obs-multistream"
    StrCpy $INSTDIR "$DefInstDir"

    IfFileExists "$DefInstDir\*.*" AskUninst DontAskUninst
    AskUninst:
        MessageBox MB_YESNO|MB_ICONQUESTION "Uninstall obs-multi-rtmp?" IDYES DoUninst IDNO NotDoUninst
    DoUninst:
        RMDir /r "$DefInstDir"
        MessageBox MB_OK|MB_ICONINFORMATION "Done."
        Quit
    NotDoUninst:
    DontAskUninst:
FunctionEnd

Function onDirPageLeave
StrCmp "$INSTDIR" "$DefInstDir" DirNotModified DirModified
DirModified:
MessageBox MB_OK|MB_ICONSTOP "Please don't change the install directory."
Abort
DirNotModified:
FunctionEnd

Page directory "" "" onDirPageLeave
Page instfiles

Section
SetOutPath "$INSTDIR\bin\64bit"
File "release\RelWithDebInfo\obs-plugins\64bit\obs-multistream.dll"
File "release\RelWithDebInfo\obs-plugins\64bit\obs-multistream.pdb"

SetOutPath "$INSTDIR\data\locale"
File "release\RelWithDebInfo\data\obs-plugins\obs-multistream\locale\*.ini"
SectionEnd

Section "Uninstaller"
RMDir /r /REBOOTOK "$INSTDIR\plugins\obs-multistream"
SectionEnd
