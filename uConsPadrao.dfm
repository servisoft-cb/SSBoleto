object frmConsPadrao: TfrmConsPadrao
  Left = 0
  Top = 0
  Caption = 'Consulta Padr'#227'o'
  ClientHeight = 474
  ClientWidth = 782
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 782
    Height = 81
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 765
    object btnConsultar: TSMButton
      Left = 344
      Top = 25
      Width = 97
      Height = 33
      Caption = 'Consultar'
      TabOrder = 0
    end
  end
  object pnlPrincipal: TPanel
    Left = 0
    Top = 81
    Width = 782
    Height = 393
    Align = alClient
    TabOrder = 1
    ExplicitTop = 8
    ExplicitWidth = 765
    ExplicitHeight = 73
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 780
      Height = 391
      ActivePage = ts_Principal
      Align = alClient
      TabOrder = 0
      object ts_Principal: TTabSheet
        Caption = 'Principal'
        ExplicitWidth = 755
        ExplicitHeight = 328
        object SMDBGrid1: TSMDBGrid
          Left = 0
          Top = 0
          Width = 772
          Height = 363
          Align = alClient
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
    end
  end
end
