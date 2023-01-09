set echo off
set verify off
set feedback off
ttitle off
set heading off
-- set page size 0
set line size 2000;
 spool 5500057918-V-NN-ped.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' || CP.SLF_CLIENTEPED_VALOR || ';' ||tk.codcli || ';' || 'D_PD;INSERIR' 
from tdvadm.v_slf_tabelakm tk,
      TDVADM.T_SLF_CLIENTEPED CP 
where tk.Contrato = '5500057918-V-NN' 
  and tk.verbacod = 'D_FRPSVO' 
  AND TK.grupo = CP.GLB_GRUPOECONOMICO_CODIGO
  AND TK.cliente = CP.GLB_CLIENTE_CGCCPFCODIGO
  AND TK.contrato = CP.SLF_CONTRATO_CODIGO
  AND TK.codcarga = CP.FCF_TPCARGA_CODIGO
  AND TK.codveic = CP.FCF_TPVEICULO_CODIGO
  AND TK.origemib = CP.GLB_LOCALIDADE_CODIGOORIIB
  AND TK.destinoib = CP.GLB_LOCALIDADE_CODIGODESIB
UNION
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500057918-V-NN' and tk.verbacod = 'D_PD' order by 1 desc;

 spool off

 spool 5500057918-V-EE-ped.csv


select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' || CP.SLF_CLIENTEPED_VALOR || ';' ||tk.codcli || ';' || 'D_PD;INSERIR' 
from tdvadm.v_slf_tabelakm tk,
      TDVADM.T_SLF_CLIENTEPED CP 
where tk.Contrato = '5500057918-V-EE' 
  and tk.verbacod = 'D_FRPSVO' 
  AND TK.grupo = CP.GLB_GRUPOECONOMICO_CODIGO
  AND TK.cliente = CP.GLB_CLIENTE_CGCCPFCODIGO
  AND TK.contrato = CP.SLF_CONTRATO_CODIGO
  AND TK.codcarga = CP.FCF_TPCARGA_CODIGO
  AND TK.codveic = CP.FCF_TPVEICULO_CODIGO
  AND TK.origemib = CP.GLB_LOCALIDADE_CODIGOORIIB
  AND TK.destinoib = CP.GLB_LOCALIDADE_CODIGODESIB
UNION
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500057918-V-EE' and tk.verbacod = 'D_PD' order by 1 desc;

 spool off
 spool 5500057918-M-NN-ped.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' || CP.SLF_CLIENTEPED_VALOR || ';' ||tk.codcli || ';' || 'D_PD;INSERIR' 
from tdvadm.v_slf_tabelakm tk,
      TDVADM.T_SLF_CLIENTEPED CP 
where tk.Contrato = '5500057918-M-NN' 
  and tk.verbacod = 'D_FRPSVO' 
  AND TK.grupo = CP.GLB_GRUPOECONOMICO_CODIGO
  AND TK.cliente = CP.GLB_CLIENTE_CGCCPFCODIGO
  AND TK.contrato = CP.SLF_CONTRATO_CODIGO
  AND TK.codcarga = CP.FCF_TPCARGA_CODIGO
  AND TK.codveic = CP.FCF_TPVEICULO_CODIGO
  AND TK.origemib = CP.GLB_LOCALIDADE_CODIGOORIIB
  AND TK.destinoib = CP.GLB_LOCALIDADE_CODIGODESIB
UNION
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500057918-M-NN' and tk.verbacod = 'D_PD' order by 1 desc;

 spool off

 spool 55000057896-DOR-ped.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' || CP.SLF_CLIENTEPED_VALOR || ';' ||tk.codcli || ';' || 'D_PD;INSERIR' 
from tdvadm.v_slf_tabelakm tk,
      TDVADM.T_SLF_CLIENTEPED CP 
where tk.Contrato = '55000057896-DOR' 
  and tk.verbacod = 'D_FRPSVO' 
  AND TK.grupo = CP.GLB_GRUPOECONOMICO_CODIGO
  AND TK.cliente = CP.GLB_CLIENTE_CGCCPFCODIGO
  AND TK.contrato = CP.SLF_CONTRATO_CODIGO
  AND TK.codcarga = CP.FCF_TPCARGA_CODIGO
  AND TK.codveic = CP.FCF_TPVEICULO_CODIGO
  AND TK.origemib = CP.GLB_LOCALIDADE_CODIGOORIIB
  AND TK.destinoib = CP.GLB_LOCALIDADE_CODIGODESIB
