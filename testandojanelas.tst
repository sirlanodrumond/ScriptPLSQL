PL/SQL Developer Test script 3.0
438
declare 
   ListaAgrupamento tdvadm.pkg_fifo_carregctrc.TpAgrupaCli;
   vJanelaCons      tdvadm.t_arm_janelacons%rowtype;
   vJanelaComp      tdvadm.t_arm_janelaconstmp%rowtype;
   vCargaExpressa   tdvadm.t_arm_coleta.arm_coleta_tpcoleta%type;
   pOrigem          char(1) := 'N';
   vContaCteJanela  INTEGER := 0;
   vSomaPeso        NUMBER;
   vSomaMerc        NUMBER;
   vContaNota       NUMBER;
--   vAcao            char(7) := 'COMPARA'; 
   vAcao            char(7) := 'CRIA';
begin
  
   for vLinha in (select an.arm_nota_numero,
                         an.glb_cliente_cgccpfremetente,
                         an.arm_nota_serie,
                         an.arm_coleta_ncompra,
                         an.arm_coleta_ciclo,
                         an.Glb_Cliente_Cgccpfsacado,
                         an.Glb_Tpcliend_Codremetente,
                         an.Glb_Cliente_Cgccpfdestinatario,
                         an.Glb_Tpcliend_Coddestinatario,
                         an.arm_nota_peso,
                         an.arm_nota_valormerc,
                         an.arm_armazem_codigo,
                         an.arm_nota_localcoletal,
                         an.arm_nota_localcoletai,
                         an.arm_nota_localentregal,
                         an.arm_nota_localentregai,
                         an.arm_janelacons_sequencia,
                         AN.Arm_Nota_Sequencia,
                         co.arm_coleta_dtfechamento
                  from tdvadm.t_arm_nota an,
                       tdvadm.t_arm_coleta co,
                       tdvadm.t_arm_janelacons jc
                  where 0 = 0
                    and an.arm_coleta_ncompra = co.arm_coleta_ncompra
                    and an.arm_coleta_ciclo = co.arm_coleta_ciclo
                    and an.arm_janelacons_sequencia = jc.arm_janelacons_sequencia
                    and jc.arm_janelacons_dtinicio <> jc.arm_janelacons_dtfim
                    and trunc(co.arm_coleta_dtfechamento) >= '15/05/2019'
--                    and an.arm_nota_sequencia in (3896054,3895287)
--                    and an.arm_nota_dtinclusao >= sysdate -2
--                    and an.arm_armazem_codigo = '07'
--                    AND AN.ARM_JANELACONS_SEQUENCIA IN (1099396,
--                                                        1099263,
--                                                        1099253,
--                                                        1099339,
--                                                        1099336,
--                                                        1099125,
--                                                        1099370,
--                                                        1099087,
--                                                        1099326,
--                                                        1099086,
--                                                        1099341)
    )
   Loop
     
   :pstatus := 'N';
   vJanelaCons := null;
   

  
      tdvadm.PKG_SLF_CONTRATO.SP_GETREGRANOTA(vLinha.Arm_Nota_Numero,
                                              vLinha.Glb_Cliente_Cgccpfremetente,
                                              vLinha.Arm_Nota_Serie,
                                              vJanelacons.Glb_Cliente_Cgccpfcodigo,
                                              vJanelacons.Glb_Grupoeconomico_Codigo,
                                              vJanelacons.Slf_Contrato_Codigo,
                                              vJanelaCons.Slf_Tpagrupa_Codigo);
              
              
       ListaAgrupamento :=  tdvadm.pkg_fifo_carregctrc.fn_RetornaAgrupamento(vJanelaCons.Slf_Tpagrupa_Codigo);

       -- Pego Informacões da Coleta
       select c.fcf_tpcarga_codigo,
              c.arm_coleta_entcoleta,
              c.arm_coleta_tpcoleta
          into vJanelacons.Fcf_Tpcarga_Codigo,
               vJanelaCons.Arm_Janelacons_Entcol,
               vCargaExpressa
       from tdvadm.t_arm_coleta c 
       where c.arm_coleta_ncompra = vLinha.Arm_Coleta_Ncompra 
         and c.arm_coleta_ciclo =  vLinha.Arm_Coleta_Ciclo ;


       tdvadm.PKG_SLF_CONTRATO.SP_GETJANELANOTA(vlinha.arm_nota_numero,
                                                vlinha.glb_cliente_cgccpfremetente,
                                                vlinha.arm_nota_serie,
                                                vJanelaCons.Arm_Janelacons_Dtinicio,
                                                vJanelacons.Arm_Janelacons_Dtfim,
                                                vJanelaCons.Arm_Janelacons_Geracte); 





       vJanelaCons.Arm_Janelacons_Origem     := nvl(pOrigem,'N');
       vJanelaCons.Glb_Cliente_Cgccpfsac     := vLinha.Glb_Cliente_Cgccpfsacado;
       vJanelaCons.Glb_Cliente_Cgccpfrem     := vLinha.Glb_Cliente_Cgccpfremetente;
       vJanelacons.Glb_Tpcliend_Codigorem    := vLinha.Glb_Tpcliend_Codremetente;
       vJanelacons.Glb_Cliente_Cgccpfdes     := vLinha.Glb_Cliente_Cgccpfdestinatario;
       vJanelacons.Glb_Tpcliend_Codigodes    := vLinha.Glb_Tpcliend_Coddestinatario;
       vJanelacons.Arm_Janelacons_Coleta  := '99999';
       vJanelaCons.Arm_Janelacons_Entrega := '99999';
       vJanelacons.Arm_Janelacons_Qtdenf     :=  1;
       vJanelacons.Arm_Janelacons_Pesocons   := vLinha.Arm_Nota_Peso;
       vJanelaCons.Arm_Janelacons_Merccons   := vLinha.Arm_Nota_Valormerc;
       vJanelacons.Arm_Janelacons_Qtdectenfs := 0;
       vJanelacons.Arm_Janelacons_Dtcriou    := sysdate;

       If ListaAgrupamento.acContrato = 'S' Then
          vJanelacons.SLF_CONTRATO_CODIGO    := vJanelacons.SLF_CONTRATO_CODIGO;
       Else -- Sirlano Colocar na principal
          vJanelacons.SLF_CONTRATO_CODIGO    := '999999999999999';
       End If;
               
     If ListaAgrupamento.acSacado = 'S' Then
          vJanelacons.GLB_CLIENTE_CGCCPFSAC  := vJanelacons.Glb_Cliente_Cgccpfsac;
       Else
          vJanelacons.GLB_CLIENTE_CGCCPFSAC  := '99999999999999';
       End If;
 
       If ListaAgrupamento.acRemetente = 'S' Then
          if vJanelacons.ARM_JANELACONS_ENTCOL =  'E' Then
             vJanelacons.GLB_CLIENTE_CGCCPFREM  := vLinha.Arm_Armazem_Codigo;
             vJanelaCons.Glb_Tpcliend_Codigorem := 'X';
          else
             vJanelacons.GLB_CLIENTE_CGCCPFREM  := vJanelacons.GLB_CLIENTE_CGCCPFREM;
          End If;
       Else
          vJanelacons.GLB_CLIENTE_CGCCPFREM  := '99999999999999';
          vJanelacons.GLB_TPCLIEND_CODIGOREM := 'X';
       End If;
                     
       If ListaAgrupamento.acDestinatario = 'S' Then
          vJanelacons.GLB_CLIENTE_CGCCPFDES  := vJanelaCons.Glb_Cliente_Cgccpfdes;
       Else
          vJanelacons.GLB_CLIENTE_CGCCPFDES  := '99999999999999';
          vJanelacons.GLB_TPCLIEND_CODIGODES := 'X';
       End If;

       If ListaAgrupamento.acTpEndRemetente = 'S' Then
          vJanelacons.Glb_Tpcliend_Codigorem    := vLinha.Glb_Tpcliend_Codremetente;
       else 
          vJanelacons.Glb_Tpcliend_Codigorem    := 'X';
       End If;
               
       If ListaAgrupamento.acTpEndDestino = 'S' Then
          vJanelacons.Glb_Tpcliend_Codigodes    := vLinha.Glb_Tpcliend_Coddestinatario;
       Else   
          vJanelacons.Glb_Tpcliend_Codigodes    := 'C';
       End If;

       If ListaAgrupamento.acLocalidadeColeta = 'S' Then
          vJanelacons.ARM_JANELACONS_COLETA  := vLinha.Arm_Nota_Localcoletal;
       Else
          vJanelacons.ARM_JANELACONS_COLETA  := '999999';
       End If;

       If ListaAgrupamento.acLocalidadeEntrega = 'S' Then
          vJanelacons.ARM_JANELACONS_ENTREGA := vLinha.Arm_Nota_Localentregal;
       Else
          vJanelacons.ARM_JANELACONS_ENTREGA := '999999';
       End If;

       If ListaAgrupamento.acIBGEColeta = 'S' Then
          vJanelacons.ARM_JANELACONS_COLETA  := vLinha.Arm_Nota_Localcoletai;
       Else
          vJanelacons.ARM_JANELACONS_COLETA  := '999999';
       End If;

       If ListaAgrupamento.acIBGEEntrega = 'S' Then
          vJanelacons.ARM_JANELACONS_ENTREGA := vLinha.Arm_Nota_Localentregai;
       Else
          vJanelacons.ARM_JANELACONS_ENTREGA := '999999';
       End If;
               
       If ListaAgrupamento.acColetaEntrega = 'S' Then
          vJanelacons.ARM_JANELACONS_ENTCOL  := vJanelacons.ARM_JANELACONS_ENTCOL;
       Else
          vJanelacons.ARM_JANELACONS_ENTCOL  := 'A';                 
       End If;
               
       If ListaAgrupamento.acTPCarga = 'S' then 
          vJanelacons.FCF_TPCARGA_CODIGO     := vJanelacons.FCF_TPCARGA_CODIGO;
       Else
          vJanelacons.FCF_TPCARGA_CODIGO     := '00';
       End If;
               
       If ListaAgrupamento.acNrColeta = 'S' Then
          vJanelaCons.Arm_Janelacons_Nrcoleta := vLinha.Arm_Coleta_Ncompra;
       Else
          vJanelaCons.Arm_Janelacons_Nrcoleta := '000000';
       End If;



       -- Procura se ja existe uma chave igual para este agrupamento janela
       Begin
          select j.arm_janelacons_sequencia,
                j.arm_janelacons_qtdectenfs
             into vJanelaCons.Arm_Janelacons_Sequencia,
                  vJanelaCons.Arm_Janelacons_Qtdectenfs
          from tdvadm.t_arm_janelacons j
          where j.GLB_GRUPOECONOMICO_CODIGO = vJanelacons.Glb_Grupoeconomico_Codigo
            and j.GLB_CLIENTE_CGCCPFCODIGO  = vJanelacons.Glb_Cliente_Cgccpfcodigo
            and j.SLF_CONTRATO_CODIGO       = vJanelacons.Slf_Contrato_Codigo
            and j.FCF_TPCARGA_CODIGO        = vJanelacons.Fcf_Tpcarga_Codigo
            and j.SLF_TPAGRUPA_CODIGO       = vJanelacons.Slf_Tpagrupa_Codigo
            and j.GLB_CLIENTE_CGCCPFSAC     = vJanelacons.Glb_Cliente_Cgccpfsac
            and j.GLB_CLIENTE_CGCCPFREM     = vJanelacons.Glb_Cliente_Cgccpfrem
            and j.GLB_TPCLIEND_CODIGOREM    = vJanelacons.Glb_Tpcliend_Codigorem
            and j.GLB_CLIENTE_CGCCPFDES     = vJanelacons.Glb_Cliente_Cgccpfdes
            and j.GLB_TPCLIEND_CODIGODES    = vJanelacons.Glb_Tpcliend_Codigodes
            and j.ARM_JANELACONS_COLETA     = vJanelacons.Arm_Janelacons_Coleta
            and j.ARM_JANELACONS_ENTREGA    = vJanelacons.Arm_Janelacons_Entrega
            and j.ARM_JANELACONS_ENTCOL     = vJanelacons.Arm_Janelacons_Entcol
            and j.ARM_JANELACONS_DTINICIO   = vJanelacons.Arm_Janelacons_Dtinicio
            and j.ARM_JANELACONS_DTFIM      = vJanelacons.Arm_Janelacons_Dtfim
            and j.arm_janelacons_origem     = vJanelaCons.Arm_Janelacons_Origem;
        
          If vJanelaCons.Arm_Janelacons_Qtdectenfs = 0 Then
             -- Se A quantidade de Cte for zerada conta novamente
             -- TIRAR CONTAGEM
             vContaCteJanela := 0;
               /********** SIRLANO JANELA *************/
             If trunc(sysdate) > to_date('08/05/2016','DD/MM/YYYY') Then
                select count(*)
                    into vContaCteJanela 
                from tdvadm.t_arm_nota an
                where an.arm_janelacons_sequencia = vJanelaCons.Arm_Janelacons_Sequencia
                  and an.con_conhecimento_codigo is not null;
                         
             Else
                select count(*)
                    into vContaCteJanela
                from tdvadm.t_arm_nota an
                where an.arm_janelacons_sequencia = vJanelaCons.Arm_Janelacons_Sequencia
                         and an.con_conhecimento_codigo is not null
                         AND AN.ARM_ARMAZEM_CODIGO = '07';
             End If;
                      
                    -- Atualiza o controle de Janela  
             If ( vContaCteJanela > 0 ) and ( vAcao = 'CRIA' ) Then
                update tdvadm.t_arm_janelacons j
                    set j.arm_janelacons_qtdectenfs = vContaCteJanela
                where j.arm_janelacons_sequencia = vJanelaCons.Arm_Janelacons_Sequencia;
             
                vJanelaCons.Arm_Janelacons_Qtdectenfs := vContaCteJanela;
             End If;
          End If;

          vJanelaCons.Arm_Janelacons_Qtdectenfs := 0;
                   
          If vJanelaCons.Arm_Janelacons_Qtdectenfs > 0 Then
             :pStatus := tdvadm.pkg_fifo.Status_Erro;
             :pMessage := 'Janela Ja Tem CTe/NFSe emitido. Aguardar FIM da Janela JANELA - ' || to_char(vJanelacons.Arm_Janelacons_Dtfim,'dd/mm/yyyy hh24:mi:ss') ;
          End If;
             
       exception
       When NO_DATA_FOUND Then
           vJanelaCons.Arm_Janelacons_Sequencia := null;
       End;
 
       If :pStatus = tdvadm.pkg_fifo.Status_Normal Then 
          -- Atualiza dados da Janela
          -- Soma Pesos da Notas
              
          If vJanelaCons.Arm_Janelacons_Sequencia is not null Then
             select sum(nvl(an.arm_nota_pesobalanca,an.arm_nota_peso)),
                    sum(nvl(an.arm_nota_valormerc,0)),
                    count(*)
                into vSomaPeso,
                     vSomaMerc,
                     vContaNota
             from tdvadm.t_arm_nota an
             where an.arm_janelacons_sequencia = vJanelaCons.Arm_Janelacons_Sequencia;
                     
             If vContaNota = 0 Then
                vSomaPeso := vLinha.Arm_Nota_Peso;
                vSomaMerc := vLinha.Arm_Nota_Valormerc;
                vContaNota := 1;
             End If;
                  

             If  vAcao = 'CRIA' Then 
                update tdvadm.t_arm_janelacons j
                   set j.arm_janelacons_qtdenf   = vContaNota,
                       j.arm_janelacons_pesocons = vSomaPeso,
                       j.arm_janelacons_merccons = vSomaMerc
                where j.arm_janelacons_sequencia = vJanelaCons.Arm_Janelacons_Sequencia;
             End If;   
          Else
             If  vAcao = 'CRIA' Then 
                vJanelaCons.Arm_Janelacons_Sequencia := tdvadm.SEQ_ARM_JANELACONS.NEXTVAL;
                insert into tdvadm.t_arm_janelacons values vJanelaCons;
             End If;
          End If;


          If  vAcao = 'CRIA' Then 
             -- Atualiza a Chave da Janela na Nota
             update tdvadm.t_arm_nota an
                set an.arm_janelacons_sequencia = vJanelaCons.Arm_Janelacons_Sequencia
             where an.arm_nota_sequencia = vLinha.Arm_Nota_Sequencia; 
             Commit;
          End If;
       Else
          rollback;
       End If;

       If vAcao = 'COMPARA' Then

          select jc.*,vlinha.arm_nota_sequencia,vLinha.Arm_Coleta_Dtfechamento,'ATUAL'
             into vJanelaComp
          from tdvadm.t_arm_janelacons jc
          where jc.arm_janelacons_sequencia = vLinha.Arm_Janelacons_Sequencia ;
            
          If ( vJanelaComp.GLB_GRUPOECONOMICO_CODIGO <> vJanelacons.Glb_Grupoeconomico_Codigo )  or 
             ( vJanelaComp.GLB_CLIENTE_CGCCPFCODIGO  <> vJanelacons.Glb_Cliente_Cgccpfcodigo  )  or 
             ( vJanelaComp.SLF_CONTRATO_CODIGO       <> vJanelacons.Slf_Contrato_Codigo       )  or 
             ( vJanelaComp.FCF_TPCARGA_CODIGO        <> vJanelacons.Fcf_Tpcarga_Codigo        )  or 
             ( vJanelaComp.SLF_TPAGRUPA_CODIGO       <> vJanelacons.Slf_Tpagrupa_Codigo       )  or 
             ( vJanelaComp.GLB_CLIENTE_CGCCPFSAC     <> vJanelacons.Glb_Cliente_Cgccpfsac     )  or 
             ( vJanelaComp.GLB_CLIENTE_CGCCPFREM     <> vJanelacons.Glb_Cliente_Cgccpfrem     )  or 
             ( vJanelaComp.Glb_Tpcliend_Codigorem    <> vJanelacons.Glb_Tpcliend_Codigorem    )  or 
             ( vJanelaComp.GLB_CLIENTE_CGCCPFDES     <> vJanelacons.Glb_Cliente_Cgccpfdes     )  or 
             ( vJanelaComp.GLB_TPCLIEND_CODIGODES    <> vJanelacons.Glb_Tpcliend_Codigodes    )  or 
             ( vJanelaComp.ARM_JANELACONS_COLETA     <> vJanelacons.Arm_Janelacons_Coleta     )  or 
             ( vJanelaComp.ARM_JANELACONS_ENTREGA    <> vJanelacons.Arm_Janelacons_Entrega    )  or 
             ( vJanelaComp.ARM_JANELACONS_ENTCOL     <> vJanelacons.Arm_Janelacons_Entcol     )  or 
             ( vJanelaComp.ARM_JANELACONS_DTINICIO   <> vJanelacons.Arm_Janelacons_Dtinicio   )  or 
             ( vJanelaComp.ARM_JANELACONS_DTFIM      <> vJanelacons.Arm_Janelacons_Dtfim      )  or 
             ( vJanelaComp.arm_janelacons_origem     <> vJanelaCons.Arm_Janelacons_Origem     ) Then 

             insert into tdvadm.t_arm_janelaconstmp
                 (arm_janelacons_sequencia,
                  glb_grupoeconomico_codigo,
                  glb_cliente_cgccpfcodigo,
                  slf_contrato_codigo,
                  fcf_tpcarga_codigo,
                  slf_tpagrupa_codigo,
                  glb_cliente_cgccpfsac,
                  glb_cliente_cgccpfrem,
                  glb_tpcliend_codigorem,
                  glb_cliente_cgccpfdes,
                  glb_tpcliend_codigodes,
                  arm_janelacons_coleta,
                  arm_janelacons_entrega,
                  arm_janelacons_entcol,
                  arm_janelacons_dtinicio,
                  arm_janelacons_dtfim,
                  arm_janelacons_qtdenf,
                  arm_janelacons_pesocons,
                  arm_janelacons_qtdectenfs,
                  arm_janelacons_dtcriou,
                  arm_janelacons_merccons,
                  arm_janelacons_nrcoleta,
                  arm_janelacons_origem,
                  arm_janelacons_geracte,
                  arm_nota_sequencia,
                  Arm_Coleta_Dtfechamento,
                  arm_janelacons_tipo)
             Values 
                  (vJanelaCons.arm_janelacons_sequencia,
                   vJanelaCons.glb_grupoeconomico_codigo,
                   vJanelaCons.glb_cliente_cgccpfcodigo,
                   vJanelaCons.slf_contrato_codigo,
                   vJanelaCons.fcf_tpcarga_codigo,
                   vJanelaCons.slf_tpagrupa_codigo,
                   vJanelaCons.glb_cliente_cgccpfsac,
                   vJanelaCons.glb_cliente_cgccpfrem,
                   vJanelaCons.glb_tpcliend_codigorem,
                   vJanelaCons.glb_cliente_cgccpfdes,
                   vJanelaCons.glb_tpcliend_codigodes,
                   vJanelaCons.arm_janelacons_coleta,
                   vJanelaCons.arm_janelacons_entrega,
                   vJanelaCons.arm_janelacons_entcol,
                   vJanelaCons.arm_janelacons_dtinicio,
                   vJanelaCons.arm_janelacons_dtfim,
                   vJanelaCons.arm_janelacons_qtdenf,
                   vJanelaCons.arm_janelacons_pesocons,
                   vJanelaCons.arm_janelacons_qtdectenfs,
                   vJanelaCons.arm_janelacons_dtcriou,
                   vJanelaCons.arm_janelacons_merccons,
                   vJanelaCons.arm_janelacons_nrcoleta,
                   vJanelaCons.arm_janelacons_origem,
                   vJanelaCons.arm_janelacons_geracte,
                   vLinha.Arm_Nota_Sequencia,
                   vlinha.arm_coleta_dtfechamento,
                   'CALCULADO');

             insert into tdvadm.t_arm_janelaconstmp
             values vJanelaComp;
          End If;
       End If;   
          
