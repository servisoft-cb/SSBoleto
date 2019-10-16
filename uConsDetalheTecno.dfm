object frmConsultaDetalheTecno: TfrmConsultaDetalheTecno
  Left = 0
  Top = 0
  Caption = 'Tela de Consulta'
  ClientHeight = 430
  ClientWidth = 854
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 854
    Height = 430
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 216
    ExplicitTop = 64
    ExplicitWidth = 185
    ExplicitHeight = 41
    object SMDBGrid1: TSMDBGrid
      Left = 1
      Top = 1
      Width = 852
      Height = 428
      Align = alClient
      DataSource = dsPadrao
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
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
      ExOptions = [eoENTERlikeTAB, eoKeepSelection, eoStandardPopup, eoBLOBEditor, eoTitleWordWrap, eoFilterAutoApply]
      RegistryKey = 'Software\Scalabium'
      RegistrySection = 'SMDBGrid'
      WidthOfIndicator = 11
      DefaultRowHeight = 17
      ScrollBars = ssHorizontal
    end
  end
  object dsPadrao: TDataSource
    DataSet = cdsPadrao
    Left = 616
    Top = 32
  end
  object cdsPadrao: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 568
    Top = 32
  end
end
