PL/SQL Developer Test script 3.0
34
-- Created on 02/01/2023 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  i integer := 1;
begin
   for C_msgAno in (select distinct to_char(oa.oco_ocorrencia_dtcadastro,'YYYY') ano
                    from tdvadm.t_oco_ocorrencia oa
                    order by 1)
   Loop
        i := 1;
        If C_msgAno.Ano = '2023' Then
           for c_msg in (select o.oco_ocorrencia_seq,
                                o.oco_ocorrencia_dtcadastro,
                                o.rowid
                         from tdvadm.t_oco_ocorrencia o
                         where to_char(o.oco_ocorrencia_dtcadastro,'YYYY') = C_msgAno.Ano
                         order by 1,2)
           Loop
              update tdvadm.t_oco_ocorrencia o
                set o.oco_ocorrencia_seq = lpad(i,5,'0')
              where o.rowid = c_msg.rowid;
              i := i + 1;
           End Loop;
           commit;
        End If;
  End Loop;
  open :cRetorno for select TO_CHAR(O.OCO_OCORRENCIA_DTCADASTRO,'YYYY') ano,
                            min(o.oco_ocorrencia_seq) menor,
                            max(o.oco_ocorrencia_seq) maior,
                            count(*) qtde
                     from tdvadm.t_oco_ocorrencia o
                     group by TO_CHAR(O.OCO_OCORRENCIA_DTCADASTRO,'YYYY')
                     order by 1  ; 
end;
1
cRetorno
1
<Cursor>
116
1
i
