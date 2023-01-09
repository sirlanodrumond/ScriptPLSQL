drop table tdvadm.synitf_dof;
drop table tdvadm.synitf_idf;
drop table tdvadm.synitf_dof_associados;


create table tdvadm.SYNITF_DOF
(
  informante_est_codigo          VARCHAR2(20 CHAR),
  informante_pfj_chave_origem    VARCHAR2(255 CHAR),
  informante_pfj_origem          VARCHAR2(30 CHAR),
  dof_import_numero              VARCHAR2(40 CHAR),
  ctrl_conteudo                  VARCHAR2(1 CHAR) default 'I',
  edof_codigo                    VARCHAR2(20 CHAR),
  ind_entrada_saida              VARCHAR2(1 CHAR),
  peso_reembalagem_kg            NUMBER(15,4) default 0,
  preco_total_m                  NUMBER(19,2) default 0,
  preco_total_o                  NUMBER(19,2) default 0,
  preco_total_p                  NUMBER(19,2) default 0,
  preco_total_s                  NUMBER(19,2) default 0,
  serie_subserie                 VARCHAR2(6 CHAR),
  sis_codigo                     VARCHAR2(6 CHAR),
  vl_ajuste_preco_total_m        NUMBER(19,2) default 0,
  vl_ajuste_preco_total_p        NUMBER(19,2) default 0,
  vl_ajuste_preco_total_s        NUMBER(19,2) default 0,
  vl_fiscal_m                    NUMBER(19,2) default 0,
  vl_fiscal_o                    NUMBER(19,2) default 0,
  vl_fiscal_p                    NUMBER(19,2) default 0,
  vl_fiscal_s                    NUMBER(19,2) default 0,
  vl_frete                       NUMBER(19,2) default 0,
  vl_outras_despesas             NUMBER(19,2) default 0,
  vl_seguro                      NUMBER(19,2) default 0,
  vl_total_base_icms             NUMBER(19,2) default 0,
  vl_total_base_ipi              NUMBER(19,2) default 0,
  vl_total_base_iss              NUMBER(19,2) default 0,
  vl_total_base_stf              NUMBER(19,2) default 0,
  vl_total_base_stt              NUMBER(19,2) default 0,
  vl_total_contabil              NUMBER(19,2) default 0,
  vl_total_faturado              NUMBER(19,2) default 0,
  vl_total_icms                  NUMBER(19,2) default 0,
  vl_total_ii                    NUMBER(19,2) default 0,
  vl_total_ipi                   NUMBER(19,2) default 0,
  vl_total_irrf                  NUMBER(19,2) default 0,
  vl_total_iss                   NUMBER(19,2) default 0,
  vl_total_stf                   NUMBER(19,2) default 0,
  vl_total_stt                   NUMBER(19,2) default 0,
  cfop_codigo                    VARCHAR2(8 CHAR),
  cobranca_loc_codigo            VARCHAR2(6 CHAR),
  cobranca_pfj_codigo            VARCHAR2(20 CHAR),
  cobranca_loc_chave_origem      VARCHAR2(255 CHAR),
  cobranca_loc_origem            VARCHAR2(30 CHAR),
  cpag_codigo                    VARCHAR2(30 CHAR),
  destinatario_loc_codigo        VARCHAR2(6 CHAR),
  destinatario_pfj_codigo        VARCHAR2(20 CHAR),
  destinatario_loc_chave_origem  VARCHAR2(255 CHAR),
  destinatario_loc_origem        VARCHAR2(30 CHAR),
  dh_emissao                     DATE,
  dt_fato_gerador_imposto        DATE,
  dt_leitura                     DATE,
  dt_prev_chegada                DATE,
  dt_prev_embarque               DATE,
  dt_romaneio                    DATE,
  emitente_loc_codigo            VARCHAR2(6 CHAR),
  emitente_pfj_codigo            VARCHAR2(20 CHAR),
  emitente_loc_chave_origem      VARCHAR2(255 CHAR),
  emitente_loc_origem            VARCHAR2(30 CHAR),
  entrega_loc_codigo             VARCHAR2(6 CHAR),
  entrega_pfj_codigo             VARCHAR2(20 CHAR),
  entrega_loc_chave_origem       VARCHAR2(255 CHAR),
  entrega_loc_origem             VARCHAR2(30 CHAR),
  ind_resp_frete                 VARCHAR2(1 CHAR),
  mun_codigo_iss                 VARCHAR2(60 CHAR),
  nop_codigo                     VARCHAR2(20 CHAR),
  numero                         VARCHAR2(60),
  num_placa_veiculo              VARCHAR2(20 CHAR),
  num_romaneio                   VARCHAR2(20),
  peso_bruto_kg                  NUMBER(15,4) default 0,
  peso_liquido_kg                NUMBER(15,4) default 0,
  placa_veiculo_uf_codigo        VARCHAR2(2 CHAR),
  remetente_loc_codigo           VARCHAR2(6 CHAR),
  remetente_pfj_codigo           VARCHAR2(20 CHAR),
  remetente_loc_chave_origem     VARCHAR2(255 CHAR),
  remetente_loc_origem           VARCHAR2(30 CHAR),
  retirada_loc_codigo            VARCHAR2(6 CHAR),
  retirada_pfj_codigo            VARCHAR2(20 CHAR),
  retirada_loc_chave_origem      VARCHAR2(255 CHAR),
  retirada_loc_origem            VARCHAR2(30 CHAR),
  substituido_pfj_codigo         VARCHAR2(20 CHAR),
  transf_dt_fato_ger_imposto     DATE,
  transf_nop_codigo_entrada      VARCHAR2(20 CHAR),
  transportador_loc_codigo       VARCHAR2(6 CHAR),
  transportador_pfj_codigo       VARCHAR2(20 CHAR),
  transportador_loc_chave_origem VARCHAR2(255 CHAR),
  transportador_loc_origem       VARCHAR2(30 CHAR),
  uf_codigo_destino              VARCHAR2(2 CHAR),
  uf_codigo_origem               VARCHAR2(2 CHAR),
  vt_codigo                      VARCHAR2(6 CHAR),
  ctrl_instrucao                 VARCHAR2(1 CHAR) default 'M',
  msg_critica                    VARCHAR2(2000 CHAR),
  dh_critica                     DATE,
  ctrl_critica                   NUMBER default 0,
  tipo                           VARCHAR2(1 CHAR) default 'N',
  vl_tributavel_difa             NUMBER(19,2),
  vl_total_inss                  NUMBER(19,2) default 0,
  vl_total_cofins                NUMBER(19,2) default 0,
  vl_total_pis_pasep             NUMBER(19,2) default 0,
  vl_total_base_irrf             NUMBER(19,2) default 0,
  vl_total_base_inss             NUMBER(19,2) default 0,
  vl_total_base_cofins           NUMBER(19,2) default 0,
  vl_total_base_pis_pasep        NUMBER(19,2) default 0,
  vl_total_base_icms_difa        NUMBER(19,2) default 0,
  vl_total_icms_difa             NUMBER(19,2) default 0,
  ind_rateio                     VARCHAR2(1 CHAR),
  obs_fiscal_icms                VARCHAR2(4000),
  obs_fiscal_ipi                 VARCHAR2(4000),
  obs_fiscal_irrf                VARCHAR2(4000),
  obs_fiscal_iss                 VARCHAR2(4000),
  obs_fiscal_stf                 VARCHAR2(4000),
  obs_fiscal_stt                 VARCHAR2(4000),
  obs_fiscal_operacional         VARCHAR2(4000),
  cobranca_pfj_origem            VARCHAR2(30 CHAR),
  cobranca_pfj_chave_origem      VARCHAR2(255 CHAR),
  destinatario_pfj_origem        VARCHAR2(30 CHAR),
  destinatario_pfj_chave_origem  VARCHAR2(255 CHAR),
  emitente_pfj_origem            VARCHAR2(30 CHAR),
  emitente_pfj_chave_origem      VARCHAR2(255 CHAR),
  remetente_pfj_origem           VARCHAR2(30 CHAR),
  remetente_pfj_chave_origem     VARCHAR2(255 CHAR),
  entrega_pfj_origem             VARCHAR2(30 CHAR),
  entrega_pfj_chave_origem       VARCHAR2(255 CHAR),
  transportador_pfj_origem       VARCHAR2(30 CHAR),
  transportador_pfj_chave_origem VARCHAR2(255 CHAR),
  substituido_pfj_origem         VARCHAR2(30 CHAR),
  substituido_pfj_chave_origem   VARCHAR2(255 CHAR),
  retirada_pfj_origem            VARCHAR2(30 CHAR),
  retirada_pfj_chave_origem      VARCHAR2(255 CHAR),
  ind_eix                        VARCHAR2(1 CHAR),
  dt_refer_ext                   DATE,
  ctrl_situacao_dof              VARCHAR2(1 CHAR) default 'N',
  ind_usa_if_calc_imp            VARCHAR2(1 CHAR),
  mun_pres_servico               VARCHAR2(60 CHAR),
  vl_base_inss_ret_per           NUMBER(19,2) default 0,
  vl_outros_abat                 NUMBER(19,2) default 0,
  ind_simples_me_epp             VARCHAR2(1 CHAR) default 'N',
  vl_total_base_inss_ret         NUMBER(19,2) default 0,
  vl_total_inss_ret              NUMBER(19,2) default 0,
  vl_total_inss_ret_per          NUMBER(19,2) default 0,
  numero_ate                     VARCHAR2(12 CHAR),
  dt_fato_gerador_ate            DATE,
  autenticacao_digital           VARCHAR2(32 CHAR),
  uf_codigo_entrega              VARCHAR2(2 CHAR),
  uf_codigo_retirada             VARCHAR2(2 CHAR),
  conta_contabil                 VARCHAR2(100 CHAR),
  dt_ref_calc_imp                DATE,
  tipo_pgto                      NUMBER(1),
  num_titulo                     VARCHAR2(255 CHAR),
  desc_titulo                    VARCHAR2(255 CHAR),
  pfj_codigo_redespachante       VARCHAR2(20 CHAR),
  redespachante_pfj_origem       VARCHAR2(30 CHAR),
  redespachante_pfj_chave_origem VARCHAR2(255 CHAR),
  vl_total_iof                   NUMBER(19,2),
  ano_veiculo                    NUMBER(4),
  cert_veiculo                   VARCHAR2(30 CHAR),
  cert_veiculo_uf                VARCHAR2(20 CHAR),
  resp_frete_redesp              VARCHAR2(1 CHAR),
  vl_sec_cat                     NUMBER(19,2),
  vl_despacho                    NUMBER(19,2),
  vl_pedagio                     NUMBER(19,2),
  num_viagem                     VARCHAR2(50 CHAR),
  tipo_tarifa                    NUMBER(1),
  vl_taxa_terrestre              NUMBER(19,2),
  vl_taxa_adv                    NUMBER(19,2),
  edof_codigo_res                VARCHAR2(20 CHAR),
  serie_subserie_res             VARCHAR2(8 CHAR),
  num_ini_res                    VARCHAR2(20 CHAR),
  num_fim_res                    VARCHAR2(20 CHAR),
  qtd_canc_res                   NUMBER(8),
  voo_codigo                     VARCHAR2(50 CHAR),
  cod_iata_ini                   VARCHAR2(3 CHAR),
  cod_iata_fim                   VARCHAR2(3 CHAR),
  dh_inclusao                    DATE default sysdate,
  nfe_protocolo                  VARCHAR2(20 CHAR),
  nfe_localizador                VARCHAR2(50 CHAR),
  nfe_cod_situacao               VARCHAR2(50 CHAR),
  nfe_desc_situacao              VARCHAR2(3000 CHAR),
  vl_abat_nt                     NUMBER(19,2) default 0,
  cod_aut                        VARCHAR2(50 CHAR),
  num_passe                      VARCHAR2(50 CHAR),
  dt_saida_mercadorias           DATE,
  temperatura                    NUMBER(6),
  nome_motorista                 VARCHAR2(255 CHAR),
  cpf                            VARCHAR2(14 CHAR),
  vl_pis_st                      NUMBER(19,2) default 0,
  vl_cofins_st                   NUMBER(19,2) default 0,
  num_ccus_dof                   NUMBER(6),
  num_doc_assoc_dof              NUMBER(6),
  num_impexp_dof                 NUMBER(6),
  num_itens_dof                  NUMBER(6),
  num_parcela_dof                NUMBER(6),
  num_vol_carga_dof              NUMBER(6),
  ind_iss_retido_fonte           VARCHAR2(1 CHAR) default 'N',
  agente                         VARCHAR2(255 CHAR),
  cnpj_col                       VARCHAR2(20 CHAR),
  cnpj_entg                      VARCHAR2(20 CHAR),
  cnx                            VARCHAR2(50 CHAR),
  cod_linha                      VARCHAR2(50 CHAR),
  cod_mun_col                    NUMBER(7),
  cod_mun_entg                   NUMBER(7),
  dem_pta                        NUMBER(15),
  ie_col                         VARCHAR2(20 CHAR),
  ie_entg                        VARCHAR2(20 CHAR),
  im_col                         VARCHAR2(20 CHAR),
  im_entg                        VARCHAR2(20 CHAR),
  ind_classe                     NUMBER(1),
  ind_fome_zero                  NUMBER(1),
  ind_nat_frete                  NUMBER(1),
  ind_nav                        NUMBER(1),
  ind_tfa                        NUMBER(1),
  ind_veic                       NUMBER(1),
  consig_pfj_codigo              VARCHAR2(20 CHAR),
  linha                          VARCHAR2(255 CHAR),
  mun_cod_destino                NUMBER(7),
  mun_cod_origem                 NUMBER(7),
  nat_volume                     VARCHAR2(50 CHAR),
  num_volume_comp                VARCHAR2(50 CHAR),
  otm                            VARCHAR2(50 CHAR),
  peso_brt_comp                  NUMBER(15,2),
  peso_liq_comp                  NUMBER(15,2),
  polt_cab                       VARCHAR2(20 CHAR),
  qtd_pass_orig                  NUMBER(10),
  uf_veic_comp                   VARCHAR2(2 CHAR),
  veic_descr                     VARCHAR2(255 CHAR),
  veic_id_comp                   VARCHAR2(255 CHAR),
  vl_adu                         NUMBER(19,2),
  vl_adu_icms                    NUMBER(19,2),
  vl_desp_car_desc               NUMBER(19,2),
  vl_desp_port                   NUMBER(19,2),
  vl_frete_liq                   NUMBER(19,2),
  vl_frete_mm                    NUMBER(19,2),
  vl_frt_pv                      NUMBER(19,2),
  vl_gris                        NUMBER(19,2),
  vl_peso_tx                     NUMBER(19,2),
  vl_serv_nt                     NUMBER(19,2),
  vl_tfa                         NUMBER(19,2),
  vl_total_fcp                   NUMBER(19,2),
  vl_total_isento_icms           NUMBER(19,2),
  vl_total_mat_terc              NUMBER(19,2),
  vl_total_outros_icms           NUMBER(19,2),
  vl_tx_red                      NUMBER(19,2),
  ind_tit                        VARCHAR2(2 CHAR),
  consig_pfj_origem              VARCHAR2(30 CHAR),
  consig_pfj_chave_origem        VARCHAR2(255 CHAR),
  qtd_prestacoes                 NUMBER(3),
  dt_ref_cpag                    DATE,
  rntc                           VARCHAR2(20 CHAR),
  rntc_comp                      VARCHAR2(20 CHAR),
  veic_id_comp_2                 VARCHAR2(8),
  uf_veic_comp_2                 VARCHAR2(2),
  rntc_comp_2                    VARCHAR2(20),
  codigo_consumo                 VARCHAR2(6 CHAR),
  qtd_canc                       NUMBER(10),
  vl_terc                        NUMBER(19,2),
  sigla_moeda                    VARCHAR2(20),
  uf_embarque                    VARCHAR2(2),
  local_embarque                 VARCHAR2(60),
  tp_ligacao                     VARCHAR2(1),
  cod_grupo_tensao               VARCHAR2(2),
  tp_assinante                   VARCHAR2(1),
  cad_especifico_inss_cei        VARCHAR2(20),
  tdv_sistema_origem             VARCHAR2(50),
  qtd_consumo                    NUMBER(19),
  dt_exe_serv                    DATE,
  nform_final                    VARCHAR2(12),
  nform_inicial                  VARCHAR2(12),
  vl_total_pis_ret               NUMBER(19,2),
  vl_total_cofins_ret            NUMBER(19,2),
  vl_total_base_pis_ret          NUMBER(19,2),
  vl_total_base_cofins_ret       NUMBER(19,2),
  vl_total_csll_ret              NUMBER(19,2),
  vl_total_base_csll_ret         NUMBER(19,2),
  ind_nfe_ajuste                 VARCHAR2(1) default 'N',
  crt_codigo                     VARCHAR2(1 CHAR) default '0',
  tipo_cte                       NUMBER(1),
  num_embarque                   VARCHAR2(12),
  vl_base_ct_stf                 NUMBER(19,2),
  vl_ct_stf                      NUMBER(19,2),
  vl_total_base_icms_fcp         NUMBER(19,2),
  vl_total_base_icms_part_rem    NUMBER(19,2),
  vl_total_icms_part_rem         NUMBER(19,2),
  vl_total_base_icms_part_dest   NUMBER(19,2),
  vl_total_icms_part_dest        NUMBER(19,2),
  hash                           VARCHAR2(100 CHAR),
  observacao                     VARCHAR2(255 CHAR)
);
-- Add comments to the columns 
comment on column SYNITF_DOF.informante_est_codigo
  is 'Codigo do estabelecimento informante do DOF.';
