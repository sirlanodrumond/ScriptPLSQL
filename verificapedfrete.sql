select vf.con_valefrete_custocarreteiro custocar,
       vf.con_valefrete_frete frete,
       vf.con_valefrete_freteoriginal freteori,
       vf.con_valefrete_pedagio ped,
       vf.con_valefrete_kmprevista km,
       vf.glb_localidade_codigoori ori,
       vf.glb_localidade_codigodes des,
       vf.fcf_veiculodisp_codigo vdisp,
       vf.fcf_veiculodisp_sequencia seq,
       vf.con_valefrete_entregas entregas,
       vf.fcf_fretecar_rowid frowid,
       vf.usu_usuario_codigo usuario,
       vf.con_valefrete_fifo fifo
from tdvadm.t_con_valefrete vf
where vf.con_conhecimento_codigo = '016630'
  and vf.glb_rota_codigo = '011';

select vd.fcf_tpveiculo_codigo tpveic,
       vd.car_veiculo_placa placa,
       vd.fcf_veiculodisp_desconto desconto,
       vd.fcf_fretecar_rowid frowid,
       vd.fcf_veiculodisp_valorfrete frete,
       vd.fcf_veiculodisp_acrescimo acrescimo,
       vd.fcf_veiculodisp_valorexcecao excecao,
       vd.fcf_veiculodisp_pedagio pedagio,
       vd.fcf_veiculodisp_qtdeentregas entregas,
       vd.fcf_veiculodisp_km km,
       vd.fcf_veiculodisp_pednofrete pednofrete
from tdvadm.t_fcf_veiculodisp vd  
where (vd.fcf_veiculodisp_codigo,
       vd.fcf_veiculodisp_sequencia) in (select vf.fcf_veiculodisp_codigo,
                                                vf.fcf_veiculodisp_sequencia
                                         from tdvadm.t_con_valefrete vf
                                         where vf.con_conhecimento_codigo = '016630'
                                           and vf.glb_rota_codigo = '011');

select sv.fcf_solveic_dtcontr,
       sv.fcf_solveic_dtprogramacao ,
       sv.fcf_tpveiculo_codigo tpveic,
       sv.fcf_solveic_valorfrete frete,
       sv.fcf_solveic_acrescimo acrescimo,
       sv.fcf_solveic_valorexcecao excecao,
       sv.fcf_solveic_desconto desconto,
       sv.fcf_solveic_pedagio ped,
       sv.fcf_solveic_qtdeentregas entregas,
       sv.fcf_solveic_pednofrete pednofrete,
       sv.fcf_solveic_cod solveic,
       sv.fcf_fretecar_rowid frowid
from tdvadm.t_fcf_solveic sv
where (sv.fcf_veiculodisp_codigo,
       sv.fcf_veiculodisp_sequencia) in (select vf.fcf_veiculodisp_codigo,
                                                vf.fcf_veiculodisp_sequencia
                                         from tdvadm.t_con_valefrete vf
                                         where vf.con_conhecimento_codigo = '016630'
                                           and vf.glb_rota_codigo = '011');
select *
from tdvadm.t_fcf_solveicorig so
where so.fcf_solveic_cod = '612410';

select *
from tdvadm.t_fcf_solveicdest vd
where vd.fcf_solveic_cod = '612410';



select fc.fcf_fretecar_origem ori,
       fc.fcf_fretecar_destino des,
       fc.fcf_fretecar_valor frete,
       fc.fcf_fretecar_pedagio pedagio,
       fc.fcf_fretecar_valor + fc.fcf_fretecar_pedagio freteped,
       fc.fcf_fretecar_km km,
       fc.fcf_fretecar_rowid frowid
from tdvadm.t_fcf_fretecar fc
where fc.fcf_fretecar_rowid in (select vf.fcf_fretecar_rowid
                                from tdvadm.t_con_valefrete vf
                                where vf.con_conhecimento_codigo = '016630'
                                  and vf.glb_rota_codigo = '011');



select *
from tdvadm.t_fcf_solveic sv
where trunc(sv.fcf_solveic_dtcontr) = '28/11/2018' 
  and nvl(sv.fcf_solveic_valorfrete,0) > 0
  and 0 = (select count(*)
           from tdvadm.t_con_valefrete vf
           where vf.fcf_veiculodisp_codigo = sv.fcf_veiculodisp_codigo
             and nvl(vf.con_valefrete_impresso,'N') = 'S')

/*
select * from tdvadm.v_lock_tables;
select * from                     

tdvadm.sp_gera_valefrete
