PL/SQL Developer Test script 3.0
82
-- Created on 27/06/2017 by DESENV 


declare 
  -- Local variables here
  i  integer;
  d0 date;
  d1 varchar2(50);
  d2 varchar2(50);
  d3 varchar2(50);
  KM varchar2(50);
begin

  delete tdvadm.t_glb_sql s
  where s.glb_sql_observacao like 'TESTE%';   
   i := 0 ;
  -- Test statements here
  for c_msg in (select n.arm_nota_numero,
                       n.glb_cliente_cgccpfremetente,
                       n.arm_nota_serie,
                       co.arm_coleta_entcoleta ennull,
                       co.arm_coleta_tpcoleta tipo,
                       tc.fcf_tpcarga_descricao carga,
                       co.arm_coleta_ncompra coleta,
                       co.arm_coleta_ciclo ciclo,
                       co.arm_coleta_dtsolicitacao dtsol,
                       co.arm_coleta_hrsolicitacao hrsol,
                       co.arm_coleta_dtprogramacao dtprog,
                       co.arm_coleta_hrprogramacao hrprog,
                       co.arm_coleta_dtautoriza autorizacao,
                       co.arm_coleta_dtfechamento defecha,
                       co.arm_coleta_dtclienteinformado dtinf,
                --       co.arm_coleta_pagadorfrete tppgto,
                --       co.arm_coletaorigem_cod origem,
                --       o.arm_coletaorigem_desc descorigem,
                       decode(co.arm_coleta_pagadorfrete,'R',co.glb_cliente_cgccpfcodigocoleta,
                                                         'D',co.glb_cliente_cgccpfcodigoentreg,
                                                         co.arm_coleta_cnpjpagadorferete) saccalc,
                       (select cl.glb_grupoeconomico_codigo ||'-'||gp.glb_grupoeconomico_nome
                        from tdvadm.t_glb_cliente cl,
                             tdvadm.t_glb_grupoeconomico gp
                        where 0 = 0
                          and cl.glb_grupoeconomico_codigo = gp.glb_grupoeconomico_codigo
                          and cl.glb_cliente_cgccpfcodigo =  decode(co.arm_coleta_pagadorfrete,'R',co.glb_cliente_cgccpfcodigocoleta,
                                                                                               'D',co.glb_cliente_cgccpfcodigoentreg,
                                                                                               co.arm_coleta_cnpjpagadorferete)) Grupo
                --      ,tdvadm.FN_CalculaPrazoColeta2(co.arm_coleta_ncompra,co.arm_coleta_ciclo,co.usu_usuario_codigo_cad,'K') KM
                --      ,tdvadm.FN_CalculaPrazoColeta2(co.arm_coleta_ncompra,co.arm_coleta_ciclo,co.usu_usuario_codigo_cad,'C') COLETAR
                --      ,tdvadm.FN_CalculaPrazoColeta2(co.arm_coleta_ncompra,co.arm_coleta_ciclo,co.usu_usuario_codigo_cad,'E') EMBARCAR
                from tdvadm.t_arm_coleta co,
                     tdvadm.t_arm_coletaorigem o,
                     tdvadm.t_fcf_tpcarga tc,
                     tdvadm.t_arm_nota n
                where co.arm_coleta_dtsolicitacao >= '01/06/2017'
                  and co.arm_coletaorigem_cod = o.arm_coletaorigem_cod
                  and co.arm_coleta_ncompra = n.arm_coleta_ncompra
                  and co.arm_coleta_ciclo = n.arm_coleta_ciclo
                  and co.fcf_tpcarga_codigo = tc.fcf_tpcarga_codigo)
    Loop
        
       i := i + 1;
       
           insert into tdvadm.t_glb_sql s values (null,sysdate,lpad(i,10,'0'),'TESTE' || '-' ||C_MSG.COLETA || '-' || C_MSG.CICLO );
           commit;
           d0 := to_date(to_date(substr(tdvadm.pkg_arm_gercoleta.FN_CalculaPrazoColeta2(C_MSG.COLETA,C_MSG.CICLO,'jsantos','C'),1,10),'dd/mm/yyyy'),'yyyy/mm/dd');
           KM := tdvadm.pkg_arm_gercoleta.FN_CalculaPrazoColeta2(C_MSG.COLETA,C_MSG.CICLO,'jsantos','K');
           d1 := tdvadm.pkg_arm_gercoleta.FN_CalculaPrazoColeta2(C_MSG.COLETA,C_MSG.CICLO,'jsantos','C');
           d2 := tdvadm.pkg_arm_gercoleta.FN_CalculaPrazoColeta2(C_MSG.COLETA,C_MSG.CICLO,'jsantos','E');
--           insert into tdvadm.t_glb_sql s values (null,sysdate,lpad(i,10,'0'),'TESTE' || '-' ||C_MSG.arm_nota_numero || '-' || C_MSG.glb_cliente_cgccpfremetente || '-' || C_MSG.arm_nota_serie );
--           commit;
--           d3 := tdvadm.pkg_fifo_recebimentotst.fn_get_dataentrega(C_MSG.arm_nota_numero,C_MSG.glb_cliente_cgccpfremetente,C_MSG.arm_nota_serie);

--       to_char(TDVADM.PKG_ARM_GERCOLETA.FN_CALCULAPRAZOCOLETA(c_msg.coleta,c_msg.ciclo, 'jsantos'),'dd/mm/yyyy') Prazo,
--       to_char(TDVADM.PKG_ARM_GERCOLETA.FN_CALCULAPRAZOAGENDAMENTO(c_msg.coleta,c_msg.ciclo, 'jsantos'),'dd/mm/yyyy') PrazoAgendamento,


    end Loop;                  
  
  
  
    
end;
0
0
