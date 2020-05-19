#RequireAdmin
#NoTrayIcon

#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=C:\Windows\Hard_Configurator\Icons\Switch D-D.ico
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_Res_Comment=Compiled with AutoIt 3.3.14.2
#AutoIt3Wrapper_Res_Description=SwitchDefaultDeny
#AutoIt3Wrapper_Res_Fileversion=1.0.1.1
#AutoIt3Wrapper_Res_LegalCopyright=Copyright *  Andy Ful , April 2019
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <Array.au3>
#Include <File.au3>
#include <FileConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <StringConstants.au3>
#include <MsgBoxConstants.au3>

#include "MetroGUI_UDF.au3"
#include <GUIConstants.au3>
#include <Security.au3>
#include 'CurrentAccountDocumentAntiExploit.au3'
#include 'ExtMsgBox.au3'
#include 'CurrentUser.au3'

SwitchDefaultDeny()



Func SwitchDefaultDeny()

;Set Theme
_SetTheme("DarkTeal") ;See MetroThemes.au3 for selectable themes or to add more

;Create resizable Metro GUI
Global $Form1 = _Metro_CreateGUI("SwitchDefaultDeny", 400, 275, -1, -1, True)
_Metro_SetGUIOption($Form1, True , False)

;Add/create control buttons to the GUI
$Control_Buttons = _Metro_AddControlButtons(True, False, True, False, True) ;CloseBtn = True, MaximizeBtn = True, MinimizeBtn = True, FullscreenBtn = True, MenuBtn = True

;Set variables for the handles of the GUI-Control buttons. (Above function always returns an array this size and in this order, no matter which buttons are selected.)
$GUI_CLOSE_BUTTON = $Control_Buttons[0]
$GUI_MINIMIZE_BUTTON = $Control_Buttons[3]
$GUI_MENU_BUTTON = $Control_Buttons[6]
;======================================================================================================================================================================
If not (@ScriptDir = @WindowsDir & "\Hard_Configurator") Then 
   MsgBox(0, "", "Wrong program location. This application should be copied to Hard_Configurator program folder (usually C:\Windows\Hard_Configurator).") 
   Exit
EndIf

If isSRPHard_ConfiguratorInstalled() > 0 Then 
   MsgBox(262144,"","Hard_Configurator SRP not installed.")
   Exit
EndIf
;Create  Buttons
$Button0 = GUICtrlCreateButton("", 0, 0, 1, 1)

;   Create a label
Local $LabelSwitchDefaultDeny = GUICtrlCreateLabel ("SwitchDefaultDeny", 40, 10, 200, 16,$SS_CENTER,-1)
GUICtrlSetColor($LabelSwitchDefaultDeny, 0xffffff)
GUICtrlSetFont ($LabelSwitchDefaultDeny, 9, 500)
GUICtrlSetBkColor($LabelSwitchDefaultDeny, "0x000000")

;;;;$Button1 = _Metro_CreateButton("Default Deny Protection", 45, 59, 200, 80, $ButtonBKColor, "0xffffff", "Courier", 14)
$Button1 = GUICtrlCreateButton(@crlf & "Default Deny Protection", 45, 59, 200, 40)
;GUICtrlSetOnEvent($Button1, "HelpDefaultDenyProtection")
GUICtrlSetColor($Button1, 0xffffff)
GUICtrlSetBkColor($Button1, "0x00796b")
GUICtrlSetFont($Button1, 10, 600, 0, "Arial", 5)


;$Button2 = GUICtrlCreateButton(@crlf & "Documents Anti-Exploit" & @crlf & "for current account", 45, 134, 180, 60, $BS_MULTILINE)
$Button2 = GUICtrlCreateButton("Documents Anti-Exploit", 45, 124, 200, 40)
;GUICtrlSetOnEvent($Button2, "HelpDocumentsMSOAntiExploitCA")
GUICtrlSetColor($Button2, 0xffffff)
GUICtrlSetBkColor($Button2, "0x0079cb")
GUICtrlSetFont($Button2, 10, 600, 0, "Arial", 5)

