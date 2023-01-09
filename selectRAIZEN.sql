6.3 Arg de Pesquisa
    Colocar o pedido da Nota
6.5 Agrumento de Pesquisa    
    email do solicitante
    
    
SELECT *
FROM TDVADM.T_UTI_GERAPLANILHA GP
WHERE gp.uti_geraplanilha_codigo LIKE 'fatRAIZEM%'
  or upper(gp.uti_geraplanilha_titulo) like '%RAIZEN%'
for update
  

SELECT * FROM TDVADM.T_UTI_GERAPLANILHAUSU GP
WHERE 0 = 0
  and GP.USU_USUARIO_CODIGO = 'brunacdv'
  and gp.uti_geraplanilha_codigo LIKE 'fatRAIZEM%'
for update
  

--6.1
select "AXO Destino",
       "Ano Veículo",
       "Autorizador",
       "C/E",
       "CFOP DESCRICAO",
       CFOP,
       "CNPJ Consignatário",
       "CNPJ Destinatário",
       "CNPJ Remetente",
       CNPJFILIAL,
       "COD ONU",
       CTEROTA,
       CTESEFAZ,
       "Cheg Portaria",
       "Consignatário",
       DATAAUTCOL,
       DIGMANUAL,
       "Data de Geraçao ASN",
       "Desc NOTA",
       "Destinatário",
       "Dt Carregamento",
       "Dt Inclusão Recebimento",
       "Dt Progr. Coleta",
       "EFETIVAÇÃO DA COLETA",
       EXPNRFORMPQ,
       "Emissão CTRC",
       FATURA2,
       "Filial Transp",
       "Frete Peso (Rota*Peso)",
       "Frete",
       GRUPOSAC,
       "GrupoREM",
       "ID Carga",
       "ID Viagem",
       ID_CTE,
       "Img Disponivel",
       "Incoterm",
       "KM Percurso",
       LOCALCOLETA,
       LOCALENTREGA,
       MODALIDADE,
       "Mesorregião Destino",
       "Mesorregião Origem",
       "Município Destino",
       "Município Origem",
       "N. CTRC de devolução",
       NF1,
       NF2,
       NFESEFAZ,
       "No. Pedido Coleta",
       OBSENTREGA,
       "ONU DESCRICAO",
       "Operação",
       PESOVALEFRETE01,
       PLACA,
       PRIORIDADE,
       "Peso Cobrado KG",
       "Pgto Caixa",
       "Placa Veículo Entrega",
       "Previsao Chegada",
       "PrevisaoDTVF",
       QUEMAUTCOL,
       "Quant. Volumes",
       "Remetente",
       "Saída CD",
       "Solicit. Coleta",
       "Solicitante",
       "Solicitação Coleta",
       TIPOCARGAXML,
       TIPOCARGA,
       TIPOPRVEIC,
       TIPOSOLICITACAO,
       TIPO_FRETE,
       "Tipo Carga2",
       "Tipo Carga3",
       "Tipo Carga",
       "Tipo Imagem",
       "Transf Para",
       "UF Destino",
       "UF Origem",
       "UF Transp",
       "Usuario Baixou",
       "Usuario Digitalizou",
       VEICULOSOLICITADO,
       "Valor Frete Total",
       "Veículo Utilizado Entrega",
       "Valor Mercadorias",
----       a.PEDAGIO,
----       VALOR_FRETE_SEM_IMPOSTO,
----       SEGURO,
----       VALOR_SEGURO_SEM_IMPOSTO,
       TIPO_FRETE TIPO_OPERACAO,
       PROTOCOLOENVIO,
       CARREGAMENTOPR,
       DI
       "Peso NF TON"
from tdvadm.v_con_petrans a
where GRUPOSAC = '0628'
  and "Dt Progr. Coleta" >= '10/07/2018'
;
  

