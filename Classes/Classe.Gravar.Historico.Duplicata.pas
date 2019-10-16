unit Classe.Gravar.Historico.Duplicata;

interface

uses
  uBaseDAO;

type
  TDuplicataHistorico = class(TBaseDao)
  private
    FID: Integer;
    FNUMCHEQUE: Integer;
    FID_HISTORICO: Integer;
    FVLR_DESCONTOS: Double;
    FVLR_JUROSPAGOS: Double;
    FTIPO_HISTORICO: string;
    FITEM: Integer;
    FCOMPLEMENTO: string;
    FVLR_JUROSCALCULADO: Double;
    FVLR_PAGAMENTO: Double;
    FVLR_DEVOLUCAO: Double;
    FVLR_DESPESAS: Double;
    FDTLANCAMENTO: TDateTime;
    FVLR_LANCAMENTO: Double;
    FEND_ARQUIVO_REM: string;
    FDTHISTORICO: TDateTime;
    FID_COMISSAO: Integer;
    FTIPO_ES: string;
    FID_CONTA: Integer;
    FDTPREVISAO_CHEQUE: TDateTime;
    FID_FORMA_PAGAMENTO: Integer;
    FID_DESCONTADA: Integer;
    FID_OCORRENCIA: Integer;
    FID_ESPECIE: Integer;
    FVLR_TAXA_BANCARIA: Double;
    FNUM_REMESSA: Integer;
    FID_CARTEIRA: Integer;
    FVLR_MULTA: Double;
    function pesquisa(id_: integer; preenche: Boolean): Boolean;
  public
    property ID: Integer read FID write FID;
    property ITEM: Integer read FITEM write FITEM;
    property TIPO_HISTORICO: string read FTIPO_HISTORICO write FTIPO_HISTORICO;
    property ID_HISTORICO: Integer read FID_HISTORICO write FID_HISTORICO;
    property COMPLEMENTO: string read FCOMPLEMENTO write FCOMPLEMENTO;
    property VLR_PAGAMENTO: Double read FVLR_PAGAMENTO write FVLR_PAGAMENTO;
    property VLR_JUROSPAGOS: Double read FVLR_JUROSPAGOS write FVLR_JUROSPAGOS;
    property VLR_DESCONTOS: Double read FVLR_DESCONTOS write FVLR_DESCONTOS;
    property VLR_DESPESAS: Double read FVLR_DESPESAS write FVLR_DESPESAS;
    property VLR_DEVOLUCAO: Double read FVLR_DEVOLUCAO write FVLR_DEVOLUCAO;
    property VLR_JUROSCALCULADO: Double read FVLR_JUROSCALCULADO write FVLR_JUROSCALCULADO;
    property NUMCHEQUE: Integer read FNUMCHEQUE write FNUMCHEQUE;
    property DTPREVISAO_CHEQUE: TDateTime read FDTPREVISAO_CHEQUE write FDTPREVISAO_CHEQUE;
    property ID_CONTA: Integer read FID_CONTA write FID_CONTA;
    property ID_COMISSAO: Integer read FID_COMISSAO write FID_COMISSAO;
    property TIPO_ES: string read FTIPO_ES write FTIPO_ES;
    property DTHISTORICO: TDateTime read FDTHISTORICO write FDTHISTORICO;
    property DTLANCAMENTO: TDateTime read FDTLANCAMENTO write FDTLANCAMENTO;
    property VLR_LANCAMENTO: Double read FVLR_LANCAMENTO write FVLR_LANCAMENTO;
    property ID_FORMA_PAGAMENTO: Integer read FID_FORMA_PAGAMENTO write FID_FORMA_PAGAMENTO;
    property END_ARQUIVO_REM: string read FEND_ARQUIVO_REM write FEND_ARQUIVO_REM;
    property NUM_REMESSA: Integer read FNUM_REMESSA write FNUM_REMESSA;
    property ID_CARTEIRA: Integer read FID_CARTEIRA write FID_CARTEIRA;
    property ID_ESPECIE: Integer read FID_ESPECIE write FID_ESPECIE;
    property ID_OCORRENCIA: Integer read FID_OCORRENCIA write FID_OCORRENCIA;
    property VLR_TAXA_BANCARIA: Double read FVLR_TAXA_BANCARIA write FVLR_TAXA_BANCARIA;
    property ID_DESCONTADA: Integer read FID_DESCONTADA write FID_DESCONTADA;
    property VLR_MULTA: Double read FVLR_MULTA write FVLR_MULTA;
    constructor create;override;
    destructor destroy; override;
    procedure Insert; override;
    procedure Update; override;
    procedure Delete; override;
    procedure inicializa; override;
    function pesquisar(id_, Item_:integer; preenche:Boolean=True):Boolean; override;
  end;

