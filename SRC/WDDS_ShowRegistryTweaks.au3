Func WDDS_ShowRegistryTweaks()
Local $tempvalue
Local $iskey
;Read Rregistry keys to be tweaked


Local $keyname = 'HKLM\Software\Policies\Microsoft\Windows\PowerShell'
Local $valuename = 'EnableScripts'
$NoPowerShellExecution = RegRead ( $keyname, $valuename )
$iskey = @error
Switch $NoPowerShellExecution
   case 1
      $NoPowerShellExecution = "OFF"
   case 0
      $NoPowerShellExecution = "ON"
   case Else
     $NoPowerShellExecution = "?"
EndSwitch
If ($iskey = -1 or $iskey =1) Then $NoPowerShellExecution = "OFF"


$keyname = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers"
$valuename = "DefaultLevel"
$SRPDefaultLevel = RegRead ( $keyname, $valuename )
$iskey = @error
Switch $SRPDefaultLevel
   case '0'
      $SRPDefaultLevel = "White List"
   case 262144
      $SRPDefaultLevel = "Allow All"
   case 131072
      $SRPDefaultLevel = "Basic User"
   case Else
      $SRPDefaultLevel = "?"
EndSwitch
If ($iskey = -1 or $iskey =1) Then $SRPDefaultLevel = "OFF"


$valuename = "TransparentEnabled"
$SRPTransparentEnabled =  RegRead ( $keyname, $valuename )
$iskey = @error
Switch $SRPTransparentEnabled
   case '0'
      $SRPTransparentEnabled = "No Enforcement"
   case 1
      $SRPTransparentEnabled = "Skip DLLs"
   case 2
      $SRPTransparentEnabled = "Include DLLs"
  case Else
      $SRPTransparentEnabled = "?"
EndSwitch
If ($iskey = -1 or $iskey =1) Then $SRPTransparentEnabled = "OFF"


If ($SRPTransparentEnabled = "No Enforcement" or $SRPTransparentEnabled = "Skip DLLs" or $SRPTransparentEnabled = "Include DLLs") Then
   If ($SRPDefaultLevel = "White List" or $SRPDefaultLevel = "Allow All" or $SRPDefaultLevel = "Basic User") Then
        $isSRPinstalled = "Installed"
   Else
      $isSRPinstalled = "Not Installed"
   EndIf
Else
   $isSRPinstalled = "Not Installed"
EndIf


If $isSRPinstalled = "Not Installed" Then
   RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers')
   RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers', 'AuthenticodeEnabled','REG_DWORD',Number('0'))
   RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers', 'Installed','REG_DWORD',Number('1'))
EndIf


If $isSRPinstalled = "Installed" Then
Local $whitelist = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers\262144\Paths'
Local $key = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers'
_RegCopyKey($key & '\Temp\262144\FirstRunWhitelist', $whitelist)
RegDelete($key & '\Temp\262144\FirstRunWhitelist')
EndIf


If $isSRPinstalled = "Installed" Then
   CheckOld_PS_CMD()
EndIf


$WritableSubWindows =  CheckWritableSubWindows()
   Switch $WritableSubWindows
      case "0"
         $WritableSubWindows = "OFF"
      case 1
        $WritableSubWindows = "ON"
      case Else
         $WritableSubWindows = "?"
   EndSwitch
If ($SRPTransparentEnabled = "No Enforcement" or $SRPTransparentEnabled = "not found" or $SRPTransparentEnabled = "?") Then
   $WritableSubWindows = "OFF"
EndIf


local $guidname = '{1016bbe0-a716-428b-822e-5E544B6A3301}'
$keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\0\paths\' & $guidname
$valuename = "ItemData"
$DenyShortcuts = RegRead ( $keyname, $valuename )
$iskey = @error
Switch $DenyShortcuts
   case "*.lnk"
      $DenyShortcuts = "ON"
   case Else
      $DenyShortcuts = "?"
EndSwitch
If ($iskey = -1 or $iskey =1) Then $DenyShortcuts = "OFF"
If ($SRPTransparentEnabled = "No Enforcement" or $SRPTransparentEnabled = "not found" or $SRPTransparentEnabled = "?") Then
   $DenyShortcuts = "OFF"
EndIf

CheckStateOfSponsorsCheckboxes()


If RegRead('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers\262144\Paths\{1016bbe0-a716-428b-822e-DE544B6A3520}', 'ItemData')='*.exe' Then
If StringInStr($_PathNumber, '*.exe') = 0 Then $_PathNumber = $_PathNumber & ' ; Allow EXE'
EndIf


