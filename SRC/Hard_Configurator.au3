﻿#NoTrayIcon
#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=C:\Windows\Hard_Configurator\Icons\H_C.ico
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_Res_Comment=Compiled with AutoIt 3.3.14.2
#AutoIt3Wrapper_Res_Description=Hard_Configurator
#AutoIt3Wrapper_Res_Fileversion=4.1.0.0
#AutoIt3Wrapper_Res_LegalCopyright=Copyright *  Andy Ful , July 2019
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;#pragma compile(Icon, C:\Windows\Hard_Configurator\Skins\Icons\security.ico)

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
#include <GuiScrollBars.au3>
#include <String.au3>


#include <GUIConstants.au3>
#include <Misc.au3>
#include <InetConstants.au3>

#include <WindowsConstants.au3>
#include <Security.au3>

#include 'AddRemoveHash.au3'
#include 'AddRemovePath.au3'
#include 'AddSRPExtension.au3'
#include 'DeleteSRPExtension.au3'
#include 'ExtMsgBox.au3'
#include 'Hash2Array.au3'
#include 'Path2Array.au3'
;#include 'RASExecutableTypes.au3'
#include 'SRPExecutableTypes.au3'
#include 'StringSize.au3'
#include 'WritableSubWindows.au3'
#Include 'XSkinModAF.au3'
#Include 'Autoruns.au3'
#Include 'Tools.au3'
#Include 'RestoreWindowsDefaults.au3'
#Include 'Create_Restore_Point.au3'
#Include 'SystemRestoreEnable.au3'
#Include 'MoreRestrictions.au3'
#Include 'CheckBoxBlockSponsors.au3'
#Include 'MoreSRPRestrictions.au3'
#Include 'RegCopyKey.au3'
#Include 'EncryptConfigFile.au3'
#Include 'SRPWhitelistSaveLoad.au3'
#Include 'SavedWhiteLists.au3'
#Include 'BlockSponsorsFromProfile.au3'
#Include 'ManageProfilesBACKUP.au3'
#Include '_ShellExecuteWithReducedPrivileges.au3'
#Include 'GetAllAccountsInfo.au3'
#Include 'SystemWideDocumentsAntiExploit.au3'

Global $Hard_ConfiguratorVersion = '4.1.0.0'
Global $systemdrive = EnvGet('systemdrive')
Global $ProgramFolder = @WindowsDir & "\Hard_Configurator\"
Global $SkinsFolder = @WindowsDir & "\Hard_Configurator\Skins\"
Global $HardConfigurator_IniFile = @WindowsDir & "\Hard_Configurator\Hard_Configurator.ini"
Global $ProgramConfigurationFolder = $ProgramFolder & "Configuration\"
Global $HKU_SID_Software = 'HKU\' & _GetCurrentUserSID() & '\Software'
;MainGUI parameters
Opt("GUIOnEventMode", 1)
Global $MainGuiWidth = 690
Global $MainGuiHeight = 400
Global $ListwievColor = 0xDFDEE1
Global $GuiSkin = "MAmbre"


If (@ScriptName = 'Hard_Configurator(x64).exe' And @OSArch = "X86") Then
   MsgBox(262144,"","This file works only on 64-bit Windows version.")
   Exit
EndIf

If (@ScriptName = 'Hard_Configurator(x86).exe' And @OSArch = "X64") Then
   MsgBox(262144,"","This file works only on 32-bit Windows version.")
   Exit
EndIf


; Remove Hard_Configurator entry from installed applications.
RegDelete('HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{035BFEF3-46F7-4E6A-AC26-5A6D99E96D7F}_is1')
RegDelete('HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{F5B80342-A8D0-4A04-AC11-6F9C9968C3C5}_is1')
RegDelete('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{F5B80342-A8D0-4A04-AC11-6F9C9968C3C5}_is1')
RegDelete('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{035BFEF3-46F7-4E6A-AC26-5A6D99E96D7F}_is1')

;; Import Configuration Profile from Hard_Configurator.ini (settings from the old versions 3.0.0.1 and before).
;If not (FileExists($ProgramConfigurationFolder & 'Hard_Configurator.hdc')="1") Then
;   If FileExists($HardConfigurator_IniFile)="1" Then
;      If FileReadLine($HardConfigurator_IniFile,17) = "ON" Then FileWriteLine($ProgramConfigurationFolder & 'Hard_Configurator.hdc', 'IsCMDBlocked')
;      If FileReadLine($HardConfigurator_IniFile,19) = "ON" Then
;         FileWriteLine($ProgramConfigurationFolder & 'Hard_Configurator.hdc', 'IsPowerShellBlocked')
;          FileWriteLine($ProgramConfigurationFolder & 'Hard_Configurator.hdc', 'IsPowerShell_iseBlocked')
;      EndIf
;      FileWrite($ProgramConfigurationFolder & 'Hard_Configurator.hdc', @CRLF & ";********* Beginning of ini section *********" & @CRLF & @CRLF)
;      Local $array = [""]
;      _FileReadToArray($HardConfigurator_IniFile, $array)
;      _ArrayDelete($array, 17)
;      _ArrayDelete($array, 18)
;      $array['0']='18'
;;      _ArrayDisplay($array)
;      Local $text = _ArrayToString($array, @CRLF)
;      $text = StringTrimLeft($text, 4)
;;      MsgBox(0,"",$text)
;      FileWrite($ProgramConfigurationFolder & 'Hard_Configurator.hdc', $text & @CRLF)
;      FileWrite($ProgramConfigurationFolder & 'Hard_Configurator.hdc', @CRLF & ";********* Beginning of profile info section *********" & @CRLF & @CRLF & "Settings imported from the older version INI file.")
;   EndIF
;EndIf

Global $DeltaX = 30
Global $DeltaY= 15
Global $DeltaListview = 19
Global $ChangeGuiSkin =0
Global $SkinNumber = 1
;Those global variables are used in external AU3 Files
Global $DescriptionLabel
Global $PathDuplicatesArray = [""]
Global $NewPathsArray = [""]
Global $BtnSRPEnableLogging
Global $ScriptAutorunsLogArray
Global $M_SRPlistview
Global $M_SRPlistGUI
Global $Toolslistview
Global $ToolslistGUI
Global $ManageProfilesBackupGUI

Global $X_ToolsGUI = -1
Global $Y_ToolsGUI = -1
Global $X_SRPExtensionsGUI = -1
Global $Y_SRPExtensionsGUI = -1
Global $X_MRSTRlistGUI = -1
Global $Y_MRSTRlistGUI = -1
Global $X_M_SRPlistGUI = -1
Global $Y_M_SRPlistGUI = -1
Global $X_SavedWhitelistslistGUI = -1
Global $Y_SavedWhitelistslistGUI = -1

Global $Extensionmessage = 0

;***********************************
;Refresh Changes
Global $RefreshExplorer = 1
Global $RefreshChangesCheck =""
;***********************************
; Blocked Sponsors
Global $NumberOfExecutables = 171
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
Global $idCheckbox89
Global $DisableAtExe
Global $idCheckbox90
Global $DisableAdvpackDll
Global $idCheckbox91
Global $DisableAppvlpExe
Global $idCheckbox92
Global $DisableAtbrokerExe
Global $idCheckbox93
Global $DisableCertutilEexe
Global $idCheckbox94
Global $DisableCL_InvocationPs1
Global $idCheckbox95
Global $DisableCL_MutexverifiersPs1
Global $idCheckbox96
Global $DisableCmdkeyExe
Global $idCheckbox97
Global $DisableCmstpExe
Global $idCheckbox98
Global $DisableControlExe
Global $idCheckbox99
Global $DisableDiskshadowExe
Global $idCheckbox100
Global $DisableDnscmdExe
Global $idCheckbox101
Global $DisableDxcapExe
Global $idCheckbox102
Global $DisableEsentutlExe
Global $idCheckbox103
Global $DisableExpandExe
Global $idCheckbox104
Global $DisableExtexportExe
Global $idCheckbox105
Global $DisableExtrac32Exe
Global $idCheckbox106
Global $DisableFindstrExe
Global $idCheckbox107
Global $DisableForfilesExe
Global $idCheckbox108
Global $DisableFtpExe
Global $idCheckbox109
Global $DisableGpscriptExe
Global $idCheckbox110
Global $DisableIe4uinitExe
Global $idCheckbox111
Global $DisableIeadvpackDll
Global $idCheckbox112
Global $DisableIeaframeDll
Global $idCheckbox113
Global $DisableJscriptDll
Global $idCheckbox114
Global $DisableMakecabExe
Global $idCheckbox115
Global $DisableManagebdeWsf
Global $idCheckbox116
Global $DisableMavinjectExe
Global $idCheckbox117
Global $DisableMftraceExe
Global $idCheckbox118
Global $DisableMicrosoftWorkflowCompilerExe
Global $idCheckbox119
Global $DisableMsconfigExe
Global $idCheckbox120
Global $DisableMsdeployExe
Global $idCheckbox121
Global $DisableMsdtExe
Global $idCheckbox122
Global $DisableMshtmlDll
Global $idCheckbox123
Global $DisableMspubExe
Global $idCheckbox124
Global $DisableMsraExe
Global $idCheckbox125
Global $DisableMsxslExe
Global $idCheckbox126
Global $DisablePcaluaExe
Global $idCheckbox127
Global $DisablePcwrunExe
Global $idCheckbox128
Global $DisablePcwutlDll
Global $idCheckbox129
Global $DisablePesterBat
Global $idCheckbox130
Global $DisablePrintExe
Global $idCheckbox131
Global $DisablePsrExe
Global $idCheckbox132
Global $DisablePubprnVbs
Global $idCheckbox133
Global $DisableRegeditExe
Global $idCheckbox134
Global $DisableRegisterCimproviderExe
Global $idCheckbox135
Global $DisableReplaceExe
Global $idCheckbox136
Global $DisableRobocopyExe
Global $idCheckbox137
Global $DisableRpcpingExe
Global $idCheckbox138
Global $DisableScExe
Global $idCheckbox139
Global $DisableScriptrunnerExe
Global $idCheckbox140
Global $DisableSetupapiDll
Global $idCheckbox141
Global $DisableShdocvwDll
Global $idCheckbox142
Global $DisableShell32Dll
Global $idCheckbox143
Global $DisableSlmgrVbs
Global $idCheckbox144
Global $DisableSqldumperExe
Global $idCheckbox145
Global $DisableSqlpsExe
Global $idCheckbox146
Global $DisableSQLToolsPSExe
Global $idCheckbox147
Global $DisableSyncAppvPublishingServerExe
Global $idCheckbox148
Global $DisableSyncAppvPublishingServerVbs
Global $idCheckbox149
Global $DisableSyssetupDll
Global $idCheckbox150
Global $DisableTeExe
Global $idCheckbox151
Global $DisableTrackerExe
Global $idCheckbox152
Global $DisableUrlDll
Global $idCheckbox153
Global $DisableVerClsidExe
Global $idCheckbox154
Global $DisableVsJitDebuggerExe
Global $idCheckbox155
Global $DisableWabExe
Global $idCheckbox156
Global $DisableWinrmVbs
Global $idCheckbox157
Global $DisableWsresetExe
Global $idCheckbox158
Global $DisableXwizardExe
Global $idCheckbox159
Global $DisableZipfldrDll
Global $idCheckbox160
Global $DisableAddInProcessExe
Global $idCheckbox161
Global $DisableAddInProcess32Exe
Global $idCheckbox162
Global $DisableAddInUtilExe
Global $idCheckbox163
Global $DisableKillExe
Global $idCheckbox164
Global $DisableLxrunExe
Global $idCheckbox165
Global $DisablePowershellCustomHostExe
Global $idCheckbox166
Global $DisableTextTransformExe
Global $idCheckbox167
Global $DisableWfcExe
Global $idCheckbox168
Global $DisableWslExe
Global $idCheckbox169
Global $DisableWslconfigExe
Global $idCheckbox170
Global $DisableWslhostExe
Global $idCheckbox171
Global $DisableRDPShellExe

;***********
Global $EditInfo
Global $EditInfoGUI
Global $EditWhitelistInfo
Global $EditWhitelistInfoGUI
Global $NameOfWhitelist

Global $DisableCachedLogons
Global $UACSecureCredentialPrompting


; Backup registry key for Switch OFF/ON Restrictions
Global $BackupSwitchRestrictions = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\SwitchRestrictions'

;Hide Gui to Tray Menu
Global $iAbout, $iExit
Opt("TrayOnEventMode", 1)
Opt("TrayMenuMode", 3)
; Create tray menu items and set the events
$About = TrayCreateItem("About")
TrayItemSetOnEvent($About, "_About")
TrayCreateItem("") ; Create a separator line.
$Exit = TrayCreateItem("Exit")
TrayItemSetOnEvent($Exit, "On_Close_Main")
; Set the action if you left click on the tray icon
TraySetOnEvent($TRAY_EVENT_PRIMARYUP, "RestoreGui")
; Show the menu if the icon is right clicked
TraySetClick(8)

;SRP Extensions GUI
Global $ARlistGUI
;SRP file Hash maintenance GUI
Global $ARHashlistGUI

;Warning parametr in the case of hiding 'Run As Administrator' option in Explorer context menu
Global $RunAsSmartScreenWarning = 0

;Supported Windows versions check
If not (@OSVersion="WIN_10" or  @OSVersion="WIN_81" or @OSVersion="WIN_8" or @OSVersion="WIN_7" or @OSVersion="WIN_VISTA") Then
   MsgBox(262144, "", "Only Windows 10, Windows 8.1, Windows 7, and Windows Vista are supported.")
EndIf

If (@ScriptName = 'Hard_Configurator(x64).exe' And @OSArch = "X86") Then
   MsgBox(262144,"","This file works only in 64-bit Windows version.")
   Exit
EndIf

If (@ScriptName = 'Hard_Configurator(x86).exe' And @OSArch = "X64") Then
   MsgBox(262144,"","This file works only in 32-bit Windows version.")
   Exit
EndIf

; Check if UAC is enabled
$EnableLUA = RegRead('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System','EnableLUA')
If not ($EnableLUA=1) Then
    Local $YesNo = MsgBox(4,"","Actually, User Account Controll (UAC) is disabled.  The recommended option is keeping UAC enabled (Windows default). Software Restriction Policies work properly, only when User Account Control (UAC) is enabled. If you press OK button, then UAC will be enabled. This program has no option to disable UAC, so after enabling it you will have to disable UAC by hand. Do you want to enable UAC?")
   Switch $YesNo
       case 6
          RegWrite('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System', 'EnableLUA', 'REG_DWORD', Number('1'))
          MsgBox(262144, "", "UAC enabled." )
       case 7
          MsgBox(262144, "", "UAC disabled. 'Software Restrictions Policies' and 'Run As Smartscreen' will not work properly. The 'Windows' and 'Program Files' folders will not be protected." )
   EndSwitch
EndIf

;Read the favourite skin or select "NoSkin" if error
;Select
;    case FileExists ($SkinsFolder) <> 1
;       $GuiSkin = "NoSkin"
;    case FileExists ($HardConfigurator_IniFile) <> 1
;       $GuiSkin = "NoSkin"
;;       MsgBox(262144,"", "Cannot locate Hard_Configurator INI File.")
;    case else
;       Local $x = FileReadLine ($HardConfigurator_IniFile,1)
;       Local $y = FileReadLine ($HardConfigurator_IniFile,2)
;       If abs(@error)=1 Then
;           MsgBox(262144,"", "Cannot read GUI Skin from Hard_Configurator INI File.")
;       Else
;          $GuiSkin = StringReplace($x,"SKIN=","",1,0)
;          $ListwievColor = StringReplace($y,"ListColor=","",1,0)
;          GuiCorrections()
;       EndIf
;EndSelect


Local $key = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\'
$GuiSkin = RegRead($key, 'SKIN')
Local $iskey = @error
$ListwievColor = RegRead($key, 'ListColor')
$iskey = @error & $iskey
$SkinNumber = RegRead($key, 'SkinNumber')
If $GuiSkin = "MAmbre" Then $SkinNumber = '1'


If $iskey = '00' Then
   GuiCorrections()
Else
   RegWrite($key, 'SKIN', 'REG_SZ', $GuiSkin)
   RegWrite($key, 'ListColor', 'REG_SZ', $ListwievColor)
EndIf

If FileExists ($SkinsFolder) <> 1 Then
   $GuiSkin = "NoSkin"
   $ListwievColor = 0xDFDEE1
   $SkinNumber = 0
   MsgBox(262144,"", "Cannot locate SKIN folder")
EndIf

While 1
  Sleep(100)
  MainGUI()
WEnd


 ; ----- GUIs

Func MainGUI()

Global $listview
Global $listview1
Global $listGUI
Global $EnableLUA

Global $BtnFirewallHardening
Global $BtnGeneralHelp
Global $BtnTurnOnAllRestrictions
Global $BtnInstallSRP
Global $BtnSRPWhitelistByHash
Global $BtnSRPWhitelistByPath
Global $BtnSRPWhitelistSaveLoad
Global $BtnViewSRPExtensions
Global $BtnSRPDefaultLevel
Global $BtnSRPTransparentEnabled
Global $BtnWritableSubWindows
Global $BtnDenyShortcuts
Global $BtnBlockSponsors
Global $BtnMoreSRPRestrictions
;Global $BtnNoRemovableDisksExecution
Global $BtnDisableSMB
Global $BtnHelpDisableSMB
Global $BtnNoPowerShellExecution
;Global $BtnDefenderAntiPUA
Global $BtnSystemWideDocumentsAntiExploit
Global $BtnDisableWSH
Global $BtnHideRunAsAdmin
Global $BtnRunAsSmartScreen
Global $BtnBlockRemoteAccess
Global $BtnDisableUntrustedFonts
Global $BtnTurnOFFAllSRP
Global $BtnTurnOFFAllRestrictions
Global $BtnLoadDefaults
Global $BtnSaveDefaults
Global $BtnConfigureDefender
Global $ARlistview
Global $ARlistGUI

GUISetOnEvent($GUI_EVENT_CLOSE, "On_Close_Main")


;Create GUI with Skin or Standard GUI on error
If $GuiSkin = "NoSkin" Then
       $listGUI = GUICreate("Main Configurator", $MainGuiWidth, $MainGuiHeight, 100, 200, -1)
;      GUICtrlSetDefBkColor(0xeeeeee)
Else
;      MsgBox(262144,"",$SkinsFolder & $GuiSkin)
       $listGUI = XSkinGUICreate( "Main Configurator", $MainGuiWidth, $MainGuiHeight, $SkinsFolder & $GuiSkin)
;      GUICtrlSetDefBkColor(0xFFEEcc)
       If $listGUI="NoSkin" Then $listGUI = GUICreate("Main Configurator", $MainGuiWidth, $MainGuiHeight, 100, 200, -1)
EndIf


GUISetState(@SW_ENABLE, $listGUI)


; The right color format of 2 listview panels
$ListwievColor = Number($ListwievColor)

; Create 2 panel lists
; Left panel list
$listview = GUICtrlCreateListView("VALUE", 10+$DeltaX, $DeltaY+44+$DeltaListview, 100, 180)
_GUICtrlListView_SetColumnWidth($listview, 0, 95)
_GUICtrlListView_SetBkColor($listview, $ListwievColor)
_GUICtrlListView_SetTextBkColor($Listview, $ListwievColor)

;Right panel list
$listview1 = GUICtrlCreateListView("VALUE", 520+$DeltaX, $DeltaY+44+$DeltaListview, 100, 180)
_GUICtrlListView_SetColumnWidth($listview1, 0, 95)
_GUICtrlListView_SetBkColor($listview1, $ListwievColor)
_GUICtrlListView_SetTextBkColor($Listview1, $ListwievColor)


; Delete old settings profiles from version 3.1.0.0 and prior.
If not (RegRead('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers','DeletedOldFiles') = 'yes') Then
   If ($Hard_ConfiguratorVersion = '4.0.0.0' or $Hard_ConfiguratorVersion = '4.0.0.2' or $Hard_ConfiguratorVersion = '4.0.1.0' or $Hard_ConfiguratorVersion = '4.1.0.0') Then
      FileDelete($ProgramConfigurationFolder & 'All_ON_Windows_7+.hdc')
      FileDelete($ProgramConfigurationFolder & 'All_ON_Windows_Vista.hdc')
      FileDelete($ProgramConfigurationFolder & 'NoElevationSUA_Windows_7.hdc')
      FileDelete($ProgramConfigurationFolder & 'NoElevationSUA_Windows_8+.hdc')
      FileDelete($ProgramConfigurationFolder & 'NoElevationSUA_Windows_Vista.hdc')
      FileDelete($ProgramConfigurationFolder & 'Recommended_withDefaultAllowSRP_and_BlockSponsors.hdc')
      FileDelete($ProgramConfigurationFolder & 'All_ON.hdc')
      FileDelete($ProgramConfigurationFolder & 'All_ON_MAX.hdc')
      FileDelete($ProgramConfigurationFolder & 'Hard_Configurator.hdc')
      FileDelete($ProgramConfigurationFolder & 'Recommended_nonSRP.hdc')
      If FileExists($ProgramFolder & 'Hard_Configurator - Manual.pdf') Then FileDelete($ProgramFolder & 'Hard_Configurator  - Manual.pdf')
      RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers','DeletedOldFiles', 'REG_SZ', 'yes')
   EndIf
EndIf

;Create Main GUI Buttons
  GUICtrlCreateLabel ("Hard_Configurator ver." & $Hard_ConfiguratorVersion, 520+$DeltaX-2,$DeltaY+30,100, 25, 1)

  $BtnUpdateHard_Configurator = GUICtrlCreateButton("Update", 20+$DeltaX, $DeltaY+30, 80, 25)
  GUICtrlSetOnEvent(-1, "UpdateHard_Configurator")

;  $BtnTurnOnAllSRP = GUICtrlCreateButton("Recommended SRP", 120+$DeltaX-3, $DeltaY+30-3, 140+6, 25+6, -1, 1)
;  GUICtrlSetOnEvent(-1, "TurnOnAllSRP")
;  GUICtrlSetColor($BtnTurnOnAllSRP, 0x000000)
;  GUICtrlSetBkColor(-1, 0xdddddd)

  $BtnConfigureDefender = GUICtrlCreateButton("ConfigureDefender", 130+$DeltaX+5, $DeltaY+30, 100+6, 25)
  GUICtrlSetOnEvent($BtnConfigureDefender,"ConfigureDefender")
  GUICtrlSetBkColor($BtnConfigureDefender, 0xbfbfff)
;  GUICtrlSetBkColor(-1, 0xeeeeee)


  $BtnTurnOnAllRestrictions = GUICtrlCreateButton("Recommended Settings", 245+$DeltaX-3+10, $DeltaY+30, 146-20, 25)
  GUICtrlSetOnEvent($BtnTurnOnAllRestrictions, "Recommended_Settings")
  GUICtrlSetBkColor($BtnTurnOnAllRestrictions, 0x00f000)
;  GUICtrlSetColor($BtnTurnOnAllRestrictions, 0x000000)

  $BtnFirewallHardening = GUICtrlCreateButton("Firewall Hardening", 400+$DeltaX-1-5-5, $DeltaY+30, 100+6, 25)
  GUICtrlSetOnEvent(-1, "FirewallHardening")
;  GUICtrlSetColor($BtnFirewallHardening, 0x000000)
  GUICtrlSetBkColor($BtnFirewallHardening, 0xbfbfff)


;GUICtrlCreateButton("", 120+$DeltaX-1, $DeltaY+70-8, 390+2, 2)
;GUICtrlCreateButton("", 120+$DeltaX-1, $DeltaY+70-50, 390+2, 2)
;GUICtrlCreateButton("", 120+$DeltaX, $DeltaY+70-50-1, 2, 45)
;GUICtrlCreateButton("", 120+$DeltaX + 386, $DeltaY+70-50-1, 2, 45)

  $BtnInstallSRP = GUICtrlCreateButton("(Re)Install SRP", 120+$DeltaX, $DeltaY+90, 140, 19)
;  GUICtrlSetColor ( $BtnInstallSRP, 0x000000 )
  GUICtrlSetOnEvent(-1, "SRP")
  $BtnHelpInstallSRP = GUICtrlCreateButton("Help", 270+$DeltaX, $DeltaY+90, 40, 19)
  GUICtrlSetOnEvent(-1,"Help1")


  $BtnSRPWhitelistByHash = GUICtrlCreateButton("Whitelist By Hash", 120+$DeltaX, $DeltaY+109, 100, 19)
  GUICtrlSetOnEvent(-1, "WhitelistByHash")
  $BtnHelpSRPWhitelistByHash = GUICtrlCreateButton("Help", 270+$DeltaX, $DeltaY+109, 40, 19)
  GUICtrlSetOnEvent(-1, "Help2")


  $BtnSRPWhitelistByPath = GUICtrlCreateButton("Whitelist By Path", 120+$DeltaX, $DeltaY+128, 100, 19)
  GUICtrlSetOnEvent(-1, "WhitelistByPath")
  $BtnHelpSRPWhitelistByPath = GUICtrlCreateButton("Help", 270+$DeltaX, $DeltaY+128, 40, 19)
  GUICtrlSetOnEvent(-1, "Help3")

  $BtnSRPWhitelistSaveLoad = GUICtrlCreateButton("Save Load", 120+$DeltaX+100, $DeltaY+128-19, 40, 38, 0x2000)
  GUICtrlSetOnEvent(-1, "SRPWhitelistSaveLoad")

  $BtnViewSRPExtensions = GUICtrlCreateButton("Designated File Types", 120+$DeltaX, $DeltaY+147, 140, 19)
  GUICtrlSetOnEvent(-1, "AddRemoveGui")
  $BtnHelpViewSRPExtensions = GUICtrlCreateButton("Help", 270+$DeltaX, $DeltaY+147, 40, 19)
  GUICtrlSetOnEvent(-1, "Help4")

  $BtnSRPDefaultLevel = GUICtrlCreateButton("Default Security Level", 120+$DeltaX, $DeltaY+166, 140, 19)
  GUICtrlSetOnEvent(-1, "DefaultLevel")
  $BtnHelpSRPDefaultLevel = GUICtrlCreateButton("Help", 270+$DeltaX, $DeltaY+166, 40, 19)
  GUICtrlSetOnEvent(-1, "Help5")


  $BtnSRPTransparentEnabled = GUICtrlCreateButton("Enforcement", 120+$DeltaX, $DeltaY+185, 140, 19)
  GUICtrlSetOnEvent(-1, "TransparentEnabled")
  $BtnHelpSRPTransparentEnabled = GUICtrlCreateButton("Help", 270+$DeltaX, $DeltaY+185, 40, 19)
  GUICtrlSetOnEvent(-1, "Help6")


  $BtnBlockSponsors = GUICtrlCreateButton("Block Sponsors",120+$DeltaX, $DeltaY+204, 140, 19)
  GUICtrlSetOnEvent(-1, "CheckBoxBlockSponsors1")
  $BtnHelpBlockSponsors = GUICtrlCreateButton("Help", 270+$DeltaX, $DeltaY+204, 40, 19)
  GUICtrlSetOnEvent(-1, "HelpBlockSponsors")


  $BtnMoreSRPRestrictions = GUICtrlCreateButton("MORE SRP ...", 120+$DeltaX, $DeltaY+223, 140, 19)
  GUICtrlSetOnEvent(-1, "MoreSRPRestrictions")
  $BtnHelpWritableSubWindows = GUICtrlCreateButton("Help", 270+$DeltaX, $DeltaY+223, 40, 19)
  GUICtrlSetOnEvent(-1, "HelpMoreSRPRestrictions")


;  $BtnWritableSubWindows = GUICtrlCreateButton("Protect Windows Folder", 120+$DeltaX, $DeltaY+204, 140, 19)
;  GUICtrlSetOnEvent(-1, "WritableSubWindows")
;  $BtnHelpWritableSubWindows = GUICtrlCreateButton("Help", 270+$DeltaX, $DeltaY+204, 40, 19)
;  GUICtrlSetOnEvent(-1, "Help7")

