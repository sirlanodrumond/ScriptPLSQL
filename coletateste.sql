tdvadm.pkg_slf_contrato;
tdvadm.pkg_fifo_recebimento;
tdvadm.pkg_fifo_carregctrc;

select *
from tdvadm.t_arm_janela x
x.arm_janela_sequencia


select co.arm_armazem_codigo,co.arm_coleta_ncompra,co.arm_coleta_ciclo,co.xml_coleta_numero,co.arm_coleta_dtsolicitacao,co.fcf_tpcarga_codigo,co.arm_coleta_tpcargacalc,co.slf_contrato_codigo
from tdvadm.t_arm_coleta co
where 0 = 0
-- ( co.arm_coleta_ncompra in ('490683','454630','460734','491027') and co.arm_coleta_ciclo = '004' ) or 
 and  co.xml_coleta_numero in ('V830130318','V830131518')
;

select an.arm_nota_numero,
       an.glb_cliente_cgccpfremetente,
       an.arm_nota_dtinclusao,
       an.arm_coleta_ncompra,
       an.arm_coleta_ciclo,
       an.glb_rota_codigo,
       an.con_conhecimento_codigo,
from tdvadm.t_arm_nota an
where (an.arm_coleta_ncompra,
       an.arm_coleta_ciclo) in (select co.arm_coleta_ncompra,
                                       co.arm_coleta_ciclo
                                from tdvadm.t_arm_coleta co
                                where ( co.xml_coleta_numero in ('V830130318','V830131518')));
 
select asn.col_asn_id,
       asn.col_asn_dtprocessamento,
       asn.col_asnstatus_id,
       an.arm_coleta_ncompra,
       an.arm_coleta_ciclo,
       an.arm_coletapart_nfe,
       an.slf_contrato_codigo,
       co.arm_coleta_obs,
       co.arm_coleta_qtdenfs,
       asn.col_asn_numeronfe,
       co.xml_coleta_numero,
       co.glb_cliente_cgccpfcodigocoleta,
       co.glb_cliente_cgccpfcodigoentreg
from tdvadm.t_arm_coletapart an,
     tdvadm.t_arm_coleta co,
     tdvadm.t_col_asn asn
where an.arm_coleta_ncompra = co.arm_coleta_ncompra
  and an.arm_coleta_ciclo = co.arm_coleta_ciclo
  and an.arm_coleta_ncompra = asn.arm_coleta_ncompra (+)
  and an.arm_coleta_ciclo = asn.arm_coleta_ciclo (+)
  and (an.arm_coleta_ncompra,
       an.arm_coleta_ciclo) in (select co.arm_coleta_ncompra,
                                       co.arm_coleta_ciclo
                                from tdvadm.t_arm_coleta co
                                where ( co.xml_coleta_numero in ('V830130318','V830131518')));

                                

select base.nota,
       base.remetenteant,
       base.destinatarioant, 
       base.datasol,
       base.coletaant,
       base.cicloant,
       base.asnant,
       base.loccoletaant,
       base.descloccoletaant,
       base.locentregaant,      
       base.desclocentregaant,      
       base.coletaatual,
       base.cicloatual,
       base.asnatual,
 
       c2.glb_cliente_cgccpfcodigocoleta remetenteatu,
       c2.glb_cliente_cgccpfcodigoentreg destinatarioatu ,
       c2.slf_contrato_codigo contrato,
       base.contratonota,
       base.armazemnota,
       c2.arm_armazem_codigo armazemcoleta
