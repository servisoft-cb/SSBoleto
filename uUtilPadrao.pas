unit uUtilPadrao;

interface

uses
 Classes,   FireDAC.Comp.Client, DmdConnection;

  function  SQLLocate(Tabela, CampoProcura, CampoRetorno, ValorFind: string): string ;

var
 vCaminhoBanco: String;

implementation

uses
  System.SysUtils;


function SQLLocate(Tabela, CampoProcura, CampoRetorno, ValorFind: string): string ;
var
  MyQuery: TFDQuery;
begin
  if ValorFind <> '' then
  begin
    MyQuery := TFDQuery.Create(DMConection);
    MyQuery.Connection := DMConection.FDConnection;
    MyQuery.Close;
    MyQuery.SQL.Clear ;
    MyQuery.SQL.Add('select ' + CampoRetorno + ' from ' + Tabela) ;
    MyQuery.SQL.Add('where  ' + CampoProcura + ' = ' + QuotedStr(ValorFind));
    MyQuery.Open ;
    if not MyQuery.EOF then
      SQLLocate := MyQuery.FieldByName(CampoRetorno).AsString
    else
      SQLLocate := '' ;
    MyQuery.Destroy ;
  end
  else
    ValorFind := '' ;
end;

end.
