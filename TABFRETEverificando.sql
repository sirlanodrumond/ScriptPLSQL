select *
from glbadm.v_job_todos t
where 0 = 0
  AND lower(t.WHAT) like '%sp_criaatulizavalores%'

select *
from glbadm.v_job_rodando t
;

SELECT *

-- Novos contratos
select tk.contrato,
       TK.tipo
--       ,tk.vigencia
--       ,tk.carga
--       ,tk.veiculo
       ,COUNT(*) QTDE
from tdvadm.v_slf_tabelakm tk
where tk.contrato in ('5500057877-RMF', 
                      '5500057880-INS', 
                      '5500057902-DX',
                      '5500057870-RT', 
                      '5500057880-ISO', 
                      '55000057895-BM',
                      '55000057896-DOR',
                      '5500057918-V-NN',
                      '5500057918-V-EE',
                      '5500057918-V-SS',
                      '5500058294-V-NO',
                      '5500058294-V-SP',
                      '5500058294-V-MG')
GROUP BY tk.contrato
         ,TK.tipo
--         ,tk.vigencia
--         ,tk.carga
--         ,tk.veiculo                      
                      
;

select * from tdvadm.t_slf_tabelaNovaCarga nc;

select k.slf_tabela_contrato contrato,
       k.slf_tabela_codigo tab,
       k.slf_tabela_saque sq,
       k.slf_tabela_tipo tipo,
       k.slf_tabela_vigencia vigencia,
       k.fcf_tpcarga_codigo carga,
       k.fcf_tpveiculo_codigo veic, 
       k.slf_tabela_coletaentrega entcol,
       (select count(*)
        from tdvadm.t_slf_calcfretekm km
        where 0 = 0
          AND km.slf_tabela_codigo = k.slf_tabela_codigo
          and km.slf_tabela_saque = k.slf_tabela_saque) qtdefrete
from tdvadm.t_slf_tabela k
--update tdvadm.t_slf_calcfretekm k
--  set k.slf_tpcalculo_codigo = '315'
where 0 = 0
--  and k.slf_tpcalculo_codigo = '041'
--  and k.fcf_tpcarga_codigo not in ('01')
  and (k.slf_tabela_codigo,
       k.slf_tabela_saque) in (select ta.slf_tabela_codigo,
                                      ta.slf_tabela_saque
                               from tdvadm.t_slf_tabela ta
                               where ta.slf_tabela_contrato in ('5500057877-RMF',  
                                                                '5500057880-INS', 
                                                                '5500057902-DX',
                                                                '5500057870-RT', 
                                                                '5500057880-ISO', 
                                                                '55000057895-BM',
                                                                '55000057896-DOR',
                                                                '5500057918-V-NN',
                                                                '5500057918-V-EE',
                                                                '5500057918-V-SS',
                                                                '5500058294-V-NO',
                                                                '5500058294-V-SP',
                                                                '5500058294-V-MG'))
ORDER by K.SLF_TABELA_CONTRATO
--         ,k.fcf_tpcarga_codigo
--         ,k.slf_tabela_tipo
--         ,k.slf_tabela_coletaentrega
--         ,k.fcf_tpveiculo_codigo
for update
  ;

SELECT CC.contrato,
       CC.VIGENCIA,
       CC.Tpcarga,
       CC.tpfretepesq,
       CC.perctex,
       CC.percentquimico,
       CC.percentoutbound,
       CC.percttransf
FROM TDVADM.V_SLF_CLIENTECARGAS CC
WHERE CC.contrato IN ('5500057877-RMF',  
                      '5500057880-INS', 
                      '5500057902-DX',
                      '5500057870-RT', 
                      '5500057880-ISO', 
                      '55000057895-BM',
                      '55000057896-DOR',
                      '5500057918-V-NN',
                      '5500057918-V-EE',
                      '5500057918-V-SS',
                      '5500058294-V-NO',
                      '5500058294-V-SP',
                      '5500058294-V-MG')
;
SELECT CC.Slf_Contrato_Codigo contrato,
       CC.SLF_CLIENTECARGAS_VIGENCIA VIGENCIA,
       CC.Fcf_Tpcarga_Codigo Codigo,
       CC.Fcf_Tpcarga_Codigopesq Codigopesq,
       CC.Slf_Clientecargas_Percntex Percntex,
       CC.Slf_Clientecargas_Percntqm Percntqm,
       CC.Slf_Clientecargas_Percntout Percntout,
       CC.Slf_Clientecargas_Percnttra Percnttra
