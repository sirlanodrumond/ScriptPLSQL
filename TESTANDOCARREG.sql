select * from glbadm.v_job_rodando;


select * from tdvadm.t_arm_carregamento lg where lg.arm_carregamento_codigo = '1474237';
SELECT * FROM TDVADM.V_SLF_CLIENTECARGAS CC
WHERE CC.contrato = '5500058294-V-NO'
FOR UPDATE
  

SELECT * FROM TDVADM.T_ARM_NOTA AN


-- Add/modify columns 
alter table TDVADM.T_ARM_NOTA modify arm_nota_qtdelimit default 'N';

SELECT CC.SLF_CONTRATO_CODIGO,
       CC.SLF_CLIENTECARGAS_VIGENCIA,
       CC.FCF_TPCARGA_CODIGO,
       CC.FCF_TPCARGA_CODIGOPESQ,
       CC.SLF_TPRATEIO_CODIGO,
       CC.SLF_CLIENTECARGAS_PERCNTEX,
       CC.SLF_CLIENTECARGAS_PERCNTQM,
       CC.SLF_CLIENTECARGAS_PERCNTOUT,
       CC.SLF_CLIENTECARGAS_PERCNTTRA
FROM TDVADM.T_SLF_CLIENTECARGAS CC
WHERE 0 = 0
  AND CC.SLF_CONTRATO_CODIGO IN ('5500057877-RMF', 
                      '5500057880-INS', 
                      '5500057902-DX',
                      '5500057870-RT', 
                      '5500057880-ISO', 
                      '55000057895-BM',
                      '55000057896-DOR',
                      '5500057918-V-NN',
                      '5500057918-V-EE',
                      '5500057918-V-SS',
                      '5500058294-V-NO',
                      '5500058294-V-SP',
                      '5500058294-V-MG')
--  AND TRUNC(CC.SLF_CLIENTECARGAS_VIGENCIA) >= TO_DATE('01/02/2019','DD/MM/YYYY')
--  AND CC.GLB_GRUPOECONOMICO_CODIGO = '0020'
FOR UPDATE
  

 
select lg.con_loggeracao_codigo seq,
       lg.arm_nota_numero nota,
       lg.con_conhecimento_codigo cte,
       lg.con_loggeracao_obsgeracao obs,
       lg.con_loggeracao_erro erro,
       lg.con_loggeracao_formula formula,
       lg.con_loggeracao_fator fator,
       lg.con_loggeracao_sql sql,
       lg.con_loggeracao_dtgeracao geracao
from tdvadm.t_con_loggeracao lg
where 0 = 0
  and lg.arm_carregamento_codigo = '2001636'
--  and lg.con_loggeracao_erro is not null
--  and lower(lg.con_loggeracao_obsgeracao) like '%frete%'
  and (lg.con_loggeracao_obsgeracao like 'TESTANDO%' 
    or lg.con_loggeracao_obsgeracao like 'BUSCANDO%' 
    or lg.con_loggeracao_obsgeracao like 'RODANDO%' 
    or lg.con_loggeracao_erro is not null 
    or lg.con_loggeracao_obsgeracao like 'Pegando Situação da NOTA Antes de Gerar CTE%'
    or lg.con_loggeracao_obsgeracao like 'NAO ENC TAB FRETE PARA%')

--  and lg.con_loggeracao_formula is not null
--  and lg.con_conhecimento_codigo = '065787'
--  and upper(lg.con_loggeracao_obsgeracao) like '%PEDAGIO%'
order by 1;

select *
from tdvadm.t_arm_nota an
where an.arm_nota_numero = 4042
  and an.glb_cliente_cgccpfremetente = '58832866000149'
  
  

select *
from tdvadm.t_con_calcconhecimento ca
where ca.con_conhecimento_codigo = '065755'
  and ca.glb_rota_codigo = '630'
  and ca.con_calcviagem_valor <> 0
;

select c.con_conhecimento_codigo cte,
       c.glb_rota_codigo rota,
       nf.con_nftransportada_numnfiscal nota,
       c.arm_coleta_ncompra coleta,
       c.arm_coleta_ciclo ciclo,
       c.arm_carregamento_codigo carreg,
       c.arm_carregamento_codigopr carregpr ,
       c.slf_tabela_codigo tabela,
       c.slf_solfrete_codigo solfrete
from tdvadm.t_con_conhecimento c,
     tdvadm.t_con_nftransporta nf
where 0 = 0
  and c.con_conhecimento_codigo in ('020211',
'020245',
'020240',
'020214',
'020104',
'020213',
'020363')

  and c.glb_rota_codigo = '028'
--  and c.arm_coleta_ncompra = '787085'
--  and c.arm_coleta_ciclo = '002'
  and c.con_conhecimento_codigo = nf.con_conhecimento_codigo
  and c.con_conhecimento_serie = nf.con_conhecimento_serie
  and c.glb_rota_codigo = nf.glb_rota_codigo;
  
select an.arm_nota_localcoletal coleta,
       an.arm_nota_localentregal entrega,
       an.arm_nota_numero nota,
       an.glb_cliente_cgccpfremetente remetente,
       an.arm_nota_serie sr,
       an.arm_coleta_ncompra coleta,
       an.arm_coleta_ciclo ciclo,
       an.arm_nota_chavenfe chave,
       tdvadm.fn_busca_codigoibge(an.glb_localidade_codigoorigem,'IBC') origemnota,
       tdvadm.fn_busca_codigoibge(cec.glb_localidade_codigo,'IBC') origemcli,
       tdvadm.fn_busca_codigoibge(cee.glb_localidade_codigo,'IBC') destinocli,
       an.con_conhecimento_codigo rps,
       an.glb_rota_codigo rotacte,
       co.arm_coleta_entcoleta entcol,
       co.arm_coletaorigem_cod origem
