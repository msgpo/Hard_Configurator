Func MoreSRPRestrictions()

;GUI for additional SRP restrictions
;#include <EditConstants.au3>
;#include <GUIConstantsEx.au3>
;#include <WindowsConstants.au3>

;Global $M_SRPlistview
;Global $M_SRPlistGUI
Local  $deltaX=10

;GUISetState(@SW_DISABLE, $listGUI)
;GUISetState(@SW_HIDE,$listGUI)
;Opt("GUIOnEventMode", 1)
HideMainGUI()

; _GUICtrlListView_DeleteAllItems($Listview)

;  Opt("GUIOnEventMode", 1)
  If not $X_M_SRPlistGUI > 0 Then $X_M_SRPlistGUI = -1
  If not $Y_M_SRPlistGUI > 0 Then $Y_M_SRPlistGUI = -1

   $M_SRPlistGUI = GUICreate("More SRP Restrictions", 330, 500, $X_M_SRPlistGUI, $Y_M_SRPlistGUI, -1)
   GUISetOnEvent($GUI_EVENT_CLOSE, "CloseMoreSRPRestrictions")
   $M_SRPlistview = GUICtrlCreateListView("Settings", 10, 10, 100, 350)
   _GUICtrlListView_SetColumnWidth($M_SRPlistview, 0, 70)

  MoreSRPRestrictionsValues()

  GUICtrlCreateListViewItem($WritableSubWindows, $M_SRPlistview)
  GUICtrlCreateListViewItem($DenyShortcuts, $M_SRPlistview)
 
  $BtnWritableSubWindows = GUICtrlCreateButton("Protect Windows Folder",  117+$deltaX, 35, 140, 19)
  GUICtrlSetOnEvent(-1, "WritableSubWindows1")
  $BtnHelpWritableSubWindows = GUICtrlCreateButton("Help", 260+$deltaX, 35, 40, 19)
  GUICtrlSetOnEvent(-1, "Help7")

  $BtnDenyShortcuts = GUICtrlCreateButton("Protect Shortcuts", 117+$deltaX, 54, 140, 19)
  GUICtrlSetOnEvent(-1, "Deny_Shortcuts1")
  $BtnHelpDenyShortcuts = GUICtrlCreateButton("Help",  260+$deltaX, 54, 40, 19)
  GUICtrlSetOnEvent(-1, "Help8")


   $BtnEndExtensions = GUICtrlCreateButton("Close", 150, 330, 80, 30)
   GUICtrlSetOnEvent(-1, "CloseMoreSRPRestrictions")
   GUISetState(@SW_SHOW, $M_SRPlistGUI)

; Disable some buttons for earlier Windows versions
  If not (@OSVersion="WIN_10") Then
     _GUICtrlButton_Enable($BtnDisableUntrustedFonts, False)
     $GreyDisableUntrustedFonts = 1
  EndIf

If not ($isSRPinstalled = "Installed") Then
  _GUICtrlButton_Enable($BtnWritableSubWindows, False)
  _GUICtrlButton_Enable($BtnDenyShortcuts, False)
EndIf

EndFunc


Func WritableSubWindows1()
   WritableSubWindows('0')
EndFunc


Func Deny_Shortcuts1()
   Deny_Shortcuts('0')
EndFunc


Func CloseMoreSRPRestrictions()
   GuiDelete($M_SRPlistGUI)
;   GUISetState(@SW_ENABLE, $listGUI)
;   GUISetState(@SW_HIDE,$listGUI)
;   GUISetState(@SW_SHOW,$listGUI)
   ShowMainGUI()
   ShowRegistryTweaks()
EndFunc


Func RefreshMoreSRPRestrictionsGUI()
  Local $pos = WinGetPos ($M_SRPlistGUI)
  $X_M_SRPlistGUI = $pos[0] 
  $Y_M_SRPlistGUI = $pos[1]
  GUISetState(@SW_HIDE,$M_SRPlistGUI)
  GuiDelete($M_SRPlistGUI)
  MoreSRPRestrictions()
