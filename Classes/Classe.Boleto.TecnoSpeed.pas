unit Classe.Boleto.TecnoSpeed;

interface

uses
  BoletoX_TLB, uBaseDAO, System.Classes, FireDAC.Comp.Client, Classe.Enviar.Email.TecnoSpeed, uUtilPadrao ;

type
  TBoletoTecnoSpeed = class(TBaseDao)
    private
    FIDs: string;
    FListaIdsIntegracao: string;
    FListaString: TStringList;
    function pesquisar(IDIntegracao: String): TStringList;

    public
      FBoletoX: TspdBoletoX;
      property IDs : string read FIDs write FIDs;
      property ListaString : TStringList read FListaString write FListaString;
      constructor create;override;
      destructor destroy; override;
      function Pesquisar_Duplicatas(ID_Duplicata : Integer) : TFDQuery;
      function EnviarEmail(ID_Duplicata : Integer) : TStringList;
  end;

implementation

uses
  System.SysUtils, Data.DB, Vcl.StdCtrls;

{ TBoletoTecnoSpeed }

constructor TBoletoTecnoSpeed.create;
begin
  inherited;

end;

destructor TBoletoTecnoSpeed.destroy;
begin

  inherited;
end;

function TBoletoTecnoSpeed.EnviarEmail(ID_Duplicata: Integer): TStringList;
var
  EnviarEmailTecnoSpeed : TEnviarEmailTecnoSpeed;
  _EnviarEmailLoteResposta : IspdRetEnvioEmailLote;
  vLista : TStringList;
begin
  Pesquisar_Duplicatas(ID_Duplicata);
  EnviarEmailTecnoSpeed := TEnviarEmailTecnoSpeed.create;
  vLista := TStringList.Create;
  qConsulta.First;
  while not qConsulta.Eof do
  begin
    try
      with EnviarEmailTecnoSpeed do
      begin
        IDIntegracao := qConsulta.FieldByName('ID_INTEGRACAO').AsString;
        EmailNomeRemetente := SQLLocate('FILIAL','ID','NOME',qConsulta.FieldByName('FILIAL').AsString);
        EmailRemetente := SQLLocate('FILIAL','ID','EMAIL_NFE',qConsulta.FieldByName('FILIAL').AsString);
        EmailAssunto := 'Boleto para pagamento nº: ' + qConsulta.FieldByName('NUMDUPLICATA').AsString + '/' + qConsulta.FieldByName('PARCELA').AsString;
        EmailMensagem := 'Prezado cliente, segue link para pagamento de seu boleto ${linkBoleto}';
        EmailDestinatario := qConsulta.FieldByName('EMAIL_PGTO').AsString;
        EmailAnexar := True;
        EmailMensagem := 'Prezado cliente, segue boleto em anexo nº: ' +  qConsulta.FieldByName('NUMDUPLICATA').AsString;
  //          case TEnumTipoEnvioAnexo(rdgAnexar.ItemIndex) of
  //            tpAnexo :
  //              begin
  //                EmailAnexar := True;
  //                EmailMensagem := 'Prezado cliente, segue boleto em anexo nº: ' +  fDMCadDuplicata.qryConsulta_DuplicataNUMDUPLICATA.AsString;
  //              end;
  //            tpLink  :
  //             begin
  //              EmailMensagem := 'Prezado cliente, segue link para pagamento de seu boleto ${linkBoleto}';
  //             end;
  //          end;
  //          TipoImpressao := IntToStr(integer(TpImpressao));
        vLista :=  MontaEmailBoleto;
  //          for n := 0 to vLista.Count - 1 do
  //          begin
  //            vWide[n] := vLista[n];
  //          end;
        _EnviarEmailLoteResposta := FBoletoX.EnviarEmailLote(vLista.Text);
      end;
      qConsulta.Next;
    finally
      EnviarEmailTecnoSpeed.Free;
    end;
  end;
end;

function TBoletoTecnoSpeed.pesquisar(IDIntegracao: String): TStringList;
begin

end;