;  $BtnDenyShortcuts = GUICtrlCreateButton("Protect Shortcuts", 120+$DeltaX, $DeltaY+223, 140, 19)
;  GUICtrlSetOnEvent(-1, "Deny_Shortcuts")
;  $BtnHelpDenyShortcuts = GUICtrlCreateButton("Help", 270+$DeltaX, $DeltaY+223, 40, 19)
;  GUICtrlSetOnEvent(-1, "Help8")

  $BtnDisableSMB = GUICtrlCreateButton("Disable SMB", 370+$DeltaX, $DeltaY+90, 140, 19)
  GUICtrlSetOnEvent(-1, "Disable_SMB")
  $BtnHelpDisableSMB = GUICtrlCreateButton("Help", 320+$DeltaX, $DeltaY+90, 40, 19)
  GUICtrlSetOnEvent(-1, "HelpSMB")


  $BtnNoPowerShellExecution = GUICtrlCreateButton("Block PowerShell Scripts", 370+$DeltaX, $DeltaY+109, 140, 19)
  GUICtrlSetOnEvent(-1, "NoPowerShellExecution")
  $BtnHelpNoPowerShellExecution = GUICtrlCreateButton("Help", 320+$DeltaX, $DeltaY+109, 40, 19)
  GUICtrlSetOnEvent(-1, "HelpA")


  ;$BtnDefenderAntiPUA = GUICtrlCreateButton("Defender PUA Protection", 370+$DeltaX, $DeltaY+128, 140, 19)
  ;GUICtrlSetOnEvent(-1, "DefenderAntiPUA")
  ;$BtnHelpDefenderAntiPUA = GUICtrlCreateButton("Help", 320+$DeltaX, $DeltaY+128, 40, 19)
  ;GUICtrlSetOnEvent(-1, "HelpB")

  $BtnSystemWideDocumentsAntiExploit = GUICtrlCreateButton("Documents Anti-Exploit", 370+$DeltaX, $DeltaY+128, 140, 19)
  GUICtrlSetOnEvent(-1, "SystemWideDocumentsAntiExploit")
  $BtnHelpSystemWideDocumentsAntiExploit = GUICtrlCreateButton("Help", 320+$DeltaX, $DeltaY+128, 40, 19)
  GUICtrlSetOnEvent(-1, "HelpSystemWideDocumentsAntiExploit")

  $BtnDisableWSH = GUICtrlCreateButton("Block Windows Script Host", 370+$DeltaX, $DeltaY+147, 140, 19)
  GUICtrlSetOnEvent(-1, "DisableWSH")
  $BtnHelpDisableWSH = GUICtrlCreateButton("Help", 320+$DeltaX, $DeltaY+147, 40, 19)
  GUICtrlSetOnEvent(-1, "HelpC")


  $BtnHideRunAsAdmin = GUICtrlCreateButton("Hide  'Run As Administrator'", 370+$DeltaX, $DeltaY+166, 140, 19)
  GUICtrlSetOnEvent(-1, "HideRunAsAdmin")
  $BtnHelpHideRunAsAdmin = GUICtrlCreateButton("Help", 320+$DeltaX, $DeltaY+166, 40, 19)
  GUICtrlSetOnEvent(-1, "HelpD")


  $BtnRunAsSmartScreen = GUICtrlCreateButton("Run As SmartScreen", 370+$DeltaX, $DeltaY+185, 140, 19)
  GUICtrlSetOnEvent(-1, "RunAsSmartScreen1")
  $BtnHelpRunAsSmartScreen = GUICtrlCreateButton("Help", 320+$DeltaX, $DeltaY+185, 40, 19)
  GUICtrlSetOnEvent(-1, "HelpE")


  $BtnBlockRemoteAccess = GUICtrlCreateButton("Block Remote Access", 370+$DeltaX, $DeltaY+204, 140, 19)
  GUICtrlSetOnEvent(-1, "BlockRemoteAccess")
  $BtnHelpBlockRemoteAccess = GUICtrlCreateButton("Help", 320+$DeltaX, $DeltaY+204, 40, 19)
  GUICtrlSetOnEvent(-1, "HelpF")


  $BtnMoreRestrictions = GUICtrlCreateButton("MORE ...", 370+$DeltaX, $DeltaY+223, 140, 19)
  GUICtrlSetOnEvent(-1, "MoreRestrictions")
  $BtnHelpDisableUntrustedFonts = GUICtrlCreateButton("Help", 320+$DeltaX, $DeltaY+223, 40, 19)
  GUICtrlSetOnEvent(-1, "HelpMoreRestrictions")

  $BtnTurnOFFAllSRP = GUICtrlCreateButton("Switch OFF/ON SRP", 120+$DeltaX-3-3, $DeltaY+277, 140+6, 25)
  GUICtrlSetOnEvent($BtnTurnOFFAllSRP, "TurnOFFAllSRP")
  GUICtrlSetBkColor($BtnTurnOFFAllSRP, 0x00f000)


  $BtnTurnOFFAllRestrictions = GUICtrlCreateButton("Switch OFF/ON Restrictions", 370+$DeltaX-3+3, $DeltaY+277, 140+6, 25)
  GUICtrlSetOnEvent(-1, "TurnOFFAllRestrictions")
  GUICtrlSetBkColor(-1, 0x00f000)

  $BtnGeneralHelp = GUICtrlCreateButton("General Help", 270+$DeltaX-6, $DeltaY+277, 90+12, 25)
  GUICtrlSetOnEvent($BtnGeneralHelp,"Help0")
;  GUICtrlSetColor($BtnGeneralHelp, 0x000000)
;  GUICtrlSetBkColor(-1, 0xdddddd)


  $BtnGuiSkin = GUICtrlCreateButton("GUI Skin", 20+$DeltaX, $DeltaY+317, 55, 25)
  GUICtrlSetOnEvent(-1, "ChangeGuiSkin")
;  GUICtrlSetColor($BtnGuiSkin, 0x000000)
;  GUICtrlSetBkColor(-1, 0xeeeeee)

  $ButtonSkinNumber = GUICtrlCreateButton($SkinNumber, 20+$DeltaX + 55, $DeltaY+317, 25, 25)
  GUICtrlSetOnEvent(-1, "ChooseSkinFromNumber")
;  GUICtrlSetColor($ButtonSkinNumber, 0xffffff)
;  GUICtrlSetFont($ButtonSkinNumber, 9, 500)
;  GUICtrlSetBkColor($ButtonSkinNumber, "0x000000")


  $BtnTools = GUICtrlCreateButton("Tools", 20+$DeltaX, $DeltaY+277, 80, 25)
  GUICtrlSetOnEvent(-1, "Tools")
;  GUICtrlSetColor($BtnTools, 0x000000)
;  GUICtrlSetBkColor(-1, 0xeeeeee)

  $BtnLoadDefaults = GUICtrlCreateButton("Load Profile", 150+$DeltaX-5, $DeltaY+317-3, 80+6, 25+6, -1, 1)
  GUICtrlSetOnEvent(-1, "LoadDefaults")
;  GUICtrlSetColor($BtnLoadDefaults, 0x000000)
;  GUICtrlSetBkColor(-1, 0xdddddd)

  $BtnApplyChanges = GUICtrlCreateButton("APPLY CHANGES", 270+$DeltaX-10, $DeltaY+312, 100+10, 35)
  GUICtrlSetOnEvent(-1,"ApplyChanges")
  GUICtrlSetBkColor(-1, 0xff4040)
  GUICtrlSetFont ( $BtnApplyChanges, -1, 700)


  $BtnSaveDefaults = GUICtrlCreateButton("Save Profile", 400+$DeltaX-3, $DeltaY+317-3, 80+6, 25+6, -1, 1)
  GUICtrlSetOnEvent(-1, "EditInfoSaveDefaults")
;  GUICtrlSetColor($BtnSaveDefaults, 0x000000)
;  GUICtrlSetBkColor(-1, 0xdddddd)



;*************************

If $GuiSkin = "NoSkin" Then _GUICtrlButton_Enable($BtnGuiSkin, False)
If $GuiSkin = "NoSkin" Then _GUICtrlButton_Enable($ButtonSkinNumber, False)

$iClose = GUICtrlCreateButton("Close", 530+$DeltaX, $DeltaY+317, 80, 25)
GUICtrlSetOnEvent(-1, "On_Close_Main")
;GUICtrlSetColor($iClose, 0x000000)
;GUICtrlSetBkColor(-1, 0xeeeeee)

$iMinimize = GUICtrlCreateButton("Minimize", 530+$DeltaX, $DeltaY+277, 80, 25)
GUICtrlSetOnEvent(-1, "_GuiMinimizeToTray")
;GUICtrlSetColor($iMinimize, 0x000000)
;GUICtrlSetBkColor(-1, 0xeeeeee)


;MsgBox(262144,"", "Stan GUISkin = " & GUICtrlSetOnEvent(-1, "ChangeGuiSkin"))


ShowRegistryTweaks()

FileDelete($ProgramFolder & 'temp\*.*')
GUISetState()
;Change GUI Skin
Do
    Sleep(100)
    Until $ChangeGuiSkin = 1
GUIDelete()
$ChangeGuiSkin = 0

EndFunc



Func ShowRegistryTweaks()

Global $SRPDefaultLevel
Global $isSRPinstalled
Global $SRPTransparentEnabled
Global $SRPAllowExe
Global $WritableSubWindows
Global $DefenderAntiPUA
Global $SystemWideDocumentsAntiExploit
Global $NoRemovableDisksExecution
Global $NoPowerShellExecution
Global $DenyShortcuts
Global $DisableWSH
Global $HideRunAsAdmin
Global $RunAsSmartScreen
Global $BlockRemoteAccess
Global $DisableUntrustedFonts
GLobal $Disable16Bits
Global $EnforceShellExtensionSecurity
;Global $DisableCommandPrompt
Global $NoElevationSUA
Global $BlockPowerShellSponsors
Global $MSIElevation
Global $DisableSMB
Global $MoreRestrictionsOutput
Global $MoreSRPRestrictionsOutput


;*****
;This buttons can be greyed/ungreyed
Global $GreySRPWhitelistByHash = 0
Global $GreySRPWhitelistByPath = 0
Global $GreyViewSRPExtensions = 0
Global $GreySRPDefaultLevel = 0
Global $GreySRPTransparentEnabled = 0
Global $GreyWritableSubWindows = 0
Global $GreyDefenderAntiPUA = 1
Global $GreySystemWideDocumentsAntiExploit = 0
Global $GreyDisableUntrustedFonts = 1
Global $GreyNoRemovableDisksExecution = 1
Global $GreyNoPowerShellExecution = 0
Global $GreyRunAsSmartScreen = 0
Global $GreyDenyShortcuts = 0
Global $GreyTurnOFFAllSRP = 0


  _GUICtrlButton_Enable($BtnFirewallHardening, True)
  _GUICtrlButton_Enable($BtnTurnOnAllRestrictions, True)
  _GUICtrlButton_Enable($BtnInstallSRP, True)
  _GUICtrlButton_Enable($BtnSRPWhitelistByHash, True)
  _GUICtrlButton_Enable($BtnSRPWhitelistByPath, True)
  _GUICtrlButton_Enable($BtnSRPWhitelistSaveLoad, True)
  _GUICtrlButton_Enable($BtnViewSRPExtensions, True)
  _GUICtrlButton_Enable($BtnSRPDefaultLevel, True)
  _GUICtrlButton_Enable($BtnSRPTransparentEnabled, True)
  _GUICtrlButton_Enable($BtnBlockSponsors, True)
  _GUICtrlButton_Enable($BtnMoreSRPRestrictions, True)
  _GUICtrlButton_Enable($BtnWritableSubWindows, True)
  _GUICtrlButton_Enable($BtnDisableSMB, True)
  _GUICtrlButton_Enable($BtnDenyShortcuts, True)
;  _GUICtrlButton_Enable($BtnNoRemovableDisksExecution, True)
  _GUICtrlButton_Enable($BtnNoPowerShellExecution, True)
  _GUICtrlButton_Enable($BtnDisableWSH, True)
;  _GUICtrlButton_Enable($BtnDefenderAntiPUA, True)
  _GUICtrlButton_Enable($BtnSystemWideDocumentsAntiExploit, True)
  _GUICtrlButton_Enable($BtnHideRunAsAdmin, True)
  _GUICtrlButton_Enable($BtnRunAsSmartScreen, True)
;  _GUICtrlButton_Enable($BtnDisableUntrustedFonts, True)
  _GUICtrlButton_Enable($BtnBlockRemoteAccess, True)
  _GUICtrlButton_Enable($BtnTurnOFFAllSRP, True)
  _GUICtrlButton_Enable($BtnTurnOFFAllRestrictions, True)
  _GUICtrlButton_Enable($BtnLoadDefaults, True)
  _GUICtrlButton_Enable($BtnSaveDefaults, True)
  _GUICtrlButton_Enable($BtnConfigureDefender, True)

If not (@OSVersion="WIN_10") Then  _GUICtrlButton_Enable($BtnConfigureDefender, False)
If RegRead('HKLM\SOFTWARE\Policies\Microsoft\Windows Defender', 'DisableAntiSpyware') = 1 Then _GUICtrlButton_Enable($BtnConfigureDefender, False)
If RegRead('HKLM\SOFTWARE\Microsoft\Windows Defender', 'DisableAntiSpyware') = 1 Then _GUICtrlButton_Enable($BtnConfigureDefender, False)
If RegRead('HKLM\SOFTWARE\Microsoft\Windows Defender', 'DisableAntiVirus') = 1 Then _GUICtrlButton_Enable($BtnConfigureDefender, False)


; Refresh the position of windows
$X_ToolsGUI = -1
$Y_ToolsGUI = -1
$X_SRPExtensionsGUI = -1
$Y_SRPExtensionsGUI = -1
$X_MRSTRlistGUI = -1
$Y_MRSTRlistGUI = -1
$X_M_SRPlistGUI = -1
$Y_M_SRPlistGUI = -1
$X_SavedWhitelistslistGUI = -1
$Y_SavedWhitelistslistGUI = -1


;Clear Main GUI panel lists
 _GUICtrlListView_DeleteAllItems($Listview)
 _GUICtrlListView_DeleteAllItems($Listview1)

; Disable some buttons for earlier Windows versions

; This option is not useful, so will be deactivated
_GUICtrlButton_Enable($BtnDisableUntrustedFonts, True)
$GreyDisableUntrustedFonts = 1

;Test if SmartScreen is Enabled
If (@OSVersion="WIN_10" or @OSVersion="WIN_81" or @OSVersion="WIN_8") Then
   Local $ES1 = RegRead('HKLM\SOFTWARE\Policies\Microsoft\Windows\System', 'EnableSmartScreen')
   If @error<>0  Then $ES1 = 'ERROR'
   Local $ES2 = RegRead('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer', 'SmartScreenEnabled')
   If @error<>0 Then $ES2 = 'ERROR'
   If $ES1='0' Then
      _GUICtrlButton_Enable($BtnRunAsSmartScreen, False)
      $GreyRunAsSmartScreen = 1
   Else
      IF ($ES2='Off' and $ES1='ERROR') Then
         _GUICtrlButton_Enable($BtnRunAsSmartScreen, False)
         $GreyRunAsSmartScreen = 1
      EndIf
   EndIf
   If ($ES1 = 'ERROR' and $ES2 = 'ERROR') Then
      RegWrite ('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer', 'SmartScreenEnabled', 'REG_SZ', 'Prompt')
      $GreyRunAsSmartScreen = 0
     _GUICtrlButton_Enable($BtnRunAsSmartScreen, True)
   EndIf
EndIf

If not (@OSVersion="WIN_10" or @OSVersion="WIN_81" or @OSVersion="WIN_8") Then
   _GUICtrlButton_Enable($BtnRunAsSmartScreen, False)
   $GreyRunAsSmartScreen = 1
EndIf

;If not (@OSVersion="WIN_81" or @OSVersion="WIN_8") Then
;   _GUICtrlButton_Enable($BtnDefenderAntiPUA, False)
;   $GreyDefenderAntiPUA = 1
;   RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine','MpEnablePus')
;EndIf


; Turn OFF No Removable Disks Execution
;If RegRead('HKLM\SOFTWARE\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}', 'Deny_Execute') = Number('1') Then
;   MsgBox(262144,"ALERT", "Hard_Configurator has detected that blocking execution from removable disks is turned ON. This Windows feature was reported by users as invalid due to wrong detection of fixed disks. Hard_Configurator will turn OFF this feature, so it will be grayed out in the main program window. Please remember, that execution from removable disks (Pendrives, USB disks, Memory Cards) can remain blocked, until they will be physically unplugged and the system restarted. Next time when you plug them again, the execution will not be blocked. See also the help for <No Removable Disks Exec.>.")
;   RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}', 'Deny_Execute')
;EndIf
;_GUICtrlButton_Enable($BtnNoRemovableDisksExecution, False)
;$GreyNoRemovableDisksExecution = 1
;If not (@OSVersion="WIN_10" or  @OSVersion="WIN_81" or @OSVersion="WIN_8" or @OSVersion="WIN_7") Then
;   _GUICtrlButton_Enable($BtnNoRemovableDisksExecution, False)
;   $GreyNoRemovableDisksExecution = 1
;   _GUICtrlButton_Enable($BtnNoPowerShellExecution, False)
;   $GreyNoPowerShellExecution = 1
;EndIf

;If not (@OSVersion="WIN_81" or @OSVersion="WIN_8" or @OSVersion="WIN_7" or @OSVersion="WIN_VISTA") Then
;   _GUICtrlButton_Enable($BtnWritableSubWindows, False)
;   $GreyWritableSubWindows = 1
;EndIf
;If @OSVersion="WIN_10" Then $WritableSubWindows = "ON"

;If RegRead('HKLM\SOFTWARE\Microsoft\Windows Defender', 'DisableAntiSpyware')=1 Then
;   _GUICtrlButton_Enable($BtnDefenderAntiPUA, False)
;   $GreyDefenderAntiPUA = 1
;EndIf

;If RegRead('HKLM\SOFTWARE\Microsoft\Windows Defender\Real-Time Protection', 'DisableRealtimeMonitoring')=1 Then
;   _GUICtrlButton_Enable($BtnDefenderAntiPUA, False)
;   $GreyDefenderAntiPUA = 1
;EndIf

;Read Rregistry keys to be tweaked


;The First RUN Maintenance
Local $Reg = RegRead('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers', 'Installed')
If not ($Reg = '1') Then
  GUISetState(@SW_HIDE,$listGUI)
  Tools()
  GuiDelete($ToolslistGUI)
;Shows Main GUI Window after doing some maintenance
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.6)
   Local $x = _ExtMsgBox(64,"&YES|NO", "", "Do you want to apply the recommended settings?")
   If $x = 1 Then 
      TurnOnAllSRP()
      TurnOnAllRestrictions1()
      $RefreshChangesCheck = "recommendedsettings"
      ApplyChangesOnExit()
   Else
 ;     _ExtMsgBox(64,"&OK", "", "Please, configure the settings manually and next use <APPLY CHANGES> button.")
   EndIf
   GUISetState(@SW_HIDE, $listGUI)
   _GUICtrlListView_DeleteAllItems($Listview)
   _GUICtrlListView_DeleteAllItems($Listview1)
   GUISetState(@SW_SHOW, $listGUI)
   GUISetState(@SW_ENABLE, $listGUI)
Else
; Shows Main GUI Window
  GUISetState(@SW_SHOW,$listGUI)
EndIf

Local $keyname = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers"
Local $valuename = "DefaultLevel"
$SRPDefaultLevel = RegRead ( $keyname, $valuename )
Local $iskey = @error
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


If CheckAllowEXE() = 2 Then 
   $SRPAllowExe = "ON"
Else
   $SRPAllowExe = "OFF"
   RemoveAllowEXE()
EndIf


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
   _GUICtrlButton_Enable($BtnSRPWhitelistByHash, False)
   _GUICtrlButton_Enable($BtnSRPWhitelistByPath, False)
   _GUICtrlButton_Enable($BtnSRPWhitelistSaveLoad, False)
   _GUICtrlButton_Enable($BtnViewSRPExtensions, False)
   _GUICtrlButton_Enable($BtnSRPDefaultLevel, False)
   _GUICtrlButton_Enable($BtnSRPTransparentEnabled, False)
   _GUICtrlButton_Enable($BtnWritableSubWindows, False)
   _GUICtrlButton_Enable($BtnDenyShortcuts, False)
   _GUICtrlButton_Enable($BtnTurnOFFAllSRP, False)
   _GUICtrlButton_Enable($BtnBlockSponsors, False)
   _GUICtrlButton_Enable($BtnMoreSRPRestrictions, False)
EndIf


If $isSRPinstalled = "Installed" Then
Local $whitelist = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers\262144\Paths'
Local $key = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers'
_RegCopyKey($key & '\Temp\262144\FirstRunWhitelist', $whitelist)
RegDelete($key & '\Temp\262144\FirstRunWhitelist')
EndIf

_GUICtrlButton_Enable($BtnBlockSponsors, False)
_GUICtrlButton_Enable($BtnMoreSRPRestrictions, False)
If $isSRPinstalled = "Installed" Then
   If Not ($SRPTransparentEnabled = "No Enforcement") Then
      _GUICtrlButton_Enable($BtnBlockSponsors, True)
      _GUICtrlButton_Enable($BtnMoreSRPRestrictions, True)
   EndIf
EndIf

If $isSRPinstalled = "Installed" Then
   _GUICtrlButton_Enable($BtnSRPWhitelistByHash, True)
   _GUICtrlButton_Enable($BtnSRPWhitelistByPath, True)
   _GUICtrlButton_Enable($BtnViewSRPExtensions, True)
   _GUICtrlButton_Enable($BtnSRPDefaultLevel, True)
   _GUICtrlButton_Enable($BtnSRPTransparentEnabled, True)
   _GUICtrlButton_Enable($BtnTurnOFFAllSRP, True)
   CheckOld_PS_CMD()
EndIf


;If @OSVersion="WIN_10" Then _GUICtrlButton_Enable($BtnWritableSubWindows, False)

Local $_HashNumber = Ubound(Hash2Array())
Local $_PathNumber = Ubound(Path2Array())
;MsgBox(262144,"",$_HashNumber)
If ($SRPDefaultLevel = "Allow All" or $SRPDefaultLevel = "not found" or $SRPDefaultLevel = "?") Then
   $_HashNumber = "OFF"
   $_PathNumber = "OFF"
EndIf

Local $_ExtensionsNumber = Ubound(Reg2Array())
If ($SRPTransparentEnabled = "No Enforcement" Or $SRPDefaultLevel = "Allow All") Then
   $_ExtensionsNumber = "OFF"
EndIf


;If $GreyWritableSubWindows = 0 Then
;   $WritableSubWindows =  CheckWritableSubWindows()
;   Switch $WritableSubWindows
;      case "0"
;         $WritableSubWindows = "OFF"
;      case 1
;         $WritableSubWindows = "ON"
;      case Else
;         $WritableSubWindows = "?"
;   EndSwitch
;EndIf
;If $GreyWritableSubWindows = 1 Then $WritableSubWindows = "OFF"
;If ($SRPTransparentEnabled = "No Enforcement" or $SRPTransparentEnabled = "not found" or $SRPTransparentEnabled = "?") Then
;   $WritableSubWindows = "OFF"
;EndIf


;local $guidname = '{1016bbe0-a716-428b-822e-5E544B6A3301}'
;$keyname = 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\0\paths\' & $guidname
;$valuename = "ItemData"
;$DenyShortcuts = RegRead ( $keyname, $valuename )
;$iskey = @error
;Switch $DenyShortcuts
;   case "*.lnk"
;      $DenyShortcuts = "ON"
;   case Else
;      $DenyShortcuts = "?"
;EndSwitch
;If ($iskey = -1 or $iskey =1) Then $DenyShortcuts = "OFF"
;If ($SRPTransparentEnabled = "No Enforcement" or $SRPTransparentEnabled = "not found" or $SRPTransparentEnabled = "?") Then
;   $DenyShortcuts = "OFF"
;EndIf

; Set the state of SRP. If TurnOFFAllSRP reg value is 0 then SRP are activated.
Local $key = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers'
Local $backkey = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers'
Local $x = RegRead($key, 'DefaultLevel')
Local $y = RegRead($key, 'TransparentEnabled')
If ($x ='262144' OR  $x ='131072' OR  $x ='0') Then RegWrite($backkey, 'TurnOFFAllSRP', 'REG_SZ', '0')
If ($y ='0' OR  $y ='1' OR  $y ='2') Then RegWrite($backkey, 'TurnOFFAllSRP', 'REG_SZ', '0')
If ($x = '262144'  And $y ='0' ) Then  RegWrite($backkey, 'TurnOFFAllSRP', 'REG_SZ', '1')

; value names changes
Local $SRPpoziomy
Switch $SRPDefaultLevel
   case "White List"
      $SRPpoziomy = "Disallowed"
   case "Allow All"
      $SRPpoziomy = "Unrestricted"
   case "Basic User"
      $SRPpoziomy = "Basic User"
   case "not found"
      $SRPpoziomy = "not found"
   case "OFF"
      $SRPpoziomy = "OFF"
   case Else
      $SRPpoziomy = "?"
EndSwitch

Switch $SRPTransparentEnabled
   case "No Enforcement"
      $SRPWymuszanie = "No Enforcement"
   case "Skip DLLs"
      $SRPWymuszanie = "Skip DLLs"
   case "Include DLLs"
      $SRPWymuszanie = "All Files"
   case "not found"
      $SRPWymuszanie = "not found"
   case "OFF"
      $SRPWymuszanie = "OFF"
   case Else
      $SRPWymuszanie = "?"
EndSwitch
; End of value names changes

CheckStateOfSponsorsCheckboxes()
MoreSRPRestrictionsValues()
$keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers\262144\Paths\{1016bbe0-a716-428b-822e-DE544B6A3520}'
If RegRead($keyname, 'ItemData')='*.exe' Then
   If StringInStr($_PathNumber, '*.exe') = 0 Then $_PathNumber = $_PathNumber & ' ;  EXE, TMP'
;  Poprawka dla ustawień wersji 4.0.0.0
   AddAllowEXE()
EndIf

; Show settings values in the left panel list
  GUICtrlCreateListViewItem($isSRPinstalled, $listview)
  GUICtrlCreateListViewItem($_HashNumber, $listview)
  GUICtrlCreateListViewItem($_PathNumber, $listview)
  GUICtrlCreateListViewItem($_ExtensionsNumber, $listview)
  GUICtrlCreateListViewItem($SRPpoziomy, $listview)
  GUICtrlCreateListViewItem($SRPWymuszanie, $listview)
  GUICtrlCreateListViewItem($BlockSponsorsNumber, $listview)
  GUICtrlCreateListViewItem('# ' & $MoreSRPRestrictionsOutput, $listview)

; Cheks if SMB is disabled ans save the check in $DisableSMB variable
_CheckDisableSMB()

$keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}'
$valuename = 'Deny_Execute'
$NoRemovableDisksExecution = RegRead ( $keyname, $valuename )
$iskey = @error
Switch $NoRemovableDisksExecution
   case 0
      $NoRemovableDisksExecution = "OFF"
   case 1
      $NoRemovableDisksExecution = "ON"
   case Else
     $NoRemovableDisksExecution = "?"
EndSwitch
If ($iskey = -1 or $iskey =1) Then $NoRemovableDisksExecution = "OFF"
;If $GreyNoRemovableDisksExecution = 1 Then $NoRemovableDisksExecution = "OFF"

$keyname = 'HKLM\Software\Policies\Microsoft\Windows\PowerShell'
$valuename = 'EnableScripts'
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
If $GreyNoPowerShellExecution = 1 Then $NoPowerShellExecution = "OFF"


;$keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine'
$valuename = 'MpEnablePus'
$DefenderAntiPUA = RegRead ( $keyname, $valuename )
$iskey = @error
Switch $DefenderAntiPUA
   case 1
      $DefenderAntiPUA = "ON"
   case 0
      $DefenderAntiPUA = "OFF"
   case Else
     $DefenderAntiPUA = "?"
EndSwitch
If ($iskey = -1 or $iskey =1) Then $DefenderAntiPUA = "OFF"
;If $GreyDefenderAntiPUA = 1 Then $DefenderAntiPUA = "OFF"

;MsgBox(0,"1", $SystemWideDocumentsAntiExploit)
$SystemWideDocumentsAntiExploit = CheckSystemWideDocumentsAntiExploit()
;MsgBox(0,"2", $SystemWideDocumentsAntiExploit)

$keyname = 'HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings'
$keyname1 = 'HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows Script Host\Settings'
$valuename = 'Enabled'
$DisableWSH = RegRead ( $keyname, $valuename )
$iskey = @error
;* Poprawka na błąd wczśniejszych wersji Hard_Configuratora
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
If $GreyRunAsSmartScreen = 1 Then $RunAsSmartScreen = "OFF"


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

;$keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows NT\MitigationOptions'
;$valuename = 'MitigationOptions_FontBocking'
;$DisableUntrustedFonts = RegRead ( $keyname, $valuename )
;$iskey = @error
;Switch $DisableUntrustedFonts
;   case 1000000000000
;      $DisableUntrustedFonts = "ON"
;   case 2000000000000
;      $DisableUntrustedFonts = "OFF"
;   case 3000000000000
;      $DisableUntrustedFonts = "AUDIT"
;   case Else
;      $DisableUntrustedFonts = "?"
;EndSwitch
;If ($iskey = -1 or $iskey =1) Then $DisableUntrustedFonts = "OFF"
;IF $GreyDisableUntrustedFonts = 1 Then $DisableUntrustedFonts = "OFF"

; Poprawka na błąd wcześniejszej wersji
;IF $GreyDisableUntrustedFonts = 1 Then
;   $DisableUntrustedFonts = "OFF"
;   $keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows NT\MitigationOptions'
;   $valuename = 'MitigationOptions_FontBocking'
;   RegDelete ( $keyname, $valuename )
;EndIf

; Get the $MoreRestrictionsOutput value for options in <More Restrictions>.

MoreRestrictionsValues()

; Show settings values in the right panel list
GUICtrlCreateListViewItem($DisableSMB, $listview1)
GUICtrlCreateListViewItem($NoPowerShellExecution, $listview1)
GUICtrlCreateListViewItem($SystemWideDocumentsAntiExploit, $listview1)
GUICtrlCreateListViewItem($DisableWSH, $listview1)
GUICtrlCreateListViewItem($HideRunAsAdmin, $listview1)
GUICtrlCreateListViewItem($RunAsSmartScreen, $listview1)
GUICtrlCreateListViewItem($BlockRemoteAccess, $listview1)
GUICtrlCreateListViewItem('# ' & $MoreRestrictionsOutput, $listview1)

;This must be after the code that are displaying list view panels.
;Warning - in the case of hiding 'Run As Administrator' option in Explorer context menu
If ($RunAsSmartScreen = "OFF" or $RunAsSmartScreen = "Standard User") Then
   If ($HideRunAsAdmin = "ON" and $SRPDefaultLevel = "White List") Then $RunAsSmartScreenWarning = $RunAsSmartScreenWarning + 1
   If ($HideRunAsAdmin = "ON" and $SRPDefaultLevel = "Basic User") Then $RunAsSmartScreenWarning = $RunAsSmartScreenWarning + 1
EndIf


If $RunAsSmartScreenWarning = 1 Then
;   MsgBox(262144,"","Be careful! SRP are activated, <Hide 'Run As Administrator'> is set to 'ON', but <Run As Smartscreen> is not set to 'Administrator'. This kind of settings will lock the User Space, so there will be no way to run/instal programs there. This warning is showing only once, so please read the help files to understand the consequences.")
   $RunAsSmartScreenWarning = 2
EndIf

$temp = RegRead('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers\0\Paths\{1016bbe0-a716-428b-822e-5E544B6A3243}', 'ItemData')
If StringLower($temp) = 'shdocvw.dll' Then
   If ($SRPTransparentEnabled = "Include DLLs" and $RunAsSmartScreen <> "OFF") Then
      _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.5)
      _ExtMsgBox(64,"OK", "Hard_Configurator", "The library 'shdocvw.dll' has been unblocked for compatibility with SmartScreen." & @crlf & "If you intentionally want to block this library, then first set <Run As SmartScreen> to OFF (not recommended).")
         EnableShdocvwDLL()
         ShowRegistryTweaks()
   EndIf
