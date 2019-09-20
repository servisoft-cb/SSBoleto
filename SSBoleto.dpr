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
  Classe.Nome.Remessa in 'Classes\Classe.Nome.Remessa.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMConection, DMConection);
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.Run;
end.