Local $ButtonHelpDocumentsAntiExploit = GUICtrlCreateButton("HELP", 270, 130, 80, 30)
GUICtrlSetColor($ButtonHelpDocumentsAntiExploit, 0xffffff)
GUICtrlSetBkColor($ButtonHelpDocumentsAntiExploit, "0x00796b")
GUICtrlSetFont($ButtonHelpDocumentsAntiExploit, 10, 600, 0, "Arial", 5)

$Button3 = GUICtrlCreateButton("Firewall Rules", 45, 189, 200, 40)
GUICtrlSetColor($Button3, 0xffffff)
GUICtrlSetBkColor($Button3, "0x0079cb")
GUICtrlSetFont($Button3, 10, 600, 0, "Arial", 5)

Local $ButtonHelpFirewallRules = GUICtrlCreateButton("HELP", 270, 195, 80, 30)
GUICtrlSetColor($ButtonHelpFirewallRules, 0xffffff)
GUICtrlSetBkColor($ButtonHelpFirewallRules, "0x00796b")
GUICtrlSetFont($ButtonHelpFirewallRules, 10, 600, 0, "Arial", 5)


$Toggle1 = _Metro_CreateOnOffToggle("ON", "OFF", 270, 65, 130, 30) ; Creates a toggle with different texts for on/off. Alternatively you can use _Metro_CreateOnOffToggleEx for the secondary toggle style.

;$Toggle2 = _Metro_CreateOnOffToggle("ON", "OFF", 270, 147, 130, 30) 


;Supported Windows versions check
If not (@OSVersion="WIN_10" or  @OSVersion="WIN_81" or @OSVersion="WIN_8" or @OSVersion="WIN_7" or @OSVersion="WIN_VISTA") Then
   MsgBox(262144, "", "Only Windows 10, Windows 8.1, Windows 7, and Windows Vista are supported.")
EndIf


If (@ScriptName = 'SwitchDefaultDeny(x64).exe' And @OSArch = "X86") Then
   MsgBox(262144,"","This file works only in 64-bit Windows version.")
   Exit
EndIf

If (@ScriptName = 'SwitchDefaultDeny(x86).exe' And @OSArch = "X64") Then
   MsgBox(262144,"","This file works only in 32-bit Windows version.")
   Exit
EndIf


Local $TempDefaultDenyKey
Local $DefaultDenyKey = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers'
Local $DefaultLevelNotConfigured = 0
Local $DefaultDenyData = RegRead($DefaultDenyKey, 'DefaultLevel')
If @error Then $DefaultLevelNotConfigured = 1
;MsgBox(0,"", $DefaultLevelNotConfigured & "     " & $DefaultDenyData)
Switch $DefaultDenyData
	case 0
		If $DefaultLevelNotConfigured = 0 Then _Metro_ToggleCheck($Toggle1)
	case 131072
		_Metro_ToggleCheck($Toggle1)
	case 262144
		_Metro_ToggleUnCheck($Toggle1)
        case Else
		_Metro_ToggleCheck($Toggle1)
EndSwitch

If $DefaultLevelNotConfigured = 1 Then _Metro_ToggleUnCheck($Toggle1)

;Local $TempDocumentMSOAntiExploit
;Local $DocumentMSOAntiExploitData = CheckCurrentAccountDocumentMSOAntiExploit()
;If @error Then $DocumentMSOAntiExploitData = '?'


;$idComboBoxDocumentMSOAntiExploit = GUICtrlCreateCombo("ON1", 270, 149, 80, 30)
;GUICtrlSetColor(-1, 0xffffff)
;GUICtrlSetBkColor(-1,0x000000)
;GUICtrlSetFont($idComboBoxDocumentMSOAntiExploit, 11, 500, 0, "Arial", 5)

