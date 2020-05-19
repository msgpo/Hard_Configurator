#include <WinAPIProc.au3>
#include <Array.au3>
#include <Process.au3>
#include <Security.au3>
Global $cmdline
Local $command = ""
Local $command0 = ""
Local $temp
Local $sponsor
Local $commandScript

; Avoid infinite loop
Local $ProcessInfoNumber = ProcessList("ProcessInfo.exe")
If $ProcessInfoNumber[0][0] > 10 Then
   MsgBox(0, "ProcessInfo", "Error. The commandline is not supported.")
   Exit
EndIf


; Array of interpreters paths.
Local $sponsorNumber = 12
Local $SponsorPathArray[$sponsorNumber +1]
$SponsorPathArray[0] = $sponsorNumber
$SponsorPathArray[1] = @SystemDir & "\WindowsPowerShell\v1.0" & "\powershell"
$SponsorPathArray[2] = @WindowsDir & "\SysWOW64\" & "WindowsPowerShell\v1.0" & "\powershell"
$SponsorPathArray[3] = @SystemDir & "\" & "wscript"
$SponsorPathArray[4] = @WindowsDir & "\SysWOW64\" & "wscript"
$SponsorPathArray[5] = @SystemDir & "\" & "cscript"
$SponsorPathArray[6] = @WindowsDir & "\SysWOW64\" & "cscript"
$SponsorPathArray[7] = @SystemDir & "\" & "mshta"
$SponsorPathArray[8] = @WindowsDir & "\SysWOW64\" & "mshta"
$SponsorPathArray[9] = @WindowsDir & "\hh"
$SponsorPathArray[10] = @WindowsDir & "\SysWOW64\" & "hh"
$SponsorPathArray[11] = @SystemDir & "\" & "cmd"
$SponsorPathArray[12] = @WindowsDir & "\SysWOW64\" & "cmd"

; _ArrayDisplay($SponsorPathArray)

