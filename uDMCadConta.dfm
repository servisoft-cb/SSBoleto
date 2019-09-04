object dmCadConta: TdmCadConta
  OldCreateOrder = False
  Height = 260
  Width = 381
  object qryConsulta: TFDQuery
    Connection = DMConection.FDConnection
    SQL.Strings = (
      
        'select C.ID, B.CODIGO, C.NOME, C.AGENCIA, C.DIG_AGENCIA, C.NUMCO' +
        'NTA, C.DIG_CONTA, C.COD_CEDENTE, C.FILIAL,'
      
        '       C.ID_CONTA_TECNOSPEED, C.ID_CONVENIO_TECNOSPEED, CART.COD' +
        'IGO CARTEIRA, C.ACBR_LAYOUTREMESSA,'
      '       C.REINICIAR_NUM_REMESSA_DIA'
      'from CONTAS C'
      'inner join BANCO B on C.ID_BANCO = B.ID'
      'left join COB_CARTEIRA CART on C.ID_CARTEIRA = CART.ID'
      'left join COB_TIPO_CADASTRO CTC on C.ID_ESPECIE = CTC.ID'
      'where (C.FILIAL = :ID or :ID = 0)  ')
    Left = 24
    Top = 16
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qryConsultaID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryConsultaCODIGO: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = []
      ReadOnly = True
      Size = 3
    end
    object qryConsultaNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 30
    end
    object qryConsultaAGENCIA: TStringField
      DisplayLabel = 'Ag'#234'ncia'
      FieldName = 'AGENCIA'
      Origin = 'AGENCIA'
      Size = 5
    end
    object qryConsultaDIG_AGENCIA: TStringField
      DisplayLabel = 'D'#237'g.Ag'#234'ncia'
      FieldName = 'DIG_AGENCIA'
      Origin = 'DIG_AGENCIA'
      Size = 2
    end
    object qryConsultaNUMCONTA: TStringField
      DisplayLabel = 'Conta Corrente'
      FieldName = 'NUMCONTA'
      Origin = 'NUMCONTA'
      Size = 12
    end
    object qryConsultaDIG_CONTA: TStringField
      DisplayLabel = 'Dig.Conta'
      FieldName = 'DIG_CONTA'
      Origin = 'DIG_CONTA'
      Size = 1
    end
    object qryConsultaCOD_CEDENTE: TStringField
      DisplayLabel = 'C'#243'digo Cedente'
      FieldName = 'COD_CEDENTE'
      Origin = 'COD_CEDENTE'
      Size = 16
    end
    object qryConsultaFILIAL: TIntegerField
      DisplayLabel = 'Filial'
      FieldName = 'FILIAL'
      Origin = 'FILIAL'
    end
    object qryConsultaID_CONTA_TECNOSPEED: TIntegerField
      DisplayLabel = 'Id Conta Tecno'
      FieldName = 'ID_CONTA_TECNOSPEED'
      Origin = 'ID_CONTA_TECNOSPEED'
    end
    object qryConsultaID_CONVENIO_TECNOSPEED: TSmallintField
      DisplayLabel = 'ID Conv'#234'nio Tecno'
      FieldName = 'ID_CONVENIO_TECNOSPEED'
      Origin = 'ID_CONVENIO_TECNOSPEED'
    end
    object qryConsultaCARTEIRA: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Carteira'
      FieldName = 'CARTEIRA'
      Origin = 'CODIGO'
      ProviderFlags = []
      ReadOnly = True
      Size = 3
    end
    object qryConsultaREINICIAR_NUM_REMESSA_DIA: TStringField
      DisplayLabel = 'Reinicia Remessa'
      FieldName = 'REINICIAR_NUM_REMESSA_DIA'
      Origin = 'REINICIAR_NUM_REMESSA_DIA'
      FixedChar = True
      Size = 1
    end
    object qryConsultaACBR_LAYOUTREMESSA: TStringField
      DisplayLabel = 'CNAB'
      FieldName = 'ACBR_LAYOUTREMESSA'
      Origin = 'ACBR_LAYOUTREMESSA'
      Size = 4
    end
  end
  object qryContas: TFDQuery
    Connection = DMConection.FDConnection
    SQL.Strings = (
      'select * from contas'
      'where id = :id')
    Left = 24
    Top = 72
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object qryContasID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryContasNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 30
    end
    object qryContasAGENCIA: TStringField
      FieldName = 'AGENCIA'
      Origin = 'AGENCIA'
      Size = 5
    end
    object qryContasFILIAL: TIntegerField
      FieldName = 'FILIAL'
      Origin = 'FILIAL'
    end
    object qryContasNUMCONTA: TStringField
      FieldName = 'NUMCONTA'
      Origin = 'NUMCONTA'
      Size = 12
    end
    object qryContasCNAB: TStringField
      FieldName = 'CNAB'
      Origin = 'CNAB'
      Size = 15
    end
    object qryContasDTENCERRAMENTO: TDateField
      FieldName = 'DTENCERRAMENTO'
      Origin = 'DTENCERRAMENTO'
    end
    object qryContasID_TIPOCOBRANCA: TIntegerField
      FieldName = 'ID_TIPOCOBRANCA'
      Origin = 'ID_TIPOCOBRANCA'
    end
    object qryContasDESCRICAO_NOTA: TStringField
      FieldName = 'DESCRICAO_NOTA'
      Origin = 'DESCRICAO_NOTA'
      Size = 30
    end
    object qryContasTIPO_CONTA: TStringField
      FieldName = 'TIPO_CONTA'
      Origin = 'TIPO_CONTA'
      FixedChar = True
      Size = 1
    end
    object qryContasID_BANCO: TIntegerField
      FieldName = 'ID_BANCO'
      Origin = 'ID_BANCO'
    end
    object qryContasDIG_CONTA: TStringField
      FieldName = 'DIG_CONTA'
      Origin = 'DIG_CONTA'
      Size = 1
    end
    object qryContasCOD_CEDENTE: TStringField
      FieldName = 'COD_CEDENTE'
      Origin = 'COD_CEDENTE'
      Size = 16
    end
    object qryContasACEITE: TStringField
      FieldName = 'ACEITE'
      Origin = 'ACEITE'
      Size = 1
    end
    object qryContasID_OCORRENCIA: TIntegerField
      FieldName = 'ID_OCORRENCIA'
      Origin = 'ID_OCORRENCIA'
    end
    object qryContasDIAS_PROTESTO: TIntegerField
      FieldName = 'DIAS_PROTESTO'
      Origin = 'DIAS_PROTESTO'
    end
    object qryContasID_ESPECIE: TIntegerField
      FieldName = 'ID_ESPECIE'
      Origin = 'ID_ESPECIE'
    end
    object qryContasID_CARTEIRA: TIntegerField
      FieldName = 'ID_CARTEIRA'
      Origin = 'ID_CARTEIRA'
    end
    object qryContasID_INSTRUCAO1: TIntegerField
      FieldName = 'ID_INSTRUCAO1'
      Origin = 'ID_INSTRUCAO1'
    end
    object qryContasID_INSTRUCAO2: TIntegerField
      FieldName = 'ID_INSTRUCAO2'
      Origin = 'ID_INSTRUCAO2'
    end
    object qryContasID_TIPO_COBRANCA: TIntegerField
      FieldName = 'ID_TIPO_COBRANCA'
      Origin = 'ID_TIPO_COBRANCA'
    end
    object qryContasMOEDA: TStringField
      FieldName = 'MOEDA'
      Origin = 'MOEDA'
      Size = 1
    end
    object qryContasVARIACAO_CARTEIRA: TStringField
      FieldName = 'VARIACAO_CARTEIRA'
      Origin = 'VARIACAO_CARTEIRA'
      Size = 3
    end
    object qryContasTIPO_DOCUMENTO: TStringField
      FieldName = 'TIPO_DOCUMENTO'
      Origin = 'TIPO_DOCUMENTO'
      Size = 5
    end
    object qryContasCOD_TRANSMISSAO: TStringField
      FieldName = 'COD_TRANSMISSAO'
      Origin = 'COD_TRANSMISSAO'
    end
    object qryContasMENSAGEM_FIXA: TStringField
      FieldName = 'MENSAGEM_FIXA'
      Origin = 'MENSAGEM_FIXA'
      Size = 30
    end
    object qryContasPERC_DESCONTO: TFloatField
      FieldName = 'PERC_DESCONTO'
      Origin = 'PERC_DESCONTO'
    end
    object qryContasPERC_JUROS: TFloatField
      FieldName = 'PERC_JUROS'
      Origin = 'PERC_JUROS'
    end
    object qryContasVLR_IOF: TFloatField
      FieldName = 'VLR_IOF'
      Origin = 'VLR_IOF'
    end
    object qryContasVLR_TAXA: TFloatField
      FieldName = 'VLR_TAXA'
      Origin = 'VLR_TAXA'
    end
    object qryContasLOCAL_PAGAMENTO: TStringField
      FieldName = 'LOCAL_PAGAMENTO'
      Origin = 'LOCAL_PAGAMENTO'
      Size = 100
    end
    object qryContasEND_ARQUIVO_REM: TStringField
      FieldName = 'END_ARQUIVO_REM'
      Origin = 'END_ARQUIVO_REM'
      Size = 200
    end
    object qryContasNOME_ARQ_REM: TStringField
      FieldName = 'NOME_ARQ_REM'
      Origin = 'NOME_ARQ_REM'
      Size = 8
    end
    object qryContasEXTENSAO_ARQ_REM: TStringField
      FieldName = 'EXTENSAO_ARQ_REM'
      Origin = 'EXTENSAO_ARQ_REM'
      Size = 3
    end
    object qryContasDT_LIMITE_DESCONTO: TDateField
      FieldName = 'DT_LIMITE_DESCONTO'
      Origin = 'DT_LIMITE_DESCONTO'
    end
    object qryContasCOMISSAO_PERMANENCIA: TStringField
      FieldName = 'COMISSAO_PERMANENCIA'
      Origin = 'COMISSAO_PERMANENCIA'
      Size = 2
    end
    object qryContasNUM_CONVENIO_LIDER: TStringField
      FieldName = 'NUM_CONVENIO_LIDER'
      Origin = 'NUM_CONVENIO_LIDER'
      Size = 6
    end
    object qryContasDIG_AGENCIA: TStringField
      FieldName = 'DIG_AGENCIA'
      Origin = 'DIG_AGENCIA'
      Size = 2
    end
    object qryContasDIAS_DEVOLUCAO: TIntegerField
      FieldName = 'DIAS_DEVOLUCAO'
      Origin = 'DIAS_DEVOLUCAO'
    end
    object qryContasNUM_ARQ_REMESSA: TIntegerField
      FieldName = 'NUM_ARQ_REMESSA'
      Origin = 'NUM_ARQ_REMESSA'
    end
    object qryContasPOS_NUMCONTA_RETORNO: TIntegerField
      FieldName = 'POS_NUMCONTA_RETORNO'
      Origin = 'POS_NUMCONTA_RETORNO'
    end
    object qryContasPOS_CODBANCO_RETORNO: TIntegerField
      FieldName = 'POS_CODBANCO_RETORNO'
      Origin = 'POS_CODBANCO_RETORNO'
    end
    object qryContasPERC_MULTA: TFloatField
      FieldName = 'PERC_MULTA'
      Origin = 'PERC_MULTA'
    end
    object qryContasDIAS_MULTA: TIntegerField
      FieldName = 'DIAS_MULTA'
      Origin = 'DIAS_MULTA'
    end
    object qryContasACBR_TIPOCOBRANCA: TStringField
      FieldName = 'ACBR_TIPOCOBRANCA'
      Origin = 'ACBR_TIPOCOBRANCA'
      FixedChar = True
      Size = 2
    end
    object qryContasNOSSONUMERO_POR_ANO: TStringField
      FieldName = 'NOSSONUMERO_POR_ANO'
      Origin = 'NOSSONUMERO_POR_ANO'
      FixedChar = True
      Size = 1
    end
    object qryContasACBR_LAYOUTREMESSA: TStringField
      FieldName = 'ACBR_LAYOUTREMESSA'
      Origin = 'ACBR_LAYOUTREMESSA'
      Size = 4
    end
    object qryContasBANCO_LOGO: TStringField
      FieldName = 'BANCO_LOGO'
      Origin = 'BANCO_LOGO'
      Size = 200
    end
    object qryContasDT_REMESSA: TDateField
      FieldName = 'DT_REMESSA'
      Origin = 'DT_REMESSA'
    end
    object qryContasSEQ_REMESSA_DIA: TIntegerField
      FieldName = 'SEQ_REMESSA_DIA'
      Origin = 'SEQ_REMESSA_DIA'
    end
    object qryContasTIPO_IMPRESSAO: TStringField
      FieldName = 'TIPO_IMPRESSAO'
      Origin = 'TIPO_IMPRESSAO'
      FixedChar = True
      Size = 1
    end
    object qryContasTIPO_DOCUMENTO_SANTANDER: TStringField
      FieldName = 'TIPO_DOCUMENTO_SANTANDER'
      Origin = 'TIPO_DOCUMENTO_SANTANDER'
      FixedChar = True
      Size = 1
    end
    object qryContasTIPO_CARTEIRA: TStringField
      FieldName = 'TIPO_CARTEIRA'
      Origin = 'TIPO_CARTEIRA'
      Size = 2
    end
    object qryContasINATIVO: TStringField
      FieldName = 'INATIVO'
      Origin = 'INATIVO'
      FixedChar = True
      Size = 1
    end
    object qryContasCONTROLA_EMISSAO_BOLETO: TStringField
      FieldName = 'CONTROLA_EMISSAO_BOLETO'
      Origin = 'CONTROLA_EMISSAO_BOLETO'
      FixedChar = True
      Size = 1
    end
    object qryContasGERAR_BOLETO: TStringField
      FieldName = 'GERAR_BOLETO'
      Origin = 'GERAR_BOLETO'
      FixedChar = True
      Size = 1
    end
    object qryContasGERAR_DEPOSITO: TStringField
      FieldName = 'GERAR_DEPOSITO'
      Origin = 'GERAR_DEPOSITO'
      FixedChar = True
      Size = 1
    end
    object qryContasCOD_CONTABIL: TIntegerField
      FieldName = 'COD_CONTABIL'
      Origin = 'COD_CONTABIL'
    end
    object qryContasCODMORA: TSmallintField
      FieldName = 'CODMORA'
      Origin = 'CODMORA'
    end
    object qryContasREMESSA_TESTE: TStringField
      FieldName = 'REMESSA_TESTE'
      Origin = 'REMESSA_TESTE'
      FixedChar = True
      Size = 1
    end
    object qryContasEND_ARQUIVO_RET: TStringField
      FieldName = 'END_ARQUIVO_RET'
      Origin = 'END_ARQUIVO_RET'
      Size = 200
    end
    object qryContasID_CONTA_TECNOSPEED: TIntegerField
      FieldName = 'ID_CONTA_TECNOSPEED'
      Origin = 'ID_CONTA_TECNOSPEED'
    end
    object qryContasID_CONVENIO_TECNOSPEED: TSmallintField
      FieldName = 'ID_CONVENIO_TECNOSPEED'
      Origin = 'ID_CONVENIO_TECNOSPEED'
    end
    object qryContasREINICIAR_NUM_REMESSA_DIA: TStringField
      FieldName = 'REINICIAR_NUM_REMESSA_DIA'
      Origin = 'REINICIAR_NUM_REMESSA_DIA'
      FixedChar = True
      Size = 1
    end
  end
end
