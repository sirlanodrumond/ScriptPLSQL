PL/SQL Developer Test script 3.0
65
-- Created on 03/08/2017 by DESENV 
declare 
  -- Local variables here
  i integer;
  vCarga tdvadm.t_fcf_tpcarga.fcf_tpcarga_descricao%type;
begin
  -- Test statements here
   i := 0;
   For c_msg in (select o.*,o.Rowid
                 from tdvadm.t_ctb_movimentoOC o
                 where o.ctb_movimentooc_cargacol is null)
   Loop
      
      Begin             
      select tc.fcf_tpcarga_descricao
         into vCarga
      from tdvadm.t_con_conhecimento c,
           tdvadm.t_arm_coletahist co,
           tdvadm.t_fcf_tpcarga tc
      where c.con_conhecimento_codigo = substr(c_msg.ctb_movimentooc_documento,1,6)
        and c.glb_rota_codigo = substr(c_msg.ctb_movimentooc_documento,8,3)
        and c.con_conhecimento_dtembarque = c_msg.ctb_movimento_dtmovto
        and co.arm_coleta_osuser <> 'oracle'
        and c.arm_coleta_ncompra = co.arm_coleta_ncompra
        and c.arm_coleta_ciclo = co.arm_coleta_ciclo
        and co.arm_coleta_sequencia = (select min(ch.arm_coleta_sequencia)
                                       from tdvadm.t_arm_coletahist ch
                                       where ch.arm_coleta_ncompra = co.arm_coleta_ncompra
                                         and ch.arm_coleta_ciclo = co.arm_coleta_ciclo
                                         and ch.arm_coleta_osuser <> 'oracle'
                                         and ch.fcf_tpcarga_codigo is not null)
        and co.fcf_tpcarga_codigo = tc.fcf_tpcarga_codigo;
       exception
         When NO_DATA_FOUND Then
            Begin
                select tc.fcf_tpcarga_descricao
                   into vCarga
                from tdvadm.t_con_conhecimento c,
                     tdvadm.t_arm_coleta co,
                     tdvadm.t_fcf_tpcarga tc
                where c.con_conhecimento_codigo = substr(c_msg.ctb_movimentooc_documento,1,6)
                  and c.glb_rota_codigo = substr(c_msg.ctb_movimentooc_documento,8,3)
                  and c.con_conhecimento_dtembarque = c_msg.ctb_movimento_dtmovto
                  and c.arm_coleta_ncompra = co.arm_coleta_ncompra
                  and c.arm_coleta_ciclo = co.arm_coleta_ciclo
                  and co.fcf_tpcarga_codigo = tc.fcf_tpcarga_codigo;  
            exception
              When NO_DATA_FOUND Then
                 vCarga := null;
              End;         
         End; 

      update tdvadm.t_ctb_movimentoOC o
         set o.ctb_movimentooc_cargacol = vCarga
      where o.rowid = c_msg.rowid;
       i := i + 1;
       If mod(i,100) = 0 Then
          commit;
       End If;


  End Loop;
  commit;
    
end;
0
2
i
vCarga
