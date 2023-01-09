SELECT *  FROM tdvadm.V_CTB_CENTROCUSTOANALITICO x;
select x.ctb_referencia_codigo,count(*)
from tdvipf.t_ipf_ctbdepara x
group by x.ctb_referencia_codigo;

;

select *
from glbadm.v_job_rodando;


-- Lista Duplicidades
select r.tmp_rpt_relatorio,
       r.con_conhecimento_codigo,
       r.con_conhecimento_serie,
       r.glb_rota_codigo,
       count(*)
from tdvadm.t_tmp_rpt r
where r.tmp_rpt_usuario = 'GRD'
group by r.tmp_rpt_relatorio,r.con_conhecimento_codigo,r.con_conhecimento_serie,r.glb_rota_codigo
having count(*) > 1;


select count(*)
from tdvadm.t_con_conhecimento@TESTEDBL


select * from dba_tab_columns x
where lower(x.COLUMN_NAME) like '%sistema externo%'
  and x.OWNER = 'TDVADM'
  

-- 4671129 TDP

-- removendo duplicidades
delete tdvadm.t_tmp_rpt r2
select *
from  tdvadm.t_tmp_rpt r2
where r2.tmp_rpt_usuario = 'GRD'
  and (r2.tmp_rpt_relatorio,
       r2.con_conhecimento_codigo,
       r2.con_conhecimento_serie,
       r2.glb_rota_codigo) in (select r.tmp_rpt_relatorio,
                                      r.con_conhecimento_codigo,
                                      r.con_conhecimento_serie,
                                      r.glb_rota_codigo
                              from tdvadm.t_tmp_rpt r
                              where r.tmp_rpt_usuario = 'GRD'
                              group by r.tmp_rpt_relatorio,r.con_conhecimento_codigo,r.con_conhecimento_serie,r.glb_rota_codigo
                              having count(*) > 1);
commit;                              
                              



select * from tdvadm.t_arm_coletaocor o
where o.arm_coletaocor_codigo in ('05','81','57');


7    

select * from tdvadm.t_arm_nota an
where an.arm_nota_numero = 77705
  and an.glb_cliente_cgccpfremetente = '635552654112';
  
select * from tdvadm.t_con_nftransporta nf
where nf.con_nftransportada_numnfiscal in ('000177705',
                                           '000177706',
                                           '000177707',
                                           '000177708',
                                           '000177709',
                                           '000177710',
                                           '000177711',
                                           '000051229')
  and nf.glb_rota_codigo = '021';
                                           
  
  
  
  
  -- Add/modify columns

alter table tdvadm.T_COL_ASN add slf_contrato_numero VARCHAR2(15);

alter table T_COL_ASN add col_asn_operacao CHAR(1);

 

-- Add/modify columns

alter table tdvadm.T_ARM_COLETA add slf_contrato_codigo VARCHAR2(15);

alter table T_ARM_COLETA add arm_coleta_operacao CHAR(1);

 

-- Add/modify columns

alter table tdvadm.T_ARM_COLETAPART add slf_contrato_codigo VARCHAR2(15);

alter table T_ARM_COLETAPART add arm_coletapart_operacao CHAR(1);
  



