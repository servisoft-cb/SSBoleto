unit uDMCadCedente;

interface

uses
  System.SysUtils, System.Classes, DmdConnection, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmCadCedente = class(TDataModule)
    dsCadCedente: TDataSource;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmCadCedente: TdmCadCedente;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}


{$R *.dfm}

end.
