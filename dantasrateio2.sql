select x.fuhistcentrcus,
       x.fuhistnomfunc,
       substr(x.fuhistdataini,1,6) ref, 
       count(distinct x.fuhistmatfunc) qtdeCC,
       (select count(distinct x1.fuhistmatfunc)
        from fpw.funcionahist x1
        where substr(x1.fuhistdataini,1,6) = substr(x.fuhistdataini,1,6)
          and x1.fuhistcentrcus = x.fuhistcentrcus ) qtdetot
from fpw.funcionahist x
where substr(x.fuhistdataini,1,6) >= 201901
group by  x.fuhistcentrcus,
       x.fuhistnomfunc,
       substr(x.fuhistdataini,1,6)
order by 1,3,2
;


select x.fuhistcentrcus,
       x.fuhistnomfunc,
       substr(x.fuhistdataini,1,6) ref, 
       count(distinct x.fuhistmatfunc) qtdeCC,
       (select count(distinct x1.fuhistmatfunc)
        from fpw.funcionahist x1
        where substr(x1.fuhistdataini,1,6) = substr(x.fuhistdataini,1,6)
          and x1.fuhistcentrcus = x.fuhistcentrcus ) qtdetot
from fpw.funcionahist x
where substr(x.fuhistdataini,1,6) >= 201901
  and x.fuhistnomfunc in ('BRUNO DIONELLO BERNARDO',
 'ALAN EDUARDO JUNIOR DE ARAUJO',
 'VANIA BARBOSA SARAIVA',
 'GILBERTO JOSE DELLA VOLPE',
 'JOSE AURELIANO VIEIRA DANTAS JUNIOR',
 'JONATHAS HENRIQUE AZEVEDO DOS REIS')
group by  x.fuhistcentrcus,
       x.fuhistnomfunc,
       substr(x.fuhistdataini,1,6)
order by 1,3,2



select *
from fpw.funcionahist x
where substr(x.fuhistdataini,1,6) >= 201901
  and x.fuhistcentrcus = '1011'
  and substr(x.fuhistdataini,1,6) = '201902'
   ;
   
   select * from fpw.situacao
   
   select * from tdvadm.t_glb_centrocusto for update
   
-- configurar a tabela de Centro de custo para o Tipo de Rateio
select cc.glb_centrocusto_codigo,
       cc.glb_centrocusto_descricao,
       cc.glb_tpcentrocusto_codigo,
       cc.glb_tpcentrocusto_rateavel,
       cc.glb_tpcentrocusto_ccrateio
from tdvadm.t_glb_centrocusto cc
where cc.glb_tpcentrocusto_rateavel = 'S'
  or cc.glb_centrocusto_codigo = '4012'
for update;

-- criando a tabela de indicadores
select * from tdvipf.t_ipf_indicadores x where x.ipf_reccust_referencia = 'AAAAMM';
--drop table tdvipf.t_ipf_indicadores;
delete tdvipf.t_ipf_indicadores i where i.ipf_reccust_referencia >= '201901';
--create table tdvipf.t_ipf_indicadores
--As
insert into tdvipf.t_ipf_indicadores
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
  and r.ipf_reccust_referencia > '201901'
--  and r.ipf_valefrete_rota = '021'
  and r.ipf_valefrete_caixa is not null
group by r.ipf_reccust_referencia,
--         r.ipf_valefrete_rota,
--         r.ipf_conhec_rota,
         r.ipf_valefrete_centrocusto
--         glb_tpmotorista_codigo
--         ,Z A SER RATEADA
;
commit;
grant select, references on tdvipf.T_IPF_INDICADORES to XLSUSER with grant option;

 
 

SELECT * FROM xlsuser.v_Ctb_Centrocustosintetico x
where x.referencia = '201907'
  and x.tipolanc = 'A'
  and x.codcc = '4023'
  
SELECT * FROM xlsuser.V_CTB_CENTROCUSTOANALITICO x
where x.referencia = '201907'
  and x.tipolanc = 'A'
  and x.codcc = '4023';
  
  
select * from tdvipf.t_ipf_indicadores;
select * from tdvipf.v_ipf_centrocustorateado_pre;
select * from tdvipf.v_ipf_centrocustorateado_online x
where x.ipf_valefrete_centrocusto = '4011'
  and x.referencia = '201901';
  

select * from xlsuser.v_ipf_centrocustorateado_online x;
-- Copiar da ONLINE para a OFFLINE







select * --ac.acc_acontas_numero
  from t_acc_acontas ac
 where ac.acc_acontas_data is null
   an
 





select * from TDVADM.V_CTB_BALANCINHO


select * from tdvadm.t_slf_clienteregras cc
where cc.glb_grupoeconomico_codigo = '0020'
  and cc.slf_clienteregras_ativo = 'S'
for update
    

select c.con_conhecimento_codigo,
       c.con_conhecimento_serie,
       c.glb_rota_codigo,
       c.con_conhecimento_dtembarque,
       c.con_conhecimento_flagcancelado
from tdvadm.t_con_conhecimento c
where c.glb_mercadoria_codigo = '69'
  and c.con_conhecimento_dtembarque >= '01/01/2019';
  
  
