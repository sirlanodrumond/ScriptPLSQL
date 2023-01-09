-- Add/modify columns 
alter table T_FCF_FRETECAR add fcf_fretecar_passandopor char(8);
alter table T_FCF_FRETECAR add fcf_fretecar_retvazio char(1);
-- Add comments to the columns 
comment on column T_FCF_FRETECAR.fcf_fretecar_passandopor
  is 'Codigo de Localidade para referenciar o PASSANDOPOR';
comment on column T_FCF_FRETECAR.fcf_fretecar_retvazio
  is 'Retorno Vazio';

select * from tdvadm.t_fcf_solveic;
select * from tdvadm.t_fcf_fretecar;


-- 2719 acrescimo > 0
-- 1915 2087 com filtro de data
-- 1059 1198 com filtro de canc e contratado

select sv.usu_usuario_soli ususol,
       sv.fcf_solveic_dtsoli dtsol,
       sv.fcf_solveic_cod codsol,
       sv.fcf_fretecar_rowid frowid,
       sv.fcf_veiculodisp_codigo solvdisp,
       sv.fcf_veiculodisp_sequencia solvdispseq,
       (select vf.con_valefrete_custocarreteiro
        from tdvadm.t_con_valefrete vf
        where vf.fcf_veiculodisp_codigo = sv.fcf_veiculodisp_codigo
          and vf.fcf_veiculodisp_sequencia = sv.fcf_veiculodisp_sequencia
          and vf.con_valefrete_status is null
          and nvl(vf.con_valefrete_impresso,'N') = 'S' 
          and vf.con_valefrete_datacadastro = (select min(vf1.con_valefrete_datacadastro)
                                               from tdvadm.t_con_valefrete vf1
                                               where vf1.fcf_veiculodisp_codigo = vf.fcf_veiculodisp_codigo
                                                 and vf1.fcf_veiculodisp_sequencia = vf.fcf_veiculodisp_sequencia
                                                 and vf1.con_valefrete_status is null
                                                 and nvl(vf1.con_valefrete_impresso,'N') = 'S')) vffrete,
       (select vfp.con_valefrete_custocarreteiro
        from tdvadm.t_con_valefrete vfp
        where vfp.con_catvalefrete_codigo = '14'
          and vfp.con_valefrete_status is null
          and nvl(vfp.con_valefrete_impresso,'N') = 'S'
          and (vfp.con_conhecimento_codigo,
               vfp.con_conhecimento_serie,
               vfp.glb_rota_codigo ) in (select vf.con_conhecimento_codigo,
                                                vf.con_conhecimento_serie,
                                                vf.glb_rota_codigo
                                         from tdvadm.t_con_valefrete vf
                                         where vf.fcf_veiculodisp_codigo = sv.fcf_veiculodisp_codigo
                                           and vf.fcf_veiculodisp_sequencia = sv.fcf_veiculodisp_sequencia
                                           and vf.con_valefrete_status is null
                                           and nvl(vf.con_valefrete_impresso,'N') = 'S' 
                                           and vf.con_valefrete_datacadastro = (select min(vf1.con_valefrete_datacadastro)
                                                                                from tdvadm.t_con_valefrete vf1
                                                                                where vf1.fcf_veiculodisp_codigo = vf.fcf_veiculodisp_codigo
                                                                                  and vf1.fcf_veiculodisp_sequencia = vf.fcf_veiculodisp_sequencia
                                                                                  and vf1.con_valefrete_status is null
                                                                                  and nvl(vf1.con_valefrete_impresso,'N') = 'S'))) vffreteBonus,
       (select count(distinct h.valor)
        from tdvadm.v_fcf_fretecarhist h
        where h.FCF_FRETECAR_ROWID = sv.fcf_fretecar_rowid) mesaqtde,
       (select max(h.valor)
        from tdvadm.v_fcf_fretecarhist h
        where h.FCF_FRETECAR_ROWID = sv.fcf_fretecar_rowid) mesavlrmaior,
       (select min(h.valor)
        from tdvadm.v_fcf_fretecarhist h
        where h.FCF_FRETECAR_ROWID = sv.fcf_fretecar_rowid) mesavlrmenor,
       (select min(h.des)
        from tdvadm.v_fcf_fretecarhist h
        where h.FCF_FRETECAR_ROWID = sv.fcf_fretecar_rowid) mesadesinencia,
       sv.fcf_solveic_valorfrete solfrete,
       sv.fcf_solveic_acrescimo solacrescimo,
       sv.fcf_solveic_valorexcecao solvalorexcecao, 
       sv.fcf_solveic_pedagio solpedagio,
       sv.fcf_solveic_pednofrete solpednofrete,
       (select cf.cad_frete_novovalor
        from tdvadm.t_cad_frete cf
        where cf.fcf_solveic_cod = sv.fcf_solveic_cod
          and cf.cad_frete_solicitacao = 'ALTERAÇAO VF'
          and cf.cad_frete_status = 'AP'
          and cf.cad_frete_data = (select max(cf1.cad_frete_data)
                                   from tdvadm.t_cad_frete cf1
                                   where cf1.fcf_solveic_cod = cf.fcf_solveic_cod
                                     and cf1.cad_frete_solicitacao = cf.cad_frete_solicitacao
                                     and cf1.cad_frete_status = cf.cad_frete_status)) cadfrete,

       (select cf.cad_frete_jacadastrado
        from tdvadm.t_cad_frete cf
        where cf.fcf_solveic_cod = sv.fcf_solveic_cod
          and cf.cad_frete_solicitacao = 'ALTERAÇAO VF'
          and cf.cad_frete_status = 'AP'
          and cf.cad_frete_data = (select max(cf1.cad_frete_data)
                                   from tdvadm.t_cad_frete cf1
                                   where cf1.fcf_solveic_cod = cf.fcf_solveic_cod
                                     and cf1.cad_frete_solicitacao = cf.cad_frete_solicitacao
                                     and cf1.cad_frete_status = cf.cad_frete_status)) cadcadastrado,
       (select cf.cad_frete_vlraprovado
        from tdvadm.t_cad_frete cf
        where cf.fcf_solveic_cod = sv.fcf_solveic_cod
          and cf.cad_frete_solicitacao = 'ALTERAÇAO VF'
          and cf.cad_frete_status = 'AP'
          and cf.cad_frete_data = (select max(cf1.cad_frete_data)
                                   from tdvadm.t_cad_frete cf1
                                   where cf1.fcf_solveic_cod = cf.fcf_solveic_cod
                                     and cf1.cad_frete_solicitacao = cf.cad_frete_solicitacao
                                     and cf1.cad_frete_status = cf.cad_frete_status)) cadaprovado,

       (select cf.cad_frete_novovalor_ajudante
        from tdvadm.t_cad_frete cf
        where cf.fcf_solveic_cod = sv.fcf_solveic_cod
          and cf.cad_frete_solicitacao = 'ALTERAÇAO VF'
          and cf.cad_frete_status = 'AP'
          and cf.cad_frete_data = (select max(cf1.cad_frete_data)
                                   from tdvadm.t_cad_frete cf1
                                   where cf1.fcf_solveic_cod = cf.fcf_solveic_cod
                                     and cf1.cad_frete_solicitacao = cf.cad_frete_solicitacao
                                     and cf1.cad_frete_status = cf.cad_frete_status)) cadajudante

