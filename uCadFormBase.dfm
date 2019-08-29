object CadFormBase: TCadFormBase
  Left = 0
  Top = 0
  Caption = 'Formul'#225'rio - Base'
  ClientHeight = 506
  ClientWidth = 791
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 791
    Height = 506
    ActivePage = ts_Consulta
    Align = alClient
    TabOrder = 0
    object ts_Consulta: TTabSheet
      Caption = 'Consulta'
      object pnlTop_Consulta: TPanel
        Left = 0
        Top = 0
        Width = 783
        Height = 57
        Align = alTop
        Color = clSilver
        ParentBackground = False
        TabOrder = 0
        object btnInserir: TSMButton
          Left = 40
          Top = 12
          Width = 113
          Height = 33
          Caption = 'Inserir'
          TabOrder = 0
          OnClick = btnInserirClick
        end
        object btnPesquisar: TSMButton
          Left = 168
          Top = 11
          Width = 113
          Height = 33
          Caption = 'Pesquisar'
          TabOrder = 1
        end
        object btnExcluir: TSMButton
          Left = 295
          Top = 11
          Width = 113
          Height = 33
          Caption = 'Excluir'
          TabOrder = 2
        end
      end
      object pnlConsulta: TPanel
        Left = 0
        Top = 57
        Width = 783
        Height = 57
        Align = alTop
        Color = clSilver
        ParentBackground = False
        TabOrder = 1
      end
      object gridConsulta: TSMDBGrid
        Left = 0
        Top = 114
        Width = 783
        Height = 345
        Align = alClient
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDblClick = gridConsultaDblClick
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
      object StatusBar1: TStatusBar
        Left = 0
        Top = 459
        Width = 783
        Height = 19
        Panels = <
          item
            Text = 'Usuario'
            Width = 150
          end
          item
            Text = 'Empresa'
            Width = 300
          end
          item
            Text = 'Mensagem'
            Width = 350
          end>
        ExplicitLeft = 336
        ExplicitTop = 416
        ExplicitWidth = 0
      end
    end
    object ts_Cadastro: TTabSheet
      Caption = 'Cadastro'
      ImageIndex = 1
      object pnlTop_Cadastro: TPanel
        Left = 0
        Top = 0
        Width = 783
        Height = 44
        Align = alTop
        Color = clHighlight
        ParentBackground = False
        TabOrder = 0
        object btnAlterar: TSMButton
          Left = 52
          Top = 6
          Width = 113
          Height = 33
          Caption = 'Alterar'
          TabOrder = 0
        end
        object btnConfirmar: TSMButton
          Left = 180
          Top = 6
          Width = 113
          Height = 33
          Caption = 'Confirmar'
          Enabled = False
          TabOrder = 1
        end
        object btnCancelar: TSMButton
          Left = 307
          Top = 6
          Width = 113
          Height = 33
          Caption = 'Cancelar'
          TabOrder = 2
        end
      end
      object pnlPrincipal: TPanel
        Left = 0
        Top = 44
        Width = 783
        Height = 434
        Align = alClient
        Enabled = False
        TabOrder = 1
        ExplicitTop = 53
        ExplicitHeight = 425
      end
    end
  end
end
