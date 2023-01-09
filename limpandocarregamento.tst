PL/SQL Developer Test script 3.0
93
-- Created on 08/08/2017 by DESENV 
declare 
  -- Local variables here
  i integer;
  vVeic tdvadm.t_arm_carregamento.fcf_veiculodisp_codigo%type;
  vArmazem tdvadm.t_arm_carregamento.arm_armazem_codigo%type;
begin
  -- Test statements here
  vArmazem := '05';
  For c_msg in (select ca.arm_carregamento_codigo,ca.arm_carregamento_dtcria
                from tdvadm.t_Arm_Carregamento ca
                where CA.ARM_CARREGAMENTO_DTFECHAMENTO IS NULL
                  AND 0 = (select count(*)
                           from tdvadm.t_arm_carregamentodet cd
                           where cd.arm_carregamento_codigo = ca.arm_carregamento_codigo)
                  AND 0 = (SELECT COUNT(*)
                           FROM TDVADM.T_CON_CONHECIMENTO C
                           WHERE C.ARM_CARREGAMENTO_CODIGO = CA.ARM_CARREGAMENTO_CODIGO)
                  AND CA.ARM_ARMAZEM_CODIGO <> vArmazem
                  order by ca.arm_carregamento_dtcria desc)
  Loop
    
     delete armadm.T_ARM_CARREGMOBGRP ca
     where CA.ARM_CARREGAMENTO_CODIGO = c_msg.arm_carregamento_codigo;
     
     i := sql%rowcount;
     
     delete armadm.T_ARM_CARREGMOBGRP ca
     where CA.ARM_CARREGMOBGRP_CODGRP = c_msg.arm_carregamento_codigo;

     
     i := sql%rowcount;


     update tdvadm.t_arm_carregamento ca
       set ca.fcf_veiculodisp_codigo = null,
           ca.fcf_veiculodisp_sequencia = null
     where ca.arm_carregamento_codigo = c_msg.arm_carregamento_codigo;

     Delete TDVADM.T_ARM_CARREGAMENTO_HIST ca
     where CA.ARM_CARREGAMENTO_CODIGO = c_msg.arm_carregamento_codigo;

     delete tdvadm.t_Arm_CarregamentohIST ca
     where CA.ARM_CARREGAMENTO_CODIGO = c_msg.arm_carregamento_codigo;

     delete tdvadm.T_ARM_CARREGAMENTOVEIC ca
     where CA.ARM_CARREGAMENTO_CODIGO = c_msg.arm_carregamento_codigo;
     

     select ca.fcf_veiculodisp_codigo
       into vVeic
     from tdvadm.t_arm_carregamento ca
     where ca.arm_carregamento_codigo = c_msg.arm_carregamento_codigo;

     update tdvadm.T_CON_DOCMDFE vd
       set vd.arm_carregamento_codigo = null
     where vd.arm_carregamento_codigo = c_msg.arm_carregamento_codigo; 

     update tdvadm.T_CON_MANIFESTO vd
       set vd.arm_carregamento_codigo = null
     where vd.arm_carregamento_codigo = c_msg.arm_carregamento_codigo; 


     update tdvadm.T_FCF_VEICULODISPDEST vd
       set vd.arm_carregamento_codigo = null
     where vd.arm_carregamento_codigo = c_msg.arm_carregamento_codigo; 

     update tdvadm.t_fcf_veiculodisp vd
       set vd.arm_carregamento_codigo = null
     where vd.arm_carregamento_codigo = c_msg.arm_carregamento_codigo; 

     
     Begin
        delete tdvadm.t_arm_carregamento ca
        where ca.arm_carregamento_codigo = c_msg.arm_carregamento_codigo;       
        commit;
     exception
       When OTHERS Then
          rollback;
          dbms_output.put_line(c_msg.arm_carregamento_codigo || '-' || sqlerrm);
--          return;
       End;
     

  
    
  End Loop;
  
  
  
  
  
end;
0
4
c_msg.arm_carregamento_codigo
c_msg.arm_carregamento_dtcria
vVeic
i
