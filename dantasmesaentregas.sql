-- Verificas as ASN
select A.COL_ASN_DTGRAVACAO gravacao,
--       A.COL_ASN_ID IDASN,
       a.col_asn_numero ASN,
       a.arm_coleta_ncompra coleta,
       a.arm_coleta_ciclo ciclo,
              Case
          When a.COL_ASN_SPECIALPROCESSCODE = 'BR09' and a.COL_ASN_TIPOCARGA = 'A' and A.COL_ASN_FRAGILELOAD = '2' AND A.COL_ASN_SELFSUPPORTINGLOAD = '2'
            Then 'DEVOLUCAO'
            Else 'NORMAL'
          end as TIPO,
       (select an.arm_nota_numero || '-' || an.glb_cliente_cgccpfremetente || '-' || an.arm_nota_serie
        from tdvadm.t_arm_nota an
        where an.arm_nota_dtinclusao >= to_date('01/08/2020','dd/mm/yyyy')
          and an.arm_coleta_ncompra = a.arm_coleta_ncompra
          and an.arm_coleta_ciclo = a.arm_coleta_ciclo) qtdenota,
       (select count(distinct c.arm_carregamento_codigo)
        from tdvadm.t_arm_carregamentodet c
        where (c.arm_embalagem_numero,
               c.arm_embalagem_flag,
               c.arm_embalagem_sequencia) in (select an.arm_embalagem_numero,
                                                     an.arm_embalagem_flag,
                                                     an.arm_embalagem_sequencia
                                              from tdvadm.t_arm_nota an
                                              where an.arm_coleta_ncompra = a.arm_coleta_ncompra
                                                and an.arm_coleta_ciclo = a.arm_coleta_ciclo)) carreg,

        (select count(*)
         from tdvadm.t_con_nftransporta nf
         where nf.con_nftransportada_dtemissao >= to_date('01/08/2020','dd/mm/yyyy')
           and (nf.con_nftransportada_numnfiscal,
                nf.glb_cliente_cgccpfcodigo) in (select lpad(an.arm_nota_numero,9,'0'),
                                                        rpad(an.glb_cliente_cgccpfremetente,20)
                                                 from tdvadm.t_arm_nota an
                                                 where an.arm_coleta_ncompra = a.arm_coleta_ncompra
                                                   and an.arm_coleta_ciclo = a.arm_coleta_ciclo)) qtdcte,
       a.COL_ASN_SPECIALPROCESSCODE,
       a.COL_ASN_TIPOCARGA,         
       A.COL_ASN_FRAGILELOAD,       
       A.COL_ASN_SELFSUPPORTINGLOAD,
       a.col_asn_obs
from tdvadm.t_Col_Asn a
where 0 = 0
  and a.col_asn_dtgravacao >= to_date('15/08/2020','dd/mm/yyyy')
  and a.COL_ASN_SPECIALPROCESSCODE = 'BR09' and a.COL_ASN_TIPOCARGA = 'A' AND A.COL_ASN_FRAGILELOAD = '2' AND A.COL_ASN_SELFSUPPORTINGLOAD = '2'
--  and  a.col_asn_numero in ('V830104589','V830117872','N000622937','V830118156','V840020716','V830126794','6593108473','V830127469')
;  

select *
from tdvadm.t_arm_nota an
where an.arm_nota_numero = 4799
  and an.glb_cliente_cgccpfremetente = '00981013000199';

select c.con_conhecimento_dtembarque,
       nf.con_nftransportada_numnfiscal,
       nf.glb_cliente_cgccpfcodigo,
       nf.con_conhecimento_codigo,
       nf.glb_rota_codigo,
       c.arm_coleta_ncompra,
       c.arm_coleta_ciclo
from tdvadm.t_con_conhecimento c,
     tdvadm.t_con_nftransporta nf
where c.con_conhecimento_codigo = nf.con_conhecimento_codigo
  and c.con_conhecimento_serie = nf.con_conhecimento_serie
  and c.glb_rota_codigo = nf.glb_rota_codigo
  and nf.con_nftransportada_numnfiscal like '%4799'
  and nf.glb_cliente_cgccpfcodigo = '00981013000199';


SELECT TO_CHAR(X.fcf_solveic_dtsoli,'YYYYMM') REFER,
       X.arm_armazem_codigo,
       X.ARM_ARMAZEM_DESCRICAO,
       X.usu_usuario_soli,
       COUNT(*) QTDE
 SELECT x.fcf_fretecar_rowid,x.rowidvf,x.origem,x.destino,count(*)
