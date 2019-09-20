inherited frmConsDuplicata: TfrmConsDuplicata
  Caption = 'Consulta Duplicata'
  ClientWidth = 967
  OnShow = FormShow
  ExplicitWidth = 973
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlTop: TPanel
    Width = 967
    Height = 105
    ExplicitWidth = 967
    ExplicitHeight = 105
    inherited Label1: TLabel
      Left = 244
      Top = 13
      ExplicitLeft = 244
      ExplicitTop = 13
    end
    object lblDiversos: TLabel [1]
      Left = 9
      Top = 12
      Width = 73
      Height = 13
      Alignment = taRightJustify
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
      Left = 424
      Top = 35
      Width = 35
      Height = 13
      Caption = 'T'#237'tulos:'
    end
    object Shape1: TShape [7]
      Left = 756
      Top = 3
      Width = 20
      Height = 18
      Brush.Color = clGreen
      Pen.Color = clGreen
    end
    object Label2: TLabel [8]
      Left = 782
      Top = 8
      Width = 35
      Height = 13
      Caption = 'Gerado'
    end
    object Shape2: TShape [9]
      Left = 756
      Top = 21
      Width = 20
      Height = 18
      Brush.Color = clOlive
      Pen.Color = clOlive
    end
    object Label8: TLabel [10]
      Left = 782
      Top = 26
      Width = 44
      Height = 13
      Caption = 'Impresso'
    end
    object Shape3: TShape [11]
      Left = 756
      Top = 39
      Width = 20
      Height = 18
      Brush.Color = clRed
      Pen.Color = clRed
    end
    object Label9: TLabel [12]
      Left = 782
      Top = 44
      Width = 37
      Height = 13
      Caption = 'Vencido'
    end
    inherited pnlSair: TPanel [13]
      Left = 853
      Height = 103
      TabOrder = 0
      ExplicitLeft = 853
      ExplicitHeight = 103
      inherited btnFechar: TSMButton
        Top = 4
        ExplicitTop = 4
      end
    end
    inherited btnConsultar: TSMButton [14]
      Left = 629
      Top = 4
      TabOrder = 2
      ExplicitLeft = 629
      ExplicitTop = 4
    end
    object edtConsulta: TEdit [15]
      Left = 88
      Top = 4
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object DateInicial: TJvDateEdit [16]
      Left = 88
      Top = 27
      Width = 121
      Height = 21
      ShowNullDate = False
      TabOrder = 4
    end
    object DateFinal: TJvDateEdit [17]
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
      Left = 89
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
      Left = 465
      Top = 27
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
      Left = 597
      Top = 3
      Width = 26
      Height = 26
      ControlData = {
        54504630185441637469766558436F6D706F6E656E74436F6E74726F6C00044C
        656674020003546F700200055769647468021A06486569676874021A0000}
    end
    object rdgImpressao: TJvRadioGroup
      Left = 424
      Top = 65
      Width = 161
      Height = 30
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Visualizar'
        'Imprimir')
      TabOrder = 11
    end
  end
  inherited pnlPrincipal: TPanel
    Top = 105
    Width = 967
    Height = 379
    ExplicitTop = 105
    ExplicitWidth = 967
    ExplicitHeight = 379
    inherited pg_Principal: TPageControl
      Width = 965
      Height = 377
      ExplicitWidth = 965
      ExplicitHeight = 377
      inherited ts_Consulta: TTabSheet
        ExplicitWidth = 957
        ExplicitHeight = 349
        inherited gridConsulta: TSMDBGrid
          Width = 957
          Height = 349
          OnTitleClick = SMDBGrid1TitleClick
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
              FieldName = 'ID_INTEGRACAO'
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
              FieldName = 'ID_IMPRESSAO'
              Width = 86
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
          Width = 957
          Height = 196
          Align = alClient
          ScrollBars = ssVertical
          TabOrder = 0
        end
        object mmEnvio: TMemo
          Left = 0
          Top = 0
          Width = 957
          Height = 153
          Align = alTop
          ScrollBars = ssVertical
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
    Left = 840
    Top = 280
  end
  inherited dsFilial: TDataSource
    Left = 872
    Top = 280
  end
  object popOpcoes: TPopupMenu
    Left = 632
    Top = 72
    object btnEnviar: TMenuItem
      Caption = 'Enviar'
      OnClick = btnEnviarClick
    end
    object btnConsulta: TMenuItem
      Caption = 'Consultar '
      OnClick = btnConsultaClick
    end
    object btnImpressao: TMenuItem
      Caption = 'Impress'#227'o'
      OnClick = btnImpressaoClick
    end
    object GerarRemessa1: TMenuItem
      Caption = 'Gerar Remessa'
      OnClick = GerarRemessa1Click
    end
  end
  object dlgSalvarPDF: TSaveDialog
    Filter = '.PDF'
    Left = 536
    Top = 208
  end
end
