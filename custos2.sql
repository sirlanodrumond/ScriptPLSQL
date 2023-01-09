select CNPJ,
       XNOME,
       IE,
       XLGR,
       NRO,
       XBAIRRO,
       CMUN,
       XMUN,
       UF,
       CEP,
       CPAIS,
       XPAIS,
       FONE
FROM TDVADM.V_XML_REMETENTE X
WHERE substr(x.XML_NFE_ID,7,14) IN (SELECT distinct TRIM(CL.GLB_CLIENTE_CGCCPFCODIGO) 
                                    FROM TDVADM.T_GLB_CLIENTE CL,
                                         TDVADm.t_glb_cliend ce,
                                         tdvadm.t_glb_tpcliend tpce
                                    WHERE CL.GLB_CLIENTE_CGCCPFCODIGO = ce.glb_cliente_cgccpfcodigo
                                      and ce.glb_tpcliend_codigo = tpce.glb_tpcliend_codigo
                                      and cl.glb_cliente_dtutlmov >= '01/01/2016');
                                      
                                      
                                      

select * from tdvadm.t_ctb_pconta pc
where 0 = 0
--  and substr(pc.ctb_pconta_codigo,1,7) = '2202022'
--  and upper(pc.ctb_pconta_descricao) like '%SASC%'
--  and upper(pc.ctb_pconta_descricao) like '%MIX%'          
--  and upper(pc.ctb_pconta_descricao) like '%TRAC%'          
--  and upper(pc.ctb_pconta_descricao) like '%ROADCARD%'   
--  and upper(pc.ctb_pconta_descricao) like '%BRASIL RISK%'
--  and upper(pc.ctb_pconta_descricao) like '%TECHIS%'
--  and upper(pc.ctb_pconta_descricao) like '%ADMINISTRACAO%'
  and upper(pc.ctb_pconta_descricao) like '%PAMCA%'

220202202081 -- BRASIL RISK GERENCIAMENTO DE RISCOS S/S LTDA  por contrato
220202204338 -- BRASIL RISK GESTAO DE RISCOS LTDA.            por contrato
220202202940 -- SASCAR
220202204209 -- TECHIS SERVICOS E CONSULTORIA S.A
220202204724 -- MIX
220202200128 -- NR ADMINISTRACAO DE NEGOCIOS RECURSOS HUMANOS LTDA

--?


select *
from tdvadm.t_slf_contrato c
where c.slf_contrato_descricao like '%ALB%';

select an.slf_contrato_codigo,m.glb_mercadoria_descricao,count(*)
from tdvadm.t_arm_nota an,
     tdvadm.t_glb_mercadoria m
where an.slf_contrato_codigo in ('C2017010106','C4600006002')
  and an.arm_nota_dtinclusao >= '01/01/2017'
group by an.slf_contrato_codigo,m.glb_mercadoria_descricao;

select c.con_conhecimento_codigo cte,
       c.glb_rota_codigo rt,
       tdvadm.pkg_slf_utilitarios.fn_retorna_contratoCod(trim(c.slf_solfrete_codigo) || trim(c.slf_tabela_codigo),trim(c.slf_solfrete_saque) || trim(c.slf_tabela_saque)) contrato,
       c.glb_mercadoria_codigo,
       m.glb_mercadoria_descricao,
       nf.con_nfttransporta_mercadoria mercadoria
from tdvadm.t_con_conhecimento c,
     tdvadm.t_glb_mercadoria m,
     tdvadm.t_con_nftransporta nf
where c.con_conhecimento_dtembarque >= '01/01/2017'
  and c.glb_mercadoria_codigo = m.glb_mercadoria_codigo
  and tdvadm.pkg_slf_utilitarios.fn_retorna_contratoCod(trim(c.slf_solfrete_codigo) || trim(c.slf_tabela_codigo),trim(c.slf_solfrete_saque) || trim(c.slf_tabela_saque)) in ('C2017010106','C4600006002')
  and c.con_conhecimento_codigo = nf.con_conhecimento_codigo
  and c.con_conhecimento_serie = nf.con_conhecimento_serie
  and c.glb_rota_codigo = nf.glb_rota_codigo
;




select * from tdvadm.t_ctb_movimento m
where m.ctb_pconta_codigo_partida = '220202200128'



select * from tdvadm.t_atr_terminal t
where t.atr_terminal_dtinstalado is not null
  and t.atr_terminal_dtretirado is null
  and t.atr_terminal_ativo = 'S'
  and t.atr_marcamodelo_codigo = '01'
  
  
  
select * from tdvadm.t_atr_marcamodelo
  


select * from tdvadm.t_glb_fornecedor f
where f.glb_fornecedor_nome like '%ROAD%'
  

            
select * from xlsuser.v_ctb_centrocustoanalitico a where a.CONTA = '220202204724'               
