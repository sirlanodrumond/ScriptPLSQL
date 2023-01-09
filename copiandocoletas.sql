select * from tdvadm.t_arq_gravados;
tdvadm.sp_jobcoleta;
tdvadm.pkg_arm_coleta;


select to_char(COLETA_DTSOLIC,'YYYYMM') ref,max(sysdate) data,count(*) from tdvadm.V_KPI_ANALISECOLETA
--delete tdvadm.V_KPI_ANALISECOLETA
     WHERE TRUNC(COLETA_DTSOLIC) >= '01/01/2020'
group by to_char(COLETA_DTSOLIC,'YYYYMM')
order by 1;

SELECT * FROM TDVADM.T_CAR_DEDICADO



select * from t_col_asnstatus
-- T_COL_ASN - Coletas
insert into tdvadm.t_col_asn
select asn.col_asn_id,
       1 col_asnstatus_id, -- Asn Aguardando processamento
       asn.col_asn_numero,
       asn.col_asn_idnimbi,
       asn.col_asn_ponumber,
       asn.col_asn_dtaltnimbi,
       sysdate col_asn_dtgravacao,
       sysdate col_asn_dtemissao,
       sysdate + 1 col_asn_dtprogcoleta,
       asn.col_asn_dtestimadacoleta,
       asn.col_asn_dtrealcoleta,
       asn.col_asn_dtprocessamento,          
       asn.col_asn_obs,
       asn.col_asn_obsrejeicao,
       asn.col_asn_obscancelamento,
       asn.col_asn_instrucoesembarque,
       asn.col_asn_alturatotal,
       asn.col_asn_comprimentototal,
       asn.col_asn_larguratotal,
       asn.col_asn_finalidade,
       asn.col_asn_nrodocimportacao,
       asn.col_asn_nroformperigoso,
       asn.col_asn_nrosolicitante,
       asn.col_asn_numeronfe,
       asn.col_asn_numeroonu,
       asn.col_asn_pesoreal,
       asn.col_asn_pesoestimado,
       asn.col_asn_pesoestimadouom,
       asn.col_asn_incoterms,
       asn.col_asn_tipocarga,
       asn.col_asn_tipocontainer,
       asn.col_asn_tipoveiculo,
       asn.col_asn_volumetotal,
       asn.col_asn_volumetotalcubico,
       asn.col_asn_valorestimado,
       null arm_coleta_ncompra, -- Nulo para criacao da Coleta
       null arm_coleta_ciclo,   -- Nulo para criacao da Coleta Ciclo
       asn.arm_armazem_codigo,
       asn.col_asn_fragileload,
       asn.col_asn_rollingload,
       asn.col_asn_selfsupportingload,
       asn.col_asn_divisibleload,
       asn.col_asn_container,
       asn.col_asn_tire,
       asn.col_asn_specialprocesscode,
       asn.col_asn_shipcitytaxcode,
       asn.slf_contrato_numero,
       asn.col_asn_operacao 
from tdvadm.t_col_asn@database_tdp asn
where asn.col_asn_numero in ('V830104589','V830117872','N000622937','V830118156','V840020716','V830126794','6593108473','V830127469');

-- T_COL_ASNITEM - Itens das Coletas
insert into tdvadm.t_col_asnitem
select i.col_asnitem_id,
       i.col_asnitem_descricao,
       i.col_asnitem_embalagem,
       i.col_asnitem_itemnumforn,
       i.col_asnitem_podata,
       i.col_asnitem_ponumber,
       i.col_asnitem_poitemnumero,
       i.col_asnitem_quantidade,
       i.col_asnitem_uom,
       i.col_asn_id,
       null col_asnitem_center,
       null col_asnitem_deposit,
       null col_asnitem_depositnumber,
       i.col_asnitem_order,
       null col_asnitem_equipament,
       i.col_asnitem_unloadingpoint,
       i.col_asnitem_receiver  
from tdvadm.t_col_asnitem@database_tdp i
where i.col_asn_id in (select asn.col_asn_id from tdvadm.t_col_asn@database_tdp asn where asn.col_asn_numero in ('V830104589','V830117872','N000622937','V830118156','V840020716','V830126794','6593108473','V830127469'));

