#RequireAdmin
#NoTrayIcon

#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Skins\Default-ToolBar\Run.ico
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_Res_Comment=Compiled with AutoIt 3.3.14.2
#AutoIt3Wrapper_Res_Description=Windows Default-Deny Security
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=Copyright *  Andy Ful , April 2018
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "MetroGUI_UDF.au3"

#Include <Array.au3>
#include <ColorConstants.au3>
#include <constants.au3>
#include <Crypt.au3>
#include <Date.au3>
#include <EditConstants.au3>
#Include <File.au3>
#include <GuiButton.au3>
#include <GUIConstantsEx.au3>
#include <GuiEdit.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIProc.au3>
#include <WinAPIDlg.au3>

#include <GuiScrollBars.au3>
#include <String.au3>

#include <GUIConstants.au3>
#include <Misc.au3>

#include <WindowsConstants.au3>

#Include '_ShellExecuteWithReducedPrivileges.au3'
#include 'AddRemoveHash.au3'
#include 'AddFolderLauncher.au3'
#include 'AddSRPExtension.au3'
#Include 'Autoruns.au3'
#Include 'BlockSponsorsFromProfile.au3'
#Include 'CheckBoxBlockSponsors.au3'
#Include 'Create_Restore_Point.au3'
#include 'DeleteSRPExtension.au3'
#Include 'EncryptConfigFile.au3'
#include 'ExtMsgBox.au3'
#include 'GetAllAccountsInfo.au3'
#Include 'ManageProfilesBACKUP.au3'
#Include 'MoreRestrictions.au3'
;#Include 'MoreSRPRestrictions.au3'
#include 'Path2Array.au3'
#Include 'RegCopyKey.au3'
#Include 'RestoreWindowsDefaults.au3'
#Include 'SavedWhiteLists.au3'
#include 'SRPExecutableTypes.au3'
#Include 'SRPWhitelistSaveLoad.au3'
;#include 'StringSize.au3'
#Include 'SubkeysFromKey2Array.au3'
#Include 'SystemRestoreEnable.au3'
#Include 'WDDS_ShowRegistryTweaks.au3'
#include 'WritableSubWindows.au3'
#Include 'XSkinModAF.au3'

Global $Form1
Global $Toggle2
Global $Toggle3
Global $Button2
Global $Button3
Global $Button4
Global $Button5
Global $Button6
Global $Button7
Global $Button8
Global $Button9
Global $Button10
Global $idComboBoxScriptProtection
Global $idComboBoxDocumentsProtection
Global $idComboBoxLoadProfile
Global $idComboBoxDefender
Global $ProgramFolder = @WindowsDir & "\Hard_Configurator\"
Global $PowerShellDir = 'c:\Windows\System32\WindowsPowerShell\v1.0\'
Global $SRPDefaultLevel
Global $isSRPinstalled
Global $SRPTransparentEnabled
Global $WritableSubWindows
Global $NoPowerShellExecution
Global $DenyShortcuts
Global $DisableWSH
Global $HideRunAsAdmin
Global $RunAsSmartScreen
Global $BlockRemoteAccess
Global $DisableUntrustedFonts
GLobal $Disable16Bits
Global $EnforceShellExtensionSecurity
Global $NoElevationSUA
Global $BlockPowerShellSponsors
Global $MSIElevation
Global $DisableSMB
Global $DisableCachedLogons
Global $UACSecureCredentialPrompting
Global $RefreshChangesCheck
Global $DescriptionLabel
Global $PathDuplicatesArray = [""]
Global $NewPathsArray = [""]
Global $systemdrive = EnvGet('systemdrive')
Global $IsSmartScreenDisabled

; Blocked Sponsors
Global $NumberOfExecutables = 88
; Make room for  elements
Global $arrBlockSponsors[$NumberOfExecutables + 1]
Global $BlockSponsorsNumber
Global $idCheckboxCMD
Global $DisableCommandPrompt
Global $idCheckboxPowerShell
Global $DisablePowerShell
Global $idCheckboxPowerShell_ise
Global $DisablePowerShell_ise
Global $idCheckbox1
Global $DisableAttribExe
Global $idCheckbox2
Global $DisableAuditpolExe
Global $idCheckbox3
Global $DisableBcdbootExe
Global $idCheckbox4
Global $DisableBcdeditExe
Global $idCheckbox5
Global $DisableBitsadminExe
Global $idCheckbox6
Global $DisableBootcfgExe
Global $idCheckbox7
Global $DisableBootimExe
Global $idCheckbox8
Global $DisableBootsectExe
Global $idCheckbox9
Global $DisableByteCodeGeneratorExe
Global $idCheckbox10
Global $DisableCaclsExe
Global $idCheckbox11
Global $DisableIcaclsExe
Global $idCheckbox12
Global $DisableCscExe
Global $idCheckbox13
Global $DisableDebugExe
Global $idCheckbox14
Global $DisableDFsvcExe
Global $idCheckbox15
Global $DisableDiskpartExe
Global $idCheckbox16
Global $DisableEventvwrExe
Global $idCheckbox17
Global $DisableHHExe
Global $idCheckbox18
Global $DisableIEExecExe
Global $idCheckbox19
Global $DisableIexploreExe
Global $idCheckbox20
Global $DisableIexpressExe
Global $idCheckbox21
Global $DisableIlasmExe
Global $idCheckbox22
Global $DisableInstallUtilLibDLL
Global $idCheckbox23
Global $DisableInstallUtilExe
Global $idCheckbox24
Global $DisableJournalExe
Global $idCheckbox25
Global $DisableJscExe
Global $idCheckbox26
Global $DisableMmcExe
Global $idCheckbox27
Global $DisableMrsaExe
Global $idCheckbox28
Global $DisableMSBuildExe
Global $idCheckbox29
Global $DisableMshtaExe
Global $idCheckbox30
Global $DisableMstscExe
Global $idCheckbox31
Global $DisableNetshExe
Global $idCheckbox32
Global $DisableNetstatExe
Global $idCheckbox33
Global $DisablePresentationHostExe
Global $idCheckbox34
Global $DisableQuserExe
Global $idCheckbox35
Global $DisableRegExe
Global $idCheckbox36
Global $DisableRegAsmGlobal
Global $idCheckbox37
Global $DisableReginiExe
Global $idCheckbox38
Global $DisableRegsvcsExe
Global $idCheckbox39
Global $DisableRegsvr32Exe
Global $idCheckbox40
Global $DisableRunLegacyCPLElevatedExe
Global $idCheckbox41
Global $DisableRunonceExe
Global $idCheckbox42
Global $DisableRunasExe
Global $idCheckbox43
Global $DisableStarScriptExe
Global $idCheckbox44
Global $DisableSetExe
Global $idCheckbox45
Global $DisableSetxExe
Global $idCheckbox46
Global $DisableStashStar
Global $idCheckbox47
Global $DisableSystemresetExe
Global $idCheckbox48
Global $DisableTakeownExe
Global $idCheckbox49
Global $DisableTaskkillExe
Global $idCheckbox50
Global $DisableUserAccountControlSettingsExe
Global $idCheckbox51
Global $DisableVbcExe
Global $idCheckbox52
Global $DisableVssadminExe
Global $idCheckbox53
Global $DisableWmicExe
Global $idCheckbox54
Global $DisableXcaclsExe
Global $idCheckbox55
Global $DisableAspnetCompilerExe
Global $idCheckbox56
Global $DisableBashExe
Global $idCheckbox57
Global $DisableBginfoExe
Global $idCheckbox58
Global $DisableBitsadmin
Global $idCheckbox59
Global $DisableCdbExe
Global $idCheckbox60
Global $DisableCsiExe
Global $idCheckbox61
Global $DisableCvtresExe
Global $idCheckbox62
Global $DisableDbghostExe
Global $idCheckbox63
Global $DisableDbgsvcExe
Global $idCheckbox64
Global $DisableDnxExe
Global $idCheckbox65
Global $DisableFsiExe
Global $idCheckbox66
Global $DisablefsiAnyCpuExe
Global $idCheckbox67
Global $DisableInfDefaultInstallExe
Global $idCheckbox68
Global $DisableInstallUtil
Global $idCheckbox69
Global $DisableKdExe
Global $idCheckbox70
Global $DisableLpkInstall
Global $idCheckbox71
Global $DisableLxssManagerDll
Global $idCheckbox72
Global $DisableMsiexecExe
Global $idCheckbox73
Global $DisableNtkdExe
Global $idCheckbox74
Global $DisableNtsdExe
Global $idCheckbox75
Global $DisableOdbcConfExe
Global $idCheckbox76
Global $DisableRcsiExe
Global $idCheckbox77
Global $DisableRegAsm
Global $idCheckbox78
Global $DisableRegsvcs
Global $idCheckbox79
Global $DisableRunScriptHelperExe
Global $idCheckbox80
Global $DisableSchTasksExe
Global $idCheckbox81
Global $DisableScrconsExe
Global $idCheckbox82
Global $DisableSdbinstExe
Global $idCheckbox83
Global $DisableSdcltExe
Global $idCheckbox84
Global $DisableSyskeyExe
Global $idCheckbox85
Global $DisableUtilmanExe
Global $idCheckbox86
Global $DisableVisualUiaVerifyNativeExe
Global $idCheckbox87
Global $DisableWbemTestExe
Global $idCheckbox88
Global $DisableWinDbgExe


Global $ASR1
Global $ASR2
Global $ASR3
Global $ASR4
Global $ASR5
Global $ASR6
Global $ASR7
Global $ControlledFolderAccess
Global $EnableNetworkProtection
Global $keynamePS = 'HKLM\Software\Policies\Microsoft\Windows\PowerShell'
Global $valuenamePS = 'EnableScripts'


;Set Theme
_SetTheme("DarkTeal") ;See MetroThemes.au3 for selectable themes or to add more

If @OSBuild < 16299 Then
   _Metro_MsgBox(0,"","This application requires at least Windows 10 Fall Creators Update (build 16299).",500,12)
   Exit
EndIf


If (@ScriptName = 'WDDS(x64).exe' And @OSArch = "X86") Then
   _Metro_MsgBox(0,"","This file works only in 64-bit Windows version.",500,12,"",4)
   Exit
EndIf

If (@ScriptName = 'WDDS(x86).exe' And @OSArch = "X64") Then
   _Metro_MsgBox(0,"","This file works only in 32-bit Windows version.",500,12,"",4)
   Exit
EndIf

If not (@ScriptDir = @WindowsDir & "\Hard_Configurator") Then 
   _Metro_MsgBox(0,"","Wrong program location. This application should be located in Hard_Configurator program folder (usually C:\Windows\Hard_Configurator).",500,12)
   Exit
EndIf

;The First RUN Maintenance
Local $Reg = RegRead('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers', 'Installed')
Local $wddsReg = RegRead('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers', 'WDDSInstalled')

If not ($wddsReg = '1') Then 
   If not ($Reg = '1') Then 
      WDDSFirstRUNMaintenance()
;     Poprawka na wartość Installed
      RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers', 'Installed', 'REG_SZ', '1')
;      MsgBox(0,"", 'After finishing the System Restore Point, you may run WDDS program to configure Windows Default-Deny Security.')
      _Metro_MsgBox(0,"","After finishing the System Restore Point, you may run WDDS program to configure Windows Default-Deny Security.",500,12)

      Exit
   EndIf
EndIf
HCLauncher()

Func HCLauncher()

Local $BlockWSH
Local $TempDefaultDenyData
Local $DefaultLevelNotConfigured
Local $DefaultDenyData
Local $TempScriptProtectionData
Local $ScriptProtectionNotConfigured
Local $ScriptProtectionData
Local $DocumentsProtectionData
Local $ProfileData
Local $DefenderData
Local $DefaultDenyKey = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers'
Local $TempKeyScripts = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\ScriptProtection'
Local $keynamePS = 'HKLM\Software\Policies\Microsoft\Windows\PowerShell'
Local $valuenamePS = 'EnableScripts'
Local $keynameWSH = 'HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings'
Local $keynameWOW = 'HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows Script Host\Settings'
Local $valuenameWSH = 'Enabled'
Local $sComboRead
Local $tempvalue
Local $BlockSponsorsArray

; Check if UAC is enabled
$EnableLUA = RegRead('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System','EnableLUA')
If not ($EnableLUA=1) Then 
         RegWrite('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System', 'EnableLUA', 'REG_DWORD', Number('1'))
	_Metro_MsgBox(0,"","User Account Controll (UAC) enabled",500,12,"",4)
;         MsgBox(262144, "", "UAC enabled." )
EndIf

;Enable SmartScreen
If (@OSVersion="WIN_10" or @OSVersion="WIN_81" or @OSVersion="WIN_8") Then
   Local $ES1 = RegRead('HKLM\SOFTWARE\Policies\Microsoft\Windows\System', 'EnableSmartScreen')
   If @error<>0  Then $ES1 = 'ERROR'
   Local $ES2 = RegRead('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer', 'SmartScreenEnabled')
   If @error<>0 Then $ES2 = 'ERROR'
   If $ES1='0' Then
      RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows\System', 'EnableSmartScreen')
      RegWrite ('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer', 'SmartScreenEnabled', 'REG_SZ', 'Prompt')
      _Metro_MsgBox(0,"","SmartScreen enabled in Explorer",500,12,"",4)
   Else
      IF ($ES2='Off' and $ES1='ERROR') Then
      RegWrite ('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer', 'SmartScreenEnabled', 'REG_SZ', 'Prompt')
      _Metro_MsgBox(0,"","SmartScreen enabled in Explorer",500,12,"",4)
      EndIf
   EndIf
   If ($ES1 = 'ERROR' and $ES2 = 'ERROR') Then
      RegWrite ('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer', 'SmartScreenEnabled', 'REG_SZ', 'Prompt')
      _Metro_MsgBox(0,"","SmartScreen enabled in Explorer",500,12,"",4)
   EndIf
EndIf
$IsSmartScreenDisabled = 0


;Create resizable Metro GUI
$Form1 = _Metro_CreateGUI("WDD_Configurator", 435, 480, -1, -1, True)
_Metro_SetGUIOption($Form1, True , False)


;Add/create control buttons to the GUI
$Control_Buttons = _Metro_AddControlButtons(True, False, True, False, True) ;CloseBtn = True, MaximizeBtn = True, MinimizeBtn = True, FullscreenBtn = True, MenuBtn = True

;Set variables for the handles of the GUI-Control buttons. (Above function always returns an array this size and in this order, no matter which buttons are selected.)
$GUI_CLOSE_BUTTON = $Control_Buttons[0]
$GUI_MINIMIZE_BUTTON = $Control_Buttons[3]
$GUI_MENU_BUTTON = $Control_Buttons[6]
;======================================================================================================================================================================

if not (RegRead('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers', 'WDDSInstalled')='1') Then
; Apply R1 profile 
   R1_profile()
;   RegWrite($keynamePS, $valuenamePS, 'REG_DWORD', Number('0'))
;   RegWrite($keynameWSH, $valuenameWSH, 'REG_DWORD', Number('0'))
;   If @OSArch = "X64" Then RegWrite($keynameWOW, $valuenameWSH, 'REG_DWORD', Number('0'))
   RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers', 'WDDSInstalled', 'REG_SZ', '1')
;   RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers\0\Paths\{1016bbe0-a716-428b-822e-5E544B6A3301}','ItemData', 'REG_SZ', 'protected')
   _GUIDisable($Form1, 70)
   _Metro_MsgBox(0,"","Software Restriction Policies (SRP) are activated.  After finishing the configuration, you must Log OFF from the account to apply default-deny protection.",500,12)	
   _GUIDisable($Form1)
EndIf

;Create  Buttons
$Button1 = GUICtrlCreateButton("", 0, 0, 1, 1)
;$Button2 = _Metro_CreateButton("Switch Default-Deny Protection", 40, 70, 250, 25, $ButtonBKColor, "0xffffff", "Courier", 14)
$Button2 = GUICtrlCreateButton("Switch Default-Deny Protection", 40, 70, 250, 25)
GUICtrlSetColor($Button2, 0xffffff)
GUICtrlSetBkColor($Button2, "0x00796b")
GUICtrlSetFont($Button2, 10, 500, 0, "Arial", 5)

$Toggle2 = _Metro_CreateOnOffToggle("ON", "OFF", 310, 68, 130, 30) 

$Button5 = GUICtrlCreateButton("Default-Deny Profiles", 40, 120, 250, 25)
GUICtrlSetColor($Button5, 0xffffff)
GUICtrlSetBkColor($Button5, "0x00796b")
GUICtrlSetFont($Button5, 10, 500, 0, "Arial", 5)

