PL/SQL Developer Test script 3.0
50
-- Created on 27/10/2021 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  i integer := 0;
  vQtde integer := 0;
  vValor number := 0;
  verro  number := 0;
  vNgravado number := 0;
  vContrato char(20) := '';
begin
  -- Test statements here
  
  vQtde := 0;
  for c_msg in (select i.edi_integra_col02 contrato,
                       substr(i.edi_integra_col03,2) vrowid,
                       i.edi_integra_col04,
                       i.edi_integra_col05,
                       i.edi_integra_col06 valor,
                       i.edi_integra_col07,
                       i.edi_integra_col08,
                       i.edi_integra_col09
                from tdvadm.t_edi_integracsv i
                where i.edi_integra_col01 = 'LOTACAOVALE2.csv' -- '5500058294-V-NO.csv' --'5500058294-V-SP.csv' --'LOTACAOVALE.csv'
                  and nvl(i.edi_integra_col02,'CONTRATO') <> 'CONTRATO')
   loop
     vQtde := vQtde + 1;
     Begin
         vContrato := c_msg.contrato;
         vValor := to_number(replace(replace(c_msg.valor,'.',''),',','.'));
         update tdvadm.t_slf_calcfretekm km
           set km.slf_calcfretekm_valor = vValor
         where km.rowid = c_msg.vrowid;
         i := sql%rowcount;
         If i = 0 Then
           vNgravado := vNgravado + 1; 
           dbms_output.put_line('Este registro nao foi gravado ' || c_msg.contrato || '-' || c_msg.vrowid || ' Valor ' || c_msg.valor);
         End If;
         commit;
     exception
       When OTHERS Then
          verro := verro + 1;
          dbms_output.put_line('Este registro nao foi gravado ' || c_msg.contrato || '-' ||  c_msg.vrowid || ' Valor ' || c_msg.valor || chr(10) || 'erro: ' || sqlerrm);
       End;
   End Loop;
   dbms_output.put_line('Contrato ' || vContrato);
   dbms_output.put_line('Total de Linhas Não Gravada ' || vNgravado);
   dbms_output.put_line('Total de Linhas Erro        ' || verro);
   dbms_output.put_line('Total de Linhas lidas       ' || vQtde);
   commit;
end;
0
1
i
