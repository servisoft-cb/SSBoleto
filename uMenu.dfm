object frmMenu: TfrmMenu
  Left = 0
  Top = 0
  Caption = 'Menu'
  ClientHeight = 391
  ClientWidth = 699
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 372
    Width = 699
    Height = 19
    Panels = <
      item
        Bevel = pbRaised
        Text = 'Copyright Servisoft'
        Width = 150
      end
      item
        Width = 150
      end
      item
        Alignment = taRightJustify
        Width = 50
      end>
  end
  object MainMenu1: TMainMenu
    Left = 584
    Top = 88
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object Parmetros1: TMenuItem
        Caption = 'Par'#226'metros'
      end
      object Cedente1: TMenuItem
        Caption = 'Cedente'
        OnClick = Cedente1Click
      end
    end
    object Administracao1: TMenuItem
      Caption = 'Administra'#231#227'o'
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 624
    Top = 88
  end
end
