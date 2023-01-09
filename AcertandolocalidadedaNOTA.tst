PL/SQL Developer Test script 3.0
66
-- Created on 26/04/2018 by DESENV 
declare 
  -- Local variables here
  i integer;
  vLocalidade tdvadm.t_glb_localidade.glb_localidade_codigo%type;
begin
  -- Test statements here
   for c_msg in (select ori.arm_coletaorigem_desc origem,
                        an.arm_armazem_codigo armazem,
                        an.arm_nota_dtinclusao datainc,
                        co.arm_coleta_entcoleta ec,
                        an.arm_nota_numero nota,
                        an.glb_cliente_cgccpfremetente rementente,
                        an.glb_tpcliend_codremetente tpendrem,
                        an.glb_localidade_codigoorigem locorigemnota,
                        ce.glb_localidade_codigo locaorigemCli,
                        an.glb_cliente_cgccpfdestinatario destinatario,
                        an.glb_tpcliend_coddestinatario tpenddes,
                        cd.glb_cliente_cgccpfdestinatario destcarreg,
                        cd.glb_tpcliend_coddestinatario tpenddescarreg,
                        eb.glb_cliente_cgccpfdestinatario destemb,
                        eb.glb_tpcliend_coddestinatario tpenddesemb,
                        an.con_conhecimento_codigo cte,
                        an.con_conhecimento_serie serie,
                        an.glb_rota_codigo rota,
                        an.arm_nota_sequencia sequencia
                 from tdvadm.t_arm_nota an,
                      tdvadm.t_arm_embalagem eb,
                      tdvadm.t_arm_carregamentodet cd, 
                      tdvadm.t_glb_cliend ce, 
                      tdvadm.t_arm_coleta co,
                      tdvadm.t_arm_coletaorigem ori
                  where an.arm_embalagem_numero = eb.arm_embalagem_numero
                   and an.arm_embalagem_flag = eb.arm_embalagem_flag
                   and an.arm_embalagem_sequencia = eb.arm_embalagem_sequencia
                   and an.arm_embalagem_numero = cd.arm_embalagem_numero
                   and an.arm_embalagem_flag = cd.arm_embalagem_flag
                   and an.arm_embalagem_sequencia = cd.arm_embalagem_sequencia
                   and rpad(an.glb_cliente_cgccpfremetente,20) = ce.glb_cliente_cgccpfcodigo
                   and an.glb_tpcliend_codremetente = ce.glb_tpcliend_codigo
                   and an.arm_coleta_ncompra = co.arm_coleta_ncompra
                   and an.arm_coleta_ciclo = co.arm_coleta_ciclo
                   and co.arm_coletaorigem_cod = ori.arm_coletaorigem_cod
                 --  and cd.arm_carregamento_codigo =  '1468350'
                   and an.arm_nota_dtinclusao >= '01/04/2018'
                   and an.con_conhecimento_codigo is null
                 --  and cd.arm_carregamento_codigo in (select c.arm_carregamento_codigo from tdvadm.t_con_conhecimento c where c.arm_carregamento_codigopr = '1468350')
                   and trim(an.glb_localidade_codigoorigem) <> trim(decode(co.arm_coleta_entcoleta,'C',ce.glb_localidade_codigo,'E',tdvadm.pkg_fifo_carregctrc.fn_RetLocalidadeArmazem(an.arm_armazem_codigo)))
                )
   Loop
      If c_msg.ec = 'C' Then
         vLocalidade := c_msg.locaorigemcli;
      Else
         vLocalidade := tdvadm.pkg_fifo_carregctrc.fn_RetLocalidadeArmazem(c_msg.armazem);
      End If;
      update tdvadm.t_arm_nota an
        set an.glb_localidade_codigoorigem = vLocalidade
      where an.arm_nota_sequencia = c_msg.sequencia;
   End Loop;
  
   commit;
   
  
  
  
end;
0
0