function TBoletoTecnoSpeed.Pesquisar_Duplicatas(
  ID_Duplicata: Integer): TFDQuery;
var
  vSQL : String;
begin
  qConsulta.Close;
  qConsulta.SQL.Clear;
  vSQL := 'select DUP.ID, DUP.TIPO_ES, DUP.FILIAL, DUP.ID_NOTA, DUP.PARCELA, DUP.NUMDUPLICATA, DUP.NUMNOTA, DUP.SERIE, DUP. DTEMISSAO, ';
  VSQL := VSQL + 'DUP.DTVENCIMENTO, DUP.VLR_PARCELA, DUP.VLR_RESTANTE, DUP.VLR_PAGO, DUP.VLR_DESCONTO, DUP.ID_PESSOA, ';
  VSQL := VSQL + 'DUP.ID_TIPOCOBRANCA, DUP.DTULTPAGAMENTO, DUP.ID_CONTA_BOLETO, DUP.ID_INTEGRACAO, CLI.NOME NOME_CLIENTE, ';
  VSQL := VSQL + 'CT.NOME NOME_CONTA, CART.CODIGO COD_CARTEIRA, CART.CODIGO_IMP COD_CARTEIRA_IMP, CART.NOME NOME_CARTEIRA, ';
  VSQL := VSQL + 'CART.GERAR_NOSSONUMERO, CLI.PESSOA, CLI.CNPJ_CPF, CLI.ENDERECO, CLI.NUM_END, CLI.CEP, CLI.BAIRRO, CLI.CIDADE, ';
  VSQL := VSQL + 'CLI.UF, CLI.PESSOA_PGTO, CLI.ENDERECO_PGTO, CLI.NUM_END_PGTO, CLI.CEP_PGTO, CLI.BAIRRO_PGTO, CLI.CIDADE_PGTO, ';
  VSQL := VSQL + 'CLI.UF_PGTO, CLI.CNPJ_CPG_PGTO, CLI.EMAIL_PGTO, CLI.COMPLEMENTO_END, CLI.COMPLEMENTO_END_PGTO,DUP.ID_CONTA, ';
  VSQL := VSQL + 'CART.GERAR_REMESSA, CLI.ID_GRUPO, GP.NOME NOME_GRUPO, CLI.ID_CARTEIRA ID_CARTEIRA_CLIENTE, ';
  VSQL := VSQL + 'CLI.COBRAR_TAXA_BANCO TAXA_BANCO, NF.TIPO_REG, NF.NFECHAVEACESSO, NS.COD_AUTENCIDADE_RET,DUP.ID_IMPRESSAO, ';
  VSQL := VSQL + 'DCOB.ID_OCORRENCIA ID_OCORRENCIA_COB from DUPLICATA DUP ';
  VSQL := VSQL + 'inner join PESSOA CLI on (DUP.ID_PESSOA = CLI.CODIGO) ';
  VSQL := VSQL + 'left join CONTAS CT on (DUP.ID_CONTA_BOLETO = CT.ID) ';
  VSQL := VSQL + 'left join COB_CARTEIRA CART on (DUP.ID_CARTEIRA = CART.ID) ';
  VSQL := VSQL + 'left join TIPOCOBRANCA TC on (DUP.ID_TIPOCOBRANCA = TC.ID) ';
  VSQL := VSQL + 'left join NOTAFISCAL NF on DUP.ID_NOTA = NF.ID ';
  VSQL := VSQL + 'left join GRUPO_PESSOA GP on CLI.ID_GRUPO = GP.ID ';
  VSQL := VSQL + 'left join NOTASERVICO NS on DUP.ID_NOTA_SERVICO = NS.ID ';
  VSQL := VSQL + 'left join DUPLICATA_COB DCOB on DUP.ID = DCOB.ID and DCOB.DTREMESSA is null ';
  VSQL := VSQL + 'WHERE DUP.ID_INTEGRACAO IN (' + IntToStr(ID_Duplicata) + ')';
  qConsulta.SQL.Add(vSQL);
  qConsulta.Open();
end;

end.