from tdvadm.t_fcf_solveic sv
where 0 = 0
  and sv.fcf_solveic_acrescimo <> 0
  and trunc(sv.fcf_solveic_dtsoli) >= to_date('01/01/2019','dd/mm/yyyy')
  and trunc(sv.fcf_solveic_dtsoli) <= to_date('31/12/2019','dd/mm/yyyy')
  and sv.fcf_solveic_dtcancel is null
  and sv.fcf_solveic_dtcontr is not null
;








select * from tdvadm.t_fcf_fretecarexc;
select * from glbadm.v_job_rodando;
select * from glbadm.v_job_parados
select * from glbadm.v_job_todos t
where t.WHAT like '%SP_MANUTENCAO_HORA%'
/* RODA ROTINAS DE MANUTENCAO */
glbadm.PGK_GLB_MANUTENCAO.SP_MANUTENCAO_HORA;

sysdate  + glbadm.PKG_Glb_DateUtil.fn_CalculaIntervalo(1,'H');



select *
f

select *
from tdvadm.t_cad_frete cf
where cf.fcf_solveic_cod = 713106 --  728257
  and cf.cad_frete_solicitacao = 'ALTERAÇAO VF'
  and cf.cad_frete_status = 'AP'
  and cf.cad_frete_data = (select max(cf1.cad_frete_data)
                           from tdvadm.t_cad_frete cf1
                           where cf1.fcf_solveic_cod = cf.fcf_solveic_cod
                             and cf1.cad_frete_solicitacao = cf.cad_frete_solicitacao
                             and cf1.cad_frete_status = cf.cad_frete_status)