comment on column SYNITF_DOF.informante_pfj_chave_origem
  is 'Codigo do estabelecimento informante do DOF no sistema / tabela origem.';
comment on column SYNITF_DOF.informante_pfj_origem
  is 'Nome do sistema ou tabela origem do estabelecimento informante do DOF.';
comment on column SYNITF_DOF.dof_import_numero
  is 'Codigo (ID) do DOF no sistema / tabela origem.';
comment on column SYNITF_DOF.ctrl_conteudo
  is 'Indicador de controle de conteudo do DOF.';
comment on column SYNITF_DOF.edof_codigo
  is 'Codigo da especie do documento fiscal.';
comment on column SYNITF_DOF.ind_entrada_saida
  is 'Indicador de entrada ou saida do documento.';
comment on column SYNITF_DOF.peso_reembalagem_kg
  is 'Peso total de reembalagens dos itens tipo mercadoria.';
comment on column SYNITF_DOF.preco_total_m
  is 'Somatorio dos precos totais dos itens tipo mercadoria.';
comment on column SYNITF_DOF.preco_total_o
  is 'Somatorio dos precos totais dos itens tipo outros.';
comment on column SYNITF_DOF.preco_total_p
  is 'Somatorio dos precos totais dos itens tipo prestacao.';
comment on column SYNITF_DOF.preco_total_s
  is 'Somatorio dos precos totais dos itens tipo servico.';
