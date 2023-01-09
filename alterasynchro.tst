PL/SQL Developer Test script 3.0
290
-- Created on 08/03/2018 by DESENV 
declare 
  -- Local variables here
  i integer;
  vPreponderante char(1) := 'N';
  vConta   char(12) := '441001000020';
  V_TOTAL_BASE_PIS_PASEP number;
  v_total_base_cofins    number;
  V_Total_Pis_Pasep      number;
  V_Total_Cofins         number;
  v_STA_CODIGO           char(2);
  v_STN_CODIGO           char(2);

begin

    EXECUTE IMMEDIATE 'ALTER TRIGGER SYNCHRO.COR_IDF_AIUDS DISABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER SYNCHRO.COR_DOF_AIUDS DISABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER SYNCHRO.COR_IDF_BIUDR DISABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER SYNCHRO.COR_DOF_BIUDR DISABLE';

    
    FOR R_DOFS IN (SELECT DOF.TDV_SISTEMA_ORIGEM SORG,
                          DOF.ID DOF_ID,
                          IDF.ID IDF_ID,
                          DOF.TDV_SISTEMA_ORIGEM,
                          DOF.EMITENTE_LOC_CODIGO, 
                          IDF.STA_CODIGO,
                          c.glb_mercadoria_codigo mercadoria,
                          c.glb_cliente_cgccpfsacado sacado,
                          IDF.STN_CODIGO,
                          IDF.VL_ALIQ_COFINS,
                          IDF.VL_ALIQ_PIS,
                          V.CON_CALCVIAGEM_VALOR VL_TOTAL_FATURADO,
                          P.CON_CALCVIAGEM_VALOR VL_PEDAGIO,
                          C.CON_CONHECIMENTO_DTEMBARQUE EMBARQUE
                     FROM SYNCHRO.COR_DOF DOF,
                          SYNCHRO.COR_IDF IDF,
                          tdvadm.V_CON_I_TTPV V,
                          tdvadm.V_CON_I_PD P,
                          tdvadm.t_con_conhecimento c
                    WHERE V.CON_CONHECIMENTO_CODIGO = SUBSTR(DOF.TDV_SISTEMA_ORIGEM,1,6)
                      AND V.CON_CONHECIMENTO_SERIE = SUBSTR(DOF.TDV_SISTEMA_ORIGEM,7,2)
                      AND V.GLB_ROTA_CODIGO = SUBSTR(DOF.TDV_SISTEMA_ORIGEM,9,3)
                      AND P.CON_CONHECIMENTO_CODIGO = SUBSTR(DOF.TDV_SISTEMA_ORIGEM,1,6)
                      AND P.CON_CONHECIMENTO_SERIE = SUBSTR(DOF.TDV_SISTEMA_ORIGEM,7,2)
                      AND P.GLB_ROTA_CODIGO = SUBSTR(DOF.TDV_SISTEMA_ORIGEM,9,3)
                      AND c.CON_CONHECIMENTO_CODIGO = SUBSTR(DOF.TDV_SISTEMA_ORIGEM,1,6)
                      AND c.CON_CONHECIMENTO_SERIE = SUBSTR(DOF.TDV_SISTEMA_ORIGEM,7,2)
                      AND c.GLB_ROTA_CODIGO = SUBSTR(DOF.TDV_SISTEMA_ORIGEM,9,3)
                      AND IDF.DOF_ID       = DOF.ID
                      AND IDF.dof_sequence = DOF.dof_sequence
                      AND DOF.DH_EMISSAO >=  TO_DATE('01/01/2018','DD/MM/YYYY')
                      AND DOF.DH_EMISSAO <=  to_date('31/01/2018','DD/MM/YYYY')
                      AND DOF.IND_ENTRADA_SAIDA = 'S'
                      AND DOF.SIS_CODIGO        = 'TDV'
                      and c.con_conhecimento_codigo || c.glb_rota_codigo in 
                      ('025066237',
                        '025067237',
                        '025068237',
                        '025070237',
                        '025071237',
                        '025081237',
                        '025094237',
                        '025095237',
                        '025120237',
                        '025134237',
                        '025138237',
                        '025145237',
                        '025148237',
                        '025173237',
                        '025187237',
                        '025196237',
                        '025197237',
                        '025198237',
                        '025204237',
                        '025208237',
                        '025213237',
                        '025224237',
                        '025230237',
                        '025249237',
                        '025250237',
                        '025251237',
                        '025255237',
                        '087269157',
                        '109402421',
                        '109403421',
                        '109404421',
                        '109405421',
                        '109413421',
                        '109420421',
                        '109421421',
                        '109426421',
                        '109428421',
                        '109429421',
                        '109430421',
                        '109440421',
                        '109441421',
                        '109443421',
                        '109445421',
                        '109446421',
                        '109447421',
                        '109448421',
                        '109449421',
                        '109450421',
                        '109455421',
                        '109457421',
                        '109461421',
                        '109464421',
                        '109465421',
                        '109466421',
                        '109467421',
                        '109468421',
                        '109471421',
                        '109475421',
                        '109477421',
                        '109479421',
                        '109480421',
                        '109488421',
                        '109489421',
                        '109490421',
                        '109491421',
                        '109492421',
                        '109493421',
                        '109499421',
                        '109500421',
                        '109506421',
                        '109507421',
                        '109508421',
                        '109510421',
                        '109511421',
                        '109516421',
                        '109517421',
                        '109519421',
                        '109527421',
                        '109528421',
                        '109529421',
                        '109530421',
                        '109531421',
                        '109532421',
                        '109533421',
                        '109534421',
                        '109535421',
                        '109536421',
                        '109537421',
                        '109538421',
                        '109539421',
                        '109541421',
                        '109545421',
                        '109546421',
                        '109547421',
                        '109548421',
                        '109549421',
                        '109550421',
                        '109551421',
                        '109552421',
                        '109554421',
                        '109555421',
                        '109556421',
                        '109564421',
                        '109567421',
                        '109568421',
                        '109569421',
                        '109570421',
                        '109571421',
                        '109572421',
                        '109573421',
                        '109574421',
                        '109575421',
                        '109582421',
                        '109583421',
                        '109584421',
                        '109585421',
                        '109586421',
                        '109588421',
                        '109593421',
                        '109595421',
                        '109596421',
                        '109599421',
                        '109600421',
                        '109601421',
                        '109602421',
                        '109603421',
                        '109604421',
                        '109605421',
                        '109609421',
                        '109613421',
                        '109617421',
                        '109622421',
                        '109623421',
                        '109625421',
                        '109626421',
                        '109627421',
                        '109628421',
                        '109629421',
                        '109630421',
                        '109632421',
                        '109633421',
                        '109634421',
                        '109635421',
                        '109636421',
                        '109639421',
                        '109651421',
                        '109652421',
                        '109653421',
                        '109656421',
                        '109657421',
                        '109658421',
                        '109659421',
                        '109660421',
                        '109661421',
                        '109662421',
                        '109663421',
                        '109664421',
                        '109665421',
                        '109666421',
                        '109667421',
                        '109668421',
                        '109669421',
                        '109670421',
                        '109671421',
                        '109672421',
                        '109673421',
                        '109675421',
                        '109682421',
                        '109683421',
                        '109687421',
                        '109688421',
                        '109689421',
                        '109696421',
                        '109697421',
                        '109698421',
                        '109699421')


                  )
      
    LOOP
   
      IF vPreponderante = 'S' THEN
        V_TOTAL_BASE_PIS_PASEP := 0;
        v_total_base_cofins    := 0;
        V_Total_Pis_Pasep      := 0;
        V_Total_Cofins         := 0;
        v_STA_CODIGO           := '09';
        v_STN_CODIGO           := '09';
      ELSE
        V_TOTAL_BASE_PIS_PASEP := R_DOFS.VL_TOTAL_FATURADO - R_DOFS.Vl_Pedagio;
        v_total_base_cofins    := R_DOFS.VL_TOTAL_FATURADO - R_DOFS.Vl_Pedagio;
        V_Total_Pis_Pasep      := V_TOTAL_BASE_PIS_PASEP * ( 1.65 / 100 );
        V_Total_Cofins         := v_total_base_cofins * ( 7.6  / 100 );
        v_STA_CODIGO           := '01';
        v_STN_CODIGO           := '01';
      END IF;

        UPDATE SYNCHRO.COR_DOF DOF
           SET dof.VL_TOTAL_BASE_PIS_PASEP = V_TOTAL_BASE_PIS_PASEP,
               dof.vl_total_base_cofins    = v_total_base_cofins,
               dof.Vl_Total_Pis_Pasep      = V_Total_Pis_Pasep,
               dof.Vl_Total_Cofins         = Vl_Total_Cofins,
               dof.CONTA_CONTABIL          = vConta
         WHERE DOF.ID = R_DOFS.DOF_ID;

        UPDATE SYNCHRO.COR_IDF IDF
          SET idf.sta_codigo         = v_STA_CODIGO,
              idf.stn_codigo         = v_STN_CODIGO,
              idf.VL_ALIQ_PIS        = 1.65,
              idf.VL_BASE_PIS        = V_TOTAL_BASE_PIS_PASEP,
              idf.VL_BASE_COFINS     = v_total_base_cofins,
              idf.VL_IMPOSTO_PIS     = V_TOTAL_BASE_PIS_PASEP * ( 1.65 / 100 ),
              idf.VL_IMPOSTO_COFINS  = v_total_base_cofins * ( 7.6  / 100 ),
              idf.VL_PIS             = 0,
              idf.VL_COFINS          = 0,
              idf.VL_ALIQ_COFINS     = 7.6,
              idf.conta_contabil     = vConta
        WHERE IDF.ID = R_DOFS.IDF_ID;
        

        
                     
      END LOOP;  

    EXECUTE IMMEDIATE 'ALTER TRIGGER SYNCHRO.COR_IDF_AIUDS enable';
    EXECUTE IMMEDIATE 'ALTER TRIGGER SYNCHRO.COR_DOF_AIUDS enable';
    EXECUTE IMMEDIATE 'ALTER TRIGGER SYNCHRO.COR_IDF_BIUDR enable';
    EXECUTE IMMEDIATE 'ALTER TRIGGER SYNCHRO.COR_DOF_BIUDR enable';

    
    COMMIT;
  
end;
0
0
