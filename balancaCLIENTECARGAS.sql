-- Create table
--CREATE TABLE TDVADM.T_SLF_CLIENTECARGAS_TMP
--AS SELECT * FROM TDVADM.T_SLF_CLIENTECARGAS;
-- Drop table
drop table T_SLF_CLIENTECARGAS cascade constraints;
-- Create table
create table T_SLF_CLIENTECARGAS
(
  glb_grupoeconomico_codigo      CHAR(4) not null,
  glb_cliente_cgccpfcodigo       CHAR(20) not null,
  slf_contrato_codigo            VARCHAR2(15) not null,
  slf_clientecargas_seqexec      INTEGER,
  slf_clientecargas_vigencia     DATE not null,
  slf_clientecargas_ativo        CHAR(1) default 'S' not null,
  fcf_tpcarga_codigo             CHAR(3) not null,
  fcf_tpcarga_codigopesq         CHAR(3) not null,
  slf_tpfrete_codigo             CHAR(4) not null,
  slf_clientecargas_rateia       CHAR(1) default 'N',
  slf_clientecargas_qtdenotacol  NUMBER default 1,
  slf_tprateio_codigo            CHAR(2),
  slf_tpagrupa_codigo            CHAR(2),
  slf_clientecargas_procedure    VARCHAR2(50),
  slf_clientecargas_pminimo      NUMBER default 0,
  slf_clientecargas_pesagemmax   NUMBER default 0,
  slf_clientecargas_agctrc       CHAR(1),
  slf_clientecargas_qtdectrc     NUMBER,
  slf_clientecargas_agnf         CHAR(1),
  slf_clientecargas_qtdenf       NUMBER,
  slf_clientecargas_priorexqm    CHAR(1),
  slf_clientecargas_percntex     NUMBER default 0,
  slf_clientecargas_percntqm     NUMBER default 0,
  slf_clientecargas_percntout    NUMBER default 0,
  slf_clientecargas_percnttra    NUMBER default 0,
  slf_clientecargas_redutor      NUMBER default 0,
  slf_clientecargas_formularioqm CHAR(1) default 'N',
  slf_clientecargas_formularioex CHAR(1) default 'N',
  slf_clientecargas_qpcolctrc    CHAR(1) default 'N',
  slf_clientecargas_qpcolnf      CHAR(1) default 'N',
  slf_clientecargas_formulafrtx  VARCHAR2(500),
  slf_clientecargas_formulafrtvl VARCHAR2(500),
  slf_clientecargas_formulapdtx  VARCHAR2(500),
  slf_clientecargas_formulapdvl  VARCHAR2(500),
  slf_clientecargas_formulafrtkm VARCHAR2(500),
  slf_clientecargas_fixaorigem   CHAR(8),
  slf_clientecargas_fixadestino  CHAR(8),
  slf_clientecargas_sotransf     CHAR(1) default 'N',
  slf_clientecargas_usaveiculo   CHAR(1) default 'S' not null,
  slf_clientecargas_pesqveiculo  CHAR(1) default 'C',
  slf_clientecargas_limitecte    NUMBER default 0,
  slf_clientecargas_limitenfse   NUMBER default 0,
  slf_clientecargas_usafaixakm   CHAR(1) default 'N' not null,
  slf_clientecargas_usafaixapeso CHAR(1) default 'N',
  slf_clientecargas_usafaixavg   CHAR(1) default 'N',
  slf_clientecargas_usafaixakmc  CHAR(1) default 'N',
  slf_clientecargas_kmminimo     NUMBER default 0,
  slf_clientecargas_cobracoleta  CHAR(1) default 'N',
  slf_clientecargas_parasempcc   CHAR(1),
  fcf_tpcarga_codigocol          CHAR(3),
  slf_tpfrete_codigocol          CHAR(4),
  slf_clientecargas_forcobcoleta CHAR(2) default '00',
  slf_clientecargas_agrporcoleta CHAR(1) default 'N',
  slf_clientecargas_formulacoltx VARCHAR2(500),
  slf_clientecargas_formulacolvl VARCHAR2(500),
  slf_clientecargas_formulacolkm VARCHAR2(500),
  slf_clientecargas_usafaixapsoc CHAR(1) default 'N',
  slf_clientecargas_usafaixavgc  CHAR(1) default 'N',
  slf_clientecargas_usaveiculoc  CHAR(1),
  slf_clientecargas_pesqveiculoc CHAR(1) default 'C',
  slf_clientecargas_ctedecoleta  CHAR(1) default 'M',
  slf_clientecargas_mudaorigemcc CHAR(1),
  slf_clientecargas_dtcadastro   DATE default sysdate
)
tablespace TSMGERAL
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 320K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table T_SLF_CLIENTECARGAS
  is 'Contem a regra de tipo de carga/Agrupamento de notas por GRUPO/CLIENTE';
