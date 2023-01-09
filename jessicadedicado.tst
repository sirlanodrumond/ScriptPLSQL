PL/SQL Developer Test script 3.0
218
-- Created on 08/01/2021 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  i integer;
  vAchou integer;
  tpdedicado tdvadm.t_car_dedicado%rowtype;
  pCorpoEmail Clob;
  vCursor PKG_EDI_PLANILHA.T_CURSOR;
  vLinha pkg_glb_SqlCursor.tpString1024;
  pEmail1 rmadm.t_glb_benasserec.glb_benasserec_origem%type;
  pEmail2 rmadm.t_glb_benasserec.glb_benasserec_origem%type;
  pTitulo varchar2(200);
  pAssunto rmadm.t_glb_benasserec.glb_benasserec_assunto%type;
begin
  -- Test statements here
  pCorpoEmail := empty_clob;
  pEmail2 := 'sirlano.drumond@dellavolpe.com.br';
  for c_msg in (select i.edi_integra_protocolo,
                       i.edi_integra_critica,
                       br.Glb_Benasserec_Assunto,
                       i.edi_integra_processado,
                       i.edi_integra_col01 acao,
                       i.edi_integra_col02 Rota, 
                       rpad(i.edi_integra_col03,7) placa, 
                       rpad(lpad(i.edi_integra_col04,11,'0'),20) proprietario,
                       rpad(lpad(trim(i.edi_integra_col05),11,'0'),20) motorista,
                       i.edi_integra_col06 validade,
                       br.glb_benasserec_origem origem,
                       i.rowid
                from rmadm.t_glb_benasserec br,
                     tdvadm.t_edi_integra i
                where trunc(br.glb_benasserec_gravacao) >= trunc(sysdate - 4)
                  and br.glb_benasserec_status = 'OK'
                  and i.edi_integra_processado is null
                  and trim(tdvadm.fn_querystring(upper(br.Glb_Benasserec_Assunto),'MSG','=',';')) = 'DEDICADO'
                  and br.glb_benasserec_chave = i.edi_integra_protocolo
                order by i.edi_integra_sequencia)
  Loop
     If c_msg.acao = 'I' Then
        select count(*)
          into vAchou
         from tdvadm.t_car_veiculo v,
              tdvadm.t_car_carreteiro c
         where v.car_veiculo_placa = c.car_veiculo_placa
           and v.car_veiculo_saque = c.car_veiculo_saque
           and v.car_veiculo_placa = c_msg.placa
           and v.car_proprietario_cgccpfcodigo = c_msg.proprietario
           and c.car_carreteiro_cpfcodigo = c_msg.motorista;
        If vAchou = 0 Then
           update tdvadm.t_edi_integra i
             set i.edi_integra_critica = 'VEICULO / PROPRIETARIO / MOTORISTA nao CADASTRADO',
                 i.edi_integra_processado = sysdate
           where i.rowid = c_msg.rowid;  
        End If;
     End If;

     Select count(*)
       into vAchou
     From tdvadm.t_car_dedicado d 
     where d.car_veiculo_placa = c_msg.placa
       and d.car_proprietario_cpfcodigo = c_msg.proprietario
       and d.car_carreteiro_cpfcodigo = c_msg.motorista;


     If ( vAchou > 0 ) and ( c_msg.acao = 'I' ) Then
        update tdvadm.t_edi_integra i
          set i.edi_integra_critica = 'VEICULO / PROPRIETARIO / MOTORISTA já CADASTRADO',
              i.edi_integra_processado = sysdate
        where i.rowid = c_msg.rowid;  
     ElsIf ( vAchou > 0 ) and ( c_msg.acao = 'S' ) Then
        Update tdvadm.t_car_dedicado d
          set d.car_dedicado_ativo = 'N',
              d.car_dedicado_validade = trunc(sysdate)
        where d.car_veiculo_placa = c_msg.placa
          and d.car_proprietario_cpfcodigo = c_msg.proprietario
          and d.car_carreteiro_cpfcodigo = c_msg.motorista;
        update tdvadm.t_edi_integra i
          set i.edi_integra_critica = 'Atualizado Com Sucesso',
              i.edi_integra_processado = sysdate
        where i.rowid = c_msg.rowid;  
     ElsIf ( vAchou = 0 ) and ( c_msg.acao = 'I' ) Then
        tpdedicado.glb_rota_codigo            := c_msg.rota;
        tpdedicado.car_carreteiro_cpfcodigo   := c_msg.motorista;
        tpdedicado.car_veiculo_placa          := c_msg.placa;
        tpdedicado.car_proprietario_cpfcodigo := c_msg.proprietario;
        tpdedicado.car_dedicado_ativo         := 'S';
        tpdedicado.car_dedicado_validade      := c_msg.validade;
        tpdedicado.car_dedicado_dtcadastro    := sysdate;
        tpdedicado.usu_usuario_codigocad      := 'aut-e';
        tpdedicado.car_dedicado_dtrevld       := sysdate;
        tpdedicado.usu_usuario_codigorevld    := null;
        tpdedicado.car_dedicao_qtdevfultano   := null;
        tpdedicado.car_dedicado_dtatuvfultano := null;
        tpdedicado.car_dedicado_observacao    := 'Aut-e Protocolo ' || c_msg.edi_integra_protocolo;
        insert into tdvadm.t_car_dedicado values tpdedicado;
        update tdvadm.t_edi_integra i
          set i.edi_integra_critica = 'Incluido Com Sucesso',
              i.edi_integra_processado = sysdate
        where i.rowid = c_msg.rowid;  
     End If;
     pEmail1 := c_msg.origem;
     pTitulo := 'PROCESSAMENTO DEDICADO PROTOCOLO - ' || C_MSG.edi_integra_protocolo;
     pAssunto := c_msg.Glb_Benasserec_Assunto;
  End Loop;


  
   If pTitulo is not null Then
          open vCursor FOR select i.edi_integra_protocolo,
                                  i.edi_integra_critica,
                                  i.edi_integra_processado,
                                  i.edi_integra_col01 acao,
                                  i.edi_integra_col02 Rota, 
                                  rpad(i.edi_integra_col03,7) placa, 
                                  rpad(lpad(i.edi_integra_col04,11,'0'),20) proprietario,
                                  rpad(lpad(trim(i.edi_integra_col05),11,'0'),20) motorista,
                                  i.edi_integra_col06 validade
                           from rmadm.t_glb_benasserec br,
                                tdvadm.t_edi_integra i
                           where trunc(br.glb_benasserec_gravacao) >= trunc(sysdate - 1)
                             and br.glb_benasserec_assunto = 'MSG=DEDICADO'
                             and br.glb_benasserec_chave = i.edi_integra_protocolo
                             and trunc(i.edi_integra_processado) = trunc(sysdate)
                           order by i.edi_integra_protocolo,i.edi_integra_sequencia ;
      
      pkg_glb_SqlCursor.TiposComuns.Formato := 'H';
      pkg_glb_SqlCursor.TipoHederHTML.Alinhamento := 'Left';
      pkg_glb_SqlCursor.sp_Get_Cursor(vCursor,vLinha);
      
      
      for i in 1 .. vLinha.count loop
         if pkg_glb_SqlCursor.TiposComuns.Formato = 'H' then
            pCorpoEmail := pCorpoEmail || vLinha(i);
         Else
            pCorpoEmail := pCorpoEmail || vLinha(i) || chr(10);
         End if;
      End loop;
      
      
      wservice.pkg_glb_email.SP_ENVIAEMAIL(pTitulo,
                                           pCorpoEmail,
                                           'aut-e@dellavolpe.com.br',
                                           pEmail1,
                                           pEmail2);

   End If;

     If pAssunto is null Then
        select max(br.glb_benasserec_chave)
          into vAchou
        from rmadm.t_glb_benasserec br
        where br.glb_benasserec_gravacao >= sysdate - 4
          and br.glb_benasserec_status = 'OK'
          and br.glb_benasserec_assunto like 'MSG=DEDICADO%'
          and trim(tdvadm.fn_querystring(upper(br.Glb_Benasserec_Assunto),'LISTAGEM','=',';')) = 'SIM';
          
          If nvl(vAchou,0) <> 0 Then
             select br.glb_benasserec_origem,
                    br.glb_benasserec_assunto
               into pEmail1,
                    pAssunto
             from rmadm.t_glb_benasserec br
             where br.glb_benasserec_chave = vAchou;
          End If;

     Else
       If trim(tdvadm.fn_querystring(upper(pAssunto),'LISTAGEM','=',';')) = 'SIM' Then
          vAchou := 1;
       End If;
     End If;
     
       
      
      If nvl(vAchou,0) <> 0 Then
          pCorpoEmail := empty_clob;
          pTitulo := 'LISTA COMPLETA DOS DEDICADOS';

              open vCursor FOR select d.glb_rota_codigo rota,
                                      d.glb_rota_descricao descricao,
                                      d.glb_estado_codigo UF,
                                      d.car_carreteiro_cpfcodigo cpfmot,
                                      d.motorista motorista,
                                      d.placa,
                                      d.sqplaca,
                                      d.propritarioplacasq,
                                      d.car_dedicado_dtcadastro cadastro,
                                      d.car_dedicado_validade validade,
                                      d.car_dedicado_ativo ativo,
                                      d.car_dedicado_observacao obs,
                                      d.qtdevig12M
                               from tdvadm.v_car_dedicado d
                               order by d.car_dedicado_dtcadastro desc,d.placa;
          
          pkg_glb_SqlCursor.TiposComuns.Formato := 'H';
          pkg_glb_SqlCursor.TipoHederHTML.Alinhamento := 'Left';
          pkg_glb_SqlCursor.sp_Get_Cursor(vCursor,vLinha);
          
          
          for i in 1 .. vLinha.count loop
             if pkg_glb_SqlCursor.TiposComuns.Formato = 'H' then
                pCorpoEmail := pCorpoEmail || vLinha(i);
             Else
                pCorpoEmail := pCorpoEmail || vLinha(i) || chr(10);
             End if;
          End loop;
          
          
          wservice.pkg_glb_email.SP_ENVIAEMAIL(pTitulo,
                                               pCorpoEmail,
                                               'aut-e@dellavolpe.com.br',
                                               pEmail1,
                                               pEmail2);
         update rmadm.t_glb_benasserec br
           set br.glb_benasserec_status = 'Ok'
         where br.glb_benasserec_chave = vAchou;
     End If;
   commit;
end;
0
5
vAchou
c_msg.acao
c_msg.placa
vLinha.count
pCorpoEmail
