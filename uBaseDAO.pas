unit uBaseDAO;

interface

uses FireDAC.Comp.Client, System.SysUtils, Vcl.Dialogs, System.Classes,
  Data.DB, System.StrUtils;

type
  TopField = (opString, opInteger, opDouble, opDate);

type
  TBaseDao = class(TObject)
  private
    FqConsulta: TFDQuery;
    FID: Integer;
    FqUpdate: TFDQuery;
    FOrdemPrincipal: String;
    FGenerator: String;
    FTabela: String;
    FSQLPrincipal: String;
    FSQLFiltro: String;

  public
    _FQry : TFDQuery;
    function RetornaDataSet(pSQL : String) : TFDQuery;
    function ExecutarComando(pSQL : String) : Integer;
    procedure Insert; virtual; abstract;
    procedure Update; virtual; abstract;
    procedure Delete; virtual; abstract;
    function Pesquisar (ID_ , Item_ : integer; preenche : Boolean = True) : Boolean; Virtual; Abstract;
    procedure inicializa; virtual; abstract;
    procedure filtro(param: Boolean);
    function UltCod : Integer; virtual;
    function UltItem(ID_ : Integer) : Integer; virtual;
    constructor Create; virtual;
    destructor Destroy; override;
    function Insert_Sql(Valor:tField;tipo:TopField):string;overload;
    function Insert_Sql(Valor:variant;tipo:TopField):string;overload;

  published
    property qConsulta : TFDQuery read FqConsulta write FqConsulta;
    property qUpdate : TFDQuery read FqUpdate write FqUpdate;
    property ID : Integer read FID write FID;
    property Tabela : String read FTabela Write FTabela;
    property Generator : String read FGenerator Write FGenerator;
    property SQLPrincipal : String read FSQLPrincipal write FSQLPrincipal;
    property OrdemPrincipal : String read FOrdemPrincipal write FOrdemPrincipal;
    property SQLFiltro : String read FSQLFiltro write FSQLFiltro;
  end;

implementation

{ TBaseDao }

uses DmdConnection;

constructor TBaseDao.Create;
begin
  inherited Create;
  _FQry := TFDQuery.Create(nil);
  _FQry.Connection := DMConection.FDConnection;
  qConsulta := TFDQuery.Create(nil);
  qConsulta.Connection := DMConection.FDConnection;
  qUpdate := TFDQuery.Create(nil);
  qUpdate.Connection := DMConection.FDConnection;
end;

destructor TBaseDao.Destroy;
begin
  try
    if Assigned(_FQry) then
      FreeAndNil(_FQry);
  except
    on e: exception do
      raise Exception.Create('Erro: ' + e.Message);
  end;

  try
    if Assigned(qConsulta) then
      qConsulta.Free;
  except
    on e: exception do
      raise Exception.Create('Erro: ' + e.Message);
  end;
  try
    if Assigned(qUpdate) then
      qUpdate.Free
  except
    on e: exception do
      raise Exception.Create('Erro: ' + e.Message);
  end;

  inherited;
end;

function TBaseDao.ExecutarComando(pSQL: String): Integer;
begin
 try
   DMConection.FDConnection.StartTransaction;
   _FQry.SQL.Text := pSQL;
   _FQry.ExecSQL;
   Result := _FQry.RowsAffected;
   DMConection.FDConnection.Commit;
 except
   DMConection.FDConnection.Rollback;
 end;
end;

procedure TBaseDao.filtro(param: Boolean);
begin
  if param then
  begin
    qConsulta.SQL.Clear;
    qConsulta.SQL.Text := SQLFiltro
  end
  else
  begin
    qConsulta.SQL.Clear;
    qConsulta.SQL.Text := SQLPrincipal + OrdemPrincipal;
  end;
end;

function TBaseDao.Insert_Sql(Valor : variant ; tipo: TopField): string;
var
  retorno_str : String;
  retorno_int : Integer;
  retorno_date : TDateTime;
  retorno_float : double;
begin
case tipo of
  opString :
    begin
      try
        retorno_str := Valor;
        retorno_str := QuotedStr(Trim(retorno_str));
      except 
       retorno_str := ''; 
      end;
      Result := retorno_str; 
    end;
  opInteger:
    begin
      try
        retorno_int := Valor;
        retorno_str := IntToStr(retorno_int);
      except 
       retorno_str := '0'; 
      end;
      Result := retorno_str; 
    end;

  opDouble:
    begin
      try
        retorno_float := Valor;
        if Pos(',',FloatToStr(retorno_float)) > 0 then
          retorno_str := AnsiReplaceStr(FloatToStr(retorno_float),',','.')
        else
          retorno_str := FloatToStr(retorno_float);
      except
        retorno_str := '0';
      end;
      Result := retorno_str;    
    end;
  opDate:
    begin
      try
        retorno_date := Valor;
        retorno_str := QuotedStr(FormatDateTime('yyyy/mm/dd',retorno_date));
      except
        retorno_str := 'null';
      end;
      Result := retorno_str;    
    end;
end;
end;

function TBaseDao.Insert_Sql(Valor : tField; tipo: TopField): string;
var
  retorno : String;
begin
  case tipo of
    opString :
      begin
        if Valor.IsNull then
          retorno := QuotedStr('')
        else
          retorno := QuotedStr(trim(Valor.AsString))
      end;
    opInteger:
      begin
        if Valor.IsNull then
          retorno := '0'
        else
          retorno := Valor.asString;
      end;
    opDouble:
      begin
        if Valor.IsNull then
          retorno := '0'
        else
          retorno := AnsiReplaceStr(valor.AsString,',','.');
      end;
    opDate:
      begin
        if Valor.IsNull then
          retorno := QuotedStr('')
        else
          retorno := QuotedStr(FormatDateTime('yyyy/mm/dd',Valor.AsDateTime));
      end;
  end;
  Result := retorno;
end;

function TBaseDao.RetornaDataSet(pSQL: String): TFDQuery;
begin
 _FQry.SQL.Text := pSQL;
 _FQry.Active   := True;
 Result         := _FQry;
end;

function TBaseDao.UltCod: Integer;
var
  Query : TFDQuery;
  Retorno : Integer;
begin
  Query := TFDQuery.Create(nil);
  Query.Connection := DMConection.FDConnection;
  Query.SQL.Clear;
  Query.SQL.Text := 'Select coalesce(GEN_ID(' +Generator+',0),0) as Ret from rdb$database';
  try
    Query.Open;
  except
    Query.Close;
    Query.Free;
  end;
  Retorno := Query.FieldByName('RET').AsInteger;
  Query.Close;
  Query.Free;
  Result := Retorno;
end;

function TBaseDao.UltItem(ID_ : Integer) : Integer;
var
  Query : TFDQuery;
  Retorno : Integer;
begin
  Query := TFDQuery.Create(nil);
  Query.Connection := DMConection.FDConnection;
  Query.SQL.Clear;
  Query.SQL.Add('Select max(coalesce(ITEM,0)) ITEM from ' + Tabela);
  Query.SQL.Add(' where ID = ' + IntToStr(ID_)) ;
  try
    Query.Open;
  except
    Query.Close;
    Query.Free;
  end;
  Retorno := Query.FieldByName('ITEM').AsInteger + 1;
  Query.Close;
  Query.Free;
  Result := Retorno;
end;

end.
