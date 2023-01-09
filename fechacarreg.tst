PL/SQL Developer Test script 3.0
143
Declare
  vXml varchar2(1000);
  vRota tdvadm.t_glb_rota.glb_rota_codigo%type;
  vStatus char(1);
  vMessage  varchar2(2000);
  vAuxiliar integer;
begin

-- 2355061
-- 2355069

  tdvadm.pkg_slf_calculos.V_VERBA_BREAKPOINT := :pverbaBreakPoint;

  -- Call the 
  select c.arm_armazem_codigo
    into :p_cod_armazem
  from tdvadm.t_arm_carregamento c
  where c.arm_carregamento_codigo = :p_cod_carregamento;
  If nvl(:p_usuario,'Sirlano') = 'Sirlano' Then
     :p_usuario := 'jsantos';
  End If;
  select a.glb_rota_codigo
    into vRota
  from tdvadm.t_arm_armazem a
  where a.arm_armazem_codigo = :p_cod_armazem;


  vXml := '<Parametros>
              <Inputs>
                 <input>
                    <usuario>jsantos</usuario>
                    <rota>CODROTA</rota>
                    <aplicacao>Carreg</aplicacao>
                    <carreg_codigo>CODCARREG</carreg_codigo>
                 </input>
              </Inputs>
           </Parametros>';
           
  vXml := replace(vXml,'CODROTA',vRota);
  vXml := replace(vXml,'CODCARREG',:p_cod_carregamento);

  vStatus := 'N';
  If nvl(:p_Devolucao,'N') = 'N' then
     tdvadm.pkg_fifo.sp_RetCarrgFifo(vXml,vStatus,vMessage);
  End If;


  If vStatus = 'N' Then


     for c_msg in (  select cs.glb_procssodet_id CodId,
                            cs.glb_processo_codigo processo,
                            cs.arm_armazem_codigo arm,
                            cs.arm_carregamento_codigo carreg,
                            s.glb_status_descricao status,
                            cs.arm_carregstatus_dtreg dtreg,
                            sysdate horaatual,
                            (select max(lg.con_loggeracao_dtgeracao)
                             from tdvadm.t_con_loggeracao lg
                             where lg.arm_carregamento_codigo = cs.arm_carregamento_codigo) DTLOG,
                            to_number(tdvadm.FN_CALCULA_TEMPODECORRIDO((select max(lg.con_loggeracao_dtgeracao)
                                                                        from tdvadm.t_con_loggeracao lg
                                                                        where lg.arm_carregamento_codigo = cs.arm_carregamento_codigo),
                                                                        sysdate,'M')) tempo,
                            (select count(*)
                             from tdvadm.t_con_loggeracao lg
                             where lg.arm_carregamento_codigo = cs.arm_carregamento_codigo) QTDELOG,
                            (select count(*)
                             from tdvadm.t_arm_carregamentodet cd
                             where cd.arm_carregamento_codigo = cs.arm_carregamento_codigo) qtdenota
                     from tdvadm.t_arm_carregstatus cs,
                          tdvadm.t_glb_processodet det,
                          tdvadm.t_glb_status s
                     where cs.glb_processo_codigo = det.glb_processo_codigo
                       and cs.glb_procssodet_id = det.glb_processodet_id
                       and cs.glb_processo_codigo = '005'   
                       and det.glb_status_codigo = s.glb_status_codigo
                       and nvl(s.glb_status_flagfinal,'N') <> 'S'
                       and cs.arm_carregamento_codigo = :p_cod_carregamento
                     order by cs.arm_carregstatus_dtreg)
      Loop
       
            -- Muda o processo para 21 CARREG LIBERADO PELO SISTEMA
            tdvadm.sp_con_voltacarreg(c_msg.carreg);
            select count(*)
              into vAuxiliar
            from tdvadm.t_con_conhecimento c
            where c.arm_carregamento_codigo = c_msg.carreg
              and c.con_conhecimento_serie = 'XXX';
              
            If vAuxiliar = 0 Then   
               update tdvadm.t_arm_carregstatus cs
                  set cs.glb_status_codigoproc = 21
               where cs.glb_procssodet_id = c_msg.codid;
               update tdvadm.t_glb_processodet det
                 set det.glb_status_codigo = 21
               where det.glb_processo_codigo = c_msg.processo
                 and det.glb_processodet_id = c_msg.codid;
            End If;
            commit;
               
          
        
      End Loop;
  
     delete tdvadm.t_con_loggeracao lg
     where lg.arm_carregamento_codigo = :p_cod_carregamento;

     If nvl(:p_Devolucao,'N') = 'N' then
        delete tdvadm.t_arm_notacte nct
        where nct.arm_nota_sequencia in (select v.arm_nota_sequencia
                                         from tdvadm.t_arm_nota v,
                                              tdvadm.t_arm_carregamentodet cd
                                              where v.arm_embalagem_numero = cd.arm_embalagem_numero
                                                and v.arm_embalagem_sequencia = cd.arm_embalagem_sequencia
                                                and cd.arm_carregamento_codigo = :p_cod_carregamento);
     End If;
                  
                                
     tdvadm.pkg_fifo_carregamento.sp_fecha_carregamento(p_cod_carregamento => :p_cod_carregamento,
                                                        p_cod_armazem => :p_cod_armazem,
                                                        p_usuario => :p_usuario,
                                                        pstatus => :pstatus,
                                                        pmessage => :pmessage);
  Else
    :pstatus := vStatus;
    :pmessage := vMessage;
  End If;             
  
  If :pmessage = 'Carregamento em processo de Fechamento' Then
     update tdvadm.t_con_loggeracao lg
       set lg.con_loggeracao_dtgeracao = lg.con_loggeracao_dtgeracao -1
     where lg.arm_carregamento_codigo = :p_cod_carregamento
       and lg.con_loggeracao_codigo = (select max(lg1.con_loggeracao_codigo)
                                       from tdvadm.t_con_loggeracao lg1
                                       where lg1.arm_carregamento_codigo = lg.arm_carregamento_codigo);
     commit;
     tdvadm.pkg_fifo_carregctrc.SP_LIBERACARREG;
     commit;
  End If;
                                           
                                                     
end;
7
p_Devolucao
1
N
5
p_cod_armazem
1
06
5
p_cod_carregamento
1
3457719
5
p_usuario
1
jsantos
5
pverbaBreakPoint
0
5
pmessage
0
5
pstatus
1
N                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
5
18
pListaNotas.cnContrato
V_FORMULA_FORMULA_VLR
V_FORMULA_CALCTRATADA
V_VALOR_FORMULA
ListaNotas.cnnrcoleta
P_RETORNOPROCESSAMENTO
vListaNotas.cnContrato
pRetBuscaFrete.FCF_TPVEICULO_CODIGO
vRetBuscaFrete.SLF_CALCFRETEKM_VALOR
vTesteCarga.vRetorna
vErroFatal
ListaNotas.cnNOTA
v_lotacao
vTesteCarga.vTestePeso
ListaVaux.cnContaTodaNotas
ListaVaux.cnPercentEx
ListaCargaCli.ccPERCTEX
ListaVerbas('V_PERCTE').AsFloat
