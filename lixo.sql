
select x.*,decode(x.kmcalculo_soma,0,0,decode(aliquota,0,fretesimp,(fretesimp * ((1-(aliquota/100))))) * (x.kmcalculo/x.kmcalculo_soma)) rateio
from (
select d.con_conhecimento_referencia referencia,
       d.con_conhecimento_codigo cte,
       d.glb_rota_codigo_conhecimento rota,
       d.con_valefrete_codigo vfrete,
       d.glb_rota_codigo_valefrete rotavf,
       d.con_catvalefrete_codigo codcat,
       cat.con_catvalefrete_descricao categoria,
       d.glb_localidade_codigo_vlfori origem,
       d.glb_localidade_codigo_vlfdes destino,
       r.ipf_reccust_rota_categoria_rat rateia,
       (select nvl(vf.con_valefrete_impresso,'N') || '-' || decode(nvl(vf.cax_movimento_sequencia,0),0,'N','S') || '-' || nvl(vf.con_valefrete_status,'N')
        from tdvadm.t_con_valefrete vf
        where vf.con_conhecimento_codigo = d.con_valefrete_codigo
          and vf.con_conhecimento_serie = d.con_valefrete_serie
          and vf.glb_rota_codigo = d.glb_rota_codigo_valefrete
          and vf.con_valefrete_saque = d.con_valefrete_saque) vfreteimpcaixa,
       d.con_valefrete_kmpercurso kmpercurso,
       d.con_valefrete_kmcalculo kmcalculo,
       d.con_valefrete_kmcalculo_soma kmcalculo_soma,
       tdvadm.fn_busca_conhec_verba(d.con_conhecimento_codigo,d.con_conhecimento_serie,d.glb_rota_codigo_conhecimento,'I_FRPSVO') fretesimp,
       tdvadm.fn_busca_conhec_verba(d.con_conhecimento_codigo,d.con_conhecimento_serie,d.glb_rota_codigo_conhecimento,'S_ALICMS') aliquota,
       (select vf.con_valefrete_frete
        from tdvadm.t_con_valefrete vf
        where vf.con_conhecimento_codigo = d.con_valefrete_codigo
          and vf.con_conhecimento_serie = d.con_valefrete_serie
          and vf.glb_rota_codigo = d.glb_rota_codigo_valefrete
          and vf.con_valefrete_saque = d.con_valefrete_saque) vlrvfrete,
       (select nvl(c.con_conhecimento_flagcancelado,'N')
        from tdvadm.t_con_conhecimento c
        where c.con_conhecimento_codigo = d.con_conhecimento_codigo
          and c.con_conhecimento_serie = d.con_conhecimento_serie
          and c.glb_rota_codigo = d.glb_rota_codigo_conhecimento) cancelado,
       (select c.con_conhecimento_dtemissao
        from tdvadm.t_con_conhecimento c
        where c.con_conhecimento_codigo = d.con_conhecimento_codigo
          and c.con_conhecimento_serie = d.con_conhecimento_serie
          and c.glb_rota_codigo = d.glb_rota_codigo_conhecimento) dtembarqe
from tdvipf.t_ipf_reccust_diretos d,
     tdvipf.t_ipf_reccust_rota_categoria r,
     tdvadm.t_con_catvalefrete cat
where d.glb_rota_codigo_valefrete = r.glb_rota_codigo (+)
  and d.con_catvalefrete_codigo = r.con_catvalefrete_codigo (+)
  and d.con_catvalefrete_codigo = cat.con_catvalefrete_codigo (+)
--  and d.con_conhecimento_codigo in ('041790','041837')
--  and d.glb_rota_codigo_conhecimento = '165'
  and nvl(d.ipf_ctrc_rat_valor,0) <= 0 
  and r.ipf_reccust_rota_categoria_rat = 'S'
  ) x;
  


select * from tdvadm.t_slf_contrato c
where c.slf_contrato_descricao like '%ALBRA%'

select *
from tdvadm.t_slf_cliregrasveic cv
where cv.slf_contrato_codigo in ('C2017100116','C4600006002')


select *
from glbadm.v_job_todos t
where upper(t.WHAT) like '%PERCURSO%'

00000001 - Matriz - 05571 
32600190 - Betim - 32500 

update tdvadm.t_con_valefrete vf
  set vf.glb_localidade_codigodes = '05571'
where vf.glb_localidade_codigodes = '00000001'

select *
from tdvadm.t_glb_localidade l 
where 0 = 0
  and ( l.glb_localidade_descricao like '%MATRIZ%'
    or l.glb_localidade_descricao like '%BETIM%'
    or l.glb_localidade_codigo = '05571')
    
update tdvipf.t_ipf_reccust_diretos d
  set d.glb_localidade_codigo_vlfdes = '05571'
