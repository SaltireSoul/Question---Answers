unit Students;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, inifiles, mmsystem;

type
  TStudentsForm = class(TForm)
    NextBtn: TButton;
    TextLbl: TLabel;
    Answer1RBtn: TRadioButton;
    Answer2RBtn: TRadioButton;
    Answer3RBtn: TRadioButton;
    Answer4RBtn: TRadioButton;
    CountDownLbl: TLabel;
    TimelefttextLbl: TLabel;
    ScoretextLbl: TLabel;
    ScoreLbl: TLabel;
    PreviousAnswerGbox: TGroupBox;
    PreviousAnswerLbl: TLabel;
    Counter: TTimer;
    PauseTimer: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure NextQuestionBtn(Sender: TObject);
    procedure CounterTimer(Sender: TObject);
    procedure PauseTimerTimer(Sender: TObject);
  private
    IniFile: TIniFile;
  public
    { Public declarations }
    Procedure DisplayTopic;
    Procedure Setup;
    Procedure ReadQuestions;
    Procedure SetAnswer;
    Procedure CheckAnswers;
    Procedure ResetAnswers;
    Procedure ExitProgram;
    function  PlayExeSound(soundfile:PChar):string;
    Procedure PlaySounds(Answered:string);
    Procedure PlayDefault;
    Procedure PlayCustom;
    Procedure PlayMySound(Filename: string);
  end;

var
  StudentsForm: TStudentsForm;
  Marked:string;


implementation

uses Teachers, Output;

{$R *.DFM}
{$R sounds.RES}

procedure TStudentsForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
{
  Procedure to exit application
}
begin
  ExitProgram;
end;

procedure TStudentsForm.FormShow(Sender: TObject);
{
  Procedures & Code to be ran when form displayed
}
begin
  PreviousAnswerLbl.Caption:='';
  NextBtn.Enabled:=true;
  DisplayTopic;
  Setup;
  ReadQuestions;
end;

procedure TStudentsForm.NextQuestionBtn(Sender: TObject);
{
  Procedures to check answers
  Procedures & code to read & display questions
}
begin
  //Reset Timer
  TimeLimit:=TeachersForm.TimeSelect.Value;
  CountDownLbl.Caption:=inttostr(Timelimit);
  CountDownLbl.Font.Color:=clblue;


  SetAnswer;                    //Set the User Answer
  CheckAnswers;                 //Check User Answer is Correct
  ResetAnswers;                 //Reset the Radio Button to prevent accidental score


  if CurrentQuestion>=NoOfQuestions then
    begin
      //Disable Timer
      Counter.Enabled:=false;

      //Disable Next Button
      NextBtn.Enabled:=false;

      //Enable 2 Second Pause before Continuing
      PauseTimer.Enabled:=true;
    end
  else
    begin
      ReadQuestions;
    end;

end;

function CountQuestion : string;
{
  Calculates the Current Question Number
}
begin
  CurrentQuestion:=CurrentQuestion+1;
  Result:='Q'+inttostr(CurrentQuestion);

  QuestionNo:=Result;
end;

procedure TStudentsForm.DisplayTopic;
{
  Code To Open Question Paper and Display the Topic
}
begin
  IniFile := TIniFile.Create (FileName);
  studentsform.caption := 'Quiz - ' + Topic;
end;

procedure TStudentsForm.Setup;
{
  Sets up quiz for questions
}
begin
  CurrentQuestion:=0;
  Score:=0;

  Answer1RBtn.Enabled :=true;
  Answer2RBtn.Enabled :=true;
  Answer3RBtn.Enabled :=true;
  Answer4RBtn.Enabled :=true;
end;

procedure TStudentsForm.ReadQuestions;
{
  Code To Read and Display Questions & Enable Timer
}
begin
  Question := inifile.readstring(CountQuestion,'Question',Question);
  TextLbl.caption := Question;

  Answer1 := inifile.readstring(QuestionNo,'Answer1',Answer1);
  Answer1RBtn.Caption := Answer1;

  Answer2 := inifile.readstring(QuestionNo,'Answer2',Answer2);
  Answer2RBtn.Caption := Answer2;

  Answer3 := inifile.readstring(QuestionNo,'Answer3',Answer3);
  Answer3RBtn.Caption := Answer3;

  Answer4 := inifile.readstring(QuestionNo,'Answer4',Answer4);
  Answer4RBtn.Caption := Answer4;

  CorrectAnswer := inifile.readstring(QuestionNo,'Correct',CorrectAnswer);

  Counter.Enabled:=true;
