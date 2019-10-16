unit Classe.Nome.Remessa;

interface

uses
  FireDAC.Comp.Client, uBaseDAO, System.SysUtils, System.DateUtils;

type
  TEnumBanco = (tpBancoBrasil, tpBanrisul, tpCaixaFederal, tpItau, tpSantander, tpBradesco, tpSicredi);

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
    FTipoBanco: TEnumBanco;
  public
    property Extensao: string read FExtensao write FExtensao;
    property NumeroRemessa: string read FNumeroRemessa write FNumeroRemessa;
    property RemessaTeste: Boolean read FRemessaTeste write FRemessaTeste;
    property EndArquivo: string read FEndArquivo write FEndArquivo;
    property NomeIniRemessa: string read FNomeIniRemessa write FNomeIniRemessa;
    property CodigoBanco: string read FCodigoBanco write FCodigoBanco;
    property CodigoCedente: Integer read FCodigoCedente write FCodigoCedente;
    property SequenciaDia : Integer read FSequenciaDia write FSequenciaDia;
    property TipoBanco : TEnumBanco read FTipoBanco write FTipoBanco;
    constructor create;
    destructor destroy; override;
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

constructor TNomeRemessa.create;
begin

end;

destructor TNomeRemessa.destroy;
begin

  inherited;
end;

function TNomeRemessa.GeraNomeArquivo(ID_Conta: string): string;
var
  Dados: TBaseDao;
  vSql: string;
  vQry: TFDQuery;
begin
  result := '';
  if ID_Conta = EmptyStr then
    raise Exception.Create('Código do banco não informado!');
  try
    Dados := TBaseDao.Create;
    vQry := TFDQuery.Create(nil);
    vSql := 'select C.NOME, B.CODIGO, B.INICIAL_NOME_ARQ_REMESSA, C.REMESSA_TESTE, C.NUM_ARQ_REMESSA, C.END_ARQUIVO_REM, ';
    vSql := vSql + 'COALESCE(C.EXTENSAO_ARQ_REM,' + '''REM''' + ')EXTENSAO_ARQ_REM, C.COD_CEDENTE, C.SEQ_REMESSA_DIA ';
    vSql := vSql + 'from CONTAS C ';
    vSql := vSql + 'left join BANCO B on C.ID_BANCO = B.ID ';
    vSql := vSql + 'where C.ID = ' + QuotedStr(ID_Conta);
    vQry := Dados.RetornaDataSet(vSql);

    NumeroRemessa := vQry.FieldByName('NUM_ARQ_REMESSA').AsString;
    Extensao := vQry.FieldByName('EXTENSAO_ARQ_REM').AsString;
    EndArquivo := vQry.FieldByName('END_ARQUIVO_REM').AsString;
    RemessaTeste := vQry.FieldByName('REMESSA_TESTE').AsString = 'S';
    NomeIniRemessa := vQry.FieldByName('INICIAL_NOME_ARQ_REMESSA').AsString;
    CodigoBanco := vQry.FieldByName('CODIGO').AsString;
    CodigoCedente := vQry.FieldByName('COD_CEDENTE').AsInteger;
    SequenciaDia := vQry.FieldByName('SEQ_REMESSA_DIA').AsInteger;
  except
    raise Exception.Create('Erro ao gerar o nome do arquivo do banco');
  end;
  case TipoBanco of
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

  Caminho := EndArquivo + '\' + IntToStr(CodigoCedente) + vMes + FormatFloat('00', Dia) + '.' + Extensao;

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