FROM (select sf.arm_armazem_codigo,
             A.ARM_ARMAZEM_DESCRICAO,
             sf.fcf_solveic_cod,
             sf.fcf_solveic_peso,
             sf.fcf_solveic_qtdentrega,
             sf.usu_usuario_soli,
             sf.fcf_solveic_dtsoli,
             sf.fcf_fretecar_rowid,
             (SELECT max(vf.fcf_fretecar_rowid)
              FROM TDVADM.T_CON_VALEFRETE VF
              WHERE VF.FCF_VEICULODISP_CODIGO = SF.FCF_VEICULODISP_CODIGO
                AND VF.FCF_VEICULODISP_SEQUENCIA = SF.FCF_VEICULODISP_SEQUENCIA
                AND NVL(VF.CON_VALEFRETE_STATUS,'N') <> 'C') rowidvf,
             FC.FCF_FRETECAR_VALOR VALORMESA,
             FC.FCF_FRETECAR_PEDAGIO VALORPEDAGIO,
             sf.fcf_solveic_qtdeentregas,
             sf.fcf_solveic_tpfrete,
             sf.fcf_solveic_valorfrete,
             SF.FCF_SOLVEIC_ACRESCIMO,
             SF.FCF_SOLVEIC_VALOREXCECAO,
             SF.FCF_SOLVEIC_PEDAGIO,
             SF.FCF_SOLVEIC_PEDNOFRETE,
             FC.origem,
             FC.destino,
             ((select count(*)
              from tdvadm.t_fcf_solveicdest vd
              where vd.fcf_solveic_cod = sf.fcf_solveic_cod) - 1) entregaad,
             (SELECT COUNT(*)
              FROM TDVADM.T_CON_VALEFRETE VF
              WHERE VF.FCF_VEICULODISP_CODIGO = SF.FCF_VEICULODISP_CODIGO
                AND VF.FCF_VEICULODISP_SEQUENCIA = SF.FCF_VEICULODISP_SEQUENCIA
                AND NVL(VF.CON_VALEFRETE_STATUS,'N') <> 'C') VFRETE,
             (SELECT SUM(VF.CON_VALEFRETE_CUSTOCARRETEIRO)
              FROM TDVADM.T_CON_VALEFRETE VF
              WHERE VF.FCF_VEICULODISP_CODIGO = SF.FCF_VEICULODISP_CODIGO
                AND VF.FCF_VEICULODISP_SEQUENCIA = SF.FCF_VEICULODISP_SEQUENCIA
                AND VF.CON_VALEFRETE_TIPOCUSTO = 'U'
                AND NVL(VF.CON_VALEFRETE_STATUS,'N') <> 'C') VFRETEVALORUNICO,
             (SELECT SUM(VF.CON_VALEFRETE_CUSTOCARRETEIRO)
              FROM TDVADM.T_CON_VALEFRETE VF
              WHERE VF.FCF_VEICULODISP_CODIGO = SF.FCF_VEICULODISP_CODIGO
                AND VF.FCF_VEICULODISP_SEQUENCIA = SF.FCF_VEICULODISP_SEQUENCIA
                AND VF.CON_VALEFRETE_TIPOCUSTO <> 'U'
                AND NVL(VF.CON_VALEFRETE_STATUS,'N') <> 'C') VFRETEVALORTAXA,
             (SELECT MAX(VF.GLB_TPMOTORISTA_CODIGO)
              FROM TDVADM.T_CON_VALEFRETE VF
              WHERE VF.FCF_VEICULODISP_CODIGO = SF.FCF_VEICULODISP_CODIGO
                AND VF.FCF_VEICULODISP_SEQUENCIA = SF.FCF_VEICULODISP_SEQUENCIA
                AND NVL(VF.CON_VALEFRETE_STATUS,'N') <> 'C') TPMOTORISTA
      from tdvadm.t_fcf_solveic sf,
           TDVADM.V_FCF_FRETECARHIST FC,
           TDVADM.T_ARM_ARMAZEM A
      where trunc(sf.fcf_solveic_dtsoli) >= to_date('01/01/2019','DD/MM/YYYY')
        AND SF.FCF_FRETECAR_ROWID = FC.FCF_FRETECAR_ROWID (+) 
        AND SF.ARM_ARMAZEM_CODIGO = A.ARM_ARMAZEM_CODIGO
        AND SF.FCF_VEICULODISP_CODIGO IS NOT NULL
--        AND SF.FCF_VEICULODISP_CODIGO = 5518620
     ) X
WHERE 0 = 0
  AND X.VFRETE > 0 
  AND X.fcf_solveic_qtdeentregas <> ( X.entregaad )
group by x.fcf_fretecar_rowid,x.rowidvf,x.origem,x.destino
GROUP BY TO_CHAR(X.fcf_solveic_dtsoli,'YYYYMM'),X.usu_usuario_soli,X.arm_armazem_codigo,X.ARM_ARMAZEM_DESCRICAO

  SELECT VF.CON_CONHECIMENTO_CODIGO,
         VF.GLB_ROTA_CODIGO,
         VF.CON_VALEFRETE_SAQUE,
         VF.FCF_VEICULODISP_CODIGO,
         VF.FCF_VEICULODISP_SEQUENCIA,
         VF.CON_VALEFRETE_STATUS
  FROM TDVADM.T_CON_VALEFRETE VF
  WHERE VF.CON_CONHECIMENTO_CODIGO = '036739'
    AND VF.GLB_ROTA_CODIGO = '161'
  
  
  
  select * from tdvadm.t_fcf_fretecar f
  where f.fcf_fretecar_rowid >= 56664 -10
--    and f.fcf_fretecar_rowid <= 56664 +10
  order by f.fcf_fretecar_rowid
  