;$Button3 = GUICtrlCreateButton("Advanced Script Protection", 40, 170, 250, 25)
;GUICtrlSetColor($Button3, 0xffffff)
;GUICtrlSetBkColor($Button3, "0x00796b")
;GUICtrlSetFont($Button3, 10, 500, 0, "Arial", 5)

$Button10 = GUICtrlCreateButton("Windows Defender Settings", 40, 170, 250, 25)
GUICtrlSetColor($Button10, 0xffffff)
GUICtrlSetBkColor($Button10, "0x00796b")
GUICtrlSetFont($Button10, 10, 500, 0, "Arial", 5)

$Button4 = GUICtrlCreateButton("Advanced Office Documents Protection", 40, 220, 250, 25)
GUICtrlSetColor($Button4, 0xffffff)
GUICtrlSetBkColor($Button4, "0x00796b")
GUICtrlSetFont($Button4, 10, 500, 0, "Arial", 5)

;$Radio1 = _Metro_CreateRadioEx("1", "OFF", 60, 207, 70, 22)
;$Radio2 = _Metro_CreateRadioEx("1", "ON", 130, 207, 70, 22)
;$Radio3 = _Metro_CreateRadioEx("1", "Partial", 200, 207, 70, 22)

$Button7 = _Metro_CreateButtonEx2("Whitelist Folders", 160, 330, 130, 35,"0x0079cb", "0x000000", "Arial", 10, 1)
;$Button7 = GUICtrlCreateButton("Whitelist Folders", 160, 330, 130, 35, -1, 1)
GUICtrlSetColor($Button7, 0x000000)
GUICtrlSetBkColor($Button7, "0x0079cb")
GUICtrlSetFont($Button7, 10, 600, 0, "Arial", 5)

$Button8 = _Metro_CreateButtonEx2("Blocked Events", 40, 330, 120, 35,"0x0079cb", "0x000000", "Arial", 10, 1)
;$Button8 = GUICtrlCreateButton("Blocked Events", 38, 330, 120, 35, -1, 1)
GUICtrlSetColor($Button8, 0x000000)
GUICtrlSetBkColor($Button8, "0x0079cb")
GUICtrlSetFont($Button8, 10, 600, 0, "Arial", 5)

$Button9 = _Metro_CreateButtonEx2("Advanced Configuration", 40, 380, 252, 35,"0x0079cb", "0x000000", "Arial", 10, 1)
;$Button9 = GUICtrlCreateButton("Advanced Configuration", 38, 380, 252, 35, -1, -1)
;GUICtrlSetColor($Button9, 0xffffff)
;GUICtrlSetBkColor($Button9, "0x0079cb")
GUICtrlSetColor($Button9, 0x000000)
GUICtrlSetBkColor($Button9, 0x0079cb)
GUICtrlSetFont($Button9, 10, 600, 0, "Arial", 5)

$Button6 = GUICtrlCreateButton(@CRLF & "H" & @CRLF & "E" & @CRLF & "L" & @CRLF & "P" & @CRLF, 330, 330, 30, 85, $BS_MULTILINE)
GUICtrlSetColor($Button6, 0xffffff)
GUICtrlSetBkColor($Button6, "0x00796b")
GUICtrlSetFont($Button6, 9, 500, 0, "Arial", 5)

$Button11 = GUICtrlCreateButton("Firewall Hardening", 40, 270, 250, 25)
GUICtrlSetColor($Button11, 0xffffff)
GUICtrlSetBkColor($Button11, "0x00796b")
GUICtrlSetFont($Button11, 10, 500, 0, "Arial", 5)

$Toggle3 = _Metro_CreateOnOffToggle("ON", "OFF", 310, 268, 130, 30) 

;If isSRPHard_ConfiguratorNOTInstalled() > 0 Then 
;   _GUICtrlButton_Enable($Button2, False)
;   _GUICtrlButton_Enable($Button3, False)
;   _GUICtrlButton_Enable($Button4, False)
;   _GUICtrlButton_Enable($Button6, False)
;   _GUICtrlButton_Enable($Button7, False)
;   _GUICtrlButton_Enable($Button8, False)
;EndIf


;Local $TempDefaultDenyData
;Local $DefaultDenyKey = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers'
$DefaultLevelNotConfigured = 0
$DefaultDenyData = RegRead($DefaultDenyKey, 'DefaultLevel')
If @error Then $DefaultLevelNotConfigured = 1
;MsgBox(0,"", $DefaultLevelNotConfigured & "     " & $DefaultDenyData)
Switch $DefaultDenyData
	case 0
		If $DefaultLevelNotConfigured = 0 Then _Metro_ToggleCheck($Toggle2)
	case 131072
		_Metro_ToggleCheck($Toggle2)
	case 262144
		_Metro_ToggleUnCheck($Toggle2)
	case Else
EndSwitch
If $DefaultLevelNotConfigured = 1 Then _Metro_ToggleUnCheck($Toggle2)
$tempvalue = RegRead($DefaultDenyKey, 'TransparentEnabled')
If not ($tempvalue = 1 or $tempvalue = 2) Then _Metro_ToggleUnCheck($Toggle2)


;Testing Advanced Script Protection
;$idComboBoxScriptProtection = GUICtrlCreateCombo("ON", 310, 170, 80, 30)
;GUICtrlSetColor(-1, 0xffffff)
;GUICtrlSetBkColor(-1,0x000000)
;GUICtrlSetFont($idComboBoxScriptProtection, 11, 500, 0, "Arial", 5)
;       Switch AreScriptsBlocked()
;	   case 0
;	      $ScriptProtectionData = "OFF"
;	   case 1
;              $ScriptProtectionData = "ON"
;	   case Else
;              $ScriptProtectionData = "Partial"
;       EndSwitch
;GUICtrlSetData($idComboBoxScriptProtection, "OFF|Partial", $ScriptProtectionData)
;    MsgBox(0,"",$ScriptProtectionData)


;Testing Advanced Office Documents Protection
$idComboBoxDocumentsProtection = GUICtrlCreateCombo("ON", 310, 220, 80, 30)
GUICtrlSetColor(-1, 0xffffff)
GUICtrlSetBkColor(-1,0x000000)
GUICtrlSetFont($idComboBoxDocumentsProtection, 11, 500, 0, "Arial", 5)
Switch AreOfficeDocumentsProtected()
   case 1       
	      $DocumentsProtectionData = "OFF"       
   case 2
              $DocumentsProtectionData = "ON"
   case Else
              $DocumentsProtectionData = "Partial"
EndSwitch
GUICtrlSetData($idComboBoxDocumentsProtection, "OFF|Partial", $DocumentsProtectionData)
;    MsgBox(0,"",$DocumentsProtectionData)
If @OSBuild < 16299 Then
   _Metro_DisableButton($idComboBoxDocumentsProtection)
   GUICtrlSetData($idComboBoxDocumentsProtection, "OFF")
EndIf


;Testing Hard_Configurator restriction values
WDDS_ShowRegistryTweaks()
;MsgBox(0,"", $NoPowerShellExecution & @CRLF & $SRPDefaultLevel & @CRLF & $isSRPinstalled & @CRLF & $SRPTransparentEnabled & @CRLF & $WritableSubWindows & @CRLF & $DenyShortcuts & @CRLF & $HideRunAsAdmin & @CRLF & $RunAsSmartScreen & @CRLF & $BlockRemoteAccess & @CRLF &  $Disable16Bits & @CRLF & $EnforceShellExtensionSecurity & @CRLF & $MSIElevation & @CRLF & $NoElevationSUA & @CRLF & $DisableSMB & @CRLF & $DisableCachedLogons & @CRLF & $UACSecureCredentialPrompting)


;Loading Profiles
AreShortcutsProtected()
Local $LoadingProfiles = $NoPowerShellExecution & @CRLF & $isSRPinstalled & @CRLF & $SRPTransparentEnabled & @CRLF & $WritableSubWindows & @CRLF & $DenyShortcuts & @CRLF & $HideRunAsAdmin & @CRLF & $RunAsSmartScreen & @CRLF & $BlockRemoteAccess & @CRLF &  $Disable16Bits & @CRLF & $EnforceShellExtensionSecurity & @CRLF & $MSIElevation & @CRLF & $NoElevationSUA & @CRLF & $DisableSMB & @CRLF & $DisableCachedLogons & @CRLF & $UACSecureCredentialPrompting
;MsgBox(0,"",$LoadingProfiles)
$idComboBoxLoadProfile = GUICtrlCreateCombo("R1", 310, 120, 80, 30)
GUICtrlSetColor(-1, 0xffffff)
GUICtrlSetBkColor(-1,0x000000)
GUICtrlSetFont($idComboBoxLoadProfile, 11, 500, 0, "Arial", 5)

$BlockSponsorsArray = RegValues2Array('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers\BlockSponsors')
Switch $LoadingProfiles
   case 'OFF' & @CRLF & 'Installed' & @CRLF & 'Skip DLLs' & @CRLF & 'ON' & @CRLF & 'ON' & @CRLF & 'ON' & @CRLF & 'Administrator' & @CRLF & 'ON' & @CRLF & 'ON'  & @CRLF & 'OFF' & @CRLF & 'ON' & @CRLF & 'OFF3' & @CRLF & 'ON1' & @CRLF & 'ON' & @CRLF & 'OFF' 
	      If (UBound($BlockSponsorsArray)) = 0 Then
		 $ProfileData = "R1"
	      Else
		 $ProfileData = "Custom"
	      EndIf
   case 'ON' & 'Installed' & @CRLF & 'Skip DLLs' & @CRLF & 'ON' & @CRLF & 'ON' & @CRLF & 'ON' & @CRLF & 'Administrator' & @CRLF & 'ON' & @CRLF & 'ON'  & @CRLF & 'ON' & @CRLF & 'ON' & @CRLF & 'OFF3' & @CRLF & 'ON123' & @CRLF & 'ON' & @CRLF & 'OFF' 
 	      $tempvalue = ""
	      Switch UBound($BlockSponsorsArray)
		case 0
		   $ProfileData = "R2"
		case 6
		  If (_ArraySearch ($BlockSponsorsArray, 'IsCMDBlocked') + _ArraySearch ($BlockSponsorsArray, 'IsPowerShellBlocked') + _ArraySearch ($BlockSponsorsArray, 'IsPowerShell_iseBlocked') + _ArraySearch ($BlockSponsorsArray, 'IsMshta.exeBlocked') + _ArraySearch ($BlockSponsorsArray, 'IsReg.exeBlocked') + _ArraySearch ($BlockSponsorsArray, 'IsWmic.exeBlocked') = 15) Then
 		      $ProfileData = "R3"
		   Else
		      $ProfileData = "Custom"
		   EndIf
		 case 57
		      $ProfileData = "R4"
		 case Else
		      $ProfileData = "Custom"     
	      EndSwitch
   case 'OFF' & 'Installed' & @CRLF & 'No Enforcement' & @CRLF & 'OFF' & @CRLF & 'OFF' & @CRLF & 'OFF' & @CRLF & 'OFF' & @CRLF & 'OFF' & @CRLF & 'OFF'  & @CRLF & 'OFF' & @CRLF & 'OFF' & @CRLF & 'OFF3' & @CRLF & 'OFF' & @CRLF & 'OFF' & @CRLF & 'OFF' 
	      If (UBound($BlockSponsorsArray)) = 0 Then
		 $ProfileData = "OFF"
	      Else
		 $ProfileData = "Custom"
	      EndIf
   case 'OFF' & 'Installed' & @CRLF & 'No Enforcement' & @CRLF & 'OFF' & @CRLF & 'OFF' & @CRLF & 'OFF' & @CRLF & 'OFF' & @CRLF & 'OFF' & @CRLF & 'OFF'  & @CRLF & 'OFF' & @CRLF & 'OFF' & @CRLF & 'OFF3' & @CRLF & 'ON1' & @CRLF & 'OFF' & @CRLF & 'OFF' 
	      If IsSMB10Uninstalled() = 1 Then
		 $ProfileData = "OFF"
	      Else
		 $ProfileData = "Custom"
	      EndIf
   case Else
              $ProfileData = "Custom"
EndSwitch
GUICtrlSetData($idComboBoxLoadProfile, "R2|R3|R4|Custom|OFF", $ProfileData)
;MsgBox(0,"",$LoadingProfiles)


;Configuring Windows Defender
$idComboBoxDefender = GUICtrlCreateCombo("Default", 310, 170, 80, 30)
GUICtrlSetColor(-1, 0xffffff)
GUICtrlSetBkColor(-1,0x000000)
GUICtrlSetFont($idComboBoxDefender, 11, 500, 0, "Arial", 5)
Switch SeeDefenderConfiguration()
   case 'Disabled' & @CRLF & 'Disabled' & @CRLF & 'Disabled' & @CRLF & 'Disabled' & @CRLF & 'Disabled' & @CRLF & 'Disabled' & @CRLF & 'Disabled' & @CRLF & 'Disabled'     
	      $DefenderData = "Default"       
   case 'Enabled' & @CRLF & 'Enabled' & @CRLF & 'Enabled' & @CRLF & 'Enabled' & @CRLF & 'Enabled' & @CRLF & 'Enabled' & @CRLF & 'Enabled' & @CRLF & 'Disabled'
              $DefenderData = "+ASR"
   case 'Disabled' & @CRLF & 'Disabled' & @CRLF & 'Disabled' & @CRLF & 'Disabled' & @CRLF & 'Disabled' & @CRLF & 'Disabled' & @CRLF & 'Disabled' & @CRLF & 'Enabled'
              $DefenderData = "+CFA"
   case 'Enabled' & @CRLF & 'Enabled' & @CRLF & 'Enabled' & @CRLF & 'Enabled' & @CRLF & 'Enabled' & @CRLF & 'Enabled' & @CRLF & 'Enabled' & @CRLF & 'Enabled'
              $DefenderData = "+Both"
   case Else
              $DefenderData = "Custom"
EndSwitch
GUICtrlSetData($idComboBoxDefender, "+ASR|+CFA|+Both|Custom", $DefenderData)
;MsgBox(0,"",$ASR1 & @CRLF & $ASR2 & @CRLF & $ASR3 & @CRLF & $ASR4 & @CRLF & $ASR5 & @CRLF & $ASR6 & @CRLF & $ASR7 & @CRLF & $ControlledFolderAccess & @CRLF & $EnableNetworkProtection)

If @OSBuild < 16299 Then
   _Metro_DisableButton($idComboBoxDefender)
   GUICtrlSetData($idComboBoxDefender, "Default")
EndIf


;Set resizing options for the controls so they don't change in size or position. This can be customized to match your gui perfectly for resizing. See AutoIt Help file.
GUICtrlSetResizing($Button2, 768 + 8)

GUICtrlSetResizing($Toggle2, 768 + 2 + 32)

GUISetState(@SW_SHOW)

While 1
	$nMsg = GUIGetMsg()
	Sleep(10)
	Switch $nMsg
		Case $GUI_EVENT_CLOSE, $GUI_CLOSE_BUTTON
			_Metro_GUIDelete($Form1) ;Delete GUI/release resources, make sure you use this when working with multiple GUIs!
			Exit
		Case $GUI_MINIMIZE_BUTTON
			GUISetState(@SW_MINIMIZE, $Form1)
		Case $GUI_MENU_BUTTON
			;Create an Array containing menu button names
			Local $MenuButtonsArray[8] = ["Introduction", "Recommended Settings", "About", "Do not Start with Windows", "Exit", '', '', 'UNINSTALL']
			; Open the metro Menu. See decleration of $MenuButtonsArray above.
			Local $MenuSelect = _Metro_MenuStart($Form1, 150, $MenuButtonsArray)
			Switch $MenuSelect ;Above function returns the index number of the selected button from the provided buttons array.
				Case "0"
;					ConsoleWrite("Returned 0 = Help button clicked. Please note that the window border colors are not updated during this demo." & @CRLF)
					Introduction()
				Case "1" 
					RecommendedSettings()
					ConsoleWrite("Returned 1 = About button clicked." & @CRLF)
				Case "2"
;					ConsoleWrite("Returned 2 = About button clicked." & @CRLF)
					_GUIDisable($Form1, 70)
					_Metro_MsgBox(0,"","WDDS ver. 1.0.0.0" & @crlf & "Copyright by Andy Ful,   April 2018" & @crlf & "e-mail: Hard_Configurator@o2.pl" & @crlf & "dev. webpage: https://github.com/AndyFul/Hard_Configurator" ,500,12,"",20)
					_GUIDisable($Form1)
				Case "3"
