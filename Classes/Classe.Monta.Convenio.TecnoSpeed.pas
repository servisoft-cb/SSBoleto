unit Classe.Monta.Convenio.TecnoSpeed;

interface

uses
  System.Classes;

type
  TMontaConvenioTecnoSpeed = class
    private
      FConvenioUtilizaVan: String;
      FConvenioEspecie: String;
      FConvenioDescricao: String;
      FConvenioNumero: String;
      FConvenioPadraoCNAB: String;
      FConta: String;
      FConvenioCarteira: String;

    public
      property ConvenioNumero : String read FConvenioNumero write FConvenioNumero;
      property ConvenioDescricao : String read FConvenioDescricao write FConvenioDescricao;
      property ConvenioCarteira : String read FConvenioCarteira write FConvenioCarteira;
      property ConvenioEspecie : String read FConvenioEspecie write FConvenioEspecie;
      property ConvenioPadraoCNAB : String read FConvenioPadraoCNAB write FConvenioPadraoCNAB;
      property ConvenioUtilizaVan : String read FConvenioUtilizaVan write FConvenioUtilizaVan;
      property Conta : String read FConta write FConta;
      constructor Create;
      destructor Destroy; override;
      class function new : TMontaConvenioTecnoSpeed;
      function MontaEnvioConvenioSicredi : TStringList;

  end;

implementation

{ TMontaConvenioTecnoSpeed }

constructor TMontaConvenioTecnoSpeed.Create;
begin

end;

destructor TMontaConvenioTecnoSpeed.Destroy;
begin

  inherited;
end;

function TMontaConvenioTecnoSpeed.MontaEnvioConvenioSicredi: TStringList;
begin
  Result := TStringList.Create;
  Result.Add('INCLUIRCONTACONVENIO');
  Result.Add('ConvenioNumero=' + ConvenioNumero);
  Result.Add('ConvenioDescricao=' + ConvenioDescricao);
  Result.Add('ConvenioCarteira=' + ConvenioCarteira);
  Result.Add('ConvenioEspecie=R$');
  Result.Add('ConvenioPadraoCNAB=' + ConvenioPadraoCNAB);
  Result.Add('ConvenioUtilizaVan=' + ConvenioUtilizaVan);
  Result.Add('Conta=' + Conta);
  Result.Add('SALVARCONTACONVENIO');
end;

class function TMontaConvenioTecnoSpeed.new: TMontaConvenioTecnoSpeed;
begin
  Result := TMontaConvenioTecnoSpeed.Create;
end;

end.
