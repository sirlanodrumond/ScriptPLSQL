PL/SQL Developer Test script 3.0
101
-- Created on 27/10/2021 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  vQtdeCalc integer;
  vQtdeTab  integer;
  vQtdePed  integer;
  vInicio   date;
  vFim      date;
  vTexto    clob;
  vDtVig    date := '25/10/2021';
  vbanco    tdvadm.v_glb_ambiente.db_name%type;
begin
  -- Test statements here
  select x.db_name
    into vbanco
  from v_glb_ambiente x;
  
  --If lower(vbanco) = 'tdp' Then
  --  return;
  --End If;
  






  
/*    for c_msg in (--select '5500058294-V-MG' contrato from dual union
                  --select '5500057918-V-EE' contrato from dual union
                  --select '55000057895-BM ' contrato from dual union
                  --select '55000057896-DOR' contrato from dual union
                  --select '5500057870-RT  ' contrato from dual union
                  --select '5500057877-RMF ' contrato from dual union
                  --select '5500057880-INS ' contrato from dual union
                  --select '5500057880-ISO ' contrato from dual union
                  --select '5500057902-DX  ' contrato from dual --union
                  --select '5500057918-V-NN' contrato from dual union
                  --select '5500057918-V-SS' contrato from dual union
                  --select '5500058294-V-NO' contrato from dual union
                  --select '5500058294-V-SP' contrato from dual
                  )

*/
    For c_msg in (select '5500058294-M-SP' contrato from dual union
                  select '5500057918-M-EE' contrato from dual union
                  select '5500057918-M-NN' contrato from dual union
                  select '5500057918-M-SS' contrato from dual union
                  select '5500058294-M-MG' contrato from dual union
                  select '5500058294-M-NO' contrato from dual)
                  

    Loop
      Begin  
         vTexto := empty_clob;
         vTexto := 'Deletando Contrato ' || c_msg.contrato || chr(10);
         vInicio := sysdate;
         delete tdvadm.t_slf_calcfretekm km
         where (km.slf_tabela_codigo,
                km.slf_tabela_saque) in (select ta.slf_tabela_codigo,
                                                ta.slf_tabela_saque
                                         from tdvadm.t_slf_tabela ta
                                         where ta.slf_tabela_contrato = trim(c_msg.contrato)
                                           and ta.slf_tabela_vigencia >= vDtVig);
         vQtdeTab := sql%rowcount;
         
         
         delete tdvadm.t_slf_clienteped cp
         where cp.slf_contrato_codigo = trim(c_msg.contrato)
           and cp.slf_clienteped_vigencia >= vDtVig;
         vQtdePed := sql%rowcount;
         
         
         
         delete tdvadm.t_slf_tabela ta
         where ta.slf_tabela_contrato = trim(c_msg.contrato)
           and ta.slf_tabela_vigencia >= vDtVig;
         vQtdeCalc := sql%rowcount;
         vFim := sysdate;
         vTexto := vTexto || 
                   tdvadm.f_mascara_valor(vQtdeTab,6,0) || ' Tabelas' || chr(10) ||
                   tdvadm.f_mascara_valor(vQtdeCalc,6,0) || ' Calculos' || chr(10) ||
                   tdvadm.f_mascara_valor(vQtdePed,6,0) || ' Pedagios' || chr(10) ||
                   tdvadm.fn_calcula_tempodecorrido(vInicio,vFim,'H') || ' Tempo' || chr(10);
      Exception
        When OTHERS Then
          vTexto := vTexto || 
                    'Erro : ' || sqlerrm || chr(10) ;
          rollback;
        End;
      wservice.pkg_glb_email.SP_ENVIAEMAIL(P_ASSUNTO => 'EXCLUSAO - ' || c_msg.contrato || ' - ' || to_char(sysdate,'dd/mm/yyyy hh24:mi:ss'),
                                           P_TEXTO   => vTexto,
                                           P_ORIGEM  => 'aut-e@dellavolpe.com.br',
                                           P_DESTINO => 'sirlano.drumond@dellavolpe.com.br',
                                           P_COPIA   => null,
                                           P_COPIA2  => null);
      commit;
      
    End Loop; 
    commit;
end;
0
2
vTexto
c_msg.contrato