EndIf

EndFunc


;*******************
;  ///// Functions *
;*******************
; Help functions for Help Buttons

Func Help0()
   Local $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\help0.txt")
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.6)
   Local $x = _ExtMsgBox(0,"&CLOSE|NEXT|DOCUMENTATION", "", $help)
   If $x = 1 Then Return
   If $x = 2 Then Help0_1()
   If $x = 3 Then Documentation()
EndFunc

Func Help0_1()
   Local $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\help0_1.txt")
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.7)
   Local $x = _ExtMsgBox(0,"&CLOSE|NEXT|BACK", "", $help)
   If $x = 1 Then Return
   If $x = 2 Then Help0_2()
   If $x = 3 Then Help0()
EndFunc

Func Help0_2()
   $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\help0_2.txt")
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.7)
   Local $x = _ExtMsgBox(0,"&CLOSE|BACK", "", $help)
   If $x = 1 Then Return
   If $x = 2 Then Help0_1()
EndFunc

Func Help1()
   Local $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\help1.txt")
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.5)
   Local $x = _ExtMsgBox(0,"&CLOSE|NEXT", "", $help)
   If $x = 1 Then Return
   $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\help1_1.txt")
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.5)
   Local $x = _ExtMsgBox(0,"&CLOSE|BACK", "", $help)
   If $x = 2 Then Help1()
EndFunc


Func Help2()
   Local $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\help2.txt")
;   MsgBox(262144,"", $help)
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.7)
   _ExtMsgBox(0,"CLOSE", "", $help)
EndFunc


Func Help3()
   Local $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\help3.txt")
;   MsgBox(262144,"", $help)
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.7)
   _ExtMsgBox(0,"CLOSE", "", $help)
EndFunc

Func Help4()
   Local $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\help4.txt")
;   MsgBox(262144,"", $help)
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.7)
   _ExtMsgBox(0,"CLOSE", "", $help)
EndFunc

Func Help5()
   Local $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\help5.txt")
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.7)
   Local $x = _ExtMsgBox(0,"&CLOSE|NEXT", "", $help)
   If $x = 1 Then Return
   $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\help5_1.txt")
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.5)
   Local $x = _ExtMsgBox(0,"&CLOSE|BACK", "", $help)
   If $x = 2 Then Help5()
EndFunc

Func Help6()
   Local $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\help6.txt")
;   MsgBox(262144,"", $help)
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.7)
   _ExtMsgBox(0,"CLOSE", "", $help)
EndFunc

Func HelpBlockSponsors()
   Local $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\HelpBlockSponsors.txt")
;   MsgBox(262144,"", $help)
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.7)
   _ExtMsgBox(0,"CLOSE", "", $help)
EndFunc

Func HelpMoreSRPRestrictions()
   Local $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\HelpMoreSRPRestrictions.txt")
;   MsgBox(262144,"", $help)
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.7)
   _ExtMsgBox(0,"CLOSE", "", $help)
EndFunc


Func Help7()
   Local $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\help7.txt")
;   MsgBox(262144,"", $help)
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.7)
   _ExtMsgBox(0,"CLOSE", "", $help)
EndFunc

Func Help8()
   Local $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\help8.txt")
;   MsgBox(262144,"", $help)
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.7)
  _ExtMsgBox(0,"CLOSE", "", $help)
EndFunc

Func Help9()
   Local $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\help9.txt")
;   MsgBox(262144,"", $help)
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.7)
   _ExtMsgBox(0,"CLOSE", "", $help)
EndFunc

Func HelpA()
  Local $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\helpA.txt")
;  MsgBox(262144,"", $help)
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.7)
   _ExtMsgBox(0,"CLOSE", "", $help)
EndFunc

Func HelpB()
   Local $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\helpB.txt")
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.5)
   Local $x = _ExtMsgBox(0,"&CLOSE|NEXT", "", $help)
   If $x = 1 Then Return
   $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\helpB_1.txt")
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.5)
   Local $x = _ExtMsgBox(0,"&CLOSE|BACK", "", $help)
   If $x = 2 Then HelpB()
EndFunc

Func HelpC()
   Local $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\helpC.txt")
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.5)
   Local $x = _ExtMsgBox(0,"&CLOSE|NEXT", "", $help)
   If $x = 1 Then Return
   $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\helpC_1.txt")
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.5)
   Local $x = _ExtMsgBox(0,"&CLOSE|BACK", "", $help)
   If $x = 2 Then HelpC()
EndFunc

Func HelpD()
   Local $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\helpD.txt")
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial",@DesktopWidth*0.75)
   _ExtMsgBox(0,"CLOSE", "", $help)
EndFunc

Func HelpE()
   Local $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\helpE.txt")
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.7)
   Local $x = _ExtMsgBox(0,"&CLOSE|NEXT", "", $help)
   If $x = 1 Then Return
   $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\helpE_1.txt")
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.7)
   Local $x = _ExtMsgBox(0,"&CLOSE|BACK", "", $help)
   If $x = 2 Then HelpE()
EndFunc

Func HelpF()
   Local $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\helpF.txt")
;   MsgBox(262144,"", $help)
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.7)
   _ExtMsgBox(0,"CLOSE", "", $help)
EndFunc

Func HelpG()
   Local $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\helpG.txt")
;   MsgBox(262144,"", $help)
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.7)
   _ExtMsgBox(0,"CLOSE", "", $help)
EndFunc

Func HelpMoreRestrictions()
   Local $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\HelpMore.txt")
;   MsgBox(262144,"", $help)
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.5)
   _ExtMsgBox(0,"CLOSE", "", $help)
EndFunc

Func HelpSystemWideDocumentsAntiExploit()
   Local $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\HelpSystemWideDocumentsAntiExploit.txt")
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.7)
   Local $x = _ExtMsgBox(0,"&CLOSE|NEXT", "", $help)
   If $x = 1 Then Return
   $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\HelpSystemWideDocumentsAntiExploit_1.txt")
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.7)
   Local $x = _ExtMsgBox(0,"&CLOSE|BACK", "", $help)
   If $x = 2 Then HelpSystemWideDocumentsAntiExploit()
EndFunc



; Functions for Registry changing Buttons

Func DefaultLevel()

Local $RegDataNew

If $isSRPinstalled = "Not Installed" Then
   MsgBox(262144,"","Software Restriction Policies were not installed yet.")
   Return
EndIf

$keyname = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers"
$valuename = "DefaultLevel"
$SRPDefaultLevel = RegRead ( $keyname, $valuename )
Switch $SRPDefaultLevel
   case "0"
      $RegDataNew = 131072
   case 131072
      $RegDataNew = 262144
   case 262144
      $RegDataNew = 0
   case Else
      $RegDataNew = 0
EndSwitch

IF ($SRPDefaultLevel = "0" or $SRPDefaultLevel = 131072 or $SRPDefaultLevel = 262144) Then
    RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers', 'DefaultLevel','REG_DWORD',  $RegDataNew)
Else
    MsgBox($MB_SYSTEMMODAL, "ALERT", "The SRP DefaultLevel value in the Registry is unusual." & @CRLF & "Please consider reinstalation of SRP!")
EndIf

;If $RegDataNew = 131072 Then RASExecutableTypes("full")
;If ($RegDataNew = 0 and $RunAsSmartScreen = "ON") Then RASExecutableTypes("light")


ShowRegistryTweaks()

EndFunc


Func TransparentEnabled()
Local $RegDataNew

If $isSRPinstalled = "Not Installed" Then
   MsgBox(262144,"","Software Restriction Policies were not installed yet.")
   Return
EndIf

;If $SRPDefaultLevel = "Allow All" Then
;   MsgBox(262144,"","SRP is set to 'Allow All' security level, so all executables are allowed to run.")
;   Return
;EndIf

$keyname = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers"
$valuename = "TransparentEnabled"
$SRPTransparentEnabled = RegRead ( $keyname, $valuename )
Switch $SRPTransparentEnabled
   case "0"
      $RegDataNew = 1
   case 1
      $RegDataNew = 2
   case 2
      $RegDataNew = 0
   case Else
      $RegDataNew = 1      
EndSwitch

IF ($SRPTransparentEnabled = "0" or $SRPTransparentEnabled = 1 or $SRPTransparentEnabled = 2) Then
    RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers', 'TransparentEnabled','REG_DWORD',  $RegDataNew)
    $RefreshChangesCheck = $RefreshChangesCheck & "SRPTransparentEnabled" & @LF
Else
    MsgBox($MB_SYSTEMMODAL, "ALERT", "The SRP TransparentEnabled value in the Registry is unusual." & @CRLF & "Please consider reinstalation of SRP!")
EndIf
ShowRegistryTweaks()

EndFunc


Func HideRunAsAdmin()

Local $RegDataNew
$keyname = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$valuename = "HideRunAsVerb"
select
   case RegRead ( $keyname, $valuename ) = 1
      $RegDataNew = 0
   case else
      $RegDataNew = 1
EndSelect
;%SystemRoot% folder should be whitelisted when RunAsAdmin is hided.
If not (RegRead('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\262144\Paths\{F38BF404-1D43-42F2-9305-67DE0B28FC23}', 'ItemData') ='%SystemRoot%' or  $RegDataNew = 0) Then
RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\262144\Paths\{F38BF404-1D43-42F2-9305-67DE0B28FC23}', 'ItemData','REG_EXPAND_SZ','%SystemRoot%')
EndIf
RegWrite($keyname, $valuename,'REG_DWORD',  $RegDataNew)
;MsgBox(262144,"","You have to log out and log in again to save changes.")
;Delete the Switch OFF/ON Restrictions backup
RegDelete($BackupSwitchRestrictions)
ShowRegistryTweaks()
RefreshChangesCheck("HideRunAsAdmin")

EndFunc

Func RunAsSmartScreen1()
 RunAsSmartScreen()
;Delete the Switch OFF/ON Restrictions backup
 RegDelete($BackupSwitchRestrictions)
 ShowRegistryTweaks()
EndFunc


Func RunAsSmartScreen()
If $GreyRunAsSmartScreen = 1 Then Return
Local $keyname1 = 'HKCR\*\shell\Run As SmartScreen\command'
Local $keyname2 = 'HKCR\*\shell\Run By SmartScreen\command'
Local $keynameIcon1 = 'HKCR\*\shell\Run As SmartScreen'
Local $keynameIcon2 = 'HKCR\*\shell\Run By SmartScreen'
Local $valueIcon
Local $value

; If "Standard User" or nonstandard then switch to "OFF"
RegDelete('HKEY_CLASSES_ROOT\*\shell\Run As SmartScreen')
RegDelete('HKEY_CLASSES_ROOT\*\shell\Run By SmartScreen')
REMOVE_WSH_FROM_ExplorerContextMenu()
REMOVE_URL_FROM_ExplorerContextMenu()
REMOVE_PIF_FROM_ExplorerContextMenu()
REMOVE_apprefms_FROM_ExplorerContextMenu()
REMOVE_WEBSITE_FROM_ExplorerContextMenu()

Local $valuename = ""

; Switch to "Administrator"
If $RunAsSmartScreen = "OFF" Then
    If @OSArch="X64" Then
       $value = @WindowsDir & '\Hard_Configurator\RunAsSmartscreen(x64).exe "%1" %*'
       $valueIcon = @WindowsDir & '\Hard_Configurator\RunAsSmartscreen(x64).exe'
    EndIf
    If @OSArch="X86" Then
       $value = @WindowsDir & '\Hard_Configurator\RunAsSmartscreen(x86).exe "%1" %*'
       $valueIcon = @WindowsDir & '\Hard_Configurator\RunAsSmartscreen(x86).exe'
    EndIf
    RegWrite($keynameIcon1, 'Icon','REG_SZ',$valueIcon)
    RegWrite($keyname1, '','REG_SZ',$value)
EndIf
; Switch to "Standard User"
If $RunAsSmartScreen = "Administrator" Then
    If @OSArch="X64" Then
       $value = @WindowsDir & '\Hard_Configurator\RunBySmartscreen(x64).exe "%1" %*'
       $valueIcon = @WindowsDir & '\Hard_Configurator\RunBySmartscreen(x64).exe'
    EndIf
    If @OSArch="X86" Then
       $value = @WindowsDir & '\Hard_Configurator\RunBySmartscreen(x86).exe "%1" %*'
       $valueIcon = @WindowsDir & '\Hard_Configurator\RunBySmartscreen(x86).exe'
    EndIf
    RegWrite($keynameIcon2, 'Icon','REG_SZ',$valueIcon)
    RegWrite($keyname2, '','REG_SZ',$value)
; Adding shortcuts
    ADD_WSH_TO_ExplorerContextMenu()
    ADD_URL_TO_ExplorerContextMenu()
    ADD_PIF_TO_ExplorerContextMenu()
    ADD_apprefms_TO_ExplorerContextMenu()
    REMOVE_URL_FROM_ExplorerContextMenu()
    ADD_URL_TO_ExplorerContextMenu()
    ADD_WEBSITE_TO_ExplorerContextMenu()
EndIf

EndFunc


Func WhitelistByHash()

#include <Array.au3>
#Include <File.au3>
#include <FileConstants.au3>
;#include <Crypt.au3>
#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <StringConstants.au3>

If $isSRPinstalled = "Installed" Then
   AddRemoveHash()

Else
   MsgBox(262144,"","Software Restriction Policies were not installed yet.")
EndIf

EndFunc



Func WhitelistByPath()
#include <Array.au3>
#Include <File.au3>
#include <FileConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
If $isSRPinstalled = "Installed" Then
   AddRemovePath()

Else
   MsgBox(262144,"","Software Restriction Policies were not installed yet.")
EndIf

EndFunc


Func NoRemovableDisksExecution()
Local $RegDataNew
Local $keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}'
Local $valuename = 'Deny_Execute'
Local $NoRemovableDisksExec = RegRead ( $keyname, $valuename )
select
   case $NoRemovableDisksExec = 1
      $RegDataNew = 0
   case else
      $RegDataNew = 1
EndSelect
RegWrite($keyname , $valuename,'REG_DWORD',  $RegDataNew)
;MsgBox(262144,"","You have to unplug removable storage devices, and plug again to make this option work.")

;Delete the Switch OFF/ON Restrictions backup
RegDelete($BackupSwitchRestrictions)

ShowRegistryTweaks()
RefreshChangesCheck("NoRemovableDisksExecution")

EndFunc


Func NoPowerShellExecution()
Local $RegDataNew
Local $keyname = 'HKLM\Software\Policies\Microsoft\Windows\PowerShell'
Local $valuename = 'EnableScripts'
Local $NoPowerShellExec = RegRead ( $keyname, $valuename )
select
   case $NoPowerShellExec = 0
      $RegDataNew = 1
   case else
      $RegDataNew = 0
EndSelect
RegWrite($keyname , $valuename,'REG_DWORD',  $RegDataNew)

;Delete the Switch OFF/ON Restrictions backup
RegDelete($BackupSwitchRestrictions)

ShowRegistryTweaks()

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
               RegWrite($key & '\0\Paths\{A4BFCC3A-DB2C-424C-B029-7FE99A87C641}', 'Description','REG_SZ','*LNK : Desktop')
               RegWrite($key & '\0\Paths\{A4BFCC3A-DB2C-424C-B029-7FE99A87C641}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\0\Paths\{A4BFCC3A-DB2C-424C-B029-7FE99A87C641}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%' & '\Desktop\*.lnk\*')
               RegWrite($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C642}', 'Description','REG_SZ','*LNK : Desktop subfolders')
               RegWrite($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C642}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C642}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%' & '\Desktop\*\*.lnk')
               RegWrite($key & '\0\Paths\{A4BFCC3A-DB2C-424C-B029-7FE99A87C642}', 'Description','REG_SZ','*LNK : Desktop subfolders')
               RegWrite($key & '\0\Paths\{A4BFCC3A-DB2C-424C-B029-7FE99A87C642}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\0\Paths\{A4BFCC3A-DB2C-424C-B029-7FE99A87C642}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%' & '\Desktop\*\*.lnk\*')
               RegWrite($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C643}', 'Description','REG_SZ','*LNK : Public Desktop')
               RegWrite($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C643}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C643}', 'ItemData','REG_EXPAND_SZ',@DesktopCommonDir & '\*.lnk')
               RegWrite($key & '\0\Paths\{A4BFCC3A-DB2C-424C-B029-7FE99A87C643}', 'Description','REG_SZ','*LNK : Public Desktop')
               RegWrite($key & '\0\Paths\{A4BFCC3A-DB2C-424C-B029-7FE99A87C643}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\0\Paths\{A4BFCC3A-DB2C-424C-B029-7FE99A87C643}', 'ItemData','REG_EXPAND_SZ',@DesktopCommonDir & '\*.lnk\*')
               RegWrite($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C644}', 'Description','REG_SZ','*LNK : TaskBar (AppData\Roaming)')
               RegWrite($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C644}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C644}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%\AppData\Roaming' & '\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*.lnk')
               RegWrite($key & '\0\Paths\{A4BFCC3A-DB2C-424C-B029-7FE99A87C644}', 'Description','REG_SZ','*LNK : TaskBar (AppData\Roaming)')
               RegWrite($key & '\0\Paths\{A4BFCC3A-DB2C-424C-B029-7FE99A87C644}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\0\Paths\{A4BFCC3A-DB2C-424C-B029-7FE99A87C644}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%\AppData\Roaming' & '\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*.lnk\*')
               RegWrite($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C645}', 'Description','REG_SZ','*LNK : Quick Launch (AppData\Roaming)')
               RegWrite($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C645}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C645}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%\AppData\Roaming' & '\Microsoft\Internet Explorer\Quick Launch\*.lnk')
               RegWrite($key & '\0\Paths\{A4BFCC3A-DB2C-424C-B029-7FE99A87C645}', 'Description','REG_SZ','*LNK : Quick Launch (AppData\Roaming)')
               RegWrite($key & '\0\Paths\{A4BFCC3A-DB2C-424C-B029-7FE99A87C645}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\0\Paths\{A4BFCC3A-DB2C-424C-B029-7FE99A87C645}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%\AppData\Roaming' & '\Microsoft\Internet Explorer\Quick Launch\*.lnk\*')

               If (@OSVersion="WIN_10" or  @OSVersion="WIN_81" or @OSVersion="WIN_8") then
                  RegWrite($key & '\262144\Paths\{99a0fd77-ed0c-4e30-91ff-9d51428d2f21}', 'Description','REG_SZ','*LNK : Power menu group 1')
                  RegWrite($key & '\262144\Paths\{99a0fd77-ed0c-4e30-91ff-9d51428d2f21}', 'SaferFlags','REG_DWORD',Number('0'))
                  RegWrite($key & '\262144\Paths\{99a0fd77-ed0c-4e30-91ff-9d51428d2f21}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%\AppData\Local' & '\Microsoft\Windows\WinX\Group1\*.lnk')
                  RegWrite($key & '\0\Paths\{89a0fd77-ed0c-4e30-91ff-9d51428d2f21}', 'Description','REG_SZ','*LNK : Power menu group 1')
                  RegWrite($key & '\0\Paths\{89a0fd77-ed0c-4e30-91ff-9d51428d2f21}', 'SaferFlags','REG_DWORD',Number('0'))
                  RegWrite($key & '\0\Paths\{89a0fd77-ed0c-4e30-91ff-9d51428d2f21}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%\AppData\Local' & '\Microsoft\Windows\WinX\Group1\*.lnk\*')
                  RegWrite($key & '\262144\Paths\{99a0fd77-ed0c-4e30-91ff-9d51428d2f22}', 'Description','REG_SZ','*LNK : Power menu group 2')
                  RegWrite($key & '\262144\Paths\{99a0fd77-ed0c-4e30-91ff-9d51428d2f22}', 'SaferFlags','REG_DWORD',Number('0'))
                  RegWrite($key & '\262144\Paths\{99a0fd77-ed0c-4e30-91ff-9d51428d2f22}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%\AppData\Local' & '\Microsoft\Windows\WinX\Group2\*.lnk')
                  RegWrite($key & '\0\Paths\{89a0fd77-ed0c-4e30-91ff-9d51428d2f22}', 'Description','REG_SZ','*LNK : Power menu group 2')
                  RegWrite($key & '\0\Paths\{89a0fd77-ed0c-4e30-91ff-9d51428d2f22}', 'SaferFlags','REG_DWORD',Number('0'))
                  RegWrite($key & '\0\Paths\{89a0fd77-ed0c-4e30-91ff-9d51428d2f22}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%\AppData\Local' & '\Microsoft\Windows\WinX\Group2\*.lnk\*')
                  RegWrite($key & '\262144\Paths\{99a0fd77-ed0c-4e30-91ff-9d51428d2f23}', 'Description','REG_SZ','*LNK : Power menu group 3')
                  RegWrite($key & '\262144\Paths\{99a0fd77-ed0c-4e30-91ff-9d51428d2f23}', 'SaferFlags','REG_DWORD',Number('0'))
                  RegWrite($key & '\262144\Paths\{99a0fd77-ed0c-4e30-91ff-9d51428d2f23}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%\AppData\Local' & '\Microsoft\Windows\WinX\Group3\*.lnk')
                  RegWrite($key & '\0\Paths\{89a0fd77-ed0c-4e30-91ff-9d51428d2f23}', 'Description','REG_SZ','*LNK : Power menu group 3')
                  RegWrite($key & '\0\Paths\{89a0fd77-ed0c-4e30-91ff-9d51428d2f23}', 'SaferFlags','REG_DWORD',Number('0'))
                  RegWrite($key & '\0\Paths\{89a0fd77-ed0c-4e30-91ff-9d51428d2f23}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%\AppData\Local' & '\Microsoft\Windows\WinX\Group3\*.lnk\*')
               EndIf

               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC19}', 'Description','REG_SZ','*LNK : Start menu (AppData\Roaming)')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC19}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC19}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu' & '\*.lnk')
               RegWrite($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC19}', 'Description','REG_SZ','*LNK : Start menu (AppData\Roaming)')
               RegWrite($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC19}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC19}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu' & '\*.lnk\*')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC20}', 'Description','REG_SZ','*LNK : Start menu programs (AppData\Roaming)')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC20}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC20}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu' & '\Programs\*.lnk')
               RegWrite($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC20}', 'Description','REG_SZ','*LNK : Start menu programs (AppData\Roaming)')
               RegWrite($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC20}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC20}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu' & '\Programs\*.lnk\*')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC21}', 'Description','REG_SZ','*LNK : Start menu programs subfolders (AppData\Roaming)')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC21}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC21}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu' & '\Programs\*\*.lnk')
               RegWrite($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC21}', 'Description','REG_SZ','*LNK : Start menu programs subfolders (AppData\Roaming)')
               RegWrite($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC21}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC21}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu' & '\Programs\*\*.lnk\*')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC22}', 'Description','REG_SZ','*LNK : Start menu')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC22}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC22}', 'ItemData','REG_SZ',$systemdrive & '\ProgramData\Microsoft\Windows\Start Menu\*.lnk')
               RegWrite($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC22}', 'Description','REG_SZ','*LNK : Start menu')
               RegWrite($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC22}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC22}', 'ItemData','REG_SZ',$systemdrive & '\ProgramData\Microsoft\Windows\Start Menu\*.lnk\*')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC23}', 'Description','REG_SZ','*LNK : Start menu programs')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC23}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC23}', 'ItemData','REG_SZ',$systemdrive & '\ProgramData\Microsoft\Windows\Start Menu\Programs\*.lnk')
               RegWrite($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC23}', 'Description','REG_SZ','*LNK : Start menu programs')
               RegWrite($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC23}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC23}', 'ItemData','REG_SZ',$systemdrive & '\ProgramData\Microsoft\Windows\Start Menu\Programs\*.lnk\*')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC24}', 'Description','REG_SZ','*LNK : Start menu programs subfolders')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC24}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC24}', 'ItemData','REG_SZ',$systemdrive & '\ProgramData\Microsoft\Windows\Start Menu\Programs\*\*.lnk')
               RegWrite($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC24}', 'Description','REG_SZ','*LNK : Start menu programs subfolders')
               RegWrite($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC24}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC24}', 'ItemData','REG_SZ',$systemdrive & '\ProgramData\Microsoft\Windows\Start Menu\Programs\*\*.lnk\*')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC25}', 'Description','REG_SZ','*LNK : Start menu programs sub-subfolders')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC25}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC25}', 'ItemData','REG_SZ',$systemdrive & '\ProgramData\Microsoft\Windows\Start Menu\Programs\*\*\*.lnk')
               RegWrite($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC25}', 'Description','REG_SZ','*LNK : Start menu programs sub-subfolders')
               RegWrite($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC25}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC25}', 'ItemData','REG_SZ',$systemdrive & '\ProgramData\Microsoft\Windows\Start Menu\Programs\*\*\*.lnk\*')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC26}', 'Description','REG_SZ','*LNK : Start menu programs sub-subfolders (AppData\Roaming)')
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC26}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC26}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu' & '\Programs\*\*\*.lnk')
               RegWrite($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC26}', 'Description','REG_SZ','*LNK : Start menu programs sub-subfolders (AppData\Roaming)')
               RegWrite($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC26}', 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC26}', 'ItemData','REG_EXPAND_SZ','%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu' & '\Programs\*\*\*.lnk\*')
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
   RegDelete($key & '\0\Paths\{A4BFCC3A-DB2C-424C-B029-7FE99A87C641}')
   RegDelete($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C642}')
   RegDelete($key & '\0\Paths\{A4BFCC3A-DB2C-424C-B029-7FE99A87C642}')
   RegDelete($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C643}')
   RegDelete($key & '\0\Paths\{A4BFCC3A-DB2C-424C-B029-7FE99A87C643}')
   RegDelete($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C644}')
   RegDelete($key & '\0\Paths\{A4BFCC3A-DB2C-424C-B029-7FE99A87C644}')
   RegDelete($key & '\262144\Paths\{B4BFCC3A-DB2C-424C-B029-7FE99A87C645}')
   RegDelete($key & '\0\Paths\{A4BFCC3A-DB2C-424C-B029-7FE99A87C645}')
   RegDelete($key & '\262144\Paths\{99a0fd77-ed0c-4e30-91ff-9d51428d2f21}')
   RegDelete($key & '\0\Paths\{89a0fd77-ed0c-4e30-91ff-9d51428d2f21}')
   RegDelete($key & '\262144\Paths\{99a0fd77-ed0c-4e30-91ff-9d51428d2f22}')
   RegDelete($key & '\0\Paths\{89a0fd77-ed0c-4e30-91ff-9d51428d2f22}')
   RegDelete($key & '\262144\Paths\{99a0fd77-ed0c-4e30-91ff-9d51428d2f23}')
   RegDelete($key & '\0\Paths\{89a0fd77-ed0c-4e30-91ff-9d51428d2f23}')
   RegDelete($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC19}')
   RegDelete($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC19}')
   RegDelete($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC20}')
   RegDelete($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC20}')
   RegDelete($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC21}')
   RegDelete($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC21}')
   RegDelete($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC22}')
   RegDelete($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC22}')
   RegDelete($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC23}')
   RegDelete($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC23}')
   RegDelete($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC24}')
   RegDelete($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC24}')
   RegDelete($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC25}')
   RegDelete($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC25}')
   RegDelete($key & '\262144\Paths\{625B53C3-AB48-4EC1-BA1F-A1EF4146FC26}')
   RegDelete($key & '\0\Paths\{525B53C3-AB48-4EC1-BA1F-A1EF4146FC26}')
EndFunc


Func DisableWSH()
Local $RegDataNew
Local $keyname = 'HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings'
Local $keyname1 = 'HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows Script Host\Settings'

Local $valuename = 'Enabled'
Local $DisableWSH1 = RegRead ($keyname, $valuename)
select
   case $DisableWSH1 = 0
      $RegDataNew = 1
   case else
      $RegDataNew = 0
EndSelect
RegWrite($keyname, $valuename,'REG_DWORD',$RegDataNew)
If @OSArch = "X64" Then RegWrite($keyname1, $valuename,'REG_DWORD',$RegDataNew)
; Poprawka na błąd starszych wersji Hard_Configuratora
If @OSArch = "X86" Then Regdelete($keyname1, $valuename)

;Delete the Switch OFF/ON Restrictions backup
RegDelete($BackupSwitchRestrictions)

ShowRegistryTweaks()

EndFunc


Func DisableUntrustedFonts1()
Local $RegDataNew
Local $keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows NT\MitigationOptions'
Local $valuename = 'MitigationOptions_FontBocking'
If $GreyDisableUntrustedFonts = 0 Then
   Local $DisableUntrustedFonts = RegRead ( $keyname, $valuename )
   select
      case $DisableUntrustedFonts = 1000000000000
         $RegDataNew = 2000000000000
      case $DisableUntrustedFonts = 2000000000000
         $RegDataNew = 3000000000000
      case else
         $RegDataNew = 1000000000000
   EndSelect
   RegWrite($keyname, $valuename,'REG_SZ',$RegDataNew)
;  Delete the Switch OFF/ON Restrictions backup
   RegDelete($BackupSwitchRestrictions)
Else
   RegDelete( $keyname, $valuename )
EndIf
EndFunc


Func DisableUntrustedFonts()
  DisableUntrustedFonts1()
  RefreshMoreRestrictionsGUI()
EndFunc


;Func DefenderAntiPUA()
;Local $RegDataNew
;Local $keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine'
;Local $valuename = 'MpEnablePus'
;Local $_DefenderAntiPUA = RegRead ($keyname, $valuename)
;select
;   case $_DefenderAntiPUA = 1
;      $RegDataNew = 0
;   case else
;      $RegDataNew = 1
;EndSelect
;RegWrite($keyname, $valuename,'REG_DWORD',$RegDataNew)

;;Delete the Switch OFF/ON Restrictions backup
;RegDelete($BackupSwitchRestrictions)

;ShowRegistryTweaks()

;EndFunc