from tdvadm.t_arm_nota an,
     tdvadm.t_glb_cliend cec,
     tdvadm.t_glb_cliend cee,
     tdvadm.t_arm_coleta co
where an.arm_armazem_codigo = '58'
  and an.arm_nota_numero in (68790,83667,67592,000178201,000067572,000010780,000009341,000061104,000036411,000048965)
  and rpad(an.glb_cliente_cgccpfremetente,20) = cec.glb_cliente_cgccpfcodigo 
  and an.glb_tpcliend_codremetente = cec.glb_tpcliend_codigo
  and rpad(an.glb_cliente_cgccpfdestinatario,20) = cee.glb_cliente_cgccpfcodigo
  and an.glb_tpcliend_coddestinatario = cee.glb_tpcliend_codigo
  and an.arm_coleta_ncompra = co.arm_coleta_ncompra
  and an.arm_coleta_ciclo = co.arm_coleta_ciclo;
  
  
  
  


select * from tdvadm.t_cax_brendimento b
where b.cax_brendimento_cggcpf = '80746659687';

  
select v.fcf_tpveiculo_descricao,v.fcf_tpveiculo_codigo
from tdvadm.t_fcf_tpveiculo v  
  
  
  


select *
from tdvadm.t_slf_clienteped cp
where cp.glb_localidade_codigooriib = '3522208'
  and cp.glb_localidade_codigodesib = '3520103'
  and cp.glb_grupoeconomico_codigo = '0628'
  and cp.glb_cliente_cgccpfcodigo = '99999999999999'
  and cp.slf_contrato_codigo = 'C2018010119'
  and cp.fcf_tpcarga_codigo = '38'
;


select 


select *
from tdvadm.t_glb_localidade lo
where lo.glb_localidade_codigoibge in ('3522208','3506805')  ;


select c.arm_coleta_ncompra,c.*
from tdvadm.t_con_conhecimento c
where c.arm_coleta_ncompra in ('724104','724120')
  and c.arm_coleta_ciclo = '002';
  
select c.arm_coletaocor_codigo,c.*
from tdvadm.t_arm_coleta c
where c.arm_coleta_ncompra in ('724104','724120')
  and c.arm_coleta_ciclo = '002';

select * from tdvadm.t_arm_coletaocor;


select distinct cv.slf_contrato_codigo contrato,
       cv.fcf_tpveiculo_codigo codveic,
       tv.fcf_tpveiculo_descricao veiculoTDV,
       cv.slf_cliregrasveic_nomeveic veiculoCLI
from tdvadm.t_slf_cliregrasveic cv,
     tdvadm.t_fcf_tpveiculo tv
where cv.slf_contrato_codigo = 'C2018010119'
  and cv.fcf_tpveiculo_codigo = tv.fcf_tpveiculo_codigo

  

  

select vc.carganOTA, vc.cte,vc.*
from tdvadm.v_arm_verifcarreg vc
where vc.carreg = '1231243'
order by 2
;

select *
from tdvadm.t_arm_coleta co
where co.arm_coleta_ncompra = '728633'
  and co.arm_coleta_ciclo = '002'
  ;
  
  
select *
from tdvadm.t_slf_clientecargas cc
where cc.slf_contrato_codigo = 'C2018010117'
  and cc.slf_clientecargas_ativo = 'S'
order by cc.slf_clientecargas_seqexec;

select * from tdvadm.v_slf_tpagrupa a
where a.COD = '01';




GLBADM.PGK_GLB_MANUTENCAO;
TDVADM.PKG_ECK_TRANSDADOS;
TDVADM.SP_JOB_PTRANS;


select distinct s.owner || '.' || s.name ||';'
from dba_source s
where lower(s.TEXT) like '%sp_cargaeclick_coletas%'




Tab/Sol            - 02102286-0001 - Vigente a partir de 22/03/2019 Status Normal
Coleta-Nota/Sr/Rem - 003-439250-000000020-A1 -33592510042400      
Contrato           - 5500058294-V-NO-MRO-VALE-FRACIONADO NO-0419
PAGADOR            - 33592510042400      -VALE S/A
Grupo Sacado       - 0020
Grupo Remetente    - 0020
Grupo Destinatario - 0020
CODIGO ONU         - 1935-I 
FRETE 1.219,20 
QUIMICO + 2.6      = 3.170,96 
TRANSFERENCIA 1.85 = 5.866,28
Correto
FRETE 1.219,20 
QUIMICO + 1.6      = 3.170,96 
TRANSFERENCIA -1.20 = 5.866,28

Cadastrado
        TABELA     PERCENTUAL   CORRETO
Quimico    1,6       160%       0,6     60%
Expresso   1,6       160%       0,6     60%
OutBound   0,85       85%      -0,2    -20%
Transf     0,85       85%      -0,2    -20%

update tdvadm.t_edi_integracsv x
  set x.row_nr = rownum;

select cc.contrato,
       cc.percentquimico,
       cc.perctex,
       cc.percentoutbound,
       cc.percttransf
from tdvadm.v_slf_clientecargas cc
where cc.contrato = '5500058294-V-NO'
  or cc.percentoutbound <> 0 
  
select *
from tdvadm.t_slf_tabela ta
where ta.slf_tabela_codigo = '02102286'