where d.glb_localidade_codigo_vlfdes = '00000001';


select *
from tdvipf.t_ipf_reccust_rota_categoria r

select c.con_catvalefrete_codigo codcat,
       c.con_catvalefrete_descricao categoria,
       r.glb_rota_codigo rota,
       r.ipf_reccust_rota_categoria_rat rateia
from tdvipf.t_ipf_reccust_rota_categoria r,
     tdvadm.t_con_catvalefrete c
where r.con_catvalefrete_codigo(+) = c.con_catvalefrete_codigo
order by 3,1;

select *
from tdvadm.t_slf_contrato c
where c.slf_contrato_descricao like '%ALBRA%';

select *
from tdvadm.v_slf_clientecargas cc
where cc.contrato in ('C2017100116','C2017010106','C4600006002')


select *
from tdvadm.t_slf_contrato c
where 0 = 0
  and nvl(c.slf_contrato_dtfinal,trunc(sysdate)) >= trunc(sysdate)
--  and c.slf_contrato_descricao like '%ALBRAS%'
  and 0 = ( select count(*)
            from tdvadm.t_slf_solfrete sf
            where sf.slf_solfrete_contrato = c.slf_contrato_codigo
              and nvl(sf.slf_solfrete_status,'N') = 'N'
              and trunc(sf.slf_solfrete_vigencia) < trunc(sysdate)
              and trunc(sf.slf_solfrete_dataefetiva) > trunc(sysdate))
  and 0 = ( select count(*)
            from tdvadm.t_slf_tabela ta
            where ta.slf_tabela_contrato = c.slf_contrato_codigo
              and nvl(ta.slf_tabela_status,'N') = 'N'
              and trunc(ta.slf_tabela_vigencia) <= trunc(sysdate)
              and ta.slf_tabela_vigencia = (select max(ta1.slf_tabela_vigencia)
                                            from tdvadm.t_slf_tabela ta1
                                            where ta1.slf_tabela_codigo = ta.slf_tabela_codigo))


tdvadm.sp_fcf_liberacaofrete


select *
from tdvadm.t_usu_perfil p
where p.usu_perfil_codigo like 'AUTORIZADOR%'
for update;


tdvadm.sp_fcf_liberacaofrete

select c.cad_frete_status,count(*)
from tdvadm.t_cad_frete c  
group by c.cad_frete_status;
select * from tdvadm.v_lock_tables;

select *
from tdvadm.t_fcf_veiculodisp vf
where vf.fcf_veiculodisp_acrescimo > 0;

select f.cad_frete_solicitacao,count(*)
from tdvadm.t_cad_frete f
group by f.cad_frete_solicitacao

select * from tdvadm.t_fcf_fretecar

insert into tdvadm.t_fcf_fretecar
select f.glb_localidade_origem,
       f.glb_localidade_destino,
--       tdvadm.fn_busca_codigoibge(f.glb_localidade_origem,'IBD') origem,
--       tdvadm.fn_busca_codigoibge(f.glb_localidade_destino,'IBD') destino,
--       f.cad_frete_status status,
       'LO',
       f.fcf_tpveiculo_codigo,
       '00',
--       nvl(f.cad_frete_vlraprovado,f.cad_frete_novovalor) cad_frete_vlraprovado2,
       f.cad_frete_vlraprovado,
       'VL',
       trunc(sysdate),
       'jsantos',
       null,
       sysdate,
       null,
       0,
       null,
       f.usu_usuario_codigo,
       f.cad_frete_km,
       null,
       null,
       null
from tdvadm.t_cad_frete f
where f.fcf_fretecar_rowid is null
  and f.cad_frete_data >= sysdate -2
  and f.cad_frete_solicitacao = 'NOVO PERCURSO'
  and f.cad_frete_status = 'AP'
  and 0 = (select count(*)
           from tdvadm.t_fcf_fretecar fc
           where fc.fcf_fretecar_origem = f.glb_localidade_origem
             and fc.fcf_fretecar_destino = f.glb_localidade_destino
             and fc.fcf_tpveiculo_codigo = f.fcf_tpveiculo_codigo);
             
             
insert into tdvadm.t_fcf_fretecar
select f.glb_localidade_origem,
       f.glb_localidade_destino,
--       tdvadm.fn_busca_codigoibge(f.glb_localidade_origem,'IBD') origem,
--       tdvadm.fn_busca_codigoibge(f.glb_localidade_destino,'IBD') destino,
--       f.cad_frete_status status,
       'LO',
       f.fcf_tpveiculo_codigo,
       '00',
