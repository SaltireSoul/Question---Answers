unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CheckLst, ComCtrls, ExtCtrls, inifiles, Menus, XPMenu, registry,
  shlobj, ImgList, Md5DeftEdit;

type
  TMakerForm = class(TForm)
    TopicNameEd: TEdit;
    TopicLbl: TStaticText;
    NumberLbl: TStaticText;
    PanelTop: TPanel;
    PanelBottom: TPanel;
    QuestionEd: TDeftEdit;
    QuestionLbl: TLabel;
    Answer1Ed: TDeftEdit;
    Answer2Ed: TDeftEdit;
    Answer3Ed: TDeftEdit;
    Answer4Ed: TDeftEdit;
    CorrectAnswerEd: TDeftEdit;
    Answer1Lbl: TLabel;
    Answer2Lbl: TLabel;
    Answer3Lbl: TLabel;
    Answer4Lbl: TLabel;
    CorrectAnswerLbl: TLabel;
    NextBtn: TButton;
    ExitBtn: TButton;
    BackBtn: TButton;
    SaveTo: TSaveDialog;
    SaveBtn: TButton;
    MainMenu: TMainMenu;
    FileMenu: TMenuItem;
    ExitMM: TMenuItem;
    SepartorMM: TMenuItem;
    SaveFileMM: TMenuItem;
    NewFileMM: TMenuItem;
    OpenFileMM: TMenuItem;
    OpenFile: TOpenDialog;
    XPMenu: TXPMenu;
    RegisterFileTypesMM: TMenuItem;
    ImageList1: TImageList;
    StatusBar1: TStatusBar;
    QuestionNoLbl: TLabel;
    Label2: TLabel;
    NoQuestionsLbl: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ExitBtnClick(Sender: TObject);
    procedure NextBtnClick(Sender: TObject);
    procedure BackBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure NewFileMMClick(Sender: TObject);
    procedure SaveFileMMClick(Sender: TObject);
    procedure ExitMMClick(Sender: TObject);
    procedure OpenFileMMClick(Sender: TObject);
    procedure RegisterFileTypesMMClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    IniFile: TIniFile;
  public
    { Public declarations }
    Procedure NewQuestionPaper;
    Procedure LoadFile;
    Procedure ReadQuestion;
    Procedure EnableForm;
    Procedure Save;
    Procedure NextQuestion;
    Procedure BackQuestion;
    Procedure ExitProgram;
    Procedure ClearFields;
    Procedure RegEditor(ExtName:string; AppName:String);
    Procedure RegQuiz(ExtName:string; AppName:String);
    Procedure ClearStatus;
    Procedure AutoLoadFile;
    Procedure LoadLang;
    Procedure SetLang;
    Function CurrentQ:string;
    Function TotalQ:string;
    function CountNextQuestion : string;
    function CountBackQuestion : string;
  end;

var
  MakerForm: TMakerForm;
  FileName:string;               //Sets the FileName to be used
  Topic:string;                  //The Topic of the Question paper
  NoOfQuestions:integer;         //The No. Of Question in the paper
  Question:WideString;           //The Question
  Answer1:WideString;            //Possible Answer 1
  Answer2:WideString;            //Possible Answer 2
  Answer3:WideString;            //Possible Answer 3
  Answer4:WideString;            //Possible Answer 4
  CorrectAnswer:WideString;      //The Correct Answer
  CurrentQuestion:integer=1;     //The current question no. e.g. 1, 2, 3 etc...
  QuestionNo:string='Q1';        //The current question no. for writing question e.g. Q1, Q2 ,Q3 etc...
  ReOpen:boolean=false;          //Indicates if file has already been saved and re-opened
  ReOpenCount:integer=0;         //Sets the Number of Questions in the Old File
  NeedText:boolean=true;      	 //Indicates if there is a need for more text before saving

  Lang:Array[1..17] of WideString;

implementation

{$R *.DFM}

{ TMakerForm }
procedure TMakerForm.NextBtnClick(Sender: TObject);
begin
    if (Answer1Ed.Text=CorrectAnswerEd.text) or (Answer2Ed.Text=CorrectAnswerEd.text) or  (Answer3Ed.Text=CorrectAnswerEd.text) or (Answer4Ed.Text=CorrectAnswerEd.text) then NextQuestion
    else StatusBar1.SimpleText:=Lang[1];
