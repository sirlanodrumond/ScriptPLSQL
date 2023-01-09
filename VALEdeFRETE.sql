SELECT count(*) qtdecte
FROM tdvadm.t_con_vfreteconhec vc
WHERE  0 = 0
  and vc.CON_VALEFRETE_CODIGO = '879947'
  AND vc.CON_VALEFRETE_SERIE  = 'A1'
  AND vc.GLB_ROTA_CODIGOVALEFRETE = '021'
  AND vc.CON_VALEFRETE_SAQUE  = '1';

SELECT count(*) qtdeNF
FROM tdvadm.t_con_vfreteconhec vc,
     tdvadm.t_con_nftransporta nf
WHERE  0 = 0
  and vc.CON_VALEFRETE_CODIGO = '879947'
  AND vc.CON_VALEFRETE_SERIE  = 'A1'
  AND vc.GLB_ROTA_CODIGOVALEFRETE = '021'
  AND vc.CON_VALEFRETE_SAQUE  = '1'
  and vc.con_conhecimento_codigo = nf.con_conhecimento_codigo
  and vc.con_conhecimento_serie = nf.con_conhecimento_serie
  and vc.glb_rota_codigo = nf.glb_rota_codigo  
;

select * from tdvadm.t_xml_clientelib cl
where cl.glb_cliente_cgccpfcodigo = 'x'
for update;

select *
from tdvadm.t_glb_pcllinha pcl
where pcl.glb_pcllinha_campo = 'QTDDOC'
for update
  

                         
