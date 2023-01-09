
select bs1.rota,
       bs1.maiordata,
       bs1.placa,
       bs1.saque,
       bs1.cnpjcpf,
       bs1.qtde,
       p.*
from (select vf.glb_rota_codigo Rota,
             bs.maiordata,
             vf.con_valefrete_placa placa,
             vf.con_valefrete_placasaque saque,
             v.car_proprietario_cgccpfcodigo cnpjcpf,
             bs.qtde
      from tdvadm.t_con_valefrete vf,
           tdvadm.t_car_veiculo v,
           (select vf.con_valefrete_placa placa,
                   max(vf.con_valefrete_datacadastro) maiordata,
                   count(*) qtde
            from tdvadm.t_con_valefrete vf
            where vf.con_valefrete_datacadastro >= '01/01/2012'
              and substr(vf.con_valefrete_placa,1,3) <> '000'
              and length(trim(vf.con_valefrete_placa)) = 7
            group by vf.con_valefrete_placa) bs
      where vf.con_valefrete_placa = bs.placa
        and vf.con_valefrete_datacadastro = bs.maiordata
        and vf.con_valefrete_placasaque = (select max(vf1.con_valefrete_placasaque)
                                           from tdvadm.t_con_valefrete vf1
                                           where vf1.con_valefrete_placa = vf.con_valefrete_placa
                                             and vf1.con_valefrete_datacadastro = vf.con_valefrete_datacadastro)
        and vf.con_valefrete_placa      = v.car_veiculo_placa
        and vf.con_valefrete_placasaque = v.car_veiculo_saque ) bs1,
       tdvadm.t_car_proprietario p                                    
where p.car_proprietario_cgccpfcodigo = rpad(bs1.cnpjcpf,20);