implementation

uses
  System.SysUtils;

{ FDuplicataHistorico }

constructor TDuplicataHistorico.create;
begin
  inherited;
  Tabela := 'DUPLICATA_HIST';
  SQLPrincipal := 'SELECT * FROM ' + Tabela;
  OrdemPrincipal := '';
  filtro(False);
end;

procedure TDuplicataHistorico.Delete;
begin

end;

destructor TDuplicataHistorico.destroy;
begin

  inherited;
end;

procedure TDuplicataHistorico.inicializa;
begin
  inherited;
    ID := 0;
    NUMCHEQUE := 0;
    ID_HISTORICO := 0;
    VLR_DESCONTOS := 0;
    VLR_JUROSPAGOS := 0;
    TIPO_HISTORICO := '';
    ITEM := 0;
    COMPLEMENTO := '';
    VLR_JUROSCALCULADO := 0;
    VLR_PAGAMENTO := 0;
    VLR_DEVOLUCAO := 0;
    VLR_DESPESAS := 0;
    DTLANCAMENTO := 0;
    VLR_LANCAMENTO := 0;
    END_ARQUIVO_REM := '';
    DTHISTORICO := 0;
    ID_COMISSAO := 0;
    TIPO_ES := '';
    ID_CONTA := 0;
    DTPREVISAO_CHEQUE := 0;
    ID_FORMA_PAGAMENTO := 0;
    ID_DESCONTADA := 0;
    ID_OCORRENCIA := 0;
    ID_ESPECIE := 0;
    VLR_TAXA_BANCARIA := 0;
    NUM_REMESSA := 0;
    ID_CARTEIRA := 0;
    VLR_MULTA := 0;
end;

