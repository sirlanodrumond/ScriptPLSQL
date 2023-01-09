PL/SQL Developer Test script 3.0
613
  --- Atualizando o SAP
declare 
  tpDBANK_MASTER_S_BNKA         migdv.BANK_MASTER_S_BNKA%rowtype;

  tpDCUSTOMER_S_ADDRESS         migdv.CUSTOMER_S_ADDRESS%rowtype;
  tpDCUSTOMER_S_CUST_COMPANY    migdv.CUSTOMER_S_CUST_COMPANY%rowtype;
  tpDCUSTOMER_S_CUST_CONT       migdv.CUSTOMER_S_CUST_CONT%rowtype;
  tpDCUSTOMER_S_CUST_GEN        migdv.CUSTOMER_S_CUST_GEN%rowtype;
  tpDCUSTOMER_S_CUST_TAXNUMBERS migdv.CUSTOMER_S_CUST_TAXNUMBERS%rowtype;
  tpDCUSTOMER_S_ROLES           migdv.CUSTOMER_S_ROLES%rowtype;

  tpDCUSTOMER_S_CUST_SALES_DATA migdv.CUSTOMER_S_CUST_SALES_DATA%rowtype;

  tpDVENDOR_S_ROLES             migdv.VENDOR_S_ROLES%rowtype;
  tpDVENDOR_S_SUPPL_GEN         migdv.VENDOR_S_SUPPL_GEN%rowtype;
  tpDVENDOR_S_SUPPL_IDENT       migdv.VENDOR_S_SUPPL_IDENT%rowtype;
  tpDVENDOR_S_SUPPL_TAXNUMBERS  migdv.VENDOR_S_SUPPL_TAXNUMBERS%rowtype;
  tpDVENDOR_S_SUPPL_WITH_TAX    migdv.VENDOR_S_SUPPL_WITH_TAX%rowtype;
  
  tpDEQUIPMENT_S_EQUI           migdv.EQUIPMENT_S_EQUI%rowtype;
  tpDFUNC_LOC_S_FUN_LOCATION    migdv.FUNC_LOC_S_FUN_LOCATION%rowtype;

  tpDMATERIAL_S_MAKT            migdv.MATERIAL_S_MAKT%rowtype;
  tpDMATERIAL_S_MARA            migdv.MATERIAL_S_MARA%rowtype;
  tpDMATERIAL_S_MLAN            migdv.MATERIAL_S_MLAN%rowtype;

  tpDOPEN_ITEM_AP_S_BSIK        migdv.OPEN_ITEM_AP_S_BSIK%rowtype;


  tpDLINHA_MEIO_TRANSP          migdv.LINHA_MEIO_TRANSP%rowtype;
  tpDLINHA_TRANSPORTE           migdv.LINHA_TRANSPORTE%rowtype;
  tpDZONA_TRANSPORTE            migdv.ZONA_TRANSPORTE%rowtype;
  
  tpDGL_BALANCES_S_BSIS migdv.GL_BALANCES_S_BSIS%rowtype;

  tpDRECURSO migdv.RECURSO%rowtype;

  i integer;
  type tpCurosr is REF CURSOR;
  vCursor1 tpCurosr;
begin
   i := 0;

If nvl(:Razao,'N') = 'S' Then
   delete migdv.GL_BALANCES_S_BSIS@database_tdx;
   commit;

   /**************************/ 
   Begin
   open vCursor1 FOR select * from migdv.GL_BALANCES_S_BSIS;
   loop
     fetch vCursor1 into tpDGL_BALANCES_S_BSIS;
        exit when vCursor1%notfound;

     insert into migdv.GL_BALANCES_S_BSIS@database_tdx values tpDGL_BALANCES_S_BSIS;

     i := i + 1;
     If mod(i,1000) = 0 Then
        commit;
     End If;
   end loop;
   close vCursor1;
   commit;
   exception
     When OTHERS Then
        DBMS_OUTPUT.put_line(SQLERRM);
     End;
   /**************************/ 

End If;

If nvl(:Banco,'N') = 'S' Then
   delete migdv.BANK_MASTER_S_BNKA@database_tdx;
   commit;
   /**************************/ 
   Begin
   open vCursor1 FOR select * from migdv.BANK_MASTER_S_BNKA;
   loop
     fetch vCursor1 into tpDBANK_MASTER_S_BNKA;
        exit when vCursor1%notfound;
     insert into migdv.BANK_MASTER_S_BNKA@database_tdx values tpDBANK_MASTER_S_BNKA;
     
     i := i + 1;
     If mod(i,1000) = 0 Then
        commit;
     End If;
   end loop;
   close vCursor1;
   commit;
   exception
     When OTHERS Then
        DBMS_OUTPUT.put_line(SQLERRM);
     End;
   /**************************/ 

