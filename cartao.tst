PL/SQL Developer Test script 3.0
114
declare 
  pProtocolo  rmadm.t_glb_benasserec.glb_benasserec_chave%type := '2557592'; 
  i Integer;
  vSeq integer;
  tpMovimento SDRUMOND.T_CCC_MOVIMENTO%rowtype;
  vInicioLanc varchar2(50) := 'SEG.,;TER.,;QUA.,;QUI.,;SEX.,;SAB.,;DOM.,;SA B.,';
begin
   vSeq := 0;
   i    := 0;
   delete sdrumond.t_ccc_movimento m where m.ccc_movimento_documento = pProtocolo;
   For c_msg in (Select i.edi_integra_col01,
                        i.edi_integra_critica,
                        i.rowid
                 from tdvadm.t_edi_integra@database_tdp i,
                      rmadm.t_glb_benasserec@database_tdp r
                 where i.edi_integra_protocolo = r.glb_benasserec_chave
                   and i.edi_integra_protocolo = pProtocolo
                 order by i.edi_integra_sequencia)
   Loop

      If i = 5 Then
         If instr(c_msg.edi_integra_col01,'Parcela') = 0 Then
            vSeq := vSeq + 1;
            tpMovimento.Ccc_Movimento_Sequencia := vSeq;
            if instr(tpMovimento.Ccc_Movimento_Descricao,'Pagamento') > 0 Then
               tpMovimento.Ccc_Movimento_Observacao := trim(tpMovimento.Ccc_Movimento_Observacao) || '- pagamento - [' || tpMovimento.Ccc_Movimento_Valor || ']';
               tpMovimento.Ccc_Movimento_Valor := 0;
            End If;
            insert into sdrumond.t_ccc_movimento values tpMovimento;
            i := 1;
         End If;   
      End If;

/*
      tpMovimento.Ccc_Movimento_Dtlanc     := null;
      tpMovimento.Ccc_Movimento_Descricao  := null;
      tpMovimento.Ccc_Movimento_Valor      := null;
      tpMovimento.Ccc_Classificacao_Codigo := null;
      tpMovimento.Ccc_Movimento_Observacao := null;
*/   
      -- Pega a Data
      If instr(c_msg.edi_integra_col01,'LanA amentos') > 0 Then
         i := -9;
      Elsif instr(c_msg.edi_integra_col01,'a€ a€ a€') > 0 Then
         tpMovimento.Ccc_Conta_Codigo := substr(c_msg.edi_integra_col01,-4,4);
         i := -9;
      End If;         

      If instr(vInicioLanc,substr(c_msg.edi_integra_col01,1,3)) > 0 Then
         tpMovimento.Ccc_Movimento_Dtlanc := substr(c_msg.edi_integra_col01,7,5) || '/2022'; 
         i := 0;
      Else
         If i = 1 Then
            Begin
               tpMovimento.Ccc_Movimento_Documento := pProtocolo;
            exception
               When OTHERS Then
                  dbms_output.put_line(vSeq ||'-' || i || '- [' || c_msg.edi_integra_col01 || ']' );
                  tpMovimento.Ccc_Movimento_Documento := '';
               End;

            Begin
               tpMovimento.Ccc_Movimento_Observacao := substr(c_msg.edi_integra_col01,1,50);   
            exception
               When OTHERS Then
                  dbms_output.put_line(vSeq ||'-' || i || '- [' || c_msg.edi_integra_col01 || ']' );
                  tpMovimento.Ccc_Movimento_Observacao := '';
               End;

         ElsIf i = 2 Then -- Onde comprou
            Begin
               tpMovimento.Ccc_Movimento_Descricao := substr(c_msg.edi_integra_col01,1,50);   
            exception
               When OTHERS Then
                  dbms_output.put_line(vSeq ||'-' || i || '- [' || c_msg.edi_integra_col01 || ']' );
                  tpMovimento.Ccc_Movimento_Descricao := '';
               End;
         ElsIf i = 3 Then -- Valor
            Begin
               tpMovimento.Ccc_Movimento_Valor := replace(replace(replace(trim(replace(c_msg.edi_integra_col01,'R','')),'-',''),'.',''),',','.');
               If instr(c_msg.edi_integra_col01,'-') > 0 Then
                  tpMovimento.Ccc_Movimento_Valor := tpMovimento.Ccc_Movimento_Valor * -1;   
               End If;
            exception
               When OTHERS Then
                  dbms_output.put_line(vSeq ||'-' || i || '- [' || c_msg.edi_integra_col01 || ']' );
                  tpMovimento.Ccc_Movimento_Valor := -999;
               End; 
         ElsIf i = 4 Then -- Clasiificacao
            Begin
               tpMovimento.Ccc_Movimento_Observacao := tpMovimento.Ccc_Movimento_Observacao || '-' || substr(c_msg.edi_integra_col01,1,50);   
            exception
               When OTHERS Then
                  dbms_output.put_line(vSeq ||'-' || i || '- [' || c_msg.edi_integra_col01 || ']' );
                  tpMovimento.Ccc_Movimento_Observacao := tpMovimento.Ccc_Movimento_Observacao || '-' ;
               End;
         ElsIf i = 5 Then -- Parcela
            Begin
               tpMovimento.Ccc_Movimento_Descricao := substr(trim(tpMovimento.Ccc_Movimento_Descricao) || '-' || c_msg.edi_integra_col01,1,50);
               i := 0;
               vSeq := vSeq + 1;
               tpMovimento.Ccc_Movimento_Sequencia := vSeq;
               insert into sdrumond.t_ccc_movimento values tpMovimento;
            exception
               When OTHERS Then
                  dbms_output.put_line(vSeq ||'-' || i || '- [' || c_msg.edi_integra_col01 || ']' );
                  tpMovimento.Ccc_Movimento_Descricao := '';
               End;
         End If;
      End If;
      i := i + 1;
   End Loop;  
   commit;
end;
0
3
c_msg.edi_integra_col01
vSeq
i