;					ConsoleWrite("Returned 3 = Do not Start with Windows button clicked." & @CRLF)
					If _Metro_ToggleIsChecked($Toggle2) Then
						_GUIDisable($Form1, 70)
						_Metro_MsgBox(0,"","Actual settings do not require to start the program with Windows.",500,12,"",10)
						_GUIDisable($Form1)
					Else
 					        _GUIDisable($Form1, 70)
						If _Metro_MsgBox(1,"","It is not recommended to disable the start of this application with Windows when 'Switch Default-Deny Protection' is set to OFF." & @CRLF & "If you press the OK button, this application will not start with Windows and you will not be informed that some important features are turned OFF.",600,12) = "OK" Then
						   RegDelete('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run', 'Hard_ConfiguratorLauncher')
						   _Metro_MsgBox(0,"","Finished.", 180,12,"",3)
						EndIf
					        _GUIDisable($Form1)
					EndIf
				Case "4"
;					ConsoleWrite("Returned 4 = Exit button clicked." & @CRLF)
					_Metro_GUIDelete($Form1)
					Exit
			EndSwitch
		Case $Button2
			HelpSwitchDefaultDeny()
		Case $Toggle2
			If _Metro_ToggleIsChecked($Toggle2) Then
				_Metro_ToggleUnCheck($Toggle2)
				$TempDefaultDenyData = RegRead($DefaultDenyKey, 'DefaultLevel')
				RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\Switch','DefaultLevel', 'REG_DWORD',$TempDefaultDenyData)
				RegWrite($DefaultDenyKey, 'DefaultLevel', 'REG_DWORD', Number('262144'))
				If (@OSArch = "X64") Then				
				   RegWrite('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run', 'Hard_ConfiguratorLauncher', 'REG_SZ', @WindowsDir & "\explorer.exe " & @WindowsDir & "\Hard_Configurator\WDDS(x64).exe")
				EndIf
				If (@OSArch = "X86") Then				
				   RegWrite('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run', 'Hard_ConfiguratorLauncher', 'REG_SZ', @WindowsDir & "\explorer.exe " & @WindowsDir & "\Hard_Configurator\WDDS(x86).exe")
				EndIf
			Else
				If  (RegRead($DefaultDenyKey, 'TransparentEnabled') > 0) then
   				   If isSRPHard_ConfiguratorNOTInstalled() = 0  Then
				      _Metro_ToggleCheck($Toggle2)
				      $TempDefaultDenyData = RegRead('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\Switch','DefaultLevel')
				      If @error Then $TempDefaultDenyData = 131072
				      If not ($TempDefaultDenyData = 131072 or $TempDefaultDenyData = 0) Then
			 		 $TempDefaultDenyData = 131072
				      EndIf
				      If ($TempDefaultDenyData = 131072 or $TempDefaultDenyData = 0) Then
					 RegWrite($DefaultDenyKey, 'DefaultLevel', 'REG_DWORD', $TempDefaultDenyData)
					 If _Metro_ToggleIsChecked($Toggle2) Then
					    RegDelete('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run', 'Hard_ConfiguratorLauncher')
					 EndIf
					 _GUIDisable($Form1, 70)
					 If $TempDefaultDenyData = 131072 Then _Metro_MsgBox(0,"","Default Security Level has been set to 'Basic User'.",500,12,"",10)
					 If $TempDefaultDenyData = 0 Then _Metro_MsgBox(0,"","Default Security Level has been set to 'Disallowed'.",500,12,"",10)			
					 _GUIDisable($Form1)
				      EndIf	
				   EndIf
				EndIf
			EndIf
;		case $Button3
;			HelpScriptProtection()
		case $Button4
			HelpOfficeDocumentsProtection()
		case $Button5
			HelpDefaultDenyProfiles()
		case $Button10
			HelpWindowsDefenderSettings()
		case $Button9
			_GUIDisable($Form1, 70)
			If @OSArch = "X64" Then RunWait($ProgramFolder & "Hard_Configurator(x64).exe")
			If @OSArch = "X86" Then RunWait($ProgramFolder & "Hard_Configurator(x86).exe")
			_GUIDisable($Form1)
		case $Button6
			HelpBlue()
		case $idComboBoxDocumentsProtection
			$sComboRead = GUICtrlRead($idComboBoxDocumentsProtection)
;			MsgBox(0,"",$sComboRead)
			Switch $sComboRead
			   Case 'OFF'
				OfficeDocumentsProtection('0')
			   Case 'ON'
				OfficeDocumentsProtection('1')
			   Case 'Partial'
				_GUIDisable($Form1, 70)
				_Metro_MsgBox(0,"","This option cannot be selected by the user. It is selected if 'Advanced Office Documents Protection' is nither ON nor OFF. That can happen if some Office applications are protected and other are not protected by the Exploit Guard mitigation 'Do not allow child processes'." & @CRLF & "Now, WDDS will try to activate the protection for all possible Office applications." ,500,12)	
				_GUIDisable($Form1)
				GUICtrlSetData($idComboBoxDocumentsProtection, 'ON')
				OfficeDocumentsProtection('1')
			EndSwitch
;		case $idComboBoxScriptProtection
;			$sComboRead = GUICtrlRead($idComboBoxScriptProtection)
;			MsgBox(0,"",$sComboRead)
;			Switch $sComboRead
;			   case 'OFF'
;				RegWrite($keynamePS, $valuenamePS, 'REG_DWORD', Number('1'))
;				RegWrite($keynameWSH, $valuenameWSH, 'REG_DWORD', Number('1'))
;				If @OSArch = "X64" Then RegWrite($keynameWOW, $valuenameWSH, 'REG_DWORD', Number('1'))
;				$ScriptProtectionData = "OFF"
;				If (@ScriptName = 'WDDS(x64).exe') Then				
;				   RegWrite('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run', 'Hard_ConfiguratorLauncher', 'REG_SZ', @WindowsDir & "\explorer.exe " & @WindowsDir & "\Hard_Configurator\WDDS(x64).exe")
;				EndIf
;				If (@ScriptName = 'WDDS(x86).exe') Then				
;				   RegWrite('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run', 'Hard_ConfiguratorLauncher', 'REG_SZ', @WindowsDir & "\explorer.exe " & @WindowsDir & "\Hard_Configurator\WDDS(x86).exe")
;				EndIf
;		  	   case 'ON'
;				RegWrite($keynamePS, $valuenamePS, 'REG_DWORD', Number('0'))
;				RegWrite($keynameWSH, $valuenameWSH, 'REG_DWORD', Number('0'))
;				If @OSArch = "X64" Then RegWrite($keynameWOW, $valuenameWSH, 'REG_DWORD', Number('0'))
;				$ScriptProtectionData = "ON"
;			   case 'Partial'
;				If $ScriptProtectionData = "OFF" Then
;				   _GUIDisable($Form1, 70)
;				   _Metro_MsgBox(0,"","This option cannot be selected by the user. It is selected when 'Advanced Script Protection' is nither ON nor OFF. That can happen if custom settings are applied via 'Advanced Settings' or via external application." & @CRLF & "Now, this option will be set to ON." ,500,12)	
;				   _GUIDisable($Form1)
;				   RegWrite($keynamePS, $valuenamePS, 'REG_DWORD', Number('0'))
;				   RegWrite($keynameWSH, $valuenameWSH, 'REG_DWORD', Number('0'))
;				   If @OSArch = "X64" Then RegWrite($keynameWOW, $valuenameWSH, 'REG_DWORD', Number('0'))
;				   GUICtrlSetData($idComboBoxScriptProtection, 'ON')
;				   $ScriptProtectionData = "ON"
;				Else
;				   If $ScriptProtectionData = "ON" Then
;				      GUICtrlSetData($idComboBoxScriptProtection, 'ON')
;				      _GUIDisable($Form1, 70)
;				      _Metro_MsgBox(0,"","This option cannot be selected by the user. It is selected when 'Advanced Script Protection' is nither ON nor OFF. That can happen if custom settings are applied via 'Advanced Settings' or via external application.", 500,12)	
;				      _GUIDisable($Form1)
;				   EndIf
;				   If $ScriptProtectionData = "Partial" Then
;				      _GUIDisable($Form1, 70)
;				      _Metro_MsgBox(0,"","This option cannot be selected by the user. It is selected when 'Advanced Script Protection' is nither ON nor OFF. That can happen if custom settings are applied via 'Advanced Settings' or via external application.", 500,12)	
;				      _GUIDisable($Form1)
;			   	   EndIf   
;				EndIf
;			EndSwitch
		case $idComboBoxLoadProfile
;			Show hidden files for better whitelisting
			RegWrite('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced', 'Hidden', 'REG_DWORD', Number('1'))
			RegWrite('HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced', 'Hidden', 'REG_DWORD', Number('1'))
;			Manage options
			$sComboRead = GUICtrlRead($idComboBoxLoadProfile)
			Switch $sComboRead
				case 'R1'
					If not ($ProfileData = 'R1') Then
						R1_profile()
					   If not ($ProfileData = 'OFF') Then
						_GUIDisable($Form1, 70)
						_Metro_MsgBox(0,"","You have to reboot the computer to apply the profile." ,500, 12, "", 5)	
						_GUIDisable($Form1)
					   Else
						_GUIDisable($Form1, 70)
						_Metro_MsgBox(0,"","You must Log OFF from the account to apply the profile." ,500, 12, "", 5)	
						_GUIDisable($Form1)
					   EndIf
		 			        $ProfileData = "R1"
					        GUICtrlSetData($idComboBoxLoadProfile, $ProfileData)
						_Metro_ToggleCheck($Toggle2)
					EndIf
				case 'R2'
					If not ($ProfileData = 'R2') Then
						R2_profile()
					   If ($ProfileData = 'R1' or $ProfileData = 'OFF') Then
						_GUIDisable($Form1, 70)
						_Metro_MsgBox(0,"","You have to reboot the computer to apply the profile." ,500, 12, "", 5)	
						_GUIDisable($Form1)
					   Else
						_GUIDisable($Form1, 70)
						_Metro_MsgBox(0,"","You must Log OFF from the account to apply the profile." ,500, 12, "", 5)	
						_GUIDisable($Form1)
					   EndIf
		 			        $ProfileData = "R2"
					        GUICtrlSetData($idComboBoxLoadProfile, $ProfileData)
						_Metro_ToggleCheck($Toggle2)
					EndIf
				case 'R3'
					If not ($ProfileData = 'R3') Then
						R3_profile()
					   If ($ProfileData = 'R1' or $ProfileData = 'OFF') Then
						_GUIDisable($Form1, 70)
						_Metro_MsgBox(0,"","You have to reboot the computer to apply the profile." ,500, 12, "", 5)	
						_GUIDisable($Form1)
					   Else
						_GUIDisable($Form1, 70)
						_Metro_MsgBox(0,"","You must Log OFF from the account to apply the profile." ,500, 12, "", 5)	
						_GUIDisable($Form1)
					   EndIf
		 			        $ProfileData = "R3"
					        GUICtrlSetData($idComboBoxLoadProfile, $ProfileData)
						_Metro_ToggleCheck($Toggle2)
					EndIf
				case 'R4'
					If not ($ProfileData = 'R4') Then
						R4_profile()
					   If ($ProfileData = 'R1' or $ProfileData = 'OFF') Then
						_GUIDisable($Form1, 70)
						_Metro_MsgBox(0,"","You have to reboot the computer to apply the profile." ,500, 12, "", 5)	
						_GUIDisable($Form1)
					   Else
						_GUIDisable($Form1, 70)
						_Metro_MsgBox(0,"","You must Log OFF from the account to apply the profile." ,500, 12, "", 5)	
						_GUIDisable($Form1)
					   EndIf
		 			        $ProfileData = "R4"
					        GUICtrlSetData($idComboBoxLoadProfile, $ProfileData)
						_Metro_ToggleCheck($Toggle2)
					EndIf
				case 'Custom'
				    		If not ($ProfileData = 'Custom') Then
					       _GUIDisable($Form1, 70)
 				      	       _Metro_MsgBox(0,"","This option cannot be selected by the user. It is selected when some other settings are changed via 'Advanced Configuration' or the external program.",500,12)	
					       _GUIDisable($Form1)
					       GUICtrlSetData($idComboBoxLoadProfile, $ProfileData)
					EndIf
				case 'OFF'
					If not ($ProfileData = 'OFF') Then
						OFF_profile()
					   If not ($ProfileData = 'R1') Then
						_GUIDisable($Form1, 70)
						_Metro_MsgBox(0,"","You have to reboot the computer to apply the profile." ,500, 12, "", 5)	
						_GUIDisable($Form1)
					   Else
						_GUIDisable($Form1, 70)
						_Metro_MsgBox(0,"","You must Log OFF from the account to apply the profile." ,500, 12, "", 5)	
						_GUIDisable($Form1)
					   EndIf
		 			        $ProfileData = "OFF"
					        GUICtrlSetData($idComboBoxLoadProfile, $ProfileData)
						_Metro_ToggleUnCheck($Toggle2)
					EndIf
			EndSwitch
		case $idComboBoxDefender
			$sComboRead = GUICtrlRead($idComboBoxDefender)
			Switch $sComboRead
				case 'Default'
				    If not ($DefenderData = 'Default') Then
				       RunWait($PowerShellDir & "PowerShell -NonInteractive -WindowStyle hidden -command Set-MpPreference -EnableControlledFolderAccess Disabled; Set-MpPreference -AttackSurfaceReductionRules_Ids BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550,D4F940AB-401B-4EFC-AADC-AD5F3C50688A,3B576869-A4EC-4529-8536-B80A7769E899,75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84,D3E037E1-3EB8-44C8-A917-57927947596D,5BEB7EFE-FD9A-4556-801D-275E5FFC04CC,92E97FA1-2EDF-4476-BDD6-9DD0B4DDDC7B -AttackSurfaceReductionRules_Actions Disabled,Disabled,Disabled,Disabled,Disabled,Disabled,Disabled; ", "", @SW_HIDE)
				       $DefenderData = "Default"
				       GUICtrlSetData($idComboBoxDefender, $DefenderData)
				    EndIf
				case '+ASR'
				    If not ($DefenderData = '+ASR') Then
				       RunWait($PowerShellDir & "PowerShell -NonInteractive -WindowStyle hidden -command Set-MpPreference -EnableControlledFolderAccess Disabled; Set-MpPreference -AttackSurfaceReductionRules_Ids BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550,D4F940AB-401B-4EFC-AADC-AD5F3C50688A,3B576869-A4EC-4529-8536-B80A7769E899,75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84,D3E037E1-3EB8-44C8-A917-57927947596D,5BEB7EFE-FD9A-4556-801D-275E5FFC04CC,92E97FA1-2EDF-4476-BDD6-9DD0B4DDDC7B -AttackSurfaceReductionRules_Actions Enabled,Enabled,Enabled,Enabled,Enabled,Enabled,Enabled; ", "", @SW_HIDE)
				       $DefenderData = "+ASR"
				       GUICtrlSetData($idComboBoxDefender, $DefenderData)
				    EndIf
				case '+CFA'
				    If not ($DefenderData = '+CFA') Then
				       RunWait($PowerShellDir & "PowerShell -NonInteractive -WindowStyle hidden -command Set-MpPreference -EnableControlledFolderAccess Enabled; Set-MpPreference -AttackSurfaceReductionRules_Ids BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550,D4F940AB-401B-4EFC-AADC-AD5F3C50688A,3B576869-A4EC-4529-8536-B80A7769E899,75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84,D3E037E1-3EB8-44C8-A917-57927947596D,5BEB7EFE-FD9A-4556-801D-275E5FFC04CC,92E97FA1-2EDF-4476-BDD6-9DD0B4DDDC7B -AttackSurfaceReductionRules_Actions Disabled,Disabled,Disabled,Disabled,Disabled,Disabled,Disabled; ", "", @SW_HIDE)
				       $DefenderData = "+CFA"
				       GUICtrlSetData($idComboBoxDefender, $DefenderData)
				    EndIf
				case '+Both'
				    If not ($DefenderData = '+Both') Then
				       RunWait($PowerShellDir & "PowerShell -NonInteractive -WindowStyle hidden -command Set-MpPreference -EnableControlledFolderAccess Enabled; Set-MpPreference -AttackSurfaceReductionRules_Ids BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550,D4F940AB-401B-4EFC-AADC-AD5F3C50688A,3B576869-A4EC-4529-8536-B80A7769E899,75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84,D3E037E1-3EB8-44C8-A917-57927947596D,5BEB7EFE-FD9A-4556-801D-275E5FFC04CC,92E97FA1-2EDF-4476-BDD6-9DD0B4DDDC7B -AttackSurfaceReductionRules_Actions Enabled,Enabled,Enabled,Enabled,Enabled,Enabled,Enabled; ", "", @SW_HIDE)
				       $DefenderData = "+Both"
				       GUICtrlSetData($idComboBoxDefender, $DefenderData)
				    EndIf				
				case 'Custom'
				    If not ($DefenderData = 'Custom') Then
				       _GUIDisable($Form1, 70)
 			      	       _Metro_MsgBox(0,"","This option cannot be selected by the user. It is selected when some other settings are changed via <Advanced Configuration> or the external program.",500,12)	
				       _GUIDisable($Form1)
				       GUICtrlSetData($idComboBoxDefender, $DefenderData)
				    EndIf
			EndSwitch
		case $Button7
				WhitelistBlockedFolders()
		case $Button8
				FullEventLogView()


	EndSwitch
