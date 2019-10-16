unit uConfigTecnoSpeed;

interface

uses uBaseDAO, FireDAC.Comp.Client;

type
  TConfigTecnoSpeed = class(TObject)
  private
    FToken: String;
    FTipoAmbiente: String;
    FCNPJCedente: String;
    FCNPJSH: String;
    FURL: String;
  public
    constructor Create(ID : Integer; Tipo : Integer);
    destructor Destroy; override;
    property Token : String read FToken write FToken;
    property TipoAmbiente : String read FTipoAmbiente write FTipoAmbiente;
    property CNPJCedente : String read FCNPJCedente write FCNPJCedente;
    property CNPJSH : String read FCNPJSH write FCNPJSH;
    property URL : String read FURL write FURL;
  end;

implementation

uses
  System.SysUtils;

{ TConfigTecnoSpeed }


{ TConfigTecnoSpeed }

constructor TConfigTecnoSpeed.Create(ID, Tipo: Integer);
var
  _Dados : TBaseDao;
  vSql : String;
  _vQry : TFDQuery;
begin
  if ID = 0 then
    raise Exception.Create('Filial não informada na SoftwareHouse!');

  if Tipo = 0 then
    raise Exception.Create('Tipo não informado!');

  _Dados := TBaseDao.Create;
  _vQry := TFDQuery.Create(nil);
  vSql := 'select F.CNPJ_CPF, FS.TIPO, FS.TOKEN, FS.CNPJ, FS.AMBIENTE_ENVIO, FS.URL_PRODUCAO, FS.URL_HOMOLOGACAO ' +
          'from FILIAL F ' +
          'left join FILIAL_SOFTWAREHOUSE FS ON F.ID = FS.ID ' +
          'where FS.ID = ' + IntToStr(ID) +' and FS.TIPO = ' + IntToStr(Tipo);
   _vQry       := _Dados.RetornaDataSet(vSql);
  Token        := _vQry.FieldByName('Token').AsString;
  CNPJSH       := _vQry.FieldByName('CNPJ').AsString;
  CNPJCedente  := _vQry.FieldByName('CNPJ_CPF').AsString;
  TipoAmbiente := _vQry.FieldByName('AMBIENTE_ENVIO').AsString;
  if TipoAmbiente = 'P' then
    URL := _vQry.FieldByName('URL_PRODUCAO').AsString
  else       ////
    URL := _vQry.FieldByName('URL_HOMOLOGACAO').AsString;
end;

destructor TConfigTecnoSpeed.Destroy;
begin

  inherited;
end;

end.