-- T_COL_ASNARQUIVO - Arquivo original da ASN
insert into tdvadm.t_col_asnarquivo
select a.col_asnarquivo_id,
       a.col_asnarquivo_dtgravacao,
       a.col_asnarquivo_arquivo,
       a.col_asn_id
from tdvadm.t_col_asnarquivo@database_tdp a
where a.col_asn_id in (select asn.col_asn_id from tdvadm.t_col_asn@database_tdp asn where asn.col_asn_numero in ('V830104589','V830117872','N000622937','V830118156','V840020716','V830126794','6593108473','V830127469'));



-- Cria o Cliente Caso não existe
insert into tdvadm.t_glb_cliente
select * 
from tdvadm.t_glb_cliente@database_tdp cl
where cl.glb_cliente_cgccpfcodigo in (select rpad(p.col_asnparceiro_cnpj,20)
                                      From tdvadm.t_col_asnparceiro@database_tdp p 
                                      where p.col_asn_id in (select asn.col_asn_id 
                                                             from tdvadm.t_col_asn@database_tdp asn where asn.col_asn_numero in ('V830104589','V830117872','N000622937','V830118156','V840020716','V830126794','6593108473','V830127469'))
                                        and 0 = (select count(*)
                                                 from tdvadm.t_glb_cliente cl1
                                                 where cl1.glb_cliente_cgccpfcodigo = rpad(p.col_asnparceiro_cnpj,20) 
                                                ) 
                                     );
                                      

-- Atauliza as Portarias antes de subir os endereços
insert into tdvadm.t_glb_portaria p
select * from tdvadm.t_glb_portaria@database_tdp p1
where 0 = (select count(*)
           from tdvadm.t_glb_portaria p2
           where p2.glb_portaria_id = p1.glb_portaria_id);


-- Cria o Endereço de Cliente Caso não existe
delete tdvadm.t_glb_cliend cl
where cl.glb_cliente_cgccpfcodigo in (select rpad(p.col_asnparceiro_cnpj,20)
                                      From tdvadm.t_col_asnparceiro@database_tdp p 
                                      where p.col_asn_id in (select asn.col_asn_id 
                                                             from tdvadm.t_col_asn@database_tdp asn where asn.col_asn_numero in ('V830104589','V830117872','N000622937','V830118156','V840020716','V830126794','6593108473','V830127469'))
                                        and 0 = (select count(*)
                                                 from tdvadm.t_glb_cliend cl1
                                                 where cl1.glb_cliente_cgccpfcodigo = rpad(p.col_asnparceiro_cnpj,20) 
                                                ) 
                                     );

insert into tdvadm.t_glb_cliend
select *
from tdvadm.t_glb_cliend@database_tdp cl
where cl.glb_cliente_cgccpfcodigo in (select rpad(p.col_asnparceiro_cnpj,20)
                                      From tdvadm.t_col_asnparceiro@database_tdp p 
                                      where p.col_asn_id in (select asn.col_asn_id 
                                                             from tdvadm.t_col_asn@database_tdp asn where asn.col_asn_numero in ('V830104589','V830117872','N000622937','V830118156','V840020716','V830126794','6593108473','V830127469'))
                                        and 0 = (select count(*)
                                                 from tdvadm.t_glb_cliend cl1
                                                 where cl1.glb_cliente_cgccpfcodigo = rpad(p.col_asnparceiro_cnpj,20) 
                                                ) 
                                     );


-- T_COL_ASNPARCEIRO - Parceiros da ASN
insert into tdvadm.t_col_asnparceiro
select p.col_asnparceiro_id,
       p.col_asnparceiro_cnpj,
       p.col_asnparceiro_razaosocial,
       p.col_asnparceiro_cidade,
       p.col_asnparceiro_uf,
       p.col_asnparceiro_cep,
       p.col_asnparceiro_ibge,
       p.col_asnparceiro_telefone,
       p.col_asnparceiro_complemento,
       p.col_asnparceiro_endereco,
       p.col_asnparceiro_numero,
       p.col_asnparceiro_codpais,
       p.col_asnparceiro_email,
       p.col_asnparceiro_contato,
       p.col_asntipoparceiro_id,
       p.glb_tpcliend_codigo,
       p.glb_localidade_codigo,
       p.glb_grupoeconomico_codigo,
       p.col_asn_id 
