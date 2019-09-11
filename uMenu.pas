unit uMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, DmdConnection,
  FireDAC.DApt, Data.DB, Vcl.Grids, Vcl.DBGrids, SMDBGrid, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.ToolWin, System.ImageList, Vcl.ImgList, Vcl.CategoryButtons,
  System.Actions, Vcl.ActnList, Vcl.WinXCtrls, JvExControls, JvPageList,
  JvTabBar, Vcl.Imaging.pngimage, Vcl.StdCtrls, TDI;

type
  TfrmMenu = class(TForm)
    MainMenu1: TMainMenu;
    Administracao1: TMenuItem;
    Cadastros1: TMenuItem;
    Parmetros1: TMenuItem;
    Cedente1: TMenuItem;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    ImageList1: TImageList;
    Cedente2: TMenuItem;
    Contas1: TMenuItem;
    Duplicatas1: TMenuItem;
    SplitView1: TSplitView;
    ActionList1: TActionList;
    pnlTop: TPanel;
    Image1: TImage;
    CategoryButtons1: TCategoryButtons;
    actCedente: TAction;
    actContas: TAction;
    actDuplicata: TAction;
    lblNomeFormulario: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Cedente2Click(Sender: TObject);
    procedure Contas1Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure Duplicatas1Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure actCedenteExecute(Sender: TObject);
    procedure actContasExecute(Sender: TObject);
    procedure actDuplicataExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure OpenForm(FClass: TFormClass; vEstado: TWindowState; TipoPessoa: String = '');
    { Public declarations }
  end;

var
  frmMenu: TfrmMenu;
  FTDI : TTDI;

implementation

{$R *.dfm}

uses uCadCedente, uUtilPadrao, uConsCedente, uConsConta, uConsDuplicata, uResumo;

{ TfrmMenu }

procedure TfrmMenu.actCedenteExecute(Sender: TObject);
begin
//  OpenForm(TfrmConsCedente, wsMaximized);
  Cedente2Click(Sender);
end;

procedure TfrmMenu.actContasExecute(Sender: TObject);
begin
//  OpenForm(TfrmConsConta, wsMaximized);
  Contas1Click(Sender);
end;

procedure TfrmMenu.actDuplicataExecute(Sender: TObject);
begin
//  OpenForm(TfrmConsDuplicata, wsMaximized);
  FTDI.MostrarFormulario(TfrmConsDuplicata, False);
end;

procedure TfrmMenu.Cedente2Click(Sender: TObject);
begin
//  OpenForm(TfrmConsCedente, wsMaximized);
  FTDI.MostrarFormulario(TfrmConsCedente, False);
end;

procedure TfrmMenu.Contas1Click(Sender: TObject);
begin
//  OpenForm(TfrmConsConta, wsMaximized);
  FTDI.MostrarFormulario(TfrmConsConta, False);
end;

procedure TfrmMenu.Duplicatas1Click(Sender: TObject);
begin
//  OpenForm(TfrmConsDuplicata, wsMaximized);
  FTDI.MostrarFormulario(TfrmConsDuplicata, False);
end;

procedure TfrmMenu.FormCreate(Sender: TObject);
begin
  FTDI := TTDI.Create(Self, TfrmResumo);
  FTDI.MostrarMenuPopup := True;
end;

procedure TfrmMenu.FormShow(Sender: TObject);
begin
  StatusBar1.Panels[2].Text := uUtilPadrao.vCaminhoBanco;
end;

procedure TfrmMenu.Image1Click(Sender: TObject);
begin
  if SplitView1.Opened then
    SplitView1.Close
  else
    SplitView1.Open;
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
    lblNomeFormulario.Caption := existe.Caption;
    existe.SetFocus;
  end
  else
  begin
    Application.CreateForm(FClass,existe);
    existe.FormStyle := fsMDIChild;
    lblNomeFormulario.Caption := existe.Caption;
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
