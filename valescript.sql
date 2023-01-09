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
