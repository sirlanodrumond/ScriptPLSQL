PL/SQL Developer Test script 3.0
93
-- Select para Testar
/*    select cc.glb_grupoeconomico_codigo,
           cc.glb_cliente_cgccpfcodigo,
           cc.slf_contrato_codigo,
           cc.slf_clienteregras_obscust,
           cc.slf_clienteregras_obscustvigencia,
           cc.slf_clienteregras_ativo

    from tdvadm.t_slf_clienteregras cc
    where cc.slf_clienteregras_vigencia = (select max(cc1.slf_clienteregras_vigencia)
                                           from tdvadm.t_slf_clienteregras cc1
                                           where cc1.glb_grupoeconomico_codigo = cc.glb_grupoeconomico_codigo
                                             and cc1.glb_cliente_cgccpfcodigo = cc.glb_cliente_cgccpfcodigo
                                             and cc1.slf_contrato_codigo = cc.slf_contrato_codigo)
      and cc.slf_contrato_codigo in ('C4600005631')
    for update;
*/


declare 
  i integer;
  i2 integer;
  vObs tdvadm.t_slf_clienteregras.slf_clienteregras_obscust%type;
  vPosi integer;
  vPosf integer;
  vResultado varchar2(100);
  
begin
  i  := 0;
  i2 := 0;
  If upper(nvl(:pApaga,'N')) = 'S' Then
     delete tdvadm.t_con_loggeracao l
     where 0 = 0
       and l.con_loggeracao_obsgeracao like 'OBS CUST %';
     commit;  
     :pApaga := 'N';    
  End If;
  for c_msg in (select distinct tdvadm.pkg_slf_utilitarios.fn_retorna_contratoCod(c.con_conhecimento_codigo,c.con_conhecimento_serie,c.glb_rota_codigo) Contrato, 
                       l.con_loggeracao_obsgeracao,
                       l.con_loggeracao_erro,
                       to_char(l.con_loggeracao_dtgeracao,'DD/MM/YYYY hh24:mi:ss') con_loggeracao_dtgeracao,
                       c.glb_rota_codigo || '-' || c.con_conhecimento_serie || '-' || c.con_conhecimento_codigo CTE,
                       c.arm_carregamento_codigo
                from tdvadm.t_con_loggeracao l,
                     tdvadm.t_arm_carregamento ca,
                     tdvadm.t_con_conhecimento c
                where 0 = 0
                --  and l.arm_carregamento_codigo = '3445822'
                  and l.arm_carregamento_codigo = ca.arm_carregamento_codigo
                  and l.arm_carregamento_codigo = c.arm_carregamento_codigo
                  and l.con_loggeracao_dtgeracao >= sysdate -1
                  and nvl(instr(l.con_loggeracao_obsgeracao,'<<'),0) > 0
                  and l.con_loggeracao_obsgeracao like 'OBS CUST 1%'
                  and l.con_loggeracao_obsgeracao not like 'OBS CUST 3 ->%')




  Loop
     vObs := trim(c_msg.con_loggeracao_obsgeracao);
     dbms_output.put_line(vOBS);
     dbms_output.put_line(c_msg.con_loggeracao_erro);
     loop
       vPosi := nvl(instr(vObs,'<<'),0);
       If i2 >= 100 Then
          dbms_output.put_line(';'||'ERRO 2 - ' || c_msg.contrato || '-' || c_msg.con_loggeracao_obsgeracao);
          exit;
       End If;
       exit when vPosi = 0;
       vPosf := instr(vObs,'>>');
       vResultado := substr(vObs,vPosi,(vPosf-vPosi +2));
       dbms_output.put_line(c_msg.con_loggeracao_dtgeracao || ';' || c_msg.CTE || ';' || c_msg.arm_carregamento_codigo || ';' || c_msg.contrato || ';' || vResultado);
       vObs := substr(vObs,vPosf+3);
       i2 := i2 +1;
     end loop;
     i2 := 0;
     If i >= 10000 Then
        dbms_output.put_line('ERRO 1 - ' || c_msg.contrato || '-' || c_msg.con_loggeracao_obsgeracao);
        exit;
     End If; 
     i := i + 1;  
  End Loop;
  
  delete tdvadm.t_con_loggeracao l
  where 0 = 0
    and l.con_loggeracao_obsgeracao like 'OBS CUST %'
    and l.con_loggeracao_obsgeracao not like 'OBS CUST 2%';
  commit;  
  
exception
  When OTHERS Then
    dbms_output.put_line('ERRO :' || sqlerrm);
end;
1
pApaga
1
N
5
2
vObs
