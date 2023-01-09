update tdvadm.t_slf_clientecargas cc
  set cc.slf_clientecargas_agctrc = 'N',
      cc.slf_clientecargas_qtdectrc = 1,
      cc.slf_clientecargas_agnf = 'N',
      cc.slf_clientecargas_qtdenf = 1,
      cc.slf_clientecargas_qtdenotacol = 500,
      cc.slf_clientecargas_fimdigitnota = 'N',
      cc.slf_tpagrupa_codigo = '04',
      cc.slf_clientecargas_cobracoleta = 'N',
      cc.slf_clientecargas_percntex = 0.4,
      cc.slf_clientecargas_percntqm = 0.3
where cc.slf_contrato_codigo = 'C4600006653';
update tdvadm.t_slf_clientecargas cc
  set cc.slf_clientecargas_usaveiculo = 'S',
      cc.slf_clientecargas_pesqveiculo = 'G'
where cc.slf_contrato_codigo = 'C4600006653'
  and cc.fcf_tpcarga_codigo = '11';
update tdvadm.t_slf_clientecargas cc
  set cc.slf_clientecargas_usaveiculo = 'S',
      cc.slf_clientecargas_pesqveiculo = 'C'
where cc.slf_contrato_codigo = 'C4600006653'
  and cc.fcf_tpcarga_codigo <> '11';
update tdvadm.t_slf_clientecargas cc
  set cc.slf_clientecargas_cobracoleta = 'S',
      cc.slf_clientecargas_forcobcoleta = '00',
      cc.fcf_tpcarga_codigocol = '20',
      cc.slf_clientecargas_usaveiculoc = 'S',
      cc.slf_clientecargas_pesqveiculoc = 'F',
      cc.slf_clientecargas_mudaorigemcc = 'S'
where cc.slf_contrato_codigo = 'C4600006653'
  and cc.fcf_tpcarga_codigo = '11';


/***************************************/

select distinct cc.Tpcarga
from tdvadm.v_slf_clientecargas cc
where cc.contrato = 'C4600006358';


update tdvadm.t_slf_clientecargas cc
  set cc.slf_clientecargas_agctrc = 'S',
      cc.slf_clientecargas_qtdectrc = 50,
      cc.slf_clientecargas_agnf = 'S',
      cc.slf_clientecargas_qtdenf = 50,
      cc.slf_clientecargas_qtdenotacol = 500,
      cc.slf_clientecargas_fimdigitnota = 'N',
      cc.slf_tpagrupa_codigo = decode(cc.fcf_tpcarga_codigo,'28','01',
                                                            '29','01','02'),
      cc.slf_clientecargas_cobracoleta = decode(cc.fcf_tpcarga_codigo,'02','S','N'),
      cc.slf_clientecargas_percntex = 0,
      cc.slf_clientecargas_percntqm = 0
where cc.slf_contrato_codigo = 'C4600006358';
update tdvadm.t_slf_clientecargas cc
  set cc.slf_clientecargas_usaveiculo = 'S',
      cc.slf_clientecargas_pesqveiculo = 'G'
where cc.slf_contrato_codigo = 'C4600006358'
  and cc.fcf_tpcarga_codigo in ('01','03','28');
update tdvadm.t_slf_clientecargas cc
  set cc.slf_clientecargas_usaveiculo = 'N',
      cc.slf_clientecargas_pesqveiculo = ''
where cc.slf_contrato_codigo = 'C4600006358'
  and cc.fcf_tpcarga_codigo not in ('01','03','28');

update tdvadm.t_slf_clientecargas cc
  set cc.slf_clientecargas_cobracoleta = decode(cc.fcf_tpcarga_codigo,'02','S','N'),
      cc.slf_clientecargas_forcobcoleta = '00',
      cc.fcf_tpcarga_codigocol = '20',
      cc.slf_clientecargas_usaveiculoc = 'N',
      cc.slf_clientecargas_pesqveiculoc = '',
      cc.slf_clientecargas_mudaorigemcc = 'N'
where cc.slf_contrato_codigo = 'C4600006358';
      
INSERT INTO TDVADM.T_GLB_CLIENTECONTRATO CC
SELECT CL.GLB_CLIENTE_CGCCPFCODIGO,
       'C4600006653',
       'S',
       SYSDATE,
       'jsantos'
FROM TDVADM.T_GLB_CLIENTE CL
WHERE CL.GLB_GRUPOECONOMICO_CODIGO = '0630';



