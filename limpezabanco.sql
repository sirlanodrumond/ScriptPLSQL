select count(*) from tdvadm.t_con_calcconhecimento c where c.con_calcviagem_valor = 0 and c.con_conhecimento_dtembarque < ADD_MONTHS(SYSDATE,-2);
186.847.922 zerados
186.847.920
187.026.359
186.965.033
186.638.655
186.241.271
186.059.156
173.004.306
165.932.869
164.364.625
 87.970.322 com valor

select A.SLF_TABELA_CODIGO, 
       A.SLF_TABELA_SAQUE,
       (select count(*) 
        from tdvadm.t_slf_calctabela ca
        where ca.slf_tabela_codigo = a.slf_tabela_codigo
          and ca.slf_tabela_saque = a.slf_tabela_saque
          and ca.slf_calctabela_valor = 0) qtdezerado
from tdvadm.t_slf_tabela A
where A.SLF_TABELA_SAQUE < (SELECT substr(to_char(MAX(B.SLF_TABELA_SAQUE) - 2, '0000'), 2, 4)
                                 FROM tdvadm.T_SLF_TABELA B
                                 WHERE B.SLF_TABELA_CODIGO = A.SLF_TABELA_CODIGO);



--TABLESPACES ACIMA DE 80%
select a.TABLESPACE_NAME,
       a.BYTES / 1024 / 1024 Megas_Usados,
       b.BYTES / 1024 / 1024 Megas_Livres,
       round(((a.BYTES - b.BYTES) / a.BYTES) * 100, 2) "%USADO"
  from (select TABLESPACE_NAME, sum(BYTES) BYTES
          from dba_data_files
         group by TABLESPACE_NAME) a,
       (select TABLESPACE_NAME, sum(BYTES) BYTES, max(BYTES) largest
          from dba_free_space
         group by TABLESPACE_NAME) b
where a.TABLESPACE_NAME = b.TABLESPACE_NAME
and a.TABLESPACE_NAME <> 'SYSTEM'
and a.TABLESPACE_NAME <> 'USERS'
and round(((a.BYTES - b.BYTES) / a.BYTES) * 100, 2) > 80
order by ((a.BYTES - b.BYTES) / a.BYTES) desc;

select t.OWNER,
       t.TABLE_NAME,
       t.NUM_ROWS,
       t.INITIAL_EXTENT,
       t.LAST_ANALYZED,
       c.comments
from dba_tables t,
     dba_tab_comments c
where 0 = 0
  and t.OWNER = c.owner
  and t.TABLE_NAME = c.table_name
--  and t.TABLESPACE_NAME = 'TSMDFT';
  and t.TABLESPACE_NAME = 'TSMCONHEC';
  
select * from dba_source s where upper(s.TEXT) like '%T_GRD_TEMPORARIA%';
  
drop table tdvadm.T_CON_LOGGERACAO2;
drop table tdvadm.T_CON_LOGGERACAOOLD;
drop table tdvadm.T_CON_LOGGERACAO_20170518;
drop table tdvadm.T_CTB_MOVIMENTO_16052011;
drop table tdvadm.T_CTB_MOVIMENTO_22022010;
drop table tdvadm.T_CON_CONHECFATURADOSIRLANO;
drop table tdvadm.T_GLB_AMBIENTELOGON;
drop table tdvadm.T_SLF_CALCFRETEKM20170525;
drop table tdvadm.T_CON_CONTROLECTRCE_BKP;
drop table tdvadm.T_CTB_PCONTASALDO_20120716;
drop table tdvadm.T_CTB_PCONTASALDO_30082011;
drop table tdvadm.T_CTB_MOVIMENTO_TST_20022015
drop table tdvadm.DBA_SOURCE_BKP;
drop table tdvadm.DBA_SOURCEKPTDP;
drop table tdvadm.DBA_SOURCEKPTDX;
drop table tdvadm.T_SLF_CALCFRETEKM20151228;
drop table tdvadm.T_SLF_CALCFRETEKM20151203;
drop table tdvadm.T_SLF_CALCFRETEKM20151207;
drop table tdvadm.T_RJR_ROMANEIO_FAFA;
drop table tdvadm.T_SLF_CALCFRETEKM0006;
drop table tdvadm.T_SLF_CALCFRETEKM20150928;
drop table tdvadm.T_CRP_HISTTITRECEBER_06062014;
drop table tdvadm.T_CTB_MOVIMENTO_TST2018102;
drop table tdvadm.T_CTB_MOVIMENTO_TST201810;
drop table tdvadm.T_SLF_CLIENTECARGAS20150909;
drop table tdvadm.T_SLF_CALCFRETEKMDRU;
drop table tdvadm.T_GRD_RELATORIOUSUARIO20150526;
drop table tdvadm.T_GRD_PARAMETRO20150526;
drop table tdvadm.T_GRD_ORDEM20150526;


drop table tdvadm.
drop table tdvadm.
drop table tdvadm.
drop table tdvadm.
drop table tdvadm.

tdvadm.PKG_CON_DIGMANUAL;
select *
from dba_source s 
where s.TEXT like '%ACRESCIMO%'
  and s.owner = 'TDVADM'
  
select sum("Tot.CTCR"),count(*) from tdvadm.v_fat_afaturar

select s.glb_sql_observacao,count(*) from tdvadm.t_glb_sql s group by s.glb_sql_observacao;
select * from tdvadm.dropme;


truncate table  tdvadm.t_glb_sql;
truncate table  tdvadm.dropme;

74.115.577

delete tdvadm.t_con_loggeracao;
delete tdvadm.t_con_calcconhecimento;
delete tdvadm.t_con_calcviagemdet;
select count(*) from tdvadm.t_slf_calctabela t where t.slf_calctabela_valor = 0 ;


select * from tdvadm.t_cpg_despesas;
select * from tdvadm.t_glb_evento E WHERE E.GLB_EVENTO_CODIGO IN ('9995','0111','9994')

select * from tdvadm.t_cpg_despesaevento;
select * from tdvadm.t_cpg_movimento;
select * from tdvadm.t_cpg_titparcelas;
SELECT * FROM TDVADM.t_Cpg_Titparcelas

select * from tdvadm.t_cpg_tppagto;
select * from tdvadm.t_cpg_tipomovimento;
SELECT * FROM TDVADM.T_CPG_TITULOEVENTO X
WHERE TRUNC(X.GPG_TITULOEVENTO_DTEVENTO) >= '01/11/2018'

select * from tdvadm.t_glb_fornecedor






