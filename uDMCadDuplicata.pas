unit uDMCadDuplicata;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, DmdConnection;

type
  TDMCadDuplicata = class(TDataModule)
    qryDuplicata: TFDQuery;
    qryDuplicataID: TIntegerField;
    qryDuplicataTIPO_ES: TStringField;
    qryDuplicataFILIAL: TIntegerField;
    qryDuplicataID_NOTA: TIntegerField;
    qryDuplicataPARCELA: TIntegerField;
    qryDuplicataNUMDUPLICATA: TStringField;
    qryDuplicataNUMNOTA: TIntegerField;
    qryDuplicataSERIE: TStringField;
    qryDuplicataDTVENCIMENTO: TDateField;
    qryDuplicataVLR_PARCELA: TFloatField;
    qryDuplicataVLR_RESTANTE: TFloatField;
    qryDuplicataVLR_PAGO: TFloatField;
    qryDuplicataVLR_DEVOLUCAO: TFloatField;
    qryDuplicataVLR_DESPESAS: TFloatField;
    qryDuplicataVLR_DESCONTO: TFloatField;
    qryDuplicataVLR_JUROSPAGOS: TFloatField;
    qryDuplicataVLR_COMISSAO: TFloatField;
    qryDuplicataPERC_COMISSAO: TFloatField;
    qryDuplicataDTULTPAGAMENTO: TDateField;
    qryDuplicataID_PESSOA: TIntegerField;
    qryDuplicataID_CONTA: TIntegerField;
    qryDuplicataID_TIPOCOBRANCA: TIntegerField;
    qryDuplicataID_VENDEDOR: TIntegerField;
    qryDuplicataID_CONTA_BOLETO: TIntegerField;
    qryDuplicataID_COMISSAO: TIntegerField;
    qryDuplicataQTD_DIASATRASO: TIntegerField;
    qryDuplicataDTRECEBIMENTO_TITULO: TDateField;
    qryDuplicataDTEMISSAO: TDateField;
    qryDuplicataPAGO_CARTORIO: TStringField;
    qryDuplicataPROTESTADO: TStringField;
    qryDuplicataTIPO_LANCAMENTO: TStringField;
    qryDuplicataARQUIVO_GERADO: TStringField;
    qryDuplicataTRANSFERENCIA_ICMS: TStringField;
    qryDuplicataNOSSONUMERO: TStringField;
    qryDuplicataDTFINANCEIRO: TDateField;
    qryDuplicataNUMCHEQUE: TIntegerField;
    qryDuplicataACEITE: TStringField;
    qryDuplicataID_COB_ELETRONICA: TIntegerField;
    qryDuplicataBOLETO_IMP: TStringField;
    qryDuplicataID_CARTEIRA: TIntegerField;
    qryDuplicataID_BANCO: TIntegerField;
    qryDuplicataIMP_BOLETO: TStringField;
    qryDuplicataNUM_REMESSA: TIntegerField;
    qryDuplicataID_NOTA_SERVICO: TIntegerField;
    qryDuplicataDESCRICAO: TStringField;
    qryDuplicataNUMRPS: TIntegerField;
    qryDuplicataANO_REF: TIntegerField;
    qryDuplicataMES_REF: TIntegerField;
    qryDuplicataNUM_CONTRATO: TIntegerField;
    qryDuplicataID_CONTA_ORCAMENTO: TIntegerField;
    qryDuplicataID_CUPOM: TIntegerField;
    qryDuplicataVLR_TAXA_BANCARIA: TFloatField;
    qryDuplicataCOBRAR_TAXA: TStringField;
    qryDuplicataID_TERMINAL: TIntegerField;
    qryDuplicataID_FECHAMENTO: TIntegerField;
    qryDuplicataTIPO_MOV: TStringField;
    qryDuplicataNOSSONUMERO_SEQ: TLargeintField;
    qryDuplicataNOSSONUMERO_GERADO: TStringField;
    qryDuplicataNUMDUPLICATA_SEQ: TIntegerField;
    qryDuplicataID_RECIBO: TIntegerField;
    qryDuplicataID_PEDIDO: TIntegerField;
    qryDuplicataPERC_COMISSAO_PAGAR_NOTA: TFloatField;
    qryDuplicataUSUARIO: TStringField;
    qryDuplicataTITULO_CARTORIO: TStringField;
    qryDuplicataID_DESCONTADA: TIntegerField;
    qryDuplicataCONFIRMA_PGTO: TStringField;
    qryDuplicataCOD_ANT: TIntegerField;
    qryDuplicataPERC_BASE_COMISSAO: TFloatField;
    qryDuplicataEMISSAO_BOLETO: TStringField;
    qryDuplicataDESCRICAO2: TStringField;
    qryDuplicataID_CONTRATO: TIntegerField;
    qryDuplicataVLR_MULTA: TFloatField;
    qryDuplicataID_CONTABIL_OPE_LACTO: TIntegerField;
    qryDuplicataID_CONTABIL_OPE_BAIXA: TIntegerField;
    qryDuplicataREGIME_CAIXA: TStringField;
    qryDuplicataPERDIDO: TStringField;
    qryDuplicataINSTRUCAO_PROTESTO: TStringField;
    qryDuplicataNGR: TStringField;
    qryDuplicataAPROVADO: TStringField;
    qryDuplicataDTAPROVADO: TDateField;
    qryDuplicataCANCELADA: TStringField;
    qryDuplicataDTVENCIMENTO_INI: TDateField;
    qryDuplicataNOME_CLIENTE: TStringField;
    qryDuplicataNOME_CONTA: TStringField;
    qryDuplicataCOD_CARTEIRA: TStringField;
    qryDuplicataCOD_CARTEIRA_IMP: TStringField;
    qryDuplicataNOME_CARTEIRA: TStringField;
    qryDuplicataGERAR_NOSSONUMERO: TStringField;
    qryDuplicataPESSOA: TStringField;
    qryDuplicataCNPJ_CPF: TStringField;
    qryDuplicataENDERECO: TStringField;
    qryDuplicataNUM_END: TStringField;
    qryDuplicataCEP: TStringField;
    qryDuplicataBAIRRO: TStringField;
    qryDuplicataCIDADE: TStringField;
    qryDuplicataUF: TStringField;
    qryDuplicataPESSOA_PGTO: TStringField;
    qryDuplicataENDERECO_PGTO: TStringField;
    qryDuplicataNUM_END_PGTO: TStringField;
    qryDuplicataCEP_PGTO: TStringField;
    qryDuplicataBAIRRO_PGTO: TStringField;
    qryDuplicataCIDADE_PGTO: TStringField;
    qryDuplicataUF_PGTO: TStringField;
    qryDuplicataCNPJ_CPG_PGTO: TStringField;
    qryDuplicataEMAIL_PGTO: TStringField;
    qryDuplicataCOMPLEMENTO_END: TStringField;
    qryDuplicataCOMPLEMENTO_END_PGTO: TStringField;
    qryDuplicataGERAR_REMESSA: TStringField;
    qryDuplicataID_GRUPO: TIntegerField;
    qryDuplicataNOME_GRUPO: TStringField;
    qryDuplicataID_CARTEIRA_CLIENTE: TIntegerField;
    qryDuplicataTAXA_BANCO: TStringField;
    qryDuplicataTIPO_REG: TStringField;
    qryDuplicataNFECHAVEACESSO: TStringField;
    qryDuplicataCOD_AUTENCIDADE_RET: TStringField;
    qryDuplicataID_OCORRENCIA_COB: TIntegerField;
    qryContas: TFDQuery;
    dsContas: TDataSource;
    qryOcorrencia: TFDQuery;
    dsOcorrencia: TDataSource;
    qryOcorrenciaENVIAR_DIAS_PROTESTO: TStringField;
    qryOcorrenciaID: TIntegerField;
    qryOcorrenciaCODIGO: TStringField;
    qryOcorrenciaNOME: TStringField;
    qryOcorrenciaTIPO_REG: TStringField;
    qryOcorrenciaID_BANCO: TIntegerField;
    qryOcorrenciaCOD_REDUZIDO: TStringField;
    qryOcorrenciaTIPO_INST: TStringField;
    qryOcorrenciaTIPO_PROTESTO: TStringField;
    qryOcorrenciaGERAR_NOSSONUMERO: TStringField;
    qryOcorrenciaGERAR_REMESSA: TStringField;
    qryOcorrenciaCOD_BANCO: TStringField;
    qryOcorrenciaTIPO_OCO: TStringField;
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
    qryContasID_CONTA_TECNOSPEED: TIntegerField;
    qryContasID_CONVENIO_TECNOSPEED: TSmallintField;
    qryContasREINICIAR_NUM_REMESSA_DIA: TStringField;
    qryContasCOD_BANCO: TStringField;
    qryContasNOME_BANCO: TStringField;
    qryContasCOD_CARTEIRA: TStringField;
    qryContasCOD_CARTEIRA_IMP: TStringField;
    qryContasNOME_CARTEIRA: TStringField;
    qryContasGERAR_NOSSONUMERO: TStringField;
    qryContasCOD_INSTRUCAO1: TStringField;
    qryContasCOD_RED_INSTRUCAO1: TStringField;
    qryContasTIPO_INSTRUCAO1: TStringField;
    qryContasCOD_INSTRUCAO2: TStringField;
    qryContasCOD_RED_INSTRUCAO2: TStringField;
    qryContasTIPO_INSTRUCAO2: TStringField;
    qryContasCOD_ESPECIE: TStringField;
    qryContasCOD_RED_ESPECIE: TStringField;
    qryContasCOD_OCORRENCIA: TStringField;
    qryContasCOD_RED_OCORRENCIA: TStringField;
    qryContasOPCAO_GERAR_NOSSNUMERO: TStringField;
    qryContasGERAR_NOSSONUMERO_ESP: TStringField;
    qryContasGERAR_REMESSA: TStringField;
    qryContasACBR_USAR_MONTAR_NOSSONUMERO: TStringField;
    qryContasINICIAL_NOME_ARQ_REMESSA: TStringField;
    procedure qryContasBeforeScroll(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ctCommandDup : String;
    procedure prc_Abrir_Ocorrencia(Tipo : String; ID_Banco : Integer);

  end;

var
  DMCadDuplicata: TDMCadDuplicata;

implementation


{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDMCadDuplicata }

procedure TDMCadDuplicata.DataModuleCreate(Sender: TObject);
begin
  ctCommandDup := qryDuplicata.SQL.Text;
end;

procedure TDMCadDuplicata.prc_Abrir_Ocorrencia(Tipo: String; ID_Banco: Integer);
begin
  qryOcorrencia.Close;
  qryOcorrencia.ParamByName('TIPO_REG').AsString := Tipo;
  qryOcorrencia.ParamByName('ID_BANCO').AsInteger := ID_Banco;
  qryOcorrencia.Open();
  if not (qryOcorrencia.IsEmpty) and (qryContasID_OCORRENCIA.AsInteger > 0) then
    qryOcorrencia.Locate('ID',qryContasID_OCORRENCIA.AsInteger);
end;

procedure TDMCadDuplicata.qryContasBeforeScroll(DataSet: TDataSet);
begin
  if qryContasID.AsInteger > 0 then
    prc_Abrir_Ocorrencia('OCO',qryContasID_BANCO.AsInteger);
end;

end.
