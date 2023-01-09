TDX - Hands23on

select *
from tdvadm.v_ctb_impostos x
where x.REF1 = '201808'
  and x.CPF = '81126425672'
--  and x.IR > 0
;  

select *
from tdvadm.v_ctb_impostosanalitico x
where x.REF1 = '201808'
  and x.CPF = '81126425672'
--  and x.IR > 0
order by x.cadastro
  

  109555,58
  
  tdvadm.tg_biud_valefretes;
  tdvadm.tg_aiud_valefrete;

  -- Cancela Vale de frete para teste  
  update tdvadm.t_con_valefrete v
    set v.con_valefrete_status = 'C',
        v.con_valefrete_obscaixa = 'SIRLANO/danas - teste'
  where 0 = 0
    and nvl(v.con_valefrete_status,'N') <> 'C'
    and ( v.con_conhecimento_codigo,
          v.con_conhecimento_serie,
          v.glb_rota_codigo,
          v.con_valefrete_saque ) in (select x.VF,
                                             x.serie,.
                                             
                                             x.rota,
                                             x.sq
                                      from tdvadm.v_ctb_impostosanalitico x
                                      where x.REF1 = '201808'
                                        and x.CPF = '81126425672'
                                        and trunc(x.cadastro) >= to_date('06/08/2018','dd/mm/yyyy'));
select v.con_conhecimento_codigo,
       v.con_conhecimento_serie,
       v.glb_rota_codigo,
       v.con_valefrete_saque,
       v.con_valefrete_placa,
       v.con_valefrete_irrf,
       v.con_valefrete_inss,
       v.con_valefrete_sestsenat
from tdvadm.t_con_valefrete v
where 0 = 0
    and ( v.con_conhecimento_codigo,
          v.con_conhecimento_serie,
          v.glb_rota_codigo,
          v.con_valefrete_saque ) in (select x.VF,
                                             x.serie,
                                             x.rota,
--                                             x.REFERENCIA,
                                             x.sq
                                      from tdvadm.v_ctb_impostosanaliticotodos x
                                      where 0 = 0
                                        and substr(x.REFERENCIA,1,6) = '201808'
                                        and x.CPF = '81126425672'
                                        and trunc(x.cadastro) >= to_date('06/08/2018','dd/mm/yyyy'))
order by v.con_valefrete_datacadastro                                        
;


select x.VF,
      x.serie,
       x.rota,
       x.sq,
       x.FRETE,
       x.FRETESP,
       x.INSS,
       x.SESTSENAT,
       x.IR,
       x.STATUS
from tdvadm.v_ctb_impostosanaliticotodos x
where 0 = 0
  and substr(x.referencia,1,6) = '201808'
  and x.cpf = '81126425672'
order by x.cadastro
;
                                        
  -- Roda o acumulado
;


select *
from tdvadm
