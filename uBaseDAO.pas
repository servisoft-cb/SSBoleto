unit uBaseDAO;

interface

uses FireDAC.Comp.Client, System.SysUtils, Vcl.Dialogs, System.Classes;

type
  TBaseDao = class(TObject)
  private

  public
    _FQry : TFDQuery;
    constructor Create;
    destructor Destroy; override;
    function RetornaDataSet(pSQL : String) : TFDQuery;
    function ExecutarComando(pSQL : String) : Integer;
  end;

implementation

{ TBaseDao }

uses DmdConnection;

constructor TBaseDao.Create;
begin
  inherited Create;
  _FQry := TFDQuery.Create(Nil);
  _FQry.Connection := DMConection.FDConnection;
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

function TBaseDao.RetornaDataSet(pSQL: String): TFDQuery;
begin
 _FQry.SQL.Text := pSQL;
 _FQry.Active   := True;
 Result         := _FQry;
end;

end.
