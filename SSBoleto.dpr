program SSBoleto;

uses
  Vcl.Forms,
  uMenu in 'uMenu.pas' {frmMenu},
  DmdConnection in 'DmdConnection.pas' {DMConection: TDataModule},
  uCadFormBase in 'uCadFormBase.pas' {CadFormBase},
  uCadCedente in 'uCadCedente.pas' {frmCadCedente},
  uDMCadCedente in 'uDMCadCedente.pas' {dmCadCedente: TDataModule},
  uUtilPadrao in 'uUtilPadrao.pas',
  uConsPadrao in 'uConsPadrao.pas' {frmConsPadrao},
  uConsCedente in 'uConsCedente.pas' {frmConsCedente},
  uBaseDAO in 'uBaseDAO.pas',
  uConfigTecnoSpeed in 'uConfigTecnoSpeed.pas',
  uConsConta in 'uConsConta.pas' {frmConsConta},
  uDMCadConta in 'uDMCadConta.pas' {dmCadConta: TDataModule},
  uConsDuplicata in 'uConsDuplicata.pas' {frmConsDuplicata},
  uDMCadDuplicata in 'uDMCadDuplicata.pas' {DMCadDuplicata: TDataModule},
  uResumo in 'uResumo.pas' {frmResumo},
  Classe.Nome.Remessa in 'Classes\Classe.Nome.Remessa.pas',
  Classe.Gravar.Historico.Duplicata in 'Classes\Classe.Gravar.Historico.Duplicata.pas',
  Classe.Monta.Conta.TecnoSpeed in 'Classes\Classe.Monta.Conta.TecnoSpeed.pas',
  Classe.Monta.Convenio.TecnoSpeed in 'Classes\Classe.Monta.Convenio.TecnoSpeed.pas',
  Classe.Enviar.Email.TecnoSpeed in 'Classes\Classe.Enviar.Email.TecnoSpeed.pas',
  Classe.Boleto.TecnoSpeed in 'Classes\Classe.Boleto.TecnoSpeed.pas',
  Classe.Email.Empresa in 'Classes\Classe.Email.Empresa.pas',
  uConsDetalheTecno in 'uConsDetalheTecno.pas' {frmConsultaDetalheTecno};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMConection, DMConection);
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.Run;
end.
