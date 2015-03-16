unit Trans;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, inifiles;

type
  TQandATransForm = class(TForm)
    pcTranslator: TPageControl;
    tsQuiz: TTabSheet;
    tsMaker: TTabSheet;
    btnSave: TButton;
    edLang1: TEdit;
    edLang2: TEdit;
    edLang4: TEdit;
    edLang3: TEdit;
    edLang8: TEdit;
    edLang7: TEdit;
    edLang6: TEdit;
    edLang5: TEdit;
    edLang9: TEdit;
    edLang10: TEdit;
    edLang11: TEdit;
    edLang12: TEdit;
    edLang13: TEdit;
    edLang14: TEdit;
    edLang15: TEdit;
    edLang16: TEdit;
    edLang17: TEdit;
    edLang18: TEdit;
    edLang19: TEdit;
    edLang20: TEdit;
    edLang21: TEdit;
    edLang22: TEdit;
    edLang23: TEdit;
    edLang24: TEdit;
    edLang25: TEdit;
    edLang26: TEdit;
    edLang27: TEdit;
    edLang28: TEdit;
    edLang29: TEdit;
    edLang30: TEdit;
    edLang38: TEdit;
    edLang33: TEdit;
    edLang34: TEdit;
    edLang35: TEdit;
    edLang36: TEdit;
    edLang37: TEdit;
    edLang32: TEdit;
    edLang31: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    SaveTo: TSaveDialog;
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
    IniFile: TIniFile;
  public
    { Public declarations }
    Procedure SaveTranslation;
  end;

var
  QandATransForm: TQandATransForm;
  FileName:string;

implementation

{$R *.dfm}

procedure TQandATransForm.btnSaveClick(Sender: TObject);
begin
   SaveTranslation;
end;

procedure TQandATransForm.SaveTranslation;
begin
  if SaveTo.Execute then
    begin
      FileName := SaveTo.FileName;
      IniFile := TIniFile.Create (FileName);

      inifile.WriteString ('Quiz', 'InternalMsg1', edLang1.text);
      inifile.WriteString ('Quiz', 'InternalMsg2', edLang2.text);
      inifile.WriteString ('Quiz', 'File', edLang3.text);
      inifile.WriteString ('Quiz', 'Start', edLang4.text);
      inifile.WriteString ('Quiz', 'Exit', edLang5.text);
      inifile.WriteString ('Quiz', 'Tools', edLang6.text);
      inifile.WriteString ('Quiz', 'FileTypes', edLang7.text);
      inifile.WriteString ('Quiz', 'CustomText', edLang8.text);
      inifile.WriteString ('Quiz', 'CustomSound', edLang9.text);
      inifile.WriteString ('Quiz', 'Help', edLang10.text);
      inifile.WriteString ('Quiz', 'Contents', edLang11.text);
      inifile.WriteString ('Quiz', 'Index', edLang12.text);
      inifile.WriteString ('Quiz', 'About', edLang13.text);
      inifile.WriteString ('Quiz', 'SelectTopic', edLang14.text);
      inifile.WriteString ('Quiz', 'Timer', edLang15.text);
      inifile.WriteString ('Quiz', 'SetTimer', edLang16.text);
      inifile.WriteString ('Quiz', 'TopicName', edLang17.text);
      inifile.WriteString ('Quiz', 'TimeLeft', edLang18.text);
      inifile.WriteString ('Quiz', 'Score', edLang19.text);
      inifile.WriteString ('Quiz', 'CorrectAnswer', edLang20.text);
      inifile.WriteString ('Quiz', 'AnswerCorrect', edLang21.text);
      inifile.WriteString ('Quiz', 'AnswerWrong', edLang22.text);
      inifile.WriteString ('Quiz', 'Result90', edLang23.text);
      inifile.WriteString ('Quiz', 'Result75', edLang24.text);
      inifile.WriteString ('Quiz', 'Result55', edLang25.text);
      inifile.WriteString ('Quiz', 'Result40', edLang26.text);
      inifile.WriteString ('Quiz', 'Result0', edLang27.text);
      inifile.WriteString ('Quiz', 'Next', edLang28.text);
      inifile.WriteString ('Quiz', 'Reset', edLang29.text);
      inifile.WriteString ('Quiz', 'NewQuiz', edLang30.text);
      inifile.WriteString ('Quiz', 'OK', edLang31.text);
      inifile.WriteString ('Quiz', 'YouScored', edLang32.text);
      inifile.WriteString ('Quiz', 'YouGot', edLang33.text);
      inifile.WriteString ('Quiz', 'OutOf', edLang34.text);
      inifile.WriteString ('Quiz', 'ProductName', edLang35.text);
      inifile.WriteString ('Quiz', 'Version', edLang36.text);
      inifile.WriteString ('Quiz', 'Copyright', edLang37.text);
      inifile.WriteString ('Quiz', 'Comments', edLang38.text);

      inifile.WriteString ('Maker', 'InternalMsg1', edit1.text);
      inifile.WriteString ('Maker', 'InternalMsg2', edit2.text);
      inifile.WriteString ('Maker', 'InternalMsg3', edit3.text);
      inifile.WriteString ('Maker', 'InternalMsg4', edit4.text);
      inifile.WriteString ('Maker', 'File', edit5.text);
      inifile.WriteString ('Maker', 'New', edit6.text);
      inifile.WriteString ('Maker', 'Open', edit7.text);
      inifile.WriteString ('Maker', 'Save', edit8.text);
      inifile.WriteString ('Maker', 'FileTypes', edit9.text);
      inifile.WriteString ('Maker', 'Exit', edit10.text);
      inifile.WriteString ('Maker', 'TopicName', edit11.text);
      inifile.WriteString ('Maker', 'QuestionNum', edit12.text);
      inifile.WriteString ('Maker', 'Question', edit13.text);
      inifile.WriteString ('Maker', 'Answer', edit14.text);
      inifile.WriteString ('Maker', 'CorrectAnswer', edit15.text);
      inifile.WriteString ('Maker', 'Back', edit16.text);
      inifile.WriteString ('Maker', 'Next', edit17.text);

      inifile.free;
    end;
end;

end.
