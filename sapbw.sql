SELECT * FROM "_SYS_BIC"."TDV.TDV_ORACLE/"@TDHDSAPBW;


-- FUNCIONANDO
SELECT * FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_CONJUNTO"@TDHDSAPBW;
SELECT * FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_NFE_CLIENTES"@TDHDSAPBW;
SELECT * FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_COLETA"@TDHDSAPBW;
SELECT * FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_BP"@TDHDSAPBW;
SELECT * FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_MOTORISTA"@TDHDSAPBW;
SELECT * FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_CONJUNTO"@TDHDSAPBW;
SELECT * FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_MOTORISTA"@TDHDSAPBW;
SELECT * FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_VEICULOS"@TDHDSAPBW;
SELECT * FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_VEICULOS"@TDHDSAPBW;
SELECT * FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_PLANO_CONTAS"@TDHDSAPBW;
SELECT * FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_CENTROCUSTO"@TDHDSAPBW;
SELECT * FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_CENTRO_LUCRO"@TDHDSAPBW;
SELECT * FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_PNEUS"@TDHDSAPBW;
SELECT * FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_CONTABILIDADE_GERAL"@TDHDSAPBW;
SELECT * FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_ETIQUETAS"@TDHDSAPBW;
SELECT * FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_CTE"@TDHDSAPBW;
SELECT * FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_TITULOS_AR_CLIENTES"@TDHDSAPBW;
SELECT * FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_TITULOS_AP_FORNECEDORES"@TDHDSAPBW;


select *
from tdvadm.t_fcf_fretecarmemohist h
where trunc(h.fcf_fretecarmemohist_gravacao) = trunc(sysdate)
  and h.fcf_veiculodisp_codigo = '8525846'
  
  select 4100 * 0.08 , (4100 + 261.3) * 0.08 from dual;
  
  select *
  from tdvadm.t_fcf_veiculodisp vd
  where vd.car_veiculo_placa = 'ISI5920'
  


select *
from dba_source s
where upper(s.TEXT) like '%JSON%'
  and s.OWNER = 'TDVADM';
  
  
  
  
  select *
  from dba_users u
  where u.username like '%FPW_REC%'
  
  ALTER SESSION SET CURRENT_SCHEMA = 'TDVADM'
  
  select * from dba_tables t
  where t.TABLE_NAME like '%REL%'
    and t.OWNER not in ('BGM')
    ;
    
    
    select * from tdvadm.t_glb_localidade l where l.glb_localidade_descricao like '%SALOBO%';
select * from tdvadm.t_glb_cliend ce where ce.glb_cliente_cgccpfcodigo = '33931478000275'
for update;

select *
from tdvadm.t_frt_veiculo v
where v.frt_veiculo_placa in ('DVT6G20','DTA7592')
  or v.frt_veiculo_codigo = 'MWL4529'


;

select *
from tdvadm.t_frt_conjunto c
where c.frt_conjveiculo_codigo = 'A007051';

select *
from tdvadm.t_frt_conteng  x
where x.frt_conjveiculo_codigo = 'A007051'
for update
   


'  