from (select an.arm_armazem_codigo armazemnota,
             an.arm_nota_numero nota,
             an.glb_cliente_cgccpfremetente remetenteant,
             an.glb_cliente_cgccpfdestinatario destinatarioant,             
             co.arm_coleta_dtsolicitacao datasol,
             an.arm_coleta_ncompra coletaant,
             an.arm_coleta_ciclo cicloant,
             co.xml_coleta_numero asnant  ,
             an.arm_nota_localcoletal loccoletaant,
             tdvadm.fn_busca_codigoibge(an.arm_nota_localcoletal,'IBD') descloccoletaant,
             an.arm_nota_localentregal  locentregaant,
             tdvadm.fn_busca_codigoibge(an.arm_nota_localentregal,'IBD') desclocentregaant,
             an.slf_contrato_codigo contratonota,       
             decode(an.arm_nota_numero,128783,'509143') coletaatual,
             '004'                                      cicloatual,
             decode(an.arm_nota_numero,128783,'V830130976') ASNATUAL
      from tdvadm.t_arm_nota an,
           tdvadm.t_arm_coleta co
      where an.arm_coleta_ncompra = co.arm_coleta_ncompra
        and an.arm_coleta_ciclo = co.arm_coleta_ciclo
        and (an.arm_nota_numero,an.glb_cliente_cgccpfremetente) in (select 128783,'33592510037074' from dual )) BASE,
     tdvadm.t_arm_coleta c2
where c2.arm_coleta_ncompra = base.coletaatual
  and c2.arm_coleta_ciclo   = base.cicloatual
;


SELECT G.KUNNR,G.NAMORG1,G.NAMORG4,G.SORTL,G.STREET,G.HOUSE_NUM1,G.HOUSE_NO2,G.CITY2,G.POST_CODE1,G.CITY1,G.STR_SUPPL1
FROM MIGDV.CUSTOMER_S_CUST_GEN G
WHERE G.KUNNR IN (35663,35664,35665,9307,9308,9309,9310,9311)


  
select *
from tdvadm.t_slf_clientecargas cc
where cc.slf_contrato_codigo = '5500058294-V-MG'
  and cc.slf_clientecargas_ativo = 'S';
  

--select * from tdvadm.t_fcf_tpcarga;



select *
from tdvadm.t_arm_nota an
where (an.arm_coleta_ncompra,
       an.arm_coleta_ciclo) in (select co.arm_coleta_ncompra,
                                       co.arm_coleta_ciclo
                                from tdvadm.t_arm_coleta co
                                where ( co.xml_coleta_numero in ('V830130318','V830131518')))
;

COL_ASN_TIPOCARGA
select *
from tdvadm.t_arm_coletapart p
where p.arm_coletapart_tipocarga

select a.COL_ASN_TIPOCARGA,a.*
from tdvadm.t_col_asn a
where a.COL_ASN_SPECIALPROCESSCODE = 'BR09' 
--  and a.COL_ASN_TIPOCARGA = 'A' 
  and A.COL_ASN_FRAGILELOAD = '2' 
  AND A.COL_ASN_SELFSUPPORTINGLOAD = '2'
  and a.arm_coleta_ciclo = '004'
  and upper(a.col_asn_obs) like '%DEVO%'
  

select A.COL_ASN_DTGRAVACAO gravacao,
--       A.COL_ASN_ID IDASN,
       a.col_asn_numero ASN,
       a.arm_coleta_ncompra coleta,
       a.arm_coleta_ciclo ciclo,
              Case
          When a.COL_ASN_SPECIALPROCESSCODE = 'BR09' and a.COL_ASN_TIPOCARGA = 'A' and A.COL_ASN_FRAGILELOAD = '2' AND A.COL_ASN_SELFSUPPORTINGLOAD = '2'
            Then 'DEVOLUCAO'
            Else 'NORMAL'
          end as TIPO,
       (select an.arm_nota_numero || '-' || an.glb_cliente_cgccpfremetente || '-' || an.arm_nota_serie
        from tdvadm.t_arm_nota an
        where an.arm_nota_dtinclusao >= to_date('01/08/2020','dd/mm/yyyy')
          and an.arm_coleta_ncompra = a.arm_coleta_ncompra
          and an.arm_coleta_ciclo = a.arm_coleta_ciclo) qtdenota,
       (select count(distinct c.arm_carregamento_codigo)
        from tdvadm.t_arm_carregamentodet c
        where (c.arm_embalagem_numero,
               c.arm_embalagem_flag,
               c.arm_embalagem_sequencia) in (select an.arm_embalagem_numero,
                                                     an.arm_embalagem_flag,
                                                     an.arm_embalagem_sequencia
                                              from tdvadm.t_arm_nota an
                                              where an.arm_coleta_ncompra = a.arm_coleta_ncompra
                                                and an.arm_coleta_ciclo = a.arm_coleta_ciclo)) carreg,

        (select count(*)
         from tdvadm.t_con_nftransporta nf
         where nf.con_nftransportada_dtemissao >= to_date('01/08/2020','dd/mm/yyyy')
           and (nf.con_nftransportada_numnfiscal,
                nf.glb_cliente_cgccpfcodigo) in (select lpad(an.arm_nota_numero,9,'0'),
                                                        rpad(an.glb_cliente_cgccpfremetente,20)
                                                 from tdvadm.t_arm_nota an
                                                 where an.arm_coleta_ncompra = a.arm_coleta_ncompra
                                                   and an.arm_coleta_ciclo = a.arm_coleta_ciclo)) qtdcte,
       a.COL_ASN_SPECIALPROCESSCODE,
       a.COL_ASN_TIPOCARGA,         
       A.COL_ASN_FRAGILELOAD,       
       A.COL_ASN_SELFSUPPORTINGLOAD,
       a.col_asn_obs
