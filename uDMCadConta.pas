unit uDMCadConta;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmCadConta = class(TDataModule)
    qryConsulta: TFDQuery;
    qryContas: TFDQuery;
    qryContasID: TIntegerField;
    qryContasNOME: TStringField;
    qryContasAGENCIA: TStringField;
    qryContasFILIAL: TIntegerField;
    qryContasNUMCONTA: TStringField;
    qryContasCNAB: TStringField;
    qryContasDTENCERRAMENTO: TDateField;
    qryContasID_TIPOCOBRANCA: TIntegerField;
    qryContasDESCRICAO_NOTA: TStringField;
    qryContasTIPO_CONTA: TStringField;
    qryContasID_BANCO: TIntegerField;
    qryContasDIG_CONTA: TStringField;
    qryContasCOD_CEDENTE: TStringField;
    qryContasACEITE: TStringField;
    qryContasID_OCORRENCIA: TIntegerField;
    qryContasDIAS_PROTESTO: TIntegerField;
    qryContasID_ESPECIE: TIntegerField;
    qryContasID_CARTEIRA: TIntegerField;
    qryContasID_INSTRUCAO1: TIntegerField;
    qryContasID_INSTRUCAO2: TIntegerField;
    qryContasID_TIPO_COBRANCA: TIntegerField;
    qryContasMOEDA: TStringField;
    qryContasVARIACAO_CARTEIRA: TStringField;
    qryContasTIPO_DOCUMENTO: TStringField;
    qryContasCOD_TRANSMISSAO: TStringField;
    qryContasMENSAGEM_FIXA: TStringField;
    qryContasPERC_DESCONTO: TFloatField;
    qryContasPERC_JUROS: TFloatField;
    qryContasVLR_IOF: TFloatField;
    qryContasVLR_TAXA: TFloatField;
    qryContasLOCAL_PAGAMENTO: TStringField;
    qryContasEND_ARQUIVO_REM: TStringField;
    qryContasNOME_ARQ_REM: TStringField;
    qryContasEXTENSAO_ARQ_REM: TStringField;
    qryContasDT_LIMITE_DESCONTO: TDateField;
    qryContasCOMISSAO_PERMANENCIA: TStringField;
    qryContasNUM_CONVENIO_LIDER: TStringField;
    qryContasDIG_AGENCIA: TStringField;
    qryContasDIAS_DEVOLUCAO: TIntegerField;
    qryContasNUM_ARQ_REMESSA: TIntegerField;
    qryContasPOS_NUMCONTA_RETORNO: TIntegerField;
    qryContasPOS_CODBANCO_RETORNO: TIntegerField;
    qryContasPERC_MULTA: TFloatField;
    qryContasDIAS_MULTA: TIntegerField;
    qryContasACBR_TIPOCOBRANCA: TStringField;
    qryContasNOSSONUMERO_POR_ANO: TStringField;
    qryContasACBR_LAYOUTREMESSA: TStringField;
    qryContasBANCO_LOGO: TStringField;
    qryContasDT_REMESSA: TDateField;
    qryContasSEQ_REMESSA_DIA: TIntegerField;
    qryContasTIPO_IMPRESSAO: TStringField;
    qryContasTIPO_DOCUMENTO_SANTANDER: TStringField;
    qryContasTIPO_CARTEIRA: TStringField;
    qryContasINATIVO: TStringField;
    qryContasCONTROLA_EMISSAO_BOLETO: TStringField;
    qryContasGERAR_BOLETO: TStringField;
    qryContasGERAR_DEPOSITO: TStringField;
    qryContasCOD_CONTABIL: TIntegerField;
    qryContasCODMORA: TSmallintField;
    qryContasREMESSA_TESTE: TStringField;
    qryContasEND_ARQUIVO_RET: TStringField;
    qryConsultaID: TIntegerField;
    qryConsultaCODIGO: TStringField;
    qryConsultaNOME: TStringField;
    qryConsultaAGENCIA: TStringField;
    qryConsultaDIG_AGENCIA: TStringField;
    qryConsultaNUMCONTA: TStringField;
    qryConsultaDIG_CONTA: TStringField;
    qryConsultaCOD_CEDENTE: TStringField;
    qryConsultaFILIAL: TIntegerField;
    qryConsultaID_CONTA_TECNOSPEED: TIntegerField;
    qryContasID_CONTA_TECNOSPEED: TIntegerField;
    qryConsultaID_CONVENIO_TECNOSPEED: TSmallintField;
    qryConsultaCARTEIRA: TStringField;
    qryConsultaREINICIAR_NUM_REMESSA_DIA: TStringField;
    qryConsultaACBR_LAYOUTREMESSA: TStringField;
    qryContasID_CONVENIO_TECNOSPEED: TSmallintField;
    qryContasREINICIAR_NUM_REMESSA_DIA: TStringField;
  private
    { Private declarations }
  public
    procedure prc_Abrir_Conta(ID : Integer);
    procedure prc_Gravar_Conta(ID_Conta_TecnoSpeed : Integer);
    procedure prc_Gravar_Convenio(ID_Convenio_TecnoSpeed : Integer);
    { Public declarations }
  end;

var
  dmCadConta: TdmCadConta;

implementation

uses
  DmdConnection;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmCadConta }

procedure TdmCadConta.prc_Abrir_Conta(ID: Integer);
begin
  qryContas.Close;
  qryContas.ParamByName('ID').AsInteger := ID;
  qryContas.Open;
end;

procedure TdmCadConta.prc_Gravar_Conta(ID_Conta_TecnoSpeed: Integer);
begin
  if not (qryContas.IsEmpty) then
  begin
    qryContas.Edit;
    qryContasID_CONTA_TECNOSPEED.AsInteger := ID_Conta_TecnoSpeed;
    qryContas.Post;
    qryContas.UpdateTransaction;
  end;
end;

procedure TdmCadConta.prc_Gravar_Convenio(ID_Convenio_TecnoSpeed: Integer);
begin
  if not (qryContas.IsEmpty) then
  begin
    qryContas.Edit;
    qryContasID_CONVENIO_TECNOSPEED.AsInteger := ID_Convenio_TecnoSpeed;
    qryContas.Post;
    qryContas.UpdateTransaction;
  end;
end;

end.
