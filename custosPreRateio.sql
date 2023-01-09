
 drop table tdvipf.t_ipf_centrocustorateado;
create table tdvipf.t_ipf_centrocustorateado
as
--insert into tdvipf.t_ipf_centrocustorateado
select 'NTCCCT' tipo,x.*,i.*
from tdvipf.v_ipf_centrocustocontrato x,
     tdvipf.t_ipf_indicadoresc i
where x.referencia = '201907'
  and x.ccrateio = 'TODOS'
  and x.codcentrocusto <> '9999'
  and x.codcccontrato <> '9999'
  and x.referencia     = i.ipf_reccust_referencia
  and x.codcentrocusto = i.ipf_valefrete_centrocusto
  and x.codcccontrato  = i.ipf_conhec_cccontrato
  and x.glb_tpcentrocusto_rateavel = 'N'
  ;


insert into tdvipf.t_ipf_centrocustorateado
select 'NTCC  ' tipo,x.*,i.*
from tdvipf.v_ipf_centrocustocontrato x,
     tdvipf.t_ipf_indicadoresc i
where x.referencia = '201907'
  and x.ccrateio = 'TODOS'
  and x.codcentrocusto <> '9999'
  and x.codcccontrato  = '9999'
  and x.referencia     = i.ipf_reccust_referencia
  and x.codcentrocusto = i.ipf_valefrete_centrocusto
--  and x.codcccontrato  = i.ipf_conhec_cccontrato
  and x.glb_tpcentrocusto_rateavel = 'N'
;


insert into tdvipf.t_ipf_centrocustorateado
select 'STCCCT' tipo,x.*,i.*
from tdvipf.v_ipf_centrocustocontrato x,
     tdvipf.t_ipf_indicadoresc i
where x.referencia = '201907'
  and x.ccrateio = 'TODOS'
  and x.codcentrocusto <> '9999'
  and x.codcccontrato <> '9999'
  and x.glb_tpcentrocusto_rateavel = 'S'
  and x.referencia     = i.ipf_reccust_referencia
  -- Para os rateaveis = a SIM não temos o centro de custo do VALE DE FRETE
--  and x.codcentrocusto = i.ipf_valefrete_centrocusto
  and x.codcccontrato  = i.ipf_conhec_cccontrato
;

insert into tdvipf.t_ipf_centrocustorateado
select 'STCCCT' tipo,x.*,i.*
from tdvipf.v_ipf_centrocustocontrato x,
     tdvipf.t_ipf_indicadoresc i
where x.referencia = '201907'
--  and x.ctb_movimento_documento = '0000001'
--  and x.ctb_movimento_dsequencia = 196
  and x.ccrateio <> 'TODOS'
  and x.codcentrocusto <> '9999'
  and x.codcccontrato <> '9999'
  and x.glb_tpcentrocusto_rateavel = 'S'
  and x.referencia     = i.ipf_reccust_referencia
  -- Para os rateaveis = a SIM não temos o centro de custo do VALE DE FRETE
  and instr(x.ccrateio,i.ipf_valefrete_centrocusto) > 0
--  and x.codcccontrato  = i.ipf_conhec_cccontrato

;
insert into tdvipf.t_ipf_centrocustorateado
select 'STCC  ' tipo,x.*,i.*
from tdvipf.v_ipf_centrocustocontrato x,
     tdvipf.t_ipf_indicadoresc i
where x.referencia = '201907'
  and x.ccrateio = 'TODOS'
  and x.codcentrocusto <> '9999'
  and x.codcccontrato  = '9999'
  and x.glb_tpcentrocusto_rateavel = 'S'
  and x.referencia     = i.ipf_reccust_referencia
  -- Para os rateaveis = a SIM não temos o centro de custo do VALE DE FRETE
--  and x.codcentrocusto = i.ipf_valefrete_centrocusto
--  and x.codcccontrato  = i.ipf_conhec_cccontrato
;

NTCCCT - RATEAVEL N / TODOS / CENTRO DE CUSTO / CONTRATO
NTCC   - RATEAVEL N / TODOS / CENTRO DE CUSTO 
STCCCT - RATEAVEL S / TODOS / CENTRO DE CUSTO / CONTRATO
STCC   - RATEAVEL S / TODOS / CENTRO DE CUSTO 

select 'STCC  ' tipo,x.*,i.*
from tdvipf.v_ipf_centrocustocontrato x,
     tdvipf.t_ipf_indicadoresc i
where x.referencia = '201907'
  and x.ccrateio = 'TODOS'
  and x.codcentrocusto <> '9999'
