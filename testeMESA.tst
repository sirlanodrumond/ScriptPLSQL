PL/SQL Developer Test script 3.0
310
-- Created on 28/05/2021 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  vSolVeic     tdvadm.t_fcf_solveic.fcf_solveic_cod%type := 894496; -- Sistema Novo [Valor da excecao errado]
  tpSolveic    tdvadm.t_fcf_solveic%rowtype;
  tpFCFMemo    tdvadm.t_fcf_fretecarmemohist%rowtype;
  tpFreteMesa  tdvadm.t_fcf_fretecar%rowtype;
  tpCadFrete   tdvadm.t_cad_frete%rowtype;
  vQuerySTR    varchar2(1000) := '<parametros>
                                     <inputs>
                                        <input>
                                           <usuario>jsantos</usuario>
                                           <aplicacao>veicdisp</aplicacao>
                                           <rota>011</rota>
                                           <versao>21.2.17.0</versao>
                                           <solicitacao_codigo><<SOLVEIC>></solicitacao_codigo>
                                            <veiculo_tipo><<CODVEIC>></veiculo_tipo>
                                           <procedure_name>sp_get_excecao</procedure_name>
                                           <package_name>pkg_veicdisp</package_name>
                                        </input>
                                     </inputs>
                                  </parametros>';
  vExcecao     number;  
  pStatus      char(1);
  pMessage     Varchar2(2000);
  pParamsSaida clob;
  vValorVfrete  number;
  vVfrete      varchar2(10);
begin
  -- Test statements here
  dbms_output.put_line('BUSCANDO SOLVEIC [' || vSolVeic || ']');
  Begin
     select *
       into tpSolveic
     from tdvadm.t_fcf_solveic sv
     where sv.fcf_solveic_cod = vSolVeic;
  exception
    When NO_DATA_FOUND Then
      dbms_output.put_line(chr(9) || 'Codigo Solicitacao Não existe na SOLVEIC [' || vSolVeic || ']');
      Return;
    When TOO_MANY_ROWS Then
      dbms_output.put_line(chr(9) || 'Codigo Solicitacao Retornou maus de uma linha SOLVEIC [' || vSolVeic || ']');
      Return;
    End;
  Begin
     Select *
       into tpFCFMemo
     from tdvadm.t_fcf_fretecarmemohist mh
     where mh.fcf_fretecarmemohist_programa = 'prjsolveic.exe'
       and mh.fcf_solveic_cod = vSolVeic
       and mh.fcf_fretecarmemohist_gravacao = (select max(mh1.fcf_fretecarmemohist_gravacao)
                                               from tdvadm.t_fcf_fretecarmemohist mh1
                                               where mh1.fcf_fretecarmemohist_programa = mh.fcf_fretecarmemohist_programa
                                                 and mh1.fcf_solveic_cod = mh.fcf_solveic_cod);
  exception
    When NO_DATA_FOUND Then
      dbms_output.put_line(chr(9) || 'Codigo Solicitacao Não existe na FRETECARMEMO [' || vSolVeic || ']');
      Return;
    When TOO_MANY_ROWS Then
      dbms_output.put_line(chr(9) || 'Codigo Solicitacao Retornou mais de uma linha FRETECARMEMO [' || vSolVeic || ']');
      Return;
    End;
  
  -- COMPARANDO SOLVEIC COM MEMO
  -- Critica Campos Obigatorios
  dbms_output.put_line('VALIDANDO SOLVEIC');
  dbms_output.put_line('');
  dbms_output.put_line('FCF_SOLVEIC_COD');
  If nvl(tpSolveic.Fcf_Solveic_Cod,9) <> nvl(tpFCFMemo.Fcf_Solveic_Cod,8) Then
     dbms_output.put_line(chr(9) || 'Codigo Solicitacao diferente SOL [' || tpSolveic.Fcf_Solveic_Cod || '] - MEMO [' || tpFCFMemo.Fcf_Solveic_Cod || ']' );
  End If; 


  dbms_output.put_line('FCF_TPVEICULO_CODIGO');
  If nvl(tpSolveic.Fcf_Tpveiculo_Codigo,'X') <> nvl(tpFCFMemo.Fcf_Tpveiculo_Codigo,'Y') Then
     dbms_output.put_line(chr(9) || 'Tipo de Veiculo diferente SOL [' || tpSolveic.Fcf_Tpveiculo_Codigo || '] - MEMO ['|| tpFCFMemo.Fcf_Tpveiculo_Codigo || ']' );
  End If; 

  dbms_output.put_line('FCF_FRETECARMEMO_DTSOLVEIC');
  If nvl(tpSolveic.Fcf_Solveic_Dtsoli,'01/01/1900') <> nvl(tpFCFMemo.Fcf_Fretecarmemo_Dtsolveic,'01/01/1901') Then
     dbms_output.put_line(chr(9) || 'Data da Solicitacao diferente SOL [' || to_char(tpSolveic.Fcf_Solveic_Dtsoli,'dd/mm/yyyy hh24:mi:ss') || '] - MEMO [' || to_char(tpFCFMemo.fcf_fretecarmemo_dtsolveic,'dd/mm/yyyy hh24:mi:ss') || ']' );
  End If; 

  dbms_output.put_line('FCF_ANTT_RETORNOVAZIO');
  If nvl(tpSolveic.Fcf_Solveic_Retornovazio,'X') <> nvl(tpFCFMemo.fcf_antt_retornovazio,'Y') Then
     dbms_output.put_line(chr(9) || 'Retorno de Vazio diferente SOL [' || tpSolveic.Fcf_Solveic_Retornovazio || '] - MEMO [' || tpFCFMemo.Fcf_Antt_Retornovazio || ']' );
  End If; 

  dbms_output.put_line('GLB_CEP_CODIGORETORNOVAZIO');
