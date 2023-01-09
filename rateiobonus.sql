-- Moreira rateio do BONUS

select vf.con_conhecimento_codigo ,
       vf.glb_rota_codigo,
       vf.con_valefrete_saque,
       vf.con_valefrete_placa,
       vf.con_valefrete_custocarreteiro,
       vf.con_valefrete_tipocusto,
       nvl(vf.con_valefrete_descbonus,'N') descbonus,
       tdvadm.VFPERCENT_CALC_BONUS percentual,
       vf.con_valefrete_custocarreteiro + decode(nvl(vf.con_valefrete_descbonus,'N'),'S',tdvadm.FN_RETORNAVALORFRETEBONUS(vf.con_valefrete_frete,tdvadm.VFPERCENT_CALC_BONUS,'B2'),0) calc,
       vf.con_valefrete_freteoriginal,
       decode(nvl(vf.con_valefrete_descbonus,'N'),'S',tdvadm.FN_RETORNAVALORFRETEBONUS(vf.con_valefrete_frete,tdvadm.VFPERCENT_CALC_BONUS,'B2'),0) bonus,
       decode(nvl(vf.con_valefrete_descbonus,'N'),'S',tdvadm.FN_RETORNAVALORFRETEBONUS(vf.con_valefrete_frete,tdvadm.VFPERCENT_CALC_BONUS,'B'),0) bonus2,
       decode(nvl(vf.con_valefrete_descbonus,'N'),'S',tdvadm.FN_RETORNAVALORFRETEBONUS(vf.con_valefrete_frete,tdvadm.VFPERCENT_CALC_BONUS,'F'),0) bonus3,
       vf.con_valefrete_condespeciais 
from tdvadm.t_con_valefrete vf
where vf.con_valefrete_datacadastro >= '01/07/2017'
--  and vf.con_conhecimento_codigo = '108018'
  and nvl(vf.con_valefrete_descbonus,'N') = 'S'


  
