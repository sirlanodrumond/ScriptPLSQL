SELECT * FROM TDVADM.T_SLF_CLIENTECARGAS_tmp ;
SELECT * FROM TDVADM.T_SLF_CLIENTEREGRAS_tmp;


SELECT * FROM v_slf_clientecargas_tmp;
SELECT * FROM v_slf_clientecargas2;
  
  
select s.OWNER || '.' || s.NAME, count(*)
from dba_source s
where upper(s.TEXT) like '%T_SLF_CLIENTECARGAS%'
group by s.OWNER || '.' || s.NAME;

select s.OWNER || '.' || s.NAME, count(*)
from dba_source s
where upper(s.TEXT) like '%T_SLF_CLIENTEREGRAS%'
group by s.OWNER || '.' || s.NAME;

TDVADM.TG_BD_CONFERECARREGDET;

TDVADM.FN_TEMJANELANOTA; Ñ
TDVADM.PKG_FIFO; Ñ
TDVADM.PKG_FIFO_CARREGAMENTO; Ñ
TDVADM.PKG_FIFO_CARREGCTRC;
TDVADM.PKG_FIFO_CARREGCTRC_TMP;
TDVADM.PKG_FIFO_RECEBIMENTO; ok
TDVADM.PKG_SLF_CONTRATO; ok
TDVADM.PKG_SLF_PERCURSO; ok
TDVADM.PKG_SLF_TABELAS; ok
TDVADM.SP_CON_CRIACTECOLETA; Ñ
TDVADM.SP_FCF_LIBERACAOFRETE; Ñ
TDVADM.SP_GET_CARGAVEICULOSR; Ñ
TDVADM.SP_SUBIRTABELAPARAOTDX;
TDVADM.TG_AIUD_CLIENTESGARGA; Ñ
TDVADM.TG_BIU_CLIENTECARGAS; Ñ

update tdvadm.t_slf_clientecargas_tmp c
  set c.slf_clientecargas_baseocupacao = 'N',
      c.slf_clientecargas_valorbase = 0;
      
  

insert into tdvadm.t_slf_clientecargas 
SELECT c.glb_grupoeconomico_codigo,
       c.glb_cliente_cgccpfcodigo,
       c.slf_contrato_codigo,
       c.slf_clientecargas_seqexec,
       c.slf_clientecargas_vigencia,
       NVL(c.slf_clientecargas_ativo,'S'),
       c.fcf_tpcarga_codigo,
       c.fcf_tpcarga_codigopesq,
       c.slf_tpfrete_codigo,
       c.slf_clientecargas_rateia,
       c.slf_clientecargas_qtdenotacol,
       c.slf_tprateio_codigo,
       c.slf_tpagrupa_codigo,
       c.slf_clientecargas_procedure,
       c.slf_clientecargas_pminimo ,
       c.slf_clientecargas_pesagemmax,
       c.slf_clientecargas_agctrc,
       c.slf_clientecargas_qtdectrc,
       c.slf_clientecargas_agnf,
       c.slf_clientecargas_qtdenf,
       c.slf_clientecargas_priorexqm,
       c.slf_clientecargas_percntex,
       c.slf_clientecargas_percntqm,
       c.slf_clientecargas_percntout,
       c.slf_clientecargas_percnttra,
       c.slf_clientecargas_redutor,
       c.slf_clientecargas_formularioqm,
       c.slf_clientecargas_formularioex,
       c.slf_clientecargas_qpcolctrc,
       c.slf_clientecargas_qpcolnf,
       c.slf_clientecargas_formulafrtx,
       c.slf_clientecargas_formulafrtvl,
       c.slf_clientecargas_formulapdtx,
       c.slf_clientecargas_formulapdvl,
       c.slf_clientecargas_formulafrtkm,
       c.slf_clientecargas_fixaorigem,
       c.slf_clientecargas_fixadestino,
       c.slf_clientecargas_sotransf,
       c.slf_clientecargas_usaveiculo,
       c.slf_clientecargas_pesqveiculo,
       c.slf_clientecargas_limitecte,
       c.slf_clientecargas_limitenfse,
       c.slf_clientecargas_usafaixakm,
       c.slf_clientecargas_usafaixapeso,
       c.slf_clientecargas_usafaixavg,
       c.slf_clientecargas_usafaixakmc,
       c.slf_clientecargas_kmminimo,
       c.slf_clientecargas_cobracoleta,
       c.slf_clientecargas_parasempcc,
       c.fcf_tpcarga_codigocol,
       c.slf_tpfrete_codigocol,
       c.slf_clientecargas_forcobcoleta,
       c.slf_clientecargas_agrporcoleta,
       c.slf_clientecargas_formulacoltx,
       c.slf_clientecargas_formulacolvl,
       c.slf_clientecargas_formulacolkm,
       c.slf_clientecargas_usafaixapsoc,
       c.slf_clientecargas_usafaixavgc,
       c.slf_clientecargas_usaveiculoc,
       c.slf_clientecargas_pesqveiculoc,
       c.slf_clientecargas_ctedecoleta,
       c.slf_clientecargas_mudaorigemcc,
       c.slf_clientecargas_dtcadastro
