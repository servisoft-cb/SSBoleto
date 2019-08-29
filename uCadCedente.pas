unit uCadCedente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadFormBase, Data.DB, Vcl.Grids,
  Vcl.DBGrids, SMDBGrid, Vcl.StdCtrls, SMultiBtn, Vcl.ExtCtrls, Vcl.ComCtrls,
  System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, uDMCadCedente,
  Vcl.OleCtrls, BoletoX_TLB;

type
  TfrmCadCedente = class(TCadFormBase)
    edtID: TEdit;
    edtNome: TEdit;
    edtEndereco: TEdit;
    edtComplemento: TEdit;
    edtNumero: TEdit;
    edtTelefone: TEdit;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtDDD: TEdit;
    LinkControlToField6: TLinkControlToField;
    LinkControlToField7: TLinkControlToField;
    SMButton1: TSMButton;
    spdBoletoX2: TspdBoletoX;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadCedente: TfrmCadCedente;
  fDMCadCedente : TdmCadCedente;

implementation

{$R *.dfm}

procedure TfrmCadCedente.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  fDMCadCedente.fdtCadCedente.Open;
end;

procedure TfrmCadCedente.FormCreate(Sender: TObject);
begin
  inherited;
  fDMCadCedente := TdmCadCedente.Create(Self);
end;

end.
