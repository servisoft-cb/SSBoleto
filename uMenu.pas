unit uMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UCDataConnector, UCDBXConn, Vcl.Menus, DmdConnection,
  UCSettings, UCBase, UCFireDACConn, FireDAC.DApt;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    UCFireDACConn1: TUCFireDACConn;
    UserControl1: TUserControl;
    UCSettings1: TUCSettings;
    Administracao1: TMenuItem;
    Cadastros1: TMenuItem;
    Parmetros1: TMenuItem;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
