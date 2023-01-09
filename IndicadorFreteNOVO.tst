PL/SQL Developer Test script 3.0
171
--Procedure sp_criaIndicadores(pReferencia in char,
--                             pStatus out char,
--                             pMessage out varchar2)
--  As
declare 
    pReferencia char(6) := '202101';
    pStatus     char(1) := 'N';
    pMessage   varchar2(1000) := '';
    vAuxiliar integer;
    type tpCurosr is REF CURSOR;
    vCursor         tpCurosr;
    vipf_reccust_referencia     tdvipf.v_ipf_reccust.ipf_reccust_referencia%type;
    vipf_valefrete_centrocusto  tdvipf.v_ipf_reccust.ipf_valefrete_centrocusto%type;
    vipf_conhec_cccontrato      tdvipf.v_ipf_reccust.ipf_conhec_cccontrato%type;  
  Begin
    
     tdvipf.pkg_reccust_diretos2019 .set_processo(tdvipf.pkg_reccust_diretos2019.cIndicadoresFrete,'P',pReferencia);

      select count(*)
         into vAuxiliar
      from TDVIPF.V_IPF_RECCUST R1
      where r1.ipf_reccust_referencia = pReferencia;
      If vAuxiliar = 0 Then
         pStatus := 'E';
         pMessage := 'Rateio das Receitas e Despesas da Referecia ' || pReferencia || ' não gerado!';
         return;
      End If;

    delete tdvipf.t_ipf_indicadoresc x
    where x.IPF_RECCUST_REFERENCIA = pReferencia;
   

    insert into tdvipf.t_ipf_indicadoresc x
     (IPF_RECCUST_REFERENCIA,
      IPF_VALEFRETE_CENTROCUSTO,
      IPF_CONHEC_CCCONTRATO,
      IPF_INDICADORES_QTDECTECHAVE,
      IPF_INDICADORES_QTDEVFCHAVE,
      RATCTFRETEPESOCHAVE,
      RATVFFRETESPCHAVE,
      RATCTFRETEPESOFROTACHAVE,
      RATVFFRETESPFROTACHAVE,
      RATCTFRETEPESONFROTACHAVE,
      RATVFFRETESPNFROTACHAVE)
     SELECT R.IPF_RECCUST_REFERENCIA                                     IPF_RECCUST_REFERENCIA,
            R.IPF_VALEFRETE_CENTROCUSTO                                  IPF_VALEFRETE_CENTROCUSTO,
            R.IPF_CONHEC_CCCONTRATO                                      IPF_CONHEC_CCCONTRATO,
            COUNT(DISTINCT R.IPF_CONHEC_CHAVE)                           IPF_INDICADORES_QTDECTECHAVE,
            COUNT(DISTINCT SUBSTR(R.IPF_VALEFRETE_CHAVE,1,11))           IPF_INDICADORES_QTDEVFCHAVE,
            SUM(R.RATCTFRETEPESO)                                        RATCTFRETEPESOCHAVE,
            SUM(R.RATVFFRETESP)                                          RATVFFRETESPCHAVE,
            SUM(decode(R.GLB_TPMOTORISTA_CODIGO,'F',R.RATCTFRETEPESO,0)) RATCTFRETEPESOFROTACHAVE,
            SUM(decode(R.GLB_TPMOTORISTA_CODIGO,'F',R.RATVFFRETESP,0))   RATVFFRETESPFROTACHAVE,
            SUM(decode(R.GLB_TPMOTORISTA_CODIGO,'F',0,R.RATCTFRETEPESO)) RATCTFRETEPESONFROTACHAVE,
            SUM(decode(R.GLB_TPMOTORISTA_CODIGO,'F',0,R.RATVFFRETESP))   RATVFFRETESPNFROTACHAVE
     FROM TDVIPF.V_IPF_RECCUST R
     WHERE 0 = 0
       AND R.IPF_RECCUST_REFERENCIA = pReferencia
       AND R.IPF_VALEFRETE_CAIXA IS NOT NULL
     GROUP BY R.IPF_RECCUST_REFERENCIA,
              R.IPF_VALEFRETE_CENTROCUSTO,
              R.IPF_CONHEC_CCCONTRATO;


    for C_msg in (SELECT R.IPF_RECCUST_REFERENCIA,
                         R.IPF_VALEFRETE_CENTROCUSTO,
                         COUNT(DISTINCT R.IPF_CONHEC_CHAVE)                           IPF_INDICADORES_QTDECTECCTOT,
                         COUNT(DISTINCT SUBSTR(R.IPF_VALEFRETE_CHAVE,1,11))           IPF_INDICADORES_QTDEVFCCTOT,
                         SUM(R.RATCTFRETEPESO)                                        RATCTFRETEPESOCCTOT,
                         SUM(R.RATVFFRETESP)                                          RATVFFRETESPCCTOT,
                         SUM(decode(R.GLB_TPMOTORISTA_CODIGO,'F',R.RATCTFRETEPESO,0)) RATCTFRETEPESOCCFROTATOT,
                         SUM(decode(R.GLB_TPMOTORISTA_CODIGO,'F',R.RATVFFRETESP,0))   RATVFFRETESPCCFROTATOT,
                         SUM(decode(R.GLB_TPMOTORISTA_CODIGO,'F',0,R.RATCTFRETEPESO)) RATCTFRETEPESOCCNFROTATOT,
                         SUM(decode(R.GLB_TPMOTORISTA_CODIGO,'F',0,R.RATVFFRETESP))   RATVFFRETESPCCNFROTATOT
                  FROM TDVIPF.V_IPF_RECCUST R
                  WHERE 0 = 0
                    AND R.IPF_RECCUST_REFERENCIA = pReferencia
                    AND R.ipf_valefrete_caixa IS NOT NULL
                   group by R.IPF_RECCUST_REFERENCIA,
                           R.IPF_VALEFRETE_CENTROCUSTO)
   Loop 
    /* REFERENCIA CENTRO DE CUSTO */
       update tdvipf.t_ipf_indicadoresc x
         set IPF_INDICADORES_QTDECTECCTOT = c_msg.IPF_INDICADORES_QTDECTECCTOT,
             IPF_INDICADORES_QTDEVFCCTOT  = c_msg.IPF_INDICADORES_QTDEVFCCTOT,
             RATCTFRETEPESOCCTOT          = c_msg.RATCTFRETEPESOCCTOT,
             RATVFFRETESPCCTOT            = c_msg.RATVFFRETESPCCTOT,
             RATCTFRETEPESOCCFROTATOT     = c_msg.RATCTFRETEPESOCCFROTATOT,
             RATVFFRETESPCCFROTATOT       = c_msg.RATVFFRETESPCCFROTATOT,
             RATCTFRETEPESOCCNFROTATOT    = c_msg.RATCTFRETEPESOCCNFROTATOT,
             RATVFFRETESPCCNFROTATOT      = c_msg.RATVFFRETESPCCNFROTATOT 
       where x.IPF_RECCUST_REFERENCIA = c_msg.ipf_reccust_referencia
         and x.IPF_VALEFRETE_CENTROCUSTO = c_msg.ipf_valefrete_centrocusto;
       
   End Loop;
   commit;
   
   
   for C_msg in (SELECT R.IPF_RECCUST_REFERENCIA,
                        R.IPF_CONHEC_CCCONTRATO,
                        COUNT(DISTINCT R.IPF_CONHEC_CHAVE)                           IPF_INDICADORES_QTDECTECONTRATOTOT,
                        COUNT(DISTINCT SUBSTR(R.IPF_VALEFRETE_CHAVE,1,11))           IPF_INDICADORES_QTDEVFCONTRATOTOT,
                        SUM(R.RATCTFRETEPESO)                                        RATCTFRETEPESOCONTRATOTOT,
                        SUM(R.RATVFFRETESP)                                          RATVFFRETESPCONTRATOTOT,
                        SUM(decode(R.GLB_TPMOTORISTA_CODIGO,'F',R.RATCTFRETEPESO,0)) RATCTFRETEPESOCONTRATOFROTATOT,
                        SUM(decode(R.GLB_TPMOTORISTA_CODIGO,'F',R.RATVFFRETESP,0))   RATVFFRETESPCONTRATOFROTATOT,
                        SUM(decode(R.GLB_TPMOTORISTA_CODIGO,'F',0,R.RATCTFRETEPESO)) RATCTFRETEPESOCONTRATONFROTATOT,
                        SUM(decode(R.GLB_TPMOTORISTA_CODIGO,'F',0,R.RATVFFRETESP))   RATVFFRETESPCONTRATONFROTATOT
                 FROM TDVIPF.V_IPF_RECCUST R
                 WHERE 0 = 0
                   AND R.IPF_RECCUST_REFERENCIA = pReferencia
                   AND R.ipf_valefrete_caixa IS NOT NULL
                 group by R.IPF_RECCUST_REFERENCIA,
                          R.IPF_CONHEC_CCCONTRATO)
    Loop  

    /* REFERENCIA CONTRATO */
       update tdvipf.t_ipf_indicadoresc x
         set IPF_INDICADORES_QTDECTECONTRATOTOT = c_msg.IPF_INDICADORES_QTDECTECONTRATOTOT,
             IPF_INDICADORES_QTDEVFCONTRATOTOT  = c_msg.IPF_INDICADORES_QTDEVFCONTRATOTOT,
             RATCTFRETEPESOCONTRATOTOT          = c_msg.RATCTFRETEPESOCONTRATOTOT,
             RATVFFRETESPCONTRATOTOT            = c_msg.RATVFFRETESPCONTRATOTOT,
             RATCTFRETEPESOCONTRATOFROTATOT     = c_msg.RATCTFRETEPESOCONTRATOFROTATOT,
             RATVFFRETESPCONTRATOFROTATOT       = c_msg.RATVFFRETESPCONTRATOFROTATOT,
             RATCTFRETEPESOCONTRATONFROTATOT    = c_msg.RATCTFRETEPESOCONTRATONFROTATOT,
             RATVFFRETESPCONTRATONFROTATOT      = c_msg.RATVFFRETESPCONTRATONFROTATOT
       where x.IPF_RECCUST_REFERENCIA = c_msg.ipf_reccust_referencia
         and x.IPF_CONHEC_CCCONTRATO = c_msg.ipf_conhec_cccontrato;
       
   End Loop;
   commit;
      
   For c_msg in (SELECT R.IPF_RECCUST_REFERENCIA,
                        COUNT(DISTINCT R.IPF_CONHEC_CHAVE)                           IPF_INDICADORES_QTDECTETOT,
                        COUNT(DISTINCT SUBSTR(R.IPF_VALEFRETE_CHAVE,1,11))           IPF_INDICADORES_QTDEVFTOT,
                        SUM(R.RATCTFRETEPESO)                                        RATCTFRETEPESOTOT,
                        SUM(R.RATVFFRETESP)                                          RATVFFRETESPTOT,
                        SUM(decode(R.GLB_TPMOTORISTA_CODIGO,'F',R.RATCTFRETEPESO,0)) RATCTFRETEPESOFROTATOT,
                        SUM(decode(R.GLB_TPMOTORISTA_CODIGO,'F',R.RATVFFRETESP,0))   RATVFFRETESPFROTATOT,
                        SUM(decode(R.GLB_TPMOTORISTA_CODIGO,'F',0,R.RATCTFRETEPESO)) RATCTFRETEPESONFROTATOT,
                        SUM(decode(R.GLB_TPMOTORISTA_CODIGO,'F',0,R.RATVFFRETESP))   RATVFFRETESPNFROTATOT
                        FROM TDVIPF.V_IPF_RECCUST R
                        WHERE 0 = 0
                          AND R.IPF_RECCUST_REFERENCIA = x.ipf_reccust_referencia                            
                          AND R.ipf_valefrete_caixa IS NOT NULL
                        group by R.IPF_RECCUST_REFERENCIA)     
    Loop                       
                                            
    /* REFERENCIA */
       update tdvipf.t_ipf_indicadoresc x
         set IPF_INDICADORES_QTDECTETOT = c_msg.IPF_INDICADORES_QTDECTETOT,
             IPF_INDICADORES_QTDEVFTOT  = c_msg.IPF_INDICADORES_QTDEVFTOT,
             RATCTFRETEPESOTOT          = c_msg.RATCTFRETEPESOTOT,
             RATVFFRETESPTOT            = c_msg.RATVFFRETESPTOT,
             RATCTFRETEPESOFROTATOT     = c_msg.RATCTFRETEPESOFROTATOT,
             RATVFFRETESPFROTATOT       = c_msg.RATVFFRETESPFROTATOT,
             RATCTFRETEPESONFROTATOT    = c_msg.RATCTFRETEPESONFROTATOT,
             RATVFFRETESPNFROTATOT      = c_msg.RATVFFRETESPNFROTATOT
       where x.IPF_RECCUST_REFERENCIA = c_msg.ipf_reccust_referencia;
   End Loop;
   commit;
                                    

    tdvipf.pkg_reccust_diretos2019.set_processo(tdvipf.pkg_reccust_diretos2019.cIndicadoresFrete,'S',pReferencia);
    commit;
exception
  When OTHERS THEN
     tdvipf.pkg_reccust_diretos2019.set_processo(tdvipf.pkg_reccust_diretos2019.cIndicadoresFrete,'S',pReferencia,sqlerrm); commit;
  

  End ;
0
0
