; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Hard_Configurator"
#define MyAppVersion "4.0.1.0"
#define MyAppPublisher "Andy Ful"
#define MyAppURL "https://github.com/AndyFul/Hard_Configurator"
#define MyAppExeName "Hard_Configurator(x64).exe"
#define MySwitchName = "Switch Default Deny"
#define MySwitchExeName = "SwitchDefaultDeny(x64).exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{035BFEF3-46F7-4E6A-AC26-5A6D99E96D7F}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={win}\{#MyAppName}
DisableDirPage=yes
DisableProgramGroupPage=yes
OutputBaseFilename=setup
Compression=lzma
SolidCompression=yes
ArchitecturesAllowed=x64
InfoBeforeFile=infobefore.txt

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"

[Code]
function IsAppRunning(const FileName: string): Boolean;
var
  FWMIService: Variant;
  FSWbemLocator: Variant;
  FWbemObjectSet: Variant;

begin
  Result := false;
  FSWbemLocator := CreateOleObject('WBEMScripting.SWBEMLocator');
  FWMIService := FSWbemLocator.ConnectServer('', 'root\CIMV2', '', '');
  FWbemObjectSet := FWMIService.ExecQuery(Format('SELECT Name FROM Win32_Process Where Name="%s"',[FileName]));
  Result := (FWbemObjectSet.Count > 0);
  FWbemObjectSet := Unassigned;
  FWMIService := Unassigned;
  FSWbemLocator := Unassigned;
end;

function InitializeSetup: boolean;
var
  Order0: Integer;
  Order1: Integer;
  Order2: Integer;
  Order3: Integer;
  Order4: Integer;
  ErrorCode: Integer;
 begin
  Order0 := 0;
  Order1 := 0;
  Order2 := 0;
  Order3 := 0;
  Result := not IsAppRunning('FullEventLogView.exe');
  if not Result then
  Order0 := 1;
  Result := not IsAppRunning('ConfigureDefender_x64.exe');
  if not Result then Order1 := 1;
  Result := not IsAppRunning('Hard_Configurator(x64).exe');
  if not Result then Order2 := 1;
  Result := not IsAppRunning('SwitchDefaultDeny(x64).exe');
  if not Result then Order3 := 1;
  Result := not IsAppRunning('DocumentsAntiExploit(x64).exe');
  if not Result then Order4 := 1;
  If not (Order1 + Order2 + Order3 + Order4 = 0) Then begin
    MsgBox('Some processes related to Hard_Configurator are running on this or another account. They will be closed. This sometimes, can cause closing the installation process. If so then run again the installer.', mbError, MB_OK);
     If not (Order0 = 0) Then begin
        ShellExec('open',  'taskkill.exe', '/f /im FullEventLogView.exe','',SW_HIDE,ewNoWait,ErrorCode);
     end;
     If not (Order1 = 0) Then begin
        ShellExec('open',  'taskkill.exe', '/f /im ConfigureDefender_x64.exe','',SW_HIDE,ewNoWait,ErrorCode);
     end;
     If not (Order2 = 0) Then begin
        ShellExec('open',  'taskkill.exe', '/f /im Hard_Configurator(x64).exe','',SW_HIDE,ewNoWait,ErrorCode);
     end;
     If not (Order3 = 0) Then begin
        ShellExec('open',  'taskkill.exe', '/f /im SwitchDefaultDeny(x64).exe','',SW_HIDE,ewNoWait,ErrorCode);
     end;
     If not (Order4 = 0) Then begin
        ShellExec('open',  'taskkill.exe', '/f /im DocumentsAntiExploit(x64).exe','',SW_HIDE,ewNoWait,ErrorCode);
     end;
  end;
end;

[Files]
Source: "C:\Windows\Hard_Configurator\Hard_Configurator(x64).exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Windows\Hard_Configurator\RunAsSmartscreen(x64).exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Windows\Hard_Configurator\RunBySmartscreen(x64).exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Windows\Hard_Configurator\ConfigureDefender_x64.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Windows\Hard_Configurator\SwitchDefaultDeny(x64).exe"; DestDir: "{app}"; Flags: ignoreversion 
Source: "C:\Windows\Hard_Configurator\DocumentsAntiExploit(x64).exe"; DestDir: "{app}"; Flags: ignoreversion 
Source: "C:\Windows\Hard_Configurator\What_is_new.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Windows\Hard_Configurator\Installation.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Windows\Hard_Configurator\Quick_Configuration.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Windows\Hard_Configurator\DeInstallation.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Windows\Hard_Configurator\readme.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Windows\Hard_Configurator\Part 1 - How do Software Restriction Policies work.pdf"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Windows\Hard_Configurator\Part 2 - How do Software Restriction Policies work.pdf"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Windows\Hard_Configurator\Part 3 - How do Software Restriction Policies work.pdf"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Windows\Hard_Configurator\Hard_Configurator - Manual.pdf"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Windows\Hard_Configurator\Backup\*"; DestDir: "{app}\Backup"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\Windows\Hard_Configurator\Configuration\*"; DestDir: "{app}\Configuration"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\Windows\Hard_Configurator\HELP\*"; DestDir: "{app}\HELP"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\Windows\Hard_Configurator\Skins\*"; DestDir: "{app}\Skins"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\Windows\Hard_Configurator\Temp\*"; DestDir: "{app}\Temp"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\Windows\Hard_Configurator\TOOLS\*"; DestDir: "{app}\Tools"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Dirs]
Name: "{app}\Temp"

[Icons]
Name: "{commonprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{commonprograms}\{#MySwitchName}"; Filename: "{app}\{#MySwitchExeName}"
Name: "{commondesktop}\{#MySwitchName}"; Filename: "{app}\{#MySwitchExeName}"; Tasks: desktopicon


[Run]
Filename: "{app}\README.TXT"; Description: "View the README file"; Flags: postinstall shellexec skipifsilent
Filename: "{app}\What_is_new.txt"; Description: "What is new?"; Flags: postinstall shellexec skipifsilent
Filename: "{app}\Quick_Configuration.txt"; Description: "Quick Configuration"; Flags: postinstall shellexec skipifsilent
Filename: "{app}\TOOLS\7zip(x64)\README.TXT"; Description: "View the 7-ZIP README file"; Flags: postinstall shellexec skipifsilent
Filename: "{app}\TOOLS\Autoruns(x64)\Eula.txt"; Description: "View the Autoruns EULA"; Flags: postinstall shellexec skipifsilent
Filename: "{app}\TOOLS\FullEventLogView(x64)\README.TXT"; Description: "View the FullEventView README file"; Flags: postinstall shellexec skipifsilent

[UninstallDelete]
Type: filesandordirs; Name: "{app}"