UNION
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '55000057896-DOR' and tk.verbacod = 'D_PD' order by 1 desc;

 spool off
 spool 5500058294-V-NO-ped.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' || CP.SLF_CLIENTEPED_VALOR || ';' ||tk.codcli || ';' || 'D_PD;INSERIR' 
from tdvadm.v_slf_tabelakm tk,
      TDVADM.T_SLF_CLIENTEPED CP 
where tk.Contrato = '5500058294-V-NO' 
  and tk.verbacod = 'D_FRPSVO' 
  AND TK.grupo = CP.GLB_GRUPOECONOMICO_CODIGO
  AND TK.cliente = CP.GLB_CLIENTE_CGCCPFCODIGO
  AND TK.contrato = CP.SLF_CONTRATO_CODIGO
  AND TK.codcarga = CP.FCF_TPCARGA_CODIGO
  AND TK.codveic = CP.FCF_TPVEICULO_CODIGO
  AND TK.origemib = CP.GLB_LOCALIDADE_CODIGOORIIB
  AND TK.destinoib = CP.GLB_LOCALIDADE_CODIGODESIB
UNION
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500058294-V-NO' and tk.verbacod = 'D_PD' order by 1 desc;

 spool off
 spool 5500057918-M-EE-ped.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' || CP.SLF_CLIENTEPED_VALOR || ';' ||tk.codcli || ';' || 'D_PD;INSERIR' 
from tdvadm.v_slf_tabelakm tk,
      TDVADM.T_SLF_CLIENTEPED CP 
where tk.Contrato = '5500057918-M-EE' 
  and tk.verbacod = 'D_FRPSVO' 
  AND TK.grupo = CP.GLB_GRUPOECONOMICO_CODIGO
  AND TK.cliente = CP.GLB_CLIENTE_CGCCPFCODIGO
  AND TK.contrato = CP.SLF_CONTRATO_CODIGO
  AND TK.codcarga = CP.FCF_TPCARGA_CODIGO
  AND TK.codveic = CP.FCF_TPVEICULO_CODIGO
  AND TK.origemib = CP.GLB_LOCALIDADE_CODIGOORIIB
  AND TK.destinoib = CP.GLB_LOCALIDADE_CODIGODESIB
UNION
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500057918-M-EE' and tk.verbacod = 'D_PD' order by 1 desc;

 spool off
 spool 5500057877-RMF-ped.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' || CP.SLF_CLIENTEPED_VALOR || ';' ||tk.codcli || ';' || 'D_PD;INSERIR' 
from tdvadm.v_slf_tabelakm tk,
      TDVADM.T_SLF_CLIENTEPED CP 
where tk.Contrato = '5500057877-RMF' 
  and tk.verbacod = 'D_FRPSVO' 
  AND TK.grupo = CP.GLB_GRUPOECONOMICO_CODIGO
  AND TK.cliente = CP.GLB_CLIENTE_CGCCPFCODIGO
  AND TK.contrato = CP.SLF_CONTRATO_CODIGO
  AND TK.codcarga = CP.FCF_TPCARGA_CODIGO
  AND TK.codveic = CP.FCF_TPVEICULO_CODIGO
  AND TK.origemib = CP.GLB_LOCALIDADE_CODIGOORIIB
  AND TK.destinoib = CP.GLB_LOCALIDADE_CODIGODESIB
UNION
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500057877-RMF' and tk.verbacod in ('D_PD') order by 1 desc;

 spool off
 spool 5500057902-DX-ped.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' || CP.SLF_CLIENTEPED_VALOR || ';' ||tk.codcli || ';' || 'D_PD;INSERIR' 
from tdvadm.v_slf_tabelakm tk,
      TDVADM.T_SLF_CLIENTEPED CP 
where tk.Contrato = '5500057902-DX' 
  and tk.verbacod = 'D_FRPSVO' 
  AND TK.grupo = CP.GLB_GRUPOECONOMICO_CODIGO
  AND TK.cliente = CP.GLB_CLIENTE_CGCCPFCODIGO
  AND TK.contrato = CP.SLF_CONTRATO_CODIGO
  AND TK.codcarga = CP.FCF_TPCARGA_CODIGO
  AND TK.codveic = CP.FCF_TPVEICULO_CODIGO
  AND TK.origemib = CP.GLB_LOCALIDADE_CODIGOORIIB
  AND TK.destinoib = CP.GLB_LOCALIDADE_CODIGODESIB
