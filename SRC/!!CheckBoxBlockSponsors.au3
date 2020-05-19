Func CheckBoxBlockSponsors()

#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
    Global $BlockSponsorsGUI
    Global $MainBlockSponsorsGUI
    Global $X_BlockSponsorsGUI = 200
    Global $Y_BlockSponsorsGUI = 400

;****************************************
;    Global $BlockSponsorsNumber = 0
;    Global $idCheckboxCMD
;    Global $idCheckboxPowerShell
;    Global $DisablePowerShell
;    Global $DisablePowerShell_ise
;****************************************
;    GUISetState(@SW_DISABLE, $listGUI)
;    GUISetState(@SW_HIDE,$listGUI)
;    Opt("GUIOnEventMode", 1)
     HideMainGUI()

    If not ($X_BlockSponsorsGUI > 0) Then $X_BlockSponsorsGUI = -1
    If not ($Y_BlockSponsorsGUI > 0) Then $Y_BlockSponsorsGUI = -1

;   Create a GUI with various controls.
;    Local $BlockSponsorsGUI = GUICreate("Block Sponsors", $X_BlockSponsorsGUI, $Y_BlockSponsorsGUI)
     $MainBlockSponsorsGUI = GUICreate("Block Sponsors", 225, 535, -1, -1, -1)
     GUISetOnEvent($GUI_EVENT_CLOSE, "CloseBlockSponsors")



; Deselect All Button
    $BtnClearAll = GUICtrlCreateButton("Clear All", 50, 430, 85, 25)
    GUICtrlSetOnEvent(-1, "AllowAllSponsors1")

; Select All Button
    $BtnSelectAll = GUICtrlCreateButton("Select All", 50, 460, 85, 25)
    GUICtrlSetOnEvent(-1, "BlockAllSponsors1")


;   Close Button
    $BtnCloseBlockSponsors = GUICtrlCreateButton("Close", 50, 490, 85, 25)
    GUICtrlSetOnEvent(-1, "CloseBlockSponsors")

$BlockSponsorsGUI = GUICreate("Child GUI", 200, 400, 10, 10, $WS_CHILD, $WS_EX_CLIENTEDGE, $MainBlockSponsorsGUI)
;Opt("GUIOnEventMode", 1)
GUIRegisterMsg($WM_VSCROLL, "WM_VSCROLL")

; Set how long has to be the scroll window (is set as depending on the number of entries).
    _GUIScrollBars_Init ($BlockSponsorsGUI, -1, 4/3*$NumberOfExecutables)
    _GUIScrollBars_EnableScrollBar($BlockSponsorsGUI, $SB_HORZ, $ESB_DISABLE_LEFT)
    _GUIScrollBars_EnableScrollBar($BlockSponsorsGUI, $SB_HORZ, $ESB_DISABLE_RIGHT)

;************************
;   Create a checkbox controls.
;   Assign names of executables to array
    Arr_GetSponsorNames()
