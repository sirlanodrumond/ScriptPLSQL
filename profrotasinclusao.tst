PL/SQL Developer Test script 3.0
118
declare 
  vAuxiliar       integer;
  tpAbastecimento tdvadm.t_acc_abastecimento%rowtype;
begin
  For c_msg in (select it.edi_integra_col01 acc_abastecimento_numero,
                       null                 acc_contas_ciclo,
                       RPAD(REPLACE(REPLACE(REPLACE(it.edi_integra_col21,'.',''),'-',''),'/',''),20) pos_cadastro_cgc,
                       null                 frt_conjveiculo_codigo,
                       null                 acc_acontas_numero,
                       null                 glb_rota_codigo_operacao,
                       RPAD(REPLACE(REPLACE(REPLACE(it.edi_integra_col29,'.',''),'-',''),'/',''),20) frt_motorista_codigo,
                       null                 cax_operacao_codigo,
                       REPLACE(REPLACE(it.edi_integra_col56,'.',''),',','.') acc_abastecimento_quantidade,
                       it.edi_integra_col07 acc_abastecimento_data,
                       REPLACE(REPLACE(it.edi_integra_col39,'.',''),',','.') acc_abastecimento_km,
                       REPLACE(REPLACE(it.edi_integra_col56,'.',''),',','.') acc_abastecimento_valor,
                       null                 acc_abastecimento_tpreg,
                       'PRO FROTAS IMP'     acc_abastecimento_obs,
                       'sistemas'           usu_usuario_codigocad,
                       decode(trim(it.edi_integra_col53),'Diesel S-10 Comum','70',
                                                         'Diesel S-500 Comum','01',
                                                         'Gasolina Comum','10',
                                                         'Etanol Comum','02',
                                                         'Diesel S-10 Aditivado','50','00') pos_combustivel_codigo,
                       it.edi_integra_col03 acc_abastecimento_indice,
                       UPPER(REPLACE(it.edi_integra_col27,'-','')) acc_abastecimento_placa,
                       sysdate              acc_abastecimento_dtcadastro
                       ,it.edi_integra_col22 NOMEPOSTO
                       ,it.edi_integra_col30 NOMEMOTORISTA
                from tdvadm.t_edi_integra it
                where it.edi_integra_protocolo in (select br.glb_benasserec_chave from rmadm.t_glb_benasserec br where br.glb_benasserec_origem like 'sirlano%' and trunc(br.glb_benasserec_gravacao) = '18/05/2021' and br.glb_benasserec_assunto = 'PRO FROTAS 2')
                )

  Loop
     Begin
         tpAbastecimento.Acc_Abastecimento_Numero     := c_msg.Acc_Abastecimento_Numero    ;
         tpAbastecimento.Acc_Contas_Ciclo             := c_msg.Acc_Contas_Ciclo            ;
         tpAbastecimento.Acc_Acontas_Numero           := c_msg.Acc_Acontas_Numero          ;
         tpAbastecimento.Glb_Rota_Codigo_Operacao     := c_msg.Glb_Rota_Codigo_Operacao    ;
         tpAbastecimento.Cax_Operacao_Codigo          := c_msg.Cax_Operacao_Codigo         ;
         tpAbastecimento.Acc_Abastecimento_Data       := c_msg.Acc_Abastecimento_Data      ;

         tpAbastecimento.Acc_Abastecimento_Tpreg      := c_msg.Acc_Abastecimento_Tpreg     ;
         tpAbastecimento.Acc_Abastecimento_Obs        := c_msg.Acc_Abastecimento_Obs       ;
         tpAbastecimento.Usu_Usuario_Codigocad        := c_msg.Usu_Usuario_Codigocad       ;
         tpAbastecimento.Pos_Combustivel_Codigo       := c_msg.Pos_Combustivel_Codigo      ;
         tpAbastecimento.Acc_Abastecimento_Indice     := c_msg.Acc_Abastecimento_Numero    ;
         tpAbastecimento.Acc_Abastecimento_Placa      := c_msg.Acc_Abastecimento_Placa     ;
         tpAbastecimento.Acc_Abastecimento_Dtcadastro := c_msg.Acc_Abastecimento_Dtcadastro;  

         select count(*)
           into vAuxiliar
         from tdvadm.t_pos_cadastro c
         where c.pos_cadastro_cgc = c_msg.Pos_Cadastro_Cgc;
         If vAuxiliar <> 0 then      
            tpAbastecimento.Pos_Cadastro_Cgc := c_msg.Pos_Cadastro_Cgc;
         Else
            tpAbastecimento.Pos_Cadastro_Cgc := '61139432000172';
         End If;
           

         tpAbastecimento.Frt_Conjveiculo_Codigo := tdvadm.pkg_frtcar_veiculo.FN_RETCONJ(tpAbastecimento.Acc_Abastecimento_Placa,tpAbastecimento.Acc_Abastecimento_Data);

         Begin
         select max(m.frt_motorista_codigo)
           into tpAbastecimento.Frt_Motorista_Codigo
         from tdvadm.t_frt_motorista m
         where m.frt_motorista_cpf = c_msg.Frt_Motorista_Codigo;
         Exception
           When NO_DATA_FOUND Then
              tpAbastecimento.Frt_Motorista_Codigo := null;
           End ;


         Begin
            tpAbastecimento.Acc_Abastecimento_Quantidade         := to_number(c_msg.Acc_Abastecimento_Quantidade);
         exception
           When Others Then
             tpAbastecimento.Acc_Abastecimento_Quantidade := 0;
           End;


         Begin
            tpAbastecimento.Acc_Abastecimento_Km         := to_number(c_msg.Acc_Abastecimento_Km);
         exception
           When Others Then
             tpAbastecimento.Acc_Abastecimento_Km := 0;
           End;

         Begin
            tpAbastecimento.Acc_Abastecimento_Valor         := to_number(c_msg.Acc_Abastecimento_Valor);
         exception
           When Others Then
             tpAbastecimento.Acc_Abastecimento_Valor := 0;
           End;
           
           
         select count(*)
           into vAuxiliar
          from tdvadm.t_acc_abastecimento ab
          where ab.acc_abastecimento_numero = tpAbastecimento.Acc_Abastecimento_Numero
            and ab.acc_abastecimento_placa = tpAbastecimento.Acc_Abastecimento_Placa
            and ab.acc_abastecimento_obs = 'PRO FROTAS IMP';  

         If vAuxiliar = 0 Then
            insert into tdvadm.t_acc_abastecimento values tpAbastecimento;
            commit;
         Else
            dbms_output.put_line('Verificar Abastecimento ' || tpAbastecimento.Acc_Abastecimento_Numero || '-' || tpAbastecimento.Acc_Abastecimento_Placa);
         End If;
     Exception
       When Others then
            dbms_output.put_line('Verificar Abastecimento ' || tpAbastecimento.Acc_Abastecimento_Numero || '-' || tpAbastecimento.Acc_Abastecimento_Placa || '-' || sqlerrm);
       End; 
  End Loop;
  commit; 

end;
0
0
