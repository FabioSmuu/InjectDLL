unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, ComCtrls, ExtCtrls, TlHelp32, ShellAPI;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    ListBox1: TListBox;
    Timer1: TTimer;
    OpenDialog1: TOpenDialog;
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    ListBox2: TListBox;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ListBox2DblClick(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
  private
    procedure VerProcess;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.VerProcess;
const
   PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := sizeof(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  ListBox2.Clear;
  while Integer(ContinueLoop) <> 0 do
  begin
    ListBox2.Items.Add(FProcessEntry32.szExeFile);
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
  ListBox2.Sorted := True; //Serve para ordenar a lista dos processos por ordem alfabética
end;
///////////////////////////////////////////////////////////////////////

function GetPID(ProcessName: string): DWORD;
var MyHandle: THandle;
    Struct: TProcessEntry32;
begin
 Result:=0;
 try
  MyHandle:=CreateToolHelp32SnapShot(TH32CS_SNAPPROCESS, 0);
  Struct.dwSize:=Sizeof(TProcessEntry32);
  if Process32First(MyHandle, Struct) then
   if Struct.szExeFile=ProcessName then
    begin
     Result:=Struct.th32ProcessID;
     Exit;
    end;
  while Process32Next(MyHandle, Struct) do
   if Struct.szExeFile=ProcessName then
    begin
     Result:=Struct.th32ProcessID;
     Exit;
    end;
 except on exception do
  Exit;
 end;
end;

function InjectDll(PID:DWORD; sDll:string):Boolean;
var
hLib:     Pointer;
hThread:  THandle;
pMod:     Pointer;
hOpen:    THandle;
dWritten: Cardinal;
ThreadID: Cardinal;
begin
  Result := FALSE;
  hOpen := OpenProcess(PROCESS_ALL_ACCESS, FALSE, PID);
  if hOpen <> INVALID_HANDLE_VALUE then
  begin
    hLib := GetProcAddress(GetModuleHandle(PChar('kernel32.dll')), PChar('LoadLibraryA'));
    pMod := VirtualAllocEx(hOpen, nil, Length(sDll) + 1, MEM_COMMIT or MEM_RESERVE, PAGE_EXECUTE_READWRITE);
    if WriteProcessMemory(hOpen, pMod, @sDll[1], Length(sDll), dWritten) then
      Result := TRUE;
    hThread := CreateRemoteThread(hOpen, nil, 0, hLib, pMod, 0, ThreadID);
    WaitForSingleObject(hThread, INFINITE);
    CloseHandle(hOpen);
    CloseHandle(hThread);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
if not OpenDialog1.Execute then Exit;
 Listbox1.Items.Add(OpenDialog1.FileName);
 Statusbar1.Panels[1].Text := inttostr(listbox1.Count)+' DLLs';
 if (listbox1.Count >= 1 ) then button1.Enabled := true;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
Timer1.Enabled:=True;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
Listbox1.DeleteSelected;
 Statusbar1.Panels[1].Text := inttostr(listbox1.Count)+' DLLs';
  if (listbox1.Count <= 0 ) then button1.Enabled := false;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
Listbox1.Clear;
button1.Enabled := false;
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
//Timer1.Enabled:=True;
end;

procedure TForm1.Timer1Timer(Sender: TObject);

var PID: DWORD;
begin
 Timer1.Enabled:=False;
 PID:=GetPID(Edit1.Text);
 if PID=0 then
  begin
   Timer1.Enabled:=True;
   Exit;
  end;
 Timer1.Enabled:=False;
// if InjectDll(PID, Edit2.Text) then
 if InjectDll(PID, Opendialog1.FileName) then
  Statusbar1.Panels[1].Text := 'DLL Injetada com Sucesso!'
 else
  MessageBoxA(Handle, 'Erro ao injetar DLL.', 'Oops!', MB_ICONERROR+MB_SYSTEMMODAL);
  if (radiobutton1.Checked) then application.Terminate;
//  if (radiobutton2.Checked) then Listbox1.Clear;button1.Enabled := false;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
VerProcess;
end;

procedure TForm1.ListBox2DblClick(Sender: TObject);
begin
edit1.text :=  listbox2.items [listbox2.itemindex];
listbox2.hide;
end;

procedure TForm1.Edit1Click(Sender: TObject);
begin
listbox2.Show;
end;

end.
