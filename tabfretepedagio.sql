SELECT * FROM TDVADM.TESTEVALE;

  alter table tdvadm.testevale location (PLANS:'FRACIONADOSP.csv',
                                         PLANS:'FRACIONADOMG.csv',
                                         PLANS:'FRACIONADONO.csv',
                                         PLANS:'LOTACAOSS.csv',
                                         PLANS:'LOTACAOEE.csv',
                                         PLANS:'LOTACAONN.csv');

ok  alter table tdvadm.testevale location (PLANS:'FRACIONADOSP.csv');

  alter table tdvadm.testevale location (PLANS:'FRACIONADOMG.csv');
ok  alter table tdvadm.testevale location (PLANS:'FRACIONADONO.csv');
ok  alter table tdvadm.testevale location (PLANS:'LOTACAOSS.csv');
ok  alter table tdvadm.testevale location (PLANS:'LOTACAOEE.csv');
ok  alter table tdvadm.testevale location (PLANS:'LOTACAONN.csv');

-- 4840
insert into   tdvadm.t_slf_clienteped
select distinct x.*
from (
select distinct x.grupo,
                x.cliente,
                x.codcarga,
                x.contrato,
                x.vigencia,
                'S',
                x.codveiculo,
                '99999',
                '99999',
                x.origem,
                x.destino,
--                valor valorT,
                to_number(replace(replace(nvl(valor,0),'.',''),',','.')) valor,
                x.des,
                x.codcli,
                nvl(trim(x.OUTRACOL),'99999'),
                nvl(trim(x.OUTRAENT),'99999')
from tdvadm.v_slf_calcfretekmpreimpcsv x 
where 0 = 0
--  AND x.protocolo = pXLS
--  and x.codcarga = '02'
--  and x.VALOR <> 0
  and trim(x.valor) not in  ('-', '0')
--  and x.ORIGEM = '3201209'
--  and x.DESTINO = '3205309'
  and substr(x.codverba,1,4) = 'D_PD'
  and x.CONTRATO = '5500058294-V-MG'
  and x.ORIGEM || x.DESTINO || valor not in ('320120932053094,24','320530932012094,24')
  and 0 = (select count(*)
           from tdvadm.t_slf_clienteped cp
           where cp.GLB_GRUPOECONOMICO_CODIGO = rpad(x.GRUPO,4)
             and cp.GLB_CLIENTE_CGCCPFCODIGO = rpad(x.CLIENTE,20)
             and cp.FCF_TPCARGA_CODIGO = rpad(x.CODCARGA,3)
             and cp.SLF_CONTRATO_CODIGO = rpad(x.CONTRATO,15)
             and trunc(cp.SLF_CLIENTEPED_VIGENCIA) = to_date(x.VIGENCIA,'DD/MM/YYYY')
             and cp.SLF_CLIENTEPED_ATIVO = 'S'
             and cp.FCF_TPVEICULO_CODIGO = rpad(trim(x.CODVEICULO),3)
             and cp.GLB_LOCALIDADE_CODIGOORI = '99999'
             and cp.GLB_LOCALIDADE_CODIGODES = '99999'
             and cp.GLB_LOCALIDADE_CODIGOORIIB = rpad(x.ORIGEM,8)
             and cp.GLB_LOCALIDADE_CODIGODESIB = rpad(x.DESTINO,8)
             and cp.GLB_LOCALIDADE_OUTRACOLETAI = rpad(nvl(trim(x.OUTRACOL),'99999'),8)
             and cp.GLB_LOCALIDADE_OUTRAENTREGAI = rpad(nvl(trim(x.OUTRAENT),'99999'),8))
) x;

commit;



select --x.grupo,
       --         x.cliente,
       --         x.codcarga,
                x.contrato,
                x.vigencia,
       --         x.codveiculo,
                x.origem,
                tdvadm.fn_busca_codigoibge(x.ORIGEM,'IBD') descori,
                x.destino,
                tdvadm.fn_busca_codigoibge(x.destino,'IBD') descdest,
                x.des,
       --         x.codcli,
       --         nvl(trim(x.OUTRACOL),'99999') OUTRACOL,
       --         nvl(trim(x.OUTRAENT),'99999') OUTRAENT,
                count(distinct x.valor) qtde
from tdvadm.v_slf_calcfretekmpreimpcsv x 
where 0 = 0
 and substr(x.CODVERBA,1,4) = 'D_PD' 
group by x.grupo,
                x.cliente,
                x.codcarga,
                x.contrato,
                x.vigencia,
                x.codveiculo,
                x.origem,
                tdvadm.fn_busca_codigoibge(x.ORIGEM,'IBD'),
                x.destino,
                tdvadm.fn_busca_codigoibge(x.destino,'IBD'),
                x.des,
                x.codcli,
                nvl(trim(x.OUTRACOL),'99999'),
                nvl(trim(x.OUTRAENT),'99999')