--       nvl(f.cad_frete_vlraprovado,f.cad_frete_novovalor) cad_frete_vlraprovado2,
       f.cad_frete_vlraprovado,
       'VL',
       trunc(sysdate),
       'jsantos',
       null,
       sysdate,
       null,
       0,
       null,
       f.usu_usuario_codigo,
       f.cad_frete_km,
       null,
       null,
       nullfrom tdvadm.t_cad_frete f
where f.fcf_fretecar_rowid is null
  and f.cad_frete_data >= sysdate -2
  and f.cad_frete_solicitacao = 'ALTERAÇAO PERCURSO'
  and f.cad_frete_status = 'RJ'
  and 0 < (select count(*)
           from tdvadm.t_fcf_fretecar fc
           where fc.fcf_fretecar_origem = f.glb_localidade_origem
             and fc.fcf_fretecar_destino = f.glb_localidade_destino
             and fc.fcf_tpveiculo_codigo = f.fcf_tpveiculo_codigo)
  
select *
from tdvadm.t_fcf_fretecarhist


select *
from tdvadm.t_slf_contrato c
where c.slf_contrato_descricao like '%RAIZ%';

select cc.slf_tpfrete_codigo,
       cc.fcf_tpcarga_codigo,
       cc.slf_tpagrupa_codigo
from tdvadm.t_slf_clientecargas cc
where cc.slf_contrato_codigo = 'C2018010119'
for update;


select * from tdvadm.v_slf_tpagrupa 





    SELECT DISTINCT B.FRT_MOTORISTA_CODIGO,
            A.FRT_CONJVEICULO_CODIGO,
            A.FRT_MOVVAZIO_NUMERO,
            A.GLB_ROTA_CODIGO,
            A.GLB_LOCALIDADE_CODIGOORIGEM,
            A.GLB_LOCALIDADE_CODIGODESTINO,
            A.FRT_MOVVAZIO_KM,
            A.FRT_MOVVAZIO_VALOR,
            A.FRT_MOVVAZIO_DTHRSAIDA,
            A.FRT_MOVVAZIO_STATUS,
            A.FRT_MOVVAZIO_OBS,
            A.FRT_MOVVAZIO_USUARIO,
            A.FRT_MOVVAZIO_DATARECEBIMENTO
    FROM tdvadm.T_FRT_MOVVAZIO A,
         tdvadm.V_FRT_CONJUNTO B
    WHERE A.FRT_CONJVEICULO_CODIGO = B.FRT_CONJVEICULO_CODIGO
      AND (TRUNC(A. FRT_MOVVAZIO_DTHRSAIDA)  <= '31/07/2018')
      AND B.FRT_MOTORISTA_CODIGO = '4550'
      AND ACC_ACONTAS_NUMERO IS NULL
      AND A.FRT_MOVVAZIO_DATARECEBIMENTO IS NOT NULL
    ORDER BY FRT_MOVVAZIO_DTHRSAIDA   
    
    250565
    251200 
    
    
   select n.fcf_tpcarga_codigo from tdvadm.t_arm_coleta n
   where n.arm_coleta_ncompra = '974480'
     and n.arm_coleta_ciclo = '002'
    select * from tdvadm.t_arm_carregamentodet cd
    where cd.arm_embalagem_numero = '2235965'
    
    select *
from tdvadm.v_arm_verifcarreg vc
where vc.carreg = '1605796';



         SELECT disitnct cv.slf_cliregrasveic_nomeveic
         FROM TDVADM.T_SLF_CLIREGRASVEIC CV
         WHERE CV.FCF_TPVEICULO_CODIGO = '14 '
           AND CV.FCF_TPCARGA_CODIGO = '01'

select 
01;


select * from glbadm.v_job_rodando


select *
from tdvadm.t_con_loggeracao lg
where lg.arm_carregamento_codigo = '1605796'
order by 1

    
    select *
    from tdvadm.t_arm_carregamento c
    where c.arm_carregamento_codigo like '166303%'
    


•	idf.preco_unitario = idf.vl_fiscal
•	idf.preco_total = idf.qtd(*)idf_preco_unitario
    






typesynchro_idf.Qtd            := 1; 
        typesynchro_idf.preco_unitario := typesynchro_idf.Vl_Fiscal;
        typesynchro_idf.preco_total    := typesynchro_idf.Qtd * typesynchro_idf.Vl_Fiscal;

-- 48.850

select f.fcf_fretecar_rowid,count(*)
from tdvadm.t_cad_frete f
group by f.fcf_fretecar_rowid
having count(*) > 1

select * from tdvadm.t_fcf_solveic
fcf_solveic_cod 



select distinct cd.cad_frete_solicitacao from tdvadm.t_cad_frete cd
where cd.cad_frete_status = 'AP'

select vf.fcf_veiculodisp_codigo
from tdvadm.t_con_valefrete vf
where vf.con_conhecimento_codigo = '941008'
  and vf.glb_rota_codigo = '021';

