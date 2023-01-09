
select x.*,
       decode(x.Vfrete,1,(Select vf1.con_conhecimento_codigo||';'||vf1.con_conhecimento_serie||';'||vf1.glb_rota_codigo||';'||vf1.con_valefrete_saque||';'||vf1.con_catvalefrete_codigo||';'||vf1.con_valefrete_obrigacoes||';'||vf1.con_valefrete_obscaixa||';'
                          from tdvadm.t_con_valefrete vf1
                          where (vf1.fcf_veiculodisp_codigo,
                                 vf1.fcf_veiculodisp_sequencia) in (select sv1.fcf_veiculodisp_codigo,sv1.fcf_veiculodisp_sequencia
                                                                    from tdvadm.t_fcf_solveic sv1
                                                                    where sv1.fcf_solveic_cod = x.fcf_solveic_cod)),'') OUTROSVF,
       decode(x.Vfrete,1,(Select vf1.con_valefrete_custocarreteiro||';'||vf1.con_valefrete_tipocusto||';'||vf1.con_valefrete_pedagio
                          from tdvadm.t_con_valefrete vf1
                          where (vf1.fcf_veiculodisp_codigo,
                                 vf1.fcf_veiculodisp_sequencia) in (select sv1.fcf_veiculodisp_codigo,sv1.fcf_veiculodisp_sequencia
                                                                    from tdvadm.t_fcf_solveic sv1
                                                                    where sv1.fcf_solveic_cod = x.fcf_solveic_cod)),'') vlrVF
                                                                    
 

from (select cf.cad_frete_codigo,
             cf.cad_frete_data,
             cf.cad_frete_solicitacao,
             cf.cad_frete_status,
             cf.slf_contrato_codigo,
             cf.glb_localidade_origem,
             cf.glb_localidade_destino,
             cf.glb_localidade_passandopor,
             cf.cad_frete_origem,
             cf.cad_frete_destino,
             cf.cad_frete_jacadastrado,
             cf.cad_frete_novovalor,
             cf.cad_frete_vlraprovado,
             cf.cad_frete_vlraprovado - cf.cad_frete_jacadastrado DIF,
             cf.cad_frete_observacao,
             cf.fcf_solveic_cod,
             cf.fcf_fretecar_rowid,
             (select sv.fcf_veiculodisp_codigo||';'||sv.fcf_veiculodisp_sequencia
              from tdvadm.t_fcf_solveic sv
              where sv.fcf_solveic_cod = cf.fcf_solveic_cod) vdisp,
              (Select count(*)
               from tdvadm.t_con_valefrete vf
               where (vf.fcf_veiculodisp_codigo,
                      vf.fcf_veiculodisp_sequencia) in (select sv.fcf_veiculodisp_codigo,sv.fcf_veiculodisp_sequencia
                                                        from tdvadm.t_fcf_solveic sv
                                                        where sv.fcf_solveic_cod = cf.fcf_solveic_cod)) Vfrete,
                (select count(*)
                 from tdvadm.v_fcf_fretecar vc
                 where vc.rowidchave = cf.fcf_fretecar_rowid) QTDEMesa,
                (select 'Frete - ' || vc.FCF_FRETECAR_VALOR || ' - Pedagio - ' || vc.pedagio
                 from tdvadm.v_fcf_fretecar vc
                 where vc.rowidchave = cf.fcf_fretecar_rowid) vlrMesa

      from tdvadm.t_cad_frete cf
      where 0 = 0
        and cf.cad_frete_codigo =  50305) x
;
select 1258.54 + 153.9 + 341.46 + 267,1258.54 +  341.46 + 267 , 1333 + 267 from dual



select vf.con_conhecimento_codigo cte,
       vf.con_conhecimento_serie sr,
       vf.glb_rota_codigo rt,
       vf.con_valefrete_saque sq,
       vf.con_valefrete_fifo fifo,
       vf.usu_usuario_codigo,
       vf.usu_usuario_codalteracao,
       vf.fcf_veiculodisp_codigo || ';' || vf.fcf_veiculodisp_sequencia veiculodisp,
       vf.con_valefrete_custocarreteiro,
       vf.con_valefrete_pedagio,
       vf.con_valefrete_pedagiooriginal,
       cf.cad_frete_codigo cadfrete,
       cf.cad_frete_solicitacao solicitado,
       cf.cad_frete_status status,
       cf.cad_frete_jacadastrado cadnovovalor,
       cf.cad_frete_vlraprovado cadaprvalor,
       cf.cad_frete_vlraprovado - cf.cad_frete_jacadastrado DIF,
       cf.cad_frete_valefrete,
       cf.cad_frete_observacao observacao,
       sv.usu_usuario_soli solusu,
       sv.fcf_solveic_acrescimo solacres,
       vf.fcf_fretecar_rowid,
       (select 'Frete - ' || tdvadm.f_mascara_valor(vc.FCF_FRETECAR_VALOR,10,2) || ' - Pedagio - ' || tdvadm.f_mascara_valor(vc.pedagio,10,2) || ' PednoFrete - ' || vc.pednofrete
        from tdvadm.v_fcf_fretecar vc
        where vc.rowidchave = vf.fcf_fretecar_rowid) QTDEMesa
--       ,vf.*
from tdvadm.t_con_valefrete vf,
     tdvadm.t_fcf_solveic sv,
     tdvadm.t_cad_frete cf
where vf.fcf_veiculodisp_codigo = sv.fcf_veiculodisp_codigo (+)
  and vf.fcf_veiculodisp_sequencia = sv.fcf_veiculodisp_sequencia (+)
  and sv.fcf_solveic_cod = cf.fcf_solveic_cod(+)
  and vf.con_conhecimento_codigo = '034873'
  and vf.glb_rota_codigo = '237'
  ;
  
  select 15662.5 - ( 11899 + 750.4 + 3763.5 ) from dual
  
  
  
  
  select (11899 + 750.4 from dual;
  tdvadm.sp_gera_valefrete;
  
  
  
  
  select * from tdvadm.t_usu_aplicacaoperfil p
  where p.usu_usuario_codigo in ('craraujo','jsantos')
    and p.usu_aplicacao_codigo = 'veicdisp'
  for update
      
    
  
  
