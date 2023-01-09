select * from tdvadm.v_ctb_centrocustosintetico;
select * from tdvipf.v_ipf_centrocustorateado;

tdvadm.sp_ctb_movimentooc
    tdvadm.t_ctb_movimentoOC; 


select * from tdvadm.v_ctb_centrocustosintetico;
       tdvadm.t_ctb_movimentoOC
       tdvipf.t_ipf_ctbdepara -- Tem REFERENCIA
       tdvipf.t_ipf_pconta



select * from tdvipf.v_ipf_reccust;
       tdvipf.t_ipf_reccust
       tdvipf.t_ipf_conhec,
       tdvipf.t_ipf_valefrete

select * from tdvipf.t_ipf_indicadores;
       tdvipf.v_ipf_reccust

select * from tdvipf.v_ipf_centrocustorateado_pre;
       tdvadm.v_ctb_centrocustosintetico
       tdvipf.t_ipf_indicadores

select * from tdvipf.v_ipf_centrocustorateado_online x

tdvipf.v_ipf_reccust;
tdvipf.t_ipf_indicadores

-- criando a tabela de indicadores
select * from tdvipf.t_ipf_indicadores x where x.ipf_reccust_referencia = 'AAAAMM';

drop table tdvipf.t_ipf_indicadores;
delete tdvipf.t_ipf_indicadores i where i.ipf_reccust_referencia >= '201901';
create table tdvipf.t_ipf_indicadores
As
--insert into tdvipf.t_ipf_indicadores
select r.ipf_reccust_referencia,
--       r.ipf_valefrete_rota,  
--       r.ipf_conhec_rota,
       r.ipf_valefrete_centrocusto,
--       r.glb_tpmotorista_codigo,
       count(distinct r.ipf_conhec_chave) ipf_indicadores_qtdeCTECHAVE,

       max((select count(distinct r1.ipf_conhec_chave) 
        from tdvipf.v_ipf_reccust r1 
        where r1.ipf_reccust_referencia = r.ipf_reccust_referencia 
          and r1.ipf_valefrete_caixa is not null)) ipf_indicadores_qtdeCTETOT,
          
       max((select count(distinct r1.ipf_conhec_chave) 
        from tdvipf.v_ipf_reccust r1 
        where r1.ipf_reccust_referencia = r.ipf_reccust_referencia 
--          and r1.glb_tpmotorista_codigo = r.glb_tpmotorista_codigo
          and r1.ipf_valefrete_caixa is not null)) ipf_indicadores_qtdeCTETOTTPM,




       count(distinct substr(r.ipf_valefrete_chave,1,11)) ipf_indicadores_qtdeVFCHAVE,

       max((select count(distinct substr(r1.ipf_valefrete_chave,1,11)) 
        from tdvipf.v_ipf_reccust r1 
        where r1.ipf_reccust_referencia = r.ipf_reccust_referencia 
          and r1.ipf_valefrete_caixa is not null)) ipf_indicadores_qtdeVFTOT,
          
       max((select count(distinct substr(r1.ipf_valefrete_chave,1,11)) 
        from tdvipf.v_ipf_reccust r1 
        where r1.ipf_reccust_referencia = r.ipf_reccust_referencia 
--          and r1.glb_tpmotorista_codigo = r.glb_tpmotorista_codigo
          and r1.ipf_valefrete_caixa is not null)) ipf_indicadores_qtdeVFTOTTPM,

       0 ipf_indicadores_qtdefunc,
       0 ipf_indicadores_qtdefuncTOT,
         
       sum(r.RATCTFRETEPESO) RATCTFRETEPESOCHAVE,

       max((select sum(r1.RATCTFRETEPESO) 
        from tdvipf.v_ipf_reccust r1 
        where r1.ipf_reccust_referencia = r.ipf_reccust_referencia 
        and r1.ipf_valefrete_caixa is not null)) RATCTFRETEPESOTOT,

       max((select sum(r1.RATCTFRETEPESO) 
        from tdvipf.v_ipf_reccust r1 
        where r1.ipf_reccust_referencia = r.ipf_reccust_referencia 
          and r1.ipf_valefrete_centrocusto = r.ipf_valefrete_centrocusto
          and r1.glb_tpmotorista_codigo = 'F'
          and r1.ipf_valefrete_caixa is not null)) RATCTFRETEPESOFROTA,

       max((select sum(r1.RATCTFRETEPESO) 
        from tdvipf.v_ipf_reccust r1 
        where r1.ipf_reccust_referencia = r.ipf_reccust_referencia 
          and r1.glb_tpmotorista_codigo = 'F'
          and r1.ipf_valefrete_caixa is not null)) RATCTFRETEPESOTOTFROTA

--select *
from tdvipf.v_ipf_reccust r
where 0 = 0
  and r.ipf_reccust_referencia = '201901'
--  and r.ipf_valefrete_rota = '021'
  and r.ipf_valefrete_caixa is not null
group by r.ipf_reccust_referencia,
--         r.ipf_valefrete_rota,
--         r.ipf_conhec_rota,
         r.ipf_valefrete_centrocusto
--         glb_tpmotorista_codigo
--         ,Z A SER RATEADA
;

grant select, references on tdvipf.T_IPF_INDICADORES to XLSUSER with grant option;


 
 
