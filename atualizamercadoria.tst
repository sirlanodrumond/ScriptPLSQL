PL/SQL Developer Test script 3.0
50
-- Created on 25/08/2017 by DESENV 
declare 
  -- Local variables here
  i integer;
  msg varchar2(1000);
begin
  -- Test statements here
  i := 0;
  msg := 'alter trigger TDVADM.TG_TRAVACTRC_DATALIVRO disable';
  execute immediate msg;
  FOR C_MSG IN (SELECT C.CON_CONHECIMENTO_DTEMBARQUE DATAEMB,
                       C.CON_CONHECIMENTO_CODIGO CTE,
                       C.CON_CONHECIMENTO_SERIE SR,
                       C.GLB_ROTA_CODIGO RT,
                       C.GLB_MERCADORIA_CODIGO MERCCTE,
                       TRIM(SF.GLB_MERCADORIA_CODIGO || TA.GLB_MERCADORIA_CODIGO) MERCTABSOL,
                       C.ARM_CARREGAMENTO_CODIGOPR CARREG,
                       C.ROWID
                       
                FROM TDVADM.T_CON_CONHECIMENTO C,
                     TDVADM.T_SLF_SOLFRETE SF,
                     TDVADM.T_SLF_TABELA TA
                WHERE C.CON_CONHECIMENTO_DTEMBARQUE >= '01/01/2017'
                  AND C.SLF_TABELA_CODIGO = TA.SLF_TABELA_CODIGO (+)
                  AND C.SLF_TABELA_SAQUE = TA.SLF_TABELA_SAQUE (+)
                  AND C.SLF_SOLFRETE_CODIGO = SF.SLF_SOLFRETE_CODIGO (+)
                  AND C.SLF_SOLFRETE_SAQUE = SF.SLF_SOLFRETE_SAQUE (+)
                  AND TRIM(C.GLB_MERCADORIA_CODIGO) <> TRIM(SF.GLB_MERCADORIA_CODIGO || TA.GLB_MERCADORIA_CODIGO)
                  and rownum < 5000)

   Loop

      i := i + 1;
      Begin
         UPDATE TDVADM.T_CON_CONHECIMENTO C 
            SET C.GLB_MERCADORIA_CODIGO = c_msg.merctabsol
         WHERE ROWID = c_msg.rowid  ;  
      Exception
        When OTHERS Then
           msg := sqlerrm;
           i:= i - 1;
      End;
      If mod(i,100) = 0 Then
         commit;
      End If;
   End Loop;
   Commit;
   msg := 'alter trigger TDVADM.TG_TRAVACTRC_DATALIVRO enable';
   execute immediate msg;
end;
0
2
i
msg
