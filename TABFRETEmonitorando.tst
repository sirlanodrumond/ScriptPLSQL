PL/SQL Developer Test script 3.0
18
-- Created on 29/03/2019 by DESENV 
declare 
  -- Local variables here
  i integer;
begin
  -- Test statements here
 create view v_TABFRETEMonitora
 as
 select SYS_CONTEXT('PROCESSOUNICO','vTABFRETETAB') Tabela,
        SYS_CONTEXT('PROCESSOUNICO','vTABFRETEHORAi') horai,
        SYS_CONTEXT('PROCESSOUNICO','vTABFRETETOTREG') TotTABReg,
        SYS_CONTEXT('PROCESSOUNICO','vTABFRETEQTDEREG') TABReglidos,
        to_number(SYS_CONTEXT('PROCESSOUNICO','vTABFRETETOTREG')) - (SYS_CONTEXT('PROCESSOUNICO','vTABFRETEQTDEREG')) Falta
        SYS_CONTEXT('PROCESSOUNICO','vTABFRETEHORAf') horaf
 from dual;
         

end;
6
var0
0
5
var1
0
5
var2
0
5
var3
0
5
var5
0
3
var4
0
5
0
