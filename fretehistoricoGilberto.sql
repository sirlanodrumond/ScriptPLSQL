
SELECT 
--       X.codorig,
--       X.coddest,
--       X.codveic,
       X.origem,
       X.destino,
       X.veiculo,
       x.datacad,
       X.usucad,
       X.vigencia,
       X.valor,
       (SELECT DISTINCT X1.usucad
        FROM TDVADM.V_FCF_FRETECARHIST X1
        WHERE X1.codorig = X.codorig
          AND X1.coddest = X.coddest
          AND X1.codveic = X.codveic
          AND X1.datacad = (SELECT MAX(X2.datacad)
                             FROM TDVADM.V_FCF_FRETECARHIST X2
                             WHERE X2.codorig = X1.codorig
                               AND X2.coddest = X1.coddest
                               AND X2.codveic = X1.codveic
                               AND X2.datacad < X.datacad)) USUANT1,
       (SELECT DISTINCT X1.vigencia
        FROM TDVADM.V_FCF_FRETECARHIST X1
        WHERE X1.codorig = X.codorig
          AND X1.coddest = X.coddest
          AND X1.codveic = X.codveic
          AND X1.datacad = (SELECT MAX(X2.datacad)
                             FROM TDVADM.V_FCF_FRETECARHIST X2
                             WHERE X2.codorig = X1.codorig
                               AND X2.coddest = X1.coddest
                               AND X2.codveic = X1.codveic
                               AND X2.datacad < X.datacad)) VIGENCIAANT1
       ,(SELECT DISTINCT X1.valor
        FROM TDVADM.V_FCF_FRETECARHIST X1
        WHERE X1.codorig = X.codorig
          AND X1.coddest = X.coddest
          AND X1.codveic = X.codveic
          AND X1.datacad = (SELECT MAX(X2.datacad)
                             FROM TDVADM.V_FCF_FRETECARHIST X2
                             WHERE X2.codorig = X1.codorig
                               AND X2.coddest = X1.coddest
                               AND X2.codveic = X1.codveic
                               AND X2.datacad < X.datacad)) VLRANT1,
       (SELECT max(X1.usucad)
        FROM TDVADM.V_FCF_FRETECARHIST X1
        WHERE X1.codorig = X.codorig
          AND X1.coddest = X.coddest
          AND X1.codveic = X.codveic
          AND X1.datacad < (SELECT MAX(X2.datacad)
                             FROM TDVADM.V_FCF_FRETECARHIST X2
                             WHERE X2.codorig = X1.codorig
                               AND X2.coddest = X1.coddest
                               AND X2.codveic = X1.codveic
                               AND X2.datacad < X.datacad)) USUANT2,
       (SELECT max(X1.vigencia)
        FROM TDVADM.V_FCF_FRETECARHIST X1
        WHERE X1.codorig = X.codorig
          AND X1.coddest = X.coddest
          AND X1.codveic = X.codveic
          AND X1.datacad < (SELECT MAX(X2.datacad)
                             FROM TDVADM.V_FCF_FRETECARHIST X2
                             WHERE X2.codorig = X1.codorig
                               AND X2.coddest = X1.coddest
                               AND X2.codveic = X1.codveic
                               AND X2.datacad < X.datacad)) VIGENCIAANT2,
       (SELECT max(X1.valor)
        FROM TDVADM.V_FCF_FRETECARHIST X1
        WHERE X1.codorig = X.codorig
          AND X1.coddest = X.coddest
          AND X1.codveic = X.codveic
          AND X1.datacad < (SELECT MAX(X2.datacad)
                             FROM TDVADM.V_FCF_FRETECARHIST X2
                             WHERE X2.codorig = X1.codorig
                               AND X2.coddest = X1.coddest
                               AND X2.codveic = X1.codveic
                               AND X2.datacad < X.datacad)) VLRANT2



FROM TDVADM.V_FCF_FRETECARHIST X
WHERE X.vigencia >= '01/06/2017'
ORDER BY X.codorig,X.coddest,X.codveic,X.vigencia

