inherited frmConsCedente: TfrmConsCedente
  Caption = 'Consulta Cedente'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlTop: TPanel
    inherited btnConsultar: TSMButton
      OnClick = btnConsultarClick
    end
    object SMButton1: TSMButton
      Left = 464
      Top = 25
      Width = 97
      Height = 33
      Caption = 'Enviar'
      TabOrder = 1
    end
  end
  inherited pnlPrincipal: TPanel
    ExplicitTop = 81
    ExplicitHeight = 358
    inherited PageControl1: TPageControl
      inherited ts_Principal: TTabSheet
        inherited SMDBGrid1: TSMDBGrid
          DataSource = dmCadCedente.dsCadCedente
        end
      end
    end
  end
end
