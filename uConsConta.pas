unit uConsConta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uConsPadrao, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, SMDBGrid,
  Vcl.ComCtrls, Vcl.DBCtrls, Vcl.StdCtrls, SMultiBtn, Vcl.ExtCtrls, uConfigTecnoSpeed,
  Vcl.OleCtrls, BoletoX_TLB, uDMCadConta, JvExControls, JvDBLookup, Classe.Monta.Conta.TecnoSpeed,
  Classe.Monta.Convenio.TecnoSpeed;

type
  TEnumEnvio = (tpConta, tpConvenio);

type
  TfrmConsConta = class(TfrmConsPadrao)
    btnEnviar: TSMButton;
    spdBoletoX1: TspdBoletoX;
    ts_Mensagem: TTabSheet;
    mmEnvio: TMemo;
    mmResposta: TMemo;
    rdgTipoEnvio: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
  private
    { Private declarations }
   procedure CarregaConfig(Filial, Tipo: Integer);
   function fnc_Montar_Envio : TStringList;
   procedure DoOnBoletoException(ASender: TObject; const aExceptionMessage: WideString);
   procedure prc_Enviar_Conta;
   procedure prc_Enviar_Convenio;
  public
    { Public declarations }
      FBoletoX: TspdBoletoX;
end;

var
  frmConsConta: TfrmConsConta;
  fDMCadConta : TdmCadConta;

implementation


{$R *.dfm}

procedure TfrmConsConta.btnConsultarClick(Sender: TObject);
begin
  inherited;
  fDMCadConta.qryConsulta.Close;
  if comboFilial.KeyValue > 0 then
    fDMCadConta.qryConsulta.ParamByName('ID').AsInteger := qryFilialID.AsInteger
  else
    fDMCadConta.qryConsulta.ParamByName('ID').AsInteger := 0;
  fDMCadConta.qryConsulta.Open;
end;

procedure TfrmConsConta.btnEnviarClick(Sender: TObject);
var
  _Conta: IspdRetCadastrarConta;
begin
  inherited;
  case TEnumEnvio(rdgTipoEnvio.ItemIndex) of
    tpConta : begin
      if fDMCadConta.qryConsultaID_CONTA_TECNOSPEED.AsInteger > 0 then
      begin
        MessageDlg('Conta já cadastrada!',mtInformation,[mbOK],0);
        Exit;
      end;
      prc_Enviar_Conta;
    end;
    tpConvenio : begin
      if fDMCadConta.qryConsultaID_CONVENIO_TECNOSPEED.AsInteger > 0 then
      begin
       MessageDlg('Convênio já cadastrado!',mtInformation,[mbOK],0);
       Exit;
      end;
      if fDMCadConta.qryConsultaID_CONTA_TECNOSPEED.AsInteger = 0 then
      begin
       MessageDlg('Conta não cadastrada!',mtInformation,[mbOK],0);
       Exit;
      end;

      prc_Enviar_Convenio;
    end;
  end;

end;

procedure TfrmConsConta.CarregaConfig(Filial, Tipo: Integer);
var
  vConfigTecnoSpeed : TConfigTecnoSpeed;
begin
  vConfigTecnoSpeed := TConfigTecnoSpeed.Create(Filial,Tipo);
  FBoletoX.Config.URL :=  vConfigTecnoSpeed.URL;
  FBoletoX.ConfigurarSoftwareHouse(vConfigTecnoSpeed.CNPJSH, vConfigTecnoSpeed.Token);
  FBoletoX.Config.CedenteCpfCnpj := vConfigTecnoSpeed.CNPJCedente;
  FBoletoX.OnException := DoOnBoletoException;
  FBoletoX.Config.SalvarLogs := true;  //Salva os logs na pasta em que se encontra o exe do projeto
end;

procedure TfrmConsConta.DoOnBoletoException(ASender: TObject;
  const aExceptionMessage: WideString);
begin
  MessageBox(0, PChar(aExceptionMessage), 'Exceção do BoletoX', MB_ICONERROR or MB_OK);
end;

function TfrmConsConta.fnc_Montar_Envio: TStringList;
var
  MontaContaTecnoSpeed : TMontaContaTecnoSpeed;
  MontaConvenioTecnoSpeed : TMontaConvenioTecnoSpeed;
begin
  Result := TStringList.Create;
  case TEnumEnvio(rdgTipoEnvio.ItemIndex) of
    tpConta : begin
      MontaContaTecnoSpeed := TMontaContaTecnoSpeed.new;
      with MontaContaTecnoSpeed do
      begin
       CodigoBanco    := fDMCadConta.qryConsultaCODIGO.AsString;
       ContaAgencia   := fDMCadConta.qryConsultaAGENCIA.AsString;
       ContaAgenciaDV := fDMCadConta.qryConsultaDIG_AGENCIA.AsString;
       ContaNumero    := fDMCadConta.qryConsultaNUMCONTA.AsString;
       ContaNumeroDV  := fDMCadConta.qryConsultaDIG_CONTA.AsString;
       ContaCodigoBeneficiario := fDMCadConta.qryConsultaCOD_CEDENTE.AsString;
       Result := MontaEnvioContaSicredi;
      end;
    end;
    tpConvenio : begin
      MontaConvenioTecnoSpeed := TMontaConvenioTecnoSpeed.New;
      with MontaConvenioTecnoSpeed do
      begin
        ConvenioNumero := fDMCadConta.qryConsultaCOD_CEDENTE.AsString;
        ConvenioDescricao := fDMCadConta.qryConsultaNOME.AsString;
        ConvenioNumero := fDMCadConta.qryConsultaCOD_CEDENTE.AsString;
        ConvenioDescricao := fDMCadConta.qryConsultaNOME.AsString;
        ConvenioCarteira := fDMCadConta.qryConsultaCARTEIRA.AsString;
        ConvenioPadraoCNAB := '400';
        if fDMCadConta.qryConsultaACBR_LAYOUTREMESSA.AsString = 'C240' then
          ConvenioPadraoCNAB := '240';
        ConvenioUtilizaVan := '0';
        Conta := fDMCadConta.qryConsultaID_CONTA_TECNOSPEED.AsString;
        Result := MontaEnvioConvenioSicredi;
      end;
    end;
  end;
