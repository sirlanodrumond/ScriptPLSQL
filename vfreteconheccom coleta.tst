PL/SQL Developer Test script 3.0
58
-- Created on 27/05/2022 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  i integer;
  pColeta tdvadm.t_con_vfretecoleta.arm_coleta_ncompra%type := '985845';
  pCiclo  tdvadm.t_con_vfretecoleta.arm_coleta_ciclo%type := '005';
  tpVfreteConhec tdvadm.t_con_vfreteconhec%rowtype;
begin
  -- Test statements here
  for c_msg in (select CO.CON_VALEFRETE_CODIGO,
                       CO.CON_VALEFRETE_SERIE,
                       CO.GLB_ROTA_CODIGOVALEFRETE,
                       CO.CON_VALEFRETE_SAQUE ,
                       CO.ARM_COLETA_NCOMPRA || '-' || CO.ARM_COLETA_CICLO COLCO,
                       VFC.CON_CONHECIMENTO_CODIGO || '-' || VFC.CON_CONHECIMENTO_SERIE || '-' || VFC.GLB_ROTA_CODIGO CTEVFC,
                       C.CON_CONHECIMENTO_CODIGO,
                       C.CON_CONHECIMENTO_SERIE,
                       C.GLB_ROTA_CODIGO
                from tdvadm.t_con_vfretecoleta co,
                     tdvadm.t_con_vfreteconhec vfc
                     ,tdvadm.t_con_conhecimento c
                where co.arm_coleta_ncompra = pColeta
                  and co.arm_coleta_ciclo   = pCiclo
                  and co.con_valefrete_codigo = vfc.con_valefrete_codigo (+)
                  and co.con_valefrete_serie = vfc.con_valefrete_serie (+)
                  and co.glb_rota_codigovalefrete = vfc.glb_rota_codigovalefrete (+)
                  and co.con_valefrete_saque = vfc.con_valefrete_saque (+)
                  and co.arm_coleta_ncompra = c.arm_coleta_ncompra (+)
                  and co.arm_coleta_ciclo = c.arm_coleta_ciclo (+))
  Loop
     If c_msg.CTEVFC  = '--' Then
        tpVfreteConhec.Con_Valefrete_Codigo           := c_msg.CON_VALEFRETE_CODIGO;
        tpVfreteConhec.Con_Valefrete_Serie            := c_msg.CON_VALEFRETE_SERIE;
        tpVfreteConhec.Glb_Rota_Codigovalefrete       := c_msg.GLB_ROTA_CODIGOVALEFRETE;
        tpVfreteConhec.Con_Valefrete_Saque            := c_msg.CON_VALEFRETE_SAQUE;
        tpVfreteConhec.Glb_Rota_Codigo                := c_msg.GLB_ROTA_CODIGO;
        tpVfreteConhec.Con_Conhecimento_Codigo        := c_msg.CON_CONHECIMENTO_CODIGO;
        tpVfreteConhec.Con_Conhecimento_Serie         := c_msg.CON_CONHECIMENTO_SERIE;
        tpVfreteConhec.Con_Vfreteconhec_Recalcula     := 'S';
        tpVfreteConhec.Slf_Tpcalculo_Codigo           := null;
        tpVfreteConhec.Con_Vfreteconhec_Saldo         := 0;
        tpVfreteConhec.Con_Vfreteconhec_Pedagio       := 0;
        tpVfreteConhec.Con_Vfreteconhec_Rateioreceita := 0;
        tpVfreteConhec.Con_Vfreteconhec_Rateiofrete   := 0;
        tpVfreteConhec.Con_Vfreteconhec_Rateiopedagio := 0;
        tpVfreteConhec.Con_Vfreteconhec_Dtentrega     := null;
        tpVfreteConhec.Con_Vfreteconhec_Rateioicmiss  := 0;
        tpVfreteConhec.Con_Vfreteconhec_Dtgravacao    := sysdate;
        tpVfreteConhec.Con_Vfreteconhec_Usumaq        := null;
        tpVfreteConhec.Con_Vfreteconhec_Transfchekin  := null;
        tpVfreteConhec.Arm_Armazem_Codigo             := null;
        insert into tdvadm.t_con_vfreteconhec values tpVfreteConhec;
        i := 1;
     End If;
     
  End Loop;
  
end;
0
1
c_msg.CTEVFC
