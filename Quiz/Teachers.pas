unit Teachers;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileCtrl, Spin, Menus, inifiles, hh_funcs, hh, XPMenu, ImgList,
  registry, shlobj;

type
  TTeachersForm = class(TForm)
    DirectoryList: TDirectoryListBox;
    FileList: TFileListBox;
    DriveList: TDriveComboBox;
    TimeSelect: TSpinEdit;
    FileSelectionGbox: TGroupBox;
    TimerSelectGbox: TGroupBox;
    TimeLbl: TLabel;
    MainMenu: TMainMenu;
    FileMenu: TMenuItem;
    EndQuiz: TMenuItem;
    StartQuiz: TMenuItem;
    StartBtn: TButton;
    TopicName: TLabel;
    HelpMenu: TMenuItem;
    AboutBtn: TMenuItem;
    DisplayHelpContents: TMenuItem;
    DisplayHelpIndex: TMenuItem;
    N1: TMenuItem;
    XPMenu1: TXPMenu;
    ImageList1: TImageList;
    Tools1: TMenuItem;
    RegisterFileTypes: TMenuItem;
    UseCustomText: TMenuItem;
    UseCustomSounds: TMenuItem;
    procedure EndQuizMenu(Sender: TObject);
    procedure StartQuestionsBtn(Sender: TObject);
    procedure SelectQuestionsLbox(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StartQuizClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AboutBtnClick(Sender: TObject);
    procedure DisplayHelpContentsClick(Sender: TObject);
    procedure DisplayHelpIndexClick(Sender: TObject);
    procedure DisplayHelpSearchClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RegisterFileTypesClick(Sender: TObject);
    procedure UseCustomTextClick(Sender: TObject);
    procedure UseCustomSoundsClick(Sender: TObject);
  private
    IniFile: TIniFile;
  public
    { Public declarations }
    Procedure ExitProgram;
    Procedure StartQuestions;
    Procedure SelectQuestions;
    Procedure RegEditor(ExtName:string; AppName:String);
    Procedure RegQuiz(ExtName:string; AppName:String);
    Procedure SaveSettings;
    Procedure LoadSettings;
    Function  CheckSettingsFile:boolean;
    Procedure SetProgramPath;
    Procedure LoadLang;
    Procedure SetLang;
  end;

var
  TeachersForm: TTeachersForm;
  Filename:string;               //The Question papers filename
  Topic:WideString;              //The Topic of the Question paper
  TimeLimit:integer;             //Set the time limit for each question
  NoOfQuestions:integer;         //The No. Of Question in the paper
  Question:WideString;           //The Question - 304 chars
  Answer1:WideString;            //Possible Answer 1 - 249 chars
  Answer2:WideString;            //Possible Answer 2 - 249 chars
  Answer3:WideString;            //Possible Answer 3 - 249 chars
  Answer4:WideString;            //Possible Answer 4 - 249 chars
  UserAnswer:WideString;         //The users answer
  CorrectAnswer:WideString;      //The Correct Answer - 249 chars
  CurrentQuestion:integer;       //The current question no. e.g. 1, 2, 3 etc...
  QuestionNo:string;             //The current question no. for reading question e.g. Q1, Q2 ,Q3 etc...
  Score:integer;                 //Running Score Counter
  Percentage:real;               //Calculates percentage

  HelpFilePath:string;           //Filename & Path of HelpFile
  HelpOpen:boolean=false;

  ProgramPath:string;            //Programs Own Path

  CustomMessage:boolean=false;
  CustomSounds:boolean=false;

  Lang:Array[1..38] of WideString;

implementation

uses Students, about;

{$R *.DFM}

procedure TTeachersForm.EndQuizMenu(Sender: TObject);
{
  Main Menu Exit Button
}
begin
  ExitProgram;
end;


procedure TTeachersForm.StartQuestionsBtn(Sender: TObject);
{
  Procedures to start quiz
}
begin
  StartQuestions;
end;

procedure TTeachersForm.StartQuizClick(Sender: TObject);
{
  Procedures to start quiz from Main Menu
}
begin
  StartQuestions;
end;

procedure TTeachersForm.SelectQuestionsLbox(Sender: TObject);
{
  Procedure to run when file selected
}
begin
  SelectQuestions;
end;

procedure TTeachersForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
{
  Procedure to run when Form closed
}
begin
  ExitProgram;
end;

procedure TTeachersForm.FormShow(Sender: TObject);
{
  Code to run when Form displayed
}
begin
  HelpFilePath:=ExtractFilePath(Application.ExeName)+'help.chm';
  HelpOpen:=False;
end;

procedure TTeachersForm.ExitProgram;
{
  Code To End Application
}
begin
  SaveSettings;
  Application.Terminate;
end;

procedure TTeachersForm.StartQuestions;
{
  Code to Set Time Limit & to check a file has been selected.
  Hides current for (Teachers) and Displays Question form (Students).
}
begin
  if filelist.filename <> '' then
    begin
      TimeLimit:=TimeSelect.Value;
      StudentsForm.CountDownLbl.Caption:=inttostr(TimeLimit);

      TeachersForm.Visible:=false;
      StudentsForm.visible:=true;
    end
  else
    begin
      Application.MessageBox(PAnsiChar(String(Lang[1])),PAnsiChar(String(Lang[2])),0)
    end;
end;

procedure TTeachersForm.SelectQuestions;
{
  Displays Topic of Question Paper Selected and reads in the
  number of questions.
}
begin
  filename:=filelist.filename; //Select & Set Question Paper
  IniFile := TIniFile.Create (filename); //Open File

  Topic := inifile.ReadString ('Main', 'Topic', Topic);  //Read in the Topic
  TopicName.Caption:=topic;                              //Display Topic in Label

  NoOfQuestions := inifile.ReadInteger ('Main', 'Questions', NoOfQuestions);  //Read No. of Questions

  IniFile.Destroy; //Close File
end;


procedure TTeachersForm.AboutBtnClick(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TTeachersForm.DisplayHelpContentsClick(Sender: TObject);
begin
  HtmlHelp(GetDesktopWindow, PChar(HelpFilePath), HH_DISPLAY_TOC, 0);
  HelpOpen:=True;
end;

procedure TTeachersForm.DisplayHelpIndexClick(Sender: TObject);
begin
  HtmlHelp(GetDesktopWindow, PChar(HelpFilePath), HH_DISPLAY_INDEX, 0);
  HelpOpen:=True;
end;

procedure TTeachersForm.DisplayHelpSearchClick(Sender: TObject);
begin
  HtmlHelp(GetDesktopWindow, PChar(HelpFilePath), HH_DISPLAY_SEARCH, 0);
  HelpOpen:=True;
end;

procedure TTeachersForm.FormDestroy(Sender: TObject);
begin
  If HelpOpen then HtmlHelp(0, nil, HH_CLOSE_ALL, 0);
end;

procedure TTeachersForm.FormCreate(Sender: TObject);
begin
  SetProgramPath;
  LoadSettings;

  If ParamStr(1)<>'' then
    begin
      Filename:=ParamStr(1);
      FileList.ApplyFilePath(ParamStr(1));
    end;

  LoadLang;
  SetLang;
end;

procedure TTeachersForm.RegEditor(ExtName:string; AppName:String);
var Reg:TRegistry;
begin
  Reg:=TRegistry.Create;
  try
    Reg.RootKey:=HKEY_CLASSES_ROOT;
    Reg.OpenKey('.' + ExtName, True);
    Reg.WriteString('', ExtName + 'file');
    Reg.CloseKey;
    Reg.OpenKey(ExtName + 'file\shell\edit\command', True);
    Reg.WriteString('', AppName+' "%1"');
    Reg.CloseKey;
  finally
    Reg.Free;
  end;

  SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
end;

procedure TTeachersForm.RegQuiz(ExtName:string; AppName:String);
var Reg:TRegistry;
begin
  Reg:=TRegistry.Create;
  try
    Reg.RootKey:=HKEY_CLASSES_ROOT;
    Reg.OpenKey('.' + ExtName, True);
    Reg.WriteString('', ExtName + 'file');
    Reg.CloseKey;
    Reg.OpenKey(ExtName + 'file\shell\open\command', True);
    Reg.WriteString('', AppName+' "%1"');
    Reg.CloseKey;
  finally
    Reg.Free;
  end;

  SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
end;

procedure TTeachersForm.RegisterFileTypesClick(Sender: TObject);
begin
  RegEditor('QQQ',ProgramPath+ExtractFileName(ParamStr(0)));
  RegQuiz('QQQ',ProgramPath+'Quiz.exe');
end;

procedure TTeachersForm.UseCustomTextClick(Sender: TObject);
begin
  If UseCustomText.Checked=True then
    begin
      UseCustomText.Checked:=False;
      CustomMessage:=False;
    end
  else
    begin
      UseCustomText.Checked:=True;
      CustomMessage:=True;
    end;
end;

procedure TTeachersForm.UseCustomSoundsClick(Sender: TObject);
begin
  If UseCustomSounds.Checked=True then
    begin
      UseCustomSounds.Checked:=False;
      CustomSounds:=False;
    end
  else
    begin
      UseCustomSounds.Checked:=True;
      CustomSounds:=True;
    end;
end;

procedure TTeachersForm.LoadSettings;
const
  Settings='settings.dat';

var
  Filein:TextFile;
  SettingFileName:string;
  i:integer;
  Input:Array[1..3] of String[5];
begin
  SettingFileName:=ProgramPath+Settings;
  If FileExists(SettingFileName) then
    begin
      AssignFile(Filein,SettingFileName);
      Reset(Filein);

      For i:=1 to 3 do begin
        Readln(Filein,Input[i]);
      end;
      CloseFile(Filein);

      //Load Custom Text Settings
      If UpperCase(Input[1])='Y' then
        begin
          UseCustomText.Checked:=True;
          CustomMessage:=True;
        end
      else
        begin
          UseCustomText.Checked:=False;
          CustomMessage:=False;
        end;

      //Load Custom Sound Settings
      If UpperCase(Input[2])='Y' then
        begin
          UseCustomSounds.Checked:=True;
          CustomSounds:=True;
        end
      else
        begin
          UseCustomSounds.Checked:=False;
          CustomSounds:=False;
        end;

      //Load Time Limit Value
      If (StrToInt(Input[3])<15) or (StrToInt(Input[3])>30) then
        begin
          TimeSelect.Value:=30;
        end
      else
        begin
          TimeSelect.Value:=StrToInt(Input[3]);
        end;
    end
  else
    begin
      UseCustomText.Checked:=False;
      UseCustomSounds.Checked:=False;
      TimeSelect.Value:=30;
    end;
end;

procedure TTeachersForm.SaveSettings;
const
  Settings='settings.dat';

var
  Fileout:TextFile;
  SettingFileName:string;
begin
  SettingFileName:=ProgramPath+Settings;
  If CheckSettingsFile=True then
    begin
    //showmessage(SettingFileName);
      AssignFile(Fileout,SettingFileName);
      ReWrite(Fileout);

      //Save Custom Text Settings
      If UseCustomText.Checked=True then Writeln(Fileout,'Y')
        else Writeln(Fileout,'N');

      //Save Custom Sound Settings
      If UseCustomSounds.Checked=True then Writeln(Fileout,'Y')
        else Writeln(Fileout,'N');

      //Save Time Limit Value
      Writeln(Fileout,IntToStr(TimeSelect.Value));

      CloseFile(Fileout);
    end;
end;

function TTeachersForm.CheckSettingsFile: boolean;
const
  Settings='settings.dat';

var
  SettingFileName:string;
  Fileout:TextFile;
begin
  SettingFileName:=ProgramPath+Settings;
  {$I-}
  AssignFile(Fileout,settings);
  ReWrite(Fileout);
  {$I+}
  Result:= (IOResult = 0);
  CloseFile(Fileout);
end;

procedure TTeachersForm.SetProgramPath;
begin
   ProgramPath := ExtractFilePath(ParamStr(0));
end;

procedure TTeachersForm.LoadLang;
begin
//Load lang from ini
  filename:=ProgramPath+'lang.ini';
  If FileExists(filename) then begin
    IniFile := TIniFile.Create (filename);

    Lang[1] := inifile.ReadString ('Quiz', 'InternalMsg1', text);
    Lang[2] := inifile.ReadString ('Quiz', 'InternalMsg2', text);
    Lang[3] := inifile.ReadString ('Quiz', 'File', text);
    Lang[4] := inifile.ReadString ('Quiz', 'Start', text);
    Lang[5] := inifile.ReadString ('Quiz', 'Exit', text);
    Lang[6] := inifile.ReadString ('Quiz', 'Tools', text);
    Lang[7] := inifile.ReadString ('Quiz', 'FileTypes', text);
    Lang[8] := inifile.ReadString ('Quiz', 'CustomText', text);
    Lang[9] := inifile.ReadString ('Quiz', 'CustomSound', text);
    Lang[10] := inifile.ReadString ('Quiz', 'Help', text);
    Lang[11] := inifile.ReadString ('Quiz', 'Contents', text);
    Lang[12] := inifile.ReadString ('Quiz', 'Index', text);
    Lang[13] := inifile.ReadString ('Quiz', 'About', text);
    Lang[14] := inifile.ReadString ('Quiz', 'SelectTopic', text);
    Lang[15] := inifile.ReadString ('Quiz', 'Timer', text);
    Lang[16] := inifile.ReadString ('Quiz', 'SetTimer', text);
    Lang[17] := inifile.ReadString ('Quiz', 'TopicName', text);
    Lang[18] := inifile.ReadString ('Quiz', 'TimeLeft', text);
    Lang[19] := inifile.ReadString ('Quiz', 'Score', text);
    Lang[20] := inifile.ReadString ('Quiz', 'CorrectAnswer', text);
    Lang[21] := inifile.ReadString ('Quiz', 'AnswerCorrect', text);
    Lang[22] := inifile.ReadString ('Quiz', 'AnswerWrong', text);
    Lang[23] := inifile.ReadString ('Quiz', 'Result90', text);
    Lang[24] := inifile.ReadString ('Quiz', 'Result75', text);
    Lang[25] := inifile.ReadString ('Quiz', 'Result55', text);
    Lang[26] := inifile.ReadString ('Quiz', 'Result40', text);
    Lang[27] := inifile.ReadString ('Quiz', 'Result0', text);
    Lang[28] := inifile.ReadString ('Quiz', 'Next', text);
    Lang[29] := inifile.ReadString ('Quiz', 'Reset', text);
    Lang[30] := inifile.ReadString ('Quiz', 'NewQuiz', text);
    Lang[31] := inifile.ReadString ('Quiz', 'OK', text);
    Lang[32] := inifile.ReadString ('Quiz', 'YouScored', text);
    Lang[33] := inifile.ReadString ('Quiz', 'YouGot', text);
    Lang[34] := inifile.ReadString ('Quiz', 'OutOf', text);
    Lang[35] := inifile.ReadString ('Quiz', 'ProductName', text);
    Lang[36] := inifile.ReadString ('Quiz', 'Version', text);
    Lang[37] := inifile.ReadString ('Quiz', 'Copyright', text);
    Lang[38] := inifile.ReadString ('Quiz', 'Comments', text);

    IniFile.Destroy;
  end
  else begin
     Application.MessageBox('Language file lang.ini not found in folder','Language Missing',0);
     Application.Terminate;
  end;
end;

procedure TTeachersForm.SetLang;
begin
   FileMenu.Caption := Lang[3];
   StartQuiz.Caption := '&'+Lang[4];
   EndQuiz.Caption := '&'+Lang[5];
   Tools1.Caption := '&'+Lang[6];
   RegisterFileTypes.Caption := Lang[7];
   UseCustomText.Caption := Lang[8];
   UseCustomSounds.Caption := Lang[9];
   HelpMenu.Caption := '&'+Lang[10];
   DisplayHelpContents.Caption := '&'+Lang[11];
   DisplayHelpIndex.Caption := '&'+Lang[12];
   AboutBtn.Caption := '&'+Lang[13];
   FileSelectionGbox.Caption := Lang[14];
   TimerSelectGbox.Caption := Lang[15];
   TimeLbl.Caption := Lang[16];
   TopicName.Caption := Lang[17];
   StartBtn.Caption := Lang[4];
end;              

end.