end;

procedure TMakerForm.BackBtnClick(Sender: TObject);
begin
  BackQuestion;
end;

procedure TMakerForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ExitProgram;
end;

procedure TMakerForm.ExitBtnClick(Sender: TObject);
begin
  ExitProgram;
end;

procedure TMakerForm.SaveBtnClick(Sender: TObject);
begin
  Save;
end;

procedure TMakerForm.NewFileMMClick(Sender: TObject);
begin
  NewQuestionPaper;
end;

procedure TMakerForm.SaveFileMMClick(Sender: TObject);
begin
  Save;
end;

procedure TMakerForm.ExitMMClick(Sender: TObject);
begin
  ExitProgram;
end;

procedure TMakerForm.OpenFileMMClick(Sender: TObject);
begin
  LoadFile;
end;




procedure TMakerForm.ExitProgram;
{
  Code To End Application
}
begin
  if (FileName<>'') then begin
  with IniFile do
    begin
      Free;                   //Closes INI file and frees up the memory used, and doesn't report an error if not initalized
    end;
  end;
  Application.Terminate;      //Exit Program
end;

procedure TMakerForm.NewQuestionPaper;
begin

  if SaveTo.Execute then
    begin
      FileName := SaveTo.FileName;
    end;

  if FileName<>'' then
    begin
      IniFile := TIniFile.Create (FileName); //Open File
      MakerForm.Caption:='Question Maker - ' + FileName;
      EnableForm;

      TopicNameEd.text:='';
      ClearFields;
    end;

end;

procedure TMakerForm.LoadFile;
begin
  if OpenFile.Execute then
    begin
      FileName := OpenFile.FileName;
    end;

  if FileName<>'' then
    begin
      CurrentQuestion:=1;
      QuestionNoLbl.Caption:=CurrentQ;

      IniFile := TIniFile.Create (FileName); //Open File
      MakerForm.Caption:='Question Maker - ' + FileName;
      EnableForm;
      ReadQuestion;
      ReOpenCount := inifile.readinteger('Main','Questions',ReOpenCount);
      NoOfQuestions := ReOpenCount;
      NoQuestionsLbl.Caption:=TotalQ;
      ReOpen:=true;
    end;

end;

procedure TMakerForm.ReadQuestion;
begin
  //Read & Display the Topic, Questions, Answers & Real Answer
  Topic := inifile.readstring('Main','Topic',Topic);
  TopicNameED.text := Topic;

  Question := inifile.readstring(QuestionNo,'Question',Question);
  QuestionED.text := Question;

  Answer1 := inifile.readstring(QuestionNo,'Answer1',Answer1);
  Answer1Ed.text := Answer1;

  Answer2 := inifile.readstring(QuestionNo,'Answer2',Answer2);
  Answer2ED.text := Answer2;

  Answer3 := inifile.readstring(QuestionNo,'Answer3',Answer3);
  Answer3ED.text := Answer3;

  Answer4 := inifile.readstring(QuestionNo,'Answer4',Answer4);
  Answer4ED.text := Answer4;

  CorrectAnswer := inifile.readstring(QuestionNo,'Correct',CorrectAnswer);
  CorrectAnswerEd.text:=CorrectAnswer;
end;

procedure TMakerForm.EnableForm;
begin
  TopicNameEd.Visible:=true;
  QuestionNoLbl.Visible:=true;
  NoQuestionsLbl.Visible:=true;
  QuestionEd.Visible:=true;
  Answer1Ed.Visible:=true;
  Answer2Ed.Visible:=true;
  Answer3Ed.Visible:=true;
  Answer4Ed.Visible:=true;
  CorrectAnswerEd.Visible:=true;
  NextBtn.Visible:=true;
  BackBtn.Visible:=true;
  SaveBtn.Visible:=true;
  ExitBtn.Visible:=true;
  TopicLbl.Visible:=true;
  NumberLbl.Visible:=true;
  QuestionLbl.Visible:=true;
  Answer1Lbl.Visible:=true;
  Answer2Lbl.Visible:=true;
  Answer3Lbl.Visible:=true;
  Answer4Lbl.Visible:=true;
  CorrectAnswerLbl.Visible:=true;
  PanelTop.Visible:=true;
  PanelBottom.Visible:=true;
