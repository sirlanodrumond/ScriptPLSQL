-- Create table
--CREATE TABLE TDVADM.T_SLF_CLIENTEREGRAS_TMP
--AS SELECT * FROM TDVADM.T_SLF_CLIENTEREGRAS;
-- Drop table
drop table T_SLF_CLIENTEREGRAS cascade constraints;
-- Create table
create table T_SLF_CLIENTEREGRAS
(
  glb_grupoeconomico_codigo      CHAR(4) not null,
  glb_cliente_cgccpfcodigo       CHAR(20) not null,
  slf_contrato_codigo            VARCHAR2(15) not null,
  slf_clienteregras_vigencia     DATE not null,
  slf_clienteregras_ativo        CHAR(1) DEFAULT 'S' NOT NULL,
  slf_clienteregras_colorig      VARCHAR2(10) default 'WSFC',
  slf_clienteregras_colpedido    CHAR(1) default 'S',
  slf_clienteregras_colpedidoreg VARCHAR2(50),
  slf_clienteregras_colautoriza  CHAR(1),
  slf_clienteregras_infcli       CHAR(1),
  slf_clienteregras_pcobranca    CHAR(2),
  slf_clienteregras_baseocupacao CHAR(1),
  slf_clienteregras_valorbase    NUMBER,
  slf_clienteregras_pbobrig      CHAR(1) default 'N',
  slf_clienteregras_pbarrend     CHAR(1) default 'S',
  slf_clienteregras_pbdecgramas  INTEGER default 1,
  slf_clienteregras_tabped       VARCHAR2(20),
  slf_clienteregras_tabkm        VARCHAR2(20),
  slf_clienteregras_globalizado  CHAR(1) default 'N',
  slf_clienteregras_criacolfifo  CHAR(1) default 'S',
  slf_clienteregras_fimdigitnota CHAR(1) default 'S',
  slf_clienteregras_valeped      CHAR(1) default 'N',
  slf_clienteregras_dtcadastro   DATE default sysdate
)
tablespace TSMGERAL
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table T_SLF_CLIENTEREGRAS
  is 'Contem as regras para o Contrato';
-- Add comments to the columns 
comment on column T_SLF_CLIENTEREGRAS.glb_grupoeconomico_codigo
  is 'Grupo Economico';
comment on column T_SLF_CLIENTEREGRAS.glb_cliente_cgccpfcodigo
  is 'CNPJ de Cliente ';
comment on column T_SLF_CLIENTEREGRAS.slf_contrato_codigo
  is 'Contrato';
comment on column T_SLF_CLIENTEREGRAS.slf_clienteregras_vigencia
  is 'Vigencia da Regra';
comment on column T_SLF_CLIENTEREGRAS.slf_clienteregras_ativo
  is 'Regra Ativa';
comment on column T_SLF_CLIENTEREGRAS.slf_clienteregras_colorig
  is 'Origem da Digitação da Coleta (W) Web, (S) Sistema, (F) FiFO, (C) Cliente';
comment on column T_SLF_CLIENTEREGRAS.slf_clienteregras_colpedido
  is 'Exige pedido na coleta';
comment on column T_SLF_CLIENTEREGRAS.slf_clienteregras_colpedidoreg
  is 'Procedure para avaliar o pedido';
comment on column T_SLF_CLIENTEREGRAS.slf_clienteregras_colautoriza
  is 'Exige Autorização (E) Expressa, (N) Normal ou (A) Ambas';
comment on column T_SLF_CLIENTEREGRAS.slf_clienteregras_infcli
  is 'Informa ao Cliente Apos coletado';
comment on column T_SLF_CLIENTEREGRAS.slf_clienteregras_pcobranca
  is 'Qual Peso cobrar PL-Lotacao,PR-Real,PC-Cubado,PF-Faixa,PB-Balança';
comment on column T_SLF_CLIENTEREGRAS.slf_clienteregras_baseocupacao
  is 'M-Metros Cubicos,% Percentual,N-Nenhum';
comment on column T_SLF_CLIENTEREGRAS.slf_clienteregras_valorbase
  is 'Valor a ser usado na base';
comment on column T_SLF_CLIENTEREGRAS.slf_clienteregras_pbobrig
  is 'Indica se a pesagem e obrigatorio ';
comment on column T_SLF_CLIENTEREGRAS.slf_clienteregras_pbarrend
  is 'Indica se o peso balanca sera arredondado';
comment on column T_SLF_CLIENTEREGRAS.slf_clienteregras_pbdecgramas
  is 'Indica quantas casas decimais (gramas) serão usadas';
comment on column T_SLF_CLIENTEREGRAS.slf_clienteregras_tabped
  is 'Nome da Tabela de Pedagio, será criado uma tabela com o Prefixo T_SLF_PEDAGIO_XXXXXXX';
comment on column T_SLF_CLIENTEREGRAS.slf_clienteregras_tabkm
  is 'Nome da Tabela de KM, será criado uma tabela com o Prefixo T_SLF_PERCURSO_XXXXXXX';
comment on column T_SLF_CLIENTEREGRAS.slf_clienteregras_globalizado
  is 'Cria CTe Globalizado';
comment on column T_SLF_CLIENTEREGRAS.slf_clienteregras_criacolfifo
  is 'Permite Criar coleta na Digitação da Nota no FIFO';
comment on column T_SLF_CLIENTEREGRAS.slf_clienteregras_fimdigitnota
  is 'Indica que Finaliza a Digitação de Nota para esta COLETA no FIFO';
comment on column T_SLF_CLIENTEREGRAS.slf_clienteregras_valeped
  is 'Se o Cliente paga Vale Pedagio.';
comment on column T_SLF_CLIENTEREGRAS.slf_clienteregras_dtcadastro
  is 'Data de gravacao do Registro';
-- Create/Recreate indexes 
create index FK_CLIENTEREGRASCLIENTE on T_SLF_CLIENTEREGRAS (GLB_CLIENTE_CGCCPFCODIGO)
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
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_SLF_CLIENTEREGRAS
  add constraint PK_SLF_CLIENTEREGRAS primary key (GLB_GRUPOECONOMICO_CODIGO, GLB_CLIENTE_CGCCPFCODIGO, SLF_CONTRATO_CODIGO, SLF_CLIENTEREGRAS_VIGENCIA)
  using index 
  tablespace TSMFRETE_I
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table T_SLF_CLIENTEREGRAS
  add constraint FK_CLIENTEREGRASCLIENTE foreign key (GLB_CLIENTE_CGCCPFCODIGO)
  references T_GLB_CLIENTE (GLB_CLIENTE_CGCCPFCODIGO);
alter table T_SLF_CLIENTEREGRAS
  add constraint FK_CLIENTEREGRASGRUPOEC foreign key (GLB_GRUPOECONOMICO_CODIGO)
  references T_GLB_GRUPOECONOMICO (GLB_GRUPOECONOMICO_CODIGO);
-- Grant/Revoke object privileges 
grant select, insert, update, delete, alter, debug on T_SLF_CLIENTEREGRAS to DESENVOLVIMENTO;


update tdvadm.t_slf_clienteregras r
  set r.slf_clienteregras_pbdecgramas = 0
where r.glb_grupoeconomico_codigo <> '0020'
