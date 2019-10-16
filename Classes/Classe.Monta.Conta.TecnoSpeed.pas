unit Classe.Monta.Conta.TecnoSpeed;

interface

uses
  System.Classes;

type
  TMontaContaTecnoSpeed = class
    private
    FCodigoBanco: String;
    FContaCodigoBeneficiario: String;
    FContaNumero: String;
    FContaNumeroDV: String;
    FContaAgencia: String;
    FContaTipo: String;
    FContaAgenciaDV: String;

    public
      property CodigoBanco : String read FCodigoBanco write FCodigoBanco;
      property ContaAgencia : String read FContaAgencia write FContaAgencia;
      property ContaAgenciaDV : String read FContaAgenciaDV write FContaAgenciaDV;
      property ContaNumero : String read FContaNumero write FContaNumero;
      property ContaNumeroDV : String read FContaNumeroDV write FContaNumeroDV;
      property ContaTipo : String read FContaTipo write FContaTipo;
      property ContaCodigoBeneficiario : String read FContaCodigoBeneficiario write FContaCodigoBeneficiario;
      constructor Create;
      destructor Destroy; override;
      class function new : TMontaContaTecnoSpeed;
      function MontaEnvioContaSicredi : TStringList;
  end;

implementation

{ TMontaContaTecnoSpeed }

constructor TMontaContaTecnoSpeed.Create;
begin

end;

destructor TMontaContaTecnoSpeed.Destroy;
begin

  inherited;
end;

function TMontaContaTecnoSpeed.MontaEnvioContaSicredi: TStringList;
begin
  Result := TStringList.Create;
  Result.Add('INCLUIRCEDENTECONTA');
  Result.Add('ContaCodigoBanco=' + CodigoBanco);
  Result.Add('ContaAgencia=' + ContaAgencia + ContaAgenciaDV);
  Result.Add('ContaAgenciaDV=' + '');
  Result.Add('ContaNumero=' + ContaNumero);
  Result.Add('ContaNumeroDV=' + ContaNumeroDV);
  Result.Add('ContaTipo=' + 'CORRENTE');
  Result.Add('ContaCodigoBeneficiario=' + ContaCodigoBeneficiario);
  Result.Add('SALVARCEDENTECONTA');
end;

class function TMontaContaTecnoSpeed.new: TMontaContaTecnoSpeed;
begin
  Result := TMontaContaTecnoSpeed.Create();
end;

end.
