PL/SQL Developer Test script 3.0
324
-- Created on 29/06/2018 by DESENV 
declare 
  -- Local variables here
  i integer;
  pRef               varchar2(6) := '201805';
  vValorPago         number;
  vValorLiquido      number;
  vBaseINSS          number;
  vBaseIR            number;
  vValorINSS         number;
  vValorSestSenat    number;
  vValorIR           number;
  vTetoINSS          number;
  vAliquotaBaseINSS  number;
  vAliquotaINSS      number;
  vAliquotaSestSenat number;
  vAliquotaBaseIR    number;
  vLinha             varchar2(200);
  vNomeArq1200       varchar2(100);
  vNomeArq1210       varchar2(100);
  vSeqArquivo        char(14);
  vSeq1200           integer;
  vSeq1210           integer;
begin
  -- Test statements here
  vSeqArquivo  := to_char(sysdate,'YYYYMMDDHH24MISS');
  vNomeArq1200 := 'REMUNERACAO_61139432000172_' ||vSeqArquivo || '.TXT';
  vNomeArq1210 := 'PAGRENDIMENTOS_61139432000172_' ||vSeqArquivo || '.TXT';
  vSeq1200     := 0;
  vSeq1210     := 0;

  delete tdvadm.T_UTI_ARQTMP a where a.uti_geraarqtmp_proc = 'eSocial1200';
  delete tdvadm.T_UTI_ARQTMP a where a.uti_geraarqtmp_proc = 'eSocial1210';
  commit;
  
  for c_msg in (Select * 
                from tdvadm.v_ctb_impostos_esocial i
                where i.ref1 = pRef
--                  and i.CPF in ('10865802653')
               )
  Loop
     If c_msg.CBO = '782510' Then
        vTetoINSS          := 608.44;
        vAliquotaINSS      := 11;
        vAliquotaSestSenat := 2.5;
        vAliquotaBaseINSS  := 20;
        vAliquotaBaseIR    := 10;
     Else
        vTetoINSS          := 608.44;
        vAliquotaINSS      := 20;
        vAliquotaSestSenat := 0;
        vAliquotaBaseINSS  := 100;
        vAliquotaBaseIR    := 100;
     End If;
     
     vValorPago      := round(nvl(c_msg.fretesp,0),2);
     vBaseINSS       := round(nvl(vValorPago *  (vAliquotaBaseINSS / 100),0),2);
     vBaseIR         := round(nvl(vValorPago *  (vAliquotaBaseIR / 100),0),2);
     vValorINSS      := round(nvl(vBaseINSS * (vAliquotaINSS / 100),0),2);
     If vValorINSS > vTetoINSS Then
        vValorINSS := vTetoINSS;
     End If;
     vValorSestSenat := round(nvl(vBaseINSS * (vAliquotaSestSenat / 100),0),2);
     vValorIR        := round(nvl(c_msg.ir,0),2);
     vValorLiquido   := round(nvl(vValorPago - vValorINSS - vValorSestSenat - vValorIR,0),2);

     -- 1200

     vLinha := 'A' || '|' || -- Identificador
               '1' || '|' || -- Finalidade
               '1' || '|' || -- Indicativo de Periodo
               c_msg.REF1 || '|' || -- periodo apuracao,
               trim(c_msg.CPF) || '|' || -- CPF,
               trim(c_msg.MATRICULA) || '|' || -- PIS
               '' || '|' || -- Indicador de Desconto
               TRIM(SUBSTR(c_msg.NOME,1,70)) || '|' || -- Nome
               to_char(c_msg.dtnascimento,'yyyymmdd') || '|' || -- Data Nascimento
               c_msg.CBO || -- CBO Carreteiro
                '||' ;
      
     INSERT INTO tdvadm.T_UTI_ARQTMP(UTI_ARQTMP_SEQ,
                              UTI_GERAARQTMP_PROC,
                              GLB_ROTA_CODIGO,
                              GLB_CLIENTE_CGCCPFCODIGO,
                              UTI_ARQTMP_LINHA,
                              UTI_ARQTMP_ARQUIVO)
                      Values (vSeq1200,
                              'eSocial1200',
                              '010',
                              '61139432000172',
                              vLinha,
                              vNomeArq1200);
     vSeq1200 := vSeq1200 + 1;           
                
     vLinha := 'D' || '|' || -- Identificador
               trim(c_msg.CPF) || '|' || -- Indicador de recebimento de pagamento numerico, vou utilizar o CPF
               c_msg.CODCAT; -- Codigo da Categoria do Trabalhador
      
     INSERT INTO tdvadm.T_UTI_ARQTMP(UTI_ARQTMP_SEQ,
                              UTI_GERAARQTMP_PROC,
                              GLB_ROTA_CODIGO,
                              GLB_CLIENTE_CGCCPFCODIGO,
                              UTI_ARQTMP_LINHA,
                              UTI_ARQTMP_ARQUIVO)
                      Values (vSeq1200,
                              'eSocial1200',
                              '010',
                              '61139432000172',
                              vLinha,
                              vNomeArq1200);
     vSeq1200 := vSeq1200 + 1;           
                
     vLinha := 'E' || '|' || -- Identificador
               '1' || '|' || -- Tipo da Incricao
               '61139432000172' || '|' || -- Numero da Incricao
               '10000000000L'; -- Codigo da Lotacao - SAO PAULO                    
      
     INSERT INTO tdvadm.T_UTI_ARQTMP(UTI_ARQTMP_SEQ,
                              UTI_GERAARQTMP_PROC,
                              GLB_ROTA_CODIGO,
                              GLB_CLIENTE_CGCCPFCODIGO,
                              UTI_ARQTMP_LINHA,
                              UTI_ARQTMP_ARQUIVO)
                      Values (vSeq1200,
                              'eSocial1200',
                              '010',
                              '61139432000172',
                              vLinha,
                              vNomeArq1200);
     vSeq1200 := vSeq1200 + 1;           
                
     vLinha := 'F' || '|' || -- Identificador
               '' ; -- Indentificado do Simples 
      
     INSERT INTO tdvadm.T_UTI_ARQTMP(UTI_ARQTMP_SEQ,
                              UTI_GERAARQTMP_PROC,
                              GLB_ROTA_CODIGO,
                              GLB_CLIENTE_CGCCPFCODIGO,
                              UTI_ARQTMP_LINHA,
                              UTI_ARQTMP_ARQUIVO)
                      Values (vSeq1200,
                              'eSocial1200',
                              '010',
                              '61139432000172',
                              vLinha,
                              vNomeArq1200);
     vSeq1200 := vSeq1200 + 1;           
                
     vLinha := 'G' || '|' || --identificador
               '2650|LG||||' ||
               trim(to_char(vValorPago,'99999999990.99')); -- Valor Pago         
      
     INSERT INTO tdvadm.T_UTI_ARQTMP(UTI_ARQTMP_SEQ,
                              UTI_GERAARQTMP_PROC,
                              GLB_ROTA_CODIGO,
                              GLB_CLIENTE_CGCCPFCODIGO,
                              UTI_ARQTMP_LINHA,
                              UTI_ARQTMP_ARQUIVO)
                      Values (vSeq1200,
                              'eSocial1200',
                              '010',
                              '61139432000172',
                              vLinha,
                              vNomeArq1200);
     vSeq1200 := vSeq1200 + 1;           
                
     vLinha := 'G' || '|' || --identificador
               '7140|LG||||' ||
               trim(to_char(vValorINSS,'99999999990.99')); -- Valor do INSS
      
     INSERT INTO tdvadm.T_UTI_ARQTMP(UTI_ARQTMP_SEQ,
                              UTI_GERAARQTMP_PROC,
                              GLB_ROTA_CODIGO,
                              GLB_CLIENTE_CGCCPFCODIGO,
                              UTI_ARQTMP_LINHA,
                              UTI_ARQTMP_ARQUIVO)
                      Values (vSeq1200,
                              'eSocial1200',
                              '010',
                              '61139432000172',
                              vLinha,
                              vNomeArq1200);
     vSeq1200 := vSeq1200 + 1;           
                
     vLinha := 'G' || '|' || --identificador
               '7340|LG||||' ||
               trim(to_char(vValorSestSenat ,'99999999990.99')); -- Valor do SestSenat
      
     INSERT INTO tdvadm.T_UTI_ARQTMP(UTI_ARQTMP_SEQ,
                              UTI_GERAARQTMP_PROC,
                              GLB_ROTA_CODIGO,
                              GLB_CLIENTE_CGCCPFCODIGO,
                              UTI_ARQTMP_LINHA,
                              UTI_ARQTMP_ARQUIVO)
                      Values (vSeq1200,
                              'eSocial1200',
                              '010',
                              '61139432000172',
                              vLinha,
                              vNomeArq1200);
     vSeq1200 := vSeq1200 + 1;           
                
     vLinha := 'G' || '|' || --identificador
               '12640|LG||||' ||
               trim(to_char(vBaseINSS,'99999999990.99')); -- Valor da Base do INSS 
      
     INSERT INTO tdvadm.T_UTI_ARQTMP(UTI_ARQTMP_SEQ,
                              UTI_GERAARQTMP_PROC,
                              GLB_ROTA_CODIGO,
                              GLB_CLIENTE_CGCCPFCODIGO,
                              UTI_ARQTMP_LINHA,
                              UTI_ARQTMP_ARQUIVO)
                      Values (vSeq1200,
                              'eSocial1200',
                              '010',
                              '61139432000172',
                              vLinha,
                              vNomeArq1200);
     vSeq1200 := vSeq1200 + 1;           
                
     vLinha := 'G' || '|' || --identificador
               '10190|LG||||' ||
               trim(to_char(vBaseIR,'99999999990.99')); -- Valor da Base IR
      
     INSERT INTO tdvadm.T_UTI_ARQTMP(UTI_ARQTMP_SEQ,
                              UTI_GERAARQTMP_PROC,
                              GLB_ROTA_CODIGO,
                              GLB_CLIENTE_CGCCPFCODIGO,
                              UTI_ARQTMP_LINHA,
                              UTI_ARQTMP_ARQUIVO)
                      Values (vSeq1200,
                              'eSocial1200',
                              '010',
                              '61139432000172',
                              vLinha,
                              vNomeArq1200);
     vSeq1200 := vSeq1200 + 1;           
                
     If c_msg.ir > 0 Then
         vLinha := 'G' || '|' || --identificador
                   '7240|LG||||' ||
                   trim(to_char(c_msg.ir,'99999999990.99')); -- Valor do IR
          
         INSERT INTO tdvadm.T_UTI_ARQTMP(UTI_ARQTMP_SEQ,
                                  UTI_GERAARQTMP_PROC,
                                  GLB_ROTA_CODIGO,
                                  GLB_CLIENTE_CGCCPFCODIGO,
                                  UTI_ARQTMP_LINHA,
                                  UTI_ARQTMP_ARQUIVO)
                          Values (vSeq1200,
                                  'eSocial1200',
                                  '010',
                                  '61139432000172',
                                  vLinha,
                                  vNomeArq1200);
         vSeq1200 := vSeq1200 + 1;           
    End If;            
     
     -- 1210
     
     vLinha := 'A' || '|' || --identificador
               '1' || '|' || --finalidade,
               '1' || '|' || --indperiodoapuracao,
               c_msg.REF1 || '|' || -- periodoapuracao,
               trim(c_msg.CPF) || '|' || --CPF,
               '0.00' ; --DeducaoDependente
      
     INSERT INTO tdvadm.T_UTI_ARQTMP(UTI_ARQTMP_SEQ,
                              UTI_GERAARQTMP_PROC,
                              GLB_ROTA_CODIGO,
                              GLB_CLIENTE_CGCCPFCODIGO,
                              UTI_ARQTMP_LINHA,
                              UTI_ARQTMP_ARQUIVO)
                      Values (vSeq1210,
                              'eSocial1210',
                              '010',
                              '61139432000172',
                              vLinha,
                              vNomeArq1210);
     vSeq1210 := vSeq1210 + 1;           
                
     vLinha := 'B' || '|' || --identificador
               to_char(last_day(to_date(pRef||'01','yyyymmdd')),'yyyymmdd') || '|' || --dtpagamento
               '1' || '|' || -- tppagamento
               'S' ; -- Indicador de residencia
      
     INSERT INTO tdvadm.T_UTI_ARQTMP(UTI_ARQTMP_SEQ,
                              UTI_GERAARQTMP_PROC,
                              GLB_ROTA_CODIGO,
                              GLB_CLIENTE_CGCCPFCODIGO,
                              UTI_ARQTMP_LINHA,
                              UTI_ARQTMP_ARQUIVO)
                      Values (vSeq1210,
                              'eSocial1210',
                              '010',
                              '61139432000172',
                              vLinha,
                              vNomeArq1210);
     vSeq1210 := vSeq1210 + 1;           
                
     vLinha := 'C' || '|' || --identificador
               pRef || '|' || --referencia da folha
               trim(c_msg.CPF) || '|' || --Indicador do Recibo tem que ser igual ao S-1200 tipo C - Indicador de recebimento de pagamento
               'S' || '|' || --Pagamento Total ou Parcial
               trim(to_char(vValorLiquido,'99999999990.99')); -- vlr liquido
      
     INSERT INTO tdvadm.T_UTI_ARQTMP(UTI_ARQTMP_SEQ,
                              UTI_GERAARQTMP_PROC,
                              GLB_ROTA_CODIGO,
                              GLB_CLIENTE_CGCCPFCODIGO,
                              UTI_ARQTMP_LINHA,
                              UTI_ARQTMP_ARQUIVO)
                      Values (vSeq1210,
                              'eSocial1210',
                              '010',
                              '61139432000172',
                              vLinha,
                              vNomeArq1210);
     vSeq1210 := vSeq1210 + 1;           
        
  End Loop;
  commit;
  
end;
0
11
vValorPago
vBaseIR
vValorINSS
c_msg.Inss
vValorSestSenat
c_msg.sestsenat
vValorIR
vValorLiquido
vLinha
vNomeArq1200
vNomeArq1210