WEnd

EndFunc

Func isSRPHard_ConfiguratorNOTInstalled()
Local $isNotinstalled = 0
Local $key1 = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers'
Local $key2 = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers'
If not (RegRead($key1, 'Installed')=1) Then $isNotinstalled = $isNotinstalled + 1
Local $DefaultLevel = RegRead($key2,'DefaultLevel')
If @error Then $DefaultLevel = @error
IF not ($DefaultLevel = 131072 or $DefaultLevel = 262144 or $DefaultLevel = 0) Then $isNotinstalled = $isNotinstalled + 1
Local $PolicyScope = RegRead($key2,'PolicyScope')
If @error Then $PolicyScope = @error
IF not ($PolicyScope = 1 or $PolicyScope = 0) Then $isNotinstalled = $isNotinstalled + 1
Local $TransparentEnabled = RegRead($key2,'TransparentEnabled')
If @error Then $TransparentEnabled = @error
If not ($TransparentEnabled = 1 or $TransparentEnabled = 0 or $TransparentEnabled = 2) Then $isNotinstalled = $isNotinstalled + 1
Local $key3 = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers\262144\Paths\{F38BF404-1D43-42F2-9305-67DE0B28FC23}'
Local $SystemRoot_Folder = RegRead($key3,'ItemData')
If not ($SystemRoot_Folder = '%SystemRoot%' or $SystemRoot_Folder = '%HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\SystemRoot%') Then $isNotinstalled = $isNotinstalled + 1
;MsgBox(0,"",$isNotinstalled)
Return $isNotinstalled
EndFunc

Func AreScriptsBlocked()

Local $keyname = 'HKLM\Software\Policies\Microsoft\Windows\PowerShell'
Local $valuename = 'EnableScripts'
Local $NoPowerShellExecution = RegRead ( $keyname, $valuename )
Local $iskey = @error
Switch $NoPowerShellExecution
   case 1
      $NoPowerShellExecution = "OFF"
   case 0
      $NoPowerShellExecution = "ON"
   case Else
     $NoPowerShellExecution = "?"
EndSwitch
If ($iskey = -1 or $iskey =1) Then $NoPowerShellExecution = "OFF"

$keyname = 'HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings'
Local $keyname1 = 'HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows Script Host\Settings'
Local $valuename = 'Enabled'
Local $DisableWSH = RegRead ( $keyname, $valuename )
$iskey = @error
;* Poprawka na błąd wcześniejszych wersji Hard_Configuratora
RegRead ( $keyname1, $valuename )
If (@error=0 And @OSArch="X86") Then RegDelete ($keyname1, $valuename)
;* Koniec poprawki
$DisableWSH = $DisableWSH & RegRead ( $keyname1, $valuename )
$iskey = $iskey & @error
;MsgBox(262144,"", $iskey & "     " & $DisableWSH)
Select
   case ($iskey='00' And $DisableWSH = '00' And @OSArch="X64")
      $DisableWSH = "ON"
   case ($iskey='00' And $DisableWSH = '11' And @OSArch="X64")
      $DisableWSH = "OFF"
   case ($iskey = '-10' and $DisableWSH = 1 And @OSArch="X64")
      $DisableWSH = "OFF"
   case ($iskey = '-1-1' And @OSArch="X64")
      $DisableWSH = "OFF"
   case ($iskey = '0-1' and $DisableWSH = 1)
      $DisableWSH = "OFF"
   case ($iskey = '-11' And @OSArch="X86")
      $DisableWSH = "OFF"
   case ($iskey = '01' And $DisableWSH = 1 And @OSArch="X86")
      $DisableWSH = "OFF"
   case ($iskey = '01' And $DisableWSH = 0 And @OSArch="X86")
      $DisableWSH = "ON"
   case ($iskey = '0-1' And $DisableWSH = 0 And @OSArch="X86")
      $DisableWSH = "ON"
   case Else
     $DisableWSH = "?"
EndSelect

If ($NoPowerShellExecution = "OFF" And $DisableWSH = "OFF") Then Return 0
If ($NoPowerShellExecution = "ON" And $DisableWSH = "ON") Then Return 1
Return 2
EndFunc


Func FullEventLogView()
  If @OSARCH = "X64" Then
     ShellExecute($ProgramFolder & 'TOOLS\FullEventLogView(x64)\FullEventLogView.exe', "", $ProgramFolder & 'TOOLS\FullEventLogView(x64)')
  EndIf
  If @OSARCH = "X86" Then
     ShellExecute($ProgramFolder & 'TOOLS\FullEventLogView(x86)\FullEventLogView.exe', "", $ProgramFolder & 'TOOLS\FullEventLogView(x86)')
  EndIf

  Local $sMessage = "Please wait! It will take some time"
  SplashTextOn("Warning", $sMessage, 300, 50, -1, -1, 0, "", 10)
     Sleep(5000)
  SplashOff()
EndFunc


Func WhitelistBlockedFolders()
#include <Array.au3>
#Include <File.au3>
#include <FileConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
If isSRPHard_ConfiguratorNOTInstalled()=0 Then
   AddFolderLauncher()
Else
   MsgBox(262144,"","Software Restriction Policies were not installed yet.")
EndIf
;HCLauncher()
EndFunc