;   Create checkboxes
    $idCheckboxCMD = GUICtrlCreateCheckbox("Cmd.exe", 10, 10, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlockCMD")    

    $idCheckboxPowerShell = GUICtrlCreateCheckbox("Powershell.exe", 10, 30, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlockPowerShell") 

    $idCheckboxPowerShell_ise = GUICtrlCreateCheckbox("Powershell_ise.exe", 10, 50, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlockPowerShell_ise")       
 
    $idCheckbox1 = GUICtrlCreateCheckbox($arrBlockSponsors[1], 10, 50 + 20*1, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock1")    

    $idCheckbox2 = GUICtrlCreateCheckbox($arrBlockSponsors[2], 10, 50 + 20*2, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock2")    

    $idCheckbox3 = GUICtrlCreateCheckbox($arrBlockSponsors[3], 10, 50 + 20*3, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock3")    

    $idCheckbox4 = GUICtrlCreateCheckbox($arrBlockSponsors[4], 10, 50 + 20*4, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock4")    

    $idCheckbox5 = GUICtrlCreateCheckbox($arrBlockSponsors[5], 10, 50 + 20*5, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock5")    

    $idCheckbox6 = GUICtrlCreateCheckbox($arrBlockSponsors[6], 10, 50 + 20*6, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock6")    

    $idCheckbox7 = GUICtrlCreateCheckbox($arrBlockSponsors[7], 10, 50 + 20*7, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock7")    

    $idCheckbox8 = GUICtrlCreateCheckbox($arrBlockSponsors[8], 10, 50 + 20*8, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock8")    

    $idCheckbox9 = GUICtrlCreateCheckbox($arrBlockSponsors[9], 10, 50 + 20*9, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock9")    

    $idCheckbox10 = GUICtrlCreateCheckbox($arrBlockSponsors[10], 10, 50 + 20*10, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock10")    

    $idCheckbox11 = GUICtrlCreateCheckbox($arrBlockSponsors[11], 10, 50 + 20*11, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock11")    

    $idCheckbox12 = GUICtrlCreateCheckbox($arrBlockSponsors[12], 10, 50 + 20*12, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock12")    

    $idCheckbox13 = GUICtrlCreateCheckbox($arrBlockSponsors[13], 10, 50 + 20*13, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock13")    

    $idCheckbox14 = GUICtrlCreateCheckbox($arrBlockSponsors[14], 10, 50 + 20*14, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock14")    

    $idCheckbox15 = GUICtrlCreateCheckbox($arrBlockSponsors[15], 10, 50 + 20*15, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock15")    

    $idCheckbox16 = GUICtrlCreateCheckbox($arrBlockSponsors[16], 10, 50 + 20*16, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock16")    

    $idCheckbox17 = GUICtrlCreateCheckbox($arrBlockSponsors[17], 10, 50 + 20*17, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock17")    

    $idCheckbox18 = GUICtrlCreateCheckbox($arrBlockSponsors[18], 10, 50 + 20*18, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock18")    

    $idCheckbox19 = GUICtrlCreateCheckbox($arrBlockSponsors[19], 10, 50 + 20*19, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock19")    

    $idCheckbox20 = GUICtrlCreateCheckbox($arrBlockSponsors[20], 10, 50 + 20*20, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock20")    

    $idCheckbox21 = GUICtrlCreateCheckbox($arrBlockSponsors[21], 10, 50 + 20*21, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock21")    

    $idCheckbox22 = GUICtrlCreateCheckbox($arrBlockSponsors[22], 10, 50 + 20*22, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock22")    

    $idCheckbox23 = GUICtrlCreateCheckbox($arrBlockSponsors[23], 10, 50 + 20*23, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock23")    

    $idCheckbox24 = GUICtrlCreateCheckbox($arrBlockSponsors[24], 10, 50 + 20*24, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock24")    

    $idCheckbox25 = GUICtrlCreateCheckbox($arrBlockSponsors[25], 10, 50 + 20*25, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock25")    

    $idCheckbox26 = GUICtrlCreateCheckbox($arrBlockSponsors[26], 10, 50 + 20*26, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock26")    

    $idCheckbox27 = GUICtrlCreateCheckbox($arrBlockSponsors[27], 10, 50 + 20*27, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock27")    

    $idCheckbox28 = GUICtrlCreateCheckbox($arrBlockSponsors[28], 10, 50 + 20*28, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock28")    

    $idCheckbox29 = GUICtrlCreateCheckbox($arrBlockSponsors[29], 10, 50 + 20*29, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock29")    

    $idCheckbox30 = GUICtrlCreateCheckbox($arrBlockSponsors[30], 10, 50 + 20*30, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock30")    

    $idCheckbox31 = GUICtrlCreateCheckbox($arrBlockSponsors[31], 10, 50 + 20*31, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock31")    

    $idCheckbox32 = GUICtrlCreateCheckbox($arrBlockSponsors[32], 10, 50 + 20*32, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock32")    

    $idCheckbox33 = GUICtrlCreateCheckbox($arrBlockSponsors[33], 10, 50 + 20*33, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock33")    

    $idCheckbox34 = GUICtrlCreateCheckbox($arrBlockSponsors[34], 10, 50 + 20*34, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock34")    

    $idCheckbox35 = GUICtrlCreateCheckbox($arrBlockSponsors[35], 10, 50 + 20*35, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock35")    

    $idCheckbox36 = GUICtrlCreateCheckbox($arrBlockSponsors[36], 10, 50 + 20*36, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock36")    

    $idCheckbox37 = GUICtrlCreateCheckbox($arrBlockSponsors[37], 10, 50 + 20*37, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock37")    

    $idCheckbox38 = GUICtrlCreateCheckbox($arrBlockSponsors[38], 10, 50 + 20*38, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock38")    

    $idCheckbox39 = GUICtrlCreateCheckbox($arrBlockSponsors[39], 10, 50 + 20*39, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock39")    

    $idCheckbox40 = GUICtrlCreateCheckbox($arrBlockSponsors[40], 10, 50 + 20*40, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock40")    

    $idCheckbox41 = GUICtrlCreateCheckbox($arrBlockSponsors[41], 10, 50 + 20*41, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock41")    

    $idCheckbox42 = GUICtrlCreateCheckbox($arrBlockSponsors[42], 10, 50 + 20*42, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock42")    

    $idCheckbox43 = GUICtrlCreateCheckbox($arrBlockSponsors[43], 10, 50 + 20*43, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock43")    

    $idCheckbox44 = GUICtrlCreateCheckbox($arrBlockSponsors[44], 10, 50 + 20*44, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock44")    

    $idCheckbox45 = GUICtrlCreateCheckbox($arrBlockSponsors[45], 10, 50 + 20*45, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock45")    

    $idCheckbox46 = GUICtrlCreateCheckbox($arrBlockSponsors[46], 10, 50 + 20*46, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock46")    

    $idCheckbox47 = GUICtrlCreateCheckbox($arrBlockSponsors[47], 10, 50 + 20*47, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock47")    

    $idCheckbox48 = GUICtrlCreateCheckbox($arrBlockSponsors[48], 10, 50 + 20*48, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock48")    

    $idCheckbox49 = GUICtrlCreateCheckbox($arrBlockSponsors[49], 10, 50 + 20*49, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock49")    

    $idCheckbox50 = GUICtrlCreateCheckbox($arrBlockSponsors[50], 10, 50 + 20*50, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock50")    

    $idCheckbox51 = GUICtrlCreateCheckbox($arrBlockSponsors[51], 10, 50 + 20*51, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock51")    

    $idCheckbox52 = GUICtrlCreateCheckbox($arrBlockSponsors[52], 10, 50 + 20*52, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock52")    

    $idCheckbox53 = GUICtrlCreateCheckbox($arrBlockSponsors[53], 10, 50 + 20*53, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock53")    

    $idCheckbox54 = GUICtrlCreateCheckbox($arrBlockSponsors[54], 10, 50 + 20*54, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock54")  

    $idCheckbox55 = GUICtrlCreateCheckbox($arrBlockSponsors[55], 10, 50 + 20*55, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock55")  

    $idCheckbox56 = GUICtrlCreateCheckbox($arrBlockSponsors[56], 10, 50 + 20*56, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock56")  

    $idCheckbox57 = GUICtrlCreateCheckbox($arrBlockSponsors[57], 10, 50 + 20*57, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock57")  

    $idCheckbox58 = GUICtrlCreateCheckbox($arrBlockSponsors[58], 10, 50 + 20*58, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock58")  

    $idCheckbox59 = GUICtrlCreateCheckbox($arrBlockSponsors[59], 10, 50 + 20*59, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock59")  

    $idCheckbox60 = GUICtrlCreateCheckbox($arrBlockSponsors[60], 10, 50 + 20*60, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock60")  

    $idCheckbox61 = GUICtrlCreateCheckbox($arrBlockSponsors[61], 10, 50 + 20*61, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock61")  

    $idCheckbox62 = GUICtrlCreateCheckbox($arrBlockSponsors[62], 10, 50 + 20*62, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock62")  

    $idCheckbox63 = GUICtrlCreateCheckbox($arrBlockSponsors[63], 10, 50 + 20*63, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock63")  

    $idCheckbox64 = GUICtrlCreateCheckbox($arrBlockSponsors[64], 10, 50 + 20*64, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock64")  

    $idCheckbox65 = GUICtrlCreateCheckbox($arrBlockSponsors[65], 10, 50 + 20*65, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock65")  

    $idCheckbox66 = GUICtrlCreateCheckbox($arrBlockSponsors[66], 10, 50 + 20*66, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock66")  

    $idCheckbox67 = GUICtrlCreateCheckbox($arrBlockSponsors[67], 10, 50 + 20*67, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock67")  

    $idCheckbox68 = GUICtrlCreateCheckbox($arrBlockSponsors[68], 10, 50 + 20*68, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock68")  

    $idCheckbox69 = GUICtrlCreateCheckbox($arrBlockSponsors[69], 10, 50 + 20*69, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock69")  

    $idCheckbox70 = GUICtrlCreateCheckbox($arrBlockSponsors[70], 10, 50 + 20*70, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock70")  

    $idCheckbox71 = GUICtrlCreateCheckbox($arrBlockSponsors[71], 10, 50 + 20*71, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock71")  

    $idCheckbox72 = GUICtrlCreateCheckbox($arrBlockSponsors[72], 10, 50 + 20*72, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock72")  

    $idCheckbox73 = GUICtrlCreateCheckbox($arrBlockSponsors[73], 10, 50 + 20*73, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock73")  

    $idCheckbox74 = GUICtrlCreateCheckbox($arrBlockSponsors[74], 10, 50 + 20*74, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock74")  

    $idCheckbox75 = GUICtrlCreateCheckbox($arrBlockSponsors[75], 10, 50 + 20*75, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock75")  

    $idCheckbox76 = GUICtrlCreateCheckbox($arrBlockSponsors[76], 10, 50 + 20*76, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock76")  

    $idCheckbox77 = GUICtrlCreateCheckbox($arrBlockSponsors[77], 10, 50 + 20*77, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock77")  

    $idCheckbox78 = GUICtrlCreateCheckbox($arrBlockSponsors[78], 10, 50 + 20*78, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock78")  

    $idCheckbox79 = GUICtrlCreateCheckbox($arrBlockSponsors[79], 10, 50 + 20*79, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock79")  

    $idCheckbox80 = GUICtrlCreateCheckbox($arrBlockSponsors[80], 10, 50 + 20*80, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock80")  

    $idCheckbox81 = GUICtrlCreateCheckbox($arrBlockSponsors[81], 10, 50 + 20*81, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock81")  

    $idCheckbox82 = GUICtrlCreateCheckbox($arrBlockSponsors[82], 10, 50 + 20*82, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock82")  

    $idCheckbox83 = GUICtrlCreateCheckbox($arrBlockSponsors[83], 10, 50 + 20*83, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock83")  

    $idCheckbox84 = GUICtrlCreateCheckbox($arrBlockSponsors[84], 10, 50 + 20*84, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock84")  

    $idCheckbox85 = GUICtrlCreateCheckbox($arrBlockSponsors[85], 10, 50 + 20*85, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock85")  

    $idCheckbox86 = GUICtrlCreateCheckbox($arrBlockSponsors[86], 10, 50 + 20*86, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock86")  

    $idCheckbox87 = GUICtrlCreateCheckbox($arrBlockSponsors[87], 10, 50 + 20*87, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock87")  

    $idCheckbox88 = GUICtrlCreateCheckbox($arrBlockSponsors[88], 10, 50 + 20*88, 185, 25)
    GUICtrlSetOnEvent(-1, "_CheckBoxSponsorBlock88")  



;   Checking the state of checkboxes
    CheckStateOfSponsorsCheckboxes()

;   Display the GUI.
    GUISetState(@SW_SHOW, $MainBlockSponsorsGUI)
    GUISetState(@SW_SHOW, $BlockSponsorsGUI)

EndFunc   ;==>CheckBoxBlockSponsors

Func _IsChecked($idControlID)
    Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked


;*************
Func _CheckBoxSponsorBlockCMD()
   BlockSponsors('cmd.exe', 'Windows CMD', 'IsCMDBlocked', '{1016bbe0-a716-428b-822e-5E544B6A3102}')
EndFunc

Func _CheckBoxSponsorBlockPowerShell()
   BlockSponsors('powershell.exe', 'PowerShell', 'IsPowerShellBlocked', '{1016bbe0-a716-428b-822e-5E544B6A3100}')
EndFunc

Func _CheckBoxSponsorBlockPowerShell_ise()
   BlockSponsors('powershell_ise.exe', 'PowerShell_ise', 'IsPowerShell_iseBlocked', '{1016bbe0-a716-428b-822e-5E544B6A3101}')
EndFunc

Func _CheckBoxSponsorBlock1()
   BlockSponsors($arrBlockSponsors[1], $arrBlockSponsors[1], 'Is' & $arrBlockSponsors[1] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3103}')
EndFunc

Func _CheckBoxSponsorBlock2()
   BlockSponsors($arrBlockSponsors[2], $arrBlockSponsors[2], 'Is' & $arrBlockSponsors[2] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3104}')
EndFunc

Func _CheckBoxSponsorBlock3()
   BlockSponsors($arrBlockSponsors[3], $arrBlockSponsors[3], 'Is' & $arrBlockSponsors[3] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3105}')
EndFunc

Func _CheckBoxSponsorBlock4()
   BlockSponsors($arrBlockSponsors[4], $arrBlockSponsors[4], 'Is' & $arrBlockSponsors[4] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3106}')
EndFunc

Func _CheckBoxSponsorBlock5()
   BlockSponsors($arrBlockSponsors[5], $arrBlockSponsors[5], 'Is' & $arrBlockSponsors[5] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3107}')
EndFunc

Func _CheckBoxSponsorBlock6()
   BlockSponsors($arrBlockSponsors[6], $arrBlockSponsors[6], 'Is' & $arrBlockSponsors[6] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3108}')
EndFunc

Func _CheckBoxSponsorBlock7()
   BlockSponsors($arrBlockSponsors[7], $arrBlockSponsors[7], 'Is' & $arrBlockSponsors[7] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3109}')
EndFunc

Func _CheckBoxSponsorBlock8()
   BlockSponsors($arrBlockSponsors[8], $arrBlockSponsors[8], 'Is' & $arrBlockSponsors[8] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3110}')
EndFunc

Func _CheckBoxSponsorBlock9()
   BlockSponsors($arrBlockSponsors[9], $arrBlockSponsors[9], 'Is' & $arrBlockSponsors[9] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3111}')
EndFunc

Func _CheckBoxSponsorBlock10()
   BlockSponsors($arrBlockSponsors[10], $arrBlockSponsors[10], 'Is' & $arrBlockSponsors[10] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3112}')
EndFunc

Func _CheckBoxSponsorBlock11()
   BlockSponsors($arrBlockSponsors[11], $arrBlockSponsors[11], 'Is' & $arrBlockSponsors[11] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3113}')
EndFunc

Func _CheckBoxSponsorBlock12()
   BlockSponsors($arrBlockSponsors[12], $arrBlockSponsors[12], 'Is' & $arrBlockSponsors[12] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3114}')
EndFunc

Func _CheckBoxSponsorBlock13()
   BlockSponsors($arrBlockSponsors[13], $arrBlockSponsors[13], 'Is' & $arrBlockSponsors[13] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3115}')
EndFunc

Func _CheckBoxSponsorBlock14()
   BlockSponsors($arrBlockSponsors[14], $arrBlockSponsors[14], 'Is' & $arrBlockSponsors[14] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3116}')
EndFunc

Func _CheckBoxSponsorBlock15()
   BlockSponsors($arrBlockSponsors[15], $arrBlockSponsors[15], 'Is' & $arrBlockSponsors[15] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3117}')
EndFunc

Func _CheckBoxSponsorBlock16()
   BlockSponsors($arrBlockSponsors[16], $arrBlockSponsors[16], 'Is' & $arrBlockSponsors[16] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3118}')
EndFunc

Func _CheckBoxSponsorBlock17()
   BlockSponsors($arrBlockSponsors[17], $arrBlockSponsors[17], 'Is' & $arrBlockSponsors[17] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3119}')
EndFunc

Func _CheckBoxSponsorBlock18()
   BlockSponsors($arrBlockSponsors[18], $arrBlockSponsors[18], 'Is' & $arrBlockSponsors[18] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3120}')
EndFunc

Func _CheckBoxSponsorBlock19()
   BlockSponsors($arrBlockSponsors[19], $arrBlockSponsors[19], 'Is' & $arrBlockSponsors[19] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3121}')
EndFunc

Func _CheckBoxSponsorBlock20()
   BlockSponsors($arrBlockSponsors[20], $arrBlockSponsors[20], 'Is' & $arrBlockSponsors[20] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3122}')
EndFunc

Func _CheckBoxSponsorBlock21()
   BlockSponsors($arrBlockSponsors[21], $arrBlockSponsors[21], 'Is' & $arrBlockSponsors[21] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3123}')
EndFunc

Func _CheckBoxSponsorBlock22()
   BlockSponsors($arrBlockSponsors[22], $arrBlockSponsors[22], 'Is' & $arrBlockSponsors[22] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3124}')
EndFunc

Func _CheckBoxSponsorBlock23()
   BlockSponsors($arrBlockSponsors[23], $arrBlockSponsors[23], 'Is' & $arrBlockSponsors[23] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3125}')
EndFunc

Func _CheckBoxSponsorBlock24()
   BlockSponsors($arrBlockSponsors[24], $arrBlockSponsors[24], 'Is' & $arrBlockSponsors[24] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3126}')
EndFunc

Func _CheckBoxSponsorBlock25()
   BlockSponsors($arrBlockSponsors[25], $arrBlockSponsors[25], 'Is' & $arrBlockSponsors[25] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3127}')
EndFunc

Func _CheckBoxSponsorBlock26()
   BlockSponsors($arrBlockSponsors[26], $arrBlockSponsors[26], 'Is' & $arrBlockSponsors[26] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3128}')
EndFunc

Func _CheckBoxSponsorBlock27()
   BlockSponsors($arrBlockSponsors[27], $arrBlockSponsors[27], 'Is' & $arrBlockSponsors[27] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3129}')
EndFunc

Func _CheckBoxSponsorBlock28()
   BlockSponsors($arrBlockSponsors[28], $arrBlockSponsors[28], 'Is' & $arrBlockSponsors[28] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3130}')
EndFunc

Func _CheckBoxSponsorBlock29()
   BlockSponsors($arrBlockSponsors[29], $arrBlockSponsors[29], 'Is' & $arrBlockSponsors[29] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3131}')
EndFunc

Func _CheckBoxSponsorBlock30()
   BlockSponsors($arrBlockSponsors[30], $arrBlockSponsors[30], 'Is' & $arrBlockSponsors[30] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3132}')
EndFunc

Func _CheckBoxSponsorBlock31()
   BlockSponsors($arrBlockSponsors[31], $arrBlockSponsors[31], 'Is' & $arrBlockSponsors[31] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3133}')
EndFunc

Func _CheckBoxSponsorBlock32()
   BlockSponsors($arrBlockSponsors[32], $arrBlockSponsors[32], 'Is' & $arrBlockSponsors[32] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3134}')
EndFunc

Func _CheckBoxSponsorBlock33()
   BlockSponsors($arrBlockSponsors[33], $arrBlockSponsors[33], 'Is' & $arrBlockSponsors[33] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3135}')
EndFunc

Func _CheckBoxSponsorBlock34()
   BlockSponsors($arrBlockSponsors[34], $arrBlockSponsors[34], 'Is' & $arrBlockSponsors[34] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3136}')
EndFunc

Func _CheckBoxSponsorBlock35()
   BlockSponsors($arrBlockSponsors[35], $arrBlockSponsors[35], 'Is' & $arrBlockSponsors[35] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3137}')
EndFunc

Func _CheckBoxSponsorBlock36()
   BlockSponsors($arrBlockSponsors[36], $arrBlockSponsors[36], 'Is' & $arrBlockSponsors[36] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3138}')
EndFunc

Func _CheckBoxSponsorBlock37()
   BlockSponsors($arrBlockSponsors[37], $arrBlockSponsors[37], 'Is' & $arrBlockSponsors[37] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3139}')
EndFunc

Func _CheckBoxSponsorBlock38()
   BlockSponsors($arrBlockSponsors[38], $arrBlockSponsors[38], 'Is' & $arrBlockSponsors[38] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3140}')
EndFunc

Func _CheckBoxSponsorBlock39()
   BlockSponsors($arrBlockSponsors[39], $arrBlockSponsors[39], 'Is' & $arrBlockSponsors[39] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3141}')
EndFunc

Func _CheckBoxSponsorBlock40()
   BlockSponsors($arrBlockSponsors[40], $arrBlockSponsors[40], 'Is' & $arrBlockSponsors[40] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3142}')
EndFunc

Func _CheckBoxSponsorBlock41()
   BlockSponsors($arrBlockSponsors[41], $arrBlockSponsors[41], 'Is' & $arrBlockSponsors[41] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3143}')
EndFunc

Func _CheckBoxSponsorBlock42()
   BlockSponsors($arrBlockSponsors[42], $arrBlockSponsors[42], 'Is' & $arrBlockSponsors[42] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3144}')
EndFunc

Func _CheckBoxSponsorBlock43()
   BlockSponsors($arrBlockSponsors[43], $arrBlockSponsors[43], 'Is' & $arrBlockSponsors[43] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3145}')
EndFunc

Func _CheckBoxSponsorBlock44()
   BlockSponsors($arrBlockSponsors[44], $arrBlockSponsors[44], 'Is' & $arrBlockSponsors[44] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3146}')
EndFunc

Func _CheckBoxSponsorBlock45()
   BlockSponsors($arrBlockSponsors[45], $arrBlockSponsors[45], 'Is' & $arrBlockSponsors[45] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3147}')
EndFunc

Func _CheckBoxSponsorBlock46()
   BlockSponsors($arrBlockSponsors[46], $arrBlockSponsors[46], 'Is' & $arrBlockSponsors[46] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3148}')
EndFunc

Func _CheckBoxSponsorBlock47()
   BlockSponsors($arrBlockSponsors[47], $arrBlockSponsors[47], 'Is' & $arrBlockSponsors[47] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3149}')
EndFunc

Func _CheckBoxSponsorBlock48()
   BlockSponsors($arrBlockSponsors[48], $arrBlockSponsors[48], 'Is' & $arrBlockSponsors[48] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3150}')
EndFunc

Func _CheckBoxSponsorBlock49()
   BlockSponsors($arrBlockSponsors[49], $arrBlockSponsors[49], 'Is' & $arrBlockSponsors[49] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3151}')
EndFunc

Func _CheckBoxSponsorBlock50()
   BlockSponsors($arrBlockSponsors[50], $arrBlockSponsors[50], 'Is' & $arrBlockSponsors[50] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3152}')
EndFunc

Func _CheckBoxSponsorBlock51()
   BlockSponsors($arrBlockSponsors[51], $arrBlockSponsors[51], 'Is' & $arrBlockSponsors[51] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3153}')
EndFunc

Func _CheckBoxSponsorBlock52()
   BlockSponsors($arrBlockSponsors[52], $arrBlockSponsors[52], 'Is' & $arrBlockSponsors[52] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3154}')
EndFunc

Func _CheckBoxSponsorBlock53()
   BlockSponsors($arrBlockSponsors[53], $arrBlockSponsors[53], 'Is' & $arrBlockSponsors[53] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3155}')
EndFunc

Func _CheckBoxSponsorBlock54()
   BlockSponsors($arrBlockSponsors[54], $arrBlockSponsors[54], 'Is' & $arrBlockSponsors[54] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3156}')
EndFunc

Func _CheckBoxSponsorBlock55()
   BlockSponsors($arrBlockSponsors[55], $arrBlockSponsors[55], 'Is' & $arrBlockSponsors[55] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3157}')
EndFunc

Func _CheckBoxSponsorBlock56()
   BlockSponsors($arrBlockSponsors[56], $arrBlockSponsors[56], 'Is' & $arrBlockSponsors[56] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3158}')
EndFunc

Func _CheckBoxSponsorBlock57()
   BlockSponsors($arrBlockSponsors[57], $arrBlockSponsors[57], 'Is' & $arrBlockSponsors[57] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3159}')
EndFunc

Func _CheckBoxSponsorBlock58()
   BlockSponsors($arrBlockSponsors[58], $arrBlockSponsors[58], 'Is' & $arrBlockSponsors[58] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3160}')
EndFunc

Func _CheckBoxSponsorBlock59()
   BlockSponsors($arrBlockSponsors[59], $arrBlockSponsors[59], 'Is' & $arrBlockSponsors[59] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3161}')
EndFunc

Func _CheckBoxSponsorBlock60()
   BlockSponsors($arrBlockSponsors[60], $arrBlockSponsors[60], 'Is' & $arrBlockSponsors[60] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3162}')
EndFunc

Func _CheckBoxSponsorBlock61()
   BlockSponsors($arrBlockSponsors[61], $arrBlockSponsors[61], 'Is' & $arrBlockSponsors[61] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3163}')
EndFunc

Func _CheckBoxSponsorBlock62()
   BlockSponsors($arrBlockSponsors[62], $arrBlockSponsors[62], 'Is' & $arrBlockSponsors[62] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3164}')
EndFunc

Func _CheckBoxSponsorBlock63()
   BlockSponsors($arrBlockSponsors[63], $arrBlockSponsors[63], 'Is' & $arrBlockSponsors[63] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3165}')
EndFunc

Func _CheckBoxSponsorBlock64()
   BlockSponsors($arrBlockSponsors[64], $arrBlockSponsors[64], 'Is' & $arrBlockSponsors[64] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3166}')
EndFunc

Func _CheckBoxSponsorBlock65()
   BlockSponsors($arrBlockSponsors[65], $arrBlockSponsors[65], 'Is' & $arrBlockSponsors[54] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3167}')
EndFunc

Func _CheckBoxSponsorBlock66()
   BlockSponsors($arrBlockSponsors[66], $arrBlockSponsors[66], 'Is' & $arrBlockSponsors[66] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3168}')
EndFunc

Func _CheckBoxSponsorBlock67()
   BlockSponsors($arrBlockSponsors[67], $arrBlockSponsors[67], 'Is' & $arrBlockSponsors[67] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3169}')
EndFunc

Func _CheckBoxSponsorBlock68()
   BlockSponsors($arrBlockSponsors[68], $arrBlockSponsors[68], 'Is' & $arrBlockSponsors[68] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3170}')
EndFunc

Func _CheckBoxSponsorBlock69()
   BlockSponsors($arrBlockSponsors[69], $arrBlockSponsors[69], 'Is' & $arrBlockSponsors[69] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3171}')
EndFunc

Func _CheckBoxSponsorBlock70()
   BlockSponsors($arrBlockSponsors[70], $arrBlockSponsors[70], 'Is' & $arrBlockSponsors[70] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3172}')
EndFunc

Func _CheckBoxSponsorBlock71()
   BlockSponsors($arrBlockSponsors[71], $arrBlockSponsors[71], 'Is' & $arrBlockSponsors[71] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3173}')
EndFunc

Func _CheckBoxSponsorBlock72()
   BlockSponsors($arrBlockSponsors[72], $arrBlockSponsors[72], 'Is' & $arrBlockSponsors[72] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3174}')
EndFunc

Func _CheckBoxSponsorBlock73()
   BlockSponsors($arrBlockSponsors[73], $arrBlockSponsors[73], 'Is' & $arrBlockSponsors[73] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3175}')
EndFunc

Func _CheckBoxSponsorBlock74()
   BlockSponsors($arrBlockSponsors[74], $arrBlockSponsors[74], 'Is' & $arrBlockSponsors[74] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3176}')
EndFunc

Func _CheckBoxSponsorBlock75()
   BlockSponsors($arrBlockSponsors[75], $arrBlockSponsors[75], 'Is' & $arrBlockSponsors[75] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3177}')
EndFunc

Func _CheckBoxSponsorBlock76()
   BlockSponsors($arrBlockSponsors[76], $arrBlockSponsors[76], 'Is' & $arrBlockSponsors[76] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3178}')
EndFunc

Func _CheckBoxSponsorBlock77()
   BlockSponsors($arrBlockSponsors[77], $arrBlockSponsors[77], 'Is' & $arrBlockSponsors[77] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3179}')
EndFunc

Func _CheckBoxSponsorBlock78()
   BlockSponsors($arrBlockSponsors[78], $arrBlockSponsors[78], 'Is' & $arrBlockSponsors[78] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3180}')
EndFunc

Func _CheckBoxSponsorBlock79()
   BlockSponsors($arrBlockSponsors[79], $arrBlockSponsors[79], 'Is' & $arrBlockSponsors[79] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3181}')
EndFunc

Func _CheckBoxSponsorBlock80()
   BlockSponsors($arrBlockSponsors[80], $arrBlockSponsors[80], 'Is' & $arrBlockSponsors[80] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3182}')
EndFunc

Func _CheckBoxSponsorBlock81()
   BlockSponsors($arrBlockSponsors[81], $arrBlockSponsors[81], 'Is' & $arrBlockSponsors[81] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3183}')
EndFunc

Func _CheckBoxSponsorBlock82()
   BlockSponsors($arrBlockSponsors[82], $arrBlockSponsors[82], 'Is' & $arrBlockSponsors[82] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3184}')
EndFunc

Func _CheckBoxSponsorBlock83()
   BlockSponsors($arrBlockSponsors[83], $arrBlockSponsors[83], 'Is' & $arrBlockSponsors[83] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3185}')
EndFunc

Func _CheckBoxSponsorBlock84()
   BlockSponsors($arrBlockSponsors[84], $arrBlockSponsors[84], 'Is' & $arrBlockSponsors[84] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3186}')
EndFunc

Func _CheckBoxSponsorBlock85()
   BlockSponsors($arrBlockSponsors[85], $arrBlockSponsors[85], 'Is' & $arrBlockSponsors[85] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3187}')
EndFunc

Func _CheckBoxSponsorBlock86()
   BlockSponsors($arrBlockSponsors[86], $arrBlockSponsors[86], 'Is' & $arrBlockSponsors[86] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3188}')
EndFunc

Func _CheckBoxSponsorBlock87()
   BlockSponsors($arrBlockSponsors[87], $arrBlockSponsors[87], 'Is' & $arrBlockSponsors[87] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3189}')
EndFunc

Func _CheckBoxSponsorBlock88()
   BlockSponsors($arrBlockSponsors[88], $arrBlockSponsors[88], 'Is' & $arrBlockSponsors[88] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3190}')
EndFunc



Func CheckBoxSponsorBlock($idCheckbox, $DisableSponsorVariableName, $DisableSponsorRegValueName, $Sponsor_GUID)
;MsgBox(0,"",'idCheckbox=' & $idCheckbox & @CRLF & 'DisableSponsorVariableName=' & $DisableSponsorVariableName  & @CRLF & 'DisableSponsorRegValueName=' & $DisableSponsorRegValueName)
        $DisableSponsorVariableName = CheckBlockedSponsors($DisableSponsorVariableName, $DisableSponsorRegValueName, $Sponsor_GUID)
        If $DisableSponsorVariableName = 'ON' Then 
           GUICtrlSetState ($idCheckbox, 1)
           $BlockSponsorsNumber = $BlockSponsorsNumber + 1
        Else 
           GUICtrlSetState ($idCheckbox, 4)
        EndIf
EndFunc

Func CloseBlockSponsors()
   GuiDelete($MainBlockSponsorsGUI)
;   GUISetState(@SW_ENABLE, $listGUI)
;   GUISetState(@SW_HIDE,$listGUI)
;   GUISetState(@SW_SHOW,$listGUI)
   ShowMainGUI()
   ShowRegistryTweaks()
EndFunc


Func RefreshBlockSponsorsGUIWindow()
  Local $pos = WinGetPos ($BlockSponsorsGUI)
  $X_BlockSponsorsGUI = $pos[0] 
  $Y_BlockSponsorsGUI = $pos[1]
  GUISetState(@SW_HIDE,$BlockSponsorsGUI)
  GuiDelete($BlockSponsorsGUI)
  CheckBoxBlockSponsors()
EndFunc


Func CheckBlockedSponsors($BlockSponsors, $valuename, $GUID0)

$keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers\BlockSponsors'
$keyname0 = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers\0\Paths\' & $GUID0

If ($SRPTransparentEnabled = "No Enforcement" or $SRPTransparentEnabled = "not found" or $SRPTransparentEnabled = "?") Then
;   RegDelete($keyname0)
;   RegDelete($keyname, $valuename)
   $BlockSponsors = "OFF"
Else
   $BlockSponsors = RegRead ( $keyname, $valuename )
   Switch $BlockSponsors
     case 1
         $BlockSponsors = "ON"
     case ''
         $BlockSponsors = "OFF"
     case Else
         $BlockSponsors = "?"
     EndSwitch
EndIf
Return $BlockSponsors
EndFunc


Func AddMoreRestrictionsOutput($BlockSponsor, $Output)
   Switch $BlockSponsor
      case "ON"
            $Output = $Output & '1'
      case "OFF"
         $Output = $Output & '0'
      case Else
         $Output = $Output & '?'
   EndSwitch
Return $Output
EndFunc


Func BlockSponsors($EXEName, $Description, $IsBlocked, $GUID)

; For example: BlockSponsors('regedit.exe', 'REGEDIT', 'IsRegeditBlocked', '{1016bbe0-a716-428b-822e-5E544B6A3107}')
; Each run of this function writes/deletes file with $EXEName on SRP blacklist with guid = $GUID.
If $isSRPinstalled = "Installed" Then
   If not ( $SRPTransparentEnabled = "No Enforcement") Then
      Local $keyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers\BlockSponsors'
      Local $BlacklistKeyname = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers\0\Paths\'
      Local $CheckBlocked = RegRead ( $keyname, $IsBlocked )
         Switch $CheckBlocked
            case 0
               RegWrite($BlacklistKeyname & $GUID, 'Description', 'REG_SZ', $Description)
               RegWrite($BlacklistKeyname & $GUID, 'SaferFlags','REG_DWORD',Number('0'))
               RegWrite($BlacklistKeyname & $GUID, 'ItemData','REG_SZ',$EXEName)
               RegWrite($keyname, $IsBlocked, 'REG_DWORD', Number('1'))
;               MsgBox(0,"", $keyname & '!' & $IsBlocked )
               RefreshChangesCheck($IsBlocked)
            case Else
               RegDelete($BlacklistKeyname & $GUID)
               RegDelete($keyname, $IsBlocked)
               RefreshChangesCheck($IsBlocked)
         EndSwitch
;         RegDelete($BlacklistKeyname & $GUID)
;         RegDelete($keyname, $IsBlocked)
   Else
;      MsgBox(262144,"","The Enforcement option must be set to 'Skip DLLs' or 'All Files'.")
   EndIf
Else
   MsgBox(262144,"","This option needs SRP to be installed, with Enforcement set to 'Skip DLLs' or 'All Files'.")
EndIf
;RefreshBlockSponsorsGUIWindow()   

EndFunc

;**********
Func CheckStateOfSponsorsCheckboxes()
    $BlockSponsorsNumber = 0
    CheckStateOfSponsorsCheckboxes1()
EndFunc

Func CheckStateOfSponsorsCheckboxes1() 
    Arr_GetSponsorNames()
    CheckBoxSponsorBlock($idCheckboxCMD, $DisableCommandPrompt, 'IsCMDBlocked', '{1016bbe0-a716-428b-822e-5E544B6A3102}')
    CheckBoxSponsorBlock($idCheckboxPowerShell, $DisablePowerShell, 'IsPowerShellBlocked', '{1016bbe0-a716-428b-822e-5E544B6A3100}')
    CheckBoxSponsorBlock($idCheckboxPowerShell_ise, $DisablePowerShell_ise, 'IsPowerShell_iseBlocked', '{1016bbe0-a716-428b-822e-5E544B6A3101}')
    CheckBoxSponsorBlock($idCheckbox1, $DisableAttribExe, 'Is' & $arrBlockSponsors[1] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3103}')
    CheckBoxSponsorBlock($idCheckbox2, $DisableAuditpolExe, 'Is' & $arrBlockSponsors[2] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3104}')
    CheckBoxSponsorBlock($idCheckbox3, $DisableBcdbootExe, 'Is' & $arrBlockSponsors[3] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3105}')
    CheckBoxSponsorBlock($idCheckbox4, $DisableBcdeditExe, 'Is' & $arrBlockSponsors[4] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3106}')
    CheckBoxSponsorBlock($idCheckbox5, $DisableBitsadminExe, 'Is' & $arrBlockSponsors[5] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3107}')
    CheckBoxSponsorBlock($idCheckbox6, $DisableBootcfgExe, 'Is' & $arrBlockSponsors[6] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3108}')
    CheckBoxSponsorBlock($idCheckbox7, $DisableBootimExe, 'Is' & $arrBlockSponsors[7] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3109}')
    CheckBoxSponsorBlock($idCheckbox8, $DisableBootsectExe, 'Is' & $arrBlockSponsors[8] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3110}')
    CheckBoxSponsorBlock($idCheckbox9, $DisableByteCodeGeneratorExe, 'Is' & $arrBlockSponsors[9] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3111}')
    CheckBoxSponsorBlock($idCheckbox10, $DisableCaclsExe, 'Is' & $arrBlockSponsors[10] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3112}')
    CheckBoxSponsorBlock($idCheckbox11, $DisableIcaclsExe, 'Is' & $arrBlockSponsors[11] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3113}')
    CheckBoxSponsorBlock($idCheckbox12, $DisableCscExe, 'Is' & $arrBlockSponsors[12] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3114}')
    CheckBoxSponsorBlock($idCheckbox13, $DisableDebugExe, 'Is' & $arrBlockSponsors[13] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3115}')
    CheckBoxSponsorBlock($idCheckbox14, $DisableDFsvcExe, 'Is' & $arrBlockSponsors[14] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3116}')
    CheckBoxSponsorBlock($idCheckbox15, $DisableDiskpartExe, 'Is' & $arrBlockSponsors[15] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3117}')
    CheckBoxSponsorBlock($idCheckbox16, $DisableEventvwrExe, 'Is' & $arrBlockSponsors[16] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3118}')
    CheckBoxSponsorBlock($idCheckbox17, $DisableHHExe, 'Is' & $arrBlockSponsors[17] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3119}')
    CheckBoxSponsorBlock($idCheckbox18, $DisableIEExecExe, 'Is' & $arrBlockSponsors[18] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3120}')
    CheckBoxSponsorBlock($idCheckbox19, $DisableIexploreExe, 'Is' & $arrBlockSponsors[19] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3121}')
    CheckBoxSponsorBlock($idCheckbox20, $DisableIexpressExe, 'Is' & $arrBlockSponsors[20] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3122}')
    CheckBoxSponsorBlock($idCheckbox21, $DisableIlasmExe, 'Is' & $arrBlockSponsors[21] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3123}')
    CheckBoxSponsorBlock($idCheckbox22, $DisableInstallUtilLibDLL, 'Is' & $arrBlockSponsors[22] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3124}')
    CheckBoxSponsorBlock($idCheckbox23, $DisableInstallUtilExe, 'Is' & $arrBlockSponsors[23] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3125}')
    CheckBoxSponsorBlock($idCheckbox24, $DisableJournalExe, 'Is' & $arrBlockSponsors[24] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3126}')
    CheckBoxSponsorBlock($idCheckbox25, $DisableJscExe, 'Is' & $arrBlockSponsors[25] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3127}')
    CheckBoxSponsorBlock($idCheckbox26, $DisableMmcExe, 'Is' & $arrBlockSponsors[26] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3128}')
    CheckBoxSponsorBlock($idCheckbox27, $DisableMrsaExe, 'Is' & $arrBlockSponsors[27] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3129}')
    CheckBoxSponsorBlock($idCheckbox28, $DisableMSBuildExe, 'Is' & $arrBlockSponsors[28] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3130}')
    CheckBoxSponsorBlock($idCheckbox29, $DisableMshtaExe, 'Is' & $arrBlockSponsors[29] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3131}')
    CheckBoxSponsorBlock($idCheckbox30, $DisableMstscExe, 'Is' & $arrBlockSponsors[30] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3132}')
    CheckBoxSponsorBlock($idCheckbox31, $DisableNetshExe, 'Is' & $arrBlockSponsors[31] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3133}')
    CheckBoxSponsorBlock($idCheckbox32, $DisableNetstatExe, 'Is' & $arrBlockSponsors[32] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3134}')
    CheckBoxSponsorBlock($idCheckbox33, $DisablePresentationHostExe, 'Is' & $arrBlockSponsors[33] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3135}')
    CheckBoxSponsorBlock($idCheckbox34, $DisableQuserExe, 'Is' & $arrBlockSponsors[34] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3136}')
    CheckBoxSponsorBlock($idCheckbox35, $DisableRegExe, 'Is' & $arrBlockSponsors[35] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3137}')
    CheckBoxSponsorBlock($idCheckbox36, $DisableRegAsmGlobal, 'Is' & $arrBlockSponsors[36] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3138}')
    CheckBoxSponsorBlock($idCheckbox37, $DisableReginiExe, 'Is' & $arrBlockSponsors[37] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3139}')
    CheckBoxSponsorBlock($idCheckbox38, $DisableRegsvcsExe, 'Is' & $arrBlockSponsors[38] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3140}')
    CheckBoxSponsorBlock($idCheckbox39, $DisableRegsvr32Exe, 'Is' & $arrBlockSponsors[39] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3141}')
    CheckBoxSponsorBlock($idCheckbox40, $DisableRunLegacyCPLElevatedExe, 'Is' & $arrBlockSponsors[40] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3142}')
    CheckBoxSponsorBlock($idCheckbox41, $DisableRunonceExe, 'Is' & $arrBlockSponsors[41] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3143}')
    CheckBoxSponsorBlock($idCheckbox42, $DisableRunasExe, 'Is' & $arrBlockSponsors[42] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3144}')
    CheckBoxSponsorBlock($idCheckbox43, $DisableStarScriptExe, 'Is' & $arrBlockSponsors[43] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3145}')
    CheckBoxSponsorBlock($idCheckbox44, $DisableSetExe, 'Is' & $arrBlockSponsors[44] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3146}')
    CheckBoxSponsorBlock($idCheckbox45, $DisableSetxExe, 'Is' & $arrBlockSponsors[45] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3147')
    CheckBoxSponsorBlock($idCheckbox46, $DisableStashStar, 'Is' & $arrBlockSponsors[46] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3148')
    CheckBoxSponsorBlock($idCheckbox47, $DisableSystemresetExe, 'Is' & $arrBlockSponsors[47] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3149')
    CheckBoxSponsorBlock($idCheckbox48, $DisableTakeownExe, 'Is' & $arrBlockSponsors[48] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3150')
    CheckBoxSponsorBlock($idCheckbox49, $DisableTaskkillExe, 'Is' & $arrBlockSponsors[49] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3151')
    CheckBoxSponsorBlock($idCheckbox50, $DisableUserAccountControlSettingsExe, 'Is' & $arrBlockSponsors[50] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3152')
   CheckBoxSponsorBlock($idCheckbox51, $DisableVbcExe, 'Is' & $arrBlockSponsors[51] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3153')
   CheckBoxSponsorBlock($idCheckbox52, $DisableVssadminExe, 'Is' & $arrBlockSponsors[52] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3154')
   CheckBoxSponsorBlock($idCheckbox53, $DisableWmicExe, 'Is' & $arrBlockSponsors[53] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3155')
   CheckBoxSponsorBlock($idCheckbox54, $DisableXcaclsExe, 'Is' & $arrBlockSponsors[54] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3156')
   CheckBoxSponsorBlock($idCheckbox55, $DisableAspnetCompilerExe, 'Is' & $arrBlockSponsors[55] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3157')
   CheckBoxSponsorBlock($idCheckbox56, $DisableBashExe, 'Is' & $arrBlockSponsors[56] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3158')
   CheckBoxSponsorBlock($idCheckbox57, $DisableBginfoExe, 'Is' & $arrBlockSponsors[57] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3159')
   CheckBoxSponsorBlock($idCheckbox58, $DisableBitsadmin, 'Is' & $arrBlockSponsors[58] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3160')
   CheckBoxSponsorBlock($idCheckbox59, $DisableCdbExe, 'Is' & $arrBlockSponsors[59] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3161')
   CheckBoxSponsorBlock($idCheckbox60, $DisableCsiExe, 'Is' & $arrBlockSponsors[60] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3162')
   CheckBoxSponsorBlock($idCheckbox61, $DisableCvtresExe, 'Is' & $arrBlockSponsors[61] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3163')
   CheckBoxSponsorBlock($idCheckbox62, $DisableDbghostExe, 'Is' & $arrBlockSponsors[62] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3164')
   CheckBoxSponsorBlock($idCheckbox63, $DisableDbgsvcExe, 'Is' & $arrBlockSponsors[63] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3165')
   CheckBoxSponsorBlock($idCheckbox64, $DisableDnxExe, 'Is' & $arrBlockSponsors[64] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3166')
   CheckBoxSponsorBlock($idCheckbox65, $DisableFsiExe, 'Is' & $arrBlockSponsors[65] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3167')
   CheckBoxSponsorBlock($idCheckbox66, $DisablefsiAnyCpuExe, 'Is' & $arrBlockSponsors[66] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3168')
   CheckBoxSponsorBlock($idCheckbox67, $DisableInfDefaultInstallExe, 'Is' & $arrBlockSponsors[67] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3169')
   CheckBoxSponsorBlock($idCheckbox68, $DisableInstallUtil, 'Is' & $arrBlockSponsors[68] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3170')
   CheckBoxSponsorBlock($idCheckbox69, $DisableKdExe, 'Is' & $arrBlockSponsors[69] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3171')
   CheckBoxSponsorBlock($idCheckbox70, $DisableLpkInstall, 'Is' & $arrBlockSponsors[70] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3172')
   CheckBoxSponsorBlock($idCheckbox71, $DisableLxssManagerDll, 'Is' & $arrBlockSponsors[71] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3173')
   CheckBoxSponsorBlock($idCheckbox72, $DisableMsiexecExe, 'Is' & $arrBlockSponsors[72] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3174')
   CheckBoxSponsorBlock($idCheckbox73, $DisableNtkdExe, 'Is' & $arrBlockSponsors[73] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3175')
   CheckBoxSponsorBlock($idCheckbox74, $DisableNtsdExe, 'Is' & $arrBlockSponsors[74] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3176')
   CheckBoxSponsorBlock($idCheckbox75, $DisableOdbcConfExe, 'Is' & $arrBlockSponsors[75] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3177')
   CheckBoxSponsorBlock($idCheckbox76, $DisableRcsiExe, 'Is' & $arrBlockSponsors[76] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3178')
   CheckBoxSponsorBlock($idCheckbox77, $DisableRegAsm, 'Is' & $arrBlockSponsors[77] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3179')
   CheckBoxSponsorBlock($idCheckbox78, $DisableRegsvcs, 'Is' & $arrBlockSponsors[78] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3180')
   CheckBoxSponsorBlock($idCheckbox79, $DisableRunScriptHelperExe, 'Is' & $arrBlockSponsors[79] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3181')
   CheckBoxSponsorBlock($idCheckbox80, $DisableSchTasksExe, 'Is' & $arrBlockSponsors[80] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3182')
   CheckBoxSponsorBlock($idCheckbox81, $DisableScrconsExe, 'Is' & $arrBlockSponsors[81] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3183')
   CheckBoxSponsorBlock($idCheckbox82, $DisableSdbinstExe, 'Is' & $arrBlockSponsors[82] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3184')
   CheckBoxSponsorBlock($idCheckbox83, $DisableSdcltExe, 'Is' & $arrBlockSponsors[83] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3185')
   CheckBoxSponsorBlock($idCheckbox84, $DisableSyskeyExe, 'Is' & $arrBlockSponsors[84] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3186')
   CheckBoxSponsorBlock($idCheckbox85, $DisableUtilmanExe, 'Is' & $arrBlockSponsors[85] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3187')
   CheckBoxSponsorBlock($idCheckbox86, $DisableVisualUiaVerifyNativeExe, 'Is' & $arrBlockSponsors[86] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3188')
   CheckBoxSponsorBlock($idCheckbox87, $DisableWbemTestExe, 'Is' & $arrBlockSponsors[87] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3189')
   CheckBoxSponsorBlock($idCheckbox88, $DisableWinDbgExe, 'Is' & $arrBlockSponsors[88] & 'Blocked', '{1016bbe0-a716-428b-822e-5E544B6A3190')



EndFunc




Func WM_VSCROLL($hWnd, $iMsg, $wParam, $lParam)
    #forceref $iMsg, $wParam, $lParam
    Local $iScrollCode = BitAND($wParam, 0x0000FFFF)
    Local $iIndex = -1, $iCharY, $iPosY
    Local $iMin, $iMax, $iPage, $iPos, $iTrackPos

    For $x = 0 To UBound($__g_aSB_WindowInfo) - 1
        If $__g_aSB_WindowInfo[$x][0] = $hWnd Then
            $iIndex = $x
            $iCharY = $__g_aSB_WindowInfo[$iIndex][3]
            ExitLoop
        EndIf
    Next
    If $iIndex = -1 Then Return 0

    ; Get all the vertial scroll bar information
    Local $tSCROLLINFO = _GUIScrollBars_GetScrollInfoEx($hWnd, $SB_VERT)
    $iMin = DllStructGetData($tSCROLLINFO, "nMin")
    $iMax = DllStructGetData($tSCROLLINFO, "nMax")
    $iPage = DllStructGetData($tSCROLLINFO, "nPage")
    ; Save the position for comparison later on
    $iPosY = DllStructGetData($tSCROLLINFO, "nPos")
    $iPos = $iPosY
    $iTrackPos = DllStructGetData($tSCROLLINFO, "nTrackPos")


    Switch $iScrollCode
        Case $SB_TOP ; user clicked the HOME keyboard key
            DllStructSetData($tSCROLLINFO, "nPos", $iMin)

        Case $SB_BOTTOM ; user clicked the END keyboard key
            DllStructSetData($tSCROLLINFO, "nPos", $iMax)

        Case $SB_LINEUP ; user clicked the top arrow
            DllStructSetData($tSCROLLINFO, "nPos", $iPos - 1)

        Case $SB_LINEDOWN ; user clicked the bottom arrow
            DllStructSetData($tSCROLLINFO, "nPos", $iPos + 1)

        Case $SB_PAGEUP ; user clicked the scroll bar shaft above the scroll box
            DllStructSetData($tSCROLLINFO, "nPos", $iPos - $iPage)

        Case $SB_PAGEDOWN ; user clicked the scroll bar shaft below the scroll box
            DllStructSetData($tSCROLLINFO, "nPos", $iPos + $iPage)

        Case $SB_THUMBTRACK ; user dragged the scroll box
            DllStructSetData($tSCROLLINFO, "nPos", $iTrackPos)
    EndSwitch

    ; // Set the position and then retrieve it.  Due to adjustments
    ; //   by Windows it may not be the same as the value set.

    DllStructSetData($tSCROLLINFO, "fMask", $SIF_POS)
    _GUIScrollBars_SetScrollInfo($hWnd, $SB_VERT, $tSCROLLINFO)
    _GUIScrollBars_GetScrollInfo($hWnd, $SB_VERT, $tSCROLLINFO)
    ;// If the position has changed, scroll the window and update it
    $iPos = DllStructGetData($tSCROLLINFO, "nPos")

    If ($iPos <> $iPosY) Then
       _GUIScrollBars_ScrollWindow($hWnd, 0, $iCharY * ($iPosY - $iPos))

        $iPosY = $iPos
    EndIf

    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_VSCROLL


Func Arr_GetSponsorNames()

;Local $NumberOfExecutables = 54
; Make room for  elements
;Global $arrBlockSponsors[$NumberOfExecutables + 1] 
;Assign the names of blocked executables
$arrBlockSponsors[0] = $NumberOfExecutables
$arrBlockSponsors[1] = 'Attrib.exe'
$arrBlockSponsors[2] = 'Auditpol.exe'
$arrBlockSponsors[3] = 'Bcdboot.exe'
$arrBlockSponsors[4] = 'Bcdedit.exe'
$arrBlockSponsors[5] = 'Bitsadmin.exe'
$arrBlockSponsors[6] = 'Bootcfg.exe'
$arrBlockSponsors[7] = 'Bootim.exe'
$arrBlockSponsors[8] = 'Bootsect.exe'
$arrBlockSponsors[9] = 'ByteCodeGenerator.exe'
$arrBlockSponsors[10] = 'Cacls.exe'
$arrBlockSponsors[11] = 'Icacls.exe'
$arrBlockSponsors[12] = 'Csc.exe'
$arrBlockSponsors[13] = 'Debug.exe'
$arrBlockSponsors[14] = 'DFsvc.exe'
$arrBlockSponsors[15] = 'Diskpart.exe'
$arrBlockSponsors[16] = 'Eventvwr.exe'
$arrBlockSponsors[17] = 'HH.exe'
$arrBlockSponsors[18] = 'IEExec.exe'
$arrBlockSponsors[19] = 'Iexplore.exe'
$arrBlockSponsors[20] = 'Iexpress.exe'
$arrBlockSponsors[21] = 'Ilasm.exe'
$arrBlockSponsors[22] = 'InstallUtilLib*'
$arrBlockSponsors[23] = 'InstallUtil.exe'
$arrBlockSponsors[24] = 'Journal.exe'
$arrBlockSponsors[25] = 'Jsc.exe'
$arrBlockSponsors[26] = 'Mmc.exe'
$arrBlockSponsors[27] = 'Mrsa.exe'
$arrBlockSponsors[28] = 'MSBuild.exe'
$arrBlockSponsors[29] = 'Mshta.exe'
$arrBlockSponsors[30] = 'Mstsc.exe'
$arrBlockSponsors[31] = 'Netsh.exe'
$arrBlockSponsors[32] = 'Netstat.exe'
$arrBlockSponsors[33] = 'PresentationHost.exe'
$arrBlockSponsors[34] = 'Quser.exe'
$arrBlockSponsors[35] = 'Reg.exe'
$arrBlockSponsors[36] = 'RegAsmGlobal*'
$arrBlockSponsors[37] = 'Regini.exe'
$arrBlockSponsors[38] = 'Regsvcs.exe'
$arrBlockSponsors[39] = 'Regsvr32.exe'
$arrBlockSponsors[40] = 'RunLegacyCPLElevated.exe'
$arrBlockSponsors[41] = 'Runonce.exe'
$arrBlockSponsors[42] = 'Runas.exe'
$arrBlockSponsors[43] = '*script.exe'
$arrBlockSponsors[44] = 'Set.exe'
$arrBlockSponsors[45] = 'Setx.exe'
$arrBlockSponsors[46] = 'Stash*'
$arrBlockSponsors[47] = 'Systemreset.exe'
$arrBlockSponsors[48] = 'Takeown.exe'
$arrBlockSponsors[49] = 'Taskkill.exe'
$arrBlockSponsors[50] = 'UserAccountControlSettings.exe'
$arrBlockSponsors[51] = 'Vbc.exe'
$arrBlockSponsors[52] = 'Vssadmin.exe'
$arrBlockSponsors[53] = 'Wmic.exe'
$arrBlockSponsors[54] = 'Xcacls.exe'
$arrBlockSponsors[55] = 'aspnet_compiler.exe'
$arrBlockSponsors[56] = 'bash.exe'
$arrBlockSponsors[57] = 'bginfo.exe'
$arrBlockSponsors[58] = 'bitsadmin*'
$arrBlockSponsors[59] = 'cdb.exe'
$arrBlockSponsors[60] = 'csi.exe'
$arrBlockSponsors[61] = 'cvtres.exe'
$arrBlockSponsors[62] = 'dbghost.exe'
$arrBlockSponsors[63] = 'dbgsvc.exe'
$arrBlockSponsors[64] = 'dnx.exe'
$arrBlockSponsors[65] = 'fsi.exe'
$arrBlockSponsors[66] = 'fsiAnyCpu.exe'
$arrBlockSponsors[67] = 'infdefaultinstall.exe'
$arrBlockSponsors[68] = 'InstallUtil*'
$arrBlockSponsors[69] = 'kd.exe'
$arrBlockSponsors[70] = 'lpkinstall*'
$arrBlockSponsors[71] = 'LxssManager.dll'
$arrBlockSponsors[72] = 'msiexec.exe'
$arrBlockSponsors[73] = 'ntkd.exe'
$arrBlockSponsors[74] = 'ntsd.exe'
$arrBlockSponsors[75] = 'odbcconf.exe'
$arrBlockSponsors[76] = 'rcsi.exe'
$arrBlockSponsors[77] = 'RegAsm*'
$arrBlockSponsors[78] = 'Regsvcs*'
$arrBlockSponsors[79] = 'runscripthelper.exe'
$arrBlockSponsors[80] = 'schtasks.exe'
$arrBlockSponsors[81] = 'scrcons.exe'
$arrBlockSponsors[82] = 'sdbinst.exe'
$arrBlockSponsors[83] = 'sdclt.exe'
$arrBlockSponsors[84] = 'syskey.exe'
$arrBlockSponsors[85] = 'utilman.exe'
$arrBlockSponsors[86] = 'visualuiaverifynative.exe'
$arrBlockSponsors[87] = 'wbemtest.exe'
$arrBlockSponsors[88] = 'windbg.exe'


EndFunc


Func BlockAllSponsors()

; Write data to ...\safer\CodeIdentifiers\0\Paths

Local $partkey = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers\0\Paths\{1016bbe0-a716-428b-822e-5E544B6A31'
RegWrite($partkey & '00}', 'Description','REG_SZ','PowerShell')
RegWrite($partkey & '00}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '00}', 'ItemData','REG_SZ','powershell.exe')
RegWrite($partkey & '01}', 'Description','REG_SZ','PowerShell_ise')
RegWrite($partkey & '01}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '01}', 'ItemData','REG_SZ','powershell_ise.exe')
RegWrite($partkey & '02}', 'Description','REG_SZ','Windows CMD')
RegWrite($partkey & '02}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '02}', 'ItemData','REG_SZ','cmd.exe')
RegWrite($partkey & '03}', 'Description','REG_SZ','Attrib.exe')
RegWrite($partkey & '03}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '03}', 'ItemData','REG_SZ','Attrib.exe')
RegWrite($partkey & '04}', 'Description','REG_SZ','Auditpol.exe')
RegWrite($partkey & '04}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '04}', 'ItemData','REG_SZ','Auditpol.exe')
RegWrite($partkey & '05}', 'Description','REG_SZ','Bcdboot.exe')
RegWrite($partkey & '05}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '05}', 'ItemData','REG_SZ','Bcdboot.exe')
RegWrite($partkey & '06}', 'Description','REG_SZ','Bcdedit.exe')
RegWrite($partkey & '06}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '06}', 'ItemData','REG_SZ','Bcdedit.exe')
RegWrite($partkey & '07}', 'Description','REG_SZ','Bitsadmin.exe')
RegWrite($partkey & '07}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '07}', 'ItemData','REG_SZ','Bitsadmin.exe')
RegWrite($partkey & '08}', 'Description','REG_SZ','Bootcfg.exe')
RegWrite($partkey & '08}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '08}', 'ItemData','REG_SZ','Bootcfg.exe')
RegWrite($partkey & '09}', 'Description','REG_SZ','Bootim.exe')
RegWrite($partkey & '09}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '09}', 'ItemData','REG_SZ','Bootim.exe')
RegWrite($partkey & '10}', 'Description','REG_SZ','Bootsect.exe')
RegWrite($partkey & '10}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '10}', 'ItemData','REG_SZ','Bootsect.exe')
RegWrite($partkey & '11}', 'Description','REG_SZ','ByteCodeGenerator.exe')
RegWrite($partkey & '11}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '11}', 'ItemData','REG_SZ','ByteCodeGenerator.exe')
RegWrite($partkey & '12}', 'Description','REG_SZ','Cacls.exe')
RegWrite($partkey & '12}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '12}', 'ItemData','REG_SZ','Cacls.exe')
RegWrite($partkey & '13}', 'Description','REG_SZ','Icacls.exe')
RegWrite($partkey & '13}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '13}', 'ItemData','REG_SZ','Icacls.exe')
RegWrite($partkey & '14}', 'Description','REG_SZ','Csc.exe')
RegWrite($partkey & '14}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '14}', 'ItemData','REG_SZ','Csc.exe')
RegWrite($partkey & '15}', 'Description','REG_SZ','Debug.exe')
RegWrite($partkey & '15}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '15}', 'ItemData','REG_SZ','Debug.exe')
RegWrite($partkey & '16}', 'Description','REG_SZ','DFsvc.exe')
RegWrite($partkey & '16}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '16}', 'ItemData','REG_SZ','DFsvc.exe')
RegWrite($partkey & '17}', 'Description','REG_SZ','Diskpart.exe')
RegWrite($partkey & '17}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '17}', 'ItemData','REG_SZ','Diskpart.exe')
RegWrite($partkey & '18}', 'Description','REG_SZ','Eventvwr.exe')
RegWrite($partkey & '18}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '18}', 'ItemData','REG_SZ','Eventvwr.exe')
RegWrite($partkey & '19}', 'Description','REG_SZ','HH.exe')
RegWrite($partkey & '19}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '19}', 'ItemData','REG_SZ','HH.exe')
RegWrite($partkey & '20}', 'Description','REG_SZ','IEExec.exe')
RegWrite($partkey & '20}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '20}', 'ItemData','REG_SZ','IEExec.exe')
RegWrite($partkey & '21}', 'Description','REG_SZ','Iexplore.exe')
RegWrite($partkey & '21}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '21}', 'ItemData','REG_SZ','Iexplore.exe')
RegWrite($partkey & '22}', 'Description','REG_SZ','Iexpress.exe')
RegWrite($partkey & '22}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '22}', 'ItemData','REG_SZ','Iexpress.exe')
RegWrite($partkey & '23}', 'Description','REG_SZ','Ilasm.exe')
RegWrite($partkey & '23}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '23}', 'ItemData','REG_SZ','Ilasm.exe')
RegWrite($partkey & '24}', 'Description','REG_SZ','InstallUtilLib*')
RegWrite($partkey & '24}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '24}', 'ItemData','REG_SZ','InstallUtilLib*')
RegWrite($partkey & '25}', 'Description','REG_SZ','InstallUtil.exe')
RegWrite($partkey & '25}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '25}', 'ItemData','REG_SZ','InstallUtil.exe')
RegWrite($partkey & '26}', 'Description','REG_SZ','Journal.exe')
RegWrite($partkey & '26}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '26}', 'ItemData','REG_SZ','Journal.exe')
RegWrite($partkey & '27}', 'Description','REG_SZ','Jsc.exe')
RegWrite($partkey & '27}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '27}', 'ItemData','REG_SZ','Jsc.exe')
RegWrite($partkey & '28}', 'Description','REG_SZ','Mmc.exe')
RegWrite($partkey & '28}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '28}', 'ItemData','REG_SZ','Mmc.exe')
RegWrite($partkey & '29}', 'Description','REG_SZ','Mrsa.exe')
RegWrite($partkey & '29}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '29}', 'ItemData','REG_SZ','Mrsa.exe')
RegWrite($partkey & '30}', 'Description','REG_SZ','MSBuild.exe')
RegWrite($partkey & '30}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '30}', 'ItemData','REG_SZ','MSBuild.exe')
RegWrite($partkey & '31}', 'Description','REG_SZ','Mshta.exe')
RegWrite($partkey & '31}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '31}', 'ItemData','REG_SZ','Mshta.exe')
RegWrite($partkey & '32}', 'Description','REG_SZ','Mstsc.exe')
RegWrite($partkey & '32}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '32}', 'ItemData','REG_SZ','Mstsc.exe')
RegWrite($partkey & '33}', 'Description','REG_SZ','Netsh.exe')
RegWrite($partkey & '33}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '33}', 'ItemData','REG_SZ','Netsh.exe')
RegWrite($partkey & '34}', 'Description','REG_SZ','Netstat.exe')
RegWrite($partkey & '34}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '34}', 'ItemData','REG_SZ','Netstat.exe')
RegWrite($partkey & '35}', 'Description','REG_SZ','PresentationHost.exe')
RegWrite($partkey & '35}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '35}', 'ItemData','REG_SZ','PresentationHost.exe')
RegWrite($partkey & '36}', 'Description','REG_SZ','Quser.exe')
RegWrite($partkey & '36}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '36}', 'ItemData','REG_SZ','Quser.exe')
RegWrite($partkey & '37}', 'Description','REG_SZ','Reg.exe')
RegWrite($partkey & '37}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '37}', 'ItemData','REG_SZ','Reg.exe')
RegWrite($partkey & '38}', 'Description','REG_SZ','RegAsmGlobal*')
RegWrite($partkey & '38}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '38}', 'ItemData','REG_SZ','RegAsmGlobal*')
RegWrite($partkey & '39}', 'Description','REG_SZ','Regini.exe')
RegWrite($partkey & '39}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '39}', 'ItemData','REG_SZ','Regini.exe')
RegWrite($partkey & '40}', 'Description','REG_SZ','Regsvcs.exe')
RegWrite($partkey & '40}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '40}', 'ItemData','REG_SZ','Regsvcs.exe')
RegWrite($partkey & '41}', 'Description','REG_SZ','Regsvr32.exe')
RegWrite($partkey & '41}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '41}', 'ItemData','REG_SZ','Regsvr32.exe')
RegWrite($partkey & '42}', 'Description','REG_SZ','RunLegacyCPLElevated.exe')
RegWrite($partkey & '42}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '42}', 'ItemData','REG_SZ','RunLegacyCPLElevated.exe')
RegWrite($partkey & '43}', 'Description','REG_SZ','Runonce.exe')
RegWrite($partkey & '43}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '43}', 'ItemData','REG_SZ','Runonce.exe')
RegWrite($partkey & '44}', 'Description','REG_SZ','Runas.exe')
RegWrite($partkey & '44}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '44}', 'ItemData','REG_SZ','Runas.exe')
RegWrite($partkey & '45}', 'Description','REG_SZ','*script.exe')
RegWrite($partkey & '45}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '45}', 'ItemData','REG_SZ','*script.exe')
RegWrite($partkey & '46}', 'Description','REG_SZ','Set.exe')
RegWrite($partkey & '46}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '46}', 'ItemData','REG_SZ','Set.exe')
RegWrite($partkey & '47}', 'Description','REG_SZ','Setx.exe')
RegWrite($partkey & '47}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '47}', 'ItemData','REG_SZ','Setx.exe')
RegWrite($partkey & '48}', 'Description','REG_SZ','Stash*')
RegWrite($partkey & '48}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '48}', 'ItemData','REG_SZ','Stash*')
RegWrite($partkey & '49}', 'Description','REG_SZ','Systemreset.exe')
RegWrite($partkey & '49}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '49}', 'ItemData','REG_SZ','Systemreset.exe')
RegWrite($partkey & '50}', 'Description','REG_SZ','Takeown.exe')
RegWrite($partkey & '50}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '50}', 'ItemData','REG_SZ','Takeown.exe')
RegWrite($partkey & '51}', 'Description','REG_SZ','Taskkill.exe')
RegWrite($partkey & '51}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '51}', 'ItemData','REG_SZ','Taskkill.exe')
RegWrite($partkey & '52}', 'Description','REG_SZ','UserAccountControlSettings.exe')
RegWrite($partkey & '52}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '52}', 'ItemData','REG_SZ','UserAccountControlSettings.exe')
RegWrite($partkey & '53}', 'Description','REG_SZ','Vbc.exe')
RegWrite($partkey & '53}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '53}', 'ItemData','REG_SZ','Vbc.exe')
RegWrite($partkey & '54}', 'Description','REG_SZ','Vssadmin.exe')
RegWrite($partkey & '54}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '54}', 'ItemData','REG_SZ','Vssadmin.exe')
RegWrite($partkey & '55}', 'Description','REG_SZ','Wmic.exe')
RegWrite($partkey & '55}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '55}', 'ItemData','REG_SZ','Wmic.exe')
RegWrite($partkey & '56}', 'Description','REG_SZ','Xcacls.exe')
RegWrite($partkey & '56}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '56}', 'ItemData','REG_SZ','Xcacls.exe')

RegWrite($partkey & '57}', 'Description','REG_SZ','aspnet_compiler.exe')
RegWrite($partkey & '57}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '57}', 'ItemData','REG_SZ','aspnet_compiler.exe')
RegWrite($partkey & '58}', 'Description','REG_SZ','bash.exe')
RegWrite($partkey & '58}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '58}', 'ItemData','REG_SZ','bash.exe')
RegWrite($partkey & '59}', 'Description','REG_SZ','bginfo.exe')
RegWrite($partkey & '59}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '59}', 'ItemData','REG_SZ','bginfo.exe')
RegWrite($partkey & '60}', 'Description','REG_SZ','bitsadmin*')
RegWrite($partkey & '60}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '60}', 'ItemData','REG_SZ','bitsadmin*')
RegWrite($partkey & '61}', 'Description','REG_SZ','cdb.exe')
RegWrite($partkey & '61}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '61}', 'ItemData','REG_SZ','cdb.exe')
RegWrite($partkey & '62}', 'Description','REG_SZ','csi.exe')
RegWrite($partkey & '62}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '62}', 'ItemData','REG_SZ','csi.exe')
RegWrite($partkey & '63}', 'Description','REG_SZ','cvtres.exe')
RegWrite($partkey & '63}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '63}', 'ItemData','REG_SZ','cvtres.exe')
RegWrite($partkey & '64}', 'Description','REG_SZ','dbghost.exe')
RegWrite($partkey & '64}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '64}', 'ItemData','REG_SZ','dbghost.exe')
RegWrite($partkey & '65}', 'Description','REG_SZ','dbgsvc.exe')
RegWrite($partkey & '65}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '65}', 'ItemData','REG_SZ','dbgsvc.exe')
RegWrite($partkey & '66}', 'Description','REG_SZ','dnx.exe')
RegWrite($partkey & '66}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '66}', 'ItemData','REG_SZ','dnx.exe')
RegWrite($partkey & '67}', 'Description','REG_SZ','fsi.exe')
RegWrite($partkey & '67}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '67}', 'ItemData','REG_SZ','fsi.exe')
RegWrite($partkey & '68}', 'Description','REG_SZ','fsiAnyCpu.exe')
RegWrite($partkey & '68}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '68}', 'ItemData','REG_SZ','fsiAnyCpu.exe')
RegWrite($partkey & '69}', 'Description','REG_SZ','infdefaultinstall.exe')
RegWrite($partkey & '69}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '69}', 'ItemData','REG_SZ','infdefaultinstall.exe')
RegWrite($partkey & '70}', 'Description','REG_SZ','InstallUtil*')
RegWrite($partkey & '70}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '70}', 'ItemData','REG_SZ','InstallUtil*')
RegWrite($partkey & '71}', 'Description','REG_SZ','kd.exe')
RegWrite($partkey & '71}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '71}', 'ItemData','REG_SZ','kd.exe')
RegWrite($partkey & '72}', 'Description','REG_SZ','lpkinstall*')
RegWrite($partkey & '72}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '72}', 'ItemData','REG_SZ','lpkinstall*')
RegWrite($partkey & '73}', 'Description','REG_SZ','LxssManager.dll')
RegWrite($partkey & '73}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '73}', 'ItemData','REG_SZ','LxssManager.dll')
RegWrite($partkey & '74}', 'Description','REG_SZ','msiexec.exe')
RegWrite($partkey & '74}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '74}', 'ItemData','REG_SZ','msiexec.exe')
RegWrite($partkey & '75}', 'Description','REG_SZ','ntkd.exe')
RegWrite($partkey & '75}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '75}', 'ItemData','REG_SZ','ntkd.exe')
RegWrite($partkey & '76}', 'Description','REG_SZ','ntsd.exe')
RegWrite($partkey & '76}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '76}', 'ItemData','REG_SZ','ntsd.exe')
RegWrite($partkey & '77}', 'Description','REG_SZ','odbcconf.exe')
RegWrite($partkey & '77}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '77}', 'ItemData','REG_SZ','odbcconf.exe')
RegWrite($partkey & '78}', 'Description','REG_SZ','rcsi.exe')
RegWrite($partkey & '78}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '78}', 'ItemData','REG_SZ','rcsi.exe')
RegWrite($partkey & '79}', 'Description','REG_SZ','RegAsm*')
RegWrite($partkey & '79}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '79}', 'ItemData','REG_SZ','RegAsm*')
RegWrite($partkey & '80}', 'Description','REG_SZ','Regsvcs*')
RegWrite($partkey & '80}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '80}', 'ItemData','REG_SZ','Regsvcs*')
RegWrite($partkey & '81}', 'Description','REG_SZ','runscripthelper.exe')
RegWrite($partkey & '81}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '81}', 'ItemData','REG_SZ','runscripthelper.exe')
RegWrite($partkey & '82}', 'Description','REG_SZ','schtasks.exe')
RegWrite($partkey & '82}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '82}', 'ItemData','REG_SZ','schtasks.exe')
RegWrite($partkey & '83}', 'Description','REG_SZ','scrcons.exe')
RegWrite($partkey & '83}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '83}', 'ItemData','REG_SZ','scrcons.exe')
RegWrite($partkey & '84}', 'Description','REG_SZ','sdbinst.exe')
RegWrite($partkey & '84}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '84}', 'ItemData','REG_SZ','sdbinst.exe')
RegWrite($partkey & '85}', 'Description','REG_SZ','sdclt.exe')
RegWrite($partkey & '85}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '85}', 'ItemData','REG_SZ','sdclt.exe')
RegWrite($partkey & '86}', 'Description','REG_SZ','syskey.exe')
RegWrite($partkey & '86}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '86}', 'ItemData','REG_SZ','syskey.exe')
RegWrite($partkey & '87}', 'Description','REG_SZ','utilman.exe')
RegWrite($partkey & '87}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '87}', 'ItemData','REG_SZ','utilman.exe')
RegWrite($partkey & '88}', 'Description','REG_SZ','visualuiaverifynative.exe')
RegWrite($partkey & '88}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '88}', 'ItemData','REG_SZ','visualuiaverifynative.exe')
RegWrite($partkey & '89}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '89}', 'Description','REG_SZ','wbemtest.exe')
RegWrite($partkey & '89}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '89}', 'ItemData','REG_SZ','wbemtest.exe')
RegWrite($partkey & '90}', 'Description','REG_SZ','windbg.exe')
RegWrite($partkey & '90}', 'SaferFlags','REG_DWORD',Number('0'))
RegWrite($partkey & '90}', 'ItemData','REG_SZ','windbg.exe')

; Write data to ...\safer_Hard_Configurator\CodeIdentifiers\BlockSponsors
$key = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers\BlockSponsors'
RegWrite($key, 'IsAuditpol.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsCMDBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsPowerShellBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsPowerShell_iseBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsAttrib.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsBcdboot.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsBcdedit.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsBitsadmin.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsBootcfg.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsBootim.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsBootsect.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsByteCodeGenerator.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsCacls.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsIcacls.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsCsc.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsDebug.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsDFsvc.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsDiskpart.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsEventvwr.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsHH.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsIEExec.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsIexplore.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsIexpress.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsIlasm.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsInstallUtilLib*Blocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsInstallUtil.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsJournal.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsJsc.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsMmc.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsMrsa.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsMSBuild.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsMshta.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsMstsc.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsNetsh.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsNetstat.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsPresentationHost.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsQuser.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsReg.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsRegAsmGlobal*Blocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsRegini.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsRegsvcs.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsRegsvr32.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsRunLegacyCPLElevated.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsRunonce.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsRunas.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'Is*script.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsSet.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsSetx.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsStash*Blocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsSystemreset.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsTakeown.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsTaskkill.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsUserAccountControlSettings.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsVbc.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsVssadmin.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsWmic.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsXcacls.exeBlocked','REG_DWORD',Number('1'))

RegWrite($key, 'IsAspnet_compiler.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsBash.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsBginfo.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsBitsadmin*Blocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsCdb.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsCsi.exeBlocked','REG_DWORD',Number('1'))

RegWrite($key, 'IsCvtres.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsDbghost.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsDbgsvc.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsDnx.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsFsi.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsfsiAnyCpu.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsInfdefaultinstall.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsInstallUtil*Blocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsKd.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsLpkinstall*Blocked','REG_DWORD',Number('1'))

RegWrite($key, 'IsLxssManager.dllBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsMsiexec.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsNtkd.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsNtsd.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsOdbcconf.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsRcsi.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsRegAsm*Blocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsRegsvcs*Blocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsRunscripthelper.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsSchtasks.exeBlocked','REG_DWORD',Number('1'))

RegWrite($key, 'IsScrcons.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsSdbinst.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsSdclt.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsSyskey.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsUtilman.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsVisualuiaverifynative.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsWbemtest.exeBlocked','REG_DWORD',Number('1'))
RegWrite($key, 'IsWindbg.exeBlocked','REG_DWORD',Number('1'))


$RefreshChangesCheck = $RefreshChangesCheck & "BlockAllSponsors" & @LF
EndFunc


Func BlockAllSponsors1()
BlockAllSponsors()
CheckStateOfSponsorsCheckboxes()
EndFunc



Func AllowAllSponsors()
Local $partkey = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers\0\Paths\{1016bbe0-a716-428b-822e-5E544B6A31'
RegDelete($partkey & '00}')
RegDelete($partkey & '01}')
RegDelete($partkey & '02}')
RegDelete($partkey & '03}')
RegDelete($partkey & '04}')
RegDelete($partkey & '05}')
RegDelete($partkey & '06}')
RegDelete($partkey & '07}')
RegDelete($partkey & '08}')
RegDelete($partkey & '09}')
RegDelete($partkey & '10}')
RegDelete($partkey & '11}')
RegDelete($partkey & '12}')
RegDelete($partkey & '13}')
RegDelete($partkey & '14}')
RegDelete($partkey & '15}')
RegDelete($partkey & '16}')
RegDelete($partkey & '17}')
RegDelete($partkey & '18}')
RegDelete($partkey & '19}')
RegDelete($partkey & '20}')
RegDelete($partkey & '21}')
RegDelete($partkey & '22}')
RegDelete($partkey & '23}')
RegDelete($partkey & '24}')
RegDelete($partkey & '25}')
RegDelete($partkey & '26}')
RegDelete($partkey & '27}')
RegDelete($partkey & '28}')
RegDelete($partkey & '29}')
RegDelete($partkey & '30}')
RegDelete($partkey & '31}')
RegDelete($partkey & '32}')
RegDelete($partkey & '33}')
RegDelete($partkey & '34}')
RegDelete($partkey & '35}')
RegDelete($partkey & '36}')
RegDelete($partkey & '37}')
RegDelete($partkey & '38}')
RegDelete($partkey & '39}')
RegDelete($partkey & '40}')
RegDelete($partkey & '41}')
RegDelete($partkey & '42}')
RegDelete($partkey & '43}')
RegDelete($partkey & '44}')
RegDelete($partkey & '45}')
RegDelete($partkey & '46}')
RegDelete($partkey & '47}')
RegDelete($partkey & '48}')
RegDelete($partkey & '49}')
RegDelete($partkey & '50}')
RegDelete($partkey & '51}')
RegDelete($partkey & '52}')
RegDelete($partkey & '53}')
RegDelete($partkey & '54}')
RegDelete($partkey & '55}')
RegDelete($partkey & '56}')

RegDelete($partkey & '57}')
RegDelete($partkey & '58}')
RegDelete($partkey & '59}')
RegDelete($partkey & '60}')
RegDelete($partkey & '61}')
RegDelete($partkey & '62}')
RegDelete($partkey & '63}')
RegDelete($partkey & '64}')
RegDelete($partkey & '65}')
RegDelete($partkey & '66}')
RegDelete($partkey & '67}')
RegDelete($partkey & '68}')
RegDelete($partkey & '69}')
RegDelete($partkey & '70}')
RegDelete($partkey & '71}')
RegDelete($partkey & '72}')
RegDelete($partkey & '73}')
RegDelete($partkey & '74}')
RegDelete($partkey & '75}')
RegDelete($partkey & '76}')
RegDelete($partkey & '77}')
RegDelete($partkey & '78}')
RegDelete($partkey & '79}')
RegDelete($partkey & '80}')
RegDelete($partkey & '81}')
RegDelete($partkey & '82}')
RegDelete($partkey & '83}')
RegDelete($partkey & '84}')
RegDelete($partkey & '85}')
RegDelete($partkey & '86}')
RegDelete($partkey & '87}')
RegDelete($partkey & '88}')
RegDelete($partkey & '89}')
RegDelete($partkey & '90}')


RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers\BlockSponsors')
$RefreshChangesCheck = $RefreshChangesCheck & "AllowAllSponsors" & @LF

EndFunc


Func AllowAllSponsors1()
AllowAllSponsors()
CheckStateOfSponsorsCheckboxes()
EndFunc
