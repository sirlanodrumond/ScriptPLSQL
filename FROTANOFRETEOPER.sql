  
select vd.fcf_veiculodisp_data data,
       vd.car_veiculo_placa placa,
       vd.frt_conjveiculo_codigo frota,
       vd.con_freteoper_id IDCOD,
       vd.con_freteoper_rota IDROTA,
       itdv.cfe_integratdv_desc INTEGRACAO,
       op.cfe_operacoes_desc OPERACAO,
       fo.cfe_statusfreteoper_status STATUS,
       fo.con_freteoper_msgenv msgenv,
       fo.con_freteoper_msgret msgret     

-- Integracoes com ID Buscando FROTA
select to_char(vd.fcf_veiculodisp_data,'YYYY') ref,
       count(distinct fo.cfe_operacoes_cod) tiposoperacoes,
       count(*) qtdeid
from tdvadm.t_fcf_veiculodisp vd,
     tdvadm.t_con_freteoper fo,
     tdvadm.t_cfe_integratdv itdv,
     tdvadm.t_cfe_operacoes op
where 0 = 0
--  and vd.fcf_veiculodisp_data >= '01/01/2021'
  and vd.con_freteoper_id is not null
  and fo.cfe_integratdv_cod = itdv.cfe_integratdv_cod
  and fo.cfe_operacoes_cod = op.cfe_operacoes_cod
  and vd.con_freteoper_id = fo.con_freteoper_id
  and vd.con_freteoper_rota = fo.con_freteoper_rota
  and vd.frt_conjveiculo_codigo is not null
group by to_char(vd.fcf_veiculodisp_data,'YYYY');


-- Integraçoes manuais sem ID
select to_char(fo.con_freteoper_dtcad,'YYYY') ref,
       itdv.cfe_integratdv_desc integracao,
       op.cfe_operacoes_desc operacao,
       sum(decode(trim(TDVADM.fn_querystring(TDVADM.fn_querystring(fo.con_freteoper_paramqrystr,'Usuario','=','*'), 'valor', '=', '|')),'jsantos',1,0)) TESTE,
       sum(decode(trim(TDVADM.fn_querystring(TDVADM.fn_querystring(fo.con_freteoper_paramqrystr,'Usuario','=','*'), 'valor', '=', '|')),'jsantos',0,1)) PRODUCAO
--select TDVADM.fn_querystring(TDVADM.fn_querystring(fo.con_freteoper_paramqrystr,'Usuario','=','*'), 'valor', '=', '|') Usuario,
--       TDVADM.fn_querystring(TDVADM.fn_querystring(fo.con_freteoper_paramqrystr,'Maquina','=','*'), 'valor', '=', '|') Maquina,
from tdvadm.t_con_freteoper fo
     ,tdvadm.t_cfe_integratdv itdv
     ,tdvadm.t_cfe_operacoes op
where 0 = 0
  and fo.cfe_integratdv_cod = itdv.cfe_integratdv_cod
  and fo.cfe_operacoes_cod = op.cfe_operacoes_cod
  and fo.con_freteoper_msgenv like '%248440%'
  and itdv.cfe_integratdv_cod in (9, --Consultar RNTRC
                                  0)
--  and op.cfe_operacoes_cod in (16, -- CONSULTAR RNTRC
--                               00)
  and 0 = (select count(*)
           from tdvadm.t_fcf_veiculodisp vd
           where vd.con_freteoper_id = fo.con_freteoper_id
             and vd.con_freteoper_rota = fo.con_freteoper_rota)
  and fo.con_freteoper_dtcad >= '01/01/2007'
group by to_char(fo.con_freteoper_dtcad,'YYYY'),
         itdv.cfe_integratdv_desc,
         op.cfe_operacoes_desc
;



-- menor data da FRETEOPER
select min(fo.con_freteoper_dtcad)
from tdvadm.t_con_freteoper fo
where 0 = (select count  (*)
           from tdvadm.t_fcf_veiculodisp vd
           where vd.con_freteoper_id = fo.con_freteoper_id)