select r.centrocusto,
       r.tipo,
       sum(r.movdeb) movdeb
 from tdvadm.v_ctb_centrocustoanalitico r
 where r.referencia = '201901'
   and r.centrocusto = 'FROTAS PROPRIA CAVALO'
 group by  r.centrocusto,r.tipo
 
 ;
 
SELECT * FROM XLSUSER.V_CTB_CENTROCUSTOANALITICO

select * from tdvipf.t_ipf_indicadores;
select * from tdvipf.v_ipf_centrocustorateado_pre;
select * from tdvipf.v_ipf_centrocustorateado_online x




select x.referencia,
       x.codcc,
       x.centrocusto,
       x.codcontrato,
       ' ' contrato,
       x.conta,
       '999 - Custos Rateados' grupo,
       x.centrocusto descricao,
       x.descricao historico,
       '  ' contacontabil,
       '  '  descricaocontabil,
       x.rateiocred movcred,
       x.rateiodeb movdeb,
       '  ' origemlanc,
       '  ' clientefornc,
       '  ' descclientefornec,
       0 peso,
       '  ' carga,
       '  ' veiculo,
       '  ' cargacol,
       '  ' documento
from tdvipf.v_ipf_centrocustorateado_online x
where x.ipf_valefrete_centrocusto = '4011'
  and x.codcc = '3066'
  and x.grupo = '130';


select *
from tdvipf.v_ipf_centrocustorateado_online x
where x.ipf_valefrete_centrocusto = '4011'
  and x.codcc = '3066'
  and x.grupo = '130';

select * from tdvadm.v_ctb_centrocustoanalitico a
where a.referencia = '201901'
  and a.codcc = '4011'
  and a.grupo = '130';  
  
  

tdvipf.pkg_reccust_diretos2019 .fn_retornavalorrateado


select * from tdvadm.v_ctb_centrocustosintetico;
select * from tdvipf.v_ipf_centrocustorateado;

select * from tdvipf.t_ipf_indicadores;
select * from tdvipf.v_ipf_centrocustorateado_pre;
select * from tdvipf.v_ipf_centrocustorateado_online x


select * from xlsuser.v_ipf_centrocustorateado_online;



drop table tdvipf.v_ipf_centrocustorateado_offline;
create table   tdvipf.v_ipf_centrocustorateado_offline
as
select * from tdvipf.v_ipf_centrocustorateado_online;


select * from tdvipf.v_ipf_centrocustorateado;
select distinct x.glb_tpcentrocusto_criteriorat  from tdvipf.v_ipf_centrocustorateado x;

    
select * from xlsuser.v_ctb_centrocustoanalitico    

select r.glb_rota_codigo,
       r.glb_centrocusto_codigo,
       r.glb_estado_codigo
from tdvadm.t_glb_rota r  
select * 
from tdvadm.t_glb_centrocusto c
where substr(c.glb_centrocusto_codigo,1,1)  in ('4')
for update
  

Valor,
glb_tpcentrocusto_criteriorat,
ipf_indicadores_qtdectechave,
ipf_indicadores_qtdectetot,
ipf_indicadores_qtdectetottpm,
ipf_indicadores_qtdevfchave,
ipf_indicadores_qtdevftot,
ipf_indicadores_qtdevftottpm,
ipf_indicadores_qtdefunc,
ipf_indicadores_qtdefunctot,
ratctfretepesochave,
ratctfretepesotot,
ratctfretepesotottpm


















;
-- teste de conferencia para o Dantas
select r.ipf_reccust_referencia,
--       r.ipf_valefrete_rota,  
       r.ipf_valefrete_centrocusto,
       r.ipf_conhec_chave,
--       r.glb_tpmotorista_codigo,
       count(distinct r.ipf_conhec_chave) ipf_indicadores_qtdeCTE,
       (select  count(distinct r1.ipf_conhec_chave) from tdvipf.v_ipf_reccust r1 where r1.ipf_reccust_referencia = '201901' and r1.ipf_valefrete_caixa is not null) ipf_indicadores_qtdeCTETOT,
       count(distinct substr(r.ipf_valefrete_chave,1,11)) ipf_indicadores_qtdeVF,
       (select  count(distinct substr(r1.ipf_valefrete_chave,1,11)) from tdvipf.v_ipf_reccust r1 where r1.ipf_reccust_referencia = '201901' and r1.ipf_valefrete_caixa is not null) ipf_indicadores_qtdeVFTOT,
       sum(r.RATCTFRETEPESO) RATCTFRETEPESO,
       (select sum(r1.RATCTFRETEPESO) from tdvipf.v_ipf_reccust r1 where r1.ipf_reccust_referencia = '201901' and r1.ipf_valefrete_caixa is not null) RATCTFRETEPESOTOT
from tdvipf.v_ipf_reccust r
where 0 = 0
  and r.ipf_reccust_referencia = '201901'
  and r.ipf_valefrete_rota = '021'
--  and r.ipf_valefrete_centrocusto = '4060'
  and r.ipf_valefrete_caixa is not null
group by r.ipf_reccust_referencia,
--         r.ipf_valefrete_rota,
         r.ipf_valefrete_centrocusto,
         r.ipf_conhec_chave
--         glb_tpmotorista_codigo
--         ,r.ipf_valefrete_chave
;

select *
from tdvipf.v_ipf_reccust r
where r.ipf_conhec_codigo = '174094'
  and r.ipf_conhec_rota = '060';
  
  
 
  