Local $keyname1 = "HKCR\*\shell\Run As SmartScreen\command"
Local $keyname2 = "HKCR\*\shell\Run By SmartScreen\command"
$valuename = ""
$RunAsSmartScreen = RegRead ( $keyname1, $valuename )
$iskey = @error
RegRead ( $keyname2, $valuename )
$iskey = $iskey & @error
$RunAsSmartScreen = $RunAsSmartScreen & RegRead ( $keyname2, $valuename )
select
   case $RunAsSmartScreen = @WindowsDir & '\Hard_Configurator\RunAsSmartscreen(x64).exe "%1" %*'
        $RunAsSmartScreen = "Administrator"
   case $RunAsSmartScreen = @WindowsDir & '\Hard_Configurator\RunAsSmartscreen(x86).exe "%1" %*'
        $RunAsSmartScreen = "Administrator"
   case $RunAsSmartScreen = @WindowsDir & '\Hard_Configurator\RunBySmartscreen(x64).exe "%1" %*'
        $RunAsSmartScreen = "Standard User"
   case $RunAsSmartScreen = @WindowsDir & '\Hard_Configurator\RunBySmartscreen(x86).exe "%1" %*'
        $RunAsSmartScreen = "Standard User"
   case $iskey = "11"
        $RunAsSmartScreen = "OFF"
   case Else
        If not ($iskey = "01" or $iskey = "10") Then
            MsgBox(262144,"","Configuration error - 'Run As SmartScreen' setting changed to 'OFF'.")
        EndIf
        RegDelete('HKCR\*\shell\Run As SmartScreen')
        RegDelete('HKCR\*\shell\Run By SmartScreen')
        $RunAsSmartScreen = "OFF"
EndSelect


$keyname = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$valuename = "HideRunAsVerb"
$HideRunAsAdmin = RegRead ( $keyname, $valuename )
$iskey = @error
Switch $HideRunAsAdmin
   case 0
      $HideRunAsAdmin = "OFF"
   case 1
      $HideRunAsAdmin = "ON"
   case Else
      $HideRunAsAdmin = "?"
EndSwitch
If ($iskey = -1 or $iskey =1) Then $HideRunAsAdmin = "OFF"

$keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
Local $keyRemoteShell = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service\WinRS'
Local $keyRemoteRegistry = 'HKLM\SYSTEM\CurrentControlSet\Services\RemoteRegistry'
$valuename = 'fAllowUnsolicited'
Local $valuename1 = 'fAllowToGetHelp'
Local $valuename2 = 'fDenyTSConnections'
Local $valRemoteRegistry = 'Start'
@error = 0
Local $valRemoteShell =  RegRead ( $keyRemoteShell, 'AllowRemoteShellAccess' )
If not (@error = 0) Then
   RegWrite($keyRemoteShell,'AllowRemoteShellAccess','REG_DWORD', Number('1'))
   $valRemoteShell = '1'
EndIf
$BlockRemoteAccess = RegRead ( $keyname, $valuename )
$iskey = @error
$BlockRemoteAccess = $BlockRemoteAccess & RegRead ( $keyname, $valuename1 )
$iskey = $iskey & @error
$BlockRemoteAccess = $BlockRemoteAccess & RegRead ( $keyname, $valuename2 )
$iskey = $iskey & @error
$BlockRemoteAccess = $BlockRemoteAccess & $valRemoteShell
Local $StartTypeRemoteRegistry = RegRead ( $keyRemoteRegistry, $valRemoteRegistry )
;Default Windows 7 and prior versions value is Remote Registry service set to MANUAL (=3).
;Default Windows 8+ default value is Disable Remote Registry service (=4)!
;So 'Block Remote Access' OFF setting is calculated here without counting the value of Remote Access.
;MsgBox(262144,"",$iskey  & "    " & $BlockRemoteAccess & "      " & $StartTypeRemoteRegistry)
select
   case ($BlockRemoteAccess = '0010' and $StartTypeRemoteRegistry = '4')
      $BlockRemoteAccess = "ON"
   case ($iskey = '-1-1-1' and $valRemoteShell = '1' )
      $BlockRemoteAccess = "OFF"
   case $BlockRemoteAccess = '1101'
      $BlockRemoteAccess = "OFF"
   case Else
      $BlockRemoteAccess = "?"
EndSelect


$keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat'
$valuename = 'VDMDisallowed'
$Disable16Bits = RegRead ( $keyname, $valuename )
$iskey = @error
Switch $Disable16Bits
   case '0'
     $Disable16Bits = 'OFF'
   case 1
     $Disable16Bits = 'ON'
   case Else
     If ($iskey = -1 or $iskey =1) Then
         $Disable16Bits = "OFF"
     Else
         $Disable16Bits = '?'
     EndIf
EndSwitch
If ($iskey = -1 or $iskey =1) Then $Disable16Bits = "OFF"

$keyname = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'
$valuename = 'EnforceShellExtensionSecurity'
$EnforceShellExtensionSecurity = RegRead ( $keyname, $valuename )
$iskey = @error
Switch $EnforceShellExtensionSecurity
   case 0
     $EnforceShellExtensionSecurity = 'OFF'
   case 1
     $EnforceShellExtensionSecurity = 'ON'
   case Else
     $EnforceShellExtensionSecurity = '?'
EndSwitch
If ($iskey = -1 or $iskey =1) Then $EnforceShellExtensionSecurity = "OFF"

