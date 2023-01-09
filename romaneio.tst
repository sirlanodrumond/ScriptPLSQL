PL/SQL Developer Test script 3.0
605
declare
     vDestinatario varchar2(100);
     vMessage      varchar2(1000);
     vNotas        clob;
     vQryString    rmadm.t_glb_benasserec.GLB_BENASSEREC_ASSUNTO%type;
     vValeFrete    char(10);
     vContador     number;
     vPlaca        varchar2(20);
     vMotorista    varchar2(50);
     vEntrega      varchar2(50);
     vCPFMot       tdvadm.t_con_valefrete.con_valefrete_carreteiro%type;
     vCursor       PKG_EDI_PLANILHA.T_CURSOR;
     vLinha1       pkg_glb_SqlCursor.tpString1024;
     vEmissao      date;
     vSaque        tdvadm.t_con_valefrete.con_valefrete_saque%type;
     vGrupo        TDVADM.T_SLF_CLIREGRASEMAIL.GLB_GRUPOECONOMICO_CODIGO%type;
     vCnpj         TDVADM.T_SLF_CLIREGRASEMAIL.GLB_CLIENTE_CGCCPFCODIGO%TYPE;
     vContrato     TDVADM.T_SLF_CLIREGRASEMAIL.SLF_CONTRATO_CODIGO%TYPE;
     i             iNTEGER;
     vEmail        varchar2(20000);
     vEmail_2      varchar2(20000);
     vEmail_3      varchar2(20000);
     vEmail_4      varchar2(20000);
     vEmail_5      varchar2(20000);
     vEmail_6      varchar2(20000);
     vEmail_7      varchar2(20000);
     vEmail_8      varchar2(20000);
     vEmail_9      varchar2(20000);
     vEmail_10     varchar2(20000);
     vEmailCopia   varchar2(2000);
     vEmail1       varchar2(500);
     vEmail2       varchar2(500);
     vEmail3       varchar2(500);
     vSQL          varchar2(1000);
     vColunasQtde  varchar2(100)   := 'SELECT COUNT(*) ' || chr(10);
     vColunaseml   varchar2(100)   := 'SELECT DISTINCT E.SLF_CLIREGRASEMAIL_EMAIL ' || chr(10);
     vTabelas      varchar2(100)   := 'FROM TDVADM.T_SLF_CLIREGRASEMAIL E' || chr(10);
     vWhereFixo    varchar2(1000) := 'WHERE E.SLF_CLIREGRASEMAIL_ATIVO = ''S''' || chr(10);
     vWhereGRP     varchar2(1000) := '  AND E.GLB_GRUPOECONOMICO_CODIGO = ''<<GRP>>''' || chr(10);
     vWhereCNPJ    varchar2(1000) := '  AND E.GLB_CLIENTE_CGCCPFCODIGO = ''<<vCNPJ>>''' || chr(10);
     vWhereCTO     varchar2(1000) := '  AND E.SLF_CONTRATO_CODIGO = ''<<vCONTRATO>>''' || chr(10);
     vWhere        varchar2(1000);
     vAchou        integer;
     v_Email       varchar2(100);
     c_email       tdvadm.pkg_edi_controle.T_CURSOR;
     pTpRecebido rmadm.t_glb_benasserec%rowtype;
     pStatus     char;
     pMessage    clob;
   Begin
     

--     vEmailCopia := '';
    
     --seto o status para erro, e o processamento para hoje
     pTpRecebido.Glb_Benasserec_Processado := sysdate;
     pTpRecebido.Glb_Benasserec_Status := 'OK';
     pStatus := pkg_glb_common.Status_Nomal;
     vNotas  := empty_clob;
     Begin
       
--       Exemplo MSG=LISTNOTA;MINUTA=9876459871;GRUPO=0535


        vQryString  := trim(upper(pTpRecebido.GLB_BENASSEREC_ASSUNTO));

        if vQryString is null Then
           vQryString := 'MSG=LISTNOTA;MINUTA=2901030111;GRUPO=0613;CNPJ=05848387000316;CONTRATO=C4600005946';
           pTpRecebido.GLB_BENASSEREC_ASSUNTO := 'MSG=LISTNOTA;MINUTA=2901030111;GRUPO=0613;CNPJ=05848387000316;CONTRATO=C4600005946';
           vEmail := 'sdrumond@dellavolpe.com.br';
        End If;  
        
        vContador := 0;
        vValeFrete  := substr(Trim(tdvadm.fn_querystring(vQryString,'MINUTA','=',';')),1,10);
        vGrupo      := Trim(tdvadm.fn_querystring(vQryString,'GRUPO','=',';'));
        vCnpj       := Trim(tdvadm.fn_querystring(vQryString,'CNPJ','=',';'));
        vContrato   := Trim(tdvadm.fn_querystring(vQryString,'CONTRATO','=',';'));

        If vValeFrete <> '7480371971' Then

