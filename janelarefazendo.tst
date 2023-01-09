PL/SQL Developer Test script 3.0
50
declare 
  i integer;
  vStatus char(1);
  vMessage varchar2(10000);
  vCarregamento tdvadm.t_arm_carregamento.arm_carregamento_codigo%type;
begin
  vCarregamento := '1485038';
  for c_msg in (select an.arm_nota_numero,
                an.glb_cliente_cgccpfremetente,
                an.arm_nota_serie,
                an.arm_nota_sequencia,
                an.arm_nota_dtetiqueta,
                np.arm_notapesagem_dtimprimiu,
                np.arm_notapesagem_status,
                an.arm_janelacons_sequencia,
                jc.arm_janelacons_dtinicio,
                jc.arm_janelacons_dtfim,
                jc.arm_janelacons_qtdenf 
         from tdvadm.t_arm_nota an,
              tdvadm.t_arm_janelacons jc,
              tdvadm.t_arm_notapesagem np
         where (an.arm_embalagem_numero,
                an.arm_embalagem_flag,
                an.arm_embalagem_sequencia) in (select cd.arm_embalagem_numero,
                                                       cd.arm_embalagem_flag,
                                                       cd.arm_embalagem_sequencia
                                                from tdvadm.t_arm_carregamentodet cd
                                                where cd.arm_carregamento_codigo = vCarregamento)
           and an.con_conhecimento_codigo is null
           and an.arm_janelacons_sequencia = jc.arm_janelacons_sequencia (+)
           and an.arm_nota_sequencia = np.arm_nota_sequencia (+))
  Loop
  
       If c_msg.arm_janelacons_sequencia is not null Then
          update tdvadm.t_arm_nota an
            set an.arm_janelacons_sequencia = null
          where an.arm_nota_sequencia = c_msg.arm_nota_sequencia;
       End If;  
  
       tdvadm.pkg_slf_contrato.SP_SETCRIAJANELA(c_msg.arm_nota_numero,
                                                c_msg.glb_cliente_cgccpfremetente,
                                                c_msg.arm_nota_serie,
                                                c_msg.arm_nota_sequencia,
                                                'N', -- Origem da Nota
                                                vStatus,
                                                vMessage);
                                                
       
  End Loop;
end;
0
0
