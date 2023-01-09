PL/SQL Developer Test script 3.0
17
-- Created on 15/05/2020 by SIRLANO.DRUMOND 
begin
  -- Test statements here
  
  for c_msg in (select i.edi_integra_col01 contade,
                       i.edi_integra_col02 contapara
                from tdvadm.t_edi_integra i
                where i.edi_integra_protocolo =  1162315)
  loop
     update tdvadm.t_ctb_pconta pc
     set pc.ctb_pconta_codigo_ref = c_msg.contapara
     where pc.ctb_pconta_codigo = c_msg.contade;
     
     commit;
  End Loop;  
 
end;
0
0
