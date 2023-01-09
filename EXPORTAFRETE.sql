set echo off
set verify off
set feedback off
ttitle off
set heading off
-- set page size 0
set line size 2000;
--spool 5500058294-M-SP.csv

--select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
--select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
--from tdvadm.v_slf_tabelakm tk where tk.contrato = '5500058294-M-SP' and tk.verbacod = 'D_FRPSVO' order by 1 desc;

--spool off
spool 5500058294-V-MG.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500058294-V-MG' and tk.verbacod = 'D_FRPSVO' order by 1 desc;

spool off
spool 5500058294-V-SP.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500058294-V-SP' and tk.verbacod = 'D_FRPSVO' order by 1 desc;

spool off
spool 5500058294-M-MG.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500058294-M-MG' and tk.verbacod = 'D_FRPSVO' order by 1 desc;

spool off



set echo off
set verify off
set feedback off
ttitle off
set heading off
-- set page size 0
set line size 2000;

spool 5500057918-V-NN.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500057918-V-NN' and tk.verbacod = 'D_FRPSVO' order by 1 desc;

spool off

spool 5500057918-V-EE.csv


select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500057918-V-EE' and tk.verbacod = 'D_FRPSVO' order by 1 desc;

spool off
spool 5500057918-M-NN.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500057918-M-NN' and tk.verbacod = 'D_FRPSVO' order by 1 desc;

spool off

spool 55000057896-DOR.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '55000057896-DOR' and tk.verbacod = 'D_FRPSVO' order by 1 desc;

spool off
spool 5500058294-V-NO.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500058294-V-NO' and tk.verbacod = 'D_FRPSVO' order by 1 desc;

spool off
spool 5500057918-M-EE.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500057918-M-EE' and tk.verbacod = 'D_FRPSVO' order by 1 desc;

spool off
spool 5500057877-RMF.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500057877-RMF' and tk.verbacod in ('D_FRPSVO','D_PD') order by 1 desc;

spool off
spool 5500057902-DX.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500057902-DX' and tk.verbacod in ('D_FRPSVO','D_PD') order by 1 desc;

spool off
spool 5500057880-ISO.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500057880-ISO' and tk.verbacod in ('D_FRPSVO','D_PD') order by 1 desc;

spool off
spool 5500057880-INS.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500057880-INS' and tk.verbacod in ('D_FRPSVO','D_PD') order by 1 desc;

spool off
spool 5500057870-RT.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500057870-RT' and tk.verbacod in ('D_FRPSVO','D_PD') order by 1 desc;

spool off
spool 55000057895-BM.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '55000057895-BM' and tk.verbacod in ('D_FRPSVO','D_PD') order by 1 desc;

spool off



spool 5500057918-M-SS.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500057918-M-SS' and tk.verbacod = 'D_FRPSVO' order by 1 desc;

spool off
spool 5500057918-V-SS.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500057918-V-SS' and tk.verbacod = 'D_FRPSVO' order by 1 desc;

spool off
spool 5500058294-M-NO.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500058294-M-NO' and tk.verbacod = 'D_FRPSVO' order by 1 desc;

spool off



