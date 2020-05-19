Func RestoreWindowsDefaults()
  
  Local $YesNo = MsgBox(4,"","Do you want to remove all Hard_Configurator settings?")
  Switch $YesNo
  case 6
     RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers')
     $isSRPinstalled = "Not Installed"
     Local $key = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers'
     RegWrite($key, 'AuthenticodeEnabled', 'REG_DWORD', Number('0'))
     RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator')
     FileDelete($ProgramFolder & 'Hard_Configurator.ini')
     RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers', 'Installed', 'REG_SZ', '1')
     TurnOFFAllRestrictions()
     RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator')
     MsgBox(0,"",'Hard_Configurator will exit now.' & @CRLF & 'Please reboot Windows to fully restore Windows Defaults.')
     Exit  
  case 7
     Return
  EndSwitch 

EndFunc

Func RestoreWindowsDefaults1()
     RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers')
     $isSRPinstalled = "Not Installed"
     Local $key = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\CodeIdentifiers'
     RegWrite($key, 'AuthenticodeEnabled', 'REG_DWORD', Number('0'))
     RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator')
     FileDelete($ProgramFolder & 'Hard_Configurator.ini')
     RegWrite('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator\CodeIdentifiers', 'Installed', 'REG_SZ', '1')
     TurnOFFAllRestrictions()
     RegDelete('HKLM\SOFTWARE\Policies\Microsoft\Windows\safer_Hard_Configurator')
EndFunc

