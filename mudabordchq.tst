PL/SQL Developer Test script 3.0
142
-- Created on 07/05/2020 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  tpChequeBanco        tdvadm.t_cpg_chequebanco%rowtype;
  tpChequeBancoParcela tdvadm.t_cpg_chequebancoparcela%rowtype;
  vRefProcessamento    char(6) := '202109';
  vDataProcessamento date := trunc(sysdate);
  vErro varchar2(2000);
  vDocumento varchar2(100);
begin
  -- Test statements here
  
   for c_msg in (select c.CPG_BORDEROS_NUMERO,
                        c.cpg_bordero_nominal
                 from tdvadm.t_cpg_borderos c
                 where substr(c.cpg_bordero_nominal,1,3) like '#CH%' 
                   and nvl(c.cpg_bordero_status,'A') <> 'C'
                   and 0 < (select count(*)
                            from tdvadm.t_cpg_borderosparc bp
                            where bp.cpg_borderos_numero = c.cpg_borderos_numero) 
                   and to_char(c.cpg_borderos_data,'YYYYMM') = vRefProcessamento
                   )
   loop
      for c_msgB in (select c.glb_banco_numero ,
                            c.glb_agencia_numero,
                            c.glb_contas_numero cpg_chequebanco_conta,
                            'BANCO ' || b.glb_banco_nome cpg_chequebanco_nominal ,
                            c.cpg_bordero_nominal,
                            c.cpg_borderos_valor cpg_chequebanco_valor ,
                            c.usu_usuario_codigo,
                            null cpg_chequebanco_dtcancel,         
                            c.cpg_borderos_data cpg_chequebanco_dtemissao,
                            null cpg_chequebanco_obs,
                            c.cpg_borderos_data cpg_chequebanco_dtimpressao,
                            substr(c.cpg_bordero_nominal,4) cpg_chequebanco_numero ,
                            c.cpg_borderos_data cpg_chequebanco_pagamento,
                            null cpg_chequebanco_dtconc
                     from tdvadm.t_cpg_borderos c,
                          tdvadm.t_glb_banco b
                     where c.glb_banco_numero = b.glb_banco_numero
                       and c.cpg_borderos_numero = c_msg.CPG_BORDEROS_NUMERO)
      Loop
         tpChequeBanco.Glb_Banco_Numero            := c_msgb.Glb_Banco_Numero;
         tpChequeBanco.Glb_Agencia_Numero          := c_msgb.Glb_Agencia_Numero; 
         tpChequeBanco.Cpg_Chequebanco_Conta       := c_msgb.Cpg_Chequebanco_Conta; 
         tpChequeBanco.Cpg_Chequebanco_Nominal     := c_msgb.Cpg_Chequebanco_Nominal; 
         tpChequeBanco.Cpg_Chequebanco_Valor       := c_msgb.Cpg_Chequebanco_Valor; 
         tpChequeBanco.Usu_Usuario_Codigo          := c_msgb.Usu_Usuario_Codigo;
         tpChequeBanco.Cpg_Chequebanco_Dtcancel    := c_msgb.Cpg_Chequebanco_Dtcancel; 
         tpChequeBanco.Cpg_Chequebanco_Dtemissao   := c_msgb.Cpg_Chequebanco_Dtemissao; 
         tpChequeBanco.Cpg_Chequebanco_Obs         := c_msgb.Cpg_Chequebanco_Obs; 
         tpChequeBanco.Cpg_Chequebanco_Dtimpressao := c_msgb.Cpg_Chequebanco_Dtimpressao; 
         tpChequeBanco.Cpg_Chequebanco_Numero      := c_msgb.Cpg_Chequebanco_Numero; 
         tpChequeBanco.Cpg_Chequebanco_Pagamento   := c_msgb.Cpg_Chequebanco_Pagamento; 
         tpChequeBanco.Cpg_Chequebanco_Dtconc      := c_msgb.Cpg_Chequebanco_Dtconc; 
         tpChequeBanco.Cpg_Chequebanco_Obs := 'Pagto: ';
         vDocumento := c_msgb.cpg_bordero_nominal;
         Begin
         insert into tdvadm.t_cpg_chequebanco values tpChequeBanco;
         exception
            When OTHERS Then
               dbms_output.put_line(trim(c_msg.cpg_bordero_nominal) || chr(10) ||  
                                         'Banco   - ' || tpChequeBanco.GLB_BANCO_NUMERO || chr(10) ||  
                                         'Agencia - ' || tpChequeBanco.GLB_AGENCIA_NUMERO || chr(10) || 
                                         'Conta   - ' || tpChequeBanco.CPG_CHEQUEBANCO_CONTA || chr(10) || 
                                         'Cheque  - ' || tpChequeBanco.CPG_CHEQUEBANCO_NUMERO || chr(10) || 
                                         'Erro    - ' || sqlerrm);
            End;
         for c_msgbp in (select c.glb_banco_numero ,
                                c.glb_agencia_numero,
                                c.glb_contas_numero cpg_chequebanco_conta,
                                substr(c.cpg_bordero_nominal,4) cpg_chequebanco_numero ,
                                bp.cpg_titulos_numtit,
                                bp.glb_fornecedor_cgccpf,
                                bp.glb_rota_codigoempresa,
                                bp.cpg_titparcelas_parcela,
                                bp.cpg_borderosparc_valortitulo cpg_chequebancotitulo_valor,
                                bp.gpg_tituloevento_seq
                         from tdvadm.t_cpg_borderosparc bp,
                              tdvadm.t_cpg_borderos c
                         where bp.cpg_borderos_numero = c.cpg_borderos_numero
                           and c.cpg_borderos_numero = c_msg.CPG_BORDEROS_NUMERO)
         Loop
            tpChequeBancoParcela.Glb_Banco_Numero           := c_msgbp.Glb_Banco_Numero;
            tpChequeBancoParcela.Glb_Agencia_Numero          := c_msgbp.Glb_Agencia_Numero;
            tpChequeBancoParcela.Cpg_Chequebanco_Conta       := c_msgbp.Cpg_Chequebanco_Conta;
            tpChequeBancoParcela.Cpg_Chequebanco_Numero      := c_msgbp.Cpg_Chequebanco_Numero;
            tpChequeBancoParcela.Cpg_Titulos_Numtit          := c_msgbp.Cpg_Titulos_Numtit;
            tpChequeBancoParcela.Glb_Fornecedor_Cgccpf       := c_msgbp.Glb_Fornecedor_Cgccpf;
            tpChequeBancoParcela.Glb_Rota_Codigoempresa      := c_msgbp.Glb_Rota_Codigoempresa;
            tpChequeBancoParcela.Cpg_Titparcelas_Parcela     := c_msgbp.Cpg_Titparcelas_Parcela;
            tpChequeBancoParcela.Cpg_Chequebancotitulo_Valor := c_msgbp.Cpg_Chequebancotitulo_Valor;
            tpChequeBancoParcela.Gpg_Tituloevento_Seq        := c_msgbp.Gpg_Tituloevento_Seq;
            insert into tdvadm.t_cpg_chequebancoparcela values tpChequeBancoParcela;
            tpChequeBanco.Cpg_Chequebanco_Obs := substr(tpChequeBanco.Cpg_Chequebanco_Obs || '[T:' || trim(tpChequeBancoParcela.Cpg_Titulos_Numtit) || ' ' ||
                                                                                              'P' || trim(tpChequeBancoParcela.Cpg_Titparcelas_Parcela) || ' ' || 
                                                                                              'V:' || trim(tdvadm.f_mascara_valor(tpChequeBancoParcela.Cpg_Chequebancotitulo_Valor,20,2)) || '] ',1,300);  
            update tdvadm.T_CPG_TITULOEVENTO te
              set te.glb_TPDOC_CODIGO = 'CHQ'
            where CPG_TITULOS_NUMTIT      = tpChequeBancoParcela.Cpg_Titulos_Numtit
              and CPG_TITPARCELAS_PARCELA = tpChequeBancoParcela.Cpg_Titparcelas_Parcela
              and GLB_ROTA_CODIGOEMPRESA  = tpChequeBancoParcela.Glb_Rota_Codigoempresa
              and GLB_FORNECEDOR_CGCCPF   = tpChequeBancoParcela.Glb_Fornecedor_Cgccpf 
              and GPG_TITULOEVENTO_SEQ    = tpChequeBancoParcela.Gpg_Tituloevento_Seq;
         End Loop;
         
         update tdvadm.t_cpg_borderos b
           set b.cpg_bordero_status = 'C'
         where b.cpg_borderos_numero = c_msg.cpg_borderos_numero;
         
         update tdvadm.t_cpg_chequebanco cb
           set cb.cpg_chequebanco_obs = tpChequeBanco.Cpg_Chequebanco_Obs
         where cb.GLB_BANCO_NUMERO = tpChequeBanco.Glb_Banco_Numero
           and cb.GLB_AGENCIA_NUMERO = tpChequeBanco.Glb_Agencia_Numero
           and cb.CPG_CHEQUEBANCO_CONTA = tpChequeBanco.Cpg_Chequebanco_Conta
           and cb.CPG_CHEQUEBANCO_NUMERO = tpChequeBanco.Cpg_Chequebanco_Numero;
      End Loop;
   End Loop;
      
    vErro := 'DELETANDO...';  
    delete tdvadm.t_cpg_tituloevento te
    where te.cpg_tituloevento_nrodoc in (select CPG_BORDEROS_NUMERO
                                         from tdvadm.t_cpg_borderos c
                                         where substr(c.cpg_bordero_nominal,1,3) like '#CH%' 
                                           and nvl(c.cpg_bordero_status,'A') = 'C')
      and te.glb_tpdoc_codigo = 'CHQ'
      and to_char(te.gpg_tituloevento_dtevento,'YYYYMM') = vRefProcessamento 
      and trunc(te.cpg_tituloevento_datagrv) = vDataProcessamento;
      
   delete tdvadm.t_cpg_borderosparc b
   where b.cpg_borderos_numero in (select CPG_BORDEROS_NUMERO
                                   from tdvadm.t_cpg_borderos c
                                   where substr(c.cpg_bordero_nominal,1,3) like '#CH%' 
                                     and nvl(c.cpg_bordero_status,'A') = 'C');      
   --commit;    
exception
  When OTHERS Then
    rollback;
    vErro := 'Documento ' || vDocumento;
    vErro := vErro || chr(10) || sqlerrm;
    raise_application_error(-20001,verro);
end;
0
1
tpChequeBanco.Cpg_Chequebanco_Obs