end;

procedure TfrmConsConta.FormCreate(Sender: TObject);
begin
  inherited;
  FBoletoX := TspdBoletoX.Create(nil);
  fDMCadConta := TdmCadConta.Create(Self);
  dsConsulta.DataSet := fDMCadConta.qryConsulta;
end;

procedure TfrmConsConta.prc_Enviar_Conta;
var
  _Conta: IspdRetCadastrarConta;
begin
  CarregaConfig(fDMCadConta.qryConsultaFILIAL.AsInteger,1);

  mmEnvio.Lines.Clear;
  mmEnvio.Lines := fnc_Montar_Envio;

  mmResposta.Lines.Clear;
  mmResposta.Refresh;
  mmResposta.Lines.BeginUpdate;
  try
    _Conta := FBoletoX.CadastrarConta(mmEnvio.Lines.Text);

    mmResposta.Lines.Clear;
    mmResposta.Lines.Add('.:: Cadastrar Conta ::.');
    mmResposta.Lines.Add('Mensgem: '          + _Conta.Mensagem);
    mmResposta.Lines.Add('Status: '           + _Conta.Status);
    mmResposta.Lines.Add('Erro de conexão: '  + _Conta.ErroConexao);
    mmResposta.Lines.Add('');

    if _Conta.Status = 'SUCESSO' then
    begin
      mmResposta.Lines.Add('  Id Conta: '            + _Conta.IdConta);
      mmResposta.Lines.Add('  Código Banco: '        + _Conta.CodigoBanco);
      mmResposta.Lines.Add('  Agência: '             + _Conta.Agencia);
      mmResposta.Lines.Add('  AgênciaDV: '           + _Conta.AgenciaDV);
      mmResposta.Lines.Add('  Conta: '               + _Conta.Conta);
      mmResposta.Lines.Add('  Conta DV: '            + _Conta.ContaDV);
      mmResposta.Lines.Add('  Tipo Conta: '          + _Conta.TipoConta);
      mmResposta.Lines.Add('  Código Beneficário: '  + _Conta.CodigoBeneficiario);
      mmResposta.Lines.Add('  Código Empresa: '      + _Conta.CodigoEmpresa);
      mmResposta.Lines.Add('');
      fDMCadConta.prc_Abrir_Conta(fDMCadConta.qryConsultaID.AsInteger);
      fDMCadConta.prc_Gravar_Conta(StrToInt(_Conta.IdConta));
    end;
    mmResposta.SelStart  := 1;
    mmResposta.SelLength := 1;
  finally
    mmResposta.Lines.EndUpdate;
    mmEnvio.Lines.Clear;
    pg_Principal.ActivePage := ts_Mensagem;
  end;

end;

procedure TfrmConsConta.prc_Enviar_Convenio;
var
 _Convenio: IspdRetCadastrarConvenio;
begin
  CarregaConfig(fDMCadConta.qryConsultaFILIAL.AsInteger,1);

  mmEnvio.Lines.Clear;
  mmEnvio.Lines := fnc_Montar_Envio;

  mmResposta.Lines.Clear;
  mmResposta.Refresh;
  mmResposta.Lines.BeginUpdate;
  try
    _Convenio := FBoletoX.CadastrarConvenio(mmEnvio.Lines.Text);

    mmResposta.Lines.Clear;
    mmResposta.Lines.Add('.:: Cadastrar Convênio ::.');
    mmResposta.Lines.Add('Mensgem: '         + _Convenio.Mensagem);
    mmResposta.Lines.Add('Status: '          + _Convenio.Status);
    mmResposta.Lines.Add('Erro de conexão: ' + _Convenio.ErroConexao);
    mmResposta.Lines.Add('');

    if _Convenio.Status = 'SUCESSO' then
    begin
      mmResposta.Lines.Add('  Id Convênio: '               + _Convenio.IdConvenio);
      mmResposta.Lines.Add('  Número Convênio: '           + _Convenio.NumeroConvenio);
      mmResposta.Lines.Add('  Descrição: '                 + _Convenio.DescricaoConvenio);
      mmResposta.Lines.Add('  Carteira: '                  + _Convenio.Carteira);
      mmResposta.Lines.Add('  Espécie: '                   + _Convenio.Especie);
      mmResposta.Lines.Add('  Padrão CNAB: '               + _Convenio.PadraoCNAB);
      mmResposta.Lines.Add('  Utiliza VAN: '               + BoolToStr(_Convenio.UtilizaVan));
      mmResposta.Lines.Add('  Número Remessa: '            + _Convenio.NumeroRemessa);
      mmResposta.Lines.Add('  Reiniciar Número Remessa: '  + BoolToStr(_Convenio.ReiniciarDiariamente));
      mmResposta.Lines.Add('');
      fDMCadConta.prc_Abrir_Conta(fDMCadConta.qryConsultaID.AsInteger);
      fDMCadConta.prc_Gravar_Convenio(StrToInt(_Convenio.IdConvenio));
    end;

    mmResposta.SelStart  := 1;
    mmResposta.SelLength := 1;
  finally
    mmResposta.Lines.EndUpdate;
    mmEnvio.Lines.Clear;
    pg_Principal.ActivePage := ts_Mensagem;
  end;


end;

end.