From tdvadm.t_col_asnparceiro@database_tdp p
where p.col_asn_id in (select asn.col_asn_id from tdvadm.t_col_asn@database_tdp asn where asn.col_asn_numero in ('V830104589','V830117872','N000622937','V830118156','V840020716','V830126794','6593108473','V830127469'));


-- Inclui as Cargas das Embalagens
INSERT INTO TDVADM.T_ARM_CARGA 
SELECT *
FROM TDVADM.T_ARM_CARGA@DATABASE_TDP CA
WHERE CA.ARM_CARGA_CODIGO IN (SELECT AN.ARM_CARGA_CODIGO
                              FROM TDVADM.T_ARM_NOTA@DATABASE_TDP AN
                              WHERE AN.ARM_NOTA_NUMERO <> 21021
                                AND (AN.ARM_COLETA_NCOMPRA,
                                     AN.ARM_COLETA_CICLO) IN (select CC.ARM_COLETA_NCOMPRA,CC.ARM_COLETA_CICLO
                                                              from tdvadm.t_Arm_Coleta@database_tdp CC
                                                              where CC.XML_COLETA_NUMERO in ('V830104589','V830117872','N000622937','V830118156','V840020716','V830126794','6593108473','V830127469')))
 

-- Inclui das Embalagens
INSERT INTO TDVADM.T_ARM_EMBALAGEM 
SELECT *
FROM TDVADM.T_ARM_EMBALAGEM@DATABASE_TDP EB
WHERE (EB.ARM_EMBALAGEM_NUMERO,
       EB.ARM_EMBALAGEM_FLAG,
       EB.ARM_EMBALAGEM_SEQUENCIA) IN (SELECT AN.ARM_EMBALAGEM_NUMERO,
                                              AN.ARM_EMBALAGEM_FLAG,
                                              AN.ARM_EMBALAGEM_SEQUENCIA
                                       FROM TDVADM.T_ARM_NOTA@DATABASE_TDP AN
                                       WHERE AN.ARM_NOTA_NUMERO <> 21021
                                         AND (AN.ARM_COLETA_NCOMPRA,
                                              AN.ARM_COLETA_CICLO) IN (select CC.ARM_COLETA_NCOMPRA,CC.ARM_COLETA_CICLO
                                                                       from tdvadm.t_Arm_Coleta@database_tdp CC
                                                                       where CC.XML_COLETA_NUMERO in ('V830104589','V830117872','N000622937','V830118156','V840020716','V830126794','6593108473','V830127469')))

-- Inclui as Janelas
insert into tdvadm.t_arm_janelacons
select *
from tdvadm.t_arm_janelacons@database_tdp j
where j.arm_janelacons_sequencia in (SELECT AN.arm_janelacons_sequencia
                                       FROM TDVADM.T_ARM_NOTA@DATABASE_TDP AN
                                       WHERE AN.ARM_NOTA_NUMERO <> 21021
                                         AND (AN.ARM_COLETA_NCOMPRA,
                                              AN.ARM_COLETA_CICLO) IN (select CC.ARM_COLETA_NCOMPRA,CC.ARM_COLETA_CICLO
                                                                       from tdvadm.t_Arm_Coleta@database_tdp CC
                                                                       where CC.XML_COLETA_NUMERO in ('V830104589','V830117872','N000622937','V830118156','V840020716','V830126794','6593108473','V830127469')))

 