FROM v_slf_clientecargas_tmp c ;

insert into tdvadm.t_slf_clienteregras 
select distinct c.glb_grupoeconomico_codigo,
                c.glb_cliente_cgccpfcodigo,
                c.slf_contrato_codigo,
                c.slf_clienteregras_vigencia,
                NVL(c.slf_clienteregras_ativo,'S'),
                c.slf_clienteregras_colorig,
                c.slf_clienteregras_colpedido,
                c.slf_clienteregras_colpedidoreg,
                c.slf_clienteregras_colautoriza,
                c.slf_clienteregras_infcli,
                c.slf_clientecargas_pcobranca,
                c.slf_clientecargas_baseocupacao,
                c.slf_clientecargas_valorbase,
                c.slf_clienteregras_pbobrig,
                c.slf_clienteregras_pbarrend,
                c.slf_clienteregras_pbdecgramas,
                c.slf_clientecargas_tabped,
                c.slf_clientecargas_tabkm,
                c.slf_clientecargas_globalizado,
                c.slf_clientecargas_criacolfifo,
                c.slf_clientecargas_fimdigitnota,
                c.slf_clientecargas_valeped,
                c.slf_clientecargas_dtcadastro
from v_slf_clientecargas_tmp c;

SELECT * FROM V_SLF_CLIENTECARGAS;

