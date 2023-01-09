If VERPARAMENTO = 'TDV' Then
      SELECT I.ARM_NOTA_NUMERO ARM_NOTAPESSAGEM_NUMERO,                                                                                 
             I.GLB_CLIENTE_CGCCPFREMETENTE,                                                                   
             I.ARM_NOTAPESAGEMITEM_SEQ,                                                                        
             I.ARM_NOTAPESAGEMITEM_DTINCLUSAO,                                                                 
             I.ARM_NOTAPESAGEMITEM_PESO,                                                                       
             I.USU_USUARIO_CODIGOPESOU,                                                                        
             N.ARM_NOTA_QTDVOLUME VOL_NOTA,                                                                    
             N.ARM_NOTA_PESO TOTPESO_NOTA,                                                                     
             NF.ARM_NOTA_SEQUENCIA,                                                                            
             NF.ARM_NOTA_CHAVENFE                                                                              
      FROM T_ARM_NOTAPESAGEMITEM_SAP I,                                                                        
           T_ARM_NOTAPESAGEM_SAP N,                                                                            
           t_arm_nota nf                                                                                       
      WHERE I.ARM_NOTA_NUMERO             = '1424687'                                                              
        AND I.GLB_CLIENTE_CGCCPFREMETENTE = '00162014030000'                                                              
        AND I.ARM_NOTA_NUMERO             = N.ARM_NOTA_NUMERO                                                  
        AND I.GLB_CLIENTE_CGCCPFREMETENTE = N.GLB_CLIENTE_CGCCPFREMETENTE                                      
        AND N.ARM_NOTA_NUMERO             = NF.ARM_NOTA_NUMERO                                                 
        AND N.GLB_CLIENTE_CGCCPFREMETENTE = NF.GLB_CLIENTE_CGCCPFREMETENTE                                     
        AND TRUNC(I.ARM_NOTAPESAGEMITEM_DTINCLUSAO) >= TRUNC(NF.ARM_NOTA_DTINCLUSAO)                           
        And nF.arm_nota_dtinclusao = (Select Max(nf_max.arm_nota_dtinclusao)                                   
                      From t_arm_nota nf_max                                                   
                      where nf_max.arm_nota_numero = n.arm_nota_numero                         
                        and nf_max.glb_cliente_cgccpfremetente = n.glb_cliente_cgccpfremetente)
      ORDER BY I.ARM_NOTAPESAGEMITEM_SEQ; 
ELSE

      SELECT I.ARM_NOTA_NUMERO ARM_NOTAPESSAGEM_NUMERO,                                                                                 
             I.GLB_CLIENTE_CGCCPFREMETENTE,                                                                   
             I.ARM_NOTAPESAGEMITEM_SEQ,                                                                        
             I.ARM_NOTAPESAGEMITEM_DTINCLUSAO,                                                                 
             I.ARM_NOTAPESAGEMITEM_PESO,                                                                       
             I.USU_USUARIO_CODIGOPESOU,                                                                        
             N.ARM_NOTA_QTDVOLUME VOL_NOTA,                                                                    
             N.ARM_NOTA_PESO TOTPESO_NOTA,                                                                     
             null ARM_NOTA_SEQUENCIA,                                                                            
             n.arm_nota_chavenfe ARM_NOTA_CHAVENFE                                                                          
      FROM T_ARM_NOTAPESAGEMITEM_SAP I,                                                                        
           T_ARM_NOTAPESAGEM_SAP N                                                                           
      WHERE I.ARM_NOTA_NUMERO             = '1424687'                                                              
        AND I.GLB_CLIENTE_CGCCPFREMETENTE = '00162014030000'                                                              
        AND I.ARM_NOTA_NUMERO             = N.ARM_NOTA_NUMERO                                                  
        AND I.GLB_CLIENTE_CGCCPFREMETENTE = N.GLB_CLIENTE_CGCCPFREMETENTE                                      
      ORDER BY I.ARM_NOTAPESAGEMITEM_SEQ; 
   
END IF;
