-- Alam 18/04/2019

-- Solicitado vanderleia e vinculado como carreta
-- 031065 / 023

-- Valor do adiantamento de 200%
-- 019701 / 187

-- Mudaram a origem/destino e alteraram o frete.
-- 027938 / 530

-- procurar view passei para o clauido 18/04
-- tdvadm.v_fcf_freteanalise

-- criar log do vale de frete
-- criar log da localidade.


select vf.con_valefrete_datacadastro,
       vf.con_valefrete_status,
       vf.con_conhecimento_codigo,
       vf.con_conhecimento_serie,
       vf.glb_rota_codigo,
       vf.con_valefrete_saque,
       vf.con_valefrete_placa,
       vf.con_valefrete_placasaque,
       vf.fcf_veiculodisp_codigo,
       vf.fcf_veiculodisp_sequencia,
       vf.fcf_fretecar_rowid,
       vf.con_valefrete_frete,
       vf.con_valefrete_adiantamento,
       vf.con_valefrete_freteoriginal,
       vf.con_valefrete_entregas
from tdvadm.t_con_valefrete vf
where vf.con_conhecimento_codigo = '019701'
  and vf.glb_rota_codigo = '187';
  
  
select *  
from tdvadm.t_fcf_fretecar fc
where fc.fcf_fretecar_rowid = 48948;

select sv.fcf_solveic_dtsoli,
       sv.fcf_solveic_tpfrete,
       sv.fcf_solveic_qtdeentregas,
       sv.fcf_solveic_valorfrete,
       sv.fcf_solveic_acrescimo,
       sv.fcf_solveic_valorexcecao,
       sv.fcf_solveic_pedagio
from tdvadm.t_fcf_solveic sv
where sv.fcf_fretecar_rowid = 48948

select *
from tdvadm.t_frt_conteng ce
where ce.frt_conjveiculo_codigo = '0003402';


select *
from tdvadm.t_frt_histconteng ce
where ce.frt_conjveiculo_codigo = '0003402';

select tdvadm.pkg_frtcar_veiculo.FN_RETAPELIDOCONJ('0003402','01/04/2019')
from dual;



tdvadm.
  
  
