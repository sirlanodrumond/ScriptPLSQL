PL/SQL Developer Test script 3.0
142
-- Created on 23/11/2020 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  i integer;
  tpCUSTOMER_S_ROLES migdv.CUSTOMER_S_ROLES%rowtype;
  tpVENDOR_S_ROLES   migdv.vendor_s_roles%rowtype;
  tpVEND_EXT_S_ROLES migdv.vend_ext_s_roles%rowtype;
  vInc char(1);
begin
  -- Test statements here
  
--  delete migdv.CUSTOMER_S_ROLES;
  delete migdv.vendor_s_roles;
--  delete migdv.vend_ext_s_roles;
  commit;

  i := 0;

/*
  For c_msg in (select g.KUNNR,
                       substr(g.NAMORG4,-3,3) tipo,
                       g.SORTL,
                       g.NATPERS,
                       d.nom_dominio
                from migdv.customer_s_cust_gen g,
--                     migdv.meta_dominio_coluna@database_tdx d
                     migdv.meta_dominio_coluna d
                where d.nom_view = 'CUSTOMER_S_ROLES' 
                  and d.nom_coluna = 'BP_ROLE')
  Loop
     vInc := 'S';
     If ( c_msg.nom_dominio = 'CRM010' ) and -- Transportadora
        ( c_msg.tipo not in ('PRO','CAR') ) Then

        vInc := 'N';
     End If;
     
     If ( c_msg.nom_dominio = 'MTRST' ) and -- Motorista
        ( c_msg.tipo not in ('PRO','CAR') ) Then
        vInc := 'N';
     End If;
     
     If Vinc = 'S' Then
        tpCUSTOMER_S_ROLES.Kunnr := c_msg.KUNNR;
        tpCUSTOMER_S_ROLES.Bp_Role := c_msg.nom_dominio;
        insert into migdv.customer_s_roles values tpCUSTOMER_S_ROLES;
        i := i + 1;
        If mod(i,100) = 0 Then
           commit;
        End If;
     End If;
    
  End Loop;
  commit;

*/



  For c_msg in (select v.LIFNR,
                       substr(v.NAME4,-3,3) tipo,
                       v.SORTL,
                       v.NATPERS,
                       d.nom_dominio 
                from migdv.vendor_s_suppl_gen v,
--                     migdv.meta_dominio_coluna@database_tdx d
                     migdv.meta_dominio_coluna d
                where d.nom_view = 'VENDOR_S_ROLES' 
                  and d.nom_coluna = 'BP_ROLE')
  Loop
     vInc := 'S';
     If ( c_msg.nom_dominio = 'CRM010' ) and -- Transportadora
        ( c_msg.tipo not in ('PRO','CAR') ) Then

        vInc := 'N';
     End If;
     
     If ( c_msg.nom_dominio = 'MTRST' ) and -- Motorista
        ( c_msg.tipo not in ('PRO','CAR') ) Then
        vInc := 'N';
     End If;
     
     If Vinc = 'S' Then
        tpVENDOR_S_ROLES.Lifnr := c_msg.LIFNR;
        tpVENDOR_S_ROLES.Bp_Role := c_msg.nom_dominio;
        insert into migdv.VENDOR_S_ROLES values tpVENDOR_S_ROLES;
        i := i + 1;
        If mod(i,100) = 0 Then
           commit;
        End If;
     End If;
    
  End Loop;
  commit;

/*
  For c_msg in (select v.LIFNR,
                       substr(v.NAME4,-3,3) tipo,
                       v.SORTL,
                       v.NATPERS,
                       d.nom_dominio
                from migdv.vend_ext_s_suppl_gen ve,
                     migdv.vendor_s_suppl_gen v,
--                     migdv.meta_dominio_coluna@database_tdx d
                     migdv.meta_dominio_coluna d
                where ve.LIFNR = v.LIFNR 
                  and d.nom_view = 'VEND_EXT_S_ROLES' 
                  and d.nom_coluna = 'BP_ROLE'
                order by 1,5)
   loop

     vInc := 'S';
     If ( c_msg.nom_dominio = 'CRM010' ) and -- Transportadora
        ( c_msg.tipo not in ('PRO','CAR') ) Then

        vInc := 'N';
     End If;
     
     If ( c_msg.nom_dominio = 'MTRST' ) and -- Motorista
        ( c_msg.tipo not in ('PRO','CAR') ) Then
        vInc := 'N';
     End If;
     
     If Vinc = 'S' Then
        tpVEND_EXT_S_ROLES.Lifnr := c_msg.LIFNR;
        tpVEND_EXT_S_ROLES.Bp_Role := c_msg.nom_dominio;
        insert into migdv.vend_ext_s_roles values tpVEND_EXT_S_ROLES;
        i := i + 1;
        If mod(i,10) = 0 Then
           commit;
        End If;
     End If;
    
     
   End Loop;
  commit;
*/
exception 
  When OTHERS Then
    raise_application_error(-20123,i || '-' || tpVEND_EXT_S_ROLES.Lifnr || '-' || tpVEND_EXT_S_ROLES.Bp_Role || chr(10) || sqlerrm);
  
end;
0
3
i
c_msg.nom_dominio
c_msg.tipo