comment on column SYNITF_DOF.serie_subserie
  is 'Serie/sub-serie do documento.';
comment on column SYNITF_DOF.sis_codigo
  is 'Codigo do sistema origem.';
comment on column SYNITF_DOF.vl_ajuste_preco_total_m
  is 'Valor do ajuste (+/-) sobre o preco total dos itens tipo mercadoria.';
comment on column SYNITF_DOF.vl_ajuste_preco_total_p
  is 'Valor do ajuste (+/-) sobre o preco total dos itens tipo prestacao.';
comment on column SYNITF_DOF.vl_ajuste_preco_total_s
  is 'Valor do ajuste (+/-) sobre o preco total dos itens tipo servico.';
comment on column SYNITF_DOF.vl_fiscal_m
  is 'Somatorio dos valores fiscais dos itens tipo mercadoria.';
comment on column SYNITF_DOF.vl_fiscal_o
  is 'Somatorio dos valores fiscais dos itens tipo outros.';
comment on column SYNITF_DOF.vl_fiscal_p
  is 'Somatorio dos valores fiscais dos itens tipo prestacao.';
comment on column SYNITF_DOF.vl_fiscal_s
  is 'Somatorio dos valores fiscais dos itens tipo servico.';
comment on column SYNITF_DOF.vl_frete
  is 'Valor total do frete.';
comment on column SYNITF_DOF.vl_outras_despesas
  is 'Valor total de outras despesas acessorias.';
comment on column SYNITF_DOF.vl_seguro
  is 'Valor total de seguro.';
comment on column SYNITF_DOF.vl_total_base_icms
  is 'Somatorio da base tributavel de ICMS dos Itens do DOF.';
comment on column SYNITF_DOF.vl_total_base_ipi
  is 'Somatorio da base tributavel de IPI dos Itens do DOF.';
comment on column SYNITF_DOF.vl_total_base_iss
  is 'Somatorio das bases de ISS dos itens do DOF.';
comment on column SYNITF_DOF.vl_total_base_stf
  is 'Somatorio da base tributavel de ICMS substituicao tributaria para frente (STF) dos Itens do DOF.';
comment on column SYNITF_DOF.vl_total_base_stt
  is 'Somatorio da base tributavel de ICMS substituicao tributaria para tras (STT) dos Itens do DOF.';
comment on column SYNITF_DOF.vl_total_contabil
  is 'Somatorio do valor contabil dos Itens do DOF.';
comment on column SYNITF_DOF.vl_total_faturado
  is 'Somatorio do valor faturado dos Itens do DOF.';
comment on column SYNITF_DOF.vl_total_icms
  is 'Somatorio do valor do ICMS dos Itens do DOF.';
comment on column SYNITF_DOF.vl_total_ii
  is 'Somatorio do valor de Imposto de Importacao dos itens do DOF.';
comment on column SYNITF_DOF.vl_total_ipi
  is 'Somatorio do valor de IPI dos itens do DOF.';
comment on column SYNITF_DOF.vl_total_irrf
  is 'Somatorio do valor de IRRF dos itens do DOF.';
comment on column SYNITF_DOF.vl_total_iss
  is 'Somatorio do valor de ISS dos itens do DOF.';
comment on column SYNITF_DOF.vl_total_stf
  is 'Somatorio do valor do ICMS substituicao tributaria para frente (STF) dos Itens do DOF.';
comment on column SYNITF_DOF.vl_total_stt
  is 'Somatorio do valor do ICMS substituicao tributaria para tras (STT) dos itens do DOF.';
comment on column SYNITF_DOF.cfop_codigo
  is 'Codigo fiscal de operacao e prestacao.';
comment on column SYNITF_DOF.cobranca_loc_codigo
  is 'Codigo interno da localidade da PFJ de Cobranca.';
comment on column SYNITF_DOF.cobranca_pfj_codigo
  is 'Codigo interno da PFJ de cobranca.';
comment on column SYNITF_DOF.cobranca_loc_chave_origem
  is 'Codigo da localidade de cobranca no sistema / tabela origem.';
comment on column SYNITF_DOF.cobranca_loc_origem
  is 'Nome do sistema / tabela origem da localidade de cobranca.';
comment on column SYNITF_DOF.cpag_codigo
  is 'Codigo da condicao de pagamento do DOF.';
comment on column SYNITF_DOF.destinatario_loc_codigo
  is 'Codigo interno da Localidade da PFJ destinataria.';
comment on column SYNITF_DOF.destinatario_pfj_codigo
  is 'Codigo interno da PFJ destinataria.';
comment on column SYNITF_DOF.destinatario_loc_chave_origem
  is 'Codigo da localidade destinataria no sistema / tabela origem.';
comment on column SYNITF_DOF.destinatario_loc_origem
  is 'Nome do sistema ou tabela origem da localidade destinataria.';
comment on column SYNITF_DOF.dh_emissao
  is 'Data da emissao do documento fiscal.';
comment on column SYNITF_DOF.dt_fato_gerador_imposto
  is 'Data do fato gerador do imposto.';
comment on column SYNITF_DOF.dt_leitura
  is 'Data de leitura do ponto de consumo.';
comment on column SYNITF_DOF.dt_prev_chegada
  is 'Data de previsao de chegada.';
comment on column SYNITF_DOF.dt_prev_embarque
  is 'Data de previsao para embarque.';
comment on column SYNITF_DOF.dt_romaneio
  is 'Data do romaneio.';
comment on column SYNITF_DOF.emitente_loc_codigo
  is 'Codigo interno da Localidade da PFJ Emitente.';
comment on column SYNITF_DOF.emitente_pfj_codigo
  is 'Codigo interno da PFJ emitente.';
comment on column SYNITF_DOF.emitente_loc_chave_origem
  is 'Codigo da PFJ emitente no sistema / tabela origem.';
comment on column SYNITF_DOF.emitente_loc_origem
  is 'Nome do sistema ou tabela origem da localidade do emitente.';
comment on column SYNITF_DOF.entrega_loc_codigo
  is 'Codigo interno da localidade da PFJ de entrega.';
comment on column SYNITF_DOF.entrega_pfj_codigo
  is 'Codigo interno da PFJ de entrega.';
comment on column SYNITF_DOF.entrega_loc_chave_origem
  is 'Codigo da localidade da PFJ de entrega no sistema / tabela origem.';
comment on column SYNITF_DOF.entrega_loc_origem
  is 'Nome do sistema / tabela origem da localidade da PFJ de entrega.';
comment on column SYNITF_DOF.ind_resp_frete
  is 'Indicador de responsabilidade pelo pagamento do frete.';
comment on column SYNITF_DOF.mun_codigo_iss
  is 'Codigo do Municipio onde o ISS eh devido.';
comment on column SYNITF_DOF.nop_codigo
  is 'Codigo da natureza de operacao (Modulo Fiscal).';
comment on column SYNITF_DOF.numero
  is 'Numero do DOF. Para documentos fiscais de Telecomunicações e Energia é o número inicial de cada grupo de 1.000.000 de documentos.';
comment on column SYNITF_DOF.num_placa_veiculo
  is 'Numero da placa do veiculo transportador.';
comment on column SYNITF_DOF.num_romaneio
  is 'Numero do Romaneio';
comment on column SYNITF_DOF.peso_bruto_kg
  is 'Peso Bruto Total em quilos para itens do tipo mercadoria.';
comment on column SYNITF_DOF.peso_liquido_kg
  is 'Peso Liquido Total em quilos para itens do tipo mercadoria.';
comment on column SYNITF_DOF.placa_veiculo_uf_codigo
  is 'UF da placa do veiculo transportador.';
comment on column SYNITF_DOF.remetente_loc_codigo
  is 'Codigo interno da Localidade da PFJ Remetente.';
comment on column SYNITF_DOF.remetente_pfj_codigo
  is 'Codigo interno da PFJ Remetente.';
comment on column SYNITF_DOF.remetente_loc_chave_origem
  is 'Codigo da localidade da PFJ remetente no sistema / tabela origem.';
comment on column SYNITF_DOF.remetente_loc_origem
  is 'Nome do sistema / tabela origem da localidade da PFJ remetente.';
comment on column SYNITF_DOF.retirada_loc_codigo
  is 'Codigo interno da localidade da PFJ de retirada da mercadoria.';
comment on column SYNITF_DOF.retirada_pfj_codigo
  is 'Codigo interno da PFJ de retirada da mercadoria.';
comment on column SYNITF_DOF.retirada_loc_chave_origem
  is 'Codigo da localidade da PFJ de retirada no sistema / tabela origem.';
comment on column SYNITF_DOF.retirada_loc_origem
  is 'Nome do sistema / tabela origem da localidade da PFJ de retirada.';
comment on column SYNITF_DOF.substituido_pfj_codigo
  is 'Codigo interno da PFJ substituida na emissao (nao confundir com substituicao tributaria).';
comment on column SYNITF_DOF.transf_dt_fato_ger_imposto
  is 'Data do fato gerador da efetivacao de transferencia entre estabelecimentos (para escrituracao automatica - LFIS entrada comandada).';
comment on column SYNITF_DOF.transf_nop_codigo_entrada
  is 'NOP de efetivacao de transferencia entre estabelecimentos (para escrituracao automatica - LFIS entrada comandada).';
