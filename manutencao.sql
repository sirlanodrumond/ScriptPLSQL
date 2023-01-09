SELECT OS.prefixoveic,
       OS.placaatualveic,
       decode(nvl(v.frt_veiculo_codigo,'X'),'X','N','S') achei,
       tdvadm.PKG_FRTCAR_VEICULO.fn_RetTpVeiculo(OS.placaatualveic) FROTAAGR,
       tdvadm.PKG_FRTCAR_VEICULO.FN_RETAPELIDOVEIC(OS.placaatualveic) apelido,
       v.frt_veiculo_datavenda venda,
       SUM(OS.qtdeitensmovto) QTDE,
       SUM(OS.valoritensmovto) VLRUNITARIO,
       SUM(OS.valortotalitensmovto) VLRTOTAL
FROM tdvadm.v_mnt_requicaoglobus OS,
     tdvadm.t_frt_veiculo v
where OS.placaatualveic =  frt_veiculo_placa (+)
GROUP BY OS.prefixoveic,
         OS.placaatualveic ,
         decode(nvl(v.frt_veiculo_codigo,'X'),'X','N','S'),
         tdvadm.PKG_FRTCAR_VEICULO.fn_RetTpVeiculo(OS.placaatualveic),
         tdvadm.PKG_FRTCAR_VEICULO.FN_RETAPELIDOVEIC(OS.placaatualveic),
         v.frt_veiculo_datavenda;

         
SELECT distinct
       os.dataaberturaos,
       os.datarq,
       os.numerorq,
       OS.prefixoveic,
       OS.placaatualveic,
       decode(nvl(v.frt_veiculo_codigo,'X'),'X','N','S') achei,
       tdvadm.PKG_FRTCAR_VEICULO.fn_RetTpVeiculo(OS.placaatualveic) FROTAAGR,
       tdvadm.PKG_FRTCAR_VEICULO.FN_RETAPELIDOVEIC(OS.placaatualveic) apelido,
       v.frt_veiculo_datavenda venda,
       SUM(OS.qtdeitensmovto) QTDE,
       SUM(OS.valoritensmovto) VLRUNITARIO,
       SUM(OS.valortotalitensmovto) VLRTOTAL
FROM tdvadm.v_mnt_requicaoglobus OS,
     tdvadm.t_frt_veiculo v
where OS.placaatualveic =  frt_veiculo_placa (+)
  and OS.prefixoveic = 'C3082'
GROUP BY os.dataaberturaos,
         os.datarq,
         os.numerorq,
         OS.prefixoveic,
         OS.placaatualveic ,
         decode(nvl(v.frt_veiculo_codigo,'X'),'X','N','S'),
         tdvadm.PKG_FRTCAR_VEICULO.fn_RetTpVeiculo(OS.placaatualveic),
         tdvadm.PKG_FRTCAR_VEICULO.FN_RETAPELIDOVEIC(OS.placaatualveic),
         v.frt_veiculo_datavenda;