/*
               open :pCursor for select 'Agora' status,
                                        jc.*
                             from tdvadm.t_arm_janelacons jc
                             where jc.arm_janelacons_sequencia = vlinha.arm_janelacons_sequencia
                             union
                             select 'Calc' status,
                                    vJanelaCons.arm_janelacons_sequencia,
                                    vJanelaCons.glb_grupoeconomico_codigo,
                                    vJanelaCons.glb_cliente_cgccpfcodigo,
                                    vJanelaCons.slf_contrato_codigo,
                                    vJanelaCons.fcf_tpcarga_codigo,
                                    vJanelaCons.slf_tpagrupa_codigo,
                                    vJanelaCons.glb_cliente_cgccpfsac,
                                    vJanelaCons.glb_cliente_cgccpfrem,
                                    vJanelaCons.glb_tpcliend_codigorem,
                                    vJanelaCons.glb_cliente_cgccpfdes,
                                    vJanelaCons.glb_tpcliend_codigodes,
                                    vJanelaCons.arm_janelacons_coleta,
                                    vJanelaCons.arm_janelacons_entrega,
                                    vJanelaCons.arm_janelacons_entcol,
                                    vJanelaCons.arm_janelacons_dtinicio,
                                    vJanelaCons.arm_janelacons_dtfim,
                                    vJanelaCons.arm_janelacons_qtdenf,
                                    vJanelaCons.arm_janelacons_pesocons,
                                    vJanelaCons.arm_janelacons_qtdectenfs,
                                    vJanelaCons.arm_janelacons_dtcriou,
                                    vJanelaCons.arm_janelacons_merccons,
                                    vJanelaCons.arm_janelacons_nrcoleta,
                                    vJanelaCons.arm_janelacons_origem,
                                    vJanelaCons.arm_janelacons_geracte
                             from dual;
*/

   End Loop;

   open :pCursor for select * from tdvadm.t_arm_janelaconstmp t order by t.arm_nota_sequencia,t.arm_janelacons_sequencia;

end;
3
pcursor
1
<Cursor>
116
pstatus
1
N
5
pmessage
0
5
2
vlinha.arm_nota_sequencia
