/*
Tabelas de cadastros do FROTA:

FRT_CADVEICULOS
FRT_MODCHASSI
FRT_TIPODEFROTA
FRT_MARCACHASSI
FRT_MODCARROC
MOT_MODELOMOTOR
FRT_TIPODEVEICULO

Tabelas de principais movimentações ESTOQUE:

EST_MOVTO
EST_ITENSMOVTO
EST_REQUISICAO
BGM_NOTAFISCAL

Tabelas de cadastros do MANUTENÇÃO:

MAN_CADASTRODESERVICOS
MAN_GRUPODESERVICO
MAN_ORIGEMOS
MAN_PLANODEREVISAO 
MAN_CADDEFEITOS
MAN_GRUPODEREVISAO

Tabelas de principais movimentações MANUTENÇÃO:

MAN_OS
MAN_OSPREVISTO
MAN_OSREALIZADO
MAN_OSREALIZADOPARCIAL
MAN_OSFUNCIONARIOS
MAN_KMREVISAO
MAN_ORCAMENTO
MAN_QTDEEXECUCOESPLANO
MAN_ASSOCIAKMREVSERV

*/


select distinct o.OWNER  from dba_objects o where o.OBJECT_TYPE = 'TABLE'

-- Definir quais veiculos seriam usados

-- Pegando o Gasto com o sistema Antes do Globus
select va.frt_veiculoanalise_referencia referencia,
       va.frt_veiculo_codigo veiculo,
       va.frt_conjveiculo_codigo,
       sum(tdvadm.pkg_frt_custo.fn_Get_QtdePecasLub(va.frt_veiculoanalise_referencia,va.frt_conjveiculo_codigo,'LA')) Lubrificante,
       sum(tdvadm.pkg_frt_custo.fn_Get_QtdePecasLub(va.frt_veiculoanalise_referencia,va.frt_conjveiculo_codigo,'PE')) Pecas,
       max(tdvadm.pkg_frt_custo.FN_BUSCA_DADOS(va.frt_veiculoanalise_referencia,va.frt_conjveiculo_codigo,'KR')) kmrodado
from tdvadm.t_frt_veiculoanalise va
group by va.frt_veiculoanalise_referencia,
         va.frt_veiculo_codigo,
         va.frt_conjveiculo_codigo
union
select to_char(o.datafechamentoos,'yyyymm') referencia,
       v.prefixoveic,
       v.placaatualveic,
--       o.numeroos,
--       o.codintos,
--       osf.valormoosfunc,
--       req.numerorq,
--       itemmov.qtdeitensmovto,
       0 lubrificantes ,
       sum(itemmov.valoritensmovto) pecas,
       max((select sum(k.con_valefrete_kmcalculo) 
            from (select distinct x.con_conhecimento_referencia,
                                 x.con_valefrete_codigo,
                                 x.frt_placa_cavalo,
                                 x.con_valefrete_kmcalculo
                 from tdvipf.t_ipf_reccust_diretos x
                 where 0 = 0
--                 and x.frt_placa_cavalo is not null
                ) k
           where k.con_conhecimento_referencia = to_char(o.datafechamentoos,'yyyymm')
             and REPLACE(k.frt_placa_cavalo,'-','') = REPLACE(v.placaatualveic,'-','')
           group by k.con_conhecimento_referencia,
                    k.frt_placa_cavalo)) km
From bgm.man_os o,
     bgm.FRT_CADVEICULOS v,
--     bgm.MAN_OSFUNCIONARIOS osf,
     bgm.EST_REQUISICAO req,
     bgm.EST_MOVTO reqmv,
     bgm.EST_ITENSMOVTO itemmov
where 0 = 0
--  and o.numeroos = 3024
--  and v.prefixoveic = 'C3120'
  and o.codigoveic = v.codigoveic
--  and o.codintos = osf.codintos (+)
  and o.codintos = req.codintos 
  and req.numerorq = reqmv.numerorq
  and reqmv.seqmovto = itemmov.seqmovto
