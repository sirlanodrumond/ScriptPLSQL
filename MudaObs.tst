PL/SQL Developer Test script 3.0
33
-- Created on 17/11/2020 by MATHEUS.MUNIZ 
declare 
  -- Variavei Locais da Funcao
  i integer;
  vOBS1 varchar2(500);
  vTransf varchar2(500);
  vCorte varchar2(100);
  vlista  glbadm.pkg_listas.tListaParamsString;


/* INICIO DA FUNCAO PRINCIPAL 
*/
begin
  -- TAG´S DE TESTE
  vLista('VAR1').value := 'CONTEUDO XXX';
--  vLista('VAR2').value := 'CONTEUDO YYY';
  vLista('VAR3').value := 'CONTEUDO ZZZ';
  
  -- OBSERVACAO DE TESTE
  vOBS1 := '{Primeira Variavel [<<VAR1>>]} {Segunda Variavel [<<VAR2>>]} {Terceira variavel [<<VAR3>>]}';
  
  -- USANDO O MUDA TAG DAS OBSERVAÇOES
  vTransf := tdvadm.pkg_fifo_carregctrc_tst .fn_MudaObservacao(vOBS1,vLista);
  
  -- REMOVE AS TAGS VAZIAS
  vTransf := tdvadm.pkg_fifo_carregctrc_tst.LimpaTAGVazia(vTransf,'{}');
  
  -- DA O RETORNO
  :pRetorno := vTransf;
  
  -- Test statements here
  
end;
1
pRetorno
1
Primeira Variavel [CONTEUDO XXX]  Terceira variavel [CONTEUDO ZZZ]
5
9
vAuxiliarObs
vPosTAG
vMarca1
vMarca2
pObs
vMarca1
vMarcaAnt 
pPosRef
vCorte
