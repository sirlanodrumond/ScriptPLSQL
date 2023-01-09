PL/SQL Developer Test script 3.0
89
-- Created on 07/12/2022 by SIRLANO.DRUMOND 
declare 
  i          integer := 0;
  pProtocolo varchar2(30) := '221206190643692.csv';
  pCaixa     tdvadm.t_cax_boletim.glb_rota_codigo%type      := '010';
  pBoletim   tdvadm.t_cax_boletim.cax_boletim_data%type     := '30/11/2022';
  pOperacao  tdvadm.t_cax_operacao.cax_operacao_codigo%type := '2401';
  tpCaixa    tdvadm.t_cax_movimento%rowtype;
begin
  -- Test statements here
  For c_msg in (select x.*,
                       nvl((select nvl(m.cax_movimento_valor,0)
                            from tdvadm.t_cax_movimento m
                            where rpad(lpad(trim(m.cax_movimento_documento),6,'0'),10) = rpad(trim(x.ValeFrete),10)
                              and m.cax_movimento_serie                                = trim(x.Serie) 
                              and m.glb_rota_codigo_referencia                         = x.rota
                              and m.cax_movimento_historico                            like '%VF%' || trim(m.cax_movimento_documento) || '%' || trim(m.glb_rota_codigo_referencia) || '%' || trim(m.cax_movimento_doccomplemento) || '%(FRETE)%'  
                              and m.cax_operacao_codigo                                = '2401' ),0) achoucx,
                            (select max(v.car_veiculo_saque)
                             from tdvadm.t_car_veiculo v
                             where v.car_veiculo_placa = x.placa
                               and v.car_proprietario_cgccpfcodigo = x.cpfcnpj) achouveic,
                            (select count(*)
                             from tdvadm.t_car_proprietario p
                             where p.car_proprietario_cgccpfcodigo = x.cpfcnpj) achoprop
                from (select pBoletim Boletim,
                             lpad(i.edi_integra_col04,6,'0') ValeFrete,
                             upper(i.edi_integra_col05) Serie,
                             lpad(TRIM(i.edi_integra_col06),3,'0') rota,
                             substr(i.edi_integra_col07,1,1) SQ,
                             i.edi_integra_col08 tipo,
                             rpad(i.edi_integra_col09,20) CPFCNPJ,
                             i.edi_integra_col10 Proprietario,
                             i.edi_integra_col11 placa,
                             to_number(replace(replace(i.edi_integra_col12,'.',''),',','.')) valor,
                             i.edi_integra_col14 obs
                      from tdvadm.t_edi_integracsv i
                      where upper(i.edi_integra_col01) = upper(pProtocolo)
                        --and lpad(i.edi_integra_col04,6,'0') = '059932'
                        and i.edi_integra_col03 <> 'REFER.') x)
  Loop
     If c_msg.achoucx = 0 Then
        i := i + 1;
        tpCaixa.Glb_Rota_Codigo              := pCaixa;
        tpCaixa.Cax_Boletim_Data             := pBoletim;
        tpCaixa.Glb_Rota_Codigo_Ccust        := c_msg.rota; -- Verificar
        tpCaixa.Glb_Rota_Codigo_Referencia   := c_msg.rota;
        tpCaixa.Glb_Rota_Codigo_Operacao     := '000';
        tpCaixa.Cax_Telefone_Ddd             := null;
        tpCaixa.Cax_Operacao_Codigo          := pOperacao;
        tpCaixa.Cax_Telefone_Numero          := null;
        tpCaixa.Frt_Conjveiculo_Codigo       := null;     
        tpCaixa.Cax_Teelfone_Ano             := null;
        tpCaixa.Cax_Movimento_Documento      := c_msg.ValeFrete;
        tpCaixa.Cax_Movimento_Cgccpf         := c_msg.CPFCNPJ;
        tpCaixa.Cax_Movimento_Favorecido     := c_msg.Proprietario;
        tpCaixa.Cax_Movimento_Serie          := c_msg.Serie;
        tpCaixa.Cax_Movimento_Historico      := substr(c_msg.obs,1,50);
        tpCaixa.Cax_Movimento_Valor          := c_msg.valor;
        tpCaixa.Cax_Movimento_Frend          := null;
        tpCaixa.Cax_Movimento_Contabil       := null;
        tpCaixa.Cax_Movimento_Usuario        := 'sistema';
        tpCaixa.Cax_Movimento_Dttrans        := null;
        tpCaixa.Cax_Movimento_Doccomplemento := c_msg.SQ;
        tpCaixa.Cax_Movimento_Dtgravacao     := sysdate; 
        tpCaixa.Cax_Movimento_Datanf         := null;
        tpCaixa.Cax_Movimento_Dtconc         := null;
        tpCaixa.Cax_Movimento_Historicop     := substr(c_msg.obs,1,50);
        tpCaixa.Cax_Movimento_Historicoc     := substr(c_msg.obs,51,50);
        tpCaixa.Glb_Tpdoc_Codigo             := null; 
        tpCaixa.Cax_Movimento_Documentoref   := c_msg.ValeFrete || c_msg.Serie || c_msg.rota || c_msg.sq;
        tpCaixa.Cax_Movimento_Origem         := 'S';
        tpCaixa.Glb_Centrocusto_Codigo       := null;
        tpCaixa.Glb_Centrocusto_Codigoc      := null;
        tpCaixa.Slf_Servicos_Codigo          := null;

        Select max(m.cax_movimento_sequencia) + 1
           into tpCaixa.Cax_Movimento_Sequencia 
        from tdvadm.t_cax_movimento m 
        where m.glb_rota_codigo = pCaixa
          and m.cax_boletim_data = pBoletim;
          
        insert into tdvadm.t_cax_movimento values tpCaixa;
        rollback;
        return;
     End If;
  End Loop;

end;
0
0
