unit uConsPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  SMDBGrid, Vcl.ExtCtrls, Vcl.StdCtrls, SMultiBtn, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.DBCtrls, uBaseDAO, JvExControls, JvDBLookup;

type
  TfrmConsPadrao = class(TForm)
    pnlTop: TPanel;
    pnlPrincipal: TPanel;
    btnConsultar: TSMButton;
    pg_Principal: TPageControl;
    ts_Consulta: TTabSheet;
    gridConsulta: TSMDBGrid;
    dsConsulta: TDataSource;
    Label1: TLabel;
    pnlSair: TPanel;
    btnFechar: TSMButton;
    qryFilial: TFDQuery;
    dsFilial: TDataSource;
    qryFilialID: TIntegerField;
    qryFilialNOME: TStringField;
    qryFilialNOME_INTERNO: TStringField;
    comboFilial: TJvDBLookupCombo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsPadrao: TfrmConsPadrao;

implementation

uses
  DmdConnection;

{$R *.dfm}

procedure TfrmConsPadrao.btnConsultarClick(Sender: TObject);
begin
  pg_Principal.ActivePage := ts_Consulta;
end;

procedure TfrmConsPadrao.btnFecharClick(Sender: TObject);
begin
//  Self.Close;
  Close;
end;

procedure TfrmConsPadrao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  FreeAndNil(Self);
end;

procedure TfrmConsPadrao.FormCreate(Sender: TObject);
begin
  qryFilial.Close;
  qryFilial.Open();
end;

procedure TfrmConsPadrao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    self.btnConsultar.Click;
end;

end.