from tdvadm.t_Col_Asn a
where 0 = 0
  and (a.arm_coleta_ncompra,
       a.arm_coleta_ciclo) in (select co.arm_coleta_ncompra,
                                       co.arm_coleta_ciclo
                                from tdvadm.t_arm_coleta co
                                where  co.xml_coleta_numero in ('V830130318','V830131518'))
  and a.col_asn_dtgravacao >= to_date('15/08/2020','dd/mm/yyyy')
  and a.COL_ASN_SPECIALPROCESSCODE = 'BR09' and a.COL_ASN_TIPOCARGA = 'A' AND A.COL_ASN_FRAGILELOAD = '2' AND A.COL_ASN_SELFSUPPORTINGLOAD = '2'
--  and  a.col_asn_numero in ('V830104589','V830117872','N000622937','V830118156','V840020716','V830126794','6593108473','V830127469')
;  






select *
from tdvadm.t_arm_notacte nc
where nc.arm_nota_sequencia = 4974074
for update
  

 
select distinct *
from tdvadm.v_arm_verifcarreg vc
where vc.Sequencia = 4974074;

select *
from tdvadm.t_arm_carregamento ca
where ca.arm_carregamento_codigo in ('2842868','2878369','2878392','2878397','2878400','2878416','2878459')
for update;

select *
from tdvadm.T_FCF_VEICULODISP ca
where ca.arm_carregamento_codigo in ('2842868','2878369','2878392','2878397','2878400','2878416','2878459')
for update;
  
select *
from tdvadm.T_ARM_CARREGAMENTO_HIST ca
where ca.arm_carregamento_codigo in ('2842868','2878369','2878392','2878397','2878400','2878416','2878459')
for update;


select *
from tdvadm.t_arm_carregamentodet cd
where cd.arm_embalagem_numero = 3963235
for update;

  



tdvadm.fk_armcarrhist_armcarr;
tdvadm.fk_carregamento_veiculodisp;

select a.col_asn_dtaltnimbi,a.col_asn_numeroonu
from tdvadm.t_col_asn a
where 0 = 0
--  and a.col_asn_numero = 'N000808420'
  and length(trim(a.col_asn_numeroonu)) > 4
order by a.col_asn_dtaltnimbi desc


  



tdvadm.pkg_arm_embalagem.Sp_Devolver_EmbalagemNF  

