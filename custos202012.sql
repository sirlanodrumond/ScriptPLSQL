select * from tdvadm.t_glb_sql t
where t.glb_sql_programa = 'RECCUST'
  and t.glb_sql_dtgravacao >= to_date('27/12/2020 00:00','dd/mm/yyyy hh24:mi')
order by 2;

select '1.01 - Pneus' tipo,a.ipf_pneu_referencia referencia,count(*) Qtude
from tdvipf.t_ipf_pneusref a 
where a.ipf_pneu_referencia >= '202010'
group by a.ipf_pneu_referencia
union
select '2.01 - VALEFRETE' tipo,rr.ipf_valefrete_referencia referencia,count(*) Qtude
from tdvipf.t_ipf_valefrete rr
where rr.ipf_valefrete_referencia >= '202010'
group by rr.ipf_valefrete_referencia
union
select '2.02 - CTE' TIPO,to_char(rr.ipf_conhec_dtemissao,'yyyymm') referencia,count(*) Qtude
from tdvipf.t_ipf_conhec rr
where to_char(rr.ipf_conhec_dtemissao,'yyyymm') >= '202010'
group by to_char(rr.ipf_conhec_dtemissao,'yyyymm')
union
select '2.03 - VFRETECONHEC' tipo,rr.ipf_reccust_referencia referencia,count(*) Qtude
from tdvipf.t_ipf_reccust rr
where rr.ipf_reccust_referencia >= '202010'
group by rr.ipf_reccust_referencia
union
select '3.00 - CTACC' tipo,cc.ctb_referencia_codigo referencia,count(*) qtde
from tdvadm.t_ctb_pcontasaldocc cc
where cc.ctb_referencia_codigo >= '202010'
group by cc.ctb_referencia_codigo 
union
select '3.01 - MOVOC' tipo,to_char(mc.ctb_movimento_dtmovto,'YYYYMM') referencia,count(*) qtde
from tdvadm.t_ctb_movimentooc mc
where to_char(mc.ctb_movimento_dtmovto,'YYYYMM') >= '202010'
group by to_char(mc.ctb_movimento_dtmovto,'YYYYMM')
union
select '3.02 - BALANC' tipo,x.REFERENCIA,count(*) qtde
from TDVADM.V_CTB_BALANCINHO x
where x.REFERENCIA >= '202010'
group by x.REFERENCIA
union
select '4.00 - IND' tipo,i.ipf_reccust_referencia,count(*) qtde
from tdvipf.t_ipf_indicadoresc i
where i.ipf_reccust_referencia >= '202010'
group by i.ipf_reccust_referencia
union
select '5.00 - CUSTRAT' tipo,i.ipf_reccust_referencia referencia,count(*) qtde
from tdvipf.t_ipf_centrocustorateado i
where i.ipf_reccust_referencia >= '202010'
group by i.ipf_reccust_referencia 
order by 1

select *
from tdvadm.v_lock_tables;


select *
from tdvipf.pkg_ipf_manut;

select r.ipf_drt_customanutplan
from tdvipf.t_ipf_drtreccust r
where r.ipf_drt_referencia = '202011'


select *
from dba_source s
where lower(s.TEXT) like '%ipf_drt_customanutplan%';

select *
from rmadm.t_glb_benasserec b
where b.glb_benasserec_origem like '%dantas%'
  and trunc(b.glb_benasserec_gravacao ) = '21/12/2020';
  
  -- 1301777
  select * from tdvadm.t_edi_integra c where c.edi_integra_protocolo = 
  
  select it.edi_integra_col03 placa,
                           sum(replace(it.edi_integra_col07,',','.')) valor,
                           it.edi_integra_col13 referencia
                      from tdvadm.t_edi_integra it
                     where it.edi_integra_protocolo = 1301777
                       and it.edi_integra_col03 <> 'PLACA'
                       and it.edi_integra_col07 <> 'VALOR'
                       group by it.edi_integra_col03, it.edi_integra_col13
  
  
  tdvadm.PKG_EDI_PLANILHA;

select * from wservice.t_glb_emailpend x
where x.glb_emailpend_assunto like '%#CUS%'