-- Add comments to the columns 
comment on column T_SLF_CLIENTECARGAS.glb_grupoeconomico_codigo
  is 'Grupo Economico';
comment on column T_SLF_CLIENTECARGAS.glb_cliente_cgccpfcodigo
  is 'CNPJ de Cliente ';
comment on column T_SLF_CLIENTECARGAS.slf_contrato_codigo
  is 'Contrato';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_seqexec
  is 'Sequencia de busca das regras';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_vigencia
  is 'Inicio da Regra';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_ativo
  is 'Regra esta Ativa ou Nao';
comment on column T_SLF_CLIENTECARGAS.fcf_tpcarga_codigo
  is 'Tipo de Carga';
comment on column T_SLF_CLIENTECARGAS.fcf_tpcarga_codigopesq
  is 'Tipo de Carga a ser pesquisado para esta regra';
comment on column T_SLF_CLIENTECARGAS.slf_tpfrete_codigo
  is 'Vide tabela T_SLF_TPFRETE';
comment on column T_SLF_CLIENTECARGAS.slf_CLIENTECARGAS_rateia
  is 'Se este tipo de Carga terá rateio';
comment on column T_SLF_CLIENTECARGAS.slf_CLIENTECARGAS_qtdenotacol
  is 'Quantidade Limite de Notas por Coleta';
comment on column T_SLF_CLIENTECARGAS.slf_tprateio_codigo
  is 'Tipo de Rateio para a Regra';
comment on column T_SLF_CLIENTECARGAS.slf_tpagrupa_codigo
  is 'Tipo de Agrupamento para a Regra';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_procedure
  is 'Procedure que sera rodada';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_pminimo
  is 'Peso minimo a ser cobrado';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_pesagemmax
  is 'Indica a Pessagem Maxima Obrigatoria 0 indica que será usado o limite da Balanca';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_agctrc
  is 'Se agrupa CTRC ';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_qtdectrc
  is 'Quantidade de Agrupamento';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_agnf
  is 'Se agrupa NF';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_qtdenf
  is 'Quantidade de Agrupamento';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_priorexqm
  is 'Prioridade para aplicação do Percentual (A) - Ambos , (E) so expresso ou (Q) quimico';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_percntex
  is 'Percentual a ser aplicado no produto Carga Expressa';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_percntqm
  is 'Percentual a ser aplicado no produto Carga Quimico';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_percntout
  is 'Percentual a ser aplicado no produto Carga OUTBOUND';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_percnttra
  is 'Percentual a ser aplicado no produto Caraga Transferencia';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_redutor
  is 'Percentual a ser aplicado no quando necessario';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_formularioqm
  is 'Exige formulario para autorizar Produto Quimico';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_formularioex
  is 'Exige formulario para Autorizar Carga Expressa';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_qpcolctrc
  is 'Se  Para Fazer um novo Conhecimento quebra por coleta diverente.';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_qpcolnf
  is 'Se  Para Fazer uma nova NFS quebra por coleta diverente.';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_formulafrtx
  is 'Formula para calculo do Frete quando Taxa';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_formulafrtvl
  is 'Formula para calculo do Frete quando Valor';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_formulapdtx
  is 'Formula para calculo do Pedagio quando Taxa';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_formulapdvl
  is 'Formula para calculo do Pedagio quando Valor';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_formulafrtkm
  is 'Formula para calculo do Frete quando envolver KM';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_fixaorigem
  is 'Codigo Fixo na ORIGEM podendo ser uma Localidade um IBGE ou Regiao Cartografica';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_fixadestino
  is 'Codigo Fixo na DESTINO podendo ser uma Localidade um IBGE ou Regiao Cartografica';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_sotransf
  is 'Obriga o Remetente e Destinatario serem do mesmo Grupo';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_usaveiculo
  is 'Se usa Veiculo neste tipo de Regra';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_pesqveiculo
  is 'Onde Pesquisar o Veiculo C- Coleta F-Faixa de Peso G-Grid do Carregamento';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_limitecte
  is 'Limite de Valor para Emissao de um CTe';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_limitenfse
  is 'Limite de Valor para Emissao de uma NFSe';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_usafaixakm
  is 'Se ira usar faixa de KM para buscar frete';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_usafaixapeso
  is 'Se ira usar faixa de PESO para buscar frete';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_usafaixavg
  is 'Se ira usar faixa de VIAGENS para buscar o frete ';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_usafaixakmc
  is 'Se ira usar faixa de KM para buscar fretre COLETA';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_kmminimo
  is 'KM Minimo para uso da Faixa';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_cobracoleta
  is 'Se cobra Coleta a parte';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_parasempcc
  is 'Para o processo se não achar valor para a Coleta';
