#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=C:\Windows\Hard_Configurator\Icons\RAS.ico
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_Res_Comment=Compiled with AutoIt 3.3.14.2
#AutoIt3Wrapper_Res_Description=RunAsSmartScreen, Run files with SmartScreen check and Administrative Rights
#AutoIt3Wrapper_Res_Fileversion=2.1.0.1
#AutoIt3Wrapper_Res_LegalCopyright=Copyright *  Andy Ful , April 2019
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
; This script can run the executable files with Administrative Rights + SmartScreen.
; If the file is in User Space the program adds "Mark of the Web" , so it is run with SmartScreen check.
; If the file is in System Space (Windows, Program Files, Program Files (x86)) then the SmartScreen
; check is skipped.
; Only EXE and MSI files are supported

#include <Array.au3>
#include <File.au3>
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
;#RequireAdmin
;#include <WinAPIProc.au3>
Local $FileDrive='' 
Local $Filename=''
Local $FilePath=''
Local $FileExt=''
Local $IsSmartScreenEnabled = 1

;Run parameters check 
If $CmdLine[0] = 0 Then 
   MsgBox(262144,"","Use with executable file path, for example:" & @CRLF & "RunAsSmartscreen.exe FilePath")
   Exit
EndIf

;Commandline parameters check. If greater than 1 then block with alert.
If $CmdLine[0] > 1 Then
    MsgBox(262144,"","The file has been blocked. It has tried to run with the command line. This is the common way used by malware to change system settings or run malicious scripts. Run this file only if you are certain that it is safe.")
    Exit
EndIf

_PathSplit ( $CmdLine[1], $FileDrive, $FilePath, $Filename, $FileExt)
Local $FileSystem = DriveGetFileSystem ($FileDrive)

;MsgBox(262144,"",$Cmdline[1] & @CRLF & $FilePath & @CRLF & $Filename & @CRLF & $FileExt )

$FileExt = StringLower($FileExt)

If not ($FileExt = ".exe" or $FileExt = ".msi") Then
   MsgBox(262144,"","Only EXE and MSI files are supported by 'Run As SmartScreen'")
   Exit
EndIf

;Test if SmartScreen is Enabled
If (@OSVersion="WIN_10" or @OSVersion="WIN_81" or @OSVersion="WIN_8") Then
   Local $ES1 = RegRead('HKLM\SOFTWARE\Policies\Microsoft\Windows\System', 'EnableSmartScreen')
   If @error<>0  Then $ES1 = 'ERROR'
   Local $ES2 = RegRead('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer', 'SmartScreenEnabled')
   If @error<>0 Then $ES2 = 'ERROR'
   If $ES1='0' Then
      $IsSmartScreenEnabled = 0
   Else
      IF ($ES2='Off' and $ES1='ERROR') Then $IsSmartScreenEnabled = 0
   EndIf
   If ($ES1 = 'ERROR' and $ES2 = 'ERROR') Then
      RegWrite ('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer', 'SmartScreenEnabled', 'REG_SZ', 'Prompt')
      $IsSmartScreenEnabled = 1
   EndIf
EndIf
If not (@OSVersion="WIN_10" or @OSVersion="WIN_81" or @OSVersion="WIN_8") Then
   MsgBox(262144,"","'Run As SmartScreen' is not supported in this version of Windows.")
   Exit
EndIf
If $IsSmartScreenEnabled = 0 Then
   MsgBox(262144,"","The SmartScreen is disabled. Please enable it to make use of 'Run As SmartScreen'")
   Exit
EndIf