create view xlsuser.v_frt_intmixconsumo
as  
select v.frt_intmixveiculo_id, 
       v.frt_intmixveiculo_codveiculo,
       v.frt_intmixveiculo_placa,
       x.frt_intmixconsumo_kmrodado,
       x.frt_intmixconsumo_consumo,
       to_date(x.frt_intmixconsumo_data,'dd/mm/yyyy') frt_intmixconsumo_data
from tdvadm.t_frt_intmixconsumo x,
     tdvadm.t_frt_intmixveiculo v
where x.frt_intmixveiculo_id = v.frt_intmixveiculo_id   

  
select * from xlsuser.v_frt_intmixconsumo x
where x.

TDVADM.TG_BU_CFOP








select c.con_conhecimento_dtembarque dtemb,
       c.con_conhecimento_codigo cte,
       c.con_conhecimento_serie sr,
       c.glb_rota_codigo rt,
       c.glb_rota_codigoreceita rtrec,
       c.con_conhecimento_flagcancelado canc,
       tdvadm.fn_busca_conhec_verba(c.con_conhecimento_codigo,c.con_conhecimento_serie,c.glb_rota_codigo,'I_TTPV')  valor
from tdvadm.t_con_conhecimento c
where c.con_conhecimento_dtembarque >= '01/08/2019'
  and (c.glb_rota_codigo <> c.glb_rota_codigoreceita or  tdvadm.fn_busca_conhec_verba(c.con_conhecimento_codigo,c.con_conhecimento_serie,c.glb_rota_codigo,'I_TTPV') > 900000 )
  

;

select * from xlsuser.v_ctb_centrocustoanalitico x
where x.referencia = '201907'
  and x.codcc = '4023'
  and x.conta = '102'
  and x.ccorig = '3069';
  
select x.referencia,
       x.codcc,
       x.centrocusto,
       x.codcontrato,
       x.contrato,
       x.conta,
       x.grupo,
       x.ccorig,
       x.descricao,
       x.historico,
       x.contacontabil,
       x.desccontacontabil,
       x.movcred,
       x.movdeb,
       x.origemlanc,
       x.clientefornc,
       x.descclientefornec,
       x.peso,
       x.carga,
       x.veiculo,
       x.cargacol,
       x.documento,
       x.tipo,
       x.RATEIOTODOS,
       tdvipf.pkg_reccust_diretos2019.fn_retornavalorrateado('R',
                                                             x.movcred,
                                                             ic.glb_tpcentrocusto_criteriorat,
                                                             'TODOS'    ,
                                                             ic.ipf_indicadores_qtdectechave ,
                                                             ic.ipf_indicadores_qtdectetot   ,
                                                             ic.ipf_indicadores_qtdectetottpm,
                                                             ic.ipf_indicadores_qtdevfchave  ,
                                                             ic.ipf_indicadores_qtdevftot    ,
                                                             ic.ipf_indicadores_qtdevftottpm ,
                                                             ic.ipf_indicadores_qtdefunc     ,
                                                             ic.ipf_indicadores_qtdefunctot  ,
                                                             ic.ratctfretepesochave          ,
                                                             ic.ratctfretepesotot            ,
                                                             ic.ratctfretepesofrota          ,
                                                             ic.ratctfretepesototfrota        ) rateiocred,
       tdvipf.pkg_reccust_diretos2019.fn_retornavalorrateado('R',
                                                             x.movdeb,
                                                             ic.glb_tpcentrocusto_criteriorat,
                                                             ic.glb_tpcentrocusto_ccrateio    ,
                                                             ic.ipf_indicadores_qtdectechave ,
                                                             ic.ipf_indicadores_qtdectetot   ,
                                                             ic.ipf_indicadores_qtdectetottpm,
                                                             ic.ipf_indicadores_qtdevfchave  ,
                                                             ic.ipf_indicadores_qtdevftot    ,
                                                             ic.ipf_indicadores_qtdevftottpm ,
                                                             ic.ipf_indicadores_qtdefunc     ,
                                                             ic.ipf_indicadores_qtdefunctot  ,
                                                             ic.ratctfretepesochave          ,
                                                             ic.ratctfretepesotot            ,
                                                             ic.ratctfretepesofrota          ,
                                                             ic.ratctfretepesototfrota        ) rateiodeb,
       tdvipf.pkg_reccust_diretos2019.fn_retornavalorrateado('F',
                                                             x.movcred,
                                                             ic.glb_tpcentrocusto_criteriorat,
                                                             'TODOS'    ,
                                                             ic.ipf_indicadores_qtdectechave ,
                                                             ic.ipf_indicadores_qtdectetot   ,
                                                             ic.ipf_indicadores_qtdectetottpm,
                                                             ic.ipf_indicadores_qtdevfchave  ,
                                                             ic.ipf_indicadores_qtdevftot    ,
                                                             ic.ipf_indicadores_qtdevftottpm ,
                                                             ic.ipf_indicadores_qtdefunc     ,
                                                             ic.ipf_indicadores_qtdefunctot  ,
                                                             ic.ratctfretepesochave          ,
                                                             ic.ratctfretepesotot            ,
                                                             ic.ratctfretepesofrota          ,
                                                             ic.ratctfretepesototfrota        ) FATOR,
       x.tipolanc
from tdvadm.v_ctb_centrocustoanalitico x,
     tdvipf.t_ipf_indicadoresc ic
where x.codcc = ic.ipf_valefrete_centrocusto     
  and x.referencia = '201907'
  and x.codcc = '4023';
  
       
     
  
  
