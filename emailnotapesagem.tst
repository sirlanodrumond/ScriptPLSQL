PL/SQL Developer Test script 3.0
35
-- Created on 16/07/2018 by DESENV 
declare 
  -- Local variables here
  i integer;
  vCursor   tdvadm.PKG_EDI_PLANILHA.T_CURSOR;
  vLinha1   tdvadm.pkg_glb_SqlCursor.tpString1024;
  vLinha2   tdvadm.pkg_glb_SqlCursor.tpString1024;
  vMessage  clob;
  
begin
   vMessage := empty_clob;
   open vCursor FOR select a.uti_audit_valoratual
                    from tdvadm.t_grd_audit a
                    where a.uti_audit_user = 'TIAGO'
                      and a.uti_audit_tabela = 'T_ARM_NOTAPESAGEM'
                      and a.uti_audit_datagravacao < trunc(sysdate)
                      and a.uti_audit_datagravacao >= trunc(sysdate-7)
                    order by  a.uti_audit_datagravacao;

   tdvadm.pkg_glb_SqlCursor.TiposComuns.Formato := 'H';
   tdvadm.pkg_glb_SqlCursor.TipoHederHTML.Alinhamento := 'Left';
   tdvadm.pkg_glb_SqlCursor.sp_Get_Cursor(vCursor,vLinha2);
   for i in 1 .. vLinha2.count loop
       if tdvadm.pkg_glb_SqlCursor.TiposComuns.Formato = 'H' then
            vMessage := vMessage || vLinha2(i);
       Else
            vMessage := vMessage || vLinha2(i) || chr(10);
       End if;
   End loop; 

   wservice.pkg_glb_email.SP_ENVIAEMAIL('REPESAGEM',vMessage,'aut-e@dellavolpe.com.br','tiago.bernardes@vale.com;sdrumond@dellavolpe.com.br');
   commit;

  
end;
0
0
