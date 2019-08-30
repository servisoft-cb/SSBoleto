object dmCadCedente: TdmCadCedente
  OldCreateOrder = False
  Height = 294
  Width = 356
  object dsCadCedente: TDataSource
    DataSet = qryConsulta
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
  object qryConsulta: TFDQuery
    Connection = DMConection.FDConnection
    SQL.Strings = (
      
        'select F.ID, F.NOME, F.NOME_INTERNO, F.ENDERECO, F.COMPLEMENTO_E' +
        'ND, F.NUM_END, F.BAIRRO, F.CEP, F.ID_CIDADE,'
      
        '       C.CODMUNICIPIO, F.UF, F.DDD1, F.FONE1, F.ID_CEDENTE, F.TO' +
        'KEN_CEDENTE, F.CNPJ_CPF, F.EMAIL_FINANCEIRO'
      'from FILIAL F'
      'left join CIDADE C on F.ID_CIDADE = C.ID  ')
    Left = 32
    Top = 24
    object qryConsultaID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryConsultaNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 60
    end
    object qryConsultaNOME_INTERNO: TStringField
      DisplayLabel = 'Fantasia'
      FieldName = 'NOME_INTERNO'
      Origin = 'NOME_INTERNO'
      Size = 30
    end
    object qryConsultaENDERECO: TStringField
      DisplayLabel = 'Endere'#231'o'
      FieldName = 'ENDERECO'
      Origin = 'ENDERECO'
      Size = 60
    end
    object qryConsultaCOMPLEMENTO_END: TStringField
      DisplayLabel = 'Complemento'
      FieldName = 'COMPLEMENTO_END'
      Origin = 'COMPLEMENTO_END'
      Size = 60
    end
    object qryConsultaNUM_END: TStringField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'NUM_END'
      Origin = 'NUM_END'
      Size = 15
    end
    object qryConsultaBAIRRO: TStringField
      DisplayLabel = 'Bairro'
      FieldName = 'BAIRRO'
      Origin = 'BAIRRO'
      Size = 30
    end
    object qryConsultaCEP: TStringField
      FieldName = 'CEP'
      Origin = 'CEP'
      Size = 9
    end
    object qryConsultaID_CIDADE: TIntegerField
      DisplayLabel = 'ID Cidade'
      FieldName = 'ID_CIDADE'
      Origin = 'ID_CIDADE'
    end
    object qryConsultaCODMUNICIPIO: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'C'#243'digo IBGE'
      FieldName = 'CODMUNICIPIO'
      Origin = 'CODMUNICIPIO'
      ProviderFlags = []
      ReadOnly = True
      Size = 7
    end
    object qryConsultaUF: TStringField
      FieldName = 'UF'
      Origin = 'UF'
      Size = 2
    end
    object qryConsultaDDD1: TIntegerField
      DisplayLabel = 'DDD'
      FieldName = 'DDD1'
      Origin = 'DDD1'
    end
    object qryConsultaFONE1: TStringField
      DisplayLabel = 'Fone'
      FieldName = 'FONE1'
      Origin = 'FONE1'
      Size = 15
    end
    object qryConsultaID_CEDENTE: TIntegerField
      DisplayLabel = 'ID Cedente'
      FieldName = 'ID_CEDENTE'
      Origin = 'ID_CEDENTE'
    end
    object qryConsultaTOKEN_CEDENTE: TStringField
      DisplayLabel = 'Token'
      FieldName = 'TOKEN_CEDENTE'
      Origin = 'TOKEN_CEDENTE'
      Size = 40
    end
    object qryConsultaCNPJ_CPF: TStringField
      DisplayLabel = 'CNPJ/CPF'
      FieldName = 'CNPJ_CPF'
      Origin = 'CNPJ_CPF'
      Size = 18
    end
    object qryConsultaEMAIL_FINANCEIRO: TStringField
      DisplayLabel = 'Email Financeiro'
      FieldName = 'EMAIL_FINANCEIRO'
      Origin = 'EMAIL_FINANCEIRO'
      Size = 200
    end
  end
end
