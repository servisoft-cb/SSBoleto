unit uConsDuplicata;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  uConsPadrao, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, SMDBGrid, Vcl.ComCtrls,
  Vcl.DBCtrls, Vcl.StdCtrls, SMultiBtn, Vcl.ExtCtrls, Vcl.Mask, JvExMask,
  JvToolEdit, JvExComCtrls, JvDateTimePicker, JvMaskEdit, JvCheckedMaskEdit,
  JvDatePickerEdit, JvExExtCtrls, JvRadioGroup, JvExControls, JvDBLookup,
  uDMCadDuplicata, JvExStdCtrls, JvCombobox;

type
  TEnumTitulos = (tpNaoEnviados, tpEnviados, tpTodos);

type
  TfrmConsDuplicata = class(TfrmConsPadrao)
    edtNumeroDoc: TEdit;
    Label2: TLabel;
    DateInicial: TJvDateEdit;
    DateFinal: TJvDateEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    comboBanco: TJvDBLookupCombo;
    Label6: TLabel;
    comboOcorrencia: TJvDBLookupCombo;
    ComboTitulo: TJvComboBox;
    Label7: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure comboOcorrenciaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure comboBancoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    fDMCadDuplicata: TDMCadDuplicata;
    procedure prc_Consulta_Duplicata;
  public
    { Public declarations }
  end;

var
  frmConsDuplicata: TfrmConsDuplicata;

implementation

uses
  uUtilPadrao;

{$R *.dfm}

procedure TfrmConsDuplicata.btnConsultarClick(Sender: TObject);
begin
  inherited;
  prc_Consulta_Duplicata;
end;

procedure TfrmConsDuplicata.comboBancoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_ESCAPE) Then
   comboBanco.KeyValue := '0';
end;

procedure TfrmConsDuplicata.comboOcorrenciaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_ESCAPE) Then
   comboOcorrencia.KeyValue := '0';
end;

procedure TfrmConsDuplicata.FormCreate(Sender: TObject);
begin
  inherited;
  fDMCadDuplicata := TDMCadDuplicata.Create(Self);
  dsConsulta.DataSet := fDMCadDuplicata.qryDuplicata;
end;

procedure TfrmConsDuplicata.FormShow(Sender: TObject);
begin
  inherited;
  fDMCadDuplicata.qryContas.Close;
  fDMCadDuplicata.qryContas.Open();
  if qryFilial.RecordCount = 1 then
    comboFilial.KeyValue := qryFilialID.AsInteger;

  if fDMCadDuplicata.qryContas.RecordCount = 1 then
  begin
    comboBanco.KeyValue := fDMCadDuplicata.qryContasID.AsInteger;
    fDMCadDuplicata.qryContasBeforeScroll(fDMCadDuplicata.qryContas);
    comboOcorrencia.KeyValue := fDMCadDuplicata.qryOcorrenciaID.AsInteger;
  end;
end;

procedure TfrmConsDuplicata.prc_Consulta_Duplicata;
begin
  fDMCadDuplicata.qryDuplicata.SQL.Text := fDMCadDuplicata.ctCommandDup;
  fDMCadDuplicata.qryDuplicata.Close;
  fDMCadDuplicata.qryDuplicata.SQL.Add(' WHERE DUP.TIPO_ES = ' + QuotedStr('E') + ' AND DUP.VLR_RESTANTE > 0');
  if comboFilial.KeyValue > 0 then
    fDMCadDuplicata.qryDuplicata.SQL.Add(' AND DUP.FILIAL = ' + IntToStr(comboFilial.KeyValue));
  if edtNumeroDoc.Text <> '' then
    fDMCadDuplicata.qryDuplicata.SQL.Add(' AND (DUP.NUMDUPLICATA = ' + QuotedStr(edtNumeroDoc.Text) + ') ');
  if DateInicial.Date > 10 then
    fDMCadDuplicata.qryDuplicata.SQL.Add(' AND DUP.DTEMISSAO >= ' + QuotedStr(FormatDateTime('MM/DD/YYYY', DateInicial.Date)));
  if DateFinal.Date > 10 then
    fDMCadDuplicata.qryDuplicata.SQL.Add(' AND DUP.DTEMISSAO <= ' + QuotedStr(FormatDateTime('MM/DD/YYYY', DateFinal.Date)));
  if SQLLocate('PARAMETROS_FIN', 'ID', 'TIPO_GERACAO_REM', '1') = '1' then
    fDMCadDuplicata.qryDuplicata.SQL.Add(' AND (DUP.ID_CONTA_BOLETO = ' + IntToStr(comboBanco.KeyValue) + ') ')
  else
    fDMCadDuplicata.qryDuplicata.SQL.Add(' AND (DUP.ID_CONTA_BOLETO = ' + IntToStr(comboBanco.KeyValue) + ' OR DUP.ID_CONTA_BOLETO IS NULL) ');
  case TEnumTitulos(ComboTitulo.ItemIndex) of
   tpNaoEnviados : fDMCadDuplicata.qryDuplicata.SQL.Add(' AND ((DUP.NUM_REMESSA = 0) OR (DUP.NUM_REMESSA IS NULL))');
   tpEnviados : fDMCadDuplicata.qryDuplicata.SQL.Add(' AND (DUP.NUM_REMESSA > 0)');
  end;
  if comboOcorrencia.KeyValue > 0 then
    fDMCadDuplicata.qryDuplicata.ParamByName('ID_OCORRENCIA').AsInteger := comboOcorrencia.KeyValue;

  fDMCadDuplicata.qryDuplicata.Open();

end;

end.