End If;

If nvl(:Cliente,'N') = 'S' Then
   delete migdv.CUSTOMER_S_ADDRESS@database_tdx;
   delete migdv.CUSTOMER_S_CUST_COMPANY@database_tdx;
   delete migdv.CUSTOMER_S_CUST_CONT@database_tdx;
   delete migdv.CUSTOMER_S_CUST_GEN@database_tdx;
   delete migdv.CUSTOMER_S_CUST_TAXNUMBERS@database_tdx;
   delete migdv.CUSTOMER_S_ROLES@database_tdx;
   commit;
   /**************************/ 
   Begin
   open vCursor1 FOR select * from migdv.CUSTOMER_S_ADDRESS;
   loop
     fetch vCursor1 into tpDCUSTOMER_S_ADDRESS;
        exit when vCursor1%notfound;
     insert into migdv.CUSTOMER_S_ADDRESS@database_tdx values tpDCUSTOMER_S_ADDRESS;
     
     i := i + 1;
     If mod(i,1000) = 0 Then
        commit;
     End If;
   end loop;
   close vCursor1;
   commit;
   exception
     When OTHERS Then
        DBMS_OUTPUT.put_line(SQLERRM);
     End;
   /**************************/ 
   Begin
   open vCursor1 FOR select * from migdv.CUSTOMER_S_CUST_COMPANY;
   loop
     fetch vCursor1 into tpDCUSTOMER_S_CUST_COMPANY;
        exit when vCursor1%notfound;
     insert into migdv.CUSTOMER_S_CUST_COMPANY@database_tdx values tpDCUSTOMER_S_CUST_COMPANY;
     
     i := i + 1;
     If mod(i,1000) = 0 Then
        commit;
     End If;
   end loop;
   close vCursor1;
   commit;
   exception
     When OTHERS Then
        DBMS_OUTPUT.put_line(SQLERRM);
     End;
   /**************************/ 
   Begin
   open vCursor1 FOR select * from migdv.CUSTOMER_S_CUST_CONT;
   loop
     fetch vCursor1 into tpDCUSTOMER_S_CUST_CONT;
        exit when vCursor1%notfound;
     insert into migdv.CUSTOMER_S_CUST_CONT@database_tdx values tpDCUSTOMER_S_CUST_CONT;
     
     i := i + 1;
     If mod(i,1000) = 0 Then
        commit;
     End If;
   end loop;
   close vCursor1;
   commit;
   exception
     When OTHERS Then
        DBMS_OUTPUT.put_line(SQLERRM);
     End;
   /**************************/ 
   Begin
   open vCursor1 FOR select * from migdv.CUSTOMER_S_CUST_GEN;
   loop
     fetch vCursor1 into tpDCUSTOMER_S_CUST_GEN;
        exit when vCursor1%notfound;
     insert into migdv.CUSTOMER_S_CUST_GEN@database_tdx values tpDCUSTOMER_S_CUST_GEN;
     
     i := i + 1;
     If mod(i,1000) = 0 Then
        commit;
     End If;
   end loop;
   close vCursor1;
   commit;
   exception
     When OTHERS Then
        DBMS_OUTPUT.put_line(SQLERRM);
     End;
   /**************************/ 
   Begin
   open vCursor1 FOR select * from migdv.CUSTOMER_S_CUST_TAXNUMBERS;
   loop
     fetch vCursor1 into tpDCUSTOMER_S_CUST_TAXNUMBERS;
        exit when vCursor1%notfound;
     insert into migdv.CUSTOMER_S_CUST_TAXNUMBERS@database_tdx values tpDCUSTOMER_S_CUST_TAXNUMBERS;
     
     i := i + 1;
     If mod(i,1000) = 0 Then
        commit;
     End If;
   end loop;
   close vCursor1;
   commit;
   exception
     When OTHERS Then
        DBMS_OUTPUT.put_line(SQLERRM);
     End;
   /**************************/ 
   Begin
   open vCursor1 FOR select * from migdv.CUSTOMER_S_ROLES;
   loop
     fetch vCursor1 into tpDCUSTOMER_S_ROLES;
        exit when vCursor1%notfound;
     insert into migdv.CUSTOMER_S_ROLES@database_tdx values tpDCUSTOMER_S_ROLES;
     
     i := i + 1;
     If mod(i,1000) = 0 Then
        commit;
     End If;
   end loop;
   close vCursor1;
   commit;
   exception
     When OTHERS Then
        DBMS_OUTPUT.put_line(SQLERRM);
     End;
   /**************************/ 


