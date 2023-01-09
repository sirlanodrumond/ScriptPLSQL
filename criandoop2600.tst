PL/SQL Developer Test script 3.0
91
-- Created on 05/07/2019 by SDRUMOND 
declare 
  -- Local variables here
  i integer;
  tpCaixa tdvadm.t_cax_movimento%rowtype;
begin

   for c_msg in ( select rpad(trim(lpad(v.acc_vales_numero,6,'0')),10) acc_vales_numero,
                         v.glb_rota_codigo,
                         v.acc_vales_data,
                         v.acc_acontas_numero,
                         v.acc_contas_ciclo,
                         v.acc_vales_valor,
                         v.acc_vales_flagpess,
                         v.acc_vales_dtimpressao,
                         (select m.frt_motorista_cpf
                          from tdvadm.t_frt_motorista m
                          where m.frt_motorista_codigo = v.frt_motorista_codigo) cpfmot
                  from tdvadm.t_acc_vales v
                  where v.acc_acontas_numero is not null
                    and v.acc_vales_data >= '01/01/2018'
                    and v.acc_acontas_numero not in ('00000000','11111111')
                    and 0 = (select count(*)
                             from tdvadm.t_cax_movimento m
                             where m.glb_rota_codigo = '015'
                               and m.cax_movimento_documento = rpad(trim(lpad(v.acc_vales_numero,6,'0')),10)
                               and m.glb_rota_codigo_referencia = '015'
                               and m.cax_operacao_codigo = '2600')
                    and 0 < (select count(*)
                             from tdvadm.t_acc_acontas ac             
                             where ac.acc_acontas_numero = v.acc_acontas_numero
                               and ac.acc_contas_ciclo = v.acc_contas_ciclo
                               and ac.acc_acontas_datatransf is not null)
                  )
   Loop

     tpCaixa.Glb_Rota_Codigo              := '015';
     tpCaixa.Cax_Boletim_Data             := '26/06/2019';
     tpCaixa.Cax_Movimento_Sequencia      := null;
     tpCaixa.Glb_Rota_Codigo_Ccust        := null;
     tpCaixa.Glb_Rota_Codigo_Referencia   := '015';
     tpCaixa.Glb_Rota_Codigo_Operacao     := '000';
     tpCaixa.Cax_Telefone_Ddd             := null;
     tpCaixa.Cax_Operacao_Codigo          := '2600';
     tpCaixa.Cax_Telefone_Numero          := null;
     tpCaixa.Frt_Conjveiculo_Codigo       := null;
     tpCaixa.Cax_Teelfone_Ano             := null;
     tpCaixa.Cax_Movimento_Documento      := c_msg.acc_vales_numero;
     tpCaixa.Cax_Movimento_Cgccpf         := c_msg.cpfmot;
     tpCaixa.Cax_Movimento_Favorecido     := null;
     tpCaixa.Cax_Movimento_Serie          := null;
     tpCaixa.Cax_Movimento_Valor          := c_msg.acc_vales_valor;
     tpCaixa.Cax_Movimento_Frend          := null;
     tpCaixa.Cax_Movimento_Contabil       := 'C';
     tpCaixa.Cax_Movimento_Usuario        := 'sistema';
     tpCaixa.Cax_Movimento_Dttrans        := null;
     tpCaixa.Cax_Movimento_Doccomplemento := null;
     tpCaixa.Cax_Movimento_Dtgravacao     := sysdate;
     tpCaixa.Cax_Movimento_Datanf         := null;
     tpCaixa.Cax_Movimento_Dtconc         := null;
     tpCaixa.Glb_Tpdoc_Codigo             := null;
     tpCaixa.Cax_Movimento_Documentoref   := 'O';
     tpCaixa.Glb_Centrocusto_Codigo       := null;
     tpCaixa.Glb_Centrocusto_Codigoc      := null;
     tpCaixa.Slf_Servicos_Codigo          := null;
     tpCaixa.Cax_Movimento_Historicop     := tdvadm.pkg_ctb_caixa .fn_set_historico(tpCaixa,'P');
     tpCaixa.Cax_Movimento_Historicoc     := tdvadm.pkg_ctb_caixa .fn_set_historico(tpCaixa,'C');
     tpCaixa.Cax_Movimento_Historico      := tdvadm.pkg_ctb_caixa .fn_set_historico(tpCaixa,'T');

     select count(*)
       into i
     from tdvadm.t_cax_movimento m
     where m.glb_rota_codigo = tpCaixa.Glb_Rota_Codigo
       and m.cax_boletim_data = tpCaixa.Cax_Boletim_Data
       and m.glb_rota_codigo_referencia = tpCaixa.Glb_Rota_Codigo_Referencia
       and m.cax_movimento_documento = tpCaixa.Cax_Movimento_Documento
       and m.glb_rota_codigo_operacao = tpCaixa.Glb_Rota_Codigo_Operacao
       and m.cax_operacao_codigo = tpCaixa.Cax_Operacao_Codigo;
    
    If i = 0 Then
       select max(m.Cax_Movimento_Sequencia)
         into tpCaixa.Cax_Movimento_Sequencia
       from tdvadm.t_cax_movimento m
       where m.glb_rota_codigo = tpCaixa.Glb_Rota_Codigo
         and m.cax_boletim_data = tpCaixa.Cax_Boletim_Data;
       tpCaixa.Cax_Movimento_Sequencia := tpCaixa.Cax_Movimento_Sequencia + 1;
       insert into tdvadm.t_cax_movimento values tpCaixa;
    End If;
   End Loop;  
   commit;
end;
0
4
tpCaixa.Cax_Movimento_Historicop
tpCaixa.Cax_Movimento_Historicoc
tpCaixa.Cax_Movimento_Historico
i
