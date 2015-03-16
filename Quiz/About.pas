unit About;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, jpeg, shellapi;

type
  TAboutBox = class(TForm)
    OKButton: TButton;
    Panel: TPanel;
    ProductLbl: TLabel;
    ProductName: TLabel;
    VersionLbl: TLabel;
    VersionNo: TLabel;
    Copyright1: TLabel;
    CopyrightLbl: TLabel;
    Copyright2: TLabel;
    Label1: TLabel;
    CommentsLbl: TLabel;
    procedure BorlandWebSite(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure SetLang;
  end;

var
  AboutBox: TAboutBox;

implementation

uses Teachers;

{$R *.DFM}

procedure TAboutBox.BorlandWebSite(Sender: TObject);
begin
  ShellExecute(handle, 'open', 'www.borland.com', NIL, NIL, SW_SHOWNORMAL);  
end;

procedure TAboutBox.FormShow(Sender: TObject);
begin
  SetLang;
end;

procedure TAboutBox.SetLang;
begin
   ProductLbl.Caption := Lang[35];
   VersionLbl.Caption := Lang[36];
   CopyrightLbl.Caption := Lang[37];
   CommentsLbl.Caption := Lang[38];
   OKButton.Caption := Lang[31];
end;

end.
 
