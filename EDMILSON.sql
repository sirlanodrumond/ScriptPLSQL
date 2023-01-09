Vale-frete, 
Data hora do Vale-frete,
Valor do Vale-frete,
Primeiro Saque Ativo
Dt de Carregamento,
Numero do Carregamento,
Placa do Vale-frete,
Vinculo Tipo do Motorista,
Motorista do vale-frete,
Tipo de veículo vinculado no Vale-frete,



SELECT a.glb_rota_codigo "Filial",
       an.arm_nota_mercadoria "Mercadoria",
       an.arm_nota_numero "Numero da Nota",
       an.arm_nota_pesobalanca "Peso Nota",
       an.arm_nota_peso "Peso Indicado",
       tdvadm.fn_busca_codigoibge(an.arm_nota_localcoletal,'IBD') "Cidade origem",
       tdvadm.fn_busca_codigoibge(an.arm_nota_localentregal,'IBD') "Cidade destino",
       TDVADM.FN_CNPJ_RAZAOSOCIAL(an.glb_cliente_cgccpfdestinatario) "Destinatário",
       TDVADM.FN_CNPJ_RAZAOSOCIAL(an.glb_cliente_cgccpfremetente) "Remetente",
       (select G.GLB_GRUPOECONOMICO_NOME 
        from tdvadm.t_glb_cliente cl,
             tdvadm.t_glb_grupoeconomico g
        where cl.glb_cliente_cgccpfcodigo = rpad(an.glb_cliente_cgccpfsacado,20)
          and cl.glb_grupoeconomico_codigo = g.glb_grupoeconomico_codigo) "Grupo econômico",
       AN.SLF_CONTRATO_CODIGO "Número do contrato",
       TDVADM.FN_RETORNA_CTRCTIPOFRETE(an.con_conhecimento_codigo,an.con_conhecimento_serie,an.glb_rota_codigo) "Tipo de Carga",
       (select DECODE(CO.ARM_COLETA_TPCOLETA,'E','EXPRESSA','NORMAL') 
        from tdvadm.t_arm_coleta co
        where co.arm_coleta_ncompra = an.arm_coleta_ncompra
          and co.arm_coleta_ciclo = an.arm_coleta_ciclo) "Tipo de Frete"
FROM TDVADM.T_ARM_NOTA AN,
     TDVADM.T_ARM_CARREGAMENTODET CD,
     TDVADM.T_ARM_ARMAZEM A
WHERE AN.ARM_NOTA_DTINCLUSAO >= '01/05/2018'
  AND AN.ARM_EMBALAGEM_NUMERO = CD.ARM_EMBALAGEM_NUMERO
  AND AN.ARM_EMBALAGEM_FLAG = CD.ARM_EMBALAGEM_FLAG
  AND AN.ARM_EMBALAGEM_SEQUENCIA = CD.ARM_EMBALAGEM_SEQUENCIA
  AND AN.ARM_ARMAZEM_CODIGO = A.ARM_ARMAZEM_CODIGO
  AND AN.CON_CONHECIMENTO_CODIGO IS NOT NULL

  
