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
  uDMCadDuplicata, JvExStdCtrls, JvCombobox, Vcl.OleCtrls, BoletoX_TLB,
  uConfigTecnoSpeed, Vcl.Menus;

type
  TEnumTitulos = (tpNaoEnviados, tpEnviados, tpTodos);
  TEnumTipoImpressao = (tpNormal = 0, tpCarneDuplo = 1, tpCarneTriplo = 2, tpDuploRetrato = 3,
                        tpMarcaDagua = 4, tpPersonalizado = 99);

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
    btnOpcoes: TSMButton;
    spdBoletoX1: TspdBoletoX;
    ts_Mensagem: TTabSheet;
    mmResposta: TMemo;
    mmEnvio: TMemo;
    SMButton1: TSMButton;
    popOpcoes: TPopupMenu;
    btnEnviar: TMenuItem;
    btnConsulta: TMenuItem;
    btnImpressao: TMenuItem;
    function ConverteErroClasse(aErroClasse: TErroClasse): string;
    procedure FormShow(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure comboOcorrenciaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure comboBancoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SMDBGrid1GetCellParams(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor; Highlight: Boolean);
    procedure btnEnviarClick(Sender: TObject);
    procedure btnConsultaClick(Sender: TObject);
    procedure btnImpressaoClick(Sender: TObject);
  private
    { Private declarations }
    fDMCadDuplicata: TDMCadDuplicata;
    procedure prc_Consulta_Duplicata;
    procedure CarregaConfig(Filial: Integer; Tipo: Integer);
    procedure DoOnBoletoException(ASender: TObject; const aExceptionMessage: WideString);
    function fnc_Verificar: Boolean;
    function fnc_Montar_Envio: TStringList;
  public
    FBoletoX: TspdBoletoX;
    { Public declarations }
  end;

var
  frmConsDuplicata: TfrmConsDuplicata;

implementation

uses
  uUtilPadrao;

{$R *.dfm}

procedure TfrmConsDuplicata.btnConsultaClick(Sender: TObject);
var
  _ConsultarList: IspdRetConsultarLista;
  _ConsultarItem: IspdRetConsultarTituloItem;
  i, j,k ,l : Integer;
begin
  inherited;
  if fDMCadDuplicata.qryConsulta_DuplicataID_INTEGRACAO.AsString = EmptyStr then
  begin
    ShowMessage('Título ainda não enviado!');
    Exit;
  end;
  CarregaConfig(comboFilial.KeyValue, 1);
  mmResposta.Lines.Clear;
  mmResposta.Refresh;
  mmResposta.Lines.BeginUpdate;

  try
    _ConsultarList := FBoletoX.Consultar(fDMCadDuplicata.qryConsulta_DuplicataID_INTEGRACAO.AsString);

    mmResposta.Lines.Add('.:: Consultar Título ::.');
    mmResposta.Lines.Add('Mensagem: ' + _ConsultarList.Mensagem);
    mmResposta.Lines.Add('Status: ' + _ConsultarList.Status);

    if _ConsultarList.ErroConexao <> '' then
      mmResposta.Lines.Add('Erro Conexão: ' + _ConsultarList.ErroConexao);

    mmResposta.Lines.Add('');

    while _ConsultarList.Count <> 0 do
    begin
      for i := 0 to pred(_ConsultarList.Count) do    //o conteúdo de pred é equivalente a (_ConsultarList.Count - 1)
      begin
        _ConsultarItem := _ConsultarList.Item[i];
        mmResposta.Lines.Add('ITEM: ' + IntToStr(i+1));
        mmResposta.Lines.Add('  IdIntegracao: ' + _ConsultarItem.IdIntegracao);
        mmResposta.Lines.Add('  Situacao: ' + _ConsultarItem.Situacao);
        mmResposta.Lines.Add('  Motivo: ' + _ConsultarItem.Motivo);
        mmResposta.Lines.Add('');
        mmResposta.Lines.Add('CEDENTE:');
        mmResposta.Lines.Add('  Agencia: ' + _ConsultarItem.CedenteAgencia);
        mmResposta.Lines.Add('  AgenciaDV: ' + _ConsultarItem.CedenteAgenciaDV);
        mmResposta.Lines.Add('  Código Banco: ' + _ConsultarItem.CedenteCodigoBanco);
        mmResposta.Lines.Add('  Carteira: ' + _ConsultarItem.CedenteCarteira);
        mmResposta.Lines.Add('  Conta: ' + _ConsultarItem.CedenteConta);
        mmResposta.Lines.Add('  DV da conta: ' + _ConsultarItem.CedenteContaNumeroDV);
        mmResposta.Lines.Add('  Numero Convênio: ' + _ConsultarItem.CedenteNumeroConvenio);
        mmResposta.Lines.Add('');
        mmResposta.Lines.Add('SACADO:');
        mmResposta.Lines.Add('  CPFCNPJ: ' + _ConsultarItem.SacadoCPFCNPJ);
        mmResposta.Lines.Add('  Nome: ' + _ConsultarItem.SacadoNome);
        mmResposta.Lines.Add('  Telefone: ' + _ConsultarItem.SacadoTelefone);
        mmResposta.Lines.Add('  Celular: ' + _ConsultarItem.SacadoCelular);
        mmResposta.Lines.Add('  Email: ' + _ConsultarItem.SacadoEmail);
        mmResposta.Lines.Add('  Endereço Número: ' + _ConsultarItem.SacadoEnderecoNumero);
        mmResposta.Lines.Add('  Endereço Bairro: ' + _ConsultarItem.SacadoEnderecoBairro);
        mmResposta.Lines.Add('  Endereço CEP: ' + _ConsultarItem.SacadoEnderecoCEP);
        mmResposta.Lines.Add('  Endereço Cidade: ' + _ConsultarItem.SacadoEnderecoCidade);
        mmResposta.Lines.Add('  Endereço Complemento: ' + _ConsultarItem.SacadoEnderecoComplemento);
        mmResposta.Lines.Add('  Endereço Logradouro: ' + _ConsultarItem.SacadoEnderecoLogradouro);
        mmResposta.Lines.Add('  Endereço País: ' + _ConsultarItem.SacadoEnderecoPais);
        mmResposta.Lines.Add('  Endereço UF: ' + _ConsultarItem.SacadoEnderecoUF);
        mmResposta.Lines.Add('  Sacador Avalista: ' + _ConsultarItem.TituloSacadorAvalista);
        mmResposta.Lines.Add('  Sacador Avalista Inscricao: ' + _ConsultarItem.TituloInscricaoSacadorAvalista);
        mmResposta.Lines.Add('  Endereço Sacador Avalista: ' + _ConsultarItem.TituloSacadorAvalistaEndereco);
        mmResposta.Lines.Add('  Cidade Sacador Avalista: ' + _ConsultarItem.TituloSacadorAvalistaCidade);
        mmResposta.Lines.Add('  CEP Sacador Avalista: ' + _ConsultarItem.TituloSacadorAvalistaCEP);
        mmResposta.Lines.Add('  UF Sacador Avalista: ' + _ConsultarItem.TituloSacadorAvalistaUF);
        mmResposta.Lines.Add('');
        mmResposta.Lines.Add('TÍTULO:');
        mmResposta.Lines.Add('  Nosso Número: ' + _ConsultarItem.TituloNossoNumero);
        mmResposta.Lines.Add('  Número Documento: ' + _ConsultarItem.TituloNumeroDocumento);
        mmResposta.Lines.Add('  Nosso Número Impressão: ' + _ConsultarItem.TituloNossoNumeroImpressao);
        mmResposta.Lines.Add('  Origem Documento: ' + _ConsultarItem.TituloOrigemDocumento);
        mmResposta.Lines.Add('  Linha Digitável: ' + _ConsultarItem.TituloLinhaDigitavel);
        mmResposta.Lines.Add('  Código de Barras: ' + _ConsultarItem.TituloCodigoBarras);
        mmResposta.Lines.Add('  Código Emissão Bloqueto: ' + _ConsultarItem.TituloCodEmissaoBloqueto);
        mmResposta.Lines.Add('  Titulo Aceite: ' + _ConsultarItem.TituloAceite);
        mmResposta.Lines.Add('  Avalista: ' + _ConsultarItem.TituloInscricaoSacadorAvalista);
        mmResposta.Lines.Add('  Doc Espécie: ' + _ConsultarItem.TituloDocEspecie);
        mmResposta.Lines.Add('  Postagem: ' + _ConsultarItem.TituloPostagemBoleto);

        mmResposta.Lines.Add('  Código para baixa ou devolução: ' + _ConsultarItem.TituloCodBaixaDevolucao);
        mmResposta.Lines.Add('  Prazo para baixa ou devolução: ' + _ConsultarItem.TituloPrazoBaixa);
        mmResposta.Lines.Add('  Data Emissão: ' + _ConsultarItem.TituloDataEmissao);
        mmResposta.Lines.Add('  Forçar Fator Vencimento: ' + BoolToStr(_ConsultarItem.TituloForcarFatorVencimento, True));
        mmResposta.Lines.Add('  Data Vencimento: ' + _ConsultarItem.TituloDataVencimento);
        mmResposta.Lines.Add('  Código de Desconto: ' + _ConsultarItem.TituloCodDesconto);
        mmResposta.Lines.Add('  Data Desconto: ' + _ConsultarItem.TituloDataDesconto);
        mmResposta.Lines.Add('  Valor Desconto: ' + FloatToStr(_ConsultarItem.TituloValorDescontoTaxa));
        mmResposta.Lines.Add('  Código de Desconto2: ' + _ConsultarItem.TituloCodDesconto2);
        mmResposta.Lines.Add('  Outras Deducoes: ' + _ConsultarItem.TituloOutrasDeducoes);
        mmResposta.Lines.Add('  Data Desconto: ' + _ConsultarItem.TituloDataDesconto2);
        mmResposta.Lines.Add('  Valor Desconto: ' + FloatToStr(_ConsultarItem.TituloValorDescontoTaxa2));
        mmResposta.Lines.Add('  Código de Juros: ' + _ConsultarItem.TituloCodigoJuros);
        mmResposta.Lines.Add('  Data Juros: ' + _ConsultarItem.TituloDataJuros);
        mmResposta.Lines.Add('  Valor Juros: ' + FloatToStr(_ConsultarItem.TituloValorJuros));
        mmResposta.Lines.Add('  Prazo Protesto: ' + _ConsultarItem.TituloPrazoProtesto);
        mmResposta.Lines.Add('  Instrucoes: ' + _ConsultarItem.TituloInstrucoes);
        mmResposta.Lines.Add('  Mensagem 1: ' + _ConsultarItem.TituloMensagem01);
        mmResposta.Lines.Add('  Mensagem 2: ' + _ConsultarItem.TituloMensagem02);
        mmResposta.Lines.Add('  Mensagem 3: ' + _ConsultarItem.TituloMensagem03);
        mmResposta.Lines.Add('  TítuloInstrucao 1: ' + _ConsultarItem.TituloInstrucao1);
        mmResposta.Lines.Add('  TítuloInstrucao 2: ' + _ConsultarItem.TituloInstrucao2);
        mmResposta.Lines.Add('  Informacoes Adicionais: ' + _ConsultarItem.TituloInformacoesAdicionais);
        mmResposta.Lines.Add('  Local Pagamento: ' + _ConsultarItem.TituloLocalPagamento);
        mmResposta.Lines.Add('  Parcela: ' + _ConsultarItem.TituloParcela);
        mmResposta.Lines.Add('  Variacao Carteira: ' + _ConsultarItem.TituloVariacaoCarteira);
        mmResposta.Lines.Add('  Categoria: ' + _ConsultarItem.TituloCategoria);
        mmResposta.Lines.Add('  Modalidade: ' + _ConsultarItem.TituloModalidade);
        mmResposta.Lines.Add('  Cip: ' + _ConsultarItem.TituloCip);
        mmResposta.Lines.Add('  Ios "utilizado apenas pelo Santander": ' + _ConsultarItem.TituloIos);
        mmResposta.Lines.Add('  Cod Cliente "exclusivo para os bancos HSBC e Safra": ' + _ConsultarItem.TituloCodCliente);
        mmResposta.Lines.Add('  Valor: ' + FloatToStr(_ConsultarItem.TituloValor));
        mmResposta.Lines.Add('  Pagamento Minimo: ' + FloatToStr(_ConsultarItem.TituloPagamentoMinimo));
        mmResposta.Lines.Add('  Data Crédito: ' + _ConsultarItem.PagamentoDataCredito);
        mmResposta.Lines.Add('  Valor Cobrado: ' + FloatToStr(_ConsultarItem.TituloValorCobrado));
        mmResposta.Lines.Add('  Título Pago: ' + BoolToStr(_ConsultarItem.PagamentoRealizado));
        mmResposta.Lines.Add('  Valor Crédito: ' + FloatToStr(_ConsultarItem.PagamentoValorCredito));
        mmResposta.Lines.Add('  Valor Outros Acréscimos: ' + FloatToStr(_ConsultarItem.TituloValorOutrosAcrescimos));
        mmResposta.Lines.Add('  Valor Pago: ' + FloatToStr(_ConsultarItem.PagamentoValorPago));
        mmResposta.Lines.Add('  Valor Taxa Cobrança: ' + FloatToStr(_ConsultarItem.PagamentoValorTaxaCobranca));
        mmResposta.Lines.Add('  Valor Abatimento: ' + FloatToStr(_ConsultarItem.TituloValorAbatimento));
        mmResposta.Lines.Add('  Valor Outras Despesas: ' + FloatToStr(_ConsultarItem.PagamentoValorOutrasDespesas));
        mmResposta.Lines.Add('  Valor IOF: ' + FloatToStr(_ConsultarItem.PagamentoValorIOF));
        mmResposta.Lines.Add('  Código Multa: ' + _ConsultarItem.TituloCodigoMulta);
        mmResposta.Lines.Add('  Valor Multa: ' + FloatToStr(_ConsultarItem.TituloValorMulta));
        mmResposta.Lines.Add('  Valor Multa Taxa: ' + FloatToStr(_ConsultarItem.TituloValorMultaTaxa));
        mmResposta.Lines.Add('  Data Multa: ' + _ConsultarItem.PagamentoData);
        mmResposta.Lines.Add('  Data Pagamento: ' + _ConsultarItem.PagamentoData);
        mmResposta.Lines.Add('  Valor Outros Créditos: ' + FloatToStr(_ConsultarItem.PagamentoValorOutrosCreditos));
        mmResposta.Lines.Add('  Pagamento Valor Desconto: ' + FloatToStr(_ConsultarItem.PagamentoValorDesconto));
        mmResposta.Lines.Add('  Pagamento Valor Acréscimos: ' + FloatToStr(_ConsultarItem.PagamentoValorAcrescimos));
        mmResposta.Lines.Add('  Pagamento Valor Abatimento: ' + FloatToStr(_ConsultarItem.PagamentoValorAbatimento));
        mmResposta.Lines.Add('  Impressão Visualizada: ' + BoolToStr(_ConsultarItem.ImpressaoVisualizada, True));   //Converte o retorno para "False" ou "True"
        mmResposta.Lines.Add('  Impressão Visualizada Data: ' + (_ConsultarItem.TituloDataImpressaoVisualizada));
        mmResposta.Lines.Add('');

        { ---> Método removido, sendo substituído pelo _ConsultarItem.CountTituloMovimentos
               que está exemplificado logo abaixo do trecho comentado.
        if _ConsultarItem.TituloOcorrencias <> nil then
        begin
          mmoResposta.Lines.Add('  LISTA DE OCORRÊNCIAS:');
          for j := 0 to _ConsultarItem.TituloOcorrencias.Count - 1 do
          begin
            mmoResposta.Lines.Add('    Código: ' + IntToStr(j+1) + ': ' + _ConsultarItem.TituloOcorrencias.Item[j].Codigo);
            mmoResposta.Lines.Add('    Mensagem: ' + IntToStr(j+1) + ': ' + _ConsultarItem.TituloOcorrencias.Item[j].Mensagem);
          end;
          mmoResposta.Lines.Add('------------');
        end;
        }


        for k := 0 to _ConsultarItem.CountTituloMovimentos -1 do
        begin
           mmResposta.Lines.Add('  MOVIMENTOS:');
           mmResposta.Lines.Add('  Movimento Código: '  + _ConsultarItem.TituloMovimentos[k].Codigo);
           mmResposta.Lines.Add('  Movimento Mensagem: '  + _ConsultarItem.TituloMovimentos[k].Mensagem);
           mmResposta.Lines.Add('  Movimento Data: '  + _ConsultarItem.TituloMovimentos[k].Data);
           mmResposta.Lines.Add('  Movimento Taxa: '  + FloatToStr(_ConsultarItem.TituloMovimentos[k].Taxa));
           for l := 0 to _ConsultarItem.TituloMovimentos[k].CountOcorrencias -1 do
            begin
              mmResposta.Lines.Add('  OCORRÊNCIAS:');
              mmResposta.Lines.Add('     Ocorrências Código: '  + _ConsultarItem.TituloMovimentos[k].Ocorrencias[l].Codigo);
              mmResposta.Lines.Add('     Ocorrências Mensagem: '  + _ConsultarItem.TituloMovimentos[k].Ocorrencias[l].Mensagem);
            end;
        mmResposta.Lines.Add('');
        end;

      end;

      _ConsultarList.PaginaSeguinte;           //Utilize este parâmetro quando a consulta for feita com mais de 1000 idIntegracao por vez. O While fará a consulta de 20 em 20 idIntegracao, e o "PaginaSeguinte" repete a consulta enquanto houverem páginas a serem consultadas.

    end;

  finally
    mmResposta.Lines.EndUpdate;
  end;

end;

procedure TfrmConsDuplicata.btnConsultarClick(Sender: TObject);
begin
  inherited;
  if comboFilial.KeyValue = 0 then
  begin
    MessageDlg('Informe a Filial', mtInformation, [mbYes], 0);
    comboFilial.SetFocus;
    Exit;
  end;
  if comboOcorrencia.KeyValue = 0 then
  begin
    MessageDlg('Informe a Ocorrência', mtInformation, [mbYes], 0);
    comboOcorrencia.SetFocus;
    Exit;
  end;
  prc_Consulta_Duplicata;
end;

procedure TfrmConsDuplicata.btnEnviarClick(Sender: TObject);
var
  _BoletoList: IspdRetIncluirLista;
  i: Integer;
  listaIdsIntegracao: string;
  vLista : TStringList;
begin
  inherited;
  if not fnc_Verificar then
    Exit;
  CarregaConfig(comboFilial.KeyValue, 1);

  vLista := TStringList.Create();
  mmResposta.Lines.Clear;
  mmResposta.Refresh;
  mmResposta.Lines.BeginUpdate;
  fDMCadDuplicata.qryConsulta_Duplicata.First;
  while not fDMCadDuplicata.qryConsulta_Duplicata.Eof do
  begin
    if (SMDBGrid1.SelectedRows.CurrentRowSelected) and (fDMCadDuplicata.qryConsulta_DuplicataDTVENCIMENTO.AsDateTime > Date) then
    begin
      vLista.Clear;
      vLista := fnc_Montar_Envio;
      for i := 0 to vLista.Count - 1 do
      begin
        mmEnvio.Lines.Add(vLista[i]);
      end;
    end;
    fDMCadDuplicata.qryConsulta_Duplicata.Next;
  end;

  try
    _BoletoList := FBoletoX.Incluir(mmEnvio.Lines.Text);

    mmResposta.Lines.Clear;
    mmResposta.Lines.Add('.:: Incluir Boleto ::.');
    mmResposta.Lines.Add('Mensgem: ' + _BoletoList.Mensagem);
    mmResposta.Lines.Add('Status: ' + _BoletoList.Status);
    mmResposta.Lines.Add('');

    for i := 0 to _BoletoList.Count - 1 do
    begin
      mmResposta.Lines.Add('Item: ' + IntToStr(i + 1));
      mmResposta.Lines.Add('  NumeroDocumento: ' + _BoletoList[i].NumeroDocumento);
      mmResposta.Lines.Add('  IdIntegracao: ' + _BoletoList[i].IdIntegracao);
      mmResposta.Lines.Add('  Situacao: ' + _BoletoList[i].Situacao);
      mmResposta.Lines.Add('  NossoNumero: ' + _BoletoList[i].NossoNumero);
      mmResposta.Lines.Add('  Banco: ' + _BoletoList[i].Banco);
      mmResposta.Lines.Add('  Conta: ' + _BoletoList[i].Conta);
      mmResposta.Lines.Add('  Convenio: ' + _BoletoList[i].Convenio);
      mmResposta.Lines.Add('  Erro: ' + _BoletoList[i].Erro);
      mmResposta.Lines.Add('  ErroClasse: ' + ConverteErroClasse(_BoletoList[i].ErroClasse));
      mmResposta.Lines.Add('');
      fDMCadDuplicata.prc_Abrir_Duplicata(StrToInt(_BoletoList[i].NumeroDocumento));
      fDMCadDuplicata.prc_Gravar_Duplicata(StrToInt(_BoletoList[i].NumeroDocumento),_BoletoList[i].IdIntegracao);

      if i = 0 then                                       //este if identifica se foi feito o envio de 1 boleto por tx2 ou de um lote de boletos, para alimentar os campos que recebem os idIntegracao
        listaIdsIntegracao := _BoletoList[i].IdIntegracao
      else
        listaIdsIntegracao := _BoletoList[i].IdIntegracao + ',' + listaIdsIntegracao;

    end;

    mmResposta.SelStart := 1;
    mmResposta.SelLength := 1;

  finally
    mmResposta.Lines.EndUpdate;
    pg_Principal.ActivePage := ts_Mensagem;
      //mmoTX2.Lines.Clear;
  end;

end;

procedure TfrmConsDuplicata.btnImpressaoClick(Sender: TObject);
var
  TipoImpressao : TEnumTipoImpressao;
  _ImprimirLoteList: IspdRetImprimirLote;
  ProtocoloImpressao : String;
begin
  inherited;
  if fDMCadDuplicata.qryConsulta_DuplicataID_INTEGRACAO.AsString = EmptyStr then
  begin
    ShowMessage('Título ainda não enviado!');
    Exit;
  end;

  TipoImpressao := tpNormal;
  CarregaConfig(comboFilial.KeyValue, 1);
  mmResposta.Lines.Clear;
  mmResposta.Refresh;
  mmResposta.Lines.BeginUpdate;
  _ImprimirLoteList := FBoletoX.ImprimirLote(fDMCadDuplicata.qryConsulta_DuplicataID_INTEGRACAO.AsString,  IntToStr(integer(TipoImpressao)));
  if _ImprimirLoteList.Protocolo <> EmptyStr then
    ProtocoloImpressao := _ImprimirLoteList.Protocolo;
  Sleep(1000);



end;

procedure TfrmConsDuplicata.CarregaConfig(Filial, Tipo: Integer);
var
  vConfigTecnoSpeed: TConfigTecnoSpeed;
begin
  vConfigTecnoSpeed := TConfigTecnoSpeed.Create(Filial, Tipo);
  FBoletoX.Config.URL := vConfigTecnoSpeed.URL;
  FBoletoX.ConfigurarSoftwareHouse(vConfigTecnoSpeed.CNPJSH, vConfigTecnoSpeed.Token);
  FBoletoX.Config.CedenteCpfCnpj := vConfigTecnoSpeed.CNPJCedente;
  FBoletoX.OnException := DoOnBoletoException;
  FBoletoX.Config.SalvarLogs := true;  //Salva os logs na pasta em que se encontra o exe do projeto
end;

procedure TfrmConsDuplicata.comboBancoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_ESCAPE) then
    comboBanco.KeyValue := '0';