-- Inclui as Notas
INSERT INTO TDVADM.T_ARM_NOTA
SELECT AN.ARM_NOTA_NUMERO,
       AN.ARM_CARGA_CODIGO,
       AN.GLB_CLIENTE_CGCCPFREMETENTE,
       AN.GLB_CLIENTE_CGCCPFDESTINATARIO,
       AN.ARM_NOTA_PRAZO,
       AN.GLB_LOCALIDADE_CODIGOORIGEM,
       AN.GLB_TPCLIEND_CODREMETENTE,
       AN.GLB_TPCLIEND_CODDESTINATARIO,
       SYSDATE ARM_NOTA_DTINCLUSAO,
       AN.ARM_NOTA_QTDVOLUME,
       AN.ARM_NOTA_PESO,
       AN.ARM_NOTA_CUBAGEM,
       AN.ARM_NOTA_SEQUENCIA,
       AN.GLB_TPCARGA_CODIGO,
       AN.ARM_NOTA_ATRIBUIDO,
       AN.ARM_NOTA_RESPONSE,
       AN.XML_NOTALINHA_NUMDOC,
       NULL ARM_COLETA_NCOMPRA,
       AN.ARM_COLETA_VLMERCADORIA,
       AN.ARM_COLETA_PESOCOBRADO,
       AN.ARM_NOTA_LARGURA,
       AN.ARM_NOTA_ALTURA,
       AN.ARM_NOTA_COMPRIMENTO,
       AN.GLB_EMBALAGEM_CODIGO,
       AN.ARM_NOTA_MERCADORIA,
       AN.ARM_NOTA_VALORNFSEGURO,
       AN.ARM_MOVIMENTO_PESOCUBADO,
       AN.ARM_ARMAZEM_CODIGO,
       SYSDATE ARM_MOVIMENTO_DATANFENTRADA,
       AN.ARM_NOTA_TIPO,
       AN.ARM_NOTA_QTD,
       AN.ARM_NOTA_SERIE,
       AN.USU_USUARIO_CODIGO,
       AN.ARM_NOTA_VIDE,
       AN.USU_USUARIO_CODIGO_XML,
       AN.ARM_NOTA_CANCELADA,
       AN.CON_CONHECIMENTO_CODIGO,
       AN.CON_CONHECIMENTO_SERIE,
       AN.GLB_ROTA_CODIGO,
       AN.ARM_NOTA_ATRIBUI_MOVIMENTO,
       SYSDATE ARM_NOTA_DTRECEBIMENTO,
       AN.ARM_NOTA_DTETIQUETA,
       AN.ARM_EMBALAGEM_NUMERO,
       AN.ARM_CARREGAMENTO_CODIGO,
       AN.ARM_EMBALAGEM_FLAG,
       AN.ARM_EMBALAGEM_SEQUENCIA,
       AN.ARM_NOTA_PESOBALANCA,
       AN.GLB_CFOP_CODIGO,
       AN.ARM_NOTA_ONU,
       AN.ARM_NOTA_FLAGONU,
       AN.GLB_CLIENTE_CGCCPFSACADO,
       AN.GLB_TPCLIEND_CODSACADO,
       AN.ARM_NOTA_FLAGPGTO,
       AN.SLF_CONTRATO_CODIGO,
       AN.GLB_MERCADORIA_CODIGO,
       AN.ARM_NOTA_VALORMERC,
       AN.ARM_NOTA_RI,
       AN.USUARIO_WEB_LOGIN_RI,
       AN.ARM_NOTA_DATARI,
       AN.ARM_NOTA_OBSERVACAO,
       AN.ARM_NOTAMOTIVOREJEICAO_CODIGO,
       AN.USUARIO_WEB_LOGIN_CTRCOK,
       AN.ARM_NOTA_DATACTRCOK,
       AN.ARM_NOTA_CHEGADAPORTARIA,
       AN.ARM_NOTA_SENHAPORTARIA,
       AN.ARM_NOTA_DTENTREGASENHA,
       AN.ARM_NOTA_DI,
       AN.ARM_NOTA_NF_E,
       AN.ARM_NOTA_CTRC_E,
       AN.USUARIO_WEB_LOGIN_RICTRC,
       AN.ARM_NOTA_RICTRC,
       AN.ARM_NOTA_DATARICTRC,
       AN.ARM_NOTA_GRPEMB,
       AN.ARM_NOTA_TABSOLCOD,
       AN.ARM_NOTA_TABSOLSQ,
       AN.ARM_NOTA_TABSOL,
       AN.ARM_NOTA_CHAVENFE,
       AN.ARM_NOTA_VALORBSICMS,
       AN.ARM_NOTA_VALORICMS,
       AN.ARM_NOTA_VALORBSICMSST,
       AN.ARM_NOTA_VALORICMSST,
       AN.ARM_COLETA_TPCOMPRA,
       AN.ARM_NOTA_FLAGEMP,
       AN.ARM_NOTA_EMPQTDE,
       AN.ARM_NOTA_USUARIOALTEROU,
       AN.CON_TPDOC_CODIGO,
       NULL ARM_COLETA_CICLO, 
       AN.ARM_NOTA_LOCALCOLETAL,
       AN.ARM_NOTA_LOCALENTREGAL,
       AN.ARM_NOTA_LOCALCOLETAI,
       AN.ARM_NOTA_LOCALENTREGAI,
       AN.ARM_CARREGAMEMCALC_MEMOCALC,
       AN.ARM_CARREGAMEMCALC_SEQAGRUP,
       AN.ARM_JANELACONS_SEQUENCIA,
       AN.ARM_NOTA_LOCALOUTRACOLETAL,
       AN.ARM_NOTA_LOCALOUTRAENTREGAL,
       AN.ARM_NOTA_LOCALOUTRACOLETAI,
       AN.ARM_NOTA_LOCALOUTRAENTREGAI,
       AN.ARM_NOTA_CODCLICOLETA,
       AN.ARM_NOTA_CODCLIVIAGEM,
       AN.ARM_NOTA_QTDELIMIT
