PL/SQL Developer Test script 3.0
88
-- Created on 05/04/2021 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  vAuxiliar integer;
  pASN       tdvadm.t_col_asn.col_asn_numero%type := 'N000913792';
  vASNID     tdvadm.t_col_asn.col_asn_id%type;
  vARMColeta tdvadm.t_col_asn.arm_coleta_ncompra%type;
  vARMCiclo  tdvadm.t_col_asn.arm_coleta_ciclo%type;
begin
  -- Test statements here
  
   for c_msg in (select a.col_asn_id,
                        a.arm_coleta_ncompra,
                        a.arm_coleta_ciclo
                 from tdvadm.t_col_asn a
                 where a.col_asn_numero = pASN)

   Loop    
     

      insert into tdvadm.T_COL_ASN@database_tdx
      select *
      from tdvadm.T_COL_ASN a
      where a.col_asn_numero = pASN
        and a.col_asn_id = c_msg.col_asn_id;
      
      insert into tdvadm.T_COL_ASNITEM@database_tdx
      select *
      from tdvadm.T_COL_ASNITEM a
      where a.col_asn_id = c_msg.col_asn_id;

      insert into tdvadm.T_COL_ASNPARCEIRO@database_tdx
      select *
      from tdvadm.T_COL_ASNPARCEIRO p
      where p.col_asn_id = c_msg.col_asn_id;
      

      insert into tdvadm.T_COL_ASNARQUIVO@database_tdx
      select *
      from tdvadm.T_COL_ASNARQUIVO a
      where a.col_asn_id = c_msg.col_asn_id;

      insert into tdvadm.T_COL_ASNREJEICAO@database_tdx
      select *
      from tdvadm.T_COL_ASNREJEICAO a
      where a.col_asn_id = c_msg.col_asn_id;


      If c_msg.arm_coleta_ncompra is not null Then
         
         select count(*)
           into vAuxiliar
         from tdvadm.t_arm_coleta@database_tdx co
         where co.arm_coleta_ncompra = c_msg.arm_coleta_ncompra
           and co.arm_coleta_ciclo = c_msg.arm_coleta_ciclo;
         
         If vAuxiliar = 0 Then
             insert into tdvadm.t_arm_coleta@database_tdx 
             select *
             from tdvadm.t_arm_coleta co
             where co.arm_coleta_ncompra = c_msg.arm_coleta_ncompra
               and co.arm_coleta_ciclo = c_msg.arm_coleta_ciclo;

             Update tdvadm.t_arm_coleta@database_tdx co
               set co.arm_coletaocor_codigo = null,
                   co.ARM_COLETA_DTFECHAMENTO = null,
                   co.usu_usuario_codigo_impresso = null
             where co.arm_coleta_ncompra = vARMColeta
               and co.arm_coleta_ciclo = vARMCiclo;
             
             insert into tdvadm.t_arm_coletancompra@database_tdx 
             select *
             from tdvadm.t_arm_coletancompra co
             where co.arm_coletancompra = vARMColeta
               and co.arm_coleta_ciclo = vARMCiclo;

             insert into tdvadm.t_arm_coletaparceiro@database_tdx 
             select *
             from tdvadm.t_arm_coletaparceiro co
             where co.arm_coleta_ncompra = vARMColeta
               and co.arm_coleta_ciclo = vARMCiclo;
         End If;  
      End If;

   End Loop;
  --rollback;

end;
4
pStarus
0
-5
pMessagem
0
-5
pStatus
0
-5
pMessage
0
-5
2
vAuxiliar
