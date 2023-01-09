PL/SQL Developer Test script 3.0
112
-- Created on 27/10/2021 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  vQtdeCalc integer;
  vQtdeTab  integer;
  vInicio   date;
  vFim      date;
  vErro    clob;
begin
  -- Test statements here








     vErro := empty_clob;
    for c_msg in (
      
                  -- EXCLUIDOS em 28/11/2021 
                  -- *********************************************************************
                  --select '5500058294-M-SP' contrato,'03/11/2021' vigencia, 7.37 Percentual,'S' Frete,'N' Pedagio, 'N' Despesas from dual
                  --union
                  --select '5500057918-M-EE' contrato,'03/11/2021' vigencia, 7.37 Percentual,'S' Frete,'N' Pedagio, 'N' Despesas from dual
                  --union
                  --select '5500057918-M-NN' contrato,'03/11/2021' vigencia, 7.37 Percentual,'S' Frete,'N' Pedagio, 'N' Despesas from dual
                  --union
                  --select '5500057918-M-SS' contrato,'03/11/2021' vigencia, 7.37 Percentual,'S' Frete,'N' Pedagio, 'N' Despesas from dual
                  --union
                  --select '5500058294-M-MG' contrato,'03/11/2021' vigencia, 7.37 Percentual,'S' Frete,'N' Pedagio, 'N' Despesas from dual
                  --union
                  --select '5500058294-M-NO' contrato,'03/11/2021' vigencia, 7.37 Percentual,'S' Frete,'N' Pedagio, 'N' Despesas from dual
                  --union
                  -- *********************************************************************

                  -- Feito 28/10/2021
                  -- *********************************************************************
                  --select '5500058294-V-SP' contrato,'03/11/2021' vigencia, 7.37 Percentual,'S' Frete,'N' Pedagio, 'N' Despesas from dual
                  --union
                  --select '5500058294-V-NO' contrato,'03/11/2021' vigencia, 7.37 Percentual,'S' Frete,'N' Pedagio, 'N' Despesas from dual
                  --union
                  --select '5500057918-V-EE' contrato,'03/11/2021' vigencia, 7.37 Percentual,'S' Frete,'N' Pedagio, 'N' Despesas from dual
                  --union
                  --select '5500057918-V-SS' contrato,'03/11/2021' vigencia, 7.37 Percentual,'S' Frete,'N' Pedagio, 'N' Despesas from dual
                  --union
                  --select '5500057918-V-NN' contrato,'03/11/2021' vigencia, 7.37 Percentual,'S' Frete,'N' Pedagio, 'N' Despesas from dual
                  --union
                  -- *********************************************************************

                  -- Feito 29/10/2021 08:00  
                  -- *********************************************************************
                  --select '5500058294-V-MG' contrato,'03/11/2021' vigencia, 7.37 Percentual,'S' Frete,'N' Pedagio, 'N' Despesas from dual
                  --union
                  -- *********************************************************************

                  -- Feito 29/10/2021 20:52  
                  -- *********************************************************************
                  select '55000057895-BM ' contrato,'03/11/2021' vigencia, 7.37 Percentual,'S' Frete,'S' Pedagio, 'N' Despesas from dual
                  union
                  select '55000057896-DOR' contrato,'03/11/2021' vigencia, 7.37 Percentual,'S' Frete,'S' Pedagio, 'N' Despesas from dual
                  union
                  Select '5500057870-RT  ' contrato,'03/11/2021' vigencia, 7.37 Percentual,'S' Frete,'S' Pedagio, 'N' Despesas from dual
                  union
                  select '5500057877-RMF ' contrato,'03/11/2021' vigencia, 7.37 Percentual,'S' Frete,'S' Pedagio, 'N' Despesas from dual
                  union
                  select '5500057880-INS ' contrato,'03/11/2021' vigencia, 7.37 Percentual,'S' Frete,'S' Pedagio, 'N' Despesas from dual
                  union
                  select '5500057880-ISO ' contrato,'03/11/2021' vigencia, 7.37 Percentual,'S' Frete,'S' Pedagio, 'N' Despesas from dual
                  union
                  select '5500057902-DX  ' contrato,'03/11/2021' vigencia, 7.37 Percentual,'S' Frete,'S' Pedagio, 'N' Despesas from dual
                  -- *********************************************************************
                  )
    Loop
       Begin
          vInicio := sysdate;
/*          TDVADM.PKG_SLF_TABELAS.sp_reajustaTABKM(pContrato => c_msg.Contrato,
                                                  pPercent => c_msg.percentual,
                                                  pVigencia => c_msg.vigencia,
                                                  pListaTAB => null,
                                                  pListaCargas => null,
                                                  pReajustaFRETE => c_msg.frete,
                                                  pReajustaPED => c_msg.pedagio,
                                                  pReajustaDESP => c_msg.despesas);
*/          TDVADM.PKG_HD_ATUALIZATDX_JOAO.sp_atualizaRegras(pContrato => c_msg.contrato);
          TDVADM.PKG_HD_ATUALIZATDX_JOAO.sp_atualizaFrete(pContrato  => c_msg.contrato);
          vFim := sysdate;
          vErro := 'Inicio ' || vInicio || chr(10) ||
                   'Fim    ' || vFim    || chr(10) ||
                   'Tempo  ' || tdvadm.fn_calcula_tempodecorrido(vInicio,vFim,'H') || chr(10);

       Exception
         When OTHERS Then
            vErro := 'Inicio ' || vInicio || chr(10) ||
                   'Fim    ' || vFim    || chr(10) ||
                   'Tempo  ' || tdvadm.fn_calcula_tempodecorrido(vInicio,vFim,'H') || chr(10) ||
                   'Erro   ' || sqlerrm;    
         End;
       wservice.pkg_glb_email.SP_ENVIAEMAIL(P_ASSUNTO => 'CONTRATO ' || c_msg.contrato,
                                            P_TEXTO   => vErro,
                                            P_ORIGEM  => 'aut-e@dellavolpe.com.br',
                                            P_DESTINO => 'sirlano.drumond@dellavolpe.com.br',
                                            P_COPIA   => null,
                                            P_COPIA2  => null);
       vErro := empty_clob;

       commit;
      
    End Loop; 
    commit;
end;
0
0