FROM TDVADM.T_ARM_NOTA@DATABASE_TDP AN
WHERE AN.ARM_NOTA_NUMERO <> 21021
   AND (AN.ARM_COLETA_NCOMPRA,AN.ARM_COLETA_CICLO) IN (select CC.ARM_COLETA_NCOMPRA,CC.ARM_COLETA_CICLO
                                                      from tdvadm.t_Arm_Coleta@database_tdp CC
                                                      where CC.XML_COLETA_NUMERO in ('V830104589','V830117872','N000622937','V830118156','V840020716','V830126794','6593108473','V830127469'))




SELECT *
FROM TDVADM.T_FCF_TPCARGA
14 - DEVOLUCAO

select ASN.COL_ASN_SPECIALPROCESSCODE,
       ASN.COL_ASN_TIPOCARGA,
       ASN.COL_ASN_FRAGILELOAD,
       ASN.COL_ASN_SELFSUPPORTINGLOAD,
       ASN.*
from tdvadm.t_col_asn asn
where asn.col_asn_numero in ('V830104589','V830117872','N000622937','V830118156','V840020716','V830126794','6593108473','V830127469')
  AND ASN.COL_ASN_SPECIALPROCESSCODE = 'BR09'
  AND ASN.COL_ASN_TIPOCARGA            = 'A'
  AND ASN.COL_ASN_FRAGILELOAD          = '2'
  AND ASN.COL_ASN_SELFSUPPORTINGLOAD   = '2'

for update;

select c.arm_coleta_ncompra, 
       c.arm_coleta_ciclo,
       c.slf_contrato_codigo,
       c.arm_coleta_cnpjpagadorferete,
       c.arm_coleta_flagquimico,
       ci.glb_onu_codigo,
       ci.glb_onu_grpemb,
       o.glb_onu_produto
from tdvadm.t_arm_coleta c,
     tdvadm.t_arm_coletancompra ci,
     tdvadm.t_glb_onu o
where trunc(c.arm_coleta_dtsolicitacao) >= sysdate - 1
  and c.arm_coleta_ncompra = ci.arm_coletancompra
  and c.arm_coleta_ciclo = ci.arm_coleta_ciclo
  and c.arm_coleta_flagquimico = 'S'     
  and ci.glb_onu_codigo = o.glb_onu_codigo (+)
  and ci.glb_onu_grpemb = o.glb_onu_grpemb (+)
  
  
  
  select c.arm_coleta_ncompra, 
       c.arm_coleta_ciclo,
       c.slf_contrato_codigo,
       c.arm_coleta_cnpjpagadorferete,
       c.arm_coleta_flagquimico,
       ci.glb_onu_codigo,
       ci.glb_onu_grpemb,
       o.glb_onu_produto,
       cp.col_asn_numeroonu