comment on column SYNITF_DOF.transportador_loc_codigo
  is 'Codigo interno da localidade da PFJ transportadora.';
comment on column SYNITF_DOF.transportador_pfj_codigo
  is 'Codigo interno da PFJ transportadora da mercadoria.';
comment on column SYNITF_DOF.transportador_loc_chave_origem
  is 'Codigo da localidade da PFJ transportadora no sistema / tabela origem.';
comment on column SYNITF_DOF.transportador_loc_origem
  is 'Nome do sistema / tabela origem da localidade da PFJ.';
comment on column SYNITF_DOF.uf_codigo_destino
  is '(Nao Utilizar) Sigla da unidade federativa.';
comment on column SYNITF_DOF.uf_codigo_origem
  is '(Nao Utilizar) Sigla da unidade federativa.';
comment on column SYNITF_DOF.vt_codigo
  is 'Codigo da via de transporte.';
comment on column SYNITF_DOF.ctrl_instrucao
  is 'Controle de Instrucao (I)nclusao, (A)lteracao, (E)xclusao ou (M)ix inclui ou altera.';
comment on column SYNITF_DOF.msg_critica
  is '(Uso exclusivo da Synchro) Mensagem de Critica.';
comment on column SYNITF_DOF.dh_critica
  is '(Uso exclusivo da Synchro) Data da ultima critica.';
comment on column SYNITF_DOF.ctrl_critica
  is '(Uso exclusivo da Synchro) Quantidade de vezes que o registro ja foi criticado.';
comment on column SYNITF_DOF.tipo
  is 'Tipo de documento fiscal.';
comment on column SYNITF_DOF.vl_tributavel_difa
  is 'Somatorio dos valores tributaveis de base tributavel do diferencial de aliquota ICMS dos itens.';
comment on column SYNITF_DOF.vl_total_inss
  is 'Somatorio do valor de INSS dos itens do tipo servico.';
comment on column SYNITF_DOF.vl_total_cofins
  is 'Somatorio dos valores de COFINS (Contribuicao para Financiamento da Seguridade Social) dos itens do DOF.';
comment on column SYNITF_DOF.vl_total_pis_pasep
  is 'Somatorio do valor de PIS/PASEP dos itens do DOF.';
comment on column SYNITF_DOF.vl_total_base_irrf
  is 'Somatorio das bases de IRRF dos itens do DOF.';
comment on column SYNITF_DOF.vl_total_base_inss
  is 'Somatorio das bases de INSS dos itens do DOF.';
comment on column SYNITF_DOF.vl_total_base_cofins
  is 'Somatorio dos valores base de COFINS (Contribuicao para Financiamento da Seguridade Social) dos itens do DOF.';
comment on column SYNITF_DOF.vl_total_base_pis_pasep
  is 'Somatorio das bases de PIS/PASEP dos itens do DOF.';
comment on column SYNITF_DOF.vl_total_base_icms_difa
  is 'Somatorio da base tributavel do  base tributavel do diferencial de aliquotas (DIFA) do ICMS.';
comment on column SYNITF_DOF.vl_total_icms_difa
  is 'Somatorio do valor do ICMS base tributavel do diferencial de aliquotas.';
comment on column SYNITF_DOF.ind_rateio
  is 'Indica o rateio de frete para documentos tipo conhecimento de transporte.';
comment on column SYNITF_DOF.obs_fiscal_icms
  is 'Mensagens de ICMS associadas ao DOF.';
comment on column SYNITF_DOF.obs_fiscal_ipi
  is 'Mensagens de IPI associadas ao DOF.';
comment on column SYNITF_DOF.obs_fiscal_irrf
  is 'Mensagens de IRRF associadas ao DOF.';
comment on column SYNITF_DOF.obs_fiscal_iss
  is 'Mensagens de ISS associadas ao DOF.';
comment on column SYNITF_DOF.obs_fiscal_stf
  is 'Mensagens de STF (substituicao tributaria para frente) associadas ao DOF.';
comment on column SYNITF_DOF.obs_fiscal_stt
  is 'Mensagens de STT (substituicao tributaria para tras) associadas ao DOF.';
comment on column SYNITF_DOF.obs_fiscal_operacional
  is 'Mensagem operacional associada ao DOF.';
comment on column SYNITF_DOF.cobranca_pfj_origem
  is 'Nome do sistema / tabela origem da PFJ de cobranca.';
comment on column SYNITF_DOF.cobranca_pfj_chave_origem
  is 'Codigo da PFJ destinataria no sistema / tabela origem.';
comment on column SYNITF_DOF.destinatario_pfj_origem
  is 'Nome do sistema / tabela origem da PFJ destinataria.';
comment on column SYNITF_DOF.destinatario_pfj_chave_origem
  is 'Codigo da PFJ Destinataria no Sistema / Tabela origem.';
comment on column SYNITF_DOF.emitente_pfj_origem
  is 'Nome do Sistema / Tabela origem da PFJ Emitente.';
comment on column SYNITF_DOF.emitente_pfj_chave_origem
  is 'Codigo da PFJ Emitente no Sistema / Tabela origem.';
comment on column SYNITF_DOF.remetente_pfj_origem
  is 'Nome do sistema / tabela origem da PFJ remetente.';
comment on column SYNITF_DOF.remetente_pfj_chave_origem
  is 'Codigo da PFJ remetente no sistema / tabela origem.';
comment on column SYNITF_DOF.entrega_pfj_origem
  is 'Nome do sistema / tabela origem da PFJ de entrega.';
comment on column SYNITF_DOF.entrega_pfj_chave_origem
  is 'Codigo da PFJ de entrega no sistema / tabela origem.';
comment on column SYNITF_DOF.transportador_pfj_origem
  is 'Nome do sistema / tabela origem da PFJ transportadora.';
comment on column SYNITF_DOF.transportador_pfj_chave_origem
  is 'Codigo da PFJ transportadora no sistema / tabela origem.';
comment on column SYNITF_DOF.substituido_pfj_origem
  is 'Nome do sistema / tabela origem da PFJ substituida.';
comment on column SYNITF_DOF.substituido_pfj_chave_origem
  is 'Codigo da PFJ substituida no sistema / tabela origem.';
comment on column SYNITF_DOF.retirada_pfj_origem
  is 'Nome do sistema / tabela origem da PFJ de retirada.';
comment on column SYNITF_DOF.retirada_pfj_chave_origem
  is 'Codigo da PFJ de retirada no sistema / tabela origem.';
comment on column SYNITF_DOF.ind_eix
  is 'Indicador de ambito da operacao.';
comment on column SYNITF_DOF.dt_refer_ext
  is 'Data de referencia para lancamento extemporaneo.';
comment on column SYNITF_DOF.ctrl_situacao_dof
  is 'Indicador da situacao do DOF.';
comment on column SYNITF_DOF.ind_usa_if_calc_imp
  is 'Indica se o documento sera calculado pelo modulo Expert Fiscal.';
comment on column SYNITF_DOF.mun_pres_servico
  is 'Codigo do municipio onde o servico foi prestado.';
comment on column SYNITF_DOF.vl_base_inss_ret_per
  is 'Valor base para calculo do INSS retido em outras empresas no mes (para verificacao do teto salario-contribuicao).';
comment on column SYNITF_DOF.vl_outros_abat
  is 'Valor de outros abatimentos do documento fiscal.';
comment on column SYNITF_DOF.ind_simples_me_epp
  is 'Indicador de optante pelo SIMPLES, ME ou EPP.';
comment on column SYNITF_DOF.vl_total_base_inss_ret
  is 'Valor base para calculo do INSS retido no documento fiscal.';
comment on column SYNITF_DOF.vl_total_inss_ret
  is 'Valor do INSS retido no documento fiscal.';
comment on column SYNITF_DOF.vl_total_inss_ret_per
  is 'Valor do INSS retido em outras empresas.';
comment on column SYNITF_DOF.numero_ate
  is 'Numero do ultimo documento de via unica consolidado.';
comment on column SYNITF_DOF.dt_fato_gerador_ate
  is 'Data do fato gerador do ultimo documento de via unica.';
comment on column SYNITF_DOF.autenticacao_digital
  is 'Autenticacao digital do arquivo mestre gerado para ser entregue a SEFAZ (hash code).';
comment on column SYNITF_DOF.uf_codigo_entrega
  is 'Sigla da unidade federativa da PFJ de entrega da operacao.';
comment on column SYNITF_DOF.uf_codigo_retirada
  is 'Sigla da unidade federativa.';
comment on column SYNITF_DOF.conta_contabil
  is 'Codigo da conta contabil.';
comment on column SYNITF_DOF.dt_ref_calc_imp
  is 'Data de referencia para calculo de impostos.';
comment on column SYNITF_DOF.tipo_pgto
  is 'Indicador do Tipo do Pagamento.';
comment on column SYNITF_DOF.num_titulo
  is 'Numero do titulo de cobranca relacionado ao documento fiscal.';
comment on column SYNITF_DOF.desc_titulo
  is 'Descricao do titulo bancario.';
comment on column SYNITF_DOF.pfj_codigo_redespachante
  is 'Codigo interno da PFJ redespachante da mercadoria.';
comment on column SYNITF_DOF.redespachante_pfj_origem
  is 'Nome do sistema / tabela origem da PFJ redespachante.';
comment on column SYNITF_DOF.redespachante_pfj_chave_origem
  is 'Codigo da PFJ redespachante no sistema / tabela origem.';
comment on column SYNITF_DOF.vl_total_iof
  is 'Somatorio do valor de Imposto de IOF dos itens do DOF.';
