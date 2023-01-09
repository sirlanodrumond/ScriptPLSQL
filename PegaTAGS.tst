PL/SQL Developer Test script 3.0
42
-- Created on 17/06/2021 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  i integer;
  i2 integer;
  vObs tdvadm.t_slf_clienteregras.slf_clienteregras_obscust%type;
  vPosi integer;
  vPosf integer;
  vResultado varchar2(100);
  
begin
  i  := 0;
  i2 := 0;
  for c_msg in (select r.slf_contrato_codigo,
                       r.glb_cliente_cgccpfcodigo,
                       r.glb_grupoeconomico_codigo,
                       r.slf_clienteregras_obscust
                from tdvadm.t_slf_clienteregras r
                where r.slf_clienteregras_obscust is not null)
  Loop
     vObs := trim(c_msg.slf_clienteregras_obscust);
     loop
       vPosi := nvl(instr(vObs,'<<'),0);
       If i2 >= 100 Then
          dbms_output.put_line(c_msg.slf_contrato_codigo||';'||c_msg.glb_cliente_cgccpfcodigo||';'||c_msg.glb_grupoeconomico_codigo||';'||'ERRO');
          Return;
       End If;
       exit when vPosi = 0;
       vPosf := instr(vObs,'>>');
       vResultado := substr(vObs,vPosi,(vPosf-vPosi +2));
       dbms_output.put_line(c_msg.slf_contrato_codigo||';'||c_msg.glb_cliente_cgccpfcodigo||';'||c_msg.glb_grupoeconomico_codigo||';'||vResultado);
       vObs := substr(vObs,vPosf+3);
       i2 := i2 +1;
     end loop;
     i2 := 0;
     If i >= 100 Then
        dbms_output.put_line(c_msg.slf_contrato_codigo||';'||c_msg.glb_cliente_cgccpfcodigo||';'||c_msg.glb_grupoeconomico_codigo||';'||'ERRO 1');
        return;
     End If; 
     i := i + 1;  
  End Loop;
end;
0
0
