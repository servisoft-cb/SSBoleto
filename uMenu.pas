unit uMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, DmdConnection,
  FireDAC.DApt, Data.DB, Vcl.Grids, Vcl.DBGrids, SMDBGrid, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.ToolWin, System.ImageList, Vcl.ImgList;

type
  TfrmMenu = class(TForm)
    MainMenu1: TMainMenu;
    Administracao1: TMenuItem;
    Cadastros1: TMenuItem;
    Parmetros1: TMenuItem;
    Cedente1: TMenuItem;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ImageList1: TImageList;
    Cedente2: TMenuItem;
    Contas1: TMenuItem;
    Duplicatas1: TMenuItem;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Cedente2Click(Sender: TObject);
    procedure Contas1Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure Duplicatas1Click(Sender: TObject);
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

uses uCadCedente, uUtilPadrao, uConsCedente, uConsConta, uConsDuplicata;

{ TfrmMenu }

procedure TfrmMenu.Cedente2Click(Sender: TObject);
begin
  OpenForm(TfrmConsCedente, wsMaximized);
end;

procedure TfrmMenu.Contas1Click(Sender: TObject);
begin
  OpenForm(TfrmConsConta, wsMaximized);
end;

procedure TfrmMenu.Duplicatas1Click(Sender: TObject);
begin
  OpenForm(TfrmConsDuplicata, wsMaximized);
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

procedure TfrmMenu.ToolButton1Click(Sender: TObject);
begin
  Cedente2Click(Sender);
end;

end.
