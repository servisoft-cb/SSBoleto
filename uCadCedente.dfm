inherited frmCadCedente: TfrmCadCedente
  Caption = 'Cadastro de Cedente - cadCedente'
  OnCreate = FormCreate
  ExplicitTop = 5
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgPrincipal: TPageControl
    inherited ts_Consulta: TTabSheet
      inherited pnlTop_Consulta: TPanel
        inherited btnPesquisar: TSMButton
          OnClick = btnPesquisarClick
        end
        object SMButton1: TSMButton
          Left = 422
          Top = 11
          Width = 113
          Height = 33
          Caption = 'Enviar'
          TabOrder = 3
        end
      end
      inherited pnlConsulta: TPanel
        object spdBoletoX2: TspdBoletoX
          Left = 696
          Top = 11
          Width = 26
          Height = 26
          ControlData = {
            54504630185441637469766558436F6D706F6E656E74436F6E74726F6C00044C
            656674020003546F700200055769647468021A06486569676874021A0000}
        end
      end
      inherited gridConsulta: TSMDBGrid
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
            Width = 154
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME_INTERNO'
            Width = 129
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ENDERECO'
            Width = 211
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COMPLEMENTO_END'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NUM_END'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BAIRRO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CEP'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ID_CIDADE'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CIDADE'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'UF'
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
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PESSOA'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CNPJ_CPF'
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
            Visible = True
          end>
      end
      inherited StatusBar1: TStatusBar
        ExplicitLeft = 0
        ExplicitTop = 459
        ExplicitWidth = 783
      end
    end
    inherited ts_Cadastro: TTabSheet
      inherited pnlPrincipal: TPanel
        ExplicitTop = 68
        ExplicitHeight = 434
        object Label1: TLabel
          Left = 72
          Top = 59
          Width = 10
          Height = 13
          Caption = 'Id'
        end
        object Label2: TLabel
          Left = 72
          Top = 86
          Width = 27
          Height = 13
          Caption = 'Nome'
        end
        object Label3: TLabel
          Left = 72
          Top = 113
          Width = 45
          Height = 13
          Caption = 'Endere'#231'o'
        end
        object Label4: TLabel
          Left = 448
          Top = 113
          Width = 33
          Height = 13
          Caption = 'Compl.'
        end
        object Label5: TLabel
          Left = 624
          Top = 113
          Width = 37
          Height = 13
          Caption = 'N'#250'mero'
        end
        object Label6: TLabel
          Left = 72
          Top = 140
          Width = 42
          Height = 13
          Caption = 'Telefone'
        end
        object edtID: TEdit
          Left = 124
          Top = 56
          Width = 41
          Height = 21
          TabOrder = 0
        end
        object edtNome: TEdit
          Left = 124
          Top = 83
          Width = 309
          Height = 21
          TabOrder = 1
        end
        object edtEndereco: TEdit
          Left = 124
          Top = 110
          Width = 309
          Height = 21
          TabOrder = 2
        end
        object edtComplemento: TEdit
          Left = 494
          Top = 110
          Width = 121
          Height = 21
          TabOrder = 3
        end
        object edtNumero: TEdit
          Left = 676
          Top = 110
          Width = 93
          Height = 21
          TabOrder = 4
        end
        object edtTelefone: TEdit
          Left = 180
          Top = 137
          Width = 121
          Height = 21
          TabOrder = 5
        end
        object edtDDD: TEdit
          Left = 123
          Top = 137
          Width = 46
          Height = 21
          TabOrder = 6
        end
      end
    end
  end
  object BindSourceDB1: TBindSourceDB
    DataSet = dmCadCedente.qryCadCedente
    ScopeMappings = <>
    Left = 576
    Top = 88
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 620
    Top = 88
    object LinkControlToField1: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDB1
      FieldName = 'ID'
      Control = edtID
      Track = True
    end
    object LinkControlToField2: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDB1
      FieldName = 'NOME'
      Control = edtNome
      Track = True
    end
    object LinkControlToField3: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDB1
      FieldName = 'ENDERECO'
      Control = edtEndereco
      Track = True
    end
    object LinkControlToField4: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDB1
      FieldName = 'COMPLEMENTO_END'
      Control = edtComplemento
      Track = True
    end
    object LinkControlToField5: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDB1
      FieldName = 'NUM_END'
      Control = edtNumero
      Track = True
    end
    object LinkControlToField6: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDB1
      FieldName = 'FONE1'
      Control = edtTelefone
      Track = True
    end
    object LinkControlToField7: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDB1
      FieldName = 'DDD1'
      Control = edtDDD
      Track = True
    end
  end
end
