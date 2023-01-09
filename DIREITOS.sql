-- criar a SYSTEM.PKG_GLB_CONTEXT antes

create or replace public synonym V$SORT_SEGMENT for sys.V$SORT_SEGMENT;

create or replace public synonym SP_SVA_SIMULA_CS278 for tdvsva.SP_SVA_SIMULA_CS278;

create or replace public synonym LOTACOES for FPW.LOTACOES;
create or replace public synonym FUNCIONA for FPW.FUNCIONA;
create or replace public synonym VALMES for FPW.VALMES;
create or replace public synonym VALANO for FPW.VALANO;
create or replace public synonym EMPRESAS for FPW.EMPRESAS;
create or replace public synonym FOLHAS for FPW.FOLHAS;
create or replace public synonym EVENTOS for FPW.EVENTOS;

create or replace public synonym v_glb_ibge for ibge.v_GLB_IBGE;

create or replace public synonym T_GLB_PARAMETROS_VIEWS for glbadm.T_GLB_PARAMETROS_VIEWS;
create or replace public synonym FN_STRINVOLVE for glbadm.FN_STRINVOLVE;
create or replace public synonym FN_STRHANDLE for glbadm.FN_STRHANDLE;
create or replace public synonym load_xlsx for glbadm.load_xlsx;

create or replace public synonym FN_GETDOCNUM for tdvadm.FN_GETDOCNUM;
create or replace public synonym T_GLB_ROTA for tdvadm.T_GLB_ROTA;
create or replace public synonym F_BUSCA_CONHEC_VLMERC for tdvadm.F_BUSCA_CONHEC_VLMERC;
create or replace public synonym FN_VERIFICATPCOLETA for TDVADM.FN_VERIFICATPCOLETA;
create or replace public synonym FN_RETORNA_CTRCTIPOCARGAXML for tdvadm.FN_RETORNA_CTRCTIPOCARGAXML;
create or replace public synonym FN_RETORNA_CTRCTIPOFRETE for tdvadm.FN_RETORNA_CTRCTIPOFRETE;
create or replace public synonym FN_RETORNA_CTRCFRMPERIG for tdvadm.FN_RETORNA_CTRCFRMPERIG;
create or replace public synonym F_BUSCA_CONHEC_PESONOTAS for tdvadm.F_BUSCA_CONHEC_PESONOTAS;
create or replace public synonym F_BUSCA_CONHEC_PESO for tdvadm.F_BUSCA_CONHEC_PESO;
create or replace public synonym F_BUSCA_CONHEC_NFPB for tdvadm.F_BUSCA_CONHEC_NFPB;
create or replace public synonym FN_RETORNA_CTRCOPERACAO for tdvadm.FN_RETORNA_CTRCOPERACAO;
create or replace public synonym FN_RETORNA_CTRCFRMEXP for tdvadm.FN_RETORNA_CTRCFRMEXP;
create or replace public synonym PKG_CON_ROTINASDIARIAS for tdvadm.PKG_CON_ROTINASDIARIAS;
create or replace public synonym FN_RETORNA_CTRCDESCNOTA for tdvadm.FN_RETORNA_CTRCDESCNOTA;
create or replace public synonym FN_RETORNA_CTRCONU for tdvadm.FN_RETORNA_CTRCONU;
create or replace public synonym FN_RETORNA_CTRCCOLETAX for tdvadm.FN_RETORNA_CTRCCOLETAX;
create or replace public synonym F_BUSCA_CONHEC_ALIQICMS for tdvadm.F_BUSCA_CONHEC_ALIQICMS;
create or replace public synonym FN_RETORNA_CTRCVEICASN for tdvadm.FN_RETORNA_CTRCVEICASN;
create or replace public synonym fn_busca_conhec_verba for tdvadm.fn_busca_conhec_verba;
create or replace public synonym T_FRT_VEICULODEPARA for tdvadm.T_FRT_VEICULODEPARA;
create or replace public synonym T_USU_USUARIO for tdvadm.T_USU_USUARIO
create or replace public synonym T_RJF_MOVIMENTO for tdvadm.T_RJF_MOVIMENTO;
create or replace public synonym t_rjf_movimentoocor for tdvadm.t_rjf_movimentoocor;


grant select on V_$SESSION to TDVADM; 
grant select on DBA_ARGUMENTS to TDVADM;
grant select on dba_free_space to TDVADM;
grant select on dba_data_files to TDVADM;
grant select on DBA_DML_LOCKS to TDVADM;
grant select on dba_tab_cols to tdvadm;
grant select on v_$open_cursor to tdvadm;
grant execute on glbadm.load_xlsx to TDVADM; 
grant execute on sys.dbms_lock to TDVADM; 
grant execute on SYSTEM.pkg_glb_context to TDVADM; 
grant select on DBA_TRIGGERS to TDVADM;

grant select on V_$SESSION to BGM; 
grant select on DBA_FREE_SPACE to BGM;

grant select on V_$SESSION to GLOBUS; 

grant select on V_$SESSION to GLBADM; 
grant select on DBA_JOBS to GLBADM  with grant option;
grant select on DBA_JOBS_RUNNING to GLBADM  with grant option;
grant execute on sys.file2blob to GLBADM; 
grant execute on sys.dbms_sys_sql to glbadm;
grant select on DBA_OBJECTS to GLBADM;
grant select on DBA_DEPENDENCIES to GLBADM;

grant select on DBA_FREE_SPACE to GLOBUS;
grant select on DBA_TEMP_FILES to GLOBUS;
grant select on V_$SORT_SEGMENT to GLOBUS;

grant select on FPW.SITUACAO to FPW_TP;
grant select on FPW.FUNCIONA to FPW_TP;
grant select on FPW.CARGOS to FPW_TP;
grant select on FPW.BANCOS to FPW_TP;


grant insert ON fpw.valmes to FPW_REC;
grant select on FPW.VALMES TO FPW_REC;
grant select on fpw.VALANO to FPW_REC;
grant select on fpw.funciona to FPW_REC;
grant select on fpw.LOTACOES to FPW_REC;


grant select on DBA_ROLLBACK_SEGS TO FPW2007;

grant select on FPW.VALANO to MANAD;
grant select on synchro_h.itfin_folha_mestre to MANAD;

grant execute on tdvadm.PKG_GLB_COMMON TO RPARIZ;

grant select on TDVADM.T_USU_USUARIO TO wtdvcore;                       
grant select on coleta.usuario_web TO wtdvcore;                     
grant execute on tdvadm.PKG_GLB_COMMON TO wtdvcore;

grant execute on dbms_network_acl_admin to wservice;

grant execute on tdvadm.PKG_CON_ROTINASDIARIAS to tdvsva;


select * from dba_objects o
where o.object_name = 'T_GLB_FUNC_AGENCIA'
