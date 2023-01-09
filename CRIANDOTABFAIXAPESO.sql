insert into tdvadm.t_fcf_limitecargas
select distinct ta.glb_grupoeconomico_codigo,
       km.slf_calcfretekm_pesode,
       km.slf_calcfretekm_pesoate,
       ta.fcf_tpcarga_codigo,
       ta.slf_tabela_contrato,
       ta.fcf_tpveiculo_codigo,
       ta.glb_cliente_cgccpfcodigo,
       ta.slf_tabela_vigencia,
       null
from tdvadm.t_slf_tabela ta,
     tdvadm.t_slf_calcfretekm km       
where ta.slf_tabela_contrato = 'C2017070112'
  and ta.slf_tabela_codigo = km.slf_tabela_codigo
  and ta.slf_tabela_saque = km.slf_tabela_saque
  and ta.slf_tabela_saque = (select max(ta1.slf_tabela_saque)
                             from tdvadm.t_slf_tabela ta1
                             where ta1.slf_tabela_codigo = ta.slf_tabela_codigo);

select cc.slf_clientecargas_usaveiculo, cc.slf_clientecargas_pesqveiculo,cc.slf_clientecargas_usaveiculoc, cc.slf_clientecargas_pesqveiculoc
from tdvadm.t_slf_clientecargas cc
where cc.slf_contrato_codigo = 'C2017070112'
for update;
