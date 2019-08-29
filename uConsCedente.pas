unit uConsCedente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uConsPadrao, Data.DB, Vcl.StdCtrls,
  SMultiBtn, Vcl.Grids, Vcl.DBGrids, SMDBGrid, Vcl.ExtCtrls, uDMCadCedente,
  Vcl.ComCtrls;

type
  TfrmConsCedente = class(TfrmConsPadrao)
    SMButton1: TSMButton;
    procedure FormShow(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsCedente: TfrmConsCedente;
  fDMCadCedente : TdmCadCedente;

implementation

{$R *.dfm}


procedure TfrmConsCedente.btnConsultarClick(Sender: TObject);
begin
  inherited;
  fDMCadCedente.fdtCadCedente.Open('FILIAL');
end;

procedure TfrmConsCedente.FormShow(Sender: TObject);
begin
  inherited;
  fDMCadCedente := TdmCadCedente.Create(Self);
end;

end.
