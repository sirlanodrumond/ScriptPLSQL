PL/SQL Developer Test script 3.0
55
begin
  -- Call the procedure
     Select TRIM(C.SLF_SOLFRETE_CODIGO) || TRIM(C.SLF_TABELA_CODIGO) par1,
            TRIM(C.SLF_SOLFRETE_SAQUE) || TRIM(C.SLF_TABELA_SAQUE) par2, 
            C.GLB_LOCALIDADE_CODIGOORIGEM par3,
            C.GLB_LOCALIDADE_CODIGODESTINO par4,
            C.GLB_ROTA_CODIGO par5,
            C.GLB_MERCADORIA_CODIGO par6,
            C.GLB_CLIENTE_CGCCPFREMETENTE par7,
            C.GLB_CLIENTE_CGCCPFSACADO par8,
            DECODE(NVL(C.SLF_SOLFRETE_CODIGO,'X'),'X','T','S') par9,
            C.CON_CONHECIMENTO_DTEMBARQUE par10,
            NULL par11,
            C.CON_CONHECIMENTO_CODIGO par12,
            C.CON_CONHECIMENTO_SERIE par13,
            C.GLB_ROTA_CODIGO par14
        into :P_SOLFRETE_CODIGO,  
             :P_SOLFRETE_SAQUE,    
             :P_LOCALIDADE_ORIGEM, 
             :P_LOCALIDADE_DESTINO,
             :P_ROTA_CODIGO,       
             :P_MERCADORIA_CODIGO, 
             :P_CLIENTE_REMETENTE,
             :P_CLIENTE_SACADO,    
             :P_TIPORETORNO,       
             :P_DATAEMBARQUE,      
             :P_LEI,               
             :P_CTRC,              
             :P_SERIE,             
             :P_ROTA              
      FROM TDVADM.T_CON_CONHECIMENTO C,
           TDVADM.T_GLB_ROTA R,
           tdvadm.t_glb_cliend cl
      WHERE C.CON_CONHECIMENTO_DTEMBARQUE >= TO_DATE('01/06/2021','DD/MM/YYYY')
        AND C.GLB_ROTA_CODIGO = R.GLB_ROTA_CODIGO
        and c.glb_cliente_cgccpfsacado = cl.glb_cliente_cgccpfcodigo
        and cl.glb_tpcliend_codigo = 'C'
        and c.con_conhecimento_codigo = '021540'
        and c.glb_rota_codigo = '057';

  PKG_SLF_CALCULOS.SP_VERIFICA_ISENCAO_SUBST(P_SOLFRETE_CODIGO => :P_SOLFRETE_CODIGO,
                                             P_SOLFRETE_SAQUE => :P_SOLFRETE_SAQUE,
                                             P_LOCALIDADE_ORIGEM => :P_LOCALIDADE_ORIGEM,
                                             P_LOCALIDADE_DESTINO => :P_LOCALIDADE_DESTINO,
                                             P_ROTA_CODIGO => :P_ROTA_CODIGO,
                                             P_MERCADORIA_CODIGO => :P_MERCADORIA_CODIGO,
                                             P_CLIENTE_REMETENTE => :P_CLIENTE_REMETENTE,
                                             P_CLIENTE_SACADO => :P_CLIENTE_SACADO,
                                             P_TIPORETORNO => :P_TIPORETORNO,
                                             P_DATAEMBARQUE => :P_DATAEMBARQUE,
                                             P_LEI => :P_LEI,
                                             P_CTRC => :P_CTRC,
                                             P_SERIE => :P_SERIE,
                                             P_ROTA => :P_ROTA);
end;
14
P_SOLFRETE_CODIGO
1
00121881
5
P_SOLFRETE_SAQUE
1
0001
5
P_LOCALIDADE_ORIGEM
1
40000   
5
P_LOCALIDADE_DESTINO
1
05571   
5
P_ROTA_CODIGO
1
057
5
P_MERCADORIA_CODIGO
1
54
5
P_CLIENTE_REMETENTE
1
13330634000154      
5
P_CLIENTE_SACADO
1
13330634000154      
5
P_TIPORETORNO
1
S                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
5
P_DATAEMBARQUE
1
20/01/2022
12
P_LEI
1
OPT.CRED.PRES.CONV.ICMS 106/96-ST ARTIGO 298, II,RICMS/BA SEM DESTAQUE DO ICMS NOS CT-e s.{ ICMS ST a SER RETIDO R$ <<I_VLICMS80>>}
5
P_CTRC
1
021540
5
P_SERIE
1
A1
5
P_ROTA
1
057
5
1
P_LEI
