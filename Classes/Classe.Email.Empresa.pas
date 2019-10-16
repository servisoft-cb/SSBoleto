unit Classe.Email.Empresa;

interface

uses
  uBaseDAO;

type
  TEnumTipo = (opNFe, opNFSe, opFinanceiro, opCompras, opOrcamento, opPedido, opPedidoConferido);

type
  TEmailEmpresa = class(TBaseDao)
  private
    FID: Integer;
    FEmail: string;
    FTipo: TEnumTipo;
    FNomeEmail: string;
  public
    property ID: Integer read FID write FID;
    property Tipo: TEnumTipo read FTipo write FTipo;
    property Email: string read FEmail write FEmail;
    property NomeEmail: string read FNomeEmail write FNomeEmail;
    constructor create; override;
    destructor destroy; override;
    function Retornar_Email(Filial: Integer; Tipo: TEnumTipo): Boolean;
  end;

implementation

{ TEmailEmpresa }

constructor TEmailEmpresa.create;
begin
  inherited;

end;

destructor TEmailEmpresa.destroy;
begin

  inherited;
end;

function TEmailEmpresa.Retornar_Email(Filial: Integer; Tipo: TEnumTipo): Boolean;
begin
  try
    qConsulta.Close;
    qConsulta.SQL.Clear;
    qConsulta.SQL.Add('select CE.REMETENTE_NOME, CE.REMETENTE_EMAIL ');
    qConsulta.SQL.Add('FROM FILIAL_EMAIL FE ');
    qConsulta.SQL.Add('inner join CONFIG_EMAIL CE on FE.ID_CONFIG_EMAIL = CE.ID ');
    qConsulta.SQL.Add('where FE.ID = ' + Insert_Sql(Filial, opInteger));
    case Tipo of
      opNFe:
        qConsulta.SQL.Add(' AND FE.TIPO_REG = 1');
      opNFSe:
        qConsulta.SQL.Add(' AND FE.TIPO_REG = 2');
      opFinanceiro:
        qConsulta.SQL.Add(' AND FE.TIPO_REG = 3');
      opCompras:
        qConsulta.SQL.Add(' AND FE.TIPO_REG = 4');
      opOrcamento:
        qConsulta.SQL.Add(' AND FE.TIPO_REG = 5');
      opPedido:
        qConsulta.SQL.Add(' AND FE.TIPO_REG = 5');
      opPedidoConferido:
        qConsulta.SQL.Add(' AND FE.TIPO_REG = 6');
    end;
    qConsulta.Open;
    Email := qConsulta.FieldByName('REMETENTE_EMAIL').AsString;
    NomeEmail := qConsulta.FieldByName('REMETENTE_NOME').AsString;
    qConsulta.Close;
    Result := True;
  except
    Result := False;
  end;
end;

end.

