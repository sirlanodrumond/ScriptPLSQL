select * from tdvadm.t_frt_abastecimento ab
where ab.frt_bomba_codigo = '01'
  and ab.frt_abastecimento_data >= '15/02/2018'
  order by ab.frt_bomba_codigo,ab.frt_abastecimento_numero;
  
="update tdvadm.t_frt_abastecimento ab set ab.frt_abastecimento_saldo = "&AB2&" where ab.frt_abastecimento_numero = '"&B2&"';"

  
