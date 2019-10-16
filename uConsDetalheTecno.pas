unit uConsDetalheTecno;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids, SMDBGrid, Vcl.ExtCtrls;

type
  TfrmConsultaDetalheTecno = class(TForm)
    Panel1: TPanel;
    SMDBGrid1: TSMDBGrid;
    dsPadrao: TDataSource;
    cdsPadrao: TClientDataSet;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaDetalheTecno: TfrmConsultaDetalheTecno;

implementation

{$R *.dfm}

procedure TfrmConsultaDetalheTecno.FormShow(Sender: TObject);
begin
  cdsPadrao.Open;
end;

end.