;GUICtrlSetData($idComboBoxDocumentMSOAntiExploit, "OFF|ON2|OFF2|Partial|?", $DocumentMSOAntiExploitData)
;;MsgBox(0,"",$LoadingProfiles)




;Set resizing options for the controls so they don't change in size or position. This can be customized to match your gui perfectly for resizing. See AutoIt Help file.
GUICtrlSetResizing($Button1, 768 + 8)

GUICtrlSetResizing($Toggle1, 768 + 2 + 32)

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
			Local $MenuButtonsArray[4] = ["Help", "About", "Do not Start with Windows", "Exit"]
			; Open the metro Menu. See decleration of $MenuButtonsArray above.
			Local $MenuSelect = _Metro_MenuStart($Form1, 150, $MenuButtonsArray)
			Switch $MenuSelect ;Above function returns the index number of the selected button from the provided buttons array.
				Case "0"
;					ConsoleWrite("Returned 0 = Help button clicked. Please note that the window border colors are not updated during this demo." & @CRLF)
					HelpSwitchDefaultDeny()
				Case "1"
;					ConsoleWrite("Returned 1 = About button clicked." & @CRLF)
					_GUIDisable($Form1, 70)
					_Metro_MsgBox(0,"","SwitchDefaultDeny ver. 1.0.1.1" & @crlf & "Copyright by Andy Ful,   April 2019" & @crlf & "e-mail: Hard_Configurator@o2.pl" & @crlf & "dev. webpage: https://github.com/AndyFul/Hard_Configurator" ,500,12,"",20)
					_GUIDisable($Form1)
				Case "2"
;					ConsoleWrite("Returned 2 = Do not Start with Windows button clicked." & @CRLF)
					If _Metro_ToggleIsChecked($Toggle1) Then
						_GUIDisable($Form1, 70)
						_Metro_MsgBox(0,"","This application does not start with Windows when Default Deny Protection is set to ON.",500,12,"",10)
						_GUIDisable($Form1)
					Else
 					        _GUIDisable($Form1, 70)
						If _Metro_MsgBox(1,"","It is not recommended to disable the start of this application with Windows when Default Deny Protection is set to OFF." & @CRLF & "If you press the OK button, this application will not start with Windows and you will not be informed that Default Deny Protection is disabled.",600,12) = "OK" Then
						   RegDelete('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run', 'Hard_ConfiguratorSwitch')
						   _Metro_MsgBox(0,"","Finished.", 180,12,"",3)
						EndIf
					        _GUIDisable($Form1)
					EndIf
				Case "3"
;					ConsoleWrite("Returned 3 = Exit button clicked." & @CRLF)
					_Metro_GUIDelete($Form1)
					Exit
				Case Else
			EndSwitch
		Case $Toggle1
			If _Metro_ToggleIsChecked($Toggle1) Then
				_Metro_ToggleUnCheck($Toggle1)
				$TempDefaultDenyKey = RegRead($DefaultDenyKey, 'DefaultLevel')
				RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\Switch','DefaultLevel', 'REG_DWORD',$TempDefaultDenyKey)
				RegWrite($DefaultDenyKey, 'DefaultLevel', 'REG_DWORD', Number('262144'))
				If (@ScriptName = 'SwitchDefaultDeny(x64).exe') Then				
				   RegWrite('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run', 'Hard_ConfiguratorSwitch', 'REG_SZ', @WindowsDir & "\explorer.exe " & @WindowsDir & "\Hard_Configurator\SwitchDefaultDeny(x64).exe")
				EndIf
				If (@ScriptName = 'SwitchDefaultDeny(x86).exe') Then				
				   RegWrite('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run', 'Hard_ConfiguratorSwitch', 'REG_SZ', @WindowsDir & "\explorer.exe " & @WindowsDir & "\Hard_Configurator\SwitchDefaultDeny(x86).exe")
				EndIf
			Else
				_Metro_ToggleCheck($Toggle1)
				$TempDefaultDenyKey = RegRead('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\Switch','DefaultLevel')
				If @error Then $TempDefaultDenyKey = 131072
				If not ($TempDefaultDenyKey = 131072 or $TempDefaultDenyKey = 0) Then
					$TempDefaultDenyKey = 131072
				EndIf
				If ($TempDefaultDenyKey = 131072 or $TempDefaultDenyKey = 0) Then
					RegWrite($DefaultDenyKey, 'DefaultLevel', 'REG_DWORD', $TempDefaultDenyKey)
					RegDelete('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run', 'Hard_ConfiguratorSwitch')
					_GUIDisable($Form1, 70)
					If $TempDefaultDenyKey = 131072 Then _Metro_MsgBox(0,"","Default Security Level has been set to 'Basic User'.",500,12,"",10)
					If $TempDefaultDenyKey = 0 Then _Metro_MsgBox(0,"","Default Security Level has been set to 'Disallowed'.",500,12,"",10)			
					_GUIDisable($Form1)
				EndIf
			EndIf
