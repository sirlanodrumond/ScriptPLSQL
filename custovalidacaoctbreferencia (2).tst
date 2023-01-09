PL/SQL Developer Test script 3.0
125
-- Created on 23/07/2021 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  i integer;
  vProcessos  tdvadm.t_ctb_referencia.ctb_referencia_processos%type;
  vReferencia char(6);
  vDataIni    date;
  vDataFim    date;
  vModulo     tdvipf.t_ipf_modulo.ipf_modulo_codigo%type;
  vRealizado  char(1);
  vAtualiza   char(1);
begin
  
  vReferencia := :pReferencia;
  vDataIni    := to_date(vReferencia || '01','YYYYMMDD');
  vDataFim    := last_day(vDataIni);
  vModulo     := 1;

  select rpad(trim(r.ctb_referencia_processos),30,'N')
     into vProcessos
  from tdvadm.t_ctb_referencia r
  where r.ctb_referencia_codigo = vReferencia;
  :pProcessoE := vProcessos;
  
  For vModulo in 1..30
  Loop
     vAtualiza := 'S';
     If vModulo = tdvipf.pkg_reccust_diretos2019.cContaPorCentroCusto Then -- 1 - Conta por Centro de Custo
        select count(*)
           into i
        From tdvadm.t_ctb_movimentooc m
        where to_char(m.ctb_movimento_dtmovto,'YYYYMM') = vReferencia;
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cPcontaSaldoCC    Then -- 2 - PConta Saldo Centro de Custo
        select count(*)
           into i
        From tdvadm.t_ctb_pcontasaldocc m
        where m.ctb_referencia_codigo = vReferencia;
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cRateiaReceita    Then -- 3 - Rateio receita 
        vAtualiza := 'N';
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cVisaoBalancinho  Then -- 4 - Visao Balancinho   
        vAtualiza := 'N';
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cCustos           Then -- 5 - Custo
        vAtualiza := 'N';
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cIndicadores      Then -- 6 - Indicadores  
        select count(*)
          into i
        from tdvipf.t_ipf_indicadoresfrota ip
        where ip.ipf_indicadoresfrota_referencia = vReferencia;
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cRateoContrato    Then -- 7 - Rateio Contrato  
        vAtualiza :='N';
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cIndicadoresFrete Then -- 8 - Indicadores Frete
        Select count(*)
           into i        
        From tdvipf.t_ipf_indicadoresc c
        where c.ipf_reccust_referencia = vReferencia;
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cCarregaPlaca     Then -- 9 - Carrega Placa
        vAtualiza := 'N';
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cMIX              Then -- 10 - Mix
        vAtualiza := 'N';
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cDespesa          Then -- 11 - Carga de Despesa
        vAtualiza := 'N';
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cManutencao       Then -- 12 - Carga Manutencao
        vAtualiza := 'N';
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cSemParar         Then -- 13 - Carga Sem Parar
        vAtualiza := 'N';
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cCTF              Then -- 14 - Carga CTF
        vAtualiza := 'N';
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cCTFFrota         Then -- 15 - Carga CTFFrota
        vAtualiza := 'N';
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cPneus            Then -- 16 - Pneus
        vAtualiza := 'N';
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cPneusFrota       Then -- 17 - Pneus Frota
        vAtualiza := 'N';
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cIPVA             Then -- 18 - IPVA    
        vAtualiza := 'N';
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cSeguro           Then -- 19 - Seguro
        vAtualiza := 'N';
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cRastreamento     Then -- 20 - Rastreamento
        vAtualiza := 'N';
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cSalMotorista     Then -- 21 - Salario Motorista
        vAtualiza := 'N';
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cEngate           Then -- 22 - Engate
        vAtualiza := 'N';
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cValeFrete        Then -- 23 - Vale de Frete
        vAtualiza := 'N';
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cConhecimento     Then -- 24 - Conhecimento
        vAtualiza := 'N';
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cVfreteConhec     Then -- 25 - Vale de Frete x Conhecimento
        vAtualiza := 'N';
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cCalcFimViagem    Then -- 26 - Calcula Fim Viagem
        vAtualiza := 'N';
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cDTReccust        Then -- 27 - DTReccust
        vAtualiza := 'N';
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cCriaTMP          Then -- 28 - Cria Temporaria
        vAtualiza := 'N';
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cDepreciacaoFrota Then -- 29 - Depreciacao Frota
        vAtualiza := 'N';
     ElsIf vModulo = tdvipf.pkg_reccust_diretos2019.cMemo             Then -- 30 - Arrumando a FreteCarMemo
        vAtualiza := 'N';
     End If;

     If vAtualiza = 'S' Then
        If i > 0 Then
          vRealizado := 'S';
        Else
          vRealizado := 'N';
        End If;
  
        -- Se for erro Não acerta
        If ( substr(vProcessos,vModulo,1) in ('P','N') ) Then
    
           If vModulo = 1 Then
              vProcessos := vRealizado || substr(vProcessos,2);
           Else
              vProcessos := substr(vProcessos,1,vModulo-1) || vRealizado || substr(vProcessos,vModulo+1);
           End If;     
        End If;
     End If;  
 
  End loop;
  
  :pProcesso := vProcessos;
  
 
end;
3
pReferencia
1
202105
5
pProcessoE
1
SSSSNNNNNNNNNNNNNNNNNNNNNNNNNN
5
pProcesso
1
SSSSNSNSNNNNNNNNNNNNNNNNNNNNNN
5
4
vReferencia
vModulo
i
vProcessos
