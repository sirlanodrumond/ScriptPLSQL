PL/SQL Developer Test script 3.0
38
declare 
  type tpCurosr is REF CURSOR;
  i integer;
  pRefInicial     char(6) := '202003';
  pRefFinal       char(6) := '202003';
  vReferenciaProc char(6);
  tpReccust       tdvipf.v_ipf_reccust%rowtype;
  vCursor         tpCurosr;

  
begin
  vReferenciaProc := pRefInicial;
  loop
    Delete tdvipf.v_ipf_reccusttmp t where t.ipf_reccust_referencia = vReferenciaProc;
    commit;
    open vCursor FOR select * from tdvipf.v_ipf_reccust r where r.ipf_reccust_referencia = vReferenciaProc;
    i := 0 ;
    loop
       fetch vCursor into tpReccust;
      exit when vCursor%notfound;
    
      i := i + 1;
      insert into tdvipf.v_ipf_reccusttmp values tpReccust;
      If mod(i,100) = 0 then
         Commit;
      End If;   
    
    end loop;
    Commit;
    close vCursor;
    
    vReferenciaProc := to_char(add_months(to_date(vReferenciaProc,'YYYYMM'),1),'YYYYMM');
      
    exit when pRefFinal <= vReferenciaProc;
    
  end loop;
  :vReferenciaProc2 := vReferenciaProc;
end;
1
vReferenciaProc2
0
5
0
