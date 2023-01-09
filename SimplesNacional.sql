
select trunc(c.omn_consulta_data) DTCONSULTA,
       p.car_proprietario_cgccpfcodigo cnpj,
       p.car_proprietario_razaosocial razao,
       p.car_proprietario_optsimples opttdv,
       decode(substr(c.omn_consulta_situacao,1,3),'NÃO','N','S') optconsulta,
       decode(substr(c.omn_consulta_situacao,1,3),'NÃO',null,substr(c.omn_consulta_situacao,-10,10)) dataini,
       c.omn_consulta_situacao situacao
from tdvadm.t_omn_consulta c,
     tdvadm.t_car_proprietario p
where c.car_proprietario_cgccpfcodigo = p.car_proprietario_cgccpfcodigo
  and trunc(c.omn_consulta_data) = trunc((select max(c1.omn_consulta_data)
                                          from tdvadm.t_omn_consulta c1))
  and c.omn_consulta_nomefonte = 'RECEITA_SIMPLES'
  AND p.car_proprietario_optsimples <> decode(substr(c.omn_consulta_situacao,1,3),'NÃO','N','S')

                                      
select *
from tdvadm.t_omn_consulta c
where trunc(c.omn_consulta_data) = trunc((select max(c1.omn_consulta_data)
                                          from tdvadm.t_omn_consulta c1))
  and c.omn_consulta_nomefonte = 'SINTEGRA';

select *
from tdvadm.t_omn_consulta c
where trunc(c.omn_consulta_data) = trunc((select max(c1.omn_consulta_data)
                                          from tdvadm.t_omn_consulta c1))
  and c.omn_consulta_nomefonte = 'RECEITA_PJ';
   
                                   

