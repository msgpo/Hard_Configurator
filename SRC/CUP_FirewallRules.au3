#include <Array.au3>
; Number of rules for programs in %systemroot%\system32 and %systemroot%\SysWOW64 folders.
Global $numberOfrules = 56
Global $ArrayFirewallRules[$numberOfrules +1]
$ArrayFirewallRules[0] = $numberOfrules
$ArrayFirewallRules[1] = "%systemroot%\system32\calc.exe"
$ArrayFirewallRules[2] = "%systemroot%\system32\certutil.exe"
$ArrayFirewallRules[3] = "%systemroot%\system32\cmstp.exe"
$ArrayFirewallRules[4] = "%systemroot%\system32\cscript.exe"
$ArrayFirewallRules[5] = "%systemroot%\system32\esentutl.exe"
$ArrayFirewallRules[6] = "%systemroot%\system32\expand.exe"
$ArrayFirewallRules[7] = "%systemroot%\system32\extrac32.exe"
$ArrayFirewallRules[8] = "%systemroot%\system32\findstr.exe"
$ArrayFirewallRules[9] = "%systemroot%\system32\hh.exe"
$ArrayFirewallRules[10] = "%systemroot%\system32\makecab.exe"
$ArrayFirewallRules[11] = "%systemroot%\system32\mshta.exe"
$ArrayFirewallRules[12] = "%systemroot%\system32\msiexec.exe"
$ArrayFirewallRules[13] = "%systemroot%\system32\nltest.exe"
$ArrayFirewallRules[14] = "%systemroot%\system32\Notepad.exe"
$ArrayFirewallRules[15] = "%systemroot%\system32\pcalua.exe"
$ArrayFirewallRules[16] = "%systemroot%\system32\print.exe"
$ArrayFirewallRules[17] = "%systemroot%\system32\powershell.exe"
$ArrayFirewallRules[18] = "%systemroot%\system32\powershell_ise.exe"
$ArrayFirewallRules[19] = "%systemroot%\system32\regsvr32.exe"
$ArrayFirewallRules[20] = "%systemroot%\system32\replace.exe"
$ArrayFirewallRules[21] = "%systemroot%\system32\rundll32.exe"
$ArrayFirewallRules[22] = "%systemroot%\system32\runscripthelper.exe"
$ArrayFirewallRules[23] = "%systemroot%\system32\scriptrunner.exe"
$ArrayFirewallRules[24] = "%systemroot%\system32\SyncAppvPublishingServer.exe"
$ArrayFirewallRules[25] = "%systemroot%\system32\wmic.exe"
$ArrayFirewallRules[26] = "%systemroot%\system32\wscript.exe"
$ArrayFirewallRules[27] = "%systemroot%\SysWOW64\calc.exe"
$ArrayFirewallRules[28] = "%systemroot%\SysWOW64\certutil.exe"
$ArrayFirewallRules[29] = "%systemroot%\SysWOW64\cmstp.exe"
$ArrayFirewallRules[30] = "%systemroot%\SysWOW64\cscript.exe"
$ArrayFirewallRules[31] = "%systemroot%\SysWOW64\esentutl.exe"
$ArrayFirewallRules[32] = "%systemroot%\SysWOW64\expand.exe"
$ArrayFirewallRules[33] = "%systemroot%\SysWOW64\extrac32.exe"
$ArrayFirewallRules[34] = "%systemroot%\SysWOW64\findstr.exe"
$ArrayFirewallRules[35] = "%systemroot%\SysWOW64\hh.exe"
$ArrayFirewallRules[36] = "%systemroot%\SysWOW64\makecab.exe"
$ArrayFirewallRules[37] = "%systemroot%\SysWOW64\mshta.exe"
$ArrayFirewallRules[38] = "%systemroot%\SysWOW64\msiexec.exe"
$ArrayFirewallRules[39] = "%systemroot%\SysWOW64\nltest.exe"
$ArrayFirewallRules[40] = "%systemroot%\SysWOW64\Notepad.exe"
$ArrayFirewallRules[41] = "%systemroot%\SysWOW64\pcalua.exe"
$ArrayFirewallRules[42] = "%systemroot%\SysWOW64\print.exe"
$ArrayFirewallRules[43] = "%systemroot%\SysWOW64\powershell.exe"
$ArrayFirewallRules[44] = "%systemroot%\SysWOW64\powershell_ise.exe"
$ArrayFirewallRules[45] = "%systemroot%\SysWOW64\regsvr32.exe"
$ArrayFirewallRules[46] = "%systemroot%\SysWOW64\replace.exe"
$ArrayFirewallRules[47] = "%systemroot%\SysWOW64\rpcping.exe"
$ArrayFirewallRules[48] = "%systemroot%\SysWOW64\rundll32.exe"
$ArrayFirewallRules[49] = "%systemroot%\SysWOW64\runscripthelper.exe"
$ArrayFirewallRules[50] = "%systemroot%\SysWOW64\scriptrunner.exe"
$ArrayFirewallRules[51] = "%systemroot%\SysWOW64\SyncAppvPublishingServer.exe"
$ArrayFirewallRules[52] = "%systemroot%\SysWOW64\wmic.exe"
$ArrayFirewallRules[53] = "%systemroot%\SysWOW64\wscript.exe"
$ArrayFirewallRules[54] = "%systemroot%\System32\rpcping.exe"
$ArrayFirewallRules[55] = chr(34) & "C:\Program Files\Microsoft Office\root\client\AppVLP.exe" & chr(34)
$ArrayFirewallRules[56] = chr(34) & "C:\Program Files\Microsoft Office\root\client\AppVLP.exe" & chr(34)

