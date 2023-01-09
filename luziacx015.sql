-- operacao
 -- 2167 - VALE FROTA PROPRIA - AUTOMATICA
tdvadm.FN_VEFIF_ACCVALE;
tdvadm.PKG_ACC_VALES;
tdvadm.PKG_CTB_CAIXA;
tdvadm.SP_SET_RESUMOCAIXAFROTA;
tdvadm.TG_AIU_CAX_PAGTOVALEFRETE;
tdvadm.TG_BD_CAX_MOVIMENTO;


select *
from tdvadm.t_cax_operacao op
where op.cax_operacao_codigo in ('2167')

select * from tdvadm.t_cax_movimento m
where m.cax_operacao_codigo = '2167'
  and m.cax_movimento_documento like  '%144427%';
  
select *
from dba_source s
where s.TEXT like '%''2167''%'

select * from tdvadm.v_acc_composicao015;
select * from tdvadm.v_acc_valessemcax015;
select * from tdvadm.v_acc_caxia015semvale;


select * 
from tdvadm.t_cax_movimento m 
where m.cax_movimento_documento = '142958'
  and m.glb_rota_codigo_referencia = '180';
  
select * from tdvadm


select * -- to_char(m.cax_boletim_data,'yyyymmdd')
       from tdvadm.t_cax_movimento m
       where m.cax_operacao_codigo = '1127' -- ADIANTAMENTO FROTA PRÓPRIA - RECEBIDO (E)
--          and m.glb_rota_codigo = '015'
          and m.cax_movimento_documento = '142958'
          and m.cax_movimento_documento || m.glb_rota_codigo_referencia || trim(to_char(m.cax_movimento_sequencia)) <> '1429581858'
          and m.glb_rota_codigo_referencia = v.glb_rota_codigo;

select * from tdvadm.t_acc_vales v
where v.acc_vales_numero = 142958        