for update;

select * from tdvadm.T_CAD_INFOFRETE c
where c.cad_infofrete_codigo in (36289,36288)
for update
  
tdvadm.fk_frete_codigo
                               

;
  


select * from tdvadm.t_fcf_antt;
select * from tdvadm.t_fcf_fretecar 

select d.glb_dirf_ano base,
       decode(d.glb_dirf_origem,'C','CAIXA','F','VALE DE FRETE','P','CONTAS A PAGAR') origem,
       d.glb_dirg_codgretencao codigo,
       decode(d.glb_dirf_identespec,'1','FISICA','JURIDICA') PESSOA,
       d.glb_dirf_cpf CPF_CNPJ,
       d.glb_dirf_nome NOME,
       d.glb_dirf_mes01_vr01 VLR_01,
       d.glb_dirf_mes02_vr01 VLR_02,
       d.glb_dirf_mes03_vr01 VLR_03,
       d.glb_dirf_mes04_vr01 VLR_04,
       d.glb_dirf_mes05_vr01 VLR_05,
       d.glb_dirf_mes06_vr01 VLR_06,
       d.glb_dirf_mes07_vr01 VLR_07,
       d.glb_dirf_mes08_vr01 VLR_08,
       d.glb_dirf_mes09_vr01 VLR_09,
       d.glb_dirf_mes10_vr01 VLR_10,
       d.glb_dirf_mes11_vr01 VLR_11,
       d.glb_dirf_mes12_vr01 VLR_12,
       d.glb_dirf_mes01_vr03 IR_01,
       d.glb_dirf_mes02_vr03 IR_02,
       d.glb_dirf_mes03_vr03 IR_03,
       d.glb_dirf_mes04_vr03 IR_04,
       d.glb_dirf_mes05_vr03 IR_05,
       d.glb_dirf_mes06_vr03 IR_06,
       d.glb_dirf_mes07_vr03 IR_07,
       d.glb_dirf_mes08_vr03 IR_08,
       d.glb_dirf_mes09_vr03 IR_09,
       d.glb_dirf_mes10_vr03 IR_10,
       d.glb_dirf_mes11_vr03 IR_11,
       d.glb_dirf_mes12_vr03 IR_12
  from tdvadm.t_glb_dirf d
 where d.glb_dirf_ano = '2019'
   and d.glb_dirf_identrendimp = 0
order by 3,2


select * from tdvadm.t_acc_vales v
where v.acc_vales_numero = '147913'
  and v.glb_rota_codigo = '187'
  for update;
  

select *
from tdvadm.t_cax_movimento m
where m.cax_movimento_documento = '147913'
  and m.glb_rota_codigo_referencia = '187'
  for update;
  
    
  
  




SELECT *
FROM TDVADM.T_USU_PERFIL P
WHERE p.usu_aplicacao_codigo = 'comvlfrete'
  and ( not p.usu_perfil_codigo like 'VLRAGREGP%' and
        not p.usu_perfil_codigo like 'ALT%' 
        not p.usu_perfil_codigo like 'PERC%' )
        

