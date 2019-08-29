unit uDMCadCedente;

interface

uses
  System.SysUtils, System.Classes, DmdConnection, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmCadCedente = class(TDataModule)
    fdtCadCedente: TFDTable;
    dsCadCedente: TDataSource;
    qryCadCedente: TFDQuery;
    fdtCadCedenteID: TIntegerField;
    fdtCadCedenteNOME: TStringField;
    fdtCadCedenteNOME_INTERNO: TStringField;
    fdtCadCedenteENDERECO: TStringField;
    fdtCadCedenteCOMPLEMENTO_END: TStringField;
    fdtCadCedenteNUM_END: TStringField;
    fdtCadCedenteBAIRRO: TStringField;
    fdtCadCedenteCEP: TStringField;
    fdtCadCedenteID_CIDADE: TIntegerField;
    fdtCadCedenteCIDADE: TStringField;
    fdtCadCedenteUF: TStringField;
    fdtCadCedenteDDD1: TIntegerField;
    fdtCadCedenteFONE1: TStringField;
    fdtCadCedenteID_CEDENTE: TIntegerField;
    fdtCadCedenteTOKEN_CEDENTE: TStringField;
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
