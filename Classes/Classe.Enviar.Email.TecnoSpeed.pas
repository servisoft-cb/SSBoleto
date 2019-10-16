unit Classe.Enviar.Email.TecnoSpeed;

interface

uses
  System.Classes;

type
  TEnviarEmailTecnoSpeed = class
    private
    FIDIntegracao: string;
    FEmailNomeRemetente: String;
    FEmailRemetente: String;
    FEmailAssunto: string;
    FEmailDestinatario: string;
    FEmailAnexar: Boolean;
    FTipoImpressao: String;
    FOutrosAnexos: String;
    FEmailMensagem: string;
    public
      property IDIntegracao : string read FIDIntegracao write FIDIntegracao;
      property EmailNomeRemetente : String read FEmailNomeRemetente write FEmailNomeRemetente;
      property EmailRemetente : String read FEmailRemetente write FEmailRemetente;
      property EmailAssunto : string read FEmailAssunto write FEmailAssunto;
      property EmailMensagem : string read FEmailMensagem write FEmailMensagem;
      property EmailDestinatario : string read FEmailDestinatario write FEmailDestinatario;
      property EmailAnexar : Boolean read FEmailAnexar write FEmailAnexar;
      property TipoImpressao : String read FTipoImpressao write FTipoImpressao;
      property OutrosAnexos : String read FOutrosAnexos write FOutrosAnexos;
      constructor create;
      destructor destroy; override;
      class function new : TEnviarEmailTecnoSpeed;
      function MontaEmailBoleto : TStringList;
  end;

implementation

{ TEnviarEmailTecnoSpeed }

constructor TEnviarEmailTecnoSpeed.create;
begin

end;

destructor TEnviarEmailTecnoSpeed.destroy;
begin

  inherited;
end;

function TEnviarEmailTecnoSpeed.MontaEmailBoleto: TStringList;
begin
  Result := TStringList.Create;
  Result.Add('INCLUIREMAIL');
  Result.Add('IdIntegracao=' + IDIntegracao);
  Result.Add('EmailNomeRemetente=' + EmailNomeRemetente);
  Result.Add('EmailRemetente=' + EmailRemetente);
  Result.Add('EmailAssunto=' + EmailAssunto);
  Result.Add('EmailMensagem=' + EmailMensagem);
  Result.Add('EmailDestinatario=' + EmailDestinatario);
  Result.Add('EmailAnexarBoleto=true');
  if not EmailAnexar then
    Result.Add('EmailAnexarBoleto=false');
  Result.Add('TipoImpressao=' + TipoImpressao);
  Result.Add('OutrosAnexos=' + OutrosAnexos);
  Result.Add('SALVAREMAIL')
end;

class function TEnviarEmailTecnoSpeed.new: TEnviarEmailTecnoSpeed;
begin
  Result := TEnviarEmailTecnoSpeed.Create;
end;

end.
