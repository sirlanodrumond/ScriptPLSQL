PL/SQL Developer Test script 3.0
67
declare 

  vTabela varchar2(30);
  vArqCSV varchar2(30);
  vComando varchar2(100);
  pxls     varchar2(10);
  pstatus  char(1);
  pmessage clob;
begin
  -- Call the procedure
  pxls := '999999';

-- FRACIONADOSP

-- FRACIONADOMG
-- LOTACAOEE
-- LOTACAOSS

  vArqCSV := 'LOTACAOEE_20190405.csv';
  vTabela := 'tdvadm.t_edi_integracsv';
  vComando := 'ALTER TABLE ' || vTabela || ' LOCATION (''' || vArqCSV || ''')';

  execute immediate(vComando);



  SYSTEM.pkg_glb_context.sp_set_vlr_PROCESSOUNICO('vTABFRETETAB',vArqCSV);
  tdvadm.pkg_slf_tabelas.sp_criaatulizaValores(pxls => pxls,
                                               pstatus => pstatus,
                                               pmessage => pmessage);


  If tdvadm.pkg_slf_tabelas.vTipoTab = 'AMB' then
     tdvadm.pkg_slf_tabelas.vTipoRodando := 'FOB';                                              
     tdvadm.pkg_slf_tabelas.sp_criaatulizaValores(pxls => pxls,
                                                  pstatus => pstatus,
                                                  pmessage => pmessage);
  End If;

/*
  vArqCSV := 'LOTACAOEE.csv';
  vTabela := 'tdvadm.testevale';
  vComando := 'ALTER TABLE ' || vTabela || ' LOCATION (''' || vArqCSV || ''')';

  execute immediate(vComando);
  
  SYSTEM.pkg_glb_context.sp_set_vlr_PROCESSOUNICO('vTABFRETETAB','LOTACAOEE.csv');
  tdvadm.pkg_slf_tabelas.sp_criaatulizaValores(pxls => pxls,
                                               pstatus => pstatus,
                                               pmessage => pmessage);


  vArqCSV := 'LOTACAOSS.csv';
  vTabela := 'tdvadm.testevale';
  vComando := 'ALTER TABLE ' || vTabela || ' LOCATION (''' || vArqCSV || ''')';

  execute immediate(vComando);
  
  SYSTEM.pkg_glb_context.sp_set_vlr_PROCESSOUNICO('vTABFRETETAB','LOTACAOSS.csv');
  tdvadm.pkg_slf_tabelas.sp_criaatulizaValores(pxls => pxls,
                                               pstatus => pstatus,
                                               pmessage => pmessage);

*/


end;
3
pxls
1
999999
-5
pstatus
1
N                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
-5
pmessage
1
<CLOB>
-112
9
vLinha.VERBA
pStatus
vAuxiliar
vCriaTabela
vNrLinha
vLinha.TABELA
vLinha.CONTRATO
vErro
pMessage