comment on column SYNITF_DOF.ano_veiculo
  is 'Ano do veiculo transportador.';
comment on column SYNITF_DOF.cert_veiculo
  is 'Certificado de pripriedade do veiculo transportador.';
comment on column SYNITF_DOF.cert_veiculo_uf
  is 'Sigla da unidade federativa do certificado de propriedade do veiculo transportador.';
comment on column SYNITF_DOF.resp_frete_redesp
  is 'Pessoa responsavel pelo pagamento do frete no redespacho.';
comment on column SYNITF_DOF.vl_sec_cat
  is 'Valor do Sec/Cat (servicos de coleta/custo adicional de transporte).';
comment on column SYNITF_DOF.vl_despacho
  is 'Valor de despacho do transporte.';
comment on column SYNITF_DOF.vl_pedagio
  is 'Valor de pedagio do transporte.';
comment on column SYNITF_DOF.num_viagem
  is 'Numero da viagem no conhecimento aereo.';
comment on column SYNITF_DOF.tipo_tarifa
  is 'Indicador do tipo de tarifa aplicada no conhecimento aereo. ';
comment on column SYNITF_DOF.vl_taxa_terrestre
  is 'Valor da taxa terrestre no conhecimento aereo.';
comment on column SYNITF_DOF.vl_taxa_adv
  is 'Valor da taxa "ad valorem" no conhecimento aereo.';
comment on column SYNITF_DOF.edof_codigo_res
  is 'Especie dos documentos que formam o mapa resumo.';
comment on column SYNITF_DOF.serie_subserie_res
  is 'Serie/sub-serie dos documentos fiscais que formam o mapa resumo.';
comment on column SYNITF_DOF.num_ini_res
  is 'Numero inicial dos documentos que formam o mapa resumo modelo 18.';
comment on column SYNITF_DOF.num_fim_res
  is 'Numero final dos documentos que formam o mapa resumo modelo 18.';
comment on column SYNITF_DOF.qtd_canc_res
  is 'Quantidade de documentos cancelados que formam o mapa resumo.';
comment on column SYNITF_DOF.voo_codigo
  is 'Numero do voo no conhecimento aereo.';
comment on column SYNITF_DOF.cod_iata_ini
  is 'Codigo IATA da cidade de inicio do voo no conhecimento aereo.';
comment on column SYNITF_DOF.cod_iata_fim
  is 'Codigo IATA da cidade final do voo no conhecimento aereo.';
comment on column SYNITF_DOF.dh_inclusao
  is '(Uso exclusivo da Synchro) Data de inclusao do registro na tabela de Open Interface.';
comment on column SYNITF_DOF.nfe_protocolo
  is 'Numero do protocolo da nota fiscal eletronica.';
comment on column SYNITF_DOF.nfe_localizador
  is 'Localizador da NFe na SEFAZ.';
comment on column SYNITF_DOF.nfe_cod_situacao
  is 'Codigo da situacao da nota fiscal eletronica.';
comment on column SYNITF_DOF.nfe_desc_situacao
  is 'Descricao da situacao da nota fiscal eletronica.';
comment on column SYNITF_DOF.vl_abat_nt
  is 'Valor de abatimento nao tributado e nao comercial.';
comment on column SYNITF_DOF.cod_aut
  is 'Codigo da autorizacao fornecido pela SEFAZ (transporte de combustiveis).';
comment on column SYNITF_DOF.num_passe
  is 'Numero do Passe Fiscal referente ao transporte de combustiveis.';
comment on column SYNITF_DOF.dt_saida_mercadorias
  is 'Data e hora da saida das mercadorias (transporte de combustiveis).';
comment on column SYNITF_DOF.temperatura
  is 'Temperatura em graus celsius utilizada para quantificacao do volume de combustivel (transporte de combustiveis).';
comment on column SYNITF_DOF.nome_motorista
  is 'Nome do motorista (transporte de combustiveis).';
comment on column SYNITF_DOF.cpf
  is 'CPF do motorista (transporte de combustiveis).';
comment on column SYNITF_DOF.vl_pis_st
  is 'Valor total do PIS retido por substituicao tributaria.';
comment on column SYNITF_DOF.vl_cofins_st
  is 'Valor total da COFINS retida por substituicao tributaria.';
comment on column SYNITF_DOF.num_ccus_dof
  is '(Nao Utilizar) Quantidade de registros de Centros de Custos esperados.';
comment on column SYNITF_DOF.num_doc_assoc_dof
  is '(Nao Utilizar) Quantidade de registros de Documentos Associados esperados.';
comment on column SYNITF_DOF.num_impexp_dof
  is '(Nao Utilizar) Quantidade de registros de Importacao / Exportacao esperados.';
comment on column SYNITF_DOF.num_itens_dof
  is '(Nao Utilizar) Quantidade de registros de Itens do Documento Fiscal esperados.';
comment on column SYNITF_DOF.num_parcela_dof
  is '(Nao Utilizar) Quantidade de registros de Parcelas esperados.';
comment on column SYNITF_DOF.num_vol_carga_dof
  is '(Nao Utilizar) Quantidade de registros de Volume / Carga esperados.';
comment on column SYNITF_DOF.ind_iss_retido_fonte
  is 'Indicador de ISS retido na fonte.';
comment on column SYNITF_DOF.agente
  is 'Identificacao do agente responsavel pelo bilhete de transporte.';
comment on column SYNITF_DOF.cnpj_col
  is 'CNPJ do local de coleta aquisicao ou prestacao de transporte.';
comment on column SYNITF_DOF.cnpj_entg
  is 'CNPJ do local de entrega.';
comment on column SYNITF_DOF.cnx
  is 'Identificacao da conexao do bilhete aereo.';
comment on column SYNITF_DOF.cod_linha
  is 'Codigo do prefixo da linha de transporte, proprio da transportadora.';
comment on column SYNITF_DOF.cod_mun_col
  is 'Codigo do municipio do local da coleta.';
comment on column SYNITF_DOF.cod_mun_entg
  is 'Codigo do municipio do local da entrega.';
comment on column SYNITF_DOF.dem_pta
  is 'Demanda contratada da ponta das operacoes com energia eletrica ou fornecimento de gas.';
comment on column SYNITF_DOF.ie_col
  is 'Inscricao estadual do local da coleta.';
comment on column SYNITF_DOF.ie_entg
  is 'Inscricao estadual do local da entrega.';
comment on column SYNITF_DOF.im_col
  is 'Inscricao municipal do local da coleta.';
comment on column SYNITF_DOF.im_entg
  is 'Inscricao municipal do local da entrega.';
comment on column SYNITF_DOF.ind_classe
  is 'Indicador da classe da passagem.';
comment on column SYNITF_DOF.ind_fome_zero
  is 'Indicador de nota fiscal recebida/destinada de/a participante do Programa Fome Zero.';
comment on column SYNITF_DOF.ind_nat_frete
  is 'Indicador da natureza do frete.';
comment on column SYNITF_DOF.ind_nav
  is 'Indicador do tipo de navegacao.';
comment on column SYNITF_DOF.ind_tfa
  is 'Indicador do tipo de tarifa aplicada.';
comment on column SYNITF_DOF.ind_veic
  is 'Indicador do tipo do veiculo transportador.';
comment on column SYNITF_DOF.consig_pfj_codigo
  is 'Codigo da PFJ Consignataria.';
comment on column SYNITF_DOF.linha
  is 'Descricao da linha de transporte.';
comment on column SYNITF_DOF.mun_cod_destino
  is 'Codigo do municipio destino do servico.';
comment on column SYNITF_DOF.mun_cod_origem
  is 'Codigo do municipio origem do servico.';
comment on column SYNITF_DOF.nat_volume
  is 'Natureza dos volumes transportados.';
comment on column SYNITF_DOF.num_volume_comp
  is 'Numeracao dos volumes transportados pelo veiculo composto.';
comment on column SYNITF_DOF.otm
  is 'Registro do operador de transporte multimodal.';
comment on column SYNITF_DOF.peso_brt_comp
  is 'Peso bruto dos volumes transportados (em Kg) pelo veiculo composto.';
comment on column SYNITF_DOF.peso_liq_comp
  is 'Peso liquido dos volumes transportados (em Kg) pelo veiculo composto.';
comment on column SYNITF_DOF.polt_cab
  is 'Numero da poltrona ou cabine.';
comment on column SYNITF_DOF.qtd_pass_orig
  is 'Quantidade de passageiros embarcados na cidade de origem.';
comment on column SYNITF_DOF.uf_veic_comp
  is 'Sigla da unidade federativa que consta na placa do veiculo composto.';
comment on column SYNITF_DOF.veic_descr
  is 'Descricao do veiculo transportador.';
comment on column SYNITF_DOF.veic_id_comp
  is 'Placa de identificacao do veiculo composto (reboque).';
comment on column SYNITF_DOF.vl_adu
  is 'Valor das despesas aduaneiras que nao integram a base de calculo do ICMS.';
comment on column SYNITF_DOF.vl_adu_icms
  is 'Valor das despesas aduaneiras que integram a base de calculo do ICMS.';
comment on column SYNITF_DOF.vl_desp_car_desc
  is 'Valor das despesas com carga e descarga.';
comment on column SYNITF_DOF.vl_desp_port
  is 'Valor das despesas portuarias referente as tabelas "A" ou "M".';
comment on column SYNITF_DOF.vl_frete_liq
  is 'Valor liquido do frete.';
