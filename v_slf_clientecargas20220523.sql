create or replace view v_slf_clientecargas as
select x.slf_clientecargas_seqexec seq,
       x.SLF_CLIENTECARGAS_VIGENCIA VIGENCIA,
       r.slf_clienteregras_vigencia vigenciareg,
       x.slf_clientecargas_ativo ATIVO,
       ct.slf_contrato_dtinicio dtinicio,
       ct.slf_contrato_dtfinal dtfinal,
       x.slf_contrato_codigo contrato,
       ct.slf_contrato_descricao desccontrato,
       x.glb_grupoeconomico_codigo Grupo,
       gp.glb_grupoeconomico_nome descgrupo,
       x.glb_cliente_cgccpfcodigo cnpj,
       x.fcf_tpcarga_codigo || '-' || tc.fcf_tpcarga_descricao Tpcarga,
       x.fcf_tpcarga_codigopesq || '-' || tcp.fcf_tpcarga_descricao TpcargaPesq,
       x.slf_clientecargas_procedure proc,
       r.slf_clienteregras_fimdigitnota fimdigitnota,
       x.slf_clientecargas_agctrc agrupaNOTActe,
       x.slf_clientecargas_qtdectrc qtdectrc,
       x.slf_clientecargas_agnf agrupaNOTAnfSE,
       x.slf_clientecargas_qtdenf qtdenf,
       r.slf_clienteregras_globalizado GLOBALIZADO,
       r.slf_clienteregras_criacolfifo criacolfifo,
       x.slf_clientecargas_qtdenotacol qtdenotacol,
       decode(r.slf_clienteregras_pcobranca,'PB','BALANCA',
                                            'PR','NOTA',
                                            'PC','CUBADO',
                                            'PE','EXCEDENTE',r.slf_clienteregras_pcobranca)  pesocobranca,
       r.slf_clienteregras_baseocupacao baseocupacao,
       r.slf_clienteregras_valorbase valorbase,
       x.slf_clientecargas_pminimo pesominimo,
       x.SLF_CLIENTECARGAS_PESAGEMMAX pesomaximo,
       x.slf_clientecargas_rateia rateia,
       X.SLF_TPRATEIO_CODIGO TIPORATEIO,
       x.slf_tprateio_codigocol tiporateiocoleta,
       x.slf_tpagrupa_codigo TIPOAGRUPA,
       x.slf_clientecargas_qpcolctrc novocteporcoleta,
       x.slf_clientecargas_qpcolnf novanotaporcoleta,
       x.slf_tpfrete_codigo || '-' || FR.SLF_TPFRETE_DESCRICAO tpfretepesq,
       fr.slf_tpfrete_tpcodorigem tporigem,
       fr.slf_tpfrete_tpcoddestino tpdestino,
       X.SLF_CLIENTECARGAS_USAFAIXAKM usaFAIXAkm,
       X.SLF_CLIENTECARGAS_USAFAIXAPESO usafaixaPESO,
       X.SLF_CLIENTECARGAS_USAFAIXAVG usafaixaVIAG,
       x.slf_clientecargas_usaveiculo usaveiculo,
       DECODE(x.slf_clientecargas_usaveiculo,'S',DECODE(x.slf_clientecargas_pesqveiculo,'C','COLETA',
                                                                                        'F','FAIXA',
                                                                                        'G','GRID FIFO'),
                                                                                        '')  pesquisaveiculo,
       x.SLF_CLIENTECARGAS_PRIOREXQM PRIOREXQM,
       x.slf_clientecargas_formularioex formularioexp,
       x.slf_clientecargas_percntex perctex,
       x.slf_clientecargas_formularioqm formaularioquimico,
       x.slf_clientecargas_percntqm percentquimico,
       x.slf_clientecargas_percntout percentoutbound,
       x.slf_clientecargas_percnttra percttransf,
       x.slf_clientecargas_redutor percentredutor,
       x.slf_clientecargas_fixaorigem fixoorigem,
       x.slf_clientecargas_fixadestino fixodestino,
       x.slf_clientecargas_sotransf sotransferencia,
       r.slf_clienteregras_tabped tabpedagio,
       r.slf_clienteregras_valeped VALEPEDAGIO,
       r.SLF_CLIENTEregras_TABKM TABKM,
       x.slf_clientecargas_kmminimo kmminimo,
       x.slf_clientecargas_cobracoleta cobracoleta,
       x.slf_clientecargas_forcobcoleta forcobcoleta,
       x.slf_clientecargas_mudaorigemcc mudaorigemcc,
       x.slf_clientecargas_parasempcc parasempcc,
       x.SLF_CLIENTECARGAS_USAFAIXAKMC USAFAIXAKMC,
       x.SLF_CLIENTECARGAS_USAFAIXAPSOC USAFAIXAPSOC,
       x.SLF_CLIENTECARGAS_USAFAIXAVGC USAFAIXAVGC,

       x.SLF_CLIENTECARGAS_CTEDECOLETA CTEDECOLETA,
       x.fcf_tpcarga_codigocol || '-' || tcc.fcf_tpcarga_descricao TpcargaCol,
       x.slf_tpfrete_codigocol || '-' || frc.slf_tpfrete_descricao tpfretepesqCol,
       frc.slf_tpfrete_tpcodorigem tporigemColeta,
       frc.slf_tpfrete_tpcoddestino tpdestinoColeta,
       x.slf_clientecargas_usaveiculoc usaveiculoc,
       DECODE(x.slf_clientecargas_usaveiculoc,'S',DECODE(x.slf_clientecargas_pesqveiculoc,'C','COLETA',
                                                                                          'F','FAIXA',
                                                                                          'G','GRID FIFO'),
                                                                                          '')  pesqveiculoc,
       x.slf_clientecargas_agrporcoleta agrporcoleta,
       x.slf_clientecargas_formulacoltx formulacoltx,
       x.slf_clientecargas_formulacolvl formulacolvl,
       x.slf_clientecargas_formulacolkm formulacolkm,
       x.slf_clientecargas_limitecte limitevlrcte,
       x.slf_clientecargas_limitenfse limitvlrnfse,
       x.slf_clientecargas_formulafrtx formulafrtx,
       x.slf_clientecargas_formulafrtvl formulafrtvl,
       x.slf_clientecargas_formulafrtKM formulafrtKM,
       x.slf_clientecargas_formulapdtx formulapdtx,
       x.slf_clientecargas_formulapdvl formulapdvl,
       x.slf_clientecargas_rateiacol rateiacol,
       x.slf_clientecargas_qpcolctrc quebracolctrc,
       x.slf_clientecargas_qpcolnf quebracolnota,
       X.SLF_CLIENTECARGAS_MUDACARREGEX MUDACARREGEX,
       X.SLF_CLIENTECARGAS_MUDACARREGQM MUDACARREGQM,
       r.slf_clienteregras_obscust