from tdvadm.t_arm_coleta c,
     tdvadm.t_arm_coletancompra ci,
     tdvadm.t_glb_onu o,
     tdvadm.t_col_asn cp
where trunc(c.arm_coleta_dtsolicitacao) >= sysdate - 1
  and c.arm_coleta_ncompra = ci.arm_coletancompra
  and c.arm_coleta_ciclo = ci.arm_coleta_ciclo
  and c.arm_coleta_flagquimico = 'S'     
  and ci.glb_onu_codigo = o.glb_onu_codigo (+)
  and ci.glb_onu_grpemb = o.glb_onu_grpemb (+)
  and c.arm_coleta_ncompra = cp.arm_coleta_ncompra (+)
  and c.arm_coleta_ciclo = cp.arm_coleta_ciclo (+)

select * from tdvadm.v_lock_tables;

select *
from tdvadm.t_arq_gravados x
where x.diretorio like '/imagens/04/460%'
  or x.documento is not null
  
  
  tdvadm.pkg_con_fatura .sp_con_valida;
  
  
  select * from tdvadm.t_glb_sql s
  where s.glb_sql_programa = 'sirlano'
    and trunc(s.glb_sql_dtgravacao) = '12/08/2020'
    
    select * from v_auditoria_ddl v
    where v.object_name like '%PKG_GLB_PCL%'
  
  
              select sum(ca.con_calcviagem_valor)
            from t_con_conhecimento c,
                 T_CON_CALCCONHECIMENTO CA
                where c.CON_FATURA_CODIGO || c.CON_FATURA_CICLO || c.GLB_ROTA_CODIGOFILIALIMP in (select gf.con_fatura_codigo || gf.con_fatura_ciclo || gf.glb_rota_codigofatura
                                                                                                  from t_con_faturagrupoxfatura gf 
                                                                                                  where gf.con_faturagrupo_codigo = '895127'
                                                                                                    and gf.con_faturagrupo_ciclo = '1'
                                                                                                    and gf.glb_rota_codigogrupo = '010')
              and c.con_conhecimento_codigo = CA.con_conhecimento_codigo (+)
              and c.con_conhecimento_serie  = CA.con_conhecimento_serie (+)
              and c.glb_rota_codigo         = CA.glb_rota_codigo (+)
              AND CA.SLF_RECCUST_CODIGO     = 'I_TTPV';

              select sum(ca.con_calcviagem_valor)
            from t_con_conhecimento c,
                 T_CON_CALCCONHECIMENTO CA
                where (c.CON_FATURA_CODIGO,c.CON_FATURA_CICLO,c.GLB_ROTA_CODIGOFILIALIMP) in (select gf.con_fatura_codigo,gf.con_fatura_ciclo,gf.glb_rota_codigofatura
                                                                                                  from t_con_faturagrupoxfatura gf 
                                                                                                  where gf.con_faturagrupo_codigo = '895127'
                                                                                                    and gf.con_faturagrupo_ciclo = '1'
                                                                                                    and gf.glb_rota_codigogrupo = '010')
              and c.con_conhecimento_codigo = CA.con_conhecimento_codigo (+)
              and c.con_conhecimento_serie  = CA.con_conhecimento_serie (+)
              and c.glb_rota_codigo         = CA.glb_rota_codigo (+)
              AND CA.SLF_RECCUST_CODIGO     = 'I_TTPV';
  
    insert into t_glb_sql
    (glb_sql_instrucao, glb_sql_dtgravacao , )
  values
    (P_XMLIN, sysdate, 'sirlano');

tdvadm.pkg_glb_pcl

  
  
