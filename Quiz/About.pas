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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

{$R *.DFM}

procedure TAboutBox.BorlandWebSite(Sender: TObject);
begin
  ShellExecute(handle, 'open', 'www.borland.com', NIL, NIL, SW_SHOWNORMAL);  
end;

end.
 
