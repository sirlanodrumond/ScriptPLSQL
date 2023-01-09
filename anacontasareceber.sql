select * from TDVADM.V_SLF_TABELANOVACARGA t
where t.planilha = '200820161938549.csv';

migdv.pkg_migracao_sap;
VF 030273-A1-023-2
select x.chave ,count(*) 
from migdv.v_contaapagar x
where x.bldat >= '20200730'
group by x.chave

select *
from migdv.v_contaapagar x 
where x.chave in ('119335A14211', -- 28
                  '389373A10112', -- 8
                  '395267A10112', -- 7
                  '119335A14212', -- 6
                  '192023A11601') -- 2


select * from tdvadm.t_ctb_origem

select *
from tdvadm.t_ctb_movimento m
where m.ctb_movimento_dtmovto >= '01/08/2020'
  and substr(x.chave) = '119335A14211'
  

select *
from tdvadm.

 
select * from tdvadm.v_lock_tables;
select * from tdvadm.v_kill_sessoes k
where k.PROGRAM like '%pl%'


ALTER SYSTEM DISCONNECT SESSION '21,5694' IMMEDIATE;




select * from tdvadm.t_uti_geraplanilha g
where g.uti_geraplanilha_titulo in ('CTB - Relação de Fretes a Pagar',
                                    'CTB - Relação de Titulos em Aberto por Fornecedor',
                                    'CTB - Relação de Fretes a Faturar',
                                    'CTB - Relação de Titulos em Aberto_Por_Cliente')
                                    