end;

procedure TfrmConsDuplicata.comboOcorrenciaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_ESCAPE) then
    comboOcorrencia.KeyValue := '0';
end;

function TfrmConsDuplicata.ConverteErroClasse(aErroClasse: TErroClasse): string;
begin
  case aErroClasse of
    ecValidacao:
      Result := 'VALIDACAO';
    ecAutenticacao:
      Result := 'AUTENTICACAO';
    ecNaoEncontrado:
      Result := 'NAOENCONTRADO';
    ecInterno:
      Result := 'INTERNO';
    ecParametroTamanhoExcedido:
      Result := 'PARAMETROTAMANHOEXCEDIDO';
    ecServidorIndisponivel:
      Result := 'SERVIDORINDISPONIVEL';
    ecNaoTratado:
      Result := 'NAOTRATADO';
    ecAcessoNegado:
      Result := 'ACESSONEGADO';
    ecNenhum:
      Result := 'NENHUM';
  end;
end;

procedure TfrmConsDuplicata.DoOnBoletoException(ASender: TObject; const aExceptionMessage: WideString);
begin
  MessageBox(0, PChar(aExceptionMessage), 'Exceção do BoletoX', MB_ICONERROR or MB_OK);
end;

function TfrmConsDuplicata.fnc_Montar_Envio: TStringList;
var
  vInstrucao1: string;
  vInstrucao2: string;
