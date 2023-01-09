PL/SQL Developer Test script 3.0
44
-- Created on 22/09/2017 by DESENV 
declare 
  -- Local variables here
  i integer;
  vScript varchar2(1000);
  vMsg    cLob;
begin
  -- Test statements here
  i := 0;
  vMsg := empty_clob;
  for c_msg in (SELECT s.SID, x.script, s.machine, oc.user_name, oc.sql_text,s.OSUSER,s.PROGRAM,s.STATUS,s.STATE,s.LOGON_TIME,s.SQL_EXEC_START,s.PREV_EXEC_START, count(1) contador
                FROM v$open_cursor oc, v$session s,tdvadm.v_kill_sessoes x
                WHERE oc.sid = s.sid
                  and oc.SID = x.SID
                  and s.STATUS not in ('ACTIVE','KILLED')
                  and trim(oc.sql_text) like '%Select sysdate from dual%'
                GROUP BY s.SID,x.script,oc.user_name, oc.sql_text, s.machine,s.OSUSER,s.PROGRAM,s.STATUS,s.LOGON_TIME,s.SQL_EXEC_START,s.PREV_EXEC_START,s.STATE
                HAVING COUNT(1) > 100
                ORDER BY s.OSUSER,s.PROGRAM,count(1) DESC)
   loop
       
       Begin
          vScript := replace(c_msg.script,';','');
          execute immediate vScript;
          i := i + 1;
          vMsg := vMsg || rpad(c_msg.PROGRAM,30) || '-' || rpad(c_msg.OSUSER,20) || '-' || '-' || rpad(c_msg.machine,30) || to_char(c_msg.contador) || chr(10);
       exception
         When OTHERS Then
           vScript := sqlerrm;
         End;
         
   
   End Loop;
   
   If i > 0 Then
      wservice.pkg_glb_email.SP_ENVIAEMAIL('MATANDO SESSOES',
                                           to_char(i) || ' - Sessoes Mortas' || chr(10) || vMsg,
                                           'aut-e@dellavolpe.com.br',
                                           'sdrumond@dellavolpe.com.br');
   End If;

   commit;
end;

0
2
vScript
i
