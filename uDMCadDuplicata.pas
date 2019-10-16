unit uDMCadDuplicata;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, DmdConnection, Datasnap.DBClient;

type
  TDMCadDuplicata = class(TDataModule)
    qryDuplicata: TFDQuery;
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
    qryConsulta_Duplicata: TFDQuery;
    qryConsulta_DuplicataID: TIntegerField;
    qryConsulta_DuplicataTIPO_ES: TStringField;
    qryConsulta_DuplicataFILIAL: TIntegerField;
    qryConsulta_DuplicataID_NOTA: TIntegerField;
    qryConsulta_DuplicataPARCELA: TIntegerField;
    qryConsulta_DuplicataNUMDUPLICATA: TStringField;
    qryConsulta_DuplicataNUMNOTA: TIntegerField;
    qryConsulta_DuplicataSERIE: TStringField;
    qryConsulta_DuplicataDTVENCIMENTO: TDateField;
    qryConsulta_DuplicataVLR_PARCELA: TFloatField;
    qryConsulta_DuplicataVLR_RESTANTE: TFloatField;
    qryConsulta_DuplicataVLR_PAGO: TFloatField;
    qryConsulta_DuplicataVLR_DESCONTO: TFloatField;
    qryConsulta_DuplicataID_PESSOA: TIntegerField;
    qryConsulta_DuplicataID_TIPOCOBRANCA: TIntegerField;
    qryConsulta_DuplicataDTULTPAGAMENTO: TDateField;
    qryConsulta_DuplicataID_CONTA_BOLETO: TIntegerField;
    qryConsulta_DuplicataNOME_CLIENTE: TStringField;
    qryConsulta_DuplicataNOME_CONTA: TStringField;
    qryConsulta_DuplicataCOD_CARTEIRA: TStringField;
    qryConsulta_DuplicataCOD_CARTEIRA_IMP: TStringField;
    qryConsulta_DuplicataNOME_CARTEIRA: TStringField;
    qryConsulta_DuplicataGERAR_NOSSONUMERO: TStringField;
    qryConsulta_DuplicataPESSOA: TStringField;
    qryConsulta_DuplicataCNPJ_CPF: TStringField;
    qryConsulta_DuplicataENDERECO: TStringField;
    qryConsulta_DuplicataNUM_END: TStringField;
    qryConsulta_DuplicataCEP: TStringField;
    qryConsulta_DuplicataBAIRRO: TStringField;
    qryConsulta_DuplicataCIDADE: TStringField;
    qryConsulta_DuplicataUF: TStringField;
    qryConsulta_DuplicataPESSOA_PGTO: TStringField;
    qryConsulta_DuplicataENDERECO_PGTO: TStringField;
    qryConsulta_DuplicataNUM_END_PGTO: TStringField;
    qryConsulta_DuplicataCEP_PGTO: TStringField;
    qryConsulta_DuplicataBAIRRO_PGTO: TStringField;
    qryConsulta_DuplicataCIDADE_PGTO: TStringField;
    qryConsulta_DuplicataUF_PGTO: TStringField;
    qryConsulta_DuplicataCNPJ_CPG_PGTO: TStringField;
    qryConsulta_DuplicataEMAIL_PGTO: TStringField;
    qryConsulta_DuplicataCOMPLEMENTO_END: TStringField;
    qryConsulta_DuplicataCOMPLEMENTO_END_PGTO: TStringField;
    qryConsulta_DuplicataGERAR_REMESSA: TStringField;
    qryConsulta_DuplicataID_GRUPO: TIntegerField;
    qryConsulta_DuplicataNOME_GRUPO: TStringField;
    qryConsulta_DuplicataID_CARTEIRA_CLIENTE: TIntegerField;
    qryConsulta_DuplicataTAXA_BANCO: TStringField;
    qryConsulta_DuplicataTIPO_REG: TStringField;
    qryConsulta_DuplicataNFECHAVEACESSO: TStringField;
    qryConsulta_DuplicataCOD_AUTENCIDADE_RET: TStringField;
    qryConsulta_DuplicataID_OCORRENCIA_COB: TIntegerField;
    qryConsulta_DuplicataDTEMISSAO: TDateField;
    qryConsulta_DuplicataID_CONTA: TIntegerField;
    qryConsulta_DuplicataID_INTEGRACAO: TStringField;
    qryConsulta: TFDQuery;
    qryConsulta_DuplicataID_IMPRESSAO: TStringField;
    cdsConsulta: TClientDataSet;
    dsConsulta: TDataSource;
    procedure qryContasBeforeScroll(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ctCommandDup : String;
    procedure prc_Abrir_Ocorrencia(Tipo : String; ID_Banco : Integer);
    procedure prc_Abrir_Duplicata(ID : Integer);
    procedure prc_Gravar_Duplicata(ID_Duplicata : Integer ; ID_Integracao : String);
    procedure prc_Criar_CampoClientDataSet(NomeCampo : string; Tipo : TFieldType; Tamanho : Integer; Obrigatorio : Boolean);
  end;

var
  DMCadDuplicata: TDMCadDuplicata;

implementation


{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDMCadDuplicata }

procedure TDMCadDuplicata.DataModuleCreate(Sender: TObject);
begin
  ctCommandDup := qryConsulta_Duplicata.SQL.Text;
end;

procedure TDMCadDuplicata.prc_Abrir_Duplicata(ID: Integer);
begin
  qryDuplicata.Close;
  qryDuplicata.ParamByName('ID').AsInteger := ID;
  qryDuplicata.Open;
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

procedure TDMCadDuplicata.prc_Criar_CampoClientDataSet(NomeCampo : string; Tipo : TFieldType; Tamanho : Integer; Obrigatorio : Boolean);
begin
  cdsConsulta.FieldDefs.Add(NomeCampo,Tipo,Tamanho,Obrigatorio);
end;

procedure TDMCadDuplicata.prc_Gravar_Duplicata(ID_Duplicata: Integer;
  ID_Integracao: String);
begin
  if not (qryDuplicata.IsEmpty) then
  begin
    qryDuplicata.Edit;
    qryDuplicata.FieldByName('ID').AsInteger := ID_Duplicata;
    qryDuplicata.FieldByName('ID_INTEGRACAO').AsString := ID_Integracao;
    qryDuplicata.Post;
    qryDuplicata.UpdateTransaction;
  end;
end;

procedure TDMCadDuplicata.qryContasBeforeScroll(DataSet: TDataSet);
begin
  if qryContasID.AsInteger > 0 then
    prc_Abrir_Ocorrencia('OCO',qryContasID_BANCO.AsInteger);
end;

end.
