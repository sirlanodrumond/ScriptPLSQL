SELECT DATA,
       PLACA,
       CHAVE,
       QTDE,
       (SELECT V.FRT_VEICULO_DATAQUISICAO || '-' || V.FRT_VEICULO_CODIGO || '-' || V.FRT_VEICULO_DATAVENDA || '-' || V.FRT_VEICULO_FLGPT
        FROM TDVADM.T_FRT_VEICULO V
        WHERE V.FRT_VEICULO_PLACA = X.PLACA
          AND V.FRT_VEICULO_DATAVENDA IS NULL
          AND ROWNUM = 1) CADVEICNVEND,
       (SELECT V.FRT_VEICULO_DATAQUISICAO || '-' || V.FRT_VEICULO_CODIGO || '-' || V.FRT_VEICULO_DATAVENDA || '-' || V.FRT_VEICULO_FLGPT
        FROM TDVADM.T_FRT_VEICULO V
        WHERE V.FRT_VEICULO_PLACA = X.PLACA
          AND V.FRT_VEICULO_DATAVENDA IS NOT NULL
          AND ROWNUM = 1) CADVEICVEND,
       (SELECT COUNT(*)
        FROM TDVADM.T_FRT_VEICULO V
        WHERE V.FRT_VEICULO_PLACA = X.PLACA) CADVEIC,
        MSG,
        CHAVEMSG
FROM (
      SELECT to_char(lo.log_system_datahora,'DD/MM/YYYY') DATA,
               lo.log_system_message msg,
               lo.log_system_campochave CHAVEMSG,
               tdvadm.fn_buscalogctf(lo.log_system_message,lo.log_system_campochave,'P') Placa,
               tdvadm.fn_buscalogctf(lo.log_system_message,lo.log_system_campochave,'C') Chave,
               count(*) qtde
        FROM TDVADM.T_LOG_SYSTEM LO
        WHERE 0 = 0 
          and lo.log_tipo_codigo <> 'W'
      --    and TRIM(LO.LOG_SYSTEM_CAMPOCHAVE) = '120570280'
          and lo.usu_aplicacao_codigo = 'integCTF'
          and lo.log_system_message not like '%TDVADM.UI_ACC_ABASTEC%'
          and to_char(lo.log_system_datahora,'yyyy') = '2017'
        group by to_char(lo.log_system_datahora,'DD/MM/YYYY'),
                 lo.log_system_message,
                 lo.log_system_campochave,
                 tdvadm.fn_buscalogctf(lo.log_system_message,lo.log_system_campochave,'P'),
                 tdvadm.fn_buscalogctf(lo.log_system_message,lo.log_system_campochave,'C')
     ) X




