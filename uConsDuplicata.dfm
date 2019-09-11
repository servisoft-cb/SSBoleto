inherited frmConsDuplicata: TfrmConsDuplicata
  Caption = 'Consulta Duplicata'
  ClientWidth = 994
  OnShow = FormShow
  ExplicitWidth = 1000
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlTop: TPanel
    Width = 994
    Height = 105
    ExplicitWidth = 994
    ExplicitHeight = 105
    inherited Label1: TLabel
      Left = 244
      Top = 13
      ExplicitLeft = 244
      ExplicitTop = 13
    end
    object Label2: TLabel [1]
      Left = 9
      Top = 12
      Width = 73
      Height = 13
      Caption = 'N'#186' Documento:'
    end
    object Label3: TLabel [2]
      Left = 36
      Top = 35
      Width = 46
      Height = 13
      Caption = 'Dt.Inicial:'
    end
    object Label4: TLabel [3]
      Left = 227
      Top = 35
      Width = 41
      Height = 13
      Caption = 'Dt.Final:'
    end
    object Label5: TLabel [4]
      Left = 49
      Top = 58
      Width = 33
      Height = 13
      Caption = 'Banco:'
    end
    object Label6: TLabel [5]
      Left = 26
      Top = 82
      Width = 56
      Height = 13
      Caption = 'Ocorr'#234'ncia:'
    end
    object Label7: TLabel [6]
      Left = 428
      Top = 58
      Width = 35
      Height = 13
      Caption = 'T'#237'tulos:'
    end
    inherited btnConsultar: TSMButton
      Left = 629
      Top = 4
      TabOrder = 2
      ExplicitLeft = 629
      ExplicitTop = 4
    end
    inherited pnlSair: TPanel
      Left = 880
      Height = 103
      TabOrder = 0
      ExplicitLeft = 880
      ExplicitHeight = 103
      inherited btnFechar: TSMButton
        Top = 4
        ExplicitTop = 4
      end
    end
    object edtNumeroDoc: TEdit [9]
      Left = 88
      Top = 4
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object DateInicial: TJvDateEdit [10]
      Left = 88
      Top = 27
      Width = 121
      Height = 21
      ShowNullDate = False
      TabOrder = 4
    end
    object DateFinal: TJvDateEdit [11]
      Left = 274
      Top = 27
      Width = 121
      Height = 21
      ShowNullDate = False
      TabOrder = 5
    end
    inherited comboFilial: TJvDBLookupCombo
      Left = 274
      Top = 5
      Width = 243
      TabOrder = 3
      ExplicitLeft = 274
      ExplicitTop = 5
      ExplicitWidth = 243
    end
    object comboBanco: TJvDBLookupCombo
      Left = 89
      Top = 50
      Width = 306
      Height = 21
      DisplayEmpty = 'Todos'
      EmptyValue = '0'
      EmptyStrIsNull = False
      EmptyItemColor = clScrollBar
      LookupField = 'ID'
      LookupDisplay = 'NOME'
      LookupSource = DMCadDuplicata.dsContas
      TabOrder = 6
      OnKeyDown = comboBancoKeyDown
    end
    object comboOcorrencia: TJvDBLookupCombo
      Left = 88
      Top = 74
      Width = 306
      Height = 21
      DisplayEmpty = 'Todas'
      EmptyValue = '0'
      EmptyStrIsNull = False
      EmptyItemColor = clScrollBar
      LookupField = 'ID'
      LookupDisplay = 'NOME'
      LookupSource = DMCadDuplicata.dsOcorrencia
      TabOrder = 8
      OnKeyDown = comboOcorrenciaKeyDown
    end
    object ComboTitulo: TJvComboBox
      Left = 469
      Top = 50
      Width = 151
      Height = 21
      TabOrder = 7
      Text = 'N'#227'o Enviados'
      Items.Strings = (
        'N'#227'o Enviados'
        'Enviados'
        'Todos')
      ItemIndex = 0
    end
    object btnOpcoes: TSMButton
      Left = 629
      Top = 35
      Width = 97
      Height = 33
      Caption = 'Op'#231#245'es'
      DropDownMenu = popOpcoes
      ParentShowHint = False
      ShowHint = False
      Style = bsSplitButton
      TabOrder = 9
    end
    object spdBoletoX1: TspdBoletoX
      Left = 816
      Top = 56
      Width = 26
      Height = 26
      ControlData = {
        54504630185441637469766558436F6D706F6E656E74436F6E74726F6C00044C
        656674020003546F700200055769647468021A06486569676874021A0000}
    end
    object SMButton1: TSMButton
      Left = 629
      Top = 66
      Width = 97
      Height = 33
      Caption = 'Consulta Boleto'
      TabOrder = 11
    end
  end
  inherited pnlPrincipal: TPanel
    Top = 105
    Width = 994
    Height = 379
    ExplicitTop = 105
    ExplicitWidth = 994
    ExplicitHeight = 379
    inherited pg_Principal: TPageControl
      Width = 992
      Height = 377
      ExplicitWidth = 992
      ExplicitHeight = 377
      inherited ts_Consulta: TTabSheet
        ExplicitWidth = 984
        ExplicitHeight = 349
        inherited SMDBGrid1: TSMDBGrid
          Width = 984
          Height = 349
          OnGetCellParams = SMDBGrid1GetCellParams
          Columns = <
            item
              Expanded = False
              FieldName = 'ID'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TIPO_ES'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'FILIAL'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ID_NOTA'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PARCELA'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NUMDUPLICATA'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NUMNOTA'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SERIE'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DTVENCIMENTO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VLR_PARCELA'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VLR_RESTANTE'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VLR_PAGO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VLR_DESCONTO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DTULTPAGAMENTO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NOME_CLIENTE'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CNPJ_CPF'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DTEMISSAO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ID_CONTA'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ID_INTEGRACAO'
              Visible = True
            end>
        end
      end
      object ts_Mensagem: TTabSheet
        Caption = 'Mensagem'
        ImageIndex = 1
        object mmResposta: TMemo
          Left = 0
          Top = 153
          Width = 984
          Height = 196
          Align = alClient
          TabOrder = 0
        end
        object mmEnvio: TMemo
          Left = 0
          Top = 0
          Width = 984
          Height = 153
          Align = alTop
          TabOrder = 1
        end
      end
    end
  end
  inherited dsConsulta: TDataSource
    Left = 824
    Top = 216
  end
  inherited qryFilial: TFDQuery
    Left = 936
    Top = 48
  end
  inherited dsFilial: TDataSource
    Left = 904
    Top = 48
  end
  object popOpcoes: TPopupMenu
    Left = 744
    Top = 40
    object btnEnviar: TMenuItem
      Caption = 'Enviar'
      OnClick = btnEnviarClick
    end
    object btnConsulta: TMenuItem
      Caption = 'Consultar'
      OnClick = btnConsultaClick
    end
    object btnImpressao: TMenuItem
      Caption = 'Impressao'
      OnClick = btnImpressaoClick
    end
  end
end