end;

procedure TStudentsForm.SetAnswer;
{
  Code To get the user answer
}
begin

  if Answer1RBtn.Checked=true then
    useranswer:=Answer1
  else if Answer2RBtn.Checked=true then
    useranswer:=Answer2
  else if Answer3RBtn.checked=true then
    useranswer:=Answer3
  else if Answer4RBtn.checked=true then
    useranswer:=Answer4;

end;

procedure TStudentsForm.CheckAnswers;
{
  Checks User Answer against the Real Answer
}
begin
  if correctanswer=useranswer then
    begin
      PreviousAnswerLbl.caption:='Well Done!!';
      Score:=Score+1;
      ScoreLbl.caption:=inttostr(Score);
      PlaySounds('correct');
    end
  else
    begin
      PreviousAnswerLbl.caption:='The correct answer was : '+correctanswer;
      PlaySounds('wrong');
    end;
end;

procedure TStudentsForm.ResetAnswers;
{
  Code To Reset Radio Buttons and User Answer
}
begin
  Answer1RBtn.Checked :=false;
  Answer2RBtn.Checked :=false;
  Answer3RBtn.Checked :=false;
  Answer4RBtn.Checked :=false;
  useranswer:='';
end;

procedure TStudentsForm.ExitProgram;
{
  Code To End Application & Close Open Files
}
begin
  IniFile.Destroy;
  Application.Terminate;
end;

procedure TStudentsForm.CounterTimer(Sender: TObject);
begin

  if strtoint(CountDownLbl.Caption)>0 then
    begin
      timelimit:=timelimit-1;
      CountDownLbl.Caption:=inttostr(timelimit);
        if strtoint(CountDownLbl.Caption) <= 10 then
            CountDownLbl.Font.Color:=clred;
    end
  else
    begin
      useranswer:='';           //Wrong Answer if timer ran out

      Counter.Enabled:=false;   //Disable Timer

      NextQuestionBtn(Self);    //Automatic Next Question Button Pressed
    end;

end;

procedure TStudentsForm.PauseTimerTimer(Sender: TObject);
begin
  OutputForm.Visible:=true;
  studentsform.visible:=false;

  PauseTimer.Enabled:=false;
end;

function TStudentsForm.PlayExeSound(soundfile: PChar): string;
var
  hfind, hres: THandle;
  song: PChar;
begin

  //Play Sound in EXE File
  hfind:=FindResource(HInstance, soundfile, 'WAVE');
  if hfind<>0 then
    begin
      hRes:=LoadResource(HInstance, hfind);
      if hRes<>0 then
        begin
          Song:=LockResource(hRes);
          if Assigned(Song) then SndPlaySound(Song,snd_ASync or snd_Memory);
          UnlockResource(hRes);
        end;
        FreeResource(hFind);
    end;
end;


procedure TStudentsForm.PlaySounds(Answered:string);
begin
  Marked:=Answered;
  If CustomSounds then
    begin
      PlayCustom;
    end
  else
    begin
      PlayDefault;
    end;
end;

procedure TStudentsForm.PlayCustom;
const
  CCorrect='Correct.wav';
  CWrong='Wrong.wav';
begin
  If FileExists(ProgramPath+CCorrect)
  and FileExists(ProgramPath+CWrong) then
    begin
      If Lowercase(Marked)='correct' then PlayMySound(CCorrect)
        else PlayMySound(CWrong);
    end
  else
    begin
      PlayDefault;
    end;
end;

procedure TStudentsForm.PlayDefault;
begin
 If Lowercase(Marked)='correct' then PlayExeSound('correct')
   else PlayExeSound('wrong');
end;

procedure TStudentsForm.PlayMySound(Filename: string);
var
  CFileName:string;
begin
  CFileName:=ProgramPath+FileName;
  PlaySound(PChar(CFileName),snd_FileName and snd_ASync or snd_Memory,1);
end;

end.
