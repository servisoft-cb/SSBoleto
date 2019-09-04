inherited frmConsDuplicata: TfrmConsDuplicata
  Caption = 'frmConsDuplicata'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlTop: TPanel
    Height = 99
    ExplicitWidth = 973
    ExplicitHeight = 99
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
      Height = 97
      TabOrder = 0
      ExplicitLeft = 859
      ExplicitHeight = 97
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
  end
  inherited pnlPrincipal: TPanel
    Top = 99
    Height = 385
    ExplicitTop = 99
    ExplicitWidth = 973
    ExplicitHeight = 375
    inherited pg_Principal: TPageControl
      Height = 383
      ExplicitWidth = 971
      ExplicitHeight = 373
      inherited ts_Consulta: TTabSheet
        ExplicitWidth = 963
        ExplicitHeight = 345
        inherited SMDBGrid1: TSMDBGrid
          Height = 355
        end
      end
    end
  end
  inherited qryFilial: TFDQuery
    Left = 936
    Top = 48
  end
  inherited dsFilial: TDataSource
    Left = 904
    Top = 48
  end
end
