PL/SQL Developer Test script 3.0
101
Declare

  vTabela varchar2(30);
  vArqCSV varchar2(200);
  vComando varchar2(200);

begin
  -- Call the procedure

-- FRACIONADOSP

-- FRACIONADOMG
-- LOTACAOEE
-- LOTACAOSS

  vArqCSV := 'LOTACAOSS_20190405.csv';
  vTabela := 'tdvadm.t_edi_integracsv';
  vComando := 'ALTER TABLE ' || vTabela || ' LOCATION (''' || vArqCSV || ''')';

  execute immediate(vComando);

-- RETURN;

  tdvadm.pkg_slf_tabelas.sp_criaatulizatabela(pxls => :pxls,
                                              pstatus => :pstatus,
                                              pmessage => :pmessage);


-- Para verificar se criou tabela
/*
select ta.slf_tabela_codigo,ta.slf_tabela_saque,ta.slf_tabela_contrato
from tdvadm.t_slf_tabela ta
where trunc(ta.slf_tabela_dtgravacao) = trunc(sysdate);
*/



  -- Criar a tabela andes de rodar
/*
select * from TDVADM.T_SLF_TABELANOVACARGA t for update;


 delete TDVADM.T_SLF_TABELANOVACARGA t;
insert into TDVADM.T_SLF_TABELANOVACARGA 
select distinct '999999' protocolo,
       'CSV' planilha,
       null sistema,
       1 SHEET_NR,
       null SHEET_NAME,
       null ROW_NR,
       null TIPOLINHA,
       null TABELA,
       'CIF' TIPOTAB,
       i.edi_integra_col04 COLENT,
       i.edi_integra_col05 VIGENCIA,
       i.edi_integra_col06 GRUPO,
       i.edi_integra_col07 CLIENTE,
       i.edi_integra_col08 CONTRATO,
       i.edi_integra_col09 CARGA,
       i.edi_integra_col10 VEICULO,
       0 PESODE,
       0 PESOATE,
       0 KMDE,
       0 KMATE,
       null TPORIGEM,
       null ORIGEM,
       null TPDESTINO,
       null DESTINO,
       0 VALOR,
       null DES,
       null TIPO,
       null COMIMP,
       null CODCLI,
       null VERBA,
       0 LIMITE,
       0 VALORE,
       null DESE,
       0 VALORFIXO,
       null DESFIXO,
       0 RAIOKMORIGEM,
       0 RAIOKMDESTINO,
       i.edi_integra_col32 CODCARGA,
       i.edi_integra_col33 CODVEICULO,
       null CODTPORIGEM,
       null CODTPDESTINO,
       null CODVERBA,
       null OUTRACOL,
       null OUTRAENT
from tdvadm.t_edi_integracsv i
where nvl(i.edi_integra_col04,'COLENT') <> 'COLENT'
      and nvl( i.edi_integra_col05,'VIGENCIA') <> 'VIGENCIA'
      and nvl( i.edi_integra_col06,'GRUPO') <> 'GRUPO'
;

update TDVADM.T_SLF_TABELANOVACARGA x
  set x.row_nr = rownum;
  
*/


end;
3
pxls
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
2
vNrLinha
vLinha.CODVERBA
