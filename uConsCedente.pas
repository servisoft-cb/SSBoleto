unit uConsCedente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uConsPadrao, Data.DB, Vcl.StdCtrls,
  SMultiBtn, Vcl.Grids, Vcl.DBGrids, SMDBGrid, Vcl.ExtCtrls, uDMCadCedente,
  Vcl.ComCtrls, uConfigTecnoSpeed, Vcl.OleCtrls, BoletoX_TLB;

type
  TfrmConsCedente = class(TfrmConsPadrao)
    btnEnviar: TSMButton;
    spdBoletoX1: TspdBoletoX;
    ts_Mensagem: TTabSheet;
    mmEnvio: TMemo;
    mmResposta: TMemo;
    edtIDCedente: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CarregaConfig(Filial : Integer; Tipo : Integer);
    procedure btnEnviarClick(Sender: TObject);
    function fnc_Montar_Envio : TStringList;
  private

    { Private declarations }
  public
    { Public declarations }
    FBoletoX: TspdBoletoX;
    procedure DoOnBoletoException(ASender: TObject; const aExceptionMessage: WideString);
  end;

var
  frmConsCedente: TfrmConsCedente;
  fDMCadCedente : TdmCadCedente;

implementation

{$R *.dfm}


procedure TfrmConsCedente.btnConsultarClick(Sender: TObject);
begin
  inherited;
  fDMCadCedente.qryConsulta.Open;
end;

procedure TfrmConsCedente.CarregaConfig(Filial, Tipo: Integer);
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

procedure TfrmConsCedente.DoOnBoletoException(ASender: TObject;
  const aExceptionMessage: WideString);
begin
  MessageBox(0, PChar(aExceptionMessage), 'Exceção do BoletoX', MB_ICONERROR or MB_OK);
end;

procedure TfrmConsCedente.FormCreate(Sender: TObject);
begin
  inherited;
  FBoletoX := TspdBoletoX.Create(nil);
end;

procedure TfrmConsCedente.FormShow(Sender: TObject);
begin
  inherited;
  fDMCadCedente := TdmCadCedente.Create(Self);
end;

function TfrmConsCedente.fnc_Montar_Envio: TStringList;
begin
  Result := TStringList.Create;
  Result.Add('INCLUIRCEDENTE');
  Result.Add('CedenteRazaoSocial='+ fDMCadCedente.qryConsultaNOME.AsString);
  Result.Add('CedenteNomeFantasia=' + fDMCadCedente.qryConsultaNOME_INTERNO.AsString);
  Result.Add('CedenteCPFCNPJ=' + fDMCadCedente.qryConsultaCNPJ_CPF.AsString);
  Result.Add('CedenteEnderecoLogradouro=' + fDMCadCedente.qryConsultaENDERECO.AsString);
  Result.Add('CedenteEnderecoNumero=' + fDMCadCedente.qryConsultaNUM_END.AsString);
  Result.Add('CedenteEnderecoComplemento=' + fDMCadCedente.qryConsultaCOMPLEMENTO_END.AsString);
  Result.Add('CedenteEnderecoBairro=' + fDMCadCedente.qryConsultaBAIRRO.AsString);
  Result.Add('CedenteEnderecoCEP=' + fDMCadCedente.qryConsultaCEP.AsString);
  Result.Add('CedenteEnderecoCidadeIBGE=' + fDMCadCedente.qryConsultaCODMUNICIPIO.AsString);
  Result.Add('CedenteTelefone=(' + fDMCadCedente.qryConsultaDDD1.AsString + ') ' + fDMCadCedente.qryConsultaFONE1.AsString);
  Result.Add('CedenteEmail=' + fDMCadCedente.qryConsultaEMAIL_FINANCEIRO.AsString);
  Result.Add('SALVARCEDENTE');
end;

procedure TfrmConsCedente.btnEnviarClick(Sender: TObject);
var
  _Cedente: IspdRetCadastrarCedente;
begin
  inherited;
  CarregaConfig(fDMCadCedente.qryConsultaID.AsInteger,1);

  mmEnvio.Lines.Clear;
  mmEnvio.Lines := fnc_Montar_Envio;

  mmResposta.Lines.Clear;
  mmResposta.Refresh;
  mmResposta.Lines.BeginUpdate;
  try
    _Cedente := FBoletoX.CadastrarCedente (mmEnvio.Lines.Text);
    mmResposta.Lines.Clear;
    mmResposta.Lines.Add('.:: Cadastrar Cedente ::.');
    mmResposta.Lines.Add('Mensgem: '          + _Cedente.Mensagem);
    mmResposta.Lines.Add('Status: '           + _Cedente.Status);
    mmResposta.Lines.Add('Erro de conexão: '  + _Cedente.ErroConexao);
    mmResposta.Lines.Add('');
    if _Cedente.Status = 'SUCESSO' then
    begin
      mmResposta.Lines.Add('  Id Cedente: '     + _Cedente.IdCedente);
      mmResposta.Lines.Add('  Situacao: '       + _Cedente.Situacao);
      mmResposta.Lines.Add('  Token: '          + _Cedente.Token);
      mmResposta.Lines.Add('  CPF / CNPJ: '     + _Cedente.CpfCnpj);
      mmResposta.Lines.Add('  Razao Social: '   + _Cedente.RazaoSocial);
      mmResposta.Lines.Add('  Nome Fantasia: '  + _Cedente.NomeFantasia);
      mmResposta.Lines.Add('');
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
