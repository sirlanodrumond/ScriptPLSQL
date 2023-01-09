select * from TDVADM.V_SLF_TABELANOVACARGA t
;



select *
from tdvadm.t_arm_nota a
where 0 = 0
  and a.arm_janelacons_sequencia = 1045896
--  and a.con_conhecimento_codigo = '097820'
--  and a.glb_rota_codigo = '011'
;
select *
from tdvadm.t_arm_janelacons j
where j.arm_janelacons_sequencia = 1045896
;
select *
from tdvadm.v_slf_tpagrupa a
where a.COD = '02'
;
SELECT VC.jancodigo,
       VC.carreg,
       VC.cte,
       VC.serie, 
       VC.nota, 
       VC.contrato,
       VC.remet,
       VC.locibgeco,
       VC.locibgeent,
       VC.entcol,
       VC.CargaCol,
       VC.fechacoleta,
       VC.DTINCLUSAO,
       VC.janinicio,
       VC.janfim,
       VC.janqtdenf,
       VC.janpesocons,
       VC.*
FROM TDVADM.V_ARM_VERIFCARREG VC
WHERE VC.jancodigo = 1045918 -- 1045896
;

SELECT VC.jancodigo,
       VC.carreg,
       VC.cte,
       VC.serie, 
       VC.nota, 
       VC.contrato,
       VC.remet,
       VC.locibgeco,
       VC.locibgeent,
       VC.entcol,
       VC.CargaCol,
       VC.fechacoleta,
       VC.DTINCLUSAO,
       VC.janinicio,
       VC.janfim,
       VC.janqtdenf,
       VC.janpesocons,
       VC.*
FROM TDVADM.V_ARM_VERIFCARREG VC
WHERE VC.cte IN ('097491','097492','097493','097819','097820','097825','097824')
  AND VC.rota = '011';
  
SELECT *
FROM TDVADM.T_ARM_JANELACONS JC
WHERE JC.ARM_JANELACONS_SEQUENCIA IN (1045918,1045896)
  
;





SELECT DISTINCT CA.CON_CONHECIMENTO_CODIGO,CA.GLB_ROTA_CODIGO,CA.SLF_TPCALCULO_CODIGO
FROM TDVADM.T_CON_CALCCONHECIMENTO CA
WHERE CA.CON_CONHECIMENTO_CODIGO || CA.GLB_ROTA_CODIGO IN ('003429183','149232185','002112166','031266161')


SELECT DISTINCT S.OWNER || '.' ||S.NAME
FROM DBA_SOURCE S
WHERE S.TEXT LIKE '%''041''%'
  AND S.NAME NOT IN ('OBR_SPEDF_BLOCO_D',
                     'SP_ATUALIZAFRETE_VALEOFICIAL2',
                     'SP_ATUALIZAFRETE_VALEOFICIAL',
                     'SP_ATUALIZAFRETE_VALE',
                     'OBR_ARQMAG_DNF20',
                     'SP_ATUALIZABALRESUMO',
                     'SP_ATUALIZAFRETE_VALE2',
                     'PKG_FIFO_CARREGCTRC_TMP',
                     'FN_RJR_RETAREA')
                     

Contrato fracionado exemplos 3429-183/149232-185 
Contrato Lotação exemplos 2112-166/31266-161


SELECT *
FROM TDVADM.T_SLF_TPCALCULO T
WHERE T.SLF_TPCALCULO_CALCULOMAE = 'S']]]]










DELETE TDVADM.T_SLF_CALCFRETEKM KM
SELECT *
FROM TDVADM.T_SLF_CALCFRETEKM KM
WHERE (KM.SLF_TABELA_CODIGO,
       KM.SLF_TABELA_SAQUE) IN (select T.SLF_TABELA_CODIGO,
                                       T.SLF_TABELA_SAQUE
                                from tdvadm.t_slf_tabela t
                                where (t.slf_tabela_tipo,
                                       t.slf_tabela_contrato,
                                       t.glb_grupoeconomico_codigo,
                                       t.glb_cliente_cgccpfcodigo,
                                       t.fcf_tpcarga_codigo,
                                       t.fcf_tpveiculo_codigo,
                                       t.slf_tabela_coletaentrega) in (select distinct decode(trim(cv.TIPOTAB),'AMB',t.slf_tabela_tipo,cv.TIPOTAB),
                                                                              cv.CONTRATO,
                                                                              lpad(cv.GRUPO,4,'0'),
                                                                              rpad(cv.CLIENTE,20), 
                                                                              RPAD(cv.CODCARGA,3),
                                                                              rpAd(cv.CODVEICULO,3),
                                                                              substr(cv.COLENT,1,1)
                                                                       from tdvadm.v_slf_calcfretekmpreimpcsv cv
                                                                       where cv.ROW_NR > 1))
  AND (KM.SLF_CALCFRETEKM_PESODE,
       KM.SLF_CALCFRETEKM_PESOATE,
       KM.SLF_CALCFRETEKM_KMDE,
       KM.SLF_CALCFRETEKM_KMATE,
       KM.SLF_CALCFRETEKM_ORIGEMI,
       KM.SLF_CALCFRETEKM_DESTINOI,
       KM.SLF_RECCUST_CODIGO) IN (select cv.PESODE,
                                         cv.PESOATE,
                                         cv.KMDE,;~;´89
                                         cv.KMATE,
                                         RPAD(cv.ORIGEM,8),
                                         RPAD(cv.DESTINO,8),
                                         RPAD(cv.CODVERBA,10)
                                  from tdvadm.v_slf_calcfretekmpreimpcsv cv
                                  WHERE CV.ROW_NR > 1);
COMMIT;



select * from tdvadm.t_arm_coletareimp;
  

