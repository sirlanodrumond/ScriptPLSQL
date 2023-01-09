PL/SQL Developer Test script 3.0
311
-- Created on 13/09/2017 by DESENV 
declare 

  TYPE T_CURSOR IS REF CURSOR;
  CODIGO_APP      CONSTANT TDVADM.T_USU_APLICACAO.USU_APLICACAO_CODIGO%TYPE := 'integCTF';
  CODIGO_MACRO    CONSTANT TDVADM.T_LOG_MACRO.LOG_MACRO_CODIGO%TYPE := 'integCTF';
  USUARIO_DEFAULT CONSTANT WSERVICE.T_WSD_USUARIOCTF.WSD_USUARIOCTF_LOGIN%TYPE := 'wstdv';
  SENHA_DEFAULT   CONSTANT WSERVICE.T_WSD_USUARIOCTF.WSD_USUARIOCTF_SENHA%TYPE := 'duplode14';

    vAuxiliar           number;
    vLinha1             tdvadm.pkg_glb_SqlCursor.tpString1024;
    vMessage            clob;
    --vCursor             T_CURSOR;
    C_POSTOSNCAD        T_CURSOR;
    C_PLACASSCONJ       T_CURSOR;
    C_ABATDUPCVLRDIF    T_CURSOR;


  BEGIN
      
    begin

      -- INSERE OS ABASTECIMENTOS SEM POSTOS PARA OS POSTOS JA CADASTRADOS      
      FOR C_CURSOR IN (SELECT A.*
                         FROM TDVADM.T_ACC_ABASTECIMENTOSEMPOSTO A,
                              TDVADM.T_POS_CADASTRO C
                        WHERE A.POS_CADASTRO_CGC = C.POS_CADASTRO_CGC) LOOP 
        begin                                               
          INSERT INTO TDVADM.T_ACC_ABASTECIMENTO2
          VALUES(C_CURSOR.ACC_ABASTECIMENTO_NUMERO,
                 C_CURSOR.ACC_CONTAS_CICLO,
                 C_CURSOR.POS_CADASTRO_CGC,
                 C_CURSOR.FRT_CONJVEICULO_CODIGO,
                 C_CURSOR.ACC_ACONTAS_NUMERO,
                 C_CURSOR.GLB_ROTA_CODIGO_OPERACAO,
                 C_CURSOR.FRT_MOTORISTA_CODIGO,
                 C_CURSOR.CAX_OPERACAO_CODIGO,
                 C_CURSOR.ACC_ABASTECIMENTO_QUANTIDADE,
                 TO_DATE(C_CURSOR.ACC_ABASTECIMENTO_DATA,'DD/MM/YYYY HH24:MI:SS'),--C_CURSOR.ACC_ABASTECIMENTO_DATA,
                 C_CURSOR.ACC_ABASTECIMENTO_KM,
                 C_CURSOR.ACC_ABASTECIMENTO_VALOR,
                 C_CURSOR.ACC_ABASTECIMENTO_TPREG,
                 C_CURSOR.ACC_ABASTECIMENTO_OBS,
                 C_CURSOR.USU_USUARIO_CODIGOCAD,
                 C_CURSOR.POS_COMBUSTIVEL_CODIGO,
                 C_CURSOR.ACC_ABASTECIMENTO_INDICE,
                 C_CURSOR.ACC_ABASTECIMENTO_PLACA);                       
          --SELECT A.*
          --FROM TDVADM.T_ACC_ABASTECIMENTOSEMPOSTO A,
          --     TDVADM.T_POS_CADASTRO C
          --WHERE A.POS_CADASTRO_CGC = C.POS_CADASTRO_CGC;
          
        exception when others then
          tdvadm.pkg_glb_log.sp_GravaLog(
          'Erro ao tentar inserir Abastecimentos sem postos para postos ja cadastrados, '||
          'Abastecimento: '||c_cursor.acc_abastecimento_numero||', '||
          'Placa: '||c_cursor.acc_abastecimento_placa||', '||
          'Combustibel: '||c_cursor.pos_combustivel_codigo||', '||sqlerrm,
          CODIGO_APP,
          tdvadm.pkg_glb_log.LOG_ERRO,
          CODIGO_MACRO,
          c_cursor.acc_abastecimento_numero); -- como neste caso não tenho um campo chave, gravo o local que ocorreu o log        
        end;                            
      END LOOP;                    
                                                                     
      -- DELETA OS QUE CONSEGUIU INSERIR     
      begin
        DELETE TDVADM.T_ACC_ABASTECIMENTOSEMPOSTO SP
        WHERE SP.ACC_ABASTECIMENTO_NUMERO IN (SELECT A.ACC_ABASTECIMENTO_NUMERO
                                                FROM TDVADM.T_ACC_ABASTECIMENTOSEMPOSTO A,
                                                     TDVADM.T_POS_CADASTRO C
                                               WHERE A.POS_CADASTRO_CGC = C.POS_CADASTRO_CGC);       
      exception when others then
        tdvadm.pkg_glb_log.sp_GravaLog(
        'Erro ao tentar inserir Abastecimentos sem postos para postos ja cadastrados, '||sqlerrm,
        CODIGO_APP,
        tdvadm.pkg_glb_log.LOG_ERRO,
        CODIGO_MACRO,
        'pkg_wsd_ctf.SP_WSD_CRITICAINTEGRACAO'); -- como neste caso não tenho um campo chave, gravo o local que ocorreu o log        
      end;                                                      
                                                                                         
     
      -- NÃO ENCONTROU NA TDV     
      FOR C_CURSOR IN (SELECT *
                       FROM TDVADM.T_ACC_ABASTECIMENTO2 AB2
                       WHERE 0 = (SELECT COUNT(*)
                                  FROM TDVADM.T_ACC_ABASTECIMENTO AB
                                  WHERE AB.ACC_ABASTECIMENTO_NUMERO = AB2.ACC_ABASTECIMENTO_NUMERO
                                  AND AB.POS_CADASTRO_CGC = AB2.POS_CADASTRO_CGC
                                  AND 0 < (SELECT COUNT(*) 
                                           FROM TDVADM.t_pos_cadastro pc 
                                           WHERE pc.pos_cadastro_cgc = ab2.pos_cadastro_cgc))
                         and ab2.acc_abastecimento_data >= '01/01/2017'
                        /*AND 0 = (SELECT COUNT(*)
                                  FROM TDVADM.T_LOG_SYSTEM LO
                                 WHERE TRIM(LO.LOG_SYSTEM_CAMPOCHAVE) = TRIM(AB2.ACC_ABASTECIMENTO_NUMERO))*/)
      LOOP                    
      
      begin
        INSERT INTO TDVADM.T_ACC_ABASTECIMENTO (
               acc_abastecimento_numero, 
               acc_contas_ciclo, 
               pos_cadastro_cgc, 
               frt_conjveiculo_codigo, 
               acc_acontas_numero, 
               glb_rota_codigo_operacao, 
               frt_motorista_codigo, 
               cax_operacao_codigo, 
               acc_abastecimento_quantidade, 
               acc_abastecimento_data, 
               acc_abastecimento_km, 
               acc_abastecimento_valor, 
               acc_abastecimento_tpreg, 
               acc_abastecimento_obs, 
               usu_usuario_codigocad, 
               pos_combustivel_codigo, 
               acc_abastecimento_indice, 
               acc_abastecimento_placa
        ) VALUES(
               C_CURSOR.ACC_ABASTECIMENTO_NUMERO,
               C_CURSOR.ACC_CONTAS_CICLO,
               C_CURSOR.POS_CADASTRO_CGC,
               C_CURSOR.FRT_CONJVEICULO_CODIGO,
               C_CURSOR.ACC_ACONTAS_NUMERO,
               C_CURSOR.GLB_ROTA_CODIGO_OPERACAO,
               C_CURSOR.FRT_MOTORISTA_CODIGO,
               C_CURSOR.CAX_OPERACAO_CODIGO,
               C_CURSOR.ACC_ABASTECIMENTO_QUANTIDADE,
               C_CURSOR.ACC_ABASTECIMENTO_DATA,
               C_CURSOR.ACC_ABASTECIMENTO_KM,
               C_CURSOR.ACC_ABASTECIMENTO_VALOR,
               C_CURSOR.ACC_ABASTECIMENTO_TPREG,
               C_CURSOR.ACC_ABASTECIMENTO_OBS,
               C_CURSOR.USU_USUARIO_CODIGOCAD,
               C_CURSOR.POS_COMBUSTIVEL_CODIGO,
               C_CURSOR.ACC_ABASTECIMENTO_INDICE,
               C_CURSOR.ACC_ABASTECIMENTO_PLACA);   
      exception when others then                   
        tdvadm.pkg_glb_log.sp_GravaLog(
          'Erro ao tentar inserir abastecimentos não encontrados na TDV, '||
          'placa:  '||C_CURSOR.ACC_ABASTECIMENTO_PLACA||' - '||
          'POS_COMBUSTIVEL_CODIGO = '||C_CURSOR.POS_COMBUSTIVEL_CODIGO||' - '||sqlerrm,
          CODIGO_APP,
          tdvadm.pkg_glb_log.LOG_ERRO,
          CODIGO_MACRO,
          C_CURSOR.ACC_ABASTECIMENTO_NUMERO); -- como neste caso não tenho um campo chave, gravo o local que ocorreu o log        
      end;
      
      END LOOP;
      
      --v_qtdeabastecimentos :=  SQL%ROWCOUNT;                      

      -- deleta o que importou
      DELETE TDVADM.T_ACC_ABASTECIMENTO2 AB2
      WHERE 0 < (SELECT COUNT(*)
                 FROM TDVADM.T_ACC_ABASTECIMENTO AB
                 WHERE AB.ACC_ABASTECIMENTO_NUMERO = AB2.ACC_ABASTECIMENTO_NUMERO
                   AND AB.POS_CADASTRO_CGC = AB2.POS_CADASTRO_CGC
                   AND AB.ACC_ABASTECIMENTO_QUANTIDADE = AB2.ACC_ABASTECIMENTO_QUANTIDADE
                   AND AB.ACC_ABASTECIMENTO_VALOR = AB2.ACC_ABASTECIMENTO_VALOR
                   AND AB.ACC_ABASTECIMENTO_KM = AB2.ACC_ABASTECIMENTO_KM)
        AND 0 < (SELECT COUNT(*) FROM TDVADM.t_pos_cadastro pc WHERE pc.pos_cadastro_cgc = ab2.pos_cadastro_cgc);


      
      -- coloca frota 00000 para quem não encontrou nada
      UPDATE TDVADM.t_acc_abastecimento ab
      SET ab.frt_conjveiculo_codigo = '0000000'
      WHERE ab.frt_conjveiculo_codigo = '       ';

     
      
      -- PEGA OS POSTOS NÃO CADASTRADOS   
      open C_POSTOSNCAD FOR SELECT PNC.POS_CADASTRO_CGC CNPJ,
                                   MAX(PNC.ACC_ABASTECIMENTO_DATA) UTL_ABASTECIMENTO,
                                   COUNT(*) QTDE
                            FROM TDVADM.T_ACC_ABASTECIMENTOSEMPOSTO PNC
                            GROUP BY PNC.POS_CADASTRO_CGC;

     tdvadm.pkg_glb_SqlCursor.TiposComuns.Formato := 'H';
     tdvadm.pkg_glb_SqlCursor.TipoHederHTML.Alinhamento := 'Left';
     vMessage := empty_clob;
     vLinha1.delete;
     tdvadm.pkg_glb_SqlCursor.sp_Get_Cursor(C_POSTOSNCAD,vLinha1);
     vAuxiliar := vLinha1.count;
     for i in 1 .. vLinha1.count loop
        if tdvadm.pkg_glb_SqlCursor.TiposComuns.Formato = 'H' then
           vMessage := vMessage || vLinha1(i);
        Else
            vMessage := vMessage || vLinha1(i) || chr(10);
        End if;
     End loop; 
     Begin
        close C_POSTOSNCAD;
     exception
       When OTHers Then
         vAuxiliar := vAuxiliar;
       end ;
     wservice.pkg_glb_email.SP_ENVIAEMAIL('CTF - POSTOS NAO CADASTRADOS NA DELLA VOLPE',
                                          vMessage,
                                          'aut-e@dellavolpe.com.br',
                                          'sdrumond@dellavolpe.com.br;ariano.pires@dellavolpe.com.br;edmilson.mendes@dellavolpe.com.br;rmsantos@dellavolpe.com.br');           



      -- PLACAS SEM CONJUNTO   
      open C_PLACASSCONJ FOR SELECT ab.acc_abastecimento_placa PLACA,
                                    MAX(ab.ACC_ABASTECIMENTO_DATA) UTL_ABASTECIMENTO,
                                    COUNT(*) QTDE
                             FROM TDVADM.t_acc_abastecimento ab
                             WHERE ab.frt_conjveiculo_codigo = '0000000'
                               AND AB.ACC_ABASTECIMENTO_DATA >= '01/01/2017'
                             GROUP BY ab.acc_abastecimento_placa;

     tdvadm.pkg_glb_SqlCursor.TiposComuns.Formato := 'H';
     tdvadm.pkg_glb_SqlCursor.TipoHederHTML.Alinhamento := 'Left';
     vMessage := empty_clob;
     vLinha1.delete;
     tdvadm.pkg_glb_SqlCursor.sp_Get_Cursor(C_PLACASSCONJ,vLinha1);
     for i in 1 .. vLinha1.count loop
        if tdvadm.pkg_glb_SqlCursor.TiposComuns.Formato = 'H' then
           vMessage := vMessage || vLinha1(i);
        Else
            vMessage := vMessage || vLinha1(i) || chr(10);
        End if;
     End loop; 
     Begin
        close C_PLACASSCONJ;
     exception
       When OTHers Then
         vAuxiliar := vAuxiliar;
       end ;
     wservice.pkg_glb_email.SP_ENVIAEMAIL('CTF - PLACAS SEM CONJUNTO',
                                          vMessage,
                                          'aut-e@dellavolpe.com.br',
                                          'sdrumond@dellavolpe.com.br;ariano.pires@dellavolpe.com.br;edmilson.mendes@dellavolpe.com.br;rmsantos@dellavolpe.com.br');           




    -- ENCONTROU MAIS TINHA VALOR OU QTDE DIFERENTE
      open C_ABATDUPCVLRDIF FOR SELECT ab2.acc_abastecimento_numero CODABAST,
                                       ab2.frt_conjveiculo_codigo conjunto,
                                       ab2.acc_abastecimento_placa placa,
                                       ab2.acc_abastecimento_data DATA,
                                       ab2.acc_abastecimento_quantidade litrosctf,
                                       ab2.acc_abastecimento_valor valorctf,
                                       ab2.acc_abastecimento_km kmctf,
                                       (SELECT AB.ACC_ABASTECIMENTO_QUANTIDADE
                                        FROM TDVADM.T_ACC_ABASTECIMENTO AB
                                        WHERE AB.ACC_ABASTECIMENTO_NUMERO = AB2.ACC_ABASTECIMENTO_NUMERO
                                          AND AB.POS_CADASTRO_CGC = AB2.POS_CADASTRO_CGC) LITROSTDV,
                                       (SELECT AB.acc_abastecimento_valor
                                        FROM TDVADM.T_ACC_ABASTECIMENTO AB
                                        WHERE AB.ACC_ABASTECIMENTO_NUMERO = AB2.ACC_ABASTECIMENTO_NUMERO
                                          AND AB.POS_CADASTRO_CGC = AB2.POS_CADASTRO_CGC) VALORTDV,
                                       (SELECT AB.ACC_ABASTECIMENTO_KM
                                        FROM TDVADM.T_ACC_ABASTECIMENTO AB
                                        WHERE AB.ACC_ABASTECIMENTO_NUMERO = AB2.ACC_ABASTECIMENTO_NUMERO
                                          AND AB.POS_CADASTRO_CGC = AB2.POS_CADASTRO_CGC) KMTDV
                                FROM TDVADM.T_ACC_ABASTECIMENTO2 AB2
                                WHERE ab2.acc_abastecimento_data >= '01/01/2017'
                                  and 0 < (SELECT COUNT(*)
                                           FROM TDVADM.T_ACC_ABASTECIMENTO AB
                                           WHERE AB.ACC_ABASTECIMENTO_NUMERO = AB2.ACC_ABASTECIMENTO_NUMERO
                                             AND AB.POS_CADASTRO_CGC = AB2.POS_CADASTRO_CGC)
                                  AND  0 = (SELECT COUNT(*)
                                           FROM TDVADM.T_ACC_ABASTECIMENTO AB
                                           WHERE AB.ACC_ABASTECIMENTO_NUMERO = AB2.ACC_ABASTECIMENTO_NUMERO
                                             AND AB.POS_CADASTRO_CGC = AB2.POS_CADASTRO_CGC
                                             AND AB.ACC_ABASTECIMENTO_QUANTIDADE = AB2.ACC_ABASTECIMENTO_QUANTIDADE
                                             AND AB.ACC_ABASTECIMENTO_VALOR = AB2.ACC_ABASTECIMENTO_VALOR
                                             AND AB.ACC_ABASTECIMENTO_KM = AB2.ACC_ABASTECIMENTO_KM );


     tdvadm.pkg_glb_SqlCursor.TiposComuns.Formato := 'H';
     tdvadm.pkg_glb_SqlCursor.TipoHederHTML.Alinhamento := 'Left';
     vMessage := empty_clob;
     vLinha1.delete;
     tdvadm.pkg_glb_SqlCursor.sp_Get_Cursor(C_ABATDUPCVLRDIF,vLinha1);
     for i in 1 .. vLinha1.count loop
        if tdvadm.pkg_glb_SqlCursor.TiposComuns.Formato = 'H' then
           vMessage := vMessage || vLinha1(i);
        Else
            vMessage := vMessage || vLinha1(i) || chr(10);
        End if;
     End loop; 
     Begin
        close C_ABATDUPCVLRDIF;
     exception
       When OTHers Then
         vAuxiliar := vAuxiliar;
       end ;

     wservice.pkg_glb_email.SP_ENVIAEMAIL('CTF - VALOR OU QTDE DIFERENTE',
                                          vMessage,
                                          'aut-e@dellavolpe.com.br',
                                          'sdrumond@dellavolpe.com.br;ariano.pires@dellavolpe.com.br;edmilson.mendes@dellavolpe.com.br;rmsantos@dellavolpe.com.br');           


      COMMIT;
    exception when others then
      tdvadm.pkg_glb_log.sp_GravaLog(
        'Erro ao efetuar a critica da integração CTF, '||sqlerrm,
        CODIGO_APP,
        tdvadm.pkg_glb_log.LOG_ERRO,
        CODIGO_MACRO,
        'pkg_wsd_ctf.SP_WSD_CRITICAINTEGRACAO'); -- como neste caso não tenho um campo chave, gravo o local que ocorreu o log        
    end;

  END  ;
0
3
vLinha1.count
i
vAuxiliar
