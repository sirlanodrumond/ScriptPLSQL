PL/SQL Developer Test script 3.0
69
/*
DIRECTORY_NAME                 DIRECTORY_PATH
------------------------------ --------------------------------------------------------------------------------
OMNIDATA                       /omnidata
OMNIDATAENT                    /omnidata/entrada
OMNIDATAENTANT                 /omnidata/entrada/anteriores
OMNIDATASAIDA                  /omnidata/saída
OMNIDATASAIDAEMPROC            /omnidata/saída/em_processamento
OMNIDATASAIDAPROC              /omnidata/saída/processadas
*/

DECLARE
 arquivo_saida  UTL_File.File_Type;
 vReferencia char(6);
Begin
    vReferencia := '201703';

    BEGIN
        arquivo_saida := UTL_File.Fopen('OMNIDATASAIDA','dellavolpe-' || to_char(sysdate,'yyyymmddhh24mi') || '-receita_simples.txt', 'w');
        For Reg_Linha in (SELECT I.CPF
                          FROM TDVADM.V_CTB_PROPRIETARIOS I
                          WHERE I.REF1 = vReferencia
                            AND LENGTH(TRIM(I.CPF)) > 11
                         ) Loop
            UTL_File.Put_Line(arquivo_saida, trim(Reg_linha.CPF));
        End Loop;
        UTL_File.Fclose(arquivo_saida);

        arquivo_saida := UTL_File.Fopen('OMNIDATASAIDA','dellavolpe-' || to_char(sysdate,'yyyymmddhh24mi') || '-receita_pj.txt', 'w');
        For Reg_Linha in (SELECT I.CPF
                          FROM TDVADM.V_CTB_PROPRIETARIOS I
                          WHERE I.REF1 = vReferencia
                            AND LENGTH(TRIM(I.CPF)) > 11
                         ) Loop
            UTL_File.Put_Line(arquivo_saida, trim(Reg_linha.CPF));
        End Loop;
        UTL_File.Fclose(arquivo_saida);

        arquivo_saida := UTL_File.Fopen('OMNIDATASAIDA','dellavolpe-' || to_char(sysdate,'yyyymmddhh24mi') || '-receita_sintegra.txt', 'w');
        For Reg_Linha in (SELECT I.CPF,I.UF
                          FROM TDVADM.V_CTB_PROPRIETARIOS I
                          WHERE I.REF1 = vReferencia
                            AND LENGTH(TRIM(I.CPF)) > 11
                         ) Loop
            UTL_File.Put_Line(arquivo_saida, trim(Reg_linha.CPF) || '|' || trim(Reg_linha.Uf) );
        End Loop;
        UTL_File.Fclose(arquivo_saida);

    EXCEPTION
          WHEN UTL_FILE.INVALID_OPERATION THEN
                   Dbms_Output.put_line(SQLERRM);
                   Dbms_Output.Put_Line('Operação inválida no arquivo.');
                   UTL_File.Fclose(arquivo_saida);
          WHEN UTL_FILE.WRITE_ERROR THEN
                   Dbms_Output.Put_Line('Erro de gravação no arquivo.');
                   UTL_File.Fclose(arquivo_saida);
          WHEN UTL_FILE.INVALID_PATH THEN
                   Dbms_Output.Put_Line('Diretório inválido.');
                   UTL_File.Fclose(arquivo_saida);
          WHEN UTL_FILE.INVALID_MODE THEN
                   Dbms_Output.Put_Line('Modo de acesso inválido.');
                   UTL_File.Fclose(arquivo_saida);
          WHEN Others THEN
                   Dbms_Output.put_line(SQLERRM);
                   Dbms_Output.Put_Line('Problemas na geração do arquivo.');
                   UTL_File.Fclose(arquivo_saida);
    END;

End; 
0
0
