PL/SQL Developer Test script 3.0
8
begin
  -- Call the procedure
  tdvadm.pkg_slf_tabelas.sp_criaatulizatabela(pxls => :pxls,
                                              pstatus => :pstatus,
                                              pmessage => :pmessage);
                                              
   insert into TDVADM.t_Slf_Calcfretekm select * from TDVADM.t_Slf_Calcfretekmimp;
end;
3
pxls
1
﻿493902
5
pstatus
0
5
pmessage
1
<CLOB>
112
0