;Manage non NTFS drives = copy file to @TempDir on the system hard drive.
If not ($FileSystem="NTFS") Then 
FileCopy ( $CmdLine[1], @TempDir & '\' & $Filename & $FileExt)
$CmdLine[1] = @TempDir & '\' & $Filename & $FileExt
EndIf

;Trim file path to compare next with Windows, Program Files, and Program Files (x86).
Local $x = StringLeft($CmdLine[1],11)
Local $y = StringLeft($CmdLine[1],17)
Local $z = StringLeft($CmdLine[1],23)
Local $PF86=1
Local $Smartscreen = 1

;Check for false "Program Files (x86)" folder in 32Bit Windows
If (@OSArch='X86' and FileExists ( @ProgramFilesDir & ' (x86)\') = 1) then $PF86=0

;Exclude System Space from SmartScreen check
If StringLower($x) = StringLower(@WindowsDir & '\') Then $Smartscreen = 0
If StringLower($y)=StringLower(@ProgramFilesDir & '\') Then $Smartscreen = 0
If ($PF86=1 and StringLower($z)=StringLower(@ProgramFilesDir & ' (x86)\')) then $Smartscreen = 0

;Manage Alternate Data Stream to force SmartScreen check
If $Smartscreen = 1 Then
   If not ($FileExt = ".bat" or $FileExt = ".cmd" or $FileExt = ".com" or $FileExt = ".cpl" or $FileExt = ".dll" or $FileExt = ".exe" or $FileExt = ".jse" or $FileExt = ".msi"  or $FileExt = ".ocx" or $FileExt = ".scr" or $FileExt = ".vbe") Then
      MsgBox(262144,"", "The  " & $FileExt & "  files are not supported by SmartScreen App on the run.")
      Exit
   EndIf
   FileSetAttrib($CmdLine[1],"-RHS")
   ADS_Delete($CmdLine[1])   
   ADS_ADD($CmdLine[1])
;  Special alert for DLL and OCX files   
   If ($FileExt = ".dll" or $FileExt = ".ocx") Then
      MsgBox(262144,"", "The 'Mark of the Web' was added to  " & $Filename & $FileExt & "  file.")
      Exit
   EndIf
EndIf

;Finally, run the file
Local $MSIPid = ShellExecute($CmdLine[1],"",$FileDrive & $FilePath, "runas")
; Exit when chosing 'Do not Run' from SmartScreen prompt.
If ($MSIPid=0) Then Exit


; Functions

Func ADS_ADD($sFilename)
;Add "Mark of the Web"
  Local $sZoneIDFileName
  ; Streams are assembled as "filename" + ":" + "Stream_ID"
  $sZoneIDFileName = FileWriteLine($sFilename & ":Zone.Identifier","[ZoneTransfer]")
  $sZoneIDFileName = FileWriteLine($sFilename & ":Zone.Identifier","ZoneId=3") 
  ;Test if the 'Mark of the Web' was properly written
  Local $isOK1 = FileReadLine($sFilename & ":Zone.Identifier",1)
  Local $isOK2 = FileReadLine($sFilename & ":Zone.Identifier",2)
  If ($isOK1 = "[ZoneTransfer]" and $isOK2 = "ZoneId=3") Then
     Return
  Else
     MsgBox(262144,"", "Write access error. The 'Mark of the Web' was skipped. The file  " & $sFilename & "  cannot be 'Run As SmartScreen'")
     Exit
  EndIf

EndFunc


Func ADS_Delete($sFilename)
;Delete Alternate Data Stream used by SmartScreen to mark files
    Local $aRet, $sZoneIDFileName
    ; Streams are assembled as "filename" + ":" + "Stream_ID"
    $sZoneIDFileName = $sFilename & ":Zone.Identifier"

    ; Make sure the stream exists
    If FileExists($sZoneIDFileName) Then
        ; While FileExists() works, FileDelete() doesn't, probably due to some internal sanity checks
        $aRet = DllCall("kernel32.dll", "bool", "DeleteFileW", "wstr", $sZoneIDFileName)
        If @error Then Return SetError(2, @error,0)
        Return $aRet[0]
    EndIf
    Return 0
EndFunc


Func IsMarkOfTheWeb($Filename)
 ;Test if the 'Mark of the Web' was properly written
  Local $isOK1 = FileReadLine($Filename & ":Zone.Identifier",1)
  Local $isOK2 = FileReadLine($Filename & ":Zone.Identifier",2)
  If ($isOK1 = "[ZoneTransfer]" and $isOK2 = "ZoneId=3") Then
     Return "1"
  Else 
     Return "0"
  EndIf
EndFunc

Func IsSRPDefaultDeny()
  Local $keyname = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers"
  Local $valuename = "DefaultLevel"
  Local $SRPDefaultLevel = RegRead ( $keyname, $valuename )
  Switch $SRPDefaultLevel
     case "0"
        Return "1"
     case 131072
        Return "1"
     case Else
        Return "?"
  EndSwitch
EndFunc

