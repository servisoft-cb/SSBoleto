unit uConsPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  SMDBGrid, Vcl.ExtCtrls, Vcl.StdCtrls, SMultiBtn, Vcl.ComCtrls;

type
  TfrmConsPadrao = class(TForm)
    pnlTop: TPanel;
    pnlPrincipal: TPanel;
    btnConsultar: TSMButton;
    PageControl1: TPageControl;
    ts_Principal: TTabSheet;
    SMDBGrid1: TSMDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsPadrao: TfrmConsPadrao;

implementation

{$R *.dfm}

procedure TfrmConsPadrao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(Self);
end;

end.
