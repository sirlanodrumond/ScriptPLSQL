with ext_loc as (
    select position-1 as pos
         , name as filename
    from sys.external_location$
    where obj# = ( select object_id
                   from user_objects
                   where object_name = 'TEST_XT' )
  )
select t.rowid,
       dump(t.rowid) as rowid_dump,
       regexp_substr(dump(t.rowid,10,9,1),'\d+$') as file#,
       t.filename
from TDVADM.T_EDI_INTEGRACSV t,
     ext_loc x
where x.pos = to_number(regexp_substr(dump(t.rowid,10,9,1),'\d+$'))    
;

select * from DBA_EXTERNAL_TABLES
select * from sys.external_location$

ext_loc x on x.pos = to_number(regexp_substr(dump(t.rowid,10,9,1),'\d+$'))
