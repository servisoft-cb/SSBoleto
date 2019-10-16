inherited frmConsConta: TfrmConsConta
  Caption = 'Consulta Contas'
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlTop: TPanel
    object btnEnviar: TSMButton
      Left = 488
      Top = 10
      Width = 97
      Height = 33
      Caption = 'Enviar'
      TabOrder = 3
      OnClick = btnEnviarClick
    end
    object spdBoletoX1: TspdBoletoX
      Left = 400
      Top = 57
      Width = 26
      Height = 26
      ControlData = {
        54504630185441637469766558436F6D706F6E656E74436F6E74726F6C00044C
        656674020003546F700200055769647468021A06486569676874021A0000}
    end
    object rdgTipoEnvio: TRadioGroup
      Left = 54
      Top = 46
      Width = 219
      Height = 37
      Caption = 'Tipo de Envio'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Conta'
        'Conv'#234'nio')
      TabOrder = 5
    end
  end
  inherited pnlPrincipal: TPanel
    inherited pg_Principal: TPageControl
      object ts_Mensagem: TTabSheet
        Caption = 'Mensagem'
        ImageIndex = 1
        object mmEnvio: TMemo
          Left = 0
          Top = 0
          Width = 782
          Height = 153
          Align = alTop
          TabOrder = 0
        end
        object mmResposta: TMemo
          Left = 0
          Top = 153
          Width = 782
          Height = 213
          Align = alClient
          TabOrder = 1
        end
      end
    end
  end
  inherited qryFilial: TFDQuery
    Left = 640
  end
  inherited dsFilial: TDataSource
    Left = 608
  end
end