CALCULA_BONUS -- Calcula Bonus   

UTILIZA_IDOPER 

ALTERA_KM

VALEFRETETRAVADO

ALTERA_TPCUSTO

tdvadm.PKG_EDI_CONTROLE;

SELECT * FROM TDVADM.T_USU_PERFIL P
WHERE P.USU_PERFIL_CODIGO = 'ALTERA_KM';

SELECT P.USU_PERFIL_CODIGO,
       P.USU_USUARIO_CODIGO,
       P.USU_GRUPO_CODIGO,
       P.GLB_ROTA_CODIGO,
       P.USU_APLICACAOPERFIL_PARAT
FROM TDVADM.T_USU_APLICACAOPERFIL P
WHERE P.USU_PERFIL_CODIGO = 'ALTERA_KM'
  AND P.USU_USUARIO_CODIGO <> '0000000000'
  AND P.USU_GRUPO_CODIGO <> '00000'
  AND P.GLB_ROTA_CODIGO <> '000'
;

select *
from tdvadm.t_con_valefrete vf
where vf.con_conhecimento_codigo = '168696'
  and vf.glb_rota_codigo = '160';

select * from tdvadm.t_fcf_veiculodisp vd
where vd.fcf_veiculodisp_codigo = '4320499'
;
select *
from tdvadm.t_fcf_solveic sv
where sv.fcf_veiculodisp_codigo = '4320499'  
  
SELECT *
FROM tdvipf.t_ipf_valefrete vf
where vf.ipf_valefrete_codigo = '168696'
  and vf.ipf_valefrete_rota = '160';
  
  select distinct vc.fcf_fretecar_origem codori,
         tdvadm.fn_busca_codigoibge(vc.fcf_fretecar_origem,'IBD') origem,
         vc.fcf_fretecar_destino coddes,
         tdvadm.fn_busca_codigoibge(vc.fcf_fretecar_destino,'IBD') destino,
--         vc.fcf_tpveiculo_codigo tpveic,
--         v.fcf_tpveiculo_descricao veiculo,
         trunc(vc.fcf_fretecar_dtcadastro) cadmesa,
         trunc(vc.fcf_fretecar_altkm) altmesa,
         trunc(p.slf_percurso_dtatualizacao) altper,
         vc.fcf_fretecar_km kmmesa,
         p.slf_percurso_km kmper
  from tdvadm.t_fcf_fretecar vc,
       tdvadm.t_slf_percurso p,
       tdvadm.t_fcf_tpveiculo v
  where vc.fcf_fretecar_origem = p.glb_localidade_codigoorigem (+)
    and vc.fcf_fretecar_destino = p.glb_localidade_codigodestino (+)
    and vc.fcf_tpveiculo_codigo = v.fcf_tpveiculo_codigo (+)
    and round(nvl(vc.fcf_fretecar_km,0),0) <> round(nvl(p.slf_percurso_km,1),0)
;

SELECT *
FROM V_GLB_IBGE  I
WHERE I.nomeex LIKE '%SAO PAULO%'
 SELECT * FROM TDVADM.T_GLB_LOCALIDADE;
 
 
select br.glb_benasserec_gravacao,br.glb_benasserec_assunto,br.glb_benasserec_status,br.glb_benasserec_obs
from rmadm.t_glb_benasserec br
where 0 = 0
  and br.glb_benasserec_gravacao >= '01/02/2020'
  and br.glb_benasserec_assunto like '%MSG=LISTNOTA;MINUTA=0421699131%'
  
select vf.con_valefrete_status,vf.con_valefrete_impresso
from tdvadm.t_con_valefrete vf
where vf.con_conhecimento_codigo = '042169'
  and vf.glb_rota_codigo = '913'
  
select *
from tdvadm.t_slf_cliregrasemail ce
where 0 = 0
  and ce.glb_grupoeconomico_codigo = '0567'
  and ce.glb_cliente_cgccpfcodigo = '60894730006308'
  and ce.slf_contrato_codigo = 'C7000067442';
  



select *
from tdvadm.t_
