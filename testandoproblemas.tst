PL/SQL Developer Test script 3.0
194
declare

   vTexto  clob;
   vCursor PKG_EDI_PLANILHA.T_CURSOR;
   vLinha  pkg_glb_SqlCursor.tpString1024;
   vErro   clob;
begin

   vTexto := empty_clob;
   vErro  := empty_clob;
   vTexto := vTexto || tdvadm.pkg_glb_html.Assinatura;

   /******************************************************************************/

   --    vTexto := vTexto || tdvadm.pkg_glb_html.PulaLinha;
   vTexto := vTexto || tdvadm.pkg_glb_html.fn_Titulo('TABELAS TRAVADAS');
   --    vTexto := vTexto || tdvadm.pkg_glb_html.PulaLinha;
   open vCursor FOR
      select l.owner, l.name, l.minutos, l.STATUS, l.OSUSER, l.PROGRAM
        from tdvadm.v_lock_tables l;

   pkg_glb_SqlCursor.TiposComuns.Formato       := 'H';
   pkg_glb_SqlCursor.TipoHederHTML.Alinhamento := 'Left';
   pkg_glb_SqlCursor.sp_Get_Cursor(vCursor, vLinha);

   for i in 1 .. vLinha.count loop
      if pkg_glb_SqlCursor.TiposComuns.Formato = 'H' then
         vTexto := vTexto || vLinha(i);
      Else
         vTexto := vTexto || vLinha(i) || chr(10);
      End if;
   End loop;

   /******************************************************************************/

   --    vTexto := vTexto || tdvadm.pkg_glb_html.PulaLinha;
   vTexto := vTexto || tdvadm.pkg_glb_html.fn_Titulo('JOB RODANDO');
   --    vTexto := vTexto || tdvadm.pkg_glb_html.PulaLinha;
   open vCursor FOR
      select r.tipo,
             r.job,
             r.SCHEMA_USER,
             r.interval,
             r.duracao,
             r.NEXT_DATE
        from tdvadm.v_job_rodando r;

   pkg_glb_SqlCursor.TiposComuns.Formato       := 'H';
   pkg_glb_SqlCursor.TipoHederHTML.Alinhamento := 'Left';
   pkg_glb_SqlCursor.sp_Get_Cursor(vCursor, vLinha);

   for i in 1 .. vLinha.count loop
      if pkg_glb_SqlCursor.TiposComuns.Formato = 'H' then
         vTexto := vTexto || vLinha(i);
      Else
         vTexto := vTexto || vLinha(i) || chr(10);
      End if;
   End loop;

   /******************************************************************************/

   --    vTexto := vTexto || tdvadm.pkg_glb_html.PulaLinha;
   vTexto := vTexto ||
             tdvadm.pkg_glb_html.fn_Titulo('JOB ACIMA DO PROGRAMADO');
   --    vTexto := vTexto || tdvadm.pkg_glb_html.PulaLinha;
   open vCursor FOR
      select r.tipo,
             r.job,
             r.SCHEMA_USER,
             r.interval,
             r.duracao,
             r.NEXT_DATE
        from tdvadm.v_job_rodandoacimadoprogramado r;

   pkg_glb_SqlCursor.TiposComuns.Formato       := 'H';
   pkg_glb_SqlCursor.TipoHederHTML.Alinhamento := 'Left';
   pkg_glb_SqlCursor.sp_Get_Cursor(vCursor, vLinha);

   for i in 1 .. vLinha.count loop
      if pkg_glb_SqlCursor.TiposComuns.Formato = 'H' then
         vTexto := vTexto || vLinha(i);
      Else
         vTexto := vTexto || vLinha(i) || chr(10);
      End if;
   End loop;

   /******************************************************************************/

   --    vTexto := vTexto || tdvadm.pkg_glb_html.PulaLinha;
   vTexto := vTexto || tdvadm.pkg_glb_html.fn_Titulo('JOB COM PROBLEMAS');
   --    vTexto := vTexto || tdvadm.pkg_glb_html.PulaLinha;
   open vCursor FOR
      select P.TIPO,
             P.JOB,
             P.SCHEMA_USER,
             P.WHAT,
             P.DURACAO,
             P.LAST_DATE,
             P.NEXT_DATE,
             P.INTERVAL,
             P.SID,
             P.BROKEN,
             P.HORAATUAL,
             P.COMMENTS,
             P.ULTIMAACAO,
             P.ERRO,
             P.OUTPUT
        from tdvadm.v_job_problemas P;

   pkg_glb_SqlCursor.TiposComuns.Formato       := 'H';
   pkg_glb_SqlCursor.TipoHederHTML.Alinhamento := 'Left';
   pkg_glb_SqlCursor.sp_Get_Cursor(vCursor, vLinha);

   for i in 1 .. vLinha.count loop
      if pkg_glb_SqlCursor.TiposComuns.Formato = 'H' then
         vTexto := vTexto || vLinha(i);
      Else
         vTexto := vTexto || vLinha(i) || chr(10);
      End if;
   End loop;

   /******************************************************************************/

   --    vTexto := vTexto || tdvadm.pkg_glb_html.PulaLinha;
   vTexto := vTexto || tdvadm.pkg_glb_html.fn_Titulo('OBJETOS INVALIDOS');
   --    vTexto := vTexto || tdvadm.pkg_glb_html.PulaLinha;
   open vCursor FOR
      select s.OWNER,
             s.OBJECT_NAME,
             s.OBJECT_TYPE,
             s.CREATED,
             s.LAST_DDL_TIME
        from dba_objects s
       where 0 = 0
         and (s.OWNER like '%ADM%' or s.OWNER = 'WSERVICE')
         and s.OWNER not in ('RJRADM')
         and s.status <> 'VALID'
       order by 1, 2;

   pkg_glb_SqlCursor.TiposComuns.Formato       := 'H';
   pkg_glb_SqlCursor.TipoHederHTML.Alinhamento := 'Left';
   pkg_glb_SqlCursor.sp_Get_Cursor(vCursor, vLinha);

   for i in 1 .. vLinha.count loop
      if pkg_glb_SqlCursor.TiposComuns.Formato = 'H' then
         vTexto := vTexto || vLinha(i);
      Else
         vTexto := vTexto || vLinha(i) || chr(10);
      End if;
   End loop;

   /******************************************************************************/

   --    vTexto := vTexto || tdvadm.pkg_glb_html.PulaLinha;
   vTexto := vTexto ||
             tdvadm.pkg_glb_html.fn_Titulo('OUTROS OBJETOS INVALIDOS');
   --    vTexto := vTexto || tdvadm.pkg_glb_html.PulaLinha;
   open vCursor FOR
      select s.OWNER,
             s.OBJECT_NAME,
             s.OBJECT_TYPE,
             s.CREATED,
             s.LAST_DDL_TIME
        from dba_objects s
       where 0 = 0
         and s.OWNER not like '%ADM%'
         and s.OWNER not in
             ('BGM', 'ECLICK', 'FPW_REC', 'FPW_TP', 'WSERVICE', 'RJRADM')
         and s.status <> 'VALID'
       order by 1, 2;

   pkg_glb_SqlCursor.TiposComuns.Formato       := 'H';
   pkg_glb_SqlCursor.TipoHederHTML.Alinhamento := 'Left';
   pkg_glb_SqlCursor.sp_Get_Cursor(vCursor, vLinha);

   for i in 1 .. vLinha.count loop
      if pkg_glb_SqlCursor.TiposComuns.Formato = 'H' then
         vTexto := vTexto || vLinha(i);
      Else
         vTexto := vTexto || vLinha(i) || chr(10);
      End if;
   End loop;

   /******************************************************************************/

   wservice.pkg_glb_email.SP_ENVIAEMAIL(P_ASSUNTO => 'TESTES DIVERSOS',
                                        P_TEXTO   => vTexto,
                                        P_ORIGEM  => 'aut-e@dellavolpe.com.br',
                                        P_DESTINO => 'sirlano.drumond@dellavolpe.com.br',
                                        P_COPIA   => null,
                                        P_COPIA2  => null);

   commit;
end;
0
0