<Parametros>/
   <Input>
      <Nota>9093</Nota>
      <CNPJ>19291268000158</CNPJ>
      <Sequencia>4918102</Sequencia>
      <Chave>31200719291268000158550010000090931068947417</Chave>
      <TipoDevolucao>D</TipoDevolucao>
      <Coleta_Original>491810</Coleta_Original>
      <Usuario>jsantos</Usuario>
      <Rota>160</Rota>
      <Aplicacao>carreg</Aplicacao>
      <Versao>20.3.2.0</Versao>
      <ConheciementoCodigo>236634</ConheciementoCodigo>
      <ConheciementoSerie>A1</ConheciementoSerie>
      <ConheciementoRota>187</ConheciementoRota>
      <PagtoFrete>S</PagtoFrete>
      <IDOcorrencia>8</IDOcorrencia>
      <Coleta>491367</Coleta>
      <Acao>D</Acao>
   </Input>
</Parametros>


SELECT * FROM TDVADM.V_LOCK_TABLES;

select cte.arm_notacte_codigo,
       cte.arm_nota_numero,
       cte.glb_cliente_cgccpfremetente,
       cte.arm_nota_serie,
       cte.arm_nota_chavenfe,
       cte.arm_coleta_ncompra,
       cte.arm_coleta_ciclo,
       cte.con_conhecimento_codigo  || '-' || cte.con_conhecimento_serie  || '-' || cte.glb_rota_codigo  cte,
       cte.con_conhecimento_codigoa || '-' || cte.con_conhecimento_seriea || '-' || cte.glb_rota_codigoa ctea,
       cte.arm_carregamento_codigo
from tdvadm.t_arm_notacte cte
where cte.arm_nota_sequencia = 4918102

select * from tdvadm.t_arm_nota cte
where cte.arm_nota_sequencia = 4918102
for update
  
select * from tdvadm.t_arm_coleta co
where co.arm_coleta_ncompra = '491367'
  and co.arm_coleta_ciclo = '004'
for update;



    SELECT CK.*,
           T.GLB_MERCADORIA_CODIGO,
           T.SLF_TABELA_COLETAENTREGA,
           T.SLF_TABELA_TIPO,
           T.FCF_TPVEICULO_CODIGO,
           T.FCF_TPCARGA_CODIGO,
           T.GLB_CLIENTE_CGCCPFCODIGO,
           T.GLB_GRUPOECONOMICO_CODIGO,
           T.SLF_TABELA_CONTRATO,
           1 vPESOCOBRADO,
           1 vFATORRATEIO,
           'OK' vRetorno,
           CK.ROWID
      FROM TDVADM.T_SLF_CALCFRETEKM CK, TDVADM.T_SLF_TABELA T
     WHERE 0 = 0
       AND CK.SLF_TABELA_CODIGO = T.SLF_TABELA_CODIGO
       AND CK.SLF_TABELA_SAQUE = T.SLF_TABELA_SAQUE
       AND NVL(T.SLF_TABELA_STATUS, 'N') = 'N'
       AND T.SLF_TABELA_CONTRATO = '5500058294-V-MG'
       AND T.GLB_GRUPOECONOMICO_CODIGO = '0020'
       AND CK.SLF_RECCUST_CODIGO = 'D_FRPSVO'
       AND T.SLF_TABELA_TIPO = 'FOB'
       AND nvl(T.SLF_TABELA_COLETAENTREGA, 'A') in ('N', 'A', 'C')
       AND round(0, 0) BETWEEN CK.SLF_CALCFRETEKM_KMDE AND
           CK.SLF_CALCFRETEKM_KMATE
       AND round(500, 1) BETWEEN CK.SLF_CALCFRETEKM_PESODE AND
           CK.SLF_CALCFRETEKM_PESOATE
       AND T.FCF_TPCARGA_CODIGO = '12'
       AND CK.SLF_CALCFRETEKM_ORIGEMI = '1502772'
