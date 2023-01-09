PL/SQL Developer Test script 3.0
6
begin
  -- Call the procedure
  tdvadm.pkg_car_proprietario.sp_veirifcadebitocontacorrente(pcursor => :pcursor,
                                                             pstatus => :pstatus,
                                                             pmessage => :pmessage);
end;
3
pcursor
1
<Cursor>
116
pstatus
0
5
pmessage
0
5
0