comment on column SYNITF_DOF.vl_frete_mm
  is 'Valor adicional do frete para Marinha Mercante.';
comment on column SYNITF_DOF.vl_frt_pv
  is 'Valor do frete por peso/volume.';
comment on column SYNITF_DOF.vl_gris
  is 'Valor do gris (gerenciamento de risco).';
comment on column SYNITF_DOF.vl_peso_tx
  is 'Peso taxado.';
comment on column SYNITF_DOF.vl_serv_nt
  is 'Valor total dos servicos nao tributados.';
comment on column SYNITF_DOF.vl_tfa
  is 'Valor da tarifa.';
comment on column SYNITF_DOF.vl_total_fcp
  is 'Valor do ICMS resultante da aliquota adicional dos itens incluidos no Fundo de Combate a Pobreza';
comment on column SYNITF_DOF.vl_total_isento_icms
  is 'Valor total das operacoes isentas do ICMS.';
comment on column SYNITF_DOF.vl_total_mat_terc
  is 'Valor total do material de terceiros utilizado na prestacao do servico.';
comment on column SYNITF_DOF.vl_total_outros_icms
  is 'Valor total das outras operacoes do ICMS.';
comment on column SYNITF_DOF.vl_tx_red
  is 'Valor da taxa de redespacho.';
comment on column SYNITF_DOF.ind_tit
  is 'Indicador do tipo de fatura/titulo de credito.';
comment on column SYNITF_DOF.consig_pfj_origem
  is 'Nome do sistema / tabela origem do registro.';
comment on column SYNITF_DOF.consig_pfj_chave_origem
  is 'Codigo da PFJ no sistema / tabela origem.';
comment on column SYNITF_DOF.qtd_prestacoes
  is 'Quantidade de parcelas de pagamento calculada.';
comment on column SYNITF_DOF.dt_ref_cpag
  is 'Data de referencia para a criacao das parcelas de pagamento.';
comment on column SYNITF_DOF.rntc
  is 'Registro Nacional do Transportador de Carga na Agencia Nacional de Transportes Terrestres.';
comment on column SYNITF_DOF.rntc_comp
  is 'Registro Nacional do Transportador de Carga do veiculo composto na Agencia Nacional de Transportes Terrestres.';
comment on column SYNITF_DOF.veic_id_comp_2
  is 'Placa de identificacao do segundo veiculo composto.';
comment on column SYNITF_DOF.uf_veic_comp_2
  is 'UF da placa do segundo veiculo composto.';
comment on column SYNITF_DOF.rntc_comp_2
  is 'Registro Nacional do Transportador de Carga do segundo veiculo composto na Agencia.';
comment on column SYNITF_DOF.codigo_consumo
  is 'Codigo da classe de consumo de telecomunicacao ou energia eletrica.';
comment on column SYNITF_DOF.qtd_canc
  is 'Quantidade de documentos cancelados na consolidacao';
comment on column SYNITF_DOF.vl_terc
  is 'Valor cobrado por terceiros';
comment on column SYNITF_DOF.sigla_moeda
  is 'Sigla da Moeda dos valores do DOF.';
comment on column SYNITF_DOF.uf_embarque
  is 'Unidade Federativa (UF) do local de embarque da exportacao.';
comment on column SYNITF_DOF.local_embarque
  is 'Local onde ocorrera o embarque da exportacao.';
comment on column SYNITF_DOF.tp_ligacao
  is 'Codigo de tipo de Ligacao de Energia Eletrica';
comment on column SYNITF_DOF.cod_grupo_tensao
  is 'Codigo de grupo de Energia Eletrica';
comment on column SYNITF_DOF.tp_assinante
  is 'Codigo do Tipo de Assinante de Comunicacao/Telecomunicacao';
comment on column SYNITF_DOF.cad_especifico_inss_cei
  is 'Matricula no Cadastro Especifico do INSS (CEI).';
comment on column SYNITF_DOF.qtd_consumo
  is 'Quantidade do Consumo total acumulado, em kWh (Modelo de documento 06 - Energia Eletrica)';
comment on column SYNITF_DOF.dt_exe_serv
  is 'Data de Execucao / Conclusao do Servico';
comment on column SYNITF_DOF.nform_final
  is 'Numero Final do Formulario do Documento Fiscal.';
comment on column SYNITF_DOF.nform_inicial
  is 'Numero Inicial do Formulario do Documento Fiscal.';
comment on column SYNITF_DOF.vl_total_pis_ret
  is 'Valor total da retencao do PIS/PASEP. Somatorio do valor de PIS/PASEP retido dos itens do DOF';
comment on column SYNITF_DOF.vl_total_cofins_ret
  is 'Valor total da retencao da COFINS. Somatorio do valor de COFINS retido dos itens do DOF';
comment on column SYNITF_DOF.vl_total_base_pis_ret
  is 'Valor base para calculo de retencao do PIS/PASEP. Somatorio das bases de PIS/PASEP retido dos itens do DOF';
comment on column SYNITF_DOF.vl_total_base_cofins_ret
  is 'Valor base para calculo de retencao da COFINS. Somatorio das bases de COFINS retida dos itens do DOF';
comment on column SYNITF_DOF.vl_total_csll_ret
  is 'Valor total da retencao da CSLL. Somatorio do valor de CSLL retido dos itens do DOF';
comment on column SYNITF_DOF.vl_total_base_csll_ret
  is 'Valor base para calculo de retencao da CSLL. Somatorio das bases de CSLL retida dos itens do DOF';
comment on column SYNITF_DOF.ind_nfe_ajuste
  is 'Indica se o DOF e utilizado como Nota Fiscal Eletronica de Ajustes';
comment on column SYNITF_DOF.crt_codigo
  is 'Cod. Regime Tribut.: 1=Para optante Simples Nacional, 2=Optante Simples Nacional que ultrapassou o sublimite de receita bruta fixado pela UF e estiver impedido de recolher o ICMS/ISS por esse regime e 3=Contribuinte que nao estiver na situacao 1 ou 2.';
comment on column SYNITF_DOF.tipo_cte
  is 'Tipo do CT-e';
comment on column SYNITF_DOF.num_embarque
  is 'Numero do Embarque para o Veiculo Transportador (interno da empresa)';
comment on column SYNITF_DOF.vl_base_ct_stf
  is 'Valor da Base do ICMS do  Conhecimento de Transporte para calculo de STF Fronteira';
comment on column SYNITF_DOF.vl_ct_stf
  is 'Valor do ICMS do Conhecimento de Transporte para calculo de STF Fronteira';
comment on column SYNITF_DOF.vl_total_base_icms_fcp
  is 'Valor total da base de calculo do ICMS relativo ao Fundo de Combate a Pobreza (FCP) da UF de destino. Somatorio da base do ICMS FCP dos itens do DOF.';
comment on column SYNITF_DOF.vl_total_base_icms_part_rem
  is 'Valor total da base de calculo do ICMS partilhado na UF do Remetente. Somatorio das bases do ICMS partilhado dos itens do DOF.';
comment on column SYNITF_DOF.vl_total_icms_part_rem
  is 'Valor total do ICMS partilhado na UF do Remetente. Somatorio do ICMS partilhado dos itens do DOF.';
comment on column SYNITF_DOF.vl_total_base_icms_part_dest
  is 'Valor total da base de calculo do ICMS partilhado na UF do Destinatario. Somatorio das bases do ICMS partilhado dos itens do DOF.';
comment on column SYNITF_DOF.vl_total_icms_part_dest
  is 'Valor total do ICMS partilhado na UF do Destinatario. Somatorio do ICMS Partilhado dos itens do DOF.';
comment on column SYNITF_DOF.hash
  is 'Campo usado pela integracao Eagle-DFE';
comment on column SYNITF_DOF.observacao
  is 'Observacoes.';

/**************************************************************/

