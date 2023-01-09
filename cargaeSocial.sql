clear break
clear comp
clear col
set pagesize 0
set linesize 10000
set trimspool on
set tab off
set echo off
set feedback off
set recsep off
spool c:\REMUNERACAO_61139432000172_20180903180200.TXT;
SELECT LINHA FROM TDVADM.V_ESOCIAL_S1200 x where x.REF1 = '201808';
  and x.CPF not in 

SPOOL OFF;
spool c:\PAGRENDIMENTOS_61139432000172_20180903180200.TXT;
SELECT LINHA FROM TDVADM.V_ESOCIAL_S1210 x where x.REF1 = '201808';
--  and x.CPF not in ;
SPOOL OFF;  




select distinct trim(i.CPF) || ';' || trim(i.MATRICULA) || ';' || trim(i.NOME) || ';' || to_char(i.dtnascimento,'DDMMYYYY')
from tdvadm.V_CTB_IMPOSTOS_eSocial i 
where i.REF1 >= '201807'
--  and i.CPF = '35906726845'
;


select * from dba_source s
where s.TEXT like '%PAGRENDIMENTOS%'
  
  
delete tdvadm.t_car_esocial e
where length(trim(e.car_proprietario_cgccpfcodigo)) > 11


select * from tdvadm.t_glb_fornecedor f
where f.glb_fornecedor_cgccpf = '23737328404'
for update
  
  
--select count(*)
select *
--select '''' || e.car_proprietario_cgccpfcodigo || ''','
from tdvadm.t_car_esocial e
where 0 = 0
--  and e.car_esocial_status <> '200'
  and e.car_proprietario_cgccpfcodigo = '23737328404'
--  and e.car_esocial_mensagem = '[{"mensagens":["Timeout ao acessar fontes de dados esocial."]}]'
--  and e.car_esocial_mensagem like '%O nome existente no cadastro do CPF é%'
for update;

select  '%''79''%' from dual


select *
from dba_source s
where s.TEXT like '%''79''%'


update tdvadm.t_car_proprietario p
  set p.car_proprietario_razaosocial = (select trim(car_esocial_mensagem) from tdvadm.t_car_esocial s where trim(s.car_proprietario_cgccpfcodigo) = trim(p.car_proprietario_cgccpfcodigo)) 
where p.car_proprietario_cgccpfcodigo in ('10994279833',
'88836606920',
'03709526850')



update tdvadm.t_glb_fornecedor f
  set f.glb_fornecedor_nome = (select trim(car_esocial_mensagem) from tdvadm.t_car_esocial s where trim(s.car_proprietario_cgccpfcodigo) = trim(f.glb_fornecedor_cgccpf)) 
where f.glb_fornecedor_cgccpf in ('10994279833',
'88836606920',
'03709526850')

select * from tdvadm.t_car_proprietario p where p.car_proprietario_cgccpfcodigo = '4417811511625013'
  

    
select op.con_freteoper_paramqrystr,op.con_freteoper_id,op.con_freteoper_rota
from tdvadm.t_con_freteoper op
where op.cfe_integratdv_cod in (92,93)
  and op.cfe_statusfreteoper_status = 'AG'
 for update;
 
 
 select *
 from tdvadm.t_slf_contrato c
 where c.slf_contrato_descricao like '%HYDR%';
 
select *
from tdvadm.v_slf_clientecargas c
where c.contrato = 'C4600005947';


select *
from tdvadm.V_CTB_IMPOSTOS_eSocial i
where i.REF1 = '201809'
    

 
select i.REF1,count(*) qtde
from tdvadm.V_CTB_IMPOSTOS_eSocial i
where i.REF1 >= '201801'
group by i.REF1




select *
from tdvadm.t_car_proprietariosusp ps
where ps.car_proprietario_cgccpfcodigo in ;                    

-- Lotacao utilizada
select * from fpw.lotacoes l
where l.locodlot = 00010000000000;
-- codigo da Rubrica
select * from fpw.eventos e
where e.evcodevent = 3501

select distinct 
       --i.filial,
       i.REF1,
       i.CPF,
       i.MATRICULA,
       i.NOME,
       i.dtnascimento,
       i.CBO,
       i.dtcadastro,
       i.cidade,
       i.telefone,
       i.celular,
       i.origem
       ,i.FRETESP valor,
       i.INSS,
       i.QTDE,
       (select replace(replace(replace(e.car_esocial_mensagem,'[{"mensagens":["',''),'."]}]',''),'","',' - ')
        from tdvadm.t_car_esocial e 
        where e.car_proprietario_cgccpfcodigo = trim(i.CPF)) msg
from tdvadm.V_CTB_IMPOSTOS_eSocial i
where i.REF1 >= '201805'
  and i.CPF in (select rpad(e.car_proprietario_cgccpfcodigo ,20) 
                from tdvadm.t_car_esocial e 
                where 0 = 0
--                  and e.car_proprietario_cgccpfcodigo = trim(i.CPF)
                  and e.car_esocial_status <> '200')
                  

select *
from tdvadm.t_car_proprietario p
where 0 = 0
--  and p.car_proprietario_inps_codigo = '20483705958'
  and p.car_proprietario_cgccpfcodigo = '12115629647' 