End If;


If nvl(:Vendor,'N') = 'S' Then
  
--   delete migdv.VENDOR_S_ROLES@database_tdx;
--   delete migdv.VENDOR_S_SUPPL_GEN@database_tdx;
--   delete migdv.VENDOR_S_SUPPL_IDENT@database_tdx;
--   delete migdv.VENDOR_S_SUPPL_TAXNUMBERS@database_tdx;
   delete migdv.VENDOR_S_SUPPL_WITH_TAX@database_tdx;
   commit;

   /**************************/ 
 Begin
   open vCursor1 FOR select * from migdv.VENDOR_S_SUPPL_WITH_TAX;
   loop
     fetch vCursor1 into tpDVENDOR_S_SUPPL_WITH_TAX;
        exit when vCursor1%notfound;
     insert into migdv.VENDOR_S_SUPPL_WITH_TAX@database_tdx values tpDVENDOR_S_SUPPL_WITH_TAX;
     
     i := i + 1;
     If mod(i,1000) = 0 Then
        commit;
     End If;
   end loop;
   close vCursor1;
   commit;
   exception
     When OTHERS Then
        DBMS_OUTPUT.put_line(SQLERRM);
     End;
   /**************************/ 
  RETURN;
   Begin
   open vCursor1 FOR select * from migdv.VENDOR_S_ROLES;
   loop
     fetch vCursor1 into tpDVENDOR_S_ROLES;
        exit when vCursor1%notfound;
     insert into migdv.VENDOR_S_ROLES@database_tdx values tpDVENDOR_S_ROLES;
     
     i := i + 1;
     If mod(i,1000) = 0 Then
        commit;
     End If;
   end loop;
   close vCursor1;
   commit;
   exception
     When OTHERS Then
        DBMS_OUTPUT.put_line(SQLERRM);
     End;
   /**************************/ 
   Begin
   open vCursor1 FOR select * from migdv.VENDOR_S_SUPPL_GEN;
   loop
     fetch vCursor1 into tpDVENDOR_S_SUPPL_GEN;
        exit when vCursor1%notfound;
     insert into migdv.VENDOR_S_SUPPL_GEN@database_tdx values tpDVENDOR_S_SUPPL_GEN;
     
     i := i + 1;
     If mod(i,1000) = 0 Then
        commit;
     End If;
   end loop;
   close vCursor1;
   commit;
   exception
     When OTHERS Then
        DBMS_OUTPUT.put_line(SQLERRM);
     End;
   /**************************/ 
   Begin
   open vCursor1 FOR select * from migdv.VENDOR_S_SUPPL_IDENT;
   loop
     fetch vCursor1 into tpDVENDOR_S_SUPPL_IDENT;
        exit when vCursor1%notfound;
     insert into migdv.VENDOR_S_SUPPL_IDENT@database_tdx values tpDVENDOR_S_SUPPL_IDENT;
     
     i := i + 1;
     If mod(i,1000) = 0 Then
        commit;
     End If;
   end loop;
   close vCursor1;
   commit;
   exception
     When OTHERS Then
        DBMS_OUTPUT.put_line(SQLERRM);
     End;
   /**************************/ 
   Begin
   open vCursor1 FOR select * from migdv.VENDOR_S_SUPPL_TAXNUMBERS;
   loop
     fetch vCursor1 into tpDVENDOR_S_SUPPL_TAXNUMBERS;
        exit when vCursor1%notfound;
     insert into migdv.VENDOR_S_SUPPL_TAXNUMBERS@database_tdx values tpDVENDOR_S_SUPPL_TAXNUMBERS;
     
     i := i + 1;
     If mod(i,1000) = 0 Then
        commit;
     End If;
   end loop;
   close vCursor1;
   commit;
   exception
     When OTHERS Then
        DBMS_OUTPUT.put_line(SQLERRM);
     End;
   /**************************/ 
  


End If;


