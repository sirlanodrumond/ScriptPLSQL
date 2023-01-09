select c.con_conhecimento_dtembarque embarque,
       c.con_conhecimento_codigo cte,
       c.glb_rota_codigo rota,
       tdvadm.fn_busca_codigoibge(c.glb_localidade_codigoorigem,'IBD')  origem,
       tdvadm.fn_busca_codigoibge(c.glb_localidade_codigodestino,'IBD') destino,
       tdvadm.fn_busca_codigoibge(ce.glb_localidade_codigo,'IBD') sacado,
       c.arm_carregamento_codigo carreg,
       c.con_conhecimento_cst cst,
       c.con_conhecimento_obslei obslei,
       trim(tdvadm.f_verifica_isencao_subst(V_SOLFRETE_CODIGO    => c.slf_solfrete_codigo || c.slf_tabela_codigo,
                                            V_SOLFRETE_SAQUE     =>  c.slf_solfrete_saque || c.slf_tabela_saque,
                                            V_LOCALIDADE_ORIGEM  => c.glb_localidade_codigoorigem,
                                            V_LOCALIDADE_DESTINO => c.glb_localidade_codigodestino,
                                            V_ROTA_CODIGO        => c.glb_rota_codigo,
                                            V_MERCADORIA_CODIGO  => c.glb_mercadoria_codigo,
                                            V_CLIENTE_REMETENTE  => c.glb_cliente_cgccpfremetente,
                                            V_CLIENTE_SACADO     => c.glb_cliente_cgccpfsacado,
                                            V_TIPORETORNO        => decode(nvl(c.slf_solfrete_codigo,'X'),'X','T','S'),
                                            V_DATAEMBARQUE       => c.con_conhecimento_dtembarque,
                                            V_LEI                => null,
                                            V_CTRC               => c.con_conhecimento_codigo,
                                            V_SERIE              => c.con_conhecimento_serie,
                                            V_ROTA               => c.glb_rota_codigo,
                                            TIPO                 => null)) Tributacao
from tdvadm.t_con_conhecimento c,
     tdvadm.t_glb_cliend ce
where c.arm_carregamento_codigo in ('3512104','3512133')-- '3512103','3512100','3512104')
  and c.glb_cliente_cgccpfsacado = ce.glb_cliente_cgccpfcodigo
  and ce.glb_tpcliend_codigo = 'C';
  