Func AreOfficeDocumentsProtected()
Local $aArray = SubkeysFromKey2Array('HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options')
Local $notFoundNumber = 0
;OpenOffice, LibreOffice
If CheckIfChildIsON($aArray, 'sbase.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'scalc.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'sdraw.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'simpress.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'smath.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'sweb.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'swriter.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
;SoftmakerOffice
If CheckIfChildIsON($aArray, 'BasicMaker.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'EqnEdt32.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'PlanMaker.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'Presentations.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'TextMaker.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
;KingSoft WPS Office
If CheckIfChildIsON($aArray, 'wpp.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'wps.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'et.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
;MS Office
If CheckIfChildIsON($aArray, 'WINWORD.EXE') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'EXCEL.EXE') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'MSACCESS.EXE') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'POWERPNT.EXE') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'PPTVIEW.EXE') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'VISIO.EXE') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'WINPROJ.EXE') = -1 Then $notFoundNumber = $notFoundNumber + 1
;WordPerfect Office 11 and later
If CheckIfChildIsON($aArray, 'wpwin11.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'wpwin12.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'wpwin13.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'wpwin14.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'wpwin15.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'wpwin16.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'wpwin17.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'wpwin18.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'wpwin19.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'PrWin11.EXE') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'PrWin12.EXE') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'PrWin13.EXE') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'PrWin14.EXE') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'PrWin15.EXE') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'PrWin16.EXE') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'PrWin17.EXE') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'PrWin18.EXE') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'PrWin19.EXE') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'ps110.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'ps120.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'ps130.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'ps140.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'ps150.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'ps160.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'ps170.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'ps180.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'ps190.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'qpw11.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'qpw12.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'qpw13.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'qpw14.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'qpw15.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'qpw16.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'qpw17.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'qpw18.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
If CheckIfChildIsON($aArray, 'qpw19.exe') = -1 Then $notFoundNumber = $notFoundNumber + 1
;MsgBox(0,"",$notFoundNumber)
Switch $notFoundNumber
   case 0
	Return 2
   case 58
	Return 1
   case Else
	Return 3
EndSwitch
EndFunc


Func CheckIfChildIsON($progArray, $program)

Local $regKey = 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\' & $program
If _ArraySearch($progArray, $program) = -1 Then Return -1

Local $mitigation = RegRead($regKey, 'MitigationOptions')
If @error Then Return -1

Switch $mitigation
   case (StringLen($mitigation) >= 34)
	Local $mitigationPart1 = StringLeft($mitigation, 26)
	Local $mitigationPart2 = StringRight($mitigation, StringLen($mitigation) - 26)
;	MsgBox(0,"", $program & '       ' &  $mitigationPart2)
	If StringLeft($mitigationPart2 , 1) = '1' Then
	   Return 1
	Else
	   Return -1
	EndIf
   case Else
	Return -1
EndSwitch

EndFunc



Func OfficeDocumentsProtection($val)
If $val = '1' Then 
;OpenOffice, LibreOffice
   ChangeNoChildMitigation('sbase.exe', '1')
   ChangeNoChildMitigation('scalc.exe', '1')
   ChangeNoChildMitigation('sdraw.exe', '1')
   ChangeNoChildMitigation('simpress.exe', '1')
   ChangeNoChildMitigation('smath.exe', '1')
   ChangeNoChildMitigation('sweb.exe', '1')
   ChangeNoChildMitigation('swriter.exe', '1')
;SoftmakerOffice
   ChangeNoChildMitigation('BasicMaker.exe', '1')
   ChangeNoChildMitigation('EqnEdt32.exe', '1')
   ChangeNoChildMitigation('PlanMaker.exe', '1')
   ChangeNoChildMitigation('Presentations.exe', '1')
   ChangeNoChildMitigation('TextMaker.exe', '1')
;KingSoft WPS Office
   ChangeNoChildMitigation('wpp.exe', '1')
   ChangeNoChildMitigation('wps.exe', '1')
   ChangeNoChildMitigation('et.exe', '1')
;MS Office
   ChangeNoChildMitigation('WINWORD.EXE', '1')
   ChangeNoChildMitigation('EXCEL.EXE', '1')
   ChangeNoChildMitigation('MSACCESS.EXE', '1')
   ChangeNoChildMitigation('POWERPNT.EXE', '1')
   ChangeNoChildMitigation('PPTVIEW.EXE', '1')
   ChangeNoChildMitigation('VISIO.EXE', '1')
   ChangeNoChildMitigation('WINPROJ.EXE', '1')
;WordPerfect Office 11 and later
   ChangeNoChildMitigation('wpwin11.exe', '1')
   ChangeNoChildMitigation('wpwin12.exe', '1')
   ChangeNoChildMitigation('wpwin13.exe', '1')
   ChangeNoChildMitigation('wpwin14.exe', '1')
   ChangeNoChildMitigation('wpwin15.exe', '1')
   ChangeNoChildMitigation('wpwin16.exe', '1')
   ChangeNoChildMitigation('wpwin17.exe', '1')
   ChangeNoChildMitigation('wpwin18.exe', '1')
   ChangeNoChildMitigation('wpwin19.exe', '1')
   ChangeNoChildMitigation('PrWin11.EXE', '1')
   ChangeNoChildMitigation('PrWin12.EXE', '1')
   ChangeNoChildMitigation('PrWin13.EXE', '1')
   ChangeNoChildMitigation('PrWin14.EXE', '1')
   ChangeNoChildMitigation('PrWin15.EXE', '1')
   ChangeNoChildMitigation('PrWin16.EXE', '1')
   ChangeNoChildMitigation('PrWin17.EXE', '1')
   ChangeNoChildMitigation('PrWin18.EXE', '1')
   ChangeNoChildMitigation('PrWin19.EXE', '1')
   ChangeNoChildMitigation('ps110.exe', '1')
   ChangeNoChildMitigation('ps120.exe', '1')
   ChangeNoChildMitigation('ps130.exe', '1')
   ChangeNoChildMitigation('ps140.exe', '1')
   ChangeNoChildMitigation('ps150.exe', '1')
   ChangeNoChildMitigation('ps160.exe', '1')
   ChangeNoChildMitigation('ps170.exe', '1')
   ChangeNoChildMitigation('ps180.exe', '1')
   ChangeNoChildMitigation('ps190.exe', '1')
   ChangeNoChildMitigation('qpw11.exe', '1')
   ChangeNoChildMitigation('qpw12.exe', '1')
   ChangeNoChildMitigation('qpw13.exe', '1')
   ChangeNoChildMitigation('qpw14.exe', '1')
   ChangeNoChildMitigation('qpw15.exe', '1')
   ChangeNoChildMitigation('qpw16.exe', '1')
   ChangeNoChildMitigation('qpw17.exe', '1')
   ChangeNoChildMitigation('qpw18.exe', '1')
   ChangeNoChildMitigation('qpw19.exe', '1')
;   ChangeNoChildMitigation('', '1')
Else
;OpenOffice, LibreOffice
   ChangeNoChildMitigation('sbase.exe', '0')
   ChangeNoChildMitigation('scalc.exe', '0')
   ChangeNoChildMitigation('sdraw.exe', '0')
   ChangeNoChildMitigation('simpress.exe', '0')
   ChangeNoChildMitigation('smath.exe', '0')
   ChangeNoChildMitigation('sweb.exe', '0')
   ChangeNoChildMitigation('swriter.exe', '0')
;SoftmakerOffice
   ChangeNoChildMitigation('BasicMaker.exe', '0')
   ChangeNoChildMitigation('EqnEdt32.exe', '0')
   ChangeNoChildMitigation('PlanMaker.exe', '0')
   ChangeNoChildMitigation('Presentations.exe', '0')
   ChangeNoChildMitigation('TextMaker.exe', '0')
;KingSoft WPS Office
   ChangeNoChildMitigation('wpp.exe', '0')
   ChangeNoChildMitigation('wps.exe', '0')
   ChangeNoChildMitigation('et.exe', '0')
;MS Office
   ChangeNoChildMitigation('WINWORD.EXE', '0')
   ChangeNoChildMitigation('EXCEL.EXE', '0')
   ChangeNoChildMitigation('MSACCESS.EXE', '0')
   ChangeNoChildMitigation('POWERPNT.EXE', '0')
   ChangeNoChildMitigation('PPTVIEW.EXE', '0')
   ChangeNoChildMitigation('VISIO.EXE', '0')
   ChangeNoChildMitigation('WINPROJ.EXE', '0')
;WordPerfect Office 11 and later
   ChangeNoChildMitigation('wpwin11.exe', '0')
   ChangeNoChildMitigation('wpwin12.exe', '0')
   ChangeNoChildMitigation('wpwin13.exe', '0')
   ChangeNoChildMitigation('wpwin14.exe', '0')
   ChangeNoChildMitigation('wpwin15.exe', '0')
   ChangeNoChildMitigation('wpwin16.exe', '0')
   ChangeNoChildMitigation('wpwin17.exe', '0')
   ChangeNoChildMitigation('wpwin18.exe', '0')
   ChangeNoChildMitigation('wpwin19.exe', '0')
   ChangeNoChildMitigation('PrWin11.EXE', '0')
   ChangeNoChildMitigation('PrWin12.EXE', '0')
   ChangeNoChildMitigation('PrWin13.EXE', '0')
   ChangeNoChildMitigation('PrWin14.EXE', '0')
   ChangeNoChildMitigation('PrWin15.EXE', '0')
   ChangeNoChildMitigation('PrWin16.EXE', '0')
   ChangeNoChildMitigation('PrWin17.EXE', '0')
   ChangeNoChildMitigation('PrWin18.EXE', '0')
   ChangeNoChildMitigation('PrWin19.EXE', '0')
   ChangeNoChildMitigation('ps110.exe', '0')
   ChangeNoChildMitigation('ps120.exe', '0')
   ChangeNoChildMitigation('ps130.exe', '0')
   ChangeNoChildMitigation('ps140.exe', '0')
   ChangeNoChildMitigation('ps150.exe', '0')
   ChangeNoChildMitigation('ps160.exe', '0')
   ChangeNoChildMitigation('ps170.exe', '0')
   ChangeNoChildMitigation('ps180.exe', '0')
   ChangeNoChildMitigation('ps190.exe', '0')
   ChangeNoChildMitigation('qpw11.exe', '0')
   ChangeNoChildMitigation('qpw12.exe', '0')
   ChangeNoChildMitigation('qpw13.exe', '0')
   ChangeNoChildMitigation('qpw14.exe', '0')
   ChangeNoChildMitigation('qpw15.exe', '0')
   ChangeNoChildMitigation('qpw16.exe', '0')
   ChangeNoChildMitigation('qpw17.exe', '0')
   ChangeNoChildMitigation('qpw18.exe', '0')
   ChangeNoChildMitigation('qpw19.exe', '0')
;   ChangeNoChildMitigation('', '0')
EndIf
EndFunc

Func ChangeNoChildMitigation($ExeName, $binaryMitigation)
; $ExeName is a name of EXE file, for example eso.exe
; $binaryMitigation is 1 or 0 mitigation value
Local $regKey = 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\' & $ExeName
Local $mitigation = RegRead($regKey, 'MitigationOptions')
If @error Then
	RegWrite($regKey, 'MitigationOptions','REG_BINARY', Binary('0x00000000000000000000000000000000'))
	RegWrite($regKey, 'MitigationAuditOptions','REG_BINARY', Binary('0x00000000000000000000000000000000'))
	$mitigation = '0x00000000000000000000000000000000'
EndIf
Switch $mitigation
   case (StringLen($mitigation) >= 34)
	   Local $mitigationPart1 = StringLeft($mitigation, 26)
	   Local $mitigationPart2 = StringRight($mitigation, StringLen($mitigation) - 26)
;   	    MsgBox(0,"", $mitigation & @CRLF & $mitigationPart1 & $mitigationPart2)
	   Local $mitigation3 = $mitigationPart1 & $binaryMitigation & StringTrimLeft($mitigationPart2, 1)
;	   MsgBox(0,"", $mitigation3 & @CRLF & $mitigation)
 	   RegWrite($regKey, 'MitigationOptions', 'REG_BINARY', Binary($mitigation3))
   case Else
      If $binaryMitigation = 1 Then
         _GUIDisable($Form1, 70)
         _Metro_MsgBox(0,"","The application " & $ExeName & " has already some anti-exploit mitigations in an old format, so they cannot be changed here. You can use Exploit Protection feature from Windows Defender Security Center and set manually 'Do not allow child processes' mitigation to ON. This will also update the old mitigation format to work with 'Advanced Office Documents Protection'.",500,12)
         _GUIDisable($Form1)
	GUICtrlSetData($idComboBoxDocumentsProtection, 'Partial')
      EndIf
EndSwitch
EndFunc

Func LoadProfile()
EndFunc


Func HelpSwitchDefaultDeny()
Local $text1 = "The toggle on the right side of the 'Switch Default-Deny Protection' label can turn ON/OFF default-deny protection. Switching OFF can be useful, if there is a problem with an application installation via 'Run As SmartScreen' or 'Run as administrator'. In such case, the user can:" & @crlf & "switch OFF to disable protection >> install an application >> switch ON to restore protection" & @crlf &  @crlf & "In the OFF position, the WDDS application is configured to start with Windows." & @crlf & "Switching OFF does not remove all policies made by WDDS application. This is posiible only when choosing the OFF profile via 'Default-Deny Profiles' option."
_SetTheme("LightTeal")
_GUIDisable($Form1, 70)
_Metro_MsgBox(0,"Switch Default-Deny Protection",$text1 ,600,10)
_GUIDisable($Form1)
_SetTheme("DarkTeal")
EndFunc


Func GeneralHelp()
EndFunc

Func Introduction()
Local $text1 = "Windows Default-Deny Security (WDDS) is a configurator that applies Windows policies to block the executables, which are not installed in the recommended by Microsoft locations (Default-Deny Protection). Additionally, it provides some system hardening against Windows script and command line vulnerabilities, remote access, unneeded Internet access, etc. So, it does not block already installed applications, but the executables downloaded from the Internet or stored on other sources (pendrive, DVD, secondary disk, external disk, etc.) will be blocked. This is a very strong prevention against the 0-day malware files and exploits, because the execution of those files will be automatically blocked."
Local $text2 = "WDDS contains 4 protection layers: 'Default-Deny Protection', 'Windows Defender Settings', 'Advanced Office Documents Protection', and 'Firewall Hardening'. The most important is the first layer that can be managed via 2 options 'Switch Default-Deny Protection' and 'Default-Deny Profiles'. Predefined default-deny profiles apply policies for executables, Windows scripts, remote access, and system hardening. The other layers can strengthen the protection at the expense of some usability, because some features in the applications may be not available."
Local $text3 = "WDDS can prevent execution of most 0-day malware files, but it would also block all new application installers. So, what can be done to install the new applications, which will be also blocked when run via a mouse click or pressing the enter key? Default-Deny Protection adds an option in the Explorer context menu named: 'Run As SmartScreen'. The user can right-click on the file and choose this option to execute an application installer. This option can run EXE or MSI files with administrative rights and check them by SmartScreen via the Microsoft Application Reputation cloud. If the executable has got good enough reputation, then it will be allowed to run."

_SetTheme("LightTeal")
_GUIDisable($Form1, 70)
_Metro_MsgBox(0,"Introduction",$text1 & @CRLF & @CRLF & $text2 & @CRLF & @CRLF & $text3, 700, 10)
_GUIDisable($Form1)
_SetTheme("DarkTeal")
EndFunc


Func RecommendedSettings()
Local $text1 = "The recommended Windows security configuration, when using WDDS with R1 profile + Windows Defender antivirus, is as follows:" & @CRLF & "1. Protected View - use Universal Applications from Microsoft Store for viewing/printing Office documents and PDF/EPUB... files. Those applications use App Container isolation, so it is hard to exploit them." & @CRLF & "2. Use your favorite desktop Office applications and favorite desktop PDF/EPUB... readers/editors for managing documents created by yourself or from trusted sources." & @CRLF & "2. Choose '+ASR' setting in WDDS 'Windows Defender Settings'." & @CRLF & "3. Use Edge or Chrome as default web browser - both have strong sandboxes." & @CRLF & "4. Use safe DNS (like Adguard DNS) or at least any adblock extension in the web browser." & @CRLF & "5. Do not ignore SmartScreen alerts when running application installers via 'Run As SmartScreen' from Explorer context menu."
Local $text2 = "For home users, the above configuration applies a decent prevention against all kinds of malware and exploits. All WDDS executables were sent to Microsoft for manual checking and they are already accepted by Windows Defender. So, Windows Defender is the preferred antivirus when using WDDS. There is no serious problem to choose another antivirus. The only difference is that some WDDS executables can be flagged as unsafe and the user has to make the exclusions for them. When using another Anti Virus, Windows blocks the possibility of changing the Defender settings, but ASR mitigations are still active. So, it is important to set 'Windows Defender Settings' = Default, before installing the new Anti Virus."
Local $text3 = "Generally, the more elements from the above security configuration are weakened, the stronger should be WDDS protection. For example, dropping the point 1. in favor of using an unsupported MS Office 2007 for viewing documents, opens many vulnerabilities (OLE, DDE commands, ActiveX Components, etc). Still, even in such case, WDDS applies a pretty good protection via the R1 profile and '+ASR' Windows Defender settings. But, that can be insufficient to stop more sophisticated malware related to Office documents. So, the user should activate additional restrictions for file execution via: R3 profile, or 'Advanced Office Documents Protection', or 'Firewall Hardening' (or any combination of the above)." & @CRLF & "On many computers, the users can activate without problems all WDDS/Hard_Configurator protection layers, but in some hardware/software configurations that will not be possible and the optimal protection can be adjusted only by advanced users via 'Advanced Configuration' option."
_SetTheme("LightTeal")
_GUIDisable($Form1, 70)
_Metro_MsgBox(0,"Recommended Settings",$text1 & @CRLF & @CRLF & $text2 & @CRLF & @CRLF & $text3, 700, 10)
_GUIDisable($Form1)
_SetTheme("DarkTeal")
EndFunc


Func HelpScriptProtection()
Local $text1 = "If this option is set to 'ON', then both Windows Script Host and PowerShell script execution is blocked for local drives, not only when run as standard user, but also when run with higher rights. This will also block scripts in whitelisted folders. Executing the PowerShell commands and cmdlets via command line or in the Powershell console is still allowed (restricted by Constrained Language mode applied by R1-R4 default-deny profiles)."
Local $text2 = "If this option is set to 'OFF', then the script protection applies to Windows Script Host and PowerShell script execution only via default-deny profile (R1-R4, see the option 'Default-Deny Profiles'). This is also a pretty good protection - more usable without losing much security."
Local $text3 = "If the script policy settings are not recognized as 'ON' or 'OFF' then the program selects 'Partial' option.  This is possible when script policies are set via <Advanced Configuration> program options or when using the external program."
_SetTheme("LightTeal")
_GUIDisable($Form1, 70)
_Metro_MsgBox(0,"Advanced Script Protection",$text1 & @CRLF & @CRLF & $text2 & @CRLF & @CRLF & $text3, 600, 10)
_GUIDisable($Form1)
_SetTheme("DarkTeal")
EndFunc

Func HelpOfficeDocumentsProtection()
Local $text1 = "'Advanced Office Documents Protection' can be useful, when the user needs an additional protection for the older MS Office versions (Office 2007 and prior) or non-Microsoft desktop applications: LibreOffice, Apache OpenOffice, Kingsoft WPS Office, SoftMaker Office, WordPerfect Office. This can happen, when Office documents from unsafe sources have to be opened for editing (unusual situation in home computing)." & @CRLF & @CRLF & "'Advanced Office Documents Protection' is based on a very restrictive mitigation (Do not allow child processes), so some Office application features can be not available, like:" & @CRLF & "1. Starting a print session from the Office application window." & @CRLF & "2. Running the features dependent on external programs." & @CRLF & @CRLF & "When using the recommended configuration, the Office Mobile applications open documents by default for viewing/printing. So, the user cannot open the document for editing from Explorer by a mouse click or pressing the Enter key. First, the desktop Office application used for document editing has to be opened, and next, the document has to be loaded from this application." & @CRLF & "It is worth to know that printing any document (even the blank one) from Office Mobile or Adobe Reader Touch (Universal Applications), opens the print session, and then printing is also possible from the protected desktop Office application." & @CRLF & "If one does not like Word Mobile, Excel Mobile, and PowerPoint Mobile for document viewing/printing, then another possibility is saving the document as PDF and print it from the PDF viewer." & @CRLF & @CRLF
Local $text2 = "For MS Office 2010 at least, 'Advanced Office Documents Protection' can be safely turned OFF, because 'Do not allow child processes' mitigation is already included in '+ASR' setting from 'Windows Defender Settings' option."
Local $text3 = ""
_SetTheme("LightTeal")
_GUIDisable($Form1, 70)
_Metro_MsgBox(0,"Advanced Office Documents Protection", $text1 & $text2 & $text3, 600, 10)
_GUIDisable($Form1)
_SetTheme("DarkTeal")
EndFunc


Func HelpDefaultDenyProfiles()
Local $text1 = "The user can choose predefined default-deny settings by selecting the profile from the combo-box list on the right side of the 'Default-Deny Profiles' label. The default WDDS settings apply the R1 profile. This profile can prevent most 0-day malware infections and exploits, including fileless PowerShell attacks. Furthermore, it works well with most hardware/software configurations. Other profiles (R2, R3, R4) are more restrictive, so they can be applied only by experienced users." & @CRLF & @CRLF
Local $text2 = ""
Local $text3 = ""
_SetTheme("LightTeal")
_GUIDisable($Form1, 70)
_Metro_MsgBox(0,"Default-Deny Profiles", $text1 & $text2 & $text3, 600, 10)
_GUIDisable($Form1)
_SetTheme("DarkTeal")
EndFunc


Func HelpWindowsDefenderSettings()
Local $text1 = "This option allows activating Defender Attack Surface Reduction mitigations (+ASR setting), which protect MS Office 2010 and newer versions, against the malware and macros embedded in Office documents. Additionally it can block executable content from email client or webmail, and restricts the execution of macros, Windows Script Host and PowerShell scripts in other applications." & @CRLF & @CRLF & "The user can also activate Defender Controlled Folder Access feature (+CFA setting), which is the basic anti-ransomware protection. Both features, can be additionally configured via <Advanced Configuration> --> <Defender> options." & @CRLF & "ASR and CFA features are disabled when choosing the 'Default' setting." & @CRLF & @CRLF & "When using another antivirus, the ASR and CFA settings are frozen and cannot be reconfigured. So, it is recommended to set 'Windows Defender Settings' to 'Default' in WDDS before installing third party antivirus over Defender."
_SetTheme("LightTeal")
_GUIDisable($Form1, 70)
_Metro_MsgBox(0,"Windows Defender Settings", $text1, 600, 10)
_GUIDisable($Form1)
_SetTheme("DarkTeal")
EndFunc

Func HelpBlue()
Local $text0 = "This is the help for the blue buttons. The help for the items on green labels can be displayed when left clicking the particular label."
Local $text1 = "'Blocked Events' option runs Nirsoft FullEventLogView tool that allows to see the processess blocked by Default-Deny Protection and Windows Defender."
Local $text2 = "<Whitelist Folders> option opens the dialog window that allows to select particular folder. The selected folder will be added to the White List, and the executables in this folder will be allowed by Default-Deny Protection."
Local $text3 = "<Advanced Configuration> option runs Hard_Configurator application that allows to configure more settings related to Software Restriction Policies, Windows Defender and system hardening. This application can be used only by advanced users."
_SetTheme("LightTeal")
_GUIDisable($Form1, 70)
_Metro_MsgBox(0,"Help for the blue buttons.", $text0 & @CRLF & @CRLF & $text1 & @CRLF & @CRLF & $text2 & @CRLF & @CRLF & $text3, 600, 10)
_GUIDisable($Form1)
_SetTheme("DarkTeal")
EndFunc


Func TurnOnAllSRP()
; The name of this option is changed to <Recommended SRP>.

; First create backup of SRP Whitelist, delete all SRP keys, delete ...\safer_Hard_Configurator\Codeidentifiers, where are
; stored the BlockSponsors parameters and keys. Next add the installed flag. Then Reinstall SRP, restore the Whitelist from
; the backup, and delete the Whitelist backup.

; Turn off refreshing Windows Explorer
$RefreshExplorer = 0

Local $key = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\'
Local $whitelist = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers\262144'
  _RegCopyKey($whitelist, $key & 'Whitelist_Backup')
  RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers')
  RegDelete($key & 'CodeIdentifiers\BlockSponsors')
  SRP()
  _RegCopyKey($key & 'Whitelist_Backup', $whitelist)
  RegDelete($key & 'Whitelist_Backup')

; Add Recommended keys for SRP DefaultLevel and TransparentEnabled values.
  Local $Reg = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers';
  Select
     case @OSVersion="WIN_VISTA"
       RegWrite($Reg, 'DefaultLevel','REG_DWORD',Number('0'))
     case (@OSVersion="WIN_10" or @OSVersion="WIN_81" or @OSVersion="WIN_8" or @OSVersion="WIN_7")
       RegWrite($Reg, 'DefaultLevel','REG_DWORD',Number('131072'))
     case Else
       MsgBox(262144,"", "This Windows version is not supported to manage SRP in Hard_Configurator")
  EndSelect
  RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers', 'TransparentEnabled','REG_DWORD',Number('1'))

; Add Protect Windows Folder and Protect Shortcuts.
  If $GreyWritableSubWindows = 0 Then
     $WritableSubWindows = 'OFF'
     WritableSubWindows('1')
  EndIf
  $DenyShortcuts = "OFF"
  Deny_Shortcuts('1')

ShowRegistryTweaks()
;Turn ON refreshing Windows Explorer
$RefreshExplorer = 1

EndFunc



Func R1_profile()
Local $keyname
Local $valuename

;Turn on recommended restrictions 
;Turn OFF refreshing Windows Explorer
;$RefreshExplorer = 0

RegWrite($keynamePS, $valuenamePS, 'REG_DWORD', Number('1'))
$NoPowerShellExecution = "OFF"

SRP()
$isSRPinstalled = "Installed"
$SRPTransparentEnabled = "Skip DLLs"

If not (CheckWritableSubWindows()=1) Then WritableSubWindows('1')
$DenyShortcuts = "OFF"
Deny_Shortcuts('1')

RegDelete('HKEY_CLASSES_ROOT\*\shell\Run As SmartScreen')
RegDelete('HKEY_CLASSES_ROOT\*\shell\Run By SmartScreen')
RunAsSmartScreen("Administrator")

; Set recommended value to ON if $RunAsSmartScreen = "Administrator"
$keyname = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$valuename = "HideRunAsVerb"
RegWrite($keyname, $valuename,'REG_DWORD', Number('1'))

$keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
Local $keyRemoteShell = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service\WinRS'
Local $keyRemoteRegistry = 'HKLM\SYSTEM\CurrentControlSet\Services\RemoteRegistry'

RegWrite($keyname, 'fAllowUnsolicited','REG_DWORD',Number('0'))
RegWrite($keyname, 'fAllowToGetHelp','REG_DWORD',Number('0'))
RegWrite($keyname, 'fDenyTSConnections','REG_DWORD',Number('1'))
RegWrite($keyRemoteShell, 'AllowRemoteShellAccess','REG_DWORD',Number('0'))
RegWrite($keyRemoteRegistry, 'Start','REG_DWORD',Number('4'))
Run("net stop RemoteRegistry",@SystemDir,@SW_HIDE)

$keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat'
$valuename = 'VDMDisallowed'
$RegDataNew = 1
RegWrite($keyname, $valuename,'REG_DWORD',$RegDataNew)

$keyname = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'
$valuename = 'EnforceShellExtensionSecurity'
$RegDataNew = 0
RegWrite($keyname, $valuename,'REG_DWORD',$RegDataNew)

$keyname = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
$valuename = 'ConsentPromptBehaviorUser'
$RegDataNew = 3
RegWrite($keyname, $valuename,'REG_DWORD',$RegDataNew)

$keyname = 'HKCR\Msi.Package\shell\runas\command'
$valuename = ''
$RegDataNew = '"%SystemRoot%\System32\msiexec.exe" /i "%1" %*'
RegWrite($keyname, $valuename,'REG_EXPAND_SZ',$RegDataNew)

RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb20', 'Start', 'REG_DWORD', Number('3'))
;           Set FF and change to ON1
RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB1', 'REG_DWORD', Number('1'))
RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB2', 'REG_DWORD', Number('1'))
DisableSMB('1')

$keyname = 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'
$valuename = 'CachedLogonsCount'
RegWrite ( $keyname, $valuename,'REG_SZ','0')

Local $keyname = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\CredUI'
Local $valuename = 'EnableSecureCredentialPrompting'
;MsgBox(0,"",$UACSecureCredentialPrompting)
If not ($UACSecureCredentialPrompting = "OFF") Then RegWrite($keyname, $valuename,'REG_DWORD',Number('0'))
AllowAllSponsors()
AddPowerShellExtensions()
RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers', 'DefaultLevel','REG_DWORD',Number('0'))
RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers\0\Paths\{1016bbe0-a716-428b-822e-5E544B6A3301}')
RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\0\paths\{1016bbe0-a716-428b-822e-5E544B6A3301}', 'ItemData', 'REG_SZ', 'protected')

EndFunc


Func R2_profile()

Local $keyname
Local $valuename
R1_profile()

RegWrite($keynamePS, $valuenamePS, 'REG_DWORD', Number('0'))
$NoPowerShellExecution = "ON"
$keyname = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'
$valuename = 'EnforceShellExtensionSecurity'
$RegDataNew = 1
RegWrite($keyname, $valuename,'REG_DWORD',$RegDataNew)
If CorrectSMB10Uninstalled() = 0 Then RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb10', 'Start', 'REG_DWORD', Number('4'))
RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb20', 'Start', 'REG_DWORD', Number('4'))
RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB1', 'REG_DWORD', Number('0'))
RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB2', 'REG_DWORD', Number('0'))
RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation', 'DependOnService','REG_MULTI_SZ', 'Bowser' & @LF & 'NSI')

EndFunc


Func R3_profile()
R2_profile()
_CheckBoxSponsorBlockCMD()
_CheckBoxSponsorBlockPowerShell()
_CheckBoxSponsorBlockPowerShell_ise()
;Block MsHta.exe, Reg.exe, Wmic.exe
_CheckBoxSponsorBlock29()
_CheckBoxSponsorBlock35()
_CheckBoxSponsorBlock53()
EndFunc


Func R4_profile()
R2_profile()
BlockAllSponsors()
EndFunc



Func OFF_profile()

Local $keyname
Local $valuename

;Turn on recommended restrictions 
;Turn OFF refreshing Windows Explorer
;$RefreshExplorer = 0

RegWrite($keynamePS, $valuenamePS, 'REG_DWORD', Number('1'))
$NoPowerShellExecution = "OFF"

RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\0')
RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers\BlockSponsors')
;RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers','DefaultLevel')
;RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers', 'TransparentEnabled')
RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers', 'DefaultLevel','REG_DWORD',Number('262144'))
RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers', 'TransparentEnabled','REG_DWORD',Number('0'))

RegDelete('HKEY_CLASSES_ROOT\*\shell\Run As SmartScreen')
RegDelete('HKEY_CLASSES_ROOT\*\shell\Run By SmartScreen')
RegWrite ( 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer', 'HideRunAsVerb','REG_DWORD',Number('0'))

$keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
$keyRemoteShell = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service\WinRS'
$keyRemoteRegistry = 'HKLM\SYSTEM\CurrentControlSet\Services\RemoteRegistry'
RegWrite($keyname, 'fAllowUnsolicited','REG_DWORD',Number('1'))
RegWrite($keyname, 'fAllowToGetHelp','REG_DWORD',Number('1'))
RegWrite($keyname, 'fDenyTSConnections','REG_DWORD',Number('0'))
RegWrite($keyRemoteShell, 'AllowRemoteShellAccess','REG_DWORD', Number('1'))
RegWrite($keyRemoteRegistry, 'Start','REG_DWORD',Number('4'))
Run("net stop RemoteRegistry",@SystemDir,@SW_HIDE)

$keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat'
$valuename = 'VDMDisallowed'
$RegDataNew = 0
RegWrite($keyname, $valuename,'REG_DWORD',$RegDataNew)

$keyname = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'
$valuename = 'EnforceShellExtensionSecurity'
$RegDataNew = 0
RegWrite($keyname, $valuename,'REG_DWORD',$RegDataNew)

$keyname = 'HKCR\Msi.Package\shell\runas\command'
$valuename = ''
$RegDataNew = '"%SystemRoot%\System32\msiexec.exe" /i "%1" %*'
RegDelete($keyname, $valuename)


$keyname = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
$valuename = 'ConsentPromptBehaviorUser'
$RegDataNew = 3
RegWrite($keyname, $valuename,'REG_DWORD',$RegDataNew)


RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb20', 'Start', 'REG_DWORD', Number('3'))
;           Set ON123 and change to OFF
RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB1', 'REG_DWORD', Number('0'))
RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB2', 'REG_DWORD', Number('0'))
DisableSMB('1')


If CorrectSMB10Uninstalled() = 1 Then 
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb20', 'Start', 'REG_DWORD', Number('3'))
;           Set FF and change to ON1
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB1', 'REG_DWORD', Number('1'))
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB2', 'REG_DWORD', Number('1'))
   DisableSMB('1')
Else
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb20', 'Start', 'REG_DWORD', Number('3'))
;           Set ON123 and change to OFF
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB1', 'REG_DWORD', Number('0'))
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB2', 'REG_DWORD', Number('0'))
   DisableSMB('1')
EndIf

$keyname = 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'
$valuename = 'CachedLogonsCount'
RegWrite ( $keyname, $valuename,'REG_SZ','10')

Local $keyname = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\CredUI'
Local $valuename = 'EnableSecureCredentialPrompting'
If not ($UACSecureCredentialPrompting = "OFF") Then RegWrite($keyname, $valuename,'REG_DWORD',Number('0'))

AllowAllSponsors()

;Turn ON refreshing Windows Explorer

EndFunc


;Func CorrectSMB10Uninstalled()
;$keyname = 'HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb10'
;$valuename = 'Start'
;RegRead ( $keyname, $valuename )
;If (@error = 1 AND (@OSVersion = "WIN_10" OR @OSVersion = "WIN_81")) Then 
;   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB1', 'REG_DWORD', Number('0'))
;   Return 1
;EndIf
;Return 0
;EndFunc


Func SRP()
; (Re)Install Software Restriction Policies

; Write SRP parameters to Windows Registry

RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers', 'DefaultLevel','REG_DWORD',Number('131072'))
RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers', 'TransparentEnabled','REG_DWORD',Number('1'))
RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers', 'PolicyScope','REG_DWORD',Number('1'))
RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers', 'AuthenticodeEnabled','REG_DWORD',Number('0'))
RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\0\Hashes')
RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\0\Paths')
RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\131072\Paths')
RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\131072\UrlZones')

;Windows 64Bit related
If @OSArch = "X64" Then
   RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\262144\Paths\{6D809377-6AF0-444B-8957-A3773F02200E}', 'Description','REG_SZ','*Default : Program Files on 64 bits')
   RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\262144\Paths\{6D809377-6AF0-444B-8957-A3773F02200E}', 'SaferFlags','REG_DWORD',Number('0'))
   RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\262144\Paths\{6D809377-6AF0-444B-8957-A3773F02200E}', 'ItemData','REG_EXPAND_SZ','%HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\ProgramW6432Dir%')
   RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\262144\Paths\{7C5A40EF-A0FB-4BFC-874A-C0F2E0B9FA8E}', 'Description','REG_SZ','*Default : Program Files (x86) on 64 bits')
   RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\262144\Paths\{7C5A40EF-A0FB-4BFC-874A-C0F2E0B9FA8E}', 'SaferFlags','REG_DWORD',Number('0'))
   RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\262144\Paths\{7C5A40EF-A0FB-4BFC-874A-C0F2E0B9FA8E}', 'ItemData','REG_EXPAND_SZ','%HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\ProgramFilesDir (x86)%')
EndIf

RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\262144\Paths\{905E63B6-C1BF-494E-B29C-65B732D3D21A}', 'Description','REG_SZ','*Default : Program Files (default)')
RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\262144\Paths\{905E63B6-C1BF-494E-B29C-65B732D3D21A}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\262144\Paths\{905E63B6-C1BF-494E-B29C-65B732D3D21A}', 'ItemData','REG_EXPAND_SZ','%HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\ProgramFilesDir%')
RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\262144\Paths\{F38BF404-1D43-42F2-9305-67DE0B28FC23}', 'Description','REG_SZ','*Default : Windows')
RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\262144\Paths\{F38BF404-1D43-42F2-9305-67DE0B28FC23}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\262144\Paths\{F38BF404-1D43-42F2-9305-67DE0B28FC23}', 'ItemData','REG_EXPAND_SZ','%HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\SystemRoot%')
If (@OSVersion="WIN_10" or @OSVersion="WIN_81" or @OSVersion="WIN_8") Then
  RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\262144\Paths\{f073d7e6-ec43-4bf6-a2a8-536eb63b03c8}', 'Description','REG_SZ','*Default : ProgramData\Microsoft\Windows Defender')
  RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\262144\Paths\{f073d7e6-ec43-4bf6-a2a8-536eb63b03c8}', 'SaferFlags','REG_DWORD',Number('0'))
  RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\262144\Paths\{f073d7e6-ec43-4bf6-a2a8-536eb63b03c8}', 'ItemData','REG_EXPAND_SZ','%HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\ProductAppDataPath%')
EndIf

SRPExecutableTypes("light")

EndFunc


Func RunAsSmartScreen($RunAsSmartScreen)

Local $keyname1 = 'HKCR\*\shell\Run As SmartScreen\command'
Local $keyname2 = 'HKCR\*\shell\Run By SmartScreen\command'
Local $keynameIcon1 = 'HKCR\*\shell\Run As SmartScreen'
Local $keynameIcon2 = 'HKCR\*\shell\Run By SmartScreen'
Local $valueIcon = $ProgramFolder & 'Skins\Icons\Parental Controls.ico'


; If "Standard User" or nonstandard then switch to "OFF"
If $RunAsSmartScreen = "OFF" Then
   RegDelete('HKEY_CLASSES_ROOT\*\shell\Run As SmartScreen')
   RegDelete('HKEY_CLASSES_ROOT\*\shell\Run By SmartScreen')
EndIf

Local $valuename = ""

; Switch to "Administrator"
If $RunAsSmartScreen = "Administrator" Then
    If @OSArch="X64" Then Local $value = @WindowsDir & '\Hard_Configurator\RunAsSmartscreen(x64).exe "%1" %*'
    If @OSArch="X86" Then Local $value = @WindowsDir & '\Hard_Configurator\RunAsSmartscreen(x86).exe "%1" %*'
    RegWrite($keynameIcon1, 'Icon','REG_SZ',$valueIcon)
    RegWrite($keyname1, '','REG_SZ',$value)
EndIf
; Switch to "Standard User"
If $RunAsSmartScreen = "Standard User" Then
    If @OSArch="X64" Then Local $value = @WindowsDir & '\Hard_Configurator\RunBySmartscreen(x64).exe "%1" %*'
    If @OSArch="X86" Then Local $value = @WindowsDir & '\Hard_Configurator\RunBySmartscreen(x86).exe "%1" %*'
    RegWrite($keynameIcon2, 'Icon','REG_SZ',$valueIcon)
    RegWrite($keyname2, '','REG_SZ',$value)
EndIf

EndFunc

Func RefreshChangesCheck($x)
EndFunc

Func Deny_Shortcuts($flag)

If $isSRPinstalled = "Installed"  Then
   If not ( $SRPTransparentEnabled = "No Enforcement") Then
      Local $key = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\codeidentifiers'
      Switch $DenyShortcuts
;     Switch the position to 'OFF'
         case "ON"
            Deny_ShortcutsOFF()
            RefreshChangesCheck("Deny_Shortcuts")
;     Switch the position to 'ON'
            case Else
               RefreshChangesCheck("Deny_Shortcuts")
               RegWrite($key & '\0\Paths\{1016bbe0-a716-428b-822e-5E544B6A3301}', 'Description','REG_SZ','*LNK : Global shortcuts deny')
               RegWrite($key & '\0\Paths\{1016bbe0-a716-428b-822e-5E544B6A3301}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\0\Paths\{1016bbe0-a716-428b-822e-5E544B6A3301}', 'ItemData','REG_SZ','*.lnk')
               RegWrite($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}', 'Description','REG_SZ','*LNK : Desktop')
               RegWrite($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%' & '\Desktop\*.lnk')
               RegWrite($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C642}', 'Description','REG_SZ','*LNK : Desktop subfolders')
               RegWrite($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C642}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C642}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%' & '\Desktop\*\*.lnk')
               RegWrite($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C643}', 'Description','REG_SZ','*LNK : Public Desktop')
               RegWrite($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C643}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C643}', 'ItemData','REG_EXPAND_SZ',@DesktopCommonDir & '\*.lnk')
               RegWrite($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C644}', 'Description','REG_SZ','*LNK : TaskBar (AppData\Roaming)')
               RegWrite($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C644}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C644}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%\AppData\Roaming' & '\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*.lnk')
               RegWrite($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C645}', 'Description','REG_SZ','*LNK : Quick Launch (AppData\Roaming)')
               RegWrite($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C645}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C645}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%\AppData\Roaming' & '\Microsoft\Internet Explorer\Quick Launch\*.lnk')

               If (@OSVersion="WIN_10" or  @OSVersion="WIN_81" or @OSVersion="WIN_8") then
                  RegWrite($key & '\262144\Paths\{99a0fd77-ed0c-4e30-91ff-9d51428d2f21}', 'Description','REG_SZ','*LNK : Power menu group 1')
                  RegWrite($key & '\262144\Paths\{99a0fd77-ed0c-4e30-91ff-9d51428d2f21}', 'SaferFlags','REG_DWORD',Number('0'))
                  RegWrite($key & '\262144\Paths\{99a0fd77-ed0c-4e30-91ff-9d51428d2f21}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%\AppData\Local' & '\Microsoft\Windows\WinX\Group1\*.lnk')
                  RegWrite($key & '\262144\Paths\{99a0fd77-ed0c-4e30-91ff-9d51428d2f22}', 'Description','REG_SZ','*LNK : Power menu group 2')
                  RegWrite($key & '\262144\Paths\{99a0fd77-ed0c-4e30-91ff-9d51428d2f22}', 'SaferFlags','REG_DWORD',Number('0'))
                  RegWrite($key & '\262144\Paths\{99a0fd77-ed0c-4e30-91ff-9d51428d2f22}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%\AppData\Local' & '\Microsoft\Windows\WinX\Group2\*.lnk')
                  RegWrite($key & '\262144\Paths\{99a0fd77-ed0c-4e30-91ff-9d51428d2f23}', 'Description','REG_SZ','*LNK : Power menu group 3')
                  RegWrite($key & '\262144\Paths\{99a0fd77-ed0c-4e30-91ff-9d51428d2f23}', 'SaferFlags','REG_DWORD',Number('0'))
                  RegWrite($key & '\262144\Paths\{99a0fd77-ed0c-4e30-91ff-9d51428d2f23}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%\AppData\Local' & '\Microsoft\Windows\WinX\Group3\*.lnk')
               EndIf
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC19}', 'Description','REG_SZ','*LNK : Start menu (AppData\Roaming)')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC19}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC19}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu' & '\*.lnk')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC20}', 'Description','REG_SZ','*LNK : Start menu programs (AppData\Roaming)')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC20}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC20}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu' & '\Programs\*.lnk')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC21}', 'Description','REG_SZ','*LNK : Start menu programs subfolders (AppData\Roaming)')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC21}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC21}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu' & '\Programs\*\*.lnk')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC22}', 'Description','REG_SZ','*LNK : Start menu')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC22}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC22}', 'ItemData','REG_SZ',$systemdrive & '\ProgramData\Microsoft\Windows\Start Menu\*.lnk')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC23}', 'Description','REG_SZ','*LNK : Start menu programs')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC23}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC23}', 'ItemData','REG_SZ',$systemdrive & '\ProgramData\Microsoft\Windows\Start Menu\Programs\*.lnk')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC24}', 'Description','REG_SZ','*LNK : Start menu programs subfolders')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC24}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC24}', 'ItemData','REG_SZ',$systemdrive & '\ProgramData\Microsoft\Windows\Start Menu\Programs\*\*.lnk')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC25}', 'Description','REG_SZ','*LNK : Start menu programs sub-subfolders')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC25}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC25}', 'ItemData','REG_SZ',$systemdrive & '\ProgramData\Microsoft\Windows\Start Menu\Programs\*\*\*.lnk')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC26}', 'Description','REG_SZ','*LNK : Start menu programs sub-subfolders (AppData\Roaming)')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC26}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC26}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu' & '\Programs\*\*\*.lnk')

      EndSwitch
   Else