from tdvadm.t_slf_clientecargas x,
     tdvadm.T_slf_tpfrete FR,
     tdvadm.T_slf_tpfrete FRC,
     tdvadm.t_fcf_tpcarga tc,
     tdvadm.t_fcf_tpcarga tcp,
     tdvadm.t_fcf_tpcarga tcc,
     tdvadm.t_glb_grupoeconomico gp,
     tdvadm.t_slf_contrato ct,
     tdvadm.t_slf_clienteregras r
where 0 = 0
  AND X.SLF_TPFRETE_CODIGO = FR.slf_tpfrete_codigo
  and x.slf_tpfrete_codigocol = FRC.SLF_TPFRETE_CODIGO (+)
  and x.fcf_tpcarga_codigo = tc.fcf_tpcarga_codigo
  and x.fcf_tpcarga_codigopesq = tcp.fcf_tpcarga_codigo
  and x.fcf_tpcarga_codigocol = tcc.fcf_tpcarga_codigo (+)
  and x.glb_grupoeconomico_codigo = gp.glb_grupoeconomico_codigo (+)
  and x.slf_contrato_codigo = ct.slf_contrato_codigo (+)
  and x.glb_grupoeconomico_codigo = r.glb_grupoeconomico_codigo
  and x.glb_cliente_cgccpfcodigo = r.glb_cliente_cgccpfcodigo
  and x.slf_contrato_codigo = r.slf_contrato_codigo
  and r.slf_clienteregras_ativo = 'S'
  and r.slf_clienteregras_vigencia = (select max(r1.slf_clienteregras_vigencia)
                                      from tdvadm.t_slf_clienteregras r1
                                      where r1.GLB_GRUPOECONOMICO_CODIGO = x.GLB_GRUPOECONOMICO_CODIGO
                                        and r1.GLB_CLIENTE_CGCCPFCODIGO  = x.GLB_CLIENTE_CGCCPFCODIGO
                                        and r1.SLF_CONTRATO_CODIGO       = x.SLF_CONTRATO_CODIGO)
  and x.slf_clientecargas_ativo = 'S'
  and x.slf_clientecargas_vigencia = (select Max(x1.slf_clientecargas_vigencia)
                                      from tdvadm.t_slf_clientecargas x1
                                      where x1.GLB_GRUPOECONOMICO_CODIGO = x.GLB_GRUPOECONOMICO_CODIGO
                                        and x1.GLB_CLIENTE_CGCCPFCODIGO  = x.GLB_CLIENTE_CGCCPFCODIGO
                                        and x1.SLF_CONTRATO_CODIGO       = x.SLF_CONTRATO_CODIGO
                                        and x1.FCF_TPCARGA_CODIGO        = x.FCF_TPCARGA_CODIGO
                                        and x1.FCF_TPCARGA_CODIGOPESQ    = x.FCF_TPCARGA_CODIGOPESQ
                                        and x1.SLF_TPFRETE_CODIGO        = x.SLF_TPFRETE_CODIGO
                                        --and x1.slf_tpfrete_codigocol     = x.slf_tpfrete_codigocol
                                        )
;
