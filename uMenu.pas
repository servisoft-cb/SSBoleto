unit uMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UCDataConnector, UCDBXConn, Vcl.Menus, DmdConnection,
  UCSettings, UCBase, UCFireDACConn, FireDAC.DApt, Data.DB, Vcl.Grids,
  Vcl.DBGrids, SMDBGrid, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TfrmMenu = class(TForm)
    MainMenu1: TMainMenu;
    UCFireDACConn1: TUCFireDACConn;
    UserControl1: TUserControl;
    UCSettings1: TUCSettings;
    Administracao1: TMenuItem;
    Cadastros1: TMenuItem;
    Parmetros1: TMenuItem;
    Cedente1: TMenuItem;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    procedure Cedente1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    procedure OpenForm(FClass: TFormClass; vEstado: TWindowState; TipoPessoa: String = '');
    { Public declarations }
  end;

var
  frmMenu: TfrmMenu;

implementation

{$R *.dfm}

uses uCadCedente, uUtilPadrao, uConsCedente;

{ TfrmMenu }

procedure TfrmMenu.Cedente1Click(Sender: TObject);
begin
  OpenForm(TfrmConsCedente, wsMaximized);
end;

procedure TfrmMenu.FormShow(Sender: TObject);
begin
  StatusBar1.Panels[2].Text := uUtilPadrao.vCaminhoBanco;
end;

procedure TfrmMenu.OpenForm(FClass: TFormClass; vEstado: TWindowState;
  TipoPessoa: String);
var
  existe: TForm;
  j: Byte;
begin
  existe := nil;
  for j := 0 to Screen.FormCount - 1 do
  begin
    if Screen.Forms[j] is FClass then
      existe := Screen.Forms[j];
  end;

  if not (existe = nil) then
  begin
    existe.BringToFront;
    existe.SetFocus;
  end
  else
  begin
    Application.CreateForm(FClass,existe);
    existe.FormStyle := fsMDIChild;
    existe.Show;
  end;
  existe.WindowState := vEstado;
end;

procedure TfrmMenu.Timer1Timer(Sender: TObject);
begin
 StatusBar1.Panels[1].Text := DateTimeToStr(Now)
end;

end.
