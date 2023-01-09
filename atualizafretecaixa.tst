PL/SQL Developer Test script 3.0
58
-- Created on 19/08/2022 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  vValeFrete char(12);
begin
  -- Test statements here
  for c_msg in (select DISTINCT VC.CON_CONHECIMENTO_CODIGO,
                       vc.con_conhecimento_serie,
                       VC.GLB_ROTA_CODIGO,
                       VC.CON_VALEFRETE_SAQUE
                from tdvadm.t_con_calcvalefrete vc
                where 0 = 0
                  and vc.con_calcvalefrete_dtpgto >= '01/08/2022'
                  and vc.usu_usuario_codigopgto is not null
                  and vc.cax_movimento_sequencia is not null
                  and 0 = (select count(*)
                           from tdvadm.t_cax_movimento m
                           where m.glb_rota_codigo = vc.glb_rota_codigocx
                             and m.cax_boletim_data = vc.cax_boletim_data
                             and m.cax_movimento_sequencia = vc.cax_movimento_sequencia)
                order by 2,1)
   Loop
      
      vValeFrete := c_msg.con_conhecimento_codigo || c_msg.con_conhecimento_serie || c_msg.glb_rota_codigo || c_msg.con_valefrete_saque;    
      update tdvadm.t_con_calcvalefrete vf
        set vf.cax_boletim_data = null,
            vf.glb_rota_codigocx = null,
            vf.cax_movimento_sequencia = null
      where vf.con_calcvalefretetp_codigo in ('01', -- Adiantamento
                                              '02', -- Pedagio
                                              '06', -- 4 - Tarifa Saque
                                              '07', -- 4 - Tarifa Transferencia 
                                              '20') -- Saldo
        and ( ( vf.usu_usuario_codigoliberou is not null and vf.usu_usuario_codigopgto is not null ) or ( vf.con_calcvalefretetp_codigo = '02' ) )
        and vf.con_conhecimento_codigo || 
            vf.con_conhecimento_serie  ||
            vf.glb_rota_codigo         ||
            vf.con_valefrete_saque      = vValeFrete;
      
      
      -- Limpa a chave da Vale de Frete Caso de Erro de Child Record Found na hora de realizar o Delete da t_cax_movimento
      update tdvadm.t_con_valefrete e
         set  E.CAX_BOLETIM_DATA = null,  E.CAX_MOVIMENTO_SEQUENCIA = null
      where e.con_conhecimento_codigo ||
            e.con_conhecimento_serie  ||
            e.glb_rota_codigo         ||
            e.con_valefrete_saque      = vValeFrete;
      
      
      --  limpa os registras da Caixa movimento
      delete tdvadm.t_cax_movimento m
      where m.Cax_Movimento_Documentoref = vValeFrete;
      commit;
   
      
   End Loop;

end;
0
0
