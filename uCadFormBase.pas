unit uCadFormBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, SMDBGrid, Vcl.StdCtrls, SMultiBtn, FireDAC.Comp.Client;

type
  TCadFormBase = class(TForm)
    pgPrincipal: TPageControl;
    ts_Consulta: TTabSheet;
    ts_Cadastro: TTabSheet;
    pnlTop_Consulta: TPanel;
    btnInserir: TSMButton;
    btnPesquisar: TSMButton;
    btnExcluir: TSMButton;
    pnlConsulta: TPanel;
    gridConsulta: TSMDBGrid;
    pnlTop_Cadastro: TPanel;
    btnAlterar: TSMButton;
    btnConfirmar: TSMButton;
    btnCancelar: TSMButton;
    pnlPrincipal: TPanel;
    StatusBar1: TStatusBar;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridConsultaDblClick(Sender: TObject);
    procedure prc_Habilita;
    procedure btnInserirClick(Sender: TObject);
  private
    { Private declarations }
    procedure prc_Double_Click(PageCont : TPageControl; Aba : TTabSheet; qry : TFDTable);
  public
    { Public declarations }
  end;

var
  CadFormBase: TCadFormBase;

implementation

{$R *.dfm}

procedure TCadFormBase.btnInserirClick(Sender: TObject);
begin
  prc_Habilita;
end;

procedure TCadFormBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(Self);
end;

procedure TCadFormBase.FormShow(Sender: TObject);
begin
  pgPrincipal.ActivePage := ts_Consulta;
end;

procedure TCadFormBase.gridConsultaDblClick(Sender: TObject);
begin
  pgPrincipal.ActivePage := ts_Cadastro;
end;

procedure TCadFormBase.prc_Habilita;
begin
  ts_Consulta.Enabled := not ts_Consulta.Enabled;
  btnAlterar.Enabled := not btnAlterar.Enabled;
  btnConfirmar.Enabled := not btnConfirmar.Enabled;
  pnlPrincipal.Enabled := not pnlPrincipal.Enabled;
end;

procedure TCadFormBase.prc_Double_Click(PageCont: TPageControl; Aba: TTabSheet;
  qry: TFDTable);
begin
  if (PageCont.ActivePage = Aba) and (not qry.IsEmpty) then
  begin

  end;
end;

end.
