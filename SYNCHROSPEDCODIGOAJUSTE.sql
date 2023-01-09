/* MUDANCA DOS IBGE DE ORIGEM E DESTINO */
select f.dt_fato_gerador_imposto,
       f.edof_codigo,
       f.tdv_sistema_origem,
       f.mun_cod_origem,
       f.mun_cod_destino,
       f.cod_mun_col,
       f.cod_mun_entg
--from synchro.cor_dof f
from tdvadm.synitf_dof  f
where 0 = 0
  and f.dt_fato_gerador_imposto >= to_date('01/12/2019','DD/MM/YYYY')
  and f.edof_codigo not in ('NF','NFE','NFS','RPA','CF','NFS-E','NFEE')
  and ( f.mun_cod_origem is null or f.mun_cod_destino is null )
;

ALTER TRIGGER SYNCHRO.COR_IDF_AIUDS DISABLE;
ALTER TRIGGER SYNCHRO.COR_DOF_AIUDS DISABLE;
ALTER TRIGGER SYNCHRO.COR_IDF_BIUDR DISABLE;
ALTER TRIGGER SYNCHRO.COR_DOF_BIUDR DISABLE;


update synchro.cor_dof f
  set f.mun_cod_origem = f.cod_mun_col,
      f.mun_cod_destino = f.cod_mun_entg
where 0 = 0
  and f.dt_fato_gerador_imposto >= to_date('01/12/2019','DD/MM/YYYY')
  and f.edof_codigo not in ('NF','NFE','NFS','RPA','CF','NFS-E','NFEE')
  and ( f.mun_cod_origem is null or f.mun_cod_destino is null )
;
commit;

ALTER TRIGGER SYNCHRO.COR_IDF_AIUDS enable;
ALTER TRIGGER SYNCHRO.COR_DOF_AIUDS enable;
ALTER TRIGGER SYNCHRO.COR_IDF_BIUDR enable;
ALTER TRIGGER SYNCHRO.COR_DOF_BIUDR enable;
   

select f.dt_fato_gerador_imposto,
       f.edof_codigo,
       f.tdv_sistema_origem,
       f.mun_cod_origem,
       f.mun_cod_destino,
       f.cod_mun_col,
       f.cod_mun_entg
from tdvadm.synitf_dof f
where 0 = 0
  and f.dt_fato_gerador_imposto >= to_date('01/08/2019','DD/MM/YYYY')
  and f.edof_codigo not in ('NF','NFE','NFS','RPA','CF','NFS-E','NFEE')
  and ( f.mun_cod_origem is null or f.mun_cod_destino is null )
      
  
  
  
UPDATE synchro.cor_dof f
  SET (f.mun_cod_origem,f.mun_cod_destino) = (SELECT f1.mun_cod_origem,f1.mun_cod_destino 
                                               FROM SYNCHRO.cor_dof@DATABASE_TDP f1
                                               WHERE F1.TDV_SISTEMA_ORIGEM = F.TDV_SISTEMA_ORIGEM)
where 0 = 0
  and f.dt_fato_gerador_imposto >= to_date('01/01/2019','DD/MM/YYYY')
  and f.edof_codigo not in ('NF','NFE','NFS','RPA','CF','NFS-E','NFEE')
  and ( f.mun_cod_origem is null or f.mun_cod_destino is null );
COMMIT;



/*       AJUSTE DO CODIGO DOS IMPOSTOS                    */


SELECT * FROM synchro.SYN_VERSAO_OBJETO ORDER BY LAST_UPDATED DESC;
SELECT * FROM synchro.SYN_REVISAO_KIT ORDER BY DT_APLICACAO DESC;

select i.observacao,count(*) qtde from synchro.FIS_LANCAMENTO_IMPOSTO i
where to_char(i.dt_fato_gerador_imposto,'YYYYMM') = '202001'
group by i.observacao;

select i.observacao,i.codigo_ajuste,I.UF_CODIGO  from synchro.FIS_LANCAMENTO_IMPOSTO i
where to_char(i.dt_fato_gerador_imposto,'YYYYMM') = '202001'
and i.observacao like '%DIFERENCIAL DE ALIQUOTA%'
and i.codigo_ajuste is null
for update;

select DISTINCT i.observacao,i.codigo_ajuste,i.uf_codigo 
from synchro.FIS_LANCAMENTO_IMPOSTO i
where to_char(i.dt_fato_gerador_imposto,'YYYYMM') = '202001'
and i.codigo_ajuste is null
AND I.OBSERVACAO NOT IN ('COFINS COMPRAS','PIS COMPRAS','*')
and i.observacao like 'AJUSTE ANULADOR%'
for update
  


 
update synchro.FIS_LANCAMENTO_IMPOSTO i
  set i.codigo_ajuste = (select distinct i2.codigo_ajuste 
                         from synchro.FIS_LANCAMENTO_IMPOSTO i2 
                         where i2.uf_codigo = I.UF_CODIGO
                           and  to_char(i2.dt_fato_gerador_imposto,'YYYYMM') = '202001' 
                           and i2.observacao like '%CR%DITO PRESUMIDO%')
where to_char(i.dt_fato_gerador_imposto,'YYYYMM') = '202001'
and ( i.observacao like '%ICMS PAGO ANTECIPADO%' OR i.observacao like '%ICMS PAGO ANTECIPADO%' )
  and i.codigo_ajuste is null
  


update synchro.FIS_LANCAMENTO_IMPOSTO i
  set i.codigo_ajuste = 'MA020033'
where to_char(i.dt_fato_gerador_imposto,'YYYYMM') = '202001'
  and i.observacao like '%CR%DITO PRESUMIDO%'
  and i.uf_codigo = 'MA'
  and i.codigo_ajuste is null

select d.emitente_pfj_codigo,
       substr(d.tdv_sistema_origem,9,3) sr,
       max((select  r.glb_rota_emitedoc
        from tdvadm.t_glb_rota r
        where r.glb_rota_codigo = substr(d.tdv_sistema_origem,9,3))) tipo, 
       count(*)
from synchro.cor_dof d
where to_char(d.dt_fato_gerador_imposto,'YYYYMM') = '202001'
  and d.tdv_sistema_origem is not null
group by d.emitente_pfj_codigo,substr(d.tdv_sistema_origem,9,3)

select r.glb_rota_emitedoc,r.glb_rota_codigo,r.glb_rota_descricao
from tdvadm.t_glb_rota r



;
  synchro.limp_IDX_fk
  
  select * from synchro.COR_INDEXADOR






















delete synchro.FIS_LANCAMENTO_IMPOSTO i
where to_char(i.dt_fato_gerador_imposto,'YYYYMM') = '202001'
  and i.observacao like '%CR%DITO PRESUMIDO%';
  









