PL/SQL Developer Test script 3.0
38
declare 
  i integer;
begin
  :vCerto    := 0;
  :vErro     := 0;
  :vNaoFeito := 0;

  for c_msg in (select trim(substr(s.edi_integra_col02,2)) nrrowid,
                       to_number(replace(replace(s.edi_integra_col03,'.',''),',','.')) valorantigo,
                       to_number(replace(replace(s.edi_integra_col04,'.',''),',','.')) valornovo
                from tdvadm.t_edi_integracsv s
                where s.edi_integra_col01 in ('CARAIBA.csv','CARAIBA2.csv')
                  and trim(nvl(s.edi_integra_col02,'ROWID')) <> 'ROWID'
                  and s.edi_integra_col03 <> 'VALOR'
)
  Loop
     Begin
        select count(*)
          into i
        from tdvadm.t_slf_calcfretekm km
        where km.rowid = c_msg.nrrowid
--          and km.slf_calcfretekm_valor = c_msg.valornovo
        ;
        If i <> 0 Then
           :vCerto := :vCerto + 1;
        Else
           :vNaoFeito := :vNaoFeito + 1;
        End If;
        
     exception
        When OTHERS Then
           :vErro := :vErro + 1;
        End;
    
     
  End Loop;
  
end;
3
vCerto
1
0
3
vNaoFeito
1
0
3
vErro
1
397066
3
2
c_msg.nrrowid