;                Case  $Toggle2
;			If _Metro_ToggleIsChecked($Toggle2) Then
;				_Metro_ToggleUnCheck($Toggle1)
;				CurrentAccountDocumentsMSOAntiExploit1('OFF')
;			Else
;				_Metro_ToggleCheck($Toggle2)
;				CurrentAccountDocumentsMSOAntiExploit1('ON1')
;			EndIf
;		Case $idComboBoxDocumentMSOAntiExploit
;			$sComboRead = GUICtrlRead($idComboBoxDocumentMSOAntiExploit)
;			Switch $sComboRead
;			   Case 'ON1'
;				CurrentAccountDocumentsMSOAntiExploit1('ON1')	
;			        GUICtrlSetData($idComboBoxDocumentMSOAntiExploit, 'ON1')	
;				$DocumentMSOAntiExploitData = 'ON1'			
;			   Case 'ON2'
;				CurrentAccountDocumentsMSOAntiExploit1('ON2')
;			        GUICtrlSetData($idComboBoxDocumentMSOAntiExploit, 'ON2')	
;				$DocumentMSOAntiExploitData = 'ON2'
;			   Case 'OFF'
;				CurrentAccountDocumentsMSOAntiExploit1('OFF')
;			        GUICtrlSetData($idComboBoxDocumentMSOAntiExploit, 'OFF')
;				$DocumentMSOAntiExploitData = 'OFF'
;			   Case 'OFF2'
;				CurrentAccountDocumentsMSOAntiExploit1('OFF2')
;				$DocumentMSOAntiExploitData = CheckCurrentAccountDocumentMSOAntiExploit()
;			        GUICtrlSetData($idComboBoxDocumentMSOAntiExploit, $DocumentMSOAntiExploitData)
;			   Case 'Partial'
;				_GUIDisable($Form1, 70)
;				_Metro_MsgBox(0,"MS Office security settings","This option cannot be selected by the user. It is displayed only when the external program was used to change the settings." ,500,12)	
;				   _GUIDisable($Form1)
;	 		        GUICtrlSetData($idComboBoxDocumentMSOAntiExploit, $DocumentMSOAntiExploitData)
;			   Case '?'
;				_GUIDisable($Form1, 70)
;				_Metro_MsgBox(0,"MS Office security settings","This option cannot be selected by the user. It is displayed only when the external program was used to change the settings." ,500,12)	
;				   _GUIDisable($Form1)
;	 		        GUICtrlSetData($idComboBoxDocumentMSOAntiExploit, $DocumentMSOAntiExploitData)
;			   Case Else
;			EndSwitch
		Case $Button1
			HelpDefaultDenyProtection()
		Case $Button2
			If @OSArch = "X64" Then Run(@WindowsDir & "\Hard_Configurator\DocumentsAntiExploit(x64).exe")
			If @OSArch = "X86" Then Run(@WindowsDir & "\Hard_Configurator\DocumentsAntiExploit(x86).exe")
		Case $ButtonHelpDocumentsAntiExploit
			HelpDocumentsAntiExploitCA()
		Case $Button3
			If @OSArch = "X64" Then Run(@WindowsDir & "\Hard_Configurator\FirewallRules(x64).exe")
			If @OSArch = "X86" Then Run(@WindowsDir & "\Hard_Configurator\FirewallRules(x86).exe")
		Case Else
	EndSwitch
