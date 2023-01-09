
SELECT CA.CON_CONHECIMENTO_DTEMBARQUE DATA,
       CA.CON_CONHECIMENTO_CODIGO CTE,
       CA.CON_CONHECIMENTO_SERIE SR,
       CA.GLB_ROTA_CODIGO RT,
       CA.SLF_RECCUST_CODIGO VERBA,
       CA.SLF_TPCALCULO_CODIGO CALCULO,
       CA.CON_CALCVIAGEM_VALOR VALOR
FROM TDVADM.T_CON_CALCCONHECIMENTO CA
WHERE CA.CON_CONHECIMENTO_DTEMBARQUE >= SYSDATE - 10
  AND CA.SLF_TPCALCULO_CODIGO IN ('115','316','320')
  AND CA.SLF_RECCUST_CODIGO = 'I_PD'
  AND CA.CON_CALCVIAGEM_VALOR <> 0;

SELECT C.CON_CONHECIMENTO_DTEMBARQUE DATA,
       C.CON_CONHECIMENTO_CODIGO CTE,
       C.CON_CONHECIMENTO_SERIE SR,
       C.GLB_ROTA_CODIGO RT
FROM TDVADM.T_CON_CONHECIMENTO C
WHERE C.CON_CONHECIMENTO_DTEMBARQUE >= SYSDATE - 10
  AND NVL(C.CON_CONHECIMENTO_FLAGCANCELADO,'N') = 'S'
  AND 0 < (SELECT COUNT(*)
           FROM TDVADM.T_CON_CALCCONHECIMENTO CA
           WHERE CA.CON_CONHECIMENTO_CODIGO = C.CON_CONHECIMENTO_CODIGO
             AND CA.CON_CONHECIMENTO_SERIE = C.CON_CONHECIMENTO_SERIE
             AND CA.GLB_ROTA_CODIGO = C.GLB_ROTA_CODIGO
             AND CA.SLF_RECCUST_CODIGO = 'I_TTPV'
             AND CA.CON_CALCVIAGEM_VALOR <> 0)