comment on column T_SLF_CLIENTECARGAS.fcf_tpcarga_codigocol
  is 'Tipo de Carga para ser usado na COLETA';
comment on column T_SLF_CLIENTECARGAS.slf_tpfrete_codigocol
  is 'Vide tabela T_SLF_TPFRETE';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_forcobcoleta
  is 'Forma de Cobranca da Coleta';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_agrporcoleta
  is 'Se usa o Numero da Coleta para Agrupar e ou Ratear';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_formulacoltx
  is 'Formula para calculo da Coleta quando Taxa';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_formulacolvl
  is 'Formula para calculo da Coleta quando Valor';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_formulacolkm
  is 'Formula para calculo da Coleta quando Por KM';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_usafaixapsoc
  is 'Se ira usar faixa de PESO para buscar frete COLETA';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_usafaixavgc
  is 'Se ira usar faixa de VIAGENS para buscar o frete COLETA';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_usaveiculoc
  is 'Se usa Veiculo na Coleta neste tipo de Regra';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_pesqveiculoc
  is 'Onde Pesquisar o Veiculo C- Coleta F-Faixa de Peso G-Grid do Carregamento';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_ctedecoleta
  is '(N) Sera Emitido um novo CTe para cobrar a Coleta
(M) Sera cobrado no Mesmo Conhecimento';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_mudaorigemcc
  is 'Muda a ORIGEM quando cobra coleta';
comment on column T_SLF_CLIENTECARGAS.slf_clientecargas_dtcadastro
  is 'Data de cadastro do registro';
-- Create/Recreate indexes 
create index FK_CLIENTESCARGACLIENTE on T_SLF_CLIENTECARGAS (GLB_CLIENTE_CGCCPFCODIGO)
  tablespace TSMCONHEC_I
  pctfree 10
  initrans 20
  maxtrans 255
  storage
  (
    initial 256K
    next 256K
    minextents 1
    maxextents unlimited
  );
create index FK_CLIENTESCARGATPCARGA on T_SLF_CLIENTECARGAS (FCF_TPCARGA_CODIGO)
  tablespace TSMCONHEC_I
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 256K
    next 256K
    minextents 1
    maxextents unlimited
  );
create index FK_CLIENTESCARGATPFRETE on T_SLF_CLIENTECARGAS (SLF_TPFRETE_CODIGO)
  tablespace TSMCONHEC_I
  pctfree 10
  initrans 20
  maxtrans 255
  storage
  (
    initial 256K
    next 256K
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_SLF_CLIENTECARGAS
  add constraint PK_SLF_CLIENTESCARGA primary key (GLB_GRUPOECONOMICO_CODIGO, GLB_CLIENTE_CGCCPFCODIGO, SLF_CONTRATO_CODIGO, FCF_TPCARGA_CODIGO, FCF_TPCARGA_CODIGOPESQ, SLF_TPFRETE_CODIGO, SLF_CLIENTECARGAS_USAVEICULO, SLF_CLIENTECARGAS_USAFAIXAKM, SLF_CLIENTECARGAS_VIGENCIA)
  using index 
  tablespace TSMFRETE_I
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table T_SLF_CLIENTECARGAS
  add constraint FK_CLIENTESCARGACLIENTE foreign key (GLB_CLIENTE_CGCCPFCODIGO)
  references T_GLB_CLIENTE (GLB_CLIENTE_CGCCPFCODIGO);
alter table T_SLF_CLIENTECARGAS
  add constraint FK_CLIENTESCARGAGRUPOEC foreign key (GLB_GRUPOECONOMICO_CODIGO)
  references T_GLB_GRUPOECONOMICO (GLB_GRUPOECONOMICO_CODIGO);
alter table T_SLF_CLIENTECARGAS
  add constraint FK_CLIENTESCARGATPCARGA foreign key (FCF_TPCARGA_CODIGO)
  references T_FCF_TPCARGA (FCF_TPCARGA_CODIGO);
alter table T_SLF_CLIENTECARGAS
  add constraint FK_CLIENTESCARGATPFRETE foreign key (SLF_TPFRETE_CODIGO)
  references T_SLF_TPFRETE (SLF_TPFRETE_CODIGO);
-- Grant/Revoke object privileges 
grant select, insert, update, delete, alter, debug on T_SLF_CLIENTECARGAS to DESENVOLVIMENTO;