UNION
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500057902-DX' and tk.verbacod in ('D_PD') order by 1 desc;

 spool off
 spool 5500057880-ISO-ped.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' || CP.SLF_CLIENTEPED_VALOR || ';' ||tk.codcli || ';' || 'D_PD;INSERIR' 
from tdvadm.v_slf_tabelakm tk,
      TDVADM.T_SLF_CLIENTEPED CP 
where tk.Contrato = '5500057880-ISO' 
  and tk.verbacod = 'D_FRPSVO' 
  AND TK.grupo = CP.GLB_GRUPOECONOMICO_CODIGO
  AND TK.cliente = CP.GLB_CLIENTE_CGCCPFCODIGO
  AND TK.contrato = CP.SLF_CONTRATO_CODIGO
  AND TK.codcarga = CP.FCF_TPCARGA_CODIGO
  AND TK.codveic = CP.FCF_TPVEICULO_CODIGO
  AND TK.origemib = CP.GLB_LOCALIDADE_CODIGOORIIB
  AND TK.destinoib = CP.GLB_LOCALIDADE_CODIGODESIB
UNION
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500057880-ISO' and tk.verbacod in ('D_PD') order by 1 desc;

 spool off
 spool 5500057880-INS-ped.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' || CP.SLF_CLIENTEPED_VALOR || ';' ||tk.codcli || ';' || 'D_PD;INSERIR' 
from tdvadm.v_slf_tabelakm tk,
      TDVADM.T_SLF_CLIENTEPED CP 
where tk.Contrato = '5500057880-INS' 
  and tk.verbacod = 'D_FRPSVO' 
  AND TK.grupo = CP.GLB_GRUPOECONOMICO_CODIGO
  AND TK.cliente = CP.GLB_CLIENTE_CGCCPFCODIGO
  AND TK.contrato = CP.SLF_CONTRATO_CODIGO
  AND TK.codcarga = CP.FCF_TPCARGA_CODIGO
  AND TK.codveic = CP.FCF_TPVEICULO_CODIGO
  AND TK.origemib = CP.GLB_LOCALIDADE_CODIGOORIIB
  AND TK.destinoib = CP.GLB_LOCALIDADE_CODIGODESIB
UNION
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500057880-INS' and tk.verbacod in ('D_PD') order by 1 desc;

 spool off
 spool 5500057870-RT-ped.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' || CP.SLF_CLIENTEPED_VALOR || ';' ||tk.codcli || ';' || 'D_PD;INSERIR' 
from tdvadm.v_slf_tabelakm tk,
      TDVADM.T_SLF_CLIENTEPED CP 
where tk.Contrato = '5500057870-RT' 
  and tk.verbacod = 'D_FRPSVO' 
  AND TK.grupo = CP.GLB_GRUPOECONOMICO_CODIGO
  AND TK.cliente = CP.GLB_CLIENTE_CGCCPFCODIGO
  AND TK.contrato = CP.SLF_CONTRATO_CODIGO
  AND TK.codcarga = CP.FCF_TPCARGA_CODIGO
  AND TK.codveic = CP.FCF_TPVEICULO_CODIGO
  AND TK.origemib = CP.GLB_LOCALIDADE_CODIGOORIIB
  AND TK.destinoib = CP.GLB_LOCALIDADE_CODIGODESIB
UNION
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500057870-RT' and tk.verbacod in ('D_PD') order by 1 desc;

 spool off
 spool 55000057895-BM-ped.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' || CP.SLF_CLIENTEPED_VALOR || ';' ||tk.codcli || ';' || 'D_PD;INSERIR' 
from tdvadm.v_slf_tabelakm tk,
      TDVADM.T_SLF_CLIENTEPED CP 
where tk.Contrato = '55000057895-BM' 
  and tk.verbacod = 'D_FRPSVO' 
  AND TK.grupo = CP.GLB_GRUPOECONOMICO_CODIGO
  AND TK.cliente = CP.GLB_CLIENTE_CGCCPFCODIGO
  AND TK.contrato = CP.SLF_CONTRATO_CODIGO
  AND TK.codcarga = CP.FCF_TPCARGA_CODIGO
  AND TK.codveic = CP.FCF_TPVEICULO_CODIGO
  AND TK.origemib = CP.GLB_LOCALIDADE_CODIGOORIIB
  AND TK.destinoib = CP.GLB_LOCALIDADE_CODIGODESIB