--6.2
select CTRC,
       N_CTRC,
       N_CTRC_NFSE,
       EMISSAOCTRC,
       CHEGADAPORTARIA,
       MATERIAL,
       FORNECEDOR,
       NOTA_FISCAL,
       VALOR_NFE,
       PEDAGIO,
       FRETE_PESO,
       VALOR_FRETE_SEM_IMPOSTO,
       SEGURO,
       VALOR_SEGURO_SEM_IMPOSTO,
       VALORFRETE,
       CHAVE_CTE,
       TIPO_OPERACAO,
       a.COLETA,
       PROTOCOLOENVIO,
       IDVIAGEM,
       CARREGAMENTOPR,
       DI,
       CHEGADAPORTARIA,
       TIPO_FRETE,
       VEICULOSOLICITADO,
       PESONFTON,
       CTESEFAZ,
       NFESEFAZ,
       CNPJREMETENTE,
       UFORIGEM,
       MUNICIPIOORIGEM,
       CNPJDESTINATARIO,
       DESTINATARIO,
       UFDESTINO,
       MUNICIPIODESTINO
from tdvadm.v_ptrans_faturamento a;


--6.3
select ALMOX DEST,
       ARMAZEM_ATUAL,
       ARMAZEM_ORIGEM,
       BAIXA_OCORRENCIA,
       CIDADE_DESTINO,
       CIDADE_ORIGEM,
       COLETAOCOR,
       COLETA,
       CTRC_SERIE_ROTA,
       UF "UF Destino",
       STATUS ,
       DATA_INCLUSAO,
       DESTINATARIO_CNPJ,
       GRUPO_SACADO "GRUPO ECONÔMICO",
       DESTINATARIO_RAZAO,
       DIGITALIZOU,
       PREVAGEND "LIM EMBARCAR",
       FATCOD,
       FATRT,
       KM,
       MERCADORIA,
       NOTA,
       NOTA_PESO,
       NOTA_VALOR,
       ONU,
---       PEDIDO_NOTA,
       PRIORIDADE,
       REMETENTE_CNPJ,
       REMETENTE_RAZAO,
       TRANSFERENCIA,
--       UF,
       UF_ORIGEM,
       VOLUME
from tdvadm.v_arm_notasarmazens_chaves
--from tdvadm.v_slacoleta_default a
where grupo_sacado = '0628';

select *
from tdvadm.t_arm_coletapriorizada

--6.5
select ALX,
       ARMAZEM "Armazem",
       ARMAZEM_DESC "Filial",
       ARM_COLETA_DTAUTORIZA,
       ARM_COLETA_DTIMP "Arm Coleta Dtimp",
       ARM_COLETA_DTPROGRAMACAO "Arm Coleta Dtprogramacao",
       ARM_COLETA_DTSOLICITACAO "Arm Coleta Dtsolicitacao",
       ARM_COLETA_FONESOLIC "Arm Coleta Fonesolic",
       ARM_COLETA_NCOMPRA "Coleta",
       ARM_COLETA_PAGADORFRETE "Arm Coleta Pagadorfrete",
       ARM_COLETA_PESO "Peso",
       TPCARGA "Prioridade",
       decode(TPCARGA,'N','NORMAL','EXPRESSA') "Descricao Prioridade",
       ARM_COLETA_SOLICITANTE "Arm Coleta Solicitante",
--       "Email solicitante",
       ARM_COLETA_VOLUMES "Arm Coleta Volumes",
       DESCRIÇÃO_CARGA "Descrição Carga",
       DEST_CIDADE "Cid. Destino",
       DEST_COMPLEMENTO "Dest Complemento",
       DEST_ENDERECO "Dest Endereco",
       DEST_RAZAOSOCIAL "Dest Razaosocial",
       DEST_UF "Dest Uf",
       Embalagem,
       GRUPOSACADO "Grupo Econ.",
       Kmcoleta,
       KM,
       Mercadoria,
       Motorista,
       Placa,
       REMETE_CIDADE "Cid. Origem",
       REMET_COMPLEMENTO "Remet Complemento",
       REMET_ENDERECO "Remet Endereco",
       REMET_RAZAOSOCIAL Remetente,
       REMET_UF "Remet Uf",
       Rota,
       Status,
--        TPCARGA,
       USUARIOFECHOU "Usuariofechou",
       USUARIO_IMPRIMIU "Usuario Imprimiu",
       Veiculo
--       XML_COLETA_NUMERO "Xml Coleta Numero"
--       TPCARGA "Tp. Carga"
from tdvadm.v_ope_gercolcoletar
where GRUPOSACADO = '0628'
  and rownum < 15
  

