-- PEDAGIOS

select *
from dba_source s
where upper(s.TEXT) like '%SP_SET_SOLICITAPED%';
select *
from glbadm.v_job_todos s
where upper(s.WHAT) like '%SP_SET_SOLICITAPED%';

select *
from dba_source s
where upper(s.TEXT) like '%SP_GET_VALORPEDAGIO%';
select *
from glbadm.v_job_todos s
where upper(s.WHAT) like '%SP_GET_VALORPEDAGIO%';


select *
from dba_source s
where upper(s.TEXT) like '%PKG_CON_VALEFRETEWEB%';
select *
from glbadm.v_job_todos s
where upper(s.WHAT) like '%PKG_CON_VALEFRETEWEB%';

select *
from dba_source s
where upper(s.TEXT) like '%F_BUSCA_PEDAGIO_PERCURSO_ATU%';
select *
from glbadm.v_job_todos s
where upper(s.WHAT) like '%F_BUSCA_PEDAGIO_PERCURSO_ATU%';

select * from tdvadm.t_fcf_fretecar
