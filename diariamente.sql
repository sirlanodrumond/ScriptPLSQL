insert into tdvadm.t_arm_carregamemcalc
select c.arm_carregamemcalc_codigo,
       c.arm_armazem_codigo,
       c.arm_carregamento_dtfechamento,
       '11',
       '61139432000172',
       '61139432000172',
       null,
       '05571',
       '61139432000172',
       null,
       '05571',
       'C',
       '111111',
       null,
       '0020',
       'T',
       '99',
       '99',
       null,
       null,
       null,
       null,
       c.arm_carregamento_dtfechamento,
       null
from tdvadm.t_arm_carregamento c
where c.arm_carregamento_dtfechamento >= '08/11/2017'
  and c.arm_carregamemcalc_codigo is not null
  and 0 = (select count(*)
           from tdvadm.t_arm_carregamemcalc ca
           where ca.arm_carregamemcalc_memocalc = c.arm_carregamemcalc_codigo);


-- Porque nao esta gerando a t_arm_carregamemcalc
-- Verificar o Codigo do sistema grando errado

