object dmCadCedente: TdmCadCedente
  OldCreateOrder = False
  Height = 294
  Width = 356
  object fdtCadCedente: TFDTable
    IndexFieldNames = 'ID'
    Connection = DMConection.FDConnection
    UpdateOptions.UpdateTableName = 'FILIAL'
    TableName = 'FILIAL'
    Left = 40
    Top = 24
    object fdtCadCedenteID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object fdtCadCedenteNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 60
    end
    object fdtCadCedenteNOME_INTERNO: TStringField
      DisplayLabel = 'Nome Interno'
      FieldName = 'NOME_INTERNO'
      Origin = 'NOME_INTERNO'
      Size = 30
    end
    object fdtCadCedenteENDERECO: TStringField
      DisplayLabel = 'Endere'#231'o'
      FieldName = 'ENDERECO'
      Origin = 'ENDERECO'
      Size = 60
    end
    object fdtCadCedenteCOMPLEMENTO_END: TStringField
      DisplayLabel = 'Complemento'
      FieldName = 'COMPLEMENTO_END'
      Origin = 'COMPLEMENTO_END'
      Size = 60
    end
    object fdtCadCedenteNUM_END: TStringField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'NUM_END'
      Origin = 'NUM_END'
      Size = 15
    end
    object fdtCadCedenteBAIRRO: TStringField
      DisplayLabel = 'Bairro'
      FieldName = 'BAIRRO'
      Origin = 'BAIRRO'
      Size = 30
    end
    object fdtCadCedenteCEP: TStringField
      FieldName = 'CEP'
      Origin = 'CEP'
      Size = 9
    end
    object fdtCadCedenteID_CIDADE: TIntegerField
      FieldName = 'ID_CIDADE'
      Origin = 'ID_CIDADE'
    end
    object fdtCadCedenteCIDADE: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Size = 40
    end
    object fdtCadCedenteUF: TStringField
      FieldName = 'UF'
      Origin = 'UF'
      Size = 2
    end
    object fdtCadCedenteDDD1: TIntegerField
      DisplayLabel = 'DDD'
      FieldName = 'DDD1'
      Origin = 'DDD1'
    end
    object fdtCadCedenteFONE1: TStringField
      DisplayLabel = 'Fone'
      FieldName = 'FONE1'
      Origin = 'FONE1'
      Size = 15
    end
    object fdtCadCedenteID_CEDENTE: TIntegerField
      DisplayLabel = 'ID Cedente'
      FieldName = 'ID_CEDENTE'
      Origin = 'ID_CEDENTE'
    end
    object fdtCadCedenteTOKEN_CEDENTE: TStringField
      DisplayLabel = 'Token'
      FieldName = 'TOKEN_CEDENTE'
      Origin = 'TOKEN_CEDENTE'
      Size = 40
    end
  end
  object dsCadCedente: TDataSource
    DataSet = fdtCadCedente
    Left = 128
    Top = 24
  end
  object qryCadCedente: TFDQuery
    Connection = DMConection.FDConnection
    SQL.Strings = (
      'Select * from FILIAL')
    Left = 40
    Top = 80
  end
end
