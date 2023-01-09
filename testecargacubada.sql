
select ta.slf_tabela_codigo tab,
       ta.slf_tabela_saque sq,
       ta.slf_tabela_tipo tipo,
       ta.fcf_tpveiculo_codigo tpveic,
       ta.fcf_tpcarga_codigo tpcarga,
       ta.slf_tabela_coletaentrega colent,
       (select count(*)
        from tdvadm.t_slf_calcfretekm km
        where km.slf_tabela_codigo = ta.slf_tabela_codigo
          and km.slf_tabela_saque = ta.slf_tabela_saque) qtdeverba
from tdvadm.t_slf_tabela ta
where ta.slf_tabela_contrato = 'C2021112601'
  and nvl(ta.slf_tabela_status,'N') <> 'S'
  and ta.slf_tabela_saque = (select max(ta1.slf_tabela_saque)
                             from tdvadm.t_slf_tabela ta1
                             where ta1.slf_tabela_codigo = ta.slf_tabela_codigo
                               and nvl(ta1.slf_tabela_status,'N') <> 'S'
                            )
order by 3,5,4;                            

select *
from tdvadm.t_slf_clientecargas cc
where cc.slf_contrato_codigo = 'C2021112601

select cc.slf_clienteregras_pcobranca
from tdvadm.t_slf_clienteregras cc
where cc.slf_contrato_codigo = 'C2021112601

-- Add/modify columns 
alter table T_SLF_CLIENTECARGAS add slf_clientecargas_pcobranca char(2) default 'PR
alter table T_SLF_CLIENTECARGAS add slf_clientecargas_baseocupacao char(1) default 'N
alter table T_SLF_CLIENTECARGAS add slf_clientecargas_valorbase number ;

-- Add comments to the columns 
comment on column T_SLF_clientecargas.slf_clientecargas_pcobranca
  is 'Qual Peso cobrar PL-Lotacao,PR-Real,PC-Cubado,PF-Faixa,PB-Balança
comment on column T_SLF_clientecargas.slf_clientecargas_baseocupacao
  is 'M-Metros Cubicos,% Percentual,N-Nenhum
comment on column T_SLF_clientecargas.slf_clientecargas_valorbase
  is 'Valor a ser usado na base

update T_SLF_CLIENTECARGAS d
  set (d.slf_clientecargas_pcobranca,
       d.slf_clientecargas_baseocupacao,
       d.slf_clientecargas_valorbase) = (select cr.slf_clienteregras_pcobranca,    
                                                cr.slf_clienteregras_baseocupacao,
                                                cr.slf_clienteregras_valorbase
                                         from tdvadm.t_slf_clienteregras cr
                                         where cr.slf_contrato_codigo = d.slf_contrato_codigo
                                           and cr.glb_grupoeconomico_codigo = d.glb_grupoeconomico_codigo
                                           and cr.glb_cliente_cgccpfcodigo = d.glb_cliente_cgccpfcodigo
                                           and cr.slf_clienteregras_ativo = 'S'
                                           and cr.slf_clienteregras_vigencia = (select max(cr1.slf_clienteregras_vigencia)
                                                                                from tdvadm.t_slf_clienteregras cr1
                                                                                where cr1.glb_grupoeconomico_codigo = cr.glb_grupoeconomico_codigo
                                                                                  and cr1.glb_cliente_cgccpfcodigo = cr.glb_cliente_cgccpfcodigo
                                                                                  and cr1.slf_contrato_codigo = cr.slf_contrato_codigo))
where d.slf_clientecargas_ativo = 'S

C:\vBox\Comum\Script\V_SLF_CLIENTECARGAS220220422.sql
C:\vBox\Comum\Script\TG_BIU_ARM_NOTA_INCLUSAO20220428.trg