--  and x.codcccontrato  = '9999'
  and x.glb_tpcentrocusto_rateavel = 'S'
  and x.referencia     = i.ipf_reccust_referencia (+)
  -- Para os rateaveis = a SIM não temos o centro de custo do VALE DE FRETE
--  and x.codcentrocusto = i.ipf_valefrete_centrocusto
--  and x.codcccontrato  = i.ipf_conhec_cccontrato
  and x.ctb_movimento_documento = '0000001'
  and x.ctb_movimento_dsequencia = 196
;

select ( x.ratctfretepesochave / x.ratctfretepesocctot) calc,x.*
from tdvipf.v_ipf_centrocustorateado x
where x.ipf_valefrete_centrocusto = '4023'
  and x.historico like '%000019980%'



tdvipf.pkg_reccust_diretos2019;


grant select, references on tdvipf.T_IPF_CENTROCUSTORATEADO to XLSUSER with grant option;
grant select, references on tdvipf.v_ipf_centrocustorateado to XLSUSER with grant option;


select * from xlsuser.v_ipf_centrocustorateado 


select x.referencia,x.tipo,count(*) qtde
select *
from tdvipf.V_ipf_centrocustorateado x
where x.ipf_valefrete_centrocusto = '4023'
  and x.ipf_conhec_cccontrato = '5366'
  AND X.ccorig = '3069'
  AND X.historico LIKE '%000250719%'
  
  
  and x.historico like '%000019980%'
group by x.referencia,x.tipo;


select C.CON_CONHECIMENTO_CODIGO,
       C.GLB_ROTA_CODIGO,
       C.GLB_CLIENTE_CGCCPFSACADO,
       C.SLF_SOLFRETE_CODIGO,
       C.SLF_SOLFRETE_SAQUE,
       C.SLF_TABELA_CODIGO,
       C.SLF_TABELA_SAQUE,
       C.ARM_CARREGAMENTO_CODIGO
from tdvadm.t_con_vfreteconhec vfc,
     TDVADM.T_CON_CONHECIMENTO C
where vfc.con_valefrete_codigo = '097025'
  and vfc.glb_rota_codigovalefrete = '157'
  AND VFC.CON_CONHECIMENTO_CODIGO = C.CON_CONHECIMENTO_CODIGO
  AND VFC.CON_CONHECIMENTO_SERIE = C.CON_CONHECIMENTO_SERIE
  AND VFC.GLB_ROTA_CODIGO = C.GLB_ROTA_CODIGO;
  
  SELECT * FROM TDVADM.T_SLF_TABELA TA
  WHERE TA.SLF_TABELA_CODIGO = '00000082';
  
;  

SELECT *
FROM TDVADM.T_SLF_CLIENTEREGRAS R
WHERE R.SLF_CONTRATO_CODIGO = 'C4600019594'
FOR UPDATE
  


SELECT * FROM TDVADM.T_CON_MODALIDADEPED;
SELECT * FROM TDVADM.T_CON_FCOBPED;
SELECT * FROM TDVADM.T_CON_FPAGTOMOTPED


SELECT * FROM TDVADM.T_CON_CONHECVPED V
WHERE V.CON_CONHECIMENTO_CODIGO IN ('097025','097024')
  AND V.GLB_ROTA_CODIGO = '157'
FOR UPDATE
  
  
 SELECT *
 FROM DBA_TAB_COLUMNS TC
 WHERE TC.COLUMN_NAME = 'CON_MODALIDADEPED_CODIGO'



select *
from xlsuser.v_ipf_centrocustorateado r
where 0 = 0
  and r.ipf_valefrete_centrocusto = '4023'
--  and r.ipf_conhec_cccontrato = '5366'
  and r.historico like '%NF 000250719 (FAT. ),SEM PARAR -VIA FACIL%';
  
STCC
  
  select 312995.25 * .00466 from dual
  
  
  
  tdvipf.pkg_reccust_diretos2019


select *
from tdvadm.t_fcf_veiculodisp vf
where (vf.fcf_veiculodisp_codigo,vf.fcf_veiculodisp_sequencia) in
(select vf.fcf_veiculodisp_codigo,vf.fcf_veiculodisp_sequencia 
 from tdvadm.t_con_valefrete vf
 where vf.con_conhecimento_codigo in ('097046','097048')
   and vf.glb_rota_codigo = '157')
for update;
   
952705506



select *
from xlsuser.v_ipf_centrocustorateado r
where 0 = 0
  and r.ipf_valefrete_centrocusto = '4023'
--  and r.ipf_conhec_cccontrato = '5366'
  and r.historico like '%NF 000260404%';
  
   
  