begin
  vInstrucao1 := '';
  vInstrucao2 := '';
  Result := TStringList.Create;
  Result.Add('INCLUIRBOLETO');
  with fDMCadDuplicata do
  begin
    // Inicio Cedente
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('select C.NUMCONTA, C.DIG_CONTA, B.CODIGO CODIGO_BANCO, ');
    qryConsulta.SQL.Add('C.COD_CEDENTE CONVENIO_NUMERO, ESP.CODIGO ESPECIE, ');
    qryConsulta.SQL.Add('INS1.NOME INSTRUCAO1, INS2.NOME INSTRUCAO2 ');
    qryConsulta.SQL.Add('from CONTAS C ');
    qryConsulta.SQL.Add('inner join BANCO B on B.ID = C.ID_BANCO ');
    qryConsulta.SQL.Add('left join COB_TIPO_CADASTRO ESP on C.ID_ESPECIE = ESP.ID ');
    qryConsulta.SQL.Add('left join COB_TIPO_CADASTRO INS1 on C.ID_INSTRUCAO1 = INS1.ID ');
    qryConsulta.SQL.Add('left join COB_TIPO_CADASTRO INS2 on C.ID_INSTRUCAO2 = INS2.ID ');
    qryConsulta.SQL.Add('where C.ID = :ID');
    qryConsulta.ParamByName('ID').AsInteger := qryConsulta_DuplicataID_CONTA_BOLETO.AsInteger;
    qryConsulta.Open();
    if not (qryConsulta.IsEmpty) then
    begin
      Result.Add('CedenteContaNumero=' + qryConsulta.FieldByName('NUMCONTA').Value);
      Result.Add('CedenteContaNumeroDV=' + qryConsulta.FieldByName('DIG_CONTA').Value);
      Result.Add('CedenteConvenioNumero=' + qryConsulta.FieldByName('CONVENIO_NUMERO').Value);
      Result.Add('CedenteContaCodigoBanco=' + qryConsulta.FieldByName('CODIGO_BANCO').Value);
      Result.Add('TituloDocEspecie=' + qryConsulta.FieldByName('ESPECIE').Value);
      vInstrucao1 := qryConsulta.FieldByName('INSTRUCAO1').AsString;
      vInstrucao2 := qryConsulta.FieldByName('INSTRUCAO2').AsString;
    end;
    // Fim Cedente
    // Inicio Sacado
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('select P.EMAIL_PGTO, P.NOME NOME_SACADO, P.CNPJ_CPF, P.CEP, P.DDDCELULAR, P.CELULAR, P.NUM_END, ');
    qryConsulta.SQL.Add('P.BAIRRO, P.CIDADE, P.ENDERECO, PA.NOME NOME_PAIS, P.UF, P.DDDFONE1, P.TELEFONE1 FROM PESSOA P ');
    qryConsulta.SQL.Add('left join PAIS PA on P.ID_PAIS = PA.ID ');
    qryConsulta.SQL.Add('where ID = :ID');
    qryConsulta.ParamByName('ID').AsInteger := qryConsulta_DuplicataID_PESSOA.AsInteger;
    qryConsulta.Open();
    if not (qryConsulta.IsEmpty) then
    begin
      Result.Add('SacadoEmail=' + qryConsulta.FieldByName('EMAIL_PGTO').Value);
      Result.Add('SacadoNome=' + qryConsulta.FieldByName('NOME_SACADO').Value);
      Result.Add('SacadoCPFCNPJ=' + qryConsulta.FieldByName('CNPJ_CPF').Value);
      Result.Add('SacadoEnderecoCEP=' + qryConsulta.FieldByName('CEP').Value);
      Result.Add('SacadoEnderecoNumero=' + qryConsulta.FieldByName('NUM_END').Value);
      Result.Add('SacadoEnderecoBairro=' + qryConsulta.FieldByName('BAIRRO').Value);
      Result.Add('SacadoEnderecoCidade=' + qryConsulta.FieldByName('CIDADE').Value);
      Result.Add('SacadoEnderecoLogradouro=' + qryConsulta.FieldByName('ENDERECO').Value);
      Result.Add('SacadoEnderecoPais=' + qryConsulta.FieldByName('NOME_PAIS').Value);
      Result.Add('SacadoEnderecoUF=' + qryConsulta.FieldByName('UF').Value);
      Result.Add('SacadoTelefone=' + qryConsulta.FieldByName('TELEFONE1').Value);
    end;
    //Fim Sacado
    // Inicio Título
    Result.Add('TituloNossoNumero=' + IntToStr(qryConsulta_DuplicataID.AsInteger));
    Result.Add('TituloNumeroDocumento=' + IntToStr(qryConsulta_DuplicataID.AsInteger));
    Result.Add('TituloDataVencimento=' + DateToStr(qryConsulta_DuplicataDTVENCIMENTO.AsDateTime));
    Result.Add('TituloDataEmissao=' + DateToStr(qryConsulta_DuplicataDTEMISSAO.AsDateTime));
    Result.Add('TituloValor=' + FormatFloat('0.00',qryConsulta_DuplicataVLR_PARCELA.AsFloat));
    Result.Add('TituloMensagem01=' + SQLLocate('CONTAS', 'ID', 'MENSAGEM_FIXA', qryConsulta_DuplicataID_CONTA.AsString));
    Result.Add('TituloMensagem02=' + '');
    Result.Add('TituloMensagem03=' + '');
    Result.Add('TituloInformacoesAdicionais=' + '');
    Result.Add('TituloInstrucoes=' + vInstrucao1);
    Result.Add('TituloInstrucoes=' + vInstrucao2);
    // Fim Título
  end;
  Result.Add('SALVARBOLETO');

