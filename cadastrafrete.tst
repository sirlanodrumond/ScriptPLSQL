PL/SQL Developer Test script 3.0
201
-- Created on 14/04/2021 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  i integer;
  tpFretecar   tdvadm.t_fcf_fretecar%rowtype;
  vMessage     tdvadm.t_edi_integra.edi_integra_critica%type;
  vInsere      char(1) := 'N';
  vHistorico   char(1) := 'N';
  pCorpoEmail  rmadm.t_glb_benasserec.glb_benasserec_corpo%type;
  vCursor      PKG_EDI_PLANILHA.T_CURSOR;
  vLinha       pkg_glb_SqlCursor.tpString1024;
  vVigencia    tdvadm.t_fcf_fretecar.fcf_fretecar_vigencia%type;       
begin
  -- Test statements here
  
  pCorpoEmail := Empty_clob;
  
  for c_msg in (select *
                from rmadm.t_glb_benasserec br
                where br.glb_benasserec_assunto = 'MSG=CADFRETE'
                  and br.glb_benasserec_status = 'OK'
                  and 0 < (select count(*)
                           from tdvadm.t_edi_integra i
                           where i.edi_integra_protocolo = br.glb_benasserec_chave
                             and i.edi_integra_col01 is not null 
                             and i.edi_integra_processado is null)
       )
     Loop     
  
        For c_msg1 in (select p.fcf_fretecar_origem,
                              p.fcf_fretecar_destino,
                              p.fcf_fretecar_tpfrete,
                              p.fcf_tpveiculo_codigo,
                              p.fcf_tpcarga_codigo,
                              p.fcf_fretecar_valor,
                              p.fcf_fretecar_desinencia,
                              p.fcf_fretecar_vigencia,
                              p.usu_usuario_cadastro,
                              p.usu_usuario_alterou,
                              p.fcf_fretecar_dtcadastro,
                              p.fcf_fretecar_dtalteracao,
                              p.fcf_fretecar_pedagio,
                              p.fcf_fretecar_altpedagio,
                              p.usu_usuario_codigo,
                              p.fcf_fretecar_km,
                              trim(tdvadm.fn_busca_codigoibge(p.fcf_fretecar_origem,'IBC')) fcf_fretecar_origemi,
                              trim(tdvadm.fn_busca_codigoibge(p.fcf_fretecar_destino,'IBC')) fcf_fretecar_destinoi,
                              p.fcf_fretecar_rowid,
                              p.fcf_fretecar_pednofrete,
                              p.FCF_FRETECAR_ALTKM,
                              p.fcf_fretecar_passandopor,
                              trim(tdvadm.fn_busca_codigoibge(p.fcf_fretecar_passandopor,'IBC')) fcf_fretecar_passandopori,
                              p.descorigem,
                              p.descdestino,
                              p.passandopor,
                              p.descveiculo,
                              p.integra_rowid
                        from tdvadm.v_fcf_fretecar_protocolo p
                       where p.protocolo = c_msg.glb_benasserec_chave)
        Loop
            
           vInsere     := 'S';
           vHistorico  := 'N';
           
           tpFretecar.Fcf_Fretecar_Origem       := c_msg1.Fcf_Fretecar_Origem;     
           tpFretecar.Fcf_Fretecar_Destino      := c_msg1.Fcf_Fretecar_Destino;     
           tpFretecar.Fcf_Fretecar_Tpfrete      := c_msg1.Fcf_Fretecar_Tpfrete;     
           tpFretecar.Fcf_Tpveiculo_Codigo      := c_msg1.Fcf_Tpveiculo_Codigo;     
           tpFretecar.Fcf_Tpcarga_Codigo        := c_msg1.Fcf_Tpcarga_Codigo;       
           tpFretecar.Fcf_Fretecar_Valor        := c_msg1.Fcf_Fretecar_Valor;       
           tpFretecar.Fcf_Fretecar_Desinencia   := c_msg1.Fcf_Fretecar_Desinencia;  
           tpFretecar.Fcf_Fretecar_Vigencia     := c_msg1.Fcf_Fretecar_Vigencia;    
           tpFretecar.Usu_Usuario_Cadastro      := c_msg1.Usu_Usuario_Cadastro;     
           tpFretecar.Usu_Usuario_Alterou       := c_msg1.Usu_Usuario_Alterou;      
           tpFretecar.Fcf_Fretecar_Dtcadastro   := c_msg1.Fcf_Fretecar_Dtcadastro;  
           tpFretecar.Fcf_Fretecar_Dtalteracao  := c_msg1.Fcf_Fretecar_Dtalteracao; 
           tpFretecar.Fcf_Fretecar_Pedagio      := c_msg1.Fcf_Fretecar_Pedagio;     
           tpFretecar.Fcf_Fretecar_Altpedagio   := c_msg1.Fcf_Fretecar_Altpedagio;  
           tpFretecar.Usu_Usuario_Codigo        := c_msg1.Usu_Usuario_Codigo;       
           tpFretecar.Fcf_Fretecar_Km           := c_msg1.Fcf_Fretecar_Km;          
           tpFretecar.Fcf_Fretecar_Origemi      := c_msg1.Fcf_Fretecar_Origemi;     
           tpFretecar.Fcf_Fretecar_Destinoi     := c_msg1.Fcf_Fretecar_Destinoi;    
           tpFretecar.Fcf_Fretecar_Rowid        := c_msg1.Fcf_Fretecar_Rowid;       
           tpFretecar.Fcf_Fretecar_Pednofrete   := c_msg1.Fcf_Fretecar_Pednofrete;  
           tpFretecar.Fcf_Fretecar_Altkm        := c_msg1.Fcf_Fretecar_Altkm;       
           tpFretecar.Fcf_Fretecar_Passandopor  := c_msg1.Fcf_Fretecar_Passandopor; 
           tpFretecar.Fcf_Fretecar_Passandopori := c_msg1.Fcf_Fretecar_Passandopori;

           If tpFretecar.fcf_fretecar_vigencia > trunc(sysdate) Then
              vMessage :=  vMessage || 'Vigencia FUTURA ' || to_char(tpFretecar.fcf_fretecar_vigencia,'DD/MM/YYYY') || chr(10);
           End If;
           
           If c_msg1.descveiculo is null Then
              vMessage := vMessage || 'Verifique Codugo do Veiculo ' || c_msg1.fcf_tpveiculo_codigo || chr(10);
              vInsere := 'N';
           End If;

           Begin
              select fc.fcf_fretecar_vigencia
                into vVigencia
              from tdvadm.t_fcf_fretecar fc
              where fc.FCF_FRETECAR_ORIGEM      = tpFretecar.FCF_FRETECAR_ORIGEM       
                and fc.FCF_FRETECAR_DESTINO     = tpFretecar.FCF_FRETECAR_DESTINO     
                and fc.FCF_FRETECAR_PASSANDOPOR = tpFretecar.FCF_FRETECAR_PASSANDOPOR 
                and fc.FCF_FRETECAR_TPFRETE     = tpFretecar.FCF_FRETECAR_TPFRETE     
                and fc.FCF_TPVEICULO_CODIGO     = tpFretecar.FCF_TPVEICULO_CODIGO     
                and fc.FCF_TPCARGA_CODIGO       = tpFretecar.FCF_TPCARGA_CODIGO;
           Exception
             When NO_DATA_FOUND Then
                 vVigencia := to_date('01/01/1900','dd/mm/yyyy');
             End;
           
           If vVigencia = to_date('01/01/1900','dd/mm/yyyy') Then
             vMessage := vMessage || 'Frete Cadastrado';
             vInsere := 'S';
           ElsIf vVigencia = tpFretecar.Fcf_Fretecar_Vigencia Then
             vMessage := vMessage || 'Registro ja existe, GERE UMA NOVA VIGENCIA';
             vInsere := 'N';
           ElsIf vVigencia > tpFretecar.Fcf_Fretecar_Vigencia Then
             vMessage := vMessage || 'Existe Vigencia maior que ' || to_char(vVigencia,'DD/MM/YYYY') || ', GERE UMA NOVA VIGENCIA';
             vInsere := 'N';
           ElsIf vVigencia < tpFretecar.Fcf_Fretecar_Vigencia Then
             vMessage := vMessage || 'Frete alterado';
             vHistorico := 'S';
             vInsere := 'S';
           End If;    
           
        
           update tdvadm.t_edi_integra i
             set i.edi_integra_processado = sysdate,
                 i.edi_integra_critica = vMessage
           where i.rowid = c_msg1.integra_rowid
             and i.edi_integra_protocolo = c_msg.glb_benasserec_chave
             and i.edi_integra_col01 is not null;

           vMessage := null; 
           
           If vHistorico = 'S' Then
              delete tdvadm.t_fcf_fretecar fc
              where fc.FCF_FRETECAR_ORIGEM      = tpFretecar.FCF_FRETECAR_ORIGEM       
                and fc.FCF_FRETECAR_DESTINO     = tpFretecar.FCF_FRETECAR_DESTINO     
                and fc.FCF_FRETECAR_PASSANDOPOR = tpFretecar.FCF_FRETECAR_PASSANDOPOR 
                and fc.FCF_FRETECAR_TPFRETE     = tpFretecar.FCF_FRETECAR_TPFRETE     
                and fc.FCF_TPVEICULO_CODIGO     = tpFretecar.FCF_TPVEICULO_CODIGO     
                and fc.FCF_TPCARGA_CODIGO       = tpFretecar.FCF_TPCARGA_CODIGO;
           End If;

           If vInsere = 'S' Then
              insert into tdvadm.t_fcf_fretecar
              values  tpFretecar;
           End If;
        End Loop;

             /******************************************************/
             /**     LOOP PARA MONTAR O E-MAIL DE RETORNO         **/
             /******************************************************/
             begin
               
               open vCursor FOR SELECT p.fcf_fretecar_vigencia Vigencia,
                                       p.descorigem origem,
                                       p.descdestino destino,
                                       p.passandopor passandopor,
                                       p.descveiculo veiculo,
                                       p.fcf_fretecar_valor valor,
                                       p.fcf_fretecar_pedagio pedagio,
                                       p.Critica
                                  from tdvadm.v_fcf_fretecar_protocolo p
                                  where p.protocolo = c_msg.glb_benasserec_chave;

               pkg_glb_SqlCursor.TiposComuns.Formato := 'H';
               pkg_glb_SqlCursor.TipoHederHTML.Alinhamento := 'Left';
               pkg_glb_SqlCursor.sp_Get_Cursor(vCursor,vLinha);
   
               pCorpoEmail := pCorpoemail ||  'CRITICAS VINCULAÇÃO DE CVA Id: '|| c_msg.glb_benasserec_chave ||' <br />';

               for i in 1 .. vLinha.count loop
                  if pkg_glb_SqlCursor.TiposComuns.Formato = 'H' then
                     pCorpoEmail := pCorpoEmail || vLinha(i);
                  Else
                     pCorpoEmail := pCorpoEmail || vLinha(i) || chr(10);
                  End if;
               End loop;
               
             end;
             COMMIT;

             wservice.pkg_glb_email.SP_ENVIAEMAIL(P_ASSUNTO => 'CADASTRO DE FRETE',
                                                  P_TEXTO   => pCorpoemail,
                                                  P_ORIGEM  => 'aut-e@dellavolpe.com.br',
                                                  P_DESTINO =>  c_msg.glb_benasserec_origem,
                                                  P_COPIA   => 'sirlano.drumond@dellavolpe.com.br',
                                                  P_COPIA2  => null);

            pCorpoemail := empty_clob;


    End Loop;
 

  
end;
0
0
