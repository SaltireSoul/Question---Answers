program Translator;

uses
  Forms,
  Trans in 'Trans.pas' {QandATransForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Questions & Answers - Translator';
  Application.CreateForm(TQandATransForm, QandATransForm);
  Application.Run;
end.
