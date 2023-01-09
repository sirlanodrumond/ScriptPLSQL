SELECT (trunc(sysdate) - trunc(s.fcf_veiculodisp_data))QtdDias,                              
       S.*,                                                                                  
       decode((select count(*)                                                               
                from tdvadm.t_arm_carregamento ca                                                   
               where ca.fcf_veiculodisp_codigo = s.fcf_veiculodisp_codigo                    
                 and ca.fcf_veiculodisp_sequencia =                                          
                     s.fcf_veiculodisp_sequencia),                                           
              0,                                                                             
              'Vazio',                                                                     
              'Carreg.') Veic,                                                             
       T.FCF_TPVEICULO_DESCRICAO,                                                            
       T.FCF_TPVEICULO_LOTACAO,                                                              
       tdvadm.FN_BUSCA_PLACAVEICULO(S.FCF_VEICULODISP_CODIGO,                                       
                             S.FCF_VEICULODISP_SEQUENCIA) PLACA,                             
       tdvadm.FN_BUSCA_MOTORISTAVEICULO(S.FCF_VEICULODISP_CODIGO,                                   
                                 S.FCF_VEICULODISP_SEQUENCIA) MOTORISTA,                     
       (SELECT NVL(SUM(CA.ARM_CARREGAMENTO_PESOCOBRADO), NULL)                               
          FROM tdvadm.T_ARM_CARREGAMENTO CA                                                         
         WHERE CA.FCF_VEICULODISP_CODIGO = S.FCF_VEICULODISP_CODIGO                          
           AND CA.FCF_VEICULODISP_SEQUENCIA = S.FCF_VEICULODISP_SEQUENCIA) PESOCOBRADO,      
       (SELECT NVL(SUM(CA.ARM_CARREGAMENTO_PESOCUBADO), NULL)                                
          FROM tdvadm.T_ARM_CARREGAMENTO CA                                                         
         WHERE CA.FCF_VEICULODISP_CODIGO = S.FCF_VEICULODISP_CODIGO                          
           AND CA.FCF_VEICULODISP_SEQUENCIA = S.FCF_VEICULODISP_SEQUENCIA) PESOCUBADO,       
       (SELECT NVL(SUM(CA.ARM_CARREGAMENTO_PESOBALANCA), NULL)                               
          FROM tdvadm.T_ARM_CARREGAMENTO CA                                                         
         WHERE CA.FCF_VEICULODISP_CODIGO = S.FCF_VEICULODISP_CODIGO                          
                AND CA.FCF_VEICULODISP_SEQUENCIA = S.FCF_VEICULODISP_SEQUENCIA) PESOBALANCA, 
            (SELECT NVL(SUM(CA.ARM_CARREGAMENTO_PESOREAL), NULL)                             
               FROM tdvadm.T_ARM_CARREGAMENTO CA                                                    
              WHERE CA.FCF_VEICULODISP_CODIGO = S.FCF_VEICULODISP_CODIGO                     
                AND CA.FCF_VEICULODISP_SEQUENCIA = S.FCF_VEICULODISP_SEQUENCIA) PESOREAL,    
       tdvadm.FN_FCF_GETDESTINOVEIC(S.FCF_VEICULODISP_CODIGO,                                       
                             S.FCF_VEICULODISP_SEQUENCIA) DESTINOS,                          
   Trim(to_char(S.con_freteoper_id))    id,                                                  
   tdvadm.PKG_CFE_FRETE.FN_GET_IDVALIDO( S.con_freteoper_id, nvl(S.CON_FRETEOPER_ROTA,S.GLB_ROTA_CODIGO) ) Status            
       FROM tdvadm.T_FCF_VEICULODISP S, 
            tdvadm.T_FCF_TPVEICULO T                                           
      WHERE FCF_VEICULODISP_CODIGO IS NOT NULL    
        and s.frt_conjveiculo_codigo = '0004172'                                           
        AND T.FCF_TPVEICULO_CODIGO = S.FCF_TPVEICULO_CODIGO                                  
        AND S.FCF_OCORRENCIA_CODIGO IS NULL                                                  
        AND S.FCF_VEICULODISP_FLAGVIRTUAL IS NULL                                            
        AND S.FCF_VEICULODISP_FLAGVALEFRETE IS NULL                                          
 and S.ARM_ARMAZEM_CODIGO           =  '23'
and Trunc(S.FCF_VEICULODISP_DATA) >=  TO_DATE('19/06/2017','DD/MM/YYYY')
and Trunc(S.FCF_VEICULODISP_DATA) <=  TO_DATE('19/07/2017','DD/MM/YYYY')
-- Carregado
/* and 0 <                                                                
   (select count(*)                                                     
      from tdvadm.t_arm_carregamento ca                                        
     where ca.fcf_veiculodisp_codigo = s.fcf_veiculodisp_codigo         
       and ca.fcf_veiculodisp_sequencia = s.fcf_veiculodisp_sequencia)  
 Order by S.FCF_VEICULODISP_DATA
*/
-- Disponivel
/*and 0 =                                                                
   (select count(*)                                                     
      from tdvadm.t_arm_carregamento ca                                        
     where ca.fcf_veiculodisp_codigo = s.fcf_veiculodisp_codigo         
       and ca.fcf_veiculodisp_sequencia = s.fcf_veiculodisp_sequencia)  
 AND 0 =                                                                
   (SELECT COUNT(*)                                                     
      FROM tdvadm.T_FCF_SOLVEIC SOL                                            
     WHERE SOL.FCF_VEICULODISP_CODIGO = S.FCF_VEICULODISP_CODIGO        
       AND SOL.FCF_VEICULODISP_SEQUENCIA = S.FCF_VEICULODISP_SEQUENCIA) 
 Order by S.FCF_VEICULODISP_DATA

*/-- Contratado
/*and 0 =                                                                
   (select count(*)                                                     
      from tdvadm.t_arm_carregamento ca                                        
     where ca.fcf_veiculodisp_codigo = s.fcf_veiculodisp_codigo         
       and ca.fcf_veiculodisp_sequencia = s.fcf_veiculodisp_sequencia)  
 AND 0 <                                                                
   (SELECT COUNT(*)                                                     
      FROM tdvadm.T_FCF_SOLVEIC SOL                                            
     WHERE SOL.FCF_VEICULODISP_CODIGO = S.FCF_VEICULODISP_CODIGO        
       AND SOL.FCF_VEICULODISP_SEQUENCIA = S.FCF_VEICULODISP_SEQUENCIA) 
 Order by S.FCF_VEICULODISP_DATA;
*/ 