;      MsgBox(262144,"","The Enforcement option should be set to 'Skip DLLs' or 'All Files'.")
;      Deny_ShortcutsOFF()
   EndIf
Else
   MsgBox(262144,"","This option requires SRP to be installed, with Enforcement set to 'Skip DLLs' or 'All Files'.")
;   Deny_ShortcutsOFF()
EndIf

If not ($flag = '1') Then
   RefreshMoreSRPRestrictionsGUI()
;   MsgBox(262144,"",$flag)
EndIf

EndFunc


Func Deny_ShortcutsOFF()
   Local $key = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\codeidentifiers'
   RegDelete($key & '\0\Paths\{1016bbe0-a716-428b-822e-5E544B6A3301}')
   RegDelete($key & '\0\Paths\{0016bbe0-a716-428b-822e-5E544B6A3301}')
   RegDelete($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}')
   RegDelete($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C642}')
   RegDelete($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C643}')
   RegDelete($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C644}')
   RegDelete($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C645}')
   RegDelete($key & '\262144\Paths\{99a0fd77-ed0c-4e30-91ff-9d51428d2f21}')
   RegDelete($key & '\262144\Paths\{99a0fd77-ed0c-4e30-91ff-9d51428d2f22}')
   RegDelete($key & '\262144\Paths\{99a0fd77-ed0c-4e30-91ff-9d51428d2f23}')
   RegDelete($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC19}')
   RegDelete($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC20}')
   RegDelete($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC21}')
   RegDelete($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC22}')
   RegDelete($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC23}')
   RegDelete($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC24}')
   RegDelete($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC25}')
   RegDelete($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC26}')