end;

procedure TMakerForm.Save;
begin
  if (TopicNameEd.text='') or (QuestionEd.text='') or (Answer1Ed.text='') or (Answer2Ed.text='') or (Answer3Ed.text='') or (Answer4Ed.text='') or (Answer1Ed.text='') or (CorrectAnswerEd.text='') then
    begin
      StatusBar1.SimpleText:=Lang[4];
      NeedText:=true;
    end
  else
    begin
      inifile.WriteString ('Main', 'Topic', TopicNameEd.text);  //Write in the Topic to the inifile
      inifile.WriteInteger('Main', 'Questions', NoOfQuestions);  //Write in the No Of Questions to the inifile
      inifile.WriteString (QuestionNo, 'Question', QuestionEd.text);  //Write in the Question to the inifile
      inifile.WriteString (QuestionNo, 'Answer1', Answer1Ed.text);  //Write in the Possible Answer 1 to the inifile
      inifile.WriteString (QuestionNo, 'Answer2', Answer2Ed.text);  //Write in the Possible Answer 2 to the inifile
      inifile.WriteString (QuestionNo, 'Answer3', Answer3Ed.text);  //Write in the Possible Answer 3 to the inifile
      inifile.WriteString (QuestionNo, 'Answer4', Answer4Ed.text);  //Write in the Possible Answer 4 to the inifile
      inifile.WriteString (QuestionNo, 'Correct', CorrectAnswerEd.text);  //Write in the Correct Answer to the inifile
      NeedText:=false;
    end;
end;

procedure TMakerForm.NextQuestion;
begin
  if (CurrentQuestion > NoOfQuestions) then NoOfQuestions := CurrentQuestion;
  Save;
  
  if NeedText=false then
    begin
      QuestionNo:=CountNextQuestion;
      QuestionNoLbl.Caption:=CurrentQ;
      NoQuestionsLbl.Caption:=TotalQ;

     if CurrentQuestion > ReOpenCount then
       begin
         ReOpen:=false;
       end;

    if ReOpen=true then
      begin
        ReadQuestion;
        ClearStatus;
      end
    else
      begin
        ClearFields;
        ClearStatus;
      end;
  end;

end;

procedure TMakerForm.BackQuestion;
begin
  if currentquestion>1 then
    begin
      if ReOpen=false then
        begin
          ReOpenCount:=CurrentQuestion-1;
          Reopen:=True;
        end;

      QuestionNo:=CountBackQuestion;
      QuestionNoLbl.Caption:=CurrentQ;
      ReadQuestion;
      ClearStatus;
    end
  else
    begin
      StatusBar1.SimpleText:=Lang[2];
    end;
end;

procedure TMakerForm.ClearFields;
begin
  QuestionEd.text:='';
  Answer1Ed.text:='';
  Answer2Ed.text:='';
  Answer3Ed.text:='';
  Answer4Ed.text:='';
  CorrectAnswerEd.text:='';
end;

procedure TMakerForm.RegisterFileTypesMMClick(Sender: TObject);
begin
  RegEditor('QQQ',ExtractFilePath(ParamStr(0))+ExtractFileName(ParamStr(0)));
  //*Bug* Access Violation when opening with Quiz Program
  //when changing visiblity to StudentsForm or changing a
  //value in that Form
  RegQuiz('QQQ',ExtractFilePath(ParamStr(0))+'Quiz.exe');
  //Application.MessageBox('Files Registered','Register File Types',0);
  Application.MessageBox(PAnsiChar(String(Lang[3])),PAnsiChar(String(Lang[9])),0);
end;

procedure TMakerForm.RegEditor(ExtName:string; AppName:String);
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

procedure TMakerForm.RegQuiz(ExtName:string; AppName:String);
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

procedure TMakerForm.ClearStatus;
begin
  StatusBar1.SimpleText:='';
end;