select *
from tdvadm.t_fcf_solveic sv
where sv.fcf_veiculodisp_codigo = '3518530';

select *
from tdvadm.t_cad_frete f
where f.fcf_solveic_cod = '580051'
  

select vf.con_valefrete_saque,
       vf.con_valefrete_localcarreg,
       vf.con_valefrete_localdescarga,
       vf.con_catvalefrete_codigo,
       vf.con_catvalefrete_codigo,
       vf.con_valefrete_placa,
       vf.usu_usuario_codigo,
       vf.usu_usuario_codalteracao
from tdvadm.t_con_valefrete vf
where vf.con_conhecimento_codigo = '920914'
  and vf.glb_rota_codigo = '197'
  
select distinct d.con_valefrete_codigo vfrete,
       d.glb_rota_codigo_valefrete rtvf,
       d.con_valefrete_saque sq,
       d.con_conhecimento_codigo cte,
       d.glb_rota_codigo_conhecimento rtcte,
       d.con_catvalefrete_codigo categoria,
       d.con_conhecimento_valor valorcte,
       tdvadm.fn_busca_conhec_verba(d.con_conhecimento_codigo,d.con_conhecimento_serie,d.glb_rota_codigo_conhecimento,'D_FRPSVO') freteCTE,
       d.con_valefrete_kmpercurso percurso,
       d.con_valefrete_kmcalculo alculo,
       d.con_valefrete_kmcalculo_soma soma
from tdvipf.t_ipf_reccust_diretos d
where d.con_valefrete_codigo = '920914'
  and d.glb_rota_codigo_valefrete = '197'
order by 1,2,3,4,5;


select * 
from tdvipf.t_ipf_reccust_rota_categoria x
where x.glb_rota_codigo = '197'


-- 14911
                    Select f.cad_frete_codigo,
                           f.fcf_solveic_cod,
                           sv.fcf_solveic_cod,
                           sv.fcf_veiculodisp_codigo,
                           sv.fcf_veiculodisp_sequencia,
                           sv.fcf_solveic_valorfrete,
                           f.cad_frete_vlraprovado,
                           f.cad_frete_status,
                           SV.FCF_SOLVEIC_ACRESCIMO
                    from tdvadm.t_cad_frete f,
                         tdvadm.t_fcf_solveic sv
                    where 0 = 0
--                      and f.fcf_fretecar_rowid is null
                      and f.cad_frete_data >= sysdate - 2
                      and trim(f.cad_frete_solicitacao) = 'ALTERAÇAO VF'
--                      and f.cad_frete_codigo = 14911
--                      and sv.fcf_solveic_cod = 580051 
                      and f.cad_frete_status = 'AP'
                      and f.fcf_solveic_cod = sv.fcf_solveic_cod 
                      and 0 < (select count(*)
                               from tdvadm.t_fcf_solveic sv1
                               where sv1.fcf_solveic_cod = sv.fcf_solveic_cod
                                 and nvl(sv1.fcf_solveic_acrescimo,0) = 0)
                      and 0 = (select count(*)
                               from tdvadm.t_con_valefrete vf
                               where vf.fcf_veiculodisp_codigo = sv.fcf_veiculodisp_codigo
                                 and vf.fcf_veiculodisp_sequencia = sv.fcf_veiculodisp_sequencia)



select CAD.CAD_FRETE_STATUS
FROM TDVADM.T_FCF_SOLVEIC FC, TDVADM.T_FCF_TPVEICULO TP, TDVADM.T_FCF_VEICULODISP VD ,TDVADM.T_CAD_FRETE CAD
WHERE FC.FCF_SOLVEIC_COD IS NOT NULL
  AND TP.FCF_TPVEICULO_CODIGO(+) = FC.FCF_TPVEICULO_CODIGO
  AND VD.FCF_VEICULODISP_CODIGO(+) = FC.FCF_VEICULODISP_CODIGO
  AND VD.FCF_VEICULODISP_SEQUENCIA(+) = FC.FCF_VEICULODISP_SEQUENCIA
  AND FC.FCF_SOLVEIC_COD = CAD.FCF_SOLVEIC_COD (+)
  AND CAD.CAD_FRETE_CODIGO IS NOT NULL
  AND CAD.CAD_FRETE_STATUS = 'AG'


select *
from tdvadm.t_usu_aplicacao ap
where ap.usu_aplicacao_path like '%prj_extmo%'
for update;
  




select * from glbadm.v_job_todos t
where upper(t.WHAT) like '%T_CAD_FRETE%';

SELECT * FROM DBA_SOURCE S
WHERE UPPER(S.TEXT) LIKE '%T_CAD_FRETE%';


TDVADM.PKG_CON_VALEFRETE;