Local $InterpretersArray[$sponsorNumber +1]
$InterpretersArray[0] = $sponsorNumber
For $i=1 to $sponsorNumber
   $sponsor = StringReverse($SponsorPathArray[$i])
   $temp = StringInStr($sponsor, "\")
   $sponsor = StringTrimLeft($SponsorPathArray[$i], StringLen($SponsorPathArray[$i])-$temp + 1)
   $InterpretersArray[$i] = $sponsor
Next
Local $Interpreters = _ArrayUnique($InterpretersArray)
;_ArrayDelete($Interpreters,1)
$Interpreters[0] = UBound($Interpreters)-1
;_ArrayDisplay($Interpreters)

Local $gpuser = _WinAPI_GetProcessUser(0)
;_ArrayDisplay($gpuser)
Local $gas = _Security__SidToStringSid(_Security__GetAccountSid($gpuser[1] & "\" & $gpuser[0]))
;MsgBox(0,"",$gas)
;_ArrayDisplay($CmdLine)

; Full path of the parent of ProcessInfo.exe
Local $gp=_WinAPI_GetParentProcess(0)
Local $gpf=_WinAPI_GetProcessFileName($gp)
;MsgBox(0,"",$gpf)
; Only the name of the parent of ProcessInfo.exe
Local $sName = _ProcessGetName($gp)
;MsgBox(0,"",$gp)
;MsgBox(0,"",$sName)

; Full path of the grand-parent of ProcessInfo.exe
Local $ggp=_WinAPI_GetParentProcess($gp)
Local $ggpf=_WinAPI_GetProcessFileName($ggp)
;MsgBox(0,"",$ggpf)



; The initial command line
Local $gpcl = _WinAPI_GetProcessCommandLine($gp)
;MsgBox(0,"Initial command line",$sName & " " & $gpcl)
;Full path of ProcessInfo.exe
Local $gpfn = _WinAPI_GetProcessFileName(0)
;MsgBox(0,"",$gpfn)

Local $ise = _WinAPI_IsElevated()
;MsgBox(0,"",$ise)
Local $scriptPath
Local $scriptsponsor
If $CmdLine[0]>0 Then
   For $i=1 to UBound($CmdLine)-1
      $command = $command & " " & $CmdLine[$i]
      If StringInStr($CmdLine[$i], ".VBS") > 0 Then 
	$scriptPath = $CmdLine[$i] 
	If StringInStr($scriptPath, ":\") = 0 Then 
	   $scriptPath = CorrectTheScriptPath($i)
;	   MsgBox(0,"correct",$scriptPath)
	EndIf
      EndIf
      If StringInStr($CmdLine[$i], ".VBE") > 0 Then 
	$scriptPath = $CmdLine[$i]
	If StringInStr($scriptPath, ":\") = 0 Then 
	   $scriptPath = CorrectTheScriptPath($i)
;	   MsgBox(0,"correct",$scriptPath)
	EndIf
      EndIf
      If StringInStr($CmdLine[$i], ".JS") > 0 Then 
	$scriptPath = $CmdLine[$i] 
	If StringInStr($scriptPath, ":\") = 0 Then 
	   $scriptPath = CorrectTheScriptPath($i)
;	   MsgBox(0,"correct",$scriptPath)
	EndIf
      EndIf
      If StringInStr($CmdLine[$i], ".JSE") > 0 Then 
	$scriptPath = $CmdLine[$i] 
	If StringInStr($scriptPath, ":\") = 0 Then 
	   $scriptPath = CorrectTheScriptPath($i)
;	   MsgBox(0,"correct",$scriptPath)
	EndIf
      EndIf
      If StringInStr($CmdLine[$i], ".WSF") > 0 Then 
	$scriptPath = $CmdLine[$i] 
	If StringInStr($scriptPath, ":\") = 0 Then 
	   $scriptPath = CorrectTheScriptPath($i)
;	   MsgBox(0,"correct",$scriptPath)
	EndIf
      EndIf
      If StringInStr($CmdLine[$i], ".WSH") > 0 Then
	$scriptPath = $CmdLine[$i] 
	If StringInStr($scriptPath, ":\") = 0 Then 
	   $scriptPath = CorrectTheScriptPath($i)
;	   MsgBox(0,"correct",$scriptPath)
	EndIf
      EndIf
      If StringInStr($CmdLine[$i], ".PS1") > 0 Then
	$scriptPath = $CmdLine[$i] 
	If StringInStr($scriptPath, ":\") = 0 Then 
	   $scriptPath = CorrectTheScriptPath($i)
;	   MsgBox(0,"correct",$scriptPath)
	EndIf
      EndIf
      If StringInStr($CmdLine[$i], ".HTA") > 0 Then
	$scriptPath = $CmdLine[$i] 
	If StringInStr($scriptPath, ":\") = 0 Then 
	   $scriptPath = CorrectTheScriptPath($i)
;	   MsgBox(0,"correct",$scriptPath)
	EndIf
      EndIf
      If StringInStr($CmdLine[$i], ".CHM") > 0 Then
	$scriptPath = $CmdLine[$i] 
	If StringInStr($scriptPath, ":\") = 0 Then 
	   $scriptPath = CorrectTheScriptPath($i)
;	   MsgBox(0,"correct",$scriptPath)
	EndIf
      EndIf
      If StringInStr($CmdLine[$i], ".PS1") > 0 Then
	$scriptPath = $CmdLine[$i] 
	If StringInStr($scriptPath, ":\") = 0 Then 
	   $scriptPath = CorrectTheScriptPath($i)
;	   MsgBox(0,"correct",$scriptPath)
	EndIf
      EndIf
      If StringInStr($CmdLine[$i], ".BAT") > 0 Then
	$scriptPath = $CmdLine[$i] 
	If StringInStr($scriptPath, ":\") = 0 Then 
	   $scriptPath = CorrectTheScriptPath($i)
;	   MsgBox(0,"correct",$scriptPath)
	EndIf
      EndIf
      If StringInStr($CmdLine[$i], ".CMD") > 0 Then
	$scriptPath = $CmdLine[$i] 
	If StringInStr($scriptPath, ":\") = 0 Then 
	   $scriptPath = CorrectTheScriptPath($i)
;	   MsgBox(0,"correct",$scriptPath)
	EndIf
      EndIf
   Next
   $command = StringTrimLeft($command, 1)
   $scriptsponsor = ""
   For $i=1 to $sponsorNumber
      If StringInStr($command, $SponsorPathArray[$i]) =1 Then $scriptsponsor = $SponsorPathArray[$i]
   Next
   If $Interpreters[0] > 0 Then
      For $i=1 to $Interpreters[0]
         If StringInStr($command, $Interpreters[$i] & " ") =1 Then
	    $scriptsponsor = @SystemDir & "\" & $Interpreters[$i]
	    $command = StringReplace($command, $Interpreters[$i] & " ", @SystemDir & "\" & $Interpreters[$i] & " ", 1)
            If $Interpreters[$i] = "powershell" Then            
		$scriptsponsor = @SystemDir & "\WindowsPowerShell\v1.0" & "\powershell"
MsgBox(0,"power",$scriptsponsor & @crlf & @crlf & $command)
		$command = StringReplace($command, @SystemDir & "\powershell" & " ", @SystemDir & "\WindowsPowerShell\v1.0" & "\powershell" & " ", 1)
	    EndIf
            If $Interpreters[$i] = "hh" Then
		$scriptsponsor = @WindowsDir & "\hh"
		$command = StringReplace($command, @SystemDir & "\hh", @WindowsDir & "\hh" & " ", 1)
	    EndIf
         EndIf
         If StringInStr($command, $Interpreters[$i] & ".exe") =1 Then
	    $scriptsponsor =  @SystemDir & "\" & $Interpreters[$i]
	    $command = StringReplace($command, $Interpreters[$i], @SystemDir & "\" & $Interpreters[$i], 1)
            If $Interpreters[$i] = "powershell" Then 
		$scriptsponsor = @SystemDir & "\WindowsPowerShell\v1.0" & "\powershell"
		$command = StringReplace($command, @SystemDir & "\powershell", @SystemDir & "\WindowsPowerShell\v1.0" & "\powershell", 1)
	    EndIf
            If $Interpreters[$i] = "hh" Then 
		$scriptsponsor = @WindowsDir & "\hh"
		$command = StringReplace($command, @SystemDir & "\hh", @WindowsDir & "\hh", 1)
	    EndIf
         EndIf
      Next
;   MsgBox(0,"interpreter", $scriptsponsor)
   EndIf
   Local $ExeExtension = ".exe"
   If $scriptsponsor = "" Then $ExeExtension =""
   FileWrite("e:\ProcessInfo.log", "Grand-Parent process: " & $ggpf & @crlf & @crlf & "Parent process: " & $gpf & @crlf & @crlf & "The initial command line: " & $gpcl & @crlf & @crlf & "Script path: " & $scriptPath & @crlf & @crlf & "Interpreter path: " & $scriptsponsor & $ExeExtension & @crlf & @crlf & "commandline: " & $command & @crlf & @crlf & "*****************************************" & @crlf & @crlf & @crlf)
;   MsgBox(0,"", "Initial command" & @crlf & $command)
   If $scriptsponsor = "" Then
	MsgBox(0,"","Blocked execution - wrong interpreter.")
        Exit
   EndIf
   $command0 = $command

   For $i=1 to $sponsorNumber
	If $scriptsponsor = $SponsorPathArray[$i] Then
	   If $SponsorPathArray[$i] = @SystemDir & "\" & "cmd" Then 
		MsgBox(0,"ProcessInfo", "CMD Shell is blocked.")
		Exit
	   EndIf
	   If $SponsorPathArray[$i] = @WindowsDir & "\SysWOW64\" & "cmd" Then 
		MsgBox(0,"ProcessInfo","CMD Shell is blocked.")
		Exit
	   EndIf
	   $sponsor = StringReverse($scriptsponsor)
	   $temp = StringInStr($sponsor, "\")
	   $sponsor = StringTrimLeft($scriptsponsor, StringLen($scriptsponsor)-$temp + 1)
           $scriptsponsor = $scriptsponsor & ".exe"
	   $sponsor = $sponsor & ".exe"
           If StringInStr($command, $scriptsponsor) = 0 Then
              $command0 = StringReplace($command, $SponsorPathArray[$i], $scriptsponsor)          
	   EndIf
           $commandScript = StringReplace($command0, $scriptsponsor, @TempDir & "\sss" & $sponsor)
;	   Correction of script paths with spaces
	   If (StringInStr($commandScript, " ") >0 And $scriptPath <> "") Then
		$commandScript = StringReplace($commandScript, $scriptPath, chr(34) & $scriptPath & chr(34))
	   EndIf
	   FileCopy($scriptsponsor, @TempDir & "\sss" & $sponsor)
;           MsgBox(0,"From Script","Initial commandline: " & $command & @crlf & @crlf & "Script path: " & $scriptPath & @crlf & @crlf & "Final commandline: " & $commandScript & @crlf & @crlf & "Interpreter path: " & $scriptsponsor)
           MsgBox(0,"From Script","Final commandline: " & $commandScript)
	   RunWait($commandScript)
           FileDelete(@TempDir & "\sss" & $sponsor)
	EndIf
   Next
EndIf


Func CorrectTheScriptPath($IsExtNumber)
Local $result = $cmdline[$IsExtNumber]
For $j = $IsExtNumber to 1 Step -1
   $result = $cmdline[$j-1] & " " & $result
   MsgBox(0,"correct sub",$result)
   If StringInStr($result, ":\") > 0 Then Return $result
Next
Return $result
EndFunc



Func _ProcessGetLocation($iPID)
    Local $aProc = DllCall('kernel32.dll', 'hwnd', 'OpenProcess', 'int', BitOR(0x0400, 0x0010), 'int', 0, 'int', $iPID)
    If $aProc[0] = 0 Then Return SetError(1, 0, '')
    Local $vStruct = DllStructCreate('int[1024]')
    DllCall('psapi.dll', 'int', 'EnumProcessModules', 'hwnd', $aProc[0], 'ptr', DllStructGetPtr($vStruct), 'int', DllStructGetSize($vStruct), 'int_ptr', 0)
    Local $aReturn = DllCall('psapi.dll', 'int', 'GetModuleFileNameEx', 'hwnd', $aProc[0], 'int', DllStructGetData($vStruct, 1), 'str', '', 'int', 2048)
    If StringLen($aReturn[3]) = 0 Then Return SetError(2, 0, '')
    Return $aReturn[3]
EndFunc