EndFunc

Func RegValues2Array($regkey)
#include <MsgBoxConstants.au3>
#include <Array.au3> ; Required for _ArrayDisplay() only.

;local $var[3]
Local $element
Local $hArray[1] =[""]
Local $n = 1
Local $value = RegEnumVal($regkey, 1)

While $value <> ""
  $value = RegEnumVal($regkey, $n)
;  MsgBox($MB_SYSTEMMODAL, "", $element) 
 _ArrayAdd($hArray, $value)
$n = $n + 1
WEnd


;Kasuje pusty rekord powsta│y przy tworzeniu wektora
_ArrayPush($hArray,"")
_ArrayPop($hArray)
_ArrayPop($hArray)
;_ArrayDisplay($hArray)

Return $hArray

EndFunc


Func SeeDefenderConfiguration()
Local $ASRValue
Local $ASRDwordValue
Local $ASRDwordValuePolicy
Local $ASRKey = 'HKLM\SOFTWARE\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules'
Local $ASRKeyPolicy = 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules'


;Saves the value of EnableNetworkProtection setting in temp registry key as DWORD 
Local $tempKey = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\Defender\TEMP\'
RegWrite($tempKey)
RunWait($PowerShellDir & "PowerShell -NonInteractive -WindowStyle hidden $Preferences=Get-MpPreference;$path='HKLM:\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\Defender\TEMP'; New-ItemProperty -Path $path -Name 'PreferencesTest' -Value $Preferences.DisableRealtimeMonitoring -PropertyType String -Force | Out-Null; function SetRegistryKey ([string]$name){$svalue=$Preferences.$name;New-ItemProperty -Path $path -Name $name -Value $svalue -PropertyType DWORD -Force | Out-Null}; SetRegistryKey('EnableNetworkProtection'); SetRegistryKey( 'EnableControlledFolderAccess');SetRegistryKey('DisableRealtimeMonitoring'); SetRegistryKey('DisableBehaviorMonitoring'); SetRegistryKey('DisableBlockAtFirstSeen'); SetRegistryKey('MAPSReporting');SetRegistryKey('SubmitSamplesConsent');SetRegistryKey('DisableIOAVProtection'); SetRegistryKey('DisableScriptScanning'); SetRegistryKey('PUAProtection'); SetRegistryKey('ScanAvgCPULoadFactor'); ", "", @SW_HIDE, $STDOUT_CHILD)


    Local $ASRValue = "BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550"
    Local $ASRDwordValue = RegRead($ASRKey, $ASRValue)
    Local $ASRDwordValuePolicy = RegRead($ASRKeyPolicy, $ASRValue)
    If not @error Then
       If ($ASRDwordValuePolicy = 0 or $ASRDwordValuePolicy = 1 or $ASRDwordValuePolicy = 2) Then
  	  $ASRDwordValue = $ASRDwordValuePolicy
       Else
	  RegDelete($ASRKeyPolicy, $ASRValue)
       EndIf
    EndIf
       Switch $ASRDwordValue
	   case 0       
	      $ASR1 = "Disabled"       
	   case 1
              $ASR1 = "Enabled"
	   case 2
              $ASR1 = "Audit"
	   case Else
	      RunWait($PowerShellDir & "PowerShell -NonInteractive -WindowStyle hidden -command Add-MpPreference -AttackSurfaceReductionRules_Ids $ASRValue -AttackSurfaceReductionRules_Actions Disable", "", @SW_HIDE)
	      $ASR1 = "Disabled"
              MsgBox(262144,"", "Wrong SmartScreen setting. The value was corrected and set to Windows default.") 
       EndSwitch
;    MsgBox(0,"",$ASR1)

    Local $ASRValue = "D4F940AB-401B-4EFC-AADC-AD5F3C50688A"
    Local $ASRDwordValue = RegRead($ASRKey, $ASRValue)
    Local $ASRDwordValuePolicy = RegRead($ASRKeyPolicy, $ASRValue)
    If not @error Then
       If ($ASRDwordValuePolicy = 0 or $ASRDwordValuePolicy = 1 or $ASRDwordValuePolicy = 2) Then
  	  $ASRDwordValue = $ASRDwordValuePolicy
       Else
	  RegDelete($ASRKeyPolicy, $ASRValue)
       EndIf
    EndIf
       Switch $ASRDwordValue
	   case 0       
	      $ASR2 = "Disabled"       
	   case 1
              $ASR2 = "Enabled"
	   case 2
              $ASR2 = "Audit"
	   case Else
	      RunWait($PowerShellDir & "PowerShell -NonInteractive -WindowStyle hidden -command Add-MpPreference -AttackSurfaceReductionRules_Ids $ASRValue -AttackSurfaceReductionRules_Actions Disable", "", @SW_HIDE)
	      $ASR2 = "Disabled"
              MsgBox(262144,"", "Wrong SmartScreen setting. The value was corrected and set to Windows default.") 
       EndSwitch
;    MsgBox(0,"",$ASR2)


    Local $ASRValue = "3B576869-A4EC-4529-8536-B80A7769E899"
    Local $ASRDwordValue = RegRead($ASRKey, $ASRValue)
    Local $ASRDwordValuePolicy = RegRead($ASRKeyPolicy, $ASRValue)
    If not @error Then
       If ($ASRDwordValuePolicy = 0 or $ASRDwordValuePolicy = 1 or $ASRDwordValuePolicy = 2) Then
  	  $ASRDwordValue = $ASRDwordValuePolicy
       Else
	  RegDelete($ASRKeyPolicy, $ASRValue)
       EndIf
    EndIf
       Switch $ASRDwordValue
	   case 0       
	      $ASR3 = "Disabled"       
	   case 1
              $ASR3 = "Enabled"
	   case 2
              $ASR3 = "Audit"
	   case Else
	      RunWait($PowerShellDir & "PowerShell -NonInteractive -WindowStyle hidden -command Add-MpPreference -AttackSurfaceReductionRules_Ids $ASRValue -AttackSurfaceReductionRules_Actions Disable", "", @SW_HIDE)
	      $ASR3 = "Disabled"
              MsgBox(262144,"", "Wrong SmartScreen setting. The value was corrected and set to Windows default.") 
       EndSwitch


    Local $ASRValue = "75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84"
    Local $ASRDwordValue = RegRead($ASRKey, $ASRValue)
    Local $ASRDwordValuePolicy = RegRead($ASRKeyPolicy, $ASRValue)
    If not @error Then
       If ($ASRDwordValuePolicy = 0 or $ASRDwordValuePolicy = 1 or $ASRDwordValuePolicy = 2) Then
  	  $ASRDwordValue = $ASRDwordValuePolicy
       Else
	  RegDelete($ASRKeyPolicy, $ASRValue)
       EndIf
    EndIf
       Switch $ASRDwordValue
	   case 0       
	      $ASR4 = "Disabled"       
	   case 1
              $ASR4 = "Enabled"
	   case 2
              $ASR4 = "Audit"
	   case Else
	      RunWait($PowerShellDir & "PowerShell -NonInteractive -WindowStyle hidden -command Add-MpPreference -AttackSurfaceReductionRules_Ids $ASRValue -AttackSurfaceReductionRules_Actions Disable", "", @SW_HIDE)
	      $ASR4 = "Disabled"
              MsgBox(262144,"", "Wrong SmartScreen setting. The value was corrected and set to Windows default.") 
       EndSwitch
;    MsgBox(0,"",$ASR4)


    Local $ASRValue = "D3E037E1-3EB8-44C8-A917-57927947596D"
    Local $ASRDwordValue = RegRead($ASRKey, $ASRValue)
    Local $ASRDwordValuePolicy = RegRead($ASRKeyPolicy, $ASRValue)
    If not @error Then
       If ($ASRDwordValuePolicy = 0 or $ASRDwordValuePolicy = 1 or $ASRDwordValuePolicy = 2) Then
  	  $ASRDwordValue = $ASRDwordValuePolicy
       Else
	  RegDelete($ASRKeyPolicy, $ASRValue)
       EndIf
    EndIf
       Switch $ASRDwordValue
	   case 0       
	      $ASR5 = "Disabled"       
	   case 1
              $ASR5 = "Enabled"
	   case 2
              $ASR5 = "Audit"
	   case Else
	      RunWait($PowerShellDir & "PowerShell -NonInteractive -WindowStyle hidden -command Add-MpPreference -AttackSurfaceReductionRules_Ids $ASRValue -AttackSurfaceReductionRules_Actions Disable", "", @SW_HIDE)
	      $ASR5 = "Disabled"
              MsgBox(262144,"", "Wrong SmartScreen setting. The value was corrected and set to Windows default.") 
       EndSwitch
;    MsgBox(0,"",$ASR5)


    Local $ASRValue = "5BEB7EFE-FD9A-4556-801D-275E5FFC04CC"
    Local $ASRDwordValue = RegRead($ASRKey, $ASRValue)
    Local $ASRDwordValuePolicy = RegRead($ASRKeyPolicy, $ASRValue)
    If not @error Then
       If ($ASRDwordValuePolicy = 0 or $ASRDwordValuePolicy = 1 or $ASRDwordValuePolicy = 2) Then
  	  $ASRDwordValue = $ASRDwordValuePolicy
       Else
	  RegDelete($ASRKeyPolicy, $ASRValue)
       EndIf
    EndIf
       Switch $ASRDwordValue
	   case 0       
	      $ASR6 = "Disabled"       
	   case 1
              $ASR6 = "Enabled"
	   case 2
              $ASR6 = "Audit"
	   case Else
	      RunWait($PowerShellDir & "PowerShell -NonInteractive -WindowStyle hidden -command Add-MpPreference -AttackSurfaceReductionRules_Ids $ASRValue -AttackSurfaceReductionRules_Actions Disable", "", @SW_HIDE)
	      $ASR6 = "Disabled"
              MsgBox(262144,"", "Wrong SmartScreen setting. The value was corrected and set to Windows default.") 
       EndSwitch
;    MsgBox(0,"",$ASR6)


    Local $ASRValue = "92E97FA1-2EDF-4476-BDD6-9DD0B4DDDC7B"
    Local $ASRDwordValue = RegRead($ASRKey, $ASRValue)
    Local $ASRDwordValuePolicy = RegRead($ASRKeyPolicy, $ASRValue)
    If not @error Then
       If ($ASRDwordValuePolicy = 0 or $ASRDwordValuePolicy = 1 or $ASRDwordValuePolicy = 2) Then
  	  $ASRDwordValue = $ASRDwordValuePolicy
       Else
	  RegDelete($ASRKeyPolicy, $ASRValue)
       EndIf
    EndIf
       Switch $ASRDwordValue
	   case 0       
	      $ASR7 = "Disabled"       
	   case 1
              $ASR7 = "Enabled"
	   case 2
              $ASR7 = "Audit"
	   case Else
	      RunWait($PowerShellDir & "PowerShell -NonInteractive -WindowStyle hidden -command Add-MpPreference -AttackSurfaceReductionRules_Ids $ASRValue -AttackSurfaceReductionRules_Actions Disable", "", @SW_HIDE)
	      $ASR7 = "Disabled"
              MsgBox(262144,"", "Wrong SmartScreen setting. The value was corrected and set to Windows default.") 
       EndSwitch
;    MsgBox(0,"",$ASR7)



    Switch RegRead($tempKey, 'EnableNetworkProtection')
	case 0       
	   $EnableNetworkProtection = "Disabled"       
	case 1
	   $EnableNetworkProtection = "Enabled"
	case 2
	   $EnableNetworkProtection = "Audit"
	case Else
  	   RunWait($PowerShellDir & "PowerShell -NonInteractive -WindowStyle hidden -command Set-MpPreference -EnableNetworkProtection Disabled", "", @SW_HIDE)
	   $EnableNetworkProtection = "Disabled"
	   MsgBox(262144,"","Wrong 'Network Protection' Defender setting. The value was corrected and set to Windows default.")
    EndSwitch    
;    MsgBox(0,"",$EnableNetworkProtection)

 
    Switch RegRead($tempKey, 'EnableControlledFolderAccess')
	case 0       
	   $ControlledFolderAccess = "Disabled"       
	case 1
	   $ControlledFolderAccess = "Enabled"
	case 2
	   $ControlledFolderAccess = "Audit"
	case Else
  	   RunWait($PowerShellDir & "PowerShell -NonInteractive -WindowStyle hidden -command Set-MpPreference -EnableControlledFolderAccess Disabled", "", @SW_HIDE)
	   $ControlledFolderAccess = "Disabled"
	   MsgBox(262144,"","Wrong 'Controlled Folder Access' Defender setting. The value was corrected and set to Windows default.")
    EndSwitch
;    MsgBox(0,"",$ControlledFolderAccess)


Return $ASR1 & @CRLF & $ASR2 & @CRLF & $ASR3 & @CRLF & $ASR4 & @CRLF & $ASR5 & @CRLF & $ASR6 & @CRLF & $ASR7 & @CRLF & $ControlledFolderAccess
EndFunc

Func IsSMB10Uninstalled()
$keyname = 'HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb10'
$valuename = 'Start'
RegRead ( $keyname, $valuename )
If (@error = 1 AND (@OSVersion = "WIN_10" OR @OSVersion = "WIN_81")) Then 
   Return 1
EndIf
Return 2
EndFunc

Func WDDSFirstRUNMaintenance()
Local $key = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers'
; Check Install flag in the registry
  Local $Reg = RegRead($key, 'Installed')
  If not ($Reg = '1') Then 
        CreateSystemRestorePoint()
        Autoruns1()
         Local $whitelist = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers\262144\Paths'
         _RegCopyKey($whitelist, $key & '\Temp\262144\FirstRunWhitelist')
  EndIf 