FROM TDVADM.T_SLF_CLIENTECARGAS CC
WHERE CC.SLF_CONTRATO_CODIGO IN ('5500057877-RMF',  
                      '5500057880-INS', 
                      '5500057902-DX',
                      '5500057870-RT', 
                      '5500057880-ISO', 
                      '55000057895-BM',
                      '55000057896-DOR',
                      '5500057918-V-NN',
                      '5500057918-V-EE',
                      '5500057918-V-SS',
                      '5500058294-V-NO',
                      '5500058294-V-SP',
                      '5500058294-V-MG')
FOR UPDATE
  
           
         

-- Alterando tabela externa
ALTER TABLE tdvadm.testevale LOCATION ( 'FRACIONADOMG.csv' );



select 


select COUNT(*) from TDVADM.V_slf_calcfretekmpreimp;
select COUNT(*) from TDVADM.V_slf_calcfretekmpreimpCSV;
select COUNT(*) from tdvadm.T_SLF_CALCFRETEKMIMP t;
select count(*) from tdvadm.t_slf_tabelaNovaCarga nc;
select * from tdvadm.testevale;


select * from glbadm.v_job_rodando


      select distinct trim(x.VIGENCIA)
      from tdvadm.v_slf_calcfretekmpreimpcsv X
      where X.CONTRATO IS NOT NULL
        and x.ROW_NR > 1;

      select x.CONTRATO,
             x.TIPOTAB,
             x.VIGENCIA,
             x.CARGA,
             x.VEICULO,
             x.CODCARGA,
             x.CODVEICULO,
             count(*) qtde
      from tdvadm.v_slf_calcfretekmpreimpcsv X
      where X.CONTRATO IS NOT NULL
        and x.ROW_NR > 1
       group by x.CONTRATO,x.TIPOTAB,
             x.VIGENCIA,
             x.CARGA,
             x.VEICULO,
             x.CODCARGA,
             x.CODVEICULO;



       select x.protocolo,x.colent,x.CARGA,count(*) qtde
       from tdvadm.v_slf_calcfretekmpreimpcsv X
       where X.CONTRATO IS NOT NULL
         and x.ROW_NR > 1
       group by x.protocolo,x.colent,x.CARGA

select *
from tdvadm.v_slf_calcfretekmpreimpcsv X
where x.VIGENCIA = '43518';

select * from tdvadm.v_slf_tabelakm t
where t.contrato = '';



select a.*
from tdvadm.t_arm_nota a
where a.arm_armazem_codigo = '36'
  and a.arm_nota_numero = 666666
for update
  


select ta.slf_tabela_codigo,
       ta.slf_tabela_saque,
       ta.slf_tabela_tipo,
       ta.slf_tabela_coletaentrega,
       ta.slf_tabela_contrato,
       ta.fcf_tpcarga_codigo,
       ta.fcf_tpveiculo_codigo
from tdvadm.t_slf_tabela ta
where 0 = 0
--  and ta.slf_tabela_vigencia = '22/02/2019';
  and ta.slf_tabela_contrato = '5500058294-V-MG'
;
select *
from tdvadm.t_slf_clientecargas cc
where cc.slf_contrato_codigo = '5500058294-V-MG'
for update;


select *
from tdvadm.v_slf_clientecargas vc
where vc.contrato = '5500058294-V-MG';

  
select X.CONTRATO,x.codverba,tv.slf_reccust_descricao verba,COUNT(*) QTDE
from tdvadm.v_slf_calcfretekmpreimpcsv X,
     tdvadm.t_slf_reccust tv
where 0 = 0
--  and X.CONTRATO IS NOT NULL
  and x.ROW_NR > 1
  and TRIM(nvl(x.codverba,'x')) = TRIM(nvl(tv.slf_reccust_codigo (+),'x'))
GROUP BY X.CONTRATO,x.codverba,tv.slf_reccust_descricao;

CREATE TABLE 
select X.CONTRATO,x.codverba,tv.slf_reccust_descricao verba,tdvadm.pkg_glb_common.Fn_Limpa_Campo(x.codverba) calc,COUNT(*) QTDE
from tdvadm.v_slf_calcfretekmpreimpcsv X,
     tdvadm.t_slf_reccust tv
where 0 = 0
--  and X.CONTRATO IS NOT NULL
  and x.ROW_NR > 1
  and TRIM(rpad(replace('"','',x.codverba),10)) = TRIM(tv.slf_reccust_codigo (+))
GROUP BY X.CONTRATO,x.codverba,tv.slf_reccust_descricao,tdvadm.pkg_glb_common.Fn_Limpa_Campo(x.codverba);

5500058294-V-MG
5500058294-V-MG
5500058294-V-MG



select * from tdvadm.t_slf_reccust tv

select replace(

5500058294-V-MG
5500058294-V-MG
5500058294-V-MG

                        
 select *
 from tdvadm.t_arm_nota an
 where an.arm_nota_dtinclusao >= '22/03/2018'
   and an.slf_contrato_codigo = '5900057491'
   
    
  
select *
from 