create table tdvadm.SYNITF_IDF
(
  informante_est_codigo          VARCHAR2(20 CHAR),
  informante_pfj_chave_origem    VARCHAR2(255 CHAR),
  informante_pfj_origem          VARCHAR2(30 CHAR),
  dof_import_numero              VARCHAR2(40 CHAR),
  idf_num                        NUMBER(6),
  aliq_difa                      NUMBER(15,4),
  aliq_icms                      NUMBER(15,4),
  aliq_ii                        NUMBER(15,4),
  aliq_ipi                       NUMBER(15,4),
  aliq_iss                       NUMBER(15,4),
  aliq_stf                       NUMBER(15,4),
  aliq_stt                       NUMBER(15,4),
  ord_impressao                  NUMBER(8),
  preco_total                    NUMBER(19,2),
  preco_unitario                 NUMBER,
  qtd                            NUMBER,
  subclasse_idf                  VARCHAR2(1 CHAR),
  vl_ajuste_preco_total          NUMBER(19,2),
  vl_base_icms                   NUMBER(19,2),
  vl_base_ipi                    NUMBER(19,2),
  vl_base_irrf                   NUMBER(19,2),
  vl_base_iss                    NUMBER(19,2),
  vl_base_stf                    NUMBER(19,2),
  vl_base_stt                    NUMBER(19,2),
  vl_contabil                    NUMBER(19,2),
  vl_difa                        NUMBER(19,2),
  vl_faturado                    NUMBER(19,2),
  vl_fiscal                      NUMBER(19,2),
  vl_icms                        NUMBER(19,2),
  vl_ii                          NUMBER(19,2),
  vl_ipi                         NUMBER(19,2),
  vl_irrf                        NUMBER(19,2),
  vl_isento_icms                 NUMBER(19,2),
  vl_isento_ipi                  NUMBER(19,2),
  vl_iss                         NUMBER(19,2),
  vl_outros_icms                 NUMBER(19,2),
  vl_outros_ipi                  NUMBER(19,2),
  vl_rateio_ajuste_preco         NUMBER(19,2),
  vl_rateio_frete                NUMBER(19,2),
  vl_rateio_oda                  NUMBER(19,2),
  vl_rateio_seguro               NUMBER(19,2),
  vl_stf                         NUMBER(19,2),
  vl_stt                         NUMBER(19,2),
  vl_tributavel_icms             NUMBER(19,2),
  vl_tributavel_ipi              NUMBER(19,2),
  vl_tributavel_stf              NUMBER(19,2),
  vl_tributavel_stt              NUMBER(19,2),
  am_codigo                      VARCHAR2(20 CHAR),
  cfop_codigo                    VARCHAR2(8 CHAR),
  dt_di                          DATE,
  entsai_uni_codigo              VARCHAR2(6 CHAR),
  fin_codigo                     VARCHAR2(4 CHAR),
  idf_texto_complementar         VARCHAR2(1000),
  merc_codigo                    VARCHAR2(60),
  merc_chave_origem              VARCHAR2(255 CHAR),
  merc_origem                    VARCHAR2(30 CHAR),
  mun_codigo                     VARCHAR2(60 CHAR),
  nbm_codigo                     VARCHAR2(20),
  nop_codigo                     VARCHAR2(20 CHAR),
  num_di                         VARCHAR2(12 CHAR),
  obs_fiscal_icms                VARCHAR2(4000),
  obs_fiscal_ipi                 VARCHAR2(4000),
  obs_fiscal_irrf                VARCHAR2(4000),
  obs_fiscal_iss                 VARCHAR2(4000),
  obs_fiscal_stf                 VARCHAR2(4000),
  obs_fiscal_stt                 VARCHAR2(4000),
  obs_fiscal_operacional         VARCHAR2(4000),
  om_codigo                      VARCHAR2(1 CHAR),
  peso_bruto_kg                  NUMBER(15,4),
  peso_liquido_kg                NUMBER(15,4),
  pres_codigo                    VARCHAR2(30 CHAR),
  siss_codigo                    VARCHAR2(30 CHAR),
  stc_codigo                     VARCHAR2(2 CHAR),
  stp_codigo                     VARCHAR2(6 CHAR),
  ctrl_instrucao                 VARCHAR2(1 CHAR),
  msg_critica                    VARCHAR2(2000 CHAR),
  dh_critica                     DATE,
  ctrl_critica                   NUMBER,
  tipo_complemento               VARCHAR2(2 CHAR),
  vl_tributavel_difa             NUMBER(19,2),
  aliq_inss                      NUMBER(15,4),
  vl_base_inss                   NUMBER(19,2),
  vl_inss                        NUMBER(19,2),
  vl_aliq_cofins                 NUMBER(15,4),
  vl_aliq_pis                    NUMBER(15,4),
  vl_base_pis                    NUMBER(19,2),
  vl_base_cofins                 NUMBER(19,2),
  vl_imposto_pis                 NUMBER(19,2),
  vl_imposto_cofins              NUMBER(19,2),
  emerc_codigo                   VARCHAR2(30),
  codigo_retencao                VARCHAR2(6 CHAR),
  codigo_iss_municipio           VARCHAR2(60),
  aliq_inss_ret                  NUMBER(15,4),
  perc_outros_abat               NUMBER(15,4),
  vl_base_inss_ret               NUMBER(19,2),
  vl_inss_ret                    NUMBER(19,2),
  vl_outros_abat                 NUMBER(19,2),
  ind_vl_icms_no_preco           VARCHAR2(1 CHAR),
  vl_iof                         NUMBER(19,2),
  tipo_oper_veic                 VARCHAR2(1),
  chassi_veic                    VARCHAR2(50 CHAR),
  conta_contabil                 VARCHAR2(100 CHAR),
  dh_inclusao                    DATE,
  sta_codigo                     VARCHAR2(2 CHAR),
  stn_codigo                     VARCHAR2(2 CHAR),
  aliq_pis                       NUMBER(15,4),
  qtd_base_pis                   NUMBER(15,3),
  vl_pis                         NUMBER(19,2),
  aliq_cofins                    NUMBER(15,4),
  qtd_base_cofins                NUMBER(15,3),
  vl_cofins                      NUMBER(19,2),
  num_tanque                     VARCHAR2(50 CHAR),
  dt_fab_med                     DATE,
  tipo_prod_med                  VARCHAR2(1 CHAR),
  participante_pfj_codigo        VARCHAR2(20 CHAR),
  cli_codigo                     VARCHAR2(5 CHAR),
  siss_origem                    VARCHAR2(30 CHAR),
  siss_chave_origem              VARCHAR2(255 CHAR),
  pres_origem                    VARCHAR2(30 CHAR),
  pres_chave_origem              VARCHAR2(255 CHAR),
  tipo_stf                       VARCHAR2(1 CHAR),
  vl_base_stf_fronteira          NUMBER(19,2),
  vl_base_stf_ido                NUMBER(19,2),
  vl_stf_fronteira               NUMBER(19,2),
  vl_stf_ido                     NUMBER(19,2),
  sti_codigo                     VARCHAR2(2 CHAR),
  cnpj_par                       VARCHAR2(20 CHAR),
  cod_iata_fim                   VARCHAR2(3 CHAR),
  cod_iata_ini                   VARCHAR2(3 CHAR),
  cpf_par                        VARCHAR2(19 CHAR),
  dt_val                         DATE,
  ie_par                         VARCHAR2(30 CHAR),
  im_subcontratacao              VARCHAR2(30 CHAR),
  ind_arm                        NUMBER(1),
  ind_med                        NUMBER(1),
  lote_med                       VARCHAR2(255 CHAR),
  num_arm                        VARCHAR2(255 CHAR),
  num_cano                       VARCHAR2(50 CHAR),
  uf_par                         VARCHAR2(2 CHAR),
  vl_tab_max                     NUMBER(19,2),
  vl_deducao_pensao_prg          NUMBER(19,2),
  vl_deducao_dependente_prg      NUMBER(19,2),
  perc_irrf                      NUMBER(15,4),
  cca_codigo                     VARCHAR2(6),
  tipo_receita                   VARCHAR2(2),
  pfj_codigo_terceiro            VARCHAR2(20),
  pfj_terceiro_origem            VARCHAR2(30),
  pfj_terceiro_chave_origem      VARCHAR2(255),
  uni_fiscal_codigo              VARCHAR2(6),
  ind_serv                       VARCHAR2(1),
  dt_ini_serv                    DATE,
  dt_fin_serv                    DATE,
  per_fiscal                     VARCHAR2(6),
  cod_area                       VARCHAR2(10),
  terminal                       VARCHAR2(50),
  vl_base_icms_desc_l            NUMBER(19,2),
  vl_tributavel_icms_desc_l      NUMBER(19,2),
  aliq_icms_desc_l               NUMBER(15,4),
  vl_icms_desc_l                 NUMBER(19,2),
  ind_zfm_alc                    VARCHAR2(1),
  ind_antecip_icms               VARCHAR2(1),
  aliq_antecip_icms              NUMBER(8,2),
  vl_antecip_icms                NUMBER(12,2),
  custo_adicao                   NUMBER(12,2),
  custo_reducao                  NUMBER(12,2),
  ind_vl_pis_cofins_no_preco     VARCHAR2(1),
  stm_codigo                     VARCHAR2(1),
  ind_movimenta_estoque          VARCHAR2(1),
  aliq_pis_st                    NUMBER(15,4),
  vl_base_pis_st                 NUMBER(19,2),
  vl_pis_st                      NUMBER(19,2),
  aliq_cofins_st                 NUMBER(15,4),
  vl_base_cofins_st              NUMBER(19,2),
  vl_cofins_st                   NUMBER(19,2),
  aliq_cofins_ret                NUMBER(15,4),
  vl_base_cofins_ret             NUMBER(19,2),
  vl_cofins_ret                  NUMBER(19,2),
  aliq_csll_ret                  NUMBER(15,4),
  vl_base_csll_ret               NUMBER(19,2),
  vl_csll_ret                    NUMBER(19,2),
  aliq_pis_ret                   NUMBER(15,4),
  vl_base_pis_ret                NUMBER(19,2),
  vl_pis_ret                     NUMBER(19,2),
  ind_iss_retido_fonte           VARCHAR2(1),
  ind_vl_trib_ret_no_preco       VARCHAR2(1),
  perc_tributavel_inss_ret       NUMBER(15,4),
  ind_nat_frt_piscofins          VARCHAR2(1),
  pfj_codigo_fornecedor          VARCHAR2(20),
  cod_ccus                       VARCHAR2(60),
  vl_base_ii                     NUMBER(19,2),
  nat_rec_piscofins_descr        VARCHAR2(255),
  vl_cred_pis_rec_trib           NUMBER(19,2),
  nat_rec_piscofins              VARCHAR2(3),
  vl_cred_pis_rec_nao_trib       NUMBER(19,2),
  vl_cred_pis_rec_expo           NUMBER(19,2),
  vl_cred_cofins_rec_trib        NUMBER(19,2),
  vl_cred_cofins_rec_expo        NUMBER(19,2),
  vl_cred_cofins_rec_nao_trib    NUMBER(19,2),
  cod_bc_credito                 VARCHAR2(2),
  ind_cpc                        VARCHAR2(1),
  ind_ciap                       VARCHAR2(1),
  cod_fisc_serv_mun              VARCHAR2(15),
  nbs_codigo                     VARCHAR2(20),
  csosn_codigo                   VARCHAR2(3),
  perc_part_ci                   NUMBER(8,5),
  vl_imp_fci                     NUMBER(19,2),
  fci_numero                     VARCHAR2(36),
  descricao_complementar_servico VARCHAR2(2000),
  vl_abat_legal_iss              NUMBER(19,2),
  vl_abat_legal_inss_ret         NUMBER(19,2),
  vl_abat_legal_irrf             NUMBER(19,2),
  desoneracao_codigo             VARCHAR2(2 CHAR),
  ind_exigibilidade_iss          VARCHAR2(2 CHAR),
  ind_incentivo_fiscal_iss       VARCHAR2(1 CHAR),
  dt_ref_calc_imp_idf            DATE,
  vl_servico_ae15                NUMBER(19,2),
  vl_servico_ae20                NUMBER(19,2),
  vl_servico_ae25                NUMBER(19,2),
  vl_adicional_ret_ae            NUMBER(19,2),
  vl_nao_retido_cp               NUMBER(19,2),
  cnpj_subempreiteiro            VARCHAR2(14),
  vl_materias_equip              NUMBER(19,2),
  vl_gilrat                      NUMBER(19,2),
  vl_senar                       NUMBER(19,2),
  ind_mp_do_bem                  VARCHAR2(1),
  vl_icms_simples_nac            NUMBER(19,2),
  perc_tributavel_stf            NUMBER(15,4),
  vl_rateio_base_ct_stf          NUMBER(19,2),
  vl_rateio_ct_stf               NUMBER(19,2),
  aliq_icms_fcp                  NUMBER(15,4),
  vl_icms_fcp                    NUMBER(19,2),
  vl_base_icms_fcp               NUMBER(19,2),
  cest_codigo                    VARCHAR2(9),
  perc_icms_part_rem             NUMBER(15,4),
  vl_base_icms_part_rem          NUMBER(19,2),
  aliq_icms_part_rem             NUMBER(15,4),
  vl_icms_part_rem               NUMBER(19,2),
  perc_icms_part_dest            NUMBER(15,4),
  vl_base_icms_part_dest         NUMBER(19,2),
  aliq_icms_part_dest            NUMBER(15,4),
  vl_icms_part_dest              NUMBER(15,4),
  aliq_difa_icms_part            NUMBER(15,4),
  enq_ipi_codigo                 VARCHAR2(5),
  hash                           VARCHAR2(100)
);
/**************************************************************/