EndFunc

Func MoreSRPRestrictionsValues()
$MoreSRPRestrictionsOutput = ""

If $GreyWritableSubWindows = 0 Then
   $WritableSubWindows =  CheckWritableSubWindows()
   If ($SRPTransparentEnabled = "No Enforcement" or $SRPTransparentEnabled = "not found" or $SRPTransparentEnabled = "?") Then
      $WritableSubWindows = "0"
   EndIf
   Switch $WritableSubWindows
      case "0"
         $WritableSubWindows = "OFF"
         $MoreSRPRestrictionsOutput =  $MoreSRPRestrictionsOutput & '0'
      case 1
         $WritableSubWindows = "ON"
         $MoreSRPRestrictionsOutput =  $MoreSRPRestrictionsOutput & '1'
      case Else
         $WritableSubWindows = "?"
         $MoreSRPRestrictionsOutput =  $MoreSRPRestrictionsOutput & '?'
   EndSwitch
EndIf
If $GreyWritableSubWindows = 1 Then
   $WritableSubWindows = "OFF"
   $MoreSRPRestrictionsOutput =  $MoreSRPRestrictionsOutput & '0'
EndIf



local $guidname = '{1016bbe0-a716-428b-822e-5E544B6A3301}'
$keyname = 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\0\paths\' & $guidname
$valuename = "ItemData"
$DenyShortcuts = RegRead ( $keyname, $valuename )
$iskey = @error
If ($SRPTransparentEnabled = "No Enforcement" or $SRPTransparentEnabled = "not found" or $SRPTransparentEnabled = "?") Then
   $DenyShortcuts = "OFF"
EndIf
If ($iskey = -1 or $iskey =1) Then $DenyShortcuts = "OFF"
If ($SRPDefaultLevel = "White List" and $DenyShortcuts = "*.lnk") Then
   RegWrite($keyname, $valuename, 'REG_SZ', "protected")
   $DenyShortcuts = "protected"
   RefreshChangesCheck("Deny_Shortcuts")
EndIf 
If ($SRPDefaultLevel = "Basic User" and $DenyShortcuts = "protected") Then
   RegWrite($keyname, $valuename, 'REG_SZ', "*.lnk")
   $DenyShortcuts = "*.lnk"
   RefreshChangesCheck("Deny_Shortcuts")
EndIf 
Switch $DenyShortcuts
   case "*.lnk"
      $DenyShortcuts = "ON"
      $MoreSRPRestrictionsOutput =  $MoreSRPRestrictionsOutput & '1'
   case "protected"
      $DenyShortcuts = "ON"
      $MoreSRPRestrictionsOutput =  $MoreSRPRestrictionsOutput & '1'
   case "OFF"
      $MoreSRPRestrictionsOutput =  $MoreSRPRestrictionsOutput & '0'
   case Else
      $DenyShortcuts = "?"
      $MoreSRPRestrictionsOutput =  $MoreSRPRestrictionsOutput & '?'
EndSwitch

; Automatical correction of Protected Shortcuts feature for updates from version 4.0.0.0 and prior.
If $DenyShortcuts = "ON" Then
   If not (RegRead('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers\0\Paths\{A4BFCC3A-DB2C-424C-B029-7FE99A87C641}', 'ItemData') = '%USERPROFILE%\Desktop\*.lnk\*') Then
       $DenyShortcuts = "OFF"
       Deny_Shortcuts('1')
   EndIf
EndIf



EndFunc


;Func HelpM()
;   Local $help = FileRead(@WindowsDir & "\Hard_Configurator\HELP\helpM.txt")
;;   MsgBox(0,"", $help)
;   _ExtMsgBoxSet(1+4+8+32, 0, -1, -1, 10, "Arial", @DesktopWidth*0.7)
;  _ExtMsgBox(0,"OK", "", $help)
;EndFunc