having count(distinct x.valor) > 1
                

--  AND x.protocolo = pXLS
--  and x.codcarga = '02'
--  and x.VALOR <> 0
  and trim(x.valor) not in  ('-', '0')
  and x.ORIGEM = '3201209'
  and x.DESTINO = '3205309'
  and substr(x.codverba,1,4) = 'D_PD'





select *
from tdvadm.t_usu_aplicacao ap
where ap.usu_aplicacao_nomeprojeto like '%prj_carreg%'
for update
  


select * from dba_source s
where s.TEXT like '%Cte_Devolucao%'
where s.TEXT like '%ctrc_localColeta%'

tdvadm.PKG_FIFO_RECEBIMENTO;
tdvadm.pkg_fifo;

select co.arm_armazem_codigo armazem,
       co.arm_coleta_dtgravacao gravacaocol,
       co.arm_coletaocor_codigo ocorrencia,
       co.xml_coleta_numero asn,
       co.arm_coleta_entcoleta entcol,
       co.arm_coleta_ncompra coleta,
       co.arm_coleta_flagquimico quimico,
       an.arm_nota_qtdelimit qtdelimit,
       co.arm_coleta_tpcoleta tpcoleta,
       oc.arm_coletaocor_descricao ocorrencia,
       oc.arm_coletaocor_cancelacoleta occanc,
       oc.arm_coletaocor_encerradig ocencerra,
       co.slf_contrato_codigo contratoco,
       an.slf_contrato_codigo contratont,
       an.usu_usuario_codigo usunota,
       an.arm_nota_numero nota,
       an.glb_cliente_cgccpfremetente remetente,
       an.glb_tpcarga_codigo carganota,
       co.fcf_tpcarga_codigo cargacol,
       co.fcf_tpveiculo_codigo veiccol,
       j.arm_janelacons_sequencia jancod,
       j.arm_janelacons_dtinicio janini,
       j.arm_janelacons_dtfim janfim,
       j.arm_janelacons_qtdenf qtdenota,
       j.arm_janelacons_pesocons pesocons,
       j.arm_janelacons_qtdectenfs qtdcte,
       an.con_conhecimento_codigo ctecd,
       an.con_conhecimento_serie ctesr,
       an.glb_rota_codigo ctert,
       tdvadm.fn_busca_conhec_verba(an.con_conhecimento_codigo,an.con_conhecimento_serie,an.glb_rota_codigo,'D_FRPSVO') Frete,
       tdvadm.fn_busca_conhec_verba(an.con_conhecimento_codigo,an.con_conhecimento_serie,an.glb_rota_codigo,'D_PD') Pedagio,
       tdvadm.fn_busca_conhec_verba(an.con_conhecimento_codigo,an.con_conhecimento_serie,an.glb_rota_codigo,'I_TTPV') vlrtotal
from tdvadm.t_arm_coleta co,
     tdvadm.t_arm_nota an,
     tdvadm.t_glb_cliente cl,
     tdvadm.t_arm_coletaocor oc,
     tdvadm.t_arm_janelacons j
where 0 = 0 
  and co.slf_contrato_codigo is not null
--  and trunc(co.arm_coleta_dtgravacao) >= sysdate -5
  and rpad(co.arm_coleta_cnpjpagadorferete,20) = cl.glb_cliente_cgccpfcodigo (+)
  and cl.glb_grupoeconomico_codigo (+) = '0020'
  and co.arm_coletaocor_codigo = oc.arm_coletaocor_codigo (+)
  and co.arm_coleta_ncompra = an.arm_coleta_ncompra (+)
  and co.arm_coleta_ciclo = an.arm_coleta_ciclo (+)
  and an.arm_janelacons_sequencia = j.arm_janelacons_sequencia (+)
;
select *
from tdvadm.t_arm_coleta co
where co.slf_contrato_codigo is not null






select *
from tdvadm.v_slf_tabelakm km
where km.contrato = '5500058294-V-SP'
  and km.codcarga = '10';
  
select *
from tdvadm.t_slf_calcfretekm k
where k.slf_reccust_codigo = 'D_FRPSVO'
  and (k.slf_tabela_codigo,
       k.slf_tabela_saque) in (select ta.slf_tabela_codigo,
                                      ta.slf_tabela_saque
                               from tdvadm.t_slf_tabela ta
                               where ta.slf_tabela_contrato = '5500058294-V-SP'
                                 and substr(ta.fcf_tpcarga_codigo,1,2) = '10'
                                 and ta.slf_tabela_coletaentrega = 'E');
                                 
select *
from tdvadm.