create table tdvadm.SYNITF_DOF_ASSOCIADO
(
  informante_est_codigo         VARCHAR2(20 CHAR),
  informante_pfj_chave_origem   VARCHAR2(255 CHAR),
  informante_pfj_origem         VARCHAR2(30 CHAR),
  dof_import_numero             VARCHAR2(40 CHAR),
  emitente_pfj_codigo_assoc     VARCHAR2(20 CHAR),
  emitente_chave_origem_assoc   VARCHAR2(255 CHAR),
  emitente_origem_assoc         VARCHAR2(30 CHAR),
  dh_emissao_assoc              DATE,
  serie_subserie_assoc          VARCHAR2(6 CHAR),
  numero_assoc                  VARCHAR2(60),
  edof_codigo_assoc             VARCHAR2(20 CHAR),
  vl_total_dof_assoc            NUMBER(19,2) default 0,
  tadoc_codigo                  VARCHAR2(6 CHAR),
  peso_total                    NUMBER(15,4) default 0,
  ctrl_instrucao                VARCHAR2(1 CHAR) default 'M',
  msg_critica                   VARCHAR2(2000 CHAR),
  dh_critica                    DATE,
  ctrl_critica                  NUMBER default 0,
  destinatario_pfj_codigo_assoc VARCHAR2(20 CHAR),
  destinatario_chave_origem_ass VARCHAR2(255 CHAR),
  destinatario_origem_assoc     VARCHAR2(30 CHAR),
  tipo_produto                  VARCHAR2(100 CHAR),
  dh_inclusao                   DATE default sysdate,
  nfe_localizador               VARCHAR2(50 CHAR),
  despacho                      VARCHAR2(50),
  ind_entrada_saida_assoc       VARCHAR2(1),
  vl_mercadorias                NUMBER(19,2),
  qtd_volumes                   NUMBER(19),
  peso_liquido_kg               NUMBER(19,2),
  mun_cod_origem                NUMBER(7),
  mun_cod_destino               NUMBER(7),
  hash                          VARCHAR2(100 CHAR)
);
-- Add comments to the columns 
comment on column SYNITF_DOF_ASSOCIADO.informante_est_codigo
  is 'Codigo do estabelecimento informante do DOF.';
comment on column SYNITF_DOF_ASSOCIADO.informante_pfj_chave_origem
  is 'Codigo do estabelecimento informante do DOF no sistema / tabela origem.';
comment on column SYNITF_DOF_ASSOCIADO.informante_pfj_origem
  is 'Nome do sistema ou tabela origem do estabelecimento informante do DOF.';
comment on column SYNITF_DOF_ASSOCIADO.dof_import_numero
  is 'Codigo (ID) do DOF no sistema / tabela origem.';
comment on column SYNITF_DOF_ASSOCIADO.emitente_pfj_codigo_assoc
  is 'Codigo do PFJ emitente do associado.';
comment on column SYNITF_DOF_ASSOCIADO.emitente_chave_origem_assoc
  is 'Codigo da PFJ emitente do documento fiscal associado no sistema / tabela origem.';
comment on column SYNITF_DOF_ASSOCIADO.emitente_origem_assoc
  is 'Nome do sistema ou tabela origem do emitente do documento fiscal associado do DOF.';
comment on column SYNITF_DOF_ASSOCIADO.dh_emissao_assoc
  is 'Data de emissao do documento fiscal associado.';
comment on column SYNITF_DOF_ASSOCIADO.serie_subserie_assoc
  is 'Serie/sub-serie do documento fiscal associado.';
comment on column SYNITF_DOF_ASSOCIADO.numero_assoc
  is 'Numero do Documento Fiscal Associado. Deduzido do DOF';
comment on column SYNITF_DOF_ASSOCIADO.edof_codigo_assoc
  is 'Especie de documento fiscal associado.';
comment on column SYNITF_DOF_ASSOCIADO.vl_total_dof_assoc
  is 'Valor total do documento fiscal associado.';
comment on column SYNITF_DOF_ASSOCIADO.tadoc_codigo
  is 'Codigo do tipo de associacao entre os documentos fiscais (DOF).';
comment on column SYNITF_DOF_ASSOCIADO.peso_total
  is 'Peso bruto do documento.';
comment on column SYNITF_DOF_ASSOCIADO.ctrl_instrucao
  is 'Controle de Instrucao (I)nclusao, (A)lteracao, (E)xclusao ou (M)ix inclui ou altera.';
comment on column SYNITF_DOF_ASSOCIADO.msg_critica
  is '(Uso exclusivo da Synchro) Mensagem de Critica.';
comment on column SYNITF_DOF_ASSOCIADO.dh_critica
  is '(Uso exclusivo da Synchro) Data da ultima critica.';
comment on column SYNITF_DOF_ASSOCIADO.ctrl_critica
  is '(Uso exclusivo da Synchro) Quantidade de vezes que o registro ja foi criticado.';
comment on column SYNITF_DOF_ASSOCIADO.destinatario_pfj_codigo_assoc
  is 'Codigo interno da PFJ destinataria do documento fiscal associado.';
comment on column SYNITF_DOF_ASSOCIADO.destinatario_chave_origem_ass
  is 'Codigo da PFJ destinataria do documento fiscal associado no sistema / tabela origem.';
comment on column SYNITF_DOF_ASSOCIADO.destinatario_origem_assoc
  is 'Nome do sistema / tabela origem da PFJ destinataria do documento fiscal associado.';
comment on column SYNITF_DOF_ASSOCIADO.tipo_produto
  is 'Tipo de produto transportado.';
comment on column SYNITF_DOF_ASSOCIADO.dh_inclusao
  is '(Uso exclusivo da Synchro) Data de inclusao do registro na tabela de Open Interface.';
comment on column SYNITF_DOF_ASSOCIADO.nfe_localizador
  is 'Localizador da NFe na SEFAZ.';
comment on column SYNITF_DOF_ASSOCIADO.despacho
  is 'Identificacao do numero do despacho';
comment on column SYNITF_DOF_ASSOCIADO.ind_entrada_saida_assoc
  is 'Indicador de Entrada e Saida do Dof Associado.';
comment on column SYNITF_DOF_ASSOCIADO.vl_mercadorias
  is 'Valores das Mercadorias constantes no documento fiscal.';
comment on column SYNITF_DOF_ASSOCIADO.qtd_volumes
  is 'Quantidade de volumes transportados.';
comment on column SYNITF_DOF_ASSOCIADO.peso_liquido_kg
  is 'Peso líquido dos volumes transportados (em kg)';
comment on column SYNITF_DOF_ASSOCIADO.mun_cod_origem
  is 'Código do município de origem do serviço. Somente para Transporte.';
comment on column SYNITF_DOF_ASSOCIADO.mun_cod_destino
  is 'Código do município de destino do serviço. Somente para Transporte.';
comment on column SYNITF_DOF_ASSOCIADO.hash
  is 'Campo usado pela integracao Eagle-DFE';


