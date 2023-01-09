SELECT 'ROLLBACK FORCE '''||LOCAL_TRAN_ID||''';'''||COMMIT#||''';'
FROM DBA_2PC_PENDING;

ROLLBACK FORCE '25.15.8789770'


select m.glb_rota_codigo,count(*)
from tdvadm.t_cax_movimento m
where m.cax_boletim_data = '29/11/2020'
group by m.glb_rota_codigo;

select *
from 

select *
from tdvadm.t_cax_boletim b
where b.glb_rota_codigo = '010'
  and b.cax_boletim_data >= '20/11/2020'
  for update
  
  10	010	29/11/2020	0,00	12252,13	1284958,86	1272706,73	F	N	25/11/2020 09:07:46	332
  