$keyname = 'HKCR\Msi.Package\shell\runas\command'
$valuename = ''
$MSIElevation = RegRead ( $keyname, $valuename )
$iskey = @error
Switch $MSIElevation
   case '"%SystemRoot%\System32\msiexec.exe" /i "%1" %*'
      $MSIElevation = "ON"
   case ''
      RegDelete('HKCR\Msi.Package\shell\runas')
      $MSIElevation = "OFF"
   case Else
      $MSIElevation = "?"
EndSwitch


$keyname = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
$valuename = 'ConsentPromptBehaviorUser'
$NoElevationSUA = RegRead ( $keyname, $valuename )
$iskey = @error
Switch $NoElevationSUA
   case '0'
      $NoElevationSUA = "ON"
   case 1
      $NoElevationSUA = "OFF1"
   case 3
      $NoElevationSUA = "OFF3"
   case Else
      $NoElevationSUA = "?"
    
EndSwitch
;If ($iskey = -1 or $iskey =1) Then $NoElevationSUA = "OFF"

$keyname = 'HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb10'
$valuename = 'Start'
$tempvalue = RegRead($keyname,'Start')
If not @error Then
    If not ($tempvalue = 4) Then RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB1', 'REG_DWORD', Number('1'))
EndIf
$DisableSMB = RegRead ( $keyname, $valuename )
If CorrectSMB10Uninstalled() = 1 Then $DisableSMB = 4
$keyname = 'HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb20'
$DisableSMB = $DisableSMB & RegRead ( $keyname, $valuename )
$keyname = 'HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation'
$valuename = 'DependOnService'
$DisableSMB = $DisableSMB & RegRead ( $keyname, $valuename )
$keyname = 'HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters'
$valuename = 'SMB1'
Local $x= RegRead ( $keyname, $valuename )
If @error <> 0 Then $x = '1'
$DisableSMB = $DisableSMB & $x
$valuename = 'SMB2'
Local $x= RegRead ( $keyname, $valuename )
If @error <> 0 Then $x = '1'
$DisableSMB = $DisableSMB & $x
;MsgBox(0,'',$DisableSMB)
Switch $DisableSMB
   case '44' & 'Bowser' & @LF & 'NSI' & '00'
      $DisableSMB = "ON123"
   case '43' & 'Bowser' & @LF & 'MRxSmb20' & @LF & 'NSI' & '01'
;      MsGBox(0,"",$DisableSMB)
      $DisableSMB = "ON1"
   case '33' & 'Bowser' & @LF & 'MRxSmb10' & @LF & 'MRxSmb20' & @LF & 'NSI' & '11'
      If (@OSVersion="WIN_8" or @OSVersion="WIN_7" or @OSVersion="WIN_VISTA") Then
         $DisableSMB = "OFF"
      Else
         $DisableSMB = "?"
      EndIf
   case '23' & 'Bowser' & @LF & 'MRxSmb20' & @LF & 'NSI' & '11'
      If (@OSVersion="WIN_10" or @OSVersion="WIN_81") Then
         $DisableSMB = "OFF"
      Else
         $DisableSMB = "?"
      EndIf 
   case Else
      $DisableSMB = "?"  
EndSwitch
;MsgBox(0,"",$DisableSMB)


Local $keyname = 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'
Local $valuename = 'CachedLogonsCount'
$DisableCachedLogons = RegRead ( $keyname, $valuename )
$iskey = @error
Switch $DisableCachedLogons
   case '0'
      $DisableCachedLogons = "ON"
   case '10'
      $DisableCachedLogons = "OFF"
   case Else
      $DisableCachedLogons = "?"    
EndSwitch
;If ($iskey = -1 or $iskey =1) Then $DisableCachedLogons = "OFF"

$keyname = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\CredUI'
$valuename = 'EnableSecureCredentialPrompting'
$UACSecureCredentialPrompting = RegRead ( $keyname, $valuename )
$iskey = @error
Switch $UACSecureCredentialPrompting
   case 1
      $UACSecureCredentialPrompting = "ON"
   case 0
      $UACSecureCredentialPrompting = "OFF"
   case Else
      $UACSecureCredentialPrompting = "?"
EndSwitch


EndFunc

Func  CheckOld_PS_CMD()
; The patch to Hard_Configurator v. 3.0.0.1
  Local $partkey = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers\0\Paths\{1016bbe0-a716-428b-822e-5E544B6A310'
  Local $BlockSponsorsKey = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers\BlockSponsors'
  If RegRead($partkey & '0}', 'ItemData') = 'powershell.exe' Then RegWrite($BlockSponsorsKey, 'IsPowerShellBlocked', 'REG_DWORD',Number('1'))
  If RegRead($partkey & '1}', 'ItemData') = 'powershell_ise.exe' Then RegWrite($BlockSponsorsKey, 'IsPowerShell_iseBlocked', 'REG_DWORD',Number('1'))
  If RegRead($partkey & '2}', 'ItemData') = 'cmd.exe' Then RegWrite($BlockSponsorsKey, 'IsCMDBlocked', 'REG_DWORD',Number('1'))
EndFunc