/*  If tpSolveic. <> tpFCFMemo.Glb_Cep_Codigoretornovazio Then
     dbms_output.put_line(chr(9) || 'Codigo Solicitacao diferente [' || tpSolveic || ']-[' || tpFCFMemo.Glb_Cep_Codigoretornovazio || ']' );
  End If; 
*/
  dbms_output.put_line('FCF_ANTT_CONTAINER');
  If tpSolveic.Fcf_Solveic_Container <> tpFCFMemo.Fcf_Antt_Container Then
     dbms_output.put_line(chr(9) || 'Containes diferente SOL [' || tpSolveic.Fcf_Solveic_Container || '] - MEMO [' || tpFCFMemo.Fcf_Antt_Container || ']' );
  End If; 



-- VERIFICANDO OS DADOS COM A MESA
  dbms_output.put_line('');
  dbms_output.put_line('VALIDANDO MESA');
  dbms_output.put_line('');
  dbms_output.put_line('FCF_FRETECAR_ROWID');
  If tpSolveic.Fcf_Fretecar_Rowid is not null Then 

     Begin
        select *
          into tpFreteMesa
        from tdvadm.t_fcf_fretecar fc
        where fc.fcf_fretecar_rowid = tpSolveic.Fcf_Fretecar_Rowid;
        dbms_output.put_line(chr(9) || 'Valor do Frete MESA   [' || tpFreteMesa.Fcf_Fretecar_Valor || ']');
        dbms_output.put_line(chr(9) || 'Valor do Pedagio MESA [' || tpFreteMesa.Fcf_Fretecar_Pedagio || ']');
        dbms_output.put_line(chr(9) || 'Pedagio no Frete MESA [' || tpFreteMesa.Fcf_Fretecar_Pednofrete || ']');
        dbms_output.put_line(chr(9) || 'Peso DE na MESA       [' || tpFreteMesa.Fcf_Fretecar_Pesode || ']');
        dbms_output.put_line(chr(9) || 'Peso ATE na MESA      [' || tpFreteMesa.Fcf_Fretecar_Pesoate || ']');
     exception
       When OTHERS Then
          dbms_output.put_line(chr(9) || 'RowId não localizado na MESA [' || tpSolveic.Fcf_Fretecar_Rowid  || ']');
     End;


     Begin
        Select *
          into tpFCFMemo
        from tdvadm.t_fcf_fretecarmemohist mh
        where mh.fcf_fretecarmemohist_programa = 'prj_veiculodisp.exe'
          and mh.fcf_solveic_cod = vSolVeic
          and mh.fcf_fretecarmemohist_gravacao = (select max(mh1.fcf_fretecarmemohist_gravacao)
                                                  from tdvadm.t_fcf_fretecarmemohist mh1
                                                  where mh1.fcf_fretecarmemohist_programa = mh.fcf_fretecarmemohist_programa
                                                    and mh1.fcf_solveic_cod = mh.fcf_solveic_cod);
     exception
       When NO_DATA_FOUND Then
         dbms_output.put_line(chr(9) || 'Codigo Solicitacao Não existe na FRETECARMEMO [' || vSolVeic || ']');
         Return;
       End;



     If tpSolveic.Fcf_Fretecar_Rowid <> tpFCFMemo.Fcf_Fretecar_Rowid Then
        dbms_output.put_line(chr(9) || 'Linha do FRETE diferente SOL [' || tpSolveic.Fcf_Fretecar_Rowid || '] - MEMO [' || tpFCFMemo.Fcf_Fretecar_Rowid || ']' );
     End If; 

     dbms_output.put_line('FCF_FRETECARMEMO_TPFRETE [' || tpFCFMemo.Fcf_Fretecarmemo_Tpfrete || ']' );
     If tpSolveic.Fcf_Solveic_Tpfrete <> tpFCFMemo.Fcf_Fretecarmemo_Tpfrete Then
        dbms_output.put_line(chr(9) || 'Tipo de Frete SOL [' || tpSolveic.Fcf_Solveic_Tpfrete || '] - MEMO [' || tpFCFMemo.Fcf_Fretecarmemo_Tpfrete || ']' );
     End If; 

     dbms_output.put_line('FCF_FRETECARMEMO_FRETE [' || tdvadm.f_mascara_valor(tpFCFMemo.Fcf_Fretecarmemo_Frete,10,2) || ']' );
     If tpSolveic.Fcf_Solveic_Valorfrete <> tpFCFMemo.Fcf_Fretecarmemo_Frete Then
        dbms_output.put_line(chr(9) || 'Valor FRETE diferente SOL [' || tpSolveic.Fcf_Solveic_Valorfrete || ']- MEMO [' || tpFCFMemo.Fcf_Fretecarmemo_Frete || ']' );
     End If; 

     dbms_output.put_line('FCF_FRETECARMEMO_DESINENCIAFRETE [' || tpFCFMemo.Fcf_Fretecarmemo_Desinenciafrete || ']' );
     If tpSolveic.Fcf_Solveic_Desinencia <> tpFCFMemo.Fcf_Fretecarmemo_Desinenciafrete Then
        dbms_output.put_line(chr(9) || 'DESINENCIA do FRETE diferente SOL [' || tpSolveic.Fcf_Solveic_Desinencia || '] - MEMO [' || tpFCFMemo.Fcf_Fretecarmemo_Desinenciafrete || ']' );
     End If; 

     dbms_output.put_line('FCF_FRETECARMEMO_PEDAGIO [' || tpFCFMemo.Fcf_Fretecarmemo_Pedagio || ']' );
     If tpSolveic.Fcf_Solveic_Pedagio <> tpFCFMemo.Fcf_Fretecarmemo_Pedagio Then
        dbms_output.put_line(chr(9) || ' diferente SOL [' || tpSolveic.Fcf_Solveic_Pedagio || '] - MEMO [' || tpFCFMemo.Fcf_Fretecarmemo_Pedagio || ']' );
     End If; 

     dbms_output.put_line('FCF_FRETECARMEMO_PEDAGIONOFRETE [' || tpFCFMemo.Fcf_Fretecarmemo_Pedagionofrete || ']' );
     If tpSolveic.Fcf_Solveic_Pednofrete <> tpFCFMemo.Fcf_Fretecarmemo_Pedagionofrete Then
        dbms_output.put_line(chr(9) || ' Pedagio no FRETE diferente SOL [' || tpSolveic.Fcf_Solveic_Pednofrete || '] - MEMO [' || tpFCFMemo.Fcf_Fretecarmemo_Pedagionofrete || ']' );
     End If; 

     dbms_output.put_line('FCF_FRETECARMEMO_QTDEENTREGA [' || tpFCFMemo.Fcf_Fretecarmemo_Qtdeentrega || ']' );
     If tpSolveic.Fcf_Solveic_Qtdentrega <> tpFCFMemo.Fcf_Fretecarmemo_Qtdeentrega Then
        dbms_output.put_line(chr(9) || ' Quandtidde de Entregas diferente SOL [' || tpSolveic.Fcf_Solveic_Qtdentrega || '] - MEMO [' || tpFCFMemo.Fcf_Fretecarmemo_Qtdeentrega || ']' );
     End If; 

     If tpFCFMemo.Fcf_Fretecarmemo_Qtdeentrega > 0 Then
        If tpFCFMemo.Fcf_Fretecarmemo_Entrega > 0 Then
           dbms_output.put_line('FCF_FRETECARMEMO_ENTREGA [' || tpFCFMemo.Fcf_Fretecarmemo_Entrega || ']') ;
        Else
           dbms_output.put_line('FCF_FRETECARMEMO_ENTREGA [ NAO CALCULADO ]') ;
        End If; 
     End If; 

     dbms_output.put_line('FCF_FRETECARMEMO_QTDECOLETA [' || tpFCFMemo.Fcf_Fretecarmemo_Qtdecoleta || ']' );
     If tpSolveic.Fcf_Solveic_Qtdecoletas <> tpFCFMemo.Fcf_Fretecarmemo_Qtdecoleta Then
        dbms_output.put_line(chr(9) || ' Quantidade de Coleta diferente SOL [' || tpSolveic.Fcf_Solveic_Qtdecoletas || '] - MEMO [' || tpFCFMemo.Fcf_Fretecarmemo_Qtdecoleta || ']' );
     End If; 

     If tpFCFMemo.Fcf_Fretecarmemo_Qtdecoleta > 0 Then
        If tpFCFMemo.Fcf_Fretecarmemo_Coleta > 0 Then
           dbms_output.put_line('FCF_FRETECARMEMO_COLETA [' || tpFCFMemo.Fcf_Fretecarmemo_Coleta || ']') ;
        Else
           dbms_output.put_line('FCF_FRETECARMEMO_COLETA [ NAO CALCULADO ]') ;
        End If; 
     End If; 

     dbms_output.put_line('FCF_FRETECARMEMO_EXCECAO [' || tpFCFMemo.Fcf_Fretecarmemo_Excecao || ']' );
     If tpSolveic.Fcf_Solveic_Valorexcecao <> tpFCFMemo.Fcf_Fretecarmemo_Excecao Then
        dbms_output.put_line(chr(9) || ' Valor de Excecao diferente SOL [' || tpSolveic.Fcf_Solveic_Valorexcecao || '] - MEMO [' || tpFCFMemo.Fcf_Fretecarmemo_Excecao || ']' );
     End If; 
      
     vQuerySTR := replace(vQuerySTR,'<<SOLVEIC>>',tpSolveic.Fcf_Solveic_Cod);
     vQuerySTR := replace(vQuerySTR,'<<CODVEIC>>',trim(tpSolveic.Fcf_Tpveiculo_Codigo));
     tdvadm.pkg_veicdisp.SP_Get_Excecao(vQuerySTR,
                                        pStatus,
                                        pMessage,
                                        pParamsSaida);

     dbms_output.put_line(chr(9) || 'Ret tdvadm.pkg_veicdisp.SP_Get_Excecao :');
     dbms_output.put_line('**************************************************************');
     dbms_output.put_line(pParamsSaida);
     dbms_output.put_line('**************************************************************');
     dbms_output.put_line('FCF_FRETECARMEMO_PARTICULARIDADE [' || tpFCFMemo.Fcf_Fretecarmemo_Particularidade || ']' );
     If tpSolveic.Fcf_Solveic_Valorparticilaridade <> tpFCFMemo.Fcf_Fretecarmemo_Particularidade Then
        dbms_output.put_line(chr(9) || ' Valor de Particularidade diferente SOL [' || tpSolveic.Fcf_Solveic_Valorparticilaridade || '] - MEMO [' || tpFCFMemo.Fcf_Fretecarmemo_Particularidade || ']' );
        If tdvadm.fn_fcf_getvalorparticularidades(vSolVeic) <> tpFCFMemo.Fcf_Fretecarmemo_Particularidade Then
           dbms_output.put_line(chr(9) || ' Valor Correto da Particularidade CALC [' || tdvadm.fn_fcf_getvalorparticularidades(vSolVeic) || ']' );
        End If;
     End If; 

     dbms_output.put_line('FCF_FRETECARMEMO_PERCENTEXPR [' || tpFCFMemo.Fcf_Fretecarmemo_Percentexpr || ']' );
     If tpFCFMemo.Fcf_Fretecarmemo_Percentexpr is null Then
        dbms_output.put_line(chr(9) || 'Percentual de Expresso nao preenchido MEMO [' || tpFCFMemo.Fcf_Fretecarmemo_Percentexpr || ']' );
     End If; 

    dbms_output.put_line('FCF_FRETECARMEMO_EXPRESSO [' || tpFCFMemo.Fcf_Fretecarmemo_Expresso || ']' );
    If nvl(tpFCFMemo.Fcf_Fretecarmemo_Expresso,0) = 0 Then
        dbms_output.put_line(chr(9) || ' Expresso Não calculado ');
     Else
       If ((tpSolveic.Fcf_Solveic_Valorfrete * tpFCFMemo.Fcf_Fretecarmemo_Percentexpr) / 100 ) <> tpFCFMemo.Fcf_Fretecarmemo_Expresso Then
          dbms_output.put_line(chr(9) || ' Valor do Expresso Sem Pedagio Errado CALC [' || ((tpSolveic.Fcf_Solveic_Valorfrete * tpFCFMemo.Fcf_Fretecarmemo_Percentexpr) / 100 ) || '] - ' || 
                                                         'MEMO [' || tpFCFMemo.Fcf_Fretecarmemo_Expresso || ']' );
       Else
         dbms_output.put_line(chr(9) || ' Valor do Expresso Sem Pedagio OK');
       End If;
       If (( ( tpSolveic.Fcf_Solveic_Valorfrete + tpSolveic.Fcf_Solveic_Pedagio ) * tpFCFMemo.Fcf_Fretecarmemo_Percentexpr) / 100 ) <> tpFCFMemo.Fcf_Fretecarmemo_Expresso Then
          dbms_output.put_line(chr(9) || ' Valor do Expresso Com Pedagio Errado CALC [' || ((( tpSolveic.Fcf_Solveic_Valorfrete + + tpSolveic.Fcf_Solveic_Pedagio ) * tpFCFMemo.Fcf_Fretecarmemo_Percentexpr) / 100 ) || '] - ' || 
                                                         'MEMO [' || tpFCFMemo.Fcf_Fretecarmemo_Expresso || ']' );
       Else
         dbms_output.put_line(chr(9) || ' Valor do Expresso Com Pedagio OK');
       End If;
     End If; 
       
