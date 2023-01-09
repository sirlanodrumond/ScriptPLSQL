PL/SQL Developer Test script 3.0
55
/*

SELECT * FROM dba_directories
CREATE OR REPLACE directory OMNIDATA AS '/omnidata';


DIRECTORY_NAME                 DIRECTORY_PATH
------------------------------ --------------------------------------------------------------------------------
OMNIDATA                       /omnidata
OMNIDATAENT                    /omnidata/entrada
OMNIDATAENTANT                 /omnidata/entrada/anteriores
OMNIDATASAIDA                  /omnidata/sa�da
OMNIDATASAIDAEMPROC            /omnidata/sa�da/em_processamento
OMNIDATASAIDAPROC              /omnidata/sa�da/processadas
*/

DECLARE
 arquivo_entrada UTL_File.File_Type;
 v_linha         varchar2(1024);
Begin

    BEGIN
        arquivo_entrada := UTL_File.Fopen('OMNIDATAENT','resposta.txt', 'r');
    loop

      utl_file.get_line(arquivo_entrada, v_linha);
      dbms_output.put_line(v_linha);

    end loop;


    EXCEPTION
          WHEN NO_DATA_FOUND THEN
                   Dbms_Output.Put_Line('Fim do Arquivo.');
                   UTL_File.Fclose(arquivo_entrada);
          WHEN UTL_FILE.INVALID_OPERATION THEN
                   Dbms_Output.put_line(SQLERRM);
                   Dbms_Output.Put_Line('Opera��o inv�lida no arquivo.');
                   UTL_File.Fclose(arquivo_entrada);
          WHEN UTL_FILE.WRITE_ERROR THEN
                   Dbms_Output.Put_Line('Erro de grava��o no arquivo.');
                   UTL_File.Fclose(arquivo_entrada);
          WHEN UTL_FILE.INVALID_PATH THEN
                   Dbms_Output.Put_Line('Diret�rio inv�lido.');
                   UTL_File.Fclose(arquivo_entrada);
          WHEN UTL_FILE.INVALID_MODE THEN
                   Dbms_Output.Put_Line('Modo de acesso inv�lido.');
                   UTL_File.Fclose(arquivo_entrada);
          WHEN Others THEN
                   Dbms_Output.put_line(SQLERRM);
                   Dbms_Output.Put_Line('Problemas na gera��o do arquivo.');
                   UTL_File.Fclose(arquivo_entrada);
    END;

End; 
0
0
