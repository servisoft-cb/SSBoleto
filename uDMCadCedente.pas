unit uDMCadCedente;

interface

uses
  System.SysUtils, System.Classes, DmdConnection, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmCadCedente = class(TDataModule)
    qryCadCedente: TFDQuery;
    qryConsulta: TFDQuery;
    qryConsultaID: TIntegerField;
    qryConsultaNOME: TStringField;
    qryConsultaNOME_INTERNO: TStringField;
    qryConsultaENDERECO: TStringField;
    qryConsultaCOMPLEMENTO_END: TStringField;
    qryConsultaNUM_END: TStringField;
    qryConsultaBAIRRO: TStringField;
    qryConsultaCEP: TStringField;
    qryConsultaID_CIDADE: TIntegerField;
    qryConsultaCODMUNICIPIO: TStringField;
    qryConsultaUF: TStringField;
    qryConsultaDDD1: TIntegerField;
    qryConsultaFONE1: TStringField;
    qryConsultaID_CEDENTE: TIntegerField;
    qryConsultaTOKEN_CEDENTE: TStringField;
    qryConsultaCNPJ_CPF: TStringField;
    qryConsultaEMAIL_FINANCEIRO: TStringField;
    qryCadCedenteID: TIntegerField;
    qryCadCedenteNOME: TStringField;
    qryCadCedenteTOKEN_CEDENTE: TStringField;
    qryCadCedenteID_CEDENTE: TIntegerField;
  private
    { Private declarations }
  public
    procedure prc_Abrir_Cedente(ID : Integer);
    procedure prc_Gravar_Cedente(ID_Cedente : Integer ; Token : String);
    { Public declarations }
  end;

var
  dmCadCedente: TdmCadCedente;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}


{$R *.dfm}

{ TdmCadCedente }

procedure TdmCadCedente.prc_Abrir_Cedente(ID: Integer);
begin
  qryCadCedente.Close;
  qryCadCedente.ParamByName('ID').AsInteger := ID;
  qryCadCedente.Open;
end;

procedure TdmCadCedente.prc_Gravar_Cedente(ID_Cedente : Integer ; Token : String);
begin
  if not (qryCadCedente.IsEmpty) then
  begin
    qryCadCedente.Edit;
    qryCadCedenteID_CEDENTE.AsInteger := ID_Cedente;
    qryCadCedenteTOKEN_CEDENTE.AsString := Token;
    qryCadCedente.Post;
    qryCadCedente.UpdateTransaction;
  end;
end;

end.
