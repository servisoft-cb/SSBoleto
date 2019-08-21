program SSBoleto;

uses
  Vcl.Forms,
  uMenu in 'uMenu.pas' {Form1},
  DmdConnection in 'DmdConnection.pas' {DMConection: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDMConection, DMConection);
  Application.Run;
end.