CREATE OR REPLACE VIEW V_SLF_CLIENTECARGAS2 AS
SELECT C.GLB_GRUPOECONOMICO_CODIGO,
       gp.glb_grupoeconomico_nome descgrupo,
       C.GLB_CLIENTE_CGCCPFCODIGO,
       C.SLF_CONTRATO_CODIGO,
       ct.slf_contrato_dtinicio dtinicio,
       ct.slf_contrato_dtfinal dtfinal,
       ct.slf_contrato_descricao desccontrato,
       C.SLF_CLIENTECARGAS_SEQEXEC,
       C.SLF_CLIENTECARGAS_VIGENCIA,
       C.SLF_CLIENTECARGAS_ATIVO,
       C.FCF_TPCARGA_CODIGO,
       C.fcf_tpcarga_codigo || '-' || tc.fcf_tpcarga_descricao Tpcarga,
       C.FCF_TPCARGA_CODIGOPESQ,
       C.fcf_tpcarga_codigopesq || '-' || tcp.fcf_tpcarga_descricao TpcargaPesq,
       C.SLF_TPFRETE_CODIGO,
       C.slf_tpfrete_codigo || '-' || FR.SLF_TPFRETE_DESCRICAO tpfretepesq,
       fr.slf_tpfrete_tpcodorigem tporigem,
       fr.slf_tpfrete_tpcoddestino tpdestino,
       C.SLF_CLIENTECARGAS_RATEIA,
       C.SLF_CLIENTECARGAS_QTDENOTACOL,
       C.SLF_TPRATEIO_CODIGO,
       C.SLF_TPAGRUPA_CODIGO,
       C.SLF_CLIENTECARGAS_PROCEDURE,
       C.SLF_CLIENTECARGAS_PMINIMO,
       C.SLF_CLIENTECARGAS_PESAGEMMAX,
       C.SLF_CLIENTECARGAS_AGCTRC,
       C.SLF_CLIENTECARGAS_QTDECTRC,
       C.SLF_CLIENTECARGAS_AGNF,
       C.SLF_CLIENTECARGAS_QTDENF,
       C.SLF_CLIENTECARGAS_PRIOREXQM,
       nvl(C.SLF_CLIENTECARGAS_PERCNTEX,1) + 1 SLF_CLIENTECARGAS_PERCNTEX,
       nvl(C.SLF_CLIENTECARGAS_PERCNTQM,1) + 1 SLF_CLIENTECARGAS_PERCNTQM,
       nvl(C.SLF_CLIENTECARGAS_PERCNTOUT,1) + 1 SLF_CLIENTECARGAS_PERCNTOUT,
       nvl(C.SLF_CLIENTECARGAS_PERCNTTRA,1) + 1 SLF_CLIENTECARGAS_PERCNTTRA,
       nvl(C.SLF_CLIENTECARGAS_REDUTOR,1) + 1 SLF_CLIENTECARGAS_REDUTOR,
       C.SLF_CLIENTECARGAS_FORMULARIOQM,
       C.SLF_CLIENTECARGAS_FORMULARIOEX,
       C.SLF_CLIENTECARGAS_QPCOLCTRC,
       C.SLF_CLIENTECARGAS_QPCOLNF,
       C.SLF_CLIENTECARGAS_FORMULAFRTX,
       C.SLF_CLIENTECARGAS_FORMULAFRTVL,
       C.SLF_CLIENTECARGAS_FORMULAPDTX,
       C.SLF_CLIENTECARGAS_FORMULAPDVL,
       C.SLF_CLIENTECARGAS_FORMULAFRTKM,
       C.SLF_CLIENTECARGAS_FIXAORIGEM,
       C.SLF_CLIENTECARGAS_FIXADESTINO,
       C.SLF_CLIENTECARGAS_SOTRANSF,
       C.SLF_CLIENTECARGAS_USAVEICULO,
       C.SLF_CLIENTECARGAS_PESQVEICULO,
       DECODE(C.slf_clientecargas_usaveiculo,'S',DECODE(C.slf_clientecargas_pesqveiculo,'C','COLETA',
                                                                                        'F','FAIXA',
                                                                                        'G','GRID FIFO'),
                                                                                        '')  pesquisaveiculo,
       C.SLF_CLIENTECARGAS_LIMITECTE,
       C.SLF_CLIENTECARGAS_LIMITENFSE,
       C.SLF_CLIENTECARGAS_USAFAIXAKM,
       C.SLF_CLIENTECARGAS_USAFAIXAPESO,
       C.SLF_CLIENTECARGAS_USAFAIXAVG,
       C.SLF_CLIENTECARGAS_USAFAIXAKMC,
       C.SLF_CLIENTECARGAS_KMMINIMO,
       C.SLF_CLIENTECARGAS_COBRACOLETA,
       C.SLF_CLIENTECARGAS_PARASEMPCC,
       C.FCF_TPCARGA_CODIGOCOL,
       C.fcf_tpcarga_codigocol || '-' || tcc.fcf_tpcarga_descricao TpcargaCol,
       C.SLF_TPFRETE_CODIGOCOL,
       C.slf_tpfrete_codigocol || '-' || frc.slf_tpfrete_descricao tpfretepesqCol,
       frc.slf_tpfrete_tpcodorigem tporigemColeta,
       frc.slf_tpfrete_tpcoddestino tpdestinoColeta,
       C.SLF_CLIENTECARGAS_FORCOBCOLETA,
       C.SLF_CLIENTECARGAS_AGRPORCOLETA,
       C.SLF_CLIENTECARGAS_FORMULACOLTX,
       C.SLF_CLIENTECARGAS_FORMULACOLVL,
       C.SLF_CLIENTECARGAS_FORMULACOLKM,
       C.SLF_CLIENTECARGAS_USAFAIXAPSOC,
       C.SLF_CLIENTECARGAS_USAFAIXAVGC,
       C.SLF_CLIENTECARGAS_USAVEICULOC,
       C.SLF_CLIENTECARGAS_PESQVEICULOC,
       DECODE(C.slf_clientecargas_usaveiculoc,'S',DECODE(C.slf_clientecargas_pesqveiculoc,'C','COLETA',
                                                                                          'F','FAIXA',
                                                                                          'G','GRID FIFO'),
                                                                                          '')  pesqveiculoc,
       C.SLF_CLIENTECARGAS_CTEDECOLETA,
       C.SLF_CLIENTECARGAS_MUDAORIGEMCC,
       C.SLF_CLIENTECARGAS_DTCADASTRO,
       R.SLF_CLIENTEREGRAS_VIGENCIA,
       R.SLF_CLIENTEREGRAS_ATIVO,
       R.SLF_CLIENTEREGRAS_COLORIG,
       R.SLF_CLIENTEREGRAS_COLPEDIDO,
       R.SLF_CLIENTEREGRAS_COLPEDIDOREG,
       R.SLF_CLIENTEREGRAS_COLAUTORIZA,
       R.SLF_CLIENTEREGRAS_INFCLI,
       R.SLF_CLIENTEREGRAS_PCOBRANCA,
       decode(R.slf_clienteREGRAS_pcobranca,'PB','BALANCA',
                                            'PR','NOTA',
                                            'PC','CUBADO',
                                            'PE','EXCEDENTE',R.slf_clienteREGRAS_pcobranca)  pesocobranca,
       R.SLF_CLIENTEREGRAS_BASEOCUPACAO,
       R.SLF_CLIENTEREGRAS_VALORBASE,
       R.SLF_CLIENTEREGRAS_PBOBRIG,
       R.SLF_CLIENTEREGRAS_PBARREND,
       R.SLF_CLIENTEREGRAS_PBDECGRAMAS,
       R.SLF_CLIENTEREGRAS_TABPED,
       R.SLF_CLIENTEREGRAS_TABKM,
       R.SLF_CLIENTEREGRAS_GLOBALIZADO,
       R.SLF_CLIENTEREGRAS_CRIACOLFIFO,
       R.SLF_CLIENTEREGRAS_FIMDIGITNOTA,
       R.SLF_CLIENTEREGRAS_VALEPED,
       R.SLF_CLIENTEREGRAS_DTCADASTRO
