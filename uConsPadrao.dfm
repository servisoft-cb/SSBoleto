object frmConsPadrao: TfrmConsPadrao
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Consulta Padr'#227'o'
  ClientHeight = 484
  ClientWidth = 792
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 792
    Height = 88
    Align = alTop
    Color = 16744576
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 30
      Width = 24
      Height = 13
      Caption = 'Filial:'
    end
    object btnConsultar: TSMButton
      Left = 375
      Top = 10
      Width = 97
      Height = 33
      Caption = 'Consultar'
      TabOrder = 0
      OnClick = btnConsultarClick
    end
    object pnlSair: TPanel
      Left = 678
      Top = 1
      Width = 113
      Height = 86
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object btnFechar: TSMButton
        Left = 12
        Top = 9
        Width = 97
        Height = 33
        Caption = 'Fechar'
        TabOrder = 0
        OnClick = btnFecharClick
      end
    end
    object comboFilial: TJvDBLookupCombo
      Left = 56
      Top = 22
      Width = 313
      Height = 21
      DisplayEmpty = 'Todas'
      EmptyValue = '0'
      EmptyStrIsNull = False
      EmptyItemColor = clScrollBar
      LookupField = 'ID'
      LookupDisplay = 'NOME'
      LookupSource = dsFilial
      TabOrder = 2
    end
  end
  object pnlPrincipal: TPanel
    Left = 0
    Top = 88
    Width = 792
    Height = 396
    Align = alClient
    TabOrder = 1
    object pg_Principal: TPageControl
      Left = 1
      Top = 1
      Width = 790
      Height = 394
      ActivePage = ts_Consulta
      Align = alClient
      TabOrder = 0
      object ts_Consulta: TTabSheet
        Caption = 'Consulta'
        object SMDBGrid1: TSMDBGrid
          Left = 0
          Top = 0
          Width = 782
          Height = 366
          Align = alClient
          DataSource = dsConsulta
          DrawingStyle = gdsGradient
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Flat = False
          BandsFont.Charset = DEFAULT_CHARSET
          BandsFont.Color = clWindowText
          BandsFont.Height = -11
          BandsFont.Name = 'Tahoma'
          BandsFont.Style = []
          Groupings = <>
          GridStyle.Style = gsNormal
          GridStyle.OddColor = clWindow
          GridStyle.EvenColor = clWindow
          TitleHeight.PixelCount = 24
          FooterColor = clBtnFace
          ExOptions = [eoCheckBoxSelect, eoDisableDelete, eoDisableInsert, eoENTERlikeTAB, eoKeepSelection, eoStandardPopup, eoBLOBEditor, eoTitleWordWrap, eoShowFilterBar, eoFilterAutoApply]
          RegistryKey = 'Software\Scalabium'
          RegistrySection = 'SMDBGrid'
          WidthOfIndicator = 23
          DefaultRowHeight = 17
          ScrollBars = ssHorizontal
        end
      end
    end
  end
  object dsConsulta: TDataSource
    Left = 728
    Top = 128
  end
  object qryFilial: TFDQuery
    Connection = DMConection.FDConnection
    SQL.Strings = (
      'SELECT ID, NOME, NOME_INTERNO FROM FILIAL')
    Left = 512
    Top = 16
    object qryFilialID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryFilialNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 60
    end
    object qryFilialNOME_INTERNO: TStringField
      FieldName = 'NOME_INTERNO'
      Origin = 'NOME_INTERNO'
      Size = 30
    end
  end
  object dsFilial: TDataSource
    DataSet = qryFilial
    Left = 480
    Top = 16
  end
end