;WriteFirewallRules()
;DeleteFirewallRules('HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\FirewallRules')
;MsgBox(0,"",CheckFirewallRules('HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\FirewallRules'))


Func CheckFirewallRules($key)
Local $FirewallActiveRules[1]
Local $mainkey = $key
Local $mainkeyVal
Local $data
Local $RuleName
$data = RegEnumVal($mainkey, 2)
Local $FirewallActiveRules[1]
Local $i = 1
While RegEnumVal($mainkey, $i) <> ""
  $mainkeyVal = RegEnumVal($mainkey, $i)
  $data = RegRead($mainkey, $mainkeyVal)
  If StringInStr($data, "|Name=CUP_for_") > 0 Then 
    $data = StringReplace($data, "|", "!")
    _ArrayAdd( $FirewallActiveRules, $data)
  EndIf
  $i=$i+1
WEnd
;_ArrayDisplay($FirewallActiveRules)
$FirewallActiveRules[0] = UBound($FirewallActiveRules)-1

$n = 0
For $i=1 To UBound($FirewallActiveRules) - 1
;  MsgBox(0 ,"", $data)
   $data = $FirewallActiveRules[$i]
  For $j=1 To $numberOfrules
    $RuleName = StringRight($ArrayFirewallRules[$j], StringLen($ArrayFirewallRules[$j])-13)
    $RuleName = "CUP_for_" & StringReplace($RuleName, "\", "_")
    If $j=55 Then $RuleName = "CUP_for_AppVLP.exe"
    If $j=56 Then $RuleName = "CUP_for_(x86)_AppVLP.exe"
;    MsgBox(0,"", $data & @crlf & $RuleName)
    If StringInStr($data, $RuleName) > 0 Then 
       $n = $n + 1
;       MsgBox(0 ,"", $data)
    EndIf
  Next
Next
;   MsgBox(0,"", $n)
Switch $n
   case $numberOfrules
	Return "ON"
   case 0 
	Return "OFF"
   case Else
	Return "Custom"
EndSwitch
EndFunc


Func WriteFirewallRules()
Local $mainkey = 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules'
Local $policykey = 'HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\FirewallRules'
Local $RuleName
Local $mainkeyVal
Local $data
Local $i
;_ArrayDisplay($ArrayFirewallRules)
SplashTextOn ( "CUP Firewall", "Writing Windows Firewall rules.", 300, 50, -1, -1, -1, -1, 10)
   For $j=1 To $numberOfrules
      $RuleName = StringRight($ArrayFirewallRules[$j], StringLen($ArrayFirewallRules[$j])-13)
      $RuleName = "CUP_for_" & StringReplace($RuleName, "\", "_")
      If $j=55 Then $RuleName = "CUP_for_AppVLP.exe"
      If $j=56 Then $RuleName = "CUP_for_(x86)_AppVLP.exe"
      Run("netsh advfirewall firewall add rule name=" & $RuleName & " program=" & $ArrayFirewallRules[$j] & " protocol=any dir=out enable=yes action=block profile=any", "", @SW_MINIMIZE)
   Next

$i = 1
While  CheckFirewallRules($mainkey) <> "ON"
   Sleep(100) 
   If $i > 1000 Then
      MsgBox(0,"", "Error. CUP cannot apply all required firewall rules.")
      Return
   EndIf
   $i = $i + 1
WEnd


  $i = 1
  While (RegEnumVal($mainkey, $i)<>"")
     $mainkeyVal = RegEnumVal($mainkey, $i)
     $data = RegRead($mainkey, $mainkeyVal)
     If StringInStr($data, "|Name=CUP_for_") > 0 Then RegWrite($policykey, $mainkeyVal, 'REG_SZ', $data)
     $i = $i +1
  WEnd
DeleteFirewallRules($mainkey)
SplashOff()
EndFunc


Func DeleteTempFirewallRules($key)
Local $mainkey = $key
Local $mainkeyVal
Local $data
Local $i
$i = 1
While (RegEnumVal($mainkey, $i)<>"")
  $mainkeyVal = RegEnumVal($mainkey, $i)
  $data = RegRead($mainkey, $mainkeyVal)
  If StringInStr($data, "|Name=CUP_for_") > 0 Then RegDelete($mainkey, $mainkeyVal)
  $i = $i +1
WEnd
EndFunc


Func DeleteFirewallRules($key)
Local $i = 1
  While  CheckFirewallRules($key) <> "OFF"
     DeleteTempFirewallRules($key)
     If $i > 20 Then
       MsgBox(0,"", "Error. Cannot delete some temporary firewall rules")   
       Return
     EndIf
     $i = $i + 1
  WEnd
;MsgBox(0,"delete loop", $i)
EndFunc