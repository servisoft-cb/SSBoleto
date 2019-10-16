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
  uConfigTecnoSpeed, Vcl.Menus, Classe.Nome.Remessa, Classe.Gravar.Historico.Duplicata,
  Classe.Enviar.Email.TecnoSpeed, Classe.Email.Empresa, uConsDetalheTecno;

type
  TEnumTitulos = (tpNaoEnviados, tpEnviados, tpTodos);

  TEnumTipoImpressao = (tpNormal = 0, tpCarneDuplo = 1, tpCarneTriplo = 2, tpDuploRetrato = 3, tpMarcaDagua = 4, tpPersonalizado = 99);

  TImprimir = (opVisualizar, opImprimir);

  TEnumTipoEnvioAnexo = (tpLink, tpAnexo);

type
  TfrmConsDuplicata = class(TfrmConsPadrao)
    edtConsulta: TEdit;
    lblDiversos: TLabel;
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
    popOpcoes: TPopupMenu;
    btnEnviar: TMenuItem;
    btnConsulta: TMenuItem;
    btnImpressao: TMenuItem;
    dlgSalvarPDF: TSaveDialog;
    Shape1: TShape;
    Label2: TLabel;
    Shape2: TShape;
    Label8: TLabel;
    Shape3: TShape;
    Label9: TLabel;
    rdgImpressao: TJvRadioGroup;
    GerarRemessa1: TMenuItem;
    rdgAnexar: TJvRadioGroup;
    EnviarEmail1: TMenuItem;
    function ConverteErroClasse(aErroClasse: TErroClasse): string;
    procedure FormShow(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure comboOcorrenciaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure comboBancoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnEnviarClick(Sender: TObject);
    procedure btnConsultaClick(Sender: TObject);
    procedure btnImpressaoClick(Sender: TObject);
    procedure SMDBGrid1TitleClick(Column: TColumn);
    procedure GerarRemessa1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EnviarEmail1Click(Sender: TObject);
    procedure gridConsultaGetCellParams(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor; Highlight: Boolean);
  private
    { Private declarations }
    CampoConsulta: string;
    fDMCadDuplicata: TDMCadDuplicata;
    ListaIdsIntegracao: string;
    ListaIdsDuplicatas : TStringList;
    function fnc_Montar_IdIntegracao: string;
    function fnc_Montar_Lista: TStringList;
    procedure prc_Consultar_Duplicata;
    procedure prc_Consultar_TecnoSpeed;
    function CarregaConfig(Filial: Integer; Tipo: Integer): Boolean;
    procedure DoOnBoletoException(ASender: TObject; const aExceptionMessage: WideString);
    function fnc_Verificar: Boolean;
    function fnc_Montar_Envio: TStringList;
    procedure prc_Email_TecnoSpeed;
    procedure prc_Montar_IDDuplicatas;
    procedure prc_Gravar_Historico(Historico : String);
    procedure prc_Criar_CampoClient;
    function fnc_Descartar_Boleto(ID_Integracao : String) : Boolean;
  public
    FBoletoX: TspdBoletoX;
    ffrmConsDetalhe : TfrmConsultaDetalheTecno;
    { Public declarations }
  end;

var
  frmConsDuplicata: TfrmConsDuplicata;

implementation

uses
  uUtilPadrao;

{$R *.dfm}

procedure TfrmConsDuplicata.btnConsultaClick(Sender: TObject);
begin
  if fDMCadDuplicata.qryConsulta_DuplicataID_INTEGRACAO.AsString = EmptyStr then
  begin
    Application.MessageBox('Título ainda não enviado!', 'ATENÇÃO', MB_OK + MB_ICONWARNING);
    Exit;
  end;
  prc_Consultar_TecnoSpeed;
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
  mmResposta.Lines.Clear;
  mmEnvio.Lines.Clear;
  prc_Consultar_Duplicata;
end;

procedure TfrmConsDuplicata.btnEnviarClick(Sender: TObject);
var
  _BoletoList: IspdRetIncluirLista;
  i: Integer;
  listaIdsIntegracao: string;
  vLista: TStringList;
begin
  inherited;
  if not fnc_Verificar then
    Exit;
  if not (CarregaConfig(comboFilial.KeyValue, 1)) then
    Application.MessageBox('Configurações inválidas!', 'ATENÇÃO', MB_OK + MB_ICONWARNING);
  vLista := TStringList.Create();
  mmResposta.Lines.Clear;
  mmResposta.Refresh;
  mmResposta.Lines.BeginUpdate;
  fDMCadDuplicata.qryConsulta_Duplicata.First;
  while not fDMCadDuplicata.qryConsulta_Duplicata.Eof do
  begin
    if (gridConsulta.SelectedRows.CurrentRowSelected) then
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
      fDMCadDuplicata.prc_Gravar_Duplicata(StrToInt(_BoletoList[i].NumeroDocumento), _BoletoList[i].IdIntegracao);

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
  TipoImpressao: TEnumTipoImpressao;
  _ImprimirLoteList: IspdRetImprimirLote;
  _Impressao: IspdRetConsultarLoteImpressao;
  _SalvarPDFLote: IspdRetSalvarLoteImpressaoPDF;
  ProtocoloImpressao: string;
  numeroConsultas: Integer;
begin
  inherited;
  if fDMCadDuplicata.qryConsulta_DuplicataID_INTEGRACAO.AsString = EmptyStr then
  begin
    Application.MessageBox('Título ainda não enviado!', 'ATENÇÃO', MB_OK + MB_ICONWARNING);
    Exit;
  end;

  pg_Principal.ActivePage := ts_Mensagem;
  TipoImpressao := tpNormal;

  if not (CarregaConfig(comboFilial.KeyValue, 1)) then
    Application.MessageBox('Configurações inválidas!', 'ATENÇÃO', MB_OK + MB_ICONWARNING);
  mmResposta.Lines.Clear;
  mmResposta.Refresh;
  mmResposta.Lines.BeginUpdate;

  ListaIdsIntegracao := fnc_Montar_IdIntegracao;

  _ImprimirLoteList := FBoletoX.ImprimirLote(ListaIdsIntegracao, IntToStr(integer(TipoImpressao)));
  Sleep(2000);
  if _ImprimirLoteList.Protocolo <> EmptyStr then
    ProtocoloImpressao := _ImprimirLoteList.Protocolo;
  mmResposta.Lines.Clear;
  mmResposta.Lines.Add('.:: IMPRESSÃO BOLETO::.');
  mmResposta.Lines.Add('Mensagem: ' + _ImprimirLoteList.Mensagem);
  mmResposta.Lines.Add('Status: ' + _ImprimirLoteList.Status);
  mmResposta.Lines.Add('Protocolo: ' + _ImprimirLoteList.Protocolo);
  if AnsiSameText(_ImprimirLoteList.Status, 'ERRO') then
  begin
    mmResposta.Lines.Add('ErroClasse: ' + ConverteErroClasse(_ImprimirLoteList.ErroClasse));
  end;
  mmResposta.Lines.Add('');
  mmResposta.Lines.EndUpdate;
  mmResposta.Lines.Add('.:: CONSULTAR PROTOCOLO IMPRESSÃO ::');
  mmResposta.Lines.EndUpdate;

  case TImprimir(rdgImpressao.ItemIndex) of
    opVisualizar:
      begin
        dlgSalvarPDF.FileName := _ImprimirLoteList.Protocolo + dlgSalvarPDF.Filter;
        if dlgSalvarPDF.Execute then
        begin
          try
            repeat           // Repete até que a nossa API tenha terminado de tratar o pedido de impressão
              begin
                _SalvarPDFLote := FBoletoX.SalvarLoteImpressaoPDF(_ImprimirLoteList.Protocolo, dlgSalvarPDF.FileName);

                mmResposta.Lines.Add('.:: CONSULTAR PROTOCOLO LOTE IMPRESSÃO - Tentativa ' + IntToStr(numeroConsultas) + ' ::.');
                mmResposta.Lines.Add('Situacao: ' + _SalvarPDFLote.Situacao);    //'PROCESSANDO': impressão em processamento  // 'PROCESSADA': impressão processada com sucesso  //  'FALHA': erro ao gerar a impressão. (O erro estará preenchido na propriedade Mensagem)  //  'CANCELADA': impressão abortada
                mmResposta.Lines.Add('Mensagem: ' + _SalvarPDFLote.Mensagem);
                mmResposta.Lines.Add('Status: ' + _SalvarPDFLote.Status);

                if _SalvarPDFLote.ErroConexao <> '' then
                  mmResposta.Lines.Add('Erro Conexão: ' + _SalvarPDFLote.ErroConexao);

                if AnsiSameText(_SalvarPDFLote.Status, 'ERRO') then
                  mmResposta.Lines.Add('ErroClasse: ' + ConverteErroClasse(_SalvarPDFLote.ErroClasse));

                if _SalvarPDFLote.Situacao = 'PROCESSANDO' then
                  Sleep(2000);    //'Se o processamento da API ainda não terminou, guarda 2 segundos.

                numeroConsultas := numeroConsultas + 1;
                mmResposta.Lines.Add('');
              end;

            until ((_SalvarPDFLote.Situacao = 'PROCESSADA') and (numeroConsultas < 40)) or (numeroConsultas > 40);

          finally
            mmResposta.Lines.EndUpdate;
          end;
        end;
      end;

    opImprimir:
      begin
        _Impressao := FBoletoX.ConsultarLoteImpressao(ProtocoloImpressao, GetDefaultPrinterName);
        while _Impressao.Situacao = 'PROCESSANDO' do
        begin
          mmResposta.Lines.Add('.:: PROCESSANDO ::');
          mmResposta.Lines.EndUpdate;
          _Impressao := FBoletoX.ConsultarLoteImpressao(ProtocoloImpressao, GetDefaultPrinterName);
        end;
        mmResposta.Lines.Add('.:: CONSULTAR PROTOCOLO IMPRESSÃO ::');
        mmResposta.Lines.Add('Situacao: ' + _Impressao.Situacao);    //'PROCESSANDO': impressão em processamento  // 'PROCESSADA': impressão processada com sucesso  //  'FALHA': erro ao gerar a impressão. (O erro estará preenchido na propriedade Mensagem)  //  'CANCELADA': impressão abortada
        mmResposta.Lines.Add('Mensagem: ' + _Impressao.Mensagem);
        mmResposta.Lines.Add('Status: ' + _Impressao.Status);
        if _Impressao.ErroConexao <> '' then
          mmResposta.Lines.Add('Erro Conexão: ' + _Impressao.ErroConexao);
        if AnsiSameText(_Impressao.Status, 'ERRO') then
          mmResposta.Lines.Add('ErroClasse: ' + ConverteErroClasse(_Impressao.ErroClasse));
        if _Impressao.Status = 'SUCESSO' then
        begin

        end;
        mmResposta.Lines.Add('');
        mmResposta.Lines.EndUpdate;
      end;
  end;
end;

function TfrmConsDuplicata.CarregaConfig(Filial, Tipo: Integer): Boolean;
var
  vConfigTecnoSpeed: TConfigTecnoSpeed;
begin
  Result := True;
  vConfigTecnoSpeed := TConfigTecnoSpeed.Create(Filial, Tipo);
  try
    FBoletoX.Config.URL := vConfigTecnoSpeed.URL;
    FBoletoX.ConfigurarSoftwareHouse(vConfigTecnoSpeed.CNPJSH, vConfigTecnoSpeed.Token);
    FBoletoX.Config.CedenteCpfCnpj := vConfigTecnoSpeed.CNPJCedente;
    FBoletoX.OnException := DoOnBoletoException;
    FBoletoX.Config.SalvarLogs := true;  //Salva os logs na pasta em que se encontra o exe do projeto
  except
    Result := False;
  end;
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

procedure TfrmConsDuplicata.EnviarEmail1Click(Sender: TObject);
var
  vLista : TStringList;
begin
  inherited;
  if fDMCadDuplicata.qryConsulta_DuplicataID_INTEGRACAO.AsString = EmptyStr then
  begin
    Application.MessageBox('Título ainda não enviado!', 'ATENÇÃO', MB_OK + MB_ICONWARNING);
    Exit;
  end;
  if not (CarregaConfig(comboFilial.KeyValue, 1)) then
    Application.MessageBox('Configurações inválidas!', 'ATENÇÃO', MB_OK + MB_ICONWARNING);
  prc_Email_TecnoSpeed;
end;

function TfrmConsDuplicata.fnc_Descartar_Boleto(ID_Integracao: String): Boolean;
var
  _DescarteList: IspdretDescartarLista;
  _DescarteItem: IspdRetDescartarTituloItem;
  i: Integer;
begin
  try
    _DescarteList := FBoletoX.Descartar(ID_Integracao);
    if AnsiSameText(_DescarteList.Status, 'ERRO') then
    begin
       Result := False;
       MessageDlg(ConverteErroClasse(_DescarteList.ErroClasse),mtInformation,[mbOK],0);
       Exit;
    end;
    for i := 0 to _DescarteList.Count - 1 do
    begin
      Result := True;
    end;
  finally
  end;
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
    qryConsulta.SQL.Add('where P.CODIGO = :ID');
    qryConsulta.ParamByName('ID').AsInteger := qryConsulta_DuplicataID_PESSOA.AsInteger;
    qryConsulta.Open();
    if not (qryConsulta.IsEmpty) then
    begin
      Result.Add('SacadoEmail=' + qryConsulta.FieldByName('EMAIL_PGTO').AsString);
      Result.Add('SacadoNome=' + qryConsulta.FieldByName('NOME_SACADO').AsString);
      Result.Add('SacadoCPFCNPJ=' + qryConsulta.FieldByName('CNPJ_CPF').AsString);
      Result.Add('SacadoEnderecoCEP=' + qryConsulta.FieldByName('CEP').AsString);
      Result.Add('SacadoEnderecoNumero=' + qryConsulta.FieldByName('NUM_END').AsString);
      Result.Add('SacadoEnderecoBairro=' + qryConsulta.FieldByName('BAIRRO').AsString);
      Result.Add('SacadoEnderecoCidade=' + qryConsulta.FieldByName('CIDADE').AsString);
      Result.Add('SacadoEnderecoLogradouro=' + qryConsulta.FieldByName('ENDERECO').AsString);
      Result.Add('SacadoEnderecoPais=' + qryConsulta.FieldByName('NOME_PAIS').AsString);
      Result.Add('SacadoEnderecoUF=' + qryConsulta.FieldByName('UF').AsString);
      Result.Add('SacadoTelefone=' + qryConsulta.FieldByName('TELEFONE1').AsString);
    end;
    //Fim Sacado
    // Inicio Título
    Result.Add('TituloNossoNumero=' + IntToStr(qryConsulta_DuplicataID.AsInteger));
    Result.Add('TituloNumeroDocumento=' + IntToStr(qryConsulta_DuplicataID.AsInteger));
    Result.Add('TituloDataVencimento=' + DateToStr(qryConsulta_DuplicataDTVENCIMENTO.AsDateTime));
    Result.Add('TituloDataEmissao=' + DateToStr(qryConsulta_DuplicataDTEMISSAO.AsDateTime));
    Result.Add('TituloValor=' + FormatFloat('0.00', qryConsulta_DuplicataVLR_PARCELA.AsFloat));
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

procedure TfrmConsDuplicata.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  ListaIdsDuplicatas.Free;
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
  ListaIdsDuplicatas := TStringList.Create;


  if fDMCadDuplicata.qryContas.RecordCount = 1 then
  begin
    comboBanco.KeyValue := fDMCadDuplicata.qryContasID.AsInteger;
    fDMCadDuplicata.qryContasBeforeScroll(fDMCadDuplicata.qryContas);
    comboOcorrencia.KeyValue := fDMCadDuplicata.qryOcorrenciaID.AsInteger;
  end;
end;

procedure TfrmConsDuplicata.GerarRemessa1Click(Sender: TObject);
var
  _RemessaList: IspdRetGerarRemessaLista;
  _RemessaItem: IspdRetGerarRemessaItem;
  i, j: Integer;
  conteudoRemessa: TStringList;
  ListaID : String;
  NomeRemessa : String;
  GeraNomeRemessa : TNomeRemessa;
begin
  inherited;
  if fDMCadDuplicata.qryConsulta_DuplicataID_INTEGRACAO.AsString = EmptyStr then
  begin
    Application.MessageBox('Título ainda não enviado!', 'ATENÇÃO', MB_OK + MB_ICONWARNING);
    Exit;
  end;

  pg_Principal.ActivePage := ts_Mensagem;
  if not (CarregaConfig(comboFilial.KeyValue, 1)) then
    Application.MessageBox('Configurações inválidas!', 'ATENÇÃO', MB_OK + MB_ICONWARNING);
  mmResposta.Lines.Clear;
  mmResposta.Refresh;
  mmResposta.Lines.BeginUpdate;
  GeraNomeRemessa := TNomeRemessa.create;
  GeraNomeRemessa.TipoBanco := tpSicredi;
  NomeRemessa := GeraNomeRemessa.GeraNomeArquivo(fDMCadDuplicata.qryContasID.AsString);
  ListaID := fnc_Montar_IdIntegracao;

  try
    _RemessaList := FBoletoX.GerarRemessa(ListaID);

    mmResposta.Lines.Clear;
    mmResposta.Lines.Add('.:: GERAR REMESSA ::.');
    mmResposta.Lines.Add('Mensagem: ' + _RemessaList.Mensagem);
    mmResposta.Lines.Add('Status: ' + _RemessaList.Status);
    mmResposta.Lines.Add('');

    for i := 0 to _RemessaList.Count - 1 do
    begin
      _RemessaItem := _RemessaList.Item[i];
      mmResposta.Lines.Add('ITEM: ' + IntToStr(i+1));
      mmResposta.Lines.Add('  Mensagem: ' + _RemessaItem.Mensagem);
      mmResposta.Lines.Add('  Remessa: ' + _RemessaItem.Remessa);
      mmResposta.Lines.Add('  Banco: ' + _RemessaItem.Banco);
      mmResposta.Lines.Add('  Conta: ' + _RemessaItem.Conta);
      mmResposta.Lines.Add('  Número Atual da Remessa: ' + IntToStr(_RemessaItem.NumeroAtualRemessa));
      mmResposta.Lines.Add('  Transmissão automática?: ' + BoolToStr(_RemessaItem.TransmissaoAutomatica));
      mmResposta.Lines.Add('  Erro: ' + _RemessaItem.Erro);

      conteudoRemessa := TStringList.Create;//---
      conteudoRemessa.Text := UTF8Encode(_RemessaItem.Remessa); //    |--> Salva o conteúdo da remessa em um arquivo texto
      conteudoRemessa.SaveToFile(NomeRemessa);//---

      for j := 0 to _RemessaItem.Titulos.Count-1 do
      begin
        mmResposta.Lines.Add('  IdIntegracao ' + IntToStr(j+1) + ': ' + _RemessaItem.Titulos.Item[j]);
      end;
      mmResposta.Lines.Add('');
      conteudoRemessa.Free;
    end;
    prc_Gravar_Historico('Envio Remessa');
  finally
    mmResposta.Lines.EndUpdate;
  end;

end;

procedure TfrmConsDuplicata.gridConsultaGetCellParams(Sender: TObject;
  Field: TField; AFont: TFont; var Background: TColor; Highlight: Boolean);
begin
  inherited;
  if fDMCadDuplicata.qryConsulta_Duplicata.IsEmpty then
    Exit;
  if (fDMCadDuplicata.qryConsulta_DuplicataID_INTEGRACAO.AsString <> EmptyStr) then
  begin
    Background := clYellow;
    AFont.Color := clWhite;
  end;
  if (fDMCadDuplicata.qryConsulta_DuplicataID_IMPRESSAO.AsString <> EmptyStr) then
  begin
    Background := clOlive;
    AFont.Color := clWhite;
  end;
  if (fDMCadDuplicata.qryConsulta_DuplicataDTVENCIMENTO.AsDateTime < Date) then
  begin
    Background := clRed;
    AFont.Color := clWhite;
  end;

end;

procedure TfrmConsDuplicata.prc_Consultar_Duplicata;
begin
  fDMCadDuplicata.qryConsulta_Duplicata.SQL.Text := fDMCadDuplicata.ctCommandDup;
  fDMCadDuplicata.qryConsulta_Duplicata.Close;
  fDMCadDuplicata.qryConsulta_Duplicata.SQL.Add(' WHERE DUP.TIPO_ES = ' + QuotedStr('E') + ' AND DUP.VLR_RESTANTE > 0');
  if comboFilial.KeyValue > 0 then
    fDMCadDuplicata.qryConsulta_Duplicata.SQL.Add(' AND DUP.FILIAL = ' + IntToStr(comboFilial.KeyValue));
  if edtConsulta.Text <> '' then
    fDMCadDuplicata.qryConsulta_Duplicata.SQL.Add(' AND (DUP. ' + CampoConsulta + ' = ' + QuotedStr(edtConsulta.Text) + ') ');
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

procedure TfrmConsDuplicata.prc_Consultar_TecnoSpeed;
var
  _ConsultarList: IspdRetConsultarLista;
  _ConsultarItem: IspdRetConsultarTituloItem;
  i, j, k, l: Integer;
begin
  inherited;
  if not (CarregaConfig(comboFilial.KeyValue, 1)) then
    Application.MessageBox('Configurações inválidas!', 'ATENÇÃO', MB_OK + MB_ICONWARNING);
  mmResposta.Lines.Clear;
  mmResposta.Refresh;
  mmResposta.Lines.BeginUpdate;
  listaIdsIntegracao :=  fnc_Montar_IdIntegracao;
  try
    _ConsultarList := FBoletoX.Consultar(listaIdsIntegracao);

    mmResposta.Lines.Add('.:: Consultar Título ::.');
    mmResposta.Lines.Add('Mensagem: ' + _ConsultarList.Mensagem);
    mmResposta.Lines.Add('Status: ' + _ConsultarList.Status);

    if _ConsultarList.ErroConexao <> '' then
      mmResposta.Lines.Add('Erro Conexão: ' + _ConsultarList.ErroConexao);

    mmResposta.Lines.Add('');

    prc_Criar_CampoClient;

    while _ConsultarList.Count <> 0 do
    begin
      for i := 0 to pred(_ConsultarList.Count) do    //o conteúdo de pred é equivalente a (_ConsultarList.Count - 1)
      begin
        _ConsultarItem := _ConsultarList.Item[i];
        mmResposta.Lines.Add('ITEM: ' + IntToStr(i + 1));

        fDMCadDuplicata.cdsConsulta.Insert;
        fDMCadDuplicata.cdsConsulta.FieldByName('Item').AsInteger := i;
        fDMCadDuplicata.cdsConsulta.FieldByName('IdIntegracao').AsString := _ConsultarItem.IdIntegracao;
        fDMCadDuplicata.cdsConsulta.FieldByName('Situacao').AsString := _ConsultarItem.Situacao;
        fDMCadDuplicata.cdsConsulta.FieldByName('Agencia').AsString := _ConsultarItem.CedenteAgencia;
        fDMCadDuplicata.cdsConsulta.FieldByName('AgenciaDV').AsString := _ConsultarItem.CedenteAgenciaDV;
        fDMCadDuplicata.cdsConsulta.FieldByName('CodigoBanco').AsString := _ConsultarItem.CedenteCodigoBanco;
        fDMCadDuplicata.cdsConsulta.FieldByName('Carteira').AsString := _ConsultarItem.CedenteCarteira;
        fDMCadDuplicata.cdsConsulta.FieldByName('Conta').AsString := _ConsultarItem.CedenteConta;
        fDMCadDuplicata.cdsConsulta.FieldByName('DVconta').AsString := _ConsultarItem.CedenteContaNumeroDV;
        fDMCadDuplicata.cdsConsulta.FieldByName('NumeroConvenio').AsString := _ConsultarItem.CedenteNumeroConvenio;
        fDMCadDuplicata.cdsConsulta.FieldByName('CPFCNPJ').AsString := _ConsultarItem.SacadoCPFCNPJ;
        fDMCadDuplicata.cdsConsulta.FieldByName('Nome').AsString := _ConsultarItem.SacadoNome;
        fDMCadDuplicata.cdsConsulta.FieldByName('Email').AsString := _ConsultarItem.SacadoEmail;
        fDMCadDuplicata.cdsConsulta.FieldByName('NossoNumero').AsString := _ConsultarItem.TituloNossoNumero;
        fDMCadDuplicata.cdsConsulta.FieldByName('NumeroDocument').AsString := _ConsultarItem.TituloNumeroDocumento;
        fDMCadDuplicata.cdsConsulta.Post;

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

         {$REGION 'Complemento da consulta'}
//        mmResposta.Lines.Add('  Código para baixa ou devolução: ' + _ConsultarItem.TituloCodBaixaDevolucao);
//        mmResposta.Lines.Add('  Prazo para baixa ou devolução: ' + _ConsultarItem.TituloPrazoBaixa);
//        mmResposta.Lines.Add('  Data Emissão: ' + _ConsultarItem.TituloDataEmissao);
//        mmResposta.Lines.Add('  Forçar Fator Vencimento: ' + BoolToStr(_ConsultarItem.TituloForcarFatorVencimento, True));
//        mmResposta.Lines.Add('  Data Vencimento: ' + _ConsultarItem.TituloDataVencimento);
//        mmResposta.Lines.Add('  Código de Desconto: ' + _ConsultarItem.TituloCodDesconto);
//        mmResposta.Lines.Add('  Data Desconto: ' + _ConsultarItem.TituloDataDesconto);
//        mmResposta.Lines.Add('  Valor Desconto: ' + FloatToStr(_ConsultarItem.TituloValorDescontoTaxa));
//        mmResposta.Lines.Add('  Código de Desconto2: ' + _ConsultarItem.TituloCodDesconto2);
//        mmResposta.Lines.Add('  Outras Deducoes: ' + _ConsultarItem.TituloOutrasDeducoes);
//        mmResposta.Lines.Add('  Data Desconto: ' + _ConsultarItem.TituloDataDesconto2);
//        mmResposta.Lines.Add('  Valor Desconto: ' + FloatToStr(_ConsultarItem.TituloValorDescontoTaxa2));
//        mmResposta.Lines.Add('  Código de Juros: ' + _ConsultarItem.TituloCodigoJuros);
//        mmResposta.Lines.Add('  Data Juros: ' + _ConsultarItem.TituloDataJuros);
//        mmResposta.Lines.Add('  Valor Juros: ' + FloatToStr(_ConsultarItem.TituloValorJuros));
//        mmResposta.Lines.Add('  Prazo Protesto: ' + _ConsultarItem.TituloPrazoProtesto);
//        mmResposta.Lines.Add('  Instrucoes: ' + _ConsultarItem.TituloInstrucoes);
//        mmResposta.Lines.Add('  Mensagem 1: ' + _ConsultarItem.TituloMensagem01);
//        mmResposta.Lines.Add('  Mensagem 2: ' + _ConsultarItem.TituloMensagem02);
//        mmResposta.Lines.Add('  Mensagem 3: ' + _ConsultarItem.TituloMensagem03);
//        mmResposta.Lines.Add('  TítuloInstrucao 1: ' + _ConsultarItem.TituloInstrucao1);
//        mmResposta.Lines.Add('  TítuloInstrucao 2: ' + _ConsultarItem.TituloInstrucao2);
//        mmResposta.Lines.Add('  Informacoes Adicionais: ' + _ConsultarItem.TituloInformacoesAdicionais);
//        mmResposta.Lines.Add('  Local Pagamento: ' + _ConsultarItem.TituloLocalPagamento);
//        mmResposta.Lines.Add('  Parcela: ' + _ConsultarItem.TituloParcela);
//        mmResposta.Lines.Add('  Variacao Carteira: ' + _ConsultarItem.TituloVariacaoCarteira);
//        mmResposta.Lines.Add('  Categoria: ' + _ConsultarItem.TituloCategoria);
//        mmResposta.Lines.Add('  Modalidade: ' + _ConsultarItem.TituloModalidade);
//        mmResposta.Lines.Add('  Cip: ' + _ConsultarItem.TituloCip);
//        mmResposta.Lines.Add('  Ios "utilizado apenas pelo Santander": ' + _ConsultarItem.TituloIos);
//        mmResposta.Lines.Add('  Cod Cliente "exclusivo para os bancos HSBC e Safra": ' + _ConsultarItem.TituloCodCliente);
//        mmResposta.Lines.Add('  Valor: ' + FloatToStr(_ConsultarItem.TituloValor));
//        mmResposta.Lines.Add('  Pagamento Minimo: ' + FloatToStr(_ConsultarItem.TituloPagamentoMinimo));
//        mmResposta.Lines.Add('  Data Crédito: ' + _ConsultarItem.PagamentoDataCredito);
//        mmResposta.Lines.Add('  Valor Cobrado: ' + FloatToStr(_ConsultarItem.TituloValorCobrado));
//        mmResposta.Lines.Add('  Título Pago: ' + BoolToStr(_ConsultarItem.PagamentoRealizado));
//        mmResposta.Lines.Add('  Valor Crédito: ' + FloatToStr(_ConsultarItem.PagamentoValorCredito));
//        mmResposta.Lines.Add('  Valor Outros Acréscimos: ' + FloatToStr(_ConsultarItem.TituloValorOutrosAcrescimos));
//        mmResposta.Lines.Add('  Valor Pago: ' + FloatToStr(_ConsultarItem.PagamentoValorPago));
//        mmResposta.Lines.Add('  Valor Taxa Cobrança: ' + FloatToStr(_ConsultarItem.PagamentoValorTaxaCobranca));
//        mmResposta.Lines.Add('  Valor Abatimento: ' + FloatToStr(_ConsultarItem.TituloValorAbatimento));
//        mmResposta.Lines.Add('  Valor Outras Despesas: ' + FloatToStr(_ConsultarItem.PagamentoValorOutrasDespesas));
//        mmResposta.Lines.Add('  Valor IOF: ' + FloatToStr(_ConsultarItem.PagamentoValorIOF));
//        mmResposta.Lines.Add('  Código Multa: ' + _ConsultarItem.TituloCodigoMulta);
//        mmResposta.Lines.Add('  Valor Multa: ' + FloatToStr(_ConsultarItem.TituloValorMulta));
//        mmResposta.Lines.Add('  Valor Multa Taxa: ' + FloatToStr(_ConsultarItem.TituloValorMultaTaxa));
//        mmResposta.Lines.Add('  Data Multa: ' + _ConsultarItem.PagamentoData);
//        mmResposta.Lines.Add('  Data Pagamento: ' + _ConsultarItem.PagamentoData);
//        mmResposta.Lines.Add('  Valor Outros Créditos: ' + FloatToStr(_ConsultarItem.PagamentoValorOutrosCreditos));
//        mmResposta.Lines.Add('  Pagamento Valor Desconto: ' + FloatToStr(_ConsultarItem.PagamentoValorDesconto));
//        mmResposta.Lines.Add('  Pagamento Valor Acréscimos: ' + FloatToStr(_ConsultarItem.PagamentoValorAcrescimos));
//        mmResposta.Lines.Add('  Pagamento Valor Abatimento: ' + FloatToStr(_ConsultarItem.PagamentoValorAbatimento));
//        mmResposta.Lines.Add('  Impressão Visualizada: ' + BoolToStr(_ConsultarItem.ImpressaoVisualizada, True));   //Converte o retorno para "False" ou "True"
//        mmResposta.Lines.Add('  Impressão Visualizada Data: ' + (_ConsultarItem.TituloDataImpressaoVisualizada));

           {$ENDREGION}

        mmResposta.Lines.Add('');

        if _ConsultarItem.Situacao = 'FALHA' then
        begin
          if MessageDlg('Duplicata nº: ' + _ConsultarItem.TituloNumeroDocumento +#13#10+ 'Deseja Descartar? ',mtConfirmation,[mbYes,mbNo],0) = mrYes then
          begin
            if fnc_Descartar_Boleto(_ConsultarItem.IdIntegracao) then
            begin

            end;
          end;
        end;


        for k := 0 to _ConsultarItem.CountTituloMovimentos - 1 do
        begin
          mmResposta.Lines.Add('  MOVIMENTOS:');
          mmResposta.Lines.Add('  Movimento Código: ' + _ConsultarItem.TituloMovimentos[k].Codigo);
          mmResposta.Lines.Add('  Movimento Mensagem: ' + _ConsultarItem.TituloMovimentos[k].Mensagem);
          mmResposta.Lines.Add('  Movimento Data: ' + _ConsultarItem.TituloMovimentos[k].Data);
          mmResposta.Lines.Add('  Movimento Taxa: ' + FloatToStr(_ConsultarItem.TituloMovimentos[k].Taxa));
          for l := 0 to _ConsultarItem.TituloMovimentos[k].CountOcorrencias - 1 do
          begin
            mmResposta.Lines.Add('  OCORRÊNCIAS:');
            mmResposta.Lines.Add('     Ocorrências Código: ' + _ConsultarItem.TituloMovimentos[k].Ocorrencias[l].Codigo);
            mmResposta.Lines.Add('     Ocorrências Mensagem: ' + _ConsultarItem.TituloMovimentos[k].Ocorrencias[l].Mensagem);
          end;
          mmResposta.Lines.Add('');
        end;

      end;

      _ConsultarList.PaginaSeguinte;           //Utilize este parâmetro quando a consulta for feita com mais de 1000 idIntegracao por vez. O While fará a consulta de 20 em 20 idIntegracao, e o "PaginaSeguinte" repete a consulta enquanto houverem páginas a serem consultadas.

    end;

  finally
    mmResposta.Lines.EndUpdate;
    pg_Principal.ActivePage := ts_Mensagem;
  end;
  ffrmConsDetalhe := TfrmConsultaDetalheTecno.Create(nil);
  CopiarDataSet(fDMCadDuplicata.cdsConsulta,ffrmConsDetalhe.cdsPadrao);
  ffrmConsDetalhe.ShowModal;
  FreeAndNil(ffrmConsDetalhe);
end;

procedure TfrmConsDuplicata.prc_Criar_CampoClient;
begin
  fDMCadDuplicata.prc_Criar_CampoClientDataSet('ITEM',ftInteger,0,false);
  fDMCadDuplicata.prc_Criar_CampoClientDataSet('IdIntegracao',ftString,10,false);
  fDMCadDuplicata.prc_Criar_CampoClientDataSet('Situacao',ftString,20,false);
  fDMCadDuplicata.prc_Criar_CampoClientDataSet('Agencia',ftString,04,false);
  fDMCadDuplicata.prc_Criar_CampoClientDataSet('AgenciaDV',ftString,04,false);
  fDMCadDuplicata.prc_Criar_CampoClientDataSet('CodigoBanco',ftString,06,false);
  fDMCadDuplicata.prc_Criar_CampoClientDataSet('Carteira',ftString,04,false);
  fDMCadDuplicata.prc_Criar_CampoClientDataSet('Conta',ftString,20,false);
  fDMCadDuplicata.prc_Criar_CampoClientDataSet('DVconta',ftString,02,false);
  fDMCadDuplicata.prc_Criar_CampoClientDataSet('NumeroConvenio',ftString,15,false);
  fDMCadDuplicata.prc_Criar_CampoClientDataSet('CPFCNPJ',ftString,18,false);
  fDMCadDuplicata.prc_Criar_CampoClientDataSet('Nome',ftString,30,false);
  fDMCadDuplicata.prc_Criar_CampoClientDataSet('Email',ftString,30,false);
  fDMCadDuplicata.prc_Criar_CampoClientDataSet('NossoNumero',ftString,20,false);
  fDMCadDuplicata.prc_Criar_CampoClientDataSet('NumeroDocument',ftString,20,false);
  fDMCadDuplicata.cdsConsulta.CreateDataSet;
end;

procedure TfrmConsDuplicata.prc_Email_TecnoSpeed;
var
  i, n : Integer;
  TpImpressao: TEnumTipoImpressao;
  EnviarEmailTecnoSpeed : TEnviarEmailTecnoSpeed;
  _EnviarEmailLoteResposta: IspdRetEnvioEmailLote;
  vLista : TStringList;
  vListaEmail : TStringList;
  ConfigEmail : TEmailEmpresa;
begin
  vLista := TStringList.Create;
  vLista := fnc_Montar_Lista;
  vListaEmail := TStringList.Create;
  EnviarEmailTecnoSpeed := TEnviarEmailTecnoSpeed.create;
  ConfigEmail := TEmailEmpresa.Create;
  TpImpressao := tpNormal;
  mmEnvio.Lines.Clear;
  mmResposta.Lines.Clear;
  pg_Principal.ActivePage := ts_Mensagem;
  for I := 0 to vLista.Count - 1 do
  begin
    fDMCadDuplicata.qryConsulta_Duplicata.Locate('ID',vLista[i],[loCaseInsensitive]);
    try
      with EnviarEmailTecnoSpeed do
      begin
        IDIntegracao := fDMCadDuplicata.qryConsulta_DuplicataID_INTEGRACAO.AsString;
        ConfigEmail.Tipo := opFinanceiro;
        if ConfigEmail.Retornar_Email(fDMCadDuplicata.qryConsulta_DuplicataFILIAL.AsInteger,ConfigEmail.Tipo) then
        begin
          EmailNomeRemetente := ConfigEmail.NomeEmail;
          EmailRemetente := ConfigEmail.Email;
        end
        else
        begin
          EmailNomeRemetente := SQLLocate('EMPRESA','ID','NOME',fDMCadDuplicata.qryConsulta_DuplicataFILIAL.AsString);
          EmailRemetente := SQLLocate('EMPRESA','ID','EMAIL',fDMCadDuplicata.qryConsulta_DuplicataFILIAL.AsString);
        end;
        EmailAssunto := 'Boleto para pagamento nº: ' + fDMCadDuplicata.qryConsulta_DuplicataNUMDUPLICATA.AsString + '/' + fDMCadDuplicata.qryConsulta_DuplicataPARCELA.AsString;
        EmailDestinatario := fDMCadDuplicata.qryConsulta_DuplicataEMAIL_PGTO.AsString;
        case TEnumTipoEnvioAnexo(rdgAnexar.ItemIndex) of
          tpAnexo :
            begin
              EmailAnexar := True;
              EmailMensagem := 'Prezado cliente, segue boleto em anexo nº: ' +  fDMCadDuplicata.qryConsulta_DuplicataNUMDUPLICATA.AsString + '/' + fDMCadDuplicata.qryConsulta_DuplicataPARCELA.AsString + ' com vencimento em : ' + FormatDateTime('dd.mm.aaaa',fDMCadDuplicata.qryConsulta_DuplicataDTVENCIMENTO.AsDateTime);
            end;
          tpLink  :
           begin
            EmailAnexar := False;
            EmailMensagem := 'Prezado cliente, segue link para pagamento de seu boleto nº: ' + fDMCadDuplicata.qryConsulta_DuplicataNUMDUPLICATA.AsString + '/' + fDMCadDuplicata.qryConsulta_DuplicataPARCELA.AsString + ' com vencimento em : ' + FormatDateTime('dd.mm.YYYY',fDMCadDuplicata.qryConsulta_DuplicataDTVENCIMENTO.AsDateTime) + ' ${linkBoleto}';
           end;
        end;
        TipoImpressao := IntToStr(integer(TpImpressao));

        vListaEmail :=  MontaEmailBoleto;
        for n := 0 to vListaEmail.Count - 1 do
        begin
          mmEnvio.Lines.Add(vListaEmail[n])
        end;

        try
          _EnviarEmailLoteResposta := FBoletoX.EnviarEmailLote(mmEnvio.Lines.Text);
          mmResposta.Lines.Clear;
          mmResposta.Lines.Add('.:: Enviar Email Lote ::.');
          mmResposta.Lines.Add('Mensagem: ' + _EnviarEmailLoteResposta.Mensagem);
          mmResposta.Lines.Add('Status: ' + _EnviarEmailLoteResposta.Status);
          mmResposta.Lines.Add('Protocolo: ' + _EnviarEmailLoteResposta.Protocolo);

//          edtProtocoloEmailLote.Text :=  _EnviarEmailLoteResposta.Protocolo;

          if AnsiSameText(_EnviarEmailLoteResposta.Status, 'ERRO') then
            mmResposta.Lines.Add('ErroClasse: ' + ConverteErroClasse(_EnviarEmailLoteResposta.ErroClasse));

          if _EnviarEmailLoteResposta.ErroConexao <> '' then
            mmResposta.Lines.Add('Erro Conexão: ' + _EnviarEmailLoteResposta.ErroConexao);
          mmResposta.Lines.Add('');
          mmResposta.SelStart := 1;
          mmResposta.SelLength := 1;
        finally
          mmResposta.Lines.EndUpdate;
        end;

      end;
    finally
      EnviarEmailTecnoSpeed.Free;
    end;
  end;
end;

procedure TfrmConsDuplicata.prc_Gravar_Historico(Historico : String);
var
  GravaHist : TDuplicataHistorico;
begin
  GravaHist := TDuplicataHistorico.Create;
  fDMCadDuplicata.qryConsulta_Duplicata.First;
  fDMCadDuplicata.qryConsulta_Duplicata.DisableControls;
  while not fDMCadDuplicata.qryConsulta_Duplicata.Eof do
  begin
    if gridConsulta.SelectedRows.CurrentRowSelected then
    begin
      with GravaHist do
      begin
        ID := fDMCadDuplicata.qryConsulta_DuplicataID.AsInteger;
        DTLANCAMENTO := Date;
        VLR_PAGAMENTO := fDMCadDuplicata.qryConsulta_DuplicataVLR_PARCELA.AsFloat;
        TIPO_HISTORICO := 'OUT';
        COMPLEMENTO := Historico;
        DTHISTORICO := Date;
        insert;
      end;
    end;
    fDMCadDuplicata.qryConsulta_Duplicata.Next;
  end;
end;

procedure TfrmConsDuplicata.prc_Montar_IDDuplicatas;
begin
  fDMCadDuplicata.qryConsulta_Duplicata.First;
  fDMCadDuplicata.qryConsulta_Duplicata.DisableControls;
  ListaIdsDuplicatas.Clear;
  while not fDMCadDuplicata.qryConsulta_Duplicata.Eof do
  begin
    if gridConsulta.SelectedRows.CurrentRowSelected then
    begin
      ListaIdsDuplicatas.Add(IntToStr(fDMCadDuplicata.qryConsulta_DuplicataID.AsInteger));
    end;
    fDMCadDuplicata.qryConsulta_Duplicata.Next;
  end;
  fDMCadDuplicata.qryConsulta_Duplicata.EnableControls;
end;

function TfrmConsDuplicata.fnc_Montar_IdIntegracao: string;
var
  Lista: TStringList;
  I: Integer;
  teste : String;
begin
  Lista := TStringList.Create;
  try
    fDMCadDuplicata.qryConsulta_Duplicata.First;
    fDMCadDuplicata.qryConsulta_Duplicata.DisableControls;
    while not fDMCadDuplicata.qryConsulta_Duplicata.eof do
    begin
      if gridConsulta.SelectedRows.CurrentRowSelected then
      begin
        Lista.Add(fDMCadDuplicata.qryConsulta_DuplicataID_INTEGRACAO.AsString + ',');
      end;
      fDMCadDuplicata.qryConsulta_Duplicata.Next;
    end;
    Lista[Lista.Count - 1] := StringReplace(Lista[Lista.Count - 1], ',', '', [rfReplaceAll]);
    for I := 0 to Lista.Count - 1 do
      Result := Result + Lista[I];
  finally
    FreeAndNil(Lista);
    fDMCadDuplicata.qryConsulta_Duplicata.EnableControls;
  end;
end;

function TfrmConsDuplicata.fnc_Montar_Lista: TStringList;
var
  Lista: TStringList;
  I: Integer;
  teste : String;
begin
  Result := TStringList.Create;
  try
    fDMCadDuplicata.qryConsulta_Duplicata.First;
    fDMCadDuplicata.qryConsulta_Duplicata.DisableControls;
    while not fDMCadDuplicata.qryConsulta_Duplicata.eof do
    begin
      if gridConsulta.SelectedRows.CurrentRowSelected then
      begin
        Result.Add(fDMCadDuplicata.qryConsulta_DuplicataID.AsString);
      end;
      fDMCadDuplicata.qryConsulta_Duplicata.Next;
    end;
  finally
    fDMCadDuplicata.qryConsulta_Duplicata.EnableControls;
  end;
end;


procedure TfrmConsDuplicata.SMDBGrid1TitleClick(Column: TColumn);
begin
  inherited;
  lblDiversos.Caption := Column.Field.DisplayLabel + ':';
  CampoConsulta := Column.FieldName;
end;

end.