for update;


select * from tdvadm.t_glb_fornecedor f
where f.glb_fornecedor_cgccpf in ('27433342826','10828359919')


select m.glb_rota_codigo rota,
       m.cax_boletim_data boletim,
       m.cax_movimento_sequencia seq,
       m.cax_movimento_cgccpf cpf,
       m.cax_movimento_favorecido favorecido,
       m.cax_movimento_valor valor
from tdvadm.t_cax_movimento m
where m.cax_movimento_cgccpf in ('11073079619',
                                 '14443907670')
  and m.cax_boletim_data >= '01/05/2018'
  and m.cax_operacao_codigo = '2046'
  




select *
from tdvadm.v_fpw_esocial e
where e.datapgto >= '01/05/2018'


-- verificando no caixa
create view tdvadm.v_fpw_esocial
as
select 'CAX' origem,
       m.glb_rota_codigo rota,
       m.cax_movimento_documento documento,
       m.cax_movimento_datanf datadoc,
       m.cax_boletim_data datapgto,
       m.cax_movimento_cgccpf CPF,
       f.glb_fornecedor_pis nit,
       f.glb_fornecedor_nome nome,
       f.glb_fornecedor_dtnascimento dtnas,
       f.glb_fornecedor_cbo codcbo,
       cbo.cbodescric ,
       m.cax_movimento_valor valor,
       (select m1.cax_movimento_valor
        from tdvadm.t_cax_movimento m1
        where m1.glb_rota_codigo = m.glb_rota_codigo
          and m1.cax_boletim_data = m.cax_boletim_data
          and m1.glb_rota_codigo_referencia = m.glb_rota_codigo_referencia
          and m1.cax_movimento_documento = m.cax_movimento_documento
          and m1.cax_movimento_cgccpf = m.cax_movimento_cgccpf
          and m1.cax_operacao_codigo = '1037'
--          and rownum = 1
          ) INSS
from tdvadm.t_cax_movimento m,
     tdvadm.t_glb_fornecedor f,
     fpw.cbo
where 0 = 0
--  and m.cax_boletim_data >= to_date ('01/05/2018','dd/mm/yyyy')
  and m.cax_movimento_cgccpf = f.glb_fornecedor_cgccpf (+)
  and f.glb_fornecedor_cbo = cbo.cbocodigo (+)
  and ( m.cax_operacao_codigo,
        m.glb_rota_codigo_operacao ) in (select op.cax_operacao_codigo,
                                                op.glb_rota_codigo_operacao
                                         from tdvadm.t_cax_operacao op
                                         where op.cax_operacao_reteminss = 'S')
union  
select 'CTP' origem,
       '010' rota,
       to_char(t.cpg_titulos_numtit) documento,
       t.cpg_titulos_dtemissao datadoc,
       t.cpg_titulos_dtemissao datapgto,
       t.glb_fornecedor_cgccpf cpf,
       f.glb_fornecedor_pis nit,
       f.glb_fornecedor_nome nome,
       f.glb_fornecedor_dtnascimento dtnas,
       f.glb_fornecedor_cbo cbo,
       cbo.cbodescric,
       t.cpg_titulos_vltotal valor,
       i.cpg_tituloimpostosvalor INSS
--       i.cpg_imposto_codigo codimp,
--       t.cax_operacao_codigo operacao,
--       ti.cpg_imposto_nome nomeimp,
from tdvadm.t_cpg_titulos t,
     tdvadm.t_glb_fornecedor f,
     tdvadm.t_cpg_tituloimpostos i,
     tdvadm.t_cpg_imposto ti,
     fpw.cbo
where 0 = 0
--  and t.cpg_titulos_dtemissao >= to_date('01/05/2018','dd/mm/yyyy')
  and f.glb_fornecedor_cbo = cbo.cbocodigo (+)
--  and length(trim(t.glb_fornecedor_cgccpf)) = 11
  and ti.cpg_imposto_codigo =8
  and t.glb_fornecedor_cgccpf = f.glb_fornecedor_cgccpf
  and t.cpg_titulos_numtit = i.cpg_titulos_numtit (+)
  and t.glb_fornecedor_cgccpf = i.glb_fornecedor_cgccpf (+)
  and i.cpg_imposto_codigo = ti.cpg_imposto_codigo;
  
  
select m.glb_rota_codigo ,
       m.cax_boletim_data ,
       m.cax_movimento_documento ,
       m.cax_operacao_codigo ,
--       op.cax_operacao_descricao ,
       m.cax_movimento_cgccpf ,
       m.cax_movimento_favorecido ,
       m.cax_movimento_valor 
from tdvadm.t_cax_movimento m
--     ,tdvadm.t_cax_operacao op
where m.cax_boletim_data >= '01/05/2018'
--  and m.cax_movimento_cgccpf = '82390916872'
  and m.cax_operacao_codigo = '1037'
  and m.glb_rota_codigo = '015'
--  and m.glb_rota_codigo_operacao = op.glb_rota_codigo_operacao
--  and m.cax_operacao_codigo = op.cax_operacao_codigo
for update
  

select *
from tdvadm.t_glb_fornecedor fv
where fv.glb_fornecedor_cgccpf = '03952823651'
for update
           