--     dbms_output.put_line('');
--     If tpSolveic <> tpFCFMemo.Fcf_Fretecarmemo_Km Then
--        dbms_output.put_line(chr(9) || ' diferente [' || tpSolveic || ']-[' || tpFCFMemo || ']' );
--     End If; 

--     dbms_output.put_line('');
--     If tpSolveic <> tpFCFMemo.Fcf_Fretecarmemo_Kmcoleta Then
--        dbms_output.put_line(chr(9) || ' diferente [' || tpSolveic || ']-[' || tpFCFMemo || ']' );
--     End If; 


     -- Procurando por acrecsimo
     dbms_output.put_line('');
     dbms_output.put_line('VERIFICANDO ACRESCIMO');
     Begin
        SELECT *
          into tpCadFrete
        from tdvadm.t_cad_frete cf
        where cf.fcf_solveic_cod = tpSolveic.Fcf_Solveic_Cod;
        dbms_output.put_line(chr(9) || 'Status                              [' || tpCadFrete.Cad_Frete_Status || ']' );
        dbms_output.put_line(chr(9) || 'Solicitacao                         [' || tpCadFrete.Cad_Frete_Solicitacao || ']' );
        dbms_output.put_line(chr(9) || 'Acrescimo                           [' || tpCadFrete.Cad_Frete_Novovalor || ']' );
        dbms_output.put_line(chr(9) || 'Ajudantes                           [' || tpCadFrete.Cad_Frete_Novovalor_Ajudante || ']' );
     Exception
       When NO_DATA_FOUND Then
        dbms_output.put_line(chr(9) || 'Solicticao Sem Acrescimo            [' || vSolVeic || ']' );
       When TOO_MANY_rows Then         
        dbms_output.put_line(chr(9) || 'Solicticao Com mais de um Acrescimo [' || vSolVeic || ']' );
     End;

     dbms_output.put_line(chr(9) || 'ACRESCIMO SOL                       [' || tpSolveic.Fcf_Solveic_Acrescimo || ']' );
     dbms_output.put_line(chr(9) || 'ACRESCIMO MEMO                      [' || tpFCFMemo.Fcf_Fretecarmemo_Acrescimo || ']' );


     dbms_output.put_line(chr(9) || 'Pedagio no Frete MESA [' || tpFreteMesa.Fcf_Fretecar_Pednofrete || ']');
     dbms_output.put_line(chr(9) || 'Peso DE na MESA       [' || tpFreteMesa.Fcf_Fretecar_Pesode || ']');
     dbms_output.put_line(chr(9) || 'Peso ATE na MESA      [' || tpFreteMesa.Fcf_Fretecar_Pesoate || ']');
     dbms_output.put_line('');
     dbms_output.put_line(chr(9) || 'Valor do Frete MESA   [' || tdvadm.f_mascara_valor(tpFreteMesa.Fcf_Fretecar_Valor,10,2) || ']');
     dbms_output.put_line(chr(9) || 'Valor do Pedagio MESA [' || tdvadm.f_mascara_valor(tpFreteMesa.Fcf_Fretecar_Pedagio,10,2) || ']');
     dbms_output.put_line(chr(9) || 'ACRESCIMO             [' || tdvadm.f_mascara_valor(tpFCFMemo.Fcf_Fretecarmemo_Acrescimo,10,2) || ']' );
     dbms_output.put_line(chr(9) || 'EXPRESSO              [' || tdvadm.f_mascara_valor(tpFCFMemo.Fcf_Fretecarmemo_Expresso,10,2) || ']' );
     dbms_output.put_line(chr(9) || 'Particularidade       [' || tdvadm.f_mascara_valor(tpFCFMemo.Fcf_Fretecarmemo_Particularidade,10,2) || ']' );
     dbms_output.put_line(chr(9) || 'Excecao               [' || tdvadm.f_mascara_valor(tpFCFMemo.Fcf_Fretecarmemo_Excecao,10,2) || ']' );

     dbms_output.put_line('');
     dbms_output.put_line(chr(9) || 'VALOR TOTAL DA VIAGEM [' || tdvadm.f_mascara_valor(tdvadm.pkg_fcf_veiculodisp.fn_valorFrete(tpSolveic.Fcf_Solveic_Cod,tpSolveic.Fcf_Solveic_Valorfrete),10,2) || ']');
     
     Begin
        select vf.con_conhecimento_codigo || vf.glb_rota_codigo,
               nvl(vf.con_valefrete_freteoriginal,0) + nvl(vf.con_valefrete_pedagiooriginal,0)
           into vVfrete,
                vValorVfrete
        from tdvadm.t_con_valefrete vf
        where vf.fcf_veiculodisp_codigo = tpFCFMemo.Fcf_Veiculodisp_Codigo
          and vf.fcf_veiculodisp_sequencia = tpFCFMemo.Fcf_Veiculodisp_Sequencia;
        dbms_output.put_line(chr(9) || 'VF ' || vVfrete || '          [' || tdvadm.f_mascara_valor(vValorVfrete,10,2) || ']');
     Exception
       When NO_DATA_FOUND Then
          dbms_output.put_line('VF Não LOCALIZADO PARA VDISP [' || tpFCFMemo.Fcf_Veiculodisp_Codigo || ']-[' || tpFCFMemo.Fcf_Veiculodisp_Sequencia || ']');
       End;

    
  Else
     dbms_output.put_line(chr(9) || 'Mesa Não Vinculada na Solicitacao   [' || vSolVeic || ']' );
  End If; 
end;
0
1
pParamsSaida