--       AND CK.SLF_CALCFRETEKM_DESTINOI = '3149309'
       AND T.SLF_TABELA_SAQUE =
           (SELECT MAX(T1.SLF_TABELA_SAQUE)
              FROM TDVADM.T_SLF_TABELA T1
             WHERE T1.SLF_TABELA_CODIGO = T.SLF_TABELA_CODIGO
               AND NVL(T1.SLF_TABELA_STATUS, 'N') = 'N'
               AND TO_DATE(T1.SLF_TABELA_VIGENCIA, 'DD/MM/YYYY') <=
                   TO_DATE(SYSDATE, 'DD/MM/YYYY'));
    SELECT CK.*,
           T.GLB_MERCADORIA_CODIGO,
           T.SLF_TABELA_COLETAENTREGA,
           T.SLF_TABELA_TIPO,
           T.FCF_TPVEICULO_CODIGO,
           T.FCF_TPCARGA_CODIGO,
           T.GLB_CLIENTE_CGCCPFCODIGO,
           T.GLB_GRUPOECONOMICO_CODIGO,
           T.SLF_TABELA_CONTRATO,
           1 vPESOCOBRADO,
           1 vFATORRATEIO,
           'OK' vRetorno,
           CK.ROWID
      FROM TDVADM.T_SLF_CALCFRETEKM CK, TDVADM.T_SLF_TABELA T
     WHERE 0 = 0
       AND CK.SLF_TABELA_CODIGO = T.SLF_TABELA_CODIGO
       AND CK.SLF_TABELA_SAQUE = T.SLF_TABELA_SAQUE
       AND NVL(T.SLF_TABELA_STATUS, 'N') = 'N'
       AND T.SLF_TABELA_CONTRATO = '5500058294-V-MG'
       AND T.GLB_GRUPOECONOMICO_CODIGO = '0020'
       AND CK.SLF_RECCUST_CODIGO = 'D_FRPSVO'
       AND T.SLF_TABELA_TIPO = 'FOB'
       AND nvl(T.SLF_TABELA_COLETAENTREGA, 'A') in ('N', 'A', 'C')
       AND round(0, 0) BETWEEN CK.SLF_CALCFRETEKM_KMDE AND
           CK.SLF_CALCFRETEKM_KMATE
       AND round(500, 1) BETWEEN CK.SLF_CALCFRETEKM_PESODE AND
           CK.SLF_CALCFRETEKM_PESOATE
       AND T.FCF_TPCARGA_CODIGO = '10'
--       AND CK.SLF_CALCFRETEKM_ORIGEMI = '1502772'
       AND CK.SLF_CALCFRETEKM_DESTINOI = '3149309'
       AND T.SLF_TABELA_SAQUE =
           (SELECT MAX(T1.SLF_TABELA_SAQUE)
              FROM TDVADM.T_SLF_TABELA T1
             WHERE T1.SLF_TABELA_CODIGO = T.SLF_TABELA_CODIGO
               AND NVL(T1.SLF_TABELA_STATUS, 'N') = 'N'
               AND TO_DATE(T1.SLF_TABELA_VIGENCIA, 'DD/MM/YYYY') <=
                   TO_DATE(SYSDATE, 'DD/MM/YYYY'));


select 'DE' arm_notacte_codigo,
       cte.arm_nota_numero,
       cte.glb_cliente_cgccpfremetente,
       cte.arm_nota_serie,
       cte.arm_nota_sequencia,
       cte.arm_nota_chavenfe,
       '491367' arm_coleta_ncompra,
       cte.arm_coleta_ciclo,
       null con_conhecimento_codigo,
       null con_conhecimento_serie,
       null glb_rota_codigo,
       'jsantos' usu_usuario_codigo,
       cte.glb_cliente_cgccpfsacado,
       null slf_contrato_codigo,
       cte.arm_nota_tabsolcod,
       cte.arm_nota_tabsolsq,
       cte.arm_nota_tabsol,
       sysdate arm_notacte_dtgravacao,
       'S' arm_notacte_pagadorfrete,
       '8' glb_ocorr_id,
       cte.arm_armazem_codigo,
       cte.arm_notacte_localrecusa,
       cte.arm_notacte_observacao,
       '68523' glb_localidade_codigoorigem,
       '33600' glb_localidade_codigodestino,
       cte.con_conhecimento_codigo con_conhecimento_codigoa,
       cte.con_conhecimento_serie con_conhecimento_seriea,
       cte.glb_rota_codigo glb_rota_codigoa,
       '2870125' arm_carregamento_codigo,
       cte.arm_notacte_valor
