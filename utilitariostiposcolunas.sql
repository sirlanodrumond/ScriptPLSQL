select * from migdv.v_controle c
where c.tabela in ('OPEN_ITEM_AR_S_BSID','OPEN_ITEM_AP_S_BSIK')
  or c.qtde <> 0
order by 2;
select distinct s.TYPE 
from dba_source s;
select * from tdvadm.V_TI_DEFCOLUNAS x
where x.owner = 'MIGDV'
  and x.TABLE_NAME = 'RECURSO';
select * from tdvadm.V_GLB_CRIATIPOS x
where x.OWNER = 'MIGDV'
  and x.TABLE_NAME = 'RECURSO';
select * from tdvadm.V_TABELAS_COMMENTS x
where x.dono = 'MIGDV'
  and x.tabela = 'RECURSO';
select * from tdvadm.V_TABELAS_MIGDV x
where x.dono = 'MIGDV'
  and x.tabela = 'RECURSO';