insert into tdvadm.t_slf_clientecargas
select x.glb_grupoeconomico_codigo,
       x.glb_cliente_cgccpfcodigo,
       x.slf_contrato_codigo,
       x.slf_clientecargas_seqexec,
       x.slf_clientecargas_vigencia,
       x.slf_clientecargas_ativo,
       '27' fcf_tpcarga_codigo, -- CUBADA
       x.fcf_tpcarga_codigopesq,
       x.slf_tpfrete_codigo,
       x.slf_clientecargas_rateia,
       x.slf_clientecargas_qtdenotacol,
       x.slf_tprateio_codigo,
       x.slf_tpagrupa_codigo,
       x.slf_clientecargas_procedure,
       x.slf_clientecargas_pminimo,
       x.slf_clientecargas_pesagemmax,
       x.slf_clientecargas_agctrc,
       x.slf_clientecargas_qtdectrc,
       x.slf_clientecargas_agnf,
       x.slf_clientecargas_qtdenf,
       x.slf_clientecargas_priorexqm,
       x.slf_clientecargas_percntex,
       x.slf_clientecargas_percntqm,
       x.slf_clientecargas_percntout,
       x.slf_clientecargas_percnttra,
       x.slf_clientecargas_redutor,
       x.slf_clientecargas_formularioqm,
       x.slf_clientecargas_formularioex,
       x.slf_clientecargas_qpcolctrc,
       x.slf_clientecargas_qpcolnf,
       x.slf_clientecargas_formulafrtx,
       x.slf_clientecargas_formulafrtvl,
       x.slf_clientecargas_formulapdtx,
       x.slf_clientecargas_formulapdvl,
       x.slf_clientecargas_formulafrtkm,
       x.slf_clientecargas_fixaorigem,
       x.slf_clientecargas_fixadestino,
       x.slf_clientecargas_sotransf,
       x.slf_clientecargas_usaveiculo,
       x.slf_clientecargas_pesqveiculo,
       x.slf_clientecargas_limitecte,
       x.slf_clientecargas_limitenfse,
       x.slf_clientecargas_usafaixakm,
       x.slf_clientecargas_usafaixapeso,
       x.slf_clientecargas_usafaixavg,
       x.slf_clientecargas_usafaixakmc,
       x.slf_clientecargas_kmminimo,
       x.slf_clientecargas_cobracoleta,
       x.slf_clientecargas_parasempcc,
       x.fcf_tpcarga_codigocol,
       x.slf_tpfrete_codigocol,
       x.slf_clientecargas_forcobcoleta,
       x.slf_clientecargas_agrporcoleta,
       x.slf_clientecargas_formulacoltx,
       x.slf_clientecargas_formulacolvl,
       x.slf_clientecargas_formulacolkm,
       x.slf_clientecargas_usafaixapsoc,
       x.slf_clientecargas_usafaixavgc,
       x.slf_clientecargas_usaveiculoc,
       x.slf_clientecargas_pesqveiculoc,
       x.slf_clientecargas_ctedecoleta,
       x.slf_clientecargas_mudaorigemcc,
       sysdate slf_clientecargas_dtcadastro,
       x.slf_clientecargas_mudacarregex,
       x.slf_clientecargas_mudacarregqm,
       x.slf_clientecargas_rateiacol,
       x.slf_tprateio_codigocol,
       'PC' slf_clientecargas_pcobranca,
       'N'  slf_clientecargas_baseocupacao,
       0    slf_clientecargas_valorbase 
from tdvadm.t_slf_clientecargas x
where x.SLF_CONTRATO_CODIGO = 'C2021112601'
  and x.FCF_TPCARGA_CODIGO = '02
 
update tdvadm.t_slf_clientecargas x
  set x.slf_clientecargas_procedure = 'TDVADM.PKG_FIFO_CARREGCTRC.SP_TESTACARGAMENORVALOR'
where x.SLF_CONTRATO_CODIGO = 'C2021112601'
  and x.FCF_TPCARGA_CODIGOPESQ = '02
commit;

