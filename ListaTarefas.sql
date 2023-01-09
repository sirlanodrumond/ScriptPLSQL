/*
TODO: owner="Sirlano.Drumond" created="19/03/2021" closed="19/03/2021"
text="TRAVA SANTOS
      Mudar a categoria do saque 2
"
*/

/*
TODO: owner="Sirlano.Drumond" created="19/03/2021"
text="Verificar se o Pedagio da TDV nao e maior que o Pedagio da Mesa"
*/


/*
TODO: owner="Sirlano.Drumond" created="19/03/2021"
text="verificar o pedagio original saque 2"
*/

/*
TODO: owner="Sirlano.Drumond" created="19/03/2021"
text="Mensagem tirar da OBSERVACAO e colocar no outro campo"
*/

/*
TODO: owner="Sirlano.Drumond" created="19/03/2021"
text="Bonus para FROTA quando contrato diz que nao Tem BONUS.
      Criar parametro de FROTA TEM BONUS no CONTRATO
      Mudar funcao no PKG_CON_VALEFRETE"
*/

/*
TODO: owner="Sirlano.Drumond" created="19/03/2021"
text="Verificar rotina que abate debitos errados
      tdvadm.pkg_car_proprietario.SP_VeirifcaDebitoContaCorrente;"
*/

/*
TODO: owner="Sirlano.Drumond" created="19/03/2021"
text="Verificar a rotina de saldo do conta corrente
      tdvadm.Pkg_Car_Proprietario.fn_RetornaSaldocc;
      
      Select x.operacao, 
             x.proprietario,
             sum(x.car_contacorrente_valor * decode(x.car_contacorrente_tplancamento,'D',0,1)) Credito,
             sum(x.car_contacorrente_valor * decode(x.car_contacorrente_tplancamento,'D',1,0)) Debito,
             sum(x.car_contacorrente_valor * decode(x.car_contacorrente_tplancamento,'D',1,-1)) valor,
             count(*) QTDE,
             min(trunc(x.dtData)) menorDT,
             max(trunc(x.dtData)) maiorDT       
      from TDVADM.V_CAR_CONTACORRENTENOVOCONCEITO x
      where 0 = 0 
        and x.dtData >= to_date('01/12/2015','dd/mm/yyyy')
      --  and x.dtincialded <= to_date('13/10/2020','dd/mm/yyyy')
        and trim(x.operacao) in ('PNEUS/TDV PARCELA')
      --  and x.proprietario like '%KENNEDY%'
      group by x.operacao,x.proprietario;
      
      Select trunc(vf.Con_Valefrete_Datacadastro) cadastro,
                                     vf.con_conhecimento_codigo vfrete,
                                     vf.con_conhecimento_serie sr,
                                     vf.glb_rota_codigo rt,
                                     vf.con_valefrete_saque sq,
                                     cat.con_catvalefrete_descricao categoria,
                                     vf.con_valefrete_placa placa,
                                     p.car_proprietario_cgccpfcodigo cnpjcpf,
                                     p.car_proprietario_razaosocial proprietario,
                                     vf.con_valefrete_multa valor,
                                     Pkg_Car_Proprietario.fn_RetornaSaldocc(p.car_proprietario_cgccpfcodigo) saldo
                              from t_con_valefrete vf,
                                   t_car_veiculo v,
                                   t_car_proprietario p,
                                   t_con_catvalefrete cat
                              where vf.con_valefrete_multa > 0
                                and vf.con_valefrete_datacadastro >=  to_date('01/05/2015','dd/mm/yyyy')
                                and nvl(vf.con_valefrete_status,'N') = 'N'
                                and vf.con_catvalefrete_codigo <> '10'
      --                          and vf.con_conhecimento_codigo = '000571'
      --                          and vf.glb_rota_codigo = '060'
                                and vf.con_valefrete_placa = v.car_veiculo_placa
                                and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                and v.car_proprietario_cgccpfcodigo = p.car_proprietario_cgccpfcodigo
                                and vf.con_catvalefrete_codigo = cat.con_catvalefrete_codigo
      --                          and vf.con_valefrete_multa <= Pkg_Car_Proprietario.fn_RetornaSaldocc(p.car_proprietario_cgccpfcodigo) 
                                and 0 = (select count(*)
                                         from t_car_contacorrente ca
                                         where trim(ca.car_contacorrente_docref) = vf.con_conhecimento_codigo || vf.glb_rota_codigo || vf.con_valefrete_saque)
      "
*/

/*
TODO: owner="Sirlano.Drumond" created="19/03/2021"
text="Rotina da TATI para criar no TDP
      tdvadm.PKG_FIFO_MANIFESTO .FN_GETXML_MDFE;
      "
*/


                                   
