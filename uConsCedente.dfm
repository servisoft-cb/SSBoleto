inherited frmConsCedente: TfrmConsCedente
  Caption = 'Consulta Cedente'
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlTop: TPanel
    inherited btnConsultar: TSMButton
      Left = 521
      OnClick = btnConsultarClick
      ExplicitLeft = 521
    end
    object btnEnviar: TSMButton
      Left = 624
      Top = 25
      Width = 97
      Height = 33
      Caption = 'Enviar'
      TabOrder = 1
      OnClick = btnEnviarClick
    end
    object spdBoletoX1: TspdBoletoX
      Left = 736
      Top = 32
      Width = 26
      Height = 26
      ControlData = {
        54504630185441637469766558436F6D706F6E656E74436F6E74726F6C00044C
        656674020003546F700200055769647468021A06486569676874021A0000}
    end
    object edtIDCedente: TEdit
      Left = 32
      Top = 48
      Width = 121
      Height = 21
      TabOrder = 3
    end
  end
  inherited pnlPrincipal: TPanel
    inherited pg_Principal: TPageControl
      inherited ts_Principal: TTabSheet
        inherited SMDBGrid1: TSMDBGrid
          DataSource = dmCadCedente.dsCadCedente
          Columns = <
            item
              Expanded = False
              FieldName = 'ID'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NOME'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NOME_INTERNO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ENDERECO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COMPLEMENTO_END'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NUM_END'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'BAIRRO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CEP'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ID_CIDADE'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CODMUNICIPIO'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'UF'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DDD1'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'FONE1'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ID_CEDENTE'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TOKEN_CEDENTE'
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CNPJ_CPF'
              Width = 64
              Visible = True
            end>
        end
      end
      object ts_Mensagem: TTabSheet
        Caption = 'Mensagem'
        ImageIndex = 1
        object mmEnvio: TMemo
          Left = 0
          Top = 0
          Width = 772
          Height = 153
          Align = alTop
          TabOrder = 0
        end
        object mmResposta: TMemo
          Left = 0
          Top = 153
          Width = 772
          Height = 191
          Align = alClient
          TabOrder = 1
        end
      end
    end
  end
end
