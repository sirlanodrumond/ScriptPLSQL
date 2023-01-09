-- Add/modify columns 
alter table TDVADM.T_ARM_NOTA add arm_nota_qtdelimit char(1);
-- Add comments to the columns 
comment on column TDVADM.T_ARM_NOTA.arm_nota_qtdelimit
  is 'Quantidade Limitade de Produto quimico (S/N)';

tdvadm.pkg_fifo_recebimento;
tdvadm.pkg_fifo

select *
from tdvadm.t_arm_nota an
where 0 = 0
  and an.arm_armazem_codigo = '06'
  and an.arm_nota_dtinclusao >= sysdate - 160
  and an.arm_nota_onu is not null
order by an.arm_nota_dtinclusao desc;

  

select * from tdvadm.t_arm_nota an


select * from dba_source s where lower(s.TEXT) like '%fnp_getdadosnotaxml%'


select a.col_asn_numero asn,
       a.arm_coleta_ncompra coleta,
       c.slf_contrato_codigo contrato
from tdvadm.t_arm_coletapart c,
     tdvadm.t_col_asn a
where c.arm_coleta_ncompra = a.arm_coleta_ncompra
  and c.arm_coleta_ciclo = a.arm_coleta_ciclo
  and a.col_asn_numero in ('V830100035','V830100041');
  
select cc.contrato,
       cc.pesominimo,
       cc.pesomaximo,
       cc.perctex,
       cc.percentquimico,
       cc.percentoutbound,
       cc.percttransf
from tdvadm.v_slf_clientecargas cc
where cc.contrato in ('5500057877-RMF', 
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
  or cc.Grupo = '0020'                      ;
  
