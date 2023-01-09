select t.*
from tdvadm.t_cpg_chequebanco t 
where 0 = 0
--  and t.cpg_chequebanco_numero = 5176;
  and t.cpg_chequebanco_numero = 5090;


select t.*
from tdvadm.t_cpg_chequebancoparcela t
where 0 = 0
--  and t.cpg_chequebanco_numero = 5176
  and t.cpg_chequebanco_numero = 5090
;


select t.*
from tdvadm.t_cpg_tituloevento t
where 0 = 0
  and t.glb_tpdoc_codigo = 'CHQ'
  and t.cpg_tituloevento_nrodoc  = 5176
  and t.cpg_tituloevento_nrodoc  = 5190
;


select t.*
from tdvadm.t_cpg_titulos t 
where t.cpg_titulos_numtit = 8581363 and t.glb_fornecedor_cgccpf = '17309790000194';


select t.*
from tdvadm.t_cpg_titparcelas t
where t.cpg_titulos_numtit = 8581363 and t.glb_fornecedor_cgccpf = '17309790000194';



tdvadm.TG_CLC_DELLINKCHEQUE;
   tdvadm.SP_CLC_EXCLUI('001',
                        V_ROTA,
                        :OLD.CPG_CHEQUEBANCO_NUMERO,
                        :OLD.GLB_BANCO_NUMERO,
                        :OLD.GLB_AGENCIA_NUMERO,
                        (SUBSTR(:OLD.CPG_CHEQUEBANCO_CONTA, 5, 5) ||
                        SUBSTR(:OLD.CPG_CHEQUEBANCO_CONTA, 10, 2)));
    EXCLUI A TDVADM.T_GLB_CONCILIACAO

tdvadm.TG_CLC_LINKCHEQUE
   TDVADM.SP_CLC_INSERE(V_ROTA,
                        TRIM(:NEW.glb_banco_numero),
                        TRIM(:NEW.glb_agencia_numero),
                        (SUBSTR(:NEW.CPG_CHEQUEBANCO_CONTA, 5, 5) ||
                        SUBSTR(:NEW.CPG_CHEQUEBANCO_CONTA, 10, 2)),
                        :NEW.CPG_CHEQUEBANCO_NUMERO,
                        :NEW.CPG_CHEQUEBANCO_PAGAMENTO,
                        :NEW.CPG_CHEQUEBANCO_VALOR,
                        '001',
                        :NEW.USU_USUARIO_CODIGO,
                        '101');
    INCLUI A TDVADM.T_GLB_CONCILIACAO


tdvadm.TG_CPG_CHEQUEBANCO
   -- APAGA O TDVADM.T_CPG_CHEQUEBANCOPARCELA


mudar emcheque tvadm.t_cpg_titulos;

Mudar o pagto final tdvadm.t_cpg_titparcelas;

Mudar o Situacao em tvadm.t_cpg_titulos,
                    tdvadm.t_cpg_titparcelas;

0000	ABERTO
0001	PARCIALMENTE ABERTO
0002	FECHADO
0003	TITULO COM JUROS
BORD	BORDERO EMITIDO



Mudar o Saldo em tvadm.t_cpg_titulos;
                 tdvadm.t_cpg_titparcelas
                 tdvadm.t_cpg_tituloevento


SELECT T.CPG_TITULOS_DTEMISSAO,
       T.CPG_TITULOS_NUMTIT,
       T.GLB_FORNECEDOR_CGCCPF,
       T.CPG_SITUACAO_CODIGO,
       S.CPG_SITUACAO_DESCRICAO,
       T.CPG_TITULOS_PREVISAO,
       T.CPG_TITULOS_EMCHEQUE,
       T.CPG_TITULOS_NUMPARC,
       T.CPG_TITULOS_VLTOTAL,
       T.CPG_TITULOS_SALDOATUAL,
       T.CPG_TITULOS_VLRPARC,
       (SELECT SUM(EV.CPG_TITULOEVENTO_VALOR)
        FROM tdvadm.t_cpg_tituloevento EV
        WHERE EV.CPG_TITULOS_NUMTIT = T.CPG_TITULOS_NUMTIT
          AND EV.GLB_FORNECEDOR_CGCCPF = T.GLB_FORNECEDOR_CGCCPF) VALOREVENTOS,
       (SELECT SUM(IP.CPG_TITULOIMPOSTOSVALOR)
        FROM tdvadm.t_cpg_tituloimpostos IP
        WHERE IP.CPG_TITULOS_NUMTIT = T.CPG_TITULOS_NUMTIT
          AND IP.GLB_FORNECEDOR_CGCCPF = T.GLB_FORNECEDOR_CGCCPF) VALORimp,
       (SELECT COUNT(*)
        FROM TDVADM.T_CPG_TITPARCELAS TP
        WHERE TP.CPG_TITULOS_NUMTIT = T.CPG_TITULOS_NUMTIT
          AND TP.GLB_FORNECEDOR_CGCCPF = T.GLB_FORNECEDOR_CGCCPF) QTDPARC,
       (SELECT COUNT(*)
        FROM tdvadm.t_cpg_tituloevento EV
        WHERE EV.CPG_TITULOS_NUMTIT = T.CPG_TITULOS_NUMTIT
          AND EV.GLB_FORNECEDOR_CGCCPF = T.GLB_FORNECEDOR_CGCCPF
          AND EV.GLB_TPDOC_CODIGO <> 'CHQ') QTDEVENTOSBOR,
       (SELECT COUNT(*)
        FROM tdvadm.t_cpg_tituloevento EV
        WHERE EV.CPG_TITULOS_NUMTIT = T.CPG_TITULOS_NUMTIT
          AND EV.GLB_FORNECEDOR_CGCCPF = T.GLB_FORNECEDOR_CGCCPF
          AND EV.GLB_TPDOC_CODIGO = 'CHQ') QTDEVENTOSCHQ,
       (SELECT COUNT(*)
        FROM tdvadm.t_cpg_chequebancoparcela TP
        WHERE TP.CPG_TITULOS_NUMTIT = T.CPG_TITULOS_NUMTIT
          AND TP.GLB_FORNECEDOR_CGCCPF = T.GLB_FORNECEDOR_CGCCPF) QTDcbp
/*       (SELECT COUNT(*)
        FROM tdvadm.t_cpg_chequebanco TP
        WHERE TP.CPG_TITULOS_NUMTIT = T.CPG_TITULOS_NUMTIT
          AND TP.GLB_FORNECEDOR_CGCCPF = T.GLB_FORNECEDOR_CGCCPF) QTDcb
*/FROM TDVADM.T_CPG_TITULOS T,
     TDVADM.T_CPG_SITUACAO S
WHERE T.CPG_SITUACAO_CODIGO = S.CPG_SITUACAO_CODIGO
  AND TRUNC(T.CPG_TITULOS_DTEMISSAO) >= TO_DATE('01/01/2017','DD/MM/YYYY')
  AND t.cpg_titulos_numtit = 8581363
  
