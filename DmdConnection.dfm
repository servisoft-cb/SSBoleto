object DMConection: TDMConection
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 264
  Width = 400
  object FDConnection: TFDConnection
    Params.Strings = (
      'User_Name=SYSDBA'
      'Database=D:\Fontes\$Servisoft\Bases\SSFacil\CRI.FDB'
      'Password=masterkey'
      'CharacterSet=win1252'
      'DriverID=FB')
    LoginPrompt = False
    Left = 32
    Top = 16
  end
  object SQLConnection1: TSQLConnection
    Left = 128
    Top = 128
  end
end