Func BlockRemoteAccess()
;Zatrzymanie serwisu Remote Registry.
Run("net stop RemoteRegistry",@SystemDir,@SW_HIDE)
; Wartości kluczy rejestru
Local $keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
Local $keyRemoteShell = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service\WinRS'
Local $keyRemoteRegistry = 'HKLM\SYSTEM\CurrentControlSet\Services\RemoteRegistry'
Local $valuename = 'fAllowUnsolicited'
Local $valuename1 = 'fAllowToGetHelp'
Local $valuename2 = 'fDenyTSConnections'
$valRemoteShell = 'AllowRemoteShellAccess'
$valRemoteRegistry = 'Start'
select
    case $BlockRemoteAccess = "ON"
           RegDelete($keyname, $valuename)
           RegDelete($keyname, $valuename1)
           RegDelete($keyname, $valuename2)
           RegDelete($keyRemoteShell, $valRemoteShell)
           RegWrite($keyRemoteRegistry, $valRemoteRegistry,'REG_DWORD',Number('4'))
           If (@OSVersion="WIN_7" or @OSVersion="WIN_VISTA") Then
              RegWrite($keyRemoteRegistry, $valRemoteRegistry,'REG_DWORD',Number('3'))
            EndIf
    case else
           RegWrite($keyname, $valuename,'REG_DWORD',Number('0'))
           RegWrite($keyname, $valuename1,'REG_DWORD',Number('0'))
           RegWrite($keyname, $valuename2,'REG_DWORD',Number('1'))
           RegWrite($keyRemoteShell, $valRemoteShell,'REG_DWORD',Number('0'))
           RegWrite($keyRemoteRegistry, $valRemoteRegistry,'REG_DWORD',Number('4'))
EndSelect

;Delete the Switch OFF/ON Restrictions backup
RegDelete($BackupSwitchRestrictions)
;;;$RefreshChangesCheck = $RefreshChangesCheck & "RemoteRegistry" & @LF
ShowRegistryTweaks()

EndFunc


Func TurnOFFAllSRP()

Local $key = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers'
Local $backkey = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers'
;Local $x = RegRead($key, 'DefaultLevel')
;Local $y = RegRead($key, 'TransparentEnabled')

; Set the state of SRP. If TurnOFFAllSRP reg value is 0 then SRP are activated.
;If ($x ='262144' OR  $x ='131072' OR  $x ='0') Then RegWrite($backkey, 'TurnOFFAllSRP', 'REG_SZ', '0')
;If ($y ='0' OR  $y ='1' OR  $y ='2') Then RegWrite($backkey, 'TurnOFFAllSRP', 'REG_SZ', '0')
;If ($x = '262144'  And $y ='0' ) Then  RegWrite($backkey, 'TurnOFFAllSRP', 'REG_SZ', '1')
;MsgBox(262144,'', $x & '    ' & $y)

Local $TurnOFFAllSRP = RegRead($backkey, 'TurnOFFAllSRP')
If $isSRPinstalled = "Installed" Then
   If $TurnOFFAllSRP = '0' Then
;     Backup the values of DefaultLevel and TransparentEnabled
      RegWrite($backkey, 'DefaultLevel', 'REG_DWORD', RegRead($key, 'DefaultLevel'))
      RegWrite($backkey, 'TransparentEnabled', 'REG_DWORD', RegRead($key, 'TransparentEnabled'))
;     Deactivate SRP (except scripts with Disallowed rules!!! Hard_Configurator does not use Disallowed script rules.)
      RegWrite($key, 'DefaultLevel','REG_DWORD', Number('262144'))
      RegWrite($key, 'TransparentEnabled','REG_DWORD',Number('0'))
;     Change the state of SRP to not activated.
      RegWrite($backkey, 'TurnOFFAllSRP', 'REG_SZ', '1')
;      $BtnTurnOFFAllSRP = _GUICtrlButton_Create($listGUI, "Activate SRP", 120+$DeltaX, $DeltaY+277, 140, 25)
;      GUICtrlSetBkColor(-1, 0x00f000)
      MsgBox(262144,'','Software Restriction Policies are going to be deactivated.')
   Else
;     Restore the last values of DefaultLevel and TransparentEnabled
      RegWrite($key, 'DefaultLevel', 'REG_DWORD', RegRead($backkey, 'DefaultLevel'))
      RegWrite($key, 'TransparentEnabled', 'REG_DWORD', RegRead($backkey, 'TransparentEnabled'))
;     Change the state of SRP to activated.
      RegWrite($backkey, 'TurnOFFAllSRP', 'REG_SZ', '0')
;      $BtnTurnOFFAllSRP = _GUICtrlButton_Create($listGUI, "Deactivate SRP", 120+$DeltaX, $DeltaY+277, 140, 25)
;      GUICtrlSetBkColor(-1, 0x00f000)
      MsgBox(262144,'','Software Restriction Policies are going to be activated.')
   EndIf
   $RefreshChangesCheck = $RefreshChangesCheck & "SRPTransparentEnabled" & @LF
EndIf

ShowRegistryTweaks()

EndFunc



Func TurnOFFAllRestrictions()

; This function changed its purpose to Switch OFF/ON Restrictions

Local $reg
Local $reg1
Local $DestinationRestrictionKey

; Restore Registry keys from the temporary backup if restrictions are switched off
If _RegKeyExists($BackupSwitchRestrictions) = 1 Then
;   MsgBox(262144,"", _RegKeyExists($BackupSwitchRestrictions))

;;  No Removable Disk Execution
;   $reg = RegRead($BackupSwitchRestrictions, 'Deny_Execute')
;   If not ($reg = 0) Then RefreshChangesCheck("NoRemovableDisksExecution")
;   $DestinationRestrictionKey = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}'
;   RegWrite($DestinationRestrictionKey, 'Deny_Execute','REG_DWORD', $reg)

;  No PowerShell Execution
   $reg = RegRead($BackupSwitchRestrictions, 'EnableScripts')
   $DestinationRestrictionKey = 'HKLM\Software\Policies\Microsoft\Windows\PowerShell'
   RegWrite($DestinationRestrictionKey, 'EnableScripts', 'REG_DWORD', $reg)

; Defender PUA Protection
;   $reg = RegRead($BackupSwitchRestrictions, 'MpEnablePus')
;   $DestinationRestrictionKey = 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine'
;   RegWrite($DestinationRestrictionKey,  'MpEnablePus', 'REG_DWORD', $reg)

;;  Disable Untrusted Fonts
;   $reg = RegRead($BackupSwitchRestrictions, 'MitigationOptions_FontBocking')
;   $DestinationRestrictionKey = 'HKLM\SOFTWARE\Policies\Microsoft\Windows NT\MitigationOptions'
;   RegWrite($DestinationRestrictionKey, 'MitigationOptions_FontBocking', 'REG_SZ', $reg)

;  Documents Anti-Exploit
If $GreySystemWideDocumentsAntiExploit = 0 Then
   $reg = RegRead($BackupSwitchRestrictions, 'SystemWideDocumentsAntiExploit')
;   MsgBox(0, "", $reg)
   If @error = 0 Then
      If not ($reg = CheckSystemWideDocumentsAntiExploit()) Then SystemWideDocumentsAntiExploit1($reg)
   EndIf
EndIf

;  Disable Windows Script Host
   $reg = RegRead($BackupSwitchRestrictions, 'WSHEnabled')
   $DestinationRestrictionKey = 'HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings'
   RegWrite($DestinationRestrictionKey, 'Enabled', 'REG_DWORD', $reg)
   If @OSArch = "X64" Then
      $reg = RegRead($BackupSwitchRestrictions, 'WSHEnabledWOW')
      $DestinationRestrictionKey = 'HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows Script Host\Settings'
      RegWrite($DestinationRestrictionKey, 'Enabled', 'REG_DWORD', $reg)
   EndIf
;  Disable Hide Run As Administrator
   $reg = RegRead($BackupSwitchRestrictions, 'HideRunAsVerb')
   If not ($reg = 0) Then RefreshChangesCheck("HideRunAsAdmin")
   $DestinationRestrictionKey = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'
   RegWrite($DestinationRestrictionKey, 'HideRunAsVerb','REG_DWORD', $reg)

;  Run As SmartScreen
   $reg = RegRead($BackupSwitchRestrictions, 'RunAsSmartScreen') & RegRead($BackupSwitchRestrictions, 'RunBySmartScreen')
;   $DestinationRestrictionKey = 'HKCR\*\shell\Run As SmartScreen\command'
   Select
	case StringInStr($reg, 'RunAsSmartscreen') > 0
	   $RunAsSmartScreen = "OFF"
	   RunAsSmartScreen()
	   $RunAsSmartScreen = "Administrator"
	case StringInStr($reg, 'RunBySmartscreen') > 0
	   $RunAsSmartScreen = "Administrator"
	   RunAsSmartScreen()
	   $RunAsSmartScreen = "Standard User"
	case Else
	   $RunAsSmartScreen = "Standard User"
	   RunAsSmartScreen()
	   $RunAsSmartScreen = "OFF"
    EndSelect
;MsgBox(0,"","")
;   REMOVE_WSH_FROM_ExplorerContextMenu()
;   REMOVE_URL_FROM_ExplorerContextMenu()
;   REMOVE_PIF_FROM_ExplorerContextMenu()
;   REMOVE_apprefms_FROM_ExplorerContextMenu()
;   $reg = RegRead($BackupSwitchRestrictions, 'RunAsSmartScreen')
;   $DestinationRestrictionKey = 'HKCR\*\shell\Run As SmartScreen\command'
;   If not ($reg = '') Then
;      RegWrite($DestinationRestrictionKey, '', 'REG_SZ', $reg)
;   EndIf
;   $reg = RegRead($BackupSwitchRestrictions, 'RunBySmartScreen')
;   $DestinationRestrictionKey = 'HKCR\*\shell\Run By SmartScreen\command'
;   If not ($reg = '') Then
;      RegWrite($DestinationRestrictionKey, '', 'REG_SZ', $reg)
;      ADD_WSH_TO_ExplorerContextMenu()
;      ADD_URL_TO_ExplorerContextMenu()
;      ADD_PIF_TO_ExplorerContextMenu()
;      ADD_apprefms_TO_ExplorerContextMenu()
;   EndIf

; Remote Access
   $reg = RegRead($BackupSwitchRestrictions, 'AllowRemoteShellAccess')
   $DestinationRestrictionKey = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service\WinRS'
   RegWrite($DestinationRestrictionKey, 'AllowRemoteShellAccess', 'REG_DWORD', $reg)
   $DestinationRestrictionKey = 'HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
   $reg = RegRead($BackupSwitchRestrictions, 'fAllowToGetHelp')
   RegWrite($DestinationRestrictionKey, 'fAllowToGetHelp','REG_DWORD', $reg)
   $reg = RegRead($BackupSwitchRestrictions, 'fAllowUnsolicited')
   RegWrite($DestinationRestrictionKey, 'fAllowUnsolicited','REG_DWORD', $reg)
   $reg = RegRead($BackupSwitchRestrictions, 'fDenyTSConnections')
   RegWrite($DestinationRestrictionKey, 'fDenyTSConnections','REG_DWORD', $reg)
   $DestinationRestrictionKey = 'HKLM\SYSTEM\CurrentControlSet\Services\RemoteRegistry'
   $reg = RegRead($BackupSwitchRestrictions, 'Start')
   RegWrite($DestinationRestrictionKey, 'Start', 'REG_DWORD', $reg)

;  Disable 16-bits
   $reg = RegRead($BackupSwitchRestrictions, 'VDMDisallowed')
   $DestinationRestrictionKey = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat'
   RegWrite($DestinationRestrictionKey, 'VDMDisallowed', 'REG_DWORD', $reg)

; Shell Extension Security
   $reg = RegRead($BackupSwitchRestrictions, 'EnforceShellExtensionSecurity')
   $DestinationRestrictionKey = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'
   RegWrite($DestinationRestrictionKey, 'EnforceShellExtensionSecurity', 'REG_DWORD', $reg)

;  MSI Elevation
   $reg = RegRead($BackupSwitchRestrictions, 'MSIElevation')
   $DestinationRestrictionKey = 'HKCR\Msi.Package\shell\runas\command'
   If Not ($reg = '') Then
      RegWrite($DestinationRestrictionKey, '', 'REG_EXPAND_SZ', $reg)
   EndIf

;  Disable Elevation on SUA
   $reg = RegRead($BackupSwitchRestrictions, 'ConsentPromptBehaviorUser')
   $DestinationRestrictionKey = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
   RegWrite($DestinationRestrictionKey, 'ConsentPromptBehaviorUser', 'REG_DWORD', $reg)

; Disable SMB
  $reg = RegRead($BackupSwitchRestrictions, 'DisableSMB1_Start')
  $DestinationRestrictionKey = 'HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb10'
  If CorrectSMB10Uninstalled() = 0 Then RegWrite($DestinationRestrictionKey, 'Start', 'REG_DWORD', $reg)
  $reg = RegRead($BackupSwitchRestrictions, 'DisableSMB2_Start')
  $DestinationRestrictionKey = 'HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb20'
  RegWrite($DestinationRestrictionKey, 'Start', 'REG_DWORD', $reg)
  $reg = RegRead($BackupSwitchRestrictions, 'DependOnService')
  $DestinationRestrictionKey = 'HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation'
  RegWrite($DestinationRestrictionKey, 'DependOnService', 'REG_MULTI_SZ', $reg)
  $reg = RegRead($BackupSwitchRestrictions, 'DisableSMB1')
  $DestinationRestrictionKey = 'HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters'
  RegWrite($DestinationRestrictionKey, 'SMB1', 'REG_DWORD', $reg)
  $reg = RegRead($BackupSwitchRestrictions, 'DisableSMB2')
  RegWrite($DestinationRestrictionKey, 'SMB2', 'REG_DWORD', $reg)

; Disable Cached Logons
  $reg = RegRead($BackupSwitchRestrictions, 'CachedLogonsCount')
  $DestinationRestrictionKey = 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'
  RegWrite($DestinationRestrictionKey, 'CachedLogonsCount', 'REG_SZ', $reg)

; UAC CTRL_ALT_DEL
  $reg = RegRead($BackupSwitchRestrictions, 'EnableSecureCredentialPrompting')
  $DestinationRestrictionKey = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\CredUI'
  RegWrite($DestinationRestrictionKey, 'EnableSecureCredentialPrompting', 'REG_DWORD', $reg)

;  Delete the Switch OFF/ON Restrictions backup
   RegDelete($BackupSwitchRestrictions)

   ShowRegistryTweaks()

   Return
EndIf

; Make the backup and Turn OFF Restrictions

;If $GreyDefenderAntiPUA = 0 Then
;    $key = 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine'
;    $reg = Regread($key, 'MpEnablePus')
;    RegWrite($BackupSwitchRestrictions, 'MpEnablePus','REG_DWORD', $reg)
;    RegWrite ($key , 'MpEnablePus','REG_DWORD',Number('0'))
;EndIf

; Make the backup and Turn OFF Restrictions

;If $GreyDisableUntrustedFonts = 0 Then
;     $key = 'HKLM\SOFTWARE\Policies\Microsoft\Windows NT\MitigationOptions'
;     $reg = Regread($key, 'MitigationOptions_FontBocking')
;     RegWrite($BackupSwitchRestrictions, 'MitigationOptions_FontBocking', 'REG_SZ', $reg)
;     RegWrite ($key , 'MitigationOptions_FontBocking','REG_SZ','2000000000000')
;EndIf

;;If $GreyNoRemovableDisksExecution = 0 Then
;     $key = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}'
;     $reg = Regread($key, 'Deny_Execute')
;     If not ($reg = 0) Then RefreshChangesCheck("NoRemovableDisksExecution")
;     RegWrite($BackupSwitchRestrictions, 'Deny_Execute','REG_DWORD', $reg)
;     RegWrite ($key , 'Deny_Execute','REG_DWORD',Number('0'))
;EndIf


If $GreySystemWideDocumentsAntiExploit = 0 Then
    $reg = CheckSystemWideDocumentsAntiExploit()
    If $reg = 'Partial' then MsgBox(262144,"","The setting <Documents Anti-Exploit> = 'Partial' cannot be switched.")
    If $reg = '?' then MsgBox(262144,"","The setting <Documents Anti-Exploit> = '?' cannot be switched.")    
    If ($reg = 'Adobe + VBA' Or $reg = 'OFF' Or $reg = 'Adobe') Then
       RegWrite($BackupSwitchRestrictions, 'SystemWideDocumentsAntiExploit','REG_SZ', $reg)
       If not ($reg = 'OFF') Then SystemWideDocumentsAntiExploit1("OFF")
    EndIf
EndIf


If $GreyNoPowerShellExecution = 0 Then
     $key = 'HKLM\Software\Policies\Microsoft\Windows\PowerShell'
     $reg = Regread($key, 'EnableScripts')
     If $NoPowerShellExecution = "OFF" Then $reg = 1
     RegWrite($BackupSwitchRestrictions, 'EnableScripts','REG_DWORD', $reg)
     RegWrite ($key, 'EnableScripts','REG_DWORD',Number('1'))
EndIf

;RegWrite ( 'HKCU\Software\Policies\Microsoft\Windows\System', 'DisableCMD','REG_DWORD',Number('0'))
;RegWrite($BackupSwitchRestrictions, 'DisableCMD','REG_DWORD', Number('0'))

; Disable Windows Script Host
$key = 'HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings'
$reg = Regread($key, 'Enabled')
If $DisableWSH = "OFF" Then $reg = 1
RegWrite($BackupSwitchRestrictions, 'WSHEnabled', 'REG_DWORD', $reg)
RegWrite ($key , 'Enabled','REG_DWORD', Number('1'))
If @OSArch = "X64" Then
   $key = 'HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows Script Host\Settings'
   $reg = Regread($key, 'Enabled')
   If $DisableWSH = "OFF" Then $reg = 1
   RegWrite($BackupSwitchRestrictions, 'WSHEnabledWOW', 'REG_DWORD', $reg)
   RegWrite ($key , 'Enabled','REG_DWORD', Number('1'))
EndIf

; Disable Hide Run As Administrator
$key = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'
$reg = Regread($key, 'HideRunAsVerb')
If not ($reg = 0) Then RefreshChangesCheck("HideRunAsAdmin")
RegWrite($BackupSwitchRestrictions, 'HideRunAsVerb', 'REG_DWORD' , $reg)
RegWrite ($key, 'HideRunAsVerb','REG_DWORD', Number('0'))


;If (@OSVersion="WIN_10" or @OSVersion="WIN_81" or @OSVersion="WIN_8") Then
;   RegDelete ('HKLM\SOFTWARE\Policies\Microsoft\Windows\System', 'EnableSmartScreen')
;EndIf

; Run As SmartScreen
REMOVE_WSH_FROM_ExplorerContextMenu()
REMOVE_URL_FROM_ExplorerContextMenu()
REMOVE_PIF_FROM_ExplorerContextMenu()
REMOVE_apprefms_FROM_ExplorerContextMenu()
$key = 'HKCR\*\shell\Run As SmartScreen'
$reg = Regread($key & '\command', "")
If not ($reg = "") Then
   RegWrite($BackupSwitchRestrictions, 'RunAsSmartScreen', 'REG_SZ', $reg)
EndIf
RegDelete($key)
$key = 'HKCR\*\shell\Run By SmartScreen'
$reg = Regread($key & '\command', "")
If not ($reg = "") Then
   RegWrite($BackupSwitchRestrictions, 'RunBySmartScreen', 'REG_SZ', $reg)
EndIf
RegDelete($key)

; Remote Access
$keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
$keyRemoteShell = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service\WinRS'
$keyRemoteRegistry = 'HKLM\SYSTEM\CurrentControlSet\Services\RemoteRegistry'
$reg = Regread($keyRemoteShell, 'AllowRemoteShellAccess')
RegWrite($BackupSwitchRestrictions, 'AllowRemoteShellAccess', 'REG_DWORD', $reg)
RegDelete($keyRemoteShell, 'AllowRemoteShellAccess')
$reg = Regread($keyname, 'fAllowToGetHelp')
If $BlockRemoteAccess = "OFF" Then $reg = 1
RegWrite($BackupSwitchRestrictions, 'fAllowToGetHelp','REG_DWORD', $reg)
RegDelete($keyname, 'fAllowToGetHelp')
$reg = Regread($keyname, 'fAllowUnsolicited')
If $BlockRemoteAccess = "OFF" Then $reg = 1
RegWrite($BackupSwitchRestrictions, 'fAllowUnsolicited','REG_DWORD', $reg)
RegDelete($keyname, 'fAllowUnsolicited')
$reg = Regread($keyname, 'fDenyTSConnections')
RegWrite($BackupSwitchRestrictions, 'fDenyTSConnections','REG_DWORD', $reg)
RegDelete($keyname, 'fDenyTSConnections')
$reg = Regread($keyRemoteRegistry, 'Start')
RegWrite($BackupSwitchRestrictions, 'Start', 'REG_DWORD', $reg)
RegWrite($keyRemoteRegistry, 'Start','REG_DWORD',Number('4'))
If (@OSVersion="WIN_7" or @OSVersion="WIN_VISTA") Then
   RegWrite($keyRemoteRegistry, 'Start','REG_DWORD',Number('3'))
EndIf
Run("net stop RemoteRegistry",@SystemDir,@SW_HIDE)

; Disable 16-bits
$key = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat'
$reg = Regread($key, 'VDMDisallowed')
RegWrite($BackupSwitchRestrictions, 'VDMDisallowed', 'REG_DWORD', $reg)
RegWrite($key, 'VDMDisallowed', 'REG_DWORD', Number('0'))

; Shell Extension Security
$key = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'
$reg = Regread($key, 'EnforceShellExtensionSecurity')
RegWrite($BackupSwitchRestrictions, 'EnforceShellExtensionSecurity', 'REG_DWORD', $reg)
RegWrite($key, 'EnforceShellExtensionSecurity','REG_DWORD', Number('0'))


;$keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers'
;$BlacklistKeyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers\0\Paths\'
;$valuename = 'IsCMDBlocked'
;$partGUID = '{1016bbe0-a716-428b-822e-5E544B6A310'
;RegDelete($BlacklistKeyname & $partGUID & '2}')
;RegDelete($keyname, $valuename)

; MSI Elevation on Explorer context menu
$key = 'HKCR\Msi.Package\shell\runas\command'
$reg = Regread($key, '')
If Not ($reg = '') Then
   RegWrite($BackupSwitchRestrictions, 'MSIElevation', 'REG_EXPAND_SZ', $reg)
EndIf
RegDelete('HKCR\Msi.Package\shell\runas')

; No Elevation on SUA
$key = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
$reg = Regread($key, 'ConsentPromptBehaviorUser')
RegWrite($BackupSwitchRestrictions, 'ConsentPromptBehaviorUser', 'REG_DWORD', $reg)
RegWrite($key, 'ConsentPromptBehaviorUser','REG_DWORD',Number('3'))

; Disable SMB
$key = 'HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb10'
$reg = RegRead($key, 'Start')
RegWrite($BackupSwitchRestrictions, 'DisableSMB1_Start', 'REG_DWORD', $reg)
;RegWrite($key, 'Start', 'REG_DWORD', Number('2'))
$key = 'HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb20'
$reg = RegRead($key, 'Start')
RegWrite($BackupSwitchRestrictions, 'DisableSMB2_Start', 'REG_DWORD', $reg)
;RegWrite($key, 'Start', 'REG_DWORD', Number('3'))
$key = 'HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation'
$reg = RegRead($key, 'DependOnService')
RegWrite($BackupSwitchRestrictions, 'DependOnService', 'REG_MULTI_SZ', $reg)
;RegWrite($key, 'DependOnService', 'REG_MULTI_SZ',  'Bowser' & @LF & 'MRxSmb10' & @LF & 'MRxSmb20' & @LF & 'NSI')
$key = 'HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters'
$reg = RegRead($key, 'SMB1')
If $DisableSMB = 'OFF' Then $reg = 1
RegWrite($BackupSwitchRestrictions, 'DisableSMB1', 'REG_DWORD', $reg)
$reg = RegRead($key, 'SMB2')
If $DisableSMB = 'OFF' Then $reg = 1
RegWrite($BackupSwitchRestrictions, 'DisableSMB2', 'REG_DWORD', $reg)
; If not OFF then set Registry to get ON123, and change settings to OFF
If not ($DisableSMB = 'OFF') Then
   If CorrectSMB10Uninstalled() = 0 Then
      RegWrite($key, 'SMB1', 'REG_DWORD', Number('0'))
      RegWrite($key, 'SMB2', 'REG_DWORD', Number('0'))
      DisableSMB('1')
   Else
      If $DisableSMB = 'ON123' Then
         RegWrite($key, 'SMB1', 'REG_DWORD', Number('0'))
         RegWrite($key, 'SMB2', 'REG_DWORD', Number('0'))
         DisableSMB('1')
      EndIf
   EndIf
EndIf

; Disable Cached Logons
$key = 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'
$reg = Regread($key, 'CachedLogonsCount')
RegWrite($BackupSwitchRestrictions, 'CachedLogonsCount', 'REG_SZ', $reg)
RegWrite($key, 'CachedLogonsCount','REG_SZ', '10')


; UAC CTRL_ALT_DEL
$key = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\CredUI'
$reg = Regread($key, 'EnableSecureCredentialPrompting')
RegWrite($BackupSwitchRestrictions, 'EnableSecureCredentialPrompting', 'REG_DWORD', $reg)
RegWrite($key, 'EnableSecureCredentialPrompting', 'REG_DWORD', Number('0'))

ShowRegistryTweaks()

EndFunc

Func Recommended_Settings()
  TurnOnAllSRP1()
 $SRPDefaultLevel = "White List"
  TurnOnAllRestrictions1()
  ShowRegistryTweaks()
EndFUnc


Func TurnOnAllSRP()
  TurnOnAllSRP1()
  ShowRegistryTweaks()
EndFunc


Func TurnOnAllSRP1()
; The name of this option is changed to <Recommended SRP>.

; First create backup of SRP Whitelist, delete all SRP keys, delete ...\safer_Hard_Configurator\Codeidentifiers, where are
; stored the BlockSponsors parameters and keys. Next add the installed flag. Then Reinstall SRP, restore the Whitelist from
; the backup, and delete the Whitelist backup.

; Turn off refreshing Windows Explorer
$RefreshExplorer = 0

Local $key = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\'
Local $whitelist = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers\262144'
Local $value
  _RegCopyKey($whitelist, $key & 'Whitelist_Backup')
  RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers')
  RegDelete($key & 'CodeIdentifiers\BlockSponsors')
  SRP()
  _RegCopyKey($key & 'Whitelist_Backup', $whitelist)
  RegDelete($key & 'Whitelist_Backup')

; Add Recommended keys for SRP DefaultLevel and TransparentEnabled values.
  Local $Reg = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers';
  Select
     case (@OSVersion="WIN_10" or @OSVersion="WIN_81" or @OSVersion="WIN_8" or @OSVersion="WIN_7" or @OSVersion="WIN_VISTA")
       RegWrite($Reg, 'DefaultLevel','REG_DWORD',Number('0'))
;     case (@OSVersion="WIN_10" or @OSVersion="WIN_81" or @OSVersion="WIN_8" or @OSVersion="WIN_7")
;       RegWrite($Reg, 'DefaultLevel','REG_DWORD',Number('131072'))
     case Else
       MsgBox(262144,"", "This Windows version is not supported to manage SRP in Hard_Configurator")
  EndSelect
  RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers', 'TransparentEnabled','REG_DWORD',Number('1'))

; Do not allow EXE
RemoveAllowEXE()

; Add Protect Windows Folder and Protect Shortcuts.
  If $GreyWritableSubWindows = 0 Then
     $WritableSubWindows = 'OFF'
     WritableSubWindows('1')
  EndIf
$DenyShortcuts = "OFF"
Deny_Shortcuts('1')

;PowerShell sponsor block
If not (@OSVersion="WIN_10") Then
  _CheckBoxSponsorBlockPowerShell()
  _CheckBoxSponsorBlockPowerShell_ise()
EndIf

;Warning about wrong order of pressed buttons while configuring the recommended settings.
;MsgBox(0,"",$RunAsSmartScreen)
If $RunAsSmartScreen = "Standard User" Then 
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.5)
   Local $x = _ExtMsgBox(64,"&OK|CANCEL", "Recommended SRP", "You probably have pressed first <Recommended Restrictions> and next <Recommended SRP> buttons. This is not recommended, except when you need a completely locked setup." & @crlf & "If you want to configure the recommended settings now, then press OK." & @crlf & "Please, remember to <APPLY CHANGES>.")
   If $x = 1 Then
     $SRPDefaultLevel = "White List"
     TurnOnAllRestrictions()
;     MsgBox(0,"",$x)
   EndIf
EndIf
;Turn ON refreshing Windows Explorer
$RefreshExplorer = 1

EndFunc


Func TurnOnAllRestrictions()
   TurnOnAllRestrictions1()
   ShowRegistryTweaks()
EndFunc


Func TurnOnAllRestrictions1()
Local $keyname
Local $valuename

