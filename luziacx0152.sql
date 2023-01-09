SELECT M.GLB_ROTA_CODIGO CX,
       M.CAX_BOLETIM_DATA DATA,
       M.CAX_OPERACAO_CODIGO OPER,
       M.CAX_MOVIMENTO_DOCUMENTO DOCUMENTO,
       M.CAX_MOVIMENTO_VALOR * DECODE(OP.CAX_OPERACAO_TIPO,'S',-1,1) VALOR,
       OP.CAX_OPERACAO_TIPO TP,
       M.CAX_MOVIMENTO_HISTORICO HISTORICO,
       OP.CAX_OPERACAO_DESCRICAO DESOPER,
       M.CAX_MOVIMENTO_USUARIO USUARIO,
       M.CAX_MOVIMENTO_DTGRAVACAO GRAVACAO,
       m.cax_movimento_documentoref docref,
       m.cax_movimento_contabil contabil
FROM TDVADM.T_CAX_MOVIMENTO M,
     TDVADM.T_CAX_OPERACAO OP
WHERE M.GLB_ROTA_CODIGO_OPERACAO = OP.GLB_ROTA_CODIGO_OPERACAO
  AND M.CAX_OPERACAO_CODIGO = OP.CAX_OPERACAO_CODIGO
  AND M.GLB_ROTA_CODIGO = '015'
--  AND M.CAX_BOLETIM_DATA = '17/03/2017'
  AND 0 = (SELECT COUNT(*)
           FROM TDVADM.T_ACC_ACONTAS AC
           WHERE AC.ACC_ACONTAS_NUMERO = M.CAX_MOVIMENTO_DOCUMENTO
             AND AC.ACC_ACONTAS_DATATRANSF = M.CAX_BOLETIM_DATA);
             
             
select *
from tdvadm.v_acc_composicao015 c
where c.data >= to_date('01/10/2018','dd/mm/yyyy')          
;

select *
        from tdvadm.t_cax_movimento m
        where m.cax_operacao_codigo = '1127' -- ADIANTAMENTO FROTA PRÓPRIA - RECEBIDO (E)
          and m.glb_rota_codigo = '015'
          and m.cax_movimento_documento = '142958'
          and m.glb_rota_codigo_referencia = v.glb_rota_codigo
          and m.cax_movimento_valor = v.acc_vales_valor

SELECT *
FROM tdvadm.t_acc_vales v
where v.acc_vales_numero = '142958'
  and v.glb_rota_codigo = '185'
  
;
select m.cax_operacao_codigo operacao,
       m.glb_rota_codigo_operacao rotaop,
       m.cax_operacao_descricao descricao,
       m.cax_operacao_tipo tipo,
       m.cax_operacao_automatica
from tdvadm.t_cax_operacao m
where m.cax_operacao_codigo in ('2167','1127','1267')











SELECT CAR_TPVEICULO_CODIGO,
               CAR_TPVEICULO_DESCRICAO || ' - ' || CAR_TPVEICULO_LOTMAX ||' TON' CAR_TPVEICULO_DESCRICAO,
               CAR_TPVEICULO_LOTMAX,
               CAR_TPVEICULO_NUMEIXOS
FROM     tdvadm.T_CAR_TPVEICULO
ORDER BY CAR_TPVEICULO_DESCRICAO








SELECT A.CAR_PROPRIETARIO_CGCCPFCODIGO,
       A.CON_VALEFRETE_IMPOSTOS_REF,
       A.CON_VALEFRETE_IMPOSTOSVLRACUMU,
       A.CON_VALEFRETE_IMPOSTOS_IRRF,
       A.CON_VALEFRETE_IMPOSTOS_INSS,
       A.CON_VALEFRETE_IMPOSTOS_PIS,
       A.CON_VALEFRETE_IMPOSTOS_COFINS,
       A.CON_VALEFRETE_IMPOSTOS_CSLL,
       A.CON_VALEFRETE_IMPOSTOS_QTDVF,
       A.CON_VALEFRETE_IMPOSTOS_COMPINS,
       A.CON_VALEFRETE_IMPOSTOS_SS,
       A.CON_VALEFRETE_IMPOSTOS_DEP
FROM   T_CON_VALEFRETEIMPOSTOS A
WHERE  A.CAR_PROPRIETARIO_CGCCPFCODIGO = '04566392686'
--  AND  A.CON_VALEFRETE_IMPOSTOS_REF    = '01/2019'
  ORDER BY SUBSTR(A.CON_VALEFRETE_IMPOSTOS_REF,4,4) || SUBSTR(A.CON_VALEFRETE_IMPOSTOS_REF,1,2) DESC ;
  

select a.*
from tdvadm.v_ctb_impostosanalitico a,
     tdvadm.t_con_valefrete vf
where a.VF = vf.con_conhecimento_codigo
  and a.serie = vf.con_conhecimento_serie
  and a.rota = vf.glb_rota_codigo
  and a.sq = vf.con_valefrete_saque     
  and a.ref1 = '201810'
  and a.CPF = '32695671890'
order by a.cadastro;

select *
from tdvadm.t_car_veiculo v
where v.car_veiculo_placa = 'OYH0052'



select *
from tdvadm.t_con_valefrete vf
where vf.con_conhecimento_codigo = '030965'
  and vf.glb_rota_codigo = '023';

select * from tdvadm.t_fcf_veiculodisp vd
where vd.fcf_veiculodisp_codigo = '4175198'


select *
from tdvadm.t_fcf_fretecar fc
where fc.fcf_fretecar_rowid = 58523;

select *
from tdvadm.t_cad_frete cf
where cf.fcf_fretecar_rowid = 58523;


select *
from dba_tab_cols tc
where lower(tc.COLUMN_NAME) in ('fcf_fretecar_rowid','fcf_veiculodisp_codigo') 
  
select *
from dba_source s
where lower(s.TEXT) like '%cad_frete_vlraprovado%' ;

tdvadm.PKG_FIFO_VALEFRETE;


  

  
