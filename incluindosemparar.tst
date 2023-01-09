PL/SQL Developer Test script 3.0
39
-- Created on 11/01/2018 by DESENV 
declare 
  -- Local variables here
  i integer;
  tpSemParar tdvipf.t_ipf_sparar%rowtype;
begin
  update t_ipf_sparartmp s
    set s.ipf_sparar_placa = replace(s.ipf_sparar_placa,'-','');
  commit; 
  -- Test statements here
  for c_msg in (select x.*,x.rowid
                from t_ipf_sparartmp x)
  Loop
  
     select count(*)
        into i
     from tdvipf.t_ipf_sparar sp
     where sp.ipf_sparar_placa = c_msg.ipf_sparar_placa
       and sp.ipf_sparar_data = c_msg.ipf_sparar_data
       and sp.ipf_sparar_hora = c_msg.ipf_sparar_hora;
     
     If i = 0 Then
        tpSemParar.Ipf_Sparar_Placa   := c_msg.Ipf_Sparar_Placa ; 
        tpSemParar.Ipf_Sparar_Tag     := c_msg.Ipf_Sparar_Tag ;
        tpSemParar.Ipf_Sparar_Prefixo := c_msg.Ipf_Sparar_Prefixo ;
        tpSemParar.Ipf_Sparar_Marca   := c_msg.Ipf_Sparar_Marca ;
        tpSemParar.Ipf_Sparar_Categ   := c_msg.Ipf_Sparar_Categ ;
        tpSemParar.Ipf_Sparar_Data    := c_msg.Ipf_Sparar_Data ;
        tpSemParar.Ipf_Sparar_Hora    := c_msg.Ipf_Sparar_Hora ;
        tpSemParar.Ipf_Sparar_Rodovia := c_msg.Ipf_Sparar_Rodovia ;
        tpSemParar.Ipf_Sparar_Praca   := c_msg.Ipf_Sparar_Praca ;
        tpSemParar.Ipf_Sparar_Valor   := c_msg.Ipf_Sparar_Valor ;
        insert into tdvipf.t_ipf_sparar values tpSemParar;
        delete tdvipf.t_ipf_sparartmp t
        where t.rowid = c_msg.rowid;
        commit; 
     End If;
  End Loop;
end;
0
1
i