select *
from tdvadm.v_slf_clientecargas2 x
where x.SLF_CONTRATO_CODIGO = 'C2021112601'
  and x.FCF_TPCARGA_CODIGOPESQ = '02';
  
select *
from tdvadm.t_arm_nota an
where an.slf_contrato_codigo = 'C2021112601' 
for update;
  
select an.arm_armazem_codigo armazem,
       cd.arm_carregamento_codigo carregamento,
       an.con_conhecimento_codigo || '-' || an.glb_rota_codigo CTe,
       an.arm_nota_dtinclusao dtinclusao,
       an.arm_nota_numero nota,
       an.arm_nota_peso peso,
       an.arm_nota_pesobalanca balanca,
       an.arm_movimento_pesocubado cubado,
       an.arm_coleta_pesocobrado cobrado,
       c.con_conhecimento_obs obs,
       ca.con_calcviagem_valor valor,
       ca.con_calcconhecimento_cocli codcli
from tdvadm.t_arm_nota an,
     tdvadm.t_arm_carregamentodet cd,
     tdvadm.t_con_conhecimento c,
     tdvadm.t_con_calcconhecimento ca
where an.slf_contrato_codigo = 'C2021112601' 
  and an.arm_embalagem_numero = cd.arm_embalagem_numero
  and an.arm_embalagem_flag= cd.arm_embalagem_flag
  and an.arm_embalagem_sequencia = cd.arm_embalagem_sequencia
  and an.con_conhecimento_codigo = c.con_conhecimento_codigo
  and an.con_conhecimento_serie  = c.con_conhecimento_serie
  and an.glb_rota_codigo         = c.glb_rota_codigo
  and an.con_conhecimento_codigo = ca.con_conhecimento_codigo
  and an.con_conhecimento_serie  = ca.con_conhecimento_serie
  and an.glb_rota_codigo         = ca.glb_rota_codigo
  and ca.slf_reccust_codigo      = 'I_TTPV'
order by 1 desc; 

tdvadm.pkg_fifo_carregctrc

select *
from tdvadm.t_con_loggeracao lg
where lg.arm_carregamento_codigo = '3512282'
  and (upper(lg.con_loggeracao_obsgeracao) like '%TESTANDO%' 
    or upper(lg.con_loggeracao_obsgeracao) like '%BUSCANDO%'
      )
  
order by lg.con_loggeracao_codigo

