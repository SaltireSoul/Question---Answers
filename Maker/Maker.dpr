program Maker;

uses
  Forms,
  Main in 'Main.pas' {MakerForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Quiz - Question Maker';
  Application.CreateForm(TMakerForm, MakerForm);
  Application.Run;
end.