SELECT decode(rownum,1,'','union ') || 'Select count(*) QTDE,''' || v.VIEW_NAME || ''' OBJETO  from ' || v.OWNER || '.' || v.VIEW_NAME 
FROM DBA_VIEWS V
WHERE V.OWNER = 'SAPBWTDV'

Select count(*) QTDE,'CV_CONJUNTO' OBJETO  from SAPBWTDV.CV_CONJUNTO
union Select count(*) QTDE,'CV_CONTABILIDADE_GERAL' OBJETO  from SAPBWTDV.CV_CONTABILIDADE_GERAL
union Select count(*) QTDE,'CV_MOTORISTA' OBJETO  from SAPBWTDV.CV_MOTORISTA
union Select count(*) QTDE,'CV_NOTAS' OBJETO  from SAPBWTDV.CV_NOTAS
union Select count(*) QTDE,'CV_ORDEM_FRETE' OBJETO  from SAPBWTDV.CV_ORDEM_FRETE
union Select count(*) QTDE,'CV_PNEUS' OBJETO  from SAPBWTDV.CV_PNEUS
union Select count(*) QTDE,'CV_TABELA_PRECO' OBJETO  from SAPBWTDV.CV_TABELA_PRECO
union Select count(*) QTDE,'CV_TITULOS_AP_FORNECEDORES' OBJETO  from SAPBWTDV.CV_TITULOS_AP_FORNECEDORES
union Select count(*) QTDE,'CV_TITULOS_AR_CLIENTES' OBJETO  from SAPBWTDV.CV_TITULOS_AR_CLIENTES
union Select count(*) QTDE,'CV_VEICULOS' OBJETO  from SAPBWTDV.CV_VEICULOS
union Select count(*) QTDE,'CV_VEICULOS_MANUTENCAO' OBJETO  from SAPBWTDV.CV_VEICULOS_MANUTENCAO
;
select * From SAPBWTDV.CV_TABELA_PRECO



create view sapbwtdv.CV_TM_GERAL as
select *
FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_TM_GERAL"@TDHDSAPBW;

create view sapbwtdv.CV_VALE_FRETE as
select *
FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_VALE_FRETE"@TDHDSAPBW;
*****************************************************
                   VERIFICAR NOME 
*****************************************************
CV_TITULOS_AP_FORNCEDORES mudar para CV_TITULOS_AP_FORNECEDORES
*****************************************************
                     ERRO 
*****************************************************
select *
FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_VALE_FRETE"@TDHDSAPBW;
select *
FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_TM_GERAL"@TDHDSAPBW;




select * FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_TITULOS_AP_FORNECEDORES"@TDHDSAPBW; 
select * FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_CONTABILIDADE_GERAL"@TDHDSAPBW; 
select * FROM "_SYS_BIC"."TDV.TDV_ORACLE/"@TDHDSAPBW; 
select * FROM "_SYS_BIC"."TDV.TDV_ORACLE/"@TDHDSAPBW; 
select * FROM "_SYS_BIC"."TDV.TDV_ORACLE/"@TDHDSAPBW; 
select * FROM "_SYS_BIC"."TDV.TDV_ORACLE/"@TDHDSAPBW; 
select * FROM "_SYS_BIC"."TDV.TDV_ORACLE/"@TDHDSAPBW; 
select * FROM "_SYS_BIC"."TDV.TDV_ORACLE/"@TDHDSAPBW; 

SELECT
    "NUM_DOC_CONTABIL",
    "DESCR_DOC_CONTABIL",
    "TP_DOC_CONTABIL",
    "NUM_CONTA_RAZAO",
    "DESCR_CONTA_RAZAO",
    "NUM_CENTRO_CUSTO",
    "DESCR_CENTRO_CUSTO",
    "EMPRESA",
    "PERIODO_FISCAL",
    "TP_LANC_DC",
    "DATA_LANCAMENTO",
    "ANO_FISCAL",
    "CENTRO",
    "DATA_CARGA",
    "ITEM",
    "COD_COND_PGMNT",
    "DESCR_COND_PGMNT",
    "DATA_COMPENSACAO",
    "NUM_DOC_COMPENSACAO",
    "DSEQUENCIA",
    "CODIGO_ROTA",
    "CODIGO_PARTIDA",
    "CODIGO_CPARTIDA",
    "CODIGO_HISTORICO",
    "ORIGEM",
    "LINKID",
    "NUM_CENTRO_CUSTO_CONTRATO",
    sum("MONTANTE") AS "MONTANTE" 
FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_CONTABILIDADE_GERAL"@TDHDSAPBW 
GROUP BY "NUM_DOC_CONTABIL",
    "DESCR_DOC_CONTABIL",
    "TP_DOC_CONTABIL",
    "NUM_CONTA_RAZAO",
    "DESCR_CONTA_RAZAO",
    "NUM_CENTRO_CUSTO",
    "DESCR_CENTRO_CUSTO",
    "EMPRESA",
    "PERIODO_FISCAL",
    "TP_LANC_DC",
    "DATA_LANCAMENTO",
    "ANO_FISCAL",
    "CENTRO",
    "DATA_CARGA",
    "ITEM",
    "COD_COND_PGMNT",
    "DESCR_COND_PGMNT",
    "DATA_COMPENSACAO",
    "NUM_DOC_COMPENSACAO",
    "DSEQUENCIA",
    "CODIGO_ROTA",
    "CODIGO_PARTIDA",
    "CODIGO_CPARTIDA",
    "CODIGO_HISTORICO",
    "ORIGEM",
    "LINKID",
    "NUM_CENTRO_CUSTO_CONTRATO"

select *
from tdvadm.t_uti_geraplanilha gp
where gp.uti_geraplanilha_codigo = 'vlfmes'
for update;



select ip.DT Referencia,
       ip.cadastro dthoravf,
       (select min(h.arm_valefretehist_gravacao)
        from tdvadm.t_con_valefretehist h
        where h.con_conhecimento_codigo = ip.VF
          and h.con_conhecimento_serie = ip.serie
          and h.glb_rota_codigo = ip.rota
          and h.con_valefrete_saque = ip.sq 
          and nvl(h.con_valefrete_impresso,'N') = 'S') dtimpressaohist,
       ip.VF Codigo,
       ip.serie Serie,
       ip.rota Rota,
       ip.sq   Saque,
       decode(trim(ip.tipo),'A','Agregado','F','Frota','D','Dedicado','Carreteiro') Tipo,
       ip.CPF  CPF,
       ip.NOME Nome,
       ip.placa Placa,       
       ip.FRETESP FreteSP,
       ip.PEDAGIO Pedagio,
       (IP.FRETEBRUTO - IP.PEDAGIO) - IP.FRETESP  AGREGADO,
       ip.IR IRRF,
       ip.INSS INSS,
       ip.SESTSENATRET SestSenatRet
  from v_ctb_impostosanalitico ip
 where ip.dt = '11/2021'
 
'







select *
from tdvadm.v_arm_coletaorigemdestinojava j
where j.coleta = '577773'














tdvadm.pkg_fifo_carregctrc
