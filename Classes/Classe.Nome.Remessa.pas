unit Classe.Nome.Remessa;

interface

uses
  FireDAC.Comp.Client, uBaseDAO, System.SysUtils, System.DateUtils;

type
  TEnumBanco = (tpBancoBrasil = '001', tpBanrisul = '041', tpCaixaFederal = '104', tpItau = '341', tpSantander = '033', tpBradesco = '237', tpSicredi = '748');

type
  TNomeRemessa = class
  private
    FExtensao: string;
    FNumeroRemessa: string;
    FRemessaTeste: Boolean;
    FEndArquivo: string;
    FNomeIniRemessa: string;
    FCodigoBanco: string;
    FCodigoCedente: Integer;
    FSequenciaDia: Integer;
  public
    property Extensao: string read FExtensao write FExtensao;
    property NumeroRemessa: string read FNumeroRemessa write FNumeroRemessa;
    property RemessaTeste: Boolean read FRemessaTeste write FRemessaTeste;
    property EndArquivo: string read FEndArquivo write FEndArquivo;
    property NomeIniRemessa: string read FNomeIniRemessa write FNomeIniRemessa;
    property CodigoBanco: string read FCodigoBanco write FCodigoBanco;
    property CodigoCedente: Integer read FCodigoCedente write FCodigoCedente;
    property SequenciaDia : Integer read FSequenciaDia write FSequenciaDia;
    class function New: TNomeRemessa;
    function GeraNomeArquivo(ID_Conta: string): string;
    function GeraNomerArquivoSicredi: string;
    function GeraNomerArquivoBradesco: string;
    function GeraNomerArquivoCaixaFederal: string;
  end;

implementation

uses
  System.TypInfo;

{ TNomeRemessa }


{ TNomeRemessa }

function TNomeRemessa.GeraNomeArquivo(ID_Conta: string): string;
var
  _Dados: TBaseDao;
  vSql: string;
  _vQry: TFDQuery;
begin
  result := '';
  if ID_Conta = EmptyStr then
    raise Exception.Create('Código do banco não informado!');
  try
    _Dados := TBaseDao.Create;
    _vQry := TFDQuery.Create(nil);
    vSql := 'select C.NOME, B.CODIGO, B.INICIAL_NOME_ARQ_REMESSA, C.REMESSA_TESTE, C.NUM_ARQ_REMESSA, C.END_ARQUIVO_REM, ';
    vSql := vSql + 'C.EXTENSAO_ARQ_REM, C.COD_CEDENTE, C.SEQ_REMESSA_DIA ';
    vSql := vSql + 'from CONTAS C ';
    vSql := vSql + 'left join BANCO B on C.ID_BANCO = B.ID ';
    vSql := vSql + 'where C.ID = ' + QuotedStr(ID_Conta);
    _vQry := _Dados.RetornaDataSet(vSql);

    NumeroRemessa := _vQry.FieldByName('NUM_ARQ_REMESSA').Value;
    Extensao := _vQry.FieldByName('EXTENSAO_ARQ_REM').Value;
    EndArquivo := _vQry.FieldByName('END_ARQUIVO_REM').Value;
    RemessaTeste := _vQry.FieldByName('REMESSA_TESTE').AsString = 'S';
    NomeIniRemessa := _vQry.FieldByName('INICIAL_NOME_ARQ_REMESSA').Value;
    CodigoBanco := _vQry.FieldByName('CODIGO').Value;
    CodigoCedente := _vQry.FieldByName('COD_CEDENTE').Value;
    SequenciaDia := _vQry.FieldByName('SEQ_REMESSA_DIA').Value;
  except
    raise Exception.Create('Erro ao gerar o nome do arquivo do banco');
  end;
  Result := EndArquivo;
  case TEnumBanco(GetEnumValue(TypeInfo(TEnumBanco), CodigoBanco)) of
    tpSicredi : Result := GeraNomerArquivoSicredi;
    tpBradesco : Result := GeraNomerArquivoBradesco;
    tpCaixaFederal : Result := GeraNomerArquivoCaixaFederal
  end;
end;

function TNomeRemessa.GeraNomerArquivoBradesco: string;
begin
  Result := NomeIniRemessa + FormatFloat('00', DayOf(Date)) + FormatFloat('00', MonthOf(Date)) + FormatFloat('00',SequenciaDia);
  if RemessaTeste then
    Result := Result + '.TST'
  else
    Result := Result + '.REM';
end;

function TNomeRemessa.GeraNomerArquivoCaixaFederal: string;
begin
  Result := NomeIniRemessa + FormatFloat('00', DayOf(Date)) + formatFloat('0000', StrToInt(NumeroRemessa)) + FormatFloat('0', SequenciaDia);
  if Extensao = '' then
    Extensao := 'REM';
end;

function TNomeRemessa.GeraNomerArquivoSicredi: string;
var
  ano, mes, dia : Word;
  vMes : String;
  Caminho : String;
  ExisteArquivo : Boolean;
  i : Integer;
begin
  i := 1;
  ExisteArquivo := True;
  DecodeDate(Date, ano, mes, dia);
  case mes of
    1 :  vMes := '1';
    2 :  vMes := '2';
    3 :  vMes := '3';
    4 :  vMes := '4';
    5 :  vMes := '5';
    6 :  vMes := '6';
    7 :  vMes := '7';
    8 :  vMes := '8';
    9 :  vMes := '9';
    10 : vMes := 'O';
    11 : vMes := 'N';
    12 : vMes := 'D';
  end;

  Caminho := Caminho + '\' + CodigoBanco + vMes + FormatFloat('00', Dia);

  while ExisteArquivo do
  begin
    if (FileExists(Caminho)) then
    begin
      inc(i);
      Delete(Caminho, Length(Caminho) - 2, 3);
      Caminho := Caminho + 'RM' + IntToStr(i);
      ExisteArquivo := True;
    end
    else
      ExisteArquivo := False;
  end;
  Result := Caminho;
end;

class function TNomeRemessa.New: TNomeRemessa;
begin
  Result := Self.Create;
end;

end.