procedure TMakerForm.FormCreate(Sender: TObject);
begin
  If ParamStr(1)<>'' then
    begin
      Filename:=ParamStr(1);
      AutoLoadFile;
    end;

  LoadLang;
  SetLang;
end;

procedure TMakerForm.AutoLoadFile;
begin
  if FileName<>'' then
    begin
      CurrentQuestion:=1;
      QuestionNoLbl.Caption:=CurrentQ;

      IniFile := TIniFile.Create (FileName); //Open File
      MakerForm.Caption:='Question Maker - ' + FileName;
      EnableForm;
      ReadQuestion;
      ReOpenCount := inifile.readinteger('Main','Questions',ReOpenCount);
      NoOfQuestions := ReOpenCount;
      NoQuestionsLbl.Caption:=TotalQ;
      ReOpen:=true;
    end;
end;

procedure TMakerForm.LoadLang;
var langfilename:string;
begin
//Load lang from ini
  langfilename:=ExtractFilePath(ParamStr(0))+'lang.ini';
  If FileExists(langfilename) then begin
    IniFile := TIniFile.Create (langfilename);

    Lang[1] := inifile.ReadString ('Maker', 'InternalMsg1', text);
    Lang[2] := inifile.ReadString ('Maker', 'InternalMsg2', text);
    Lang[3] := inifile.ReadString ('Maker', 'InternalMsg3', text);
    Lang[4] := inifile.ReadString ('Maker', 'InternalMsg4', text);
    Lang[5] := inifile.ReadString ('Maker', 'File', text);
    Lang[6] := inifile.ReadString ('Maker', 'New', text);
    Lang[7] := inifile.ReadString ('Maker', 'Open', text);
    Lang[8] := inifile.ReadString ('Maker', 'Save', text);
    Lang[9] := inifile.ReadString ('Maker', 'FileTypes', text);
    Lang[10] := inifile.ReadString ('Maker', 'Exit', text);
    Lang[11] := inifile.ReadString ('Maker', 'TopicName', text);
    Lang[12] := inifile.ReadString ('Maker', 'QuestionNum', text);
    Lang[13] := inifile.ReadString ('Maker', 'Question', text);
    Lang[14] := inifile.ReadString ('Maker', 'Answer', text);
    Lang[15] := inifile.ReadString ('Maker', 'CorrectAnswer', text);
    Lang[16] := inifile.ReadString ('Maker', 'Back', text);
    Lang[17] := inifile.ReadString ('Maker', 'Next', text);

    IniFile.Destroy;
  end
  else begin
     Application.MessageBox('Language file lang.ini not found in folder','Language Missing',0);
     Application.Terminate;
  end;
end;

procedure TMakerForm.SetLang;
begin
   FileMenu.Caption := Lang[5];
   NewFileMM.Caption := Lang[6];
   OpenFileMM.Caption := Lang[7];
   SaveFileMM.Caption := Lang[8];
   RegisterFileTypesMM.Caption := Lang[9];
   ExitMM.Caption := Lang[10];
   TopicLbl.Caption := Lang[11]+':';
   NumberLbl.Caption := Lang[12]+':';
   QuestionLbl.Caption := Lang[13]+':';
   Answer1Lbl.Caption := Lang[14]+' 1:';
   Answer2Lbl.Caption := Lang[14]+' 2:';
   Answer3Lbl.Caption := Lang[14]+' 3:';
   Answer4Lbl.Caption := Lang[14]+' 4:';
   CorrectAnswerLbl.Caption := Lang[15]+':';
   ExitBtn.Caption := Lang[10];
   BackBtn.Caption := '< '+Lang[16];
   SaveBtn.Caption := Lang[8];
   NextBtn.Caption := Lang[17]+' >';
end;

function TMakerForm.CurrentQ: string;
begin
   Result := IntToStr(CurrentQuestion);
end;

function TMakerForm.TotalQ: string;
begin
   Result := IntToStr(NoOfQuestions);
end;

function TMakerForm.CountBackQuestion: string;
begin
  CurrentQuestion:=CurrentQuestion-1;
  Result:='Q'+CurrentQ;
end;

function TMakerForm.CountNextQuestion: string;
begin
  CurrentQuestion:=CurrentQuestion+1;
  Result:='Q'+CurrentQ;
end;

end.