FROM TDVADM.T_SLF_CLIENTECARGAS C,
     TDVADM.T_SLF_CLIENTEREGRAS R,
     tdvadm.T_slf_tpfrete FR,
     tdvadm.T_slf_tpfrete FRC,
     tdvadm.t_fcf_tpcarga tc,
     tdvadm.t_fcf_tpcarga tcp,
     tdvadm.t_fcf_tpcarga tcc,
     tdvadm.t_glb_grupoeconomico gp,
     tdvadm.t_slf_contrato ct

WHERE C.GLB_GRUPOECONOMICO_CODIGO = R.GLB_GRUPOECONOMICO_CODIGO (+)
  AND C.GLB_CLIENTE_CGCCPFCODIGO = R.GLB_CLIENTE_CGCCPFCODIGO (+)
  AND C.SLF_CONTRATO_CODIGO = R.SLF_CONTRATO_CODIGO (+)
  AND C.SLF_TPFRETE_CODIGO = FR.slf_tpfrete_codigo
  and C.slf_tpfrete_codigocol = FRC.SLF_TPFRETE_CODIGO (+)
  and C.fcf_tpcarga_codigo = tc.fcf_tpcarga_codigo
  and C.fcf_tpcarga_codigopesq = tcp.fcf_tpcarga_codigo
  and C.fcf_tpcarga_codigocol = tcc.fcf_tpcarga_codigo (+)
  and C.glb_grupoeconomico_codigo = gp.glb_grupoeconomico_codigo (+)
  and C.slf_contrato_codigo = ct.slf_contrato_codigo (+)
  AND C.SLF_CLIENTECARGAS_VIGENCIA = (SELECT MAX(C1.SLF_CLIENTECARGAS_VIGENCIA)
                                      FROM TDVADM.T_SLF_CLIENTECARGAS C1
                                      WHERE C1.GLB_GRUPOECONOMICO_CODIGO = C.GLB_GRUPOECONOMICO_CODIGO
                                        AND C1.GLB_CLIENTE_CGCCPFCODIGO = C.GLB_CLIENTE_CGCCPFCODIGO
                                        AND C1.SLF_CONTRATO_CODIGO = C.SLF_CONTRATO_CODIGO
                                        AND C1.FCF_TPCARGA_CODIGO = C.FCF_TPCARGA_CODIGO
                                        AND C1.FCF_TPCARGA_CODIGOPESQ = C.FCF_TPCARGA_CODIGOPESQ
                                        AND C1.SLF_TPFRETE_CODIGO = C.SLF_TPFRETE_CODIGO
                                        AND C1.SLF_CLIENTECARGAS_ATIVO = 'S')
  AND R.SLF_CLIENTEREGRAS_VIGENCIA = (SELECT MAX(R1.SLF_CLIENTEREGRAS_VIGENCIA)
                                      FROM TDVADM.T_SLF_CLIENTEREGRAS R1
                                      WHERE R1.GLB_GRUPOECONOMICO_CODIGO = R.GLB_GRUPOECONOMICO_CODIGO
                                        AND R1.GLB_CLIENTE_CGCCPFCODIGO = R.GLB_CLIENTE_CGCCPFCODIGO
                                        AND R1.SLF_CONTRATO_CODIGO = R.SLF_CONTRATO_CODIGO
                                        AND R1.SLF_CLIENTEREGRAS_ATIVO = 'S');
    
  




select *
from tdvadm.t_glb_filialbalanca f
where f.glb_rota_codigo = '011'
for update
  
