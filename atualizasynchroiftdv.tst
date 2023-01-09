PL/SQL Developer Test script 3.0
66
declare 
  i integer := 0;
begin
  :isaida := i;
  for c_msg in (select *
                from (select (select distinct sd.tdv_sistema_origem
                              from tdvadm.synitf_dof sd
                              where sd.dof_import_numero = d.dof_import_numero
                                and sd.dt_fato_gerador_imposto = d.dt_fato_gerador_imposto) chavetdv,
                             d.dt_fato_gerador_imposto,
                             d.numero,
                             d.edof_codigo,
                             d.rowid
                      from synchro.cor_dof d
                      where trunc(d.dt_fato_gerador_imposto) >= to_date('01/' || to_char(add_months(sysdate,-2),'MM/YYYY'),'dd/mm/yyyy')
                        and d.tdv_sistema_origem is null
                        and d.edof_codigo in ('NFS','ANU','CTE','CTRC') ) x
                where x.chavetdv is not null)
  Loop
     If i = 0 Then
        execute immediate 'alter trigger SYNCHRO.COR_DOF_AIUDR disable';
        execute immediate 'alter trigger SYNCHRO.cor_dof_aiuds disable';
        execute immediate 'alter trigger SYNCHRO.COR_DOF_BIUDR disable';
        execute immediate 'alter trigger SYNCHRO.cor_dof_biuds disable';
        execute immediate 'alter trigger SYNCHRO.fis_dof_biudr disable';
        execute immediate 'alter trigger SYNCHRO.in_cor_dof_aiudr disable';
        execute immediate 'alter trigger SYNCHRO.JP_TRG_CONF_NF disable';
        execute immediate 'alter trigger SYNCHRO.RETIDOS_DOF_AUS disable';
        execute immediate 'alter trigger SYNCHRO.RETIDOS_DOF_BUDR disable';
     End If;
     update synchro.cor_dof d
     set d.tdv_sistema_origem = c_msg.chavetdv
     where d.rowid = c_msg.rowid;
     
     i := i + 1;
     :isaida := i;
     If mod(i,100) = 0 Then
        commit;
        --return;
     End IF;
  End Loop;
  commit;  
  If i > 0 Then
     execute immediate 'alter trigger SYNCHRO.COR_DOF_AIUDR enable';
     execute immediate 'alter trigger SYNCHRO.cor_dof_aiuds enable';
     execute immediate 'alter trigger SYNCHRO.COR_DOF_BIUDR enable';
     execute immediate 'alter trigger SYNCHRO.cor_dof_biuds enable';
     execute immediate 'alter trigger SYNCHRO.fis_dof_biudr enable';
     execute immediate 'alter trigger SYNCHRO.in_cor_dof_aiudr enable';
     execute immediate 'alter trigger SYNCHRO.JP_TRG_CONF_NF enable';
     execute immediate 'alter trigger SYNCHRO.RETIDOS_DOF_AUS enable';
     execute immediate 'alter trigger SYNCHRO.RETIDOS_DOF_BUDR enable';
  End If;
exception
   When OTHERS Then
     :isaida := i;
     execute immediate 'alter trigger SYNCHRO.COR_DOF_AIUDR enable';
     execute immediate 'alter trigger SYNCHRO.cor_dof_aiuds enable';
     execute immediate 'alter trigger SYNCHRO.COR_DOF_BIUDR enable';
     execute immediate 'alter trigger SYNCHRO.cor_dof_biuds enable';
     execute immediate 'alter trigger SYNCHRO.fis_dof_biudr enable';
     execute immediate 'alter trigger SYNCHRO.in_cor_dof_aiudr enable';
     execute immediate 'alter trigger SYNCHRO.JP_TRG_CONF_NF enable';
     execute immediate 'alter trigger SYNCHRO.RETIDOS_DOF_AUS enable';
     execute immediate 'alter trigger SYNCHRO.RETIDOS_DOF_BUDR enable';
end;
1
isaida
1
0
3
0
