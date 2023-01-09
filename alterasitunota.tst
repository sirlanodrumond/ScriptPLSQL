PL/SQL Developer Test script 3.0
82
-- Created on 06/05/2022 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  vAuxiliar integer;
  vDtFechamentoJan date := sysdate;
begin
   
   update tdvadm.t_edi_integra@database_tdp i
     set i.edi_integra_col02 = 'FECHAJAN',
         i.edi_integra_processado = null
   where i.edi_integra_protocolo = 2124562
    and i.edi_integra_col01 = 'DADOS';
   vAuxiliar := sql%rowcount;
  for c_msgp in (select i.edi_integra_col02 Acao,
                        i.edi_integra_col03 Nota,
                        i.edi_integra_col04 CNPJ,
                        i.rowid
                 from tdvadm.t_edi_integra@database_tdp i
                 where i.edi_integra_protocolo = 2124562
                   and i.edi_integra_col03 in (11312,11342/*,6900*/)
                   and i.edi_integra_processado is null
                   and i.edi_integra_col01 = 'DADOS')
  Loop


  If c_msgp.acao in ('FECHAJAN','TODAS') Then
        -- Fecha Janela
        for c_msg in (select distinct 
      --                                an.arm_nota_numero,
      --                                an.glb_cliente_cgccpfremetente,
      --                                an.glb_embalagem_codigo,
      --                                an.arm_nota_sequencia,
                                      an.arm_janelacons_sequencia
                      from tdvadm.t_arm_nota an
                      where an.arm_nota_numero = c_msgp.nota
                        and an.glb_cliente_cgccpfremetente = c_msgp.cnpj
                     )
         Loop
           update tdvadm.t_arm_janelacons j
             set j.arm_janelacons_dtfim =  vDtFechamentoJan
           where j.arm_janelacons_sequencia = c_msg.arm_janelacons_sequencia;
           vAuxiliar := sql%rowcount
         End Loop
         commit;
   
  End If;


  If c_msgp.acao in ('INICIALIZA','TODAS') Then
        -- Inicializa Nota
        for c_msg in (select distinct 
                                      an.arm_nota_numero,
                                      an.glb_cliente_cgccpfremetente,
                                      an.glb_embalagem_codigo,
                                      an.arm_nota_sequencia,
                                      an.arm_janelacons_sequencia
                      from tdvadm.t_arm_nota an
                      where an.arm_nota_numero = c_msgp.nota
                        and an.glb_cliente_cgccpfremetente = c_msgp.cnpj
                    )
         Loop
            update tdvadm.t_arm_nota an
              set an.arm_movimento_datanfentrada = trunc(sysdate),
                  an.arm_nota_dtrecebimento      = trunc(sysdate),
                  an.arm_nota_dtinclusao         = trunc(sysdate),
                  an.arm_nota_dtetiqueta         = null,
                  an.arm_janelacons_sequencia    = null
            where an.arm_nota_sequencia = c_msg.arm_nota_sequencia;
           vAuxiliar := sql%rowcount
         End Loop
         commit;
   End If; 
   
   update tdvadm.t_edi_integra@database_tdp i
     set i.edi_integra_processado = sysdate
   where i.rowid = c_msgp.rowid;
   vAuxiliar := sql%rowcount
   
  End Loop; 


end;
0
2
vAuxiliar
c_msgp.nota
