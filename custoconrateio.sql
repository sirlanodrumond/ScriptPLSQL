select x.ctb_referencia_codigo_partida referencia,
       cc.glb_centrocusto_codigo codcc,
       cc.glb_centrocusto_descricao centrocusto,
       x.glb_centrocusto_codigoc codcontrato,
       ccc.glb_centrocusto_descricao contrato,
       oc.slf_contrato_codigo,
       c2.ipf_pconta_codigo conta,
       c2.ipf_pconta_grupo grupo,
       cc.glb_centrocusto_codigo ccorig,
       c2.ipf_pconta_descricao descricao,
       x.ctb_movimento_descricao historico,
--       c2.ipf_pconta_explanacao explanacao,
       c.ctb_pconta_codigo contacontabil,
       c.ctb_pconta_descricao desccontacontabil,
       decode(x.ctb_movimento_tvalor,'C',x.ctb_movimento_valor,0) movcred,
       decode(x.ctb_movimento_tvalor,'D',x.ctb_movimento_valor,0) movdeb,
       o.ctb_origem_descricao origemlanc,
       x.ctb_movimento_cgccnpj clientefornc,
       trim(cl.glb_cliente_razaosocial) || trim(f.glb_fornecedor_nome) descclientefornec,
       oc.ctb_movimentooc_peso peso,
       oc.ctb_movimentooc_carga carga,
       oc.ctb_movimentooc_veiculo veiculo,
       oc.ctb_movimentooc_cargacol cargacol,
       oc.ctb_movimentooc_documento documento,
       'C' tipo,
       'N' RATEIOTODOS,
       0 ipf_indicadores_qtdectechave,
       0 ipf_indicadores_qtdectetot,
       0 ipf_indicadores_qtdectetotTPM,
       0 ipf_indicadores_qtdevfchave,
       0 ipf_indicadores_qtdevftot,
       0 ipf_indicadores_qtdevftotTPM,
       0 ipf_indicadores_qtdefunc,
       0 ipf_indicadores_qtdefunctot,
       0 ratctfretepesoCHAVE,
       0 ratctfretepesotot,
       0 ratctfretepesofrota,
       0 ratctfretepesototfrota,
       0 FATOR,
       'C' tipolanc
from tdvadm.t_ctb_movimento x,
     tdvadm.t_ctb_pconta c,
     tdvipf.t_ipf_ctbdepara dp,
     tdvipf.t_ipf_pconta c2,
     tdvadm.t_glb_centrocusto cc,
     tdvadm.t_glb_centrocusto ccc,
     tdvadm.t_ctb_origem o,
     tdvadm.t_glb_cliente cl,
     tdvadm.t_glb_fornecedor f,
     tdvadm.t_ctb_movimentoOC oc
where to_char(x.ctb_movimento_dtmovto,'yyyymm') = '201907'
  and x.ctb_pconta_codigo_partida = c.ctb_pconta_codigo
  and x.ctb_movimento_cgccnpj = cl.glb_cliente_cgccpfcodigo (+)
  and x.ctb_movimento_cgccnpj = f.glb_fornecedor_cgccpf (+)
  and x.glb_centrocusto_codigo = cc.glb_centrocusto_codigo (+)
  and x.glb_centrocusto_codigoc = ccc.glb_centrocusto_codigo (+)
  and c.ctb_pconta_codigo = dp.ctb_pconta_codigo
  AND X.CTB_PCONTA_CODIGO_PARTIDA = DP.CTB_PCONTA_CODIGO
  and x.ctb_referencia_codigo_partida = dp.ctb_referencia_codigo
  and dp.ipf_pconta_codigo = c2.ipf_pconta_codigo
  and x.ctb_movimento_origem = o.ctb_origem_codigo (+)
  and x.ctb_movimento_documento = oc.ctb_movimento_documento (+)
  and x.ctb_movimento_dsequencia = oc.ctb_movimento_dsequencia (+)
  and x.ctb_movimento_dtmovto = oc.ctb_movimento_dtmovto (+)
;
select * from  tdvipf.v_ipf_centrocustorateado_prec;



select * from xlsuser.v_ctb_centrocustoanalitico x
where x.referencia = '201907'
;

