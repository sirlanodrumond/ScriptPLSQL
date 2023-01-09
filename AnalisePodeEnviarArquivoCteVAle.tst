PL/SQL Developer Test script 3.0
27
-- Created on 11/01/2017 by DESENV 
declare 
  -- Local variables here
  i integer;
  vStatus  char(1);
  vMessage varchar2(2000);
  
begin
  -- Test statements here
  
  for p_cursor in (SELECT LK.GLB_TESTESTR_1
                     FROM TDVADM.T_GLB_TESTESTR LK
                    WHERE TRUNC(LK.GLB_TESTESTR_DTGRAV) = TRUNC(SYSDATE)
                   )
  loop
    
    tdvadm.pkg_con_cte.Sp_CtePodeEnviar(p_cursor.glb_testestr_1, vStatus, vMessage);
    
    if (vStatus != 'N') then
      
    dbms_output.put_line(p_cursor.glb_testestr_1||' - '||vMessage);
    
    end if;  
    
  end loop;
  
end;
0
0
