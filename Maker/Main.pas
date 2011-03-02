unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CheckLst, ComCtrls, ExtCtrls, inifiles, Menus, XPMenu, registry,
  shlobj, ImgList;

type
  TMakerForm = class(TForm)
    TopicNameEd: TEdit;
    TopicLbl: TStaticText;
    NoQuestionsEd: TEdit;
    NumberLbl: TStaticText;
    PanelTop: TPanel;
    PanelBottom: TPanel;
    QuestionEd: TEdit;
    QuestionLbl: TLabel;
    Answer1Ed: TEdit;
    Answer2Ed: TEdit;
    Answer3Ed: TEdit;
    Answer4Ed: TEdit;
    CorrectAnswerEd: TEdit;
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
  end;

var
  MakerForm: TMakerForm;
  FileName:string;               //Sets the FileName to be used
  Topic:string[30];              //The Topic of the Question paper
  NoOfQuestions:integer;         //The No. Of Question in the paper
  Question:string[149];          //The Question
  Answer1:string[59];            //Possible Answer 1
  Answer2:string[59];            //Possible Answer 2
  Answer3:string[59];            //Possible Answer 3
  Answer4:string[59];            //Possible Answer 4
  CorrectAnswer:string[59];      //The Correct Answer
  CurrentQuestion:integer=1;     //The current question no. e.g. 1, 2, 3 etc...
  QuestionNo:string='Q1';        //The current question no. for writing question e.g. Q1, Q2 ,Q3 etc...
  ReOpen:boolean=false;          //Indicates if file has already been saved and re-opened
  ReOpenCount:integer=0;         //Sets the Number of Questions in the Old File
  NeedText:boolean=true;	 //Indicates if there is a need for more text before saving

implementation

{$R *.DFM}

{ TMakerForm }
procedure TMakerForm.NextBtnClick(Sender: TObject);
begin
    if (Answer1Ed.Text=CorrectAnswerEd.text) or (Answer2Ed.Text=CorrectAnswerEd.text) or  (Answer3Ed.Text=CorrectAnswerEd.text) or (Answer4Ed.Text=CorrectAnswerEd.text) then NextQuestion
    else StatusBar1.SimpleText:='None of Your Possible Answer Match the Correct Answer';
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




{My Own Functions & Procedures}
function CountNextQuestion : string;
{
  Calculates the Current Question Number
}
begin
  CurrentQuestion:=CurrentQuestion+1;
  Result:='Q'+inttostr(CurrentQuestion);
end;

function CountBackQuestion : string;
{
  Calculates the Previous Question Number
}
begin
  CurrentQuestion:=CurrentQuestion-1;
  Result:='Q'+inttostr(CurrentQuestion);
end;

procedure TMakerForm.ExitProgram;
{
  Code To End Application
}
begin
  with IniFile do
    begin
      Free;                   //Closes INI file and frees up the memory used, and doesn't report an error if not initalized
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
      NoQuestionsEd.Text:=inttostr(currentquestion);

      IniFile := TIniFile.Create (FileName); //Open File
      MakerForm.Caption:='Question Maker - ' + FileName;
      EnableForm;
      ReadQuestion;
      ReOpenCount := inifile.readinteger('Main','Questions',ReOpenCount);
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
  NoQuestionsEd.Visible:=true;
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
      StatusBar1.SimpleText:='You need to fill in all the fields before saving';
      NeedText:=true;
    end
  else
    begin
      inifile.WriteString ('Main', 'Topic', TopicNameEd.text);  //Write in the Topic to the inifile
      inifile.WriteInteger('Main', 'Questions', currentquestion);  //Write in the No Of Questions to the inifile
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
  Save;
  
  if NeedText=false then
    begin
      QuestionNo:=CountNextQuestion;
      NoQuestionsEd.Text:=inttostr(currentquestion);

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
      NoQuestionsEd.Text:=inttostr(currentquestion);
      ReadQuestion;
      ClearStatus;
    end
  else
    begin
      StatusBar1.SimpleText:='You can not Go back any further';
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
  Application.MessageBox('Files Registered','Register File Types',0);
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
end;

procedure TMakerForm.AutoLoadFile;
begin
  if FileName<>'' then
    begin
      CurrentQuestion:=1;
      NoQuestionsEd.Text:=inttostr(currentquestion);

      IniFile := TIniFile.Create (FileName); //Open File
      MakerForm.Caption:='Question Maker - ' + FileName;
      EnableForm;
      ReadQuestion;
      ReOpenCount := inifile.readinteger('Main','Questions',ReOpenCount);
      ReOpen:=true;
    end;
end;

end.