end;

function TfrmConsDuplicata.fnc_Verificar: Boolean;
var
  vMensagem: string;
begin
  Result := True;
  vMensagem := '';
  if comboBanco.KeyValue = 0 then
    vMensagem := vMensagem + #13 + 'Banco não informado!';
  if comboFilial.KeyValue = 0 then
    vMensagem := vMensagem + #13 + 'Filial não informada!';
  if vMensagem = '' then
  begin
    fDMCadDuplicata.qryContas.Locate('ID', comboBanco.KeyValue, [loCaseInsensitive]);
    if (comboFilial.KeyValue > 0) and (fDMCadDuplicata.qryContasFILIAL.AsInteger <> comboFilial.KeyValue) then
      vMensagem := vMensagem + #13 + 'Banco selecionado não pertence a filial!';
  end;
  if vMensagem <> '' then
  begin
    Result := False;
    MessageDlg(vMensagem, mtWarning, [mbOK], 0);
  end;
end;

procedure TfrmConsDuplicata.FormCreate(Sender: TObject);
begin
  inherited;
  FBoletoX := TspdBoletoX.Create(nil);
  fDMCadDuplicata := TDMCadDuplicata.Create(Self);
  dsConsulta.DataSet := fDMCadDuplicata.qryConsulta_Duplicata;
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
  fDMCadDuplicata.qryConsulta_Duplicata.SQL.Text := fDMCadDuplicata.ctCommandDup;
  fDMCadDuplicata.qryConsulta_Duplicata.Close;
  fDMCadDuplicata.qryConsulta_Duplicata.SQL.Add(' WHERE DUP.TIPO_ES = ' + QuotedStr('E') + ' AND DUP.VLR_RESTANTE > 0');
  if comboFilial.KeyValue > 0 then
    fDMCadDuplicata.qryConsulta_Duplicata.SQL.Add(' AND DUP.FILIAL = ' + IntToStr(comboFilial.KeyValue));
  if edtNumeroDoc.Text <> '' then
    fDMCadDuplicata.qryConsulta_Duplicata.SQL.Add(' AND (DUP.NUMDUPLICATA = ' + QuotedStr(edtNumeroDoc.Text) + ') ');
  if DateInicial.Date > 10 then
    fDMCadDuplicata.qryConsulta_Duplicata.SQL.Add(' AND DUP.DTEMISSAO >= ' + QuotedStr(FormatDateTime('MM/DD/YYYY', DateInicial.Date)));
  if DateFinal.Date > 10 then
    fDMCadDuplicata.qryConsulta_Duplicata.SQL.Add(' AND DUP.DTEMISSAO <= ' + QuotedStr(FormatDateTime('MM/DD/YYYY', DateFinal.Date)));
  if SQLLocate('PARAMETROS_FIN', 'ID', 'TIPO_GERACAO_REM', '1') = '1' then
    fDMCadDuplicata.qryConsulta_Duplicata.SQL.Add(' AND (DUP.ID_CONTA_BOLETO = ' + IntToStr(comboBanco.KeyValue) + ') ')
  else
    fDMCadDuplicata.qryConsulta_Duplicata.SQL.Add(' AND (DUP.ID_CONTA_BOLETO = ' + IntToStr(comboBanco.KeyValue) + ' OR DUP.ID_CONTA_BOLETO IS NULL) ');
  case TEnumTitulos(ComboTitulo.ItemIndex) of
    tpNaoEnviados:
      fDMCadDuplicata.qryConsulta_Duplicata.SQL.Add(' AND ((DUP.NUM_REMESSA = 0) OR (DUP.NUM_REMESSA IS NULL))');
    tpEnviados:
      fDMCadDuplicata.qryConsulta_Duplicata.SQL.Add(' AND (DUP.NUM_REMESSA > 0)');
  end;
  if comboOcorrencia.KeyValue > 0 then
    fDMCadDuplicata.qryConsulta_Duplicata.ParamByName('ID_OCORRENCIA').AsInteger := comboOcorrencia.KeyValue;

  fDMCadDuplicata.qryConsulta_Duplicata.Open();

end;

procedure TfrmConsDuplicata.SMDBGrid1GetCellParams(Sender: TObject;
  Field: TField; AFont: TFont; var Background: TColor; Highlight: Boolean);
begin
  inherited;
  if fDMCadDuplicata.qryConsulta_Duplicata.IsEmpty then
    Exit;
  if (fDMCadDuplicata.qryConsulta_DuplicataID_INTEGRACAO.AsString <> EmptyStr) then
    Background := clGreen;
end;

end.