SELECT CK.*,        T.GLB_MERCADORIA_CODIGO,        T.SLF_TABELA_COLETAENTREGA,        T.SLF_TABELA_TIPO,        T.FCF_TPVEICULO_CODIGO,        T.FCF_TPCARGA_CODIGO,        T.GLB_CLIENTE_CGCCPFCODIGO,        T.GLB_GRUPOECONOMICO_CODIGO,        T.SLF_TABELA_CONTRATO,        1 vPESOCOBRADO,        1 vFATORRATEIO,        'OK' vRetorno,        CK.ROWID FROM TDVADM.T_SLF_CALCFRETEKM CK,      TDVADM.T_SLF_TABELA T WHERE 0 = 0   AND CK.SLF_TABELA_CODIGO = T.SLF_TABELA_CODIGO   AND CK.SLF_TABELA_SAQUE = T.SLF_TABELA_SAQUE   AND NVL(T.SLF_TABELA_STATUS,'N') = 'N'  AND T.SLF_TABELA_CONTRATO = 'C2021112601'  AND T.GLB_GRUPOECONOMICO_CODIGO = '0752'  AND CK.SLF_RECCUST_CODIGO = 'D_FRPSVO'  AND T.SLF_TABELA_TIPO = 'FOB'  AND nvl(T.SLF_TABELA_COLETAENTREGA,'A') in ('N','A','C')   AND round(10,0) BETWEEN CK.SLF_CALCFRETEKM_PESODE AND CK.SLF_CALCFRETEKM_PESOATE   AND T.FCF_TPCARGA_CODIGO =  '02'          AND CK.SLF_CALCFRETEKM_ORIGEMI  = '4314902'          AND CK.SLF_CALCFRETEKM_DESTINOI  = '4322004'  AND T.SLF_TABELA_SAQUE = (SELECT MAX(T1.SLF_TABELA_SAQUE)                             FROM TDVADM.T_SLF_TABELA T1                             WHERE T1.SLF_TABELA_CODIGO = T.SLF_TABELA_CODIGO                               AND NVL(T1.SLF_TABELA_STATUS,'N') = 'N'                              AND TO_DATE(T1.SLF_TABELA_VIGENCIA,'DD/MM/YYYY') <= TO_DATE(SYSDATE,'DD/MM/YYYY')) ;
SELECT CK.*,        T.GLB_MERCADORIA_CODIGO,        T.SLF_TABELA_COLETAENTREGA,        T.SLF_TABELA_TIPO,        T.FCF_TPVEICULO_CODIGO,        T.FCF_TPCARGA_CODIGO,        T.GLB_CLIENTE_CGCCPFCODIGO,        T.GLB_GRUPOECONOMICO_CODIGO,        T.SLF_TABELA_CONTRATO,        1 vPESOCOBRADO,        1 vFATORRATEIO,        'OK' vRetorno,        CK.ROWID FROM TDVADM.T_SLF_CALCFRETEKM CK,      TDVADM.T_SLF_TABELA T WHERE 0 = 0   AND CK.SLF_TABELA_CODIGO = T.SLF_TABELA_CODIGO   AND CK.SLF_TABELA_SAQUE = T.SLF_TABELA_SAQUE   AND NVL(T.SLF_TABELA_STATUS,'N') = 'N'  AND T.SLF_TABELA_CONTRATO = 'C2021112601'  AND T.GLB_GRUPOECONOMICO_CODIGO = '0752'  AND CK.SLF_RECCUST_CODIGO = 'D_FRPSVO'  AND T.SLF_TABELA_TIPO = 'FOB'  AND nvl(T.SLF_TABELA_COLETAENTREGA,'A') in ('N','A','C')   AND round(200,0) BETWEEN CK.SLF_CALCFRETEKM_PESODE AND CK.SLF_CALCFRETEKM_PESOATE   AND T.FCF_TPCARGA_CODIGO =  '02'          AND CK.SLF_CALCFRETEKM_ORIGEMI  = '4314902'          AND CK.SLF_CALCFRETEKM_DESTINOI  = '4322004'  AND T.SLF_TABELA_SAQUE = (SELECT MAX(T1.SLF_TABELA_SAQUE)                             FROM TDVADM.T_SLF_TABELA T1                             WHERE T1.SLF_TABELA_CODIGO = T.SLF_TABELA_CODIGO                               AND NVL(T1.SLF_TABELA_STATUS,'N') = 'N'                              AND TO_DATE(T1.SLF_TABELA_VIGENCIA,'DD/MM/YYYY') <= TO_DATE(SYSDATE,'DD/MM/YYYY'));
                   


   
select * from tdvadm.t_slf_contrato c
where c.slf_contrato_codigo = 'C2021112601'  ;

                    
select * from tdvadm.v_slf_clientecargas2 x
where x.SLF_CLIENTECARGAS_PROCEDURE is not null
                                        
                                        
tdvadm.pkg_fifo_carregctrc
      

select * from tdvadm.v_job_todos t
where upper(t.WHAT) like '%SENAT%'

select *
from xlsuser.v_slf_tabsusp

create view xlsuser.v_slf_tabelakmcomp as
select * from tdvadm.v_slf_tabelakmcomp;


create view xlsuser.v_slf_tabelakmcomptodos as
select * from tdvadm.v_slf_tabelakmcomptodos;


select * from xlsusr.v_slf_tabelakmcomp ;
select * from xlsusr.v_slf_tabelakmcomptodos ;
