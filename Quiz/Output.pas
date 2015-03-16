unit Output;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, mmsystem;

type
  TOutputForm = class(TForm)
    YouScoredtextLbl: TLabel;
    OutOftextLbl: TLabel;
    ScoreLbl: TLabel;
    NoOfQuestionsLbl: TLabel;
    ResetBtn: TButton;
    ExitBtn: TButton;
    PercentageLbl: TLabel;
    MessageLbl: TLabel;
    YouGottextLbl: TLabel;
    NewBtn: TButton;
    procedure ResetButtonPress(Sender: TObject);
    procedure ExitButtonPress(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure NewBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure ExitProgram;
    Procedure CalcPercentage;
    Procedure DisplayMessage;
    Procedure DisplayCustomMessage;
    Procedure ReStartQuiz;
    Procedure ResetScore;
    Procedure ResetTimer;
    Procedure StartNewQuiz;
    Procedure DisplayScores;
    Procedure PlayDefaultSounds;
    Procedure PlayCustomSounds;
    Function CheckCustomMessagesFile:boolean;
    Procedure PlayMySound(Filename:string);
    Procedure SetLang;
  end;

var
  OutputForm: TOutputForm;

implementation

uses Teachers, Students;

{$R *.DFM}

procedure TOutputForm.ResetButtonPress(Sender: TObject);
{
  Code To Reset Questions, Score
}
begin
  ReStartQuiz;
end;

procedure TOutputForm.ExitButtonPress(Sender: TObject);
{
  Procedure to Exit Application
}
begin
  ExitProgram;
end;

procedure TOutputForm.FormClose(Sender: TObject; var Action: TCloseAction);
{
  Procedure to Exit Application
}
begin
  ExitProgram;
end;

procedure TOutputForm.FormShow(Sender: TObject);
{
  Procedures ran when output form shown
}
const
  CFileName='Messages.dat';
  CBrilliant='Brilliant.wav';
  CGood='Good.wav';
  CFair='Fair.wav';
  CNotBad='NotBad.wav';
  CTryAgain='TryAgain.wav';
begin
  SetLang;
  CalcPercentage;
  DisplayScores;

  //Display Custom Messages if Ok
  If CustomMessage then
    begin
      If FileExists(ProgramPath+CFileName) then
        begin
          If CheckCustomMessagesFile then DisplayCustomMessage
            else DisplayMessage;
        end
      else
        begin
          //ShowMessage('Unable To Display Custom Messages');
          DisplayMessage;
        end;
    end
  else
    begin
      DisplayMessage;
    end;

  If CustomSounds then
    begin
      If FileExists(ProgramPath+CBrilliant)
      and FileExists(ProgramPath+CGood)
      and FileExists(ProgramPath+CFair)
      and FileExists(ProgramPath+CNotBad)
      and FileExists(ProgramPath+CTryAgain) then
        begin
          PlayCustomSounds;
        end
      else
        begin
          //ShowMessage('Unable To Play Custom Sounds');
          PlayDefaultSounds;
        end;
    end
  else
    begin
      PlayDefaultSounds;
    end;
end;

procedure TOutputForm.DisplayMessage;
{
  Code To Display Results
}
begin
  if percentage>=90 then
    begin
      MessageLbl.caption:= Lang[23];
    end
  else if percentage>=75 then
    begin
      MessageLbl.caption:=Lang[24];
    end
  else if percentage>=55 then
    begin
      MessageLbl.caption:=Lang[25];
    end
  else if percentage>=40 then
    begin
      MessageLbl.caption:=Lang[26];
    end
  else MessageLbl.caption:=Lang[27];
end;

procedure TOutputForm.DisplayCustomMessage;
{
  Display Custom Messages
}
const
  CFileName='Messages.dat';

var Filein:TextFile;
    i:integer;
    Messages:Array[1..5] of String[23];
    Filename:string;
begin
  Filename:=ProgramPath+CFileName;
  AssignFile(Filein,Filename);
  Reset(Filein);

  For i:=1 to 5 do begin
    Readln(Filein,Messages[i]);
  end;

  CloseFile(Filein);

  if percentage>=90 then
    begin
      MessageLbl.caption:=Messages[1];
    end
  else if percentage>=75 then
    begin
      MessageLbl.caption:=Messages[2];
    end
  else if percentage>=55 then
    begin
      MessageLbl.caption:=Messages[3];
    end
  else if percentage>=40 then
    begin
      MessageLbl.caption:=Messages[4];
    end
  else if percentage<40 then
    begin
      MessageLbl.caption:=Messages[5];
    end;
end;

procedure TOutputForm.CalcPercentage;
{
  Code To Calculate Percentage
}
begin
  Percentage:=score/NoOfQuestions*100;
end;

procedure TOutputForm.ReStartQuiz;
{
  Code To Re-start Quiz
}
begin
  ResetScore;

  ResetTimer;

  //Display Form
  OutputForm.Visible:=false;
  studentsform.visible:=true;
end;

procedure TOutputForm.ExitProgram;
{
  Code To End Application
}
begin
  TeachersForm.SaveSettings;
  Application.Terminate;
end;

procedure TOutputForm.ResetScore;
begin
  //Reset Score and Question No.
  score:=0;
  CurrentQuestion:=0;
  StudentsForm.ScoreLbl.Caption:='0';
end;

procedure TOutputForm.ResetTimer;
begin
  //Resets Timer
  TimeLimit:=TeachersForm.TimeSelect.Value;
  StudentsForm.CountDownLbl.Caption:=inttostr(Timelimit);
  StudentsForm.CountDownLbl.Font.Color:=clblue;
end;

procedure TOutputForm.StartNewQuiz;
begin
  ResetScore;
  ResetTimer;

  //Display Form
  OutputForm.Visible:=False;
  TeachersForm.Visible:=True;
end;

procedure TOutputForm.NewBtnClick(Sender: TObject);
begin
  StartNewQuiz;
end;

procedure TOutputForm.DisplayScores;
begin
  ScoreLbl.caption:=inttostr(score);
  NoOfQuestionsLbl.caption:=inttostr(NoOfQuestions);
  PercentageLbl.caption:=floattostrF(percentage,ffFixed,15,0)+'%';
end;

procedure TOutputForm.PlayCustomSounds;
const
  CBrilliant='Brilliant.wav';
  CGood='Good.wav';
  CFair='Fair.wav';
  CNotBad='NotBad.wav';
  CTryAgain='TryAgain.wav';
begin
  if percentage>=90 then
    begin
      PlayMySound(CBrilliant);
    end
  else if percentage>=75 then
    begin
      PlayMySound(CGood);
    end
  else if percentage>=55 then
    begin
      PlayMySound(CFair);
    end
  else if percentage>=40 then
    begin
      PlayMySound(CNotBad);
    end
  else if percentage<40 then
    begin
      PlayMySound(CTryAgain);
    end;
end;

procedure TOutputForm.PlayMySound(Filename: string);
var
  CFileName:string;
begin
  CFileName:=ProgramPath+FileName;
  PlaySound(PChar(CFileName),snd_FileName and snd_ASync or snd_Memory,1);
end;

procedure TOutputForm.PlayDefaultSounds;
begin
  if percentage>=90 then
    begin
      StudentsForm.PlayExeSound('clap');
    end
  else if percentage<40 then
    begin
      StudentsForm.PlayExeSound('read');
    end;
end;

function TOutputForm.CheckCustomMessagesFile: boolean;
const
  CFileName='Messages.dat';

var
  Filein:TextFile;
  i:integer;
  temp:string;
  Filename:string;
begin
  Filename:=ProgramPath+CFileName;
  AssignFile(Filein,Filename);
  Reset(Filein);

  For i:=1 to 5 do begin
    Readln(Filein,temp);

    If temp<>'' then
      begin
        Result:=True;
      end
    else
      begin
        //ShowMessage('No Text on line '+IntToStr(i));
        Result:=False;
        CloseFile(Filein);
        Break;
      end;
  end;

  CloseFile(Filein);
end;

procedure TOutputForm.SetLang;
begin
   YouScoredtextLbl.Caption := Lang[32];
   YouGottextLbl.Caption := Lang[33];
   OutOftextLbl.Caption := Lang[34];
   ResetBtn.Caption := Lang[29];
   NewBtn.Caption := Lang[30];
   ExitBtn.Caption := Lang[5];
end;

end.
