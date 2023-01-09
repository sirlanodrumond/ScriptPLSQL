select *
from tdvipf.t_ipf_conhec;

select * from tdvipf.v_ipf_reccust;
select * from xlsuser.v_ipf_reccust;





create or replace view tdvadm.v_cax_caixa015 as
select m.glb_rota_codigo rtcx,
       m.cax_boletim_data dtcax,
       m.cax_operacao_codigo oper,
       m.cax_movimento_documento doc,
       m.glb_rota_codigo_referencia rtdoc,
       m.cax_movimento_historico historico,
       m.cax_movimento_valor valor,
       (select count(*)
        from tdvadm.t_cax_movimento m1
        where m1.cax_movimento_documento = m.cax_movimento_documento
          and m1.glb_rota_codigo_referencia = m.glb_rota_codigo_referencia
          and m1.cax_movimento_valor = m.cax_movimento_valor
          and m1.cax_operacao_codigo = '2412') cxS2412,
       decode(m.cax_movimento_documento || m.glb_rota_codigo_referencia,'142958185',1,
                                                                        '144775045',1,
                                                                        '145161010',1,(select count(*)
                                                                                       from tdvadm.t_cax_movimento m1
                                                                                       where m1.cax_movimento_documento = m.cax_movimento_documento
                                                                                         and m1.glb_rota_codigo_referencia = '015' --m.glb_rota_codigo_referencia
                                                                                         and m1.cax_movimento_valor = m.cax_movimento_valor
                                                                                         and m1.cax_operacao_codigo = '2600')) cx2600,
       (select to_char(v.acc_vales_data,'dd/mm/yyyy') || '-' || v.acc_vales_numero || '-' || v.glb_rota_codigo
        from tdvadm.t_acc_vales v
        where v.acc_vales_numero = m.cax_movimento_documento
          and v.glb_rota_codigo = m.glb_rota_codigo_referencia
          and v.acc_vales_valor = m.cax_movimento_valor) accvale
from tdvadm.t_cax_movimento m
where m.cax_boletim_data >=to_date( '01/09/2018','DD/MM/YYYY');


select *
from tdvadm.v_cax_caixa015 m
where 0 = 0
--  and m.cx2600 = 0
  and m.doc = '144895'
  and m.dtcax <= to_date(?,'DD/MM/YYYY')
  and m.oper in ('1127')
;

select m.glb_rota_codigo,
       m.cax_boletim_data,
       m.cax_movimento_documento,
       m.glb_rota_codigo_referencia,
       m.cax_operacao_codigo,
       m.cax_movimento_valor,
       m.cax_movimento_historico
from tdvadm.t_cax_movimento m
where m.cax_movimento_documento = '142853'
  and m.glb_rota_codigo_referencia = '010'

select *
from tdvadm.t_cax_movimento m
where m.cax_boletim_data >= '01/06/2019'
  and m.cax_operacao_codigo = '2600'
  
  
select v.acc_vales_numero vale,
       v.glb_rota_codigo rota,
       v.acc_vales_data data,
       v.acc_vales_valor valor,
       v.acc_acontas_numero acerto
from tdvadm.t_acc_vales v
where v.acc_acontas_numero is not null
  and v.acc_vales_data >= to_date('01/09/2018','dd/mm/yyyy')
--  and v.acc_vales_numero = 141730
  and 0 = (select count(*)
           from tdvadm.t_cax_movimento m
           where m.cax_operacao_codigo = '2600'
             and m.cax_movimento_documento = rpad(v.acc_vales_numero,10)
             and m.glb_rota_codigo_referencia = '015'
          )
  and 0 = (select count(*)
           from tdvadm.t_cax_movimento m
           where m.cax_operacao_codigo = '2412'
             and m.cax_movimento_documento = rpad(v.acc_vales_numero,10)
             and m.glb_rota_codigo_referencia = v.glb_rota_codigo)          
  and 0 < (select count(*)
           from tdvadm.t_cax_movimento m
           where m.cax_operacao_codigo = '1127'
             and m.cax_movimento_documento = rpad(v.acc_vales_numero,10)
             and m.glb_rota_codigo_referencia = v.glb_rota_codigo);
             

tdvadm.TG_BU_SLF_PERCURSO_BLOQUPDATE;
tdvadm.TG_BIUC_SLF_PERCURSO_NOVO;
             
             

             
select *
from dba_source s
where s.TEXT like '%11111111%'

select '%''11111111''%' from dual;

tdvadm.PKG_ACC_VALES;
