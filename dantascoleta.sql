select co.*,
       (select distinct vf.con_conhecimento_codigo || vf.con_conhecimento_serie || vf.glb_rota_codigo || vf.con_valefrete_saque
        from tdvadm.t_con_valefrete vf
        where vf.con_valefrete_placa = co.placa
          and vf.con_valefrete_datacadastro >= co.dtimp
          and vf.cax_boletim_data is not null
          and rownum = 1
          and vf.con_valefrete_datacadastro = (select min(vf1.con_valefrete_datacadastro)
                                               from tdvadm.t_con_valefrete vf1
                                               where vf1.con_valefrete_placa = vf.con_valefrete_placa
                                                 and vf1.con_valefrete_datacadastro >= co.dtimp) ) vfrete
from (select trunc(c.arm_coleta_dtimp) dtimp,
             m.arm_coleta_motorista_placa placa,
             c.glb_cliente_cgccpfcodigocoleta,
             c.glb_tpcliend_codigocoleta,
             c.fcf_tpcarga_codigo,
             c.fcf_tpveiculo_codigo,
             count(*) qtde
      from tdvadm.t_arm_coleta_motorista m,
           tdvadm.t_arm_coleta c
      where m.arm_coleta_ncompra = c.arm_coleta_ncompra
        and m.arm_coleta_ciclo = c.arm_coleta_ciclo
        and c.arm_coleta_dtgravacao >= '01/07/2018'
        and c.arm_coleta_entcoleta = 'C'
      group by trunc(c.arm_coleta_dtimp),
                     m.arm_coleta_motorista_placa,
                     c.glb_cliente_cgccpfcodigocoleta,
                     c.glb_tpcliend_codigocoleta,
                     c.fcf_tpcarga_codigo,
                     c.fcf_tpveiculo_codigo) co
where co.dtimp is not null
order by co.placa,co.dtimp
  