If nvl(:Equipamento,'N') = 'S' then

   delete migdv.EQUIPMENT_S_EQUI@database_tdx;
   delete migdv.FUNC_LOC_S_FUN_LOCATION@database_tdx;
   commit;

   /**************************/ 
   Begin
   open vCursor1 FOR select * from migdv.EQUIPMENT_S_EQUI;
   loop
     fetch vCursor1 into tpDEQUIPMENT_S_EQUI;
        exit when vCursor1%notfound;
     insert into migdv.EQUIPMENT_S_EQUI@database_tdx values tpDEQUIPMENT_S_EQUI;
     
     i := i + 1;
     If mod(i,1000) = 0 Then
        commit;
     End If;
   end loop;
   close vCursor1;
   commit;
   exception
     When OTHERS Then
        DBMS_OUTPUT.put_line(SQLERRM);
     End;
   /**************************/ 
   Begin
   open vCursor1 FOR select * from migdv.FUNC_LOC_S_FUN_LOCATION;
   loop
     fetch vCursor1 into tpDFUNC_LOC_S_FUN_LOCATION;
        exit when vCursor1%notfound;
     
     If tpDFUNC_LOC_S_FUN_LOCATION.EXTERNAL_NUMBER <> ' ' Then
        insert into migdv.FUNC_LOC_S_FUN_LOCATION@database_tdx values tpDFUNC_LOC_S_FUN_LOCATION;
     End If;   
     i := i + 1;
     If mod(i,1000) = 0 Then
        commit;
     End If;
   end loop;
   close vCursor1;
   commit;
   exception
     When OTHERS Then
        DBMS_OUTPUT.put_line(SQLERRM);
     End;
   /**************************/ 

End If;

If nvl(:Material,'N') = 'S' Then
  
   delete migdv.MATERIAL_S_MAKT@database_tdx;
   delete migdv.MATERIAL_S_MARA@database_tdx;
   delete migdv.MATERIAL_S_MLAN@database_tdx;
   commit;

   /**************************/ 
   Begin
   open vCursor1 FOR select * from migdv.MATERIAL_S_MAKT;
   loop
     fetch vCursor1 into tpDMATERIAL_S_MAKT;
        exit when vCursor1%notfound;
     insert into migdv.MATERIAL_S_MAKT@database_tdx values tpDMATERIAL_S_MAKT;
     
     i := i + 1;
     If mod(i,1000) = 0 Then
        commit;
     End If;
   end loop;
   close vCursor1;
   commit;
   exception
     When OTHERS Then
        DBMS_OUTPUT.put_line(SQLERRM);
     End;
   /**************************/ 
   Begin
   open vCursor1 FOR select * from migdv.MATERIAL_S_MARA;
   loop
     fetch vCursor1 into tpDMATERIAL_S_MARA;
        exit when vCursor1%notfound;
     insert into migdv.MATERIAL_S_MARA@database_tdx values tpDMATERIAL_S_MARA;
     
     i := i + 1;
     If mod(i,1000) = 0 Then
        commit;
     End If;
   end loop;
   close vCursor1;
   commit;
   exception
     When OTHERS Then
        DBMS_OUTPUT.put_line(SQLERRM);
     End;
   /**************************/ 
   Begin
   open vCursor1 FOR select * from migdv.MATERIAL_S_MLAN;
   loop
     fetch vCursor1 into tpDMATERIAL_S_MLAN;
        exit when vCursor1%notfound;
     insert into migdv.MATERIAL_S_MLAN@database_tdx values tpDMATERIAL_S_MLAN;
     
     i := i + 1;
     If mod(i,1000) = 0 Then
        commit;
     End If;
   end loop;
   close vCursor1;
   commit;
   exception
     When OTHERS Then
        DBMS_OUTPUT.put_line(SQLERRM);
     End;
   /**************************/ 

End If;

