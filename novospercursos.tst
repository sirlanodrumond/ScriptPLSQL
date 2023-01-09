PL/SQL Developer Test script 3.0
72
-- Created on 14/09/2017 by DESENV 
declare 
  -- Local variables here
  i integer;
  vOrigem    tdvadm.t_arm_nota.arm_nota_localcoletal%type;
  vDestino   tdvadm.t_arm_nota.arm_nota_localentregal%type;
  vOrigemi   tdvadm.t_arm_nota.arm_nota_localcoletai%type;
  vDestinoi  tdvadm.t_arm_nota.arm_nota_localentregai%type;
  vTabela    tdvadm.t_slf_clientecargas.slf_clientecargas_tabkm%type;
  tpPercurso tdvadm.t_slf_percurso%rowType;
begin
  -- Test statements here
  i := 0;
  FOR C_MSG IN (SELECT DISTINCT AN.ARM_NOTA_DTINCLUSAO,
                                AN.ARM_NOTA_LOCALCOLETAL,
                                AN.ARM_NOTA_LOCALCOLETAI,
                                AN.ARM_NOTA_LOCALENTREGAL,
                                AN.ARM_NOTA_LOCALENTREGAI,
                                CC.SLF_CLIENTECARGAS_TABKM
                FROM TDVADM.T_ARM_NOTA AN,
                     TDVADM.T_SLF_CLIENTECARGAS CC 
                WHERE AN.ARM_NOTA_DTINCLUSAO >= SYSDATE - 4
                  AND AN.SLF_CONTRATO_CODIGO = CC.SLF_CONTRATO_CODIGO (+)
                  AND CC.SLF_CLIENTECARGAS_ATIVO =  'S'
--                  AND CC.SLF_CLIENTECARGAS_TABKM = '2781910'
                  AND 0 = DECODE(CC.SLF_CLIENTECARGAS_TABKM,'2781910',(SELECT COUNT(*)
                                                                       FROM TDVADM.T_SLF_PERCURSO_2781910 P
                                                                       WHERE P.GLB_LOCALIDADE_CODIGOORIGEMI = AN.ARM_NOTA_LOCALCOLETAI
                                                                         AND P.GLB_LOCALIDADE_CODIGODESTINOI = AN.ARM_NOTA_LOCALENTREGAI),
                                                             '82795' ,(SELECT COUNT(*)
                                                                       FROM TDVADM.T_SLF_PERCURSO_82795 P
                                                                       WHERE P.GLB_LOCALIDADE_CODIGOORIGEMI = AN.ARM_NOTA_LOCALCOLETAI
                                                                         AND P.GLB_LOCALIDADE_CODIGODESTINOI = AN.ARM_NOTA_LOCALENTREGAI),
                                                             '91566' ,(SELECT COUNT(*)
                                                                       FROM TDVADM.T_SLF_PERCURSO_91566 P
                                                                       WHERE P.GLB_LOCALIDADE_CODIGOORIGEMI = AN.ARM_NOTA_LOCALCOLETAI
                                                                         AND P.GLB_LOCALIDADE_CODIGODESTINOI = AN.ARM_NOTA_LOCALENTREGAI),1))
   Loop
      vTabela  := c_msg.slf_clientecargas_tabkm;
      vOrigem  := c_msg.arm_nota_localcoletal;
      vDestino := c_msg.arm_nota_localentregal;
      Begin
        select *
          into tpPercurso
        From tdvadm.t_slf_percurso p
        where p.glb_localidade_codigoorigem = vOrigem
          and p.glb_localidade_codigodestino = vDestino
          and p.slf_percurso_km > 0
          and p.slf_percurso_flagcons = 'S';
        i:= 1;
      Exception
        When NO_DATA_FOUND then
           i := 0;
        End;     
      If i =  1 then
         vOrigemi := c_msg.arm_nota_localcoletai;
         vDestinoi := c_msg.arm_nota_localentregai;
         tpPercurso.Slf_Percurso_Datacadastro := sysdate;
         If vTabela = '2781910' Then
            insert into tdvadm.t_slf_percurso_2781910
            values tpPercurso;
         ElsIf vTabela = '82795' Then
            insert into tdvadm.t_slf_percurso_82795
            values tpPercurso;
         ElsIf vTabela = '91566' Then
            insert into tdvadm.t_slf_percurso_91566
            values tpPercurso;
         End If;
      End IF;
   End Loop;
                    
end;
0
3
vTabela
vOrigem
vDestino
