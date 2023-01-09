CREATE OR REPLACE VIEW V_TI_DEFCOLUNAS AS
select tc.owner,
       tc.TABLE_NAME ,
       tc.COLUMN_NAME,
       TC.DATA_TYPE ||
                      decode(instr(TC.DATA_TYPE,'CHAR'),0,' ','(') ||
                      decode(instr(TC.DATA_TYPE,'NUM'),0,null,'(') ||
                      decode(instr(TC.DATA_TYPE,'DATE'),0,TC.DATA_LENGTH ||
                      decode(instr(TC.DATA_TYPE,'CHAR'),0,' ',')') ||
                      decode(instr(TC.DATA_TYPE,'NUM'),0,null,',') ||
                      TC.DATA_PRECISION || decode(instr(TC.DATA_TYPE,'NUM'),0,null,')'),null) DATA_TYPE,
       tc.INTERNAL_COLUMN_ID,
       (SELECT cc.COMMENTS
        FROM Dba_Col_Comments CC
        WHERE CC.OWNER = TC.OWNER
          and cc.TABLE_NAME = tc.TABLE_NAME
          and cc.COLUMN_NAME = tc.COLUMN_NAME) comentario,
       '    Q_T_CON_VALEFRETE.FieldDefs.Add(' ||
        tdvadm.pkg_glb_common.fn_QuotedStr(lower(tc.COLUMN_NAME)) || ',' ||
        decode(tc.DATA_TYPE,'NUMBER','ftFloat',
                            'VARCHAR2','ftString' || ',' || trim(to_char(tc.DATA_LENGTH)),
                            'CHAR','ftString' || ',' || trim(to_char(tc.DATA_LENGTH)),
                            'DATE','ftDateTime',
                            'ROWID','ftString' || ',' || trim(to_char(tc.DATA_LENGTH)),
                            tc.DATA_TYPE) || ');' defDelphi,
       rpad(lower(tc.COLUMN_NAME),31) || LOWER(tc.owner)  || '.' || LOWER(tc.TABLE_NAME) || '.' || lower(tc.COLUMN_NAME) || '%type,' tipoOracle,
       'extractvalue(value(field), vRow || ''/' || lower(tc.COLUMN_NAME) || '''),' extracaoxmloracle,
       'vf.'|| rpad(tc.COLUMN_NAME,31) || '= TipoDados(1).' ||tc.COLUMN_NAME || ',' updateoracle,
       'tpTipo.'|| rpad(tc.COLUMN_NAME,31) || ' := :old.' ||tc.COLUMN_NAME || ';' triggeroracle
from dba_tab_cols tc
where  tc.owner in ('TDVADM','COLETA','WSERVICE')
order by tc.INTERNAL_COLUMN_ID;