group by to_char(o.datafechamentoos,'yyyymm'),
         v.prefixoveic,
         v.placaatualveic;
         
         
select * from tdvadm.t_frt_abastecimento a
where 0 = 0
--  and to_char(a.frt_abastecimento_data,'YYYYMM') = '201711'         
  and a.frt_conjveiculo_codigo = '0004402';

         
select * from tdvadm.t_acc_abastecimento a
where 0 = 0
--  and to_char(a.frt_abastecimento_data,'YYYYMM') = '201711'         
  and a.frt_conjveiculo_codigo = '0004402';
  
select k.con_conhecimento_referencia,
       k.frt_placa_cavalo,
       sum(k.con_valefrete_kmcalculo) KM
from (select distinct x.con_conhecimento_referencia,
                      x.con_valefrete_codigo,
                      x.frt_placa_cavalo,
                      x.con_valefrete_kmcalculo
      from tdvipf.t_ipf_reccust_diretos x
      where 0 = 0
--        and x.frt_placa_cavalo is not null
        and x.frt_placa_cavalo = 'DTE4764'
     ) k
group by k.con_conhecimento_referencia,
         k.frt_placa_cavalo
  
select * from tdvipf.v_ipf_reccust_diretos  
  
  
  
  
  
           


-- Pegando o gasto com a folha

tdvadm.pkg_frt_custo.sp_folha('O','0004','201710');
-- 201710 104.499.84
-- 201709 107.669.96
-- 201708 132.841.21
-- 201707 106.944.96
-- 201706 104.829.34 
-- 201705 104.688.07
-- 201704 114.030.01
-- 201703 102.561.31
-- 201702 104.303.11
-- 201701  98.718.03


-- Pegando os Precos gastos em Pecas no Globus
select o.datafechamentoos,
       v.prefixoveic,
       v.placaatualveic,
       o.numeroos,
       o.codintos,
--       osf.valormoosfunc,
       req.numerorq,
       itemmov.qtdeitensmovto,
       itemmov.valoritensmovto
From bgm.man_os o,
     bgm.FRT_CADVEICULOS v,
--     bgm.MAN_OSFUNCIONARIOS osf,
     bgm.EST_REQUISICAO req,
     bgm.EST_MOVTO reqmv,
     bgm.EST_ITENSMOVTO itemmov
where 0 = 0
--  and o.numeroos = 3024
  and v.prefixoveic = 'C3120'
  and o.codigoveic = v.codigoveic
--  and o.codintos = osf.codintos (+)
  and o.codintos = req.codintos 
  and req.numerorq = reqmv.numerorq
  and reqmv.seqmovto = itemmov.seqmovto;


select --v.prefixoveic,
       to_char(o.datafechamentoos,'YYYYMM') ref,
--       v.codigotpveic,
--       tv.descricaotpveic,
       min(o.datafechamentoos) menor,
       max(o.datafechamentoos) maior,
       count(distinct v.prefixoveic) qtde
From bgm.man_os o,
     bgm.FRT_CADVEICULOS v,
--     bgm.MAN_OSFUNCIONARIOS osf,
     bgm.EST_REQUISICAO req,
     bgm.EST_MOVTO reqmv,
     bgm.EST_ITENSMOVTO itemmov,
     bgm.FRT_TIPODEVEICULO tv
where 0 = 0
--  and o.numeroos = 3024
--  and v.prefixoveic = 'C3120'
  and o.codigoveic = v.codigoveic
  and v.codigotpveic = tv.codigotpveic
  and tv.possuimotortpveic = 'S'
--  and o.codintos = osf.codintos (+)
  and o.codintos = req.codintos 
  and req.numerorq = reqmv.numerorq
  and reqmv.seqmovto = itemmov.seqmovto
  and tv.descricaotpveic not like '%CARRETA%'
--group by v.prefixoveic
group by to_char(o.datafechamentoos,'YYYYMM')
--         ,v.codigotpveic,
--         ,tv.descricaotpveic


  
