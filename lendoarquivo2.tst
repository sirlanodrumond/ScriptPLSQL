PL/SQL Developer Test script 3.0
78
-- Created on 03/10/2020 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  i integer;
  tpRegistro tdvadm.t_arq_gravados%rowtype;
begin
  :vdatai := sysdate;
  :vQtde := 0;
  -- Test statements here
  for c_msg in (select y.completo,
                       y.diretorio,
                       y.arquivo,
                       tdvadm.fn_tamarquivo(y.diretorio,y.arquivo) TAM
                from (select trim(replace(replace(substr(x.edi_integra_col01,3),'\','/'),chr(13),null)) completo,
                             '/'|| replace(substr(x.edi_integra_col01,4,instr(x.edi_integra_col01,'\',-1)-4),'\','/') || '/'  diretorio,
                             trim(replace(substr(x.edi_integra_col01,instr(x.edi_integra_col01,'\',-1) + 1),chr(13),null)) arquivo
                      from tdvadm.t_edi_integracsv x
                      where 0 = (select count(*)
                                 from tdvadm.t_arq_gravados ag
                                 where ag.completo = y.completo
                                   and trunc(ag.pesquisa) >= to_date('03/10/2020','dd/mm/yyyy'))
--                      where x.edi_integra_col01 like '%001390A17400400010002.jpg%'
                     ) y
               )
  Loop

     :vQtde := :vQtde + 1;
     tpRegistro.diretorio              := c_msg.diretorio;   
     tpRegistro.arquivo                := c_msg.arquivo;
     tpRegistro.completo               := c_msg.completo;
     tpRegistro.gravacao               := sysdate;
     tpRegistro.pesquisa               := sysdate;
     tpRegistro.documento              := substr(c_msg.arquivo,1,6);
     tpRegistro.serie                  := substr(c_msg.arquivo,7,2);
     tpRegistro.rota                   := substr(c_msg.arquivo,9,3);
     tpRegistro.saque                  := null;
     tpRegistro.cnpj                   := null;
     tpRegistro.glb_grupoimagem_codigo := substr(c_msg.arquivo,12,2);
     tpRegistro.glb_tpimagem_codigo    := substr(c_msg.arquivo,14,4);
     tpRegistro.glb_tparquivo_codigo   := substr(c_msg.arquivo,18,4);
     tpRegistro.arq_gravado_tamanho    := c_msg.tam;

     update tdvadm.t_arq_gravados ag
       set ag.arq_gravado_tamanho = tpRegistro.arq_gravado_tamanho,
           ag.pesquisa = tpRegistro.pesquisa
     where ag.completo = tpRegistro.completo;
     
     i:= sql%rowcount;
     If i = 0 Then
        select max(g.indice)
          into tpRegistro.Indice
        from tdvadm.t_arq_gravados g;
        tpRegistro.Indice                 := tpRegistro.Indice + 1;
        insert into tdvadm.t_arq_gravados
        values tpRegistro;
     End If;


       If instr(c_msg.diretorio,'imagens/04/') > 0 Then
       
           update tdvadm.t_glb_compimagem ci
             set ci.glb_compimagem_localservidor2 = tpRegistro.completo,
                 ci.glb_compimagem_dtpesquisaok = tpRegistro.pesquisa
           where ci.con_conhecimento_codigo = tpRegistro.Documento
             and ci.con_conhecimento_serie  = tpRegistro.Serie
             and ci.glb_rota_codigo         = tpRegistro.Rota
             and ci.glb_grupoimagem_codigo  = tpRegistro.Glb_Grupoimagem_Codigo
             and ci.glb_tpimagem_codigo     = tpRegistro.Glb_Tpimagem_Codigo
             and ci.glb_tparquivo_codigo    = tpRegistro.Glb_Tparquivo_Codigo;
       End If;

     commit;           
    
  End Loop;

  :vdataf := sysdate;

end;
3
vQtde
0
3
vDatai
0
12
vDataf
0
12
2
i
c_msg.completo