If nvl(:MeioTransp,'N') = 'S' Then

   delete migdv.LINHA_MEIO_TRANSP@database_tdx;
   delete migdv.LINHA_TRANSPORTE@database_tdx;
   delete migdv.ZONA_TRANSPORTE@database_tdx;
   commit;

   /**************************/ 
   Begin
   open vCursor1 FOR select * from migdv.LINHA_MEIO_TRANSP;
   loop
     fetch vCursor1 into tpDLINHA_MEIO_TRANSP;
        exit when vCursor1%notfound;
     insert into migdv.LINHA_MEIO_TRANSP@database_tdx values tpDLINHA_MEIO_TRANSP;
     
     i := i + 1;
     If mod(i,1000) = 0 Then
        commit;
     End If;
   end loop;
   close vCursor1;
   commit;
   exception
     When OTHERS Then
        DBMS_OUTPUT.put_line(SQLERRM);
     End;
   /**************************/ 
   Begin
   open vCursor1 FOR select * from migdv.LINHA_TRANSPORTE;
   loop
     fetch vCursor1 into tpDLINHA_TRANSPORTE;
        exit when vCursor1%notfound;
     insert into migdv.LINHA_TRANSPORTE@database_tdx values tpDLINHA_TRANSPORTE;
     
     i := i + 1;
     If mod(i,1000) = 0 Then
        commit;
     End If;
   end loop;
   close vCursor1;
   commit;
   exception
     When OTHERS Then
        DBMS_OUTPUT.put_line(SQLERRM);
     End;
   /**************************/ 
   Begin
   open vCursor1 FOR select * from migdv.ZONA_TRANSPORTE;
   loop
     fetch vCursor1 into tpDZONA_TRANSPORTE;
        exit when vCursor1%notfound;
     insert into migdv.ZONA_TRANSPORTE@database_tdx values tpDZONA_TRANSPORTE;
     
     i := i + 1;
     If mod(i,1000) = 0 Then
        commit;
     End If;
   end loop;
   close vCursor1;
   commit;
   exception
     When OTHERS Then
        DBMS_OUTPUT.put_line(SQLERRM);
     End;
   /**************************/ 

End If;

If nvl(:Sales,'N') = 'S' Then
  
   delete migdv.CUSTOMER_S_CUST_SALES_DATA@database_tdx;
   commit;

   /**************************/ 
   Begin
   open vCursor1 FOR select * from migdv.CUSTOMER_S_CUST_SALES_DATA;
   loop
     fetch vCursor1 into tpDCUSTOMER_S_CUST_SALES_DATA;
        exit when vCursor1%notfound;
     insert into migdv.CUSTOMER_S_CUST_SALES_DATA@database_tdx values tpDCUSTOMER_S_CUST_SALES_DATA;
     
     i := i + 1;
     If mod(i,1000) = 0 Then
        commit;
     End If;
   end loop;
   close vCursor1;
   commit;
   exception
     When OTHERS Then
        DBMS_OUTPUT.put_line(SQLERRM);
     End;
   /**************************/ 
End If;


If nvl(:ContaPagar,'N') = 'S' Then
  
   delete migdv.OPEN_ITEM_AP_S_BSIK@database_tdx;
   commit;

   /**************************/ 
   Begin
   open vCursor1 FOR select * from migdv.OPEN_ITEM_AP_S_BSIK X ;
   loop
     fetch vCursor1 into tpDOPEN_ITEM_AP_S_BSIK;
        exit when vCursor1%notfound;
     insert into migdv.OPEN_ITEM_AP_S_BSIK@database_tdx values tpDOPEN_ITEM_AP_S_BSIK;
     
     i := i + 1;
     If mod(i,1000) = 0 Then
        commit;
     End If;
   end loop;
   close vCursor1;
   commit;
   exception
     When OTHERS Then
        DBMS_OUTPUT.put_line(SQLERRM);
     End;
   /**************************/ 

End If;


If nvl(:Recurso,'N') = 'S' Then
  
   delete migdv.recurso@database_tdx;
   commit;

   /**************************/ 
   Begin
   insert into migdv.recurso
   select * from migdv.v_recurso;
   commit;
   open vCursor1 FOR select * from migdv.recurso X ;
   loop
     fetch vCursor1 into tpDrecurso;
        exit when vCursor1%notfound;
     insert into migdv.recurso@database_tdx values tpDrecurso;
     
     i := i + 1;
     If mod(i,1000) = 0 Then
        commit;
     End If;
   end loop;
   close vCursor1;
   commit;
   exception
     When OTHERS Then
        DBMS_OUTPUT.put_line(SQLERRM);
     End;
   /**************************/ 

End If;


End ;
10
Razao
1
N
5
Banco
1
N
5
CLiente
1
N
5
Vendor
1
N
5
Sales
1
N
5
Equipamento
1
N
5
Material
1
N
5
MeioTransp
1
N
5
ContaPagar
1
N
5
Recurso
1
S
5
0
