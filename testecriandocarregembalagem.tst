PL/SQL Developer Test script 3.0
95
declare 
  vArm_armazem_codigo          tdvadm.t_arm_armazem.arm_armazem_codigo%type;
  vUsu_usuario_codigo          tdvadm.t_usu_usuario.usu_usuario_codigo%type;
  vArm_carregamento_codigo     tdvadm.t_arm_carregamento.arm_carregamento_codigo%type;
  vArm_carregamento_flagvirtua char(1);
  vMessage                     clob;
  vMessage2                    clob;
  vStatus                      char(1);
begin

   vArm_armazem_codigo            := '19';
   vUsu_usuario_codigo            := 'jsantos';
   vArm_carregamento_codigo       := null;
   vArm_carregamento_flagvirtua   := 'S';
   vMessage                       := empty_clob;
   vMessage2                      := empty_clob;
   vStatus                        := 'N';

  
  If ( pkg_fifo_carregamento.FN_Get_Carregamento(pArm_armazem_codigo          => vArm_armazem_codigo         ,
                                                 pUsu_usuario_codigo          => vUsu_usuario_codigo         ,
                                                 pArm_carregamento_codigo     => vArm_carregamento_codigo    ,
                                                 pMessage                     => vMessage,
                                                 pArm_carregamento_flagvirtua => vArm_carregamento_flagvirtua)) Then

     for c_msg in (select e.arm_embalagem_numero,
                          e.arm_embalagem_flag,
                          e.arm_embalagem_sequencia,
                          cd.arm_carregamento_codigo
                   from tdvadm.t_arm_embalagem e,
                        tdvadm.t_arm_carregamentodet cd
                   where e.arm_embalagem_numero    = cd.arm_embalagem_numero (+)
                     and e.arm_embalagem_flag      = cd.arm_embalagem_flag (+)
                     and e.arm_embalagem_sequencia = cd.arm_embalagem_sequencia (+)
                     and e.arm_embalagem_numero in ('6394264',
                                                    '6394258',
                                                    '6394278',
                                                    '6394252',
                                                    '6394270',
                                                    '6394255',
                                                    '6394239',
                                                    '6394273',
                                                    '6394245',
                                                    '6394242',
                                                    '6394233',
                                                    '6394237',
                                                    '6394229',
                                                    '6394225',
                                                    '6394219',
                                                    '6394282',
                                                    '6394212',
                                                    '6394216'))
     Loop
     
        If c_msg.arm_carregamento_codigo is null Then
           tdvadm.pkg_fifo_carregamento.sp_VinculaEmbCarreg(pCodCarreg => vArm_carregamento_codigo,
                                                            pNumEmb    => c_msg.arm_embalagem_numero,
                                                            pFlgEmb    => c_msg.arm_embalagem_flag,
                                                            pSeqEmb    => c_msg.arm_embalagem_sequencia,
                                                            pStatus    => vstatus,
                                                            pMessage   => vMessage2);   
        Else
           vStatus := 'E';
           vMessage2 := 'Embalagem ' || c_msg.arm_embalagem_numero || ' Com carregamento '|| c_msg.arm_carregamento_codigo;
        End If;

        vMessage := vMessage || vMessage2 || chr(10);


/*
        tdvadm.pkg_fifo_carregamento.SP_VinculaEmbCarregamento(pXmlIn   => ,
                                                               pStatus  => ,
                                                               pMessage => )

*/
          
     End Loop;
     If vStatus =  'E' Then
        rollback;
     Else
        commit;
     End If;

  End If;
  :RetStatus       := vStatus;
  :RetMessage      := vMessage;
  :RetCarregamento := vArm_carregamento_codigo;
  
  
  
  
  
  
  
end;
3
RetStatus
1
N
5
RetMessage
1
<CLOB>
4208
RetCarregamento
1
3512581
5
3
vArm_carregamento_codigo
c_msg.arm_carregamento_codigo
