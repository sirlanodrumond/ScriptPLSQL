PL/SQL Developer Test script 3.0
34
declare 

  vTabela varchar2(30);
  vArqCSV varchar2(30);
  vComando varchar2(100);
  
begin
  -- Call the procedure

-- FRACIONADOSP_20190405.csv

-- FRACIONADOMG
-- LOTACAOEE
-- LOTACAOSS

  vArqCSV := 'LOTACAOSS_20190405.csv';
  vTabela := 'tdvadm.t_edi_integracsv';
  vComando := 'ALTER TABLE ' || vTabela || ' LOCATION (''' || vArqCSV || ''')';

  execute immediate(vComando);

  tdvadm.pkg_slf_tabelas.sp_criticaplanilha(pprotocolo => :pprotocolo,
                                            pstatus => :pstatus,
                                            pmessage => :pmessage);

  If tdvadm.pkg_slf_tabelas.vTipoTab = 'AMB' then
     tdvadm.pkg_slf_tabelas.vTipoRodando := 'FOB';
     tdvadm.pkg_slf_tabelas .sp_criticaplanilha(pprotocolo => :pprotocolo,
                                                pstatus => :pstatus,
                                                pmessage => :pmessage);
  End If;


end;
3
pprotocolo
1
999999
5
pstatus
1
N                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
5
pmessage
1
<CLOB>
112
6
vAuxiliarT
c_msg.TIPOTAB
tdvadm.pkg_slf_tabelas.vTipoTab
vComando
vCerto
vErrado