UNION
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '55000057895-BM' and tk.verbacod in ('D_PD') order by 1 desc;

 spool off



 spool 5500057918-M-SS-ped.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' || CP.SLF_CLIENTEPED_VALOR || ';' ||tk.codcli || ';' || 'D_PD;INSERIR' 
from tdvadm.v_slf_tabelakm tk,
      TDVADM.T_SLF_CLIENTEPED CP 
where tk.Contrato = '5500057918-M-SS' 
  and tk.verbacod = 'D_FRPSVO' 
  AND TK.grupo = CP.GLB_GRUPOECONOMICO_CODIGO
  AND TK.cliente = CP.GLB_CLIENTE_CGCCPFCODIGO
  AND TK.contrato = CP.SLF_CONTRATO_CODIGO
  AND TK.codcarga = CP.FCF_TPCARGA_CODIGO
  AND TK.codveic = CP.FCF_TPVEICULO_CODIGO
  AND TK.origemib = CP.GLB_LOCALIDADE_CODIGOORIIB
  AND TK.destinoib = CP.GLB_LOCALIDADE_CODIGODESIB
UNION
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500057918-M-SS' and tk.verbacod = 'D_PD' order by 1 desc;

 spool off
 spool 5500057918-V-SS-ped.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' || CP.SLF_CLIENTEPED_VALOR || ';' ||tk.codcli || ';' || 'D_PD;INSERIR' 
from tdvadm.v_slf_tabelakm tk,
      TDVADM.T_SLF_CLIENTEPED CP 
where tk.Contrato = '5500057918-V-SS' 
  and tk.verbacod = 'D_FRPSVO' 
  AND TK.grupo = CP.GLB_GRUPOECONOMICO_CODIGO
  AND TK.cliente = CP.GLB_CLIENTE_CGCCPFCODIGO
  AND TK.contrato = CP.SLF_CONTRATO_CODIGO
  AND TK.codcarga = CP.FCF_TPCARGA_CODIGO
  AND TK.codveic = CP.FCF_TPVEICULO_CODIGO
  AND TK.origemib = CP.GLB_LOCALIDADE_CODIGOORIIB
  AND TK.destinoib = CP.GLB_LOCALIDADE_CODIGODESIB
UNION
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500057918-V-SS' and tk.verbacod = 'D_PD' order by 1 desc;

 spool off
 spool 5500058294-M-NO-ped.csv

select 'tabela;saque;contrato;carga;veiculo;colent;pesode;pesoate;origemib;destinoib;valor;tk.codcli;verbacod;chavetabkm' from dual union 
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' || CP.SLF_CLIENTEPED_VALOR || ';' ||tk.codcli || ';' || 'D_PD;INSERIR' 
from tdvadm.v_slf_tabelakm tk,
      TDVADM.T_SLF_CLIENTEPED CP 
where tk.Contrato = '5500058294-M-NO' 
  and tk.verbacod = 'D_FRPSVO' 
  AND TK.grupo = CP.GLB_GRUPOECONOMICO_CODIGO
  AND TK.cliente = CP.GLB_CLIENTE_CGCCPFCODIGO
  AND TK.contrato = CP.SLF_CONTRATO_CODIGO
  AND TK.codcarga = CP.FCF_TPCARGA_CODIGO
  AND TK.codveic = CP.FCF_TPVEICULO_CODIGO
  AND TK.origemib = CP.GLB_LOCALIDADE_CODIGOORIIB
  AND TK.destinoib = CP.GLB_LOCALIDADE_CODIGODESIB
UNION
select tk.tabela || ';' ||tk.saque || ';' ||tk.contrato || ';' ||tk.carga || ';' ||tk.veiculo || ';' ||tk.colent || ';' ||tk.pesode || ';' ||tk.pesoate || ';' ||tk.origemib || ';' ||tk.destinoib || ';' ||tk.valor || ';' ||tk.codcli || ';' ||tk.verbacod || ';' ||tk.chavetabkm
from tdvadm.v_slf_tabelakm tk where tk.Contrato = '5500058294-M-NO' and tk.verbacod = 'D_PD' order by 1 desc;

 spool off