select CC.FCF_TPCARGA_CODIGO,cc.xml_coleta_numero,CC.ARM_COLETA_NCOMPRA,CC.ARM_COLETA_CICLO,cc.arm_coleta_flagquimico,cc.
from tdvadm.t_Arm_Coleta CC
where CC.XML_COLETA_NUMERO in (SELECT asn.col_asn_numero 
                               From tdvadm.t_col_asn asn
                               where asn.col_asn_numero in ('V830104589','V830117872','N000622937','V830118156','V840020716','V830126794','6593108473','V830127469'))
                                 AND ASN.COL_ASN_SPECIALPROCESSCODE = 'BR09'
                                 AND ASN.COL_ASN_TIPOCARGA            = 'A'
                                 AND ASN.COL_ASN_FRAGILELOAD          = '2'
                                 AND ASN.COL_ASN_SELFSUPPORTINGLOAD   = '2')
FOR UPDATE
  
  
select an.arm_nota_numero nota,
       an.glb_cliente_cgccpfremetente remetente,
       an.arm_nota_serie serie,
       an.glb_cliente_cgccpfdestinatario destinatario,
       c.xml_coleta_numero asn,
       an.arm_coleta_ncompra coleta,
       an.arm_coleta_ciclo ciclo,
       tdvadm.fn_busca_codigoibge(an.arm_nota_localcoletal,'IBD') coleta,
       tdvadm.fn_busca_codigoibge(an.arm_nota_localentregal,'IBD') entrega,
       tdvadm.fn_busca_codigoibge(cec.glb_localidade_codigo,'IBD') coleta_c,
       tdvadm.fn_busca_codigoibge(cee.glb_localidade_codigo,'IBD') entrega_c
from tdvadm.t_arm_nota an,
     tdvadm.t_arm_coleta c,
     tdvadm.t_glb_cliend cec,
     tdvadm.t_glb_cliend cee
where an.arm_coleta_ncompra = c.arm_coleta_ncompra
  and an.arm_coleta_ciclo = c.arm_coleta_ciclo
  and c.glb_cliente_cgccpfcodigocoleta = cec.glb_cliente_cgccpfcodigo
  and c.glb_tpcliend_codigocoleta = cec.glb_tpcliend_codigo
  and c.glb_cliente_cgccpfcodigoentreg = cee.glb_cliente_cgccpfcodigo
  and c.glb_tpcliend_codigoentrega = cee.glb_tpcliend_codigo
  and (an.arm_coleta_ncompra,an.arm_coleta_ciclo) in (select CC.ARM_COLETA_NCOMPRA,CC.ARM_COLETA_CICLO
                                                      from tdvadm.t_Arm_Coleta CC
                                                      where CC.XML_COLETA_NUMERO in (SELECT asn.col_asn_numero 
                                                                                     From tdvadm.t_col_asn asn
                                                                                     where asn.col_asn_numero in ('V830104589','V830117872','N000622937','V830118156','V840020716','V830126794','6593108473','V830127469')))

;
select c.glb_cliente_cgccpfcodigocoleta remetente,
       c.glb_cliente_cgccpfcodigoentreg destinatario,
       c.xml_coleta_numero asn,
       c.arm_coleta_ncompra coleta,
       c.arm_coleta_ciclo ciclo,
       tdvadm.fn_busca_codigoibge(cec.glb_localidade_codigo,'IBD') coleta_c,
       tdvadm.fn_busca_codigoibge(cee.glb_localidade_codigo,'IBD') entrega_c
from tdvadm.t_arm_coleta c,
     tdvadm.t_glb_cliend cec,
     tdvadm.t_glb_cliend cee
where c.glb_cliente_cgccpfcodigocoleta = cec.glb_cliente_cgccpfcodigo
  and c.glb_tpcliend_codigocoleta = cec.glb_tpcliend_codigo
  and c.glb_cliente_cgccpfcodigoentreg = cee.glb_cliente_cgccpfcodigo
  and c.glb_tpcliend_codigoentrega = cee.glb_tpcliend_codigo
  and c.xml_coleta_numero in ('V830104589','V830117872','N000622937','V830118156','V840020716','V830126794','6593108473','V830127469');




select an.arm_nota_numero,
       an.arm_nota_dtinclusao,
       an.arm_coleta_ncompra,an.arm_coleta_ciclo
from tdvadm.t_arm_nota an
where an.arm_nota_numero = 125741
  and trunc(an.arm_nota_dtinclusao) = '12/08/2020'
for update
  





  
  