from tdvadm.t_arm_notacte cte
where cte.arm_nota_sequencia = 4918102
  and cte.arm_notacte_codigo = 'NO'



select *
from tdvadm.t_slf_clientecargas cc
where cc.slf_contrato_codigo = '5500058294-V-MG'
  and cc.slf_clientecargas_ativo = 'S'
for update
    

select distinct c.contrato,
                c.COLETA,
                c.LOCA,
                c.locr,
                tdvadm.fn_busca_codigoibge(c.locr,'IBD') origem,
                c.LOCD,
                tdvadm.fn_busca_codigoibge(c.LOCD,'IBD') destino,
                c.ARM_COLETAOCOR_CODIGO codocor,
                c.ARM_COLETAOCOR_DESCRICAO ocorrencia,
                c.ARM_COLETAOCOR_FINALIZA finaliza,
                c.armazem,
                c.remetente,
                c.DESTINATARIO,
                c.arm_coleta_tpcargacalc 
from tdvadm.v_arm_coleta c
where c.COLETA in ('523689','460853')
  and c.ciclo = '004'
;


select * from xlsuser.v_ipf_reccust;

select distinct *
from tdvadm.t_con_calcconhecimento c
where c.CON_CONHECIMENTO_CODIGO || c.glb_rota_codigo in ('316983187','194824160')
  and c.slf_reccust_codigo in ('D_FRPSVO')
  
select *
from tdvadm.t_slf_reccust rc
where rc.slf_reccust_descricao like '%PESO%'  

select distinct c.con_conhecimento_codigo,c.glb_rota_codigo,c.arm_carregamento_codigo
from tdvadm.t_con_conhecimento c
where (c.CON_CONHECIMENTO_CODIGO,c.glb_rota_codigo) in (select '316983','187' from dual union
                                                        select '194824','160' from dual)
  and c.slf_reccust_codigo in ('I_PSCOBRAD')
  

  


select *
from tdvipf.v_ipf_reccust




<Parametros><Input><Nota>1425</Nota><CNPJ>00152695000470</CNPJ><Sequencia>4967188</Sequencia><Chave>15200800152695000470550010000014251572275420</Chave><TipoDevolucao>D</TipoDevolucao><Coleta_Original>460853</Coleta_Original><Usuario>jsantos</Usuario><Rota>160</Rota><Aplicacao>carreg</Aplicacao><Versao>20.3.2.0</Versao><ConheciementoCodigo>038632</ConheciementoCodigo><ConheciementoSerie>A1</ConheciementoSerie><ConheciementoRota>161</ConheciementoRota><PagtoFrete>S</PagtoFrete><IDOcorrencia>8</IDOcorrencia><Coleta>523689</Coleta><Acao>D</Acao></Input></Parametros>

select *
from tdvadm.t_arm_nota an
where an.arm_nota_sequencia = 4967188
for update;

ASN 	- V830131952
COLETA NOVA - 523689
Nota	- 1425
Fornec	- 00152695000470
CTE	- 038632 161
COLETA ATUAL - 460853
Janela - 1789414
Carreg -  2890403

select *
from tdvadm.t_arm_coleta co
where co.xml_coleta_numero = 'V830131952'

select an.*
from tdvadm.t_arm_nota an
where an.con_conhecimento_codigo = '038632'
  and an.glb_rota_codigo = '161'
  for update;
  
  select cd.*
  from tdvadm.t_arm_carregamentodet cd
  where cd.arm_embalagem_numero = 3956349
    and cd.arm_embalagem_sequencia = 4985799
    
  
    
select * 
from tdvadm.t_con_loggeracao lg
where lg.arm_carregamento_codigo = '2890067'
  and ( lg.con_loggeracao_obsgeracao like '%BUSCANDO PRECO TAB%' 
     or lg.con_loggeracao_obsgeracao like '%TESTANDO TIPO DE CARGA%'
      )
order by 1;  