;Turn on recommended restrictions (there were a change i the functionality, before this function was rurning on all restrictions.
;Turn OFF refreshing Windows Explorer
$RefreshExplorer = 0

;If $GreyDefenderAntiPUA = 0 Then
;    RegWrite ( 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine', 'MpEnablePus','REG_DWORD',Number('1'))
;EndIf

;If (@OSVersion="WIN_10") Then
;   If $GreyDisableUntrustedFonts = 0 Then
;         RegWrite ( 'HKLM\SOFTWARE\Policies\Microsoft\Windows NT\MitigationOptions','MitigationOptions_FontBocking', 'REG_SZ','1000000000000')
;   EndIf
;EndIf


;If $GreyNoRemovableDisksExecution = 0 Then
;     If not (RegRead('HKLM\SOFTWARE\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}', 'Deny_Execute'  ) = '1' ) Then RefreshChangesCheck("NoRemovableDisksExecution")
;     RegWrite ( 'HKLM\SOFTWARE\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}', 'Deny_Execute','REG_DWORD',Number('1'))
;EndIf

If $GreySystemWideDocumentsAntiExploit = 0 Then
    SystemWideDocumentsAntiExploit1("Adobe + VBA")
EndIf


If $GreyNoPowerShellExecution = 0 Then
      RegWrite ( 'HKLM\Software\Policies\Microsoft\Windows\PowerShell', 'EnableScripts','REG_DWORD',Number('0'))
EndIf

If not ($SRPDefaultLevel = "White List") Then
   RegWrite ( 'HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings', 'Enabled','REG_DWORD',Number('0'))
   If @OSArch = "X64" Then
      RegWrite ( 'HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows Script Host\Settings', 'Enabled','REG_DWORD',Number('0'))
   EndIf
Else 
   RegWrite ( 'HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings', 'Enabled','REG_DWORD',Number('1'))
   If @OSArch = "X64" Then
      RegWrite ( 'HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows Script Host\Settings', 'Enabled','REG_DWORD',Number('1'))
   EndIf
EndIf

If (@OSVersion="WIN_10" or @OSVersion="WIN_81" or @OSVersion="WIN_8") Then
   If $GreyRunAsSmartScreen = 1 Then
      RegWrite ('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer', 'SmartScreenEnabled', 'REG_SZ', 'Prompt')
      MsgBox(262144,"",'The SmartScreen Application Reputation was turned ON.')
      $GreyRunAsSmartScreen = 0
   EndIf
EndIf
If $GreyRunAsSmartScreen = 0 Then
   If ($SRPTransparentEnabled = "Skip DLLs" OR $SRPTransparentEnabled = "Include DLLs") Then
      Switch $SRPDefaultLevel
          case "White List"
              RegDelete('HKEY_CLASSES_ROOT\*\shell\Run As SmartScreen')
              RegDelete('HKEY_CLASSES_ROOT\*\shell\Run By SmartScreen')
              $RunAsSmartScreen = "OFF"
              RunAsSmartScreen()
              $RunAsSmartScreen = "Administrator"
          case "Basic User"
              RegDelete('HKEY_CLASSES_ROOT\*\shell\Run As SmartScreen')
              RegDelete('HKEY_CLASSES_ROOT\*\shell\Run By SmartScreen')
              $RunAsSmartScreen = "OFF"
              RunAsSmartScreen()
              $RunAsSmartScreen = "Administrator"
          case else
              RegDelete('HKEY_CLASSES_ROOT\*\shell\Run As SmartScreen')
              RegDelete('HKEY_CLASSES_ROOT\*\shell\Run By SmartScreen')
              $RunAsSmartScreen = "Administrator"
              RunAsSmartScreen()
              $RunAsSmartScreen = "Standard User"
      EndSwitch
   Else
      RegDelete('HKEY_CLASSES_ROOT\*\shell\Run As SmartScreen')
      RegDelete('HKEY_CLASSES_ROOT\*\shell\Run By SmartScreen')
      $RunAsSmartScreen = "Administrator"
      RunAsSmartScreen()
      $RunAsSmartScreen = "Standard User"
   EndIf
EndIf

; Set recommended value to ON if $RunAsSmartScreen = "Administrator"
$keyname = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$valuename = "HideRunAsVerb"
If $RunAsSmartScreen = "Administrator" Then
   RegWrite($keyname, $valuename,'REG_DWORD', Number('1'))
Else
   RegWrite($keyname, $valuename,'REG_DWORD', Number('0'))
EndIf

$keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
Local $keyRemoteShell = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service\WinRS'
Local $keyRemoteRegistry = 'HKLM\SYSTEM\CurrentControlSet\Services\RemoteRegistry'

RegWrite($keyname, 'fAllowUnsolicited','REG_DWORD',Number('0'))
RegWrite($keyname, 'fAllowToGetHelp','REG_DWORD',Number('0'))
RegWrite($keyname, 'fDenyTSConnections','REG_DWORD',Number('1'))
RegWrite($keyRemoteShell, 'AllowRemoteShellAccess','REG_DWORD',Number('0'))
RegWrite($keyRemoteRegistry, 'Start','REG_DWORD',Number('4'))
Run("net stop RemoteRegistry",@SystemDir,@SW_HIDE)
;If not ($BlockRemoteAccess = "ON") Then
;   If StringInStr($RefreshChangesCheck, "RemoteRegistry" & @LF)>0 Then
;      StringReplace($RefreshChangesCheck, "RemoteRegistry" & @LF, "")
;   Else
;      $RefreshChangesCheck = $RefreshChangesCheck & "RemoteRegistry" & @LF
;   EndIf
;EndIf

$keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat'
$valuename = 'VDMDisallowed'
$RegDataNew = 1
RegWrite($keyname, $valuename,'REG_DWORD',$RegDataNew)


$keyname = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'
$valuename = 'EnforceShellExtensionSecurity'
$RegDataNew = 0
RegWrite($keyname, $valuename,'REG_DWORD',$RegDataNew)

;$keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers'
;$BlacklistKeyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers\0\Paths\'
;$valuename = 'IsCMDBlocked'
;$partGUID = '{1016bbe0-a716-428b-822e-5E544B6A310'
;RegDelete($BlacklistKeyname & $partGUID & '2}')
;RegDelete($keyname, $valuename)

$keyname = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
$valuename = 'ConsentPromptBehaviorUser'
$RegDataNew = 3
RegWrite($keyname, $valuename,'REG_DWORD',$RegDataNew)

;$keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers'
;$BlacklistKeyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers\0\Paths\'
;$valuename = 'IsPowerShellBlocked'
;$partGUID = '{1016bbe0-a716-428b-822e-5E544B6A310'
;If (@OSVersion="WIN_10" or @OSVersion="WIN_81" or @OSVersion="WIN_8" or @OSVersion="WIN_7") Then
;   RegDelete($BlacklistKeyname & $partGUID & '0}')
;   RegDelete($BlacklistKeyname & $partGUID & '1}')
;   RegDelete($keyname, $valuename)
;EndIf
;If @OSVersion="WIN_VISTA" Then
;   Local $PowerShell = RegRead ( $keyname, $valuename )
;   If $isSRPinstalled = "Installed" Then
;      RegWrite($BlacklistKeyname & $partGUID & '0}', 'Description','REG_SZ','powershell.exe  (***)  Microsoft Corporation Windows PowerShell')
;      RegWrite($BlacklistKeyname & $partGUID & '0}', 'SaferFlags','REG_DWORD',Number('0'))
;      RegWrite($BlacklistKeyname & $partGUID & '0}', 'ItemData','REG_SZ','powershell.exe')
;      RegWrite($BlacklistKeyname & $partGUID & '1}', 'Description','REG_SZ','powershell_ise.exe  (***)  Microsoft Corporation Windows PowerShell ISE')
;      RegWrite($BlacklistKeyname & $partGUID & '1}', 'SaferFlags','REG_DWORD',Number('0'))
;      RegWrite($BlacklistKeyname & $partGUID & '1}', 'ItemData','REG_SZ','powershell_ise.exe')
;      RegWrite($keyname, $valuename, 'REG_DWORD', Number('1'))
;      If $SRPTransparentEnabled = "No Enforcement" Then
;         MsgBox(262144,"", "Cannot turn on <Block PowerShell Sponsors>, because of <Enforcement> = 'No Enforcement' setting.")
;         RegDelete($BlacklistKeyname & $partGUID & '0}')
;         RegDelete($BlacklistKeyname & $partGUID & '1}')
;         RegDelete($keyname, $valuename)
;      EndIf
;   Else
;      MsgBox(262144,"", "Cannot set <Block PowerShell Sponsors>. Please, use <(Re)Install SRP> option first to activate SRP.")
;      RegDelete($BlacklistKeyname & $partGUID & '0}')
;      RegDelete($BlacklistKeyname & $partGUID & '1}')
;      RegDelete($keyname, $valuename)
;   EndIf
;EndIf


If $isSRPinstalled = "Not Installed" Then
   RegDelete('HKCR\Msi.Package\shell\runas')
EndIf
If $isSRPinstalled = "Installed" Then
   $keyname = 'HKCR\Msi.Package\shell\runas\command'
   $valuename = ''
   $RegDataNew = '"%SystemRoot%\System32\msiexec.exe" /i "%1" %*'
   RegWrite($keyname, $valuename,'REG_EXPAND_SZ',$RegDataNew)
EndIf

; Enable SMB
Local $SMB_flag=0
;  Correction When loaded setting is OFF and SMB1 is uninstalled -> setting is changed to ON1.
If $DisableSMB = "OFF" Then $SMB_flag = 1
If ($DisableSMB = "ON1" AND CorrectSMB10Uninstalled() = 1) Then $SMB_flag = 1
If $SMB_flag = 0 Then
   If (@OSVersion="WIN_10" or  @OSVersion="WIN_81") Then
      If CorrectSMB10Uninstalled() = 0 Then RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb10', 'Start', 'REG_DWORD', Number('2'))
      RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation', 'DependOnService','REG_MULTI_SZ', 'Bowser' & @LF & 'MRxSmb20' & @LF & 'NSI')
   Else
      If CorrectSMB10Uninstalled() = 0 Then RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb10', 'Start', 'REG_DWORD', Number('3'))
      RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation', 'DependOnService','REG_MULTI_SZ', 'Bowser' & @LF & 'MRxSmb10' & @LF & 'MRxSmb20' & @LF & 'NSI')
   EndIf
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb20', 'Start', 'REG_DWORD', Number('3'))
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB1', 'REG_DWORD', Number('1'))
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB2', 'REG_DWORD', Number('1'))
   $RefreshChangesCheck = $RefreshChangesCheck & "DisableSMB" & @LF
EndIf

; Disable Cached Logons
$keyname = 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'
$valuename = 'CachedLogonsCount'
$RegDataNew = '0'
RegWrite($keyname, $valuename,'REG_SZ',$RegDataNew)

; UAC CTRL_ALT_DEL set to OFF
$keyname = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\CredUI'
$valuename = 'EnableSecureCredentialPrompting'
$RegDataNew = 0
RegWrite($keyname, $valuename,'REG_DWORD',$RegDataNew)

;Delete the Switch OFF/ON Restrictions backup
RegDelete($BackupSwitchRestrictions)
;Turn ON refreshing Windows Explorer
$RefreshExplorer = 1

EndFunc


Func GuiCorrections()

If $GuiSkin = "NoSkin" Then $GuiSkin = "MAmbre"
If $GuiSkin = "Rezak" Then $DeltaY= 20
If $GuiSkin = "Skilled" Then $DeltaY= 20
If $GuiSkin = "DarkRed" Then $DeltaY= 27
If $GuiSkin = "HeavenlyBodies" Then $DeltaY= 27
If $GuiSkin = "Carbon" Then $MainGuiHeight = 390

EndFunc



Func ChangeGuiSkin()
; Change GUI Skin. The Skins are predefined in @WindowsDir\Hard_Configurator\Skins\  folder.
; XSkin.au3 uses RGB for displaing GIU colors (can be edited in Skin.dat file for each Skin).
; Autoit Listview uses BGR (Blue Green Red) for displaying colors.
$MainGuiHeight = 400
$DeltaY= 15
Switch $GuiSkin
;   case "NoSkin"
;      $GuiSkin = "MAmbre"
;      $ListwievColor = 0xDADEE1
;      $SkinNumber = "1"
   case "MAmbre"
      $GuiSkin = "MsgPlus!"
;      $ListwievColor = 0xFFFBF0
      $ListwievColor = 0xECE7E1
      $SkinNumber = "2"
   case  "MsgPlus!"
      $GuiSkin = "Mid_Gray"
      $ListwievColor = 0xDADEE1
      $SkinNumber = "3"
   case "Mid_Gray"
      $GuiSkin = "Lizondo"
      $ListwievColor = 0xfdf0eb
      $SkinNumber = "4"
   case "Lizondo"
      $GuiSkin = "DeFacto"
      $ListwievColor = 0xDDDEE1
      $SkinNumber = "5"
   case "DeFacto"
      $GuiSkin = "Light-Green"
      $ListwievColor = 0xDEE1DA
      $SkinNumber = "6"
;   case "Light-Green"
;      $GuiSkin = "Blue-line"
;;      $ListwievColor = 0xCEDDB0
; ;     $ListwievColor = 0xCEDDB0
;      $ListwievColor = 0xCED7B0
;      $SkinNumber = "7"
;   case "Blue-line"
;      $GuiSkin = "Blue-Gray"
;;      $ListwievColor = 0xCEDDB0
;;      $ListwievColor = 0xE7EDDC
;      $ListwievColor = 0xE2E8D7
;      $SkinNumber = "8"
   case "Light-Green"
      $GuiSkin = "Carbon"
;      $ListwievColor = 0xE0E5E0
      $ListwievColor = 0xDCDCDD
;      $MainGuiHeight = 390
      $SkinNumber = "7"
   case "Carbon"
      $GuiSkin = "Gray-bar"
      $ListwievColor = 0xcccccc
      $SkinNumber = "8"
   case "Gray-bar"
      $ListwievColor = 0xcccccc
      $GuiSkin = "DarkRed"
      $SkinNumber = "9"
;      $DeltaY= 27
   case "DarkRed"
      $GuiSkin = "HeavenlyBodies"
      $ListwievColor = 0xddccaa
;      $DeltaY= 27
      $SkinNumber = "10"
   case "HeavenlyBodies"
      $GuiSkin = "Leadore"
      $ListwievColor = 0xd3d6d9
      $SkinNumber = "11"
   case "Leadore"
      $GuiSkin =  "Noir"
      $ListwievColor = 0xcccccc
      $SkinNumber = "12"
   case "Noir"
      $GuiSkin = "Noir1"
      $ListwievColor = 0xE4E5E0
      $SkinNumber = "13"
   case "Noir1"
      $GuiSkin = "Rezak"
      $ListwievColor = 0xE4E5E0
      $SkinNumber = "14"
;      $DeltaY= 20
   case "Rezak"
      $GuiSkin = "Skilled"
      $ListwievColor = 0xcccccc
      $SkinNumber = "15"
;      $DeltaY= 20
   case "Skilled"
      $GuiSkin = "Sleek"
      $ListwievColor = 0xbbbbbb
      $SkinNumber = "16"
   case "Sleek"
      $GuiSkin = "MAmbre"
      $ListwievColor = 0xDFDEE1
      $SkinNumber = "1"
   case else
       $GuiSkin = "NoSkin"
       $ListwievColor = 0xDFDEE1
       $SkinNumber = "0"
EndSwitch
;_ExtMsgBox(0,"CLOSE", "", "GUI changing.")
GuiCorrections()
$ChangeGuiSkin = 1
EndFunc

Func ChooseSkinFromNumber()
Local $Prompt = "Enter the number (1 ... 16) of the GUI skin." & @crlf & @crlf & "1. MAmbre" & @crlf & "2. MsgPlus!" & @crlf & "3. Mid_Gray" & @crlf & "4. Lizondo" & @crlf & "5. DeFacto" & @crlf & "6. Light-Green" & @crlf & "7. Carbon" & @crlf & "8. Gray-bar" & @crlf & "9. DarkRed" & @crlf & "10. HeavenlyBodies" & @crlf & "11. Leadore" & @crlf & "12. Noir" & @crlf & "13. Noir1" & @crlf & "14. Rezak" & @crlf & "15. Skilled" & @crlf & "16. Sleek"
Local $oldSkinNumber = $SkinNumber
Local $oldGUISkin = $GuiSkin
$SkinNumber = InputBox("Choose Skin", $Prompt, $oldSkinNumber, "", -1, 400)
$MainGuiHeight = 400
$DeltaY= 15
Switch $SkinNumber
   case "1"
      $GuiSkin = "MAmbre"
      $ListwievColor = 0xDADEE1
      $SkinNumber = "1"
   case "2"
      $GuiSkin = "MsgPlus!"
;      $ListwievColor = 0xFFFBF0
      $ListwievColor = 0xECE7E1
      $SkinNumber = "2"
   case  "3"
      $GuiSkin = "Mid_Gray"
      $ListwievColor = 0xDADEE1
      $SkinNumber = "3"
   case "4"
      $GuiSkin = "Lizondo"
      $ListwievColor = 0xfdf0eb
      $SkinNumber = "4"
   case "5"
      $GuiSkin = "DeFacto"
      $ListwievColor = 0xDDDEE1
      $SkinNumber = "5"
   case "6"
      $GuiSkin = "Light-Green"
      $ListwievColor = 0xDEE1DA
      $SkinNumber = "6"
;   case "7"
;      $GuiSkin = "Blue-line"
;;      $ListwievColor = 0xCEDDB0
;;     $ListwievColor = 0xCEDDB0
;      $ListwievColor = 0xCED7B0
;      $SkinNumber = "7"
;   case "8"
;      $GuiSkin = "Blue-Gray"
;;      $ListwievColor = 0xCEDDB0
;;      $ListwievColor = 0xE7EDDC
;      $ListwievColor = 0xE2E8D7
;      $SkinNumber = "8"
   case "7"
      $GuiSkin = "Carbon"
;      $ListwievColor = 0xE0E5E0
      $ListwievColor = 0xDCDCDD
;      $MainGuiHeight = 390
      $SkinNumber = "7"
   case "8"
      $GuiSkin = "Gray-bar"
      $ListwievColor = 0xcccccc
      $SkinNumber = "8"
   case "9"
      $ListwievColor = 0xcccccc
      $GuiSkin = "DarkRed"
      $SkinNumber = "9"
;      $DeltaY= 27
   case "10"
      $GuiSkin = "HeavenlyBodies"
      $ListwievColor = 0xddccaa
;      $DeltaY= 27
      $SkinNumber = "10"
   case "11"
      $GuiSkin = "Leadore"
      $ListwievColor = 0xd3d6d9
      $SkinNumber = "11"
   case "12"
      $GuiSkin =  "Noir"
      $ListwievColor = 0xcccccc
      $SkinNumber = "12"
   case "13"
      $GuiSkin = "Noir1"
      $ListwievColor = 0xE4E5E0
      $SkinNumber = "13"
   case "14"
      $GuiSkin = "Rezak"
      $ListwievColor = 0xE4E5E0
      $SkinNumber = "14"
;      $DeltaY= 20
   case "15"
      $GuiSkin = "Skilled"
      $ListwievColor = 0xcccccc
      $SkinNumber = "15"
;      $DeltaY= 20
   case "16"
      $GuiSkin = "Sleek"
      $ListwievColor = 0xbbbbbb
      $SkinNumber = "16"
   case else
;      $GuiSkin = "MAmbre"
;      $ListwievColor = 0xDADEE1
;      $SkinNumber = "1"
EndSwitch
;_ExtMsgBox(0,"CLOSE", "", "GUI changing.")
GuiCorrections()
If $SkinNumber = "" and $oldSkinNumber > 0 and $oldSkinNumber < 17 Then $SkinNumber = $oldSkinNumber
If $oldSkinNumber <> $SkinNumber then $ChangeGuiSkin = 1
EndFunc


Func SRP()
; (Re)Install Software Restriction Policies

; Write SRP parameters to Windows Registry

RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers', 'DefaultLevel','REG_DWORD',Number('262144'))
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

; Write to Registry SRP Executable types without BAT, CMD, JSE, VBE if RunAsSmartScreen is active and
; SRP security level is "WhiteList"
$keyname = "HKEY_CLASSES_ROOT\*\shell\Run As SmartScreen\command"
$valuename = ""
$RunAsSmartScreen = RegRead ( $keyname, $valuename )

;If ($RunAsSmartScreen = @WindowsDir & '\Hard_Configurator\RunAsSmartscreen(x64).exe "%1" %*' or $RunAsSmartScreen = ;@WindowsDir & '\Hard_Configurator\RunAsSmartscreen(x86).exe "%1" %*') Then
;     SRPExecutableTypes("light")
;Else
;     SRPExecutableTypes("full")
;EndIf

;If (@OSVersion="WIN_10" or  @OSVersion="WIN_81" or @OSVersion="WIN_8" or @OSVersion="WIN_7") Then
;   SRPExecutableTypes("light")
;Else
;   SRPExecutableTypes("light")
;   AddPowerShellExtensions1()
;EndIf
;AddWindowsScriptHostExtensions1()

RestoreDefaultExtensions1()
RemoveAllowEXE()

;Local $sVar = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers", "ExecutableTypes")
;MsgBox($MB_SYSTEMMODAL, "SRP Extensions:", $sVar)

;If not (@OSVersion="WIN_10" or  @OSVersion="WIN_81" or @OSVersion="WIN_8") Then
;   If $HideRunAsAdmin = "ON" Then MsgBox(262144,"","'Hide Run As Administrator' is set to 'ON', so 'Run As Administrator' option is removed from Explorer context menu. There will be no way to run programs with Administrative Rights to bypass SRP in the User Space. Please, consider changing 'Hide Run As Administrator' setting to 'OFF'.")
;EndIf

$RefreshChangesCheck = $RefreshChangesCheck & "SRP" & @LF

ShowRegistryTweaks()


EndFunc


Func AddRemoveGui()
;GUI for Adding/Removing SRP Extensions
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
;#include <WindowsConstants.au3>

Global $ARlistview
Global $ARlistGUI
Global $BtnAddExtension
Global $BtnRemoveExtension
Global $BtnEndExtension
Local $x = 70

;If $SRPDefaultLevel = "Allow All" Then
;   If $Extensionmessage = 0 Then MsgBox(262144,"","The extension protection for Designated File Types is disabled in 'Allow All' SRP security level.")
;   $Extensionmessage = $Extensionmessage +1
;EndIf
$Extensionmessage = 1

HideMainGUI()

If $isSRPinstalled = "Installed" Then
;   Opt("GUIOnEventMode", 1)
   $ARlistGUI = GUICreate("SRP Extensions", 340, 500, $X_SRPExtensionsGUI, $Y_SRPExtensionsGUI, -1)
   GUISetOnEvent($GUI_EVENT_CLOSE, "CloseExtensions")
   $ARlistview = GUICtrlCreateListView("Extensions", 10, 10, 170, 450)
   _GUICtrlListView_SetColumnWidth($ARlistview, 0, 200)

   Local $keyname = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers"
   Local $valuename = "ExecutableTypes"
   Local $sVal = RegRead($keyname, $valuename)

   If $sVal = "" Then MsgBox(262144, "Alert", "Your list of SRP protected extensions is empty! Please, consider to (Re)Install SRP.")

   Local $_Array = Reg2Array()
   _ArraySort($_Array,1)
   Local $element
   While UBound($_Array) > 0
      $element = _ArrayPop($_Array)
      GUICtrlCreateListViewItem($element, $ARlistview)
   WEnd

   $BtnAddExtension = GUICtrlCreateButton("Add", 150 + $x, 15, 80, 30)
   GUICtrlSetOnEvent(-1, "AddItem")
   $BtnRemoveExtension = GUICtrlCreateButton("Remove", 150 + $x, 55, 80, 30)
   GUICtrlSetOnEvent(-1, "RemoveItem")
   GUICtrlCreateLabel ( "Windows Script Host", 135 + $x, 130, 120, 20, -1, -1)
   $BtnAddWindowsScriptHostExtensions = GUICtrlCreateButton("Add", 125 + $x, 150, 60, 20)
   GUICtrlSetOnEvent(-1, "AddWindowsScriptHostExtensions")
   $BtnRemoveWindowsScriptHostExtensions = GUICtrlCreateButton("Remove", 190 + $x, 150, 60, 20)
   GUICtrlSetOnEvent(-1, "RemoveWindowsScriptHostExtensions")
   GUICtrlCreateLabel ( "PowerShell", 160 + $x, 180, 120, 20, -1, -1)
   $BtnAddPowerShellExtensions = GUICtrlCreateButton("Add", 125 + $x, 200, 60, 20)
   GUICtrlSetOnEvent(-1, "AddPowerShellExtensions")
   $BtnRemovePowerShellExtensions = GUICtrlCreateButton("Remove", 190 + $x, 200, 60, 20)
   GUICtrlSetOnEvent(-1, "RemovePowerShellExtensions")
   $BtnSaveSRPExtensions = GUICtrlCreateButton("Save Extensions", 140 + $x - 5, 260, 110, 30)
   GUICtrlSetOnEvent(-1, "SaveSRPExtensions")
   $BtnRestoreSRPExtensions = GUICtrlCreateButton("Restore Saved", 140 + $x - 5, 300, 110, 30)
   GUICtrlSetOnEvent(-1, "RestoreSRPExtensions")
   $BtnRestoreDefaultExtensions = GUICtrlCreateButton("Restore Defaults", 140 + $x - 5, 340, 110, 30)
   GUICtrlSetOnEvent(-1, "RestoreDefaultExtensions")

   $BtnRestoreDefaultExtensions = GUICtrlCreateButton("Paranoid Extensions", 140 + $x - 5, 380, 110, 30)
   GUICtrlSetOnEvent(-1, "ParanoidExtensions")


   $BtnEndExtensions = GUICtrlCreateButton("Close", 150 + $x, 430, 80, 30)
   GUICtrlSetOnEvent(-1, "CloseExtensions")

   GUISetState(@SW_SHOW, $ARlistGUI)
Else
   MsgBox(262144,"","Software Restriction Policies were not installed yet.")
EndIf

EndFunc


Func CloseExtensions()
   GuiDelete($ARlistGUI)
;   GUISetState(@SW_ENABLE, $listGUI)
;   GUISetState(@SW_HIDE,$listGUI)
;   GUISetState(@SW_SHOW,$listGUI)
   ShowMainGUI()
   ShowRegistryTweaks()
EndFunc


Func AddItem()

;Add SRP extension
Local $sToAdd = InputBox("Add", "Enter Item Name", "")

;Check if the extension is OK, and if so, add it to the list
Local $_aArray = Reg2Array()
Local $n = _ArraySearch($_aArray, $sToAdd)
If not ($n >= 0 or $sToAdd = "") Then
      GUICtrlCreateListViewItem($sToAdd, $ARlistview)
;     Local $hWndListView = GUICtrlGetHandle($ARlistview)
;     _GUICtrlListView_SimpleSort($hWndListView, False,1)
      AddSRPExtension($sToAdd)
Else
      If $n >= 0 Then MsgBox(262144, "ALERT", "The  " & '"' & $sToAdd & '"' & "  extension is already on the list!")
EndIf
EndFunc

Func RemoveItem()
;Remove SRP extension
  Local $sItem = GUICtrlRead(GUICtrlRead($ARlistview))
  $sItem = StringTrimRight($sItem, 1) ; Will remove the pipe "|" from the end of the string
  If not ($sItem = "") Then
     MsgBox(262144, "Selected Item", $sItem)
     DeleteSRPExtension($sItem)
     local $n = _GUICtrlListView_FindText($ARlistview, $sItem)
     _GUICtrlListView_DeleteItem($ARlistview, $n)
  Else
    MsgBox(262144, "Selected Item", "Please choose non empty item.")
  EndIf
EndFunc


Func SaveSRPExtensions()

Local $StartKey = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers'
Local $EndKey = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers'
Local $value = RegRead($StartKey,'ExecutableTypes')
If not (@error = "0") Then
   MsgBox(262144,"", 'Error. Extensions not saved.')
   Return
EndIf
If RegWrite($EndKey, 'ExecutableTypes' , 'REG_MULTI_SZ',$value) = "1" Then
      MsgBox(262144,"", 'Extensions saved successfully.')
   Else
      MsgBox(262144,"", 'Write Registry Error. Extensions not saved.')
EndIf

EndFunc


Func RestoreSRPExtensions()

Local $StartKey = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers'
Local $EndKey = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers'
Local $value = RegRead($StartKey,'ExecutableTypes')
If @error = "1" Then
   MsgBox(262144,"", "Error. There is nothing to restore. Please, first use 'Save Extensions' button to save extensions.")
   Return
EndIf
If not (@error = "0") Then
   MsgBox(262144,"", 'Error. Extensions not restored.')
   Return
EndIf
If RegWrite($EndKey, 'ExecutableTypes' , 'REG_MULTI_SZ',$value) = "1" Then
      ;Refresh the GUI Window
      RefreshSRPExtensionsGUIWindow("YES")
   Else
      MsgBox(262144,"", 'Write Registry Error. Extensions not restored.')
EndIf

EndFunc


Func RestoreDefaultExtensions1()
SRPExecutableTypes('Light')
AddWindowsScriptHostExtensions1()
If @OSVersion="WIN_VISTA" Then
   AddPowerShellExtensions1()
EndIf
EndFunc


Func RestoreDefaultExtensions()
  RestoreDefaultExtensions1()
  ;Refresh the GUI Window
  RefreshSRPExtensionsGUIWindow("YES")
EndFunc


Func ParanoidExtensions()
SRPExecutableTypes('paranoid')
;AddWindowsScriptHostExtensions1()
;If @OSVersion="WIN_VISTA" Then
;   AddPowerShellExtensions1()
;EndIf
RefreshSRPExtensionsGUIWindow("YES")
EndFunc



Func AddWindowsScriptHostExtensions()
 AddWindowsScriptHostExtensions1()
 ;Refresh the GUI Window
 RefreshSRPExtensionsGUIWindow("YES")
EndFunc

Func AddWindowsScriptHostExtensions1()
Local $n
Local $_WSHArray = Reg2Array()
Local $sToAdd[6] = ['JS','JSE', 'VBS', 'VBE', 'WSF', 'WSH']
;Check if the extension is OK, and if so, add it to the list
For $i=0 To 5
   $n = _ArraySearch($_WSHArray, $sToAdd[$i])
   If not ($n >= 0) Then
      GUICtrlCreateListViewItem($sToAdd[$i], $ARlistview)
      AddSRPExtension($sToAdd[$i])
   Else
      If $n >= 0 Then MsgBox(262144, "ALERT", "The  " & '"' & $sToAdd[$i] & '"' & "  extension is already on the list!")
   EndIf
Next

EndFunc


Func RemoveWindowsScriptHostExtensions()
Local $m
Local $n
Local $p = 0
Local $_WSHArray = Reg2Array()
Local $sToRemove[6] = ['JS','JSE', 'VBS', 'VBE', 'WSF', 'WSH']
;Check if the extension is OK, and if so, remove it from the list
For $i=0 To 5
   $n = _ArraySearch($_WSHArray, $sToRemove[$i])
   If ($n >= 0) Then
      $m = _GUICtrlListView_FindText($ARlistview, $sToRemove[$i])
      _GUICtrlListView_DeleteItem($ARlistview, $m)
      DeleteSRPExtension($sToRemove[$i])
      $p = $p + 1
   Else
      MsgBox(262144, "ALERT", "The  " & '"' & $sToRemove[$i] & '"' & "  extension is not on the list!")
   EndIf
Next
;Refresh the GUI Window
RefreshSRPExtensionsGUIWindow("YES")

EndFunc


Func AddPowerShellExtensions1()
Local $n
Local $_PSHArray = Reg2Array()
Local $sToAdd[6] = ['PS1', 'PS1XML', 'PS2', 'PS2XML', 'PSC1', 'PSC2']
;Check if the extension is OK, and if so, add it to the list
For $i=0 To 5
   $n = _ArraySearch($_PSHArray, $sToAdd[$i])
   If not ($n >= 0) Then
      GUICtrlCreateListViewItem($sToAdd[$i], $ARlistview)
      AddSRPExtension($sToAdd[$i])
   Else
      If $n >= 0 Then MsgBox(262144, "ALERT", "The  " & '"' & $sToAdd[$i] & '"' & "  extension is already on the list!")
   EndIf
Next
EndFunc


Func AddPowerShellExtensions()
  AddPowerShellExtensions1()
  ;Refresh the GUI Window
  RefreshSRPExtensionsGUIWindow("YES")
EndFunc


Func RemovePowerShellExtensions1()

Local $m
Local $n
Local $p = 0
Local $_PSHArray = Reg2Array()
Local $sToRemove[6] = ['PS1', 'PS1XML', 'PS2', 'PS2XML', 'PSC1', 'PSC2']
;Check if the extension is OK, and if so, remove it from the list
For $i=0 To 5
   $n = _ArraySearch($_PSHArray, $sToRemove[$i])
   If ($n >= 0) Then
      $m = _GUICtrlListView_FindText($ARlistview, $sToRemove[$i])
      _GUICtrlListView_DeleteItem($ARlistview, $m)
      DeleteSRPExtension($sToRemove[$i])
      $p = $p + 1
   Else
      MsgBox(262144, "ALERT", "The  " & '"' & $sToRemove[$i] & '"' & "  extension is not on the list!")
   EndIf
Next
EndFunc


Func RemovePowerShellExtensions()
  RemovePowerShellExtensions1()
  ;Refresh the GUI Window
  RefreshSRPExtensionsGUIWindow("YES")
EndFunc



Func RefreshSRPExtensionsGUIWindow($x)
  Local $pos = WinGetPos ($ARlistGUI)
  $X_SRPExtensionsGUI = $pos[0]
  $Y_SRPExtensionsGUI = $pos[1]
  GUISetState(@SW_HIDE,$ARlistGUI)
  GuiDelete($ARlistGUI)
  AddRemoveGui()
  If $x = "YES" Then MsgBox(262144,"", 'FINISHED')
EndFunc


Func LoadDefaults()

;Turn OFF refreshing Windows Explorer
$RefreshExplorer = 0

HideMainGUI()
;GUISetState(@SW_DISABLE, $listGUI)

Local $keyname
Local $valuename
Local $canread
Local $keyRemoteShell
Local $keyRemoteRegistry
Local $BlacklistKeyname
Local $partGUID

Local $path = MakeConfigFiles()

If $path = 'ERROR' Then
   MsgBox(262144, "", 'Wrong configuration file. Please, choose another one.')
   ShowMainGUI()
   Return
EndIf
If $path= 'CANCEL' Then
   ShowMainGUI()
   Return
EndIf

;Load other settings from profile embeded in the ini section
Local $tempkey = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator'
RegRead($tempkey, 'text_ini')
If @error = 0 Then
;  clear the registry related to the blacklist
   RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\0')
   RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers\BlockSponsors')

;  Load the blocked Sponsors from profile
   Local $BlockedSponsorsLoadProfile = RegRead($tempkey, 'text_reg')
   BlockSponsorsFromProfile($BlockedSponsorsLoadProfile)

;  Check the requirement for applying default White List and default Designated File Types
   $SRPDefaultLevel = RegReadLine('text_ini',3)
   $SRPTransparentEnabled = RegReadLine('text_ini',4)
   Local $isNewSRPinstalled
   If ($SRPTransparentEnabled = "No Enforcement" or $SRPTransparentEnabled = "Skip DLLs" or $SRPTransparentEnabled = "Include DLLs") Then
      If ($SRPDefaultLevel = "White List" or $SRPDefaultLevel = "Allow All" or $SRPDefaultLevel = "Basic User") Then
           $isNewSRPinstalled = "Installed"
      Else
         $isNewSRPinstalled = "Not Installed"
      EndIf
   Else
      $isNewSRPinstalled = "Not Installed"
   EndIf
   If $isSRPinstalled = "Not Installed" And $isNewSRPinstalled = "Installed" Then
;      Check if the current Whitelist exists, if not then load default White List.
      IF not (CheckDefaultCurrentWhitelistedFolders() = 1) Then
         SRP()
         Local $x = MsgBox(262145, "", 'SRP with default White List and default Designated File Types have been applied. It is highly recommended to whitelist the User Space autoruns. Do you want to run autoruns check?')
         If $x = 1 Then
;            HideMainGUI()
            Autoruns()
         EndIf
      EndIf
   EndIf

;     Apply loaded settings
;     MsgBox(0,"", _StringToHex($SRPDefaultLevel) & @CRLF & $SRPDefaultLevel )
      $SRPDefaultLevel = RegReadLine('text_ini',3)
      $canread = $canread + Abs(@error)
      Switch $SRPDefaultLevel
         case "White List"
           RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers','DefaultLevel','REG_DWORD',Number('0'))
           $SRPDefaultLevel = 'White List'
         case "Allow All"
           RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers','DefaultLevel','REG_DWORD',Number('262144'))
           $SRPDefaultLevel = "Allow All"
         case "Basic User"
           RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers','DefaultLevel','REG_DWORD',Number('131072'))
           $SRPDefaultLevel = "Basic User"
         case 'not found'
           RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers','DefaultLevel')
         case 'OFF'
           RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers','DefaultLevel')
         case Else
           RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers','DefaultLevel','REG_DWORD',Number('0'))
           MsgBox(262144,"", "Wrong parameter. 'SRP Default Level' will be set to 'Disallowed'.")
           $SRPDefaultLevel = 'White List'
      EndSwitch


      $SRPTransparentEnabled = RegReadLine('text_ini',4)
      $canread = $canread + Abs(@error)
      Switch $SRPTransparentEnabled
         case "No Enforcement"
            RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers', 'TransparentEnabled','REG_DWORD',Number('0'))
	    $SRPTransparentEnabled = "No Enforcement"
         case "Skip DLLs"
            RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers', 'TransparentEnabled','REG_DWORD',Number('1'))
	    $SRPTransparentEnabled = "Skip DLLs"
         case "Include DLLs"
            RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers', 'TransparentEnabled','REG_DWORD',Number('2'))
	    $SRPTransparentEnabled = "Include DLLs"
         case "OFF"
            RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers', 'TransparentEnabled')
         case 'not found'
           RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers', 'TransparentEnabled')
         case Else
            RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers', 'TransparentEnabled','REG_DWORD',Number('1'))
            MsgBox(262144,"", "Wrong parameter. 'SRP Transparent Enabled' will be set to 'Skip DLLs'.")
	    $SRPTransparentEnabled = "Skip DLLs"
      EndSwitch

      If ($SRPTransparentEnabled = "No Enforcement" or $SRPTransparentEnabled = "Skip DLLs" or $SRPTransparentEnabled = "Include DLLs") Then
         If ($SRPDefaultLevel = "White List" or $SRPDefaultLevel = "Allow All" or $SRPDefaultLevel = "Basic User") Then
            $isSRPinstalled = "Installed"
         Else
            $isSRPinstalled = "Not Installed"
         EndIf
      Else
         $isSRPinstalled = "Not Installed"
      EndIf

;MsgBox(0,"",$SRPDefaultLevel & @crlf & $SRPTransparentEnabled & @crlf & $isSRPinstalled)

   If $isSRPinstalled = "Installed" Then
      If $GreyWritableSubWindows = 0 Then
         $WritableSubWindows = RegReadLine('text_ini',5)
         $canread = $canread + Abs(@error)
         Switch $WritableSubWindows
            case "OFF"
               $WritableSubWindows = 'ON'
               WritableSubWindows('1')
            case "ON"
               $WritableSubWindows = 'OFF'
               WritableSubWindows('1')
            case Else
	       If not ($SRPTransparentEnabled = "No Enforcement") Then
                  $WritableSubWindows = 'OFF'
                  WritableSubWindows('1')
	          $WritableSubWindows = 'ON'
                  MsgBox(262144,"", "Wrong parameter. 'Protect Windows Folder' will be set to 'ON'.")
	       Else
                  $WritableSubWindows = 'ON'
                  WritableSubWindows('1')
	          $WritableSubWindows = 'OFF'
                  MsgBox(262144,"", "Wrong parameter. 'Protect Windows Folder' will be set to 'OFF'.") 
	       EndIf
         EndSwitch
      EndIf

      $DenyShortcuts = RegReadLine('text_ini',6);
      $canread = $canread + Abs(@error)
      If $isSRPinstalled = "Not Installed" Then $DenyShortcuts = "OFF"
      Switch $DenyShortcuts
         case "ON"
            $DenyShortcuts = "OFF"
            Deny_Shortcuts('1')
         case "OFF"
            $DenyShortcuts = "ON"
            Deny_Shortcuts('1')
         case Else
	       If not ($SRPTransparentEnabled = "No Enforcement") Then
                  $DenyShortcuts = 'OFF'
                  Deny_Shortcuts('1')
	          $DenyShortcuts = 'ON'
                  MsgBox(262144,"", "Wrong parameter. 'Protect Shortcuts' will be set to 'ON'.")
	       Else
                  $DenyShortcuts = 'ON'
                  Deny_Shortcuts('1')
	          $DenyShortcuts = 'OFF'
                  MsgBox(262144,"", "Wrong parameter. 'Protect Shortcuts' will be set to 'OFF'.") 
	       EndIf
      EndSwitch
   Else
      $WritableSubWindows = 'ON'
      WritableSubWindows('1')
      $DenyShortcuts = "ON"
      Deny_Shortcuts('1')
   EndIf


;   If $GreyDefenderAntiPUA = 0 Then
;      $DefenderAntiPUA =  RegReadLine('text_ini',9)
;      $canread = $canread + Abs(@error)
;      Switch $DefenderAntiPUA
;      case "ON"
;         RegWrite ( 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine', 'MpEnablePus','REG_DWORD',Number('1'))
;      case "OFF"
;         RegWrite ( 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine', 'MpEnablePus','REG_DWORD',Number('0'))
;      case 'not found'
;         RegDelete ( 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine', 'MpEnablePus')
;      case Else
;        RegWrite ( 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine', 'MpEnablePus','REG_DWORD',Number('1'))
;        MsgBox(262144,"", "Wrong parameter. 'Defender PUA Protection' will be set to 'ON'.")
;      EndSwitch
;   EndIf

;   If $GreyDisableUntrustedFonts = 0 Then
;      $DisableUntrustedFonts = RegReadLine('text_ini',14)
;      $canread = $canread + Abs(@error)
;      Switch $DisableUntrustedFonts
;         case "ON"
;            RegWrite ( 'HKLM\SOFTWARE\Policies\Microsoft\Windows NT\MitigationOptions', 'MitigationOptions_FontBocking','REG_SZ','1000000000000')
;         case "OFF"
;            RegWrite ( 'HKLM\SOFTWARE\Policies\Microsoft\Windows NT\MitigationOptions', 'MitigationOptions_FontBocking','REG_SZ','2000000000000')
;         case "AUDIT"
;           RegWrite ( 'HKLM\SOFTWARE\Policies\Microsoft\Windows NT\MitigationOptions', 'MitigationOptions_FontBocking','REG_SZ','3000000000000')
;         case 'not found'
;           RegDelete ( 'HKLM\SOFTWARE\Policies\Microsoft\Windows NT\MitigationOptions', 'MitigationOptions_FontBocking')
;         case Else
;            RegWrite ( 'HKLM\SOFTWARE\Policies\Microsoft\Windows NT\MitigationOptions', 'MitigationOptions_FontBocking','REG_SZ','1000000000000')
;            MsgBox(262144,"", "Wrong parameter. 'Disable Untrusted Fonts' will be set to 'ON'.")
;      EndSwitch
;   Else
;      $GreyDisableUntrustedFonts = 1
;      RegDelete ( 'HKLM\SOFTWARE\Policies\Microsoft\Windows NT\MitigationOptions', 'MitigationOptions_FontBocking')
;   EndIf

;   If $GreyNoRemovableDisksExecution = 0 Then
;      $NoRemovableDisksExecution = RegReadLine('text_ini',7)
;      $canread = $canread + Abs(@error)
;      Switch $NoRemovableDisksExecution
;         case "OFF"
;            RegWrite ( 'HKLM\SOFTWARE\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}', 'Deny_Execute','REG_DWORD',Number('0'))
;         case "ON"
;            RegWrite ( 'HKLM\SOFTWARE\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}', 'Deny_Execute','REG_DWORD',Number('1'))
;         case 'not found'
;           RegDelete ( 'HKLM\SOFTWARE\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}', 'Deny_Execute')
;         case Else
;            RegWrite ( 'HKLM\SOFTWARE\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}', 'Deny_Execute','REG_DWORD',Number('1'))
;            MsgBox(262144,"", "Wrong parameter. 'No Removable Disks Exec.' will be set to 'ON'.")
;      EndSwitch
;   Else
;     RegDelete ( 'HKLM\SOFTWARE\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}', 'Deny_Execute')
;     $GreyNoRemovableDisksExecution = 1
;   EndIf

   If $GreyNoPowerShellExecution = 0 Then
      $NoPowerShellExecution = RegReadLine('text_ini',8)
      $canread = $canread + Abs(@error)
      Switch $NoPowerShellExecution
         case "OFF"
            RegWrite ( 'HKLM\Software\Policies\Microsoft\Windows\PowerShell', 'EnableScripts','REG_DWORD',Number('1'))
         case "ON"
            RegWrite ( 'HKLM\Software\Policies\Microsoft\Windows\PowerShell', 'EnableScripts','REG_DWORD',Number('0'))
         case 'not found'
            RegDelete ( 'HKLM\Software\Policies\Microsoft\Windows\PowerShell', 'EnableScripts')
         case Else
           RegWrite ( 'HKLM\Software\Policies\Microsoft\Windows\PowerShell', 'EnableScripts','REG_DWORD',Number('0'))
           MsgBox(262144,"", "Wrong parameter. 'No PowerShell Exec.' will be set to 'ON'.")
      EndSwitch
   Else
      RegDelete ( 'HKLM\Software\Policies\Microsoft\Windows\PowerShell', 'EnableScripts')
      $GreyNoPowerShellExecution = 1
   EndIf

   $DisableWSH = RegReadLine('text_ini',10)
   $canread = $canread + Abs(@error)
   Switch $DisableWSH
      case "ON"
         RegWrite ( 'HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings', 'Enabled','REG_DWORD',Number('0'))
         If @OSArch = "X64" Then RegWrite ( 'HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows Script Host\Settings', 'Enabled','REG_DWORD',Number('0'))
      case "OFF"
         RegWrite ( 'HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings', 'Enabled','REG_DWORD',Number('1'))
         If @OSArch = "X64" Then RegWrite ( 'HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows Script Host\Settings', 'Enabled','REG_DWORD',Number('1'))
      case 'not found'
         RegDelete ( 'HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings', 'Enabled')
         RegDelete ( 'HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows Script Host\Settings', 'Enabled')
      case Else
         RegWrite ( 'HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings', 'Enabled','REG_DWORD',Number('0'))
         If @OSArch = "X64" Then RegWrite ( 'HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows Script Host\Settings', 'Enabled','REG_DWORD',Number('0'))
         MsgBox(262144,"", "Wrong parameter. 'Disable Win. Script Host' will be set to 'ON'.")
   EndSwitch


   If $GreyRunAsSmartScreen = 0 Then
      $RunAsSmartScreen = RegReadLine('text_ini',12)
      $canread = $canread + Abs(@error)
      Switch $RunAsSmartScreen
         case "OFF"
            RegDelete('HKEY_CLASSES_ROOT\*\shell\Run As SmartScreen')
            RegDelete('HKEY_CLASSES_ROOT\*\shell\Run By SmartScreen')
         case "Administrator"
            RegDelete('HKEY_CLASSES_ROOT\*\shell\Run By SmartScreen')
            $RunAsSmartScreen = "OFF"
            RunAsSmartScreen()
         case "Standard User"
            RegDelete('HKEY_CLASSES_ROOT\*\shell\Run As SmartScreen')
            $RunAsSmartScreen = "Administrator"
            RunAsSmartScreen()
         case 'not found'
            RegDelete( 'HKEY_CLASSES_ROOT\*\shell\Run As SmartScreen')
            RegDelete('HKEY_CLASSES_ROOT\*\shell\Run By SmartScreen')
         case Else
              If ($SRPDefaultLevel = "White List" OR $SRPDefaultLevel = "Basic User") Then
                 RegDelete('HKEY_CLASSES_ROOT\*\shell\Run As SmartScreen')
                 RegDelete('HKEY_CLASSES_ROOT\*\shell\Run By SmartScreen')
                 $RunAsSmartScreen = "OFF"
                 RunAsSmartScreen()
                 MsgBox(262144,"", "Wrong parameter. Run As SmartScreen will be set to 'Administrator'.")
                 $RunAsSmartScreen = 'Administrator'
              Else
                 RegDelete('HKEY_CLASSES_ROOT\*\shell\Run As SmartScreen')
                 RegDelete('HKEY_CLASSES_ROOT\*\shell\Run By SmartScreen')
                 $RunAsSmartScreen = "Administrator"
                 RunAsSmartScreen()
                 MsgBox(262144,"", "Wrong parameter. Run As SmartScreen will be set to 'Standard User'.")
              EndIf
      EndSwitch
   Else
      RegDelete('HKEY_CLASSES_ROOT\*\shell\Run As SmartScreen')
      RegDelete('HKEY_CLASSES_ROOT\*\shell\Run By SmartScreen')
      $GreyRunAsSmartScreen = 1
   EndIf

   $HideRunAsAdmin = RegReadLine('text_ini',11)
   $canread = $canread + Abs(@error)
   Switch $HideRunAsAdmin
      case "OFF"
         RegWrite ( 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer', 'HideRunAsVerb','REG_DWORD',Number('0'))
      case "ON"
         RegWrite ( 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer', 'HideRunAsVerb','REG_DWORD',Number('1'))
      case 'not found'
         RegDelete (  'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer', 'HideRunAsVerb')
      case Else
         If $RunAsSmartScreen = "Administrator" Then
            RegWrite ( 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer', 'HideRunAsVerb','REG_DWORD',Number('1'))
            MsgBox(262144,"", "Wrong parameter. 'Hide Run As Administrator' will be set to 'ON'.")
         Else
            RegWrite ( 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer', 'HideRunAsVerb','REG_DWORD',Number('0'))
            MsgBox(262144,"", "Wrong parameter. 'Hide Run As Administrator' will be set to 'OFF'.")
         EndIf
   EndSwitch


   $keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
   $keyRemoteShell = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service\WinRS'
   $keyRemoteRegistry = 'HKLM\SYSTEM\CurrentControlSet\Services\RemoteRegistry'
   $BlockRemoteAccess = RegReadLine('text_ini',13)
   $canread = $canread + Abs(@error)
   Switch $BlockRemoteAccess
      case "ON"
         RegWrite($keyname, 'fAllowUnsolicited','REG_DWORD',Number('0'))
         RegWrite($keyname, 'fAllowToGetHelp','REG_DWORD',Number('0'))
         RegWrite($keyname, 'fDenyTSConnections','REG_DWORD',Number('1'))
         RegWrite($keyRemoteShell, 'AllowRemoteShellAccess','REG_DWORD', Number('0'))
         RegWrite($keyRemoteRegistry, 'Start','REG_DWORD',Number('4'))
      case "OFF"
         RegDelete($keyname, 'fAllowUnsolicited')
         RegDelete($keyname, 'fAllowToGetHelp')
         RegDelete($keyname, 'fDenyTSConnections')
         RegDelete($keyRemoteShell, 'AllowRemoteShellAccess')
         RegWrite($keyRemoteRegistry, 'Start','REG_DWORD',Number('4'))
         If (@OSVersion="WIN_7" or @OSVersion="WIN_VISTA") Then
            RegWrite($keyRemoteRegistry, 'Start','REG_DWORD',Number('3'))
         EndIf
       case Else
         RegWrite($keyname, 'fAllowUnsolicited','REG_DWORD',Number('0'))
         RegWrite($keyname, 'fAllowToGetHelp','REG_DWORD',Number('0'))
         RegWrite($keyname, 'fDenyTSConnections','REG_DWORD',Number('1'))
         RegWrite($keyRemoteShell, 'AllowRemoteShellAccess','REG_DWORD', Number('0'))
         RegWrite($keyRemoteRegistry, 'Start','REG_DWORD',Number('4'))
         MsgBox(262144,"", "Wrong parameter. 'Block Remote Assistance' will be set to 'ON'.")
     EndSwitch
     Run("net stop RemoteRegistry",@SystemDir,@SW_HIDE)

   $Disable16Bits = RegReadLine('text_ini',15)
   $canread = $canread + Abs(@error)
   $keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat'
   $valuename = 'VDMDisallowed'
   Switch $Disable16Bits
      case "ON"
         RegWrite ( $keyname, $valuename,'REG_DWORD',Number('1'))
      case "OFF"
         RegWrite ( $keyname, $valuename,'REG_DWORD',Number('0'))
      case Else
         RegWrite ( $keyname, $valuename,'REG_DWORD',Number('0'))
      MsgBox(262144,"", "Wrong parameter. 'Disable 16-bits' will be set to 'OFF'.")
   EndSwitch


   $EnforceShellExtensionSecurity = RegReadLine('text_ini',16)
   $canread = $canread + Abs(@error)
   $keyname = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'
   $valuename = 'EnforceShellExtensionSecurity'
   Switch $EnforceShellExtensionSecurity
      case "ON"
         RegWrite ( $keyname, $valuename,'REG_DWORD',Number('1'))
      case "OFF"
         RegWrite ( $keyname, $valuename,'REG_DWORD',Number('0'))
      case Else
         RegWrite ( $keyname, $valuename,'REG_DWORD',Number('0'))
      MsgBox(262144,"", "Wrong parameter. 'Shell Extension Security' will be set to 'OFF'.")
   EndSwitch

;   $DisableCommandPrompt = FileReadLine($HardConfigurator_IniFile,17)
;   $canread = $canread + Abs(@error)
;   $keyname = $keyname = 'HKCU\Software\Policies\Microsoft\Windows\System'
;   $valuename = 'DisableCMD'
;   Switch $DisableCommandPrompt
;      case "ON"
;         RegWrite ( 'HKCU\Software\Policies\Microsoft\Windows\System', 'DisableCMD','REG_DWORD',Number('1'))
;      case "OFF"
;         RegWrite ( 'HKCU\Software\Policies\Microsoft\Windows\System', 'DisableCMD','REG_DWORD',Number('0'))
;      case Else
;         RegWrite ( 'HKCU\Software\Policies\Microsoft\Windows\System', 'DisableCMD','REG_DWORD',Number('0'))
;      MsgBox(262144,"", "Wrong parameter. 'Disable Command Prompt' will be set to 'OFF'.")
;   EndSwitch
;  $DisableCommandPrompt = FileReadLine($HardConfigurator_IniFile,17)
;  $canread = $canread + Abs(@error)
;  $keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers'
;  $BlacklistKeyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers\0\Paths\'
;  $valuename = 'IsCMDBlocked'
;  $partGUID = '{1016bbe0-a716-428b-822e-5E544B6A310'
;  If $isSRPinstalled = "Installed" Then
;     Switch $DisableCommandPrompt
;        case 'ON'
;           RegWrite($BlacklistKeyname & $partGUID & '2}', 'Description','REG_SZ','cmd.exe  (***)  Microsoft Corporation Windows Command Processor')
;           RegWrite($BlacklistKeyname & $partGUID & '2}', 'SaferFlags','REG_DWORD',Number('0'))
;           RegWrite($BlacklistKeyname & $partGUID & '2}', 'ItemData','REG_SZ','cmd.exe')
;           RegWrite($keyname, $valuename, 'REG_DWORD', Number('1'))
;       case 'OFF'
;           RegDelete($BlacklistKeyname & $partGUID & '2}')
;           RegDelete($keyname, $valuename)
;       case Else
;           RegDelete($BlacklistKeyname & $partGUID & '2}')
;           RegDelete($keyname, $valuename)
;           MsgBox(262144,"", "Wrong parameter. 'Disable Command Prompt' will be set to 'OFF'.")
;     EndSwitch
;  Else
;     If $DisableCommandPrompt = 'ON' Then
;        MsgBox(262144,"", "Cannot set <Disable Command Prompt>. Please, use <(Re)Install SRP> option first to activate SRP.")
;        RegDelete($BlacklistKeyname & $partGUID & '2}')
;        RegDelete($keyname, $valuename)
;     EndIf
;  EndIf


   $NoElevationSUA = RegReadLine('text_ini',17)
   $canread = $canread + Abs(@error)
   $keyname = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
   $valuename = 'ConsentPromptBehaviorUser'
   Switch $NoElevationSUA
      case "ON"
         RegWrite ( $keyname, $valuename,'REG_DWORD',Number('0'))
      case "OFF1"
         RegWrite ( $keyname, $valuename,'REG_DWORD',Number('1'))
      case "OFF3"
         RegWrite ( $keyname, $valuename,'REG_DWORD',Number('3'))
      case Else
         RegWrite ( $keyname, $valuename,'REG_DWORD',Number('3'))
      MsgBox(262144,"", "Wrong parameter. 'Disable Elevation on SUA' will be set to 'OFF3'.")
   EndSwitch


;   $BlockPowerShellSponsors = FileReadLine($HardConfigurator_IniFile,19)
;   $canread = $canread + Abs(@error)
;   $keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers'
;   $valuename = 'IsPowerShellBlocked'
;   $BlacklistKeyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers\0\Paths\'
;   $partGUID = '{1016bbe0-a716-428b-822e-5E544B6A310'
;   If $isSRPinstalled = "Installed" Then
;      Switch $BlockPowerShellSponsors
;         case "ON"
;            RegWrite($BlacklistKeyname & $partGUID & '0}', 'Description','REG_SZ','powershell.exe  (***)  Microsoft Corporation Windows PowerShell')
;            RegWrite($BlacklistKeyname & $partGUID & '0}', 'SaferFlags','REG_DWORD',Number('0'))
;            RegWrite($BlacklistKeyname & $partGUID & '0}', 'ItemData','REG_SZ','powershell.exe')
;            RegWrite($BlacklistKeyname & $partGUID & '1}', 'Description','REG_SZ','powershell_ise.exe  (***)  Microsoft Corporation Windows PowerShell ISE')
;            RegWrite($BlacklistKeyname & $partGUID & '1}', 'SaferFlags','REG_DWORD',Number('0'))
;            RegWrite($BlacklistKeyname & $partGUID & '1}', 'ItemData','REG_SZ','powershell_ise.exe')
;            RegWrite($keyname, $valuename, 'REG_DWORD', Number('1'))
;         case "OFF"
;            RegDelete($BlacklistKeyname & $partGUID & '0}')
;            RegDelete($BlacklistKeyname & $partGUID & '1}')
;            RegDelete($keyname, $valuename)
;         case Else
;            RegDelete($BlacklistKeyname & $partGUID & '0}')
;            RegDelete($BlacklistKeyname & $partGUID & '1}')
;            RegDelete($keyname, $valuename)
;         MsgBox(262144,"", "Wrong parameter. 'Block PowerShell Sponsors' will be set to 'OFF'.")
;   EndSwitch
;   Else
;      If $BlockPowerShellSponsors = 'ON' Then
;         MsgBox(262144,"", "Cannot set <Block PowerShell Sponsors>. Please, use <(Re)Install SRP> option first to activate SRP.")
;         RegDelete($BlacklistKeyname & $partGUID & '0}')
;         RegDelete($BlacklistKeyname & $partGUID & '1}')
;         RegDelete($keyname, $valuename)
;      EndIf
;   EndIf

   $MSIElevation = RegReadLine('text_ini',18)
   $canread = $canread + Abs(@error)
   $keyname = 'HKCR\Msi.Package\shell\runas\command'
   $valuename = ''
   Switch $MSIElevation
      case "ON"
         Local $RegDataNew = '"%SystemRoot%\System32\msiexec.exe" /i "%1" %*'
         RegWrite($keyname, $valuename,'REG_EXPAND_SZ',$RegDataNew)
      case "OFF"
         RegDelete('HKCR\Msi.Package\shell\runas')
      case Else
         Local $RegDataNew = '"%SystemRoot%\System32\msiexec.exe" /i "%1" %*'
         RegWrite($keyname, $valuename,'REG_EXPAND_SZ',$RegDataNew)
         MsgBox(262144,"", "Wrong parameter. 'MSI Elevation' will be set to 'ON'.")
   EndSwitch

   Local $DisableSMB_Old = $DisableSMB
   $DisableSMB = RegReadLine('text_ini',19)
   $canread = $canread + Abs(@error)
;  Correction When loaded setting is OFF and SMB1 is uninstalled -> setting is changed to ON1.
   If ($DisableSMB = "OFF" AND CorrectSMB10Uninstalled() = 1) Then $DisableSMB = "ON1"
;   MsgBox(0,"",$DisableSMB_Old & "   " & $DisableSMB)
   If not ($DisableSMB_Old = $DisableSMB) Then
;  ON123 (00) > OFF (11) > ON1 (01)
      Switch $DisableSMB
         case "ON123"
;            If CorrectSMB10Uninstalled() = 0 Then RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb10', 'Start', 'REG_DWORD', Number('4'))
            RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb20', 'Start', 'REG_DWORD', Number('4'))
;           Set ON1 and change to ON123
            RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB1', 'REG_DWORD', Number('0'))
            RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB2', 'REG_DWORD', Number('1'))
            DisableSMB('1')
         case "OFF"
;            If CorrectSMB10Uninstalled() = 0 Then RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb10', 'Start', 'REG_DWORD', Number('2'))
            RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb20', 'Start', 'REG_DWORD', Number('3'))
;           Set ON123 and change to OFF
            RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB1', 'REG_DWORD', Number('0'))
            RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB2', 'REG_DWORD', Number('0'))
            DisableSMB('1')
         case 'ON1'
;            If CorrectSMB10Uninstalled() = 0 Then RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb10', 'Start', 'REG_DWORD', Number('4'))
            RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb20', 'Start', 'REG_DWORD', Number('3'))
;           Set OFF and change to ON1
            RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB1', 'REG_DWORD', Number('1'))
            RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB2', 'REG_DWORD', Number('1'))
            DisableSMB('1')
         case Else
;            If CorrectSMB10Uninstalled() = 0 Then RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb10', 'Start', 'REG_DWORD', Number('2'))
            RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb20', 'Start', 'REG_DWORD', Number('3'))
;           Set ON123 and change to OFF
            RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB1', 'REG_DWORD', Number('0'))
            RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB2', 'REG_DWORD', Number('0'))
            DisableSMB('1')
            MsgBox(262144,"", "Wrong parameter. 'Block SMB' will be set to 'OFF'.")
      EndSwitch
   EndIF
   
   $DisableCachedLogons = RegReadLine('text_ini',20)
   $canread = $canread + Abs(@error)
   $keyname = 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'
   $valuename = 'CachedLogonsCount'
   Switch $DisableCachedLogons
      case "ON"
         RegWrite ( $keyname, $valuename,'REG_SZ','0')
      case "OFF"
         RegWrite ( $keyname, $valuename,'REG_SZ','10')
      case Else
         RegWrite ( $keyname, $valuename,'REG_SZ','0')
      MsgBox(262144,"", "Wrong parameter. 'Disable Cached Logons' will be set to 'ON'.")
   EndSwitch

   $UACSecureCredentialPrompting = RegReadLine('text_ini',21)
   $canread = $canread + Abs(@error)
   $keyname = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\CredUI'
   $valuename = 'EnableSecureCredentialPrompting'
   Switch $UACSecureCredentialPrompting
      case "ON"
         RegWrite ( $keyname, $valuename,'REG_DWORD', Number('1'))
      case "OFF"
         RegWrite ( $keyname, $valuename,'REG_DWORD', Number('0'))
      case Else
         RegWrite ( $keyname, $valuename,'REG_DWORD', Number('0'))
      MsgBox(262144,"", "Wrong parameter. 'UAC CRL_ALT_DEL' will be set to 'OFF'.")
   EndSwitch

   If $GreySystemWideDocumentsAntiExploit = 0 Then
      $SystemWideDocumentsAntiExploit =  RegReadLine('text_ini',22)
      $canread = $canread + Abs(@error)
      Switch $SystemWideDocumentsAntiExploit
      case "Adobe + VBA"
         SystemWideDocumentsAntiExploit1("Adobe + VBA")
      case "ON"
         SystemWideDocumentsAntiExploit1("Adobe + VBA")
      case "Adobe"
         SystemWideDocumentsAntiExploit1("Adobe")
      case "OFF"
         SystemWideDocumentsAntiExploit1("OFF")
      case "Partial"
         MsgBox(262144, "", "The 'Partial' setting from the loaded profile will be ignored." & @crlf & "The <Documents Anti-Exploit> settings will not be changed.")
      case Else
         SystemWideDocumentsAntiExploit1("Adobe + VBA")
         MsgBox(262144,"", "Wrong parameter. <Documents Anti-Exploit> will be set to" & @crlf & "'Adobe + VBA'.")
      EndSwitch
   EndIf

   $SRPAllowExe = RegReadLine('text_ini',23)
   $canread = $canread + Abs(@error)
   Switch $SRPAllowExe
   case "ON"
	   AddAllowEXE()
   case "OFF"
	   RemoveAllowEXE()
   case Else
	   RemoveAllowEXE()
	   MsgBox(262144,"", "Wrong parameter. 'Allow EXE' will be set to OFF.")   
   EndSwitch

; Check errors
   If $canread > 0 Then
       MsgBox(262144,"", "There were " & $canread & " errors, when reading the configuration file.")
   Else
       MsgBox(262144,"", "Configuration loaded successfully." & @CRLF & "Please, remember to <APPLY CHANGES>, after configuration is done.")
   EndIf
Else
      MsgBox(262144, "", "Cannot find saved settings!")
EndIf

;Delete temporary files
RegDelete($tempkey, 'text_reg')
RegDelete($tempkey, 'text_ini')
RegDelete($tempkey, 'text_info')

; Delete Switch OFF/ON SRP and Switch OFF/ON Restrictions
RegDelete($BackupSwitchRestrictions)

; Refresh Block Sponsors
;RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers\BlockSponsors')
;_RegCopyKey('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\Backup\BlockSponsors', 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers\BlockSponsors')

; Delete actual SRP settings and load SRP settings from saved backup.
;RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers')
;$keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\Backup\CodeIdentifiers'
;_RegCopyKey($keyname, 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers')

ShowMainGUI()
ShowRegistryTweaks()
;Turn ON refreshing Windows Explorer
$RefreshExplorer = 1

EndFunc


Func CheckAllowEXE()
Local $Key = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers\262144\Paths\{1016bbe0-a716-428b-822e-DE544B6A3520}'
Local $check1 = RegRead($Key, 'ItemData')
Local $check2 = RegRead($Key, 'SaferFlags')
Local $n = 0
If not @error Then
   If $check1 = '*.exe' Then $n = $n + 1
   If $check2 = 0 Then $n = $n + 1
EndIf
; $n = 2 for EXE allowed
;MsgBox(0,"",$n)
Return $n
EndFunc


Func SaveDefaults($ProfileInfo)
Local $configuration_ini = $PathToConfigurationFile
; Info about the profile to save is in $ProfileInfo variable.
;Save SRP Blocked Sponsors to file
Local $text = ExportRegSettings($PathToConfigurationFile)
If $text = 'DoNotCreate' Then Return
FileWrite($configuration_ini, $text)
$text = ""
$text = $text & "SKIN=" & $GuiSkin & @CRLF
$text = $text & "ListColor=" & $ListwievColor & @CRLF
$text = $text & $SRPDefaultLevel & @CRLF
$text = $text & $SRPTransparentEnabled & @CRLF
$text = $text & $WritableSubWindows & @CRLF
$text = $text & $DenyShortcuts & @CRLF
$text = $text & $NoRemovableDisksExecution & @CRLF
$text = $text & $NoPowerShellExecution & @CRLF
$text = $text & $DefenderAntiPUA & @CRLF
$text = $text & $DisableWSH & @CRLF
$text = $text & $HideRunAsAdmin & @CRLF
$text = $text & $RunAsSmartScreen & @CRLF
$text = $text & $BlockRemoteAccess & @CRLF
$text = $text & $DisableUntrustedFonts & @CRLF
$text = $text & $Disable16Bits & @CRLF
$text = $text & $EnforceShellExtensionSecurity & @CRLF
$text = $text & $NoElevationSUA & @CRLF
$text = $text & $MSIElevation & @CRLF
$text = $text & $DisableSMB & @CRLF
$text = $text & $DisableCachedLogons & @CRLF
$text = $text & $UACSecureCredentialPrompting & @CRLF
$text = $text & $SystemWideDocumentsAntiExploit & @CRLF
$text = $text & $SRPAllowExe & @CRLF
$text = $text & "END"
If $SystemWideDocumentsAntiExploit = 'Partial' Then MsgBox(262144,"","<Documents Anti-Exe> option is set to 'Partial'. This setting will be ignored when downloading later this profile, so MS Office and Adobe Acrobat Reader settings will not be restored.")
FileWrite($configuration_ini, @CRLF & ";********* Beginning of ini section *********" & @CRLF & @CRLF)
FileWrite($configuration_ini, $text & @CRLF)
FileWrite($configuration_ini, @CRLF & ";********* Beginning of profile info section *********" & @CRLF & @CRLF)
If not ($ProfileInfo="") Then FileWrite($configuration_ini, $ProfileInfo)
RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\Export_Profile')
MsgBox(262144,"", "Configuration saved successfully.")
ShowRegistryTweaks()

EndFunc


Func _GuiMinimizeToTray()

;check if 1 = Window exists, then check to see if its 16 = Window is minimized
    If BitAND(WinGetState($listGUI), 1) Or Not BitAND(WinGetState($listGUI), 16) Then
        ; Change the Main GUI state to minimized
        GUISetState (@SW_MINIMIZE, $listGUI)
        TraySetState(1)
    EndIf
EndFunc


Func RestoreGui()
    ; Restore the GUI
    GUISetState(@SW_SHOW, $listGUI)
    GUISetState(@SW_RESTORE,$listGUI)
    ; Hide the icon
    TraySetState(2)
EndFunc


Func _About()
    MsgBox(262144,"Hard_Configurator", "Windows Hardening Configurator" & @CRLF & "ver. " & $Hard_ConfiguratorVersion & @CRLF & "Copyright *  Andy Ful, July 2019")
EndFunc


Func On_Close_Main()
  Local $key = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\'
  RegWrite($key, 'SKIN', 'REG_SZ', $GuiSkin)
  RegWrite($key, 'ListColor', 'REG_SZ', $ListwievColor)
  RegWrite($key, 'SkinNumber', 'REG_SZ', $SkinNumber)
;  If FileExists($HardConfigurator_IniFile) = 0 Then
;     CreateHardConfiguratorIniFile();   MsgBox(262144,"", "Hard_Configurator.ini file has been created.")
;  EndIf
;;  Automatically save Skin settings on exit
;;  MsgBox(262144,"",$ListwievColor)
;  _FileWriteToLine ( $HardConfigurator_IniFile, 1, "SKIN=" & $GuiSkin, True)
;  _FileWriteToLine ( $HardConfigurator_IniFile, 2, "ListColor=" & $ListwievColor, True)
   ApplyChangesOnExit()
  Exit
EndFunc

Func CreateHardConfiguratorIniFile()
 If FileExists($HardConfigurator_IniFile) = 0 Then
    For $i=1 to 19
        FileWrite ( $HardConfigurator_IniFile, @CRLF & @CRLF)
    Next
 EndIf
   _FileWriteToLine ( $HardConfigurator_IniFile, 1, "SKIN=" & $GuiSkin, True)
   _FileWriteToLine ( $HardConfigurator_IniFile, 2, "ListColor=" & $ListwievColor, True)
    For $i=3 to 16
   _FileWriteToLine ( $HardConfigurator_IniFile, $i, "OFF", True)
   Next
   _FileWriteToLine ( $HardConfigurator_IniFile, 17, "OFF3", True)
    For $i=18 to 19
   _FileWriteToLine ( $HardConfigurator_IniFile, $i, "OFF", True)
   Next
   _FileWriteToLine ( $HardConfigurator_IniFile, $i-1, 'END', True)
EndFunc


Func Documentation()
   ; Display an open dialog to select a file.
   Local $sFileOpenDialog = FileOpenDialog("", $ProgramFolder, "Documents (*.pdf)", $FD_FILEMUSTEXIST)
   If @error Then
      ; Display the error message.
      MsgBox(262144, "", "No file was selected." & $sFileOpenDialog)

      ; Change the working directory (@WorkingDir) back to the location of the script directory as FileOpenDialog sets it to the last accessed folder.
      FileChangeDir(@ScriptDir)
   Else
      ; Change the working directory (@WorkingDir) back to the location of the script directory as FileOpenDialog sets it to the last accessed folder.
      FileChangeDir(@ScriptDir)
      ShellExecute($sFileOpenDialog)
   EndIf
EndFunc


Func ImportSettings()
   ; Display an open dialog to select a file.
   Local $sFileOpenDialog = FileOpenDialog("Please, choose the profile to load.", $ProgramFolder & 'Configuration', "Configuration Files (*.hdc)", $FD_FILEMUSTEXIST)
   If @error Then
      ; Display the error message.
      MsgBox(262144, "", "No file was selected." & $sFileOpenDialog)
      ; Change the working directory (@WorkingDir) back to the location of the script directory as FileOpenDialog sets it to the last accessed folder.
      FileChangeDir(@ScriptDir)
   Else
      ; Change the working directory (@WorkingDir) back to the location of the script directory as FileOpenDialog sets it to the last accessed folder.
      FileChangeDir(@ScriptDir)
      If (@OSVersion="WIN_7" or @OSVersion="WIN_VISTA") Then;
         If StringInStr($sFileOpenDialog, 'TestingSmartscreen.hdc') > 0 Then
            MsgBox(262144, "", "This profile is supported only in Windows 8 and higher versions.")
            $sFileOpenDialog = "!!!ImportSettingsAgain!!!"
         EndIf
      EndIf
      Return $sFileOpenDialog
   EndIf
EndFunc


Func MakeConfigFiles()
  Local $text=""
  Local $text_reg=""
  Local $text_ini=""
  Local $text_info=""
  Local $x= "!!!ImportSettingsAgain!!!"
  Local $y = 2

While $y = 2
; Find the configuration file

  While $x= "!!!ImportSettingsAgain!!!"
    $x=ImportSettings()
    If $x = '' Then Return 'CANCEL'
  WEnd
  $textsource = FileRead($x)
; Znacznik oddzielający sekcję REG od sekcji INI
  local $entrypoint = ";********* Beginning of ini section *********"
  local $n = StringInStr($textsource, $entrypoint)
  If $n = 0 Then Return 'ERROR'
  local $m = StringLen($entrypoint)
; Zawartość sekcji REG (blacklist)
  $text_reg= StringLeft($textsource, $n-1)
;  Zawartość sekcji INI + Profile info
  $text= StringRight($textsource, StringLen($textsource) - $n-$m-1)
; Znacznik oddzielający sekcję INI od sekcji INFO
  $entrypoint = ";********* Beginning of profile info section *********"
  $n = StringInStr($text, $entrypoint)
  If $n = 0 Then Return 'ERROR'
  $m = StringLen($entrypoint)
; Zawartość sekcji INI
  $text_ini= StringLeft($text, $n-1)
  $text_ini = StringTrimLeft($text_ini, 2)
;  Zawartość sekcji Profile info
  $text= StringRight($text, StringLen($text) - $n-$m-1)
  $text_info= StringTrimLeft($text, 2)
  ; Tworzenie tymczasowych plików konfiguracyjnych
  $x = StringLeft($x, StringLen($x)-4)
;  FileWrite($x & ".reg", $text_reg)
;  FileWrite($x & ".ini", $text_ini)
;  FileWrite($x & ".info", $text_info)
  Local $tempkey = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator'
  RegWrite($tempkey, 'text_reg', 'REG_SZ', $text_reg)
  RegWrite($tempkey, 'text_ini', 'REG_SZ', $text_ini)
  RegWrite($tempkey, 'text_info', 'REG_SZ', _StringToHex($text_info))
  Local $y = MsgBox(262145,"Profile info - press OK to load.",$text_info)
  If $y = 2 Then
;     FileDelete($x & ".reg")
;     FileDelete($x & ".ini")
;     FileDelete($x & ".info")
     RegDelete($tempkey, 'text_reg')
     RegDelete($tempkey, 'text_ini')
     RegDelete($tempkey, 'text_info')
  EndIf
WEnd
  Return $x
EndFunc


Func ExportRegSettings($x)

Local $regvalue = ""
local $regkey1 = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers\BlockSponsors"

; $x = path to the configuration .hcd file
If $x = "ERROR" Then Return 'DoNotCreate'
If FileExists($x) Then
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.5)
   Local $y = _ExtMsgBox(0,"&OVERWRITE|CANCEL", "", 'The profile exists already. Do you want to overwrite it?')
   If $y = 2 Then Return 'DoNotCreate'
   FileDelete($x)
EndIf

;Local $key = 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\Export_Profile'
;Local $Export_Profile = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers\'
;_RegCopyKey($Export_Profile, $key)
;RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\Export_Profile\262144')
;('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\Export_Profile', 'ExecutableTypes')
;RunWait(@WindowsDir & "\regedit.exe /e " & $ProgramConfigurationFolder & "0.reg" & " " & $regkey1)
;Local $text = FileRead($ProgramConfigurationFolder & "0.reg")
;$text = StringReplace($text, "safer_Hard_Configurator\Export_Profile", "safer\CodeIdentifiers") & @LF & @LF
;RunWait(@WindowsDir & "\regedit.exe /e " & $ProgramConfigurationFolder & "1.reg" & " " & $regkey1 )
;$text = $text & FileRead($ProgramConfigurationFolder & "1.reg") & @LF & @LF
;FileWrite($x, $text)
Local $i=1
While not (RegEnumVal($regkey1, $i) = "")
 $regvalue = $regvalue & RegEnumVal($regkey1, $i) & @CRLF
 $i=$i+1
WEnd
;MsgBox(262144,"",$regvalue)
;FileDelete($ProgramConfigurationFolder & "0.reg")
;FileDelete($ProgramConfigurationFolder & "1.reg")
; path to the configuration .hcd file

;Return $x
Return $regvalue
EndFunc


Func SaveTheConfigFile()
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
    If not FileExists($ProgramConfigurationFolder) Then DirCreate($ProgramConfigurationFolder)
    ; Create a constant variable in Local scope of the message to display in FileSaveDialog.
    Local $sMessage = "Please, write the name of profile to be saved."

    ; Display an open dialog to select a list of file(s).
    Local $sFileSaveDialog = FileSaveDialog($sMessage, $ProgramConfigurationFolder, "Configuration files (*.hdc)", $FD_FILEMUSTEXIST)
    If @error Then
        ; Display the error message.
        MsgBox($MB_SYSTEMMODAL, "", "No file(s) were selected." & $sFileSaveDialog)

        ; Change the working directory (@WorkingDir) back to the location of the Configuration folder as FileSaveDialog sets it to the last accessed folder.
        FileChangeDir($ProgramConfigurationFolder)
        Return "ERROR"
    Else
        ; Change the working directory (@WorkingDir) back to the location of the Configuration folder as FileSaveDialog sets it to the last accessed folder.
        FileChangeDir($ProgramConfigurationFolder)

        ; Replace instances of "|" with @CRLF in the string returned by FileSaveDialog.
        $sFileSaveDialog = StringReplace($sFileSaveDialog, "|", @CRLF)

        ; Display the list of selected files.
;        MsgBox($MB_SYSTEMMODAL, "", "You chose the following files:" & @CRLF & $sFileSaveDialog)
    EndIf
Return $sFileSaveDialog
EndFunc


Func EditInfoSaveDefaults()
HideMainGUI()
Local  $text = ""
; Path to configuration file .hdc
Global $PathToConfigurationFile = SaveTheConfigFile()
If $PathToConfigurationFile = "ERROR" Then
   ShowMainGUI()
   Return
EndIf
If FileExists($PathToConfigurationFile) Then
; Decrypt the configuration file
;;  Local $textsource = EncryptConfigFile($PathToConfigurationFile, 'DECRYPT')
  Local $textsource = FileRead($PathToConfigurationFile)
  $entrypoint = ";********* Beginning of profile info section *********"
  $n = StringInStr($textsource, $entrypoint)
  If $n = 0 Then
    MsgBox(262144,"", 'Wrong configuration file. Please choose another one.')
    ShowMainGUI()
    Return 'ERROR'
  EndIf
  $m = StringLen($entrypoint)
;  Zawartość sekcji Profile info
  $text= StringRight($textsource, StringLen($textsource) - $n-$m-3)
EndIf

Local $sWow64 = ""
If @AutoItX64 Then $sWow64 = "\Wow6432Node"

; Create GUI
$EditInfoGUI = GUICreate("Write the info about the profile to be saved.", 400, 330, -1, -1, -1)
GUISetOnEvent($GUI_EVENT_CLOSE, "CloseEditInfo")

; Create Edit window
$EditInfo = GUICtrlCreateEdit("", 2, 2, 394, 268, BitOR($ES_WANTRETURN, $WS_VSCROLL))

GUISetState(@SW_SHOW)
; Set Margins
_GUICtrlEdit_SetMargins($EditInfo, BitOR($EC_LEFTMARGIN, $EC_RIGHTMARGIN), 10, 10)
; Set Text
If $text = "" Then
   _GUICtrlEdit_SetText($EditInfo, "" & @CRLF)
Else
   _GUICtrlEdit_SetText($EditInfo, "")
EndIf
; Insert text
 _GUICtrlEdit_InsertText($EditInfo, $text, 0)

; Create buttons
Local $BtnEditInfoHelp = GUICtrlCreateButton("Help",175, 285, 50, 30)
GUICtrlSetOnEvent(-1, "EditInfoHelp")
Local $BtnCloseEditInfo = GUICtrlCreateButton("OK", 330,  285, 50, 30)
GUICtrlSetOnEvent(-1, "CloseEditInfo")

GUISetState(@SW_SHOW,$EditInfoGUI)

EndFunc


Func EditInfoHelp()
   Local $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\helpEditInfo.txt")
;   MsgBox(262144,"", $help)
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.41)
   _ExtMsgBox(0,"OK", "", $help)
EndFunc


Func CloseEditInfo()
    Local $ProfileInfoText = _GUICtrlEdit_GetText($EditInfo)
    Local $n = StringInStr ( $ProfileInfoText, @LF, 0 , 25)
    Local $m = 0
    If $n > 0 Then
       $ProfileInfoText = StringLeft($ProfileInfoText, $n)
       $m=1
    EndIf
    If StringLen($ProfileInfoText) > 1400 Then
       $ProfileInfoText = StringLeft($ProfileInfoText, '1400')
       $m = 1
    EndIf
    If $m = 1 Then MsgBox(262144,"","The info text is too long. Only part of it will be saved.")
;    MsgBox(262144,"", $n & '   ' & $m & '   ' & StringLen($ProfileInfoText))
   GuiDelete($EditInfoGUI)
;  Transfer the text Info Profile to the saving profile function
   SaveDefaults($ProfileInfoText)
;   GUISetState(@SW_HIDE, $listGUI)
;   GUISetState(@SW_SHOW, $listGUI)
;   GUISetState(@SW_ENABLE, $listGUI)
   ShowRegistryTweaks()
   ShowMainGUI()
EndFunc


Func CheckBoxBlockSponsors1()
  CheckBoxBlockSponsors()
EndFunc


Func _sGetLoggedAccountsNumber()
 Local $hArray[1] =[""]
 Local $n = 1
 Local $profilesList = "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList"
 Local $vSID = RegEnumKey("HKU", 1)

 While $vSID <> ""
   $vSID = RegEnumKey("HKU", $n)
   If RegRead($profilesList & '\' & $vSID, 'FullProfile') = 1 Then _ArrayAdd($hArray, $vSID)
   $n = $n + 1
 WEnd
 Return Ubound($hArray) - 1
EndFunc

Func _sGetAccountsNumber()
 Local $hArray[1] =[""]
 Local $n = 1
 Local $profilesList = "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList"
 Local $vSID = RegEnumKey($profilesList, 1)

 While $vSID <> ""
   $vSID = RegEnumKey($profilesList, $n)
   If RegRead($profilesList & '\' & $vSID, 'FullProfile') = 1 Then _ArrayAdd($hArray, $vSID)
   $n = $n + 1
 WEnd
 Return Ubound($hArray) - 1
EndFunc


Func ApplyChangesOnExit()
If $RefreshChangesCheck = "" Then Return
If StringInStr($RefreshChangesCheck, "DisableSMB" & @LF) > 0 Then
    Local $help = "Hard_Configurator requires to RESTART the computer to apply the new configuration." & @LF & @LF & "Do you want to RESTART?"
   _ExtMsgBoxSet(1+4+8+32, 0, -1, 0xaa0000, 10, "Arial", @DesktopWidth*0.4)
   Local $x = _ExtMsgBox(0,"&RESTART COMPUTER|CANCEL", "", $help)
   _ExtMsgBoxSet(1+4+8+32, 0, -1, 0x000000, 10, "Arial", @DesktopWidth*0.4)
   If $x = 1 Then
      $RefreshChangesCheck = ""
      Shutdown(2)
   EndIf
   Return
EndIf
If (@OSVersion="WIN_10" And _sGetLoggedAccountsNumber() = 1) Then
   Local $help = "It is recommended Log Off / Log ON to apply the new configuration."  & @CRLF & "Closing all applications and Refreshing Explorer has the same effect, but sometimes (rarely), can cause reordering of icons on the Desktop." & @CRLF & "Do you want to LOG OFF?"
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.5)
   Local $x = _ExtMsgBox(0,"&LOG OFF|Refresh Explorer|CANCEL", "", $help)
   If $x = 1 Then Shutdown(0)
   If $x = 2 Then
      RefreshExplorer()
;      MsgBox(262144,"",$RefreshChangesCheck)
      $RefreshChangesCheck = ""
      SplashTextOn("", "Windows Explorer refreshed." & @LF & "FINISHED!", 220, 60, -1, -1, $DLG_TEXTLEFT, "", 10)
        Sleep(3000)
      SplashOff()
      Return
   EndIf
   If $x = 3 Then
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.5)
   _ExtMsgBox(0,"OK", "",  "The new configuration has not been applied." & @CRLF & "Some settings will not work as expected.")
;      MsgBox(262144,"", "The new configuration has not been applied." & @CRLF & "Some settings will not work as expected.")
      Return
   EndIf
EndIf

If (@OSVersion="WIN_10" And _sGetLoggedAccountsNumber() <> 1) Then
    Local $help = "Hard_Configurator requires to LOG OFF from the current account when applying the new configuration." & @crlf & @crlf & "If you do not want to LOG OFF, then you may press the 'Cancel' button and next refresh the Explorer - this will also apply configuration changes. Simply, run Explorer and Task Manager in extended view (from Power Menu). Sort the view in Task Manager window by clicking the 'Name' column. In the Applications section, right-click on 'Windows Explorer' entry and choose 'Restart'." & @LF & @LF & "Do you want to LOG OFF?"
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.4)
   Local $x = _ExtMsgBox(0,"&OK|CANCEL", "", $help)
   If $x = 1 Then Shutdown(0)
   Return
EndIf

If (@OSVersion="WIN_81" or @OSVersion="WIN_8") Then
    Local $help = "Hard_Configurator requires to LOG OFF from the current account when applying the new configuration." & @crlf & @crlf & "If you do not want to LOG OFF, then you may press the 'Cancel' button and next refresh the Explorer - this will also apply configuration changes. Simply, run Windows Explorer and execute taskmgr.exe from it. Sort the view in Task Manager window by clicking the 'Name' column. In the Applications section, right-click on 'Windows Explorer' entry and choose 'Restart'." & @LF & @LF & "Do you want to LOG OFF?"
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.4)
   Local $x = _ExtMsgBox(0,"&OK|CANCEL", "", $help)
   If $x = 1 Then Shutdown(0)
   Return
EndIf

If (@OSVersion="WIN_7" or  @OSVersion="WIN_VISTA") Then
    Local $help = "Hard_Configurator requires to LOG OFF from the current account, when applying the new configuration." & @LF & @LF & "Do you want to LOG OFF?"
   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.4)
   Local $x = _ExtMsgBox(0,"&OK|CANCEL", "", $help)
   If $x = 1 Then Shutdown(0)
   Return
EndIf



EndFunc


Func ConfigureDefender()
Local $sMessage = "Starting the external module."
SplashTextOn("", $sMessage, 300, 40, -1, -1, 1, "", 10)
 Sleep(3000)
SplashOff()
If @OSArch = "X86" Then Run($ProgramFolder & 'ConfigureDefender_x86.exe')
If @OSArch = "X64" Then Run($ProgramFolder & 'ConfigureDefender_x64.exe')
EndFunc


Func FirewallHardening()
Local $sMessage = "Starting the external module."
SplashTextOn("", $sMessage, 300, 40, -1, -1, 1, "", 10)
 Sleep(3000)
SplashOff()
If @OSArch = "X86" Then Run($ProgramFolder & 'FirewallHardening(x86).exe')
If @OSArch = "X64" Then Run($ProgramFolder & 'FirewallHardening(x64).exe')
EndFunc



Func ApplyChanges()
If $RefreshChangesCheck = "" Then
   SplashTextOn("", "FINISHED!", 150, 50, -1, -1, 0, "", 10)
    Sleep(3000)
   SplashOff()
   Return
EndIf
ApplyChangesOnExit()
EndFunc


Func RefreshExplorer()
While ProcessExists("explorer.exe")
   Run("explorer.exe",Call(ProcessClose("explorer.exe")))
WEnd
;  EnvUpdate()
  Run("Explorer.exe")
;  MsgBox(262144,"","Done")

EndFunc


Func RefreshChangesCheck($x)
local $n = StringInStr ( $RefreshChangesCheck, $x & @LF )
If $n = 0 Then $RefreshChangesCheck = $RefreshChangesCheck & $x & @LF
If $n >0 Then $RefreshChangesCheck = StringReplace ( $RefreshChangesCheck, $x & @LF, "")
EndFunc


Func HideMainGUI()
  GUISetState(@SW_HIDE, $listGUI)
  GUISetState(@SW_DISABLE, $listGUI)
  Opt("GUIOnEventMode", 1)
EndFunc


Func ShowMainGUI()
  GUISetState(@SW_HIDE, $listGUI)
  GUISetState(@SW_SHOW, $listGUI)
;  GUISetState(@SW_SHOWNORMAL, $listGUI)
  GUISetState(@SW_ENABLE, $listGUI)

EndFunc


Func  CheckOld_PS_CMD()
; The patch to Hard_Configurator v. 3.0.0.1
  Local $partkey = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers\0\Paths\{1016bbe0-a716-428b-822e-5E544B6A310'
  Local $BlockSponsorsKey = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers\BlockSponsors'
  If RegRead($partkey & '0}', 'ItemData') = 'powershell.exe' Then RegWrite($BlockSponsorsKey, 'IsPowerShellBlocked', 'REG_DWORD',Number('1'))
  If RegRead($partkey & '1}', 'ItemData') = 'powershell_ise.exe' Then RegWrite($BlockSponsorsKey, 'IsPowerShell_iseBlocked', 'REG_DWORD',Number('1'))
  If RegRead($partkey & '2}', 'ItemData') = 'cmd.exe' Then RegWrite($BlockSponsorsKey, 'IsCMDBlocked', 'REG_DWORD',Number('1'))
EndFunc


Func RegReadLine($x, $n)
; $n = n-th line in the settings file
;  $x = registry value in the temporary registry key, for example:
;  'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator'
;  $x = "text_ini"
  $n = $n - 1
  If $n < 0 Then Return 'ERROR'
  If $n > 22 Then Return 'ERROR'
; Load settings for INI section from the temporary Registry key to the Array.
  Local $Array = TempReg2Array('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator', $x)
  If Ubound($Array) < 16 Then _ArrayAdd($Array, "")
  If Ubound($Array) < 17 Then _ArrayAdd($Array, "")
  If Ubound($Array) < 18 Then _ArrayAdd($Array, "")
  If Ubound($Array) < 19 Then _ArrayAdd($Array, "")
  If Ubound($Array) < 20 Then _ArrayAdd($Array, "")
  If Ubound($Array) < 21 Then _ArrayAdd($Array, "")
  Return $Array[$n]
EndFunc


Func TempReg2Array($x, $y)
  #include <MsgBoxConstants.au3>
  #include <Array.au3> ; Required for _ArrayDisplay() only.
; $x = registry key and $y = registry value, for example
;  'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator'
;  "text_ini"
  Local $aArray[1] =[""]
  Local $sVar = RegRead($x, $y)
  Local $element
  Local $n
  ;MsgBox($MB_SYSTEMMODAL, "", $sVar)

  While StringLen ( $sVar ) > 1
    ;MsgBox($MB_SYSTEMMODAL, "", StringLen ( $sVar ))
    $n = StringInStr ( $sVar, @CRLF)
    $element = StringLeft ( $sVar, $n-1)
    _ArrayAdd($aArray, $element)
    $sVar = StringRight ( $sVar,StringLen ( $sVar )-$n)
    $sVar = StringTrimLeft($sVar, 1)
  WEnd
  ;Delete the empty record
  _ArrayPush($aArray,"")
  _ArrayPop($aArray)
 ;_ArrayDisplay($aArray)

  Return $aArray
EndFunc

Func CheckDefaultCurrentWhitelistedFolders()
Local $key = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers\262144\Paths\'
Local $flag = '1'
;Windows 64Bit related
If @OSArch = "X64" Then
   If not ( RegRead($key & '{6D809377-6AF0-444B-8957-A3773F02200E}', 'Description') = '*Default : Program Files on 64 bits') Then $flag = '0'
   If not ( RegRead($key & '{6D809377-6AF0-444B-8957-A3773F02200E}', 'SaferFlags') = Number('0')) Then $flag = '0'
   If not ( RegRead($key & '{6D809377-6AF0-444B-8957-A3773F02200E}', 'ItemData') = '%HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\ProgramW6432Dir%') Then $flag = '0'
   If not ( RegRead($key & '{7C5A40EF-A0FB-4BFC-874A-C0F2E0B9FA8E}', 'Description') = '*Default : Program Files (x86) on 64 bits') Then $flag = '0'
   If not ( RegRead($key & '{7C5A40EF-A0FB-4BFC-874A-C0F2E0B9FA8E}', 'SaferFlags') = Number('0')) Then $flag = '0'
   If not ( RegRead($key & '{7C5A40EF-A0FB-4BFC-874A-C0F2E0B9FA8E}', 'ItemData') = '%HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\ProgramFilesDir (x86)%') Then $flag = '0'
EndIf
If (@OSVersion="WIN_10" or @OSVersion="WIN_81" or @OSVersion="WIN_8") Then
   If not ( RegRead($key & '{f073d7e6-ec43-4bf6-a2a8-536eb63b03c8}', 'Description') = '*Default : ProgramData\Microsoft\Windows Defender') Then $flag = '0'
   If not ( RegRead($key & '{f073d7e6-ec43-4bf6-a2a8-536eb63b03c8}', 'SaferFlags') = Number('0')) Then $flag = '0'
   If not ( RegRead($key & '{f073d7e6-ec43-4bf6-a2a8-536eb63b03c8}', 'ItemData') = '%HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\ProductAppDataPath%') Then $flag = '0'
EndIf
If not ( RegRead($key & '{905E63B6-C1BF-494E-B29C-65B732D3D21A}', 'Description') = '*Default : Program Files (default)') Then $flag = '0'
If not ( RegRead($key & '{905E63B6-C1BF-494E-B29C-65B732D3D21A}', 'SaferFlags') = Number('0')) Then $flag = '0'
If not ( RegRead($key & '{905E63B6-C1BF-494E-B29C-65B732D3D21A}', 'ItemData') = '%HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\ProgramFilesDir%') Then $flag = '0'
If not ( RegRead($key & '{F38BF404-1D43-42F2-9305-67DE0B28FC23}', 'Description') = '*Default : Windows') Then $flag = '0'
If not ( RegRead($key & '{F38BF404-1D43-42F2-9305-67DE0B28FC23}', 'SaferFlags') = Number('0')) Then $flag = '0'
If not ( RegRead($key & '{F38BF404-1D43-42F2-9305-67DE0B28FC23}', 'ItemData') = '%HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\SystemRoot%') Then $flag = '0'
;MsgBox(262144,"",$flag)
Return $flag
EndFunc


Func _RegValueEqualTo($s_key, $s_val, $s_data)
;MsgBox(0,"", $s_key & @CRLF & _RegValueExists($s_key, $s_val))
Local $reg = RegRead($s_key, $s_val)
Local $is_error = @error
If ($is_error = 0 And $reg = $s_data) Then
   Return 1
Else
   Return 0
EndIf
EndFunc


Func CheckSystemWideDocumentsAntiExploit()
   Local $n = 0
   Local $m = 0
  ;Block VBA interpreter in Microsoft Excel, Microsoft FrontPage, Microsoft Outlook, Microsoft PowerPoint, Microsoft Publisher, and Microsoft Word
   $n = $n + _RegValueEqualTo('HKLM\Software\Policies\Microsoft\Office\16.0\Common', 'VBAOFF', Number('1'))
   $n = $n + _RegValueEqualTo('HKLM\Software\Policies\Microsoft\Office\15.0\Common', 'VBAOFF', Number('1'))
   $n = $n + _RegValueEqualTo('HKLM\Software\Policies\Microsoft\Office\14.0\Common', 'VBAOFF', Number('1'))
   $n = $n + _RegValueEqualTo('HKLM\Software\Policies\Microsoft\Office\12.0\Common', 'VBAOFF', Number('1'))
   $n = $n + _RegValueEqualTo('HKLM\Software\Policies\Microsoft\Office\11.0\Common', 'VBAOFF', Number('1'))
   $n = $n + _RegValueEqualTo('HKLM\Software\Policies\Microsoft\Office\10.0\Common', 'VBAOFF', Number('1'))
;  If the below $n = 6 then VBA interpreter is enabled, If $n = 0 then VBA interpreter is disbled

  ;ADOBE READEER
  ;Adobe Acrobat 10+ on Windows 64-bit Enables Protected Mode globally and thereby sandboxes Reader processes
  ;Adobe Reader 10+
   If @OSArch = "X64" Then
      $m = $m + _RegValueEqualTo('HKLM\SOFTWARE\Wow6432Node\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown', 'bProtectedMode', Number('1'))
     ;Adobe Reader 9.5 and 10.1.2+ 
      $m = $m + _RegValueEqualTo('HKLM\SOFTWARE\Wow6432Node\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown', 'bDisableJavaScript', Number('1'))
     ;Enhanced security when the application is running in the browser Adobe Reader 9+
      $m = $m + _RegValueEqualTo('HKLM\SOFTWARE\Wow6432Node\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown', 'bEnhancedSecurityInBrowser', Number('1'))
      $m = $m + _RegValueEqualTo('HKLM\SOFTWARE\Wow6432Node\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown', 'bEnhancedSecurityStandalone', Number('1'))
     ;11.0+ (Acrobat Reader)
      $m = $m + _RegValueEqualTo('HKLM\SOFTWARE\Wow6432Node\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown', 'iProtectedView', Number('2'))
     ;Enable AppContainer Adobe Reader beta spring 2018
      $m = $m + _RegValueEqualTo('HKLM\SOFTWARE\Wow6432Node\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown', 'bEnableProtectedModeAppContainer', Number('1'))
   EndIf
  ;Adobe Acrobat 10+ on Windows 32-bit Enables Protected Mode globally and thereby sandboxes Reader processes
   $m = $m + _RegValueEqualTo('HKLM\SOFTWARE\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown', 'bProtectedMode', Number('1'))
   $m = $m + _RegValueEqualTo('HKLM\SOFTWARE\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown', 'bDisableJavaScript', Number('1'))
   $m = $m + _RegValueEqualTo('HKLM\SOFTWARE\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown', 'bEnhancedSecurityInBrowser', Number('1'))
   $m = $m + _RegValueEqualTo('HKLM\SOFTWARE\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown', 'bEnhancedSecurityStandalone', Number('1'))
   $m = $m + _RegValueEqualTo('HKLM\SOFTWARE\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown', 'iProtectedView', Number('2'))
   $m = $m + _RegValueEqualTo('HKLM\SOFTWARE\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown', 'bEnableProtectedModeAppContainer', Number('1'))
   If @OSArch = "X64" Then
      $m = $m + _RegValueEqualTo('HKLM\SOFTWARE\Wow6432Node\Policies\Adobe\Acrobat Reader\11.0\FeatureLockDown', 'bProtectedMode', Number('1'))
      $m = $m + _RegValueEqualTo('HKLM\SOFTWARE\Wow6432Node\Policies\Adobe\Acrobat Reader\11.0\FeatureLockDown', 'bDisableJavaScript', Number('1'))
      $m = $m + _RegValueEqualTo('HKLM\SOFTWARE\Wow6432Node\Policies\Adobe\Acrobat Reader\11.0\FeatureLockDown', 'bEnhancedSecurityInBrowser', Number('1'))
      $m = $m + _RegValueEqualTo('HKLM\SOFTWARE\Wow6432Node\Policies\Adobe\Acrobat Reader\11.0\FeatureLockDown', 'bEnhancedSecurityStandalone', Number('1'))
      $m = $m + _RegValueEqualTo('HKLM\SOFTWARE\Wow6432Node\Policies\Adobe\Acrobat Reader\11.0\FeatureLockDown', 'iProtectedView', Number('2'))
   EndIf
   $m = $m + _RegValueEqualTo('HKLM\SOFTWARE\Policies\Adobe\Acrobat Reader\11.0\FeatureLockDown', 'bProtectedMode', Number('1'))
   $m = $m + _RegValueEqualTo('HKLM\SOFTWARE\Policies\Adobe\Acrobat Reader\11.0\FeatureLockDown', 'bDisableJavaScript', Number('1'))
   $m = $m + _RegValueEqualTo('HKLM\SOFTWARE\Policies\Adobe\Acrobat Reader\11.0\FeatureLockDown', 'bEnhancedSecurityInBrowser', Number('1'))
   $m = $m + _RegValueEqualTo('HKLM\SOFTWARE\Policies\Adobe\Acrobat Reader\11.0\FeatureLockDown', 'bEnhancedSecurityStandalone', Number('1'))
   $m = $m + _RegValueEqualTo('HKLM\SOFTWARE\Policies\Adobe\Acrobat Reader\11.0\FeatureLockDown', 'iProtectedView', Number('2'))


   If ($n<0 Or $n>6)   Then Return '?'
   If @OSArch = "X64" Then
	If ($n=6 And $m=22) Then Return 'Adobe + VBA'
	If ($n=0 And $m=22) Then Return 'Adobe' 
 	If ($n=0 And $m=0)  Then Return 'OFF'
	If ($m<0 Or $m>22) Then Return '?'
	Return 'Partial'
   EndIf
   If @OSArch = "X86" Then
	If ($n=6 And $m=11) Then Return 'Adobe + VBA'
	If ($n=0 And $m=11) Then Return 'Adobe' 
 	If ($n=0 And $m=0)  Then Return 'OFF'
	If ($m<0 Or $m>11) Then Return '?'
	Return 'Partial'
   EndIf
EndFunc

Func SystemWideDocumentsAntiExploit()
Switch $SystemWideDocumentsAntiExploit
	case 'Adobe + VBA'
		SystemWideDocumentsAntiExploit1('Adobe')
	case 'Adobe'
		SystemWideDocumentsAntiExploit1('OFF')
	case 'OFF'
		SystemWideDocumentsAntiExploit1('Adobe + VBA')
	case 'Partial'
		SystemWideDocumentsAntiExploit1('OFF')
	case '?'
		SystemWideDocumentsAntiExploit1('OFF')
	case Else
		SystemWideDocumentsAntiExploit1('Adobe + VBA')		
EndSwitch
;Delete the Switch OFF/ON Restrictions backup
RegDelete($BackupSwitchRestrictions)

ShowRegistryTweaks()

EndFunc


Func UpdateHard_Configurator()
   Local $OSArchitecture = "(x86)_"
   If @OSArch = "X64" Then $OSArchitecture = "(x64)_"
   Local $DownloadComplete
;   $Hard_ConfiguratorVersion = '3.0.1.0'
;  Download the file in the background with the selected option of 'force a reload from the remote site.'
   Local $hDownload = InetGet("https://raw.githubusercontent.com/AndyFul/Hard_Configurator/master/version.txt", $ProgramFolder & 'Temp\version.txt', $INET_FORCERELOAD, $INET_DOWNLOADBACKGROUND)
;  Wait for the download to complete by monitoring when the 2nd index value of InetGetInfo returns True.
   Do
      Sleep(250)
   Until InetGetInfo($hDownload, $INET_DOWNLOADCOMPLETE)
   InetClose($hDownload)
   If FileExists($ProgramFolder & 'Temp\version.txt') = 0 Then
      MsgBox(0,"","Can't access the Hard_Configurator webpage." & @CRLF & "Please check your Internet connection.")
      Return
   EndIf
   Local $version = FileReadLine($ProgramFolder & 'Temp\version.txt') 
   Local $beta
   Local $sFilePath = $ProgramFolder & "Temp\" & "Hard_Configurator_setup" & $OSArchitecture & $beta & $version & ".exe"
   Local $urlpath = "https://github.com/AndyFul/Hard_Configurator/raw/master/Hard_Configurator_setup" & $OSArchitecture & $beta & $version & ".exe"
   If StringInStr($version, "beta_") > 0 Then 
      $beta = "beta_"
      $version = StringReplace($version, $beta, "")
   EndIf
;   MsgBox(0,"",$version)
   If $version > $Hard_ConfiguratorVersion Then
;	MsgBox(0,"","Downloading the new version " & $version)
     SplashTextOn("Warning", "Downloading the new version " & $version, 300, 50, -1, -1, 0, "", 10)
	$hDownload = InetGet($urlpath, $sFilePath, $INET_FORCERELOAD, 1)
; 	Wait for the download to complete by monitoring when the 2nd index value of InetGetInfo returns True.
	Do
	   Sleep(1000)
        Until InetGetInfo($hDownload, $INET_DOWNLOADCOMPLETE)
        InetClose($hDownload)
     SplashOff()
        Sleep(1000)
	If FileExists($sFilePath) = 0 Then
		 MsgBox(0,"",'Error when downloading the file. Please download the installer manually.')
		 Run("explorer.exe https://github.com/AndyFul/Hard_Configurator")
		 Return
	EndIf
	Local $YesNo = MsgBox(4,"", "The new version has been downloaded to the folder:" & @CRLF & $ProgramFolder & 'Temp' & @CRLF & 'Do you want to install the update?')
	Switch $YesNo
	    case 6
		Run($ProgramFolder & "Temp\" & "Hard_Configurator_setup" & $OSArchitecture & $beta & $version & ".exe")
		Exit
            case 7
                Return
	    case Else
	        Return
        EndSwitch
   Else
	MsgBox(0,"", "This Hard_Configurator version is up to date.")
EndIf
EndFunc


Func _GetCurrentUser()
    Local $result = DllCall("Wtsapi32.dll","int", "WTSQuerySessionInformationW", "Ptr", 0, "int", -1, "int", 5, "ptr*", 0, "dword*", 0)
    If @error Or $result[0] = 0 Then Return SetError(1,0,"")
    Local $User = DllStructGetData(DllStructCreate("wchar[" & $result[5] & "]" , $result[4]),1)
    DllCall("Wtsapi32.dll", "int", "WTSFreeMemory", "ptr", $result[4])
    Return $User
EndFunc

Func _GetCurrentUserSID()
    ; Prog@ndy
    Local $User = _Security__LookupAccountName(_GetCurrentUser(),@ComputerName)
    If @error Then Return SetError(1,0,"")
    Return $User[0]
EndFunc


; Run By SmartScreen functions
;*****************************************************************************
Func ADD_WSH_TO_ExplorerContextMenu()
RegRead('HKEY_CLASSES_ROOT\WSHFile', 'IsShortcut')
If not @error Then 
   RegDelete('HKEY_CLASSES_ROOT\WSHFile', 'IsShortcut')
   RegWrite('HKEY_CLASSES_ROOT\WSHFile', 'NoIsShortcut', 'REG_SZ','')
EndIf
EndFunc


Func REMOVE_WSH_FROM_ExplorerContextMenu()
RegRead('HKEY_CLASSES_ROOT\WSHFile', 'NoIsShortcut')
If not @error Then 
   RegDelete('HKEY_CLASSES_ROOT\WSHFile', 'NoIsShortcut')
   RegWrite('HKEY_CLASSES_ROOT\WSHFile', 'IsShortcut', 'REG_SZ','')
EndIf
EndFunc


Func ADD_URL_TO_ExplorerContextMenu()
RegRead('HKCR\IE.AssocFile.URL', 'IsShortcut')
If not @error Then 
   RegWrite('HKEY_CLASSES_ROOT\IE.AssocFile.URL', 'NoIsShortcut', 'REG_SZ','')
   RegDelete('HKEY_CLASSES_ROOT\IE.AssocFile.URL', 'IsShortcut')
EndIf
RegRead('HKEY_CLASSES_ROOT\InternetShortcut', 'IsShortcut')
If not @error Then 
   RegDelete('HKEY_CLASSES_ROOT\InternetShortcut', 'IsShortcut')
   RegWrite('HKEY_CLASSES_ROOT\InternetShortcut', 'NoIsShortcut', 'REG_SZ','')
EndIf
EndFunc

Func REMOVE_URL_FROM_ExplorerContextMenu()
RegRead('HKEY_CLASSES_ROOT\IE.AssocFile.URL', 'NoIsShortcut')
If not @error Then 
   RegDelete('HKEY_CLASSES_ROOT\IE.AssocFile.URL', 'IsShortcut')
   RegDelete('HKEY_CLASSES_ROOT\IE.AssocFile.URL', 'NoIsShortcut')
   RegWrite('HKEY_CLASSES_ROOT\IE.AssocFile.URL', 'IsShortcut', 'REG_SZ','')
EndIf
RegRead('HKEY_CLASSES_ROOT\InternetShortcut', 'NoIsShortcut')
If not @error Then 
   RegDelete('HKEY_CLASSES_ROOT\InternetShortcut', 'NoIsShortcut')
   RegWrite('HKEY_CLASSES_ROOT\InternetShortcut', 'IsShortcut', 'REG_SZ','')
EndIf
EndFunc


Func ADD_apprefms_TO_ExplorerContextMenu()
RegRead('HKEY_CLASSES_ROOT\Application.Reference', 'IsShortcut')
If not @error Then 
   RegDelete('HKEY_CLASSES_ROOT\Application.Reference', 'IsShortcut')
   RegWrite('HKEY_CLASSES_ROOT\Application.Reference', 'NoIsShortcut', 'REG_SZ','')
EndIf
EndFunc


Func REMOVE_apprefms_FROM_ExplorerContextMenu()
RegRead('HKEY_CLASSES_ROOT\Application.Reference', 'NoIsShortcut')
If not @error Then 
   RegDelete('HKEY_CLASSES_ROOT\Application.Reference', 'NoIsShortcut')
   RegWrite('HKEY_CLASSES_ROOT\Application.Reference', 'IsShortcut', 'REG_SZ','')
EndIf
EndFunc

Func ADD_PIF_TO_ExplorerContextMenu()
RegRead('HKEY_CLASSES_ROOT\piffile', 'IsShortcut')
If not @error Then 
   RegDelete('HKEY_CLASSES_ROOT\piffile', 'IsShortcut')
   RegWrite('HKEY_CLASSES_ROOT\piffile', 'NoIsShortcut', 'REG_SZ','')
EndIf
EndFunc


Func REMOVE_PIF_FROM_ExplorerContextMenu()
RegRead('HKEY_CLASSES_ROOT\piffile', 'NoIsShortcut')
If not @error Then 
   RegDelete('HKEY_CLASSES_ROOT\piffile', 'NoIsShortcut')
   RegWrite('HKEY_CLASSES_ROOT\piffile', 'IsShortcut', 'REG_SZ','')
EndIf
EndFunc

Func ADD_WEBSITE_TO_ExplorerContextMenu()
RegRead('HKCR\IE.AssocFile.WEBSITE', 'IsShortcut')
If not @error Then
   RegDelete('HKCR\IE.AssocFile.WEBSITE', 'IsShortcut')
   RegWrite('HKCR\IE.AssocFile.WEBSITE', 'NoIsShortcut', 'REG_SZ','')
EndIf
RegRead('HKCR\Microsoft.Website', 'IsShortcut')
If not @error Then
   RegDelete('HKCR\Microsoft.Website', 'IsShortcut')
   RegWrite('HKCR\Microsoft.Website', 'NoIsShortcut', 'REG_SZ','')
EndIf
EndFunc

Func REMOVE_WEBSITE_FROM_ExplorerContextMenu()
RegRead('HKEY_CLASSES_ROOT\IE.AssocFile.WEBSITE', 'NoIsShortcut')
If not @error Then 
   RegDelete('HKEY_CLASSES_ROOT\IE.AssocFile.WEBSITE', 'NoIsShortcut')
   RegWrite('HKEY_CLASSES_ROOT\IE.AssocFile.WEBSITE', 'IsShortcut', 'REG_SZ','')
EndIf
RegRead('HKEY_CLASSES_ROOT\Microsoft.Website', 'NoIsShortcut')
If not @error Then 
   RegDelete('HKEY_CLASSES_ROOT\Microsoft.Website', 'NoIsShortcut')
   RegWrite('HKEY_CLASSES_ROOT\Microsoft.Website', 'IsShortcut', 'REG_SZ','')
EndIf
EndFunc


;**********************************************************************************

Func _CheckDisableSMB()
Local $keyname = 'HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb10'
Local $valuename = 'Start'
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
$x= RegRead ( $keyname, $valuename )
If @error <> 0 Then $x = '1'
$DisableSMB = $DisableSMB & $x

;Correction to invalid registry values after Windows upgrade
If $DisableSMB = '43' & 'Bowser' & @LF & 'MRxSmb20' & @LF & 'NSI' & '00' Then
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb20', 'Start', 'REG_DWORD', Number('4'))
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation', 'DependOnService', 'REG_MULTI_SZ', 'Bowser' & @LF & 'NSI')
   $DisableSMB = '44' & 'Bowser' & @LF & 'NSI' & '00'
EndIf
If $DisableSMB = '23' & 'Bowser' & @LF & 'MRxSmb20' & @LF & 'NSI' & '00' Then
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb10', 'Start', 'REG_DWORD', Number('4'))
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb20', 'Start', 'REG_DWORD', Number('4'))
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation', 'DependOnService', 'REG_MULTI_SZ', 'Bowser' & @LF & 'NSI')
   $DisableSMB = '44' & 'Bowser' & @LF & 'NSI' & '00'
EndIf
If $DisableSMB = '23' & 'Bowser' & @LF & 'MRxSmb20' & @LF & 'NSI' & '01' Then
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb10', 'Start', 'REG_DWORD', Number('4'))
   $DisableSMB = '43' & 'Bowser' & @LF & 'MRxSmb20' & @LF & 'NSI' & '01'
EndIf

Switch $DisableSMB
   case '44' & 'Bowser' & @LF & 'NSI' & '00'
      $DisableSMB = "ON123"
;      $MoreRestrictionsOutput = $MoreRestrictionsOutput & '3'
   case '43' & 'Bowser' & @LF & 'MRxSmb20' & @LF & 'NSI' & '01'
      $DisableSMB = "ON1"
;      $MoreRestrictionsOutput = $MoreRestrictionsOutput & '1'
   case '33' & 'Bowser' & @LF & 'MRxSmb10' & @LF & 'MRxSmb20' & @LF & 'NSI' & '11'
      If (@OSVersion="WIN_8" or @OSVersion="WIN_7" or @OSVersion="WIN_VISTA") Then
         $DisableSMB = "OFF"
;         $MoreRestrictionsOutput = $MoreRestrictionsOutput & '0'   
      Else
         $DisableSMB = "?"
;         $MoreRestrictionsOutput = $MoreRestrictionsOutput & '?'   
      EndIf
   case '23' & 'Bowser' & @LF & 'MRxSmb20' & @LF & 'NSI' & '11'
      If (@OSVersion="WIN_10" or @OSVersion="WIN_81") Then
         $DisableSMB = "OFF"
;         $MoreRestrictionsOutput = $MoreRestrictionsOutput & '0'   
      Else
         $DisableSMB = "?"
;         $MoreRestrictionsOutput = $MoreRestrictionsOutput & '?'  
      EndIf 
   case Else
      $DisableSMB = "?"
;      $MoreRestrictionsOutput = $MoreRestrictionsOutput & '?'         
EndSwitch
EndFunc


Func Disable_SMB()
  DisableSMB('0')
  ShowRegistryTweaks()
EndFunc


Func DisableSMB($flag)
StringReplace($RefreshChangesCheck, "DisableSMB" & @LF, "")
$RefreshChangesCheck = $RefreshChangesCheck & "DisableSMB" & @LF
Local $x1 = RegRead('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB1')
If not ($x1 = '1') Then $x1 = '0'
Local $x2 = RegRead('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB2')
If not ($x2 = '1') Then $x2 = '0'

; ON123 (00) > OFF (11) > ON1 (01) > 
; Disable SMBv2 and SMBv3 on the SMB server and on SMB client.

; If '01' -> '00'
If ($x1='0' And $x2='1') Then
   If CorrectSMB10Uninstalled() = 0 Then RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb10', 'Start', 'REG_DWORD', Number('4'))
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb20', 'Start', 'REG_DWORD', Number('4'))
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation', 'DependOnService','REG_MULTI_SZ', 'Bowser' & @LF & 'NSI')
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB1', 'REG_DWORD', Number('0'))
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB2', 'REG_DWORD', Number('0'))
;  Delete the Switch OFF/ON Restrictions backup
   If $flag = '0' Then RegDelete($BackupSwitchRestrictions)
   Return
EndIf

; If '00' -> '11'
If ($x1='0' And $x2='0') Then
   If (@OSVersion="WIN_10" or  @OSVersion="WIN_81") Then
      If CorrectSMB10Uninstalled() = 0 Then RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb10', 'Start', 'REG_DWORD', Number('2'))
      RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation', 'DependOnService','REG_MULTI_SZ', 'Bowser' & @LF & 'MRxSmb20' & @LF & 'NSI')
   Else
      If CorrectSMB10Uninstalled() = 0 Then RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb10', 'Start', 'REG_DWORD', Number('3'))
      RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation', 'DependOnService','REG_MULTI_SZ', 'Bowser' & @LF & 'MRxSmb10' & @LF & 'MRxSmb20' & @LF & 'NSI')
   EndIf
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb20', 'Start', 'REG_DWORD', Number('3'))
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB1', 'REG_DWORD', Number('1'))
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB2', 'REG_DWORD', Number('1'))
;  Delete the Switch OFF/ON Restrictions backup
   If $flag = '0' Then RegDelete($BackupSwitchRestrictions)
   Return
EndIf

; If '11' -> '01'
If ($x1='1' And $x2='1') Then
   If CorrectSMB10Uninstalled() = 0 Then RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb10', 'Start', 'REG_DWORD', Number('4'))
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb20', 'Start', 'REG_DWORD', Number('3'))
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation', 'DependOnService','REG_MULTI_SZ', 'Bowser' & @LF & 'MRxSmb20' & @LF & 'NSI')
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB1', 'REG_DWORD', Number('0'))
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB2', 'REG_DWORD', Number('1'))
;  Delete the Switch OFF/ON Restrictions backup
   If $flag = '0' Then RegDelete($BackupSwitchRestrictions)
   Return
EndIf

; Not typical values -> set SMB values to OFF ('11')
If (@OSVersion="WIN_10" or  @OSVersion="WIN_81") Then
   If CorrectSMB10Uninstalled() = 0 Then RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb10', 'Start', 'REG_DWORD', Number('2'))
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation', 'DependOnService','REG_MULTI_SZ', 'Bowser' & @LF & 'MRxSmb20' & @LF & 'NSI')
Else
   If CorrectSMB10Uninstalled() = 0 Then RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb10', 'Start', 'REG_DWORD', Number('3'))
   RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation', 'DependOnService','REG_MULTI_SZ', 'Bowser' & @LF & 'MRxSmb10' & @LF & 'MRxSmb20' & @LF & 'NSI')
EndIf
RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb20', 'Start', 'REG_DWORD', Number('3'))
RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB1', 'REG_DWORD', Number('1'))
RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters', 'SMB2', 'REG_DWORD', Number('1'))

;Delete the Switch OFF/ON Restrictions backup
If $flag = '0' Then RegDelete($BackupSwitchRestrictions)

EndFunc