procedure TDuplicataHistorico.Insert;
begin
  inherited;
  qUpdate.SQL.Clear;
  qUpdate.SQL.Add('INSERT INTO ' + Tabela + '(');
  qUpdate.SQL.Add('ID, ITEM, TIPO_HISTORICO, ID_HISTORICO, ');
  qUpdate.SQL.Add('COMPLEMENTO, VLR_PAGAMENTO, VLR_JUROSPAGOS, ');
  qUpdate.SQL.Add('VLR_DESCONTOS, VLR_DESPESAS, VLR_DEVOLUCAO, ');
  qUpdate.SQL.Add('VLR_JUROSCALCULADO, NUMCHEQUE, DTPREVISAO_CHEQUE, ');
  qUpdate.SQL.Add('ID_CONTA, ID_COMISSAO, TIPO_ES, DTHISTORICO, DTLANCAMENTO, ');
  qUpdate.SQL.Add('VLR_LANCAMENTO, ID_FORMA_PAGAMENTO, END_ARQUIVO_REM, ');
  qUpdate.SQL.Add('NUM_REMESSA, ID_CARTEIRA, ID_ESPECIE, ');
  qUpdate.SQL.Add('ID_OCORRENCIA, VLR_TAXA_BANCARIA, ID_DESCONTADA, VLR_MULTA)');
  qUpdate.SQL.Add('VALUES (');
  qUpdate.SQL.Add(Insert_Sql(ID,opInteger) + ',');
  qUpdate.SQL.Add(Insert_Sql(UltItem(ID),opInteger) + ',');
  qUpdate.SQL.Add(Insert_Sql(TIPO_HISTORICO,opString) + ',');
  qUpdate.SQL.Add(Insert_Sql(ID_HISTORICO,opInteger) + ',');
  qUpdate.SQL.Add(Insert_Sql(COMPLEMENTO,opString) + ',');
  qUpdate.SQL.Add(Insert_Sql(VLR_PAGAMENTO,opDouble) + ',');
  qUpdate.SQL.Add(Insert_Sql(VLR_JUROSPAGOS,opDouble) + ',');
  qUpdate.SQL.Add(Insert_Sql(VLR_DESCONTOS,opDouble) + ',');
  qUpdate.SQL.Add(Insert_Sql(VLR_DESPESAS,opDouble) + ',');
  qUpdate.SQL.Add(Insert_Sql(VLR_DEVOLUCAO,opDouble) + ',');
  qUpdate.SQL.Add(Insert_Sql(VLR_JUROSCALCULADO,opDouble) + ',');
  qUpdate.SQL.Add(Insert_Sql(NUMCHEQUE,opInteger) + ',');
  qUpdate.SQL.Add(Insert_Sql(DTPREVISAO_CHEQUE,opDate) + ',');
  qUpdate.SQL.Add(Insert_Sql(ID_CONTA,opInteger) + ',');
  qUpdate.SQL.Add(Insert_Sql(ID_COMISSAO,opInteger) + ',');
  qUpdate.SQL.Add(Insert_Sql(TIPO_ES,opString) + ',');
  qUpdate.SQL.Add(Insert_Sql(DTHISTORICO,opDate) + ',');
  qUpdate.SQL.Add(Insert_Sql(DTLANCAMENTO,opDate) + ',');
  qUpdate.SQL.Add(Insert_Sql(VLR_LANCAMENTO,opDouble) + ',');
  qUpdate.SQL.Add(Insert_Sql(ID_FORMA_PAGAMENTO,opInteger) + ',');
  qUpdate.SQL.Add(Insert_Sql(END_ARQUIVO_REM,opString) + ',');
  qUpdate.SQL.Add(Insert_Sql(NUM_REMESSA,opInteger) + ',');
  qUpdate.SQL.Add(Insert_Sql(ID_CARTEIRA,opInteger) + ',');
  qUpdate.SQL.Add(Insert_Sql(ID_ESPECIE,opInteger) + ',');
  qUpdate.SQL.Add(Insert_Sql(ID_OCORRENCIA,opInteger) + ',');
  qUpdate.SQL.Add(Insert_Sql(VLR_TAXA_BANCARIA,opDouble) + ',');
  qUpdate.SQL.Add(Insert_Sql(ID_DESCONTADA,opInteger) + ',');
  qUpdate.SQL.Add(Insert_Sql(VLR_MULTA,opDouble) + ')');
  try
    qUpdate.ExecSQL;
  except
    on E : Exception do
    begin
      raise Exception.Create(e.ClassName + ' ' + E.Message + #13#10 + 'Erro ao Gravar!'+ qUpdate.Text);
    end;
  end;

end;

function TDuplicataHistorico.pesquisa(id_: integer; preenche: Boolean): Boolean;
begin

end;

function TDuplicataHistorico.pesquisar(id_, Item_: integer;
  preenche: Boolean): Boolean;
begin
 Result := False;
 qConsulta.Close;
 qConsulta.SQL.Clear;
 qConsulta.SQL.Add('Select * from ' + Tabela + ' where ID = ' + Insert_Sql(id_,opInteger));
 qConsulta.SQL.Add(' AND ITEM = ' + Insert_Sql(Item_,opInteger));
 qConsulta.Open;
 if preenche then
 begin
   ID := qConsulta.FieldByName('ID').AsInteger;
   NUMCHEQUE := qConsulta.FieldByName('NUMCHEQUE').AsInteger;
   ID_HISTORICO := qConsulta.FieldByName('ID_HISTORICO').AsInteger;
   ITEM := qConsulta.FieldByName('ITEM').AsInteger;
   ID_COMISSAO := qConsulta.FieldByName('ID_COMISSAO').AsInteger;
   ID_CONTA := qConsulta.FieldByName('ID_CONTA').AsInteger;
   ID_ESPECIE := qConsulta.FieldByName('ID_ESPECIE').AsInteger;
   NUM_REMESSA := qConsulta.FieldByName('NUM_REMESSA').AsInteger;
   ID_CARTEIRA := qConsulta.FieldByName('ID_CARTEIRA').AsInteger;
   ID_DESCONTADA := qConsulta.FieldByName('ID_DESCONTADA').AsInteger;
   ID_OCORRENCIA := qConsulta.FieldByName('ID_OCORRENCIA').AsInteger;
   ID_FORMA_PAGAMENTO := qConsulta.FieldByName('ID_FORMA_PAGAMENTO').AsInteger;
   VLR_DESCONTOS := qConsulta.FieldByName('VLR_DESCONTOS').AsFloat;
   VLR_JUROSPAGOS := qConsulta.FieldByName('VLR_JUROSPAGOS').AsFloat;
   VLR_JUROSCALCULADO := qConsulta.FieldByName('VLR_JUROSCALCULADO').AsFloat;
   VLR_PAGAMENTO := qConsulta.FieldByName('VLR_PAGAMENTO').AsFloat;
   VLR_DEVOLUCAO := qConsulta.FieldByName('VLR_DEVOLUCAO').AsFloat;
   VLR_DESPESAS := qConsulta.FieldByName('VLR_DESPESAS').AsFloat;
   VLR_LANCAMENTO := qConsulta.FieldByName('VLR_LANCAMENTO').AsFloat;
   VLR_TAXA_BANCARIA := qConsulta.FieldByName('VLR_TAXA_BANCARIA').AsFloat;
   VLR_MULTA := qConsulta.FieldByName('VLR_MULTA').AsFloat;
   TIPO_HISTORICO := qConsulta.FieldByName('TIPO_HISTORICO').AsString;
   COMPLEMENTO := qConsulta.FieldByName('COMPLEMENTO').AsString;
   TIPO_ES := qConsulta.FieldByName('TIPO_ES').AsString;
   END_ARQUIVO_REM := qConsulta.FieldByName('END_ARQUIVO_REM').AsString;
   DTLANCAMENTO := qConsulta.FieldByName('DTLANCAMENTO').AsDateTime;
   DTHISTORICO := qConsulta.FieldByName('DTHISTORICO').AsDateTime;
   DTPREVISAO_CHEQUE := qConsulta.FieldByName('DTPREVISAO_CHEQUE').AsDateTime;
 end
 else
   inicializa;
 qConsulta.Close;
 filtro(False);
end;

procedure TDuplicataHistorico.Update;
begin
  inherited;
  qUpdate.SQL.Clear;
  qUpdate.SQL.Add('UPDATE ' + Tabela + ' SET');
  qUpdate.SQL.Add('ID_HISTORICO = ' + Insert_Sql(ID_HISTORICO,opInteger) + ',');
  qUpdate.SQL.Add('COMPLEMENTO = ' +Insert_Sql(COMPLEMENTO,opString) + ',');
  qUpdate.SQL.Add('VLR_PAGAMENTO = ' + Insert_Sql(VLR_PAGAMENTO,opDouble) + ',');
  qUpdate.SQL.Add('VLR_JUROSPAGOS = ' + Insert_Sql(VLR_JUROSPAGOS,opDouble) + ',');
  qUpdate.SQL.Add('VLR_DESCONTOS = ' + Insert_Sql(VLR_DESCONTOS,opDouble) + ',');
  qUpdate.SQL.Add('VLR_DESPESAS = ' + Insert_Sql(VLR_DESPESAS,opDouble) + ',');
  qUpdate.SQL.Add('VLR_DEVOLUCAO = ' + Insert_Sql(VLR_DEVOLUCAO,opDouble) + ',');
  qUpdate.SQL.Add('VLR_JUROSCALCULADO = ' + Insert_Sql(VLR_JUROSCALCULADO,opDouble) + ',');
  qUpdate.SQL.Add('NUMCHEQUE = ' + Insert_Sql(NUMCHEQUE,opInteger) + ',');
  qUpdate.SQL.Add('DTPREVISAO_CHEQUE = ' + Insert_Sql(DTPREVISAO_CHEQUE,opDate) + ',');
  qUpdate.SQL.Add('ID_CONTA = ' + Insert_Sql(ID_CONTA,opInteger) + ',');
  qUpdate.SQL.Add('ID_COMISSAO = ' + Insert_Sql(ID_COMISSAO,opInteger) + ',');
  qUpdate.SQL.Add('TIPO_ES = ' + Insert_Sql(TIPO_ES,opString) + ',');
  qUpdate.SQL.Add('DTHISTORICO = ' + Insert_Sql(DTHISTORICO,opDate) + ',');
  qUpdate.SQL.Add('DTLANCAMENTO = ' + Insert_Sql(DTLANCAMENTO,opDate) + ',');
  qUpdate.SQL.Add('VLR_LANCAMENTO = ' + Insert_Sql(VLR_LANCAMENTO,opDouble) + ',');
  qUpdate.SQL.Add('ID_FORMA_PAGAMENTO = ' + Insert_Sql(ID_FORMA_PAGAMENTO,opInteger) + ',');
  qUpdate.SQL.Add('END_ARQUIVO_REM = ' + Insert_Sql(END_ARQUIVO_REM,opString) + ',');
  qUpdate.SQL.Add('NUM_REMESSA = ' + Insert_Sql(NUM_REMESSA,opInteger) + ',');
  qUpdate.SQL.Add('ID_CARTEIRA = ' + Insert_Sql(ID_CARTEIRA,opInteger) + ',');
  qUpdate.SQL.Add('ID_ESPECIE = ' + Insert_Sql(ID_ESPECIE,opInteger) + ',');
  qUpdate.SQL.Add('ID_OCORRENCIA = ' + Insert_Sql(ID_OCORRENCIA,opInteger) + ',');
  qUpdate.SQL.Add('VLR_TAXA_BANCARIA = ' + Insert_Sql(VLR_TAXA_BANCARIA,opDouble) + ',');
  qUpdate.SQL.Add('ID_DESCONTADA = ' + Insert_Sql(ID_DESCONTADA,opInteger) + ',');
  qUpdate.SQL.Add('VLR_MULTA = ' + Insert_Sql(VLR_MULTA,opDouble) + ',');
  qUpdate.SQL.Add('WHERE ID = ' + Insert_Sql(ID,opInteger) + ' AND ITEM = ' + Insert_Sql(ITEM,opInteger));
end;

end.