/*          if vGrupo = '0006' Then
             vEmail := 'grp.romaneioamsted@dellavolpe.com.br;';
          ElsIf vGrupo = '0534' Then
             vEmail := 'grp.romaneiovotorantimenergia@dellavolpe.com.br;';   
          ElsIf vGrupo = '0535' Then
             vEmail := 'grp.romaneioacelor@dellavolpe.com.br;';
          ElsIf vGrupo = '0570' Then
             vEmail := 'grp.romaneioternium@dellavolpe.com.br;';
          ElsIf vGrupo = '0074' Then
             vEmail := 'grp.romaneiovli@dellavolpe.com.br;';
          ElsIf vGrupo = '0565' Then
             vEmail := 'grp.romaneiovenergia@dellavolpe.com.br;';
          ElsIf vGrupo = '0597' Then
             vEmail := 'grp.romaneiovotorantimzinco@dellavolpe.com.br;';
           ElsIf vGrupo = '0613' Then
             vEmail := 'grp.romaneioalunorte@dellavolpe.com.br;';   
           ElsIf vGrupo = '0612' Then
             vEmail := 'grp.romaneioalbras@dellavolpe.com.br;';   
           ElsIf vGrupo = '0614' Then
             vEmail := 'grp.romaneioparagominas@dellavolpe.com.br;';   
           ElsIf vGrupo = '0567' Then
             vEmail := 'grp.romaneiousiminas@dellavolpe.com.br;';
           ElsIf vGrupo = '0628' Then
             vEmail := 'grp.raizenromaneios@dellavolpe.com.br;';
           ElsIf vGrupo = '0630' Then
             vEmail := 'grp.romaneiousimecanica@dellavolpe.com.br;';
           ElsIf vGrupo = '0541' Then
             vEmail := 'grp.romaneiosuzimp@dellavolpe.com.br;';
           ElsIf vGrupo = '0633' Then
             vEmail := 'grp.romaneiosuzsp@dellavolpe.com.br;';
           ElsIf vGrupo = '0632' Then
             vEmail := 'grp.romaneiosuzmuc@dellavolpe.com.br;';
           ElsIf vGrupo = '0634' Then
             vEmail := 'grp.romaneiosuzlime@dellavolpe.com.br;'; 
            ElsIf vGrupo = '0639' Then
             vEmail := 'grp.romaneionovelis@dellavolpe.com.br;'; 
           ElsIf vGrupo = '0642' Then
             vEmail := 'grp.romaneiogutierrez@dellavolpe.com.br;';       
           ElsIf vGrupo = '0643' Then
             vEmail := 'grp.romaneiobiosev@dellavolpe.com.br;';
           ElsIf vGrupo = '0020' Then
             vEmail := 'grp.romaneiosvale@dellavolpe.com.br;';
           ElsIf vGrupo = '0569' Then
             vEmail := 'grp.romaneiocba@dellavolpe.com.br;';
           ElsIf vGrupo = '0647' Then
             vEmail := 'grp.petropolisromaneios@dellavolpe.com.br;'; 
           ElsIf vGrupo = '0615' Then
             vEmail := 'grp.romaneioprada@dellavolpe.com.br;';               
          Else
             vEmail := 'grp.hd@dellavolpe.com.br;';
          End If;
*/          
                    
          vWhere := vWhereFixo;   
          vWhere := vWhere || replace(vWhereGRP,'<<GRP>>',vGrupo);
          vWhere := vWhere || replace(vWhereCNPJ,'<<vCNPJ>>',vCnpj);
          vWhere := vWhere || replace(vWhereCTO,'<<vCONTRATO>>',vContrato);
          vSQL :=  vColunasQtde || vTabelas || vWhere;
          execute immediate vSql into vAchou;
          If vAchou = 0 Then
            
              vWhere := vWhereFixo;   
              vWhere := vWhere || replace(vWhereGRP,'<<GRP>>',vGrupo);
              vWhere := vWhere || replace(vWhereCNPJ,'<<vCNPJ>>',vCnpj);
              vSQL :=  vColunasQtde || vTabelas || vWhere;
              execute immediate vSql into vAchou;
              If vAchou = 0 Then

                  vWhere := vWhereFixo;   
                  vWhere := vWhere || replace(vWhereGRP,'<<GRP>>',vGrupo);
                  vWhere := vWhere || replace(vWhereCTO,'<<vCONTRATO>>',vContrato);
                  vSQL :=  vColunasQtde || vTabelas || vWhere;
                  execute immediate vSql into vAchou;
                  If vAchou = 0 Then
                   
                      vWhere := vWhereFixo;   
                      vWhere := vWhere || replace(vWhereCNPJ,'<<vCNPJ>>',vCnpj);
                      vWhere := vWhere || replace(vWhereCTO,'<<vCONTRATO>>',vContrato);
                      vSQL :=  vColunasQtde || vTabelas || vWhere;
                      execute immediate vSql into vAchou;
                      If vAchou = 0 Then

                          vWhere := vWhereFixo;   
                          vWhere := vWhere || replace(vWhereCNPJ,'<<vCNPJ>>',vCnpj);
                          vSQL :=  vColunasQtde || vTabelas || vWhere;
                          execute immediate vSql into vAchou;
                          If vAchou = 0 Then
                                
                              vWhere := vWhereFixo;   
                              vWhere := vWhere || replace(vWhereCTO,'<<vCONTRATO>>',vContrato);
                              vSQL :=  vColunasQtde || vTabelas || vWhere;
                              execute immediate vSql into vAchou;
                              If vAchou = 0 Then

                                  vWhere := vWhereFixo;   
                                  vWhere := vWhere || replace(vWhereGRP,'<<GRP>>',vGrupo);
                                  vSQL :=  vColunasQtde || vTabelas || vWhere;
                                  execute immediate vSql into vAchou;
                               
                              End If;

                          End If;


                       
                      End If;
                      
                  End If;

              End If;
          End If;
          
          vEmail := '';
          vEmail_2 := '';
          vEmail_3 := '';
          vEmail_4 := '';
          vEmail_5 := '';
          vEmail_6 := '';
          vEmail_7 := '';
          vEmail_8 := '';
          vEmail_9 := '';
          vEmail_10 := '';
          vSQL :=  vColunaseml || vTabelas || vWhere;
          If vAchou > 0 Then
             open c_email FOR vSql;
             loop
                   fetch c_email into v_Email;
                   exit when c_email%notfound;               

               If length(trim(nvl(vEmail,'1'))) < 20 Then
                  vEmail := vEmail || v_Email || ';';     
               ElsIf length(trim(nvl(vEmail_2,'1'))) < 20 Then
                  vEmail_2 := vEmail_2 || v_Email || ';';     
               ElsIf length(trim(nvl(vEmail_3,'1'))) < 20 Then
                  vEmail_3 := vEmail_3 || v_Email || ';';     
               ElsIf length(trim(nvl(vEmail_4,'1'))) < 20 Then
                  vEmail_4 := vEmail_4 || v_Email || ';';     
               ElsIf length(trim(nvl(vEmail_5,'1'))) < 20 Then
                  vEmail_5 := vEmail_5 || v_Email || ';';     
               ElsIf length(trim(nvl(vEmail_6,'1'))) < 20 Then
                  vEmail_6 := vEmail_6 || v_Email || ';';     
               ElsIf length(trim(nvl(vEmail_7,'1'))) < 20 Then
                  vEmail_7 := vEmail_7 || v_Email || ';';     
               ElsIf length(trim(nvl(vEmail_8,'1'))) < 20 Then
                  vEmail_8 := vEmail_8 || v_Email || ';';     
               ElsIf length(trim(nvl(vEmail_9,'1'))) < 20 Then
                  vEmail_9 := vEmail_9 || v_Email || ';';     
               Else
                  vEmail_10 := vEmail_10 || v_Email || ';';     
               End If;               

             End Loop;
              
          End If;
        End If;
         
       
        if pTpRecebido.glb_benasserec_origem not in ('tdv.operacao@dellavolpe.com.br','aut-e@dellavolpe.com.br') Then
           vEmail := vEmail || pTpRecebido.glb_benasserec_origem;
        End If;

        

        if  pTpRecebido.Glb_Benasserec_Origem in ('tdv.operacao@dellavolpe.com.br','aut-e@dellavolpe.com.br') Then
           select min(vf.con_valefrete_saque)
              into vSaque
           from tdvadm.t_con_valefrete vf
           WHERE VF.CON_CONHECIMENTO_CODIGO = SUBSTR(vValeFrete,1,6)
             AND VF.GLB_ROTA_CODIGO = SUBSTR(vValeFrete,7,3)
             and nvl(vf.con_valefrete_status,'N') = 'N'
             and nvl(vf.con_valefrete_impresso,'N') = 'S';
        Else
           vSaque  := SUBSTR(vValeFrete,10,1) ;
        End If;


        -- verifica se ja não existe alguma outra soliucitacação
        select count(*)
          into vContador
        from rmadm.t_glb_benasserec br
        where 0 = 0
          and br.glb_benasserec_origem = pTpRecebido.Glb_Benasserec_Origem
          and br.glb_benasserec_assunto = pTpRecebido.Glb_Benasserec_Assunto
          and br.glb_benasserec_status <> 'ER';
          
        if vContador > 1 then
           pTpRecebido.Glb_Benasserec_Status := 'ER';
           pMessage := 'Ja existe uma solictacao deste ROMANEIO ' || vValeFrete ;
           vEmail := '';
           return;
          
        End If;

        -- Primeiro Saque Valido e Rotas <> das 900
        if ( vSaque  = SUBSTR(vValeFrete,10,1) ) and ( SUBSTR(vValeFrete,7,1) <> '9' ) Then

        


        Begin
           select vf.con_valefrete_placa,
                  vf.con_valefrete_carreteiro ca,
                  vf.con_valefrete_datacadastro
             into vPlaca,
                  vCPFMot,
                  vEmissao
           from tdvadm.t_con_valefrete vf
           WHERE VF.CON_CONHECIMENTO_CODIGO = SUBSTR(vValeFrete,1,6)
             AND VF.GLB_ROTA_CODIGO = SUBSTR(vValeFrete,7,3) 
             AND VF.CON_VALEFRETE_SAQUE = SUBSTR(vValeFrete,10,1);

           if substr(vPlaca,1,3) = '000' Then
              select distinct m.frt_motorista_nome
                 into vMotorista
              from tdvadm.t_frt_motorista m
              where m.frt_motorista_cpf = vCPFMot
                and rownum = 1;         
           Else    
              select distinct ca.car_carreteiro_nome
                 into vMotorista
              from tdvadm.t_car_carreteiro ca
              where ca.car_carreteiro_cpfcodigo = vCPFMot
                and rownum = 1;         
           End If;
        exception
          When NO_DATA_FOUND Then
             vPlaca := 'VFERRADO';
             vEmail := 'sdrumond@dellavolpe.com.br';
        end;  
       
       
     --Exemplo de QryString = MSG=LISTNOTA;MINUTA=0549686301
     
     
        if vPlaca <> 'VFERRADO' Then


           vMessage := pkg_glb_html.Assinatura || '<br />';
           vMessage := vMessage || 'Use o Link abaixo para Gerar uma copia em EXCEL/PDF <br />';
           vMessage := vMessage || 'http://extranet.dellavolpe.com.br:6917/gerplanilha/get/result?codigoPlanilha=romVale' || 
                                   '&ValeFrete=' || SUBSTR(vValeFrete,1,6) || 
                                   '&Rota=' || SUBSTR(vValeFrete,7,3) || 
                                   '&Saque=' || SUBSTR(vValeFrete,10,1) || 
                                   '&GrupoEconomico=' || vGrupo ||
                                   '&usuarioChamou=aut-e <br /><br />';
           vMessage := vMessage || pkg_glb_html.fn_Titulo('MOTORISTA - ' || vMotorista );
           vMessage := vMessage || pkg_glb_html.LinhaH;
 
           pTpRecebido.Glb_Benasserec_Status := 'OK';
           pMessage := vMessage || vNotas || pkg_glb_html.LinhaH;
 
           vContador := 0;
           
           -- Conta pra ver tem tem nota
           
           
          SELECT count(*),
                 tdvadm.fn_busca_codigoibge(c.con_conhecimento_localentrega,'IBD') ENTREGA
              into vContador,
                   vEntrega
          FROM tdvadm.T_CON_VFRETECONHEC VFC
               ,tdvadm.T_CON_VALEFRETE VF
               ,tdvadm.T_CON_CONHECIMENTO C
               ,tdvadm.T_CON_NFTRANSPORTA NF
               ,tdvadm.T_ARM_COLETA CO
               ,tdvadm.T_ARM_NOTA NT
               ,tdvadm.T_GLB_CLIENTE CS
               ,tdvadm.T_GLB_CLIENTE CD
          WHERE VFC.CON_VALEFRETE_CODIGO = SUBSTR(vValeFrete,1,6)
            AND VFC.GLB_ROTA_CODIGOVALEFRETE = SUBSTR(vValeFrete,7,3) -- AJUSTADO POR JONATAS VELOSO 13/11/2018
            AND VFC.CON_VALEFRETE_SAQUE = SUBSTR(vValeFrete,10,1)     -- AJUSTADO POR JONATAS VELOSO 13/11/2018
            AND cS.glb_grupoeconomico_codigo = vGrupo
            AND CD.GLB_GRUPOECONOMICO_CODIGO = vGrupo
            -- Sirlano 03/02/2020
            -- Criticar o CNP e Contrato
            AND C.GLB_CLIENTE_CGCCPFSACADO = vCnpj
            AND NT.SLF_CONTRATO_CODIGO = vContrato
            AND VFC.CON_CONHECIMENTO_CODIGO = C.CON_CONHECIMENTO_CODIGO
            AND VFC.CON_CONHECIMENTO_SERIE = C.CON_CONHECIMENTO_SERIE
            AND VFC.GLB_ROTA_CODIGO = C.GLB_ROTA_CODIGO

            AND VFC.CON_VALEFRETE_CODIGO = VF.CON_CONHECIMENTO_CODIGO
            AND VFC.CON_VALEFRETE_SERIE = VF.CON_CONHECIMENTO_SERIE
            AND VFC.GLB_ROTA_CODIGOVALEFRETE = VF.GLB_ROTA_CODIGO
            AND VFC.CON_VALEFRETE_SAQUE = VF.CON_VALEFRETE_SAQUE

            AND C.CON_CONHECIMENTO_CODIGO = NF.CON_CONHECIMENTO_CODIGO
            AND C.CON_CONHECIMENTO_SERIE = NF.CON_CONHECIMENTO_SERIE
            AND C.GLB_ROTA_CODIGO = NF.GLB_ROTA_CODIGO

            AND C.ARM_COLETA_NCOMPRA = CO.ARM_COLETA_NCOMPRA (+)
            AND C.ARM_COLETA_CICLO = CO.ARM_COLETA_CICLO (+)

            AND C.ARM_COLETA_NCOMPRA = NT.ARM_COLETA_NCOMPRA (+)
            AND C.ARM_COLETA_CICLO = NT.ARM_COLETA_CICLO (+)

            AND C.GLB_CLIENTE_CGCCPFSACADO = CS.GLB_CLIENTE_CGCCPFCODIGO
            AND c.Glb_Cliente_Cgccpfdestinatario = CD.GLB_CLIENTE_CGCCPFCODIGO
            and ROWNUM = 1 
         group by tdvadm.fn_busca_codigoibge(c.con_conhecimento_localentrega,'IBD');
                              
           if vContador = 0 Then
             vMessage := '';
             pTpRecebido.Glb_Benasserec_Status := 'ER';
             Return;
           End If;  

           open vCursor FOR SELECT DISTINCT RT.GLB_ROTA_CODIGO || '-' || TRIM(RT.GLB_ROTA_DESCRICAO) ROTA,
                                            nvl(nt.xml_notalinha_numdoc,CO.ARM_COLETA_PEDIDO) PEDIDO,
                                            nf.glb_cfop_codigo CFOP,
                                            nf.con_nftransportada_numnfiscal NF,
                                            NF.GLB_CLIENTE_CGCCPFCODIGO CNPJFORNEC,
                                            CR.GLB_CLIENTE_RAZAOSOCIAL FORNECEDOR,
                                            NF.CON_NFTRANSPORTADA_DTEMISSAO DTEMISSAONF,
                                            NF.CON_NFTRANSPORTADA_VOLUMES QTDEVOLUMES,
                                            NF.CON_NFTRANSPORTADA_PESO PESO,
                                            CO.ARM_COLETA_DTSOLICITACAO DTACIONTRANSP,
                                            co.arm_coleta_dtprogramacao DTCHEGTRANSP,
                                            TRUNC(VF.CON_VALEFRETE_DATACADASTRO) DTSAIDATRANSP,
                                            VF.CON_VALEFRETE_PLACA PLACAVEICULO,
                                            VFC.CON_CONHECIMENTO_CODIGO CTRC,
                                            nf.con_nftransportada_valor VALOR,
                                            'TIPO' TIPOTRANSP,
                                            NF.CON_NFTRANSPORTADA_CHAVENFE CHAVE,
                                            VF.CON_VALEFRETE_DATAPRAZOMAX PREVISAO,
                                            AR.ARM_ARMAZEM_DESCRICAO TRANSFERENCIA
                                            
                            FROM tdvadm.T_CON_VFRETECONHEC VFC
                                 ,tdvadm.T_CON_VALEFRETE VF
                                 ,tdvadm.T_CON_CONHECIMENTO C
                                 ,tdvadm.T_CON_NFTRANSPORTA NF
                                 ,tdvadm.T_ARM_COLETA CO
                                 ,tdvadm.T_ARM_NOTA NT
                                 ,tdvadm.T_GLB_CLIENTE CS
                                 ,tdvadm.T_GLB_CLIENTE CD
                                 ,tdvadm.T_GLB_CLIENTE CR
                                 ,tdvadm.T_GLB_ROTA RT
                                 ,tdvadm.t_Arm_Armazem AR
                                 ,tdvadm.t_arm_notacte ncte
                            WHERE VFC.CON_VALEFRETE_CODIGO                = SUBSTR(vValeFrete,1,6)  --Rafael AITI 14/11/2018 (substr estava errado)
                              AND VFC.GLB_ROTA_CODIGOVALEFRETE            = SUBSTR(vValeFrete,7,3)  --Rafael AITI 14/11/2018 (substr estava errado)
                              AND VFC.CON_VALEFRETE_SAQUE                 = SUBSTR(vValeFrete,10,1) --Rafael AITI 14/11/2018 (substr estava errado)
                              AND cS.glb_grupoeconomico_codigo            = vGrupo
                              AND CD.GLB_GRUPOECONOMICO_CODIGO            = vGrupo
                              AND VFC.CON_CONHECIMENTO_CODIGO             = C.CON_CONHECIMENTO_CODIGO
                              AND VFC.CON_CONHECIMENTO_SERIE              = C.CON_CONHECIMENTO_SERIE
                              AND VFC.GLB_ROTA_CODIGO                     = C.GLB_ROTA_CODIGO

                              -- Sirlano 03/02/2020
                              -- Criticar o CNP e Contrato
                              
                              AND C.GLB_CLIENTE_CGCCPFSACADO = vCnpj
                              AND NT.SLF_CONTRATO_CODIGO = vContrato


                              -- Sirlano em 26/09/2018
                              -- Coloquei a notacte
                               
                              and VFC.con_conhecimento_codigo              = ncte.con_conhecimento_codigo (+)
                              and VFC.con_conhecimento_serie               = ncte.con_conhecimento_serie (+)
                              and VFC.glb_rota_codigo                      = ncte.glb_rota_codigo (+)
                              and ncte.arm_notacte_codigo (+) = 'NO'

                              -- fim da notacte
                              
                              AND VFC.CON_VALEFRETE_CODIGO                = VF.CON_CONHECIMENTO_CODIGO
                              AND VFC.CON_VALEFRETE_SERIE                 = VF.CON_CONHECIMENTO_SERIE
                              AND VFC.GLB_ROTA_CODIGOVALEFRETE            = VF.GLB_ROTA_CODIGO
                              AND VFC.CON_VALEFRETE_SAQUE                 = VF.CON_VALEFRETE_SAQUE
                              AND VFC.GLB_ROTA_CODIGOVALEFRETE            = RT.GLB_ROTA_CODIGO
                              AND VFC.ARM_ARMAZEM_CODIGO                  = AR.ARM_ARMAZEM_CODIGO (+)
                              AND C.CON_CONHECIMENTO_CODIGO               = NF.CON_CONHECIMENTO_CODIGO
                              AND C.CON_CONHECIMENTO_SERIE                = NF.CON_CONHECIMENTO_SERIE
                              AND C.GLB_ROTA_CODIGO                       = NF.GLB_ROTA_CODIGO
                             
                             -- Sirlano em 26-09/2018
                             -- mudamos para a nota
                              AND nt.ARM_COLETA_NCOMPRA                    = CO.ARM_COLETA_NCOMPRA (+)
                              AND nt.ARM_COLETA_CICLO                      = CO.ARM_COLETA_CICLO (+)
                              
                             -- Klayton em 13/09/2018, quando temos notas agrupadas o cte só tem um numero-  
                             -- de coleta com isso o select trazia informações incorretas. mudei a ligação da t_arm_nota pela a chave da nfe.
                             -- desabilitei as duas linhas abaixo
                             /*AND C.ARM_COLETA_NCOMPRA                    = NT.ARM_COLETA_NCOMPRA (+)
                               AND C.ARM_COLETA_CICLO                      = NT.ARM_COLETA_CICLO   (+)*/
                             -- habilitei essa linha
                              and nf.con_nftransportada_chavenfe = nt.arm_nota_chavenfe(+)
                              
                              AND C.GLB_CLIENTE_CGCCPFREMETENTE    = CR.GLB_CLIENTE_CGCCPFCODIGO
                              AND C.GLB_CLIENTE_CGCCPFSACADO       = CS.GLB_CLIENTE_CGCCPFCODIGO
                              AND c.Glb_Cliente_Cgccpfdestinatario = CD.GLB_CLIENTE_CGCCPFCODIGO
                             order by nf.con_nftransportada_numnfiscal;
           
           pkg_glb_SqlCursor.TiposComuns.Formato := 'H';
           pkg_glb_SqlCursor.TipoHederHTML.Alinhamento := 'Left';
           pkg_glb_SqlCursor.sp_Get_Cursor(vCursor,vLinha1);
           for i in 1 .. vLinha1.count loop
              if pkg_glb_SqlCursor.TiposComuns.Formato = 'H' then
                 pMessage := pMessage || vLinha1(i);
              Else
                 pMessage := pMessage || vLinha1(i) || chr(10);
              End if;
           End loop; 
        Else
          pTpRecebido.Glb_Benasserec_Status := 'ER';
          pMessage := '';
          vEmail := 'sdrumond@dellavolpe.com.br';
        End If;
       --caso ocorra algum erro durante a execução da função, manda um e-mail pro Analista Rogerio
     Else
         pTpRecebido.Glb_Benasserec_Status := 'ER';
         If SUBSTR(vValeFrete,7,1) <> '9' Then
            pMessage := 'Não e o Primeiro Saque Valido ' || vValeFrete ;
         Else
            pMessage := 'Rotas 9?? não tem Romaneio ' || vValeFrete ;
         End If;
         vEmail := '';
     End If;

  EXCEPTION
    when others then
       pStatus := pkg_glb_common.Status_Erro;
       pMessage := 'Erro Rodando Confirmação de Comprovantes . ' || chr(10) || 
                   '********************************************************************************' || chr(10) ||
                   sqlerrm || chr(10) ||
                   '********************************************************************************' || chr(10) ||
                   DBMS_UTILITY.format_error_backtrace || chr(10) ||
                   '********************************************************************************' || chr(10);
       vEmail := 'sdrumond@dellavolpe.com.br';

  End;
  
  if length(trim(nvl(vEmail,'a'))) <> 1 Then
     
     wservice.pkg_glb_email.SP_ENVIAEMAIL('ROMANEIO - ' || vValeFrete || ' PLACA - ' || vPlaca || ' EMISSAO - ' || TO_CHAR(vEmissao,'DD/MM/YYYY') || ' ENTREGA - ' || vEntrega ,
                                          pMessage,
                                          'sirlano.drumond@dellavolpe.com.br',
--                                        'amarques@dellavolpe.com.br;gmachado@dellavolpe.com.br;toliveira@dellavolpe.com.br'); 
                                          vEmail,
                                          'romaneiolog@dellavolpe.com.br');

     If length(trim(nvl(vEmail_2,'a'))) <> 1 Then
        wservice.pkg_glb_email.SP_ENVIAEMAIL('ROMANEIO - ' || vValeFrete || ' PLACA - ' || vPlaca || ' EMISSAO - ' || TO_CHAR(vEmissao,'DD/MM/YYYY') || ' ENTREGA - ' || vEntrega ,
                                             pMessage,
                                             'sirlano.drumond@dellavolpe.com.br',
--                                           'amarques@dellavolpe.com.br;gmachado@dellavolpe.com.br;toliveira@dellavolpe.com.br'); 
                                             vEmail_2,
                                             'romaneiolog@dellavolpe.com.br');
     End If;

     If length(trim(nvl(vEmail_3,'a'))) <> 1 Then
        wservice.pkg_glb_email.SP_ENVIAEMAIL('ROMANEIO - ' || vValeFrete || ' PLACA - ' || vPlaca || ' EMISSAO - ' || TO_CHAR(vEmissao,'DD/MM/YYYY') || ' ENTREGA - ' || vEntrega ,
                                             pMessage,
                                             'sirlano.drumond@dellavolpe.com.br',
--                                           'amarques@dellavolpe.com.br;gmachado@dellavolpe.com.br;toliveira@dellavolpe.com.br'); 
                                             vEmail_3,
                                             'romaneiolog@dellavolpe.com.br');
     End If;

     If length(trim(nvl(vEmail_4,'a'))) <> 1 Then
        wservice.pkg_glb_email.SP_ENVIAEMAIL('ROMANEIO - ' || vValeFrete || ' PLACA - ' || vPlaca || ' EMISSAO - ' || TO_CHAR(vEmissao,'DD/MM/YYYY') || ' ENTREGA - ' || vEntrega ,
                                             pMessage,
                                             'sirlano.drumond@dellavolpe.com.br',
--                                           'amarques@dellavolpe.com.br;gmachado@dellavolpe.com.br;toliveira@dellavolpe.com.br'); 
                                             vEmail_4,
                                             'romaneiolog@dellavolpe.com.br');
     End If;
     If length(trim(nvl(vEmail_5,'a'))) <> 1 Then
        wservice.pkg_glb_email.SP_ENVIAEMAIL('ROMANEIO - ' || vValeFrete || ' PLACA - ' || vPlaca || ' EMISSAO - ' || TO_CHAR(vEmissao,'DD/MM/YYYY') || ' ENTREGA - ' || vEntrega ,
                                             pMessage,
                                             'sirlano.drumond@dellavolpe.com.br',
--                                           'amarques@dellavolpe.com.br;gmachado@dellavolpe.com.br;toliveira@dellavolpe.com.br'); 
                                             vEmail_5,
                                             'romaneiolog@dellavolpe.com.br');
     End If;

     If length(trim(nvl(vEmail_6,'a'))) <> 1 Then
        wservice.pkg_glb_email.SP_ENVIAEMAIL('ROMANEIO - ' || vValeFrete || ' PLACA - ' || vPlaca || ' EMISSAO - ' || TO_CHAR(vEmissao,'DD/MM/YYYY') || ' ENTREGA - ' || vEntrega ,
                                             pMessage,
                                             'sirlano.drumond@dellavolpe.com.br',
--                                           'amarques@dellavolpe.com.br;gmachado@dellavolpe.com.br;toliveira@dellavolpe.com.br'); 
                                             vEmail_6,
                                             'romaneiolog@dellavolpe.com.br');
     End If;
     If length(trim(nvl(vEmail_7,'a'))) <> 1 Then
        wservice.pkg_glb_email.SP_ENVIAEMAIL('ROMANEIO - ' || vValeFrete || ' PLACA - ' || vPlaca || ' EMISSAO - ' || TO_CHAR(vEmissao,'DD/MM/YYYY') || ' ENTREGA - ' || vEntrega ,
                                             pMessage,
                                             'sirlano.drumond@dellavolpe.com.br',
--                                           'amarques@dellavolpe.com.br;gmachado@dellavolpe.com.br;toliveira@dellavolpe.com.br'); 
                                             vEmail_7,
                                             'romaneiolog@dellavolpe.com.br');
     End If;
     If length(trim(nvl(vEmail_8,'a'))) <> 1 Then
        wservice.pkg_glb_email.SP_ENVIAEMAIL('ROMANEIO - ' || vValeFrete || ' PLACA - ' || vPlaca || ' EMISSAO - ' || TO_CHAR(vEmissao,'DD/MM/YYYY') || ' ENTREGA - ' || vEntrega ,
                                             pMessage,
                                             'sirlano.drumond@dellavolpe.com.br',
--                                           'amarques@dellavolpe.com.br;gmachado@dellavolpe.com.br;toliveira@dellavolpe.com.br'); 
                                             vEmail_8,
                                             'romaneiolog@dellavolpe.com.br');
     End If;
     If length(trim(nvl(vEmail_9,'a'))) <> 1 Then
        wservice.pkg_glb_email.SP_ENVIAEMAIL('ROMANEIO - ' || vValeFrete || ' PLACA - ' || vPlaca || ' EMISSAO - ' || TO_CHAR(vEmissao,'DD/MM/YYYY') || ' ENTREGA - ' || vEntrega ,
                                             pMessage,
                                             'sirlano.drumond@dellavolpe.com.br',
--                                           'amarques@dellavolpe.com.br;gmachado@dellavolpe.com.br;toliveira@dellavolpe.com.br'); 
                                             vEmail_9,
                                             'romaneiolog@dellavolpe.com.br');
     End If;
     If length(trim(nvl(vEmail_10,'a'))) <> 1 Then
        wservice.pkg_glb_email.SP_ENVIAEMAIL('ROMANEIO - ' || vValeFrete || ' PLACA - ' || vPlaca || ' EMISSAO - ' || TO_CHAR(vEmissao,'DD/MM/YYYY') || ' ENTREGA - ' || vEntrega ,
                                             pMessage,
                                             'sirlano.drumond@dellavolpe.com.br',
--                                           'amarques@dellavolpe.com.br;gmachado@dellavolpe.com.br;toliveira@dellavolpe.com.br'); 
                                             vEmail_10,
                                             'romaneiolog@dellavolpe.com.br');
     End If;


  End If;

--     wservice.pkg_glb_email.SP_ENVIAEMAIL('ROMANEIO - ' || vValeFrete || ' PLACA - ' || vPlaca || ' EMISSAO - ' || TO_CHAR(vEmissao,'DD/MM/YYYY') ,
--                                          pMessage,
--                                          'aut-e@dellavolpe.com.br',
--                                          'toliveira@dellavolpe.com.br');
     
end ;                                                                  
0
9
vEmail
vEmail_2
vEmail_3
vEmail_4
vEmail_5
vEmail_6
vEmail_7
vEmail_8
vEmail_9
