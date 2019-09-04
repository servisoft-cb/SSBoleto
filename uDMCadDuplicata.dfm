object DMCadDuplicata: TDMCadDuplicata
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 262
  Width = 397
  object qryDuplicata: TFDQuery
    Connection = DMConection.FDConnection
    SQL.Strings = (
      
        'select DUP.*, CLI.NOME NOME_CLIENTE, CT.NOME NOME_CONTA, CART.CO' +
        'DIGO COD_CARTEIRA, CART.CODIGO_IMP COD_CARTEIRA_IMP,'
      
        '       CART.NOME NOME_CARTEIRA, CART.GERAR_NOSSONUMERO, CLI.PESS' +
        'OA, CLI.CNPJ_CPF, CLI.ENDERECO, CLI.NUM_END, CLI.CEP,'
      
        '       CLI.BAIRRO, CLI.CIDADE, CLI.UF, CLI.PESSOA_PGTO, CLI.ENDE' +
        'RECO_PGTO, CLI.NUM_END_PGTO, CLI.CEP_PGTO,'
      
        '       CLI.BAIRRO_PGTO, CLI.CIDADE_PGTO, CLI.UF_PGTO, CLI.CNPJ_C' +
        'PG_PGTO, CLI.EMAIL_PGTO, CLI.COMPLEMENTO_END,'
      
        '       CLI.COMPLEMENTO_END_PGTO, CART.GERAR_REMESSA, CLI.ID_GRUP' +
        'O, GP.NOME NOME_GRUPO,'
      
        '       CLI.ID_CARTEIRA ID_CARTEIRA_CLIENTE, CLI.COBRAR_TAXA_BANC' +
        'O TAXA_BANCO, NF.TIPO_REG, NF.NFECHAVEACESSO,'
      '       NS.COD_AUTENCIDADE_RET,'
      'CASE'
      '  WHEN DCOB.id_ocorrencia > 0 THEN DCOB.ID_OCORRENCIA'
      '  ELSE :ID_OCORRENCIA'
      '  END ID_OCORRENCIA_COB'
      'from DUPLICATA DUP'
      'inner join PESSOA CLI on (DUP.ID_PESSOA = CLI.CODIGO)'
      'left join CONTAS CT on (DUP.ID_CONTA_BOLETO = CT.ID)'
      'left join COB_CARTEIRA CART on (DUP.ID_CARTEIRA = CART.ID)'
      'left join TIPOCOBRANCA TC on (DUP.ID_TIPOCOBRANCA = TC.ID)'
      'left join NOTAFISCAL NF on DUP.ID_NOTA = NF.ID'
      'left join GRUPO_PESSOA GP on CLI.ID_GRUPO = GP.ID'
      'left join NOTASERVICO NS on DUP.ID_NOTA_SERVICO = NS.ID  '
      'left join duplicata_cob dcob'
      '  ON DUP.ID = DCOB.ID'
      '  AND DCOB.DTREMESSA IS NULL'
      '')
    Left = 32
    Top = 32
    ParamData = <
      item
        Name = 'ID_OCORRENCIA'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qryDuplicataID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryDuplicataTIPO_ES: TStringField
      DisplayLabel = 'Ent/Sai'
      FieldName = 'TIPO_ES'
      Origin = 'TIPO_ES'
      Size = 1
    end
    object qryDuplicataFILIAL: TIntegerField
      DisplayLabel = 'Filial'
      FieldName = 'FILIAL'
      Origin = 'FILIAL'
    end
    object qryDuplicataID_NOTA: TIntegerField
      DisplayLabel = 'Id Nota'
      FieldName = 'ID_NOTA'
      Origin = 'ID_NOTA'
    end
    object qryDuplicataPARCELA: TIntegerField
      DisplayLabel = 'Parcela'
      FieldName = 'PARCELA'
      Origin = 'PARCELA'
    end
    object qryDuplicataNUMDUPLICATA: TStringField
      DisplayLabel = 'N'#186' Dup'
      FieldName = 'NUMDUPLICATA'
      Origin = 'NUMDUPLICATA'
    end
    object qryDuplicataNUMNOTA: TIntegerField
      DisplayLabel = 'N'#186' Nota'
      FieldName = 'NUMNOTA'
      Origin = 'NUMNOTA'
    end
    object qryDuplicataSERIE: TStringField
      DisplayLabel = 'S'#233'rie'
      FieldName = 'SERIE'
      Origin = 'SERIE'
      Size = 3
    end
    object qryDuplicataDTVENCIMENTO: TDateField
      DisplayLabel = 'Dt Venc'
      FieldName = 'DTVENCIMENTO'
      Origin = 'DTVENCIMENTO'
    end
    object qryDuplicataVLR_PARCELA: TFloatField
      DisplayLabel = 'Vlr Parcela'
      FieldName = 'VLR_PARCELA'
      Origin = 'VLR_PARCELA'
      DisplayFormat = ',0.00'
      EditFormat = ',0.00'
    end
    object qryDuplicataVLR_RESTANTE: TFloatField
      DisplayLabel = 'Vlr Restante'
      FieldName = 'VLR_RESTANTE'
      Origin = 'VLR_RESTANTE'
      DisplayFormat = ',0.00'
      EditFormat = ',0.00'
    end
    object qryDuplicataVLR_PAGO: TFloatField
      DisplayLabel = 'Vlr Pago'
      FieldName = 'VLR_PAGO'
      Origin = 'VLR_PAGO'
      DisplayFormat = ',0.00'
      EditFormat = ',0.00'
    end
    object qryDuplicataVLR_DEVOLUCAO: TFloatField
      DisplayLabel = 'Vlr Devolu'#231#227'o'
      FieldName = 'VLR_DEVOLUCAO'
      Origin = 'VLR_DEVOLUCAO'
      DisplayFormat = ',0.00'
      EditFormat = ',0.00'
    end
    object qryDuplicataVLR_DESPESAS: TFloatField
      DisplayLabel = 'Vlr Despesa'
      FieldName = 'VLR_DESPESAS'
      Origin = 'VLR_DESPESAS'
      DisplayFormat = ',0.00'
      EditFormat = ',0.00'
    end
    object qryDuplicataVLR_DESCONTO: TFloatField
      DisplayLabel = 'Vlr Desconto'
      FieldName = 'VLR_DESCONTO'
      Origin = 'VLR_DESCONTO'
      DisplayFormat = ',0.00'
      EditFormat = ',0.00'
    end
    object qryDuplicataVLR_JUROSPAGOS: TFloatField
      DisplayLabel = 'Vlr Juros'
      FieldName = 'VLR_JUROSPAGOS'
      Origin = 'VLR_JUROSPAGOS'
      DisplayFormat = ',0.00'
      EditFormat = ',0.00'
    end
    object qryDuplicataVLR_COMISSAO: TFloatField
      DisplayLabel = 'Vlr Comiss'#227'o'
      FieldName = 'VLR_COMISSAO'
      Origin = 'VLR_COMISSAO'
      DisplayFormat = ',0.00'
      EditFormat = ',0.00'
    end
    object qryDuplicataPERC_COMISSAO: TFloatField
      DisplayLabel = '% Comiss'#227'o'
      FieldName = 'PERC_COMISSAO'
      Origin = 'PERC_COMISSAO'
      DisplayFormat = ',0.00'
      EditFormat = ',0.00'
    end
    object qryDuplicataDTULTPAGAMENTO: TDateField
      DisplayLabel = 'Dt Ult Pagto'
      FieldName = 'DTULTPAGAMENTO'
      Origin = 'DTULTPAGAMENTO'
    end
    object qryDuplicataID_PESSOA: TIntegerField
      FieldName = 'ID_PESSOA'
      Origin = 'ID_PESSOA'
    end
    object qryDuplicataID_CONTA: TIntegerField
      FieldName = 'ID_CONTA'
      Origin = 'ID_CONTA'
    end
    object qryDuplicataID_TIPOCOBRANCA: TIntegerField
      FieldName = 'ID_TIPOCOBRANCA'
      Origin = 'ID_TIPOCOBRANCA'
    end
    object qryDuplicataID_VENDEDOR: TIntegerField
      FieldName = 'ID_VENDEDOR'
      Origin = 'ID_VENDEDOR'
    end
    object qryDuplicataID_CONTA_BOLETO: TIntegerField
      FieldName = 'ID_CONTA_BOLETO'
      Origin = 'ID_CONTA_BOLETO'
    end
    object qryDuplicataID_COMISSAO: TIntegerField
      FieldName = 'ID_COMISSAO'
      Origin = 'ID_COMISSAO'
    end
    object qryDuplicataQTD_DIASATRASO: TIntegerField
      FieldName = 'QTD_DIASATRASO'
      Origin = 'QTD_DIASATRASO'
    end
    object qryDuplicataDTRECEBIMENTO_TITULO: TDateField
      FieldName = 'DTRECEBIMENTO_TITULO'
      Origin = 'DTRECEBIMENTO_TITULO'
    end
    object qryDuplicataDTEMISSAO: TDateField
      DisplayLabel = 'Dt Emiss'#227'o'
      FieldName = 'DTEMISSAO'
      Origin = 'DTEMISSAO'
    end
    object qryDuplicataPAGO_CARTORIO: TStringField
      FieldName = 'PAGO_CARTORIO'
      Origin = 'PAGO_CARTORIO'
      FixedChar = True
      Size = 1
    end
    object qryDuplicataPROTESTADO: TStringField
      FieldName = 'PROTESTADO'
      Origin = 'PROTESTADO'
      FixedChar = True
      Size = 1
    end
    object qryDuplicataTIPO_LANCAMENTO: TStringField
      FieldName = 'TIPO_LANCAMENTO'
      Origin = 'TIPO_LANCAMENTO'
      Size = 3
    end
    object qryDuplicataARQUIVO_GERADO: TStringField
      FieldName = 'ARQUIVO_GERADO'
      Origin = 'ARQUIVO_GERADO'
      FixedChar = True
      Size = 1
    end
    object qryDuplicataTRANSFERENCIA_ICMS: TStringField
      FieldName = 'TRANSFERENCIA_ICMS'
      Origin = 'TRANSFERENCIA_ICMS'
      FixedChar = True
      Size = 1
    end
    object qryDuplicataNOSSONUMERO: TStringField
      FieldName = 'NOSSONUMERO'
      Origin = 'NOSSONUMERO'
    end
    object qryDuplicataDTFINANCEIRO: TDateField
      FieldName = 'DTFINANCEIRO'
      Origin = 'DTFINANCEIRO'
    end
    object qryDuplicataNUMCHEQUE: TIntegerField
      FieldName = 'NUMCHEQUE'
      Origin = 'NUMCHEQUE'
    end
    object qryDuplicataACEITE: TStringField
      FieldName = 'ACEITE'
      Origin = 'ACEITE'
      FixedChar = True
      Size = 1
    end
    object qryDuplicataID_COB_ELETRONICA: TIntegerField
      FieldName = 'ID_COB_ELETRONICA'
      Origin = 'ID_COB_ELETRONICA'
    end
    object qryDuplicataBOLETO_IMP: TStringField
      FieldName = 'BOLETO_IMP'
      Origin = 'BOLETO_IMP'
      FixedChar = True
      Size = 1
    end
    object qryDuplicataID_CARTEIRA: TIntegerField
      FieldName = 'ID_CARTEIRA'
      Origin = 'ID_CARTEIRA'
    end
    object qryDuplicataID_BANCO: TIntegerField
      FieldName = 'ID_BANCO'
      Origin = 'ID_BANCO'
    end
    object qryDuplicataIMP_BOLETO: TStringField
      FieldName = 'IMP_BOLETO'
      Origin = 'IMP_BOLETO'
      FixedChar = True
      Size = 1
    end
    object qryDuplicataNUM_REMESSA: TIntegerField
      FieldName = 'NUM_REMESSA'
      Origin = 'NUM_REMESSA'
    end
    object qryDuplicataID_NOTA_SERVICO: TIntegerField
      FieldName = 'ID_NOTA_SERVICO'
      Origin = 'ID_NOTA_SERVICO'
    end
    object qryDuplicataDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 70
    end
    object qryDuplicataNUMRPS: TIntegerField
      FieldName = 'NUMRPS'
      Origin = 'NUMRPS'
    end
    object qryDuplicataANO_REF: TIntegerField
      FieldName = 'ANO_REF'
      Origin = 'ANO_REF'
    end
    object qryDuplicataMES_REF: TIntegerField
      FieldName = 'MES_REF'
      Origin = 'MES_REF'
    end
    object qryDuplicataNUM_CONTRATO: TIntegerField
      FieldName = 'NUM_CONTRATO'
      Origin = 'NUM_CONTRATO'
    end
    object qryDuplicataID_CONTA_ORCAMENTO: TIntegerField
      FieldName = 'ID_CONTA_ORCAMENTO'
      Origin = 'ID_CONTA_ORCAMENTO'
    end
    object qryDuplicataID_CUPOM: TIntegerField
      FieldName = 'ID_CUPOM'
      Origin = 'ID_CUPOM'
    end
    object qryDuplicataVLR_TAXA_BANCARIA: TFloatField
      FieldName = 'VLR_TAXA_BANCARIA'
      Origin = 'VLR_TAXA_BANCARIA'
    end
    object qryDuplicataCOBRAR_TAXA: TStringField
      FieldName = 'COBRAR_TAXA'
      Origin = 'COBRAR_TAXA'
      Size = 1
    end
    object qryDuplicataID_TERMINAL: TIntegerField
      FieldName = 'ID_TERMINAL'
      Origin = 'ID_TERMINAL'
    end
    object qryDuplicataID_FECHAMENTO: TIntegerField
      FieldName = 'ID_FECHAMENTO'
      Origin = 'ID_FECHAMENTO'
    end
    object qryDuplicataTIPO_MOV: TStringField
      FieldName = 'TIPO_MOV'
      Origin = 'TIPO_MOV'
      FixedChar = True
      Size = 1
    end
    object qryDuplicataNOSSONUMERO_SEQ: TLargeintField
      FieldName = 'NOSSONUMERO_SEQ'
      Origin = 'NOSSONUMERO_SEQ'
    end
    object qryDuplicataNOSSONUMERO_GERADO: TStringField
      FieldName = 'NOSSONUMERO_GERADO'
      Origin = 'NOSSONUMERO_GERADO'
      FixedChar = True
      Size = 1
    end
    object qryDuplicataNUMDUPLICATA_SEQ: TIntegerField
      FieldName = 'NUMDUPLICATA_SEQ'
      Origin = 'NUMDUPLICATA_SEQ'
    end
    object qryDuplicataID_RECIBO: TIntegerField
      FieldName = 'ID_RECIBO'
      Origin = 'ID_RECIBO'
    end
    object qryDuplicataID_PEDIDO: TIntegerField
      FieldName = 'ID_PEDIDO'
      Origin = 'ID_PEDIDO'
    end
    object qryDuplicataPERC_COMISSAO_PAGAR_NOTA: TFloatField
      FieldName = 'PERC_COMISSAO_PAGAR_NOTA'
      Origin = 'PERC_COMISSAO_PAGAR_NOTA'
    end
    object qryDuplicataUSUARIO: TStringField
      FieldName = 'USUARIO'
      Origin = 'USUARIO'
    end
    object qryDuplicataTITULO_CARTORIO: TStringField
      FieldName = 'TITULO_CARTORIO'
      Origin = 'TITULO_CARTORIO'
      FixedChar = True
      Size = 1
    end
    object qryDuplicataID_DESCONTADA: TIntegerField
      FieldName = 'ID_DESCONTADA'
      Origin = 'ID_DESCONTADA'
    end
    object qryDuplicataCONFIRMA_PGTO: TStringField
      FieldName = 'CONFIRMA_PGTO'
      Origin = 'CONFIRMA_PGTO'
      FixedChar = True
      Size = 1
    end
    object qryDuplicataCOD_ANT: TIntegerField
      FieldName = 'COD_ANT'
      Origin = 'COD_ANT'
    end
    object qryDuplicataPERC_BASE_COMISSAO: TFloatField
      FieldName = 'PERC_BASE_COMISSAO'
      Origin = 'PERC_BASE_COMISSAO'
    end
    object qryDuplicataEMISSAO_BOLETO: TStringField
      FieldName = 'EMISSAO_BOLETO'
      Origin = 'EMISSAO_BOLETO'
      FixedChar = True
      Size = 1
    end
    object qryDuplicataDESCRICAO2: TStringField
      FieldName = 'DESCRICAO2'
      Origin = 'DESCRICAO2'
      Size = 100
    end
    object qryDuplicataID_CONTRATO: TIntegerField
      FieldName = 'ID_CONTRATO'
      Origin = 'ID_CONTRATO'
    end
    object qryDuplicataVLR_MULTA: TFloatField
      FieldName = 'VLR_MULTA'
      Origin = 'VLR_MULTA'
    end
    object qryDuplicataID_CONTABIL_OPE_LACTO: TIntegerField
      FieldName = 'ID_CONTABIL_OPE_LACTO'
      Origin = 'ID_CONTABIL_OPE_LACTO'
    end
    object qryDuplicataID_CONTABIL_OPE_BAIXA: TIntegerField
      FieldName = 'ID_CONTABIL_OPE_BAIXA'
      Origin = 'ID_CONTABIL_OPE_BAIXA'
    end
    object qryDuplicataREGIME_CAIXA: TStringField
      FieldName = 'REGIME_CAIXA'
      Origin = 'REGIME_CAIXA'
      FixedChar = True
      Size = 1
    end
    object qryDuplicataPERDIDO: TStringField
      FieldName = 'PERDIDO'
      Origin = 'PERDIDO'
      Size = 1
    end
    object qryDuplicataINSTRUCAO_PROTESTO: TStringField
      FieldName = 'INSTRUCAO_PROTESTO'
      Origin = 'INSTRUCAO_PROTESTO'
      FixedChar = True
      Size = 1
    end
    object qryDuplicataNGR: TStringField
      FieldName = 'NGR'
      Origin = 'NGR'
      FixedChar = True
      Size = 1
    end
    object qryDuplicataAPROVADO: TStringField
      FieldName = 'APROVADO'
      Origin = 'APROVADO'
      FixedChar = True
      Size = 1
    end
    object qryDuplicataDTAPROVADO: TDateField
      FieldName = 'DTAPROVADO'
      Origin = 'DTAPROVADO'
    end
    object qryDuplicataCANCELADA: TStringField
      FieldName = 'CANCELADA'
      Origin = 'CANCELADA'
      Size = 1
    end
    object qryDuplicataDTVENCIMENTO_INI: TDateField
      FieldName = 'DTVENCIMENTO_INI'
      Origin = 'DTVENCIMENTO_INI'
    end
    object qryDuplicataNOME_CLIENTE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME_CLIENTE'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 60
    end
    object qryDuplicataNOME_CONTA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME_CONTA'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object qryDuplicataCOD_CARTEIRA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'COD_CARTEIRA'
      Origin = 'CODIGO'
      ProviderFlags = []
      ReadOnly = True
      Size = 3
    end
    object qryDuplicataCOD_CARTEIRA_IMP: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'COD_CARTEIRA_IMP'
      Origin = 'CODIGO_IMP'
      ProviderFlags = []
      ReadOnly = True
      Size = 7
    end
    object qryDuplicataNOME_CARTEIRA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME_CARTEIRA'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object qryDuplicataGERAR_NOSSONUMERO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'GERAR_NOSSONUMERO'
      Origin = 'GERAR_NOSSONUMERO'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object qryDuplicataPESSOA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'PESSOA'
      Origin = 'PESSOA'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object qryDuplicataCNPJ_CPF: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CNPJ_CPF'
      Origin = 'CNPJ_CPF'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryDuplicataENDERECO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'ENDERECO'
      Origin = 'ENDERECO'
      ProviderFlags = []
      ReadOnly = True
      Size = 60
    end
    object qryDuplicataNUM_END: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NUM_END'
      Origin = 'NUM_END'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryDuplicataCEP: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CEP'
      Origin = 'CEP'
      ProviderFlags = []
      ReadOnly = True
      Size = 10
    end
    object qryDuplicataBAIRRO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'BAIRRO'
      Origin = 'BAIRRO'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object qryDuplicataCIDADE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      ProviderFlags = []
      ReadOnly = True
      Size = 40
    end
    object qryDuplicataUF: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'UF'
      Origin = 'UF'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 2
    end
    object qryDuplicataPESSOA_PGTO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'PESSOA_PGTO'
      Origin = 'PESSOA_PGTO'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object qryDuplicataENDERECO_PGTO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'ENDERECO_PGTO'
      Origin = 'ENDERECO_PGTO'
      ProviderFlags = []
      ReadOnly = True
      Size = 40
    end
    object qryDuplicataNUM_END_PGTO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NUM_END_PGTO'
      Origin = 'NUM_END_PGTO'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryDuplicataCEP_PGTO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CEP_PGTO'
      Origin = 'CEP_PGTO'
      ProviderFlags = []
      ReadOnly = True
      Size = 10
    end
    object qryDuplicataBAIRRO_PGTO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'BAIRRO_PGTO'
      Origin = 'BAIRRO_PGTO'
      ProviderFlags = []
      ReadOnly = True
      Size = 26
    end
    object qryDuplicataCIDADE_PGTO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CIDADE_PGTO'
      Origin = 'CIDADE_PGTO'
      ProviderFlags = []
      ReadOnly = True
      Size = 40
    end
    object qryDuplicataUF_PGTO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'UF_PGTO'
      Origin = 'UF_PGTO'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 2
    end
    object qryDuplicataCNPJ_CPG_PGTO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CNPJ_CPG_PGTO'
      Origin = 'CNPJ_CPG_PGTO'
      ProviderFlags = []
      ReadOnly = True
      Size = 18
    end
    object qryDuplicataEMAIL_PGTO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'EMAIL_PGTO'
      Origin = 'EMAIL_PGTO'
      ProviderFlags = []
      ReadOnly = True
      Size = 150
    end
    object qryDuplicataCOMPLEMENTO_END: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'COMPLEMENTO_END'
      Origin = 'COMPLEMENTO_END'
      ProviderFlags = []
      ReadOnly = True
      Size = 60
    end
    object qryDuplicataCOMPLEMENTO_END_PGTO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'COMPLEMENTO_END_PGTO'
      Origin = 'COMPLEMENTO_END_PGTO'
      ProviderFlags = []
      ReadOnly = True
      Size = 60
    end
    object qryDuplicataGERAR_REMESSA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'GERAR_REMESSA'
      Origin = 'GERAR_REMESSA'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object qryDuplicataID_GRUPO: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'ID_GRUPO'
      Origin = 'ID_GRUPO'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryDuplicataNOME_GRUPO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME_GRUPO'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 40
    end
    object qryDuplicataID_CARTEIRA_CLIENTE: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'ID_CARTEIRA_CLIENTE'
      Origin = 'ID_CARTEIRA'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryDuplicataTAXA_BANCO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'TAXA_BANCO'
      Origin = 'COBRAR_TAXA_BANCO'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object qryDuplicataTIPO_REG: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'TIPO_REG'
      Origin = 'TIPO_REG'
      ProviderFlags = []
      ReadOnly = True
      Size = 3
    end
    object qryDuplicataNFECHAVEACESSO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NFECHAVEACESSO'
      Origin = 'NFECHAVEACESSO'
      ProviderFlags = []
      ReadOnly = True
      Size = 44
    end
    object qryDuplicataCOD_AUTENCIDADE_RET: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'COD_AUTENCIDADE_RET'
      Origin = 'COD_AUTENCIDADE_RET'
      ProviderFlags = []
      ReadOnly = True
      Size = 15
    end
    object qryDuplicataID_OCORRENCIA_COB: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'ID_OCORRENCIA_COB'
      Origin = 'ID_OCORRENCIA_COB'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object qryContas: TFDQuery
    BeforeScroll = qryContasBeforeScroll
    Connection = DMConection.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      
        'select CT.*, B.CODIGO COD_BANCO, B.NOME NOME_BANCO, CART.CODIGO ' +
        'COD_CARTEIRA, CART.CODIGO_IMP COD_CARTEIRA_IMP,'
      
        '       CART.NOME NOME_CARTEIRA, CART.GERAR_NOSSONUMERO, INS1.COD' +
        'IGO COD_INSTRUCAO1,'
      
        '       INS1.COD_REDUZIDO COD_RED_INSTRUCAO1, INS1.TIPO_INST TIPO' +
        '_INSTRUCAO1, INS2.CODIGO COD_INSTRUCAO2,'
      
        '       INS2.COD_REDUZIDO COD_RED_INSTRUCAO2, INS2.TIPO_INST TIPO' +
        '_INSTRUCAO2, ESP.CODIGO COD_ESPECIE,'
      
        '       ESP.COD_REDUZIDO COD_RED_ESPECIE, OCO.CODIGO COD_OCORRENC' +
        'IA, OCO.COD_REDUZIDO COD_RED_OCORRENCIA,'
      
        '       B.OPCAO_GERAR_NOSSNUMERO, ESP.GERAR_NOSSONUMERO GERAR_NOS' +
        'SONUMERO_ESP, CART.GERAR_REMESSA,'
      
        '       B.ACBR_USAR_MONTAR_NOSSONUMERO, B.INICIAL_NOME_ARQ_REMESS' +
        'A'
      'from CONTAS CT'
      'inner join BANCO B on (CT.ID_BANCO = B.ID)'
      'left join COB_CARTEIRA CART on (CT.ID_CARTEIRA = CART.ID)'
      'left join COB_TIPO_CADASTRO INS1 on (CT.ID_INSTRUCAO1 = INS1.ID)'
      'left join COB_TIPO_CADASTRO INS2 on (CT.ID_INSTRUCAO2 = INS2.ID)'
      'left join COB_TIPO_CADASTRO ESP on (CT.ID_ESPECIE = ESP.ID)'
      'left join COB_TIPO_CADASTRO OCO on (CT.ID_OCORRENCIA = OCO.ID)'
      'where CT.TIPO_CONTA = '#39'B'#39' ')
    Left = 32
    Top = 88
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
    object qryContasCOD_BANCO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'COD_BANCO'
      Origin = 'CODIGO'
      ProviderFlags = []
      ReadOnly = True
      Size = 3
    end
    object qryContasNOME_BANCO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME_BANCO'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 60
    end
    object qryContasCOD_CARTEIRA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'COD_CARTEIRA'
      Origin = 'CODIGO'
      ProviderFlags = []
      ReadOnly = True
      Size = 3
    end
    object qryContasCOD_CARTEIRA_IMP: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'COD_CARTEIRA_IMP'
      Origin = 'CODIGO_IMP'
      ProviderFlags = []
      ReadOnly = True
      Size = 7
    end
    object qryContasNOME_CARTEIRA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME_CARTEIRA'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object qryContasGERAR_NOSSONUMERO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'GERAR_NOSSONUMERO'
      Origin = 'GERAR_NOSSONUMERO'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object qryContasCOD_INSTRUCAO1: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'COD_INSTRUCAO1'
      Origin = 'CODIGO'
      ProviderFlags = []
      ReadOnly = True
      Size = 3
    end
    object qryContasCOD_RED_INSTRUCAO1: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'COD_RED_INSTRUCAO1'
      Origin = 'COD_REDUZIDO'
      ProviderFlags = []
      ReadOnly = True
      Size = 3
    end
    object qryContasTIPO_INSTRUCAO1: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'TIPO_INSTRUCAO1'
      Origin = 'TIPO_INST'
      ProviderFlags = []
      ReadOnly = True
      Size = 3
    end
    object qryContasCOD_INSTRUCAO2: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'COD_INSTRUCAO2'
      Origin = 'CODIGO'
      ProviderFlags = []
      ReadOnly = True
      Size = 3
    end
    object qryContasCOD_RED_INSTRUCAO2: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'COD_RED_INSTRUCAO2'
      Origin = 'COD_REDUZIDO'
      ProviderFlags = []
      ReadOnly = True
      Size = 3
    end
    object qryContasTIPO_INSTRUCAO2: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'TIPO_INSTRUCAO2'
      Origin = 'TIPO_INST'
      ProviderFlags = []
      ReadOnly = True
      Size = 3
    end
    object qryContasCOD_ESPECIE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'COD_ESPECIE'
      Origin = 'CODIGO'
      ProviderFlags = []
      ReadOnly = True
      Size = 3
    end
    object qryContasCOD_RED_ESPECIE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'COD_RED_ESPECIE'
      Origin = 'COD_REDUZIDO'
      ProviderFlags = []
      ReadOnly = True
      Size = 3
    end
    object qryContasCOD_OCORRENCIA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'COD_OCORRENCIA'
      Origin = 'CODIGO'
      ProviderFlags = []
      ReadOnly = True
      Size = 3
    end
    object qryContasCOD_RED_OCORRENCIA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'COD_RED_OCORRENCIA'
      Origin = 'COD_REDUZIDO'
      ProviderFlags = []
      ReadOnly = True
      Size = 3
    end
    object qryContasOPCAO_GERAR_NOSSNUMERO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'OPCAO_GERAR_NOSSNUMERO'
      Origin = 'OPCAO_GERAR_NOSSNUMERO'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object qryContasGERAR_NOSSONUMERO_ESP: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'GERAR_NOSSONUMERO_ESP'
      Origin = 'GERAR_NOSSONUMERO'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object qryContasGERAR_REMESSA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'GERAR_REMESSA'
      Origin = 'GERAR_REMESSA'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object qryContasACBR_USAR_MONTAR_NOSSONUMERO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'ACBR_USAR_MONTAR_NOSSONUMERO'
      Origin = 'ACBR_USAR_MONTAR_NOSSONUMERO'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object qryContasINICIAL_NOME_ARQ_REMESSA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'INICIAL_NOME_ARQ_REMESSA'
      Origin = 'INICIAL_NOME_ARQ_REMESSA'
      ProviderFlags = []
      ReadOnly = True
      Size = 2
    end
  end
  object dsContas: TDataSource
    DataSet = qryContas
    Left = 64
    Top = 89
  end
  object qryOcorrencia: TFDQuery
    Connection = DMConection.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'select *'
      'from COB_TIPO_CADASTRO'
      'where (TIPO_REG = :TIPO_REG) AND'
      '      (ID_BANCO = :ID_BANCO or :ID_BANCO = 0)  ')
    Left = 32
    Top = 144
    ParamData = <
      item
        Name = 'TIPO_REG'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ID_BANCO'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object qryOcorrenciaENVIAR_DIAS_PROTESTO: TStringField
      FieldName = 'ENVIAR_DIAS_PROTESTO'
      Origin = 'ENVIAR_DIAS_PROTESTO'
      FixedChar = True
      Size = 1
    end
    object qryOcorrenciaID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryOcorrenciaCODIGO: TStringField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      Size = 3
    end
    object qryOcorrenciaNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 100
    end
    object qryOcorrenciaTIPO_REG: TStringField
      FieldName = 'TIPO_REG'
      Origin = 'TIPO_REG'
      Size = 3
    end
    object qryOcorrenciaID_BANCO: TIntegerField
      FieldName = 'ID_BANCO'
      Origin = 'ID_BANCO'
    end
    object qryOcorrenciaCOD_REDUZIDO: TStringField
      FieldName = 'COD_REDUZIDO'
      Origin = 'COD_REDUZIDO'
      Size = 3
    end
    object qryOcorrenciaTIPO_INST: TStringField
      FieldName = 'TIPO_INST'
      Origin = 'TIPO_INST'
      Size = 3
    end
    object qryOcorrenciaTIPO_PROTESTO: TStringField
      FieldName = 'TIPO_PROTESTO'
      Origin = 'TIPO_PROTESTO'
      Size = 1
    end
    object qryOcorrenciaGERAR_NOSSONUMERO: TStringField
      FieldName = 'GERAR_NOSSONUMERO'
      Origin = 'GERAR_NOSSONUMERO'
      FixedChar = True
      Size = 1
    end
    object qryOcorrenciaGERAR_REMESSA: TStringField
      FieldName = 'GERAR_REMESSA'
      Origin = 'GERAR_REMESSA'
      FixedChar = True
      Size = 1
    end
    object qryOcorrenciaCOD_BANCO: TStringField
      FieldName = 'COD_BANCO'
      Origin = 'COD_BANCO'
      FixedChar = True
      Size = 3
    end
    object qryOcorrenciaTIPO_OCO: TStringField
      FieldName = 'TIPO_OCO'
      Origin = 'TIPO_OCO'
      Size = 3
    end
  end
  object dsOcorrencia: TDataSource
    DataSet = qryOcorrencia
    Left = 64
    Top = 145
  end
end