WEnd
EndFunc


Func isSRPHard_ConfiguratorInstalled()
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

Func HelpSwitchDefaultDeny()
Local $text1 = "SwitchDefaultDeny is a companion utility to Hard_Configurator. For now, two options are available:" & @crlf & "<Default Deny Protection> and <Documents Anti-Exploit>" & @crlf & @crlf & "The option <Default Deny Protection> works only when Software Restrictions Policies are properly activated in Hard_Configurator." & @crlf & "Press <Default Deny Protection> green button for more help." & @crlf & @crlf
Local $text2 =  "The option <Documents Anti-Exploit> runs DocumentsAntiExploit tool (external application). It can be used to harden MS Office and Adobe Acrobat Reader XI/DC applications." & @crlf & "Press the green <HELP> button on the right side of <Documents Anti-Exploit> for more help." & @crlf & @crlf 
Local $text3 = "There are also some additional options available from the menu:" & @crlf & @crlf & "* Help - shows this help." & @crlf & "* About - shows an info about SwitchDefaultDeny." & @crlf & "* Do not start with Windows - removes the autorun entry, so SwitchDefaultDeny does not start automatically with Windows." & @crlf & "* Exit - exits the utility." 
Local $text4 = ""
_SetTheme("LightTeal")
_GUIDisable($Form1, 70)
_Metro_MsgBox(0,"SwitchDefaultDeny Help",$text1 & $text2 & $text3 & $text4,800,10)
_GUIDisable($Form1)
_SetTheme("DarkTeal")

EndFunc


Func HelpDefaultDenyProtection()
Local $text1 = "The <Default Deny Protection> feature works only when Software Restrictions Policies are properly activated in Hard_Configurator. It can be useful for inexperienced users, when there are problems with application installations via Hard_Configurator 'Run As SmartScreen' or 'Run as administrator' features. In such case, the user can use SwitchDefaultDeny to:" & @crlf & "disable Default Deny Protection >> install applications >> enable Default Deny Protection." & @crlf &  @crlf & "When switching to the OFF setting, this utility simply changes SRP Default Security Level to Unrestricted (the old value is saved), and adds the autorun entry to start with Windows." & @crlf &  @crlf & "When switching to the ON setting, it restores the old SRP Default Security Level setting ('Basic User' or 'Disallowed') and removes the autorun entry."
Local $text2 = ""
Local $text3 = ""
_SetTheme("LightTeal")
_GUIDisable($Form1, 70)
_Metro_MsgBox(0,"Help for <Default Deny Protection>",$text1 & $text2 & $text3,800,10)
_GUIDisable($Form1)
_SetTheme("DarkTeal")

EndFunc


Func HelpDocumentsAntiExploitCA()

Local $text1 = "The option 'Documents Anti-Exploit' runs DocumentsAntiExploit tool (external application). It can be used to Harden MS Office and Adobe Acrobat Reader XI/DC applications. On the contrary to Hard_Configurator <Documents Anti-Exploit> system-wide feature, the DocumentsAntiExploit tool is focused on the current account from which was started. So, the user can apply the different restrictions on the different accounts." & @crlf & @crlf

Local $text2 = "DocumentsAntiExploit tool is copied to the Public Desktop when uninstalling Hard_Configurator, so the user can still use it to harden MS Office and Adobe Acrobat Reader XI/DC applications."

Local $text3 = "" 

_SetTheme("LightTeal")
_GUIDisable($Form1, 70)
_Metro_MsgBox(0,"Help for <Documents Anti-Exploit>",$text1 & $text2 & $text3,500,10)
_GUIDisable($Form1)
_SetTheme("DarkTeal")

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

