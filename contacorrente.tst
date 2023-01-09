PL/SQL Developer Test script 3.0
11
declare 
  vCursor Types.cursorType;
  vStatus char(1);
  vMessage varchar2(1000);
begin
  -- Call the procedure
  tdvadm.pkg_car_proprietario.sp_veirifcadebitocontacorrente(vCursor,
                                                             vStatus,
                                                             vMessage);
  DBMS_OUTPUT.put_line(vStatus || '-' || vMessage);                                                           
end;
0
1
r_cursor.placa