EndFunc


Func CreateSystemRestorePoint()
Local $iPID
Local $aArray[2][2] = [[0,0],[0,0]]
Local $PreviousControlName
; Uses external _CreateRestorePoint(), _SR_Enable(), and  _ResizeSR_MaxDiskStorage() functions.
;   Check if System Restore is not enabled.
;   It must be RegRead() = 0 because it handles RPSessionInterval=0 and also missing RPSessionInterval value in the Registry
;   (fresh installed Windows 10)
    If RegRead('HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore', 'RPSessionInterval') = 0 Then
;       Enable System Restore
        If _SR_Enable($systemdrive & '\') = "1" Then
           MsgBox(262144,"","System Restore Enabled.", 1)
        Else
           MsgBox(262144,"","Error. Failed to enable System Restore." & @CRLF & "Please, make System Restore Point manually." & @CRLF & "Hard_Configurator will exit now." )
           RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers', 'Installed', 'REG_SZ','1')
           Exit
        EndIf
    EndIf
;   Create the System Restore Point
;   Check if the space reserved for restore points is not too small (minimum 1GB)
;   MsgBox(262144,"", CheckMaxShadowStorage() & 'GB')
    If CheckMaxShadowStorage() < 1 Then 
;   It contains the 'error' or less than 1 values returned by CheckMaxShadowStorage()
       If _ResizeSR_MaxDiskStorage() = "0" Then
          MsgBox(262144,"","Error. Failed to resize System Restore Storage to make System Restore Point." & @CRLF & "Please, make System Restore Point manually." & @CRLF & "Hard_Configurator will exit now." )
          Exit
       EndIf
    EndIf
    If not (@OSVersion="WIN_10" or @OSVersion="WIN_81" or @OSVersion="WIN_8" or @OSVersion="WIN_7" or @OSVersion="WIN_VISTA") Then
       MsgBox(262144, "", "Error. Unsupported Windows version. Only Windows Vista, 7, 8, 8.1, and 10 are supported.")
       Return
    EndIf
    $iPID = Run('C:\Windows\System32\SystemPropertiesProtection.exe')
    SplashTextOn("Restore Point", "Please Wait. Do not use the mouse and keybord for a while.", 300, 80, -1, -1, 0, "", 12) 
; Loop checking if the process is created after running 'SystemPropertiesProtection.exe'
      Local $nn = 1
      While 1
        If $nn > 100 Then
           MsgBox( 262144, "", "Error. Cannot run 'SystemPropertiesProtection.exe' to make System Restore Point.")
           SplashOff()
           Return
        EndIf
        Sleep (100)
        $nn = $nn+1
        If ProcessExists($iPID) = $iPID Then ExitLoop
      WEnd
      $nn = 1
; Loop checking if $aArray is created, because _WinAPI_EnumProcessWindows takes a while to find $aArray[1][0] 
      While 1
        $aArray = _WinAPI_EnumProcessWindows ($iPID) 
        If $nn > 6 Then
           MsgBox( 262144, "", "Error. Cannot run 'SystemPropertiesProtection.exe' to make System Restore Point.")
           SplashOff()
           Return
        EndIf
        Sleep ($nn*500)
        _ArrayMax($aArray)
        If @error Then 
           $nn = $nn+1
        Else
           ExitLoop
        EndIf
      WEnd   
      WinWaitActive($aArray[1][0],"")
      $PreviousControlName = FindPreviousControlName($aArray[1][0])
      ControlClick($aArray[1][0],"",$PreviousControlName)
      Sleep(2000)
      Send("Hard_Configurator{ENTER}")
    SplashOff()
EndFunc


Func CheckMaxShadowStorage()

;Returns the Floor of the Maximum size (in GB) of Shadow Copy Storage (for Sytem Restore Points).
 Local $command = @WindowsDir & '\system32\vssadmin.exe' & ' List' & ' ShadowStorage' & ' /On=' & $systemdrive
 Local $iPID = Run($command , "", @SW_HIDE, $STDOUT_CHILD)
 ProcessWaitClose($iPID)
 Local $sOutput = StdoutRead($iPID, False, True)
 FileWrite($ProgramFolder & 'ShadowStorageInfo.log', $sOutput)
;Read the 'ShadowStorage.log' into the string
 Local $ShadowStorageInfo =  FileRead($ProgramFolder & 'ShadowStorageInfo.log')
 If @error Then
    MsgBox($MB_SYSTEMMODAL, "", "There was an error reading the file. @error: " & @error)
 Else
;    MsgBox(262144,"",$ShadowStorageInfo)
 EndIf
 FileDelete($ProgramFolder & 'ShadowStorageInfo.log')
 Local $n = StringInStr($ShadowStorageInfo, 'Maximum Shadow Copy Storage space: ')
 $ShadowStorageInfo = StringTrimLeft($ShadowStorageInfo, $n-1)
 $ShadowStorageInfo = StringReplace($ShadowStorageInfo, 'Maximum Shadow Copy Storage space: ', "")
 $n = StringInStr($ShadowStorageInfo, "(")
 If not ($n=0) Then
    $ShadowStorageInfo = StringTrimRight($ShadowStorageInfo, StringLen($ShadowStorageInfo) - $n+1)
 EndIf
 Local $measure = StringTrimRight($ShadowStorageInfo,3)
; MsgBox(262144,"", $ShadowStorageInfo & "    " & StringInStr($ShadowStorageInfo, 'GB'))
 Select
    case StringInStr($ShadowStorageInfo, 'GB') > 0
;       MsgBox(262144,"", $measure & "GB")
       Return Floor($measure)
    case StringInStr($ShadowStorageInfo , 'MB') > 0
;       MsgBox(262144,"", $measure/1024 & "GB")
       Return Floor($measure/1024)
    case StringInStr($ShadowStorageInfo , 'TB') > 0
;       MsgBox(262144,"", $measure*1024 & "GB")
       Return Floor($measure*1024)
    case Else
       Return 'error'
 EndSelect

EndFunc

Func FindPreviousControlName($hWnd)
    Local $avArr
    If UBound($avArr, 0) <> 2 Then
        Local $avTmp[10][2] = [[0]]
        $avArr = $avTmp
    EndIf
    Global $ActualControlName
    Global $PreviousControlName
    Local $hChild = _WinAPI_GetWindow($hWnd, $GW_CHILD)
    
    While $hChild
        If $avArr[0][0]+1 > UBound($avArr, 1)-1 Then ReDim $avArr[$avArr[0][0]+10][2]
        $avArr[$avArr[0][0]+1][0] = $hChild
        $avArr[$avArr[0][0]+1][1] = _WinAPI_GetWindowText($hChild)
        $ActualControlName = _WinAPI_GetWindowText($hChild)
;        MsgBox(262144,"",$ActualControlName)
        If $ActualControlName = "OK" Then 
           Return $PreviousControlName
;           MsgBox(262144,"",$PreviousControlName)
        EndIf
        $PreviousControlName = $ActualControlName
        $avArr[0][0] += 1
        FindPreviousControlName($hChild)
        $hChild = _WinAPI_GetWindow($hChild, $GW_HWNDNEXT)

    WEnd
    
    ReDim $avArr[$avArr[0][0]+1][2]
EndFunc

Func RefreshToolsGUIWindow()
EndFUnc


Func AreShortcutsProtected()
local $guidname = '{1016bbe0-a716-428b-822e-5E544B6A3301}'

$keyname = 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\0\paths\' & $guidname
$valuename = "ItemData"
$DenyShortcuts = RegRead ( $keyname, $valuename )
$iskey = @error
If ($SRPTransparentEnabled = "No Enforcement" or $SRPTransparentEnabled = "not found" or $SRPTransparentEnabled = "?") Then
   $DenyShortcuts = "OFF"
EndIf
If ($iskey = -1 or $iskey =1) Then $DenyShortcuts = "OFF"
Switch $DenyShortcuts
   case "*.lnk"
      $DenyShortcuts = "ON"
   case "protected"
      $DenyShortcuts = "ON"
   case "OFF"
   case Else
      $DenyShortcuts = "?"
EndSwitch

EndFunc


Func AddPowerShellExtensions()
Local $n
Local $_PSHArray = Reg2Array()
Local $sToAdd[6] = ['PS1', 'PS1XML', 'PS2', 'PS2XML', 'PSC1', 'PSC2']
;Check if the extension is OK, and if so, add it to the list
For $i=0 To 5
   $n = _ArraySearch($_PSHArray, $sToAdd[$i])
   If not ($n >= 0) Then
      AddSRPExtension($sToAdd[$i])
   Else
;      If $n >= 0 Then MsgBox(262144, "ALERT", "The  " & '"' & $sToAdd[$i] & '"' & "  extension is already on the list!")
   EndIf
Next
EndFunc

Func AddOneDrive1()
Local $_xarr = _sGetAllAccountsInfo()
Local $temp
If Ubound($_xarr) < 2 Then
   MsgBox(262144, "", "Error. Cannot find OneDrive on any Account.")
   Return
EndIf
For $n=1 to Ubound($_xarr)-1
   $temp = StringTrimLeft($_xarr[$n], StringInStr($_xarr[$n], "(***)")+4)
   $temp = StringTrimRight($temp,StringLen($temp) - StringInStr($temp, "(****)")+1)
;   MsgBox(262144, "", $temp)
   AddOneDrive($temp , "*OneDrive for Account: " & $_xarr[$n])
Next

Local $temp = $_xarr[1]
;MsgBox(0,"",$temp)

$RefreshChangesCheck = $RefreshChangesCheck & "WhitelistPath" & @LF
RefreshAddRemovePathGUIWindow()
EndFunc

Func AddOneDrive($PathToUserProfile, $whitelist_Info)
Local $_path
;MsgBox(0,"",$PathToUserProfile)
Local $_Part_GUID = '{1016bbe0-a716-428b-822e-0E544B6A3'
Local $_LocalAppdataDir = $PathToUserProfile & '\AppData\Local'
;   OneDrive on the Whitelist
   $_path = $_LocalAppdataDir & '\Microsoft\OneDrive\OneDrive.exe'
   If SearchWhitelistedPathsDuplicates ($_path) = 0 Then
      CalculateFilePaths2($_path, $_Part_GUID, $whitelist_Info)
   EndIf 
   $_path = $_LocalAppdataDir & '\Microsoft\OneDrive\*\*.dll'
   If SearchWhitelistedPathsDuplicates ($_path) = 0 Then
       CalculateFilePaths2($_path, $_Part_GUID, $whitelist_Info)
   EndIf
   $_path = $_LocalAppdataDir & '\Microsoft\OneDrive\*\OneDriveStandaloneUpdater.exe'
   If SearchWhitelistedPathsDuplicates ($_path) = 0 Then
       CalculateFilePaths2($_path, $_Part_GUID, $whitelist_Info)
   EndIf
   $_path = $_LocalAppdataDir & '\Microsoft\OneDrive\OneDrivePersonal.cmd'
   If SearchWhitelistedPathsDuplicates ($_path) = 0 Then
       CalculateFilePaths2($_path, $_Part_GUID, $whitelist_Info)
   EndIf
   $_path = $_LocalAppdataDir & '\Microsoft\OneDrive\*\*\*.dll'
   If SearchWhitelistedPathsDuplicates ($_path) = 0 Then
       CalculateFilePaths2($_path, $_Part_GUID, $whitelist_Info)
   EndIf
   $_path = $_LocalAppdataDir & '\Microsoft\OneDrive\Update\OneDriveSetup.exe'
   If SearchWhitelistedPathsDuplicates ($_path) = 0 Then
       CalculateFilePaths2($_path, $_Part_GUID, $whitelist_Info)
   EndIf
   $_path = $_LocalAppdataDir & '\Microsoft\OneDrive\OneDriveStandaloneUpdater.exe'
   If SearchWhitelistedPathsDuplicates ($_path) = 0 Then
       CalculateFilePaths2($_path, $_Part_GUID, $whitelist_Info)
   EndIf
   $_path = $_LocalAppdataDir & '\Microsoft\OneDrive\*\FileSyncConfig.exe'
   If SearchWhitelistedPathsDuplicates ($_path) = 0 Then
       CalculateFilePaths2($_path, $_Part_GUID, $whitelist_Info)
   EndIf
   $_path = $_LocalAppdataDir & '\Microsoft\OneDrive\*\FileCoAuth.exe'
   If SearchWhitelistedPathsDuplicates ($_path) = 0 Then
       CalculateFilePaths2($_path, $_Part_GUID, $whitelist_Info)
   EndIf
   $_path = $_LocalAppdataDir & '\Microsoft\OneDrive\*\OneDriveSetup.exe'
   If SearchWhitelistedPathsDuplicates ($_path) = 0 Then
       CalculateFilePaths2($_path, $_Part_GUID, $whitelist_Info)
   EndIf
   $_path = $_LocalAppdataDir & '\Microsoft\OneDrive\*\CollectSyncLogs.bat'
   If SearchWhitelistedPathsDuplicates ($_path) = 0 Then
       CalculateFilePaths2($_path, $_Part_GUID, $whitelist_Info)
   EndIf

EndFunc

Func CalculateFilePaths2($path, $Part_GUID, $whitelist_Info)
;MsgBox(0,"",$path & @crlf & $Part_GUID & @crlf & $whitelist_Info)
;$DescriptionLabel variable is the Global variable defined in Autoruns() function !!!
#include <GUIConstantsEx.au3>
#include <StringConstants.au3>
#Include <File.au3>
#include <FileConstants.au3>
#RequireAdmin

Local $var[6]
;Select a file for adding to the Whitelist.
$var[0] = $path
;MsgBox(262144,"", $var[0])
If not ($var[0] = "") Then
;Get the filesize
        $var[1] = FileGetSize ($var[0])
;       MsgBox(262144,"", $var[0] & @CRLF & $var[1])
;Get the info about the file               
        Local $fileinfo = FileGetVersion ( $var[0], $FV_COMPANYNAME)
        $fileinfo =  $fileinfo & "   " & FileGetVersion ( $var[0], $FV_FILEDESCRIPTION)
        $var[2] =  $fileinfo & "   " & FileGetVersion ( $var[0], $FV_FILEVERSION)
;       MsgBox(262144,"", $var[2])
;Create new GUID
        Local $mainkey = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\262144\Paths'
        Local $sSubKey = RegEnumKey($mainkey, 1)
        Local $partSubkey = $mainkey & '\' & $Part_GUID
        Local $i = 1
        Local $n = 100
        While ($sSubKey <> "")
            If $n > 999 Then
               MsgBox(262144,"ALERT", "Cannot be whitelist by Path. There are too many entries already whitelisted")
               ExitLoop
            EndIf
            $sSubKey = RegEnumKey($mainkey, $i)
            If @error Then ExitLoop  
;           MsgBox(262144,"", $partSubkey & $n  & "}" & @CRLF & $mainkey & '\' & $sSubKey)
            If $partSubkey & $n & "}" = $mainkey & '\' & $sSubKey Then
                $n = $n + 1
                $i = 0
            EndIf
            $i = $i + 1
;           MsgBox(262144,"", "$i = " & $i & @CRLF & "$n = " & $n)
        WEnd

;Here is the path with the new GUID
        $var[5] = $partSubkey & $n & '}'
;       MsgBox(262144,"Found the new GUID", $var[5])

        ;Write data to the Registry
   If SearchWhitelistedPathsDuplicates ($var[0]) = 0 Then
      If $whitelist_Info = "" Then
          RegWrite ($var[5], 'Description','REG_SZ', $DescriptionLabel & $var[0] & "  (***)  " & $var[2] & '  REG = ' & $var[5])
      Else
;          MsgBox(0,"",$var[5] & @crlf & $whitelist_Info)
          RegWrite ($var[5], 'Description','REG_SZ', $whitelist_Info)
      EndIf
      _ArrayAdd($NewPathsArray, $var[0])
      RegWrite ($var[5], 'SaferFlags','REG_DWORD', Number('0'))
      RegWrite ($var[5], 'ItemData','REG_SZ', $var[0])
;     MsgBox("0","",RegRead ($var[5], 'ItemData'))
   Else
     _ArrayAdd($PathDuplicatesArray, $var[0])
;    MsgBox(262144,"", 'This item is already on the list' & @CRLF & $PathDuplicatesArray[1])
     Return '-1'
   EndIf

;Content of the added list item 
   If Stringlen($var[2]) > 200 Then $var[2] = StringLeft($var[2],200)
   Return $var[0] & "  (***)  " & $var[2] & '   REG = ' & $var[5]
EndIf
EndFunc 

