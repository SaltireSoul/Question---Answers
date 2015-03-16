program Quiz;

uses
  Forms,
  Teachers in 'Teachers.pas' {TeachersForm},
  Students in 'Students.pas' {StudentsForm},
  Output in 'Output.pas' {OutputForm},
  About in 'About.pas' {AboutBox},
  hh_funcs in 'hh_funcs.pas',
  hh in 'hh.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Quiz Reader';
  Application.HelpFile := '';
  Application.CreateForm(TTeachersForm, TeachersForm);
  Application.CreateForm(TStudentsForm, StudentsForm);
  Application.CreateForm(TOutputForm, OutputForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
