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
  uConsCedente in 'uConsCedente.pas' {frmConsCedente};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMConection, DMConection);
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.Run;
end.
